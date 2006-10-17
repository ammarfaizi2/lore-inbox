Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWJQIKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWJQIKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 04:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWJQIKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 04:10:32 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:13481 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932224AbWJQIKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 04:10:30 -0400
Date: Tue, 17 Oct 2006 12:10:18 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Prarit Bhargava <prarit@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] ->signal->tty locking
Message-ID: <20061017081018.GA115@oleg>
References: <1160992420.22727.14.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160992420.22727.14.camel@taijtu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16, Peter Zijlstra wrote:
>
> Oleg wrote:
> "Historically ->signal/->sighand (both ptrs and their contents) were globally
> protected by tasklist_lock. 'current' can use these pointers lockless, they
> can't be changed under him.
> 
> Nowadays ->signal/->sighand are _also_ protected by ->sighand->siglock.
> Unless you are current, you can't lock ->siglock directly (without holding
> tasklist_lock), you should use lock_task_sighand()."
> 
> Then, to be consistent with the rest of the kernel, ->signal->tty
> locking should look like so:
> 
>   mutex_lock(&tty_mutex)
>     read_lock(&tasklist_lock)
>       lock_task_sighand(p, &flags)

I've also started similar patches, but have no time to finish it.

I don't think we need tasklist_lock. I think ->sighand->siglock is enough.

So do_task_stat() doesn't need to take tty_mutex at all.

However, tty_mutex protects ->tty from release_dev(tty), so it is also
possible to do:

	mutex_lock(&tty_mutex);
	tty = task->signal->tty;
	barrier();
	if (tty) {
		// ->tty could be changed/cleared from under us,
		// but it can't be released while we are holding
		// tty_mutex
		do_something(tty);
	}
	...

But first I think we should kill task_lock(). This is changelog for
the first patch in unfinished series:

	Taking task_lock() when updating/using signal->tty doesn't help because

		- it is used only in some random places

		- signal->tty is per-process, while ->alloc_lock is per-thread

	We can improve this if we take task_lock(task->group_leader), but I think
	this is not the best option and we should use sighand->siglock instead,
	because

		- task_lock() interacts badly with write_lock_irq(&tasklist_lock),
		  sys_setsid() won't be happy.

		- unless we are 'current' or tasklist_lock is held, we anyway need
		  ->siglock to access ->signal. Actually, even reading ->group_leader
		  is not safe unless we know the task was not released.

		- most of signal_struct's contents is already protected by ->siglock,
		  why ->tty isn't?

> However, lock_task_sighand(), is a conditional lock, p might not have a
> ->sighand, in which case it returns NULL. What would that mean for
> ->signal, can I then still modify it?

This means the task has already dead, it doesn't have ->signal.

> struct sighand_struct *sighand = lock_task_sighand(p, &flags);
> if (sighand) {
> 	/* modify/use ->signal->tty */
> 	unlock_task_sighand(p, &flags);
> } else
> 	/* now what !? */

see above.

> The same problem appears in fs/proc/array.c:do_task_stat(), there the
> locking doesn't look quite right either.

Hmm. I think do_task_stat() is fine, it does nothing when lock_task_sighand()
fails.

> --- linux-2.6.orig/drivers/char/tty_io.c
> +++ linux-2.6/drivers/char/tty_io.c
> @@ -63,6 +63,12 @@
>   *
>   * Move do_SAK() into process context.  Less stack use in devfs functions.
>   * alloc_tty_struct() always uses kmalloc() -- Andrew Morton <andrewm@uow.edu.eu> 17Mar01
> + *
> + * A word on (struct task)::signal->tty locking
> + *
> + *   mutex_lock(&tty_mutex)
> + *     read_lock(&tasklist_lock)
> + *       lock_task_sighand()
>   */
>  
>  #include <linux/types.h>
> @@ -1282,6 +1288,7 @@ static void do_tty_hangup(void *data)
>  	struct task_struct *p;
>  	struct tty_ldisc *ld;
>  	int    closecount = 0, n;
> +	unsigned long flags;
>  
>  	if (!tty)
>  		return;
> @@ -1350,20 +1357,26 @@ static void do_tty_hangup(void *data)
>  	  This should get done automatically when the port closes and
>  	  tty_release is called */
>  	
> +	mutex_lock(&tty_mutex);

I am not sure it is needed.

>  	read_lock(&tasklist_lock);
>  	if (tty->session > 0) {
>  		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
> +			lock_task_sighand(p, &flags);
>  			if (p->signal->tty == tty)
>  				p->signal->tty = NULL;
> +			unlock_task_sighand(p, &flags);

We don't need lock_task_sighand() here, we can use spin_lock_irq(->siglock).

We are holding tasklist_lock. This means that all tasks found by
do_each_task_pid() have a valid ->signal/->sighand != NULL.
tasklist_lock protects against release_task()->__exit_signal() and
from changing ->sighand by de_thread().

> @@ -1506,14 +1522,27 @@ void disassociate_ctty(int on_exit)
>  
>  	/* Must lock changes to tty_old_pgrp */
>  	mutex_lock(&tty_mutex);
> +	lock_task_sighand(current, &flags);

Again, we can use spin_lock_irq(current->signal->siglock). It is safe to
use current->sighand directly, it can't be freed or changed from under us.

>  	current->signal->tty_old_pgrp = 0;
> -	tty->session = 0;
> -	tty->pgrp = -1;
> +
> +	/* It is possible that do_tty_hangup has free'd this tty */
> +	if (current->signal->tty) {
> +		current->signal->tty->session = 0;
> +		current->signal->tty->pgrp = 0;
> +	} else {
> +#ifdef TTY_DEBUG_HANGUP
> +		printk(KERN_DEBUG "error attempted to write to tty [0x%p]"
> +		       " = NULL", tty);
> +#endif
> +	}
> +	unlock_task_sighand(current, &flags);
>  
>  	/* Now clear signal->tty under the lock */
>  	read_lock(&tasklist_lock);
>  	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
> +		lock_task_sighand(p, &flags);
>  		p->signal->tty = NULL;
> +		unlock_task_sighand(p, &flags);
>  	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
>  	read_unlock(&tasklist_lock);
>  	mutex_unlock(&tty_mutex);
> @@ -2340,11 +2369,15 @@ static void release_dev(struct file * fi
>  
>  		read_lock(&tasklist_lock);
>  		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
> +			lock_task_sighand(p, &flags);
>  			p->signal->tty = NULL;
> +			unlock_task_sighand(p, &flags);
>  		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
>  		if (o_tty)
>  			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
> +				lock_task_sighand(p, &flags);
>  				p->signal->tty = NULL;
> +				unlock_task_sighand(p, &flags);
>  			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
>  		read_unlock(&tasklist_lock);

While doing a similar changes, I introduced a couple of simple
helpers:

	static inline void proc_clear_tty(struct task_struct *p)
	{
		spin_lock_irq(&p->sighand->siglock);
		p->signal->tty = NULL;
		spin_unlock_irq(&p->sighand->siglock);
	}

	static void session_clear_tty(pid_t session)
	{
		struct task_struct *p;

		do_each_task_pid(session, PIDTYPE_SID, p) {
			proc_clear_tty(p);
		} while_each_task_pid(session, PIDTYPE_SID, p);
	}

I think it makes sense.

>  static int tiocsctty(struct tty_struct *tty, int arg)
>  {
>  	struct task_struct *p;
> +	unsigned long flags;
>  
>  	if (current->signal->leader &&
>  	    (current->signal->session == tty->session))
> @@ -2898,6 +2940,7 @@ static int tiocsctty(struct tty_struct *
>  	 */
>  	if (!current->signal->leader || current->signal->tty)
>  		return -EPERM;
> +	mutex_lock(&tty_mutex);
>  	if (tty->session > 0) {
>  		/*
>  		 * This tty is already the controlling
> @@ -2910,20 +2953,23 @@ static int tiocsctty(struct tty_struct *
>  
>  			read_lock(&tasklist_lock);
>  			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
> +				lock_task_sighand(p, &flags);
>  				p->signal->tty = NULL;
> +				unlock_task_sighand(p, &flags);
>  			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
>  			read_unlock(&tasklist_lock);
> -		} else
> +		} else {
> +			mutex_unlock(&tty_mutex);
>  			return -EPERM;
> +		}
>  	}
> -	mutex_lock(&tty_mutex);
> -	task_lock(current);
> -	current->signal->tty = tty;
> -	task_unlock(current);
> -	mutex_unlock(&tty_mutex);
> -	current->signal->tty_old_pgrp = 0;
>  	tty->session = current->signal->session;
>  	tty->pgrp = process_group(current);
> +	lock_task_sighand(current, &flags);
> +	current->signal->tty = tty;
> +	current->signal->tty_old_pgrp = 0;
> +	unlock_task_sighand(current, &flags);
> +	mutex_unlock(&tty_mutex);
>  	return 0;
>  }

There is a very similar code in tty_open(), probably we need another
helper, proc_set_tty().

But I am not sure about locking. I think we should check
->signal->leader/->signal->tty and set ->tty in proc_set_tty()
under ->siglock, this way we can remove tty_mutex from sys_setsid().

Oleg.

