Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272473AbTHIRgX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272623AbTHIRgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:36:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43396 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272473AbTHIRgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:36:20 -0400
Date: Sat, 9 Aug 2003 18:35:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix protocol bugs with NFS and nanoseconds
Message-ID: <20030809173546.GA29917@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS with 2.5.75 as both client and server is totally broken with GNU
Make.  Kernel builds fail.  The nanosecond field of timestamps of
newly touched files is often negative on the client, which is probably
why Make fails.  The value also bears no relation to the file's
nanosecond field on the server.

The culprit is htons() used where htonl() should be:

-	*p++ = htonl((u32) time->tv_sec); *p++ = htons(time->tv_nsec);
+	*p++ = htonl((u32) time->tv_sec); *p++ = htonl(time->tv_nsec);

The rest of this patch corrects nfsd to use microseconds in NFSv2, not
nanoseconds.  (The client already gets this right, but I have
optimised it slightly to avoid division when possible).

With this patch, kernel builds work again over NFSv3.  The NFSv2
fix is also tested.

Please apply.

Enjoy,
-- Jamie

diff -ur orig-2.5.75/fs/nfs/nfs2xdr.c laptop-2.5.75/fs/nfs/nfs2xdr.c
--- orig-2.5.75/fs/nfs/nfs2xdr.c	2003-07-08 21:40:56.000000000 +0100
+++ laptop-2.5.75/fs/nfs/nfs2xdr.c	2003-08-09 17:57:08.498827393 +0100
@@ -90,7 +90,7 @@
 {
 	*p++ = htonl(timep->tv_sec);
 	/* Convert nanoseconds into microseconds */
-	*p++ = htonl(timep->tv_nsec / 1000);
+	*p++ = htonl(timep->tv_nsec ? timep->tv_nsec / 1000 : 0);
 	return p;
 }
 
diff -ur orig-2.5.75/fs/nfsd/nfs3xdr.c laptop-2.5.75/fs/nfsd/nfs3xdr.c
--- orig-2.5.75/fs/nfsd/nfs3xdr.c	2003-07-08 21:55:24.000000000 +0100
+++ laptop-2.5.75/fs/nfsd/nfs3xdr.c	2003-08-09 17:59:34.416338758 +0100
@@ -4,6 +4,8 @@
  * XDR support for nfsd/protocol version 3.
  *
  * Copyright (C) 1995, 1996, 1997 Olaf Kirch <okir@monad.swb.de>
+ *
+ * 2003-08-09 Jamie Lokier: Use htonl() for nanoseconds, not htons()!
  */
 
 #include <linux/types.h>
@@ -43,7 +45,7 @@
 static inline u32 *
 encode_time3(u32 *p, struct timespec *time)
 {
-	*p++ = htonl((u32) time->tv_sec); *p++ = htons(time->tv_nsec);
+	*p++ = htonl((u32) time->tv_sec); *p++ = htonl(time->tv_nsec);
 	return p;
 }
 
diff -ur orig-2.5.75/fs/nfsd/nfsxdr.c laptop-2.5.75/fs/nfsd/nfsxdr.c
--- orig-2.5.75/fs/nfsd/nfsxdr.c	2003-07-08 21:54:20.000000000 +0100
+++ laptop-2.5.75/fs/nfsd/nfsxdr.c	2003-08-09 17:57:52.963829023 +0100
@@ -123,13 +123,13 @@
 	if (tmp != (u32)-1 && tmp1 != (u32)-1) {
 		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 		iap->ia_atime.tv_sec = tmp;
-		iap->ia_atime.tv_nsec = tmp1; 
+		iap->ia_atime.tv_nsec = tmp1 * 1000; 
 	}
 	tmp  = ntohl(*p++); tmp1 = ntohl(*p++);
 	if (tmp != (u32)-1 && tmp1 != (u32)-1) {
 		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
 		iap->ia_mtime.tv_sec = tmp;
-		iap->ia_mtime.tv_nsec = tmp1; 
+		iap->ia_mtime.tv_nsec = tmp1 * 1000; 
 	}
 	return p;
 }
@@ -171,12 +171,12 @@
 		*p++ = htonl((u32) stat.dev);
 	*p++ = htonl((u32) stat.ino);
 	*p++ = htonl((u32) stat.atime.tv_sec);
-	*p++ = htons(stat.atime.tv_nsec);
+	*p++ = htonl(stat.atime.tv_nsec ? stat.atime.tv_nsec / 1000 : 0);
 	lease_get_mtime(dentry->d_inode, &time); 
 	*p++ = htonl((u32) time.tv_sec);
-	*p++ = htons(time.tv_nsec); 
+	*p++ = htonl(time.tv_nsec ? time.tv_nsec / 1000 : 0); 
 	*p++ = htonl((u32) stat.ctime.tv_sec);
-	*p++ = htons(stat.ctime.tv_nsec);
+	*p++ = htonl(stat.ctime.tv_nsec ? stat.ctime.tv_nsec / 1000 : 0);
 
 	return p;
 }
