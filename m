Return-Path: <linux-kernel-owner+w=401wt.eu-S1751722AbXANXzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbXANXzG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 18:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXANXzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 18:55:06 -0500
Received: from mail.screens.ru ([213.234.233.54]:59605 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbXANXzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 18:55:04 -0500
Date: Mon, 15 Jan 2007 02:54:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070114235410.GA6165@tv-sign.ru>
References: <20070107115957.6080aa08.akpm@osdl.org> <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org> <20070109150755.GB89@tv-sign.ru> <20070109155908.GD22080@in.ibm.com> <20070109163815.GA208@tv-sign.ru> <20070109164604.GA17915@in.ibm.com> <20070109165655.GA215@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109165655.GA215@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about the pseudo-code below?

workqueue_mutex is only used to protect "struct list_head workqueues",
all workqueue operations can run in parallel with cpuhotplug callback path.
take_over_work(), migrate_sequence, CPU_LOCK_ACQUIRE/RELEASE go away.

I'd like to make a couple of cleanups (and fix schedule_on_each_cpu) before
sending the patch, but if somebody doesn't like this intrusive change, he
can nack it right now.

Oleg.

struct cpu_workqueue_srtuct {
	...
	int should_stop;
	...
};

// also used by flush_work/flush_workqueue
static cpumask_t cpu_populated_map __read_mostly;

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
	while (!cwq_should_stop(cwq)) {
		...
		run_workqueue();
		...
	}
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
			if (err || !cpu_isset(cpu, cpu_populated_map))
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
	if (action == CPU_UP_PREPARE)
		cpu_set(cpu, cpu_populated_map);

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

