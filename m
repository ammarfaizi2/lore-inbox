Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbTBHQf2>; Sat, 8 Feb 2003 11:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTBHQf2>; Sat, 8 Feb 2003 11:35:28 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:65492 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S266761AbTBHQfW>; Sat, 8 Feb 2003 11:35:22 -0500
Message-ID: <3E453408.1030907@quark.didntduck.org>
Date: Sat, 08 Feb 2003 11:44:56 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] uninline i386 do_traps()
Content-Type: multipart/mixed;
 boundary="------------060409090009040400080408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060409090009040400080408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Change do_trap() to be a single table-driven function instead of 
inlining it into many different fault handlers, saving about 1k of memory.

--
				Brian Gerst

--------------060409090009040400080408
Content-Type: text/plain;
 name="traps-b2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traps-b2"

diff -urN linux-2.5.59-bk1/arch/i386/kernel/entry.S linux-b2/arch/i386/kernel/entry.S
--- linux-2.5.59-bk1/arch/i386/kernel/entry.S	2003-02-07 14:46:13.000000000 -0500
+++ linux-b2/arch/i386/kernel/entry.S	2003-02-07 14:58:25.000000000 -0500
@@ -404,26 +404,55 @@
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
 
-ENTRY(divide_error)
-	pushl $0			# no error code
-	pushl $do_divide_error
+#define TRAP(name,nr) \
+ENTRY(name) \
+	pushl $0; \
+	pushl $nr; \
+	jmp error_code
+
+#define TRAP_CODE(name,nr) \
+ENTRY(name) \
+	pushl $nr; \
+	jmp error_code
+
+TRAP(divide_error,0)
+TRAP(debug,1)
+TRAP(int3,3)
+TRAP(overflow,4)
+TRAP(bounds,5)
+TRAP(invalid_op,6)
+TRAP_CODE(double_fault,8)
+TRAP(coprocessor_segment_overrun,9)
+TRAP_CODE(invalid_TSS,10)
+TRAP_CODE(segment_not_present,11)
+TRAP_CODE(stack_segment,12)
+TRAP_CODE(general_protection,13)
+TRAP_CODE(page_fault,14)
+TRAP(spurious_interrupt_bug,15)
+TRAP(coprocessor_error,16)
+TRAP_CODE(alignment_check,17)
+#ifdef CONFIG_X86_MCE
+TRAP(machine_check,18)
+#else
+#define do_machine_check 0
+#endif
+TRAP(simd_coprocessor_error,19)
+
 	ALIGN
 error_code:
 	pushl %ds
 	pushl %eax
-	xorl %eax, %eax
 	pushl %ebp
 	pushl %edi
 	pushl %esi
 	pushl %edx
-	decl %eax			# eax = -1
 	pushl %ecx
 	pushl %ebx
 	cld
 	movl %es, %ecx
 	movl ORIG_EAX(%esp), %esi	# get the error code
-	movl ES(%esp), %edi		# get the function address
-	movl %eax, ORIG_EAX(%esp)
+	movl ES(%esp), %edi		# get the trap number
+	movl %edi, ORIG_EAX(%esp)
 	movl %ecx, ES(%esp)
 	movl %esp, %edx
 	pushl %esi			# push the error code
@@ -431,20 +460,10 @@
 	movl $(__USER_DS), %edx
 	movl %edx, %ds
 	movl %edx, %es
-	call *%edi
+	call *trap_table(,%edi,4)
 	addl $8, %esp
 	jmp ret_from_exception
 
-ENTRY(coprocessor_error)
-	pushl $0
-	pushl $do_coprocessor_error
-	jmp error_code
-
-ENTRY(simd_coprocessor_error)
-	pushl $0
-	pushl $do_simd_coprocessor_error
-	jmp error_code
-
 ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
@@ -460,11 +479,6 @@
 	addl $4, %esp
 	jmp ret_from_exception
 
-ENTRY(debug)
-	pushl $0
-	pushl $do_debug
-	jmp error_code
-
 ENTRY(nmi)
 	pushl %eax
 	SAVE_ALL
@@ -475,72 +489,29 @@
 	addl $8, %esp
 	RESTORE_ALL
 
-ENTRY(int3)
-	pushl $0
-	pushl $do_int3
-	jmp error_code
-
-ENTRY(overflow)
-	pushl $0
-	pushl $do_overflow
-	jmp error_code
-
-ENTRY(bounds)
-	pushl $0
-	pushl $do_bounds
-	jmp error_code
-
-ENTRY(invalid_op)
-	pushl $0
-	pushl $do_invalid_op
-	jmp error_code
-
-ENTRY(coprocessor_segment_overrun)
-	pushl $0
-	pushl $do_coprocessor_segment_overrun
-	jmp error_code
-
-ENTRY(double_fault)
-	pushl $do_double_fault
-	jmp error_code
-
-ENTRY(invalid_TSS)
-	pushl $do_invalid_TSS
-	jmp error_code
-
-ENTRY(segment_not_present)
-	pushl $do_segment_not_present
-	jmp error_code
-
-ENTRY(stack_segment)
-	pushl $do_stack_segment
-	jmp error_code
-
-ENTRY(general_protection)
-	pushl $do_general_protection
-	jmp error_code
-
-ENTRY(alignment_check)
-	pushl $do_alignment_check
-	jmp error_code
-
-ENTRY(page_fault)
-	pushl $do_page_fault
-	jmp error_code
-
-#ifdef CONFIG_X86_MCE
-ENTRY(machine_check)
-	pushl $0
-	pushl $do_machine_check
-	jmp error_code
-#endif
-
-ENTRY(spurious_interrupt_bug)
-	pushl $0
-	pushl $do_spurious_interrupt_bug
-	jmp error_code
-
 .data
+ENTRY(trap_table)
+	.long do_trap		/* divide */
+	.long do_debug
+	.long 0			/* nmi */
+	.long do_trap		/* int3 */
+	.long do_trap		/* overflow */
+	.long do_trap		/* bounds */
+	.long do_trap		/* invalid op */
+	.long 0			/* device not available */
+	.long do_trap		/* double fault */
+	.long do_trap		/* coprocessor segment */
+	.long do_trap		/* invalid TSS */
+	.long do_trap		/* segment not present */
+	.long do_trap		/* stack segment */
+	.long do_trap		/* general protection */
+	.long do_page_fault
+	.long do_spurious_interrupt_bug
+	.long do_coprocessor_error
+	.long do_trap		/* alignment check */
+	.long do_machine_check
+	.long do_simd_coprocessor_error
+
 ENTRY(sys_call_table)
 	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
 	.long sys_exit
diff -urN linux-2.5.59-bk1/arch/i386/kernel/traps.c linux-b2/arch/i386/kernel/traps.c
--- linux-2.5.59-bk1/arch/i386/kernel/traps.c	2003-01-13 16:20:57.000000000 -0500
+++ linux-b2/arch/i386/kernel/traps.c	2003-02-07 14:58:25.000000000 -0500
@@ -258,126 +258,82 @@
 	do_exit(SIGSEGV);
 }
 
-static inline void die_if_kernel(const char * str, struct pt_regs * regs, long err)
+static void siginfo_intdiv(siginfo_t *info)
 {
-	if (!(regs->eflags & VM_MASK) && !(3 & regs->xcs))
-		die(str, regs, err);
+	info->si_code = FPE_INTDIV;
 }
 
-static inline unsigned long get_cr2(void)
+static void siginfo_illopn(siginfo_t *info)
 {
-	unsigned long address;
+	info->si_code = ILL_ILLOPN;
+}
 
-	/* get the address */
-	__asm__("movl %%cr2,%0":"=r" (address));
-	return address;
+static void siginfo_adraln(siginfo_t *info)
+{
+	info->si_code = BUS_ADRALN;
+	/* Is this correct? */
+	__asm__("movl %%cr2,%0" : "=r" (info->si_addr));
 }
 
-static inline void do_trap(int trapnr, int signr, char *str, int vm86,
-			   struct pt_regs * regs, long error_code, siginfo_t *info)
+static struct trap_info {
+	int signr;
+	char *name;
+	void (*siginfo)(siginfo_t *);
+} trap_info[] = {
+	[ 0] = { SIGFPE,  "divide error", siginfo_intdiv },
+	[ 3] = { SIGTRAP, "int3", NULL },
+	[ 4] = { SIGSEGV, "overflow", NULL },
+	[ 5] = { SIGSEGV, "bounds", NULL },
+	[ 6] = { SIGILL,  "invalid operand", siginfo_illopn },
+	[ 8] = { SIGSEGV, "double fault", NULL },
+	[ 9] = { SIGFPE,  "coprocessor segment overrun", NULL },
+	[10] = { SIGSEGV, "invalid TSS", NULL },
+	[11] = { SIGBUS,  "segment not present", NULL },
+	[12] = { SIGBUS,  "stack segment", NULL },
+	[13] = { SIGSEGV, "general protection fault", NULL },
+	[17] = { SIGBUS,  "alignment check", siginfo_adraln },
+	[19] = { SIGSEGV, "cache flush denied", NULL },
+};
+
+asmlinkage void do_trap(struct pt_regs * regs, long error_code)
 {
-	if (regs->eflags & VM_MASK) {
-		if (vm86)
-			goto vm86_trap;
-		goto trap_signal;
-	}
+	int trapnr = regs->orig_eax;
+	struct trap_info *info = &trap_info[trapnr];
+
+	if (regs->eflags & VM_MASK)
+		goto vm86_trap;
 
 	if (!(regs->xcs & 3))
 		goto kernel_trap;
 
 	trap_signal: {
 		struct task_struct *tsk = current;
+		siginfo_t siginfo;
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = trapnr;
-		if (info)
-			force_sig_info(signr, info, tsk);
-		else
-			force_sig(signr, tsk);
+		siginfo.si_signo = info->signr;
+		siginfo.si_errno = 0;
+		siginfo.si_code = __SI_FAULT;
+		siginfo.si_addr = (void *) regs->eip;
+		if (info->siginfo)
+			info->siginfo(&siginfo);
+		force_sig_info(info->signr, &siginfo, tsk);
 		return;
 	}
 
 	kernel_trap: {
 		if (!fixup_exception(regs))
-			die(str, regs, error_code);
+			die(info->name, regs, error_code);
 		return;
 	}
 
 	vm86_trap: {
-		int ret = handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr);
-		if (ret) goto trap_signal;
+		if (handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr));
+			goto trap_signal;
 		return;
 	}
 }
 
-#define DO_ERROR(trapnr, signr, str, name) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
-{ \
-	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
-}
-
-#define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
-{ \
-	siginfo_t info; \
-	info.si_signo = signr; \
-	info.si_errno = 0; \
-	info.si_code = sicode; \
-	info.si_addr = (void *)siaddr; \
-	do_trap(trapnr, signr, str, 0, regs, error_code, &info); \
-}
-
-#define DO_VM86_ERROR(trapnr, signr, str, name) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
-{ \
-	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
-}
-
-#define DO_VM86_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
-{ \
-	siginfo_t info; \
-	info.si_signo = signr; \
-	info.si_errno = 0; \
-	info.si_code = sicode; \
-	info.si_addr = (void *)siaddr; \
-	do_trap(trapnr, signr, str, 1, regs, error_code, &info); \
-}
-
-DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
-DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
-DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
-DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
-DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
-DO_VM86_ERROR( 7, SIGSEGV, "device not available", device_not_available)
-DO_ERROR( 8, SIGSEGV, "double fault", double_fault)
-DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)
-DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
-DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
-DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
-DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, get_cr2())
-
-asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
-{
-	if (regs->eflags & VM_MASK)
-		goto gp_in_vm86;
-
-	if (!(regs->xcs & 3))
-		goto gp_in_kernel;
-
-	current->thread.error_code = error_code;
-	current->thread.trap_no = 13;
-	force_sig(SIGSEGV, current);
-	return;
-
-gp_in_vm86:
-	handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
-	return;
-
-gp_in_kernel:
-	if (!fixup_exception(regs))
-		die("general protection fault", regs, error_code);
-}
-
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
@@ -703,15 +659,7 @@
 		 * Handle strange cache flush from user space exception
 		 * in all other cases.  This is undocumented behaviour.
 		 */
-		if (regs->eflags & VM_MASK) {
-			handle_vm86_fault((struct kernel_vm86_regs *)regs,
-					  error_code);
-			return;
-		}
-		die_if_kernel("cache flush denied", regs, error_code);
-		current->thread.trap_no = 19;
-		current->thread.error_code = error_code;
-		force_sig(SIGSEGV, current);
+		do_trap(regs, error_code);
 	}
 }
 
diff -urN linux-2.5.59-bk1/arch/i386/kernel/vm86.c linux-b2/arch/i386/kernel/vm86.c
--- linux-2.5.59-bk1/arch/i386/kernel/vm86.c	2003-01-13 16:20:56.000000000 -0500
+++ linux-b2/arch/i386/kernel/vm86.c	2003-02-07 15:07:05.000000000 -0500
@@ -502,6 +502,22 @@
 
 int handle_vm86_trap(struct kernel_vm86_regs * regs, long error_code, int trapno)
 {
+	switch(trapno) {
+	case 13:
+	case 19:
+		handle_vm86_fault(regs, error_code);
+		return 0;
+	case 0:
+	case 1:
+	case 3:
+	case 4:
+	case 5:
+	case 7:
+		break;
+	default:
+		return 1;
+	};
+
 	if (VMPI.is_vm86pus) {
 		if ( (trapno==3) || (trapno==1) )
 			return_to_32bit(regs, VM86_TRAP + (trapno << 8));
diff -urN linux-2.5.59-bk1/arch/i386/mm/fault.c linux-b2/arch/i386/mm/fault.c
--- linux-2.5.59-bk1/arch/i386/mm/fault.c	2003-01-13 16:20:57.000000000 -0500
+++ linux-b2/arch/i386/mm/fault.c	2003-02-07 14:58:25.000000000 -0500
@@ -136,7 +136,7 @@
 	console_loglevel = loglevel_save;
 }
 
-asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
+asmlinkage void do_trap(struct pt_regs *, unsigned long);
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -302,7 +302,8 @@
 		nr = (address - idt_descr.address) >> 3;
 
 		if (nr == 6) {
-			do_invalid_op(regs, 0);
+			regs->orig_eax = 6;
+			do_trap(regs, 0);
 			return;
 		}
 	}

--------------060409090009040400080408--

