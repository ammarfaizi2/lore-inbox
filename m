Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVACXpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVACXpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVACXoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:44:09 -0500
Received: from mail.aknet.ru ([217.67.122.194]:20242 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261991AbVACXjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:39:48 -0500
Message-ID: <41D9D7CC.3090409@aknet.ru>
Date: Tue, 04 Jan 2005 02:39:56 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: [patch] x86: fix ESP corruption CPU bug
Content-Type: multipart/mixed;
 boundary="------------070400060008010409000400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070400060008010409000400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Attached patch works around the corruption
of the high word of the ESP register, which
is the official bug of x86 CPUs. The bug
triggers only when the one is using the
16bit stack segment.
Patch helps running many apps under dosemu,
and, according to the comments found in
Wine sources, also helps Wine.

The patch defines the per-CPU 16bit stacks,
and every time the process that uses 16bit
stack, returns to the userspace, we switch
to our 16bit stack and preload the high word
of ESP.
This also closes the "informational leak",
which is that the user process is not
supposed to know the kernel's ESP value.

Can this please be applied?

Acked-by: Linus Torvalds <torvalds@osdl.org>
|Signed-off-by: Stas Sergeev <stsp@aknet.ru>|


--------------070400060008010409000400
Content-Type: text/x-patch;
 name="linux-2.6.10-mm1-stk4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.10-mm1-stk4.diff"

diff -urN linux-2.6.10-mm1/arch/i386/kernel/cpu/common.c linux-2.6.10-mm1-stk/arch/i386/kernel/cpu/common.c
--- linux-2.6.10-mm1/arch/i386/kernel/cpu/common.c	2005-01-03 22:56:03.000000000 +0300
+++ linux-2.6.10-mm1-stk/arch/i386/kernel/cpu/common.c	2005-01-03 23:13:21.000000000 +0300
@@ -16,6 +16,10 @@
 DEFINE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 EXPORT_PER_CPU_SYMBOL(cpu_gdt_table);
 
+unsigned char cpu_16bit_stack[CPU_16BIT_STACK_SIZE];
+DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
+EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
+
 static int cachesize_override __initdata = -1;
 static int disable_x86_fxsr __initdata = 0;
 static int disable_x86_serial_nr __initdata = 1;
@@ -505,6 +509,7 @@
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
+	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
 
 	if (test_and_set_bit(cpu, &cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
@@ -527,6 +532,13 @@
 	 */
 	memcpy(&per_cpu(cpu_gdt_table, cpu), cpu_gdt_table,
 	       GDT_SIZE);
+
+	/* Set up GDT entry for 16bit stack */
+	*(__u64 *)&(per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_ESPFIX_SS]) |=
+		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
+		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
+		(CPU_16BIT_STACK_SIZE - 1);
+
 	cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
 	cpu_gdt_descr[cpu].address =
 	    (unsigned long)&per_cpu(cpu_gdt_table, cpu);
diff -urN linux-2.6.10-mm1/arch/i386/kernel/entry.S linux-2.6.10-mm1-stk/arch/i386/kernel/entry.S
--- linux-2.6.10-mm1/arch/i386/kernel/entry.S	2005-01-03 22:56:03.000000000 +0300
+++ linux-2.6.10-mm1-stk/arch/i386/kernel/entry.S	2005-01-04 00:47:03.000000000 +0300
@@ -47,6 +47,7 @@
 #include <asm/segment.h>
 #include <asm/smp.h>
 #include <asm/page.h>
+#include <asm/desc.h>
 #include "irq_vectors.h"
         /* We do not recover from a stack overflow, but at least
          * we know it happened and should be able to track it down.
@@ -90,7 +91,7 @@
 #define preempt_stop		cli
 #else
 #define preempt_stop
-#define resume_kernel		restore_all
+#define resume_kernel		resume_kernelX
 #endif
 
 #define SAVE_ALL \
@@ -135,24 +136,6 @@
 .previous
 
 
-#define RESTORE_ALL	\
-	RESTORE_REGS	\
-	addl $4, %esp;	\
-1:	iret;		\
-.section .fixup,"ax";   \
-2:	sti;		\
-	movl $(__USER_DS), %edx; \
-	movl %edx, %ds; \
-	movl %edx, %es; \
-	movl $11,%eax;	\
-	call do_exit;	\
-.previous;		\
-.section __ex_table,"a";\
-	.align 4;	\
-	.long 1b,2b;	\
-.previous
-
-
 ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
@@ -176,7 +159,7 @@
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	testl $(VM_MASK | 3), %eax
-	jz resume_kernel		# returning to kernel or vm86-space
+	jz resume_kernel
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -190,7 +173,7 @@
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
-	jnz restore_all
+	jnz resume_kernelX
 need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
@@ -204,6 +187,31 @@
 	jmp need_resched
 #endif
 
+ldt_ss:
+	larl OLDSS(%esp), %eax
+	jnz resume_kernelX
+	testl $0x00400000, %eax		# returning to 32bit stack?
+	jnz resume_kernelX		# allright, normal return
+	/* If returning to userspace with 16bit stack,
+	 * try to fix the higher word of ESP, as the CPU
+	 * won't restore it.
+	 * This is an "official" bug of all the x86-compatible
+	 * CPUs, which we can try to work around to make
+	 * dosemu and wine happy. */
+	subl $8, %esp		# reserve space for switch16 pointer
+	cli
+	movl %esp, %eax
+	/* Set up the 16bit stack frame with switch32 pointer on top,
+	 * and a switch16 pointer on top of the current frame. */
+	call setup_x86_bogus_stack
+	RESTORE_REGS
+	lss 20+4(%esp), %esp	# The magic pointer above iret frame
+1:	iret
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
+
 /* SYSENTER_RETURN points to after the "sysenter" instruction in
    the vsyscall page.  See vsyscall-sysentry.S, which defines the symbol.  */
 
@@ -273,21 +281,40 @@
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
+
 restore_all:
-#ifdef CONFIG_TRAP_BAD_SYSCALL_EXITS
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
-	jz resume_kernelX		# returning to kernel or vm86-space
+	andl $(VM_MASK | 3), %eax
+	cmpl $3, %eax
+	jne resume_kernelX		# returning to kernel or vm86-space
 
+#ifdef CONFIG_TRAP_BAD_SYSCALL_EXITS
 	cmpl $0,TI_preempt_count(%ebp)  # non-zero preempt_count ?
-	jz resume_kernelX
-
+	jz 47f
         int $3
+47:
+#endif
 
+	testl $4, OLDSS(%esp)
+	jnz ldt_ss
 resume_kernelX:
-#endif
-	RESTORE_ALL
+	RESTORE_REGS
+	addl $4, %esp
+1:	iret
+.section .fixup,"ax"
+iret_exc:
+	sti
+	movl $(__USER_DS), %edx
+	movl %edx, %ds
+	movl %edx, %es
+	movl $11,%eax
+	call do_exit
+.previous
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
 
 	# perform work that needs to be done immediately before resumption
 	ALIGN
@@ -363,6 +390,25 @@
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
 
+/* Check if we are on 16bit stack. Can happen either on iret of ESPFIX,
+ * or in an exception handler after that iret... */
+#define FIXUP_ESPFIX_STACK \
+	movl %esp, %eax; \
+	/* Magic pointer is at the top of the 16bit stack */ \
+	lss %ss:CPU_16BIT_STACK_SIZE-8, %esp; \
+	call fixup_x86_bogus_stack; \
+	movl %eax, %esp;
+#define UNWIND_ESPFIX_STACK \
+	pushl %eax; \
+	movl %ss, %eax; \
+	cmpw $__ESPFIX_SS, %ax; \
+	jne 28f; \
+	movl $(__KERNEL_DS), %edx; \
+	movl %edx, %ds; \
+	movl %edx, %es; \
+	FIXUP_ESPFIX_STACK \
+28:	popl %eax;
+
 /*
  * Build the entry stubs and pointer table with
  * some assembler magic.
@@ -427,7 +473,9 @@
 	pushl %ecx
 	pushl %ebx
 	cld
-	movl %es, %ecx
+	pushl %es
+	UNWIND_ESPFIX_STACK
+	popl %ecx
 	movl ES(%esp), %edi		# get the function address
 	movl ORIG_EAX(%esp), %edx	# get the error code
 	movl %eax, ORIG_EAX(%esp)
@@ -509,6 +557,11 @@
  * fault happened on the sysenter path.
  */
 ENTRY(nmi)
+	pushl %eax
+	movl %ss, %eax
+	cmpw $__ESPFIX_SS, %ax
+	popl %eax
+	je nmi_16bit_stack
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
 	pushl %eax
@@ -528,7 +581,7 @@
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_nmi
-	RESTORE_ALL
+	jmp restore_all
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
@@ -544,6 +597,29 @@
 	FIX_STACK(24,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
 
+nmi_16bit_stack:
+	/* create the pointer to lss back */
+	pushl %ss
+	pushl %esp
+	andl $0xffff, %esp
+	addw $4, (%esp)
+	/* copy the iret frame of 12 bytes */
+	.rept 3
+	pushl 16(%esp)
+	.endr
+	pushl %eax
+	SAVE_ALL
+	FIXUP_ESPFIX_STACK		# %eax == %esp
+	xorl %edx,%edx			# zero error code
+	call do_nmi
+	RESTORE_REGS
+	lss 12+4(%esp), %esp		# back to 16bit stack
+1:	iret
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
+
 ENTRY(int3)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
diff -urN linux-2.6.10-mm1/arch/i386/kernel/head.S linux-2.6.10-mm1-stk/arch/i386/kernel/head.S
--- linux-2.6.10-mm1/arch/i386/kernel/head.S	2005-01-03 22:56:03.000000000 +0300
+++ linux-2.6.10-mm1-stk/arch/i386/kernel/head.S	2005-01-03 23:13:21.000000000 +0300
@@ -512,7 +512,7 @@
 	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
-	.quad 0x0000000000000000	/* 0xd0 - unused */
+	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
 	.quad 0x0000000000000000	/* 0xd8 - unused */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
diff -urN linux-2.6.10-mm1/arch/i386/kernel/traps.c linux-2.6.10-mm1-stk/arch/i386/kernel/traps.c
--- linux-2.6.10-mm1/arch/i386/kernel/traps.c	2005-01-03 22:56:03.000000000 +0300
+++ linux-2.6.10-mm1-stk/arch/i386/kernel/traps.c	2005-01-03 23:13:21.000000000 +0300
@@ -972,6 +972,51 @@
 #endif
 }
 
+fastcall void setup_x86_bogus_stack(unsigned char * stk)
+{
+	unsigned long *switch16_ptr, *switch32_ptr;
+	struct pt_regs *regs;
+	unsigned long stack_top, stack_bot;
+	unsigned short iret_frame16_off;
+	int cpu = smp_processor_id();
+	/* reserve the space on 32bit stack for the magic switch16 pointer */
+	memmove(stk, stk + 8, sizeof(struct pt_regs));
+	switch16_ptr = (unsigned long *)(stk + sizeof(struct pt_regs));
+	regs = (struct pt_regs *)stk;
+	/* now the switch32 on 16bit stack */
+	stack_bot = (unsigned long)&per_cpu(cpu_16bit_stack, cpu);
+	stack_top = stack_bot +	CPU_16BIT_STACK_SIZE;
+	switch32_ptr = (unsigned long *)(stack_top - 8);
+	iret_frame16_off = CPU_16BIT_STACK_SIZE - 8 - 20;
+	/* copy iret frame on 16bit stack */
+	memcpy((void *)(stack_bot + iret_frame16_off), &regs->eip, 20);
+	/* fill in the switch pointers */
+	switch16_ptr[0] = (regs->esp & 0xffff0000) | iret_frame16_off;
+	switch16_ptr[1] = __ESPFIX_SS;
+	switch32_ptr[0] = (unsigned long)stk + sizeof(struct pt_regs) +
+		8 - CPU_16BIT_STACK_SIZE;
+	switch32_ptr[1] = __KERNEL_DS;
+}
+
+fastcall unsigned char * fixup_x86_bogus_stack(unsigned short sp)
+{
+	unsigned long *switch32_ptr;
+	unsigned char *stack16, *stack32;
+	unsigned long stack_top, stack_bot;
+	int len;
+	int cpu = smp_processor_id();
+	stack_bot = (unsigned long)&per_cpu(cpu_16bit_stack, cpu);
+	stack_top = stack_bot +	CPU_16BIT_STACK_SIZE;
+	switch32_ptr = (unsigned long *)(stack_top - 8);
+	/* copy the data from 16bit stack to 32bit stack */
+	len = CPU_16BIT_STACK_SIZE - 8 - sp;
+	stack16 = (unsigned char *)(stack_bot + sp);
+	stack32 = (unsigned char *)
+		(switch32_ptr[0] + CPU_16BIT_STACK_SIZE - 8 - len);
+	memcpy(stack32, stack16, len);
+	return stack32;
+}
+
 /*
  *  'math_state_restore()' saves the current math information in the
  * old math state array, and gets the new ones from the current task
diff -urN linux-2.6.10-mm1/include/asm-i386/desc.h linux-2.6.10-mm1-stk/include/asm-i386/desc.h
--- linux-2.6.10-mm1/include/asm-i386/desc.h	2005-01-03 22:55:08.000000000 +0300
+++ linux-2.6.10-mm1-stk/include/asm-i386/desc.h	2005-01-03 23:13:21.000000000 +0300
@@ -4,6 +4,8 @@
 #include <asm/ldt.h>
 #include <asm/segment.h>
 
+#define CPU_16BIT_STACK_SIZE 1024
+
 #ifndef __ASSEMBLY__
 
 #include <linux/preempt.h>
@@ -15,6 +17,9 @@
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
 
+extern unsigned char cpu_16bit_stack[CPU_16BIT_STACK_SIZE];
+DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
+
 struct Xgt_desc_struct {
 	unsigned short size;
 	unsigned long address __attribute__((packed));
diff -urN linux-2.6.10-mm1/include/asm-i386/segment.h linux-2.6.10-mm1-stk/include/asm-i386/segment.h
--- linux-2.6.10-mm1/include/asm-i386/segment.h	2005-01-03 22:56:32.000000000 +0300
+++ linux-2.6.10-mm1-stk/include/asm-i386/segment.h	2005-01-03 23:13:21.000000000 +0300
@@ -38,7 +38,7 @@
  *  24 - APM BIOS support
  *  25 - APM BIOS support 
  *
- *  26 - unused
+ *  26 - ESPFIX small SS
  *  27 - unused
  *  28 - unused
  *  29 - unused
@@ -71,6 +71,9 @@
 #define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
+#define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
+#define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
+
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
 /*

--------------070400060008010409000400--
