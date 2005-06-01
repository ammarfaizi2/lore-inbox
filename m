Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVFANwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVFANwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVFANwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:52:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45157
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261389AbVFANwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:52:05 -0400
Date: Wed, 1 Jun 2005 15:51:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Esben Nielsen <simlo@phys.au.dk>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601135154.GF5413@g5.random>
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429DA7AE.5000304@grupopie.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 01:18:54PM +0100, Paulo Marques wrote:
> It seems you didn't follow that thread too closely :)

True, not yet. But trust me I've seen many times the kernel hanging
preventing scheduling, despite ping was still doing fine ;).

> This wouldn't affect real-time tasks running over preempt-RT at all, 
> since the interactive bonus would never be enough to go over real-time 
> priority tasks.

I've a bug in my queue that definitely would break preempt-RT:

	BUG xxx : spends excessive time with interrupts disabled on large memory
	systems

workaround:
	
	#define MAX_ITERATION 100000
	if ((nr_pages > MAX_ITERATION) && !(nr_pages % MAX_ITERATION)) {
		spin_unlock_irq(&zone->lru_lock);
		spin_lock_irq(&zone->lru_lock);
	}

Measurements wouldn't necessary catch that bug, unless they were running
the same workload with the same amount of ram.

Or perhaps Ingo will try to remove all spinlocks from the kernel instead
of creating RT-aware spinlocks, dunno. But whatever we change, will have
a performance impact for the fast path (but perhaps not measurable).

> I do understand the point you're trying to make about the simplicity of 
> a nano-kernel that makes it much more reliable and verifiable.

Exactly, they're simply not remotely comaprable, a VM improvement may
break preempt-RT anytime, it's just too easy to screw things up and
invalidate all "measurements".

> However it seems that the range of applications that can use the 
> nano-kernel approach is getting pretty thin between the applications 
> that are so simple that they can run on a dedicated hardware/processor 
> without any OS at all, and the applications that require more complex 
> services than those that a nanokernel can provide by itself.

Sure, preempt-RT makes sense (preempt alone doesn't make any sense
IMHO). I'm simply saying that using preempt-RT metal hard is a mistake
when RTAI ruby hard will be much safer and much simpler to use and it
doesn't risk to break at every kernel upgrade.

For other RT apps like audio built on a weak soft-RT API from the ground
using RTAI wouldn't be feasible (at least in the short term).
