Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755827AbWKQT1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbWKQT1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbWKQT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:27:17 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:26342 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1755827AbWKQT1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:27:16 -0500
Date: Fri, 17 Nov 2006 14:27:15 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Thomas Gleixner <tglx@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, <manfred@colorfullife.com>, <oleg@tv-sign.ru>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061117191538.GA2632@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611171421270.2627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, Paul E. McKenney wrote:

> > It works for me, but the overhead is still large. Before it would take
> > 8-12 jiffies for a synchronize_srcu() to complete without there actually
> > being any reader locks active, now it takes 2-3 jiffies. So it's
> > definitely faster, and as suspected the loss of two of three
> > synchronize_sched() cut down the overhead to a third.
> 
> Good to hear, thank you for trying it out!
> 
> > It's still too heavy for me, by far the most calls I do to
> > synchronize_srcu() doesn't have any reader locks pending. I'm still a
> > big advocate of the fastpath srcu_readers_active() check. I can
> > understand the reluctance to make it the default, but for my case it's
> > "safe enough", so if we could either export srcu_readers_active() or
> > export a synchronize_srcu_fast() (or something like that), then SRCU
> > would be a good fit for barrier vs plug rework.
> 
> OK, will export the interface.  Do your queues have associated locking?
> 
> > > Attached is a patch that compiles, but probably goes down in flames
> > > otherwise.
> > 
> > Works here :-)
> 
> I have at least a couple bugs that would show up under low-memory
> situations, will fix and post an update.

Perhaps a better approach to the initialization problem would be to assume 
that either:

    1.  The srcu_struct will be initialized before it is used, or

    2.  When it is used before initialization, the system is running
	only one thread.

In other words, statically allocated SRCU strucures that get used during
system startup must be initialized before the system starts multitasking.  
That seems like a reasonable requirement.

This eliminates worries about readers holding mutexes.  It doesn't 
solve the issues surrounding your hardluckref, but maybe it makes them 
easier to think about.

Alan Stern

