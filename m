Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVGUEuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVGUEuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVGUEun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:50:43 -0400
Received: from mail.timesys.com ([65.117.135.102]:127 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261619AbVGUEuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:50:37 -0400
Message-ID: <42DF293A.4050702@timesys.com>
Date: Thu, 21 Jul 2005 00:48:58 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, john cooper <john.cooper@timesys.com>
Subject: 2.6.12 PREEMPT_RT && PPC
References: <200507200816.11386.kernel@kolivas.org>	 <20050719223216.GA4194@elte.hu>	 <1121819037.26927.75.camel@dhcp153.mvista.com>	 <200507201104.48249.kernel@kolivas.org> <1121822524.26927.85.camel@dhcp153.mvista.com>
In-Reply-To: <1121822524.26927.85.camel@dhcp153.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------000506020703010308050208"
X-OriginalArrivalTime: 21 Jul 2005 04:41:24.0593 (UTC) FILETIME=[732AAE10:01C58DAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506020703010308050208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo,
     Attached is a patch for 51-28 which brings PPC
up to date for 2.6.12 PREEMPT_RT.  My goal was to
get a more recent vintage of this work building and
minimally booting for PPC.  Yet this has been stable
even under our internal stress tests.  We now have
this running on 8560 and 8260 PPC targets with a few
others in the pipe.

Remaining are a few known BUG asserts to address,
but as we've historically been chasing seemingly
PPC-specific (or perhaps usage-specific) problems in
a fairly old code base it seemed high time to move
forward.  I've also applied the same patch to 51-33
which not being very far from 51-28 did apply clean,
builds, boots, and appears equally stable as 51-28.

In the process of producing the patch I stumbled
across a change introduced in 51-15 where in the
case of PREEMPT_RT it appears hw_irq_controller.end()
is never being called at the end of do_hardirq().
This appears to be an oversight in the code and
the existing PPC openpic code does register a end()
handler which it expects to be called in order to
terminate the interrupt.  Otherwise interrupts at
the current level are effectively disabled.

There is also what I suspect to be some "leaking"
of the __RAW_LOCAL_ILLEGAL_MASK bit out of the
local_irq*() API primitives as the *flags argument.
This may subsequently be used by non-local_irq*()
primitives and wind up unintentionally setting the
__RAW_LOCAL_ILLEGAL_MASK bit in the machine control
register with unpredictable results.

Lastly there is a problem I've yet to isolate
in kernel/printk.c:release_console_sem() where
the expansion of spin_unlock_irq(&logbuf_lock)
generating a call to __raw_local_irq_enable()
will lockup console output on PPC.  In the
interim this has been reverted to a spin_unlock()
call for the case of PREEMPT_RT && PPC.

Feedback, comments welcome.

-john

-- 
john.cooper@timesys.com




--------------000506020703010308050208
Content-Type: text/plain;
 name="diff.51-28"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.51-28"

./arch/ppc/kernel/entry.S
./arch/ppc/kernel/temp.c
./arch/ppc/kernel/smp.c
./arch/ppc/kernel/dma-mapping.c
./arch/ppc/kernel/process.c
./arch/ppc/kernel/smp-tbsync.c
./arch/ppc/kernel/misc.S
./arch/ppc/kernel/irq.c
./arch/ppc/kernel/idle.c
./arch/ppc/kernel/time.c
./arch/ppc/kernel/traps.c
./arch/ppc/kernel/head_fsl_booke.S
./arch/ppc/mm/fault.c
./arch/ppc/mm/init.c
./arch/ppc/platforms/4xx/xilinx_ml300.c
./arch/ppc/platforms/adir_setup.c
./arch/ppc/platforms/apus_setup.c
./arch/ppc/platforms/chestnut.c
./arch/ppc/platforms/cpci690.c
./arch/ppc/platforms/ev64260.c
./arch/ppc/platforms/gemini_setup.c
./arch/ppc/platforms/hdpu.c
./arch/ppc/platforms/k2.c
./arch/ppc/platforms/lopec.c
./arch/ppc/platforms/mcpn765.c
./arch/ppc/platforms/mvme5100.c
./arch/ppc/platforms/pal4_setup.c
./arch/ppc/platforms/pcore.c
./arch/ppc/platforms/pmac_cpufreq.c
./arch/ppc/platforms/pmac_smp.c
./arch/ppc/platforms/powerpmc250.c
./arch/ppc/platforms/pplus.c
./arch/ppc/platforms/prep_setup.c
./arch/ppc/platforms/prpmc750.c
./arch/ppc/platforms/prpmc800.c
./arch/ppc/platforms/radstone_ppc7d.c
./arch/ppc/platforms/sandpoint.c
./arch/ppc/platforms/spruce.c
./arch/ppc/syslib/ibm440gx_common.c
./arch/ppc/syslib/ibm44x_common.c
./arch/ppc/syslib/m8260_pci_erratum9.c
./arch/ppc/syslib/m8260_setup.c
./arch/ppc/syslib/m8xx_setup.c
./arch/ppc/syslib/mpc52xx_setup.c
./arch/ppc/syslib/ppc4xx_setup.c
./arch/ppc/syslib/ppc83xx_setup.c
./arch/ppc/syslib/ppc85xx_setup.c
./arch/ppc/xmon/xmon.c
./arch/ppc/Kconfig
./drivers/char/blocker.c
./drivers/char/lpptest.c
./include/asm-ppc/thread_info.h
./include/asm-ppc/hw_irq.h
./include/asm-ppc/tlb.h
./include/linux/rt_irq.h
./kernel/irq/manage.c
./kernel/latency.c
./kernel/softirq.c
./kernel/sys.c
./kernel/timer.c
./kernel/printk.c
./lib/Kconfig.debug
=================================================================
--- ./arch/ppc/kernel/entry.S.ORG	2005-07-12 10:19:24.000000000 -0400
+++ ./arch/ppc/kernel/entry.S	2005-07-12 11:29:26.000000000 -0400
@@ -237,7 +237,7 @@ ret_from_syscall:
 	SYNC
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
-	andi.	r0,r9,(_TIF_SYSCALL_TRACE|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	andi.	r0,r9,(_TIF_SYSCALL_TRACE|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
 	bne-	syscall_exit_work
 syscall_exit_cont:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
@@ -313,7 +313,7 @@ syscall_exit_work:
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
 	lwz	r9,TI_FLAGS(r12)
 5:
-	andi.	r0,r9,_TIF_NEED_RESCHED
+	andi.	r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
 	bne	1f
 	lwz	r5,_MSR(r1)
 	andi.	r5,r5,MSR_PR
@@ -653,7 +653,7 @@ user_exc_return:		/* r10 contains MSR_KE
 	/* Check current_thread_info()->flags */
 	rlwinm	r9,r1,0,0,18
 	lwz	r9,TI_FLAGS(r9)
-	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
 	bne	do_work
 
 restore_user:
@@ -902,7 +902,7 @@ load_dbcr0:
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */
 
 do_work:			/* r10 contains MSR_KERNEL here */
-	andi.	r0,r9,_TIF_NEED_RESCHED
+	andi.	r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
 	beq	do_user_signal
 
 do_resched:			/* r10 contains MSR_KERNEL here */
@@ -916,7 +916,7 @@ recheck:
 	MTMSRD(r10)		/* disable interrupts */
 	rlwinm	r9,r1,0,0,18
 	lwz	r9,TI_FLAGS(r9)
-	andi.	r0,r9,_TIF_NEED_RESCHED
+	andi.	r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
 	bne-	do_resched
 	andi.	r0,r9,_TIF_SIGPENDING
 	beq	restore_user
=================================================================
--- ./arch/ppc/kernel/temp.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/kernel/temp.c	2005-07-12 11:29:27.000000000 -0400
@@ -143,7 +143,7 @@ static void tau_timeout(void * info)
 	int shrink;
 
 	/* disabling interrupts *should* be okay */
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	cpu = smp_processor_id();
 
 #ifndef CONFIG_TAU_INT
@@ -186,7 +186,7 @@ static void tau_timeout(void * info)
 	 */
 	mtspr(SPRN_THRM3, THRM3_SITV(500*60) | THRM3_E);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 static void tau_timeout_smp(unsigned long unused)
=================================================================
--- ./arch/ppc/kernel/smp.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/kernel/smp.c	2005-07-12 11:29:27.000000000 -0400
@@ -137,6 +137,11 @@ void smp_send_reschedule(int cpu)
 	smp_message_pass(cpu, PPC_MSG_RESCHEDULE, 0, 0);
 }
 
+/*
+ * this function sends a 'reschedule' IPI to all other CPUs.
+ * This is used when RT tasks are starving and other CPUs
+ * might be able to run them:
+ */
 void smp_send_reschedule_allbutself(void)
 {
 	smp_message_pass(MSG_ALL_BUT_SELF, PPC_MSG_RESCHEDULE, 0, 0);
@@ -151,7 +156,7 @@ void smp_send_xmon_break(int cpu)
 
 static void stop_this_cpu(void *dummy)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1)
 		;
 }
@@ -201,7 +206,7 @@ int smp_call_function(void (*func) (void
 	if (num_online_cpus() <= 1)
 		return 0;
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	WARN_ON(raw_irqs_disabled());
 	return __smp_call_function(func, info, wait, MSG_ALL_BUT_SELF);
 }
 
@@ -342,7 +347,7 @@ int __devinit start_secondary(void *unus
 	printk("CPU %i done callin...\n", cpu);
 	smp_ops->setup_cpu(cpu);
 	printk("CPU %i done setup...\n", cpu);
-	local_irq_enable();
+	raw_local_irq_enable();
 	smp_ops->take_timebase();
 	printk("CPU %i done timebase take...\n", cpu);
 
=================================================================
--- ./arch/ppc/kernel/dma-mapping.c.ORG	2005-07-12 10:19:24.000000000 -0400
+++ ./arch/ppc/kernel/dma-mapping.c	2005-07-12 11:29:27.000000000 -0400
@@ -407,7 +407,7 @@ static inline void __dma_sync_page_highm
 	int nr_segs = PAGE_ALIGN(size + (PAGE_SIZE - offset))/PAGE_SIZE;
 	int seg_nr = 0;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	do {
 		start = (unsigned long)kmap_atomic(page + seg_nr,
@@ -426,7 +426,7 @@ static inline void __dma_sync_page_highm
 		seg_offset = 0;
 	} while (seg_nr < nr_segs);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 #endif /* CONFIG_HIGHMEM */
 
=================================================================
--- ./arch/ppc/kernel/process.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/kernel/process.c	2005-07-12 11:29:27.000000000 -0400
@@ -37,6 +37,8 @@
 #include <linux/kallsyms.h>
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
+#include <linux/init_task.h>
+#include <linux/fs_struct.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -52,8 +54,8 @@ struct task_struct *last_task_used_math 
 struct task_struct *last_task_used_altivec = NULL;
 struct task_struct *last_task_used_spe = NULL;
 
-static struct fs_struct init_fs = INIT_FS;
-static struct files_struct init_files = INIT_FILES;
+static struct fs_struct init_fs = INIT_FS(init_fs);
+static struct files_struct init_files = INIT_FILES(init_files);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
@@ -241,7 +243,7 @@ struct task_struct *__switch_to(struct t
 	unsigned long s;
 	struct task_struct *last;
 
-	local_irq_save(s);
+	raw_local_irq_save(s);
 #ifdef CHECK_STACK
 	check_stack(prev);
 	check_stack(new);
@@ -302,7 +304,7 @@ struct task_struct *__switch_to(struct t
 	new_thread = &new->thread;
 	old_thread = &current->thread;
 	last = _switch(old_thread, new_thread);
-	local_irq_restore(s);
+	raw_local_irq_restore(s);
 	return last;
 }
 
=================================================================
--- ./arch/ppc/kernel/smp-tbsync.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/kernel/smp-tbsync.c	2005-07-12 11:29:27.000000000 -0400
@@ -49,7 +49,7 @@ smp_generic_take_timebase( void )
 {
 	int cmd, tbl, tbu;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	while( !running )
 		;
 	rmb();
@@ -78,7 +78,7 @@ smp_generic_take_timebase( void )
 		}
 		enter_contest( tbsync->mark, -1 );
 	}
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 static int __devinit
@@ -88,7 +88,7 @@ start_contest( int cmd, int offset, int 
 
 	tbsync->cmd = cmd;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	for( i=-3; i<num; ) {
 		tbl = get_tbl() + 400;
 		tbsync->tbu = tbu = get_tbu();
@@ -114,7 +114,7 @@ start_contest( int cmd, int offset, int 
 		if( i++ > 0 )
 			score += tbsync->race_result;
 	}
-	local_irq_enable();
+	raw_local_irq_enable();
 	return score;
 }
 
=================================================================
--- ./arch/ppc/kernel/misc.S.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/kernel/misc.S	2005-07-12 11:29:27.000000000 -0400
@@ -302,8 +302,8 @@ _GLOBAL(local_save_flags_ptr)
 	nop
 _GLOBAL(local_save_flags_ptr_end)
 
-/* void local_irq_restore(unsigned long flags) */
-_GLOBAL(local_irq_restore)
+/* void __raw_local_irq_restore(unsigned long flags) */
+_GLOBAL(__raw_local_irq_restore)
 /*
  * Just set/clear the MSR_EE bit through restore/flags but do not
  * change anything else.  This is needed by the RT system and makes
@@ -341,9 +341,9 @@ _GLOBAL(local_irq_restore)
 	nop
 	nop
 	nop
-_GLOBAL(local_irq_restore_end)
+_GLOBAL(__raw_local_irq_restore_end)
 
-_GLOBAL(local_irq_disable)
+_GLOBAL(__raw_local_irq_disable)
 	mfmsr	r0		/* Get current interrupt state */
 	rlwinm	r3,r0,16+1,32-1,31	/* Extract old value of 'EE' */
 	rlwinm	r0,r0,0,17,15	/* clear MSR_EE in r0 */
@@ -370,9 +370,9 @@ _GLOBAL(local_irq_disable)
 	nop
 	nop
 	nop
-_GLOBAL(local_irq_disable_end)
+_GLOBAL(__raw_local_irq_disable_end)
 
-_GLOBAL(local_irq_enable)
+_GLOBAL(__raw_local_irq_enable)
 	mfmsr	r3		/* Get current state */
 	ori	r3,r3,MSR_EE	/* Turn on 'EE' bit */
 	SYNC			/* Some chip revs have problems here... */
@@ -399,7 +399,7 @@ _GLOBAL(local_irq_enable)
 	nop
 	nop
 	nop
-_GLOBAL(local_irq_enable_end)
+_GLOBAL(__raw_local_irq_enable_end)
 
 /*
  * complement mask on the msr then "or" some values on.
=================================================================
--- ./arch/ppc/kernel/irq.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/kernel/irq.c	2005-07-21 00:12:15.000000000 -0400
@@ -138,6 +138,7 @@ skip:
 void do_IRQ(struct pt_regs *regs)
 {
 	int irq, first = 1;
+
         irq_enter();
 
 	/*
@@ -149,6 +150,7 @@ void do_IRQ(struct pt_regs *regs)
 	 * has already been handled. -- Tom
 	 */
 	while ((irq = ppc_md.get_irq(regs)) >= 0) {
+		trace_special(regs->nip, irq, 0);
 		__do_IRQ(irq, regs);
 		first = 0;
 	}
=================================================================
--- ./arch/ppc/kernel/idle.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/kernel/idle.c	2005-07-12 11:29:27.000000000 -0400
@@ -38,7 +38,7 @@ void default_idle(void)
 
 	powersave = ppc_md.power_save;
 
-	if (!need_resched()) {
+	if (!need_resched() && !need_resched_delayed()) {
 		if (powersave != NULL)
 			powersave();
 #ifdef CONFIG_SMP
@@ -50,8 +50,11 @@ void default_idle(void)
 		}
 #endif
 	}
-	if (need_resched())
-		schedule();
+	if (need_resched()) {
+		raw_local_irq_disable();
+		__schedule();
+		raw_local_irq_enable();
+	}
 }
 
 /*
@@ -59,11 +62,15 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
-	for (;;)
+	for (;;) {
+		BUG_ON(raw_irqs_disabled());
+		stop_critical_timing();
+		propagate_preempt_locks_value();
 		if (ppc_md.idle != NULL)
 			ppc_md.idle();
 		else
 			default_idle();
+	}
 }
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_6xx)
=================================================================
--- ./arch/ppc/kernel/time.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/kernel/time.c	2005-07-12 11:29:27.000000000 -0400
@@ -108,7 +108,7 @@ static inline int tb_delta(unsigned *jif
 }
 
 #ifdef CONFIG_SMP
-unsigned long profile_pc(struct pt_regs *regs)
+unsigned long notrace profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
 
=================================================================
--- ./arch/ppc/kernel/traps.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/kernel/traps.c	2005-07-12 11:29:27.000000000 -0400
@@ -111,6 +111,10 @@ void _exception(int signr, struct pt_reg
 		debugger(regs);
 		die("Exception in kernel mode", regs, signr);
 	}
+#ifdef CONFIG_PREEMPT_RT
+	raw_local_irq_enable();
+	preempt_check_resched();
+#endif
 	info.si_signo = signr;
 	info.si_errno = 0;
 	info.si_code = code;
=================================================================
=================================================================
--- ./arch/ppc/mm/fault.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/mm/fault.c	2005-07-12 11:29:27.000000000 -0400
@@ -92,7 +92,7 @@ static int store_updates_sp(struct pt_re
  * the error_code parameter is ESR for a data fault, 0 for an instruction
  * fault.
  */
-int do_page_fault(struct pt_regs *regs, unsigned long address,
+int notrace do_page_fault(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code)
 {
 	struct vm_area_struct * vma;
=================================================================
--- ./arch/ppc/mm/init.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/mm/init.c	2005-07-13 17:53:56.000000000 -0400
@@ -56,7 +56,7 @@
 #endif
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
 
 unsigned long total_memory;
 unsigned long total_lowmem;
=================================================================
--- ./arch/ppc/platforms/4xx/xilinx_ml300.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/4xx/xilinx_ml300.c	2005-07-12 11:29:27.000000000 -0400
@@ -62,7 +62,7 @@ static volatile unsigned *powerdown_base
 static void
 xilinx_power_off(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
 	while (1) ;
 }
=================================================================
--- ./arch/ppc/platforms/adir_setup.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/adir_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -134,7 +134,7 @@ adir_setup_arch(void)
 static void
 adir_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	/* SRR0 has system reset vector, SRR1 has default MSR value */
 	/* rfi restores MSR from SRR1 and sets the PC to the SRR0 value */
 	__asm__ __volatile__
=================================================================
--- ./arch/ppc/platforms/apus_setup.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/apus_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -481,7 +481,7 @@ void cache_clear(__u32 addr, int length)
 void
 apus_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	APUS_WRITE(APUS_REG_LOCK,
 		   REGLOCK_BLACKMAGICK1|REGLOCK_BLACKMAGICK2);
@@ -599,7 +599,7 @@ int __debug_serinit( void )
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	/* turn off Rx and Tx interrupts */
 	custom.intena = IF_RBF | IF_TBE;
@@ -607,7 +607,7 @@ int __debug_serinit( void )
 	/* clear any pending interrupt */
 	custom.intreq = IF_RBF | IF_TBE;
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	/*
 	 * set the appropriate directions for the modem control flags,
=================================================================
--- ./arch/ppc/platforms/chestnut.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/chestnut.c	2005-07-12 11:29:27.000000000 -0400
@@ -456,7 +456,7 @@ chestnut_restart(char *cmd)
 {
 	volatile ulong i = 10000000;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
         /*
          * Set CPLD Reg 3 bit 0 to 1 to allow MPP signals on reset to work
@@ -475,7 +475,7 @@ chestnut_restart(char *cmd)
 static void
 chestnut_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for (;;);
 	/* NOTREACHED */
 }
=================================================================
--- ./arch/ppc/platforms/cpci690.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/cpci690.c	2005-07-12 11:29:27.000000000 -0400
@@ -364,7 +364,7 @@ cpci690_reset_board(void)
 {
 	u32	i = 10000;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	out_8((u8 *)(cpci690_br_base + CPCI690_BR_SW_RESET), 0x11);
 
 	while (i != 0) i++;
=================================================================
--- ./arch/ppc/platforms/ev64260.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/ev64260.c	2005-07-12 11:29:27.000000000 -0400
@@ -445,7 +445,7 @@ ev64260_platform_notify(struct device *d
 static void
 ev64260_reset_board(void *addr)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* disable and invalidate the L2 cache */
 	_set_L2CR(0);
@@ -513,7 +513,7 @@ ev64260_restart(char *cmd)
 static void
 ev64260_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1);
 	/* NOTREACHED */
 }
=================================================================
--- ./arch/ppc/platforms/gemini_setup.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/gemini_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -303,7 +303,7 @@ void __init gemini_init_l2(void)
 void
 gemini_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	/* make a clean restart, not via the MPIC */
 	_gemini_reboot();
 	for(;;);
=================================================================
--- ./arch/ppc/platforms/hdpu.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/hdpu.c	2005-07-12 11:29:27.000000000 -0400
@@ -473,7 +473,7 @@ static void hdpu_reset_board(void)
 
 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_RESET);
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* Clear all the LEDs */
 	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, ((1 << 4) |
@@ -515,7 +515,7 @@ static void hdpu_restart(char *cmd)
 
 static void hdpu_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	hdpu_cpustate_set(CPUSTATE_KERNEL_MAJOR | CPUSTATE_KERNEL_HALT);
 
=================================================================
--- ./arch/ppc/platforms/k2.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/k2.c	2005-07-12 11:29:27.000000000 -0400
@@ -480,7 +480,7 @@ static void __init k2_setup_arch(void)
 
 static void k2_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* Flip FLASH back to page 1 to access firmware image */
 	__raw_writel(0, GPOUT);
=================================================================
--- ./arch/ppc/platforms/lopec.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/lopec.c	2005-07-12 11:29:27.000000000 -0400
@@ -162,7 +162,7 @@ lopec_restart(char *cmd)
 	reg |= 0x80;
 	*((unsigned char *) LOPEC_SYSSTAT1) = reg;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	while(1);
 #undef LOPEC_SYSSTAT1
 }
@@ -170,7 +170,7 @@ lopec_restart(char *cmd)
 static void
 lopec_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while(1);
 }
 
=================================================================
--- ./arch/ppc/platforms/mcpn765.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/mcpn765.c	2005-07-12 11:29:27.000000000 -0400
@@ -415,7 +415,7 @@ mcpn765_map_io(void)
 static void
 mcpn765_reset_board(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* set VIA IDE controller into native mode */
 	mcpn765_set_VIA_IDE_native();
@@ -449,7 +449,7 @@ mcpn765_power_off(void)
 static void
 mcpn765_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1);
 	/* NOTREACHED */
 }
=================================================================
--- ./arch/ppc/platforms/mvme5100.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/mvme5100.c	2005-07-12 11:29:27.000000000 -0400
@@ -267,7 +267,7 @@ mvme5100_map_io(void)
 static void
 mvme5100_reset_board(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* Set exception prefix high - to the firmware */
 	_nmask_and_or_msr(0, MSR_IP);
@@ -291,7 +291,7 @@ mvme5100_restart(char *cmd)
 static void
 mvme5100_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1);
 }
 
=================================================================
--- ./arch/ppc/platforms/pal4_setup.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/pal4_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -81,7 +81,7 @@ pal4_show_cpuinfo(struct seq_file *m)
 static void
 pal4_restart(char *cmd)
 {
-        local_irq_disable();
+        raw_local_irq_disable();
         __asm__ __volatile__("lis  3,0xfff0\n \
                               ori  3,3,0x100\n \
                               mtspr 26,3\n \
@@ -95,7 +95,7 @@ pal4_restart(char *cmd)
 static void
 pal4_power_off(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for(;;);
 }
 
=================================================================
--- ./arch/ppc/platforms/pcore.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/pcore.c	2005-07-12 11:29:27.000000000 -0400
@@ -242,7 +242,7 @@ pcore_setup_arch(void)
 static void
 pcore_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	/* Hard reset */
 	writeb(0x11, 0xfe000332);
 	while(1);
@@ -251,7 +251,7 @@ pcore_restart(char *cmd)
 static void
 pcore_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	/* Turn off user LEDs */
 	writeb(0x00, 0xfe000300);
 	while (1);
=================================================================
--- ./arch/ppc/platforms/pmac_cpufreq.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/pmac_cpufreq.c	2005-07-12 11:29:27.000000000 -0400
@@ -285,7 +285,7 @@ static int __pmac pmu_set_cpu_speed(int 
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
 
 	/* We can now disable MSR_EE */
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	/* Giveup the FPU & vec */
 	enable_kernel_fp();
@@ -341,7 +341,7 @@ static int __pmac pmu_set_cpu_speed(int 
  	openpic_set_priority(pic_prio);
 
 	/* Let interrupts flow again ... */
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 #ifdef DEBUG_FREQ
 	debug_calc_bogomips();
=================================================================
--- ./arch/ppc/platforms/pmac_smp.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/pmac_smp.c	2005-07-12 11:29:27.000000000 -0400
@@ -511,8 +511,8 @@ static void __init smp_core99_kick_cpu(i
 		return;
 	if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu", 0x346);
 
-	local_irq_save(flags);
-	local_irq_disable();
+	raw_local_irq_save(flags);
+	raw_local_irq_disable();
 
 	/* Save reset vector */
 	save_vector = *vector;
@@ -550,7 +550,7 @@ static void __init smp_core99_kick_cpu(i
 	*vector = save_vector;
 	flush_icache_range((unsigned long) vector, (unsigned long) vector + 4);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 	if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu done", 0x347);
 }
 
@@ -592,7 +592,7 @@ void smp_core99_take_timebase(void)
 		mb();
 
 	/* set our stuff the same as the primary */
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	set_dec(1);
 	set_tb(pri_tb_hi, pri_tb_lo);
 	last_jiffy_stamp(smp_processor_id()) = pri_tb_stamp;
@@ -601,7 +601,7 @@ void smp_core99_take_timebase(void)
 	/* tell the primary we're done */
        	sec_tb_reset = 0;
 	mb();
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 /* not __init, called in sleep/wakeup code */
@@ -621,7 +621,7 @@ void smp_core99_give_timebase(void)
 	/* freeze the timebase and read it */
 	/* disable interrupts so the timebase is disabled for the
 	   shortest possible time */
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 4);
 	pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, core99_tb_gpio, 0);
 	mb();
@@ -645,7 +645,7 @@ void smp_core99_give_timebase(void)
 	/* Now, restart the timebase by leaving the GPIO to an open collector */
        	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 0);
         pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, core99_tb_gpio, 0);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 
=================================================================
--- ./arch/ppc/platforms/powerpmc250.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/powerpmc250.c	2005-07-12 11:29:27.000000000 -0400
@@ -173,7 +173,7 @@ powerpmc250_calibrate_decr(void)
 static void
 powerpmc250_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	/* Hard reset */
 	writeb(0x11, 0xfe000332);
 	while(1);
@@ -182,7 +182,7 @@ powerpmc250_restart(char *cmd)
 static void
 powerpmc250_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1);
 }
 
=================================================================
--- ./arch/ppc/platforms/pplus.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/pplus.c	2005-07-12 11:29:27.000000000 -0400
@@ -608,7 +608,7 @@ static void pplus_restart(char *cmd)
 {
 	unsigned long i = 10000;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* set VIA IDE controller into native mode */
 	pplus_set_VIA_IDE_native();
=================================================================
--- ./arch/ppc/platforms/prep_setup.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/prep_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -458,7 +458,7 @@ static void __prep
 prep_restart(char *cmd)
 {
 #define PREP_SP92	0x92	/* Special Port 92 */
-	local_irq_disable(); /* no interrupts */
+	raw_local_irq_disable(); /* no interrupts */
 
 	/* set exception prefix high - to the prom */
 	_nmask_and_or_msr(0, MSR_IP);
@@ -476,7 +476,7 @@ prep_restart(char *cmd)
 static void __prep
 prep_halt(void)
 {
-	local_irq_disable(); /* no interrupts */
+	raw_local_irq_disable(); /* no interrupts */
 
 	/* set exception prefix high - to the prom */
 	_nmask_and_or_msr(0, MSR_IP);
@@ -544,7 +544,7 @@ prep_sig750_poweroff(void)
 {
 	/* tweak the power manager found in most IBM PRePs (except Thinkpads) */
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	/* set exception prefix high - to the prom */
 	_nmask_and_or_msr(0, MSR_IP);
 
=================================================================
--- ./arch/ppc/platforms/prpmc750.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/prpmc750.c	2005-07-12 11:29:27.000000000 -0400
@@ -276,14 +276,14 @@ static void __init prpmc750_calibrate_de
 
 static void prpmc750_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	writeb(PRPMC750_MODRST_MASK, PRPMC750_MODRST_REG);
 	while (1) ;
 }
 
 static void prpmc750_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1) ;
 }
 
=================================================================
--- ./arch/ppc/platforms/prpmc800.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/prpmc800.c	2005-07-12 11:29:27.000000000 -0400
@@ -379,7 +379,7 @@ static void prpmc800_restart(char *cmd)
 {
 	ulong temp;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	temp = in_be32((uint *) HARRIER_MISC_CSR_REG);
 	temp |= HARRIER_RSTOUT;
 	out_be32((uint *) HARRIER_MISC_CSR_REG, temp);
@@ -388,7 +388,7 @@ static void prpmc800_restart(char *cmd)
 
 static void prpmc800_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1) ;
 }
 
=================================================================
--- ./arch/ppc/platforms/radstone_ppc7d.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/radstone_ppc7d.c	2005-07-12 11:29:27.000000000 -0400
@@ -177,7 +177,7 @@ static void ppc7d_power_off(void)
 {
 	u32 data;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* Ensure that internal MV643XX watchdog is disabled.
 	 * The Disco watchdog uses MPP17 on this hardware.
=================================================================
--- ./arch/ppc/platforms/sandpoint.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/platforms/sandpoint.c	2005-07-12 11:29:27.000000000 -0400
@@ -521,7 +521,7 @@ sandpoint_map_io(void)
 static void
 sandpoint_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* Set exception prefix high - to the firmware */
 	_nmask_and_or_msr(0, MSR_IP);
@@ -535,7 +535,7 @@ sandpoint_restart(char *cmd)
 static void
 sandpoint_power_off(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for(;;);	/* No way to shut power off with software */
 	/* NOTREACHED */
 }
=================================================================
--- ./arch/ppc/platforms/spruce.c.ORG	2005-07-12 10:19:25.000000000 -0400
+++ ./arch/ppc/platforms/spruce.c	2005-07-12 11:29:27.000000000 -0400
@@ -237,7 +237,7 @@ spruce_setup_arch(void)
 static void
 spruce_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* SRR0 has system reset vector, SRR1 has default MSR value */
 	/* rfi restores MSR from SRR1 and sets the PC to the SRR0 value */
=================================================================
--- ./arch/ppc/syslib/ibm440gx_common.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/syslib/ibm440gx_common.c	2005-07-12 11:29:27.000000000 -0400
@@ -142,7 +142,7 @@ void __init ibm440gx_l2c_enable(void){
 		return;
 	}
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	asm volatile ("sync" ::: "memory");
 
 	/* Disable SRAM */
@@ -186,7 +186,7 @@ void __init ibm440gx_l2c_enable(void){
 	mtdcr(DCRN_L2C0_CFG, r);
 
 	asm volatile ("sync; isync" ::: "memory");
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 /* Disable L2 cache */
@@ -194,7 +194,7 @@ void __init ibm440gx_l2c_disable(void){
 	u32 r;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	asm volatile ("sync" ::: "memory");
 
 	/* Disable L2C mode */
@@ -213,7 +213,7 @@ void __init ibm440gx_l2c_disable(void){
 	      SRAM_SBCR_BAS3 | SRAM_SBCR_BS_64KB | SRAM_SBCR_BU_RW);
 
 	asm volatile ("sync; isync" ::: "memory");
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 void __init ibm440gx_l2c_setup(struct ibm44x_clocks* p)
=================================================================
--- ./arch/ppc/syslib/ibm44x_common.c.ORG	2005-07-12 10:19:26.000000000 -0400
+++ ./arch/ppc/syslib/ibm44x_common.c	2005-07-12 11:29:27.000000000 -0400
@@ -77,19 +77,19 @@ extern void abort(void);
 
 static void ibm44x_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	abort();
 }
 
 static void ibm44x_power_off(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for(;;);
 }
 
 static void ibm44x_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for(;;);
 }
 
=================================================================
--- ./arch/ppc/syslib/m8260_pci_erratum9.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/syslib/m8260_pci_erratum9.c	2005-07-12 11:29:27.000000000 -0400
@@ -132,7 +132,7 @@ idma_pci9_read(u8 *dst, u8 *src, int byt
 	volatile idma_bd_t *bd = &idma_dpram->bd;
 	volatile cpm2_map_t *immap = cpm2_immr;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	/* initialize IDMA parameter RAM for this transfer */
 	if (sinc)
@@ -161,7 +161,7 @@ idma_pci9_read(u8 *dst, u8 *src, int byt
 	/* wait for transfer to complete */
 	while(bd->flags & IDMA_BD_V);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return;
 }
@@ -184,7 +184,7 @@ idma_pci9_write(u8 *dst, u8 *src, int by
 	volatile idma_bd_t *bd = &idma_dpram->bd;
 	volatile cpm2_map_t *immap = cpm2_immr;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	/* initialize IDMA parameter RAM for this transfer */
 	if (dinc)
@@ -213,7 +213,7 @@ idma_pci9_write(u8 *dst, u8 *src, int by
 	/* wait for transfer to complete */
 	while(bd->flags & IDMA_BD_V);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return;
 }
=================================================================
--- ./arch/ppc/syslib/m8260_setup.c.ORG	2005-07-12 10:19:26.000000000 -0400
+++ ./arch/ppc/syslib/m8260_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -130,7 +130,7 @@ m8260_restart(char *cmd)
 static void
 m8260_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1);
 }
 
=================================================================
--- ./arch/ppc/syslib/m8xx_setup.c.ORG	2005-07-12 10:19:26.000000000 -0400
+++ ./arch/ppc/syslib/m8xx_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -239,7 +239,7 @@ m8xx_restart(char *cmd)
 {
 	__volatile__ unsigned char dummy;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;
 
 	/* Clear the ME bit in MSR to cause checkstop on machine check
=================================================================
--- ./arch/ppc/syslib/mpc52xx_setup.c.ORG	2005-07-12 10:19:26.000000000 -0400
+++ ./arch/ppc/syslib/mpc52xx_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -40,7 +40,7 @@ mpc52xx_restart(char *cmd)
 {
 	struct mpc52xx_gpt __iomem *gpt0 = MPC52xx_VA(MPC52xx_GPTx_OFFSET(0));
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/* Turn on the watchdog and wait for it to expire. It effectively
 	  does a reset */
@@ -53,7 +53,7 @@ mpc52xx_restart(char *cmd)
 void
 mpc52xx_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	while (1);
 }
=================================================================
--- ./arch/ppc/syslib/ppc4xx_setup.c.ORG	2005-07-12 10:19:26.000000000 -0400
+++ ./arch/ppc/syslib/ppc4xx_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -147,7 +147,7 @@ static void
 ppc4xx_power_off(void)
 {
 	printk("System Halted\n");
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1) ;
 }
 
@@ -155,7 +155,7 @@ static void
 ppc4xx_halt(void)
 {
 	printk("System Halted\n");
-	local_irq_disable();
+	raw_local_irq_disable();
 	while (1) ;
 }
 
=================================================================
--- ./arch/ppc/syslib/ppc83xx_setup.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/syslib/ppc83xx_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -123,7 +123,7 @@ mpc83xx_restart(char *cmd)
 
 	reg = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	/*
 	 * Unlock the BCSR bits so a PRST will update the contents.
@@ -152,14 +152,14 @@ mpc83xx_restart(char *cmd)
 void
 mpc83xx_power_off(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for(;;);
 }
 
 void
 mpc83xx_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for(;;);
 }
 
=================================================================
--- ./arch/ppc/syslib/ppc85xx_setup.c.ORG	2005-07-12 10:19:26.000000000 -0400
+++ ./arch/ppc/syslib/ppc85xx_setup.c	2005-07-12 11:29:27.000000000 -0400
@@ -114,21 +114,21 @@ mpc85xx_early_serial_map(void)
 void
 mpc85xx_restart(char *cmd)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	abort();
 }
 
 void
 mpc85xx_power_off(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for(;;);
 }
 
 void
 mpc85xx_halt(void)
 {
-	local_irq_disable();
+	raw_local_irq_disable();
 	for(;;);
 }
 
=================================================================
--- ./arch/ppc/xmon/xmon.c.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./arch/ppc/xmon/xmon.c	2005-07-12 11:29:27.000000000 -0400
@@ -266,10 +266,10 @@ irqreturn_t
 xmon_irq(int irq, void *d, struct pt_regs *regs)
 {
 	unsigned long flags;
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	printf("Keyboard interrupt\n");
 	xmon(regs);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 	return IRQ_HANDLED;
 }
 
=================================================================
--- ./arch/ppc/Kconfig.ORG	2005-07-12 10:19:24.000000000 -0400
+++ ./arch/ppc/Kconfig	2005-07-12 11:29:27.000000000 -0400
@@ -15,20 +15,6 @@ config GENERIC_HARDIRQS
 	bool
 	default y
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	depends on !PREEMPT_RT
-
-config ASM_SEMAPHORES
-	bool
-	depends on !PREEMPT_RT
-	default y
-
-config RWSEM_XCHGADD_ALGORITHM
-	bool
-	depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
@@ -904,7 +890,21 @@ config NR_CPUS
 	depends on SMP
 	default "4"
 
-source "lib/Kconfig.RT"
+source "kernel/Kconfig.preempt"
+
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	depends on !PREEMPT_RT
+
+config ASM_SEMAPHORES
+	bool
+	depends on !PREEMPT_RT
+	default y
+
+config RWSEM_XCHGADD_ALGORITHM
+	bool
+	depends on !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT
+	default y
 
 config HIGHMEM
 	bool "High memory support"
=================================================================
--- ./drivers/char/blocker.c.ORG	2005-07-12 10:19:28.000000000 -0400
+++ ./drivers/char/blocker.c	2005-07-12 11:29:27.000000000 -0400
@@ -4,6 +4,7 @@
 
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <asm/time.h>
 
 #define BLOCKER_MINOR		221
 
@@ -12,13 +13,25 @@
 
 #define MAX_LOCK_DEPTH		10
 
-u64 notrace get_cpu_tick(void)
+/* this needs to be reconciled with driver/char/lpptest.c
+ */
+static inline u64 notrace get_cpu_tick(void)
 {
 	u64 tsc;
-#ifdef ARCHARM
+#if defined(CONFIG_X86)
+	__asm__ __volatile__("rdtsc" : "=A" (tsc));
+#elif defined(CONFIG_PPC)
+	unsigned long hi, lo;
+
+	do {
+		hi = get_tbu();
+		lo = get_tbl();
+	} while (get_tbu() != hi);
+	tsc = (u64)hi << 32 | lo;
+#elif defined(CONFIG_ARM)
 	tsc = *oscr;
 #else
-	__asm__ __volatile__("rdtsc" : "=A" (tsc));
+	#error Implement get_cpu_tick()
 #endif
 	return tsc;
 }
=================================================================
--- ./drivers/char/lpptest.c.ORG	2005-07-12 10:19:28.000000000 -0400
+++ ./drivers/char/lpptest.c	2005-07-12 11:29:28.000000000 -0400
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/time.h>
 
 #define LPPTEST_CHAR_MAJOR 245
 #define LPPTEST_DEVICE_NAME "lpptest"
@@ -39,6 +40,29 @@ static char dev_id[] = "lpptest";
 
 static unsigned char out = 0x5a;
 
+/* this needs to be reconciled with driver/char/blocker.c
+ */
+static inline u64 notrace get_cpu_tick(void)
+{
+	u64 tsc;
+#if defined(CONFIG_X86)
+	__asm__ __volatile__("rdtsc" : "=A" (tsc));
+#elif defined(CONFIG_PPC)
+	unsigned long hi, lo;
+
+	do {
+		hi = get_tbu();
+		lo = get_tbl();
+	} while (get_tbu() != hi);
+	tsc = (u64)hi << 32 | lo;
+#elif defined(CONFIG_ARM)
+	tsc = *oscr;
+#else
+	#error Implement get_cpu_tick()
+#endif
+	return tsc;
+}
+
 /**
  * Interrupt handler. Flip a bit in the reply.
  */
@@ -60,7 +84,7 @@ static cycles_t test_response(void)
 	in = inb(0x379);
 	inb(0x378);
 	outb(0x08, 0x378);
-	rdtscll(now);
+	now = get_cpu_tick();
 	while(1) {
     		if (inb(0x379) != in)
 			break;
@@ -71,7 +95,7 @@ static cycles_t test_response(void)
 			return 0;
 		}
 	}
-	rdtscll(end);
+	end = get_cpu_tick();
 	outb(0x00, 0x378);
 	local_irq_enable();
 
=================================================================
--- ./include/asm-ppc/thread_info.h.ORG	2005-06-17 15:48:29.000000000 -0400
+++ ./include/asm-ppc/thread_info.h	2005-07-12 11:29:28.000000000 -0400
@@ -77,12 +77,14 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_NEED_RESCHED_DELAYED 6     /* reschedule on return to userspace */
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_NEED_RESCHED_DELAYED (1<<TIF_NEED_RESCHED_DELAYED)
 
 /*
  * Non racy (local) flags bit numbers
=================================================================
--- ./include/asm-ppc/hw_irq.h.ORG	2005-07-12 10:19:38.000000000 -0400
+++ ./include/asm-ppc/hw_irq.h	2005-07-15 22:43:55.000000000 -0400
@@ -7,33 +7,36 @@
 
 #include <asm/ptrace.h>
 #include <asm/reg.h>
+#include <linux/rt_irq.h>
 
 extern void timer_interrupt(struct pt_regs *);
 
 #define INLINE_IRQS
 
-#define irqs_disabled()	((mfmsr() & MSR_EE) == 0)
-#define irqs_disabled_flags(flags)	((flags & MSR_EE) == 0)
+#define __raw_irqs_disabled()	((mfmsr() & MSR_EE) == 0)
+#define __raw_irqs_disabled_flags(flags)	((flags & MSR_EE) == 0)
 
-#ifdef INLINE_IRQS
+#if defined(INLINE_IRQS) || defined(CONFIG_PREEMPT_RT)
 
-static inline void local_irq_disable(void)
+static inline void __raw_local_irq_disable(void)
 {
 	unsigned long msr;
 	msr = mfmsr();
 	mtmsr(msr & ~MSR_EE);
 	__asm__ __volatile__("": : :"memory");
+	trace_irqs_off();
 }
 
-static inline void local_irq_enable(void)
+static inline void __raw_local_irq_enable(void)
 {
 	unsigned long msr;
+	trace_irqs_on();
 	__asm__ __volatile__("": : :"memory");
 	msr = mfmsr();
 	mtmsr(msr | MSR_EE);
 }
 
-static inline void local_irq_save_ptr(unsigned long *flags)
+static inline void __raw_local_irq_save_ptr(unsigned long *flags)
 {
 	unsigned long msr;
 	msr = mfmsr();
@@ -42,9 +45,13 @@ static inline void local_irq_save_ptr(un
 	__asm__ __volatile__("": : :"memory");
 }
 
-#define local_save_flags(flags)		((flags) = mfmsr())
-#define local_irq_save(flags)		local_irq_save_ptr(&flags)
-#define local_irq_restore(flags)	mtmsr(flags)
+/* for debugging purposes - a bit that is otherwise illegal
+ */
+#define __RAW_LOCAL_ILLEGAL_MASK        (1 << 17)
+
+#define __raw_local_save_flags(flags)	((flags) = mfmsr())
+#define __raw_local_irq_save(flags)	__raw_local_irq_save_ptr(&flags)
+#define __raw_local_irq_restore(flags)	mtmsr(flags)
 
 #else
 
=================================================================
=================================================================
--- ./include/linux/rt_irq.h.ORG	2005-07-12 10:19:39.000000000 -0400
+++ ./include/linux/rt_irq.h	2005-07-12 11:29:28.000000000 -0400
@@ -20,7 +20,13 @@ extern int irqs_disabled_flags(unsigned 
 
 # define RAW_LOCAL_ILLEGAL_MASK		__RAW_LOCAL_ILLEGAL_MASK
 # ifdef CONFIG_DEBUG_IRQ_FLAGS
-#  define LOCAL_ILLEGAL_MASK		0x40000000
+#  if defined(CONFIG_X86)
+#   define LOCAL_ILLEGAL_MASK		0x40000000
+#  elif defined(CONFIG_PPC)
+#   define LOCAL_ILLEGAL_MASK		0x10000000
+#  else
+#   error LOCAL_ILLEGAL_MASK undefined for this architecture
+#  endif
    void check_raw_flags(unsigned long flags);
 # else
 #  define check_raw_flags(flags)	do { } while (0)
=================================================================
--- ./kernel/irq/manage.c.ORG	2005-07-12 10:19:40.000000000 -0400
+++ ./kernel/irq/manage.c	2005-07-20 13:30:51.000000000 -0400
@@ -435,6 +435,7 @@ static void do_hardirq(struct irq_desc *
 		 */
 		if (!(desc->status & IRQ_DISABLED))
 			desc->handler->enable(irq);
+		desc->handler->end(irq);	/* terminate this IRQ */
 	}
 	spin_unlock_irq(&desc->lock);
 
=================================================================
--- ./kernel/latency.c.ORG	2005-07-12 10:19:40.000000000 -0400
+++ ./kernel/latency.c	2005-07-12 11:29:28.000000000 -0400
@@ -2079,24 +2079,30 @@ static int preempt_write_proc(struct fil
 	return done;
 }
 
+#define	PROCNAME_PML	"sys/kernel/preempt_max_latency"
+#define PROCNAME_PT	"sys/kernel/preempt_thresh"
+
 static __init int latency_init(void)
 {
 	struct proc_dir_entry *entry;
 
-	entry = create_proc_entry("sys/kernel/preempt_max_latency", 0644, NULL);
-
-	entry->nlink = 1;
-	entry->data = &preempt_max_latency;
-	entry->read_proc = preempt_read_proc;
-	entry->write_proc = preempt_write_proc;
-
-	entry = create_proc_entry("sys/kernel/preempt_thresh", 0644, NULL);
-
-	entry->nlink = 1;
-	entry->data = &preempt_thresh;
-	entry->read_proc = preempt_read_proc;
-	entry->write_proc = preempt_write_proc;
-
+	if (!(entry = create_proc_entry(PROCNAME_PML, 0644, NULL)))
+		printk("latency_init(): can't create %s\n", PROCNAME_PML);
+	else {
+		entry->nlink = 1;
+		entry->data = &preempt_max_latency;
+		entry->read_proc = preempt_read_proc;
+		entry->write_proc = preempt_write_proc;
+	}
+
+	if (!(entry = create_proc_entry(PROCNAME_PT, 0644, NULL)))
+		printk("latency_init(): can't create %s\n", PROCNAME_PT);
+	else {
+		entry->nlink = 1;
+		entry->data = &preempt_thresh;
+		entry->read_proc = preempt_read_proc;
+		entry->write_proc = preempt_write_proc;
+	}
 	return 0;
 }
 __initcall(latency_init);
=================================================================
--- ./kernel/softirq.c.ORG	2005-07-12 10:19:40.000000000 -0400
+++ ./kernel/softirq.c	2005-07-12 11:29:28.000000000 -0400
@@ -457,6 +457,8 @@ static int ksoftirqd(void * __data)
 //	param.sched_priority = 1;
 //	sys_sched_setscheduler(current->pid, SCHED_FIFO, &param);
 	set_user_nice(current, -10);
+	printk("ksoftirqd started: %s 0x%x policy %d prio %d\n",
+		current->comm, current, current->policy, current->prio);
 	current->flags |= PF_NOFREEZE | PF_SOFTIRQ;
 
 	set_current_state(TASK_INTERRUPTIBLE);
=================================================================
--- ./kernel/sys.c.ORG	2005-07-12 10:19:40.000000000 -0400
+++ ./kernel/sys.c	2005-07-12 11:29:28.000000000 -0400
@@ -29,6 +29,7 @@
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
+#include <linux/rt_lock.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
=================================================================
--- ./kernel/timer.c.ORG	2005-07-12 10:19:40.000000000 -0400
+++ ./kernel/timer.c	2005-07-12 11:29:28.000000000 -0400
@@ -406,6 +406,15 @@ int try_to_del_timer_sync(struct timer_l
 	unsigned long flags;
 	int ret = -1;
 
+
+	base = &per_cpu(tvec_bases, get_cpu());
+	if (base->running_timer == timer) {
+		del_timer(timer);
+		put_cpu();
+		return (1);
+	}
+	put_cpu();
+
 	base = lock_timer_base(timer, &flags);
 
 	if (base->running_timer == timer)
=================================================================
--- ./kernel/printk.c.ORG	2005-07-12 10:19:40.000000000 -0400
+++ ./kernel/printk.c	2005-07-20 15:45:24.000000000 -0400
@@ -742,7 +742,12 @@ void release_console_sem(void)
 		 * on PREEMPT_RT, call console drivers with
 		 * interrupts enabled:
 		 */
+#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_PPC)
+		/* __raw_local_irq_enable() here hangs PPC bootup: TBI */
+		spin_unlock(&logbuf_lock);
+#else
 		spin_unlock_irq(&logbuf_lock);
+#endif
 		call_console_drivers(_con_start, _log_end);
 		raw_local_irq_restore(flags);
 	}
=================================================================
--- ./lib/Kconfig.debug.ORG	2005-07-12 10:19:40.000000000 -0400
+++ ./lib/Kconfig.debug	2005-07-12 11:29:28.000000000 -0400
@@ -109,7 +109,8 @@ config DEBUG_PREEMPT
 
 config DEBUG_IRQ_FLAGS
 	bool
-	default y
+#	default y
+	default n
 	depends on DEBUG_PREEMPT
 
 # broken by PREEMPT_RT, disable for now
@@ -189,7 +190,9 @@ config CRITICAL_TIMING
 config LATENCY_TIMING
 	bool
 	default y
+#	depends on (WAKEUP_TIMING || CRITICAL_TIMING) && SYSCTL
 	depends on WAKEUP_TIMING || CRITICAL_TIMING
+	select SYSCTL
 
 config LATENCY_TRACE
 	bool "Latency tracing"

--------------000506020703010308050208--
