Return-Path: <linux-kernel-owner+w=401wt.eu-S932547AbXAQRD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbXAQRD1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 12:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbXAQRD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 12:03:26 -0500
Received: from mail.screens.ru ([213.234.233.54]:35915 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932547AbXAQRD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 12:03:26 -0500
Date: Wed, 17 Jan 2007 20:01:36 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070117170136.GA2924@tv-sign.ru>
References: <20070114235410.GA6165@tv-sign.ru> <20070115043304.GA16435@in.ibm.com> <20070115125401.GA134@tv-sign.ru> <20070115161810.GB16435@in.ibm.com> <20070115165516.GA254@tv-sign.ru> <20070116052606.GA995@in.ibm.com> <20070116132725.GA81@tv-sign.ru> <20070117061705.GB2803@in.ibm.com> <20070117154716.GA104@tv-sign.ru> <20070117161207.GE26211@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117161207.GE26211@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/17, Srivatsa Vaddagiri wrote:
>
> On Wed, Jan 17, 2007 at 06:47:16PM +0300, Oleg Nesterov wrote:
> > > What do you mean by "currently" executing work? worker thread executing
> > > some work on the cpu? That is not possible, because all threads are
> > > frozen at this point. There cant be any ongoing flush_workxxx() as well
> > > because of this, which should avoid breaking flush_workxxx() ..
> > 
> > work->func() sleeps/freezed. 
> 
> Didnt Andrew call that (work->func calling try_to_freeze) madness?
> 
> 	http://lkml.org/lkml/2007/01/07/166

This means we should move try_to_freeze() to run_workqueue() or we should
forbid auto-requeued works.

I don't have a time to do anything till weekend, but please see a "final"
version below.

	- Do you see any bugs?

	- Do you agree it is better than we have now?

If/when we use freezer/lock_cpu_hotplug() we probably can simplfy things
further.

Note: schedule_on_each_cpu() remains broken.

Oleg.

struct cpu_workqueue_srtuct {
	...
	int should_stop;
	...
};

static cpumask_t cpu_populated_map __read_mostly; //also used in flush_work...
static int embryonic_cpu __read_mostly = -1;

/*
 * NOTE: the caller must not touch *cwq if this func returns true
 */
static inline int cwq_should_stop(struct cpu_workqueue_struct *cwq)
{
	int should_stop = cwq->should_stop;

	if (unlikely(should_stop)) {
		spin_lock_irq(&cwq->lock);
		should_stop = cwq->should_stop && list_empty(&cwq->worklist);
		if (should_stop)
			cwq->thread = NULL;
		spin_unlock_irq(&cwq->lock);
	}

	return should_stop;
}

static int worker_thread(void *cwq)
{
	...
	while (!cwq_should_stop(cwq)) {
		if (cwq->wq->freezeable)
			try_to_freeze();

		prepare_to_wait(&cwq->more_work, &wait, TASK_INTERRUPTIBLE);
		if (!cwq->should_stop && list_empty(&cwq->worklist))
			schedule();
		finish_wait(&cwq->more_work, &wait);

		run_workqueue(cwq);
	}
	return 0;
}

static int create_workqueue_thread(struct cpu_workqueue_struct *cwq, int cpu)
{
	struct task_struct *p;

	spin_lock_irq(&cwq->lock);
	cwq->should_stop = 0;
	p = cwq->thread;
	spin_unlock_irq(&cwq->lock);

	if (!p) {
		struct workqueue_struct *wq = cwq->wq;
		const char *fmt = is_single_threaded(wq) ? "%s" : "%s/%d";

		p = kthread_create(worker_thread, cwq, fmt, wq->name, cpu);
		/*
		 * Nobody can add the work_struct to this cwq,
		 *	if (caller is __create_workqueue)
		 *		nobody should see this wq
		 *	else // caller is CPU_UP_PREPARE
		 *		cpu is not on cpu_online_map
		 * so we can abort safely.
		 */
		if (IS_ERR(p))
			return PTR_ERR(p);

		if (!is_single_threaded(wq))
			kthread_bind(p, cpu);
		/*
		 * Cancels affinity if the caller is CPU_UP_PREPARE.
		 * Needs a cleanup, but OK.
		 */
		wake_up_process(p);
		cwq->thread = p;
	}

	return 0;
}

struct workqueue_struct *__create_workqueue(const char *name,
					    int singlethread, int freezeable)
{
	struct workqueue_struct *wq;
	struct cpu_workqueue_struct *cwq;
	int err = 0, cpu;

	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
	if (!wq)
		return NULL;

	wq->cpu_wq = alloc_percpu(struct cpu_workqueue_struct);
	if (!wq->cpu_wq) {
		kfree(wq);
		return NULL;
	}

	wq->name = name;
	wq->freezeable = freezeable;

	if (singlethread) {
		INIT_LIST_HEAD(&wq->list);
		cwq = init_cpu_workqueue(wq, singlethread_cpu);
		err = create_workqueue_thread(cwq, singlethread_cpu);
	} else {
		mutex_lock(&workqueue_mutex);
		list_add(&wq->list, &workqueues);

		for_each_possible_cpu(cpu) {
			cwq = init_cpu_workqueue(wq, cpu);
			if (err || !(cpu_online(cpu) || cpu == embryonic_cpu))
				continue;
			err = create_workqueue_thread(cwq, cpu);
		}
		mutex_unlock(&workqueue_mutex);
	}

	if (err) {
		destroy_workqueue(wq);
		wq = NULL;
	}
	return wq;
}

static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
{
	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
	struct wq_barrier barr;
	int alive = 0;

	spin_lock_irq(&cwq->lock);
	if (cwq->thread != NULL) {
		insert_wq_barrier(cwq, &barr, 1);
		cwq->should_stop = 1;
		alive = 1;
	}
	spin_unlock_irq(&cwq->lock);

	if (alive) {
		wait_for_completion(&barr.done);

		while (unlikely(cwq->thread != NULL))
			cpu_relax();
		/*
		 * Wait until cwq->thread unlocks cwq->lock,
		 * it won't touch *cwq after that.
		 */
		smp_rmb();
		spin_unlock_wait(&cwq->lock);
	}
}

void destroy_workqueue(struct workqueue_struct *wq)
{
	if (is_single_threaded(wq))
		cleanup_workqueue_thread(wq, singlethread_cpu);
	else {
		int cpu;

		mutex_lock(&workqueue_mutex);
		list_del(&wq->list);
		mutex_unlock(&workqueue_mutex);

		for_each_cpu_mask(cpu, cpu_populated_map)
			cleanup_workqueue_thread(wq, cpu);
	}

	free_percpu(wq->cpu_wq);
	kfree(wq);
}

static int __devinit workqueue_cpu_callback(struct notifier_block *nfb,
						unsigned long action,
						void *hcpu)
{
	struct workqueue_struct *wq;
	struct cpu_workqueue_struct *cwq;
	unsigned int cpu = (unsigned long)hcpu;
	int ret = NOTIFY_OK;

	mutex_lock(&workqueue_mutex);
	embryonic_cpu = -1;
	if (action == CPU_UP_PREPARE) {
		cpu_set(cpu, cpu_populated_map);
		embryonic_cpu = cpu;
	}

	list_for_each_entry(wq, &workqueues, list) {
		cwq = per_cpu_ptr(wq->cpu_wq, cpu);

		switch (action) {
		case CPU_UP_PREPARE:
			if (create_workqueue_thread(cwq, cpu))
				ret = NOTIFY_BAD;
			break;

		case CPU_ONLINE:
			set_cpus_allowed(cwq->thread, cpumask_of_cpu(cpu));
			break;

		case CPU_UP_CANCELED:
		case CPU_DEAD:
			cwq->should_stop = 1;
			wake_up(&cwq->more_work);
			break;
		}

		if (ret != NOTIFY_OK) {
			printk(KERN_ERR "workqueue for %i failed\n", cpu);
			break;
		}
	}
	mutex_unlock(&workqueue_mutex);

	return ret;
}

void init_workqueues(void)
{
	...
	cpu_populated_map = cpu_online_map;
	...
}

