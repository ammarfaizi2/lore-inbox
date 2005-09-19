Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbVIST33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbVIST33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbVIST33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:29:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932610AbVIST33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:29:29 -0400
Date: Mon, 19 Sep 2005 12:28:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: vandrove@vc.cvut.cz, alokk@calsoftinc.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-Id: <20050919122847.4322df95.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz>
	<20050916023005.4146e499.akpm@osdl.org>
	<432AA00D.4030706@vc.cvut.cz>
	<20050916230809.789d6b0b.akpm@osdl.org>
	<432EE103.5020105@vc.cvut.cz>
	<20050919112912.18daf2eb.akpm@osdl.org>
	<Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Mon, 19 Sep 2005, Andrew Morton wrote:
> 
> > Well.  The CPU_UP_CANCELED locking in cpuup_callback() looks borked to me -
> > it takes cachep->nodelists[node]->list_lock and then calls
> > drain_alien_cache() which appears to take the same lock.  But that's not
> > the problem here.
> > 
> > The code in cache_reap() recalculates numa_node_id() multiple times, so if
> > the caller changes CPUs then this assertion will trigger.  However it's
> > running under keventd here, which is pinned to a single CPU.  Still, it
> > would be useful if you could try putting preempt_disable()s in
> > cache_reap(), or change cache_reap() to evaluate numa_node_id() just the
> > once, and cache that in a local variable.
> 
> drain_array_cache_locked calls check_spinlock_acquired_node which is in 
> turn insuring that interrupts are off. So no move to a different processor 
> should be possible.

	list_for_each(walk, &cache_chain) {
		kmem_cache_t *searchp;
		struct list_head* p;
		int tofree;
		struct slab *slabp;

		searchp = list_entry(walk, kmem_cache_t, next);

		if (searchp->flags & SLAB_NO_REAP)
			goto next;

		check_irq_on();

		l3 = searchp->nodelists[numa_node_id()];
		if (l3->alien)
			drain_alien_cache(searchp, l3);
->preempt here
		spin_lock_irq(&l3->list_lock);

		drain_array_locked(searchp, ac_data(searchp), 0,
				numa_node_id());
->oops, wrong node.


Still, this should all be pinned to one CPU, by happenstance.

> However, that is contradicted by __wake_up calling 
> drain_array_cache_locked. The process just woke up?

Not sure what you mean here.

> > I wonder why numa_node_id() uses raw_smp_processor_id()?  That's just
> > asking for preempt non-atomicity bugs.
> 
> Accessing arrays indexed by node number even works if the process 
> continues to be executed on another node.

That's a special case and the callers should be changed to use a new
raw_numa_node_id() in that case.

Code which calls numa_node_id() and then continues to use the result of
that in preemptible code is often buggy.  Code which reevaluates
numa_node_id() in preemptible code and assumes that it returned the same
thing is even buggier (unless it happens to be CPU pinned).

numa_node_id() is doing a bad thing and should be converted to use
smp_processor_id() so we can identify all the possibly-buggy callsites.


