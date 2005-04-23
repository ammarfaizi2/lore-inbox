Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVDWBPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVDWBPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 21:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVDWBPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 21:15:10 -0400
Received: from fmr23.intel.com ([143.183.121.15]:64997 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261419AbVDWBOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 21:14:51 -0400
Date: Fri, 22 Apr 2005 18:14:41 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohit.seth@intel.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH] Increase number of e820 entries hard limit from 32 to 128
Message-ID: <20050422181441.A18205@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The specifications that talk about E820 map doesn't have an upper limit
on the number of E820 entries. But, today's kernel has a hard limit of 32.
With increase in memory size, we are seeing the number of E820 entries
reaching close to 32. Patch below bumps the number upto 128. 

Patch does it for both i386 and x86-64.

Side-effect: 
bss increases by ~ 2K and init.data increases by ~7.5K
on all systems, due to increase in size of static arrays.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN  linux-2.6.11/Documentation/i386/zero-page.txt.orig linux-2.6.11/Documentation/i386/zero-page.txt
--- linux-2.6.11/Documentation/i386/zero-page.txt.orig	2005-04-21 17:09:08.059184904 -0700
+++ linux-2.6.11/Documentation/i386/zero-page.txt	2005-04-21 17:09:14.955136560 -0700
@@ -79,6 +79,6 @@ Offset	Type		Description
 0x22c   unsigned long	ramdisk_max
 0x230   16 bytes 	trampoline
 0x290 - 0x2cf		EDD_MBR_SIG_BUFFER (edd.S)
-0x2d0 - 0x600		E820MAP
-0x600 - 0x7ff		EDDBUF (edd.S) for disk signature read sector
-0x600 - 0x7eb		EDDBUF (edd.S) for edd data
+0x2d0 - 0xd00		E820MAP
+0xd00 - 0xeff		EDDBUF (edd.S) for disk signature read sector
+0xd00 - 0xeeb		EDDBUF (edd.S) for edd data
diff -purN  linux-2.6.11/include/linux/edd.h.orig linux-2.6.11/include/linux/edd.h
--- linux-2.6.11/include/linux/edd.h.orig	2005-04-21 17:09:08.059184904 -0700
+++ linux-2.6.11/include/linux/edd.h	2005-04-21 17:09:14.956136408 -0700
@@ -32,7 +32,7 @@
 
 #define EDDNR 0x1e9		/* addr of number of edd_info structs at EDDBUF
 				   in boot_params - treat this as 1 byte  */
-#define EDDBUF	0x600		/* addr of edd_info structs in boot_params */
+#define EDDBUF	0xd00		/* addr of edd_info structs in boot_params */
 #define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
 #define EDDEXTSIZE 8		/* change these if you muck with the structures */
 #define EDDPARMSIZE 74
diff -purN  linux-2.6.11/include/asm-i386/e820.h.orig linux-2.6.11/include/asm-i386/e820.h
--- linux-2.6.11/include/asm-i386/e820.h.orig	2005-04-21 17:09:08.060184752 -0700
+++ linux-2.6.11/include/asm-i386/e820.h	2005-04-21 17:09:14.956136408 -0700
@@ -13,7 +13,7 @@
 #define __E820_HEADER
 
 #define E820MAP	0x2d0		/* our map */
-#define E820MAX	32		/* number of entries in E820MAP */
+#define E820MAX	128		/* number of entries in E820MAP */
 #define E820NR	0x1e8		/* # entries in E820MAP */
 
 #define E820_RAM	1
diff -purN  linux-2.6.11/include/asm-i386/setup.h.orig linux-2.6.11/include/asm-i386/setup.h
--- linux-2.6.11/include/asm-i386/setup.h.orig	2005-04-21 17:09:08.060184752 -0700
+++ linux-2.6.11/include/asm-i386/setup.h	2005-04-21 17:09:14.957136256 -0700
@@ -16,7 +16,7 @@
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 #define MAX_NONPAE_PFN	(1 << 20)
 
-#define PARAM_SIZE 2048
+#define PARAM_SIZE 4096
 #define COMMAND_LINE_SIZE 256
 
 #define OLD_CL_MAGIC_ADDR	0x90020
diff -purN  linux-2.6.11/arch/i386/boot/setup.S.orig linux-2.6.11/arch/i386/boot/setup.S
--- linux-2.6.11/arch/i386/boot/setup.S.orig	2005-04-21 17:09:08.061184600 -0700
+++ linux-2.6.11/arch/i386/boot/setup.S	2005-04-21 17:09:14.957136256 -0700
@@ -164,7 +164,7 @@ ramdisk_max:	.long (-__PAGE_OFFSET-(512 
 trampoline:	call	start_of_setup
 		.align 16
 					# The offset at this point is 0x240
-		.space	(0x7ff-0x240+1) # E820 & EDD space (ending at 0x7ff)
+		.space	(0xeff-0x240+1) # E820 & EDD space (ending at 0xeff)
 # End of setup header #####################################################
 
 start_of_setup:
@@ -333,9 +333,9 @@ jmpe820:
 	# sizeof(e820rec).
 	#
 good820:
-	movb	(E820NR), %al			# up to 32 entries
+	movb	(E820NR), %al			# up to 128 entries
 	cmpb	$E820MAX, %al
-	jnl	bail820
+	jae	bail820
 
 	incb	(E820NR)
 	movw	%di, %ax
diff -purN  linux-2.6.11/include/asm-x86_64/e820.h.orig linux-2.6.11/include/asm-x86_64/e820.h
--- linux-2.6.11/include/asm-x86_64/e820.h.orig	2005-04-21 17:09:08.061184600 -0700
+++ linux-2.6.11/include/asm-x86_64/e820.h	2005-04-21 17:09:14.958136104 -0700
@@ -14,7 +14,7 @@
 #include <linux/mmzone.h>
 
 #define E820MAP	0x2d0		/* our map */
-#define E820MAX	32		/* number of entries in E820MAP */
+#define E820MAX	128		/* number of entries in E820MAP */
 #define E820NR	0x1e8		/* # entries in E820MAP */
 
 #define E820_RAM	1
diff -purN  linux-2.6.11/include/asm-x86_64/bootsetup.h.orig linux-2.6.11/include/asm-x86_64/bootsetup.h
--- linux-2.6.11/include/asm-x86_64/bootsetup.h.orig	2005-04-21 17:09:08.061184600 -0700
+++ linux-2.6.11/include/asm-x86_64/bootsetup.h	2005-04-22 14:38:39.793893360 -0700
@@ -2,7 +2,8 @@
 #ifndef _X86_64_BOOTSETUP_H
 #define _X86_64_BOOTSETUP_H 1
 
-extern char x86_boot_params[2048];
+#define BOOT_PARAM_SIZE		4096
+extern char x86_boot_params[BOOT_PARAM_SIZE];
 
 /*
  * This is set up by the setup-routine at boot-time
diff -purN  linux-2.6.11/arch/x86_64/boot/setup.S.orig linux-2.6.11/arch/x86_64/boot/setup.S
--- linux-2.6.11/arch/x86_64/boot/setup.S.orig	2005-04-21 17:09:08.062184448 -0700
+++ linux-2.6.11/arch/x86_64/boot/setup.S	2005-04-22 15:32:57.074711408 -0700
@@ -160,7 +160,7 @@ ramdisk_max:	.long 0xffffffff
 trampoline:	call	start_of_setup
 		.align 16
 					# The offset at this point is 0x240
-		.space  (0x7ff-0x240+1)	# E820 & EDD space (ending at 0x7ff)
+		.space  (0xeff-0x240+1)	# E820 & EDD space (ending at 0xeff)
 # End of setup header #####################################################
 
 start_of_setup:
@@ -412,9 +412,9 @@ jmpe820:
 	# sizeof(e820rec).
 	#
 good820:
-	movb	(E820NR), %al			# up to 32 entries
+	movb	(E820NR), %al			# up to 128 entries
 	cmpb	$E820MAX, %al
-	jnl	bail820
+	jae	bail820
 
 	incb	(E820NR)
 	movw	%di, %ax
diff -purN  linux-2.6.11/arch/x86_64/kernel/setup64.c.orig linux-2.6.11/arch/x86_64/kernel/setup64.c
--- linux-2.6.11/arch/x86_64/kernel/setup64.c.orig	2005-04-22 15:29:38.304929008 -0700
+++ linux-2.6.11/arch/x86_64/kernel/setup64.c	2005-04-21 17:12:15.529685056 -0700
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/bootmem.h>
 #include <linux/bitops.h>
+#include <asm/bootsetup.h>
 #include <asm/pda.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -26,7 +27,7 @@
 #include <asm/mman.h>
 #include <asm/numa.h>
 
-char x86_boot_params[2048] __initdata = {0,};
+char x86_boot_params[BOOT_PARAM_SIZE] __initdata = {0,};
 
 cpumask_t cpu_initialized __initdata = CPU_MASK_NONE;
 
diff -purN  linux-2.6.11/arch/x86_64/kernel/head64.c.orig linux-2.6.11/arch/x86_64/kernel/head64.c
--- linux-2.6.11/arch/x86_64/kernel/head64.c.orig	2005-04-22 15:29:22.004407064 -0700
+++ linux-2.6.11/arch/x86_64/kernel/head64.c	2005-04-22 15:32:37.295718272 -0700
@@ -29,8 +29,6 @@ static void __init clear_bss(void)
 	       (unsigned long) __bss_end - (unsigned long) __bss_start);
 }
 
-extern char x86_boot_params[2048];
-
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC            0xA33F
@@ -44,7 +42,7 @@ static void __init copy_bootdata(char *r
 	int new_data;
 	char * command_line;
 
-	memcpy(x86_boot_params, real_mode_data, 2048); 
+	memcpy(x86_boot_params, real_mode_data, BOOT_PARAM_SIZE); 
 	new_data = *(int *) (x86_boot_params + NEW_CL_POINTER);
 	if (!new_data) {
 		if (OLD_CL_MAGIC != * (u16 *) OLD_CL_MAGIC_ADDR) {
