Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278098AbRJ1KCS>; Sun, 28 Oct 2001 05:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278099AbRJ1KCK>; Sun, 28 Oct 2001 05:02:10 -0500
Received: from colorfullife.com ([216.156.138.34]:50952 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S278098AbRJ1KCD>;
	Sun, 28 Oct 2001 05:02:03 -0500
Message-ID: <3BDBD7BB.F7BE06D0@colorfullife.com>
Date: Sun, 28 Oct 2001 11:02:35 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sysenter support
Content-Type: multipart/mixed;
 boundary="------------8D12764D26DB149EAF708B0A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8D12764D26DB149EAF708B0A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've added sysenter/sysexit support for all syscalls with up to 4
parameters.
The syscalls with 5 or 6 parameters must continue to use int $0x80, I
need 2 registers to pass the user space stack and instruction pointer
values. The sysenter instruction destroys them.

sysenter is supported by AMD K7 and Intel Pentium II and later.
Result: simple syscall (getpid()) more than 35% faster.

before: 295 cpu ticks
now: 186 cpu ticks.

patch attached, sample code on
http://colorfullife.com/~manfred/sysenter

syscall support for K6/2 is not planned :-(

--
	Manfred
--------------8D12764D26DB149EAF708B0A
Content-Type: text/plain; charset=us-ascii;
 name="patch-sysenter"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sysenter"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 14
//  EXTRAVERSION =-pre3
diff -urN 2.4/include/asm-i386/msr.h build-2.4/include/asm-i386/msr.h
--- 2.4/include/asm-i386/msr.h	Sun Sep 30 16:25:49 2001
+++ build-2.4/include/asm-i386/msr.h	Sat Oct 27 22:30:06 2001
@@ -53,6 +53,10 @@
 
 #define MSR_IA32_BBL_CR_CTL		0x119
 
+#define MSR_IA32_SYSENTER_CS		0x174
+#define MSR_IA32_SYSENTER_ESP		0x175
+#define MSR_IA32_SYSENTER_EIP		0x176
+
 #define MSR_IA32_MCG_CAP		0x179
 #define MSR_IA32_MCG_STATUS		0x17a
 #define MSR_IA32_MCG_CTL		0x17b
diff -urN 2.4/include/asm-i386/processor.h build-2.4/include/asm-i386/processor.h
--- 2.4/include/asm-i386/processor.h	Sun Oct 28 02:12:45 2001
+++ build-2.4/include/asm-i386/processor.h	Sat Oct 27 22:27:46 2001
@@ -90,6 +90,7 @@
 #define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
 #define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
 #define cpu_has_apic	(test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
+#define cpu_has_sep	(test_bit(X86_FEATURE_SEP,  boot_cpu_data.x86_capability))
 
 extern char ignore_irq13;
 
diff -urN 2.4/include/asm-i386/syscall.h build-2.4/include/asm-i386/syscall.h
--- 2.4/include/asm-i386/syscall.h	Thu Jan  1 01:00:00 1970
+++ build-2.4/include/asm-i386/syscall.h	Sun Oct 28 10:14:35 2001
@@ -0,0 +1,128 @@
+#ifndef __ASM_SYSCALL_H
+#define __ASM_SYSCALL_H
+#ifdef __KERNEL__
+/*
+ * Helper structures for fast system call instructions.
+ *
+ * Intel support sysenter/sysexit since Pentium II.
+ * 	AMD supports sysenter/sysexit since K7.
+ * AMD supports syscall and sysret since K6 (/2?)
+ *
+ * Copyright (C) 2001 Manfred Spraul
+ *
+ * A) SYSENTER/SYSEXIT
+ * Interrupts are disabled after sysenter until the normal
+ * stack layout is built.
+ *
+ * sysenter only switches EIP and ESP, and then
+ * entry.S must find current.
+ */
+union sysenter_struct {
+	struct {
+		/* small emergency stack to handle trap flag
+		 * debug exceptions. Only 4 dwords are needed.
+		 */
+		unsigned long TF_stack[8];
+		/* esp points to cur_tsk after sysenter */
+		void * cur_tsk;
+	} u;
+	unsigned char fill[SMP_CACHE_BYTES];
+};
+extern union sysenter_struct sysenter_data[NR_CPUS];
+/*
+ * B) SYSCALL/SYSRET
+ *
+ * Not yet implemented. I can't find a clean way to
+ * implement SMP support and trap flag clearing.
+ */
+#endif
+
+/* Alternate syscall macros for sysenter and syscall */
+/* A) sysenter
+ *	- only up to 4 parametesr
+ */
+
+/* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
+#define _syscallSEP0(type,name) \
+type name(void) \
+{ \
+long __res; \
+__asm__ __volatile__( \
+		"mov $1f, %%edi\n\t" \
+		"push %%ebp\n\t" \
+		"mov %%esp, %%ebp\n\t" \
+		"sysenter\n\t" \
+		"1:pop %%ebp\n\t" \
+		: "=a" (__res) \
+		: "0" (__NR_##name) \
+		: "ecx", "edx", "edi", "flags"); \
+__syscall_return(type,__res); \
+}
+
+#define _syscallSEP1(type,name,type1,arg1) \
+type name(type1 arg1) \
+{ \
+long __res; \
+__asm__ __volatile__( \
+		"mov $1f, %%edi\n\t" \
+		"push %%ebp\n\t" \
+		"mov %%esp, %%ebp\n\t" \
+		"sysenter\n\t" \
+		"1:pop %%ebp\n\t" \
+		: "=a" (__res) \
+		: "0" (__NR_##name), "b" ((long)(arg1)) \
+		: "ecx", "edx", "edi", "flags"); \
+__syscall_return(type,__res); \
+}
+
+#define _syscallSEP2(type,name,type1,arg1,type2,arg2) \
+type name(type1 arg1,type2 arg2) \
+{ \
+long __res; \
+__asm__ __volatile__( \
+		"mov $1f, %%edi\n\t" \
+		"push %%ebp\n\t" \
+		"mov %%esp, %%ebp\n\t" \
+		"sysenter\n\t" \
+		"1:pop %%ebp\n\t" \
+		: "=a" (__res) \
+		: "0" (__NR_##name), "b" ((long)(arg1)), "c" ((long)(arg2)) \
+		: "edx", "edi", "flags"); \
+__syscall_return(type,__res); \
+}
+
+#define _syscallSEP3(type,name,type1,arg1,type2,arg2,type3,arg3) \
+type name(type1 arg1,type2 arg2,type3 arg3) \
+{ \
+long __res; \
+__asm__ __volatile__( \
+		"mov $1f, %%edi\n\t" \
+		"push %%ebp\n\t" \
+		"mov %%esp, %%ebp\n\t" \
+		"sysenter\n\t" \
+		"1:pop %%ebp\n\t" \
+		: "=a" (__res) \
+		: "0" (__NR_##name), "b" ((long)(arg1)), "c" ((long)(arg2)) \
+			"d" ((long)(arg3)) \
+		: "edi", "flags"); \
+__syscall_return(type,__res); \
+}
+
+#define _syscallSEP4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
+type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
+{ \
+long __res; \
+__asm__ __volatile__( \
+		"mov $1f, %%edi\n\t" \
+		"push %%ebp\n\t" \
+		"mov %%esp, %%ebp\n\t" \
+		"sysenter\n\t" \
+		"1:pop %%ebp\n\t" \
+		: "=a" (__res) \
+		: "0" (__NR_##name), "b" ((long)(arg1)), "c" ((long)(arg2)) \
+	  		"d" ((long)(arg3)),"S" ((long)(arg4)) \
+		: "edi", "flags"); \
+__syscall_return(type,__res); \
+} 
+
+#endif
--- 2.4/arch/i386/kernel/setup.c	Sun Oct 28 10:07:01 2001
+++ build-2.4/arch/i386/kernel/setup.c	Sun Oct 28 00:42:50 2001
@@ -108,6 +108,7 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#include <asm/syscall.h>
 /*
  * Machine setup..
  */
@@ -2771,6 +2772,7 @@
  * and IDT. We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
  */
+extern void system_call_SYSENTER(void);
 void __init cpu_init (void)
 {
 	int nr = smp_processor_id();
@@ -2832,6 +2834,12 @@
 	current->flags &= ~PF_USEDFPU;
 	current->used_math = 0;
 	stts();
+
+	if (cpu_has_sep) {
+		wrmsr(MSR_IA32_SYSENTER_CS, 0x10, 0);
+		wrmsr(MSR_IA32_SYSENTER_ESP, &sysenter_data[nr].u.cur_tsk, 0);
+		wrmsr(MSR_IA32_SYSENTER_EIP, system_call_SYSENTER, 0);
+	}	
 }
 
 /*
--- 2.4/arch/i386/kernel/process.c	Thu Oct 11 15:19:41 2001
+++ build-2.4/arch/i386/kernel/process.c	Sun Oct 28 00:16:22 2001
@@ -43,6 +43,7 @@
 #include <asm/i387.h>
 #include <asm/desc.h>
 #include <asm/mmu_context.h>
+#include <asm/syscall.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
@@ -650,6 +651,8 @@
 			: /* no output */ \
 			:"r" (thread->debugreg[register]))
 
+union sysenter_struct sysenter_data[NR_CPUS];
+
 /*
  *	switch_to(x,yn) should switch tasks from x to y.
  *
@@ -679,6 +682,7 @@
 				 *next = &next_p->thread;
 	struct tss_struct *tss = init_tss + smp_processor_id();
 
+	sysenter_data[smp_processor_id()].u.cur_tsk = current;
 	unlazy_fpu(prev_p);
 
 	/*
--- 2.4/arch/i386/kernel/traps.c	Sun Oct 28 02:12:43 2001
+++ build-2.4/arch/i386/kernel/traps.c	Sat Oct 27 22:57:07 2001
@@ -921,7 +921,7 @@
 #endif
 
 	set_trap_gate(0,&divide_error);
-	set_trap_gate(1,&debug);
+	set_intr_gate(1,&debug);
 	set_intr_gate(2,&nmi);
 	set_system_gate(3,&int3);	/* int3-5 can be called from all */
 	set_system_gate(4,&overflow);
--- 2.4/arch/i386/kernel/entry.S	Sun Oct 28 02:12:43 2001
+++ build-2.4/arch/i386/kernel/entry.S	Sun Oct 28 09:48:25 2001
@@ -45,6 +45,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
+#include <asm/unistd.h>
 
 EBX		= 0x00
 ECX		= 0x04
@@ -97,7 +98,7 @@
 	movl %edx,%ds; \
 	movl %edx,%es;
 
-#define RESTORE_ALL	\
+#define RESTORE_NORET	\
 	popl %ebx;	\
 	popl %ecx;	\
 	popl %edx;	\
@@ -107,14 +108,22 @@
 	popl %eax;	\
 1:	popl %ds;	\
 2:	popl %es;	\
-	addl $4,%esp;	\
-3:	iret;		\
 .section .fixup,"ax";	\
-4:	movl $0,(%esp);	\
+3:	movl $0,(%esp);	\
 	jmp 1b;		\
-5:	movl $0,(%esp);	\
+4:	movl $0,(%esp);	\
 	jmp 2b;		\
-6:	pushl %ss;	\
+.previous;		\
+.section __ex_table,"a";\
+	.align 4;	\
+	.long 1b,3b;	\
+	.long 2b,4b;	\
+.previous
+
+#define DO_IRET		\
+1:	iret;		\
+.section .fixup,"ax";	\
+2:	pushl %ss;	\
 	popl %ds;	\
 	pushl %ss;	\
 	popl %es;	\
@@ -122,12 +131,15 @@
 	call do_exit;	\
 .previous;		\
 .section __ex_table,"a";\
-	.align 4;	\
-	.long 1b,4b;	\
-	.long 2b,5b;	\
-	.long 3b,6b;	\
+	.long 1b,2b;	\
 .previous
 
+
+#define RESTORE_ALL	\
+	RESTORE_NORET	\
+	addl $4,%esp;	\
+	DO_IRET
+
 #define GET_CURRENT(reg) \
 	movl $-8192, reg; \
 	andl %esp, reg
@@ -259,6 +271,92 @@
 	call SYMBOL_NAME(schedule)    # test
 	jmp ret_from_sys_call
 
+/*
+ * SYSENTER entry point
+ * ptrace must work without changes, thus the code pushes everything
+ * identical to int 0x80
+ */
+
+ENTRY(system_call_SYSENTER)
+	movl (%esp), %esp # load current
+	addl $0x2000, %esp # and go to the stack
+	sti
+	pushl $0x2b	# user ss
+	pushl %ebp	# user esp
+	pushfl
+	pushl $0x23	# user cs
+	pushl %edi	# user eip
+
+	pushl %eax	# orig_eax	
+
+	SAVE_ALL
+	GET_CURRENT(%ebx)
+	cmpl $(NR_syscalls),%eax
+	jae badsys
+	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
+	jne tracesys
+	call *SYMBOL_NAME(sys_call_table)(,%eax,4)
+	movl %eax,EAX(%esp)		# save the return value
+	cli				# need_resched and signals atomic test
+	cmpl $0,need_resched(%ebx)
+	jne reschedule
+	cmpl $0,sigpending(%ebx)
+	jne signal_return
+	#
+	# for return from execve and sigreturn, we must use iretd,
+	# since we must not clobber %ecx and %edx in these cases.
+	#
+	# FIXME: ak says that iopl is special, too.
+	RESTORE_NORET
+	cmpl $__NR_execve, (%esp)
+	je sysexit_iretd
+	cmpl $__NR_sigreturn, (%esp)
+	je sysexit_iretd
+	popl %edx		# discard orig_eax
+	popl %edx		# user eip
+	popl %ecx		# discard user cs
+
+	movl 4(%esp),%ecx	# user esp
+	# popfl reenables interrupts.
+	# To guarantee an atomic enable & return,
+	# that must be the last instruction before sysexit
+	# FIXME: check docu. hpa says ok.
+	popfl
+	# Alternative:
+	# andl $0xfffffdff, (%esp)
+	# popfl
+	# sti
+	sysexit
+	# user esp was already loaded
+	# ignore user ss
+sysexit_iretd:
+	DO_IRET
+
+
+sysenter_trap_fixup:
+	# Sysenter was called single stepping is on.
+	# We must transparently switch from sysenter to int $0x80.
+	# Sysexit does not support enabling the trap flag.
+	# Stack layout:
+	pushl %eax
+	movl %esp, %eax
+	# 0(%eax): true eax
+	# 4(%eax): EIP (==system_call_SYSENTER)
+	# 8(%eax): CS (==KERNEL_CS)
+	# 12(%eax): flags
+	# 16(%eax): current
+	movl 16(%esp), %esp
+	addl $0x2000, %esp
+	sti
+	pushl $0x2b	# user ss
+	pushl %ebp	# user esp
+	orl $0x200, 12(%eax) # enable interrupts, sysenter disabled them
+	pushl 12(%eax)	# flags
+	pushl $0x23	# user cs
+	pushl %edi	# user eip
+	movl (%eax), %eax	
+	jmp system_call
+
 ENTRY(divide_error)
 	pushl $0		# no error code
 	pushl $ SYMBOL_NAME(do_divide_error)
@@ -317,6 +415,9 @@
 	jmp ret_from_exception
 
 ENTRY(debug)
+	cmpl $system_call_SYSENTER, (%esp)
+	je sysenter_trap_fixup
+	sti
 	pushl $0
 	pushl $ SYMBOL_NAME(do_debug)
 	jmp error_code

--------------8D12764D26DB149EAF708B0A--

