Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268153AbTBNAl3>; Thu, 13 Feb 2003 19:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268155AbTBNAl2>; Thu, 13 Feb 2003 19:41:28 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:57218 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268153AbTBNAlL>; Thu, 13 Feb 2003 19:41:11 -0500
Subject: [PATCH] Ingo's E6 vs 2.5.60-mm1
From: Core <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-gZi/D3pl1R4P4tmKuhgb"
Organization: 
Message-Id: <1045183872.6351.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Feb 2003 18:51:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gZi/D3pl1R4P4tmKuhgb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Does anyone see anything messy about this patch? I decided to post this
JFSAG, and if anyone wanted to avoide the trouble of resolving a couple
minor rejects.

-- 
Core <core@enodev.com>

--=-gZi/D3pl1R4P4tmKuhgb
Content-Description: 
Content-Disposition: inline; filename=sched-2.5.60-mm1-E6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- linux-2.5.60-mm1/arch/i386/kernel/cpu/proc.c	2003-02-10 12:38:52.000000=
000 -0600
+++ linux-2.5.60-mm1-E6sched/arch/i386/kernel/cpu/proc.c	2003-02-13 18:30:2=
3.000000000 -0600
@@ -1,4 +1,5 @@
 #include <linux/smp.h>
+#include <linux/sched.h>
 #include <linux/timex.h>
 #include <linux/string.h>
 #include <asm/semaphore.h>
@@ -101,6 +102,13 @@
 		     fpu_exception ? "yes" : "no",
 		     c->cpuid_level,
 		     c->wp_works_ok ? "yes" : "no");
+#if CONFIG_SHARE_RUNQUEUE
+{
+	extern long __rq_idx[NR_CPUS];
+
+	seq_printf(m, "\nrunqueue\t: %d\n", __rq_idx[n]);
+}
+#endif
=20
 	for ( i =3D 0 ; i < 32*NCAPINTS ; i++ )
 		if ( test_bit(i, c->x86_capability) &&
--- linux-2.5.60-mm1/arch/i386/kernel/smpboot.c	2003-02-13 18:26:15.0000000=
00 -0600
+++ linux-2.5.60-mm1-E6sched/arch/i386/kernel/smpboot.c	2003-02-13 18:30:23=
.000000000 -0600
@@ -38,6 +38,7 @@
 #include <linux/kernel.h>
=20
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
@@ -941,6 +942,16 @@
=20
 int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
=20
+static int test_ht;
+
+static int __init ht_setup(char *str)
+{
+	test_ht =3D 1;
+	return 1;
+}
+
+__setup("test_ht", ht_setup);
+
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit;
@@ -1072,16 +1083,31 @@
 	Dprintk("Boot done.\n");
=20
 	/*
-	 * If Hyper-Threading is avaialble, construct cpu_sibling_map[], so
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	smpboot_setup_io_apic();
+
+	setup_boot_APIC_clock();
+
+	/*
+	 * Synchronize the TSC with the AP
+	 */
+	if (cpu_has_tsc && cpucount)
+		synchronize_tsc_bp();
+	/*
+	 * If Hyper-Threading is available, construct cpu_sibling_map[], so
 	 * that we can tell the sibling CPU efficiently.
 	 */
+printk("cpu_has_ht: %d, smp_num_siblings: %d, num_online_cpus(): %d.\n", c=
pu_has_ht, smp_num_siblings, num_online_cpus());
 	if (cpu_has_ht && smp_num_siblings > 1) {
 		for (cpu =3D 0; cpu < NR_CPUS; cpu++)
 			cpu_sibling_map[cpu] =3D NO_PROC_ID;
 	=09
 		for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
 			int 	i;
-			if (!test_bit(cpu, &cpu_callout_map)) continue;
+			if (!test_bit(cpu, &cpu_callout_map))
+				continue;
=20
 			for (i =3D 0; i < NR_CPUS; i++) {
 				if (i =3D=3D cpu || !test_bit(i, &cpu_callout_map))
@@ -1097,17 +1123,41 @@
 				printk(KERN_WARNING "WARNING: No sibling found for CPU %d.\n", cpu);
 			}
 		}
-	}
-
-	smpboot_setup_io_apic();
-
-	setup_boot_APIC_clock();
+#if CONFIG_SHARE_RUNQUEUE
+		/*
+		 * At this point APs would have synchronised TSC and
+		 * waiting for smp_commenced, with their APIC timer
+		 * disabled. So BP can go ahead do some initialization
+		 * for Hyper-Threading (if needed).
+		 */
+		for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
+			int i;
+			if (!test_bit(cpu, &cpu_callout_map))
+				continue;
+			for (i =3D 0; i < NR_CPUS; i++) {
+				if (i <=3D cpu)
+					continue;
+				if (!test_bit(i, &cpu_callout_map))
+					continue;
=20
-	/*
-	 * Synchronize the TSC with the AP
-	 */
-	if (cpu_has_tsc && cpucount)
-		synchronize_tsc_bp();
+				if (phys_proc_id[cpu] !=3D phys_proc_id[i])
+					continue;
+				/*
+				 * merge runqueues, resulting in one
+				 * runqueue per package:
+				 */
+				sched_map_runqueue(cpu, i);
+				break;
+			}
+		}
+#endif
+	}
+#if CONFIG_SHARE_RUNQUEUE
+	if (smp_num_siblings =3D=3D 1 && test_ht) {
+		printk("Simulating a 2-sibling 1-phys-CPU HT setup!\n");
+		sched_map_runqueue(0, 1);
+	}
+#endif
 }
=20
 /* These are wrappers to interface to the new boot process.  Someone
--- linux-2.5.60-mm1/arch/i386/Kconfig	2003-02-13 18:26:15.000000000 -0600
+++ linux-2.5.60-mm1-E6sched/arch/i386/Kconfig	2003-02-13 18:30:23.00000000=
0 -0600
@@ -408,6 +408,24 @@
=20
 	  If you don't know what to do here, say N.
=20
+choice
+
+	prompt "Hyperthreading Support"
+	depends on SMP
+	default NR_SIBLINGS_0
+
+config NR_SIBLINGS_0
+	bool "off"
+
+config NR_SIBLINGS_2
+	bool "2 siblings"
+
+config NR_SIBLINGS_4
+	bool "4 siblings"
+
+endchoice
+
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
--- linux-2.5.60-mm1/include/linux/sched.h	2003-02-13 18:26:16.000000000 -0=
600
+++ linux-2.5.60-mm1-E6sched/include/linux/sched.h	2003-02-13 18:30:23.0000=
00000 -0600
@@ -147,6 +147,24 @@
 extern void sched_init(void);
 extern void init_idle(task_t *idle, int cpu);
=20
+/*
+ * Is there a way to do this via Kconfig?
+ */
+#define CONFIG_NR_SIBLINGS 0
+
+#if CONFIG_NR_SIBLINGS_2
+# define CONFIG_NR_SIBLINGS 2
+#elif CONFIG_NR_SIBLINGS_4
+# define CONFIG_NR_SIBLINGS 4
+#endif
+
+#if CONFIG_NR_SIBLINGS
+# define CONFIG_SHARE_RUNQUEUE 1
+#else
+# define CONFIG_SHARE_RUNQUEUE 0
+#endif
+extern void sched_map_runqueue(int cpu1, int cpu2);
+
 extern void show_state(void);
 extern void show_trace(unsigned long *stack);
 extern void show_stack(unsigned long *stack);
@@ -311,7 +329,7 @@
 	prio_array_t *array;
=20
 	unsigned long sleep_avg;
-	unsigned long sleep_timestamp;
+	unsigned long last_run;
=20
 	unsigned long policy;
 	unsigned long cpus_allowed;
@@ -807,11 +825,6 @@
 	return p->thread_info->cpu;
 }
=20
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-	p->thread_info->cpu =3D cpu;
-}
-
 #else
=20
 static inline unsigned int task_cpu(struct task_struct *p)
@@ -819,10 +832,6 @@
 	return 0;
 }
=20
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-}
-
 #endif /* CONFIG_SMP */
=20
 #endif /* __KERNEL__ */
--- linux-2.5.60-mm1/include/asm-i386/apic.h	2003-02-10 12:39:00.000000000 =
-0600
+++ linux-2.5.60-mm1-E6sched/include/asm-i386/apic.h	2003-02-13 18:30:23.00=
0000000 -0600
@@ -98,4 +98,6 @@
=20
 #endif /* CONFIG_X86_LOCAL_APIC */
=20
+extern int phys_proc_id[NR_CPUS];
+
 #endif /* __ASM_APIC_H */
--- linux-2.5.60-mm1/kernel/fork.c	2003-02-10 12:37:58.000000000 -0600
+++ linux-2.5.60-mm1-E6sched/kernel/fork.c	2003-02-13 18:30:23.000000000 -0=
600
@@ -896,7 +896,7 @@
 	 */
 	p->first_time_slice =3D 1;
 	current->time_slice >>=3D 1;
-	p->sleep_timestamp =3D jiffies;
+	p->last_run =3D jiffies;
 	if (!current->time_slice) {
 		/*
 	 	 * This case is rare, it happens when the parent has only
--- linux-2.5.60-mm1/kernel/sched.c	2003-02-13 18:26:16.000000000 -0600
+++ linux-2.5.60-mm1-E6sched/kernel/sched.c	2003-02-13 18:36:23.000000000 -=
0600
@@ -80,6 +80,7 @@
 #define INTERACTIVE_DELTA	(interactive_delta)
 #define MAX_SLEEP_AVG		(max_sleep_avg)
 #define STARVATION_LIMIT	(starvation_limit)
+#define AGRESSIVE_IDLE_STEAL	1
 #define NODE_THRESHOLD          125
=20
 /*
@@ -154,6 +155,48 @@
 };
=20
 /*
+ * It's possible for two CPUs to share the same runqueue.
+ * This makes sense if they eg. share caches.
+ *
+ * We take the common 1:1 (SMP, UP) case and optimize it,
+ * the rest goes via remapping: rq_idx(cpu) gives the
+ * runqueue on which a particular cpu is on, cpu_idx(cpu)
+ * gives the rq-specific index of the cpu.
+ *
+ * (Note that the generic scheduler code does not impose any
+ *  restrictions on the mappings - there can be 4 CPUs per
+ *  runqueue or even assymetric mappings.)
+ */
+#if CONFIG_SHARE_RUNQUEUE
+# define MAX_NR_SIBLINGS CONFIG_NR_SIBLINGS
+  long __rq_idx[NR_CPUS] __cacheline_aligned;
+  static long __cpu_idx[NR_CPUS] __cacheline_aligned;
+# define rq_idx(cpu) (__rq_idx[(cpu)])
+# define cpu_idx(cpu) (__cpu_idx[(cpu)])
+# define for_each_sibling(idx, rq) \
+		for ((idx) =3D 0; (idx) < (rq)->nr_cpus; (idx)++)
+# define rq_nr_cpus(rq) ((rq)->nr_cpus)
+# define cpu_active_balance(c) (cpu_rq(c)->cpu[0].active_balance)
+#else
+# define MAX_NR_SIBLINGS 1
+# define rq_idx(cpu) (cpu)
+# define cpu_idx(cpu) 0
+# define for_each_sibling(idx, rq) while (0)
+# define cpu_active_balance(c) 0
+# define do_active_balance(rq, cpu) do { } while (0)
+# define rq_nr_cpus(rq) 1
+  static inline void active_load_balance(runqueue_t *rq, int this_cpu) { }
+#endif
+
+typedef struct cpu_s {
+	task_t *curr, *idle;
+	task_t *migration_thread;
+	struct list_head migration_queue;
+	int active_balance;
+	int cpu;
+} cpu_t;
+
+/*
  * This is the main, per-CPU runqueue data structure.
  *
  * Locking rule: those places that want to lock multiple runqueues
@@ -164,7 +207,7 @@
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
-	task_t *curr, *idle;
+	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 #ifdef CONFIG_NUMA
@@ -172,27 +215,39 @@
 	unsigned int nr_balanced;
 	int prev_node_load[MAX_NUMNODES];
 #endif
-	task_t *migration_thread;
-	struct list_head migration_queue;
+	int nr_cpus;
+	cpu_t cpu[MAX_NR_SIBLINGS];
=20
 	atomic_t nr_iowait;
 } ____cacheline_aligned;
=20
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
=20
-#define cpu_rq(cpu)		(runqueues + (cpu))
+#define cpu_rq(cpu)		(runqueues + (rq_idx(cpu)))
+#define cpu_int(c)		((cpu_rq(c))->cpu + cpu_idx(c))
+#define cpu_curr_ptr(cpu)	(cpu_int(cpu)->curr)
+#define cpu_idle_ptr(cpu)	(cpu_int(cpu)->idle)
+
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq(task_cpu(p))
-#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
=20
+#define migration_thread(cpu)	(cpu_int(cpu)->migration_thread)
+#define migration_queue(cpu)	(&cpu_int(cpu)->migration_queue)
+
+#if NR_CPUS > 1
+# define task_allowed(p, cpu)	((p)->cpus_allowed & (1UL << (cpu)))
+#else
+# define task_allowed(p, cpu)	1
+#endif
+
 /*
  * Default context-switch locking:
  */
 #ifndef prepare_arch_switch
 # define prepare_arch_switch(rq, next)	do { } while(0)
 # define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
-# define task_running(rq, p)		((rq)->curr =3D=3D (p))
+# define task_running(p)		(cpu_curr_ptr(task_cpu(p)) =3D=3D (p))
 #endif
=20
 #ifdef CONFIG_NUMA
@@ -335,16 +390,21 @@
  * Also update all the scheduling statistics stuff. (sleep average
  * calculation, priority modifiers, etc.)
  */
+static inline void __activate_task(task_t *p, runqueue_t *rq)
+{
+	enqueue_task(p, rq->active);
+	nr_running_inc(rq);
+}
+
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
-	unsigned long sleep_time =3D jiffies - p->sleep_timestamp;
-	prio_array_t *array =3D rq->active;
+	unsigned long sleep_time =3D jiffies - p->last_run;
=20
 	if (!rt_task(p) && sleep_time) {
 		/*
 		 * This code gives a bonus to interactive tasks. We update
 		 * an 'average sleep time' value here, based on
-		 * sleep_timestamp. The more time a task spends sleeping,
+		 * ->last_run. The more time a task spends sleeping,
 		 * the higher the average gets - and the higher the priority
 		 * boost gets as well.
 		 */
@@ -353,8 +413,7 @@
 			p->sleep_avg =3D MAX_SLEEP_AVG;
 		p->prio =3D effective_prio(p);
 	}
-	enqueue_task(p, array);
-	nr_running_inc(rq);
+	__activate_task(p, rq);
 }
=20
 /*
@@ -395,8 +454,18 @@
 #endif
 }
=20
+static inline void resched_cpu(int cpu)
+{
+	resched_task(cpu_curr_ptr(cpu));
+}
+
 #ifdef CONFIG_SMP
=20
+static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+		p->thread_info->cpu =3D cpu;
+}
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -411,7 +480,7 @@
 repeat:
 	preempt_disable();
 	rq =3D task_rq(p);
-	if (unlikely(task_running(rq, p))) {
+	if (unlikely(task_running(p))) {
 		cpu_relax();
 		/*
 		 * enable/disable preemption just to make this
@@ -422,7 +491,7 @@
 		goto repeat;
 	}
 	rq =3D task_rq_lock(p, &flags);
-	if (unlikely(task_running(rq, p))) {
+	if (unlikely(task_running(p))) {
 		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
@@ -430,6 +499,13 @@
 	task_rq_unlock(rq, &flags);
 	preempt_enable();
 }
+
+#else
+
+static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+}
+
 #endif
=20
 /*
@@ -444,10 +520,39 @@
  */
 void kick_if_running(task_t * p)
 {
-	if ((task_running(task_rq(p), p)) && (task_cpu(p) !=3D smp_processor_id()=
))
+	if ((task_running(p)) && (task_cpu(p) !=3D smp_processor_id()))
 		resched_task(p);
 }
=20
+static void wake_up_cpu(runqueue_t *rq, int cpu, task_t *p)
+{
+	cpu_t *curr_cpu;
+	task_t *curr;
+	int idx;
+
+	if (idle_cpu(cpu))
+		return resched_cpu(cpu);
+
+	for_each_sibling(idx, rq) {
+		curr_cpu =3D rq->cpu + idx;
+		if (!task_allowed(p, curr_cpu->cpu))
+			continue;
+		if (curr_cpu->idle =3D=3D curr_cpu->curr)
+			return resched_cpu(curr_cpu->cpu);
+	}
+
+	if (p->prio < cpu_curr_ptr(cpu)->prio)
+		return resched_task(cpu_curr_ptr(cpu));
+
+	for_each_sibling(idx, rq) {
+		curr_cpu =3D rq->cpu + idx;
+		if (!task_allowed(p, curr_cpu->cpu))
+			continue;
+		curr =3D curr_cpu->curr;
+		if (p->prio < curr->prio)
+			return resched_task(curr);
+	}
+}
 /***
  * try_to_wake_up - wake up a thread
  * @p: the to-be-woken-up thread
@@ -478,7 +583,7 @@
 			 * Fast-migrate the task if it's not running or runnable
 			 * currently. Do not violate hard affinity.
 			 */
-			if (unlikely(sync && !task_running(rq, p) &&
+			if (unlikely(sync && !task_running(p) &&
 				(task_cpu(p) !=3D smp_processor_id()) &&
 				(p->cpus_allowed & (1UL << smp_processor_id())))) {
=20
@@ -488,10 +593,11 @@
 			}
 			if (old_state =3D=3D TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible--;
-			activate_task(p, rq);
-=09
-			if (p->prio < rq->curr->prio)
-				resched_task(rq->curr);
+			if (sync)
+				__activate_task(p, rq);
+			else {
+				activate_task(p, rq);
+			}
 			success =3D 1;
 		}
 		p->state =3D TASK_RUNNING;
@@ -582,7 +688,7 @@
  * context_switch - switch to the new MM and the new
  * thread's register state.
  */
-static inline task_t * context_switch(task_t *prev, task_t *next)
+static inline task_t * context_switch(runqueue_t *rq, task_t *prev, task_t=
 *next)
 {
 	struct mm_struct *mm =3D next->mm;
 	struct mm_struct *oldmm =3D prev->active_mm;
@@ -596,7 +702,7 @@
=20
 	if (unlikely(!prev->mm)) {
 		prev->active_mm =3D NULL;
-		mmdrop(oldmm);
+		rq->prev_mm =3D oldmm;
 	}
=20
 	/* Here we just switch the register state and the stack. */
@@ -617,8 +723,9 @@
 	unsigned long i, sum =3D 0;
=20
 	for (i =3D 0; i < NR_CPUS; i++)
-		sum +=3D cpu_rq(i)->nr_running;
-
+		/* Shared runqueues are counted only once. */
+		if (!cpu_idx(i))
+			sum +=3D cpu_rq(i)->nr_running;
 	return sum;
 }
=20
@@ -629,7 +736,9 @@
 	for (i =3D 0; i < NR_CPUS; i++) {
 		if (!cpu_online(i))
 			continue;
-		sum +=3D cpu_rq(i)->nr_uninterruptible;
+		/* Shared runqueues are counted only once. */
+		if (!cpu_idx(i))
+			sum +=3D cpu_rq(i)->nr_uninterruptible;
 	}
 	return sum;
 }
@@ -811,7 +920,23 @@
=20
 #endif /* CONFIG_NUMA */
=20
-#if CONFIG_SMP
+/*
+ * One of the idle_cpu_tick() and busy_cpu_tick() functions will
+ * get called every timer tick, on every CPU. Our balancing action
+ * frequency and balancing agressivity depends on whether the CPU is
+ * idle or not.
+ *
+ * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
+ * systems with HZ=3D100, every 10 msecs.)
+ */
+#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
+#define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
+
+#if !CONFIG_SMP
+
+static inline void load_balance(runqueue_t *rq, int this_cpu, int idle) { =
}
+
+#else
=20
 /*
  * double_lock_balance - lock the busiest runqueue
@@ -927,12 +1052,7 @@
 	set_task_cpu(p, this_cpu);
 	nr_running_inc(this_rq);
 	enqueue_task(p, this_rq->active);
-	/*
-	 * Note that idle threads have a prio of MAX_PRIO, for this test
-	 * to be always true for them.
-	 */
-	if (p->prio < this_rq->curr->prio)
-		set_need_resched();
+	wake_up_cpu(this_rq, this_cpu, p);
 }
=20
 /*
@@ -943,9 +1063,9 @@
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle)
+static void load_balance(runqueue_t *this_rq, int this_cpu, int idle)
 {
-	int imbalance, idx, this_cpu =3D smp_processor_id();
+	int imbalance, idx;
 	runqueue_t *busiest;
 	prio_array_t *array;
 	struct list_head *head, *curr;
@@ -993,12 +1113,15 @@
 	 * 1) running (obviously), or
 	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
 	 * 3) are cache-hot on their current CPU.
+	 *
+	 * (except if we are in idle mode which is a more agressive
+	 *  form of rebalancing.)
 	 */
=20
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
-		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+#define CAN_MIGRATE_TASK(p,rq,cpu)		\
+	(((idle && AGRESSIVE_IDLE_STEAL) ||	\
+		(jiffies - (p)->last_run > cache_decay_ticks)) && \
+			!task_running(p) && task_allowed(p, cpu))
=20
 	curr =3D curr->prev;
=20
@@ -1021,31 +1144,136 @@
 	;
 }
=20
+#if CONFIG_SHARE_RUNQUEUE
+static void active_load_balance(runqueue_t *this_rq, int this_cpu)
+{
+	runqueue_t *rq;
+	int i, idx;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		rq =3D cpu_rq(i);
+		if (rq =3D=3D this_rq)
+			continue;
+		/*
+		 * Any SMT-specific imbalance?
+		 */
+		for_each_sibling(idx, rq)
+			if (rq->cpu[idx].idle =3D=3D rq->cpu[idx].curr)
+				goto next_cpu;
+
+		/*
+		 * At this point it's sure that we have a SMT
+		 * imbalance: this (physical) CPU is idle but
+		 * another CPU has two (or more) tasks running.
+		 *
+		 * We wake up one of the migration threads (it
+		 * doesnt matter which one) and let it fix things up:
+		 */
+		if (!cpu_active_balance(i)) {
+			cpu_active_balance(i) =3D 1;
+			spin_unlock(&this_rq->lock);
+			wake_up_process(rq->cpu[0].migration_thread);
+			spin_lock(&this_rq->lock);
+		}
+next_cpu:
+	}
+}
+
+static void do_active_balance(runqueue_t *this_rq, int this_cpu)
+{
+	runqueue_t *rq;
+	int i, idx;
+
+	spin_unlock(&this_rq->lock);
+
+	cpu_active_balance(this_cpu) =3D 0;
+
+	/*
+	 * Is the imbalance still present?
+	 */
+	for_each_sibling(idx, this_rq)
+		if (this_rq->cpu[idx].idle =3D=3D this_rq->cpu[idx].curr)
+			goto out;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		rq =3D cpu_rq(i);
+		if (rq =3D=3D this_rq)
+			continue;
+
+		/* completely idle CPU? */
+		if (rq->nr_running)
+			continue;
+
+		/*
+		 * At this point it's reasonably sure that we have an
+		 * imbalance. Since we are the migration thread, try to
+	 	 * balance a thread over to the target queue.
+		 */
+		spin_lock(&rq->lock);
+		load_balance(rq, i, 1);
+		spin_unlock(&rq->lock);
+		goto out;
+	}
+out:
+	spin_lock(&this_rq->lock);
+}
+
 /*
- * One of the idle_cpu_tick() and busy_cpu_tick() functions will
- * get called every timer tick, on every CPU. Our balancing action
- * frequency and balancing agressivity depends on whether the CPU is
- * idle or not.
+ * This routine is called to map a CPU into another CPU's runqueue.
  *
- * busy-rebalance every 250 msecs. idle-rebalance every 1 msec. (or on
- * systems with HZ=3D100, every 10 msecs.)
+ * This must be called during bootup with the merged runqueue having
+ * no tasks.
  */
-#define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
-#define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
+void sched_map_runqueue(int cpu1, int cpu2)
+{
+	runqueue_t *rq1 =3D cpu_rq(cpu1);
+	runqueue_t *rq2 =3D cpu_rq(cpu2);
+	int cpu2_idx_orig =3D cpu_idx(cpu2), cpu2_idx;
+
+	printk("sched_merge_runqueues: CPU#%d <=3D> CPU#%d, on CPU#%d.\n", cpu1, =
cpu2, smp_processor_id());
+	if (rq1 =3D=3D rq2)
+		BUG();
+	if (rq2->nr_running)
+		BUG();
+	/*
+	 * At this point, we dont have anything in the runqueue yet. So,
+	 * there is no need to move processes between the runqueues.
+	 * Only, the idle processes should be combined and accessed
+	 * properly.
+	 */
+	cpu2_idx =3D rq1->nr_cpus++;
+
+	if (rq_idx(cpu1) !=3D cpu1)
+		BUG();
+	rq_idx(cpu2) =3D cpu1;
+	cpu_idx(cpu2) =3D cpu2_idx;
+	rq1->cpu[cpu2_idx].cpu =3D cpu2;
+	rq1->cpu[cpu2_idx].idle =3D rq2->cpu[cpu2_idx_orig].idle;
+	rq1->cpu[cpu2_idx].curr =3D rq2->cpu[cpu2_idx_orig].curr;
+	INIT_LIST_HEAD(&rq1->cpu[cpu2_idx].migration_queue);
+
+	/* just to be safe: */
+	rq2->cpu[cpu2_idx_orig].idle =3D NULL;
+	rq2->cpu[cpu2_idx_orig].curr =3D NULL;
+}
+#endif
+#endif
+
+DEFINE_PER_CPU(struct kernel_stat, kstat) =3D { { 0 } };
=20
-static inline void idle_tick(runqueue_t *rq)
+static inline void idle_tick(runqueue_t *rq, unsigned long j)
 {
-	if (jiffies % IDLE_REBALANCE_TICK)
+	if (j % IDLE_REBALANCE_TICK)
 		return;
 	spin_lock(&rq->lock);
-	load_balance(rq, 1);
+	load_balance(rq, smp_processor_id(), 1);
 	spin_unlock(&rq->lock);
 }
=20
-#endif
-
-DEFINE_PER_CPU(struct kernel_stat, kstat) =3D { { 0 } };
-
 /*
  * We place interactive tasks back into the active array, if possible.
  *
@@ -1056,9 +1284,9 @@
  * increasing number of running tasks:
  */
 #define EXPIRED_STARVING(rq) \
-		((rq)->expired_timestamp && \
+		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >=3D \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))
+			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
=20
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -1071,12 +1299,13 @@
 {
 	int cpu =3D smp_processor_id();
 	runqueue_t *rq =3D this_rq();
+	unsigned long j =3D jiffies;
 	task_t *p =3D current;
=20
  	if (rcu_pending(cpu))
  		rcu_check_callbacks(cpu, user_ticks);
=20
-	if (p =3D=3D rq->idle) {
+	if (p =3D=3D cpu_idle_ptr(cpu)) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >=3D SOFTIRQ_OFFSET)
 			kstat_cpu(cpu).cpustat.system +=3D sys_ticks;
@@ -1084,9 +1313,7 @@
 			kstat_cpu(cpu).cpustat.iowait +=3D sys_ticks;
 		else
 			kstat_cpu(cpu).cpustat.idle +=3D sys_ticks;
-#if CONFIG_SMP
-		idle_tick(rq);
-#endif
+		idle_tick(rq, j);
 		return;
 	}
 	if (TASK_NICE(p) > 0)
@@ -1095,12 +1322,13 @@
 		kstat_cpu(cpu).cpustat.user +=3D user_ticks;
 	kstat_cpu(cpu).cpustat.system +=3D sys_ticks;
=20
+	spin_lock(&rq->lock);
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array !=3D rq->active) {
 		set_tsk_need_resched(p);
+		spin_unlock(&rq->lock);
 		return;
 	}
-	spin_lock(&rq->lock);
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
@@ -1136,16 +1364,14 @@
=20
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
-				rq->expired_timestamp =3D jiffies;
+				rq->expired_timestamp =3D j;
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
 	}
 out:
-#if CONFIG_SMP
-	if (!(jiffies % BUSY_REBALANCE_TICK))
-		load_balance(rq, 0);
-#endif
+	if (!(j % BUSY_REBALANCE_TICK))
+		load_balance(rq, smp_processor_id(), 0);
 	spin_unlock(&rq->lock);
 }
=20
@@ -1156,11 +1382,11 @@
  */
 asmlinkage void do_schedule(void)
 {
+	int idx, this_cpu, retry =3D 0;
+	struct list_head *queue;
 	task_t *prev, *next;
-	runqueue_t *rq;
 	prio_array_t *array;
-	struct list_head *queue;
-	int idx;
+	runqueue_t *rq;
=20
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -1173,15 +1399,15 @@
 			dump_stack();
 		}
 	}
-
-	check_highmem_ptes();
 need_resched:
+	check_highmem_ptes();
+	this_cpu =3D smp_processor_id();
 	preempt_disable();
 	prev =3D current;
 	rq =3D this_rq();
=20
 	release_kernel_lock(prev);
-	prev->sleep_timestamp =3D jiffies;
+	prev->last_run =3D jiffies;
 	spin_lock_irq(&rq->lock);
=20
 	/*
@@ -1204,12 +1430,14 @@
 	}
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {
-#if CONFIG_SMP
-		load_balance(rq, 1);
+		load_balance(rq, this_cpu, 1);
 		if (rq->nr_running)
 			goto pick_next_task;
-#endif
-		next =3D rq->idle;
+		active_load_balance(rq, this_cpu);
+		if (rq->nr_running)
+			goto pick_next_task;
+pick_idle:
+		next =3D cpu_idle_ptr(this_cpu);
 		rq->expired_timestamp =3D 0;
 		goto switch_tasks;
 	}
@@ -1225,24 +1453,60 @@
 		rq->expired_timestamp =3D 0;
 	}
=20
+new_array:
 	idx =3D sched_find_first_bit(array->bitmap);
 	queue =3D array->queue + idx;
 	next =3D list_entry(queue->next, task_t, run_list);
+	if ((next !=3D prev) && (rq_nr_cpus(rq) > 1)) {
+		struct list_head *tmp =3D queue->next;
+
+		while ((task_running(next) && (next !=3D prev)) || !task_allowed(next, t=
his_cpu)) {
+			tmp =3D tmp->next;
+			if (tmp !=3D queue) {
+				next =3D list_entry(tmp, task_t, run_list);
+				continue;
+			}
+			idx =3D find_next_bit(array->bitmap, MAX_PRIO, ++idx);
+			if (idx =3D=3D MAX_PRIO) {
+				if (retry || !rq->expired->nr_active) {
+					goto pick_idle;
+				}
+				/*
+				 * To avoid infinite changing of arrays,
+				 * when we have only tasks runnable by
+				 * sibling.
+				 */
+				retry =3D 1;
+
+				array =3D rq->expired;
+				goto new_array;
+			}
+			queue =3D array->queue + idx;
+			tmp =3D queue->next;
+			next =3D list_entry(tmp, task_t, run_list);
+		}
+	}
=20
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
-	RCU_qsctr(prev->thread_info->cpu)++;
+	RCU_qsctr(task_cpu(prev))++;
=20
 	if (likely(prev !=3D next)) {
+		struct mm_struct *prev_mm;
 		rq->nr_switches++;
-		rq->curr =3D next;
+		cpu_curr_ptr(this_cpu) =3D next;
+		set_task_cpu(next, this_cpu);
 =09
 		prepare_arch_switch(rq, next);
-		prev =3D context_switch(prev, next);
+		prev =3D context_switch(rq, prev, next);
 		barrier();
 		rq =3D this_rq();
+		prev_mm =3D rq->prev_mm;
+		rq->prev_mm =3D NULL;
 		finish_arch_switch(rq, prev);
+		if (prev_mm)
+			mmdrop(prev_mm);
 	} else
 		spin_unlock_irq(&rq->lock);
=20
@@ -1526,9 +1790,8 @@
 		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) ||
-							task_running(rq, p))
-			resched_task(rq->curr);
+		if ((NICE_TO_PRIO(nice) < p->static_prio) || task_running(p))
+			resched_task(cpu_curr_ptr(task_cpu(p)));
 	}
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -1606,7 +1869,7 @@
  */
 int task_curr(task_t *p)
 {
-	return cpu_curr(task_cpu(p)) =3D=3D p;
+	return cpu_curr_ptr(task_cpu(p)) =3D=3D p;
 }
=20
 /**
@@ -1615,7 +1878,7 @@
  */
 int idle_cpu(int cpu)
 {
-	return cpu_curr(cpu) =3D=3D cpu_rq(cpu)->idle;
+	return cpu_curr_ptr(cpu) =3D=3D cpu_idle_ptr(cpu);
 }
=20
 /**
@@ -1705,7 +1968,7 @@
 	else
 		p->prio =3D p->static_prio;
 	if (array)
-		activate_task(p, task_rq(p));
+		__activate_task(p, task_rq(p));
=20
 out_unlock:
 	task_rq_unlock(rq, &flags);
@@ -2180,7 +2443,7 @@
 	local_irq_save(flags);
 	double_rq_lock(idle_rq, rq);
=20
-	idle_rq->curr =3D idle_rq->idle =3D idle;
+	cpu_curr_ptr(cpu) =3D cpu_idle_ptr(cpu) =3D idle;
 	deactivate_task(idle, rq);
 	idle->array =3D NULL;
 	idle->prio =3D MAX_PRIO;
@@ -2235,6 +2498,7 @@
 	unsigned long flags;
 	migration_req_t req;
 	runqueue_t *rq;
+	int cpu;
=20
 #if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
 	new_mask &=3D cpu_online_map;
@@ -2256,31 +2520,31 @@
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!p->array && !task_running(p)) {
 		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		return;
 	}
 	init_completion(&req.done);
 	req.task =3D p;
-	list_add(&req.list, &rq->migration_queue);
+	cpu =3D task_cpu(p);
+	list_add(&req.list, migration_queue(cpu));
 	task_rq_unlock(rq, &flags);
-
-	wake_up_process(rq->migration_thread);
+	wake_up_process(migration_thread(cpu));
=20
 	wait_for_completion(&req.done);
 }
=20
 /*
- * migration_thread - this is a highprio system thread that performs
+ * migration_task - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.
  */
-static int migration_thread(void * data)
+static int migration_task(void * data)
 {
 	struct sched_param param =3D { .sched_priority =3D MAX_RT_PRIO-1 };
 	int cpu =3D (long) data;
 	runqueue_t *rq;
-	int ret;
+	int ret, idx;
=20
 	daemonize();
 	sigfillset(&current->blocked);
@@ -2295,7 +2559,8 @@
 	ret =3D setscheduler(0, SCHED_FIFO, &param);
=20
 	rq =3D this_rq();
-	rq->migration_thread =3D current;
+	migration_thread(cpu) =3D current;
+	idx =3D cpu_idx(cpu);
=20
 	sprintf(current->comm, "migration/%d", smp_processor_id());
=20
@@ -2308,7 +2573,9 @@
 		task_t *p;
=20
 		spin_lock_irqsave(&rq->lock, flags);
-		head =3D &rq->migration_queue;
+		if (cpu_active_balance(cpu))
+			do_active_balance(rq, cpu);
+		head =3D migration_queue(cpu);
 		current->state =3D TASK_INTERRUPTIBLE;
 		if (list_empty(head)) {
 			spin_unlock_irqrestore(&rq->lock, flags);
@@ -2337,9 +2604,8 @@
 			set_task_cpu(p, cpu_dest);
 			if (p->array) {
 				deactivate_task(p, rq_src);
-				activate_task(p, rq_dest);
-				if (p->prio < rq_dest->curr->prio)
-					resched_task(rq_dest->curr);
+				__activate_task(p, rq_dest);
+				wake_up_cpu(rq_dest, cpu_dest, p);
 			}
 		}
 		double_rq_unlock(rq_src, rq_dest);
@@ -2357,12 +2623,13 @@
 			  unsigned long action,
 			  void *hcpu)
 {
+	long cpu =3D (long) hcpu;
+
 	switch (action) {
 	case CPU_ONLINE:
-		printk("Starting migration thread for cpu %li\n",
-		       (long)hcpu);
-		kernel_thread(migration_thread, hcpu, CLONE_KERNEL);
-		while (!cpu_rq((long)hcpu)->migration_thread)
+		printk("Starting migration thread for cpu %li\n", cpu);
+		kernel_thread(migration_task, hcpu, CLONE_KERNEL);
+		while (!migration_thread(cpu))
 			yield();
 		break;
 	}
@@ -2437,11 +2704,20 @@
 	for (i =3D 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
=20
+		/*
+		 * Start with a 1:1 mapping between CPUs and runqueues:
+		 */
+#if CONFIG_SHARE_RUNQUEUE
+		rq_idx(i) =3D i;
+		cpu_idx(i) =3D 0;
+#endif
 		rq =3D cpu_rq(i);
 		rq->active =3D rq->arrays;
 		rq->expired =3D rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		INIT_LIST_HEAD(&rq->migration_queue);
+		INIT_LIST_HEAD(migration_queue(i));
+		rq->nr_cpus =3D 1;
+		rq->cpu[cpu_idx(i)].cpu =3D i;
 		atomic_set(&rq->nr_iowait, 0);
 		nr_running_init(rq);
=20
@@ -2459,9 +2735,9 @@
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.
 	 */
-	rq =3D this_rq();
-	rq->curr =3D current;
-	rq->idle =3D current;
+	cpu_curr_ptr(smp_processor_id()) =3D current;
+	cpu_idle_ptr(smp_processor_id()) =3D current;
+
 	set_task_cpu(current, smp_processor_id());
 	wake_up_forked_process(current);
=20
--- linux-2.5.60-mm1/init/main.c	2003-02-13 18:26:16.000000000 -0600
+++ linux-2.5.60-mm1-E6sched/init/main.c	2003-02-13 18:31:47.000000000 -060=
0
@@ -358,7 +358,14 @@
=20
 static void rest_init(void)
 {
+	/*=20
+	 *	We count on the initial thread going ok=20
+	 *	Like idlers init is an unlocked kernel thread, which will
+	 *	make syscalls (and thus be locked).
+	 */
+	init_idle(current, smp_processor_id());
 	kernel_thread(init, NULL, CLONE_KERNEL);
+
 	unlock_kernel();
  	cpu_idle();
 }=20
@@ -442,13 +449,6 @@
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
=20
-	/*=20
-	 *	We count on the initial thread going ok=20
-	 *	Like idlers init is an unlocked kernel thread, which will
-	 *	make syscalls (and thus be locked).
-	 */
-	init_idle(current, smp_processor_id());
-
 #ifdef CONFIG_X86_REMOTE_DEBUG
 	if (gdb_enter) {
 		gdb_hook();		/* right at boot time */

--=-gZi/D3pl1R4P4tmKuhgb--
