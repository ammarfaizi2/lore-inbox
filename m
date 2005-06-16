Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVFPLeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVFPLeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 07:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVFPLeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 07:34:04 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19400 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261569AbVFPLd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 07:33:57 -0400
Subject: Re: [PATCH] Re: [BUG] Race condition with it_real_fn in
	kernel/itimer.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <42B12DD6.7028CBAE@tv-sign.ru>
References: <42B067BD.F4526CD@tv-sign.ru>
	 <1118860623.4508.70.camel@localhost.localdomain>
	 <1118864043.4508.81.camel@localhost.localdomain>
	 <42B12DD6.7028CBAE@tv-sign.ru>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 16 Jun 2005 07:33:43 -0400
Message-Id: <1118921624.4512.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-16 at 11:44 +0400, Oleg Nesterov wrote:
> Steven Rostedt wrote:
> >
> > So, timer_pending tests if timer->base is NULL, but here we see that
> > timer->base IS NULL before the function is called, and as I have said
> > earlier, the it_real_arm can be called on two CPUS simultaneously. So
> > here's another patch that should fix this race condition too.
> >
> > [...]
> >
> > +		/*
> > +		 * Call del_timer_sync unconditionally, since we don't
> > +		 * know if it is running or not. We also need to unlock
> > +		 * the siglock so that the it_real_fn called by ksoftirqd
> > +		 * doesn't wait for us.
> > +		 */
> > +		spin_unlock(&tsk->sighand->siglock);
> > +		del_timer_sync(&tsk->signal->real_timer);
> > +		spin_lock(&tsk->sighand->siglock);
> 
> I don't think this is 100% correct. After del_timer_sync() returns another
> thread can come and call do_setitimer() and re-arm the timer (because with
> your patch we are dropping tsk->sighand->siglock here). So this patch does
> not garantees that the timer is not queued/running after del_timer_sync(),
> and the it_real_arm can be called on two CPUS simultaneously again.
> 

I first thought that too, but then looking at the code I noticed:

int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
{
        struct task_struct *tsk = current;

Where tsk is current.  So the only ones that can change the
tsk->signal->real_timer seems to be the task itself and ksoftirqd. So
between del_timer_sync (which handles the ksoftirqd part) and the
spin_lock, there's no one else that can modify tsk->signal->real_timer.
So I don't believe that there is a race condition here.

[thinks about this a little]

Oh wait, is ->signal shared among threads?  Damn, I think so! So you are
right, another _thread_ can come and change this. I forgot about threads
(they're evil! ;-).

> There is a try_to_del_timer_sync() in the -mm tree which is suitable here:
> 
> 	again:
> 		spin_lock_irq(&tsk->sighand->siglock);
> 		if (try_to_del_timer_sync(&tsk->signal->real_timer) < 0) {
> 			spin_unlock_irq(&tsk->sighand->siglock);
> 			goto again;
> 		}

OK, for the -mm branch this may work. But for the current tree, we may
need to do something else.  Like this ugly patch. But it should work!


int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
{
        struct task_struct *tsk = current;
	static spinlock_t lock = SPIN_LOCK_UNLOCKED;

[...]
		spin_lock(&lock);
		spin_unlock(&tsk->sighand->siglock);
		del_timer_sync(&tsk->signal->real_timer);
		spin_lock(&tsk->sighand->siglock);
		spin_unlock(&lock);

This would handle the case for threads in the main line kernel, but it
looks (to me) pretty ugly, but should work. I also don't like this
because it is shared among all tasks!

Andrew, (or Roland since I see Andrew added you to the list)
  
 What do you think? Should try_to_del_timer_sync be brought over to the
mainline, or have the above ugly code added?

-- Steve


