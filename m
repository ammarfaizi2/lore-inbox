Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVLSRNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVLSRNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVLSRNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:13:50 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16380 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964869AbVLSRNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:13:50 -0500
Subject: Re: [PATCH rc5-rt2 3/3] plist: convert the code to new
	implementation
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
In-Reply-To: <43A5A7BD.152A4F80@tv-sign.ru>
References: <43A5A7BD.152A4F80@tv-sign.ru>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:13:16 -0800
Message-Id: <1135012399.30466.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think firstly, if you want to have success with this patch you'll need
to clean it up a bit. I'm not an authority on clean code , but below
isn't clean to my eyes. However, this is cleaner than your last
attempt .

Hard coding MAX_PRIO isn't really acceptable. If your going to make it
more similar to list_head , why not name it plist_head instead of
pl_head that way it's easy to switch between them. Part of what I wanted
out of plist was to switch between a regular list , and a plist easily.
You seem to add something to that, and take something away. Like you
remove a lot of the API which makes it less similar to a regular list .

Also, making any changes to the internals of the plist structure outside
of plist.c (or similar) isn't acceptable. For instance you set the node
priority in several places, that should be hidden inside another
function or macro. That makes it easier for people to change the
internal structure without treading though tons of code. 

Changing plist_empty() doesn't make any sense to me. Also changing
dp_node to prio_list doesn't make much sense either.

Daniel

On Sun, 2005-12-18 at 21:17 +0300, Oleg Nesterov wrote:
> This patch blindly fixes compilation errors caused by
> a previous patch.
> 
>  include/linux/rt_lock.h   |    8 ++--
>  include/linux/sched.h     |    2 -
>  include/linux/init_task.h |    2 -
>  kernel/fork.c             |    2 -
>  kernel/rt.c               |   78 ++++++++++++++++++++--------------------------
>  5 files changed, 42 insertions(+), 50 deletions(-)
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- RT/include/linux/rt_lock.h~3_FIX	2005-12-17 19:59:45.000000000 +0300
> +++ RT/include/linux/rt_lock.h	2005-12-18 22:23:40.000000000 +0300
> @@ -24,7 +24,7 @@
>   */
>  struct rt_mutex {
>  	raw_spinlock_t		wait_lock;
> -	struct plist		wait_list;
> +	struct pl_head		wait_list;
>  	struct thread_info	*owner;
>  # ifdef CONFIG_DEBUG_RT_LOCKING_MODE
>  	raw_spinlock_t		debug_slock;
> @@ -49,8 +49,8 @@ struct rt_mutex {
>   */
>  struct rt_mutex_waiter {
>  	struct rt_mutex		*lock;
> -	struct plist		list;
> -	struct plist		pi_list;
> +	struct pl_node		list;
> +	struct pl_node		pi_list;
>  	struct thread_info	*ti;
>  #ifdef CONFIG_DEBUG_DEADLOCKS
>  	unsigned long eip;
> @@ -87,7 +87,7 @@ struct rt_mutex_waiter {
>  # define __PLIST_INIT(lockname)
>  #else
>  # define __PLIST_INIT(lockname) \
> -	, .wait_list = PLIST_INIT((lockname).wait_list, 140 /*MAX_PRIO*/)
> +	, .wait_list = PL_HEAD_INIT((lockname).wait_list)
>  #endif
>  
>  #define __RT_MUTEX_INITIALIZER(lockname) \
> --- RT/include/linux/sched.h~3_FIX	2005-12-17 19:59:45.000000000 +0300
> +++ RT/include/linux/sched.h	2005-12-18 00:21:43.000000000 +0300
> @@ -1026,7 +1026,7 @@ struct task_struct {
>  #endif
>  	/* realtime bits */
>  	struct list_head delayed_put;
> -	struct plist pi_waiters;
> +	struct pl_head pi_waiters;
>  
>  	/* RT deadlock detection and priority inheritance handling */
>  	struct rt_mutex_waiter *blocked_on;
> --- RT/include/linux/init_task.h~3_FIX	2005-12-17 19:59:45.000000000 +0300
> +++ RT/include/linux/init_task.h	2005-12-18 00:27:31.000000000 +0300
> @@ -121,7 +121,7 @@ extern struct group_info init_groups;
>  	.alloc_lock	= SPIN_LOCK_UNLOCKED(tsk.alloc_lock),		\
>  	.proc_lock	= SPIN_LOCK_UNLOCKED(tsk.proc_lock),		\
>  	.delayed_put	= LIST_HEAD_INIT(tsk.delayed_put),		\
> -	.pi_waiters	= PLIST_INIT(tsk.pi_waiters, MAX_PRIO),		\
> +	.pi_waiters	= PL_HEAD_INIT(tsk.pi_waiters),			\
>  	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
>  	.journal_info	= NULL,						\
>  	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
> --- RT/kernel/fork.c~3_FIX	2005-12-17 19:59:45.000000000 +0300
> +++ RT/kernel/fork.c	2005-12-18 00:55:41.000000000 +0300
> @@ -1027,7 +1027,7 @@ static task_t *copy_process(unsigned lon
>  #endif
>  	INIT_LIST_HEAD(&p->delayed_put);
>  	preempt_disable();
> -	plist_init(&p->pi_waiters, MAX_PRIO);
> +	pl_head_init(&p->pi_waiters);
>  	preempt_enable();
>  	p->blocked_on = NULL; /* not blocked yet */
>  	spin_lock_init(&p->pi_lock);
> --- RT/kernel/rt.c~3_FIX	2005-12-17 19:59:45.000000000 +0300
> +++ RT/kernel/rt.c	2005-12-18 22:03:25.000000000 +0300
> @@ -396,8 +396,8 @@ static void printk_waiter(struct rt_mute
>  {
>  	printk("-------------------------\n");
>  	printk("| waiter struct %p:\n", w);
> -	printk("| w->list: [DP:%p/%p|SP:%p/%p|PRI:%d]\n", w->list.dp_node.prev, w->list.dp_node.next, w->list.sp_node.prev, w->list.sp_node.next, w->list.prio);
> -	printk("| w->pi_list: [DP:%p/%p|SP:%p/%p|PRI:%d]\n", w->pi_list.dp_node.prev, w->pi_list.dp_node.next, w->pi_list.sp_node.prev, w->pi_list.sp_node.next, w->pi_list.prio);
> +	printk("| w->list: [DP:%p/%p|SP:%p/%p|PRI:%d]\n", w->list.plist.prio_list.prev, w->list.plist.prio_list.next, w->list.plist.node_list.prev, w->list.plist.node_list.next, w->list.prio);
> +	printk("| w->pi_list: [DP:%p/%p|SP:%p/%p|PRI:%d]\n", w->pi_list.plist.prio_list.prev, w->pi_list.plist.prio_list.next, w->pi_list.plist.node_list.prev, w->pi_list.plist.node_list.next,
> w->pi_list.prio);
>  	printk("\n| lock:\n");
>  	printk_lock(w->lock, 1);
>  	printk("| w->ti->task:\n");
> @@ -617,7 +617,6 @@ void check_no_held_locks(struct task_str
>  {
>  	struct thread_info *ti = task->thread_info;
>  	struct list_head *curr, *next, *cursor = NULL;
> -	struct plist *curr1;
>  	struct rt_mutex *lock;
>  	struct rt_mutex_waiter *w;
>  	struct thread_info *t;
> @@ -671,8 +670,7 @@ restart:
>  		goto restart;
>  	}
>  	_raw_spin_lock(&task->pi_lock);
> -	plist_for_each(curr1, &task->pi_waiters) {
> -		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
> +	plist_for_each_entry(w, &task->pi_waiters, pi_list) {
>  		TRACE_OFF();
>  		_raw_spin_unlock(&task->pi_lock);
>  		trace_unlock_irqrestore(&trace_lock, flags, ti);
> @@ -734,13 +732,11 @@ check_pi_list_present(struct rt_mutex *l
>  		      struct thread_info *old_owner)
>  {
>  	struct rt_mutex_waiter *w;
> -	struct plist *curr1;
>  
>  	_raw_spin_lock(&old_owner->task->pi_lock);
> -	TRACE_WARN_ON_LOCKED(plist_empty(&waiter->pi_list));
> +	TRACE_WARN_ON_LOCKED(plist_unhashed(&waiter->pi_list));
>  
> -	plist_for_each(curr1, &old_owner->task->pi_waiters) {
> -		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
> +	plist_for_each_entry(w, &old_owner->task->pi_waiters, pi_list) {
>  		if (w == waiter)
>  			goto ok;
>  	}
> @@ -754,11 +750,9 @@ static void
>  check_pi_list_empty(struct rt_mutex *lock, struct thread_info *old_owner)
>  {
>  	struct rt_mutex_waiter *w;
> -	struct plist *curr1;
>  
>  	_raw_spin_lock(&old_owner->task->pi_lock);
> -	plist_for_each(curr1, &old_owner->task->pi_waiters) {
> -		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
> +	plist_for_each_entry(w, &old_owner->task->pi_waiters, pi_list) {
>  		if (w->lock == lock) {
>  			TRACE_OFF();
>  			printk("hm, PI interest but no waiter? Old owner:\n");
> @@ -793,8 +787,7 @@ static void
>  change_owner(struct rt_mutex *lock, struct thread_info *old_owner,
>  	     struct thread_info *new_owner)
>  {
> -	struct plist *next1, *curr1;
> -	struct rt_mutex_waiter *w;
> +	struct rt_mutex_waiter *w, *tmp;
>  	int requeued = 0, sum = 0;
>  
>  	if (old_owner == new_owner)
> @@ -802,12 +795,11 @@ change_owner(struct rt_mutex *lock, stru
>  
>  	SMP_TRACE_BUG_ON_LOCKED(!spin_is_locked(&old_owner->task->pi_lock));
>  	SMP_TRACE_BUG_ON_LOCKED(!spin_is_locked(&new_owner->task->pi_lock));
> -	plist_for_each_safe(curr1, next1, &old_owner->task->pi_waiters) {
> -		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
> +	plist_for_each_entry_safe(w, tmp, &old_owner->task->pi_waiters, pi_list) {
>  		if (w->lock == lock) {
>  			trace_special_pid(w->ti->task->pid, w->ti->task->prio, w->ti->task->normal_prio);
> -			plist_del(&w->pi_list, &old_owner->task->pi_waiters);
> -			plist_init(&w->pi_list, w->ti->task->prio);
> +			plist_del(&w->pi_list);
> +			w->pi_list.prio = w->ti->task->prio;
>  			plist_add(&w->pi_list, &new_owner->task->pi_waiters);
>  			requeued++;
>  		}
> @@ -917,7 +909,7 @@ static void pi_setprio(struct rt_mutex *
>  
>  		TRACE_BUG_ON_LOCKED(!lock_owner(l));
>  
> -		if (!plist_empty(&w->pi_list)) {
> +		if (!plist_unhashed(&w->pi_list)) {
>  			TRACE_BUG_ON_LOCKED(!was_rt && !ALL_TASKS_PI && !rt_task(p));
>  			/*
>  			 * If the task is blocked on a lock, and we just restored
> @@ -927,17 +919,17 @@ static void pi_setprio(struct rt_mutex *
>  			 * (TODO: this can be unfair to SCHED_NORMAL tasks if they
>  			 *        get PI handled.)
>  			 */
> -			plist_del(&w->pi_list, &lock_owner(l)->task->pi_waiters);
> +			plist_del(&w->pi_list);
>  		} else
>  			TRACE_BUG_ON_LOCKED((ALL_TASKS_PI || rt_task(p)) && was_rt);
>  
>  		if (ALL_TASKS_PI || rt_task(p)) {
> -			plist_init(&w->pi_list,prio);
> +			w->pi_list.prio = prio;
>  			plist_add(&w->pi_list, &lock_owner(l)->task->pi_waiters);
>  		}
>  
> -		plist_del(&w->list, &l->wait_list);
> -		plist_init(&w->list, prio);
> +		plist_del(&w->list);
> +		w->list.prio = prio;
>  		plist_add(&w->list, &l->wait_list);
>  
>  		pi_walk++;
> @@ -1028,7 +1020,7 @@ task_blocks_on_lock(struct rt_mutex_wait
>  	task->blocked_on = waiter;
>  	waiter->lock = lock;
>  	waiter->ti = ti;
> -	plist_init(&waiter->pi_list, task->prio);
> +	pl_node_init(&waiter->pi_list, task->prio);
>  	/*
>  	 * Add SCHED_NORMAL tasks to the end of the waitqueue (FIFO):
>  	 */
> @@ -1067,7 +1059,7 @@ static void __init_rt_mutex(struct rt_mu
>  	lock->owner = NULL;
>  	spin_lock_init(&lock->wait_lock);
>  	preempt_disable();
> -	plist_init(&lock->wait_list, MAX_PRIO);
> +	pl_head_init(&lock->wait_list);
>  	preempt_enable();
>  #ifdef CONFIG_DEBUG_DEADLOCKS
>  	lock->save_state = save_state;
> @@ -1178,9 +1170,9 @@ pick_new_owner(struct rt_mutex *lock, st
>  #endif
>  		_raw_spin_lock(&old_owner->task->pi_lock);
>  
> -	plist_del_init(&waiter->list, &lock->wait_list);
> -	plist_del(&waiter->pi_list, &old_owner->task->pi_waiters);
> -	plist_init(&waiter->pi_list, waiter->ti->task->prio);
> +	plist_del(&waiter->list);
> +	plist_del(&waiter->pi_list);
> +	waiter->pi_list.prio = waiter->ti->task->prio;
>  
>  	set_new_owner(lock, old_owner, new_owner __W_EIP__(waiter));
>  	/* Don't touch waiter after ->task has been NULLed */
> @@ -1203,8 +1195,8 @@ static inline void init_lists(struct rt_
>  {
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_DEADLOCKS)
>  	// we have to do this until the static initializers get fixed:
> -	if (unlikely(!lock->wait_list.dp_node.prev)) {
> -		plist_init(&lock->wait_list, MAX_PRIO);
> +	if (unlikely(!lock->wait_list.prio_list.prev)) {
> +		pl_head_init(&lock->wait_list);
>  #ifdef CONFIG_DEBUG_DEADLOCKS
>  		pi_initialized++;
>  #endif
> @@ -1334,8 +1326,8 @@ capture_lock(struct rt_mutex_waiter *wai
>  			ret = 0;
>  		} else {
>  			/* Add ourselves back to the list */
> -			TRACE_BUG_ON_LOCKED(!plist_empty(&waiter->list));
> -			plist_init(&waiter->list, task->prio);
> +			TRACE_BUG_ON_LOCKED(!plist_unhashed(&waiter->list));
> +			pl_node_init(&waiter->list, task->prio);
>  			task_blocks_on_lock(waiter, ti, lock __W_EIP__(waiter));
>  			ret = 1;
>  		}
> @@ -1355,16 +1347,16 @@ static inline void INIT_WAITER(struct rt
>  {
>  #ifdef CONFIG_DEBUG_DEADLOCKS
>  	memset(waiter, 0x11, sizeof(*waiter));
> -	plist_init(&waiter->list, MAX_PRIO);
> -	plist_init(&waiter->pi_list, MAX_PRIO);
> +	pl_node_init(&waiter->list, MAX_PRIO);
> +	pl_node_init(&waiter->pi_list, MAX_PRIO);
>  #endif
>  }
>  
>  static inline void FREE_WAITER(struct rt_mutex_waiter *waiter)
>  {
>  #ifdef CONFIG_DEBUG_DEADLOCKS
> -	TRACE_WARN_ON(!plist_empty(&waiter->list));
> -	TRACE_WARN_ON(!plist_empty(&waiter->pi_list));
> +	TRACE_WARN_ON(!plist_unhashed(&waiter->list));
> +	TRACE_WARN_ON(!plist_unhashed(&waiter->pi_list));
>  	TRACE_WARN_ON(current->blocked_on);
>  	memset(waiter, 0x22, sizeof(*waiter));
>  #endif
> @@ -1409,7 +1401,7 @@ ____down(struct rt_mutex *lock __EIP_DEC
>  
>  	set_task_state(task, TASK_UNINTERRUPTIBLE);
>  
> -	plist_init(&waiter.list, task->prio);
> +	pl_node_init(&waiter.list, task->prio);
>  	task_blocks_on_lock(&waiter, ti, lock __EIP__);
>  
>  	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
> @@ -1490,7 +1482,7 @@ ____down_mutex(struct rt_mutex *lock __E
>  		return;
>  	}
>  
> -	plist_init(&waiter.list, task->prio);
> +	pl_node_init(&waiter.list, task->prio);
>  	task_blocks_on_lock(&waiter, ti, lock __EIP__);
>  
>  	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
> @@ -1589,7 +1581,7 @@ ____up_mutex(struct rt_mutex *lock, int 
>  	trace_lock_irqsave(&trace_lock, flags, ti);
>  	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
>  	_raw_spin_lock(&lock->wait_lock);
> -	TRACE_BUG_ON_LOCKED(!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next);
> +	TRACE_BUG_ON_LOCKED(!lock->wait_list.prio_list.prev && !lock->wait_list.prio_list.next);
>  
>  #ifdef CONFIG_DEBUG_DEADLOCKS
>  	TRACE_WARN_ON_LOCKED(lock_owner(lock) != ti);
> @@ -1873,7 +1865,7 @@ static int __sched __down_interruptible(
>  
>  	set_task_state(task, TASK_INTERRUPTIBLE);
>  
> -	plist_init(&waiter.list, task->prio);
> +	pl_node_init(&waiter.list, task->prio);
>  	task_blocks_on_lock(&waiter, ti, lock __EIP__);
>  
>  	TRACE_BUG_ON_LOCKED(!raw_irqs_disabled());
> @@ -1908,7 +1900,7 @@ wait_again:
>  			_raw_spin_lock(&task->pi_lock);
>  			_raw_spin_lock(&lock->wait_lock);
>  			if (waiter.ti || time) {
> -				plist_del_init(&waiter.list, &lock->wait_list);
> +				plist_del(&waiter.list);
>  				/*
>  				 * Just remove ourselves from the PI list.
>  				 * (No big problem if our PI effect lingers
> @@ -1916,8 +1908,8 @@ wait_again:
>  				 */
>  				TRACE_WARN_ON_LOCKED(waiter.ti != ti);
>  				TRACE_WARN_ON_LOCKED(current->blocked_on != &waiter);
> -				plist_del(&waiter.pi_list, &task->pi_waiters);
> -				plist_init(&waiter.pi_list, task->prio);
> +				plist_del(&waiter.pi_list);
> +				waiter.pi_list.prio = task->prio;
>  				waiter.ti = NULL;
>  				current->blocked_on = NULL;
>  				if (time) {

