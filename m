Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWJQMSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWJQMSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWJQMSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:18:22 -0400
Received: from [213.46.243.16] ([213.46.243.16]:9833 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750741AbWJQMSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:18:22 -0400
Subject: Re: [RFC][PATCH] ->signal->tty locking
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Prarit Bhargava <prarit@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20061017081018.GA115@oleg>
References: <1160992420.22727.14.camel@taijtu>  <20061017081018.GA115@oleg>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 12:17:01 +0200
Message-Id: <1161080221.3036.38.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 12:10 +0400, Oleg Nesterov wrote:
> On 10/16, Peter Zijlstra wrote:
> >
> > Oleg wrote:
> > "Historically ->signal/->sighand (both ptrs and their contents) were globally
> > protected by tasklist_lock. 'current' can use these pointers lockless, they
> > can't be changed under him.
> > 
> > Nowadays ->signal/->sighand are _also_ protected by ->sighand->siglock.
> > Unless you are current, you can't lock ->siglock directly (without holding
> > tasklist_lock), you should use lock_task_sighand()."
> > 
> > Then, to be consistent with the rest of the kernel, ->signal->tty
> > locking should look like so:
> > 
> >   mutex_lock(&tty_mutex)
> >     read_lock(&tasklist_lock)
> >       lock_task_sighand(p, &flags)
> 
> I've also started similar patches, but have no time to finish it.
> 
> I don't think we need tasklist_lock. I think ->sighand->siglock is enough.

Right, sys_unshare() makes tasklist_lock meaningless wrt ->siglock.

> So do_task_stat() doesn't need to take tty_mutex at all.
> 
> However, tty_mutex protects ->tty from release_dev(tty), so it is also
> possible to do:
> 
> 	mutex_lock(&tty_mutex);
> 	tty = task->signal->tty;
> 	barrier();
> 	if (tty) {
> 		// ->tty could be changed/cleared from under us,
> 		// but it can't be released while we are holding
> 		// tty_mutex
> 		do_something(tty);
> 	}
> 	...

Nice, I think we have to convert all those callers like sys_vhangup() to
this form.


> > @@ -1350,20 +1357,26 @@ static void do_tty_hangup(void *data)
> >  	  This should get done automatically when the port closes and
> >  	  tty_release is called */
> >  	
> > +	mutex_lock(&tty_mutex);
> 
> I am not sure it is needed.

Right, this would only be needed when using the tty, not when changing
signal->tty.

> >  	read_lock(&tasklist_lock);
> >  	if (tty->session > 0) {
> >  		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
> > +			lock_task_sighand(p, &flags);
> >  			if (p->signal->tty == tty)
> >  				p->signal->tty = NULL;
> > +			unlock_task_sighand(p, &flags);
> 
> We don't need lock_task_sighand() here, we can use spin_lock_irq(->siglock).
> 
> We are holding tasklist_lock. This means that all tasks found by
> do_each_task_pid() have a valid ->signal/->sighand != NULL.
> tasklist_lock protects against release_task()->__exit_signal() and
> from changing ->sighand by de_thread().

I think sys_unshare() spoils the game here; it changes ->sighand in
midair without holding tasklist_lock. So any ->sighand but current's is
fair game.

Hmm, either sys_unshare() is broken in that it doesn't take the
tasklist_lock or a lot of other code is broken.

let us take send_sig_info() vs. sys_unshare()

      1                                        2

read_lock(&tasklist_lock)
spin_lock_irqsave(&p->sighand->siglock, flags);

                         rcu_assign_pointer(current->sighand, new_sigh)

spin_unlock_irqsave(&p->sighand->siglock, flags);
read_unlock(&tasklist_lock);

what happens when 2's current is 1's p....

> > @@ -2910,20 +2953,23 @@ static int tiocsctty(struct tty_struct *
> >  
> >  			read_lock(&tasklist_lock);
> >  			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
> > +				lock_task_sighand(p, &flags);
> >  				p->signal->tty = NULL;
> > +				unlock_task_sighand(p, &flags);
> >  			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
> >  			read_unlock(&tasklist_lock);
> > -		} else
> > +		} else {
> > +			mutex_unlock(&tty_mutex);
> >  			return -EPERM;
> > +		}
> >  	}
> > -	mutex_lock(&tty_mutex);
> > -	task_lock(current);
> > -	current->signal->tty = tty;
> > -	task_unlock(current);
> > -	mutex_unlock(&tty_mutex);
> > -	current->signal->tty_old_pgrp = 0;
> >  	tty->session = current->signal->session;
> >  	tty->pgrp = process_group(current);
> > +	lock_task_sighand(current, &flags);
> > +	current->signal->tty = tty;
> > +	current->signal->tty_old_pgrp = 0;
> > +	unlock_task_sighand(current, &flags);
> > +	mutex_unlock(&tty_mutex);
> >  	return 0;
> >  }
> 
> There is a very similar code in tty_open(), probably we need another
> helper, proc_set_tty().
> 
> But I am not sure about locking. I think we should check
> ->signal->leader/->signal->tty and set ->tty in proc_set_tty()
> under ->siglock, this way we can remove tty_mutex from sys_setsid().

Right, use tty_mutex when using the tty, use ->sighand when changing
signal->tty.

