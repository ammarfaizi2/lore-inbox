Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWGZHjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWGZHjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWGZHjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:39:51 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:16816 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP id S932497AbWGZHju
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:39:50 -0400
Date: Wed, 26 Jul 2006 13:06:22 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] 2.6.17-rt1 : fix x86_64 oops
Message-ID: <20060726073622.GB6942@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060628200247.GA7932@in.ibm.com> <20060629142442.GA11546@elte.hu> <20060629163236.GD1294@us.ibm.com> <20060629194145.GA2327@us.ibm.com> <20060629201144.GA24287@elte.hu> <20060703165750.GB3899@in.ibm.com> <20060704041519.GC16074@in.ibm.com> <20060704064307.GB2752@elte.hu> <20060704065024.GA5789@elte.hu> <20060705091157.GA7619@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705091157.GA7619@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 02:41:57PM +0530, Dipankar Sarma wrote:
> On Tue, Jul 04, 2006 at 08:50:24AM +0200, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > > Ingo, do you have a suspect ?
> > > 
> > > I suspect it's the patch below. That patch (from John) relaxes the 
> > > affinities of IRQ threads: if there are /proc/irq/*/smp_affinity 
> > > entries that have multiple bits set an IRQ thread is allowed to jump 
> > > from one CPU to another while it is executing a IRQ-handler. It 
> > > _should_ be fine but i'd not be surprised if that caused breakage ...
> > 
> > the patch below is against 2.6.17-rt5, does this solve the crashes?
> > 
> 
> I tried this patch but I still oops quickly after starting rcutorture.
> 
> There is some additional information - my -rt20 directory had
> another patch which re-organized RCU code to cleanly have multiple
> RCU implementations (rcuclassic and rcupreempt for now). That
> kernel ran fine with rcutorture, but when I removed that
> reorg-rcu-code patch to go to standard -rt20, I started seeing
> the same oops. This is bizarre because the reorg-rcu-code
> patch isn't supposed to change any logic. I am still investigating
> this, but the patch is included below for your reference.

Hello Ingo,

Finally, I got around to debug this a little bit and I have
figured out why I get this oops. In the oops I see that
I am advancing a list of rcu callbacks to the done list
but the last element of the done list has already been
freed. This made me suspect rcutorture module and I remembered
that rcu_barrier() is a NOP in rcupreempt. In my rcu
code reorganization patchset, I fixed that (rcu_barrier()
is a common primitive on top of both classic and preemptible
rcu). That is why I wasn't seeing the crash with my
patchset applied.

Anyway, the following patch fixes this problem in my
x86_64 box (64-bit kernel) and I can run rcutorture.
However, I would request not applying this for the moment
since this would get fixed in the RCU cleanup that
is to follow. I am working on your suggestion at Ottawa of 
merging as much possible in the mainline itself.
The patch below is only for those who want to temporarily work around
this for running rcutorture.

Thanks
Dipankar


Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>

diff -puN kernel/rcupreempt.c~fix-rcu-barrier-in-preempt kernel/rcupreempt.c
--- linux-2.6.17-rt7-rcu/kernel/rcupreempt.c~fix-rcu-barrier-in-preempt	2006-07-26 12:12:46.000000000 +0530
+++ linux-2.6.17-rt7-rcu-dipankar/kernel/rcupreempt.c	2006-07-26 12:17:19.000000000 +0530
@@ -93,6 +93,11 @@ static struct rcu_ctrlblk rcu_ctrlblk = 
 static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
 	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
 
+static DEFINE_PER_CPU(struct rcu_head, rcu_barrier_head);
+static atomic_t rcu_barrier_cpu_count;
+static DEFINE_MUTEX(rcu_barrier_mutex);
+static struct completion rcu_barrier_completion;
+
 /*
  * Return the number of RCU batches processed thus far.  Useful
  * for debug and statistics.
@@ -388,6 +393,39 @@ rcu_pending(int cpu)
 		rcu_data.nextlist != NULL);
 }
 
+static void rcu_barrier_callback(struct rcu_head *notused)
+{
+        if (atomic_dec_and_test(&rcu_barrier_cpu_count))
+                complete(&rcu_barrier_completion);
+}
+
+/*
+ * Called with preemption disabled, and from cross-cpu IRQ context.
+ */
+static void rcu_barrier_func(void *notused)
+{
+        int cpu = smp_processor_id();
+        struct rcu_head *head = &per_cpu(rcu_barrier_head, cpu);
+
+        atomic_inc(&rcu_barrier_cpu_count);
+        call_rcu(head, rcu_barrier_callback);
+}
+
+/**
+ * rcu_barrier - Wait until all the in-flight RCUs are complete.
+ */
+void rcu_barrier(void)
+{
+        BUG_ON(in_interrupt());
+        /* Take cpucontrol mutex to protect against CPU hotplug */
+        mutex_lock(&rcu_barrier_mutex);
+        init_completion(&rcu_barrier_completion);
+        atomic_set(&rcu_barrier_cpu_count, 0);
+        on_each_cpu(rcu_barrier_func, NULL, 0, 1);
+        wait_for_completion(&rcu_barrier_completion);
+        mutex_unlock(&rcu_barrier_mutex);
+}
+
 void __init rcu_init(void)
 {
 /*&&&&*/printk("WARNING: experimental RCU implementation.\n");
@@ -477,6 +515,7 @@ int rcu_read_proc_ctrs_data(char *page)
 
 #endif /* #ifdef CONFIG_RCU_STATS */
 
+EXPORT_SYMBOL_GPL(rcu_barrier);
 EXPORT_SYMBOL_GPL(call_rcu);
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL_GPL(synchronize_rcu);
diff -puN include/linux/rcupdate.h~fix-rcu-barrier-in-preempt include/linux/rcupdate.h
--- linux-2.6.17-rt7-rcu/include/linux/rcupdate.h~fix-rcu-barrier-in-preempt	2006-07-26 12:18:00.000000000 +0530
+++ linux-2.6.17-rt7-rcu-dipankar/include/linux/rcupdate.h	2006-07-26 12:18:38.000000000 +0530
@@ -275,12 +275,11 @@ extern int rcu_pending(int cpu);
  */
 #ifndef CONFIG_PREEMPT_RCU
 #define synchronize_sched() synchronize_rcu()
-extern void rcu_barrier(void);
 #else /* #ifndef CONFIG_PREEMPT_RCU */
 extern void synchronize_sched(void);
-#define rcu_barrier() do {} while(0)
 #endif /* #else #ifndef CONFIG_PREEMPT_RCU */
 
+extern void rcu_barrier(void);
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);

_



