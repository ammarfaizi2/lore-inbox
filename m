Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314525AbSEBO7E>; Thu, 2 May 2002 10:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314526AbSEBO7D>; Thu, 2 May 2002 10:59:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12649 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314525AbSEBO65>; Thu, 2 May 2002 10:58:57 -0400
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, constants  4/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
	<m1wuumy5eo.fsf@frodo.biederman.org>
	<m1sn5ay5ac.fsf_-_@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2002 08:51:06 -0600
Message-ID: <m1offyy55x.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply,

This patch introduces several constants to the x86 boot process.

Eric

diff -uNr linux-2.5.12.boot.spring-cleaning/arch/i386/boot/setup.S linux-2.5.12.boot.syntax/arch/i386/boot/setup.S
--- linux-2.5.12.boot.spring-cleaning/arch/i386/boot/setup.S	Wed May  1 09:38:54 2002
+++ linux-2.5.12.boot.syntax/arch/i386/boot/setup.S	Wed May  1 09:39:11 2002
@@ -59,6 +59,12 @@
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
@@ -118,13 +124,8 @@
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
@@ -343,7 +344,7 @@
 
 	incb	(E820NR)
 	movw	%di, %ax
-	addw	$20, %ax
+	addw	$E820ENTRY_SIZE, %ax
 	movw	%ax, %di
 again820:
 	cmpl	$0, %ebx			# check to see if
diff -uNr linux-2.5.12.boot.spring-cleaning/include/asm-i386/boot.h linux-2.5.12.boot.syntax/include/asm-i386/boot.h
--- linux-2.5.12.boot.spring-cleaning/include/asm-i386/boot.h	Wed Apr 16 15:15:00 1997
+++ linux-2.5.12.boot.syntax/include/asm-i386/boot.h	Wed May  1 09:39:11 2002
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
diff -uNr linux-2.5.12.boot.spring-cleaning/include/asm-i386/e820.h linux-2.5.12.boot.syntax/include/asm-i386/e820.h
--- linux-2.5.12.boot.spring-cleaning/include/asm-i386/e820.h	Fri Aug 18 10:30:51 2000
+++ linux-2.5.12.boot.syntax/include/asm-i386/e820.h	Wed May  1 09:39:11 2002
@@ -15,6 +15,7 @@
 #define E820MAP	0x2d0		/* our map */
 #define E820MAX	32		/* number of entries in E820MAP */
 #define E820NR	0x1e8		/* # entries in E820MAP */
+#define E820ENTRY_SIZE 20	/* size of an E820MAP entry */
 
 #define E820_RAM	1
 #define E820_RESERVED	2
