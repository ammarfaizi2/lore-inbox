Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWGVAOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWGVAOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWGVAOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:14:45 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:44256 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751080AbWGVAOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:14:44 -0400
Subject: [PATCH 5/6] Begin abstraction of sensitive instructions: asm files
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 22 Jul 2006 10:14:34 +1000
Message-Id: <1153527274.13699.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(forgot to send this to lkml before)

Abstract sensitive instructions in assembler code, replacing them with
macros (which currently are #defined to the native versions).  We use
long names: assembler is case-insensitive, so if something goes wrong
and macros do not expand, it would assemble anyway.

Resulting object files are exactly the same as before.

Signed-off-by Rusty Russell <rusty@rustcorp.com.au>

Index: working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/entry.S
===================================================================
--- working-2.6.18-rc2-hg-paravirt.orig/arch/i386/kernel/entry.S	2006-07-21 21:09:22.000000000 +1000
+++ working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/entry.S	2006-07-22 04:32:25.000000000 +1000
@@ -76,8 +76,15 @@
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
+/* These are replaces for paravirtualization */
+#define DISABLE_INTERRUPTS		cli
+#define ENABLE_INTERRUPTS		sti
+#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
+#define INTERRUPT_RETURN		iret
+#define GET_CR0			movl %cr0, %eax
+
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli; TRACE_IRQS_OFF
+#define preempt_stop		DISABLE_INTERRUPTS; TRACE_IRQS_OFF
 #else
 #define preempt_stop
 #define resume_kernel		restore_nocheck
@@ -234,7 +241,7 @@
 	cmpl $SEGMENT_RPL_MASK, %eax
 	jb resume_kernel		# returning to kernel or vm86-space
 ENTRY(resume_userspace)
- 	cli				# make sure we don't miss an interrupt
+ 	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -245,7 +252,7 @@
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cli
+	DISABLE_INTERRUPTS
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_nocheck
 need_resched:
@@ -273,7 +280,7 @@
 	 * No need to follow this irqs on/off section: the syscall
 	 * disabled irqs and here we enable it straight after entry:
 	 */
-	sti
+	ENABLE_INTERRUPTS
 	pushl $(__USER_DS)
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET ss, 0*/
@@ -318,7 +325,7 @@
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
-	cli
+	DISABLE_INTERRUPTS
 	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
@@ -328,8 +335,7 @@
 	movl OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
 	TRACE_IRQS_ON
-	sti
-	sysexit
+	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
 

@@ -354,7 +360,7 @@
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -379,11 +385,11 @@
 	RESTORE_REGS
 	addl $4, %esp
 	CFI_ADJUST_CFA_OFFSET -4
-1:	iret
+1:	INTERRUPT_RETURN
 .section .fixup,"ax"
 iret_exc:
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
@@ -407,7 +413,7 @@
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
 	CFI_ADJUST_CFA_OFFSET 8
-	cli
+	DISABLE_INTERRUPTS
 	TRACE_IRQS_OFF
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
@@ -417,7 +423,7 @@
 	TRACE_IRQS_IRET
 	RESTORE_REGS
 	lss 20+4(%esp), %esp	# switch to 16bit stack
-1:	iret
+1:	INTERRUPT_RETURN
 .section __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
@@ -432,7 +438,7 @@
 	jz work_notifysig
 work_resched:
 	call schedule
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -488,7 +494,7 @@
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
 	TRACE_IRQS_ON
-	sti				# could let do_syscall_trace() call
+	ENABLE_INTERRUPTS		# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -667,7 +673,7 @@
 	pushl $-1			# mark this as an int
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
-	movl %cr0, %eax
+	GET_CR0
 	testl $0x4, %eax		# EM (math emulation bit)
 	jne device_not_available_emulate
 	preempt_stop
@@ -797,7 +803,7 @@
 	call do_nmi
 	RESTORE_REGS
 	lss 12+4(%esp), %esp		# back to 16bit stack
-1:	iret
+1:	INTERRUPT_RETURN
 	CFI_ENDPROC
 .section __ex_table,"a"
 	.align 4
Index: working-2.6.18-rc2-hg-paravirt/include/asm-i386/spinlock.h
===================================================================
--- working-2.6.18-rc2-hg-paravirt.orig/include/asm-i386/spinlock.h	2006-07-21 20:27:59.000000000 +1000
+++ working-2.6.18-rc2-hg-paravirt/include/asm-i386/spinlock.h	2006-07-22 04:32:51.000000000 +1000
@@ -17,6 +17,9 @@
  * (the type definitions are in asm/spinlock_types.h)
  */
 
+#define CLI_STRING	"cli"
+#define STI_STRING	"sti"
+
 #define __raw_spin_is_locked(x) \
 		(*(volatile signed char *)(&(x)->slock) <= 0)
 
@@ -43,12 +46,12 @@
 	"2:\t" \
 	"testl $0x200, %1\n\t" \
 	"jz 4f\n\t" \
-	"sti\n" \
+	STI_STRING "\n" \
 	"3:\t" \
 	"rep;nop\n\t" \
 	"cmpb $0, %0\n\t" \
 	"jle 3b\n\t" \
-	"cli\n\t" \
+	CLI_STRING "\n\t" \
 	"jmp 1b\n" \
 	"4:\t" \
 	"rep;nop\n\t" \

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

