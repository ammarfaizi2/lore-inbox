Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWG3AEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWG3AEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWG3AEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 20:04:39 -0400
Received: from mail.aknet.ru ([82.179.72.26]:23301 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750824AbWG3AEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 20:04:37 -0400
Message-ID: <44CBF833.3010106@aknet.ru>
Date: Sun, 30 Jul 2006 04:07:15 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Jan Beulich <JBeulich@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>
Subject: [patch] espfix code cleanup
Content-Type: multipart/mixed;
 boundary="------------000201070702070608010307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000201070702070608010307
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

The current espfix code used to make problem for some
people by its uglyness and the stack switching.
The attached patch removes about 2/3 of the mess by
utilizing the 32bit stack instead of the 16bit one.
I simply patch the base address at gdt so that the
kernel esp have the same high word as the user esp.

In case there are no objections - Andrew, could you please apply?

-----
Clean up the espfix code by utilizing the 32bit stack
instead of the 16bit one.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------000201070702070608010307
Content-Type: text/x-patch;
 name="espfcln.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="espfcln.diff"

--- linux-2.6.18-rc2-mm1/include/asm-i386/desc.h	2006-07-29 17:34:57.000000000 +0400
+++ linux-2.6.18-rc2-mm1/include/asm-i386/desc.h	2006-07-29 17:35:07.000000000 +0400
@@ -4,8 +4,6 @@
 #include <asm/ldt.h>
 #include <asm/segment.h>
 
-#define CPU_16BIT_STACK_SIZE 1024
-
 #ifndef __ASSEMBLY__
 
 #include <linux/preempt.h>
@@ -16,8 +14,6 @@
 
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 
-DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
-
 struct Xgt_desc_struct {
 	unsigned short size;
 	unsigned long address __attribute__((packed));
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/head.S	2006-07-29 15:32:14.000000000 +0400
+++ linux-2.6.18-rc2-mm1/arch/i386/kernel/head.S	2006-07-29 17:17:51.000000000 +0400
@@ -590,7 +590,7 @@
 	.quad 0x00009a000000ffff	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
 
-	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
+	.quad 0x00cf92000000ffff	/* 0xd0 - ESPFIX SS */
 	.quad 0x0000000000000000	/* 0xd8 - unused */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/traps.c	2006-07-29 15:32:14.000000000 +0400
+++ linux-2.6.18-rc2-mm1/arch/i386/kernel/traps.c	2006-07-30 02:19:59.000000000 +0400
@@ -1018,49 +1018,30 @@
 #endif
 }
 
-fastcall void setup_x86_bogus_stack(unsigned char * stk)
+fastcall unsigned long patch_espfix_gdt(struct pt_regs *regs,
+					  unsigned long kesp)
 {
-	unsigned long *switch16_ptr, *switch32_ptr;
-	struct pt_regs *regs;
-	unsigned long stack_top, stack_bot;
-	unsigned short iret_frame16_off;
 	int cpu = smp_processor_id();
-	/* reserve the space on 32bit stack for the magic switch16 pointer */
-	memmove(stk, stk + 8, sizeof(struct pt_regs));
-	switch16_ptr = (unsigned long *)(stk + sizeof(struct pt_regs));
-	regs = (struct pt_regs *)stk;
-	/* now the switch32 on 16bit stack */
-	stack_bot = (unsigned long)&per_cpu(cpu_16bit_stack, cpu);
-	stack_top = stack_bot +	CPU_16BIT_STACK_SIZE;
-	switch32_ptr = (unsigned long *)(stack_top - 8);
-	iret_frame16_off = CPU_16BIT_STACK_SIZE - 8 - 20;
-	/* copy iret frame on 16bit stack */
-	memcpy((void *)(stack_bot + iret_frame16_off), &regs->eip, 20);
-	/* fill in the switch pointers */
-	switch16_ptr[0] = (regs->esp & 0xffff0000) | iret_frame16_off;
-	switch16_ptr[1] = __ESPFIX_SS;
-	switch32_ptr[0] = (unsigned long)stk + sizeof(struct pt_regs) +
-		8 - CPU_16BIT_STACK_SIZE;
-	switch32_ptr[1] = __KERNEL_DS;
-}
-
-fastcall unsigned char * fixup_x86_bogus_stack(unsigned short sp)
-{
-	unsigned long *switch32_ptr;
-	unsigned char *stack16, *stack32;
-	unsigned long stack_top, stack_bot;
-	int len;
-	int cpu = smp_processor_id();
-	stack_bot = (unsigned long)&per_cpu(cpu_16bit_stack, cpu);
-	stack_top = stack_bot +	CPU_16BIT_STACK_SIZE;
-	switch32_ptr = (unsigned long *)(stack_top - 8);
-	/* copy the data from 16bit stack to 32bit stack */
-	len = CPU_16BIT_STACK_SIZE - 8 - sp;
-	stack16 = (unsigned char *)(stack_bot + sp);
-	stack32 = (unsigned char *)
-		(switch32_ptr[0] + CPU_16BIT_STACK_SIZE - 8 - len);
-	memcpy(stack32, stack16, len);
-	return stack32;
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+	struct desc_struct *gdt = (struct desc_struct *)cpu_gdt_descr->address;
+	unsigned long base = (kesp - regs->esp) & -THREAD_SIZE;
+	__u64 desc = *(__u64 *)&gdt[GDT_ENTRY_ESPFIX_SS];
+	/* Set up base for espfix segment */
+ 	desc &= 0x00ffff000000ffffULL;
+ 	desc |=	((((__u64)base) << 16) & 0x000000ffffff0000ULL) |
+		((((__u64)base) << 32) & 0xff00000000000000ULL);
+	*(__u64 *)&gdt[GDT_ENTRY_ESPFIX_SS] = desc;
+	return kesp - base;
+}
+
+fastcall unsigned long get_orig_kesp(unsigned long kesp, unsigned long cpu)
+{
+	/* Since we are on a wrong stack, the smp_processor_id() cannot
+	 * be used. So the cpu number is passed from an assembly. */
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+	struct desc_struct *gdt = (struct desc_struct *)cpu_gdt_descr->address;
+	unsigned long base = get_desc_base(&gdt[GDT_ENTRY_ESPFIX_SS].a);
+	return base + kesp;
 }
 
 /*
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/entry.S	2006-07-29 15:29:00.000000000 +0400
+++ linux-2.6.18-rc2-mm1/arch/i386/kernel/entry.S	2006-07-30 02:19:47.000000000 +0400
@@ -380,8 +380,6 @@
 1:	iret
 .section .fixup,"ax"
 iret_exc:
-	TRACE_IRQS_ON
-	sti
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
@@ -403,23 +401,18 @@
 	 * This is an "official" bug of all the x86-compatible
 	 * CPUs, which we can try to work around to make
 	 * dosemu and wine happy. */
-	subl $8, %esp		# reserve space for switch16 pointer
-	CFI_ADJUST_CFA_OFFSET 8
+	movl %esp, %eax		# pt_regs pointer
+	movl %esp, %edx
+	call patch_espfix_gdt
+	pushl $__ESPFIX_SS
+	CFI_ADJUST_CFA_OFFSET 4
+	pushl %eax
+	CFI_ADJUST_CFA_OFFSET 4
 	cli
 	TRACE_IRQS_OFF
-	movl %esp, %eax
-	/* Set up the 16bit stack frame with switch32 pointer on top,
-	 * and a switch16 pointer on top of the current frame. */
-	call setup_x86_bogus_stack
-	CFI_ADJUST_CFA_OFFSET -8	# frame has moved
-	TRACE_IRQS_IRET
-	RESTORE_REGS
-	lss 20+4(%esp), %esp	# switch to 16bit stack
-1:	iret
-.section __ex_table,"a"
-	.align 4
-	.long 1b,iret_exc
-.previous
+	lss (%esp), %esp
+	CFI_ADJUST_CFA_OFFSET -8
+	jmp restore_nocheck
 	CFI_ENDPROC
 
 	# perform work that needs to be done immediately before resumption
@@ -510,26 +503,23 @@
 
 #define FIXUP_ESPFIX_STACK \
 	movl %esp, %eax; \
-	/* switch to 32bit stack using the pointer on top of 16bit stack */ \
-	lss %ss:CPU_16BIT_STACK_SIZE-8, %esp; \
-	/* copy data from 16bit stack to 32bit stack */ \
-	call fixup_x86_bogus_stack; \
-	/* put ESP to the proper location */ \
-	movl %eax, %esp;
-#define UNWIND_ESPFIX_STACK \
+	GET_THREAD_INFO(%ebp); \
+	movl TI_cpu(%ebp), %edx; \
+	call get_orig_kesp; \
+	pushl $__KERNEL_DS; \
 	pushl %eax; \
-	CFI_ADJUST_CFA_OFFSET 4; \
+	lss (%esp), %esp;
+#define UNWIND_ESPFIX_STACK \
 	movl %ss, %eax; \
-	/* see if on 16bit stack */ \
+	/* see if on espfix stack */ \
 	cmpw $__ESPFIX_SS, %ax; \
 	je 28f; \
-27:	popl %eax; \
-	CFI_ADJUST_CFA_OFFSET -4; \
+27:; \
 .section .fixup,"ax"; \
 28:	movl $__KERNEL_DS, %eax; \
 	movl %eax, %ds; \
 	movl %eax, %es; \
-	/* switch to 32bit stack */ \
+	/* switch to normal stack */ \
 	FIXUP_ESPFIX_STACK; \
 	jmp 27b; \
 .previous
@@ -600,8 +590,6 @@
 	/*CFI_REL_OFFSET ds, 0*/
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
-	CFI_REL_OFFSET eax, 0
-	xorl %eax, %eax
 	pushl %ebp
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ebp, 0
@@ -614,7 +602,6 @@
 	pushl %edx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET edx, 0
-	decl %eax			# eax = -1
 	pushl %ecx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ecx, 0
@@ -631,7 +618,7 @@
 	/*CFI_REGISTER es, ecx*/
 	movl ES(%esp), %edi		# get the function address
 	movl ORIG_EAX(%esp), %edx	# get the error code
-	movl %eax, ORIG_EAX(%esp)
+	movl $-1, ORIG_EAX(%esp)
 	movl %ecx, ES(%esp)
 	/*CFI_REL_OFFSET es, ES*/
 	movl $(__USER_DS), %ecx
@@ -733,7 +720,7 @@
 	cmpw $__ESPFIX_SS, %ax
 	popl %eax
 	CFI_ADJUST_CFA_OFFSET -4
-	je nmi_16bit_stack
+	je nmi_espfix_stack
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
 	pushl %eax
@@ -772,14 +759,13 @@
 	FIX_STACK(24,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
 
-nmi_16bit_stack:
+nmi_espfix_stack:
 	RING0_INT_FRAME
 	/* create the pointer to lss back */
 	pushl %ss
 	CFI_ADJUST_CFA_OFFSET 4
 	pushl %esp
 	CFI_ADJUST_CFA_OFFSET 4
-	movzwl %sp, %esp
 	addw $4, (%esp)
 	/* copy the iret frame of 12 bytes */
 	.rept 3
@@ -790,11 +776,11 @@
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	FIXUP_ESPFIX_STACK		# %eax == %esp
-	CFI_ADJUST_CFA_OFFSET -20	# the frame has now moved
+	CFI_ADJUST_CFA_OFFSET -20
 	xorl %edx,%edx			# zero error code
 	call do_nmi
 	RESTORE_REGS
-	lss 12+4(%esp), %esp		# back to 16bit stack
+	lss 12+4(%esp), %esp		# back to espfix stack
 1:	iret
 	CFI_ENDPROC
 .section __ex_table,"a"
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/cpu/common.c	2006-07-29 15:29:00.000000000 +0400
+++ linux-2.6.18-rc2-mm1/arch/i386/kernel/cpu/common.c	2006-07-29 17:39:01.000000000 +0400
@@ -24,9 +24,6 @@
 DEFINE_PER_CPU(struct Xgt_desc_struct, cpu_gdt_descr);
 EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
 
-DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
-EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
-
 static int cachesize_override __cpuinitdata = -1;
 static int disable_x86_fxsr __cpuinitdata;
 static int disable_x86_serial_nr __cpuinitdata = 1;
@@ -594,7 +591,6 @@
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 	struct desc_struct *gdt;
-	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
@@ -642,13 +638,6 @@
 	 * and set up the GDT descriptor:
 	 */
  	memcpy(gdt, cpu_gdt_table, GDT_SIZE);
-
-	/* Set up GDT entry for 16bit stack */
- 	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
-		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
-		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
-		(CPU_16BIT_STACK_SIZE - 1);
-
 	cpu_gdt_descr->size = GDT_SIZE - 1;
  	cpu_gdt_descr->address = (unsigned long)gdt;
 

--------------000201070702070608010307--
