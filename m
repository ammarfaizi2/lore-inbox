Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVBXAoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVBXAoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVBXAIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:08:35 -0500
Received: from mail.timesys.com ([65.117.135.102]:64691 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261723AbVBWX5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:57:04 -0500
Message-ID: <421D175A.2010804@timesys.com>
Date: Wed, 23 Feb 2005 18:52:58 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       john cooper <john.cooper@timesys.com>,
       "Saksena, Manas" <Manas.Saksena@timesys.com>
Subject: PPC RT Patch..
References: <1109182061.16201.6.camel@krustophenia.net>	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>	 <1109187381.3174.5.camel@krustophenia.net>	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>	 <1109190614.3126.1.camel@krustophenia.net>	 <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com> <1109196876.4009.3.camel@krustophenia.net>
In-Reply-To: <1109196876.4009.3.camel@krustophenia.net>
Content-Type: multipart/mixed;
 boundary="------------040902020302020909030302"
X-OriginalArrivalTime: 23 Feb 2005 23:54:46.0500 (UTC) FILETIME=[0D94B240:01C51A03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040902020302020909030302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo,
     We've had a PPC port of your RT work underway with
a focus on trace instrumentation.  This is based upon
realtime-preempt-2.6.11-rc2-V0.7.37-02.  A diff is
attached.

To the extent possible the tracing facilities are the
same as your x86 work.  In the process a few PPC/gcc
issues needed to be resolved.  There is also a bug fix
contained for tlb_gather_mmu() which was causing debug
assertions to be generated in a path which attempted to
sleep with a non-zero preempt count.

This does build and function when SMP is configured,
though we have not yet verified it on other than a
uniprocessor.  As a simplifying assumption, testing has
thus far concentrated on the following modes:

PREEMPT_NONE
     - verify baseline regression

PREEMPT_RT && !PREEMPT_SMP
     - typical for an embedded RT PPC application

PREEMPT_RT && PREEMPT_SMP
     - kicks in live locking code which otherwise receives no
     coverage.  This is functionally equivalent to the above
     config on a single CPU target thus no MP dynamic testing
     is achieved.  Still quite useful IMHO.

The target used for development/testing is an Ampro EnCore PP1
which sports a 300Mhz MPC8245.  For testing this boots with NFS
as root.  An mp3 decode at nice --20 is launched which requires
just under 20% of the CPU to maintain an uninterrupted audio
decode and output.  To this a series of "du -s /" are launched
to soak up excess CPU bandwidth.  Perhaps not rigorous but a
fair sanity check and load for the purpose at hand.

Under these conditions maximum scheduling latencies are seen in
the 120-150us range.  Note no attempt has yet been made to
optimize arch specific paths and full trace instrumentation has
been enabled.

I've written some logging code to help find problems such as
the tlb issue above.  As it has not been made general I've
removed it from this patch.  At some point I'll likely revisit
this.

Comments/suggestions welcome.

-john


-- 
john.cooper@timesys.com

--------------040902020302020909030302
Content-Type: text/plain;
 name="realtime-preempt-2.6.11-rc2-V0.7.37-02-ppc"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="realtime-preempt-2.6.11-rc2-V0.7.37-02-ppc"

--- ./arch/ppc/syslib/i8259.c.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/syslib/i8259.c	2005-02-10 12:57:45.000000000 -0500
@@ -10,7 +10,7 @@ unsigned char cached_8259[2] = { 0xff, 0
 #define cached_A1 (cached_8259[0])
 #define cached_21 (cached_8259[1])
 
-static DEFINE_SPINLOCK(i8259_lock);
+static DEFINE_RAW_SPINLOCK(i8259_lock);
 
 int i8259_pic_irq_offset;
 
=================================================================
--- ./arch/ppc/syslib/ocp.c.ORG	2004-12-24 16:35:23.000000000 -0500
+++ ./arch/ppc/syslib/ocp.c	2005-02-23 16:51:04.009548560 -0500
@@ -49,7 +49,6 @@
 #include <asm/io.h>
 #include <asm/ocp.h>
 #include <asm/errno.h>
-#include <asm/rwsem.h>
 #include <asm/semaphore.h>
 
 //#define DBG(x)	printk x
=================================================================
--- ./arch/ppc/kernel/Makefile.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/kernel/Makefile	2005-02-18 20:34:07.000000000 -0500
@@ -13,7 +13,7 @@ extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
-					semaphore.o syscalls.o setup.o \
+					syscalls.o setup.o \
 					cputable.o ppc_htab.o perfmon.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
@@ -26,6 +26,9 @@ obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 obj-$(CONFIG_FSL_BOOKE)		+= perfmon_fsl_booke.o
 
+obj-$(CONFIG_ASM_SEMAPHORES)	+= semaphore.o
+obj-$(CONFIG_MCOUNT)		+= mcount.o
+
 ifndef CONFIG_MATH_EMULATION
 obj-$(CONFIG_8xx)		+= softemu8xx.o
 endif
=================================================================
--- ./arch/ppc/kernel/signal.c.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/kernel/signal.c	2005-02-09 19:16:25.000000000 -0500
@@ -704,6 +704,13 @@ int do_signal(sigset_t *oldset, struct p
 	unsigned long frame, newsp;
 	int signr, ret;
 
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Fully-preemptible kernel does not need interrupts disabled:
+	 */
+	local_irq_enable();
+	preempt_check_resched();
+#endif
 	if (!oldset)
 		oldset = &current->blocked;
 
=================================================================
--- ./arch/ppc/kernel/time.c.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/kernel/time.c	2005-02-19 10:46:17.000000000 -0500
@@ -91,7 +91,7 @@ extern unsigned long wall_jiffies;
 
 static long time_offset;
 
-DEFINE_SPINLOCK(rtc_lock);
+DEFINE_RAW_SPINLOCK(rtc_lock);
 
 EXPORT_SYMBOL(rtc_lock);
 
@@ -109,7 +109,7 @@ static inline int tb_delta(unsigned *jif
 }
 
 #ifdef CONFIG_SMP
-unsigned long profile_pc(struct pt_regs *regs)
+unsigned long notrace profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
 
@@ -126,7 +126,7 @@ EXPORT_SYMBOL(profile_pc);
  * with interrupts disabled.
  * We set it up to overflow again in 1/HZ seconds.
  */
-void timer_interrupt(struct pt_regs * regs)
+void notrace timer_interrupt(struct pt_regs * regs)
 {
 	int next_dec;
 	unsigned long cpu = smp_processor_id();
=================================================================
--- ./arch/ppc/kernel/traps.c.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/kernel/traps.c	2005-02-09 18:59:40.000000000 -0500
@@ -72,7 +72,7 @@ void (*debugger_fault_handler)(struct pt
  * Trap & Exception support
  */
 
-DEFINE_SPINLOCK(die_lock);
+DEFINE_RAW_SPINLOCK(die_lock);
 
 void die(const char * str, struct pt_regs * fp, long err)
 {
@@ -111,6 +111,10 @@ void _exception(int signr, struct pt_reg
 		debugger(regs);
 		die("Exception in kernel mode", regs, signr);
 	}
+#ifdef CONFIG_PREEMPT_RT
+	local_irq_enable();
+	preempt_check_resched();
+#endif
 	info.si_signo = signr;
 	info.si_errno = 0;
 	info.si_code = code;
=================================================================
--- ./arch/ppc/kernel/ppc_ksyms.c.ORG	2004-12-24 16:35:28.000000000 -0500
+++ ./arch/ppc/kernel/ppc_ksyms.c	2005-02-08 12:00:56.000000000 -0500
@@ -294,9 +294,11 @@ EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(xmon);
 EXPORT_SYMBOL(xmon_printf);
 #endif
+#ifdef CONFIG_ASM_SEMAPHORES
 EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(__down);
 EXPORT_SYMBOL(__down_interruptible);
+#endif
 
 #if defined(CONFIG_KGDB) || defined(CONFIG_XMON)
 extern void (*debugger)(struct pt_regs *regs);
=================================================================
--- ./arch/ppc/kernel/entry.S.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/kernel/entry.S	2005-02-23 16:30:55.924205448 -0500
@@ -8,6 +8,7 @@
  *  rewritten by Paul Mackerras.
  *    Copyright (C) 1996 Paul Mackerras.
  *  MPC8xx modifications Copyright (C) 1997 Dan Malek (dmalek@jlc.net).
+ *  RT_PREEMPT support (C) Timesys Corp.  <john.cooper@timesys.com>
  *
  *  This file contains the system call entry code, context switch
  *  code, and exception/interrupt return code for PowerPC.
@@ -44,6 +45,48 @@
 #define LOAD_MSR_KERNEL(r, x)	li r,(x)
 #endif
 
+#if defined(CONFIG_LATENCY_TRACE) || defined(CONFIG_CRITICAL_IRQSOFF_TIMING) \
+    || defined(CONFIG_CRITICAL_TIMING)
+#define TFSIZE 64	/* frame SHDB multiple of 16 bytes */
+#define TFR12 48	/* TODO: prune this down -- safe but overkill */
+#define TFR11 44
+#define TFR10 40
+#define TFR9 36
+#define TFR8 32
+#define TFR7 28
+#define TFR6 24
+#define TFR5 20
+#define TFR4 16
+#define TFR3 12
+#define TFR0 8
+#define PUSHFRAME() \
+	stwu	r1, -TFSIZE(r1); \
+	stw	r12, TFR12(r1); \
+	stw	r11, TFR11(r1); \
+	stw	r10, TFR10(r1); \
+	stw	r9, TFR9(r1); \
+	stw	r8, TFR8(r1); \
+	stw	r7, TFR7(r1); \
+	stw	r6, TFR6(r1); \
+	stw	r5, TFR5(r1); \
+	stw	r4, TFR4(r1); \
+	stw	r3, TFR3(r1); \
+	stw	r0, TFR0(r1)
+#define POPFRAME() \
+	lwz	r12, TFR12(r1); \
+	lwz	r11, TFR11(r1); \
+	lwz	r10, TFR10(r1); \
+	lwz	r9, TFR9(r1); \
+	lwz	r8, TFR8(r1); \
+	lwz	r7, TFR7(r1); \
+	lwz	r6, TFR6(r1); \
+	lwz	r5, TFR5(r1); \
+	lwz	r4, TFR4(r1); \
+	lwz	r3, TFR3(r1); \
+	lwz	r0, TFR0(r1); \
+	addi	r1, r1, TFSIZE
+#endif
+
 #ifdef CONFIG_BOOKE
 #define	COR	r8	/* Critical Offset Register (COR) */
 #define BOOKE_LOAD_COR	lis COR,crit_save@ha
@@ -197,6 +240,20 @@ _GLOBAL(DoSyscall)
 	lwz	r11,_CCR(r1)	/* Clear SO bit in CR */
 	rlwinm	r11,r11,0,4,2
 	stw	r11,_CCR(r1)
+#ifdef CONFIG_LATENCY_TRACE
+	lwz	r3,GPR0(r1)
+	lwz	r4,GPR3(r1)
+	lwz	r5,GPR4(r1)
+	lwz	r6,GPR5(r1)
+	bl	sys_call
+	lwz	r0,GPR0(r1)
+	lwz	r3,GPR3(r1)
+	lwz	r4,GPR4(r1)
+	lwz	r5,GPR5(r1)
+	lwz	r6,GPR6(r1)
+	lwz	r7,GPR7(r1)
+	lwz	r8,GPR8(r1)
+#endif
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
@@ -250,6 +307,21 @@ syscall_exit_cont:
 	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_dbcr0
 #endif
+#if defined(CONFIG_LATENCY_TRACE) || defined(CONFIG_CRITICAL_IRQSOFF_TIMING) \
+    || defined(CONFIG_CRITICAL_TIMING)
+	PUSHFRAME();
+#ifdef CONFIG_CRITICAL_TIMING
+	bl	touch_critical_timing
+#endif
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+	bl	trace_irqs_on
+#endif
+#ifdef CONFIG_LATENCY_TRACE
+	lwz	r3, RESULT+TFSIZE(r1)
+	bl	sys_ret
+#endif
+	POPFRAME();
+#endif
 	stwcx.	r0,0,r1			/* to clear the reservation */
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
@@ -614,32 +686,38 @@ restore_user:
 
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
+	lis	r9,kernel_preemption@ha
+	lwz	r9,kernel_preemption@l(r9)
+	cmpwi	0,r9,0
+	beq	restore
 	/* check current_thread_info->preempt_count */
 	rlwinm	r9,r1,0,0,18
 	lwz	r0,TI_PREEMPT(r9)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
+check_resched:
 	lwz	r0,TI_FLAGS(r9)
 	andi.	r0,r0,_TIF_NEED_RESCHED
 	beq+	restore
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
 	beq	restore		/* don't schedule if so */
-1:	lis	r0,PREEMPT_ACTIVE@h
-	stw	r0,TI_PREEMPT(r9)
+1:
 	ori	r10,r10,MSR_EE
-	SYNC
-	MTMSRD(r10)		/* hard-enable interrupts */
-	bl	schedule
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
+	bl	preempt_schedule_irq
 	rlwinm	r9,r1,0,0,18
 	li	r0,0
 	stw	r0,TI_PREEMPT(r9)
+#if 0
 	lwz	r3,TI_FLAGS(r9)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
 #else
+	b	check_resched
+#endif
+#else
 resume_kernel:
 #endif /* CONFIG_PREEMPT */
 
=================================================================
--- ./arch/ppc/kernel/process.c.ORG	2004-12-24 16:34:45.000000000 -0500
+++ ./arch/ppc/kernel/process.c	2005-02-09 18:43:14.000000000 -0500
@@ -360,6 +360,7 @@ void show_regs(struct pt_regs * regs)
 	print_symbol("%s\n", regs->nip);
 	printk("LR [%08lx] ", regs->link);
 	print_symbol("%s\n", regs->link);
+	printk("preempt: %08x\n", preempt_count());
 #endif
 	show_stack(current, (unsigned long *) regs->gpr[1]);
 }
=================================================================
--- ./arch/ppc/kernel/mcount.S.ORG	2005-02-18 19:51:33.000000000 -0500
+++ ./arch/ppc/kernel/mcount.S	2005-02-23 14:25:18.780025528 -0500
@@ -0,0 +1,86 @@
+/*
+ *  linux/arch/ppc/kernel/mcount.S
+ *
+ *  Copyright (C) 2005 TimeSys Corporation, john.cooper@timesys.com
+ */
+
+#include <asm/ppc_asm.h>
+
+/*
+ * stack frame in effect when calling __mcount():
+ *
+ *	52: RA to caller
+ *	48: caller chain
+ *	44: [alignment pad]
+ *	40: saved LR to prolog/target function
+ *	36: r10
+ *	32: r9
+ *	28: r8
+ *	24: r7
+ *	20: r6
+ *	16: r5
+ *	12: r4
+ *	 8: r3
+ *	 4: LR save for __mcount() use
+ *	 0: frame chain pointer / current r1
+ */
+
+/* preamble present in each traced function:
+ *
+ *	.data
+ *	.align	2
+ * 0:
+ *	.long	0
+ *	.previous
+ *	mflr	r0
+ *	lis	r11, 0b@ha
+ *	stw	r0, 4(r1)
+ *	addi	r0, r11, 0b@l
+ *	bl	_mcount
+ */
+
+	.text
+.globl _mcount
+_mcount:
+	lis	r11,mcount_enabled@ha
+	lwz	r11,mcount_enabled@l(r11)
+	cmpwi	0,r11,0
+	beq	disabled
+	stwu	r1,-48(r1)	/* local frame */
+	stw	r3, 8(r1)
+	stw	r4, 12(r1)
+	stw	r5, 16(r1)
+	stw	r6, 20(r1)
+	mflr	r4		/* RA to function prolog */
+	stw	r7, 24(r1)
+	stw	r8, 28(r1)
+	stw	r9, 32(r1)
+	stw	r10,36(r1)
+	stw	r4, 40(r1)
+	bl	__mcount	/* __void mcount(void) */
+	nop
+	lwz	r0, 40(r1)
+	lwz	r3, 8(r1)
+	mtctr	r0
+	lwz	r4, 12(r1)
+	lwz	r5, 16(r1)
+	lwz	r6, 20(r1)
+	lwz	r0, 52(r1)	/* RA to function caller */
+	lwz	r7, 24(r1)
+	lwz	r8, 28(r1)
+	mtlr	r0
+	lwz	r9, 32(r1)
+	lwz	r10,36(r1)
+	addi	r1,r1,48	/* toss frame */
+	bctr			/* return to target function */
+
+/* the function preamble modified LR in getting here so we need
+ * to restore its LR and return to the preamble otherwise
+ */
+disabled:
+        mflr    r12             /* return address to preamble */
+        lwz     r11, 4(r1)
+        mtlr    r11             /* restore LR modified by preamble */
+        mtctr   r12
+        bctr
+
=================================================================
--- ./arch/ppc/kernel/smp.c.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/kernel/smp.c	2005-02-22 10:21:39.000000000 -0500
@@ -163,7 +163,7 @@ void smp_send_stop(void)
  * static memory requirements. It also looks cleaner.
  * Stolen from the i386 version.
  */
-static DEFINE_SPINLOCK(call_lock);
+static DEFINE_RAW_SPINLOCK(call_lock);
 
 static struct call_data_struct {
 	void (*func) (void *info);
@@ -397,5 +397,15 @@ int __cpu_up(unsigned int cpu)
 
 void smp_cpus_done(unsigned int max_cpus)
 {
-	smp_ops->setup_cpu(0);
+	if (smp_ops)
+		smp_ops->setup_cpu(0);
+}
+
+/* this function sends a 'reschedule' IPI to all other CPUs.
+ * This is used when RT tasks are starving and other CPUs
+ * might be able to run them
+ */
+void smp_send_reschedule_allbutself(void)
+{
+	smp_message_pass(MSG_ALL_BUT_SELF, PPC_MSG_RESCHEDULE, 0, 0);
 }
=================================================================
--- ./arch/ppc/kernel/irq.c.ORG	2004-12-24 16:35:24.000000000 -0500
+++ ./arch/ppc/kernel/irq.c	2005-02-19 21:43:53.000000000 -0500
@@ -135,10 +135,11 @@ skip:
 	return 0;
 }
 
-void do_IRQ(struct pt_regs *regs)
+void notrace do_IRQ(struct pt_regs *regs)
 {
 	int irq, first = 1;
         irq_enter();
+	trace_special(regs->nip, irq, 0);
 
 	/*
 	 * Every platform is required to implement ppc_md.get_irq.
=================================================================
--- ./arch/ppc/kernel/idle.c.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/kernel/idle.c	2005-02-23 13:02:34.000000000 -0500
@@ -39,6 +39,7 @@ void default_idle(void)
 	powersave = ppc_md.power_save;
 
 	if (!need_resched()) {
+		stop_critical_timing();
 		if (powersave != NULL)
 			powersave();
 		else {
=================================================================
--- ./arch/ppc/mm/fault.c.ORG	2004-12-24 16:34:29.000000000 -0500
+++ ./arch/ppc/mm/fault.c	2005-02-19 21:32:02.000000000 -0500
@@ -92,7 +92,7 @@ static int store_updates_sp(struct pt_re
  * the error_code parameter is ESR for a data fault, 0 for an instruction
  * fault.
  */
-int do_page_fault(struct pt_regs *regs, unsigned long address,
+int notrace do_page_fault(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code)
 {
 	struct vm_area_struct * vma;
@@ -104,6 +104,7 @@ int do_page_fault(struct pt_regs *regs, 
 #else
 	int is_write = 0;
 
+	trace_special(regs->nip, error_code, address);
 	/*
 	 * Fortunately the bit assignments in SRR1 for an instruction
 	 * fault and DSISR for a data fault are mostly the same for the
=================================================================
--- ./arch/ppc/mm/init.c.ORG	2005-02-01 16:26:40.000000000 -0500
+++ ./arch/ppc/mm/init.c	2005-02-21 13:26:10.000000000 -0500
@@ -56,7 +56,7 @@
 #endif
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
 
 unsigned long total_memory;
 unsigned long total_lowmem;
=================================================================
--- ./arch/ppc/boot/common/util.S.ORG	2004-12-24 16:35:49.000000000 -0500
+++ ./arch/ppc/boot/common/util.S	2005-02-23 14:27:14.577421648 -0500
@@ -289,5 +289,15 @@ _GLOBAL(flush_data_cache)
 	bdnz	00b
 10:	blr
 
-	.previous
+#ifdef CONFIG_MCOUNT
+/* innocuous _mcount for boot header
+ */
+_GLOBAL(_mcount)
+	mflr	r12		/* return address to preamble */
+	lwz     r11, 4(r1)
+	mtlr    r11		/* restore LR modified by preamble */
+	mtctr	r12
+	bctr
+#endif
 
+	.previous
=================================================================
--- ./arch/ppc/platforms/encpp1_time.c.ORG	2005-02-02 20:42:55.000000000 -0500
+++ ./arch/ppc/platforms/encpp1_time.c	2005-02-09 16:35:10.000000000 -0500
@@ -155,9 +155,9 @@ int pp1_set_rtc_time (unsigned long nowt
 {
 	unsigned char save_control, save_freq_select;
 	struct rtc_time tm;
-	extern spinlock_t rtc_lock;
+	extern raw_spinlock_t rtc_lock;
 
-	spin_lock (&rtc_lock);
+	__raw_spin_lock (&rtc_lock);
 	to_tm (nowtime, &tm);
 
 	called ();
@@ -202,7 +202,7 @@ int pp1_set_rtc_time (unsigned long nowt
 
 	if ((time_state == TIME_ERROR) || (time_state == TIME_BAD))
 		time_state = TIME_OK;
-	spin_unlock (&rtc_lock);
+	__raw_spin_unlock (&rtc_lock);
 	return 0;
 }
 
=================================================================
--- ./arch/ppc/lib/locks.c.ORG	2004-12-24 16:34:26.000000000 -0500
+++ ./arch/ppc/lib/locks.c	2005-02-07 19:21:14.000000000 -0500
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/rt_lock.h>
 #include <asm/ppc_asm.h>
 #include <asm/smp.h>
 
@@ -43,7 +44,7 @@ static inline unsigned long __spin_trylo
 	return ret;
 }
 
-void _raw_spin_lock(spinlock_t *lock)
+void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	int cpu = smp_processor_id();
 	unsigned int stuck = INIT_STUCK;
@@ -63,9 +64,9 @@ void _raw_spin_lock(spinlock_t *lock)
 	lock->owner_pc = (unsigned long)__builtin_return_address(0);
 	lock->owner_cpu = cpu;
 }
-EXPORT_SYMBOL(_raw_spin_lock);
+EXPORT_SYMBOL(__raw_spin_lock);
 
-int _raw_spin_trylock(spinlock_t *lock)
+int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	if (__spin_trylock(&lock->lock))
 		return 0;
@@ -73,9 +74,9 @@ int _raw_spin_trylock(spinlock_t *lock)
 	lock->owner_pc = (unsigned long)__builtin_return_address(0);
 	return 1;
 }
-EXPORT_SYMBOL(_raw_spin_trylock);
+EXPORT_SYMBOL(__raw_spin_trylock);
 
-void _raw_spin_unlock(spinlock_t *lp)
+void __raw_spin_unlock(raw_spinlock_t *lp)
 {
   	if ( !lp->lock )
 		printk("_spin_unlock(%p): no lock cpu %d curr PC %p %s/%d\n",
@@ -89,7 +90,7 @@ void _raw_spin_unlock(spinlock_t *lp)
 	wmb();
 	lp->lock = 0;
 }
-EXPORT_SYMBOL(_raw_spin_unlock);
+EXPORT_SYMBOL(__raw_spin_unlock);
 
 
 /*
@@ -97,7 +98,7 @@ EXPORT_SYMBOL(_raw_spin_unlock);
  * with the high bit (sign) being the "write" bit.
  * -- Cort
  */
-void _raw_read_lock(rwlock_t *rw)
+void __raw_read_lock(raw_rwlock_t *rw)
 {
 	unsigned long stuck = INIT_STUCK;
 	int cpu = smp_processor_id();
@@ -123,9 +124,9 @@ again:
 	}
 	wmb();
 }
-EXPORT_SYMBOL(_raw_read_lock);
+EXPORT_SYMBOL(__raw_read_lock);
 
-void _raw_read_unlock(rwlock_t *rw)
+void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	if ( rw->lock == 0 )
 		printk("_read_unlock(): %s/%d (nip %08lX) lock %lx\n",
@@ -134,9 +135,9 @@ void _raw_read_unlock(rwlock_t *rw)
 	wmb();
 	atomic_dec((atomic_t *) &(rw)->lock);
 }
-EXPORT_SYMBOL(_raw_read_unlock);
+EXPORT_SYMBOL(__raw_read_unlock);
 
-void _raw_write_lock(rwlock_t *rw)
+void __raw_write_lock(raw_rwlock_t *rw)
 {
 	unsigned long stuck = INIT_STUCK;
 	int cpu = smp_processor_id();
@@ -175,9 +176,9 @@ again:
 	}
 	wmb();
 }
-EXPORT_SYMBOL(_raw_write_lock);
+EXPORT_SYMBOL(__raw_write_lock);
 
-int _raw_write_trylock(rwlock_t *rw)
+int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	if (test_and_set_bit(31, &(rw)->lock)) /* someone has a write lock */
 		return 0;
@@ -190,9 +191,9 @@ int _raw_write_trylock(rwlock_t *rw)
 	wmb();
 	return 1;
 }
-EXPORT_SYMBOL(_raw_write_trylock);
+EXPORT_SYMBOL(__raw_write_trylock);
 
-void _raw_write_unlock(rwlock_t *rw)
+void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	if ( !(rw->lock & (1<<31)) )
 		printk("_write_lock(): %s/%d (nip %08lX) lock %lx\n",
@@ -201,6 +202,6 @@ void _raw_write_unlock(rwlock_t *rw)
 	wmb();
 	clear_bit(31,&(rw)->lock);
 }
-EXPORT_SYMBOL(_raw_write_unlock);
+EXPORT_SYMBOL(__raw_write_unlock);
 
 #endif
=================================================================
--- ./arch/ppc/lib/dec_and_lock.c.ORG	2004-12-24 16:35:27.000000000 -0500
+++ ./arch/ppc/lib/dec_and_lock.c	2005-02-07 21:25:52.000000000 -0500
@@ -19,7 +19,7 @@
  */
 
 #ifndef ATOMIC_DEC_AND_LOCK
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+int _atomic_dec_and_raw_spin_lock(atomic_t *atomic, raw_spinlock_t *lock)
 {
 	int counter;
 	int newcount;
@@ -35,12 +35,12 @@ int _atomic_dec_and_lock(atomic_t *atomi
 			return 0;
 	}
 
-	spin_lock(lock);
+	_raw_spin_lock(lock);
 	if (atomic_dec_and_test(atomic))
 		return 1;
-	spin_unlock(lock);
+	_raw_spin_unlock(lock);
 	return 0;
 }
 
-EXPORT_SYMBOL(_atomic_dec_and_lock);
+EXPORT_SYMBOL(_atomic_dec_and_raw_spin_lock);
 #endif /* ATOMIC_DEC_AND_LOCK */
=================================================================
--- ./arch/ppc/Kconfig.ORG	2005-02-02 20:42:55.000000000 -0500
+++ ./arch/ppc/Kconfig	2005-02-08 19:54:51.000000000 -0500
@@ -15,13 +15,6 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
@@ -866,15 +859,21 @@ config NR_CPUS
 	depends on SMP
 	default "4"
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
+source "lib/Kconfig.RT"
 
-	  Say Y here if you are building a kernel for a desktop, embedded
-	  or real-time system.  Say N if you are unsure.
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	depends on !PREEMPT_RT
+	default y
+
+config ASM_SEMAPHORES
+	bool
+	depends on !PREEMPT_RT
+	default y
+
+config RWSEM_XCHGADD_ALGORITHM
+	bool
+	depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT
 
 config HIGHMEM
 	bool "High memory support"
=================================================================
--- ./include/asm-generic/tlb.h.ORG	2005-02-01 16:26:51.000000000 -0500
+++ ./include/asm-generic/tlb.h	2005-02-21 13:43:21.000000000 -0500
@@ -50,7 +50,8 @@ struct mmu_gather {
 #define tlb_mm(tlb) ((tlb)->mm)
 
 /* Users of the generic TLB shootdown code must declare this storage space. */
-DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
+
+DECLARE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
 
 /* tlb_gather_mmu
  *	Return a pointer to an initialized struct mmu_gather.
@@ -58,7 +59,8 @@ DECLARE_PER_CPU(struct mmu_gather, mmu_g
 static inline struct mmu_gather *
 tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
-	struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
+	struct mmu_gather *tlb = &get_cpu_var_locked(mmu_gathers,
+		_smp_processor_id());
 
 	tlb->mm = mm;
 
@@ -99,7 +101,7 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 		freed = rss;
 	mm->rss = rss - freed;
 	tlb_flush_mmu(tlb, start, end);
-	put_cpu_var(mmu_gathers);
+	put_cpu_var_locked(mmu_gathers, _smp_processor_id());
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
=================================================================
--- ./include/asm-generic/percpu.h.ORG	2005-02-01 16:26:51.000000000 -0500
+++ ./include/asm-generic/percpu.h	2005-02-21 13:11:53.000000000 -0500
@@ -53,6 +53,9 @@ do {								\
 #endif	/* SMP */
 
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+#define DECLARE_PER_CPU_LOCKED(type, name) \
+	extern __typeof__(type) per_cpu__##name##_locked; \
+	extern spinlock_t per_cpu_lock__##name##_locked
 
 #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
 #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
=================================================================
--- ./include/asm-ppc/rtc.h.ORG	2004-12-24 16:33:49.000000000 -0500
+++ ./include/asm-ppc/rtc.h	2005-02-23 14:30:06.705254240 -0500
@@ -24,6 +24,11 @@
 #ifndef __ASM_RTC_H__
 #define __ASM_RTC_H__
 
+#ifdef CONFIG_ENCPP1	/* Ampro work-around.  Ugh. */
+#define cpu_mhz	300
+#define cpu_khz (cpu_mhz * 1000)
+#endif
+
 #ifdef __KERNEL__
 
 #include <linux/rtc.h>
=================================================================
--- ./include/asm-ppc/semaphore.h.ORG	2004-12-24 16:34:57.000000000 -0500
+++ ./include/asm-ppc/semaphore.h	2005-02-08 11:39:18.000000000 -0500
@@ -18,6 +18,13 @@
 
 #include <asm/atomic.h>
 #include <asm/system.h>
+
+#ifdef CONFIG_PREEMPT_RT
+
+#include <linux/rt_lock.h>
+
+#else
+
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
@@ -108,4 +115,8 @@ extern inline void up(struct semaphore *
 
 #endif /* __KERNEL__ */
 
+extern int FASTCALL(sem_is_locked(struct semaphore *sem));
+
+#endif /* CONFIG_PREEMPT_RT */
+
 #endif /* !(_PPC_SEMAPHORE_H) */
=================================================================
--- ./include/asm-ppc/spinlock.h.ORG	2005-02-01 16:26:45.000000000 -0500
+++ ./include/asm-ppc/spinlock.h	2005-02-22 09:50:38.000000000 -0500
@@ -7,17 +7,6 @@
  * Simple spin lock operations.
  */
 
-typedef struct {
-	volatile unsigned long lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	volatile unsigned long owner_pc;
-	volatile unsigned long owner_cpu;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
 #ifdef __KERNEL__
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define SPINLOCK_DEBUG_INIT     , 0, 0
@@ -25,16 +14,19 @@ typedef struct {
 #define SPINLOCK_DEBUG_INIT     /* */
 #endif
 
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 SPINLOCK_DEBUG_INIT }
+#define __RAW_SPIN_LOCK_UNLOCKED { 0 SPINLOCK_DEBUG_INIT }
+#define RAW_SPIN_LOCK_UNLOCKED	(raw_spinlock_t) __RAW_SPIN_LOCK_UNLOCKED
 
-#define spin_lock_init(x) 	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __raw_spin_lock_init(x)  \
+	do { *(x) = RAW_SPIN_LOCK_UNLOCKED; } while(0)
+#define __raw_spin_is_locked(x)	((x)->lock != 0)
+#define __raw_spin_unlock_wait(x) \
+	do { barrier(); } while(__raw_spin_is_locked(x))
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	unsigned long tmp;
 
@@ -55,54 +47,37 @@ static inline void _raw_spin_lock(spinlo
 	: "cr0", "memory");
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__("eieio		# spin_unlock": : :"memory");
 	lock->lock = 0;
 }
 
-#define _raw_spin_trylock(l) (!test_and_set_bit(0,&(l)->lock))
+#define __raw_spin_trylock(l) (!test_and_set_bit(0,&(l)->lock))
 
 #else
 
-extern void _raw_spin_lock(spinlock_t *lock);
-extern void _raw_spin_unlock(spinlock_t *lock);
-extern int _raw_spin_trylock(spinlock_t *lock);
-
-#endif
+extern void __raw_spin_lock(raw_spinlock_t *lock);
+extern void __raw_spin_unlock(raw_spinlock_t *lock);
+extern int __raw_spin_trylock(raw_spinlock_t *lock);
 
-/*
- * Read-write spinlocks, allowing multiple readers
- * but only one writer.
- *
- * NOTE! it is quite common to have readers in interrupts
- * but no interrupt writers. For those circumstances we
- * can "mix" irq-safe locks - any writer needs to get a
- * irq-safe write-lock, but readers can get non-irqsafe
- * read-locks.
- */
-typedef struct {
-	volatile unsigned long lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	volatile unsigned long owner_pc;
-#endif
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
+#endif	/* CONFIG_DEBUG_SPINLOCK */
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_DEBUG_INIT     , 0
+#define RAW_RWLOCK_DEBUG_INIT     , 0
 #else
-#define RWLOCK_DEBUG_INIT     /* */
+#define RAW_RWLOCK_DEBUG_INIT     /* */
 #endif
 
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 RWLOCK_DEBUG_INIT }
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
+#define __RAW_RW_LOCK_UNLOCKED { 0 RAW_RWLOCK_DEBUG_INIT }
+#define RAW_RW_LOCK_UNLOCKED (raw_rwlock_t) __RAW_RW_LOCK_UNLOCKED
+#define __raw_rwlock_init(lp) do { *(lp) = RAW_RW_LOCK_UNLOCKED; } while(0)
+#define	__raw_read_can_lock(lp)	(0 <= (lp)->lock)
+#define	__raw_write_can_lock(lp)	(!(lp)->lock)
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 
-static __inline__ void _raw_read_lock(rwlock_t *rw)
+static __inline__ void __raw_read_lock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -123,7 +98,7 @@ static __inline__ void _raw_read_lock(rw
 	: "cr0", "memory");
 }
 
-static __inline__ void _raw_read_unlock(rwlock_t *rw)
+static __inline__ void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -139,7 +114,7 @@ static __inline__ void _raw_read_unlock(
 	: "cr0", "memory");
 }
 
-static __inline__ int _raw_write_trylock(rwlock_t *rw)
+static __inline__ int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -159,7 +134,7 @@ static __inline__ int _raw_write_trylock
 	return tmp == 0;
 }
 
-static __inline__ void _raw_write_lock(rwlock_t *rw)
+static __inline__ void __raw_write_lock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -180,7 +155,7 @@ static __inline__ void _raw_write_lock(r
 	: "cr0", "memory");
 }
 
-static __inline__ void _raw_write_unlock(rwlock_t *rw)
+static __inline__ void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	__asm__ __volatile__("eieio		# write_unlock": : :"memory");
 	rw->lock = 0;
@@ -188,15 +163,15 @@ static __inline__ void _raw_write_unlock
 
 #else
 
-extern void _raw_read_lock(rwlock_t *rw);
-extern void _raw_read_unlock(rwlock_t *rw);
-extern void _raw_write_lock(rwlock_t *rw);
-extern void _raw_write_unlock(rwlock_t *rw);
-extern int _raw_write_trylock(rwlock_t *rw);
+extern void __raw_read_lock(raw_rwlock_t *rw);
+extern void __raw_read_unlock(raw_rwlock_t *rw);
+extern void __raw_write_lock(raw_rwlock_t *rw);
+extern void __raw_write_unlock(raw_rwlock_t *rw);
+extern int __raw_write_trylock(raw_rwlock_t *rw);
 
 #endif
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic_raw_read_trylock(lock)
 
 #endif /* __ASM_SPINLOCK_H */
 #endif /* __KERNEL__ */
=================================================================
--- ./include/asm-ppc/hw_irq.h.ORG	2004-12-24 16:35:15.000000000 -0500
+++ ./include/asm-ppc/hw_irq.h	2005-02-23 15:55:45.653015432 -0500
@@ -13,8 +13,17 @@ extern void timer_interrupt(struct pt_re
 #define INLINE_IRQS
 
 #define irqs_disabled()	((mfmsr() & MSR_EE) == 0)
+#define irqs_disabled_flags(f)	(!((f) & MSR_EE))
 
-#ifdef INLINE_IRQS
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+  extern void notrace trace_irqs_off(void);
+  extern void notrace trace_irqs_on(void);
+#else
+# define trace_irqs_off()              do { } while (0)
+# define trace_irqs_on()               do { } while (0)
+#endif
+
+#if defined(INLINE_IRQS) || defined(CONFIG_CRITICAL_IRQSOFF_TIMING)
 
 static inline void local_irq_disable(void)
 {
@@ -22,11 +31,14 @@ static inline void local_irq_disable(voi
 	msr = mfmsr();
 	mtmsr(msr & ~MSR_EE);
 	__asm__ __volatile__("": : :"memory");
+	trace_irqs_off();
 }
 
 static inline void local_irq_enable(void)
 {
 	unsigned long msr;
+
+	trace_irqs_on();
 	__asm__ __volatile__("": : :"memory");
 	msr = mfmsr();
 	mtmsr(msr | MSR_EE);
@@ -39,11 +51,19 @@ static inline void local_irq_save_ptr(un
 	*flags = msr;
 	mtmsr(msr & ~MSR_EE);
 	__asm__ __volatile__("": : :"memory");
+	trace_irqs_off();
 }
 
 #define local_save_flags(flags)		((flags) = mfmsr())
 #define local_irq_save(flags)		local_irq_save_ptr(&flags)
-#define local_irq_restore(flags)	mtmsr(flags)
+#define local_irq_restore(flags) \
+	do { \
+		if (irqs_disabled_flags(flags)) \
+			trace_irqs_off(); \
+		else \
+			trace_irqs_on();  \
+		mtmsr(flags); \
+	} while (0)
 
 #else
 
=================================================================
--- ./include/asm-ppc/tlb.h.ORG	2004-12-24 16:34:58.000000000 -0500
+++ ./include/asm-ppc/tlb.h	2005-02-09 19:12:21.000000000 -0500
@@ -50,7 +50,11 @@ static inline void __tlb_remove_tlb_entr
 #define tlb_flush(tlb)			flush_tlb_mm((tlb)->mm)
 
 /* Get the generic bits... */
+#ifdef CONFIG_PREEMPT_RT
+#include <asm-generic/tlb-simple.h>
+#else
 #include <asm-generic/tlb.h>
+#endif
 
 #endif /* CONFIG_PPC_STD_MMU */
 
=================================================================
--- ./include/asm-ppc/ocp.h.ORG	2004-12-24 16:34:26.000000000 -0500
+++ ./include/asm-ppc/ocp.h	2005-02-23 16:50:53.514144104 -0500
@@ -32,7 +32,6 @@
 
 #include <asm/mmu.h>
 #include <asm/ocp_ids.h>
-#include <asm/rwsem.h>
 #include <asm/semaphore.h>
 
 #ifdef CONFIG_PPC_OCP
=================================================================
--- ./include/linux/sched.h.ORG	2005-02-01 16:26:51.000000000 -0500
+++ ./include/linux/sched.h	2005-02-20 18:24:02.000000000 -0500
@@ -74,9 +74,18 @@ extern int debug_direct_keyboard;
 #endif
 
 #ifdef CONFIG_FRAME_POINTER
+#ifdef CONFIG_PPC
+# define __valid_ra(l)	((__builtin_frame_address(l) && \
+	*(unsigned long *)__builtin_frame_address(l)) ? \
+	(unsigned long)__builtin_return_address(l) : 0UL)
+# define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
+# define CALLER_ADDR1 __valid_ra(1)
+# define CALLER_ADDR2 (__valid_ra(1) ? __valid_ra(2) : 0UL)
+#else
 # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
 # define CALLER_ADDR1 ((unsigned long)__builtin_return_address(1))
 # define CALLER_ADDR2 ((unsigned long)__builtin_return_address(2))
+#endif
 #else
 # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
 # define CALLER_ADDR1 0UL
@@ -84,9 +93,14 @@ extern int debug_direct_keyboard;
 #endif
 
 #ifdef CONFIG_MCOUNT
-  extern void notrace mcount(void);
+#ifdef CONFIG_PPC
+# define ARCH_MCOUNT     _mcount
+#else
+# define ARCH_MCOUNT     mcount
+#endif
+  extern void notrace ARCH_MCOUNT(void);
 #else
-# define mcount() do { } while (0)
+# define ARCH_MCOUNT() do { } while (0)
 #endif
 
 #ifdef CONFIG_LATENCY_TRACE
=================================================================
--- ./drivers/char/blocker.c.ORG	2005-02-01 16:26:48.000000000 -0500
+++ ./drivers/char/blocker.c	2005-02-02 17:16:24.000000000 -0500
@@ -4,6 +4,7 @@
 
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <asm/time.h>
 
 #define BLOCKER_MINOR		221
 
@@ -17,8 +18,18 @@ u64 notrace get_cpu_tick(void)
 	u64 tsc;
 #ifdef ARCHARM
 	tsc = *oscr;
-#else
+#elif defined(CONFIG_X86)
 	__asm__ __volatile__("rdtsc" : "=A" (tsc));
+#elif defined(CONFIG_PPC)
+	unsigned long hi, lo;
+
+	do {
+		hi = get_tbu();
+		lo = get_tbl();
+	} while (get_tbu() != hi);
+	tsc = (u64)hi << 32 | lo;
+#else
+	#error Implement get_cpu_tick()
 #endif
 	return tsc;
 }
=================================================================
--- ./kernel/sched.c.ORG	2005-02-01 16:26:46.000000000 -0500
+++ ./kernel/sched.c	2005-02-23 14:37:51.325621208 -0500
@@ -1237,7 +1237,7 @@ int fastcall wake_up_process(task_t * p)
 	int ret = try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
 				 TASK_RUNNING_MUTEX | TASK_INTERRUPTIBLE |
 				 TASK_UNINTERRUPTIBLE, 0, 0);
-	mcount();
+	ARCH_MCOUNT();
 	return ret;
 }
 
@@ -1248,7 +1248,7 @@ int fastcall wake_up_process_mutex(task_
 	int ret = try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
 				 TASK_RUNNING_MUTEX | TASK_INTERRUPTIBLE |
 				 TASK_UNINTERRUPTIBLE, 0, 1);
-	mcount();
+	ARCH_MCOUNT();
 	return ret;
 }
 
@@ -1257,7 +1257,7 @@ EXPORT_SYMBOL(wake_up_process_mutex);
 int fastcall wake_up_state(task_t *p, unsigned int state)
 {
 	int ret = try_to_wake_up(p, state | TASK_RUNNING_MUTEX, 0, 0);
-	mcount();
+	ARCH_MCOUNT();
 	return ret;
 }
 
@@ -1502,7 +1502,11 @@ static void finish_task_switch(task_t *p
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
  */
+#ifdef CONFIG_PPC
+asmlinkage notrace void schedule_tail(task_t *prev)
+#else
 asmlinkage void schedule_tail(task_t *prev)
+#endif
 	__releases(rq->lock)
 {
 	preempt_disable(); // TODO: move this to fork setup
=================================================================
--- ./kernel/latency.c.ORG	2005-02-01 16:26:46.000000000 -0500
+++ ./kernel/latency.c	2005-02-23 08:32:38.000000000 -0500
@@ -50,6 +50,12 @@ static __cacheline_aligned_in_smp struct
 int wakeup_timing = 1;
 #endif
 
+#ifdef NONASCII
+#define MU '�'
+#else
+#define MU 'u'
+#endif
+
 #ifdef CONFIG_LATENCY_TIMING
 
 /*
@@ -357,9 +363,9 @@ void notrace __trace(unsigned long eip, 
 	___trace(TRACE_FN, eip, parent_eip, 0, 0, 0);
 }
 
-extern void mcount(void);
+extern void ARCH_MCOUNT(void);
 
-EXPORT_SYMBOL(mcount);
+EXPORT_SYMBOL(ARCH_MCOUNT);
 
 void notrace __mcount(void)
 {
@@ -631,8 +637,8 @@ static void * notrace l_start(struct seq
 	if (!n) {
 		seq_printf(m, "preemption latency trace v1.1.4 on %s\n", UTS_RELEASE);
 		seq_puts(m, "--------------------------------------------------------------------\n");
-		seq_printf(m, " latency: %lu 탎, #%lu/%lu, CPU#%d | (M:%s VP:%d, KP:%d, SP:%d HP:%d #P:%d)\n",
-			cycles_to_usecs(tr->saved_latency),
+		seq_printf(m, " latency: %lu %cs, #%lu/%lu, CPU#%d | (M:%s VP:%d, KP:%d, SP:%d HP:%d #P:%d)\n",
+			cycles_to_usecs(tr->saved_latency), MU,
 			entries, tr->trace_idx, out_tr.cpu,
 #if defined(CONFIG_PREEMPT_NONE)
 			"server",
@@ -698,7 +704,7 @@ static void notrace l_stop(struct seq_fi
 static void print_timestamp(struct seq_file *m, unsigned long abs_usecs,
 						unsigned long rel_usecs)
 {
-	seq_printf(m, " %4ld탎", abs_usecs);
+	seq_printf(m, " %4ld%cs", abs_usecs, MU);
 	if (rel_usecs > 100)
 		seq_puts(m, "!: ");
 	else if (rel_usecs > 1)
@@ -711,7 +717,7 @@ static void
 print_timestamp_short(struct seq_file *m, unsigned long abs_usecs,
 			unsigned long rel_usecs)
 {
-	seq_printf(m, " %4ld탎", abs_usecs);
+	seq_printf(m, " %4ld%cs", abs_usecs, MU);
 	if (rel_usecs > 100)
 		seq_putc(m, '!');
 	else if (rel_usecs > 1)
@@ -1043,7 +1049,7 @@ static int setup_preempt_thresh(char *s)
 	get_option(&s, &thresh);
 	if (thresh > 0) {
 		preempt_thresh = usecs_to_cycles(thresh);
-		printk("Preemption threshold = %u 탎\n", thresh);
+		printk("Preemption threshold = %u %cs\n", thresh, MU);
 	}
 	return 1;
 }
@@ -1091,18 +1097,18 @@ check_critical_timing(struct cpu_trace *
 	update_max_tr(tr);
 
 	if (preempt_thresh)
-		printk("(%16s-%-5d|#%d): %lu 탎 critical section "
-			"violates %lu 탎 threshold.\n"
+		printk("(%16s-%-5d|#%d): %lu %cs critical section "
+			"violates %lu %cs threshold.\n"
 			" => started at timestamp %lu: ",
 				current->comm, current->pid,
-				_smp_processor_id(),
-				latency, cycles_to_usecs(preempt_thresh), t0);
+				_smp_processor_id(), latency,
+				MU, cycles_to_usecs(preempt_thresh), MU, t0);
 	else
-		printk("(%16s-%-5d|#%d): new %lu 탎 maximum-latency "
+		printk("(%16s-%-5d|#%d): new %lu %cs maximum-latency "
 			"critical section.\n => started at timestamp %lu: ",
 				current->comm, current->pid,
 				_smp_processor_id(),
-				latency, t0);
+				latency, MU, t0);
 
 	print_symbol("<%s>\n", tr->critical_start);
 	printk(" =>   ended at timestamp %lu: ", t1);
@@ -1345,15 +1351,15 @@ check_wakeup_timing(struct cpu_trace *tr
 	update_max_tr(tr);
 
 	if (preempt_thresh)
-		printk("(%16s-%-5d|#%d): %lu 탎 wakeup latency "
-			"violates %lu 탎 threshold.\n",
+		printk("(%16s-%-5d|#%d): %lu %cs wakeup latency "
+			"violates %lu %cs threshold.\n",
 				current->comm, current->pid,
 				_smp_processor_id(), latency,
-				cycles_to_usecs(preempt_thresh));
+				MU, cycles_to_usecs(preempt_thresh), MU);
 	else
-		printk("(%16s-%-5d|#%d): new %lu 탎 maximum-latency "
+		printk("(%16s-%-5d|#%d): new %lu %cs maximum-latency "
 			"wakeup.\n", current->comm, current->pid,
-				_smp_processor_id(), latency);
+				_smp_processor_id(), latency, MU);
 
 	max_sequence++;
 
@@ -1399,7 +1405,7 @@ void __trace_start_sched_wakeup(struct t
 	tr->preempt_timestamp = cycles();
 	tr->critical_start = CALLER_ADDR0;
 	trace_cmdline();
-	mcount();
+	ARCH_MCOUNT();
 out_unlock:
 	spin_unlock(&sch.trace_lock);
 }
@@ -1489,7 +1495,7 @@ long user_trace_start(void)
 	tr->critical_sequence = max_sequence;
 	tr->preempt_timestamp = cycles();
 	trace_cmdline();
-	mcount();
+	ARCH_MCOUNT();
 	preempt_enable();
 
 	up(&max_mutex);
@@ -1507,7 +1513,7 @@ long user_trace_stop(void)
 		return -EINVAL;
 
 	preempt_disable();
-	mcount();
+	ARCH_MCOUNT();
 
 	if (wakeup_timing) {
 		spin_lock_irqsave(&sch.trace_lock, flags);
@@ -1538,15 +1544,15 @@ long user_trace_stop(void)
 		latency = cycles_to_usecs(delta);
 
 		if (preempt_thresh)
-			printk("(%16s-%-5d|#%d): %lu 탎 user-latency "
-				"violates %lu 탎 threshold.\n",
+			printk("(%16s-%-5d|#%d): %lu %cs user-latency "
+				"violates %lu %cs threshold.\n",
 					current->comm, current->pid,
-					_smp_processor_id(), latency,
-					cycles_to_usecs(preempt_thresh));
+					_smp_processor_id(), latency, MU,
+					cycles_to_usecs(preempt_thresh), MU);
 		else
-			printk("(%16s-%-5d|#%d): new %lu 탎 user-latency.\n",
+			printk("(%16s-%-5d|#%d): new %lu %cs user-latency.\n",
 				current->comm, current->pid,
-					_smp_processor_id(), latency);
+					_smp_processor_id(), latency, MU);
 
 		max_sequence++;
 		up(&max_mutex);

--------------040902020302020909030302--
