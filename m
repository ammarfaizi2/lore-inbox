Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRC3A1w>; Thu, 29 Mar 2001 19:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRC3A1m>; Thu, 29 Mar 2001 19:27:42 -0500
Received: from nrg.org ([216.101.165.106]:19780 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129495AbRC3A1a>;
	Thu, 29 Mar 2001 19:27:30 -0500
Date: Thu, 29 Mar 2001 16:26:44 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <Pine.LNX.4.05.10103201525480.26853-100000@cosmic.nrg.org>
Message-ID: <Pine.LNX.4.05.10103291555390.8122-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Nigel Gamble wrote:
> On Tue, 20 Mar 2001, Rusty Russell wrote:
> > Thoughts?
> 
> Perhaps synchronize_kernel() could take the run_queue lock, mark all the
> tasks on it and count them.  Any task marked when it calls schedule()
> voluntarily (but not if it is preempted) is unmarked and the count
> decremented.  synchronize_kernel() continues until the count is zero.

Hi Rusty,

Here is an attempt at a possible version of synchronize_kernel() that
should work on a preemptible kernel.  I haven't tested it yet.


static int sync_count = 0;
static struct task_struct *syncing_task = NULL;
static DECLARE_MUTEX(synchronize_kernel_mtx);

void
synchronize_kernel()
{
	struct list_head *tmp;
	struct task_struct *p;

	/* Guard against multiple calls to this function */
	down(&synchronize_kernel_mtx);

	/* Mark all tasks on the runqueue */
	spin_lock_irq(&runqueue_lock);
	list_for_each(tmp, &runqueue_head) {
		p = list_entry(tmp, struct task_struct, run_list);
		if (p == current)
			continue;
		if (p->state == TASK_RUNNING ||
				(p->state == (TASK_RUNNING|TASK_PREEMPTED))) {
			p->flags |= PF_SYNCING;
			sync_count++;
		}
	}
	if (sync_count == 0)
		goto out;

	syncing_task = current;
	spin_unlock_irq(&runqueue_lock);

	/*
	 * Cause a schedule on every CPU, as for a non-preemptible
	 * kernel
	 */

	/* Save current state */
	cpus_allowed = current->cpus_allowed;
	policy = current->policy;
	rt_priority = current->rt_priority;

	/* Create an unreal time task. */
	current->policy = SCHED_FIFO;
	current->rt_priority = 1001 + sys_sched_get_priority_max(SCHED_FIFO);

	/* Make us schedulable on all CPUs. */
	current->cpus_allowed = (1UL<<smp_num_cpus)-1;

	/* Eliminate current cpu, reschedule */
	while ((current->cpus_allowed &= ~(1 << smp_processor_id())) != 0)
		schedule();

	/* Back to normal. */
	current->cpus_allowed = cpus_allowed;
	current->policy = policy;
	current->rt_priority = rt_priority;

	/*
	 * Wait, if necessary, until all preempted tasks
	 * have reached a sync point.
	 */

	spin_lock_irq(&runqueue_lock);
	for (;;) {
		set_current_state(TASK_UNINTERRUPTIBLE);
		if (sync_count == 0)
			break;
		spin_unlock_irq(&runqueue_lock);
		schedule();
		spin_lock_irq(&runqueue_lock);
	}
	current->state = TASK_RUNNING;
	syncing_task =  NULL;
out:
	spin_unlock_irq(&runqueue_lock);

	up(&synchronize_kernel_mtx);
}

And add this code to the beginning of schedule(), just after the
runqueue_lock is taken (the flags field is probably not be the right
place to put the synchronize mark; and the test should be optimized for
the fast path in the same way as the other tests in schedule(), but you
get the idea):

	if ((prev->flags & PF_SYNCING) && !(prev->state & TASK_PREEMPTED)) {
		prev->flags &= ~PF_SYNCING;
		if (--sync_count == 0) {
			syncing_task->state = TASK_RUNNING;
			if (!task_on_runqueue(syncing_task))
				add_to_runqueue(syncing_task);
			syncing_task = NULL;
		}

	}

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

