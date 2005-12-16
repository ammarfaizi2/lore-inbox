Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVLPNNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVLPNNH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVLPNNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:13:07 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:3316 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932604AbVLPNNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:13:05 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: <viro@zeniv.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>
Subject: [PATCH 1/3] Fix problems on multi-TB filesystem and file
Date: Fri, 16 Dec 2005 22:10:39 +0900
Message-ID: <000001c60242$1f86c1a0$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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


