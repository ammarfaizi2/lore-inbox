Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUJEFQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUJEFQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUJEFQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:16:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268786AbUJEFPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:15:50 -0400
Date: Mon, 4 Oct 2004 22:15:36 -0700
Message-Id: <200410050515.i955Fa15004063@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Subject: [PATCH] CPU time clock support in clock_* syscalls
X-Shopping-List: (1) Dramatic Budweiser splits
   (2) Weary translators
   (3) Onerous concussions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an alternative to Christoph Lameter's proposals.  I think it
provides better functionality, and a more robust implementation.  (The last
version of Christoph's patch I saw had a notable lack of necessary locking,
for example.)  I am working on an expansion of this to implement timers
too.  But since the code I've already finished and tested does more than
the proposal that's been floated, it seemed appropriate to separate out the
clock sampling functionality and post this.


This patch implements CPU time clocks in the clock_* interface
(posix-timers) for threads and processes (thread groups).  These are
clockid_t values with the high bits set (i.e. negative), which encode a PID
(which can be zero to indicate the caller), and a flag indicating a
per-thread or per-process clock.  

There are three flavors of clock supported, each in thread and process
variants.  The PROF clock counts utime + stime; this is the same clock by
which ITIMER_PROF is defined.  The VIRT clock counts just utime; this is
the same clock by which ITIMER_VIRTUAL is defined.  These utime and stime
are the same values reported e.g. by getrusage and times.  That is, the
clock accumulates 1sec/HZ for each 1sec/HZ period in which that thread was
running when the system timer interrupt came.  The final flavor of clock is
SCHED, which uses time as reported by `sched_clock' and count the elapsed
time that the thread was scheduled on the CPU.  For many platforms,
sched_clock just uses jiffies (i.e. the system timer interrupt) and so this
is the same as the PROF clock.  But when a high-resolution cycle counter is
available (e.g. TSC on x86), then the SCHED clock records finer-grained and
more accurate information, because it charges a thread for the time it was
actually on a CPU between context switches, not the whole 1sec/HZ period.
When examining the SCHED clocks of other threads that are currently
scheduled on other CPUs, you only see the time accumulated as of the last
timer interrupt or context switch, but when asking about the current thread
it also adds in the current delta since the last context switch.

The PROF and VIRT clocks are the information that's traditionally available
and used for getrusage, SIGPROF/SIGVTALRM, etc.  The SCHED clock is the
best information available.  I figured I'd provide all three and let
userland decide when it wants to use which.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/include/linux/posix-timers.h 2 Jul 2004 17:31:23 -0000 1.3
+++ linux-2.6/include/linux/posix-timers.h 5 Oct 2004 04:36:57 -0000
@@ -4,6 +4,23 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 
+#define CPUCLOCK_PID(clock)	((pid_t) ~((clock) >> 3))
+#define CPUCLOCK_PERTHREAD(clock) \
+	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
+#define CPUCLOCK_PID_MASK	7
+#define CPUCLOCK_PERTHREAD_MASK	4
+#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
+#define CPUCLOCK_CLOCK_MASK	3
+#define CPUCLOCK_PROF		0
+#define CPUCLOCK_VIRT		1
+#define CPUCLOCK_SCHED		2
+#define CPUCLOCK_MAX		3
+
+#define MAKE_PROCESS_CPUCLOCK(pid, clock) \
+	((~(clockid_t) (pid) << 3) | (clockid_t) (clock))
+#define MAKE_THREAD_CPUCLOCK(tid, clock) \
+	MAKE_PROCESS_CPUCLOCK((tid), (clock) | CPUCLOCK_PERTHREAD_MASK)
+
 struct k_clock_abs {
 	struct list_head list;
 	spinlock_t lock;
@@ -41,4 +58,9 @@ struct now_struct {
                   (timr)->it_overrun += orun;				\
               }								\
             }while (0)
+
+int posix_cpu_clock_getres(clockid_t, struct timespec __user *);
+int posix_cpu_clock_gettime(clockid_t, struct timespec __user *);
+int posix_cpu_clock_settime(clockid_t, const struct timespec __user *);
+
 #endif
--- linux-2.6/include/linux/sched.h 13 Sep 2004 21:05:18 -0000 1.272
+++ linux-2.6/include/linux/sched.h 5 Oct 2004 01:08:31 -0000
@@ -312,6 +312,14 @@ struct signal_struct {
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw;
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
+
+	/*
+	 * Cumulative ns of scheduled CPU time for dead threads in the
+	 * group, not including a zombie group leader.  (This only differs
+	 * from jiffies_to_ns(utime + stime) if sched_clock uses something
+	 * other than jiffies.)
+	 */
+	unsigned long long sched_time;
 };
 
 /*
@@ -450,6 +458,7 @@ struct task_struct {
 	unsigned long sleep_avg;
 	long interactive_credit;
 	unsigned long long timestamp;
+	unsigned long long sched_time; /* sched_clock time spent running */
 	int activated;
 
 	unsigned long policy;
@@ -632,6 +641,7 @@ static inline int set_cpus_allowed(task_
 #endif
 
 extern unsigned long long sched_clock(void);
+extern unsigned long long current_sched_time(const task_t *current_task);
 
 /* sched_exec is called by processes performing an exec */
 #ifdef CONFIG_SMP
--- linux-2.6/kernel/Makefile 4 Sep 2004 23:18:26 -0000 1.43
+++ linux-2.6/kernel/Makefile 5 Oct 2004 01:04:59 -0000
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o posix-cpu-timers.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
--- linux-2.6/kernel/fork.c 23 Sep 2004 01:21:19 -0000 1.216
+++ linux-2.6/kernel/fork.c 5 Oct 2004 01:25:58 -0000
@@ -871,6 +871,7 @@ static inline int copy_signal(unsigned l
 	sig->utime = sig->stime = sig->cutime = sig->cstime = 0;
 	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
 	sig->min_flt = sig->maj_flt = sig->cmin_flt = sig->cmaj_flt = 0;
+	sig->sched_time = 0;
 
 	return 0;
 }
@@ -991,6 +992,7 @@ static task_t *copy_process(unsigned lon
 	p->real_timer.data = (unsigned long) p;
 
 	p->utime = p->stime = 0;
+	p->sched_time = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
--- linux-2.6/kernel/posix-timers.c 11 Sep 2004 06:20:07 -0000 1.36
+++ linux-2.6/kernel/posix-timers.c 5 Oct 2004 01:14:04 -0000
@@ -133,13 +133,9 @@ static spinlock_t idr_lock = SPIN_LOCK_U
  *	    resolution.	 Here we define the standard CLOCK_REALTIME as a
  *	    1/HZ resolution clock.
  *
- * CPUTIME & THREAD_CPUTIME: We are not, at this time, definding these
- *	    two clocks (and the other process related clocks (Std
- *	    1003.1d-1999).  The way these should be supported, we think,
- *	    is to use large negative numbers for the two clocks that are
- *	    pinned to the executing process and to use -pid for clocks
- *	    pinned to particular pids.	Calls which supported these clock
- *	    ids would split early in the function.
+ * CPUTIME: These clocks have clockid_t values < -1.  All the clock
+ *	    and timer system calls here just punt to posix_cpu_*
+ *	    functions defined in posix-cpu-timers.c, which see.there.
  *
  * RESOLUTION: Clock resolution is used to round up timer and interval
  *	    times, NOT to report clock times, which are reported with as
@@ -1232,6 +1228,9 @@ sys_clock_settime(clockid_t which_clock,
 {
 	struct timespec new_tp;
 
+	if (which_clock < 0)
+		return posix_cpu_clock_settime(which_clock, tp);
+
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
@@ -1249,6 +1248,9 @@ sys_clock_gettime(clockid_t which_clock,
 	struct timespec rtn_tp;
 	int error = 0;
 
+	if (which_clock < 0)
+		return posix_cpu_clock_gettime(which_clock, tp);
+
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
@@ -1267,6 +1269,9 @@ sys_clock_getres(clockid_t which_clock, 
 {
 	struct timespec rtn_tp;
 
+	if (which_clock < 0)
+		return posix_cpu_clock_getres(which_clock, tp);
+
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
--- linux-2.6/kernel/sched.c 24 Sep 2004 16:31:53 -0000 1.353
+++ linux-2.6/kernel/sched.c 5 Oct 2004 01:03:34 -0000
@@ -2358,6 +2358,31 @@ DEFINE_PER_CPU(struct kernel_stat, kstat
 EXPORT_PER_CPU_SYMBOL(kstat);
 
 /*
+ * This is called on clock ticks and on context switches.
+ * Bank in p->sched_time the ns elapsed since the last tick or switch.
+ */
+static void update_cpu_clock(task_t *p, runqueue_t *rq,
+			     unsigned long long now)
+{
+	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
+	p->sched_time += now - last;
+}
+
+/*
+ * Return current->sched_time plus any more ns on the sched_clock
+ * that have not yet been banked.
+ */
+unsigned long long current_sched_time(const task_t *tsk)
+{
+	unsigned long long ns;
+	local_irq_disable();
+	ns = max(tsk->timestamp, task_rq(tsk)->timestamp_last_tick);
+	ns = tsk->sched_time + (sched_clock() - ns);
+	local_irq_enable();
+	return ns;
+}
+
+/*
  * We place interactive tasks back into the active array, if possible.
  *
  * To guarantee that this does not starve expired tasks we ignore the
@@ -2386,8 +2411,11 @@ void scheduler_tick(int user_ticks, int 
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
+	unsigned long long now = sched_clock();
+
+	update_cpu_clock(p, rq, now);
 
-	rq->timestamp_last_tick = sched_clock();
+	rq->timestamp_last_tick = now;
 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
@@ -2758,6 +2786,8 @@ switch_tasks:
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 
+	update_cpu_clock(prev, rq, now);
+
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0) {
 		prev->sleep_avg = 0;
--- linux-2.6/kernel/signal.c 16 Sep 2004 14:12:54 -0000 1.139
+++ linux-2.6/kernel/signal.c 5 Oct 2004 05:11:59 -0000
@@ -385,6 +385,7 @@ void __exit_signal(struct task_struct *t
 		sig->maj_flt += tsk->maj_flt;
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
+		sig->sched_time += tsk->sched_time;
 		spin_unlock(&sighand->siglock);
 		sig = NULL;	/* Marker for below.  */
 	}
--- /dev/null	2004-02-23 13:02:56.000000000 -0800
+++ linux-2.6/kernel/posix-cpu-timers.c	2004-10-04 18:28:40.000000000 -0700
@@ -0,0 +1,234 @@
+/*
+ * Implement CPU time clocks for the POSIX clock interface.
+ */
+
+#include <linux/sched.h>
+#include <linux/posix-timers.h>
+#include <asm/uaccess.h>
+#include <linux/errno.h>
+
+union cpu_time_count {
+	unsigned long cpu;
+	unsigned long long sched;
+};
+
+static int check_clock(clockid_t which_clock)
+{
+	int error = 0;
+	struct task_struct *p;
+	const pid_t pid = CPUCLOCK_PID(which_clock);
+
+	if (CPUCLOCK_WHICH(which_clock) >= CPUCLOCK_MAX)
+		return -EINVAL;
+
+	if (pid == 0)
+		return 0;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	if (!p || (CPUCLOCK_PERTHREAD(which_clock) ?
+		   p->tgid != current->tgid : p->tgid != pid)) {
+		error = -EINVAL;
+	}
+	read_unlock(&tasklist_lock);
+
+	return error;
+}
+
+static void sample_to_timespec(clockid_t which_clock,
+			       union cpu_time_count cpu,
+			       struct timespec *tp)
+{
+	if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+		tp->tv_sec = div_long_long_rem(cpu.sched,
+					       NSEC_PER_SEC, &tp->tv_nsec);
+	} else {
+		jiffies_to_timespec(cpu.cpu, tp);
+	}
+}
+
+static int sample_to_user(clockid_t which_clock,
+			  union cpu_time_count cpu,
+			  struct timespec __user *tp)
+{
+	struct timespec ts;
+	sample_to_timespec(which_clock, cpu, &ts);
+	return copy_to_user(tp, &ts, sizeof *tp) ? -EFAULT : 0;
+}
+
+static inline unsigned long prof_ticks(struct task_struct *p)
+{
+	return p->utime + p->stime;
+}
+static inline unsigned long virt_ticks(struct task_struct *p)
+{
+	return p->utime;
+}
+static inline unsigned long long sched_ns(struct task_struct *p)
+{
+	return (p == current) ? current_sched_time(p) : p->sched_time;
+}
+
+int posix_cpu_clock_getres(clockid_t which_clock, struct timespec __user *tp)
+{
+	int error = check_clock(which_clock);
+	if (!error && tp) {
+		struct timespec rtn_tp = { 0, ((NSEC_PER_SEC + HZ - 1) / HZ) };
+		if (CPUCLOCK_WHICH(which_clock) == CPUCLOCK_SCHED) {
+			/*
+			 * If sched_clock is using a cycle counter, we
+			 * don't have any idea of its true resolution
+			 * exported, but it is much more than 1s/HZ.
+			 */
+			rtn_tp.tv_nsec = 1;
+		}
+		if (copy_to_user(tp, &rtn_tp, sizeof *tp))
+			error = -EFAULT;
+	}
+	return error;
+}
+
+int posix_cpu_clock_settime(clockid_t which_clock,
+			    const struct timespec __user *tp)
+{
+	/*
+	 * You can never reset a CPU clock, but we check for other errors
+	 * in the call before failing with EPERM.
+	 */
+	int error = check_clock(which_clock);
+	if (error == 0) {
+		struct timespec new_tp;
+		error = -EPERM;
+		if (copy_from_user(&new_tp, tp, sizeof *tp))
+			error = -EFAULT;
+	}
+	return error;
+}
+
+static int cpu_clock_sample(clockid_t which_clock, struct task_struct *p,
+			    union cpu_time_count *cpu)
+{
+	switch (CPUCLOCK_WHICH(which_clock)) {
+	default:
+		return -EINVAL;
+	case CPUCLOCK_PROF:
+		cpu->cpu = prof_ticks(p);
+		break;
+	case CPUCLOCK_VIRT:
+		cpu->cpu = virt_ticks(p);
+		break;
+	case CPUCLOCK_SCHED:
+		cpu->sched = sched_ns(p);
+		break;
+	}
+	return 0;
+}
+
+/*
+ * Must be called with tasklist_lock held for reading.
+ */
+static int cpu_clock_sample_group(clockid_t which_clock,
+				  struct task_struct *p,
+				  union cpu_time_count *cpu,
+				  unsigned int *nthreads)
+{
+	struct task_struct *t = p;
+	unsigned long flags;
+	switch (CPUCLOCK_WHICH(which_clock)) {
+	default:
+		return -EINVAL;
+	case CPUCLOCK_PROF:
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		*nthreads = 0;
+		cpu->cpu = p->signal->utime + p->signal->stime;
+		do {
+			if (!unlikely(t->state & (TASK_DEAD|TASK_ZOMBIE)))
+				++*nthreads;
+			cpu->cpu += prof_ticks(t);
+			t = next_thread(t);
+		} while (t != p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		break;
+	case CPUCLOCK_VIRT:
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		*nthreads = 0;
+		cpu->cpu = p->signal->utime;
+		do {
+			if (!unlikely(t->state & (TASK_DEAD|TASK_ZOMBIE)))
+				++*nthreads;
+			cpu->cpu += virt_ticks(t);
+			t = next_thread(t);
+		} while (t != p);
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		break;
+	case CPUCLOCK_SCHED:
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		cpu->sched = p->signal->sched_time;
+		*nthreads = 1;
+		/* Add in each other live thread.  */
+		while ((t = next_thread(t)) != p) {
+			if (!unlikely(t->state & (TASK_DEAD|TASK_ZOMBIE)))
+				++*nthreads;
+			cpu->sched += t->sched_time;
+		}
+		if (p->tgid == current->tgid) {
+			/*
+			 * We're sampling ourselves, so include the
+			 * cycles not yet banked.  We still omit
+			 * other threads running on other CPUs,
+			 * so the total can always be behind as
+			 * much as max(nthreads-1,ncpus) * (NSEC_PER_SEC/HZ).
+			 */
+			cpu->sched += current_sched_time(current);
+		} else {
+			cpu->sched += p->sched_time;
+		}
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		break;
+	}
+	return 0;
+}
+
+int posix_cpu_clock_gettime(clockid_t which_clock, struct timespec __user *tp)
+{
+	const pid_t pid = CPUCLOCK_PID(which_clock);
+	int error = -EINVAL;
+	union cpu_time_count rtn;
+
+	if (pid == 0) {
+		if (CPUCLOCK_PERTHREAD(which_clock)) {
+			/*
+			 * Sampling just ourselves we can do with no locking.
+			 */
+			error = cpu_clock_sample(which_clock,
+						 current, &rtn);
+		} else {
+			unsigned int n;
+			read_lock(&tasklist_lock);
+			error = cpu_clock_sample_group(which_clock,
+						       current, &rtn, &n);
+			read_unlock(&tasklist_lock);
+		}
+	} else {
+		struct task_struct *p;
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(pid);
+		if (p) {
+			if (CPUCLOCK_PERTHREAD(which_clock)) {
+				if (p->tgid == current->tgid) {
+					error = cpu_clock_sample(which_clock,
+								 p, &rtn);
+				}
+			} else if (p->tgid == pid && p->signal) {
+				unsigned int n;
+				error = cpu_clock_sample_group(which_clock,
+							       p, &rtn, &n);
+			}
+		}
+		read_unlock(&tasklist_lock);
+	}
+
+	if (error)
+		return error;
+	return sample_to_user(which_clock, rtn, tp);
+}
