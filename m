Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVC3WfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVC3WfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVC3WfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:35:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:42637 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262464AbVC3WeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:34:04 -0500
Date: Wed, 30 Mar 2005 14:34:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for
 asynchronous I/O
Message-Id: <20050330143409.04f48431.akpm@osdl.org>
In-Reply-To: <1112219491.10771.18.camel@lade.trondhjem.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> In NFSv4 we often want to serialize asynchronous RPC calls with ordinary
> RPC calls (OPEN and CLOSE for instance). On paper, semaphores would
> appear to fit the bill, however there is no support for asynchronous I/O
> with semaphores.
> <rant>What's more, trying to add that type of support is an exercise in
> futility: there are currently 23 slightly different arch-dependent and
> over-optimized versions of semaphores (not counting the different
> versions of read/write semaphores).</rant>

Yeah.

> Anyhow, the following is a simple implementation of semaphores designed
> to satisfy the needs of those I/O subsystems that want to support
> asynchronous behaviour too. Please comment.
> 

So I've been staring at this code for a while and I Just Don't Get It.  If
I want some custom callback function to be called when someone does an
iosem_unlock(), how do I do it?

Or have I misunderstood the intent?  Some /* comments */ would be appropriate..

> +struct iosem {
> +	unsigned long state;
> +	wait_queue_head_t wait;
> +};
> +
> +#define IOSEM_LOCK_EXCLUSIVE (24)
> +/* #define IOSEM_LOCK_SHARED (25) */
> +
> +struct iosem_wait {
> +	struct iosem *lock;
> +	wait_queue_t wait;
> +};
> +
> +struct iosem_work {
> +	struct work_struct work;
> +	struct iosem_wait waiter;
> +};

Commenting the data structures is particularly helpful.

> +extern void FASTCALL(iosem_lock(struct iosem *lk));
> +extern void FASTCALL(iosem_unlock(struct iosem *lk));
> +extern int iosem_lock_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
> +
> +static inline void init_iosem(struct iosem *lk)
> +{
> +	lk->state = 0;
> +	init_waitqueue_head(&lk->wait);
> +}
> +
> +static inline void init_iosem_waiter(struct iosem_wait *waiter)
> +{
> +	waiter->lock = NULL;
> +	init_waitqueue_entry(&waiter->wait, current);
> +	INIT_LIST_HEAD(&waiter->wait.task_list);
> +}
> +
> +static inline void init_iosem_work(struct iosem_work *wk, void (*func)(void *), void *data)
> +{
> +	INIT_WORK(&wk->work, func, data);
> +}

I'd be inclined to call these iosem_init, iosem_waiter_init and
iosem_work_init.

> --- /dev/null
> +++ linux-2.6.12-rc1/lib/iosem.c
> @@ -0,0 +1,103 @@
> +/*
> + * linux/fs/nfs/iosem.c

This filename is stale.

> +	spin_lock(&lk->wait.lock);

I wonder if this lock should be irq-safe everywhere.  Is it not possible
that someone might want to do an unlock from irq context?

> +	if (lk->state != 0) {
> +		waiter->lock = lk;
> +		add_wait_queue_exclusive_locked(&lk->wait, &waiter->wait);
> +		ret = -EINPROGRESS;
> +	} else {
> +		lk->state |= 1 << IOSEM_LOCK_EXCLUSIVE;
> +		ret = 0;
> +	}
> +	spin_unlock(&lk->wait.lock);
> +	return ret;
> +}

Again, some commentary would be needed to help the poor reader understand
what a -EINPROGRESS return means.

> +	struct iosem_wait waiter;
> +
> +	might_sleep();
> +
> +	init_iosem_waiter(&waiter);
> +	waiter.wait.func = iosem_lock_wake_function;
> +
> +	set_current_state(TASK_UNINTERRUPTIBLE);
> +	if (__iosem_lock(lk, &waiter))
> +		schedule();
> +	__set_current_state(TASK_RUNNING);
> +
> +	BUG_ON(!list_empty(&waiter.wait.task_list));
> +}

Is this BUG_ON() safe?  No locks are held, so couldn't another object get
added by some other thread of control?

> +int iosem_lock_and_schedule_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
> +{
> +	struct iosem_wait *waiter = container_of(wait, struct iosem_wait, wait);
> +	struct iosem_work *wk = container_of(waiter, struct iosem_work, waiter);
> +	unsigned long *lk_state = &waiter->lock->state;
> +	int ret = 0;
> +
> +	if (*lk_state == 0) {
> +		ret = schedule_work(&wk->work);
> +		if (ret) {
> +			*lk_state |= 1 << IOSEM_LOCK_EXCLUSIVE;
> +			list_del_init(&wait->task_list);
> +		}
> +	}
> +	return ret;
> +}

Again, I don't understand why this function was created.  I think it means
that there are restrictions upon what keventd can do with iosems, to avoid
deadlocking.  If correct, they should be spelled out.

> +int fastcall iosem_lock_and_schedule_work(struct iosem *lk, struct iosem_work *wk)
> +{
> +	int ret;
> +
> +	init_iosem_waiter(&wk->waiter);
> +	wk->waiter.wait.func = iosem_lock_and_schedule_function;
> +	ret = __iosem_lock(lk, &wk->waiter);
> +	if (ret == 0)
> +		ret = schedule_work(&wk->work);
> +	return ret;
> +}
> +EXPORT_SYMBOL(iosem_lock_and_schedule_work);

Ditto.


