Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWHCO1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWHCO1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWHCO1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:27:54 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:29943 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932517AbWHCO1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:27:54 -0400
Subject: Re: Problems with 2.6.17-rt8
From: Steven Rostedt <rostedt@goodmis.org>
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Bill Huey <billh@gnuppy.monkey.org>
In-Reply-To: <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:27:41 -0400
Message-Id: <1154615261.32264.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't trim CC lines.  LKML is too big to read all emails.

On Thu, 2006-08-03 at 04:48 -0700, Robert Crocombe wrote: 
> On 8/2/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> > You mention problems but I don't see you listing what exactly the
> > problems are.  Just saying "the problems exist" doesn't tell us
> > anything.
> >
> > Don't assume that we will go to some web site to figure out what you're
> > talking about. Please list the problems you are facing.
> 
> The machine dies (no alt-sysrq, no keyboard LEDs of any kind: dead in
> the water).  I thought the log would provide more useful information
> without potentially erroneous editorialization by myself.  Here are
> some highlights:
> 
> kjournald/1105[CPU#3]: BUG in debug_rt_mutex_unlock at kernel/rtmutex-debug.c:47
> 1

Ouch, that looks like kjournald is unlocking a lock that it doesn't own?

> 
> Call Trace:
>        <ffffffff8047655a>{_raw_spin_lock_irqsave+24}
>        <ffffffff8022b272>{__WARN_ON+100}
>        <ffffffff802457e4>{debug_rt_mutex_unlock+199}
>        <ffffffff804757b7>{rt_lock_slowunlock+25}
>        <ffffffff80476301>{__lock_text_start+9}

hmm, here we are probably having trouble with the percpu slab locks,
that is somewhat of a hack to get slabs working on a per cpu basis.

>        <ffffffff80271e93>{kmem_cache_alloc+202}

It would also be nice to know exactly where ffffffff80271e93 is.

>        <ffffffff8025493b>{mempool_alloc_slab+17}
>        <ffffffff80254d07>{mempool_alloc+75}
>        <ffffffff802f2f8c>{generic_make_request+375}
>        <ffffffff8027b914>{bio_alloc_bioset+35}
>        <ffffffff8027ba2a>{bio_alloc+16}
>        <ffffffff802781d1>{submit_bh+137}
>        <ffffffff80279377>{ll_rw_block+122}
>        <ffffffff8027939e>{ll_rw_block+161}
>        <ffffffff802c85dc>{journal_commit_transaction+1011}
>        <ffffffff80476a5f>{_raw_spin_unlock_irqrestore+56}
>        <ffffffff804769ac>{_raw_spin_unlock+46}
>        <ffffffff804757df>{rt_lock_slowunlock+65}
>        <ffffffff80476301>{__lock_text_start+9}
>        <ffffffff802339b0>{try_to_del_timer_sync+85}
>        <ffffffff802cca63>{kjournald+202}
>        <ffffffff8023db60>{autoremove_wake_function+0}
>        <ffffffff802cc999>{kjournald+0}
>        <ffffffff8023d739>{keventd_create_kthread+0}
>        <ffffffff8023da2f>{kthread+219}
>        <ffffffff80225a23>{schedule_tail+188}
>        <ffffffff8020aaca>{child_rip+8}
>        <ffffffff8023d739>{keventd_create_kthread+0}
>        <ffffffff8023d954>{kthread+0}
>        <ffffffff8020aac2>{child_rip+0}
> ---------------------------
> | preempt count: 00000002 ]
> | 2-level deep critical section nesting:
> ----------------------------------------
> .. [<ffffffff80476499>] .... _raw_spin_lock+0x16/0x23
> .....[<ffffffff804757af>] ..   ( <= rt_lock_slowunlock+0x11/0x6b)
> .. [<ffffffff8047655a>] .... _raw_spin_lock_irqsave+0x18/0x29
> .....[<ffffffff8022b22d>] ..   ( <= __WARN_ON+0x1f/0x82)
> 
> 
> Somewhat later:
> 
> Kernel BUG at kernel/rtmutex.c:639

The rest was probably caused as a side effect from above.  The above is
already broken!

You have NUMA configured too, so this is also something to look at.

I still wouldn't ignore the first bug message you got:

----
BUG: scheduling while atomic: udev_run_devd/0x00000001/1568

Call Trace:
       <ffffffff8045c693>{__schedule+155}
       <ffffffff8045f156>{_raw_spin_unlock_irqrestore+53}
       <ffffffff80242241>{task_blocks_on_rt_mutex+518}
       <ffffffff80252da0>{free_pages_bulk+39}
       <ffffffff80252da0>{free_pages_bulk+39}
...
----

This could also have a side effect that messes things up.

Unfortunately, right now I'm assigned to other tasks and I cant spend
much more time on this at the moment.  So hopefully, Ingo, Thomas or
Bill, or someone else can help you find the reason for this problem.

-- Steve


