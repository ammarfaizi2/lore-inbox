Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVLGK5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVLGK5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVLGK5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:57:45 -0500
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:64206 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750786AbVLGK5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:57:44 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: "'Andreas Dilger'" <adilger@clusterfs.com>
Cc: "'Dave Kleikamp'" <shaggy@austin.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>
Subject: RE: stat64 for over 2TB file returned invalid st_blocks
Date: Wed, 7 Dec 2005 19:57:33 +0900
Message-ID: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <20051206212416.GZ14509@schatzie.adilger.int>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > On Tue, 2005-12-06 at 08:30 -0600, Dave Kleikamp wrote:
> > > I think it looks good.  The only issue I have is that I agree with
> > > Andreas that i_blocks should be of type sector_t.  I find the case
> > > of accessing very large files over nfs with CONFIG_LBD disabled to
> > > be very unlikely.
> >
> > NO! sector_t is a block-device specific type. It does not belong in
> > the generic inode.
>
> sector_t would imply "units of 512-byte sectors", and this is exactly
> what i_blocks is actually measuring, so I don't really understand your
> objection.
>
> If you have objection to the use of sector_t, it could be some other
> type that is defined virtually identically as CONFIG_LBD sector_t,
> except that it might be desirable to allow it to be configured
> separately for network filesystems that have large files.  I'm sure
> the embedded linux folks wouldn't be thrilled at an extra 4 bytes in
> every inode and 64-bit math if they don't really use it.
>
> Even in HPC very few users have many-TB files, and Lustre is one of
> the few filesystems that can actually do this today.  We of course
> would enable this option for our kernels, but I don't want to force it
> upon everyone.

On my previous mail, I said that CONFIG_LBD should not determine
whether large single files is enabled.  But after further
consideration, on such a small system that CONFIG_LBD is disabled,
using large filesystem over network seems to be very rare.
So I think that the type of i_blocks should be sector_t.

Below shows the updated patch.

This patch fixes st_blocks of >2TB file on 32-bit linux.
- inode.i_blocks
  changes to sector_t whose size depends on CONFIG_LBD.
- kstat.blocks
  changes to `unsigned long long'.
- stat64.st_blocks
  changes to `unsigned long long' on i386, m68k and sh.

Any feedback and comments are welcome.

Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>

diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-i386/stat.h
linux-2.6.15-rc5-blocks/include/asm-i386/stat.h
--- linux-2.6.15-rc5.org/include/asm-i386/stat.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-i386/stat.h	2005-12-06 16:24:31.000000000 +0900
@@ -58,8 +58,7 @@ struct stat64 {
 	long long	st_size;
 	unsigned long	st_blksize;

-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-	unsigned long	__pad4;		/* future possible st_blocks high bits */
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */

 	unsigned long	st_atime;
 	unsigned long	st_atime_nsec;
diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-m68k/stat.h
linux-2.6.15-rc5-blocks/include/asm-m68k/stat.h
--- linux-2.6.15-rc5.org/include/asm-m68k/stat.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-m68k/stat.h	2005-12-06 16:29:50.000000000 +0900
@@ -60,8 +60,7 @@ struct stat64 {
 	long long	st_size;
 	unsigned long	st_blksize;

-	unsigned long	__pad4;		/* future possible st_blocks high bits */
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */

 	unsigned long	st_atime;
 	unsigned long	st_atime_nsec;
diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/asm-sh/stat.h
linux-2.6.15-rc5-blocks/include/asm-sh/stat.h
--- linux-2.6.15-rc5.org/include/asm-sh/stat.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-sh/stat.h	2005-12-06 16:28:37.000000000 +0900
@@ -60,13 +60,7 @@ struct stat64 {
 	long long	st_size;
 	unsigned long	st_blksize;

-#if defined(__BIG_ENDIAN__)
-	unsigned long	__pad4;		/* Future possible st_blocks hi bits */
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-#else /* Must be little */
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-	unsigned long	__pad4;		/* Future possible st_blocks hi bits */
-#endif
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */

 	unsigned long	st_atime;
 	unsigned long	st_atime_nsec;
diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/linux/fs.h
linux-2.6.15-rc5-blocks/include/linux/fs.h
--- linux-2.6.15-rc5.org/include/linux/fs.h	2005-12-06 16:20:21.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/linux/fs.h	2005-12-07 14:35:42.000000000 +0900
@@ -450,7 +450,7 @@ struct inode {
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
 	unsigned long		i_version;
-	unsigned long		i_blocks;
+	sector_t		i_blocks;
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct semaphore	i_sem;
diff -uprN -X linux-2.6.15-rc5.org/Documentation/dontdiff linux-2.6.15-rc5.org/include/linux/stat.h
linux-2.6.15-rc5-blocks/include/linux/stat.h
--- linux-2.6.15-rc5.org/include/linux/stat.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/linux/stat.h	2005-12-06 16:26:26.000000000 +0900
@@ -69,7 +69,7 @@ struct kstat {
 	struct timespec	mtime;
 	struct timespec	ctime;
 	unsigned long	blksize;
-	unsigned long	blocks;
+	unsigned long long	blocks;
 };

 #endif

-- Takashi Sato


