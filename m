Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWHJUYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWHJUYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWHJUPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932549AbWHJTf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:59 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [43/145] i386: Redo semaphore and rwlock assembly helpers
Message-Id: <20060810193557.7E1F313B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:57 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

- Move them to a pure assembly file. Previously they were in 
a C file that only consisted of inline assembly. Doing it in pure
assembler is much nicer.
- Add a frame.i include with FRAME/ENDFRAME macros to easily
add frame pointers to assembly functions 
- Add dwarf2 annotation to them so that the new dwarf2 unwinder
doesn't get stuck on them
[TBD: needs review from someone who knows more about CFA than me, e.g. Jan]
- Random cleanups

Cc: jbeulich@novell.com
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/Makefile    |    2 
 arch/i386/kernel/semaphore.c |  134 -------------------------------------------
 arch/i386/lib/Makefile       |    2 
 arch/i386/lib/semaphore.S    |  132 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/frame.i     |   19 ++++++
 5 files changed, 153 insertions(+), 136 deletions(-)

Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile
+++ linux/arch/i386/kernel/Makefile
@@ -4,7 +4,7 @@
 
 extra-y := head.o init_task.o vmlinux.lds
 
-obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
+obj-y	:= process.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bootflag.o \
 		quirks.o i8237.o topology.o alternative.o i8253.o tsc.o
Index: linux/arch/i386/kernel/semaphore.c
===================================================================
--- linux.orig/arch/i386/kernel/semaphore.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/*
- * i386 semaphore implementation.
- *
- * (C) Copyright 1999 Linus Torvalds
- *
- * Portions Copyright 1999 Red Hat, Inc.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
- */
-#include <asm/semaphore.h>
-
-/*
- * The semaphore operations have a special calling sequence that
- * allow us to do a simpler in-line version of them. These routines
- * need to convert that sequence back into the C sequence when
- * there is contention on the semaphore.
- *
- * %eax contains the semaphore pointer on entry. Save the C-clobbered
- * registers (%eax, %edx and %ecx) except %eax whish is either a return
- * value or just clobbered..
- */
-asm(
-".section .sched.text\n"
-".align 4\n"
-".globl __down_failed\n"
-"__down_failed:\n\t"
-#if defined(CONFIG_FRAME_POINTER)
-	"pushl %ebp\n\t"
-	"movl  %esp,%ebp\n\t"
-#endif
-	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
-	"call __down\n\t"
-	"popl %ecx\n\t"
-	"popl %edx\n\t"
-#if defined(CONFIG_FRAME_POINTER)
-	"movl %ebp,%esp\n\t"
-	"popl %ebp\n\t"
-#endif
-	"ret"
-);
-
-asm(
-".section .sched.text\n"
-".align 4\n"
-".globl __down_failed_interruptible\n"
-"__down_failed_interruptible:\n\t"
-#if defined(CONFIG_FRAME_POINTER)
-	"pushl %ebp\n\t"
-	"movl  %esp,%ebp\n\t"
-#endif
-	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
-	"call __down_interruptible\n\t"
-	"popl %ecx\n\t"
-	"popl %edx\n\t"
-#if defined(CONFIG_FRAME_POINTER)
-	"movl %ebp,%esp\n\t"
-	"popl %ebp\n\t"
-#endif
-	"ret"
-);
-
-asm(
-".section .sched.text\n"
-".align 4\n"
-".globl __down_failed_trylock\n"
-"__down_failed_trylock:\n\t"
-#if defined(CONFIG_FRAME_POINTER)
-	"pushl %ebp\n\t"
-	"movl  %esp,%ebp\n\t"
-#endif
-	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
-	"call __down_trylock\n\t"
-	"popl %ecx\n\t"
-	"popl %edx\n\t"
-#if defined(CONFIG_FRAME_POINTER)
-	"movl %ebp,%esp\n\t"
-	"popl %ebp\n\t"
-#endif
-	"ret"
-);
-
-asm(
-".section .sched.text\n"
-".align 4\n"
-".globl __up_wakeup\n"
-"__up_wakeup:\n\t"
-	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
-	"call __up\n\t"
-	"popl %ecx\n\t"
-	"popl %edx\n\t"
-	"ret"
-);
-
-/*
- * rw spinlock fallbacks
- */
-#if defined(CONFIG_SMP)
-asm(
-".section .sched.text\n"
-".align	4\n"
-".globl	__write_lock_failed\n"
-"__write_lock_failed:\n\t"
-	LOCK_PREFIX "addl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
-"1:	rep; nop\n\t"
-	"cmpl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
-	"jne	1b\n\t"
-	LOCK_PREFIX "subl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
-	"jnz	__write_lock_failed\n\t"
-	"ret"
-);
-
-asm(
-".section .sched.text\n"
-".align	4\n"
-".globl	__read_lock_failed\n"
-"__read_lock_failed:\n\t"
-	LOCK_PREFIX "incl	(%eax)\n"
-"1:	rep; nop\n\t"
-	"cmpl	$1,(%eax)\n\t"
-	"js	1b\n\t"
-	LOCK_PREFIX "decl	(%eax)\n\t"
-	"js	__read_lock_failed\n\t"
-	"ret"
-);
-#endif
Index: linux/arch/i386/lib/semaphore.S
===================================================================
--- /dev/null
+++ linux/arch/i386/lib/semaphore.S
@@ -0,0 +1,132 @@
+/*
+ * i386 semaphore implementation.
+ *
+ * (C) Copyright 1999 Linus Torvalds
+ *
+ * Portions Copyright 1999 Red Hat, Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
+ */
+
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/rwlock.h>
+#include <asm/alternative-asm.i>
+#include <asm/frame.i>
+#include <asm/dwarf2.h>
+
+/*
+ * The semaphore operations have a special calling sequence that
+ * allow us to do a simpler in-line version of them. These routines
+ * need to convert that sequence back into the C sequence when
+ * there is contention on the semaphore.
+ *
+ * %eax contains the semaphore pointer on entry. Save the C-clobbered
+ * registers (%eax, %edx and %ecx) except %eax whish is either a return
+ * value or just clobbered..
+ */
+	.section .sched.text
+ENTRY(__down_failed)
+	CFI_STARTPROC
+	FRAME
+	pushl %edx
+	CFI_ADJUST_CFA_OFFSET 4
+	pushl %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	call __down
+	popl %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+	popl %edx
+	CFI_ADJUST_CFA_OFFSET -4
+	ENDFRAME
+	ret
+	CFI_ENDPROC
+	END(__down_failed)
+
+ENTRY(__down_failed_interruptible)
+	CFI_STARTPROC
+	FRAME
+	pushl %edx
+	CFI_ADJUST_CFA_OFFSET 4
+	pushl %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	call __down_interruptible
+	popl %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+	popl %edx
+	CFI_ADJUST_CFA_OFFSET -4
+	ENDFRAME
+	ret
+	CFI_ENDPROC
+	END(__down_failed_interruptible)
+
+ENTRY(__down_failed_trylock)
+	CFI_STARTPROC
+	FRAME
+	pushl %edx
+	CFI_ADJUST_CFA_OFFSET 4
+	pushl %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	call __down_trylock
+	popl %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+	popl %edx
+	CFI_ADJUST_CFA_OFFSET -4
+	ENDFRAME
+	ret
+	CFI_ENDPROC
+	END(__down_failed_trylock)
+
+ENTRY(__up_wakeup)
+	CFI_STARTPROC
+	pushl %edx
+	CFI_ADJUST_CFA_OFFSET 4
+	pushl %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	call __up
+	popl %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+	popl %edx
+	CFI_ADJUST_CFA_OFFSET -4
+	ret
+	CFI_ENDPROC
+	END(__up_wakeup)
+
+/*
+ * rw spinlock fallbacks
+ */
+#ifdef CONFIG_SMP
+ENTRY(__write_lock_failed)
+	CFI_STARTPROC simple
+	LOCK_PREFIX
+	addl	$ RW_LOCK_BIAS,(%eax)
+1:	rep; nop
+	cmpl	$ RW_LOCK_BIAS,(%eax)
+	jne	1b
+	LOCK_PREFIX
+	subl	$ RW_LOCK_BIAS,(%eax)
+	jnz	__write_lock_failed
+	ret
+	CFI_ENDPROC
+	END(__write_lock_failed)
+
+ENTRY(__read_lock_failed)
+	CFI_STARTPROC
+	LOCK_PREFIX
+	incl	(%eax)
+1:	rep; nop
+	cmpl	$1,(%eax)
+	js	1b
+	LOCK_PREFIX
+	decl	(%eax)
+	js	__read_lock_failed
+	ret
+	CFI_ENDPROC
+	END(__read_lock_failed)
+
+#endif
Index: linux/include/asm-i386/frame.i
===================================================================
--- /dev/null
+++ linux/include/asm-i386/frame.i
@@ -0,0 +1,19 @@
+#include <linux/config.h>
+#include <asm/dwarf2.h>
+
+#ifdef CONFIG_FRAME_POINTER
+	.macro FRAME
+	pushl %ebp
+	CFI_ADJUST_CFA_OFFSET 4
+	movl %esp,%ebp
+	.endm
+	.macro ENDFRAME
+	popl %ebp
+	CFI_ADJUST_CFA_OFFSET -4
+	.endm
+#else
+	.macro FRAME
+	.endm
+	.macro ENDFRAME
+	.endm
+#endif
Index: linux/arch/i386/lib/Makefile
===================================================================
--- linux.orig/arch/i386/lib/Makefile
+++ linux/arch/i386/lib/Makefile
@@ -4,6 +4,6 @@
 
 
 lib-y = checksum.o delay.o usercopy.o getuser.o putuser.o memcpy.o strstr.o \
-	bitops.o
+	bitops.o semaphore.o
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
