Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWAEKEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWAEKEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWAEKEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:04:04 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:63421 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750810AbWAEKED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:04:03 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: <torvalds@osdl.org>, <viro@zeniv.linux.org.uk>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <trond.myklebust@fys.uio.no>
Subject: [PATCH 1/3] Fix problems on multi-TB filesystem and file
Date: Thu, 5 Jan 2006 19:03:47 +0900
Message-ID: <000001c611df$5556aa00$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I sent following patches three weeks ago, but I got only a few
responses.
So, I am sending them again.  Comments are always welcome.

We made patches to fix problems that occur when handling a large
filesystem and a large file.  It was discussed on the mails titled
"stat64 for over 2TB file returned invalid st_blocks".

They consist of three patches.
[1/3] Fix the problem that st_blocks is invalid when calling stat64
      for > 2TB-file.
[2/3] Add blkcnt_t as the type of inode.i_blocks.
      This enables you to make the size of blkcnt_t either 4 bytes
      or 8 bytes on 32 bits architecture with new configuration
      parameter (CONFIG_LSF).
[3/3] Fix the problem that kstatfs's entries related to blocks are
      invalid on statfs64 for a network filesystem which has more
      than 2^32-1 blocks when CONFIG_LBD is disabled.  This fix was
      proposed by Trond Myklebust.

The content of the patch attached to this mail is below.
- inode.i_blocks
    Change the type from unsigned long to sector_t.
- kstat.blocks
    Change the type from unsigned long to unsigned long long.
- stat64.st_blocks
    Change the type from unsigned long to unsigned long long on
    architectures (i386, m68k, sh).

Any feedback and comments are welcome.

Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>

diff -uprN -X linux-2.6.15.org/Documentation/dontdiff linux-2.6.15.org/include/asm-i386/stat.h
linux-2.6.15-iblocks/include/asm-i386/stat.h
--- linux-2.6.15.org/include/asm-i386/stat.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.15-iblocks/include/asm-i386/stat.h	2006-01-04 15:39:06.000000000 +0900
@@ -58,8 +58,7 @@ struct stat64 {
 	long long	st_size;
 	unsigned long	st_blksize;

-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-	unsigned long	__pad4;		/* future possible st_blocks high bits */
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */

 	unsigned long	st_atime;
 	unsigned long	st_atime_nsec;
diff -uprN -X linux-2.6.15.org/Documentation/dontdiff linux-2.6.15.org/include/asm-m68k/stat.h
linux-2.6.15-iblocks/include/asm-m68k/stat.h
--- linux-2.6.15.org/include/asm-m68k/stat.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.15-iblocks/include/asm-m68k/stat.h	2006-01-04 15:39:06.000000000 +0900
@@ -60,8 +60,7 @@ struct stat64 {
 	long long	st_size;
 	unsigned long	st_blksize;

-	unsigned long	__pad4;		/* future possible st_blocks high bits */
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
+	unsigned long long	st_blocks;	/* Number 512-byte blocks allocated. */

 	unsigned long	st_atime;
 	unsigned long	st_atime_nsec;
diff -uprN -X linux-2.6.15.org/Documentation/dontdiff linux-2.6.15.org/include/asm-sh/stat.h
linux-2.6.15-iblocks/include/asm-sh/stat.h
--- linux-2.6.15.org/include/asm-sh/stat.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.15-iblocks/include/asm-sh/stat.h	2006-01-04 15:39:06.000000000 +0900
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
diff -uprN -X linux-2.6.15.org/Documentation/dontdiff linux-2.6.15.org/include/linux/fs.h linux-2.6.15-iblocks/include/linux/fs.h
--- linux-2.6.15.org/include/linux/fs.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.15-iblocks/include/linux/fs.h	2006-01-04 15:39:06.000000000 +0900
@@ -450,7 +450,7 @@ struct inode {
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
 	unsigned long		i_version;
-	unsigned long		i_blocks;
+	sector_t		i_blocks;
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct semaphore	i_sem;
diff -uprN -X linux-2.6.15.org/Documentation/dontdiff linux-2.6.15.org/include/linux/stat.h
linux-2.6.15-iblocks/include/linux/stat.h
--- linux-2.6.15.org/include/linux/stat.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.15-iblocks/include/linux/stat.h	2006-01-04 15:39:06.000000000 +0900
@@ -69,7 +69,7 @@ struct kstat {
 	struct timespec	mtime;
 	struct timespec	ctime;
 	unsigned long	blksize;
-	unsigned long	blocks;
+	unsigned long long	blocks;
 };

 #endif

-- Takashi Sato


