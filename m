Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVLaCGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVLaCGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 21:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLaCGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 21:06:12 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:51783 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932075AbVLaCGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 21:06:10 -0500
Message-ID: <43B5E78C.9000509@bigpond.net.au>
Date: Sat, 31 Dec 2005 13:06:04 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
References: <20051227190918.65c2abac@localhost>	<20051227224846.6edcff88@localhost>	<200512281027.00252.kernel@kolivas.org> <20051230145221.301faa40@localhost>
In-Reply-To: <20051230145221.301faa40@localhost>
Content-Type: multipart/mixed;
 boundary="------------070402020701070906040506"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 31 Dec 2005 02:06:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070402020701070906040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paolo Ornati wrote:
> WAS: [SCHED] Totally WRONG prority calculation with specific test-case
> (since 2.6.10-bk12)
> http://lkml.org/lkml/2005/12/27/114/index.html
> 
> On Wed, 28 Dec 2005 10:26:58 +1100
> Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>The issue is that the scheduler interactivity estimator is a state machine and 
>>can be fooled to some degree, and a cpu intensive task that just happens to 
>>sleep a little bit gets significantly better priority than one that is fully 
>>cpu bound all the time. Reverting that change is not a solution because it 
>>can still be fooled by the same process sleeping lots for a few seconds or so 
>>at startup and then changing to the cpu mostly-sleeping slightly behaviour. 
>>This "fluctuating" behaviour is in my opinion worse which is why I removed 
>>it.
> 
> 
> Trying to find a "as simple as possible" test case for this problem
> (that I consider a BUG in priority calculation) I've come up with this
> very simple program:
> 
> ------ sched_fooler.c -------------------------------
> #include <stdlib.h>
> #include <unistd.h>
> 
> static void burn_cpu(unsigned int x)
> {
> 	static char buf[1024];
> 	int i;
> 	
> 	for (i=0; i < x; ++i)
> 		buf[i%sizeof(buf)] = (x-i)*3;
> }
> 
> int main(int argc, char **argv)
> {
> 	unsigned long burn;
> 	if (argc != 2)
> 		return 1;
> 	burn = (unsigned long)atoi(argv[1]);
> 	while(1) {
> 		burn_cpu(burn*1000);
> 		usleep(1);
> 	}
> 	return 0;
> }
> ----------------------------------------------
> 
> paolo@tux ~/tmp/sched_fooler $ gcc sched_fooler.c
> paolo@tux ~/tmp/sched_fooler $ ./a.out 5000
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5633 paolo     15   0  2392  320  252 S 77.7  0.1   0:18.84 a.out
>  5225 root      15   0  169m  19m 2956 S  2.0  3.9   0:13.17 X
>  5307 paolo     15   0  100m  22m  13m S  2.0  4.4   0:04.32 kicker
> 
> 
> paolo@tux ~/tmp/sched_fooler $ ./a.out 10000
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5637 paolo     16   0  2396  320  252 R 87.4  0.1   0:13.38 a.out
>  5312 paolo     16   0 86636  22m  15m R  0.1  4.5   0:02.02 konsole
>     1 root      16   0  2552  560  468 S  0.0  0.1   0:00.71 init
> 
> 
> If I only run 2 of these together the system becomes everything but
> interactive ;)
> 
> ./a.out 10000 & ./a.out 4000
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5714 paolo     15   0  2392  320  252 S 59.2  0.1   0:12.28 a.out
>  5713 paolo     16   0  2396  320  252 S 37.1  0.1   0:07.63 a.out
> 
> 
> DD TEST: the usual DD test (to read 128 MB from a non-cached file =
> disk bounded) says everything, numbers with 2.6.15-rc7:
> 
> paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
> 128+0 records in
> 128+0 records out
> 
> real    0m4.052s
> user    0m0.004s
> sys     0m0.180s
> 
> START 2 OF THEM "./a.out 10000 & ./a.out 4000"
> 
> paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
> 128+0 records in
> 128+0 records out
> 
> real    2m4.578s
> user    0m0.000s
> sys     0m0.244s
> 
> 
> This does't surprise me anymore, since DD gets priority 18 and these
> two CPU eaters get 15/16.
> 
> As usual "nicksched" is NOT affected at all, IOW it gives to these CPU
> eaters the priority that they deserve.
> 

Attached is a testing version of a patch for modifying scheduler bonus 
calculations that I'm working on.  Although these changes aren't 
targetted at the problem you are experiencing I believe that they may 
help.  My testing shows that sched_fooler instances don't get any 
bonuses but I would appreciate it if you could try it out.

It is a patch against the 2.6.15-rc7 kernel and includes some other 
scheduling patches from the -mm kernels.

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------070402020701070906040506
Content-Type: text/x-patch;
 name="lial-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lial-test.patch"

Index: GIT_lial/fs/proc/array.c
===================================================================
--- GIT_lial.orig/fs/proc/array.c	2005-12-29 12:05:42.000000000 +1100
+++ GIT_lial/fs/proc/array.c	2005-12-31 12:29:47.000000000 +1100
@@ -165,7 +165,7 @@ static inline char * task_state(struct t
 	read_lock(&tasklist_lock);
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
-		"SleepAVG:\t%lu%%\n"
+		"LatencyAVG:\t%llu nsec\n"
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
@@ -173,7 +173,7 @@ static inline char * task_state(struct t
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		(p->sleep_avg/1024)*100/(1020000000/1024),
+		SCHED_AVG_RND(p->avg_latency),
 	       	p->tgid,
 		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
 		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
Index: GIT_lial/include/linux/sched.h
===================================================================
--- GIT_lial.orig/include/linux/sched.h	2005-12-29 12:05:42.000000000 +1100
+++ GIT_lial/include/linux/sched.h	2005-12-31 12:29:47.000000000 +1100
@@ -158,6 +158,7 @@ extern unsigned long nr_iowait(void);
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_BATCH		3
 
 struct sched_param {
 	int sched_priority;
@@ -473,9 +474,9 @@ struct signal_struct {
 
 /*
  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
- * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
- * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
- * are inverted: lower p->prio value means higher priority.
+ * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
+ * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
+ * values are inverted: lower p->prio value means higher priority.
  *
  * The MAX_USER_RT_PRIO value allows the actual maximum
  * RT priority to be separate from the value exported to
@@ -683,6 +684,19 @@ static inline void prefetch_stack(struct
 struct audit_context;		/* See audit.c */
 struct mempolicy;
 
+/*
+ * Fixed denominator rational numbers for use estimating task's average
+ * latencies and cpu usage per run
+ */
+#define SCHED_AVG_OFFSET 4
+/*
+ * Get the rounded integer value of a scheduling statistic average field
+ * Needs to be public for printing average interactive latency in
+ * fs/proc/array.c
+ */
+#define SCHED_AVG_RND(x) \
+	(((x) + (1 << (SCHED_AVG_OFFSET - 1))) >> (SCHED_AVG_OFFSET))
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -695,16 +709,19 @@ struct task_struct {
 #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	int oncpu;
 #endif
-	int prio, static_prio;
+	int prio, static_prio, latency_bonus;
+#ifdef CONFIG_SMP
+	int bias_prio;
+#endif
 	struct list_head run_list;
 	prio_array_t *array;
 
 	unsigned short ioprio;
 
-	unsigned long sleep_avg;
+	unsigned long long avg_latency;
 	unsigned long long timestamp, last_ran;
+	unsigned long long avg_cpu_run;
 	unsigned long long sched_time; /* sched_clock time spent running */
-	int activated;
 
 	unsigned long policy;
 	cpumask_t cpus_allowed;
@@ -908,6 +925,8 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_JUST_WOKEN   0x01000000      /* just woken */
+#define PF_IA_WAKE_UP   0x02000000      /* just woken from interactive sleep */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: GIT_lial/init/main.c
===================================================================
--- GIT_lial.orig/init/main.c	2005-12-31 12:28:25.000000000 +1100
+++ GIT_lial/init/main.c	2005-12-31 12:29:41.000000000 +1100
@@ -603,6 +603,8 @@ static void __init do_initcalls(void)
  *
  * Now we can finally start doing some real work..
  */
+extern void sched_sysfs_init(void);
+
 static void __init do_basic_setup(void)
 {
 	/* drivers will send hotplug events */
@@ -613,6 +615,7 @@ static void __init do_basic_setup(void)
 #ifdef CONFIG_SYSCTL
 	sysctl_init();
 #endif
+	sched_sysfs_init();
 
 	/* Networking initialization needs a process context */ 
 	sock_init();
Index: GIT_lial/kernel/exit.c
===================================================================
--- GIT_lial.orig/kernel/exit.c	2005-12-28 12:09:27.000000000 +1100
+++ GIT_lial/kernel/exit.c	2005-12-29 12:16:49.000000000 +1100
@@ -243,7 +243,9 @@ static inline void reparent_to_init(void
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
 
-	if ((current->policy == SCHED_NORMAL) && (task_nice(current) < 0))
+	if ((current->policy == SCHED_NORMAL ||
+			current->policy == SCHED_BATCH)
+				&& (task_nice(current) < 0))
 		set_user_nice(current, 0);
 	/* cpus_allowed? */
 	/* rt_priority? */
Index: GIT_lial/kernel/sched.c
===================================================================
--- GIT_lial.orig/kernel/sched.c	2005-12-29 12:05:42.000000000 +1100
+++ GIT_lial/kernel/sched.c	2005-12-31 12:30:51.000000000 +1100
@@ -60,6 +60,16 @@
 #define PRIO_TO_NICE(prio)	((prio) - MAX_RT_PRIO - 20)
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
 
+#ifdef CONFIG_SMP
+/*
+ * Priority bias for load balancing ranges from 1 (nice==19) to 139 (RT
+ * priority of 100).
+ */
+#define NICE_TO_BIAS_PRIO(nice)	(20 - (nice))
+#define PRIO_TO_BIAS_PRIO(prio)	NICE_TO_BIAS_PRIO(PRIO_TO_NICE(prio))
+#define RTPRIO_TO_BIAS_PRIO(rp)	(40 + (rp))
+#endif
+
 /*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
@@ -84,16 +94,10 @@
  */
 #define MIN_TIMESLICE		max(5 * HZ / 1000, 1)
 #define DEF_TIMESLICE		(100 * HZ / 1000)
-#define ON_RUNQUEUE_WEIGHT	 30
-#define CHILD_PENALTY		 95
-#define PARENT_PENALTY		100
-#define EXIT_WEIGHT		  3
 #define PRIO_BONUS_RATIO	 25
 #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 #define INTERACTIVE_DELTA	  2
-#define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
-#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
-#define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
+#define STARVATION_LIMIT       	(DEF_TIMESLICE * MAX_BONUS)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -123,9 +127,8 @@
  * too hard.
  */
 
-#define CURRENT_BONUS(p) \
-	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
-		MAX_SLEEP_AVG)
+#define CURRENT_BONUS(p) (just_woken_from_ia_sleep(p) ? \
+			  (p)->latency_bonus + 1 : (p)->latency_bonus)
 
 #define GRANULARITY	(10 * HZ / 1000 ? : 1)
 
@@ -147,10 +150,6 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
-
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
@@ -261,6 +260,91 @@ struct runqueue {
 
 static DEFINE_PER_CPU(struct runqueue, runqueues);
 
+#define SCHED_AVG_REAL(a) ((a) << SCHED_AVG_OFFSET)
+#define SCHED_AVG_ALPHA ((1 << SCHED_AVG_OFFSET) - 1)
+
+/* The range of acceptable interactive latencies in nanosecs */
+unsigned long unacceptable_ia_latency = 150000UL;
+unsigned int acceptability_factor = 8;
+#define ACCEPTABLE(l) ((l) >> acceptability_factor)
+#define UNACCEPTABLE_IA_LATENCY unacceptable_ia_latency
+#define ACCEPTABLE_IA_LATENCY ACCEPTABLE(UNACCEPTABLE_IA_LATENCY)
+
+static inline void incr_latency_bonus(task_t *p)
+{
+	/*
+	 * one bonus point is reserved for allocation to all  interactive
+	 * wake ups
+	 */
+	if (p->latency_bonus < (MAX_BONUS - 1))
+		++p->latency_bonus;
+}
+
+static inline void decr_latency_bonus(task_t *p)
+{
+	if (p->latency_bonus > 0)
+		--p->latency_bonus;
+}
+
+static inline int just_woken(task_t *p)
+{
+	return p->flags & PF_JUST_WOKEN;
+}
+
+static inline int just_woken_from_ia_sleep(task_t *p)
+{
+	return p->flags & PF_IA_WAKE_UP;
+}
+
+static inline void decay_avg_value(unsigned long long *val)
+{
+	*val *= SCHED_AVG_ALPHA;
+	*val >>= SCHED_AVG_OFFSET;
+}
+
+static void update_latency_bonus(task_t *p, runqueue_t *rq, unsigned long long now)
+{
+	long long delta = now - p->timestamp;
+
+	/* make allowance for sched_clock() not being monotonic */
+	if (unlikely(delta < 0))
+		delta = 0;
+
+	decay_avg_value(&p->avg_latency);
+	p->avg_latency += delta;
+
+	/* do this now rather than earlier so that average latency is available
+	 * for didplay for all tasks not just SCHED_NORMAL.
+	 */
+	if (rt_task(p) || p->policy == SCHED_BATCH)
+		goto out;
+
+	if (just_woken_from_ia_sleep(p)) {
+		if (delta > UNACCEPTABLE_IA_LATENCY)
+			incr_latency_bonus(p);
+		else if (delta < ACCEPTABLE_IA_LATENCY)
+			decr_latency_bonus(p);
+	} else {
+		unsigned long long ual = UNACCEPTABLE_IA_LATENCY;
+
+		/*
+		 * The more tasks runnable the greater the acceptable non
+		 * interactive delay.  In the interests of fairness, tasks that
+		 * use short CPU runs are smaller acceptable latencies.
+		 */
+		if (likely(rq->nr_running > 0))
+			ual += SCHED_AVG_RND(p->avg_cpu_run) *
+				(rq->nr_running - 1);
+
+		if (delta > ual)
+			incr_latency_bonus(p);
+		else if (delta < ACCEPTABLE(ual))
+			decr_latency_bonus(p);
+	}
+out:
+	p->flags &= ~(PF_IA_WAKE_UP|PF_JUST_WOKEN);
+}
+
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
  * See detach_destroy_domains: synchronize_sched for details.
@@ -633,9 +717,6 @@ static inline void enqueue_task_head(str
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
- * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
- * into the -5 ... 0 ... +5 bonus/penalty range.
- *
  * We use 25% of the full 0...39 priority range so that:
  *
  * 1) nice +19 interactive tasks do not preempt nice 0 CPU hogs.
@@ -661,46 +742,53 @@ static int effective_prio(task_t *p)
 }
 
 #ifdef CONFIG_SMP
-static inline void inc_prio_bias(runqueue_t *rq, int prio)
+static inline void set_bias_prio(task_t *p)
 {
-	rq->prio_bias += MAX_PRIO - prio;
+	if (rt_task(p)) {
+		if (p == task_rq(p)->migration_thread)
+			/*
+			 * The migration thread does the actual balancing. Do
+			 * not bias by its priority as the ultra high priority
+			 * will skew balancing adversely.
+			 */
+			p->bias_prio = 0;
+		else
+			p->bias_prio = RTPRIO_TO_BIAS_PRIO(p->rt_priority);
+	} else
+		p->bias_prio = PRIO_TO_BIAS_PRIO(p->static_prio);
+}
+
+static inline void inc_prio_bias(runqueue_t *rq, const task_t *p)
+{
+	rq->prio_bias += p->bias_prio;
 }
 
-static inline void dec_prio_bias(runqueue_t *rq, int prio)
+static inline void dec_prio_bias(runqueue_t *rq, const task_t *p)
 {
-	rq->prio_bias -= MAX_PRIO - prio;
+	rq->prio_bias -= p->bias_prio;
 }
 
 static inline void inc_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running++;
-	if (rt_task(p)) {
-		if (p != rq->migration_thread)
-			/*
-			 * The migration thread does the actual balancing. Do
-			 * not bias by its priority as the ultra high priority
-			 * will skew balancing adversely.
-			 */
-			inc_prio_bias(rq, p->prio);
-	} else
-		inc_prio_bias(rq, p->static_prio);
+	inc_prio_bias(rq, p);
 }
 
 static inline void dec_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	if (rt_task(p)) {
-		if (p != rq->migration_thread)
-			dec_prio_bias(rq, p->prio);
-	} else
-		dec_prio_bias(rq, p->static_prio);
+	dec_prio_bias(rq, p);
 }
 #else
-static inline void inc_prio_bias(runqueue_t *rq, int prio)
+static inline void set_bias_prio(task_t *p)
+{
+}
+
+static inline void inc_prio_bias(runqueue_t *rq, const task_t *p)
 {
 }
 
-static inline void dec_prio_bias(runqueue_t *rq, int prio)
+static inline void dec_prio_bias(runqueue_t *rq, const task_t *p)
 {
 }
 
@@ -733,68 +821,6 @@ static inline void __activate_idle_task(
 	inc_nr_running(p, rq);
 }
 
-static int recalc_task_prio(task_t *p, unsigned long long now)
-{
-	/* Caller must always ensure 'now >= p->timestamp' */
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
-
-	if (__sleep_time > NS_MAX_SLEEP_AVG)
-		sleep_time = NS_MAX_SLEEP_AVG;
-	else
-		sleep_time = (unsigned long)__sleep_time;
-
-	if (likely(sleep_time > 0)) {
-		/*
-		 * User tasks that sleep a long time are categorised as
-		 * idle and will get just interactive status to stay active &
-		 * prevent them suddenly becoming cpu hogs and starving
-		 * other processes.
-		 */
-		if (p->mm && p->activated != -1 &&
-			sleep_time > INTERACTIVE_SLEEP(p)) {
-				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-						DEF_TIMESLICE);
-		} else {
-			/*
-			 * The lower the sleep avg a task has the more
-			 * rapidly it will rise with sleep time.
-			 */
-			sleep_time *= (MAX_BONUS - CURRENT_BONUS(p)) ? : 1;
-
-			/*
-			 * Tasks waking from uninterruptible sleep are
-			 * limited in their sleep_avg rise as they
-			 * are likely to be waiting on I/O
-			 */
-			if (p->activated == -1 && p->mm) {
-				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
-					sleep_time = 0;
-				else if (p->sleep_avg + sleep_time >=
-						INTERACTIVE_SLEEP(p)) {
-					p->sleep_avg = INTERACTIVE_SLEEP(p);
-					sleep_time = 0;
-				}
-			}
-
-			/*
-			 * This code gives a bonus to interactive tasks.
-			 *
-			 * The boost works by updating the 'average sleep time'
-			 * value here, based on ->timestamp. The more time a
-			 * task spends sleeping, the higher the average gets -
-			 * and the higher the priority boost gets as well.
-			 */
-			p->sleep_avg += sleep_time;
-
-			if (p->sleep_avg > NS_MAX_SLEEP_AVG)
-				p->sleep_avg = NS_MAX_SLEEP_AVG;
-		}
-	}
-
-	return effective_prio(p);
-}
-
 /*
  * activate_task - move a task to the runqueue and do priority recalculation
  *
@@ -816,30 +842,8 @@ static void activate_task(task_t *p, run
 #endif
 
 	if (!rt_task(p))
-		p->prio = recalc_task_prio(p, now);
+		p->prio = effective_prio(p);
 
-	/*
-	 * This checks to make sure it's not an uninterruptible task
-	 * that is now waking up.
-	 */
-	if (!p->activated) {
-		/*
-		 * Tasks which were woken up by interrupts (ie. hw events)
-		 * are most likely of interactive nature. So we give them
-		 * the credit of extending their sleep time to the period
-		 * of time they spend on the runqueue, waiting for execution
-		 * on a CPU, first time around:
-		 */
-		if (in_interrupt())
-			p->activated = 2;
-		else {
-			/*
-			 * Normal first-time wakeups get a credit too for
-			 * on-runqueue time, but it will be weighted down:
-			 */
-			p->activated = 1;
-		}
-	}
 	p->timestamp = now;
 
 	__activate_task(p, rq);
@@ -994,61 +998,29 @@ void kick_process(task_t *p)
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
-static inline unsigned long __source_load(int cpu, int type, enum idle_type idle)
+static inline unsigned long source_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long running = rq->nr_running;
-	unsigned long source_load, cpu_load = rq->cpu_load[type-1],
-		load_now = running * SCHED_LOAD_SCALE;
+	unsigned long load_now = rq->prio_bias * SCHED_LOAD_SCALE;
 
 	if (type == 0)
-		source_load = load_now;
-	else
-		source_load = min(cpu_load, load_now);
+		return load_now;
 
-	if (running > 1 || (idle == NOT_IDLE && running))
-		/*
-		 * If we are busy rebalancing the load is biased by
-		 * priority to create 'nice' support across cpus. When
-		 * idle rebalancing we should only bias the source_load if
-		 * there is more than one task running on that queue to
-		 * prevent idle rebalance from trying to pull tasks from a
-		 * queue with only one running task.
-		 */
-		source_load = source_load * rq->prio_bias / running;
-
-	return source_load;
-}
-
-static inline unsigned long source_load(int cpu, int type)
-{
-	return __source_load(cpu, type, NOT_IDLE);
+	return min(rq->cpu_load[type-1], load_now);
 }
 
 /*
  * Return a high guess at the load of a migration-target cpu
  */
-static inline unsigned long __target_load(int cpu, int type, enum idle_type idle)
+static inline unsigned long target_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long running = rq->nr_running;
-	unsigned long target_load, cpu_load = rq->cpu_load[type-1],
-		load_now = running * SCHED_LOAD_SCALE;
+	unsigned long load_now = rq->prio_bias * SCHED_LOAD_SCALE;
 
 	if (type == 0)
-		target_load = load_now;
-	else
-		target_load = max(cpu_load, load_now);
-
-	if (running > 1 || (idle == NOT_IDLE && running))
-		target_load = target_load * rq->prio_bias / running;
+		return load_now;
 
-	return target_load;
-}
-
-static inline unsigned long target_load(int cpu, int type)
-{
-	return __target_load(cpu, type, NOT_IDLE);
+	return max(rq->cpu_load[type-1], load_now);
 }
 
 /*
@@ -1306,7 +1278,7 @@ static int try_to_wake_up(task_t *p, uns
 			 * of the current CPU:
 			 */
 			if (sync)
-				tl -= SCHED_LOAD_SCALE;
+				tl -= p->bias_prio * SCHED_LOAD_SCALE;
 
 			if ((tl <= load &&
 				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
@@ -1353,25 +1325,21 @@ out_set_cpu:
 
 out_activate:
 #endif /* CONFIG_SMP */
-	if (old_state == TASK_UNINTERRUPTIBLE) {
+	if (old_state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible--;
-		/*
-		 * Tasks on involuntary sleep don't earn
-		 * sleep_avg beyond just interactive state.
-		 */
-		p->activated = -1;
-	}
-
 	/*
-	 * Tasks that have marked their sleep as noninteractive get
-	 * woken up without updating their sleep average. (i.e. their
-	 * sleep is handled in a priority-neutral manner, no priority
-	 * boost and no penalty.)
+	 * uninterruptible sleeps are assumed to be non interactive.
+	 * interruptible sleeps are assumed to be interactive unless
+	 * tagged with the TASK_NONINTERACTIVE flag.
 	 */
-	if (old_state & TASK_NONINTERACTIVE)
-		__activate_task(p, rq);
+	if (old_state == TASK_INTERRUPTIBLE)
+		p->flags |= PF_IA_WAKE_UP;
 	else
-		activate_task(p, rq, cpu == this_cpu);
+		p->flags &= ~PF_IA_WAKE_UP;
+
+	p->flags |= PF_JUST_WOKEN;
+
+	activate_task(p, rq, cpu == this_cpu);
 	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
@@ -1421,6 +1389,15 @@ void fastcall sched_fork(task_t *p, int 
 	set_task_cpu(p, cpu);
 
 	/*
+	 * Leave the latency bonus the same as the parent's.
+	 * This helps new tasks launched by media to get off to a good start
+	 * when the system is under load. If they don't warrant it they'll soon
+	 * lose it.
+	 */
+	p->avg_latency = 0;
+	p->avg_cpu_run = 0;
+
+	/*
 	 * We mark the process as running here, but have not actually
 	 * inserted it onto the runqueue yet. This guarantees that
 	 * nobody will actually run it, and a signal or other external
@@ -1477,22 +1454,13 @@ void fastcall wake_up_new_task(task_t *p
 {
 	unsigned long flags;
 	int this_cpu, cpu;
-	runqueue_t *rq, *this_rq;
+	runqueue_t *rq;
 
 	rq = task_rq_lock(p, &flags);
 	BUG_ON(p->state != TASK_RUNNING);
 	this_cpu = smp_processor_id();
 	cpu = task_cpu(p);
 
-	/*
-	 * We decrease the sleep average of forking parents
-	 * and children as well, to keep max-interactive tasks
-	 * from forking tasks that are max-interactive. The parent
-	 * (current) is done further down, under its lock.
-	 */
-	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
-		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-
 	p->prio = effective_prio(p);
 
 	if (likely(cpu == this_cpu)) {
@@ -1515,15 +1483,8 @@ void fastcall wake_up_new_task(task_t *p
 		} else
 			/* Run child last */
 			__activate_task(p, rq);
-		/*
-		 * We skip the following code due to cpu == this_cpu
-	 	 *
-		 *   task_rq_unlock(rq, &flags);
-		 *   this_rq = task_rq_lock(current, &flags);
-		 */
-		this_rq = rq;
 	} else {
-		this_rq = cpu_rq(this_cpu);
+		runqueue_t *this_rq = cpu_rq(this_cpu);
 
 		/*
 		 * Not the local CPU - must adjust timestamp. This should
@@ -1534,17 +1495,8 @@ void fastcall wake_up_new_task(task_t *p
 		__activate_task(p, rq);
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
-
-		/*
-		 * Parent and child are on different CPUs, now get the
-		 * parent runqueue to update the parent's ->sleep_avg:
-		 */
-		task_rq_unlock(rq, &flags);
-		this_rq = task_rq_lock(current, &flags);
 	}
-	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
-		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
-	task_rq_unlock(this_rq, &flags);
+	task_rq_unlock(rq, &flags);
 }
 
 /*
@@ -1571,10 +1523,6 @@ void fastcall sched_exit(task_t *p)
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
 	}
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
-		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
-		(EXIT_WEIGHT + 1);
 	task_rq_unlock(rq, &flags);
 }
 
@@ -1911,15 +1859,16 @@ int can_migrate_task(task_t *p, runqueue
  * Called with both runqueues locked.
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
-		      unsigned long max_nr_move, struct sched_domain *sd,
-		      enum idle_type idle, int *all_pinned)
+		      unsigned long max_nr_move, long max_bias_move,
+		      struct sched_domain *sd, enum idle_type idle,
+		      int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0, pinned = 0;
 	task_t *tmp;
 
-	if (max_nr_move == 0)
+	if (max_nr_move == 0 || max_bias_move == 0)
 		goto out;
 
 	pinned = 1;
@@ -1962,7 +1911,8 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+	if (tmp->bias_prio > max_bias_move ||
+	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1976,9 +1926,13 @@ skip_queue:
 
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
+	max_bias_move -= tmp->bias_prio;
 
-	/* We only want to steal up to the prescribed number of tasks. */
-	if (pulled < max_nr_move) {
+	/*
+	 * We only want to steal up to the prescribed number of tasks
+	 * and the prescribed amount of biased load.
+	 */
+	if (pulled < max_nr_move && max_bias_move > 0) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1999,7 +1953,7 @@ out:
 
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
- * domain. It calculates and returns the number of tasks which should be
+ * domain. It calculates and returns the amount of biased load which should be
  * moved to restore balance via the imbalance parameter.
  */
 static struct sched_group *
@@ -2035,9 +1989,9 @@ find_busiest_group(struct sched_domain *
 
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
-				load = __target_load(i, load_idx, idle);
+				load = target_load(i, load_idx);
 			else
-				load = __source_load(i, load_idx, idle);
+				load = source_load(i, load_idx);
 
 			avg_load += load;
 		}
@@ -2092,7 +2046,7 @@ find_busiest_group(struct sched_domain *
 		unsigned long tmp;
 
 		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
-			*imbalance = 1;
+			*imbalance = NICE_TO_BIAS_PRIO(0);
 			return busiest;
 		}
 
@@ -2125,7 +2079,7 @@ find_busiest_group(struct sched_domain *
 		if (pwr_move <= pwr_now)
 			goto out_balanced;
 
-		*imbalance = 1;
+		*imbalance = NICE_TO_BIAS_PRIO(0);
 		return busiest;
 	}
 
@@ -2142,15 +2096,14 @@ out_balanced:
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
-static runqueue_t *find_busiest_queue(struct sched_group *group,
-	enum idle_type idle)
+static runqueue_t *find_busiest_queue(struct sched_group *group)
 {
 	unsigned long load, max_load = 0;
 	runqueue_t *busiest = NULL;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = __source_load(i, 0, idle);
+		load = source_load(i, 0);
 
 		if (load > max_load) {
 			max_load = load;
@@ -2167,6 +2120,7 @@ static runqueue_t *find_busiest_queue(st
  */
 #define MAX_PINNED_INTERVAL	512
 
+#define minus_1_or_zero(n) ((n) > 0 ? (n) - 1 : 0)
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -2194,7 +2148,7 @@ static int load_balance(int this_cpu, ru
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, idle);
+	busiest = find_busiest_queue(group);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2214,6 +2168,7 @@ static int load_balance(int this_cpu, ru
 		 */
 		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, idle, &all_pinned);
 		double_rq_unlock(this_rq, busiest);
 
@@ -2317,7 +2272,7 @@ static int load_balance_newidle(int this
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, NEWLY_IDLE);
+	busiest = find_busiest_queue(group);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2332,6 +2287,7 @@ static int load_balance_newidle(int this
 		/* Attempt to move tasks */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
 	}
@@ -2412,7 +2368,8 @@ static void active_load_balance(runqueue
 
 	schedstat_inc(sd, alb_cnt);
 
-	if (move_tasks(target_rq, target_cpu, busiest_rq, 1, sd, SCHED_IDLE, NULL))
+	if (move_tasks(target_rq, target_cpu, busiest_rq, 1,
+			RTPRIO_TO_BIAS_PRIO(100), sd, SCHED_IDLE, NULL))
 		schedstat_inc(sd, alb_pushed);
 	else
 		schedstat_inc(sd, alb_failed);
@@ -2440,7 +2397,7 @@ static void rebalance_tick(int this_cpu,
 	struct sched_domain *sd;
 	int i;
 
-	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
+	this_load = this_rq->prio_bias * SCHED_LOAD_SCALE;
 	/* Update our load */
 	for (i = 0; i < 3; i++) {
 		unsigned long new_load = this_load;
@@ -2689,6 +2646,10 @@ void scheduler_tick(void)
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
+		/* make sure that tasks that obtain an latency_bonus but then
+		 * become CPU bound eventually lose the bonus.
+		 */
+		decr_latency_bonus(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
@@ -2949,8 +2910,7 @@ asmlinkage void __sched schedule(void)
 	prio_array_t *array;
 	struct list_head *queue;
 	unsigned long long now;
-	unsigned long run_time;
-	int cpu, idx, new_prio;
+	int cpu, idx;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2985,21 +2945,12 @@ need_resched_nonpreemptible:
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
-		run_time = now - prev->timestamp;
-		if (unlikely((long long)(now - prev->timestamp) < 0))
-			run_time = 0;
-	} else
-		run_time = NS_MAX_SLEEP_AVG;
-
-	/*
-	 * Tasks charged proportionately less run_time at high sleep_avg to
-	 * delay them losing their interactive status
-	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
 
 	spin_lock_irq(&rq->lock);
 
+	if (likely(now > prev->timestamp))
+		prev->avg_cpu_run += now - prev->timestamp;
+
 	if (unlikely(prev->flags & PF_DEAD))
 		prev->state = EXIT_DEAD;
 
@@ -3063,25 +3014,6 @@ go_idle:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (!rt_task(next) && next->activated > 0) {
-		unsigned long long delta = now - next->timestamp;
-		if (unlikely((long long)(now - next->timestamp) < 0))
-			delta = 0;
-
-		if (next->activated == 1)
-			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
-
-		array = next->array;
-		new_prio = recalc_task_prio(next, next->timestamp + delta);
-
-		if (unlikely(next->prio != new_prio)) {
-			dequeue_task(next, array);
-			next->prio = new_prio;
-			enqueue_task(next, array);
-		} else
-			requeue_task(next, array);
-	}
-	next->activated = 0;
 switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
@@ -3091,14 +3023,13 @@ switch_tasks:
 	rcu_qsctr_inc(task_cpu(prev));
 
 	update_cpu_clock(prev, rq, now);
-
-	prev->sleep_avg -= run_time;
-	if ((long)prev->sleep_avg <= 0)
-		prev->sleep_avg = 0;
 	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
+		decay_avg_value(&prev->avg_cpu_run);
+		if (just_woken(next))
+			update_latency_bonus(next, rq, now);
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
@@ -3543,7 +3474,7 @@ void set_user_nice(task_t *p, long nice)
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
 	 * it wont have any effect on scheduling until the task is
-	 * not SCHED_NORMAL:
+	 * not SCHED_NORMAL/SCHED_BATCH:
 	 */
 	if (rt_task(p)) {
 		p->static_prio = NICE_TO_PRIO(nice);
@@ -3552,18 +3483,19 @@ void set_user_nice(task_t *p, long nice)
 	array = p->array;
 	if (array) {
 		dequeue_task(p, array);
-		dec_prio_bias(rq, p->static_prio);
+		dec_prio_bias(rq, p);
 	}
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
+	set_bias_prio(p);
 	p->prio += delta;
 
 	if (array) {
 		enqueue_task(p, array);
-		inc_prio_bias(rq, p->static_prio);
+		inc_prio_bias(rq, p);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3689,10 +3621,17 @@ static void __setscheduler(struct task_s
 	BUG_ON(p->array);
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL)
+	if (policy != SCHED_NORMAL && policy != SCHED_BATCH) {
 		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
-	else
+	} else {
 		p->prio = p->static_prio;
+		/*
+		 * SCHED_BATCH tasks are treated as perpetual CPU hogs:
+		 */
+		if (policy == SCHED_BATCH)
+			p->latency_bonus = 0;
+	}
+	set_bias_prio(p);
 }
 
 /**
@@ -3716,29 +3655,35 @@ recheck:
 	if (policy < 0)
 		policy = oldpolicy = p->policy;
 	else if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
+				policy != SCHED_NORMAL && policy != SCHED_BATCH)
 			return -EINVAL;
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
+	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL and
+	 * SCHED_BATCH is 0.
 	 */
 	if (param->sched_priority < 0 ||
 	    (p->mm && param->sched_priority > MAX_USER_RT_PRIO-1) ||
 	    (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
 		return -EINVAL;
-	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
+	if ((policy == SCHED_NORMAL || policy == SCHED_BATCH)
+					!= (param->sched_priority == 0))
 		return -EINVAL;
 
 	/*
 	 * Allow unprivileged RT tasks to decrease priority:
 	 */
 	if (!capable(CAP_SYS_NICE)) {
-		/* can't change policy */
-		if (policy != p->policy &&
-			!p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
+		/*
+		 * can't change policy, except between SCHED_NORMAL
+		 * and SCHED_BATCH:
+		 */
+		if (((policy != SCHED_NORMAL && p->policy != SCHED_BATCH) &&
+			(policy != SCHED_BATCH && p->policy != SCHED_NORMAL)) &&
+				!p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
 			return -EPERM;
 		/* can't increase priority */
-		if (policy != SCHED_NORMAL &&
+		if ((policy != SCHED_NORMAL && policy != SCHED_BATCH) &&
 		    param->sched_priority > p->rt_priority &&
 		    param->sched_priority >
 				p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
@@ -4216,6 +4161,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 		break;
 	}
@@ -4239,6 +4185,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 	}
 	return ret;
@@ -4394,7 +4341,9 @@ void __devinit init_idle(task_t *idle, i
 	runqueue_t *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	idle->sleep_avg = 0;
+	idle->avg_latency = 0;
+	idle->avg_cpu_run = 0;
+	idle->latency_bonus = 0;
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
@@ -5634,6 +5583,7 @@ void __init sched_init(void)
 		}
 	}
 
+	set_bias_prio(&init_task);
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
@@ -5745,3 +5695,128 @@ void set_curr_task(int cpu, task_t *p)
 }
 
 #endif
+
+/*
+ * Place scheduler attributes in sysfs
+ */
+
+#include <linux/sysfs.h>
+
+static ssize_t show_unacceptable_ia_latency(char *page)
+{
+	return sprintf(page, "%ld\n", unacceptable_ia_latency);
+}
+
+static ssize_t store_unacceptable_ia_latency(const char *page, size_t count)
+{
+	unsigned long long val;
+	char *end = NULL;
+
+	val = simple_strtoull(page, &end, 10);
+	if ((end == page) || ((*end != '\0') && (*end != '\n')))
+		return -EINVAL;
+	if (val > ULONG_MAX)
+		unacceptable_ia_latency = ULONG_MAX;
+	else
+		unacceptable_ia_latency = val;
+
+	return count;
+}
+
+static ssize_t show_acceptability_factor(char *page)
+{
+	return sprintf(page, "%d\n", acceptability_factor);
+}
+
+static ssize_t store_acceptability_factor(const char *page, size_t count)
+{
+	unsigned long long val;
+	char *end = NULL;
+
+	val = simple_strtoull(page, &end, 10);
+	if ((end == page) || ((*end != '\0') && (*end != '\n')))
+		return -EINVAL;
+	if (val > UINT_MAX)
+		acceptability_factor = UINT_MAX;
+	else
+		acceptability_factor = val;
+
+	return count;
+}
+
+struct sched_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(char *);
+	ssize_t (*store)(const char *, size_t);
+};
+
+#define to_sched_sysfs_entry(a) \
+	container_of((a), struct sched_sysfs_entry, attr)
+
+static ssize_t show_attribute(struct kobject *kobj, struct attribute *attr,
+			      char *page)
+{
+	struct sched_sysfs_entry *e = to_sched_sysfs_entry(attr);
+
+	if (!e->show)
+		return 0;
+
+	return e->show(page);
+}
+
+static ssize_t store_attribute(struct kobject *kobj, struct attribute *attr,
+			       const char *page, size_t length)
+{
+	struct sched_sysfs_entry *e = to_sched_sysfs_entry(attr);
+
+	if (!e->show)
+		return -EBADF;
+
+	return e->store(page, length);
+}
+
+struct sysfs_ops sched_sysfs_ops = {
+	.show = show_attribute,
+	.store = store_attribute,
+};
+
+static struct sched_sysfs_entry unacceptable_ia_latency_sdse = {
+	.attr = { .name = "unacceptable_ia_latency",
+		  .mode = S_IRUGO | S_IWUSR },
+	.show = show_unacceptable_ia_latency,
+	.store = store_unacceptable_ia_latency,
+};
+
+static struct sched_sysfs_entry acceptability_factor_sdse = {
+	.attr = { .name = "acceptability_factor",
+		  .mode = S_IRUGO | S_IWUSR },
+	.show = show_acceptability_factor,
+	.store = store_acceptability_factor,
+};
+
+static struct attribute *sched_attrs[] = {
+	&unacceptable_ia_latency_sdse.attr,
+	&acceptability_factor_sdse.attr,
+	NULL,
+};
+
+static struct kobj_type sched_ktype = {
+	.sysfs_ops = &sched_sysfs_ops,
+	.default_attrs = sched_attrs,
+};
+
+static struct kobject sched_kobj = {
+	.ktype = &sched_ktype
+};
+
+decl_subsys(cpusched, NULL, NULL);
+
+void __init sched_sysfs_init(void)
+{
+	if (subsystem_register(&cpusched_subsys) == 0) {
+		sched_kobj.kset = &cpusched_subsys.kset;
+		strncpy(sched_kobj.name, "attrs", KOBJ_NAME_LEN);
+		sched_kobj.kset = &cpusched_subsys.kset;
+		(void)kobject_register(&sched_kobj);
+ 	}
+}

--------------070402020701070906040506--
