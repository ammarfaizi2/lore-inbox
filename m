Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVC1Q4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVC1Q4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVC1Q4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:56:39 -0500
Received: from digitalimplant.org ([64.62.235.95]:37095 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261950AbVC1Q4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:56:19 -0500
Date: Mon, 28 Mar 2005 08:56:13 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.44L0.0503261152160.13772-100000@netrider.rowland.org>
Message-ID: <Pine.LNX.4.50.0503280819480.28120-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503261152160.13772-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Mar 2005, Alan Stern wrote:

> Pat:
>
> Your recent series of driver model patches naturally divides up into
> two parts: those involved with implementing and using klists, and
> those involved with adding a semaphore to struct device.  Let's
> consider these parts separately.

I've split them into two replies to reflect their nature of separateness.

>     (1)	Your structures contain more fields than I would have used.
> 	klist_node.n_klist isn't really needed; it only gets used
> 	when removing a klist_node from a klist, and at such times
> 	the caller could easily pass the klist directly.  Also,
> 	klist_iter.i_head isn't needed because it's easily derivable
> 	from klist_iter.i_klist.  (Doesn't really matter because
> 	there never are very many iterators in existence.)

Those are good suggestions. Thanks.

>     (2) Likewise I'm not so sure about klist_node.n_removed.  Waiting
> 	for removal operations to complete is generally a bad idea;
> 	in the driver-model core it's important only when deregistering
> 	a driver.  The only other scenario I can think of where you
> 	would need to wait is when you remove an object from a klist
> 	and then want to put it on another (see also (5)).  While this
> 	might be necessary for general-purpose usage, the driver-model
> 	core doesn't do it.  It also means that moving an object from
> 	one klist to another can't be carried out in_interrupt.  (Not
> 	to mention you're adding a lot of struct completions all over
> 	the place, most of which shouldn't need to be used.)

It's important when removing a containing object's knode from the list
when that object is about to be freed. This happens during both device and
driver unregistration. In most cases, the removal operation will return
immediately. When it doesn't, it means another thread is using that
particular knode, which means its imperative that the containing object
not be freed.

Do you have suggestions about an alternative (with code)?

>     (3)	Your iteratators don't allow for some simple optimizations.
> 	For example, a bus's driver<->device matching routine should
> 	be able to run while retaining the klist's spinlock.

It's trivial to add a helper that holds a lock across an entire iteration.

However, we currently don't separate the bus->match() and the
driver->probe()  operations. We must not hold a spinlock across ->probe(),
which means we drop the lock before both ->match() and ->probe(). However,
it might be interesting to split those up and do a locked iteration just
to find a match, grab a reference for the driver, break out of the
iteration, and call ->probe().

>     (4)	You don't have any way of marking klist_nodes that have been
> 	removed from their klist.  So an iterator will return these
> 	nodes instead of skipping right past them, as one would expect.
> 	This can have unpleasant consequences, such as probing a new
> 	device against a driver that has been unregistered.  The
> 	klist_node's container will be forced to have its own "deleted"
> 	marker, and callers will have to skip deleted entries by hand.

Good point. It's trivial to add an atomic flag (.n_attached) which is
checked during an iteration. This can also be used for the
klist_node_attached() function that I posted a few days ago (and you may
have missed).

>     (5) Most importantly, klist_nodes aren't protected against their
> 	containers being deallocated.  Or rather, the way in which
> 	you've set up the protection is inappropriate.  Right now
> 	you force a caller to wait until list-removal is complete,
> 	and only later is it allowed to deallocate the container
> 	object.  This is a violation of the principles underlying the
> 	reference-counting approach; instead a klist_node should take
> 	a reference to its container.  But your generic library-based
> 	approach doesn't allow that, at least, not without some
> 	awkward coding.  This also means that iterating through a
> 	klist requires acquiring and releasing two references at each
> 	step: one for the klist_node and one for the container.

It's assumed that the controlling subsystem will handle lifetime-based
reference counting for the containing objects. If you can point me to a
potential usage where this assumption would get us into trouble, I'd be
interested in trying to work arond this.

[ device sem questions issues addressed separately. ]


	Pat
