Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbTBQOU4>; Mon, 17 Feb 2003 09:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbTBQOUF>; Mon, 17 Feb 2003 09:20:05 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:21709
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267395AbTBQOTh>; Mon, 17 Feb 2003 09:19:37 -0500
Date: Mon, 17 Feb 2003 09:27:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Don't wake up tasks on offline processors
In-Reply-To: <Pine.LNX.4.44.0302171518220.24394-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0302170924250.18087-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302171518220.24394-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Ingo Molnar wrote:

> 
> On Mon, 17 Feb 2003, Zwane Mwaikambo wrote:
> 
> > This patch stops waking up of tasks onto offline processors. We need
> > this when migrating tasks from offline processors onto other online ones
> > and to avert a livelock whilst doing so.
> 
> this code too should be done in a separate 'zap_runqueue()' function,
> which also needs to iterate through all tasks and migrate them off to an
> online CPU. This code definitely does not belong into the wakeup hotpath.

This is the current code to migrate tasks off a dead cpu;

diff -u -r1.1.1.1 sched.c
--- linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/sched.c	17 Feb 2003 06:47:05 -0000
@@ -2235,6 +2253,102 @@
 	wait_for_completion(&req.done);
 }
 
+/* Move (not current) task off this cpu, onto dest cpu.  Reference to
+   task must be held. */
+static void move_task_away(struct task_struct *p, unsigned int dest_cpu)
+{
+	runqueue_t *rq_dest;
+	unsigned long flags;
+
+	rq_dest = cpu_rq(dest_cpu);
+
+	if (task_cpu(p) != smp_processor_id())
+		return; /* Already moved */
+
+	local_irq_save(flags);
+	double_rq_lock(this_rq(), rq_dest);
+	if (task_cpu(p) != smp_processor_id())
+		goto out; /* Already moved */
+
+	set_task_cpu(p, dest_cpu);
+	if (p->array) {
+		deactivate_task(p, this_rq());
+		activate_task(p, rq_dest);
+		if (p->prio < rq_dest->curr->prio)
+			resched_task(rq_dest->curr);
+	}
+ out:
+	double_rq_unlock(this_rq(), rq_dest);
+	local_irq_restore(flags);
+}
+
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_SMP)
+/* Slow but sure.  We don't fight against load_balance, new people
+   setting affinity, or try_to_wake_up's fast path pulling things in,
+   as cpu_online() no longer true. */
+static int move_all_tasks(unsigned int kill_it)
+{
+	unsigned int num_signalled = 0;
+	unsigned int dest_cpu;
+	struct task_struct *g, *t;
+	unsigned long cpus_allowed;
+
+ again:
+	read_lock(&tasklist_lock);
+	do_each_thread(g, t) {
+		if (t == current)
+			continue;
+
+		/* Kernel threads which are bound to specific
+		   processors need to look after themselves
+		   with their own callbacks */
+		if (t->mm == NULL && t->cpus_allowed != ~0UL)
+			continue;
+
+		if (task_cpu(t) == smp_processor_id()) {
+			get_task_struct(t);
+			goto move_one;
+		}
+	} while_each_thread(g, t);
+	read_unlock(&tasklist_lock);
+	return num_signalled;
+
+ move_one:
+	read_unlock(&tasklist_lock);
+	cpus_allowed = t->cpus_allowed & ~(1UL << smp_processor_id());
+	dest_cpu = any_online_cpu(cpus_allowed);
+	if (dest_cpu < 0) {
+		num_signalled++;
+		if (!kill_it) {
+			/* FIXME: New signal needed? --RR */
+			force_sig(SIGPWR, t);
+			goto again;
+		}
+		/* Kill it (it can die on any CPU). */
+		t->cpus_allowed = ~(1 << smp_processor_id());
+		dest_cpu = any_online_cpu(t->cpus_allowed);
+		force_sig(SIGKILL, t);
+	}
+	move_task_away(t, dest_cpu);
+	put_task_struct(t);
+	goto again;
+}
+
+/* Move non-kernel-thread tasks off this (offline) CPU, except us. */
+void migrate_all_tasks(void)
+{
+	if (move_all_tasks(0)) {
+		/* Wait for processes to react to signal */
+		schedule_timeout(30*HZ);
+		move_all_tasks(1);
+	}
+}
+#endif /* CONFIG_HOTPLUG */
+
+/* This is the CPU to stop, and who to wake about it */
+static int migration_stop = -1;
+static struct completion migration_stopped;
+
 /*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.

-- 
function.linuxpower.ca
