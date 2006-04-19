Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWDSOFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWDSOFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWDSOFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:05:52 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:37550 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1750785AbWDSOFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:05:51 -0400
Date: Wed, 19 Apr 2006 08:05:40 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, ralf@linux-mips.org,
       paulus@samba.org, schwidefsky@de.ibm.com, lethal@linux-sh.org,
       kkojima@rr.iij4u.or.jp, ysato@users.sourceforge.jp
Subject: [PATCH] Handle CONFIG_LBD and CONFIG_LSF in one place
Message-ID: <20060419140540.GK24104@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_LBD and CONFIG_LSF are spread into asm/types.h for no particularly
good reason.  Centralising the definition in linux/types.h means that arch
maintainers don't need to bother adding it, as well as fixing the problem
with x86-64 users being asked to make a decision that has absolutely no
effect.  The H8/300 porters seem particularly confused since I'm not aware
of any microcontrollers that need to support 2TB filesystems these days.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: ./block/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/block/Kconfig,v
retrieving revision 1.4
diff -u -p -r1.4 Kconfig
--- ./block/Kconfig	3 Apr 2006 13:44:01 -0000	1.4
+++ ./block/Kconfig	19 Apr 2006 13:43:26 -0000
@@ -1,11 +1,9 @@
 #
 # Block layer core configuration
 #
-#XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
-#for instance.
 config LBD
 	bool "Support for Large Block Devices"
-	depends on X86 || (MIPS && 32BIT) || PPC32 || (S390 && !64BIT) || SUPERH || UML
+	depends on !64BIT
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
@@ -26,7 +24,7 @@ config BLK_DEV_IO_TRACE
 
 config LSF
 	bool "Support for Large Single Files"
-	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
+	depends on !64BIT
 	help
 	  Say Y here if you want to be able to handle very large files (bigger
 	  than 2TB), otherwise say N.
Index: ./include/asm-h8300/types.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-h8300/types.h,v
retrieving revision 1.5
diff -u -p -r1.5 types.h
--- ./include/asm-h8300/types.h	3 Apr 2006 13:45:48 -0000	1.5
+++ ./include/asm-h8300/types.h	19 Apr 2006 13:40:47 -0000
@@ -55,12 +55,6 @@ typedef unsigned long long u64;
 
 typedef u32 dma_addr_t;
 
-#define HAVE_SECTOR_T
-typedef u64 sector_t;
-
-#define HAVE_BLKCNT_T
-typedef u64 blkcnt_t;
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
Index: ./include/asm-i386/types.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-i386/types.h,v
retrieving revision 1.4
diff -u -p -r1.4 types.h
--- ./include/asm-i386/types.h	3 Apr 2006 13:45:49 -0000	1.4
+++ ./include/asm-i386/types.h	19 Apr 2006 13:36:02 -0000
@@ -58,16 +58,6 @@ typedef u32 dma_addr_t;
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
Index: ./include/asm-mips/types.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-mips/types.h,v
retrieving revision 1.6
diff -u -p -r1.6 types.h
--- ./include/asm-mips/types.h	3 Apr 2006 13:45:53 -0000	1.6
+++ ./include/asm-mips/types.h	19 Apr 2006 13:36:08 -0000
@@ -94,16 +94,6 @@ typedef unsigned long long phys_t;
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
Index: ./include/asm-powerpc/types.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-powerpc/types.h,v
retrieving revision 1.3
diff -u -p -r1.3 types.h
--- ./include/asm-powerpc/types.h	3 Apr 2006 13:45:55 -0000	1.3
+++ ./include/asm-powerpc/types.h	19 Apr 2006 13:36:14 -0000
@@ -98,16 +98,6 @@ typedef struct {
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
Index: ./include/asm-s390/types.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-s390/types.h,v
retrieving revision 1.6
diff -u -p -r1.6 types.h
--- ./include/asm-s390/types.h	3 Apr 2006 13:45:56 -0000	1.6
+++ ./include/asm-s390/types.h	19 Apr 2006 13:36:20 -0000
@@ -88,16 +88,6 @@ typedef union {
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
Index: ./include/asm-sh/types.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-sh/types.h,v
retrieving revision 1.5
diff -u -p -r1.5 types.h
--- ./include/asm-sh/types.h	3 Apr 2006 13:45:57 -0000	1.5
+++ ./include/asm-sh/types.h	19 Apr 2006 13:36:26 -0000
@@ -53,16 +53,6 @@ typedef unsigned long long u64;
 
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
Index: ./include/linux/types.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/types.h,v
retrieving revision 1.11
diff -u -p -r1.11 types.h
--- ./include/linux/types.h	3 Apr 2006 13:46:02 -0000	1.11
+++ ./include/linux/types.h	19 Apr 2006 13:40:32 -0000
@@ -130,14 +130,19 @@ typedef		__s64		int64_t;
 
 /*
  * The type used for indexing onto a disc or disc partition.
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
 
