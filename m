Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRAZGMR>; Fri, 26 Jan 2001 01:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAZGMI>; Fri, 26 Jan 2001 01:12:08 -0500
Received: from linuxcare.com.au ([203.29.91.49]:61713 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129367AbRAZGMB>; Fri, 26 Jan 2001 01:12:01 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Fri, 26 Jan 2001 17:10:15 +1100
To: Sasi Peter <sape@iq.rulez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010126171014.B18463@linuxcare.com>
In-Reply-To: <20010125212033.E14807@linuxcare.com> <Pine.LNX.4.30.0101251157400.5377-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0101251157400.5377-100000@iq.rulez.org>; from sape@iq.rulez.org on Thu, Jan 25, 2001 at 11:58:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Do you have it at a URL?

The patch is small so I have attached it to this email. It should apply
to the samba CVS tree. Remember this is still a hack and I need to add
code to ensure the file is not truncated and we sendfile() less than we
promised. (After talking to tridge and davem, this should be fixed shortly.)

There is a lot more going on than in the web serving case, so
sendfile+zero copy is not going to help us as much as it did for the tux
guys. For example currently on 2.4.0 + zero copy patches:

anton@drongo:~/dbench$ ~anton/samba/source/bin/smbtorture //otherhost/netbench -U% -N 15 NBW95

read/write:
Throughput 16.5478 MB/sec (NB=20.6848 MB/sec  165.478 MBit/sec)

sendfile:
Throughput 17.0128 MB/sec (NB=21.266 MB/sec  170.128 MBit/sec)

Of course there is still lots to be done :)

Cheers,
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
