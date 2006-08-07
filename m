Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWHGPHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWHGPHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWHGPHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:07:40 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:57037 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932127AbWHGPHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:07:37 -0400
Date: Mon, 7 Aug 2006 17:07:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: initrd vs. bootmem bitmap.
Message-ID: <20060807150736.GF10416@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] initrd vs. bootmem bitmap.

Move initrd if the bitmap of the bootmem allocator would overwrite it.
In addition this patch sets the default size and address of the initrd to 0.
Therefore all boot loaders must set the initrd size and address correctly.
This is especially relevant for ftp boot via HMC/SE, where this change
requires a special patch file entry in the .ins file which sets these two
values contained at address 0x10408 and 0x10410.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head.S   |   10 ++++++----
 arch/s390/kernel/head31.S |    4 ++--
 arch/s390/kernel/head64.S |    4 ++--
 arch/s390/kernel/setup.c  |   40 +++++++++++++++++++++++++++++++++++++---
 include/asm-s390/setup.h  |    2 --
 5 files changed, 47 insertions(+), 13 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-08-07 14:14:47.000000000 +0200
@@ -26,8 +26,8 @@ startup:basr	%r13,0			# get base
 #
 	.org	PARMAREA
 	.long	0,0			# IPL_DEVICE
-	.long	0,RAMDISK_ORIGIN	# INITRD_START
-	.long	0,RAMDISK_SIZE		# INITRD_SIZE
+	.long	0,0			# INITRD_START
+	.long	0,0			# INITRD_SIZE
 
 	.org	COMMAND_LINE
 	.byte	"root=/dev/ram0 ro"
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-08-07 14:14:47.000000000 +0200
@@ -26,8 +26,8 @@ startup:basr  %r13,0			 # get base
 #
 	.org   PARMAREA
 	.quad  0			# IPL_DEVICE
-	.quad  RAMDISK_ORIGIN		# INITRD_START
-	.quad  RAMDISK_SIZE		# INITRD_SIZE
+	.quad  0			# INITRD_START
+	.quad  0			# INITRD_SIZE
 
 	.org   COMMAND_LINE
 	.byte  "root=/dev/ram0 ro"
diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head.S	2006-08-07 14:14:47.000000000 +0200
@@ -272,7 +272,7 @@ iplstart:
 # load parameter file from ipl device
 #
 .Lagain1:
- 	l     %r2,INITRD_START+ARCH_OFFSET-PARMAREA(%r12) # ramdisk loc. is temp
+	l     %r2,.Linitrd		       # ramdisk loc. is temp
         bas   %r14,.Lloader                    # load parameter file
         ltr   %r2,%r2                          # got anything ?
         bz    .Lnopf
@@ -280,7 +280,7 @@ iplstart:
 	bnh   .Lnotrunc
 	la    %r2,895
 .Lnotrunc:
-	l     %r4,INITRD_START+ARCH_OFFSET-PARMAREA(%r12)
+	l     %r4,.Linitrd
 	clc   0(3,%r4),.L_hdr		       # if it is HDRx
 	bz    .Lagain1			       # skip dataset header
 	clc   0(3,%r4),.L_eof		       # if it is EOFx
@@ -323,14 +323,15 @@ iplstart:
 # load ramdisk from ipl device
 #	
 .Lagain2:
- 	l     %r2,INITRD_START+ARCH_OFFSET-PARMAREA(%r12) # addr of ramdisk
+	l     %r2,.Linitrd		       # addr of ramdisk
+	st    %r2,INITRD_START+ARCH_OFFSET-PARMAREA(%r12)
         bas   %r14,.Lloader                    # load ramdisk
  	st    %r2,INITRD_SIZE+ARCH_OFFSET-PARMAREA(%r12) # store size of ramdisk
         ltr   %r2,%r2
         bnz   .Lrdcont
         st    %r2,INITRD_START+ARCH_OFFSET-PARMAREA(%r12) # no ramdisk found
 .Lrdcont:
-	l     %r2,INITRD_START+ARCH_OFFSET-PARMAREA(%r12)
+	l     %r2,.Linitrd
 
 	clc   0(3,%r2),.L_hdr		       # skip HDRx and EOFx 
 	bz    .Lagain2
@@ -379,6 +380,7 @@ iplstart:
         l     %r1,.Lstartup
         br    %r1
 
+.Linitrd:.long _end + 0x400000		       # default address of initrd
 .Lparm:	.long  PARMAREA
 .Lstartup: .long startup
 .Lcvtab:.long  _ebcasc                         # ebcdic to ascii table
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-08-07 14:14:47.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
+#include <linux/pfn.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -501,13 +502,46 @@ setup_memory(void)
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
 	 */
-	start_pfn = (__pa(&_end) + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	end_pfn = max_pfn = memory_end >> PAGE_SHIFT;
+	start_pfn = PFN_UP(__pa(&_end));
+	end_pfn = max_pfn = PFN_DOWN(memory_end);
 
 	/* Initialize storage key for kernel pages */
 	for (init_pfn = 0 ; init_pfn < start_pfn; init_pfn++)
 		page_set_storage_key(init_pfn << PAGE_SHIFT, PAGE_DEFAULT_KEY);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	/*
+	 * Move the initrd in case the bitmap of the bootmem allocater
+	 * would overwrite it.
+	 */
+
+	if (INITRD_START && INITRD_SIZE) {
+		unsigned long bmap_size;
+		unsigned long start;
+
+		bmap_size = PFN_ALIGN((end_pfn - start_pfn) >> 3);
+
+		if (PFN_PHYS(start_pfn) + bmap_size > INITRD_START) {
+			start = PFN_PHYS(start_pfn) + bmap_size + PAGE_SIZE;
+
+			if (start + INITRD_SIZE > memory_end) {
+				printk("initrd extends beyond end of memory "
+				       "(0x%08lx > 0x%08lx)\n"
+				       "disabling initrd\n",
+				       start + INITRD_SIZE, memory_end);
+				INITRD_START = INITRD_SIZE = 0;
+			} else {
+				printk("Moving initrd (0x%08lx -> 0x%08lx, "
+				       "size: %ld)\n",
+				       INITRD_START, start, INITRD_SIZE);
+				memmove((void *) start, (void *) INITRD_START,
+					INITRD_SIZE);
+				INITRD_START = start;
+			}
+		}
+	}
+#endif
+
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
 	 */
@@ -559,7 +593,7 @@ setup_memory(void)
 	reserve_bootmem(start_pfn << PAGE_SHIFT, bootmap_size);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (INITRD_START) {
+	if (INITRD_START && INITRD_SIZE) {
 		if (INITRD_START + INITRD_SIZE <= memory_end) {
 			reserve_bootmem(INITRD_START, INITRD_SIZE);
 			initrd_start = INITRD_START;
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2006-08-07 14:14:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/setup.h	2006-08-07 14:14:47.000000000 +0200
@@ -14,8 +14,6 @@
 
 #define PARMAREA		0x10400
 #define COMMAND_LINE_SIZE 	896
-#define RAMDISK_ORIGIN		0x800000
-#define RAMDISK_SIZE		0x800000
 #define MEMORY_CHUNKS		16	/* max 0x7fff */
 #define IPL_PARMBLOCK_ORIGIN	0x2000
 
