Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTLJWZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTLJWZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:25:36 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:64926 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S264163AbTLJWZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:25:16 -0500
Date: Wed, 10 Dec 2003 23:23:55 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031210222355.GB28912@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch> <20031209040501.GE19856@holomorphy.com> <20031209151103.GA4837@k3.hellgate.ch> <20031209193801.GF19856@holomorphy.com> <20031210135829.GA18370@k3.hellgate.ch> <20031210174757.GK19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20031210174757.GK19856@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, 10 Dec 2003 09:47:57 -0800, William Lee Irwin III wrote:
> On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> > Actually, I'm rather well on my way wrapping things up. I documented
> > in detail how much 2.6 sucks in this area and where the potential for
> > improvements would have likely been, but now I've got a deadline to
> > meet and other things on my plate.
> 
> Well, it'd be nice to see the code, then.

I attached the stunning code I wrote a few months ago, rediffed
against test11, seems to compile. It does not include the eviction code
(although you can tell where it plugs in) -- that's a bit messy and
I'm not too confident that I got all the locking right.

The trigger in the page allocator worked pretty well in test4 to test6,
but it is sensitive to VM changes. Earlier 2.5 kernels went through
the slow path much more frequently (IIRC before akpm limited use of
blk_congestion_wait), for instance. That would require a different
trigger.

The time processes spend in the stunning queue (defined in stun_time())
is too short to gain much in terms of throughput -- that's because back
then I tried to put a cap on worst case latency.

> you pointed them out. I had presumed it was due to physical scanning.

Everybody did, including me. Only after doing some of the benchmarks
did I realize I had been wrong. It's quite clear that physical scanning
accounts for a 50% higher execution time at most, which is a mere fifth
of the overall slow down in compile benchmarks.

> > There are variables other than the demotion criteria that I found can
> > be important, to name a few:
> > - Trigger: Under which circumstances is suspending any processes
> >   considered? How often?
> 
> This is generally part of the load control algorithm, but it
> essentially just tries to detect levels of overcommitment that would
> degrade performance so it can resolve them.

Level of overcommitment? What kind of criteria is that supposed to be?
You can have 10x overcommit and not thrash at all, if most of the memory
is allocated and filled but never referenced again. IOW, I can't derive
an algorithm from your handwaving <g>.

> > - Eviction: Does regular pageout take care of the memory of a suspended
> >   process, or are pages marked old or even unmapped upon stunning?
> 
> This is generally unmapping and evicting upon suspension. The effect
> isn't immediate anyway, since io is required, and batching the work for
> io contiguity etc. is a fair amount of savings, so there's little or no
> incentive to delay this apart from keeping io rates down to where user
> io and VM io aren't in competition.

I agree with that part.

> On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> > - Release: Is the stunning queue a simple FIFO? How long do the
> >   processes stay there? Does a process get a bonus after it's woken up
> >   again -- bigger quantum, chunk of free memory, prepaged working set
> >   before stunning?
> 
> It's a form of process scheduling. Memory scheduling policies are not
> discussed very much in the sources I can get at, so some synthesis may
> be required unless material can be found on that, but in general this
> isn't a very interesting problem (at least not since the 70's or earlier).

Not interesting, yes. And I realize that it's not even important once
you accept the very real possibility of extreme latencies.

> > There's quite a bit of complexity involved and many variables will depend
> > on the scenario. Sort of like interactivity, except lots of people were
> > affected by the interactivity tuning and only few will notice and test
> > load control.
> 
> It's basically just process scheduling, so I don't see an issue there.

The issue is that there are tons of knobs and dials that affect the
behavior, and it's hard to get good heuristics with a tiny test field.
Admittedly, things get easier once you want load control only for the
heavy thrashing case, and that's been my plan, too, since I realized that
it doesn't work well for the light and medium type I'd been working on.

Roger

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.0-test11-stun.patch"

diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 ../../18_binsearch/linux-2.6.0-test11/include/linux/loadcontrol.h ./include/linux/loadcontrol.h
--- ../../18_binsearch/linux-2.6.0-test11/include/linux/loadcontrol.h	1970-01-01 01:00:00.000000000 +0100
+++ ./include/linux/loadcontrol.h	2003-12-10 22:11:15.999792424 +0100
@@ -0,0 +1,14 @@
+#ifndef _LINUX_LOADCONTROL_H
+#define _LINUX_LOADCONTROL_H
+
+#include <asm/atomic.h>
+
+extern wait_queue_head_t loadctrl_wq;
+extern struct semaphore stun_ser;
+extern struct semaphore unstun_token;
+
+extern void loadcontrol(void);
+extern void thrashing(unsigned long);
+extern atomic_t lctrl_waiting;
+
+#endif /* _LINUX_LOADCONTROL_H */
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 ../../18_binsearch/linux-2.6.0-test11/include/linux/sched.h ./include/linux/sched.h
--- ../../18_binsearch/linux-2.6.0-test11/include/linux/sched.h	2003-11-24 10:28:54.000000000 +0100
+++ ./include/linux/sched.h	2003-12-10 22:11:16.002791985 +0100
@@ -500,6 +500,8 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
+#define PF_STUN		0x00400000
+#define PF_YIELD	0x00800000
 
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
@@ -581,6 +583,7 @@ extern int FASTCALL(wake_up_process(stru
 #endif
 extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
 extern void FASTCALL(sched_exit(task_t * p));
+extern int task_interactive(task_t * p);
 
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 ../../18_binsearch/linux-2.6.0-test11/include/linux/swap.h ./include/linux/swap.h
--- ../../18_binsearch/linux-2.6.0-test11/include/linux/swap.h	2003-10-15 15:03:46.000000000 +0200
+++ ./include/linux/swap.h	2003-12-10 22:11:16.003791839 +0100
@@ -174,6 +174,7 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone *, unsigned int, unsigned int);
+extern int shrink_list(struct list_head *, unsigned int, int *, int *);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 ../../18_binsearch/linux-2.6.0-test11/kernel/loadcontrol.c ./kernel/loadcontrol.c
--- ../../18_binsearch/linux-2.6.0-test11/kernel/loadcontrol.c	1970-01-01 01:00:00.000000000 +0100
+++ ./kernel/loadcontrol.c	2003-12-10 22:11:16.005791546 +0100
@@ -0,0 +1,169 @@
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/loadcontrol.h>
+
+void loadcontrol(void);
+void thrashing(unsigned long);
+
+DECLARE_MUTEX(stun_ser);
+DECLARE_MUTEX_LOCKED(unstun_token);
+DECLARE_WAIT_QUEUE_HEAD(loadctrl_wq);
+
+atomic_t lctrl_waiting;
+
+static inline void stun_me(void)
+{
+	DEFINE_WAIT(wait);
+
+	up(&stun_ser);		/* Allow next */
+	atomic_inc(&lctrl_waiting);
+
+	for (;;) {
+		prepare_to_wait_exclusive(&loadctrl_wq, &wait,
+				TASK_UNINTERRUPTIBLE);
+		schedule();
+		if (!down_trylock(&unstun_token)) {
+			/* Yay. Got unstun token, wake up */
+			break;
+		}
+	}
+	finish_wait(&loadctrl_wq, &wait);
+
+	atomic_dec(&lctrl_waiting);
+}
+
+void loadcontrol()
+{
+	unsigned long flags = current->flags;
+
+	spin_lock_irq(&current->sighand->siglock);
+	recalc_sigpending();	/* We sent fake signal, clean it up */
+	spin_unlock_irq(&current->sighand->siglock);
+
+	if (flags & PF_STUN)
+		stun_me();
+
+	current->flags &= ~(PF_STUN|PF_YIELD|PF_MEMALLOC);
+}
+
+/*
+ * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
+ * @x: integer of which to calculate the sqrt
+ *
+ * A very rough approximation to the sqrt() function.
+ */
+static unsigned int int_sqrt(unsigned int x)
+{
+	unsigned int out = x;
+	while (x & ~(unsigned int)1) x >>=2, out >>=1;
+	if (x) out -= out >> 2;
+	return (out ? out : 1);
+}
+
+static int badness(struct task_struct *p, int flags)
+{
+	int points, cpu_time, run_time;
+
+	if (!p->mm)
+		return 0;
+
+	if (p->flags & (PF_MEMDIE | flags))
+		return 0;
+
+	/*
+	 * Resident memory size of the process is the basis for the badness.
+	 */
+	points = p->mm->rss;
+
+	/*
+	 * CPU time is in seconds and run time is in minutes. There is no
+	 * particular reason for this other than that it turned out to work
+	 * very well in practice.
+	 */
+	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
+	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
+
+	points *= int_sqrt(cpu_time);
+	points *= int_sqrt(int_sqrt(run_time));
+
+	/*
+	 * Niced processes are most likely less important.
+	 */
+	if (task_nice(p) > 0)
+		points *= 4;
+
+	/*
+	 * Keep interactive processes around.
+	 */
+	if (task_interactive(p))
+		points /= 4;
+
+	/*
+	 * Superuser processes are usually more important, so we make it
+	 * less likely that we kill those.
+	 */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
+				p->uid == 0 || p->euid == 0)
+		points /= 2;
+
+	/*
+	 * We don't want to kill a process with direct hardware access.
+	 * Not only could that mess up the hardware, but usually users
+	 * tend to only have this flag set on applications they think
+	 * of as important.
+	 */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
+		points /= 2;
+
+	return points;
+}
+
+/*
+ * Simple selection loop. We chose the process with the highest
+ * number of 'points'. We expect the caller will lock the tasklist.
+ */
+static struct task_struct * pick_bad_process(int flags)
+{
+	int maxpoints = 0;
+	struct task_struct *g, *p;
+	struct task_struct *chosen = NULL;
+
+	do_each_thread(g, p)
+		if (p->pid) {
+			int points = badness(p, flags);
+			if (points > maxpoints) {
+				chosen = p;
+				maxpoints = points;
+			}
+		}
+	while_each_thread(g, p);
+	return chosen;
+}
+
+
+void thrashing(unsigned long action)
+{
+	struct task_struct *p;
+	unsigned long flags;
+
+	if (down_trylock(&stun_ser))
+		return;
+
+	read_lock(&tasklist_lock);
+
+	p = pick_bad_process(PF_STUN|action);
+	if (!p) {
+		up(&stun_ser);
+		goto out_unlock;
+	}
+
+	p->flags |= action|PF_MEMALLOC;
+	p->time_slice = HZ;
+
+	spin_lock_irqsave(&p->sighand->siglock, flags);
+	signal_wake_up(p, 0);
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+}
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 ../../18_binsearch/linux-2.6.0-test11/kernel/Makefile ./kernel/Makefile
--- ../../18_binsearch/linux-2.6.0-test11/kernel/Makefile	2003-10-15 15:03:46.000000000 +0200
+++ ./kernel/Makefile	2003-12-10 22:11:16.006791400 +0100
@@ -6,7 +6,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    loadcontrol.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 ../../18_binsearch/linux-2.6.0-test11/kernel/sched.c ./kernel/sched.c
--- ../../18_binsearch/linux-2.6.0-test11/kernel/sched.c	2003-11-24 10:28:54.000000000 +0100
+++ ./kernel/sched.c	2003-12-10 22:11:16.015790083 +0100
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/loadcontrol.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -1465,6 +1466,22 @@ out:
 
 void scheduling_functions_start_here(void) { }
 
+static unsigned long stun_time(void) {
+	unsigned long ret;
+	int ql = atomic_read(&lctrl_waiting);
+	if (ql == 1)
+		ret = 5*HZ;
+	else if (ql == 2)
+		ret = 3*HZ;
+	else if (ql < 5)
+		ret = 2*HZ;
+	else if (ql < 10)
+		ret = 1*HZ;
+	else
+		ret = HZ/2;
+	return ret;
+}
+
 /*
  * schedule() is the main scheduler function.
  */
@@ -1495,6 +1512,22 @@ need_resched:
 	prev = current;
 	rq = this_rq();
 
+	if (unlikely(waitqueue_active(&loadctrl_wq))) {
+		static unsigned long prev_unstun;
+		unsigned long wait = stun_time();
+		if (time_before(jiffies, prev_unstun + wait) && prev_unstun)
+			goto loadctrl_done;
+		if (!atomic_read(&stun_ser.count))
+			goto loadctrl_done;
+		if (!prev_unstun) {
+			prev_unstun = jiffies;
+			goto loadctrl_done;
+		}
+		prev_unstun = jiffies;
+		up(&unstun_token);
+		wake_up(&loadctrl_wq);
+	}
+loadctrl_done:
 	release_kernel_lock(prev);
 	now = sched_clock();
 	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
@@ -1935,6 +1968,11 @@ asmlinkage long sys_nice(int increment)
 
 #endif
 
+int task_interactive(task_t *p)
+{
+	return TASK_INTERACTIVE(p);
+}
+
 /**
  * task_prio - return the priority value of a given task.
  * @p: the task in question.
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 ../../18_binsearch/linux-2.6.0-test11/arch/i386/kernel/signal.c ./arch/i386/kernel/signal.c
--- ../../18_binsearch/linux-2.6.0-test11/arch/i386/kernel/signal.c	2003-11-24 10:28:51.000000000 +0100
+++ ./arch/i386/kernel/signal.c	2003-12-10 22:11:16.018789645 +0100
@@ -24,6 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/i387.h>
 #include "sigframe.h"
+#include <linux/loadcontrol.h>
 
 #define DEBUG_SIG 0
 
@@ -569,6 +570,10 @@ int do_signal(struct pt_regs *regs, sigs
 		refrigerator(0);
 		goto no_signal;
 	}
+	if (current->flags & (PF_STUN|PF_YIELD)) {
+		loadcontrol();
+		goto no_signal;
+	}
 
 	if (!oldset)
 		oldset = &current->blocked;
diff -uNp -X /home/rl/data/doc/kernel/dontdiff-2.6 ../../18_binsearch/linux-2.6.0-test11/mm/page_alloc.c ./mm/page_alloc.c
--- ../../18_binsearch/linux-2.6.0-test11/mm/page_alloc.c	2003-10-15 15:03:46.000000000 +0200
+++ ./mm/page_alloc.c	2003-12-10 22:11:16.021789206 +0100
@@ -31,6 +31,7 @@
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/loadcontrol.h>
 
 #include <asm/tlbflush.h>
 
@@ -606,6 +607,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	}
 
 	/* here we're in the low on memory slow path */
+	thrashing(PF_STUN);
 
 rebalance:
 	if ((p->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {

--3MwIy2ne0vdjdPXF--
