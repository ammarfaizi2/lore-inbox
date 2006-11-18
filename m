Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755331AbWKRWqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbWKRWqo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbWKRWqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:46:44 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:31469 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1755331AbWKRWqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:46:44 -0500
Date: Sun, 19 Nov 2006 01:46:27 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061118224627.GA270@oleg>
References: <20061118212542.GA235@oleg> <Pine.LNX.4.44L0.0611181656230.23270-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611181656230.23270-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18, Alan Stern wrote:
>
> On Sun, 19 Nov 2006, Oleg Nesterov wrote:
> 
> > On 11/18, Alan Stern wrote:
> > >
> > > By the way, I think the fastpath for synchronize_srcu() should be safe, 
> > > now that you have added the memory barriers into srcu_read_lock() and 
> > > srcu_read_unlock().  You might as well try putting it in.
> > 
> > I still think the fastpath should do mb() unconditionally to be correct.
> 
> Yes, it definitely should.
> 
> > > Although now that I look at it again, you have forgotten to put smp_mb()
> > > after the atomic_inc() call and before the atomic_dec().
> > 
> > As I see it, currently we don't need this barrier because synchronize_srcu()
> > does synchronize_sched() before reading ->hardluckref.
> > 
> > But if we add the fastpath into synchronize_srcu() then yes, we need mb()
> > after atomic_inc().
> > 
> > Unless I totally confused :)
> 
> Put it this way: If the missing memory barrier in srcu_read_lock() after
> the atomic_inc call isn't needed, then neither is the existing memory
> barrier after the per-cpu counter gets incremented.

I disagree. There is another reason for mb() after the per-cpu counter gets
incremented. Without this barrier we can read the updated value of ->completed
(incremented by synchronize_srcu()), but then read a stale data of the rcu
protected memory.

>                                                     Likewise, if a memory
> barrier isn't needed before the atomic_dec in srcu_read_unlock(), then
> neither is the memory barrier before the per-cpu counter gets decremented.

Yes, you are right, I forgot about unlock(), it definitely needs mb().

> What you're ignoring is the synchronize_sched() call at the end of
> synchronize_srcu(), which has been replaced with smp_mb().  The smp_mb()
> needs to pair against a memory barrier on the read side, and that memory
> barrier has to occur after srcu_read_lock() has incremented the counter
> and before the read-side critical section begins.  Otherwise code in the
> critical section might leak out to before the counter is incremented.

Still I am not sure you are right. It is ok (I think) if the code in the
critical section leaks out to before the atomic_inc(). In fact this doesn't
differ from the case when srcu_read_lock() happens before synchronize_srcu()
starts. In that case synchronize_srcu() will wait until the critical section
is closed via srcu_read_unlock(). Because of synchronize_sched() synchronize_srcu()
can't miss the fact that the critical section is in progress, so it doesn't
matter if it leaks _before_.

Oleg.

