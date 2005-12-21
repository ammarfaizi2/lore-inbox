Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVLUPF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVLUPF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVLUPF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:05:57 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:40626 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932441AbVLUPF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:05:57 -0500
Message-ID: <43A98101.364DB5CF@tv-sign.ru>
Date: Wed, 21 Dec 2005 19:21:21 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
References: <20051219013718.GA28038@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> mutex implementation, core files: just the basic subsystem, no users of it.

Ingo, could you explain to me ...

> +__mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter,
> +		    struct thread_info *ti, struct task_struct *task,
> +		    unsigned long *flags, unsigned long task_state __IP_DECL__)
> +{
> +	unsigned int old_val;
> +
> +	debug_lock_irqsave(&debug_lock, *flags, ti);
> +	DEBUG_WARN_ON(lock->magic != lock);
> +
> +	spin_lock(&lock->wait_lock);
> +	__add_waiter(lock, waiter, ti, task __IP__);
> +	set_task_state(task, task_state);

I can't understand why __mutex_lock_common() does xchg() after
adding the waiter to the ->wait_list. We are holding ->wait_lock,
we can't race with __mutex_unlock_nonatomic() - it calls wake_up()
and sets ->count under this spinlock.

So, I think it can be simplified:

int __mutex_lock_common(lock, waiter)
{
	lock(&lock->wait_lock);

	ret = 1;
	if (xchg(&lock->count, -1) == 1)
		goto out;

	__add_waiter(lock, waiter);
	task->state = state;

	ret = 0;
out:
	unlock(&lock->wait_lock);
	return ret;
}

No?

> +__mutex_wakeup_waiter(struct mutex *lock __IP_DECL__)
> +{
> +	struct mutex_waiter *waiter;
> ...
> +	if (!waiter->woken) {
> +		waiter->woken = 1;
> +		wake_up_process(waiter->ti->task);
> +	}

Is it optimization? If yes - why? From mutex.h:

	- only one task can hold the mutex at a time
	- only the owner can unlock the mutex

So, how can this help?

> +start_mutex_timer(struct timer_list *timer, unsigned long time,
> +		  unsigned long *expire)
> +{
> +	*expire = time + jiffies;
> +	init_timer(timer);
> +	timer->expires = *expire;
> +	timer->data = (unsigned long)current;
> +	timer->function = process_timeout;
> +	add_timer(timer);
> +}

How about
	setup_timer(&timer, process_timeout, (unsigned long)current);
	__mod_timer(&timer, *expire);
?

> +stop_mutex_timer(struct timer_list *timer, unsigned long time,
> +		 unsigned long expire)
> +{
> +	int ret;
> +
> +	ret = (int)(expire - jiffies);
> +	if (!timer_pending(timer)) {
> +		del_singleshot_timer_sync(timer);
> +		ret = -ETIMEDOUT;
> +	}

Did you mean

	if (!timer_pending(timer))
		ret = -ETIMEDOUT;
	del_singleshot_timer_sync(timer);
?

> +__mutex_lock_interruptible(struct mutex *lock, unsigned long time __IP_DECL__)
> +{
> +	struct thread_info *ti = current_thread_info();
> +	struct task_struct *task = ti->task;
> +	unsigned long expire = 0, flags;
> +	struct mutex_waiter waiter;
> +	struct timer_list timer;
> +	int ret;
> +
> +repeat:
> +	if (__mutex_lock_common(lock, &waiter, ti, task, &flags,
> +						TASK_INTERRUPTIBLE __IP__))
> +		return 0;

I think this is wrong. We may have pending timer here if we were woken
by signal.

Oleg.
