Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbSLEUzr>; Thu, 5 Dec 2002 15:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbSLEUzr>; Thu, 5 Dec 2002 15:55:47 -0500
Received: from [195.39.17.254] ([195.39.17.254]:5124 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267433AbSLEUzj>;
	Thu, 5 Dec 2002 15:55:39 -0500
Date: Wed, 4 Dec 2002 13:58:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: acpi_wakeup.S: simplify logic
Message-ID: <20021204125816.GA8190@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This simplifies logic in acpi_wakeup.S by putting code and data into
same segment. Plus it kills off-by-3 bug and uses constant instead of
hardcoded value. Please apply,
								Pavel

--- clean/arch/i386/kernel/acpi_wakeup.S	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-12-04 13:34:30.000000000 +0100
@@ -1,12 +1,21 @@
-
 .text
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/page.h>
 
-# Do we need to deal with A20?
+#
+# wakeup_code runs in real mode, and at unknown address (determined at run-time).
+# Therefore it must only use relative jumps/calls. 
+#
+# Do we need to deal with A20? It is okay: ACPI specs says A20 must be enabled
+#
+# If physical address of wakeup_code is 0x12345, BIOS should call us with
+# cs = 0x1234, eip = 0x05
+# 
 
 ALIGN
-wakeup_start:
+	.align	4096
+ENTRY(wakeup_start)
 wakeup_code:
 	wakeup_code_start = .
 	.code16
@@ -14,49 +23,70 @@
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)
+
 	cli
 	cld
-	  
+
 	# setup data segment
 	movw	%cs, %ax
-
-	addw	$(wakeup_data - wakeup_code) >> 4, %ax
-	movw	%ax, %ds
+	movw	%ax, %ds					# Make ds:0 point to wakeup_start
 	movw	%ax, %ss
-	mov	$(wakeup_stack - wakeup_data), %sp		# Private stack is needed for ASUS board
-	movw	$0x0e00 + 'S', %fs:(0x12)	
+	mov	wakeup_stack - wakeup_code, %sp			# Private stack is needed for ASUS board
+	movw	$0x0e00 + 'S', %fs:(0x12)
 
-	movl	real_magic - wakeup_data, %eax
+	pushl	$0						# Kill any dangerous flags
+	popfl
+
+	movl	real_magic - wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
-	mov	video_mode - wakeup_data, %ax
+#if 1
+	lcall   $0xc000,$3
+#endif
+#if 0
+	mov	video_mode - wakeup_code, %ax
 	call	mode_set
+#endif
 
 	# set up page table
-	movl	(real_save_cr3 - wakeup_data), %eax
+#if 1
+	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
+#else
+	movl    (real_save_cr3 - wakeup_data), %eax
+#endif
 	movl	%eax, %cr3
 
 	# make sure %cr4 is set correctly (features, etc)
-	movl	(real_save_cr4 - wakeup_data), %eax
+	movl	real_save_cr4 - wakeup_code, %eax
 	movl	%eax, %cr4
 	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'i', %fs:(0x12)
-
+	
 	# need a gdt
-	lgdt	real_save_gdt - wakeup_data
+	lgdt	real_save_gdt - wakeup_code
 
-	movl	(real_save_cr0 - wakeup_data), %eax
+	movl	real_save_cr0 - wakeup_code, %eax
 	movl	%eax, %cr0
+	jmp 1f
+1:
 	movw	$0x0e00 + 'n', %fs:(0x14)
 
-	movl	real_magic - wakeup_data, %eax
+	movl	real_magic - wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
 	ljmpl	$__KERNEL_CS,$wakeup_pmode_return
 
+real_save_gdt:	.word 0
+		.long 0
+real_save_cr0:	.long 0
+real_save_cr3:	.long 0
+real_save_cr4:	.long 0
+real_magic:	.long 0
+video_mode:	.long 0
+
 bogus_real_magic:
 	movw	$0x0e00 + 'B', %fs:(0x12)
 	jmp bogus_real_magic
@@ -129,20 +159,12 @@
 	.code32
 	ALIGN
 
-.org	0x300
-wakeup_data:
-		.word 0
-real_save_gdt:	.word 0
-		.long 0
-real_save_cr0:	.long 0
-real_save_cr3:	.long 0
-real_save_cr4:	.long 0
-real_magic:	.long 0
-video_mode:	.long 0
 
-.org	0x500
+.org	0x2000
 wakeup_stack:
-wakeup_end:
+.org	0x3000
+ENTRY(wakeup_end)
+.org	0x4000
 
 wakeup_pmode_return:
 	movl	$__KERNEL_DS, %eax
@@ -205,7 +227,6 @@
 	movw	$0x0e00 + '2', %ds:(0xb8018)
 	jmp bogus_magic2
 		
-
 ##
 # acpi_copy_wakeup_routine
 #
@@ -228,7 +249,7 @@
 
 	movl	%eax, %edi
 	leal	wakeup_start, %esi
-	movl	$(wakeup_end - wakeup_start) >> 2, %ecx
+	movl	$(wakeup_end - wakeup_start + 3) >> 2, %ecx
 
 	rep ;  movsl
 
@@ -290,8 +311,8 @@
 	ret
 	.p2align 4,,7
 .L1432:
-	movl $104,%eax
-	movw %eax, %ds
+	movl $__KERNEL_DS,%eax
+	movw %ax, %ds
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_eax, %eax
@@ -310,5 +331,4 @@
 saved_idt:	.long	0,0
 saved_ldt:	.long	0
 saved_tss:	.long	0
-saved_cr0:	.long	0
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
