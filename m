Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVK1CnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVK1CnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 21:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVK1CnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 21:43:06 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:42160 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750792AbVK1CnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 21:43:04 -0500
Date: Sun, 27 Nov 2005 18:43:01 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>, ak@suse.de,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-ID: <20051128024301.GA8651@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051127172725.GJ20775@brahms.suse.de> <24158.1133113176@ocs3.ocs.com.au> <20051127115640.3073f8e3.akpm@osdl.org> <20051127220329.GA17786@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051127220329.GA17786@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 02:03:29PM -0800, Greg KH wrote:
> On Sun, Nov 27, 2005 at 11:56:40AM -0800, Andrew Morton wrote:
> > We're saying that kernel/sys.c:notifier_lock should be removed and that all
> > callers of notifier_chain_register(), notifier_chain_unregister() and
> > notifier_call_chain() should be changed to define and use their own lock.
> > 
> > So the _callers_ get to decide whether they're going to use down(),
> > spin_lock(), down_read(), read_lock(), preempt_disable(), local_irq_disable()
> > or whatever.
> 
> I completely agree.  I just watched in mute horror as Chandra and Alan
> spun off into the rcu blackhole trying to create one-size-fits-all
> notifiers.

RCU as blackhole?  I am impressed -- even -I- don't find RCU to have the
same limiting-case attraction that a black hole does.  ;-)

(My apologies, Greg, but you did leave yourself open for this!)

> Making the user do the locking it needs to do is simple and sane.
> 
> And the reason USB's notifiers are implemented correctly, is they don't
> use the notifier core, but rather, reimplemented their own, due to the
> locking mess.

The locking mess is due to the fact that the notifier chain itself
must be protected by something or another, right?  Here are the options
I have come across:

1.	The notifier chain is guarded by a separate notifier-chain lock.
	We then have the following deadlock situation:

	o	The subsystem requesting the notifier likely has
		to hold one of its own locks when registering and
		unregistering, which means that the notifier lock
		must be subordinate to the subsystem lock.

	o	But when invoking the notifiers, the notifier lock
		must be held while walking the chain.  Since the
		subsystem being notified likely has to acquire one
		of its own locks, the subsystem lock must be subordinate
		to the notifier lock.

	There are a number of ways of breaking this deadlock, some of
	which are listed below.  Note that this deadlock situation can
	arise both for spinlocks and for sleeplocks.

	I believe that this deadlock situation is the core reason why
	notifier locking is so difficult to get right.

	Even ignoring the deadlock, this does not work for NMIs.

2.	Each element of the notifier chain is guarded by reference
	counts, and the chain itself is guarded by a lock.  Each
	element of the chain holds a reference to the next element
	in the chain, and new elements are always added to the end
	of the chain.  The traversal code looks something like the
	following:

	spin_lock(&chain_lock);
	p = head;
	atomic_inc(&p->refcnt);
	while (p != NULL) {
		spin_unlock(&chain_lock);
		p->func(p->arg);
		spin_lock(&chain_lock);
		q = p->next;
		atomic_inc(&q->refcnt);
		if (atomic_dec_and_test(&p->refcnt)) {
			kfree(p);
		}
		p = q;
	}
	spin_unlock(&chain_lock);

	Note that all actual deletion is done under chain_lock.

	This works (I think...), and the subsystem code can use a
	single lock that the notifier lock (chain_lock in this case)
	is subordinate to.  But the notifier traversal loop is quite
	heavyweight.  And it cannot be invoked from NMI handlers without
	risk of self-deadlock.

3.	Like #1, but require that the subsystem have at least two locks,
	one of which is subordinate to the notifier lock (and is acquired
	from the notifier callback function), and the other of which is
	superior to the notifier lock, and is held when registering and
	deregistering callbacks.  This can work, but could significantly
	complicate the subsystem locking, and also will require that some
	operations acquire two locks instead of just one, since one must
	hold both to exclude both notifications and register/unregister
	operations.

	This approach also fails to handle notifications from NMIs.

4.	"Just say no" to a separate notifier-chain lock, and guard
	the hole thing with whatever mechanism the subsystem
	deems appropriate.  This can be made to work with NMI-based
	notification, since such subsystems can use RCU or whatever
	other lock-free mechanism they desire.

	I believe that Greg took this "just say no" approach in USB,
	but could easily be missing something.

	This works with minimal added complexity to the subsystem,
	but requires that each subsystem have its own notifier
	chain, since it does not make sense to have a single chain
	guarded by multiple locks.  But it means that notifier
	code must be replicated in a number of subsystems, which
	seems sub-optimal.

	This might be the best we can do, but in the interest of
	completeness...

5.	Use RCU to traverse the notifier chain and use simple locking
	to guard updates, similar to Alan's and Chandra's patch.
	This avoids the deadlock, and handles NMIs nicely, but does
	not tolerate synchronous notification callbacks that sleep.
	(Cases that can tolerate asynchronous notification can make use
	of workqueues or similar mechanisms to defer the sleeping code
	so that it is not executed in the scope of the rcu_read_lock()
	protecting the notifier-chain traversal.)

6.	Have separate mechanisms for the non-sleeping and the synchronous
	sleeping cases.  For example, #5 for non-sleeping and either #2,
	#3, or #4 for the synchronous sleeping case.

	This works in all cases, and achieves a high degree of code
	commonality, but does require two separate APIs.

7.	Use wait-free synchronization everywhere.  This has some issues
	with complexity, last I checked.

8.	Come up with a safe and sane RCU implementation that tolerates
	general blocking in read-side critical sections.  Note that
	although some realtime implementations of RCU do tolerate
	blocking, they do so only in the special case that priority
	inheritance applies to.  Might happen,
	but I would not recommend holding your breath.

Any options I missed?

							Thanx, Paul
