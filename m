Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWGRTHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWGRTHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGRTHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:07:12 -0400
Received: from ozlabs.org ([203.10.76.45]:23782 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932363AbWGRTHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:07:10 -0400
Subject: Re: [RFC PATCH 15/33] move segment checks to subarch
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091952.263186000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091952.263186000@sous-sol.org>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 05:06:41 +1000
Message-Id: <1153249601.5467.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (i386-segments)
> We allow for the fact that the guest kernel may not run in ring 0.
> This requires some abstraction in a few places when setting %cs or
> checking privilege level (user vs kernel).

Zach had an alternate patch for this, which didn't assume the kernel ran
in a compile-time known ring, but is otherwise very similar.  I've put
it below for discussion (but Zach now tells me the asm parts are not
required: Zach, can you mod this patch and comment?).

Your patch #16 finishes the job you started here, by doing the mods to
entry.S.  I think it's cleaner to have all this in one patch (and it can
go in almost immediately AFAICT).

Comments?
Rusty.

Name: Kernel Ring Cleanups
Status: Booted on 2.6.18-rc1
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

This is Zach's patch to clean up assumptions about the kernel running
in ring 0 (which it doesn't when running paravirtualized).

1) Remove the hardcoded 3 and introduce #define SEGMENT_RPL_MASK 3
2) Add a get_kernel_rpl() function
3) Create COMPARE_SEGMENT_STACK and COMPARE_SEGMENT_REG macros which
   can mask out the bottom two bits (RPL) when comparing for
   paravirtualization.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27795-linux-2.6.18-rc1/arch/i386/kernel/entry.S .27795-linux-2.6.18-rc1.updated/arch/i386/kernel/entry.S
--- .27795-linux-2.6.18-rc1/arch/i386/kernel/entry.S	2006-07-07 10:46:38.000000000 +1000
+++ .27795-linux-2.6.18-rc1.updated/arch/i386/kernel/entry.S	2006-07-07 12:11:01.000000000 +1000
@@ -228,9 +228,11 @@ ret_from_intr:
 	GET_THREAD_INFO(%ebp)
 check_userspace:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
+	andl $VM_MASK, %eax
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
-	jz resume_kernel
+	andb $SEGMENT_RPL_MASK, %al
+	cmpl $SEGMENT_RPL_MASK, %eax
+	jb resume_kernel		# returning to kernel or vm86-space
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -517,22 +519,16 @@ syscall_badsys:
 	/* put ESP to the proper location */ \
 	movl %eax, %esp;
 #define UNWIND_ESPFIX_STACK \
-	pushl %eax; \
-	CFI_ADJUST_CFA_OFFSET 4; \
-	movl %ss, %eax; \
-	/* see if on 16bit stack */ \
-	cmpw $__ESPFIX_SS, %ax; \
-	je 28f; \
-27:	popl %eax; \
-	CFI_ADJUST_CFA_OFFSET -4; \
+	COMPARE_SEGMENT_REG(__ESPFIX_SS, %ss); \
+	jne 28f; \
 .section .fixup,"ax"; \
-28:	movl $__KERNEL_DS, %eax; \
+	movl $__KERNEL_DS, %eax; \
 	movl %eax, %ds; \
 	movl %eax, %es; \
 	/* switch to 32bit stack */ \
 	FIXUP_ESPFIX_STACK; \
-	jmp 27b; \
-.previous
+.previous \
+28: ; 
 
 /*
  * Build the entry stubs and pointer table with
@@ -629,6 +625,7 @@ error_code:
 	popl %ecx
 	CFI_ADJUST_CFA_OFFSET -4
 	/*CFI_REGISTER es, ecx*/
+	movl EAX(%esp), %eax
 	movl ES(%esp), %edi		# get the function address
 	movl ORIG_EAX(%esp), %edx	# get the error code
 	movl %eax, ORIG_EAX(%esp)
@@ -694,12 +691,12 @@ device_not_available_emulate:
  * the instruction that would have done it for sysenter.
  */
 #define FIX_STACK(offset, ok, label)		\
-	cmpw $__KERNEL_CS,4(%esp);		\
+	COMPARE_SEGMENT_STACK(__KERNEL_CS, 4);	\
 	jne ok;					\
 label:						\
 	movl TSS_sysenter_esp0+offset(%esp),%esp;	\
 	pushfl;					\
-	pushl $__KERNEL_CS;			\
+	push  %cs;				\
 	pushl $sysenter_past_esp
 
 KPROBE_ENTRY(debug)
@@ -727,12 +724,7 @@ debug_stack_correct:
  */
 ENTRY(nmi)
 	RING0_INT_FRAME
-	pushl %eax
-	CFI_ADJUST_CFA_OFFSET 4
-	movl %ss, %eax
-	cmpw $__ESPFIX_SS, %ax
-	popl %eax
-	CFI_ADJUST_CFA_OFFSET -4
+	COMPARE_SEGMENT_REG(__ESPFIX_SS, %ss)
 	je nmi_16bit_stack
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
@@ -763,7 +755,7 @@ nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
 nmi_debug_stack_check:
-	cmpw $__KERNEL_CS,16(%esp)
+	COMPARE_SEGMENT_STACK(__KERNEL_CS, 16)
 	jne nmi_stack_correct
 	cmpl $debug,(%esp)
 	jb nmi_stack_correct
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27795-linux-2.6.18-rc1/arch/i386/kernel/process.c .27795-linux-2.6.18-rc1.updated/arch/i386/kernel/process.c
--- .27795-linux-2.6.18-rc1/arch/i386/kernel/process.c	2006-07-07 10:46:38.000000000 +1000
+++ .27795-linux-2.6.18-rc1.updated/arch/i386/kernel/process.c	2006-07-07 11:10:30.000000000 +1000
@@ -346,7 +346,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.xes = __USER_DS;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
-	regs.xcs = __KERNEL_CS;
+	regs.xcs = __KERNEL_CS | get_kernel_rpl();
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27795-linux-2.6.18-rc1/arch/i386/kernel/traps.c .27795-linux-2.6.18-rc1.updated/arch/i386/kernel/traps.c
--- .27795-linux-2.6.18-rc1/arch/i386/kernel/traps.c	2006-07-07 10:46:38.000000000 +1000
+++ .27795-linux-2.6.18-rc1.updated/arch/i386/kernel/traps.c	2006-07-07 11:10:30.000000000 +1000
@@ -1034,10 +1034,10 @@ fastcall void setup_x86_bogus_stack(unsi
 	memcpy((void *)(stack_bot + iret_frame16_off), &regs->eip, 20);
 	/* fill in the switch pointers */
 	switch16_ptr[0] = (regs->esp & 0xffff0000) | iret_frame16_off;
-	switch16_ptr[1] = __ESPFIX_SS;
+	switch16_ptr[1] = __ESPFIX_SS | get_kernel_rpl();
 	switch32_ptr[0] = (unsigned long)stk + sizeof(struct pt_regs) +
 		8 - CPU_16BIT_STACK_SIZE;
-	switch32_ptr[1] = __KERNEL_DS;
+	switch32_ptr[1] = __KERNEL_DS | get_kernel_rpl();
 }
 
 fastcall unsigned char * fixup_x86_bogus_stack(unsigned short sp)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27795-linux-2.6.18-rc1/include/asm-i386/ptrace.h .27795-linux-2.6.18-rc1.updated/include/asm-i386/ptrace.h
--- .27795-linux-2.6.18-rc1/include/asm-i386/ptrace.h	2006-03-23 12:44:59.000000000 +1100
+++ .27795-linux-2.6.18-rc1.updated/include/asm-i386/ptrace.h	2006-07-07 11:10:30.000000000 +1000
@@ -60,6 +60,7 @@ struct pt_regs {
 #ifdef __KERNEL__
 
 #include <asm/vm86.h>
+#include <asm/segment.h>
 
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
@@ -73,11 +74,11 @@ extern void send_sigtrap(struct task_str
  */
 static inline int user_mode(struct pt_regs *regs)
 {
-	return (regs->xcs & 3) != 0;
+	return (regs->xcs & SEGMENT_RPL_MASK) == 3;
 }
 static inline int user_mode_vm(struct pt_regs *regs)
 {
-	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
+	return (((regs->xcs & SEGMENT_RPL_MASK) | (regs->eflags & VM_MASK)) >= 3);
 }
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27795-linux-2.6.18-rc1/include/asm-i386/segment.h .27795-linux-2.6.18-rc1.updated/include/asm-i386/segment.h
--- .27795-linux-2.6.18-rc1/include/asm-i386/segment.h	2006-03-23 12:44:59.000000000 +1100
+++ .27795-linux-2.6.18-rc1.updated/include/asm-i386/segment.h	2006-07-07 11:49:39.000000000 +1000
@@ -112,4 +112,20 @@
  */
 #define IDT_ENTRIES 256
 
+/* Bottom three bits of xcs give the ring privilege level */
+#define SEGMENT_RPL_MASK 0x3
+
+#define get_kernel_rpl()  0
+
+#define COMPARE_SEGMENT_STACK(segment, offset)	\
+	cmpw $segment, offset(%esp);
+
+#define COMPARE_SEGMENT_REG(segment, reg)	\
+	pushl %eax;				\
+	CFI_ADJUST_CFA_OFFSET 4;		\
+	mov   reg, %eax;			\
+	cmpw  $segment,%ax;			\
+	popl  %eax;				\
+	CFI_ADJUST_CFA_OFFSET -4
+
 #endif

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

