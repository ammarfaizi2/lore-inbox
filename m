Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSDQRAI>; Wed, 17 Apr 2002 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSDQRAH>; Wed, 17 Apr 2002 13:00:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17230 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310258AbSDQRAF>; Wed, 17 Apr 2002 13:00:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 boot enhancements, cleanups 4/11
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 10:52:49 -0600
Message-ID: <m1vgaqgtcu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus please apply,


  All changes are syntactic the generated code is not affected.

- e820.h Add define E820ENTRY_SIZE

- boot.h Add defines for address space divisions.

- Add define KERNEL_START in setup.S so if I need this
  value more than once it is easy to get at.

Eric

diff -uNr linux-2.5.8.boot.spring-cleaning/arch/i386/boot/setup.S linux-2.5.8.boot.syntax/arch/i386/boot/setup.S
--- linux-2.5.8.boot.spring-cleaning/arch/i386/boot/setup.S	Tue Apr 16 20:13:05 2002
+++ linux-2.5.8.boot.syntax/arch/i386/boot/setup.S	Tue Apr 16 20:32:53 2002
@@ -56,6 +56,12 @@
 #define SIG1	0xAA55
 #define SIG2	0x5A5A
 
+#ifndef __BIG_KERNEL__
+#define KERNEL_START LOW_BASE		/* zImage */
+#else
+#define KERNEL_START HIGH_BASE 		/* bzImage */
+#endif
+
 INITSEG  = DEF_INITSEG		# 0x9000, we move boot here, out of the way
 SYSSEG   = DEF_SYSSEG		# 0x1000, system loaded at 0x10000 (65536).
 SETUPSEG = DEF_SETUPSEG		# 0x9020, this is the current segment
@@ -115,13 +121,8 @@
 					# loader knows how much data behind
 					# us also needs to be loaded.
 
-code32_start:				# here loaders can put a different
+code32_start:	.long	KERNEL_START	# here loaders can put a different
 					# start address for 32-bit code.
-#ifndef __BIG_KERNEL__
-		.long	0x1000		#   0x1000 = default for zImage
-#else
-		.long	0x100000	# 0x100000 = default for big kernel
-#endif
 
 ramdisk_image:	.long	0		# address of loaded ramdisk image
 					# Here the loader puts the 32-bit
@@ -340,7 +341,7 @@
 
 	incb	(E820NR)
 	movw	%di, %ax
-	addw	$20, %ax
+	addw	$E820ENTRY_SIZE, %ax
 	movw	%ax, %di
 again820:
 	cmpl	$0, %ebx			# check to see if
diff -uNr linux-2.5.8.boot.spring-cleaning/include/asm-i386/boot.h linux-2.5.8.boot.syntax/include/asm-i386/boot.h
--- linux-2.5.8.boot.spring-cleaning/include/asm-i386/boot.h	Wed Apr 16 15:15:00 1997
+++ linux-2.5.8.boot.syntax/include/asm-i386/boot.h	Wed Apr 17 00:13:56 2002
@@ -1,6 +1,19 @@
 #ifndef _LINUX_BOOT_H
 #define _LINUX_BOOT_H
 
+/* Address space division during load */
+	/* Memory below 640 we can use for loading */
+#define LOW_BASE   0x001000
+#define LOW_MAX    0x0a0000  /* Maximum low memory address to use */
+	/* Memory above 640 we can use for loading */
+#define HIGH_BASE  0x100000
+#define HIGH_MAX   __MAXMEM
+	/* Subset of the low segment that is generally safe to
+	 * use for loading.
+	 */
+#define REAL_BASE  0x010000
+#define REAL_MAX   0x090000
+
 /* Don't touch these, unless you really know what you're doing. */
 #define DEF_INITSEG	0x9000
 #define DEF_SYSSEG	0x1000
diff -uNr linux-2.5.8.boot.spring-cleaning/include/asm-i386/e820.h linux-2.5.8.boot.syntax/include/asm-i386/e820.h
--- linux-2.5.8.boot.spring-cleaning/include/asm-i386/e820.h	Fri Aug 18 10:30:51 2000
+++ linux-2.5.8.boot.syntax/include/asm-i386/e820.h	Tue Apr 16 20:32:53 2002
@@ -15,6 +15,7 @@
 #define E820MAP	0x2d0		/* our map */
 #define E820MAX	32		/* number of entries in E820MAP */
 #define E820NR	0x1e8		/* # entries in E820MAP */
+#define E820ENTRY_SIZE 20	/* size of an E820MAP entry */
 
 #define E820_RAM	1
 #define E820_RESERVED	2
