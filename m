Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWJERGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWJERGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWJERGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:06:39 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:22923 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751434AbWJERGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:06:37 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Centralise definitions of sector_t and blkcnt_t
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Thu, 05 Oct 2006 11:04:11 -0600
Message-Id: <11600678512429-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
X-Spam-Score: 0.1 (/)
X-Spam-Report: SpamAssassin version 3.0.6 on pentafluge.infradead.org summary:
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_LBD and CONFIG_LSF are spread into asm/types.h for no particularly
good reason.  Centralising the definition in linux/types.h means that arch
maintainers don't need to bother adding it, as well as fixing the problem
with x86-64 users being asked to make a decision that has absolutely no
effect.  The H8/300 porters seem particularly confused since I'm not aware
of any microcontrollers that need to support 2TB filesystems these days.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
---
 block/Kconfig               |    6 ++----
 include/asm-h8300/types.h   |    6 ------
 include/asm-i386/types.h    |   10 ----------
 include/asm-mips/types.h    |   10 ----------
 include/asm-powerpc/types.h |   10 ----------
 include/asm-s390/types.h    |   10 ----------
 include/asm-sh/types.h      |   10 ----------
 include/asm-x86_64/types.h  |    3 ---
 include/linux/types.h       |   14 +++++++++-----
 9 files changed, 11 insertions(+), 68 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 83766a6..a50f481 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -19,11 +19,9 @@ config BLOCK
 
 if BLOCK
 
-#XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
-#for instance.
 config LBD
 	bool "Support for Large Block Devices"
-	depends on X86 || (MIPS && 32BIT) || PPC32 || (S390 && !64BIT) || SUPERH || UML
+	depends on !64BIT
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
@@ -44,7 +42,7 @@ config BLK_DEV_IO_TRACE
 
 config LSF
 	bool "Support for Large Single Files"
-	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
+	depends on !64BIT
 	help
 	  Say Y here if you want to be able to handle very large files (bigger
 	  than 2TB), otherwise say N.
diff --git a/include/asm-h8300/types.h b/include/asm-h8300/types.h
index da2402b..2a8b1b2 100644
--- a/include/asm-h8300/types.h
+++ b/include/asm-h8300/types.h
@@ -55,12 +55,6 @@ #define BITS_PER_LONG 32
 
 typedef u32 dma_addr_t;
 
-#define HAVE_SECTOR_T
-typedef u64 sector_t;
-
-#define HAVE_BLKCNT_T
-typedef u64 blkcnt_t;
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
index 4b4b295..ad0a55b 100644
--- a/include/asm-i386/types.h
+++ b/include/asm-i386/types.h
@@ -57,16 +57,6 @@ typedef u32 dma_addr_t;
 #endif
 typedef u64 dma64_addr_t;
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
-#ifdef CONFIG_LSF
-typedef u64 blkcnt_t;
-#define HAVE_BLKCNT_T
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/include/asm-mips/types.h b/include/asm-mips/types.h
index 2b52e18..63a13c5 100644
--- a/include/asm-mips/types.h
+++ b/include/asm-mips/types.h
@@ -93,16 +93,6 @@ #else
 typedef unsigned long phys_t;
 #endif
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
-#ifdef CONFIG_LSF
-typedef u64 blkcnt_t;
-#define HAVE_BLKCNT_T
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/types.h b/include/asm-powerpc/types.h
index d6fb56b..3b36375 100644
--- a/include/asm-powerpc/types.h
+++ b/include/asm-powerpc/types.h
@@ -97,16 +97,6 @@ typedef struct {
 	unsigned long env;
 } func_descr_t;
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
-#ifdef CONFIG_LSF
-typedef u64 blkcnt_t;
-#define HAVE_BLKCNT_T
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/include/asm-s390/types.h b/include/asm-s390/types.h
index ae2951c..fc5d7cf 100644
--- a/include/asm-s390/types.h
+++ b/include/asm-s390/types.h
@@ -87,16 +87,6 @@ typedef union {
 	} subreg;
 } register_pair;
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
-#ifdef CONFIG_LSF
-typedef u64 blkcnt_t;
-#define HAVE_BLKCNT_T
-#endif
-
 #endif /* ! __s390x__   */
 #endif /* __ASSEMBLY__  */
 #endif /* __KERNEL__    */
diff --git a/include/asm-sh/types.h b/include/asm-sh/types.h
index 3c09dd4..fd00dbb 100644
--- a/include/asm-sh/types.h
+++ b/include/asm-sh/types.h
@@ -52,16 +52,6 @@ typedef unsigned long long u64;
 
 typedef u32 dma_addr_t;
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
-#ifdef CONFIG_LSF
-typedef u64 blkcnt_t;
-#define HAVE_BLKCNT_T
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/include/asm-x86_64/types.h b/include/asm-x86_64/types.h
index c86c2e6..2d4491a 100644
--- a/include/asm-x86_64/types.h
+++ b/include/asm-x86_64/types.h
@@ -48,9 +48,6 @@ typedef unsigned long long u64;
 typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/include/linux/types.h b/include/linux/types.h
index 750f085..c0fa603 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -134,15 +134,19 @@ #define aligned_u64 unsigned long long _
  *
  * Linux always considers sectors to be 512 bytes long independently
  * of the devices real block size.
- *
- * If required, asm/types.h can override it and define
- * HAVE_SECTOR_T
  */
-#ifndef HAVE_SECTOR_T
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#else
 typedef unsigned long sector_t;
 #endif
 
-#ifndef HAVE_BLKCNT_T
+/*
+ * The type of the inode's block count.
+ */
+#ifdef CONFIG_LSF
+typedef u64 blkcnt_t;
+#else
 typedef unsigned long blkcnt_t;
 #endif
 
-- 
1.4.1.1
