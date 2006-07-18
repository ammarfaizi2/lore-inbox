Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWGRJZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWGRJZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWGRJVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:21:35 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38018 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932141AbWGRJVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:21:19 -0400
Message-Id: <20060718091952.505770000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:16 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: [RFC PATCH 16/33] Add support for Xen to entry.S.
Content-Disposition: inline; filename=i386-entry.S
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- change cli/sti
- change test for user mode return to work for kernel mode in ring1
- check hypervisor saved event mask on return from exception
- add entry points for the hypervisor upcall handlers
- avoid math emulation check when running on Xen
- add nmi handler for running on Xen

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/kernel/asm-offsets.c |   26 +++++++
 arch/i386/kernel/entry.S       |  141 ++++++++++++++++++++++++++++++++++++-----
 arch/i386/mach-xen/setup-xen.c |   19 +++++
 drivers/xen/core/features.c    |    2
 4 files changed, 169 insertions(+), 19 deletions(-)

diff -r 5cca1805b8a7 arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Tue Jul 18 02:20:39 2006 -0400
+++ b/arch/i386/kernel/entry.S	Tue Jul 18 02:22:56 2006 -0400
@@ -76,8 +76,39 @@ NT_MASK		= 0x00004000
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
+#ifndef CONFIG_XEN
+#define DISABLE_INTERRUPTS	cli
+#define ENABLE_INTERRUPTS	sti
+#else
+#include <xen/interface/xen.h>
+
+EVENT_MASK	= 0x2E
+
+/* Offsets into shared_info_t. */
+#define evtchn_upcall_pending		/* 0 */
+#define evtchn_upcall_mask		1
+
+#ifdef CONFIG_SMP
+/* Set %esi to point to the appropriate vcpu structure */
+#define GET_VCPU_INFO		movl TI_cpu(%ebp),%esi			; \
+				shl  $SIZEOF_VCPU_INFO_SHIFT,%esi	; \
+				addl HYPERVISOR_shared_info,%esi
+#else
+#define GET_VCPU_INFO		movl HYPERVISOR_shared_info,%esi
+#endif
+
+/* The following end up using/clobbering %esi, because of GET_VCPU_INFO */
+#define __DISABLE_INTERRUPTS	movb $1,evtchn_upcall_mask(%esi)
+#define DISABLE_INTERRUPTS	GET_VCPU_INFO				; \
+				__DISABLE_INTERRUPTS
+#define ENABLE_INTERRUPTS	GET_VCPU_INFO				; \
+				movb $0,evtchn_upcall_mask(%esi)
+#define __TEST_PENDING		testb $0xFF,evtchn_upcall_pending(%esi)
+#endif
+
+
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli; TRACE_IRQS_OFF
+#define preempt_stop		DISABLE_INTERRUPTS; TRACE_IRQS_OFF
 #else
 #define preempt_stop
 #define resume_kernel		restore_nocheck
@@ -229,10 +260,10 @@ check_userspace:
 check_userspace:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
+	testl $(VM_MASK | USER_MODE_MASK), %eax
 	jz resume_kernel
 ENTRY(resume_userspace)
- 	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -243,7 +274,7 @@ ENTRY(resume_userspace)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cli
+	DISABLE_INTERRUPTS
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_nocheck
 need_resched:
@@ -271,7 +302,7 @@ sysenter_past_esp:
 	 * No need to follow this irqs on/off section: the syscall
 	 * disabled irqs and here we enable it straight after entry:
 	 */
-	sti
+	ENABLE_INTERRUPTS
 	pushl $(__USER_DS)
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET ss, 0*/
@@ -316,7 +347,7 @@ 1:	movl (%ebp),%ebp
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
-	cli
+	DISABLE_INTERRUPTS
 	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
@@ -326,7 +357,7 @@ 1:	movl (%ebp),%ebp
 	movl OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS
 	sysexit
 	CFI_ENDPROC
 
@@ -352,7 +383,7 @@ syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -361,6 +392,7 @@ syscall_exit:
 	jne syscall_exit_work
 
 restore_all:
+#ifndef CONFIG_XEN
 	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
 	# Warning: OLDSS(%esp) contains the wrong/random values if we
 	# are returning to the kernel.
@@ -372,6 +404,27 @@ restore_all:
 	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
+#else
+restore_nocheck:
+	/* Return back to the hypervisor if we're not returning to user-mode */
+	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
+	movb CS(%esp), %al
+	andl $(VM_MASK | 3), %eax
+	cmpl $3, %eax
+	jne hypervisor_iret
+	ENABLE_INTERRUPTS
+	__TEST_PENDING
+	jz restore_regs_and_iret
+	__DISABLE_INTERRUPTS
+	jmp do_hypervisor_callback
+hypervisor_iret:
+	TRACE_IRQS_IRET
+	RESTORE_REGS
+	addl $4, %esp
+	CFI_ADJUST_CFA_OFFSET -4
+	jmp  hypercall_page + (__HYPERVISOR_iret * 32)
+#endif	/* CONFIG_XEN */
+restore_regs_and_iret:
 	TRACE_IRQS_IRET
 restore_nocheck_notrace:
 	RESTORE_REGS
@@ -380,8 +433,10 @@ 1:	iret
 1:	iret
 .section .fixup,"ax"
 iret_exc:
+#ifndef CONFIG_XEN
 	TRACE_IRQS_ON
-	sti
+	ENABLE_INTERRUPTS
+#endif
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
@@ -392,6 +447,7 @@ iret_exc:
 .previous
 
 	CFI_RESTORE_STATE
+#ifndef CONFIG_XEN
 ldt_ss:
 	larl OLDSS(%esp), %eax
 	jnz restore_nocheck
@@ -405,7 +461,7 @@ ldt_ss:
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
 	CFI_ADJUST_CFA_OFFSET 8
-	cli
+	DISABLE_INTERRUPTS
 	TRACE_IRQS_OFF
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
@@ -420,6 +476,7 @@ 1:	iret
 	.align 4
 	.long 1b,iret_exc
 .previous
+#endif
 	CFI_ENDPROC
 
 	# perform work that needs to be done immediately before resumption
@@ -430,7 +487,7 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -486,7 +543,7 @@ syscall_exit_work:
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
 	TRACE_IRQS_ON
-	sti				# could let do_syscall_trace() call
+	ENABLE_INTERRUPTS		# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -508,6 +565,7 @@ syscall_badsys:
 	jmp resume_userspace
 	CFI_ENDPROC
 
+#ifndef CONFIG_XEN
 #define FIXUP_ESPFIX_STACK \
 	movl %esp, %eax; \
 	/* switch to 32bit stack using the pointer on top of 16bit stack */ \
@@ -586,6 +644,9 @@ ENTRY(name)				\
 
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
+#else
+#define UNWIND_ESPFIX_STACK
+#endif
 
 ENTRY(divide_error)
 	RING0_INT_FRAME
@@ -642,6 +703,44 @@ error_code:
 	jmp ret_from_exception
 	CFI_ENDPROC
 
+#ifdef CONFIG_XEN
+ENTRY(hypervisor_callback)
+	pushl %eax
+	SAVE_ALL
+do_hypervisor_callback:
+	push %esp
+	call evtchn_do_upcall
+	add  $4,%esp
+	jmp  ret_from_intr
+
+# Hypervisor uses this for application faults while it executes.
+ENTRY(failsafe_callback)
+1:	popl %ds
+2:	popl %es
+3:	popl %fs
+4:	popl %gs
+	subl $4,%esp
+	SAVE_ALL
+	jmp  ret_from_exception
+.section .fixup,"ax";	\
+6:	movl $0,(%esp);	\
+	jmp 1b;		\
+7:	movl $0,(%esp);	\
+	jmp 2b;		\
+8:	movl $0,(%esp);	\
+	jmp 3b;		\
+9:	movl $0,(%esp);	\
+	jmp 4b;		\
+.previous;		\
+.section __ex_table,"a";\
+	.align 4;	\
+	.long 1b,6b;	\
+	.long 2b,7b;	\
+	.long 3b,8b;	\
+	.long 4b,9b;	\
+.previous
+#endif
+
 ENTRY(coprocessor_error)
 	RING0_INT_FRAME
 	pushl $0
@@ -665,18 +764,20 @@ ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
+#ifndef CONFIG_XEN
 	movl %cr0, %eax
 	testl $0x4, %eax		# EM (math emulation bit)
-	jne device_not_available_emulate
-	preempt_stop
-	call math_state_restore
-	jmp ret_from_exception
-device_not_available_emulate:
+	je device_available_emulate
 	pushl $0			# temporary storage for ORIG_EIP
 	CFI_ADJUST_CFA_OFFSET 4
 	call math_emulate
 	addl $4, %esp
 	CFI_ADJUST_CFA_OFFSET -4
+	jmp ret_from_exception
+device_available_emulate:
+#endif
+	preempt_stop
+	call math_state_restore
 	jmp ret_from_exception
 	CFI_ENDPROC
 
@@ -717,6 +818,8 @@ debug_stack_correct:
 	jmp ret_from_exception
 	CFI_ENDPROC
 	.previous .text
+
+#ifndef CONFIG_XEN
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
  * a debug fault, and the debug fault hasn't yet been able to
@@ -801,6 +904,10 @@ 1:	iret
 	.align 4
 	.long 1b,iret_exc
 .previous
+#else
+ENTRY(nmi)
+	jmp restore_all
+#endif
 
 KPROBE_ENTRY(int3)
 	RING0_INT_FRAME
diff -r 5cca1805b8a7 arch/i386/mach-xen/setup-xen.c
--- a/arch/i386/mach-xen/setup-xen.c	Tue Jul 18 02:20:39 2006 -0400
+++ b/arch/i386/mach-xen/setup-xen.c	Tue Jul 18 02:22:56 2006 -0400
@@ -40,7 +40,26 @@ char * __init machine_specific_memory_se
 
 void __init machine_specific_arch_setup(void)
 {
+	struct physdev_op op;
+
 	setup_xen_features();
+
+	HYPERVISOR_shared_info =
+		(struct shared_info *)__va(xen_start_info->shared_info);
+	memset(empty_zero_page, 0, sizeof(empty_zero_page));
+
+	HYPERVISOR_vm_assist(VMASST_CMD_enable, VMASST_TYPE_4gb_segments);
+
+	HYPERVISOR_set_callbacks(
+	    __KERNEL_CS, (unsigned long)hypervisor_callback,
+	    __KERNEL_CS, (unsigned long)failsafe_callback);
+
+	init_pg_tables_end = __pa(xen_start_info->pt_base) +
+		PFN_PHYS(xen_start_info->nr_pt_frames);
+
+	op.cmd = PHYSDEVOP_SET_IOPL;
+	op.u.set_iopl.iopl = 1;
+	HYPERVISOR_physdev_op(&op);
 
 #ifdef CONFIG_ACPI
 	if (!(xen_start_info->flags & SIF_INITDOMAIN)) {
diff -r 5cca1805b8a7 drivers/xen/core/features.c
--- a/drivers/xen/core/features.c	Tue Jul 18 02:20:39 2006 -0400
+++ b/drivers/xen/core/features.c	Tue Jul 18 02:22:56 2006 -0400
@@ -16,7 +16,6 @@ EXPORT_SYMBOL_GPL(xen_features);
 
 void setup_xen_features(void)
 {
-#if 0	/* hypercalls come later in the series */
 	struct xen_feature_info fi;
 	int i, j;
 
@@ -27,5 +26,4 @@ void setup_xen_features(void)
 		for (j=0; j<32; j++)
 			xen_features[i*32+j] = !!(fi.submap & 1<<j);
 	}
-#endif
 }
diff -r 5cca1805b8a7 arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Tue Jul 18 02:20:39 2006 -0400
+++ b/arch/i386/kernel/asm-offsets.c	Tue Jul 18 02:22:56 2006 -0400
@@ -15,6 +15,7 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/elf.h>
+#include <xen/interface/xen.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -23,6 +24,27 @@
 
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem));
+
+/* return log2(const) computed at compile time */
+extern inline int get_shift(const int x)
+{
+	extern int __bad_size_in_get_shift(void);
+	if (__builtin_constant_p(x)) {
+		switch(x) {
+		case 1:		return 0;
+		case 2:		return 1;
+		case 4:		return 2;
+		case 8:		return 3;
+		case 16:	return 4;
+		case 32:	return 5;
+		case 64:	return 6;
+		case 128:	return 7;
+		case 256:	return 8;
+		}
+	}
+
+	return __bad_size_in_get_shift();
+}
 
 void foo(void)
 {
@@ -74,4 +96,8 @@ void foo(void)
 	DEFINE(VDSO_PRELINK, VDSO_PRELINK);
 
 	OFFSET(crypto_tfm_ctx_offset, crypto_tfm, __crt_ctx);
+
+	BLANK();
+	DEFINE(SIZEOF_VCPU_INFO, sizeof(struct vcpu_info));
+	DEFINE(SIZEOF_VCPU_INFO_SHIFT, get_shift(sizeof(struct vcpu_info)));
 }

--
