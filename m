Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTILDVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 23:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbTILDVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 23:21:54 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:29846 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261528AbTILDVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 23:21:18 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
Message-ID: <16225.15265.818912.895180@wombat.chubb.wattle.id.au>
Date: Fri, 12 Sep 2003 13:21:05 +1000
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WXYwVdl7zp"
Content-Transfer-Encoding: 7bit
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schedstat-2.6.0-test5-A1 measuring process scheduling latency 
In-Reply-To: <16225.10465.132753.695040@wombat.chubb.wattle.id.au>
References: <16225.5591.442410.58842@wombat.chubb.wattle.id.au>
	<200309120102.h8C12NV07347@owlet.beaverton.ibm.com>
	<16225.10465.132753.695040@wombat.chubb.wattle.id.au>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WXYwVdl7zp
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


Updated microstate accounting patch attached.  This one includes
Dominik Brodowski's patch to use the power-management timer as an
alternative timing source.

Patch also at
http://www.gelato.unsw.edu.au/patches/


--WXYwVdl7zp
Content-Type: text/plain
Content-Disposition: inline;
	filename="2.6.0-test5-ustate-patch"
Content-Transfer-Encoding: 7bit

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/Kconfig linux-2.5-ustate+PM/arch/i386/Kconfig
--- linux-2.5-import/arch/i386/Kconfig	Thu Sep 11 10:16:25 2003
+++ linux-2.5-ustate+PM/arch/i386/Kconfig	Fri Sep 12 10:59:29 2003
@@ -521,6 +521,16 @@
 	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
+config X86_PM_TIMER
+	tristate "Use Power Management Timer (PMTMR) as primary timing source"
+	depends on ACPI_BUS
+	help
+	  The Power Management Timer (PMTMR) is available on all 
+	  ACPI-capable systems. it provides a reliable timing source 
+	  which does not get affected by powermanagement features 
+	  (e.g. aggressive idling, throttling or frequency scaling), 
+	  unlike the commonly used Time Stamp Counter (TSC) timing source.
+
 config X86_MCE
 	bool "Machine Check Exception"
 	---help---
@@ -1338,6 +1348,44 @@
 	bool
 	depends on X86_LOCAL_APIC && !X86_VISWS
 	default y
+
+config MICROSTATE
+       bool "Microstate accounting"
+       help
+         This option causes the kernel to keep very accurate track of
+	 how long your threads spend on the runqueues, running, or asleep or
+	 stopped.  It will slow down your kernel.
+	 Times are reported in /proc/pid/msa and through a new msa()
+	 system call.
+
+choice 
+       depends on MICROSTATE
+       prompt "Microstate timing source"
+       default MICROSTATE_TSC
+
+config MICROSTATE_PM
+       bool "Use Power-Management timer for microstate timings"
+       depends on X86_PM_TIMER
+       help
+	 If your machine is ACPI enabled and uses pwer-management, then the 
+	 TSC runs at a variable rate, which will distort the 
+	 microstate measurements.  Unfortunately, the PM timer has a resolution
+	 of only 279 nanoseconds or so.
+
+config MICROSTATE_TSC
+       bool "Use on-chip TSC for microstate timings"
+       depends on X86_TSC
+       help
+         If your machine's clock runs at constant rate, then this timer 
+	 gives you cycle precision in measureing times spent in microstates.
+
+config MICROSTATE_TOD
+       bool "Use time-of-day clock for microstate timings"
+       help
+         If none of the other timers are any good for you, this timer 
+	 will give you micro-second precision.
+endchoice
+	
 
 endmenu
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/entry.S linux-2.5-ustate+PM/arch/i386/kernel/entry.S
--- linux-2.5-import/arch/i386/kernel/entry.S	Tue Aug 19 13:57:56 2003
+++ linux-2.5-ustate+PM/arch/i386/kernel/entry.S	Fri Sep  5 14:52:40 2003
@@ -264,9 +264,17 @@
 
 	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebp)
 	jnz syscall_trace_entry
+#ifdef CONFIG_MICROSTATE
+	pushl	%eax
+	call msa_start_syscall
+	popl	%eax
+#endif
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
 	cli
+#ifdef CONFIG_MICROSTATE
+	call msa_end_syscall
+#endif
 	movl TI_FLAGS(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
@@ -288,9 +296,17 @@
 	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebp)
 	jnz syscall_trace_entry
 syscall_call:
+#ifdef CONFIG_MICROSTATE
+	pushl	%eax
+	call msa_start_syscall
+	popl	%eax
+#endif
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
+#ifdef CONFIG_MICROSTATE
+	call msa_end_syscall
+#endif
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
@@ -879,5 +895,6 @@
 	.long sys_tgkill	/* 270 */
 	.long sys_utimes
  	.long sys_fadvise64_64
+	.long sys_msa			/* 273 */
 
 nr_syscalls=(.-sys_call_table)/4
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/irq.c linux-2.5-ustate+PM/arch/i386/kernel/irq.c
--- linux-2.5-import/arch/i386/kernel/irq.c	Wed Aug 20 08:52:58 2003
+++ linux-2.5-ustate+PM/arch/i386/kernel/irq.c	Fri Sep  5 14:52:40 2003
@@ -155,10 +155,18 @@
 		seq_printf(p, "%3d: ",i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
+#ifdef CONFIG_MICROSTATE
+		seq_printf(p, "%10llu", msa_irq_time(0, i));
+#endif
 #else
 		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
+			if (cpu_online(j)) {
 				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+#ifdef CONFIG_MICROSTATE
+				seq_printf(p, "%10llu", msa_irq_time(j, i));
+#endif
+			}
+
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
@@ -419,6 +427,7 @@
 	unsigned int status;
 
 	irq_enter();
+	msa_start_irq(irq);
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
@@ -498,6 +507,7 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+	msa_finish_irq(irq);
 
 	return 1;
 }
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/time.c linux-2.5-ustate+PM/arch/i386/kernel/time.c
--- linux-2.5-import/arch/i386/kernel/time.c	Mon Sep  1 19:16:13 2003
+++ linux-2.5-ustate+PM/arch/i386/kernel/time.c	Fri Sep  5 14:52:40 2003
@@ -83,6 +83,7 @@
 EXPORT_SYMBOL(i8253_lock);
 
 struct timer_opts *cur_timer = &timer_none;
+EXPORT_SYMBOL(cur_timer);
 
 /*
  * This version of gettimeofday has microsecond resolution
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/timers/Makefile linux-2.5-ustate+PM/arch/i386/kernel/timers/Makefile
--- linux-2.5-import/arch/i386/kernel/timers/Makefile	Thu Sep 11 10:16:25 2003
+++ linux-2.5-ustate+PM/arch/i386/kernel/timers/Makefile	Fri Sep 12 10:59:29 2003
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
 obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
+obj-$(CONFIG_X86_PM_TIMER) += timer_pm.o
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/i386/kernel/timers/timer_pm.c linux-2.5-ustate+PM/arch/i386/kernel/timers/timer_pm.c
--- linux-2.5-import/arch/i386/kernel/timers/timer_pm.c	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate+PM/arch/i386/kernel/timers/timer_pm.c	Fri Aug 29 09:26:09 2003
@@ -0,0 +1,199 @@
+/*
+ * (C) Dominik Brodowski <linux@brodo.de> 2003
+ *
+ * Driver to use the Power Management Timer (PMTMR) available in some
+ * southbridges as primary timing source for the Linux kernel.
+ *
+ * based on parts of linux/drivers/acpi/hardware/hwtimer.c and of timer_pit.c,
+ * and on Arjan van de Ven's implementation for 2.4. 
+ *
+ * This file is licensed under the GPL v2.
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <asm/types.h>
+#include <asm/timer.h>
+#include <asm/smp.h>
+#include <asm/io.h>
+#include <asm/arch_hooks.h>
+
+/* The I/O port the PMTMR resides at */
+static u32 pmtmr_ioport = 0;
+
+/* value of the Power timer at last timer interrupt */
+static u32 offset_tick;
+
+/* forward declaration of our timer_opts struct */
+struct timer_opts timer_pmtmr;
+static void mark_offset_pmtmr(void);
+
+/************ detection of the I/O port *****************/
+
+/*
+ * The PMTMR I/O port can be detected using the following methods:
+ *
+ * a) Scan the PCI bus for the device the PMTMR is located at [e.g. PIIX4 southbridge],
+ *    locate its I/O port range, and then use a table-lookup to find the I/O port 
+ *    (offset) for the PMTMR for this device. 
+ *    While this provides some safety from buggy BIOSes, it is also very chipset-specific
+ *    and only available once the PCI devices are properly enabled, e.g. very late during
+ *    the boot process. Another timing source needs to be used in between. However, as this
+ *    approach is independent of ACPI and CONFIG_ACPI, it might be a good solution for some
+ *    very broken systems.
+ *    This method is not implemented yet.
+ *
+ * b) Ask the ACPI subsystem's FADT. While this is the easiest approach, it also means that
+ *    this timer is only available _late_ in the boot process, only after the ACPI subsystem
+ *    has been initialized (which is a subsys_initcall). However, the timing sources are set
+ *    up already earlier. This means that we need to use the TSC or the PIT intermediately until
+ *    this code replaces the earlier used timer with the PMTMR [see mark_offset_and_replace() foir
+ *    details on this].
+ *    This method is implemented.
+ *
+ * c) Parse the ACPI FADT here, too. This means that this code could be independend of CONFIG_ACPI,
+ *    but it would cause a lot of code duplication between the ACPI subsystem and this file. However,
+ *    as this could mean that the PMTMR can be used immediately, without having to rely on alternate
+ *    timing sources first.
+ *    This method is not implemented yet.
+ */
+
+static void mark_offset_and_replace(void)
+{
+	cur_timer = &timer_pmtmr;
+	mark_offset_pmtmr();
+}
+
+/* method b) */
+
+#include <acpi/acpi.h>
+#include <acpi/acpi_bus.h>
+
+struct timer_opts *prev_timer;
+
+static int __init pmtimer_init(void)
+{
+	int ret;
+
+	ret = acpi_get_timer(&offset_tick);
+	if (ret) {
+		printk(KERN_ERR "acpi_get_timer failed\n");
+		return -EINVAL;
+	}
+
+	if (acpi_fadt.xpm_tmr_blk.address_space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
+		printk(KERN_INFO "ACPI PM timer is not at IO port -- error\n");
+		return -EINVAL;
+	}
+
+	pmtmr_ioport = acpi_fadt.xpm_tmr_blk.address;
+	if (!pmtmr_ioport) {
+		printk(KERN_INFO "ACPI PM timer invalid IO port\n");
+		return -EINVAL;
+	}
+
+	printk(KERN_INFO "Using ACPI PM timer at 0x%x as timing source.\n", pmtmr_ioport);
+
+	prev_timer = cur_timer;
+	cur_timer->mark_offset = mark_offset_and_replace;
+
+	return 0;
+}
+fs_initcall(pmtimer_init);
+
+static void __exit pmtimer_exit(void)
+{
+	cur_timer = prev_timer;
+}
+module_exit(pmtimer_exit);
+
+
+/************ actual timing code *****************/
+
+/*
+ * this gets called during each timer interrupt
+ */
+static void mark_offset_pmtmr(void)
+{
+	offset_tick = inl(pmtmr_ioport);
+	offset_tick &= 0xFFFFFF; /* limit it to 24 bits */
+	return;
+}
+
+/*
+ * would it be desirable to have a ~279 nanosecond resolution?
+ */
+static unsigned long long monotonic_clock_pmtmr(void)
+{
+	static unsigned long long ctr;
+	static unsigned long lstclk;
+	unsigned long pmclk = 0xffffff & inl(pmtmr_ioport);
+	unsigned long long clk;
+
+	if (pmclk < lstclk) {
+		ctr += (1<<24);
+	}
+
+	lstclk = pmclk;
+	clk = ((ctr + pmclk) * 1144280) >> 12;
+	return clk;
+}
+
+/*
+ * copied from delay_pit
+ */
+static void delay_pmtmr(unsigned long loops)
+{
+	int d0;
+	__asm__ __volatile__(
+		"\tjmp 1f\n"
+		".align 16\n"
+		"1:\tjmp 2f\n"
+		".align 16\n"
+		"2:\tdecl %0\n\tjns 2b"
+		:"=&a" (d0)
+		:"0" (loops));
+}
+
+/*
+ * get the offset (in microseconds) from the last call to mark_offset()
+ */
+static unsigned long get_offset_pmtmr(void)
+{
+	u32 now, offset, delta = 0;
+
+	offset = offset_tick;
+	now = inl(pmtmr_ioport);
+	now &= 0xFFFFFF;
+	if (offset < now)
+		delta = now - offset;
+	else if (offset > now)
+		delta = (0xFFFFFF - offset) + now;
+
+	/* The Power Management Timer ticks at 3.579545 ticks per microsecond.
+	 * 1 / PM_TIMER_FREQUENCY == 0.27936511 =~ 286/1024 [error: 0.024%]
+	 *
+	 * Even with HZ = 100, delta is at maximum 35796 ticks, so it can 
+	 * easily be multiplied with 286 (=0x11E) without having to fear
+	 * u32 overflows.
+	 */
+	delta *= 286;
+	return (unsigned long) (delta >> 10);
+}
+
+/* acpi timer_opts struct */
+struct timer_opts timer_pmtmr = {
+	.init =		NULL,
+	.mark_offset =	mark_offset_pmtmr, 
+	.get_offset =	get_offset_pmtmr,
+	.monotonic_clock = monotonic_clock_pmtmr,
+	.delay = delay_pmtmr,
+};
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION("Power Management Timer (PMTMR) as primary timing source for i386");
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/Kconfig linux-2.5-ustate+PM/arch/ia64/Kconfig
--- linux-2.5-import/arch/ia64/Kconfig	Wed Sep 10 08:49:05 2003
+++ linux-2.5-ustate+PM/arch/ia64/Kconfig	Fri Sep 12 10:59:29 2003
@@ -669,6 +669,26 @@
 	  and restore instructions.  It's useful for tracking down spinlock
 	  problems, but slow!  If you're unsure, select N.
 
+config MICROSTATE
+       bool "Microstate accounting"
+       help
+         This option causes the kernel to keep very accurate track of
+	 how long your threads spend on the runqueues, running, or asleep or
+	 stopped.  It will slow down your kernel.
+	 Times are reported in /proc/pid/msa and through a new msa()
+	 system call.
+choice
+       depends on MICROSTATE
+       prompt "Microstate timing source"
+       default MICROSTATE_ITC
+
+config MICROSTATE_ITC
+       bool "Use on-chip IDT for microstate timing"
+
+config MICROSTATE_TOD
+       bool "Use time-of-day clock for microstate timings"
+endchoice
+
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
 	depends on DEBUG_KERNEL
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/kernel/entry.S linux-2.5-ustate+PM/arch/ia64/kernel/entry.S
--- linux-2.5-import/arch/ia64/kernel/entry.S	Wed Sep 10 08:49:05 2003
+++ linux-2.5-ustate+PM/arch/ia64/kernel/entry.S	Fri Sep 12 10:59:29 2003
@@ -551,6 +551,36 @@
 	br.cond.sptk strace_save_retval
 END(ia64_trace_syscall)
 
+#ifdef CONFIG_MICROSTATE
+GLOBAL_ENTRY(invoke_msa_end_syscall)
+	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(8)
+	alloc loc1=ar.pfs,8,4,0,0
+	mov loc0=rp
+	.body
+	;;
+	br.call.sptk.many rp=msa_end_syscall
+1:	mov rp=loc0
+	mov ar.pfs=loc1
+	br.ret.sptk.many rp
+END(invoke_msa_end_syscall)
+
+GLOBAL_ENTRY(invoke_msa_start_syscall)
+	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(8)
+	alloc loc1=ar.pfs,8,4,0,0
+	mov loc0=rp
+	.body
+	mov loc2=b6
+	mov loc3=r15
+	;;
+	br.call.sptk.many rp=msa_start_syscall
+1:	mov rp=loc0
+	mov r15=loc3
+	mov ar.pfs=loc1
+	mov b6=loc2
+	br.ret.sptk.many rp
+END(invoke_msa_start_syscall)
+#endif /* CONFIG_MICROSTATE */
+
 GLOBAL_ENTRY(ia64_ret_from_clone)
 	PT_REGS_UNWIND_INFO(0)
 {	/*
@@ -632,6 +662,10 @@
  */
 GLOBAL_ENTRY(ia64_leave_syscall)
 	PT_REGS_UNWIND_INFO(0)
+#ifdef CONFIG_MICROSTATE
+	br.call.sptk.many rp=invoke_msa_end_syscall
+1:	
+#endif
 	/*
 	 * work.need_resched etc. mustn't get changed by this CPU before it returns to
 	 * user- or fsys-mode, hence we disable interrupts early on:
@@ -973,7 +1007,7 @@
 	mov loc7=0
 (pRecurse) br.call.sptk.few b0=rse_clear_invalid
 	;;
-	mov loc8=0
+1:	mov loc8=0
 	mov loc9=0
 	cmp.ne pReturn,p0=r0,in1	// if recursion count != 0, we need to do a br.ret
 	mov loc10=0
@@ -1474,7 +1508,7 @@
 	data8 sys_fstatfs64
 	data8 sys_statfs64
 	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall			// 1260
+	data8 sys_msa				//1260
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/kernel/irq_ia64.c linux-2.5-ustate+PM/arch/ia64/kernel/irq_ia64.c
--- linux-2.5-import/arch/ia64/kernel/irq_ia64.c	Sat Aug 23 18:00:03 2003
+++ linux-2.5-ustate+PM/arch/ia64/kernel/irq_ia64.c	Fri Sep  5 14:52:40 2003
@@ -77,6 +77,7 @@
 ia64_handle_irq (ia64_vector vector, struct pt_regs *regs)
 {
 	unsigned long saved_tpr;
+	ia64_vector oldvector;
 #ifdef CONFIG_SMP
 #	define IS_RESCHEDULE(vec)	(vec == IA64_IPI_RESCHEDULE)
 #else
@@ -120,6 +121,8 @@
 	 */
 	saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
 	ia64_srlz_d();
+	oldvector = vector;
+	msa_start_irq(local_vector_to_irq(vector));
 	while (vector != IA64_SPURIOUS_INT_VECTOR) {
 		if (!IS_RESCHEDULE(vector)) {
 			ia64_setreg(_IA64_REG_CR_TPR, vector);
@@ -134,7 +137,10 @@
 			ia64_setreg(_IA64_REG_CR_TPR, saved_tpr);
 		}
 		ia64_eoi();
-		vector = ia64_get_ivr();
+		oldvector = vector;
+		vector = ia64_get_ivr();		
+		msa_continue_irq(local_vector_to_irq(oldvector),
+				 local_vector_to_irq(vector));
 	}
 	/*
 	 * This must be done *after* the ia64_eoi().  For example, the keyboard softirq
@@ -143,6 +149,8 @@
 	 */
 	if (local_softirq_pending())
 		do_softirq();
+
+	msa_finish_irq(local_vector_to_irq(vector));
 }
 
 #ifdef CONFIG_SMP
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/arch/ia64/kernel/ivt.S linux-2.5-ustate+PM/arch/ia64/kernel/ivt.S
--- linux-2.5-import/arch/ia64/kernel/ivt.S	Tue Aug 19 13:58:00 2003
+++ linux-2.5-ustate+PM/arch/ia64/kernel/ivt.S	Thu Jul 24 10:32:53 2003
@@ -697,6 +697,10 @@
 	srlz.i					// guarantee that interruption collection is on
 	;;
 (p15)	ssm psr.i				// restore psr.i
+#ifdef CONFIG_MICROSTATE
+	br.call.sptk.many rp=invoke_msa_start_syscall
+1:	
+#endif  /* CONFIG_MICROSTATE */
 	;;
 	mov r3=NR_syscalls - 1
 	movl r16=sys_call_table
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/video/radeonfb.c linux-2.5-ustate+PM/drivers/video/radeonfb.c
--- linux-2.5-import/drivers/video/radeonfb.c	Tue Aug 19 13:59:12 2003
+++ linux-2.5-ustate+PM/drivers/video/radeonfb.c	Wed Aug 27 06:55:58 2003
@@ -2090,7 +2090,7 @@
 	
 	}
 	/* Update fix */
-        info->fix.line_length = rinfo->pitch*64;
+        info->fix.line_length = mode->xres_virtual*(mode->bits_per_pixel/8);
         info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 #ifdef CONFIG_BOOTX_TEXT
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/proc/base.c linux-2.5-ustate+PM/fs/proc/base.c
--- linux-2.5-import/fs/proc/base.c	Mon Sep  1 19:16:15 2003
+++ linux-2.5-ustate+PM/fs/proc/base.c	Tue Sep  9 13:56:05 2003
@@ -65,6 +65,9 @@
 	PROC_PID_ATTR_EXEC,
 	PROC_PID_ATTR_FSCREATE,
 #endif
+#ifdef CONFIG_MICROSTATE
+	PROC_PID_MSA,
+#endif
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -95,6 +98,9 @@
 #ifdef CONFIG_KALLSYMS
   E(PROC_PID_WCHAN,	"wchan",	S_IFREG|S_IRUGO),
 #endif
+#ifdef CONFIG_MICROSTATE
+  E(PROC_PID_MSA,	"msa",		S_IFREG|S_IRUGO),
+#endif
   {0,0,NULL,0}
 };
 #ifdef CONFIG_SECURITY
@@ -288,6 +294,78 @@
 }
 #endif /* CONFIG_KALLSYMS */
 
+#ifdef CONFIG_MICROSTATE
+/*
+ * provides microstate accounting information
+ *
+ */
+static int proc_pid_msa(struct task_struct *task, char *buffer) 
+{
+	struct microstates *msp = &task->microstates;
+	clk_t now;
+	clk_t *tp;
+	struct microstates msp1;
+	static char *statenames[] = {
+		"User",
+		"System",
+		"Interruptible",
+		"Uninterruptible",
+		"OnActiveQueue",
+		"OnExpiredQueue",
+		"Zombie",
+		"Stopped",
+		"Paging",
+		"Futex",
+		"Poll",
+		"Interrupted",
+	};
+  
+	memcpy(&msp1, msp, sizeof(*msp));
+	switch (msp1.cur_state) {
+	case ONCPU_USER:
+	case ONCPU_SYS:
+	case ONACTIVEQUEUE:
+	case ONEXPIREDQUEUE:
+		now = msp1.last_change;
+		break;
+	default:
+		MSA_NOW(now);
+		tp = msp1.timers;
+		tp[msp1.cur_state] += now - msp1.last_change;
+	}
+	return sprintf(buffer, 
+		       "State:         %s\n"		\
+		       "Now:	       %15llu\n"	\
+		       "ONCPU_USER     %15llu\n"	\
+		       "ONCPU_SYS      %15llu\n"	\
+		       "INTERRUPTIBLE  %15llu\n"	\
+		       "UNINTERRUPTIBLE%15llu\n"	\
+		       "INTERRUPTED    %15llu\n"	\
+		       "ACTIVEQUEUE    %15llu\n"	\
+		       "EXPIREDQUEUE   %15llu\n"	\
+		       "STOPPED        %15llu\n"	\
+		       "ZOMBIE         %15llu\n"	\
+		       "SLP_POLL       %15llu\n"	\
+		       "SLP_PAGING     %15llu\n"	\
+		       "SLP_FUTEX      %15llu\n",	\
+		       msp1.cur_state >= 0 && msp1.cur_state < NR_MICRO_STATES ?
+		       statenames[msp1.cur_state] : "Impossible",
+		       (unsigned long long)MSA_TO_NSEC(now),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONCPU_USER]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONCPU_SYS]),
+		       (unsigned long long)MSA_TO_NSEC(tp[INTERRUPTIBLE_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[UNINTERRUPTIBLE_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[INTERRUPTED]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONACTIVEQUEUE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ONEXPIREDQUEUE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[STOPPED]),
+		       (unsigned long long)MSA_TO_NSEC(tp[ZOMBIE]),
+		       (unsigned long long)MSA_TO_NSEC(tp[POLL_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[PAGING_SLEEP]),
+		       (unsigned long long)MSA_TO_NSEC(tp[FUTEX_SLEEP]));
+}
+#endif /* CONFIG_MICROSTATE */
+
 /************************************************************************/
 /*                       Here the fs part begins                        */
 /************************************************************************/
@@ -1228,6 +1306,12 @@
 		case PROC_PID_WCHAN:
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_wchan;
+			break;
+#endif
+#ifdef CONFIG_MICROSTATE
+		case PROC_PID_MSA:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_msa;
 			break;
 #endif
 		default:
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/select.c linux-2.5-ustate+PM/fs/select.c
--- linux-2.5-import/fs/select.c	Tue Aug 19 13:59:15 2003
+++ linux-2.5-ustate+PM/fs/select.c	Thu Jul 24 10:33:09 2003
@@ -253,6 +253,7 @@
 			retval = table.error;
 			break;
 		}
+		msa_next_state(current, POLL_SLEEP);
 		__timeout = schedule_timeout(__timeout);
 	}
 	__set_current_state(TASK_RUNNING);
@@ -443,6 +444,7 @@
 		count = wait->error;
 		if (count)
 			break;
+		msa_next_state(current, POLL_SLEEP);
 		timeout = schedule_timeout(timeout);
 	}
 	__set_current_state(TASK_RUNNING);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-i386/msa.h linux-2.5-ustate+PM/include/asm-i386/msa.h
--- linux-2.5-import/include/asm-i386/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate+PM/include/asm-i386/msa.h	Tue Sep  9 13:46:32 2003
@@ -0,0 +1,40 @@
+/************************************************************************
+ * asm-i386/msa.h
+ *
+ * Provide an architecture-specific clock.
+ */
+
+#ifndef _ASM_I386_MSA_H
+# define _ASM_I386_MSA_H
+
+# ifdef __KERNEL__
+#  include <linux/config.h>
+
+typedef __u64 clk_t;
+
+#  if defined(CONFIG_MICROSTATE_TSC)
+#   include <asm/msr.h>
+#   include <asm/div64.h>
+#   define MSA_NOW(now)  rdtscll(now)
+
+extern unsigned long cpu_khz;
+#   define MSA_TO_NSEC(clk) ({ clk_t _x = ((clk) * 1000000ULL); do_div(_x, cpu_khz); _x; })
+
+#  elif defined(CONFIG_MICROSTATE_PM)
+unsigned long long monotonic_clock(void);
+#   define MSA_NOW(now) do { now = monotonic_clock(); } while (0)
+#   define MSA_TO_NSEC(clk) (clk)
+
+#  elif defined(CONFIG_MICROSTATE_TOD)
+static inline void msa_now(clk_t *nsp) {
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	*nsp = tv.tv_sec * 1000000 + tv.tv_usec;
+}
+#    define MSA_NOW(x) msa_now(&x)
+#    define MSA_TO_NSEC(clk) ((clk) * 1000)
+#  endif
+
+# endif /* _KERNEL */
+
+#endif /* _ASM_I386_MSA_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-i386/unistd.h linux-2.5-ustate+PM/include/asm-i386/unistd.h
--- linux-2.5-import/include/asm-i386/unistd.h	Tue Aug 19 13:59:30 2003
+++ linux-2.5-ustate+PM/include/asm-i386/unistd.h	Fri Sep  5 14:52:43 2003
@@ -278,8 +278,9 @@
 #define __NR_tgkill		270
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
+#define __NR_msa		273
 
-#define NR_syscalls 273
+#define NR_syscalls 274
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-ia64/msa.h linux-2.5-ustate+PM/include/asm-ia64/msa.h
--- linux-2.5-import/include/asm-ia64/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate+PM/include/asm-ia64/msa.h	Tue Sep  9 13:46:32 2003
@@ -0,0 +1,35 @@
+/************************************************************************
+ * asm-ia64/msa.h
+ *
+ * Provide an architecture-specific clock.
+ */
+
+#ifndef _ASM_IA64_MSA_H
+#define _ASM_IA64_MSA_H
+
+#ifdef __KERNEL__
+#include <asm/processor.h>
+#include <asm/timex.h>
+#include <asm/smp.h>
+
+typedef u64 clk_t;
+
+# if defined(MICROSTATE_ITC)
+#   define MSA_NOW(now)  do { now = (clk_t)get_cycles(); } while (0)
+
+#   define MSA_TO_NSEC(clk) ((1000000000*clk) / cpu_data(smp_processor_id())->itc_freq)
+
+# elif defined(MICROSTATE_TOD)
+static inline void msa_now(clk_t *nsp) {
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	*nsp = tv.tv_sec * 1000000 + tv.tv_usec;
+}
+#   define MSA_NOW(x) msa_now(&x)
+#   define MSA_TO_NSEC(clk) ((clk) * 1000)
+
+# endif
+
+#endif /* _KERNEL */
+
+#endif /* _ASM_IA64_MSA_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-ia64/unistd.h linux-2.5-ustate+PM/include/asm-ia64/unistd.h
--- linux-2.5-import/include/asm-ia64/unistd.h	Wed Sep 10 08:49:05 2003
+++ linux-2.5-ustate+PM/include/asm-ia64/unistd.h	Fri Sep 12 10:59:31 2003
@@ -248,10 +248,11 @@
 #define __NR_sys_clock_nanosleep	1256
 #define __NR_sys_fstatfs64		1257
 #define __NR_sys_statfs64		1258
+#define __NR_sys_msa			1260
 
 #ifdef __KERNEL__
 
-#define NR_syscalls			256 /* length of syscall table */
+#define NR_syscalls			273 /* length of syscall table */
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/msa.h linux-2.5-ustate+PM/include/linux/msa.h
--- linux-2.5-import/include/linux/msa.h	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate+PM/include/linux/msa.h	Tue Sep  9 13:46:32 2003
@@ -0,0 +1,137 @@
+/* 
+ * msa.h
+ * microstate accouting 
+ */
+
+#ifndef _LINUX_MSA_H
+#define _LINUX_MSA_H
+#include <config/microstate.h>
+
+#include <asm/msa.h>
+
+extern clk_t msa_last_flip[];
+
+/*
+ * Tracked states
+ */
+
+enum thread_state {
+	UNKNOWN = -1,
+	ONCPU_USER,
+	ONCPU_SYS,
+	INTERRUPTIBLE_SLEEP,
+	UNINTERRUPTIBLE_SLEEP,
+	ONACTIVEQUEUE,
+	ONEXPIREDQUEUE,
+	ZOMBIE,
+	STOPPED,
+	INTERRUPTED,
+	PAGING_SLEEP,
+	FUTEX_SLEEP,
+	POLL_SLEEP,
+	
+	NR_MICRO_STATES /* Must be last */
+};
+
+#define ONCPU ONCPU_USER /* for now... */
+
+/*
+ * Times are tracked for the current task in timers[],
+ * and for the current task's children in child_timers[] (accumulated at wait() time)
+ */
+struct microstates {
+	enum thread_state cur_state;
+	enum thread_state next_state;
+	int lastqueued;
+	unsigned flags;
+	clk_t last_change;
+	clk_t timers[NR_MICRO_STATES];
+	clk_t child_timers[NR_MICRO_STATES];
+};
+
+/*
+ * Values for microstates.flags
+ */
+#define QUEUE_FLIPPED	(1<<0)	/* Active and Expired queues were swapped */
+#define MSA_SYS		(1<<1)	/* this task executing in system call */
+
+/*
+ * A system call for getting the timers.
+ * The number of timers wanted is passed as argument, in case not all 
+ * are needed (and to guard against when we add more timers!)
+ */
+
+#define MSA_SELF 0
+#define MSA_CHILDREN 1
+
+
+#if defined __KERNEL__
+extern long sys_msa(int ntimers, int which, clk_t *timers);
+#if defined(CONFIG_MICROSTATE)
+#include <asm/current.h>
+#include <asm/irq.h>
+
+
+#define MSA_SOFTIRQ NR_IRQS
+
+void msa_init_timer(struct task_struct *task);
+void msa_switch(struct task_struct *prev, struct task_struct *next);
+void msa_update_parent(struct task_struct *parent, struct task_struct *this);
+void msa_init(struct task_struct *p);
+void msa_set_timer(struct task_struct *p, int state);
+void msa_start_irq(int irq);
+void msa_continue_irq(int oldirq, int newirq);
+void msa_finish_irq(int irq);
+void msa_start_syscall(void);
+void msa_end_syscall(void);
+
+clk_t msa_irq_time(int cpu, int irq);
+
+#ifdef TASK_STRUCT_DEFINED
+static inline void msa_next_state(struct task_struct *p, enum thread_state next_state) 
+{
+	p->microstates.next_state = next_state;
+}
+static inline void msa_flip_expired(struct task_struct *prev) {
+	prev->microstates.flags |= QUEUE_FLIPPED;
+}
+
+static inline void msa_syscall(void) {
+	if (current->microstates.cur_state == ONCPU_USER)
+		msa_start_syscall();
+	else
+		msa_end_syscall();
+}
+
+#else
+#define msa_next_state(p, s) ((p)->microstates.next_state = (s))
+#define msa_flip_expired(p) ((p)->microstates.flags |= QUEUE_FLIPPED)
+#define msa_syscall() do { \
+	if (current->microstates.cur_state == ONCPU_USER) \
+		msa_start_syscall(); \
+	else \
+		msa_end_syscall(); \
+} while (0)
+
+#endif
+#else /* CONFIG_MICROSTATE */
+
+
+static inline void msa_switch(struct task_struct *prev, struct task_struct *next) { }
+static inline void msa_update_parent(struct task_struct *parent, struct task_struct *this) { }
+
+static inline void msa_init(struct task_struct *p) { }
+static inline void msa_set_timer(struct task_struct *p, int state) { }
+static inline void msa_start_irq(int irq) { }
+static inline void msa_continue_irq(int oldirq, int newirq) { }
+static inline void msa_finish_irq(int irq) { };
+
+static inline clk_t msa_irq_time(int cpu, int irq) { return 0; }
+static inline void msa_next_state(struct task_struct *p, int s) { }
+static inline void msa_flip_expired(struct task_struct *p) { }
+static inline void msa_start_syscall(void) { }
+static inline void msa_end_syscall(void) { }
+
+#endif /* CONFIG_MICROSTATE */
+#endif /* __KERNEL__ */
+#endif /* _LINUX_MSA_H */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/sched.h linux-2.5-ustate+PM/include/linux/sched.h
--- linux-2.5-import/include/linux/sched.h	Mon Sep  1 19:16:16 2003
+++ linux-2.5-ustate+PM/include/linux/sched.h	Fri Sep  5 14:52:44 2003
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/msa.h>
 
 struct exec_domain;
 
@@ -393,6 +394,9 @@
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
 	u64 start_time;
+#ifdef CONFIG_MICROSTATE
+	struct microstates microstates;
+#endif
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 /* process credentials */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/Makefile linux-2.5-ustate+PM/kernel/Makefile
--- linux-2.5-import/kernel/Makefile	Thu Sep 11 10:16:25 2003
+++ linux-2.5-ustate+PM/kernel/Makefile	Fri Sep 12 10:59:31 2003
@@ -6,7 +6,8 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    msa.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/exit.c linux-2.5-ustate+PM/kernel/exit.c
--- linux-2.5-import/kernel/exit.c	Mon Sep  1 19:16:16 2003
+++ linux-2.5-ustate+PM/kernel/exit.c	Fri Sep  5 14:52:44 2003
@@ -83,6 +83,9 @@
 	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
 	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
 	sched_exit(p);
+
+	msa_update_parent(p->parent, p);
+
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
 	proc_pid_flush(proc_dentry);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/fork.c linux-2.5-ustate+PM/kernel/fork.c
--- linux-2.5-import/kernel/fork.c	Mon Sep  1 19:16:16 2003
+++ linux-2.5-ustate+PM/kernel/fork.c	Fri Sep  5 14:52:44 2003
@@ -824,6 +824,7 @@
 #endif
 	p->did_exec = 0;
 	p->state = TASK_UNINTERRUPTIBLE;
+	msa_init(p);
 
 	copy_flags(clone_flags, p);
 	if (clone_flags & CLONE_IDLETASK)
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/futex.c linux-2.5-ustate+PM/kernel/futex.c
--- linux-2.5-import/kernel/futex.c	Sun Sep  7 11:44:06 2003
+++ linux-2.5-ustate+PM/kernel/futex.c	Tue Sep  9 09:52:50 2003
@@ -38,6 +38,7 @@
 #include <linux/futex.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
+#include <linux/msa.h>
 
 #define FUTEX_HASHBITS 8
 
@@ -374,6 +375,7 @@
 	 */
 	add_wait_queue(&q.waiters, &wait);
 	spin_lock(&futex_lock);
+	msa_next_state(current, FUTEX_SLEEP);
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	if (unlikely(list_empty(&q.list))) {
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/msa.c linux-2.5-ustate+PM/kernel/msa.c
--- linux-2.5-import/kernel/msa.c	Thu Jan  1 10:00:00 1970
+++ linux-2.5-ustate+PM/kernel/msa.c	Tue Aug 26 12:10:00 2003
@@ -0,0 +1,334 @@
+/*
+ * Microstate accounting.
+ * Try to account for various states much more accurately than
+ * the normal code does.
+ */
+
+
+#include <config/microstate.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#ifdef CONFIG_MICROSTATE
+#include <asm/irq.h>
+#include <asm/hardirq.h>
+#include <linux/sched.h>
+#include <asm/uaccess.h>
+#include <linux/jiffies.h>
+
+static clk_t queueflip_time[NR_CPUS];
+
+clk_t msa_irq_times[NR_CPUS][NR_IRQS + 1];
+clk_t msa_irq_entered[NR_CPUS][NR_IRQS + 1];
+int   msa_irq_pids[NR_CPUS][NR_IRQS + 1];
+
+/*
+ * Switch from one task to another.
+ * The retiring task is coming off the processor;
+ * the new task is about to run on the processor.
+ *
+ * Update the time in both.
+ *
+ * We'll eventually account for user and sys time separately.
+ * For now, they're both accumulated into ONCPU_USER.
+ */
+void
+msa_switch(struct task_struct *prev, struct task_struct *next)
+{
+	struct microstates *msprev = &prev->microstates;
+	struct microstates *msnext = &next->microstates;
+	clk_t now;
+	enum thread_state next_state;
+	int interrupted = msprev->cur_state == INTERRUPTED;
+
+	MSA_NOW(now);
+
+	if (msprev->flags & QUEUE_FLIPPED) {
+		queueflip_time[smp_processor_id()] = now;
+		msprev->flags &= ~QUEUE_FLIPPED;
+	}
+
+	/*
+	 * If the queues have been flipped,
+	 * update the state as of the last flip time.
+	 */
+	if (msnext->cur_state == ONEXPIREDQUEUE) {
+		msnext->cur_state = ONACTIVEQUEUE;
+		msnext->timers[ONEXPIREDQUEUE] += queueflip_time[msnext->lastqueued] - msnext->last_change;
+		msnext->last_change = queueflip_time[msnext->lastqueued];
+	}
+
+	msprev->timers[msprev->cur_state] += now - msprev->last_change;
+	msnext->timers[msnext->cur_state] += now - msnext->last_change;
+	
+	/* Update states */
+	switch (msprev->next_state) {
+	case UNKNOWN: /*
+		       * Infer from actual state
+		       */
+		switch (prev->state) {
+		case TASK_INTERRUPTIBLE:
+			next_state = INTERRUPTIBLE_SLEEP;
+			break;
+		
+		case TASK_UNINTERRUPTIBLE:
+			next_state = UNINTERRUPTIBLE_SLEEP;
+			break;
+
+		case TASK_STOPPED:
+			next_state = STOPPED;
+			break;
+
+		case TASK_ZOMBIE:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_DEAD:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_RUNNING:		
+			next_state = ONACTIVEQUEUE;
+			break;
+
+		default:
+			next_state = UNKNOWN;
+			break;
+
+		} 
+		break;
+
+	case PAGING_SLEEP: /*
+			    * Sleep states are PAGING_SLEEP;
+			    * others inferred from task state
+			    */
+		switch(prev->state) {
+		case TASK_INTERRUPTIBLE: /* FALLTHROUGH */
+		case TASK_UNINTERRUPTIBLE:
+			next_state = PAGING_SLEEP;
+			break;
+
+		case TASK_STOPPED:
+			next_state = STOPPED;
+			break;
+
+		case TASK_ZOMBIE:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_DEAD:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_RUNNING:		
+			next_state = ONACTIVEQUEUE;
+			break;
+
+		default:
+			next_state = UNKNOWN;
+			break;
+		}
+		break;
+
+	default: /* Explicitly set next state */
+		next_state = msprev->next_state;
+		msprev->next_state = UNKNOWN;
+		break;
+	}
+
+	msprev->cur_state = next_state;
+	msprev->last_change = now;
+	msprev->lastqueued = smp_processor_id();
+
+	msnext->cur_state = interrupted ? INTERRUPTED : (
+		msnext->flags & MSA_SYS ? ONCPU_SYS : ONCPU_USER);
+	msnext->last_change = now;
+}
+
+/*
+ * Initialise the struct microstates in a new task (called from copy_process())
+ */
+void msa_init(struct task_struct *p)
+{
+	struct microstates *msp = &p->microstates;
+
+	memset(msp, 0, sizeof *msp);
+	MSA_NOW(msp->last_change);
+	msp->cur_state = UNINTERRUPTIBLE_SLEEP;
+	msp->next_state = UNKNOWN;
+}
+
+static void inline __msa_set_timer(struct microstates *msp, int next_state)
+{
+	clk_t now;
+
+	MSA_NOW(now);
+	msp->timers[msp->cur_state] += now - msp->last_change;
+	msp->last_change = now;
+	msp->cur_state = next_state;
+
+}
+
+/*
+ * Time stamp an explicit state change (called, e.g., from __activate_task())
+ */
+void
+msa_set_timer(struct task_struct *p, int next_state)
+{
+	struct microstates *msp = &p->microstates;
+
+	__msa_set_timer(msp, next_state);
+	msp->lastqueued = smp_processor_id();
+	msp->next_state = UNKNOWN;
+}
+
+/*
+ * Helper routines, to be called from assembly language stubs 
+ */
+void msa_start_syscall(void)
+{
+	struct microstates *msp = &current->microstates;
+
+	__msa_set_timer(msp, ONCPU_SYS);
+	msp->flags |= MSA_SYS;
+}
+
+void msa_end_syscall(void)
+{
+	struct microstates *msp = &current->microstates;
+
+	__msa_set_timer(msp, ONCPU_USER);
+	msp->flags &= ~MSA_SYS;
+}
+
+/*
+ * Accumulate child times into parent, after zombie is over.
+ */
+void msa_update_parent(struct task_struct *parent, struct task_struct *this)
+{
+	enum thread_state s;
+	clk_t *msp = parent->microstates.child_timers;
+	struct microstates *mp = &this->microstates;
+	clk_t *msc = mp->timers;
+	clk_t *msgc = mp->child_timers;
+	clk_t now;
+
+	/*
+	 * State could be ZOMBIE (if parent is interested)
+	 * or something else (if the parent isn't interested)
+	 */
+	MSA_NOW(now);
+	msc[mp->cur_state] += now - mp->last_change;
+
+	for (s = 0; s < NR_MICRO_STATES; s++) {
+		*msp++ += *msc++ + *msgc++;
+	}
+}
+
+void msa_start_irq(int irq) 
+{
+	struct task_struct *p = current;
+	struct microstates *mp = &p->microstates;
+	clk_t now;
+	int cpu = smp_processor_id();
+
+	MSA_NOW(now);
+	mp->timers[mp->cur_state] += now - mp->last_change;
+	mp->last_change = now;
+	mp->cur_state = INTERRUPTED;
+
+	msa_irq_entered[cpu][irq] = now;
+	/* DEBUGGING */
+	msa_irq_pids[cpu][irq] = current->pid;
+}
+
+void msa_continue_irq(int oldirq, int newirq) 
+{
+	clk_t now;
+	int cpu = smp_processor_id();
+	MSA_NOW(now);
+
+	msa_irq_times[cpu][oldirq] += now - msa_irq_entered[cpu][oldirq];
+	msa_irq_entered[cpu][newirq] = now;
+	msa_irq_pids[cpu][newirq] = current->pid;
+}
+
+
+void msa_finish_irq(int irq) 
+{
+	struct task_struct *p = current;
+	struct microstates *mp = &p->microstates;
+	clk_t now;
+	int cpu = smp_processor_id();
+
+	MSA_NOW(now);
+
+	/*
+	 * Interrupts can nest.
+	 * Set current state to ONCPU
+	 * iff we're not in a nested interrupt.
+	 */
+	if (irq_count() == 0) {
+		mp->timers[mp->cur_state] += now - mp->last_change;
+		mp->last_change = now;
+		mp->cur_state = ONCPU_USER;
+	}
+	msa_irq_times[cpu][irq] += now - msa_irq_entered[cpu][irq];
+
+}
+
+/* return interrupt handling duration in microseconds */
+clk_t msa_irq_time(int cpu, int irq) 
+{
+	clk_t x = MSA_TO_NSEC(msa_irq_times[cpu][irq]);
+	do_div(x, 1000);
+	return x;
+}
+
+/*
+ * The msa system call --- get microstate data for self or waited-for children.
+ */
+long asmlinkage sys_msa(int ntimers, int which, clk_t __user *timers)
+{
+	clk_t now;
+	clk_t *tp;
+	int i;
+	struct microstates *msp = &current->microstates;
+
+	switch (which) {
+	case MSA_SELF:
+	case MSA_CHILDREN:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ntimers > NR_MICRO_STATES)
+		ntimers = NR_MICRO_STATES;
+	
+	if (which == MSA_SELF) {
+		BUG_ON(msp->cur_state != ONCPU_USER);
+	
+		if (ntimers > 0) {
+			MSA_NOW(now);
+			/* Should be ONCPU_SYS */
+			msp->timers[ONCPU_USER] += now - msp->last_change;
+			msp->last_change = now;
+		}
+	}
+
+	tp = which == MSA_SELF ? msp->timers : msp->child_timers;
+	for (i = 0; i < ntimers; i++) {
+		clk_t x = MSA_TO_NSEC(*tp++);
+		if (copy_to_user(timers++, &x, sizeof x))
+			return -EFAULT;
+	}
+	return 0L;
+}
+
+#else
+asmlinkage long sys_msa(int ntimers, __u64 *timers)
+{
+	return -ENOSYS;
+}
+#endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/kernel/sched.c linux-2.5-ustate+PM/kernel/sched.c
--- linux-2.5-import/kernel/sched.c	Thu Sep 11 10:16:25 2003
+++ linux-2.5-ustate+PM/kernel/sched.c	Fri Sep 12 12:45:02 2003
@@ -335,6 +335,7 @@
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
+	msa_set_timer(p, ONACTIVEQUEUE);
 	enqueue_task(p, rq->active);
 	nr_running_inc(rq);
 }
@@ -558,6 +559,7 @@
 	if (unlikely(!current->array))
 		__activate_task(p, rq);
 	else {
+		msa_set_timer(p, ONACTIVEQUEUE);
 		p->prio = current->prio;
 		list_add_tail(&p->run_list, &current->run_list);
 		p->array = current->array;
@@ -1266,6 +1268,7 @@
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
+			msa_next_state(p, ONEXPIREDQUEUE);
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
@@ -1351,6 +1354,7 @@
 		rq->expired = array;
 		array = rq->active;
 		rq->expired_timestamp = 0;
+		msa_flip_expired(prev);
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -1366,6 +1370,8 @@
 		rq->nr_switches++;
 		rq->curr = next;
 
+		msa_switch(prev, next);
+
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
@@ -2021,6 +2027,7 @@
 	 */
 	if (likely(!rt_task(current))) {
 		dequeue_task(current, array);
+		msa_next_state(current, ONEXPIREDQUEUE);
 		enqueue_task(current, rq->expired);
 	} else {
 		list_del(&current->run_list);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/mm/filemap.c linux-2.5-ustate+PM/mm/filemap.c
--- linux-2.5-import/mm/filemap.c	Thu Sep 11 10:16:25 2003
+++ linux-2.5-ustate+PM/mm/filemap.c	Fri Sep 12 10:59:31 2003
@@ -289,8 +289,11 @@
 	do {
 		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
 		if (test_bit(bit_nr, &page->flags)) {
+			msa_next_state(current, PAGING_SLEEP);
 			sync_page(page);
+			msa_next_state(current, PAGING_SLEEP);
 			io_schedule();
+			msa_next_state(current, UNKNOWN);
 		}
 	} while (test_bit(bit_nr, &page->flags));
 	finish_wait(waitqueue, &wait);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/mm/memory.c linux-2.5-ustate+PM/mm/memory.c
--- linux-2.5-import/mm/memory.c	Sun Sep  7 08:08:39 2003
+++ linux-2.5-ustate+PM/mm/memory.c	Fri Sep 12 11:06:23 2003
@@ -1593,6 +1593,7 @@
 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
 
+	msa_next_state(current, PAGING_SLEEP);
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
@@ -1602,10 +1603,14 @@
 
 	if (pmd) {
 		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
-			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+		if (pte) {
+			int ret = handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+			msa_next_state(current, UNKNOWN);
+			return ret;
+		}
 	}
 	spin_unlock(&mm->page_table_lock);
+	msa_next_state(current, UNKNOWN);
 	return VM_FAULT_OOM;
 }
 

--WXYwVdl7zp--
