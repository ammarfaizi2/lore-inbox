Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936085AbWK1UE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936085AbWK1UE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936088AbWK1UE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:04:59 -0500
Received: from gw.goop.org ([64.81.55.164]:60092 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S936085AbWK1UE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:04:57 -0500
Message-ID: <456C96B8.1040001@goop.org>
Date: Tue, 28 Nov 2006 12:06:16 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Ingo Molnar <mingo@elte.hu>, Eric Dumazet <dada1@cosmosbay.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>,
       Ian Campbell <Ian.Campbell@XenSource.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH] Convert i386 PDA code to use %fs.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts the PDA code to use %fs rather than %gs.  It is patch
to 2.6.19-rc6-mm1, which I think should apply cleanly to Andi's tree as
well.
--

Subject: Convert PDA code to use %fs.

This patch converts the PDA code to use %fs rather than %gs as the
segment for per-processor data.  This is because some processors show
a small but measurable performance gain for reloading a NULL segment
selector (as %fs generally is in user-space) versus a non-NULL one (as
%gs generally is).

On modern processors the difference is very small, perhaps
undetectable.  Some old AMD "K6 3D+" processors are noticably slower
when %fs is used rather than %gs; I have no idea why this might be,
but I think they're sufficiently rare that it doesn't matter much.

This patch also fixes the math emulator, which had not been adjusted
to match the changed struct pt_regs.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Ian Campbell <Ian.Campbell@XenSource.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <andi@muc.de>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>

--
 arch/i386/kernel/asm-offsets.c   |    2 +-
 arch/i386/kernel/cpu/common.c    |   16 ++++++++--------
 arch/i386/kernel/entry.S         |   36 ++++++++++++++++++------------------
 arch/i386/kernel/head.S          |    6 +++---
 arch/i386/kernel/kprobes.c       |    4 ++--
 arch/i386/kernel/process.c       |   26 ++++++++++++--------------
 arch/i386/kernel/ptrace.c        |    8 ++++----
 arch/i386/kernel/signal.c        |   10 +++++-----
 arch/i386/kernel/traps.c         |    7 ++++---
 arch/i386/kernel/vm86.c          |   35 ++++++++++++++++++-----------------
 arch/i386/math-emu/get_address.c |   12 ++++--------
 include/asm-i386/elf.h           |    4 ++--
 include/asm-i386/math_emu.h      |    1 +
 include/asm-i386/mmu_context.h   |    2 +-
 include/asm-i386/pda.h           |   12 ++++++------
 include/asm-i386/processor.h     |    6 +++---
 include/asm-i386/ptrace.h        |    4 ++--
 include/asm-i386/unwind.h        |    2 +-
 18 files changed, 95 insertions(+), 98 deletions(-)

diff -r d86d060c5dc0 arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/asm-offsets.c	Sat Nov 25 08:24:03 2006 -0800
@@ -72,7 +72,7 @@ void foo(void)
 	OFFSET(PT_EAX, pt_regs, eax);
 	OFFSET(PT_DS,  pt_regs, xds);
 	OFFSET(PT_ES,  pt_regs, xes);
-	OFFSET(PT_GS,  pt_regs, xgs);
+	OFFSET(PT_FS,  pt_regs, xfs);
 	OFFSET(PT_ORIG_EAX, pt_regs, orig_eax);
 	OFFSET(PT_EIP, pt_regs, eip);
 	OFFSET(PT_CS,  pt_regs, xcs);
diff -r d86d060c5dc0 arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/cpu/common.c	Sat Nov 25 08:24:03 2006 -0800
@@ -605,7 +605,7 @@ struct pt_regs * __devinit idle_regs(str
 struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
 {
 	memset(regs, 0, sizeof(struct pt_regs));
-	regs->xgs = __KERNEL_PDA;
+	regs->xfs = __KERNEL_PDA;
 	return regs;
 }
 
@@ -662,12 +662,12 @@ struct i386_pda boot_pda = {
 	.pcurrent = &init_task,
 };
 
-static inline void set_kernel_gs(void)
-{
-	/* Set %gs for this CPU's PDA.  Memory clobber is to create a
+static inline void set_kernel_fs(void)
+{
+	/* Set %fs for this CPU's PDA.  Memory clobber is to create a
 	   barrier with respect to any PDA operations, so the compiler
 	   doesn't move any before here. */
-	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA) : "memory");
+	asm volatile ("mov %0, %%fs" : : "r" (__KERNEL_PDA) : "memory");
 }
 
 /* Initialize the CPU's GDT and PDA.  The boot CPU does this for
@@ -721,7 +721,7 @@ static void __cpuinit _cpu_init(int cpu,
 	   the boot CPU, this will transition from the boot gdt+pda to
 	   the real ones). */
 	load_gdt(cpu_gdt_descr);
-	set_kernel_gs();
+	set_kernel_fs();
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
@@ -760,8 +760,8 @@ static void __cpuinit _cpu_init(int cpu,
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 #endif
 
-	/* Clear %fs. */
-	asm volatile ("mov %0, %%fs" : : "r" (0));
+	/* Clear %gs. */
+	asm volatile ("mov %0, %%gs" : : "r" (0));
 
 	/* Clear all 6 debug registers: */
 	set_debugreg(0, 0);
diff -r d86d060c5dc0 arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/entry.S	Sat Nov 25 08:24:03 2006 -0800
@@ -30,7 +30,7 @@
  *	18(%esp) - %eax
  *	1C(%esp) - %ds
  *	20(%esp) - %es
- *	24(%esp) - %gs
+ *	24(%esp) - %fs
  *	28(%esp) - orig_eax
  *	2C(%esp) - %eip
  *	30(%esp) - %cs
@@ -99,9 +99,9 @@ 1:
 
 #define SAVE_ALL \
 	cld; \
-	pushl %gs; \
+	pushl %fs; \
 	CFI_ADJUST_CFA_OFFSET 4;\
-	/*CFI_REL_OFFSET gs, 0;*/\
+	/*CFI_REL_OFFSET fs, 0;*/\
 	pushl %es; \
 	CFI_ADJUST_CFA_OFFSET 4;\
 	/*CFI_REL_OFFSET es, 0;*/\
@@ -133,7 +133,7 @@ 1:
 	movl %edx, %ds; \
 	movl %edx, %es; \
 	movl $(__KERNEL_PDA), %edx; \
-	movl %edx, %gs
+	movl %edx, %fs
 
 #define RESTORE_INT_REGS \
 	popl %ebx;	\
@@ -166,9 +166,9 @@ 2:	popl %es;	\
 2:	popl %es;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
 	/*CFI_RESTORE es;*/\
-3:	popl %gs;	\
+3:	popl %fs;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
-	/*CFI_RESTORE gs;*/\
+	/*CFI_RESTORE fs;*/\
 .pushsection .fixup,"ax";	\
 4:	movl $0,(%esp);	\
 	jmp 1b;		\
@@ -345,11 +345,11 @@ 1:	movl (%ebp),%ebp
 	movl PT_OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
 	TRACE_IRQS_ON
-1:	mov  PT_GS(%esp), %gs
+1:	mov  PT_FS(%esp), %fs
 	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
 .pushsection .fixup,"ax"
-2:	movl $0,PT_GS(%esp)
+2:	movl $0,PT_FS(%esp)
 	jmp 1b
 .section __ex_table,"a"
 	.align 4
@@ -546,7 +546,7 @@ syscall_badsys:
 
 #define FIXUP_ESPFIX_STACK \
 	/* since we are on a wrong stack, we cant make it a C code :( */ \
-	movl %gs:PDA_cpu, %ebx; \
+	movl %fs:PDA_cpu, %ebx; \
 	PER_CPU(cpu_gdt_descr, %ebx); \
 	movl GDS_address(%ebx), %ebx; \
 	GET_DESC_BASE(GDT_ENTRY_ESPFIX_SS, %ebx, %eax, %ax, %al, %ah); \
@@ -628,7 +628,7 @@ KPROBE_ENTRY(page_fault)
 	CFI_ADJUST_CFA_OFFSET 4
 	ALIGN
 error_code:
-	/* the function address is in %gs's slot on the stack */
+	/* the function address is in %fs's slot on the stack */
 	pushl %es
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET es, 0*/
@@ -657,20 +657,20 @@ error_code:
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ebx, 0
 	cld
-	pushl %gs
-	CFI_ADJUST_CFA_OFFSET 4
-	/*CFI_REL_OFFSET gs, 0*/
+	pushl %fs
+	CFI_ADJUST_CFA_OFFSET 4
+	/*CFI_REL_OFFSET fs, 0*/
 	movl $(__KERNEL_PDA), %ecx
-	movl %ecx, %gs
+	movl %ecx, %fs
 	UNWIND_ESPFIX_STACK
 	popl %ecx
 	CFI_ADJUST_CFA_OFFSET -4
 	/*CFI_REGISTER es, ecx*/
-	movl PT_GS(%esp), %edi		# get the function address
+	movl PT_FS(%esp), %edi		# get the function address
 	movl PT_ORIG_EAX(%esp), %edx	# get the error code
 	movl $-1, PT_ORIG_EAX(%esp)	# no syscall to restart
-	mov  %ecx, PT_GS(%esp)
-	/*CFI_REL_OFFSET gs, ES*/
+	mov  %ecx, PT_FS(%esp)
+	/*CFI_REL_OFFSET fs, ES*/
 	movl $(__USER_DS), %ecx
 	movl %ecx, %ds
 	movl %ecx, %es
@@ -995,7 +995,7 @@ ENTRY(arch_unwind_init_running)
 	movl	%ebx, PT_EAX(%edx)
 	movl	$__USER_DS, PT_DS(%edx)
 	movl	$__USER_DS, PT_ES(%edx)
-	movl	$0, PT_GS(%edx)
+	movl	$0, PT_FS(%edx)
 	movl	%ebx, PT_ORIG_EAX(%edx)
 	movl	%ecx, PT_EIP(%edx)
 	movl	12(%esp), %ecx
diff -r d86d060c5dc0 arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/head.S	Sat Nov 25 08:24:03 2006 -0800
@@ -319,12 +319,12 @@ 1:	movl $(__KERNEL_DS),%eax	# reload all
 	movl %eax,%ds
 	movl %eax,%es
 
-	xorl %eax,%eax			# Clear FS and LDT
-	movl %eax,%fs
+	xorl %eax,%eax			# Clear GS and LDT
+	movl %eax,%gs
 	lldt %ax
 
 	movl $(__KERNEL_PDA),%eax
-	mov  %eax,%gs
+	mov  %eax,%fs
 
 	cld			# gcc2 wants the direction flag cleared at all times
 	pushl $0		# fake return address for unwinder
diff -r d86d060c5dc0 arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/kprobes.c	Sat Nov 25 08:24:03 2006 -0800
@@ -363,7 +363,7 @@ no_kprobe:
 			"	pushf\n"
 			/* skip cs, eip, orig_eax */
 			"	subl $12, %esp\n"
-			"	pushl %gs\n"
+			"	pushl %fs\n"
 			"	pushl %ds\n"
 			"	pushl %es\n"
 			"	pushl %eax\n"
@@ -387,7 +387,7 @@ no_kprobe:
 			"	popl %edi\n"
 			"	popl %ebp\n"
 			"	popl %eax\n"
-			/* skip eip, orig_eax, es, ds, gs */
+			/* skip eip, orig_eax, es, ds, fs */
 			"	addl $20, %esp\n"
 			"	popf\n"
 			"	ret\n");
diff -r d86d060c5dc0 arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/process.c	Mon Nov 27 16:18:13 2006 -0800
@@ -305,8 +305,8 @@ void show_regs(struct pt_regs * regs)
 		regs->eax,regs->ebx,regs->ecx,regs->edx);
 	printk("ESI: %08lx EDI: %08lx EBP: %08lx",
 		regs->esi, regs->edi, regs->ebp);
-	printk(" DS: %04x ES: %04x GS: %04x\n",
-	       0xffff & regs->xds,0xffff & regs->xes, 0xffff & regs->xgs);
+	printk(" DS: %04x ES: %04x FS: %04x\n",
+	       0xffff & regs->xds,0xffff & regs->xes, 0xffff & regs->xfs);
 
 	cr0 = read_cr0();
 	cr2 = read_cr2();
@@ -337,7 +337,7 @@ int kernel_thread(int (*fn)(void *), voi
 
 	regs.xds = __USER_DS;
 	regs.xes = __USER_DS;
-	regs.xgs = __KERNEL_PDA;
+	regs.xfs = __KERNEL_PDA;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
 	regs.xcs = __KERNEL_CS | get_kernel_rpl();
@@ -422,7 +422,7 @@ int copy_thread(int nr, unsigned long cl
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 
-	savesegment(fs,p->thread.fs);
+	savesegment(gs,p->thread.gs);
 
 	tsk = current;
 	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
@@ -498,8 +498,8 @@ void dump_thread(struct pt_regs * regs, 
 	dump->regs.eax = regs->eax;
 	dump->regs.ds = regs->xds;
 	dump->regs.es = regs->xes;
-	savesegment(fs,dump->regs.fs);
-	dump->regs.gs = regs->xgs;
+	dump->regs.fs = regs->xfs;
+	savesegment(gs,dump->regs.gs);
 	dump->regs.orig_eax = regs->orig_eax;
 	dump->regs.eip = regs->eip;
 	dump->regs.cs = regs->xcs;
@@ -650,7 +650,7 @@ struct task_struct fastcall * __switch_t
 	load_esp0(tss, next);
 
 	/*
-	 * Save away %fs. No need to save %gs, as it was saved on the
+	 * Save away %gs. No need to save %fs, as it was saved on the
 	 * stack on entry.  No need to save %es and %ds, as those are
 	 * always kernel segments while inside the kernel.  Doing this
 	 * before setting the new TLS descriptors avoids the situation
@@ -659,7 +659,7 @@ struct task_struct fastcall * __switch_t
 	 * used %fs or %gs (it does not today), or if the kernel is
 	 * running inside of a hypervisor layer.
 	 */
-	savesegment(fs, prev->fs);
+	savesegment(gs, prev->gs);
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
@@ -667,12 +667,10 @@ struct task_struct fastcall * __switch_t
 	load_TLS(next, cpu);
 
 	/*
-	 * Restore %fs if needed.
-	 *
-	 * Glibc normally makes %fs be zero.
-	 */
-	if (unlikely(prev->fs | next->fs))
-		loadsegment(fs, next->fs);
+	 * Restore %gs if needed (which is common)
+	 */
+	if (prev->gs | next->gs)
+		loadsegment(gs, next->gs);
 
 	write_pda(pcurrent, next_p);
 
diff -r d86d060c5dc0 arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/ptrace.c	Sat Nov 25 08:24:04 2006 -0800
@@ -112,7 +112,7 @@ static int putreg(struct task_struct *ch
 			value |= get_stack_long(child, EFL_OFFSET) & ~FLAG_MASK;
 			break;
 	}
-	if (regno > ES*4)
+	if (regno > FS*4)
 		regno -= 1*4;
 	put_stack_long(child, regno - sizeof(struct pt_regs), value);
 	return 0;
@@ -124,18 +124,18 @@ static unsigned long getreg(struct task_
 	unsigned long retval = ~0UL;
 
 	switch (regno >> 2) {
-		case FS:
+		case GS:
 			retval = child->thread.fs;
 			break;
 		case DS:
 		case ES:
-		case GS:
+		case FS:
 		case SS:
 		case CS:
 			retval = 0xffff;
 			/* fall through */
 		default:
-			if (regno > ES*4)
+			if (regno > FS*4)
 				regno -= 1*4;
 			regno = regno - sizeof(struct pt_regs);
 			retval &= get_stack_long(child, regno);
diff -r d86d060c5dc0 arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/signal.c	Sat Nov 25 08:24:04 2006 -0800
@@ -128,8 +128,8 @@ restore_sigcontext(struct pt_regs *regs,
 			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
 			 X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_CF)
 
-	COPY_SEG(gs);
-	GET_SEG(fs);
+	GET_SEG(gs);
+	COPY_SEG(fs);
 	COPY_SEG(es);
 	COPY_SEG(ds);
 	COPY(edi);
@@ -244,9 +244,9 @@ setup_sigcontext(struct sigcontext __use
 {
 	int tmp, err = 0;
 
-	err |= __put_user(regs->xgs, (unsigned int __user *)&sc->gs);
-	savesegment(fs, tmp);
-	err |= __put_user(tmp, (unsigned int __user *)&sc->fs);
+	err |= __put_user(regs->xfs, (unsigned int __user *)&sc->fs);
+	savesegment(gs, tmp);
+	err |= __put_user(tmp, (unsigned int __user *)&sc->gs);
 
 	err |= __put_user(regs->xes, (unsigned int __user *)&sc->es);
 	err |= __put_user(regs->xds, (unsigned int __user *)&sc->ds);
diff -r d86d060c5dc0 arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/traps.c	Mon Nov 27 15:58:20 2006 -0800
@@ -350,10 +350,11 @@ void show_registers(struct pt_regs *regs
 	int i;
 	int in_kernel = 1;
 	unsigned long esp;
-	unsigned short ss;
+	unsigned short ss, gs;
 
 	esp = (unsigned long) (&regs->esp);
 	savesegment(ss, ss);
+	savesegment(gs, gs);
 	if (user_mode_vm(regs)) {
 		in_kernel = 0;
 		esp = regs->esp;
@@ -372,8 +373,8 @@ void show_registers(struct pt_regs *regs
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
 	printk(KERN_EMERG "esi: %08lx   edi: %08lx   ebp: %08lx   esp: %08lx\n",
 		regs->esi, regs->edi, regs->ebp, esp);
-	printk(KERN_EMERG "ds: %04x   es: %04x   ss: %04x\n",
-		regs->xds & 0xffff, regs->xes & 0xffff, ss);
+	printk(KERN_EMERG "ds: %04x   es: %04x   fs: %04x  gs: %04x  ss: %04x\n",
+	       regs->xds & 0xffff, regs->xes & 0xffff, regs->xfs & 0xffff, gs, ss);
 	printk(KERN_EMERG "Process %.*s (pid: %d, ti=%p task=%p task.ti=%p)",
 		TASK_COMM_LEN, current->comm, current->pid,
 		current_thread_info(), current, current->thread_info);
diff -r d86d060c5dc0 arch/i386/kernel/vm86.c
--- a/arch/i386/kernel/vm86.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/kernel/vm86.c	Mon Nov 27 11:38:10 2006 -0800
@@ -96,12 +96,12 @@ static int copy_vm86_regs_to_user(struct
 {
 	int ret = 0;
 
-	/* kernel_vm86_regs is missing xfs, so copy everything up to
-	   (but not including) xgs, and then rest after xgs. */
-	ret += copy_to_user(user, regs, offsetof(struct kernel_vm86_regs, pt.xgs));
-	ret += copy_to_user(&user->__null_gs, &regs->pt.xgs,
+	/* kernel_vm86_regs is missing xgs, so copy everything up to
+	   (but not including) orig_eax, and then rest including orig_eax. */
+	ret += copy_to_user(user, regs, offsetof(struct kernel_vm86_regs, pt.orig_eax));
+	ret += copy_to_user(&user->orig_eax, &regs->pt.orig_eax,
 			    sizeof(struct kernel_vm86_regs) -
-			    offsetof(struct kernel_vm86_regs, pt.xgs));
+			    offsetof(struct kernel_vm86_regs, pt.orig_eax));
 
 	return ret;
 }
@@ -113,12 +113,13 @@ static int copy_vm86_regs_from_user(stru
 {
 	int ret = 0;
 
-	ret += copy_from_user(regs, user, offsetof(struct kernel_vm86_regs, pt.xgs));
-	ret += copy_from_user(&regs->pt.xgs, &user->__null_gs,
+	/* copy eax-xfs inclusive */
+	ret += copy_from_user(regs, user, offsetof(struct kernel_vm86_regs, pt.orig_eax));
+	/* copy orig_eax-__gsh+extra */
+	ret += copy_from_user(&regs->pt.orig_eax, &user->orig_eax,
 			      sizeof(struct kernel_vm86_regs) -
-			      offsetof(struct kernel_vm86_regs, pt.xgs) +
+			      offsetof(struct kernel_vm86_regs, pt.orig_eax) +
 			      extra);
-
 	return ret;
 }
 
@@ -157,8 +158,8 @@ struct pt_regs * fastcall save_v86_state
 
 	ret = KVM86->regs32;
 
-	loadsegment(fs, current->thread.saved_fs);
-	ret->xgs = current->thread.saved_gs;
+	ret->xfs = current->thread.saved_fs;
+	loadsegment(gs, current->thread.saved_gs);
 
 	return ret;
 }
@@ -285,9 +286,9 @@ static void do_sys_vm86(struct kernel_vm
  */
 	info->regs.pt.xds = 0;
 	info->regs.pt.xes = 0;
-	info->regs.pt.xgs = 0;
-
-/* we are clearing fs later just before "jmp resume_userspace",
+	info->regs.pt.xfs = 0;
+
+/* we are clearing gs later just before "jmp resume_userspace",
  * because it is not saved/restored.
  */
 
@@ -321,8 +322,8 @@ static void do_sys_vm86(struct kernel_vm
  */
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
-	savesegment(fs, tsk->thread.saved_fs);
-	tsk->thread.saved_gs = info->regs32->xgs;
+	tsk->thread.saved_fs = info->regs32->xfs;
+	savesegment(gs, tsk->thread.saved_gs);
 
 	tss = &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
@@ -342,7 +343,7 @@ static void do_sys_vm86(struct kernel_vm
 	__asm__ __volatile__(
 		"movl %0,%%esp\n\t"
 		"movl %1,%%ebp\n\t"
-		"mov  %2, %%fs\n\t"
+		"mov  %2, %%gs\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
 		:"r" (&info->regs), "r" (task_thread_info(tsk)), "r" (0));
diff -r d86d060c5dc0 arch/i386/math-emu/get_address.c
--- a/arch/i386/math-emu/get_address.c	Fri Nov 24 17:00:00 2006 -0800
+++ b/arch/i386/math-emu/get_address.c	Mon Nov 27 16:26:37 2006 -0800
@@ -56,15 +56,14 @@ static int reg_offset_vm86[] = {
 #define VM86_REG_(x) (*(unsigned short *) \
 		      (reg_offset_vm86[((unsigned)x)]+(u_char *) FPU_info))
 
-/* These are dummy, fs and gs are not saved on the stack. */
-#define ___FS ___ds
+/* This dummy, gs is not saved on the stack. */
 #define ___GS ___ds
 
 static int reg_offset_pm[] = {
 	offsetof(struct info,___cs),
 	offsetof(struct info,___ds),
 	offsetof(struct info,___es),
-	offsetof(struct info,___FS),
+	offsetof(struct info,___fs),
 	offsetof(struct info,___GS),
 	offsetof(struct info,___ss),
 	offsetof(struct info,___ds)
@@ -169,14 +168,11 @@ static long pm_address(u_char FPU_modrm,
 
   switch ( segment )
     {
-      /* fs and gs aren't used by the kernel, so they still have their
-	 user-space values. */
+      /* gs isn't used by the kernel, so it still has its
+	 user-space value. */
     case PREFIX_FS_-1:
       /* N.B. - movl %seg, mem is a 2 byte write regardless of prefix */
       savesegment(fs, addr->selector);
-      break;
-    case PREFIX_GS_-1:
-      savesegment(gs, addr->selector);
       break;
     default:
       addr->selector = PM_REG_(segment);
diff -r d86d060c5dc0 include/asm-i386/elf.h
--- a/include/asm-i386/elf.h	Fri Nov 24 17:00:00 2006 -0800
+++ b/include/asm-i386/elf.h	Sat Nov 25 08:24:04 2006 -0800
@@ -90,8 +90,8 @@ typedef struct user_fxsr_struct elf_fpxr
 	pr_reg[6] = regs->eax;				\
 	pr_reg[7] = regs->xds;				\
 	pr_reg[8] = regs->xes;				\
-	savesegment(fs,pr_reg[9]);			\
-	pr_reg[10] = regs->xgs;				\
+	pr_reg[9] = regs->xfs;				\
+	savesegment(gs,pr_reg[10]);			\
 	pr_reg[11] = regs->orig_eax;			\
 	pr_reg[12] = regs->eip;				\
 	pr_reg[13] = regs->xcs;				\
diff -r d86d060c5dc0 include/asm-i386/math_emu.h
--- a/include/asm-i386/math_emu.h	Fri Nov 24 17:00:00 2006 -0800
+++ b/include/asm-i386/math_emu.h	Mon Nov 27 16:29:28 2006 -0800
@@ -21,6 +21,7 @@ struct info {
 	long ___eax;
 	long ___ds;
 	long ___es;
+	long ___fs;
 	long ___orig_eax;
 	long ___eip;
 	long ___cs;
diff -r d86d060c5dc0 include/asm-i386/mmu_context.h
--- a/include/asm-i386/mmu_context.h	Fri Nov 24 17:00:00 2006 -0800
+++ b/include/asm-i386/mmu_context.h	Sat Nov 25 08:24:04 2006 -0800
@@ -63,7 +63,7 @@ static inline void switch_mm(struct mm_s
 }
 
 #define deactivate_mm(tsk, mm)			\
-	asm("movl %0,%%fs": :"r" (0));
+	asm("movl %0,%%gs": :"r" (0));
 
 #define activate_mm(prev, next) \
 	switch_mm((prev),(next),NULL)
diff -r d86d060c5dc0 include/asm-i386/pda.h
--- a/include/asm-i386/pda.h	Fri Nov 24 17:00:00 2006 -0800
+++ b/include/asm-i386/pda.h	Sat Nov 25 08:24:04 2006 -0800
@@ -39,19 +39,19 @@ extern struct i386_pda _proxy_pda;
 		if (0) { T__ tmp__; tmp__ = (val); }			\
 		switch (sizeof(_proxy_pda.field)) {			\
 		case 1:							\
-			asm(op "b %1,%%gs:%c2"				\
+			asm(op "b %1,%%fs:%c2"				\
 			    : "+m" (_proxy_pda.field)			\
 			    :"ri" ((T__)val),				\
 			     "i"(pda_offset(field)));			\
 			break;						\
 		case 2:							\
-			asm(op "w %1,%%gs:%c2"				\
+			asm(op "w %1,%%fs:%c2"				\
 			    : "+m" (_proxy_pda.field)			\
 			    :"ri" ((T__)val),				\
 			     "i"(pda_offset(field)));			\
 			break;						\
 		case 4:							\
-			asm(op "l %1,%%gs:%c2"				\
+			asm(op "l %1,%%fs:%c2"				\
 			    : "+m" (_proxy_pda.field)			\
 			    :"ri" ((T__)val),				\
 			     "i"(pda_offset(field)));			\
@@ -65,19 +65,19 @@ extern struct i386_pda _proxy_pda;
 		typeof(_proxy_pda.field) ret__;				\
 		switch (sizeof(_proxy_pda.field)) {			\
 		case 1:							\
-			asm(op "b %%gs:%c1,%0"				\
+			asm(op "b %%fs:%c1,%0"				\
 			    : "=r" (ret__)				\
 			    : "i" (pda_offset(field)),			\
 			      "m" (_proxy_pda.field));			\
 			break;						\
 		case 2:							\
-			asm(op "w %%gs:%c1,%0"				\
+			asm(op "w %%fs:%c1,%0"				\
 			    : "=r" (ret__)				\
 			    : "i" (pda_offset(field)),			\
 			      "m" (_proxy_pda.field));			\
 			break;						\
 		case 4:							\
-			asm(op "l %%gs:%c1,%0"				\
+			asm(op "l %%fs:%c1,%0"				\
 			    : "=r" (ret__)				\
 			    : "i" (pda_offset(field)),			\
 			      "m" (_proxy_pda.field));			\
diff -r d86d060c5dc0 include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Fri Nov 24 17:00:00 2006 -0800
+++ b/include/asm-i386/processor.h	Sat Nov 25 08:24:04 2006 -0800
@@ -424,7 +424,7 @@ struct thread_struct {
 	.vm86_info = NULL,						\
 	.sysenter_cs = __KERNEL_CS,					\
 	.io_bitmap_ptr = NULL,						\
-	.gs = __KERNEL_PDA,						\
+	.fs = __KERNEL_PDA,						\
 }
 
 /*
@@ -442,8 +442,8 @@ struct thread_struct {
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\
-	__asm__("movl %0,%%fs": :"r" (0));			\
-	regs->xgs = 0;						\
+	__asm__("movl %0,%%gs": :"r" (0));			\
+	regs->xfs = 0;						\
 	set_fs(USER_DS);					\
 	regs->xds = __USER_DS;					\
 	regs->xes = __USER_DS;					\
diff -r d86d060c5dc0 include/asm-i386/ptrace.h
--- a/include/asm-i386/ptrace.h	Fri Nov 24 17:00:00 2006 -0800
+++ b/include/asm-i386/ptrace.h	Sat Nov 25 08:24:04 2006 -0800
@@ -16,8 +16,8 @@ struct pt_regs {
 	long eax;
 	int  xds;
 	int  xes;
-	/* int  xfs; */
-	int  xgs;
+	int  xfs;
+	/* int  xgs; */
 	long orig_eax;
 	long eip;
 	int  xcs;
diff -r d86d060c5dc0 include/asm-i386/unwind.h
--- a/include/asm-i386/unwind.h	Fri Nov 24 17:00:00 2006 -0800
+++ b/include/asm-i386/unwind.h	Sat Nov 25 08:24:04 2006 -0800
@@ -71,7 +71,7 @@ static inline void arch_unw_init_blocked
 	info->regs.xss = __KERNEL_DS;
 	info->regs.xds = __USER_DS;
 	info->regs.xes = __USER_DS;
-	info->regs.xgs = __KERNEL_PDA;
+	info->regs.xfs = __KERNEL_PDA;
 }
 
 extern asmlinkage int arch_unwind_init_running(struct unwind_frame_info *,

