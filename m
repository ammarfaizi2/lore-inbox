Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbTBLUkO>; Wed, 12 Feb 2003 15:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbTBLUih>; Wed, 12 Feb 2003 15:38:37 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2308 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267643AbTBLUh1>;
	Wed, 12 Feb 2003 15:37:27 -0500
Date: Tue, 11 Feb 2003 19:44:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Fix stack handling in acpi_wakeup.S
Message-ID: <20030211184452.GA24966@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes stack handling in acpi_wakeup.S, and makes stack smaller so
that wakeup code actually fits inside memory allocated for it. Plus
someone renamed .L1432 to something meaningfull. Please apply,
								Pavel

--- clean/arch/i386/kernel/acpi_wakeup.S	2003-02-11 17:40:33.000000000 +0100
+++ linux/arch/i386/kernel/acpi_wakeup.S	2003-02-11 12:51:03.000000000 +0100
@@ -31,7 +31,7 @@
 	movw	%cs, %ax
 	movw	%ax, %ds					# Make ds:0 point to wakeup_start
 	movw	%ax, %ss
-	mov	wakeup_stack - wakeup_code, %sp			# Private stack is needed for ASUS board
+	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
 	movw	$0x0e00 + 'S', %fs:(0x12)
 
 	pushl	$0						# Kill any dangerous flags
@@ -159,12 +159,14 @@
 	.code32
 	ALIGN
 
+.org	0x800
+wakeup_stack_begin:	# Stack grows down
 
-.org	0x2000
+.org	0xff0		# Just below end of page
 wakeup_stack:
-.org	0x3000
 ENTRY(wakeup_end)
-.org	0x4000
+	
+.org	0x1000
 
 wakeup_pmode_return:
 	movl	$__KERNEL_DS, %eax
@@ -274,7 +276,7 @@
 
 ENTRY(do_suspend_lowlevel)
 	cmpl $0,4(%esp)
-	jne .L1432
+	jne ret_point
 	call save_processor_state
 
 	movl %esp, saved_context_esp
@@ -287,7 +289,7 @@
 	movl %edi, saved_context_edi
 	pushfl ; popl saved_context_eflags
 
-	movl $.L1432,saved_eip
+	movl $ret_point,saved_eip
 	movl %esp,saved_esp
 	movl %ebp,saved_ebp
 	movl %ebx,saved_ebx
@@ -299,7 +301,7 @@
 	addl $4,%esp
 	ret
 	.p2align 4,,7
-.L1432:
+ret_point:
 	movl $__KERNEL_DS,%eax
 	movw %ax, %ds
 	movl saved_context_esp, %esp

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
