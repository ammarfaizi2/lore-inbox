Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWHAMSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWHAMSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 08:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWHAMSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 08:18:44 -0400
Received: from mail.aknet.ru ([82.179.72.26]:9479 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751265AbWHAMSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 08:18:43 -0400
Message-ID: <44CF474C.9070800@aknet.ru>
Date: Tue, 01 Aug 2006 16:21:32 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, 76306.1226@compuserve.com, ak@muc.de, JBeulich@novell.com,
       rohitseth@google.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net> <44CE766D.6000705@vmware.com>
In-Reply-To: <44CE766D.6000705@vmware.com>
Content-Type: multipart/mixed;
 boundary="------------090308050600090707030708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090308050600090707030708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zach and thanks for you really great review!

Zachary Amsden wrote:
> Overall, this looks like a great cleanup.  But I think there are some 
> details with the patch that need fixing.  It is extremely hard to follow 
> the entry.S changes based on patches alone - which tree does this apply 
> cleanly to?
This should cleanly apply to 2.6.18-rc2-mm1.

> I would like to see the final result in entry.S, there are
I'll send it to you privately.

> still some details (dealing with eliminating the push/pop of %eax as a 
> temporary for the segment comparison) which I could not follow exactly 
> in patch format.
The reason for removal was that I also removed the xorl %eax,%eax, decl %eax
stuff from error_code (replaced with $-1, as you've seen), and so preserving
%eax became unnecessary I think.

>> iret_exc:
>> -    TRACE_IRQS_ON
>> -    sti
>>      pushl $0            # no error code
>>      pushl $do_iret_error
>>      jmp error_code
>>  
> Why did you remove the sti here?
Because I simply broke my head over that code. If you say sti should
stay - I beleive you. But please, explain me how it works, before I
went crazy! :)
I read the iret pseudo-code in the Intel manuals carefully. It first
pops the iret frame into temporaries, then checks the values for
validity, and then either faults or writes the values to the real
registers. Now, if we have a bad user's iret frame, the iret will
pop it, raise an exception and push a kernel's iret frame, while
the popped user's frame at that point should be completely lost,
as far as I can understand. Now we go into GPF handler, then to a
fixup, push $0 as an error code, but what iret frame is above that
error code? Where does it come from? Doesn't the iret loses the
user's iret frame completely? Certainly I am missing something obvious
here, but I just can't follow that magic...

> Did you test this with deliberately 
> faulting IRETs?  I think this is a bug.
Yes, I tested that and it works (I have a rather extensive test-suite
for that problem - faulting iret is always tested). But since I
don't understand the magic, I can't say why it works.

>>      pushl %eax; \                     <----
>> -    CFI_ADJUST_CFA_OFFSET 4; \
>> +    lss (%esp), %esp;
> <---- CFI adjustment here is missing.
Well, someone used that macro in a .fixup section, where the
CFI adjustments do not seem to work. But since I don't know
why this was done (Jan?), I reverted that to my original code and
added the adjustments now.

> Bigger problem!  (*!)  It is _unsafe_ to call C-code here.
Ow, holly shit!!! What a disaster... But you are right. Well,
this will make my new patch really big...

> You did not 
> introduce this bug, I just spotted it now, and the old code has the same 
> problem.
You are wrong here - I introduced that bug as the old code is
also mine. Linus attributed it to someone else though, probably
by mistake (or did he just wanted to rescue me from the rant about
that code? :). But it was mine.

> There are two options I see to fixing this problem.  One is to move the 
> GDT fixup code into assembler.  The other is to compile the GDT fixup 
> code in a separate .o file with exactly specified CFLAGS to make sure 
> -fomit-frame-pointer is not passed to it.
Well, unsafe is unsafe. If we can't explicitly tell gcc to prefix the
%ebp accesses with %ds, then I'd better go for an asm version. 

>>      FIXUP_ESPFIX_STACK        # %eax == %esp
>> -    CFI_ADJUST_CFA_OFFSET -20    # the frame has now moved
>> +    CFI_ADJUST_CFA_OFFSET -20
> Is this CFI adjustment still correct?
Hmm, I guess it wasn't correct also before, so I just
left it as is. Should now be fixed. 

>> -    .quad 0x0000920000000000    /* 0xd0 - ESPFIX 16-bit SS */
>> +    .quad 0x00cf92000000ffff    /* 0xd0 - ESPFIX SS */
> Seems a bit dangerous to allow access to full 4GB through this.  Can you 
> tighten the limit any?  I suppose not, because the high bits in %esp 
> really could be anything.  But it might be nice to try setting the limit 
> to regs->esp + THREAD_SIZE.  Of course, this is not strictly necessary, 
> just an extra paranoid protection mechanism.
Since, when calculating the base, I do &-THREAD_SIZE, I guess the minimal
safe limit is regs->esp + THREAD_SIZE*2... Well, may just I not do that please? :)
For what, btw? There are no such a things for __KERNEL_DS or anything, so
I just don't see the necessity.

The new patch is attached. Hopefully I addressed all of your concerns.
Thanks!


--------------090308050600090707030708
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
 

--------------090308050600090707030708--
