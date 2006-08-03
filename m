Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWHCA0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWHCA0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWHCAZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:25:54 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:48345 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1750918AbWHCAZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:50 -0400
Message-Id: <20060803002518.298650539@xensource.com>
References: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:14 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 4/8] Replace sensitive instructions with macros.
Content-Disposition: inline; filename=004-abstract-asm.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract sensitive instructions in assembler code, replacing them with
macros (which currently are #defined to the native versions).  We use
long names: assembler is case-insensitive, so if something goes wrong
and macros do not expand, it would assemble anyway.

Resulting object files are exactly the same as before.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/entry.S    |   38 ++++++++++++++++++++++----------------
 include/asm-i386/spinlock.h |    7 +++++--
 2 files changed, 27 insertions(+), 18 deletions(-)


===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -76,8 +76,15 @@ NT_MASK		= 0x00004000
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
+/* These are replaces for paravirtualization */
+#define DISABLE_INTERRUPTS		cli
+#define ENABLE_INTERRUPTS		sti
+#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
+#define INTERRUPT_RETURN		iret
+#define GET_CR0_INTO_EAX		movl %cr0, %eax
+
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli; TRACE_IRQS_OFF
+#define preempt_stop		DISABLE_INTERRUPTS; TRACE_IRQS_OFF
 #else
 #define preempt_stop
 #define resume_kernel		restore_nocheck
@@ -233,7 +240,7 @@ check_userspace:
 	cmpl $SEGMENT_RPL_MASK, %eax
 	jb resume_kernel		# not returning to v8086 or userspace
 ENTRY(resume_userspace)
- 	cli				# make sure we don't miss an interrupt
+ 	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -244,7 +251,7 @@ ENTRY(resume_userspace)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cli
+	DISABLE_INTERRUPTS
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_nocheck
 need_resched:
@@ -272,7 +279,7 @@ sysenter_past_esp:
 	 * No need to follow this irqs on/off section: the syscall
 	 * disabled irqs and here we enable it straight after entry:
 	 */
-	sti
+	ENABLE_INTERRUPTS
 	pushl $(__USER_DS)
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET ss, 0*/
@@ -317,7 +324,7 @@ 1:	movl (%ebp),%ebp
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
-	cli
+	DISABLE_INTERRUPTS
 	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
@@ -327,8 +334,7 @@ 1:	movl (%ebp),%ebp
 	movl OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
 	TRACE_IRQS_ON
-	sti
-	sysexit
+	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
 
 
@@ -353,7 +359,7 @@ syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -378,11 +384,11 @@ restore_nocheck_notrace:
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
@@ -406,7 +412,7 @@ ldt_ss:
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
 	CFI_ADJUST_CFA_OFFSET 8
-	cli
+	DISABLE_INTERRUPTS
 	TRACE_IRQS_OFF
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
@@ -416,7 +422,7 @@ ldt_ss:
 	TRACE_IRQS_IRET
 	RESTORE_REGS
 	lss 20+4(%esp), %esp	# switch to 16bit stack
-1:	iret
+1:	INTERRUPT_RETURN
 .section __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
@@ -431,7 +437,7 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -487,7 +493,7 @@ syscall_exit_work:
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
 	TRACE_IRQS_ON
-	sti				# could let do_syscall_trace() call
+	ENABLE_INTERRUPTS		# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -666,7 +672,7 @@ ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
-	movl %cr0, %eax
+	GET_CR0_INTO_EAX
 	testl $0x4, %eax		# EM (math emulation bit)
 	jne device_not_available_emulate
 	preempt_stop
@@ -796,7 +802,7 @@ nmi_16bit_stack:
 	call do_nmi
 	RESTORE_REGS
 	lss 12+4(%esp), %esp		# back to 16bit stack
-1:	iret
+1:	INTERRUPT_RETURN
 	CFI_ENDPROC
 .section __ex_table,"a"
 	.align 4
===================================================================
--- a/include/asm-i386/spinlock.h
+++ b/include/asm-i386/spinlock.h
@@ -16,6 +16,9 @@
  *
  * (the type definitions are in asm/spinlock_types.h)
  */
+
+#define CLI_STRING	"cli"
+#define STI_STRING	"sti"
 
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

