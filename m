Return-Path: <linux-kernel-owner+w=401wt.eu-S1750770AbWLVQVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWLVQVa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 11:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWLVQVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 11:21:30 -0500
Received: from mail.sgg.ru ([217.23.135.1]:36423 "EHLO mail.sgg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbWLVQV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 11:21:29 -0500
Date: Fri, 22 Dec 2006 19:20:44 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: ego@in.ibm.com, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, David Wilder <dwilder@us.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>, kiran@scalex86.org,
       venkatesh.pallipadi@intel.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       torvalds@osdl.org, davej@redhat.com
Subject: Re: [PATCH] Relay CPU Hotplug support
Message-ID: <20061222162044.GA279@tv-sign.ru>
References: <20061221003101.GA28643@Krystal> <20061220232350.eb4b6a46.akpm@osdl.org> <20061222103724.GA29348@in.ibm.com> <20061222024458.322adffd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222024458.322adffd.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22, Andrew Morton wrote:
>
> On Fri, 22 Dec 2006 16:07:24 +0530
> Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> > While we are at this per-subsystem cpuhotplug "locking", here's a
> > proposal that might put an end to the workqueue deadlock woes.
> 
> Oleg is working on some patches which will permit us to cancel or wait upon
> a particular work_struct, rather than upon all pending work_structs.  

I hope there are completed. I am waiting for the next -mm release to
send a "final" patch, I need too look at set_wq_data/set_wq_data when
workqueue.c will be in sync with Linus's changes.

> This will fix the problem where we accidentlly wait upon some unrelated
> work_struct which takes a lock which is related to one which we already
> hold.
> 
> I hope.  It'll be a bit tricky to implement: if some foreign work_struct is
> running right now, we cannot wait upon it - we must non-blockingly dequeue
> the work_struct which we want to kill before it gets to run.

The previous patch I sent

	[PATCH, RFC rc1-mm1] implement flush_work()
	http://marc.theaimsgroup.com/?l=linux-kernel&m=116647310413104

has a race.

	 +static void wait_on_work(struct cpu_workqueue_struct *cwq,
	 +                               struct work_struct *work)
	 +{
	 +       struct wq_barrier barr;
	 +       int running = 0;
	 +
	 +       spin_lock_irq(&cwq->lock);
	 +       if (get_wq_data(work) == cwq) {
	 +               list_del_init(&work->entry);
	 +               work_release(work);
	 +       }

If that work is pending on CPU 1 it, and this CPU goes down, it may be
moved to CPU 0 after flush_work() already checked CPU 0.

I think we can do this:

	static void wait_on_work(struct cpu_workqueue_struct *cwq,
					struct work_struct *work)
	{
		struct wq_barrier barr;
		int running = 0;

		spin_lock_irq(&cwq->lock);
		if (unlikely(cwq->current_work == work)) {
			init_wq_barrier(&barr);
			insert_work(cwq, &barr.work, 0);
			running = 1;
		}
		spin_unlock_irq(&cwq->lock);

		if (unlikely(running)) {
			mutex_unlock(&workqueue_mutex);
			wait_for_completion(&barr.done);
			mutex_lock(&workqueue_mutex);
		}
	}

	void flush_work(struct workqueue_struct *wq, struct work_struct *work)
	{
		struct cpu_workqueue_struct *cwq;

		cwq = get_wq_data(work);
		if (!cwq)
			return;

		spin_lock_irq(&cwq->lock);
		list_del_init(&work->entry);
		work_release(work);
		spin_unlock_irq(&cwq->lock);

		mutex_lock(&workqueue_mutex);
		if (is_single_threaded(wq)) {
			/* Always use first cpu's area. */
			wait_on_work(per_cpu_ptr(wq->cpu_wq, singlethread_cpu), work);
		} else {
			int cpu;

			for_each_online_cpu(cpu)
				wait_on_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
		}
		mutex_unlock(&workqueue_mutex);
	}

Do you see any problems? When wait_on_work() unlocks workqueue_mutex (or
whatever we choose to protect against CPU hotplug), CPU may go away. But
in that case take_over_work() will move a barrier we queued to another
CPU, it will be fired sometime, and wait_on_work() will be woken.

Actually, we are doing cleanup_workqueue_thread()->kthread_stop() before
take_over_work(), so cwq->thread should complete its ->worklist (and thus
the barrier), because currently we don't check kthread_should_stop() in
run_workqueue(). But even if we did, everything looks safe to me.

Oleg.

