Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTDDTxK (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTDDTxK (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:53:10 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:25333 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261335AbTDDTxH (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 14:53:07 -0500
Date: Fri, 4 Apr 2003 22:12:41 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Antonio Vargas <wind@cocodriloo.com>,
       Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030404201241.GB15864@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <200304021144.21924.frankeh@watson.ibm.com> <20030403125355.GA12001@wind.cocodriloo.com> <20030403192241.GB1828@holomorphy.com> <20030404112704.GA15864@wind.cocodriloo.com> <20030404140447.GC1828@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404140447.GC1828@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 06:04:47AM -0800, William Lee Irwin III wrote:
> On Thu, Apr 03, 2003 at 11:22:41AM -0800, William Lee Irwin III wrote:
> >> Use spin_lock_irq(&uidhash_lock) or you will deadlock if you hold it
> >> while you take a timer tick, but it's wrong anyway. it's O(N) with
> >> respect to number of users present. An O(1) algorithm could easily
> >> make use of reference counts held by tasks.
> [...]
> >> This isn't right, when expiration happens needs to be tracked by both
> >> user and task. Basically which tasks are penalized when the user
> >> expiration happens? The prediction is the same set of tasks will always
> >> be the target of the penalty.
> 
> On Fri, Apr 04, 2003 at 01:27:04PM +0200, Antonio Vargas wrote:
> > Just out of experimenting, I've coded something that looks reasonable
> > and would not experience starvation.
> > In the normal scheduler, a non-interactive task will, when used all
> > his timeslice, reset p->time_slice and queue onto the expired array.
> > I'm now reseting p->reserved_time_slice instead and queuing the task
> > onto a per-user pending task queue.
> > A separate kernel thread walks the user list, calculates the user
> > timeslice and distributes it to it's pending tasks. When a task
> > receives timeslices, it's moved from the per-user pending queue to
> > the expired array of the runqueue, thus preparing it to run on the
> > next array-switch.
> 
> Hmm, priorities getting recalculated by a kernel thread sounds kind of
> scary, but who am I to judge?

First and foremost, root user is handled as usual, so kernel tasks should
also be handled as usual if they always run as root...
but I've yet to find out how to check if a task is a kernel thread or not,
and skip these explicitely just to be safe.

Also, while I've coded it on a kernel thread, I'd settle perfectly to a
periodic timer, but I don't know yet ask for one... perhaps a
self-propagating workqueue entry with a delay?

> On Fri, Apr 04, 2003 at 01:27:04PM +0200, Antonio Vargas wrote:
> > If the user has many timeslices, he can give timeslices to many tasks, thus
> > getting more work done.
> > While the implementation may not be good enough, due to locking problems and
> > the use of a kernel-thread, I think the fundamental algorithm feels right.
> > William, should I take the lock on the uidhash_list when adding a task
> > to a per-user task list?
> 
> Possible, though I'd favor a per-user spinlock.

So, when trying to add a task to the per-user pending tasks, I'd have
to do this:

1. spin_lock_irqsave(uidhash_lock, flags)
2. spin_lock(my_user->user_lock)
3. spin_unlock_restore(uidhash_lock, flags);

Is this any good?

Could I simply do "spin_unlock(my_user->user_lock)" at end without
taking the uidhash_lock again?

> The code looks reasonable now, modulo that race you asked about.

What do I need to lock when I want to add a task to a runqueue?
I'm doing a "spin_lock_irq(this_rq()->lock);"

As you can see, I'm not yet at speed with the locking rules... any
online references to the latest locking rules? The BKL was really
easy to understand in comparison! *grin*

Greets, Antonio.
