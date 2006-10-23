Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWJWOFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWJWOFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWJWOFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:05:22 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:4583 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751385AbWJWOFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:05:21 -0400
Date: Mon, 23 Oct 2006 18:05:09 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_task_stat: don't take tty_mutex
Message-ID: <20061023140509.GA1511@oleg>
References: <20061022155735.GA10491@oleg> <1161602202.5230.91.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161602202.5230.91.camel@lappy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23, Peter Zijlstra wrote:
>
> On Sun, 2006-10-22 at 19:57 +0400, Oleg Nesterov wrote:
> > Depends on
> > 	tty-signal-tty-locking.patch
> > 
> > ->signal->tty is protected by ->siglock, no need to take the global tty_mutex.
> > 
> > Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> ->siglock protects the value of ->signal->tty, not memory it points to;

Yes. That is why we can't avoid tty_mutex in audit_log_exit() (unless we copy
tty->name to the safe location). But is is bad we take tasklist_lock to access
tsk->signal. This 'tsk' should be 'current', we can use get_current_tty().
Or we can use lock_task_sighand() to be safe.

What do you think?

Oleg.

> however since destroying the tty also means clearing all ->signal->tty
> references, which means taking all ->siglocks, just holding the
> ->siglock around this piece of code looks sufficient indeed.
> 
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> > --- rc2-mm2/fs/proc/array.c~	2006-10-22 19:28:17.000000000 +0400
> > +++ rc2-mm2/fs/proc/array.c	2006-10-22 19:45:52.000000000 +0400
> > @@ -346,20 +346,13 @@ static int do_task_stat(struct task_stru
> >  	sigemptyset(&sigcatch);
> >  	cutime = cstime = utime = stime = cputime_zero;
> >  
> > -	mutex_lock(&tty_mutex);
> >  	rcu_read_lock();
> >  	if (lock_task_sighand(task, &flags)) {
> >  		struct signal_struct *sig = task->signal;
> > -		struct tty_struct *tty = sig->tty;
> >  
> > -		if (tty) {
> > -			/*
> > -			 * sig->tty is not stable, but tty_mutex
> > -			 * protects us from release_dev(tty)
> > -			 */
> > -			barrier();
> > -			tty_pgrp = tty->pgrp;
> > -			tty_nr = new_encode_dev(tty_devnum(tty));
> > +		if (sig->tty) {
> > +			tty_pgrp = sig->tty->pgrp;
> > +			tty_nr = new_encode_dev(tty_devnum(sig->tty));
> >  		}
> >  
> >  		num_threads = atomic_read(&sig->count);
> > @@ -395,7 +388,6 @@ static int do_task_stat(struct task_stru
> >  		unlock_task_sighand(task, &flags);
> >  	}
> >  	rcu_read_unlock();
> > -	mutex_unlock(&tty_mutex);
> >  
> >  	if (!whole || num_threads<2)
> >  		wchan = get_wchan(task);
> > 
> 

