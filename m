Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVFAOsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVFAOsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVFAOst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:48:49 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:26045 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261400AbVFAOsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:48:04 -0400
Date: Wed, 1 Jun 2005 16:45:57 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050601143202.GI5413@g5.random>
Message-Id: <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Andrea Arcangeli wrote:

> On Wed, Jun 01, 2005 at 04:19:19PM +0200, Ingo Molnar wrote:
> > 
> > * Andrea Arcangeli <andrea@suse.de> wrote:
> > 
> > > I've a bug in my queue that definitely would break preempt-RT:
> > >
> > >       BUG xxx : spends excessive time with interrupts disabled on large memory>
> >        systems
> > >
> > > workaround:
> > >
> > >       #define MAX_ITERATION 100000
> > >       if ((nr_pages > MAX_ITERATION) && !(nr_pages % MAX_ITERATION)) {
> > >               spin_unlock_irq(&zone->lru_lock);
> > >               spin_lock_irq(&zone->lru_lock);
> > >       }
> > 
> > you are wrong. This codepath is not running with interrupts disabled on 
> > PREEMPT_RT. irqs-off spinlocks dont turn off interrupts on PREEMPT_RT.  
> 
> Then I'm afraid preempt-RT infringe on the patent that they take after
> years of doing that in linux. I'm not a lawyer but you may want to
> check before investing too much on this for the next 15 years. The
> nanokernel thing has happened exactly because they couldn't wrap the cli
> calls to do something different than a cli AFIK. Nanokernel was a nice
> workaround to avoid having to us the patented irq disable redefine.
> 
> I assumed you weren't infringing on the patent and in turn disabling irq
> locally would actually do that, sorry.
> 
I haven't seen the patent - it isn't valid here in Europe yet anyway :-) -
but don't worry: disable_irq is _not_ redefined, see below.


> > (there are still some ways to introduce latencies into PREEMPT_RT, but 
> > they are not common and we are working on ways to cover them all.)
> 
> How can you schedule a task while a spinlock is held? Ok irqs will keep
> going, but how can you reschedule risking to deadlock? As long as there
> are regular spinlocks in any driver out there (i.e. all of them) then
> you can still introduce latencies.

I'll explain it again: All spinlocks are made into mutexes. Everything
runs in threads under the normal scheduler with interrupt disabled. Only
the implementation of the former spinlock, now a mutex, is using a
raw_spin_lock, which disables interrupts.

>  It doesn't seem too uncommon to me to
> take a spinlock. Preempt-rt reliability cannot be remotely compared to
> RTAI.

It can come close, but not all the way, no.

Esben


