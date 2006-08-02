Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWHBQkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWHBQkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWHBQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:40:55 -0400
Received: from mail.aknet.ru ([82.179.72.26]:63756 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932096AbWHBQky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:40:54 -0400
Message-ID: <44D0D643.6090108@aknet.ru>
Date: Wed, 02 Aug 2006 20:43:47 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch] espfix cleanup take 2
Content-Type: multipart/mixed;
 boundary="------------010605080707060505020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010605080707060505020002
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Attached is a new espfix cleanup patch.
- Introduced PER_CPU() macro to be used from asm
- Introduced GET_DESC_BASE() macro to be used from asm
- Rewrote the fixup code in asm, as calling a C code with
the altered %ss appeared to be unsafe
- No longer altering the stack from a .fixup section
- 16bit per-cpu stack is no longer used, instead the 32bit
stack is used, and the base is patched the way so that the
high word of the kernel and user %esp are the same.
- I think that the limit of regs->esp+THREAD_SIZE*2 is very
permissive too (and I don't want to mess with granularity),
so I left the default 4G limit, unless Zach will really
complain on that. :)

Signed-off-by: Stas Sergeev <stsp@aknet.ru>
Acked-by: Zachary Amsden <zach@vmware.com>


--------------010605080707060505020002
Content-Type: text/x-patch;
 name="espfcln2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="espfcln2.diff"

--- linux-2.6.18-rc2-mm1/percpu.h	2004-01-09 10:00:03.000000000 +0300
+++ linux-2.6.18-rc2-mm1/percpu.h	2006-08-01 14:31:10.000000000 +0400
@@ -1,6 +1,27 @@
 #ifndef __ARCH_I386_PERCPU__
 #define __ARCH_I386_PERCPU__
 
+#ifndef __ASSEMBLY__
 #include <asm-generic/percpu.h>
+#else
+
+/*
+ * PER_CPU finds an address of a per-cpu variable.
+ *
+ * Args:
+ *    var - variable name
+ *    cpu - 32bit register containing the current CPU number
+ *
+ * The resulting address is stored in the "cpu" argument.
+ *
+ * Example:
+ *    PER_CPU(cpu_gdt_descr, %ebx)
+ */
+#define PER_CPU(var, cpu) \
+	shll $2, cpu; \
+	movl __per_cpu_offset(cpu), cpu; \
+	addl $per_cpu__/**/var, cpu;
+
+#endif /* !__ASSEMBLY__ */
 
 #endif /* __ARCH_I386_PERCPU__ */
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
@@ -162,6 +158,29 @@
 	return base;
 }
 
+#else /* __ASSEMBLY__ */
+
+/*
+ * GET_DESC_BASE reads the descriptor base of the specified segment.
+ *
+ * Args:
+ *    idx - descriptor index
+ *    gdt - GDT pointer
+ *    base - 32bit register to which the base will be written
+ *    lo_w - lo word of the "base" register
+ *    lo_b - lo byte of the "base" register
+ *    hi_b - hi byte of the low word of the "base" register
+ *
+ * Example:
+ *    GET_DESC_BASE(GDT_ENTRY_ESPFIX_SS, %ebx, %eax, %ax, %al, %ah)
+ *    Will read the base address of GDT_ENTRY_ESPFIX_SS and put it into %eax.
+ */
+#define GET_DESC_BASE(idx, gdt, base, lo_w, lo_b, hi_b) \
+	movb idx*8+4(gdt), lo_b; \
+	movb idx*8+7(gdt), hi_b; \
+	shll $16, base; \
+	movw idx*8+2(gdt), lo_w;
+
 #endif /* !__ASSEMBLY__ */
 
 #endif
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
@@ -1018,49 +1018,20 @@
 #endif
 }
 
-fastcall void setup_x86_bogus_stack(unsigned char * stk)
+fastcall unsigned long patch_espfix_base(unsigned long uesp,
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
+	unsigned long base = (kesp - uesp) & -THREAD_SIZE;
+	__u64 desc = *(__u64 *)&gdt[GDT_ENTRY_ESPFIX_SS];
+	/* Set up base for espfix segment */
+ 	desc &= 0x00ffff000000ffffULL;
+ 	desc |=	((((__u64)base) << 16) & 0x000000ffffff0000ULL) |
+		((((__u64)base) << 32) & 0xff00000000000000ULL);
+	*(__u64 *)&gdt[GDT_ENTRY_ESPFIX_SS] = desc;
+	return kesp - base;
 }
 
 /*
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/entry.S	2006-07-29 15:29:00.000000000 +0400
+++ linux-2.6.18-rc2-mm1/arch/i386/kernel/entry.S	2006-07-30 02:19:47.000000000 +0400
@@ -48,6 +48,7 @@
 #include <asm/smp.h>
 #include <asm/page.h>
 #include <asm/desc.h>
+#include <asm/percpu.h>
 #include <asm/dwarf2.h>
 #include "irq_vectors.h"
 
@@ -403,23 +404,18 @@
 	 * This is an "official" bug of all the x86-compatible
 	 * CPUs, which we can try to work around to make
 	 * dosemu and wine happy. */
-	subl $8, %esp		# reserve space for switch16 pointer
-	CFI_ADJUST_CFA_OFFSET 8
+	movl OLDESP(%esp), %eax
+	movl %esp, %edx
+	call patch_espfix_base
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
@@ -509,30 +505,30 @@
 	CFI_ENDPROC
 
 #define FIXUP_ESPFIX_STACK \
-	movl %esp, %eax; \
-	/* switch to 32bit stack using the pointer on top of 16bit stack */ \
-	lss %ss:CPU_16BIT_STACK_SIZE-8, %esp; \
-	/* copy data from 16bit stack to 32bit stack */ \
-	call fixup_x86_bogus_stack; \
-	/* put ESP to the proper location */ \
-	movl %eax, %esp;
-#define UNWIND_ESPFIX_STACK \
+	/* since we are on a wrong stack, we cant make it a C code :( */ \
+	GET_THREAD_INFO(%ebp); \
+	movl TI_cpu(%ebp), %ebx; \
+	PER_CPU(cpu_gdt_descr, %ebx); \
+	movl GDS_address(%ebx), %ebx; \
+	GET_DESC_BASE(GDT_ENTRY_ESPFIX_SS, %ebx, %eax, %ax, %al, %ah); \
+	addl %esp, %eax; \
+	pushl $__KERNEL_DS; \
+	CFI_ADJUST_CFA_OFFSET 4; \
 	pushl %eax; \
 	CFI_ADJUST_CFA_OFFSET 4; \
+	lss (%esp), %esp; \
+	CFI_ADJUST_CFA_OFFSET -8;
+#define UNWIND_ESPFIX_STACK \
 	movl %ss, %eax; \
-	/* see if on 16bit stack */ \
+	/* see if on espfix stack */ \
 	cmpw $__ESPFIX_SS, %ax; \
-	je 28f; \
-27:	popl %eax; \
-	CFI_ADJUST_CFA_OFFSET -4; \
-.section .fixup,"ax"; \
-28:	movl $__KERNEL_DS, %eax; \
+	jne 27f; \
+	movl $__KERNEL_DS, %eax; \
 	movl %eax, %ds; \
 	movl %eax, %es; \
-	/* switch to 32bit stack */ \
+	/* switch to normal stack */ \
 	FIXUP_ESPFIX_STACK; \
-	jmp 27b; \
-.previous
+27:;
 
 /*
  * Build the entry stubs and pointer table with
@@ -601,7 +597,6 @@
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET eax, 0
-	xorl %eax, %eax
 	pushl %ebp
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ebp, 0
@@ -614,7 +609,6 @@
 	pushl %edx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET edx, 0
-	decl %eax			# eax = -1
 	pushl %ecx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ecx, 0
@@ -631,7 +625,7 @@
 	/*CFI_REGISTER es, ecx*/
 	movl ES(%esp), %edi		# get the function address
 	movl ORIG_EAX(%esp), %edx	# get the error code
-	movl %eax, ORIG_EAX(%esp)
+	movl $-1, ORIG_EAX(%esp)
 	movl %ecx, ES(%esp)
 	/*CFI_REL_OFFSET es, ES*/
 	movl $(__USER_DS), %ecx
@@ -733,7 +727,7 @@
 	cmpw $__ESPFIX_SS, %ax
 	popl %eax
 	CFI_ADJUST_CFA_OFFSET -4
-	je nmi_16bit_stack
+	je nmi_espfix_stack
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
 	pushl %eax
@@ -772,14 +766,13 @@
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
@@ -790,11 +783,11 @@
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	FIXUP_ESPFIX_STACK		# %eax == %esp
-	CFI_ADJUST_CFA_OFFSET -20	# the frame has now moved
 	xorl %edx,%edx			# zero error code
 	call do_nmi
 	RESTORE_REGS
-	lss 12+4(%esp), %esp		# back to 16bit stack
+	lss 12+4(%esp), %esp		# back to espfix stack
+	CFI_ADJUST_CFA_OFFSET -24
 1:	iret
 	CFI_ENDPROC
 .section __ex_table,"a"
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/asm-offsets.c	2006-07-29 15:29:00.000000000 +0400
+++ linux-2.6.18-rc2-mm1/arch/i386/kernel/asm-offsets.c	2006-08-01 12:38:25.000000000 +0400
@@ -58,6 +58,11 @@
 	OFFSET(TI_sysenter_return, thread_info, sysenter_return);
 	BLANK();
 
+	OFFSET(GDS_size, Xgt_desc_struct, size);
+	OFFSET(GDS_address, Xgt_desc_struct, address);
+	OFFSET(GDS_pad, Xgt_desc_struct, pad);
+	BLANK();
+
 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
 	OFFSET(RT_SIGFRAME_sigcontext, rt_sigframe, uc.uc_mcontext);
 	BLANK();
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
 

--------------010605080707060505020002--
