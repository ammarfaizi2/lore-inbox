Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVDDCQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVDDCQY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVDDCNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:13:36 -0400
Received: from fmr20.intel.com ([134.134.136.19]:59822 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261981AbVDDCJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:09:30 -0400
Subject: [RFC 5/6]clean cpu state after hotremove CPU
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:07:02 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up all CPU states including its runqueue and idle thread, 
so we can use boot time code without any changes.
Note this makes /sys/devices/system/cpu/cpux/online unworkable.

Thanks,
Shaohua

---

 linux-2.6.11-root/arch/i386/kernel/cpu/common.c |   12 ++++
 linux-2.6.11-root/arch/i386/kernel/irq.c        |    5 +
 linux-2.6.11-root/arch/i386/kernel/process.c    |   20 +++++++
 linux-2.6.11-root/arch/i386/kernel/smpboot.c    |   44 ++++++++++++++++-
 linux-2.6.11-root/include/asm-i386/irq.h        |    2 
 linux-2.6.11-root/kernel/exit.c                 |   59 +++++++++++++++++++++++
 linux-2.6.11-root/kernel/sched.c                |   61 +++++++++++++++++++++---
 7 files changed, 195 insertions(+), 8 deletions(-)

diff -puN arch/i386/kernel/process.c~cpu_state_clean arch/i386/kernel/process.c
--- linux-2.6.11/arch/i386/kernel/process.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/process.c	2005-04-04 09:07:29.172936768 +0800
@@ -144,12 +144,32 @@ static void poll_idle (void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 #include <asm/nmi.h>
+
+#ifdef CONFIG_STR_SMP
+extern void cpu_exit_clear(int);
+#endif
+
 /* We don't actually take CPU down, just spin without interrupts. */
 static inline void play_dead(void)
 {
+#ifdef CONFIG_STR_SMP
+	cpu_exit_clear(_smp_processor_id());
+#endif
+
 	/* Ack it */
 	__get_cpu_var(cpu_state) = CPU_DEAD;
 
+#ifdef CONFIG_STR_SMP
+	/*
+	 * With physical CPU hotplug, we should halt the CPU
+	 * Note: release idle task struct requires the CPU doesn't
+	 * touch stack or anything else.
+	 */
+	local_irq_disable();
+	while (1)
+		__asm__ __volatile__ ("hlt": : :"memory");
+#endif
+
 	/* We shouldn't have to disable interrupts while dead, but
 	 * some interrupts just don't seem to go away, and this makes
 	 * it "work" for testing purposes. */
diff -puN arch/i386/kernel/smpboot.c~cpu_state_clean arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-04 09:05:41.699275248 +0800
@@ -794,8 +794,13 @@ static int __devinit do_boot_cpu(int api
 	int timeout, cpu;
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
+	cpumask_t	tmp_map;
 
-	cpu = ++cpucount;
+	cpus_complement(tmp_map, cpu_present_map);
+	cpu = first_cpu(tmp_map);
+	if (cpu >= NR_CPUS)
+		return -ENODEV;
+	++cpucount;
 	/*
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
@@ -867,13 +872,16 @@ static int __devinit do_boot_cpu(int api
 			inquire_remote_apic(apicid);
 		}
 	}
-	x86_cpu_to_apicid[cpu] = apicid;
+
 	if (boot_error) {
 		/* Try to put things back the way they were before ... */
 		unmap_cpu_to_logical_apicid(cpu);
 		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
 		cpu_clear(cpu, cpu_initialized); /* was set by cpu_init() */
 		cpucount--;
+	} else {
+		x86_cpu_to_apicid[cpu] = apicid;
+		cpu_set(cpu, cpu_present_map);
 	}
 
 	/* mark "stuck" area as not stuck */
@@ -882,6 +890,37 @@ static int __devinit do_boot_cpu(int api
 	return boot_error;
 }
 
+#ifdef CONFIG_STR_SMP
+extern void do_exit_idle(void);
+extern void cpu_uninit(void);
+void cpu_exit_clear(int cpu)
+{
+	int sibling;
+	cpucount --;
+
+	cpu_uninit();
+
+	irq_ctx_exit(cpu);
+
+	cpu_clear(cpu, cpu_callout_map);
+	cpu_clear(cpu, cpu_callin_map);
+	cpu_clear(cpu, cpu_present_map);
+
+	x86_cpu_to_apicid[cpu] = BAD_APICID;
+
+	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
+		cpu_clear(cpu, cpu_sibling_map[sibling]);
+	cpus_clear(cpu_sibling_map[cpu]);
+
+	phys_proc_id[cpu] = BAD_APICID;
+
+	cpu_clear(cpu, smp_commenced_mask);
+
+	unmap_cpu_to_logical_apicid(cpu);
+
+	do_exit_idle();
+}
+#endif
 static void smp_tune_scheduling (void)
 {
 	unsigned long cachesize;       /* kB   */
@@ -1104,6 +1143,7 @@ void __devinit smp_prepare_boot_cpu(void
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
+	cpu_set(smp_processor_id(), cpu_present_map);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff -puN arch/i386/kernel/cpu/common.c~cpu_state_clean arch/i386/kernel/cpu/common.c
--- linux-2.6.11/arch/i386/kernel/cpu/common.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/common.c	2005-03-31 10:50:27.000000000 +0800
@@ -621,3 +621,15 @@ void __devinit cpu_init (void)
 	clear_used_math();
 	mxcsr_feature_mask_init();
 }
+
+#ifdef CONFIG_STR_SMP
+void __devinit cpu_uninit(void)
+{
+	int cpu = smp_processor_id();
+	cpu_clear(cpu, cpu_initialized);
+
+	/* lazy TLB state */
+	per_cpu(cpu_tlbstate, cpu).state = 0;
+	per_cpu(cpu_tlbstate, cpu).active_mm = &init_mm;
+}
+#endif
diff -puN include/asm-i386/irq.h~cpu_state_clean include/asm-i386/irq.h
--- linux-2.6.11/include/asm-i386/irq.h~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
+++ linux-2.6.11-root/include/asm-i386/irq.h	2005-03-31 10:50:27.000000000 +0800
@@ -29,9 +29,11 @@ extern void release_vm86_irqs(struct tas
 
 #ifdef CONFIG_4KSTACKS
   extern void irq_ctx_init(int cpu);
+  extern void irq_ctx_exit(int cpu);
 # define __ARCH_HAS_DO_SOFTIRQ
 #else
 # define irq_ctx_init(cpu) do { } while (0)
+# define irq_ctx_exit(cpu) do { } while (0)
 #endif
 
 #ifdef CONFIG_IRQBALANCE
diff -puN arch/i386/kernel/irq.c~cpu_state_clean arch/i386/kernel/irq.c
--- linux-2.6.11/arch/i386/kernel/irq.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/irq.c	2005-03-31 10:50:27.000000000 +0800
@@ -153,6 +153,11 @@ void irq_ctx_init(int cpu)
 		cpu,hardirq_ctx[cpu],softirq_ctx[cpu]);
 }
 
+void irq_ctx_exit(int cpu)
+{
+	hardirq_ctx[cpu] = NULL;
+}
+
 extern asmlinkage void __do_softirq(void);
 
 asmlinkage void do_softirq(void)
diff -puN kernel/exit.c~cpu_state_clean kernel/exit.c
--- linux-2.6.11/kernel/exit.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
+++ linux-2.6.11-root/kernel/exit.c	2005-03-31 10:50:27.000000000 +0800
@@ -845,6 +845,65 @@ fastcall NORET_TYPE void do_exit(long co
 	for (;;) ;
 }
 
+#ifdef CONFIG_STR_SMP
+void do_exit_idle(void)
+{
+	struct task_struct *tsk = current;
+	int group_dead;
+
+	BUG_ON(tsk->pid);
+	BUG_ON(tsk->mm);
+
+	if (tsk->io_context)
+		exit_io_context();
+	tsk->flags |= PF_EXITING;
+ 	tsk->it_virt_expires = cputime_zero;
+ 	tsk->it_prof_expires = cputime_zero;
+	tsk->it_sched_expires = 0;
+
+	acct_update_integrals(tsk);
+	update_mem_hiwater(tsk);
+	group_dead = atomic_dec_and_test(&tsk->signal->live);
+	if (group_dead) {
+ 		del_timer_sync(&tsk->signal->real_timer);
+		acct_process(-1);
+	}
+	exit_mm(tsk);
+
+	exit_sem(tsk);
+	__exit_files(tsk);
+	__exit_fs(tsk);
+	exit_namespace(tsk);
+	exit_thread();
+	exit_keys(tsk);
+
+	if (group_dead && tsk->signal->leader)
+		disassociate_ctty(1);
+
+	module_put(tsk->thread_info->exec_domain->module);
+	if (tsk->binfmt)
+		module_put(tsk->binfmt->module);
+
+	tsk->exit_code = -1;
+	tsk->exit_state = EXIT_DEAD;
+
+	/* in release_task */
+	atomic_dec(&tsk->user->processes);
+	write_lock_irq(&tasklist_lock);
+	__exit_signal(tsk);
+	__exit_sighand(tsk);
+	write_unlock_irq(&tasklist_lock);
+	release_thread(tsk);
+	put_task_struct(tsk);
+
+	tsk->flags |= PF_DEAD;
+#ifdef CONFIG_NUMA
+	mpol_free(tsk->mempolicy);
+	tsk->mempolicy = NULL;
+#endif
+}
+#endif
+
 NORET_TYPE void complete_and_exit(struct completion *comp, long code)
 {
 	if (comp)
diff -puN kernel/sched.c~cpu_state_clean kernel/sched.c
--- linux-2.6.11/kernel/sched.c~cpu_state_clean	2005-03-31 10:50:27.000000000 +0800
+++ linux-2.6.11-root/kernel/sched.c	2005-04-04 09:06:40.362357104 +0800
@@ -4028,6 +4028,58 @@ void __devinit init_idle(task_t *idle, i
 }
 
 /*
+ * Initial dummy domain for early boot and for hotplug cpu. Being static,
+ * it is initialized to zero, so all balancing flags are cleared which is
+ * what we want.
+ */
+static struct sched_domain sched_domain_dummy;
+
+#ifdef CONFIG_STR_SMP
+static void __devinit exit_idle(int cpu)
+{
+	runqueue_t *rq = cpu_rq(cpu);
+	struct task_struct *p = rq->idle;
+	int j, k;
+	prio_array_t *array;
+
+	/* init runqueue */
+	spin_lock_init(&rq->lock);
+	rq->active = rq->arrays;
+	rq->expired = rq->arrays + 1;
+	rq->best_expired_prio = MAX_PRIO;
+
+	rq->prev_mm = NULL;
+	rq->curr = rq->idle = NULL;
+	rq->expired_timestamp = 0;
+
+	rq->sd = &sched_domain_dummy;
+	rq->cpu_load = 0;
+	rq->active_balance = 0;
+	rq->push_cpu = 0;
+	rq->migration_thread = NULL;
+	INIT_LIST_HEAD(&rq->migration_queue);
+	atomic_set(&rq->nr_iowait, 0);
+
+	for (j = 0; j < 2; j++) {
+		array = rq->arrays + j;
+		for (k = 0; k < MAX_PRIO; k++) {
+			INIT_LIST_HEAD(array->queue + k);
+			__clear_bit(k, array->bitmap);
+		}
+		// delimiter for bitsearch
+		__set_bit(MAX_PRIO, array->bitmap);
+	}
+	/* Destroy IDLE thread.
+	 * it's safe now, the CPU is in busy loop
+	 */
+	if (p->active_mm)
+		mmdrop(p->active_mm);
+	p->active_mm = NULL;
+	put_task_struct(p);
+}
+#endif
+
+/*
  * In a system that switches off the HZ timer nohz_cpu_mask
  * indicates which cpus entered this state. This is used
  * in the rcu update to wait only for active cpus. For system
@@ -4432,6 +4484,9 @@ static int migration_call(struct notifie
 			complete(&req->done);
 		}
 		spin_unlock_irq(&rq->lock);
+#ifdef CONFIG_STR_SMP
+		exit_idle(cpu);
+#endif
 		break;
 #endif
 	}
@@ -4834,12 +4889,6 @@ static void __devinit arch_destroy_sched
 
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 
-/*
- * Initial dummy domain for early boot and for hotplug cpu. Being static,
- * it is initialized to zero, so all balancing flags are cleared which is
- * what we want.
- */
-static struct sched_domain sched_domain_dummy;
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
_


