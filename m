Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132682AbRDQUhB>; Tue, 17 Apr 2001 16:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132678AbRDQUgy>; Tue, 17 Apr 2001 16:36:54 -0400
Received: from thorin.y.ics.muni.cz ([147.251.61.126]:61190 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S132702AbRDQUgk>; Tue, 17 Apr 2001 16:36:40 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Tue, 17 Apr 2001 22:36:36 +0200
To: Jesse S Sipprell <jss@inflicted.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        proftpd-devel@proftpd.org, pavel@janik.cz
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417223636.C2167@informatics.muni.cz>
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz> <E14pXxg-0002cI-00@the-village.bc.nu> <20010417181524.E2589096@informatics.muni.cz> <20010417161036.A21620@bastard.inflicted.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010417161036.A21620@bastard.inflicted.net>; from jss@inflicted.net on Tue, Apr 17, 2001 at 04:10:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse S Sipprell wrote:
: After cursory examination of proftpd, it appears that there is a misuse of the
: sendfile() call under Linux, which may be responsible for the corruption.  The
: code was originally based on BSD semantics.  Under Linux, the offset argument
: is not being used correctly to determine how much data has been sent in the
: case of EINTR.
: 
: A patch will be coming out soon, as it is a fairly trivial fix.
: 
	FWIW, I've fixed ProFTPd on my server with the following patch.
Sorry for making noise @ linux-kernel list, it was totally unrelated
to the Linux kernel:

--- proftpd-1.2.2rc1/src/data.c.sendfile	Thu Feb 15 15:24:53 2001
+++ proftpd-1.2.2rc1/src/data.c	Tue Apr 17 21:35:24 2001
@@ -760,7 +760,9 @@
      *
      * ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
      */
-    if((len = sendfile(session.d->outf->fd, retr_fd, offset, count)) == -1) {
+    len = sendfile(session.d->outf->fd, retr_fd, offset, count);
+    if (len == -1 || len > 0 && len < count) {
+       errno = EINTR;
 #elif defined(HAVE_BSD_SENDFILE)
     /* BSD semantics for sendfile are flexible...it'd be nice if we could
      * standardize on something like it.  The semantics are:
@@ -797,7 +799,9 @@
 	if((count -= len) <= 0)
 	  break;
 	
+#if !defined(HAVE_LINUX_SENDFILE)
 	*offset += len;
+#endif
 	
 	if(TimeoutStalled)
 	  reset_timer(TIMER_STALLED, ANY_MODULE);

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
Mantra: "everything is a stream of bytes". Repeat until enlightened. --Linus
