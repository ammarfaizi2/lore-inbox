Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVEaI2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVEaI2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVEaI2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:28:17 -0400
Received: from fmr19.intel.com ([134.134.136.18]:55509 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261192AbVEaI2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:28:06 -0400
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
From: Shaohua Li <shaohua.li@intel.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       nickpiggin@yahoo.com.au
In-Reply-To: <20050531010030.A5239@unix-os.sc.intel.com>
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com>
	 <20050531010030.A5239@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Tue, 31 May 2005 16:35:09 +0800
Message-Id: <1117528509.3957.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 01:00 -0700, Ashok Raj wrote:
> On Tue, May 31, 2005 at 12:35:09AM -0700, Shaohua Li wrote:
> > 
> >    Hi,
> >    There is a race condition at wake_up_new_task at CPU hotplug case.
> >    Say do_fork
> >             copy_process  (which  sets  new  forked  task's  current cpu,
> >    cpu_allowed)
> >                    <-------- the new forked task's current cpu is offline
> >            wake_up_new_task
> >    wake_up_new_task will put the forked task into a dead cpu.
> > 
> 
> The while() loop doesnt look pretty here.. could you try to 
> disable preempt, and see the problem goes away? or use 
> get_cpu()/put_cpu() combo when you get this_cpu?
> 
> Just wondering if the code would be a little more simpler in this
> case.
I must be over considering. Ok, how does this updated one look?


Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.11-rc5-mm1-root/kernel/sched.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~wake_up_new_task_to_online_cpu kernel/sched.c
--- linux-2.6.11-rc5-mm1/kernel/sched.c~wake_up_new_task_to_online_cpu	2005-05-31 13:39:43.888682784 +0800
+++ linux-2.6.11-rc5-mm1-root/kernel/sched.c	2005-05-31 16:14:37.390855704 +0800
@@ -1412,6 +1412,10 @@ void fastcall sched_fork(task_t *p, int 
 	put_cpu();
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int task_select_online_cpu(int dead_cpu, struct task_struct *tsk);
+#endif
+
 /*
  * wake_up_new_task - wake up a newly created task for the first time.
  *
@@ -1425,10 +1429,18 @@ void fastcall wake_up_new_task(task_t * 
 	int this_cpu, cpu;
 	runqueue_t *rq, *this_rq;
 
+	this_cpu = get_cpu();
 	rq = task_rq_lock(p, &flags);
 	BUG_ON(p->state != TASK_RUNNING);
-	this_cpu = smp_processor_id();
 	cpu = task_cpu(p);
+#ifdef CONFIG_HOTPLUG_CPU
+	if (!cpu_online(cpu)) {
+		cpu = task_select_online_cpu(cpu, p);
+		set_task_cpu(p, cpu);
+		task_rq_unlock(rq, &flags);
+		rq = task_rq_lock(p, &flags);
+	}
+#endif
 
 	/*
 	 * We decrease the sleep average of forking parents
@@ -1491,6 +1503,7 @@ void fastcall wake_up_new_task(task_t * 
 	current->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(current) *
 		PARENT_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 	task_rq_unlock(this_rq, &flags);
+	put_cpu();
 }
 
 /*
@@ -4457,7 +4470,7 @@ wait_to_die:
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* Figure out where task on dead CPU should go, use force if neccessary. */
-static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
+static int task_select_online_cpu(int dead_cpu, struct task_struct *tsk)
 {
 	int dest_cpu;
 	cpumask_t mask;
@@ -4486,6 +4499,12 @@ static void move_task_off_dead_cpu(int d
 			       "longer affine to cpu%d\n",
 			       tsk->pid, tsk->comm, dead_cpu);
 	}
+	return dest_cpu;
+}
+
+static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
+{
+	int dest_cpu = task_select_online_cpu(dead_cpu, tsk);
 	__migrate_task(tsk, dead_cpu, dest_cpu);
 }
 
_


