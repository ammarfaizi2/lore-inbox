Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269437AbRH3AQi>; Wed, 29 Aug 2001 20:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269100AbRH3AQ3>; Wed, 29 Aug 2001 20:16:29 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:41031 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269515AbRH3AQR>; Wed, 29 Aug 2001 20:16:17 -0400
Date: Wed, 29 Aug 2001 20:16:34 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
In-Reply-To: <20010829.170315.28787631.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0108292009440.28439-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001, David S. Miller wrote:

> Any problems with using "u64" or some other more strictly portable
> type?  "long long" and other non-fixed sized types cause grief for
> many dual-API platforms.

That's entirely doable; I used long long because the existing API used
long.  In fact, thinking about it a bit more, it would be better to not
add the ioctl as _IO(0x12,109), but instead use 110 and reserve 108 and
109 as braindamage ioctl writeoff (except documented, unlike the current
silent usage of ioctls by ia64).  I hate ioctls and binary
incompatibilities.  Here's the modified patch (incompatible with
e2fsprogs 1.23, but not conflicting with ia64: ioctls that write to disk
are b0rken).

		-ben

diff -urN /md0/kernels/2.4/v2.4.10-pre2/include/linux/fs.h work-v2.4.10-pre2/include/linux/fs.h
--- /md0/kernels/2.4/v2.4.10-pre2/include/linux/fs.h	Wed Aug 29 18:28:50 2001
+++ work-v2.4.10-pre2/include/linux/fs.h	Wed Aug 29 20:14:58 2001
@@ -166,7 +166,7 @@
 #define BLKROSET   _IO(0x12,93)	/* set device read-only (0 = read-write) */
 #define BLKROGET   _IO(0x12,94)	/* get read-only status (0 = read_write) */
 #define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
-#define BLKGETSIZE _IO(0x12,96)	/* return device size */
+#define BLKGETSIZE _IO(0x12,96)	/* return device size (long *arg) */
 #define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
 #define BLKRASET   _IO(0x12,98)	/* Set read ahead for block device */
 #define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
@@ -182,6 +182,8 @@
 /* This was here just to show that the number is taken -
    probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
 #endif
+/* _IO(0x12,108) and _IO(0x12,109) are reserved for binary compatibility */
+#define BLKGETSIZE64 _IO(0x12,110)	/* return device size (u64 *arg) */


 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */

