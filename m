Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVLPNNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVLPNNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVLPNNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:13:25 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:27048 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932299AbVLPNNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:13:23 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: <viro@zeniv.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>
Subject: [PATCH 2/3] Fix problems on multi-TB filesystem and file
Date: Fri, 16 Dec 2005 22:10:57 +0900
Message-ID: <000101c60242$2a247fd0$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to add blkcnt_t as the type of inode.i_blocks.
This enables you to make the size of blkcnt_t either 4 bytes or 8 bytes
on 32 bits architecture with CONFIG_LSF.

The content of the patch attached to this mail is below.
- CONFIG_LSF
  Add new configuration parameter.
- blkcnt_t
  On h8300, i386, mips, powerpc, s390 and sh that define sector_t,
  blkcnt_t is defined as u64 if CONFIG_LSF is enabled; otherwise it is
  defined as unsigned long.
  On other architectures, it is defined as unsigned long.
- inode.i_blocks
  Change the type from sector_t to blkcnt_t.

Any feedback and comments are welcome.

Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>

diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/block/Kconfig
linux-2.6.15-rc5-blocks/block/Kconfig
--- linux-2.6.15-rc5-iblocks/block/Kconfig	2005-12-13 11:51:46.000000000 +0900
+++ linux-2.6.15-rc5-blocks/block/Kconfig	2005-12-14 14:58:32.425068960 +0900
@@ -6,9 +6,19 @@
 config LBD
 	bool "Support for Large Block Devices"
 	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
+	select LSF
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
 	  bigger than 2TB.  Otherwise say N.

+config LSF
+	bool "Support for Large Single Files"
+	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
+	default n
+	help
+	  When CONFIG_LBD is disabled, say Y here if you want to
+	  handle large file(bigger than 2TB), otherwise say N.
+	  When CONFIG_LBD is enabled, Y is set automatically.
+
 source block/Kconfig.iosched
diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/include/asm-h8300/types.h
linux-2.6.15-rc5-blocks/include/asm-h8300/types.h
--- linux-2.6.15-rc5-iblocks/include/asm-h8300/types.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-h8300/types.h	2005-12-14 09:07:43.000000000 +0900
@@ -58,6 +58,9 @@ typedef u32 dma_addr_t;
 #define HAVE_SECTOR_T
 typedef u64 sector_t;

+#define HAVE_BLKCNT_T
+typedef u64 blkcnt_t;
+
 #endif /* __KERNEL__ */

 #endif /* __ASSEMBLY__ */
diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/include/asm-i386/types.h
linux-2.6.15-rc5-blocks/include/asm-i386/types.h
--- linux-2.6.15-rc5-iblocks/include/asm-i386/types.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-i386/types.h	2005-12-14 09:05:33.000000000 +0900
@@ -63,6 +63,11 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif

+#ifdef CONFIG_LSF
+typedef u64 blkcnt_t;
+#define HAVE_BLKCNT_T
+#endif
+
 #endif /* __ASSEMBLY__ */

 #endif /* __KERNEL__ */
diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/include/asm-mips/types.h
linux-2.6.15-rc5-blocks/include/asm-mips/types.h
--- linux-2.6.15-rc5-iblocks/include/asm-mips/types.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-mips/types.h	2005-12-14 09:08:04.000000000 +0900
@@ -99,6 +99,11 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif

+#ifdef CONFIG_LSF
+typedef u64 blkcnt_t;
+#define HAVE_BLKCNT_T
+#endif
+
 #endif /* __ASSEMBLY__ */

 #endif /* __KERNEL__ */
diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/include/asm-powerpc/types.h
linux-2.6.15-rc5-blocks/include/asm-powerpc/types.h
--- linux-2.6.15-rc5-iblocks/include/asm-powerpc/types.h	2005-12-13 11:51:54.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-powerpc/types.h	2005-12-14 09:06:21.000000000 +0900
@@ -103,6 +103,11 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif

+#ifdef CONFIG_LSF
+typedef u64 blkcnt_t;
+#define HAVE_BLKCNT_T
+#endif
+
 #endif /* __ASSEMBLY__ */

 #endif /* __KERNEL__ */
diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/include/asm-s390/types.h
linux-2.6.15-rc5-blocks/include/asm-s390/types.h
--- linux-2.6.15-rc5-iblocks/include/asm-s390/types.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-s390/types.h	2005-12-14 09:06:02.000000000 +0900
@@ -93,6 +93,11 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif

+#ifdef CONFIG_LSF
+typedef u64 blkcnt_t;
+#define HAVE_BLKCNT_T
+#endif
+
 #endif /* ! __s390x__   */
 #endif /* __ASSEMBLY__  */
 #endif /* __KERNEL__    */
diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/include/asm-sh/types.h
linux-2.6.15-rc5-blocks/include/asm-sh/types.h
--- linux-2.6.15-rc5-iblocks/include/asm-sh/types.h	2005-10-28 09:02:08.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/asm-sh/types.h	2005-12-14 09:07:01.000000000 +0900
@@ -58,6 +58,11 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif

+#ifdef CONFIG_LSF
+typedef u64 blkcnt_t;
+#define HAVE_BLKCNT_T
+#endif
+
 #endif /* __ASSEMBLY__ */

 #endif /* __KERNEL__ */
diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/include/linux/fs.h
linux-2.6.15-rc5-blocks/include/linux/fs.h
--- linux-2.6.15-rc5-iblocks/include/linux/fs.h	2005-12-13 11:58:09.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/linux/fs.h	2005-12-14 08:59:59.000000000 +0900
@@ -450,7 +450,7 @@ struct inode {
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
 	unsigned long		i_version;
-	sector_t		i_blocks;
+	blkcnt_t		i_blocks;
 	unsigned short          i_bytes;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct semaphore	i_sem;
diff -uprN -X linux-2.6.15-rc5-iblocks/Documentation/dontdiff linux-2.6.15-rc5-iblocks/include/linux/types.h
linux-2.6.15-rc5-blocks/include/linux/types.h
--- linux-2.6.15-rc5-iblocks/include/linux/types.h	2005-12-13 11:51:55.000000000 +0900
+++ linux-2.6.15-rc5-blocks/include/linux/types.h	2005-12-14 09:07:26.000000000 +0900
@@ -135,6 +135,10 @@ typedef		__s64		int64_t;
 typedef unsigned long sector_t;
 #endif

+#ifndef HAVE_BLKCNT_T
+typedef unsigned long blkcnt_t;
+#endif
+
 /*
  * The type of an index into the pagecache.  Use a #define so asm/types.h
  * can override it.

-- Takashi Sato


