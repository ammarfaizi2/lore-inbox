Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVFAOcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVFAOcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVFAOcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:32:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27428
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261391AbVFAOcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:32:13 -0400
Date: Wed, 1 Jun 2005 16:32:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601143202.GI5413@g5.random>
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601141919.GA9282@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 04:19:19PM +0200, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > I've a bug in my queue that definitely would break preempt-RT:
> >
> >       BUG xxx : spends excessive time with interrupts disabled on large memory>
>        systems
> >
> > workaround:
> >
> >       #define MAX_ITERATION 100000
> >       if ((nr_pages > MAX_ITERATION) && !(nr_pages % MAX_ITERATION)) {
> >               spin_unlock_irq(&zone->lru_lock);
> >               spin_lock_irq(&zone->lru_lock);
> >       }
> 
> you are wrong. This codepath is not running with interrupts disabled on 
> PREEMPT_RT. irqs-off spinlocks dont turn off interrupts on PREEMPT_RT.  

Then I'm afraid preempt-RT infringe on the patent that they take after
years of doing that in linux. I'm not a lawyer but you may want to
check before investing too much on this for the next 15 years. The
nanokernel thing has happened exactly because they couldn't wrap the cli
calls to do something different than a cli AFIK. Nanokernel was a nice
workaround to avoid having to us the patented irq disable redefine.

I assumed you weren't infringing on the patent and in turn disabling irq
locally would actually do that, sorry.

> (there are still some ways to introduce latencies into PREEMPT_RT, but 
> they are not common and we are working on ways to cover them all.)

How can you schedule a task while a spinlock is held? Ok irqs will keep
going, but how can you reschedule risking to deadlock? As long as there
are regular spinlocks in any driver out there (i.e. all of them) then
you can still introduce latencies. It doesn't seem too uncommon to me to
take a spinlock. Preempt-rt reliability cannot be remotely compared to
RTAI.
