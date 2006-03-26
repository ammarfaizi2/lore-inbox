Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWCZGLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWCZGLV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 01:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWCZGLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 01:11:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750803AbWCZGLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 01:11:19 -0500
Date: Sat, 25 Mar 2006 22:07:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org
Subject: Re: [patch 05/10] PI-futex: rt-mutex core
Message-Id: <20060325220728.3d5c8d36.akpm@osdl.org>
In-Reply-To: <20060325184612.GF16724@elte.hu>
References: <20060325184612.GF16724@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> From: Ingo Molnar <mingo@elte.hu>
> 
> +/*
> + * The rt_mutex structure
> + *
> + * @wait_lock:	spinlock to protect the structure
> + * @wait_list:	pilist head to enqueue waiters in priority order
> + * @owner:	the mutex owner
> + */
> +struct rt_mutex {
> +	spinlock_t		wait_lock;
> +	struct plist_head	wait_list;
> +	struct task_struct	*owner;
> +# ifdef CONFIG_DEBUG_RT_MUTEXES
> +	int			save_state;
> +	struct list_head	held_list;
> +	unsigned long		acquire_ip;
> +	const char 		*name, *file;
> +	int			line;
> +	void			*magic;
> +# endif
> +};

The indented #-statments make some sense when we're using nested #ifs
(although I tend to accidentally-on-purpose delete them).  But the above
ones aren't even nested..

> +extern void fastcall __rt_mutex_init(struct rt_mutex *lock, const char *name);
> +extern void fastcall rt_mutex_destroy(struct rt_mutex *lock);
> +
> +extern void fastcall rt_mutex_lock(struct rt_mutex *lock);
> +extern int fastcall rt_mutex_lock_interruptible(struct rt_mutex *lock,
> +						int detect_deadlock);
> +extern int fastcall rt_mutex_timed_lock(struct rt_mutex *lock,
> +					struct hrtimer_sleeper *timeout,
> +					int detect_deadlock);
> +
> +extern int fastcall rt_mutex_trylock(struct rt_mutex *lock);
> +
> +extern void fastcall rt_mutex_unlock(struct rt_mutex *lock);

Does fastcall actually do any good?  Isn't CONFIG_REGPARM equivalent to
that anyway?   It's a bit of an eyesore.

> +#ifdef CONFIG_RT_MUTEXES
> +# define rt_mutex_init_task(p)						\
> + do {									\
> +	spin_lock_init(&p->pi_lock);					\
> +	plist_head_init(&p->pi_waiters);				\
> +	p->pi_blocked_on = NULL;					\
> +	p->pi_locked_by = NULL;						\
> +	INIT_LIST_HEAD(&p->pi_lock_chain);				\
> + } while (0)

Somewhere in there is a C function struggling to escape.

> Index: linux-pi-futex.mm.q/include/linux/rtmutex_internal.h

Perhaps this could go in kernel/.  If you think that's valuable.

> +/*
> + * Plist wrapper macros
> + */
> +#define rt_mutex_has_waiters(lock)	(!plist_head_empty(&lock->wait_list))
> +
> +#define rt_mutex_top_waiter(lock) 	\
> +({ struct rt_mutex_waiter *__w = plist_first_entry(&lock->wait_list, \
> +					struct rt_mutex_waiter, list_entry); \
> +	BUG_ON(__w->lock != lock);	\
> +	__w;				\
> +})
> +
> +#define task_has_pi_waiters(task)	(!plist_head_empty(&task->pi_waiters))
> +
> +#define task_top_pi_waiter(task) 	\
> +	plist_first_entry(&task->pi_waiters, struct rt_mutex_waiter, pi_list_entry)

All of these can become C functions, yes?

> +#define rt_mutex_owner(lock)						\
> +({									\
> +	typecheck(struct rt_mutex *,(lock));				\
> + 	((struct task_struct *)((unsigned long)((lock)->owner) & ~RT_MUTEX_OWNER_MASKALL)); \
> +})
> +
> +#define rt_mutex_real_owner(lock)					\
> +({									\
> +	typecheck(struct rt_mutex *,(lock));				\
> + 	((struct task_struct *)((unsigned long)((lock)->owner) & ~RT_MUTEX_HAS_WAITERS)); \
> +})
> +
> +#define rt_mutex_owner_pending(lock)					\
> +({									\
> +	typecheck(struct rt_mutex *,(lock));				\
> +	((unsigned long)((lock)->owner) & RT_MUTEX_OWNER_PENDING);	\
> +})

Bizarre.  The `typecheck' thingies were added, I assume, because these
macros really wanted to be C functions?

> +static inline void rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
> +				      unsigned long msk)
> +{
> +	unsigned long val = ((unsigned long) owner) | msk;
> +
> +	if (rt_mutex_has_waiters(lock))
> +		val |= RT_MUTEX_HAS_WAITERS;
> +
> +	lock->owner = (struct task_struct *)(val);
> +}

Might be getting a bit large for inlining.

> +/*
> + * Lock the full boosting chain.
> + *
> + * If 'try' is set, we have to backout if we hit a owner who is
> + * running its own pi chain operation. We go back and take the slow
> + * path via the pi_conflicts_lock.
> + */
> +static int lock_pi_chain(struct rt_mutex *act_lock,
> +			 struct rt_mutex_waiter *waiter,
> +			 struct list_head *lock_chain,
> +			 int try, int detect_deadlock)
> +{
> +	struct task_struct *owner;
> +	struct rt_mutex *nextlock, *lock = act_lock;
> +	struct rt_mutex_waiter *nextwaiter;
> +
> +	/*
> +	 * Debugging might turn deadlock detection on, unconditionally:
> +	 */
> +	detect_deadlock = debug_rt_mutex_detect_deadlock(detect_deadlock);
> +
> +	for (;;) {
> +		owner = rt_mutex_owner(lock);
> +
> +		/* Check for circular dependencies */
> +		if (unlikely(owner->pi_locked_by == current)) {
> +			debug_rt_mutex_deadlock(detect_deadlock, waiter, lock);
> +			return detect_deadlock ? -EDEADLK : 0;
> +		}
> +
> +		while (!spin_trylock(&owner->pi_lock)) {
> +			/*
> +			 * Owner runs its own chain. Go back and take
> +			 * the slow path
> +			 */
> +			if (try && owner->pi_locked_by == owner)
> +				return -EBUSY;
> +			cpu_relax();
> +		}
> +
> +		BUG_ON(owner->pi_locked_by);
> +		owner->pi_locked_by = current;
> +		BUG_ON(!list_empty(&owner->pi_lock_chain));
> +		list_add(&owner->pi_lock_chain, lock_chain);
> +
> +		/*
> +		 * When the owner is blocked on a lock, try to take
> +		 * the lock:
> +		 */
> +		nextwaiter = owner->pi_blocked_on;
> +
> +		/* End of chain? */
> +		if (!nextwaiter)
> +			return 0;

We return zero with the spinlock held?  I guess that's the point of the
whole function.


> +		nextlock = nextwaiter->lock;
> +
> +		/* Check for circular dependencies: */
> +		if (unlikely(nextlock == act_lock ||
> +			     rt_mutex_owner(nextlock) == current)) {
> +			debug_rt_mutex_deadlock(detect_deadlock, waiter,
> +						nextlock);
> +			list_del_init(&owner->pi_lock_chain);
> +			owner->pi_locked_by = NULL;
> +			spin_unlock(&owner->pi_lock);
> +			return detect_deadlock ? -EDEADLK : 0;
> +		}

But here we can return zero without having locked anything.  How does the
caller know what locks are held?

This function needs a better covering description, IMO.

> +		/* Try to get nextlock->wait_lock: */
> +		if (unlikely(!spin_trylock(&nextlock->wait_lock))) {
> +			list_del_init(&owner->pi_lock_chain);
> +			owner->pi_locked_by = NULL;
> +			spin_unlock(&owner->pi_lock);
> +			cpu_relax();
> +			continue;
> +		}

All these trylocks and cpu_relaxes are a worry.

> +/*
> + * Do the priority (un)boosting along the chain:
> + */
> +static void adjust_pi_chain(struct rt_mutex *lock,
> +			    struct rt_mutex_waiter *waiter,
> +			    struct rt_mutex_waiter *top_waiter,
> +			    struct list_head *lock_chain)
> +{
> +	struct task_struct *owner = rt_mutex_owner(lock);
> +	struct list_head *curr = lock_chain->prev;
> +
> +	for (;;) {
> +		if (top_waiter)
> +			plist_del(&top_waiter->pi_list_entry,
> +				  &owner->pi_waiters);
> +
> +		if (waiter && waiter == rt_mutex_top_waiter(lock)) {

rt_mutex_top_waiter() can never return NULL, so the test for NULL could be
removed.

> +/*
> + * Slow path lock function:
> + */
> +static int fastcall noinline __sched
> +rt_mutex_slowlock(struct rt_mutex *lock, int state,
> +		  struct hrtimer_sleeper *timeout,
> +		  int detect_deadlock __IP_DECL__)
> +{

heh, fastcall slowpath.  Why's it noinline?

> +	struct rt_mutex_waiter waiter;
> +	int ret = 0;
> +	unsigned long flags;
> +
> +	debug_rt_mutex_init_waiter(&waiter);
> +	waiter.task = NULL;
> +
> +	spin_lock_irqsave(&lock->wait_lock, flags);
> +
> +	/* Try to acquire the lock again: */
> +	if (try_to_take_rt_mutex(lock __IP__)) {
> +		spin_unlock_irqrestore(&lock->wait_lock, flags);
> +		return 0;
> +	}
> +
> +	BUG_ON(rt_mutex_owner(lock) == current);
> +
> +	set_task_state(current, state);

set_current_state()  (Several more below)

> +void fastcall __rt_mutex_init(struct rt_mutex *lock, const char *name)
> +{
> +	lock->owner = NULL;
> +	spin_lock_init(&lock->wait_lock);
> +	plist_head_init(&lock->wait_list);
> +
> +	debug_rt_mutex_init(lock, name);
> +}
> +EXPORT_SYMBOL_GPL(__rt_mutex_init);

What's the export for?


Anyway.  Tricky-looking stuff.
