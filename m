Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129545AbRBQIW7>; Sat, 17 Feb 2001 03:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130384AbRBQIWk>; Sat, 17 Feb 2001 03:22:40 -0500
Received: from linuxcare.com.au ([203.29.91.49]:47879 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129545AbRBQIW3>; Sat, 17 Feb 2001 03:22:29 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 17 Feb 2001 19:17:47 +1100
To: "Gord R. Lamb" <glamb@lcis.dyndns.org>
Cc: Jeremy Jackson <jeremy.jackson@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Samba performance / zero-copy network I/O
Message-ID: <20010217191746.B2484@linuxcare.com>
In-Reply-To: <3A8AEDB9.59721801@sympatico.ca> <Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain>; from glamb@lcis.dyndns.org on Wed, Feb 14, 2001 at 03:53:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Hmm.  Yeah, I think that may be one of the problems (Intel's card isn't
> supported afaik; if I have to I'll switch to 3com, or hopelessly try to
> implement support).  I'm looking for a patch to implement sendfile in
> Samba, as Alan suggested.  That seems like a good first step.

As Alan said, the smb protocol is pretty ugly. This patch makes samba use
sendfile for unchained read_and_X replies. I could hook this into some of
the other *read* replies but this is the one smbtorture uses so it served my
purpose.  Of course this is against the current CVS head, not some wimpy
stable branch. :)

I still need to write some code to make this safe (things will break badly
if multiple clients hit the same file and one of them truncates at just the
right time).

In my tests, this only improved things by a couple of percent because we do
so many other things than just serving files in real life (well if you can
call netbench land real life).

Anton

diff -u -u -r1.195 includes.h
--- source/include/includes.h	2000/12/06 00:05:14	1.195
+++ source/include/includes.h	2001/01/26 05:38:51
@@ -871,7 +871,8 @@
 
 /* default socket options. Dave Miller thinks we should default to TCP_NODELAY
    given the socket IO pattern that Samba uses */
-#ifdef TCP_NODELAY
+
+#if 0
 #define DEFAULT_SOCKET_OPTIONS "TCP_NODELAY"
 #else
 #define DEFAULT_SOCKET_OPTIONS ""
diff -u -u -r1.257 reply.c
--- source/smbd/reply.c	2001/01/24 19:34:53	1.257
+++ source/smbd/reply.c	2001/01/26 05:38:53
@@ -2383,6 +2391,51 @@
     END_PROFILE(SMBreadX);
     return(ERROR(ERRDOS,ERRlock));
   }
+
+#if 1
+  /* We can use sendfile if it is not chained */
+  if (CVAL(inbuf,smb_vwv0) == 0xFF) {
+    off_t tmpoffset;
+    struct stat buf;
+    int flags = 0;
+
+    nread = smb_maxcnt;
+
+    fstat(fsp->fd, &buf);
+    if (startpos > buf.st_size)
+      return(UNIXERROR(ERRDOS,ERRnoaccess));
+    if (nread > (buf.st_size - startpos))
+       nread = (buf.st_size - startpos);
+
+    SSVAL(outbuf,smb_vwv5,nread);
+    SSVAL(outbuf,smb_vwv6,smb_offset(data,outbuf));
+    SSVAL(smb_buf(outbuf),-2,nread);
+    CVAL(outbuf,smb_vwv0) = 0xFF;
+    set_message(outbuf,12,nread,False);
+
+#define MSG_MORE 0x8000
+    if (nread > 0)
+       flags = MSG_MORE;
+    if (send(smbd_server_fd(), outbuf, data - outbuf, flags) == -1)
+      DEBUG(0,("reply_read_and_X: send ERROR!\n"));
+
+    tmpoffset = startpos;
+    while(nread) {
+    	int nwritten;
+	nwritten = sendfile(smbd_server_fd(), fsp->fd, &tmpoffset, nread);
+	if (nwritten == -1)
+	  DEBUG(0,("reply_read_and_X: sendfile ERROR!\n"));
+
+	if (!nwritten)
+		break;
+
+	nread -= nwritten;
+    }
+
+    return -1;
+  }
+#endif
+
   nread = read_file(fsp,data,startpos,smb_maxcnt);
   
   if (nread < 0) {
