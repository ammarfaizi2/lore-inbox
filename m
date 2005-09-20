Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbVITFRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbVITFRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 01:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbVITFRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 01:17:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932728AbVITFRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 01:17:09 -0400
Date: Mon, 19 Sep 2005 22:16:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: vandrove@vc.cvut.cz, alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-Id: <20050919221614.6c01c2d1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz>
	<20050916023005.4146e499.akpm@osdl.org>
	<432AA00D.4030706@vc.cvut.cz>
	<20050916230809.789d6b0b.akpm@osdl.org>
	<432EE103.5020105@vc.cvut.cz>
	<20050919112912.18daf2eb.akpm@osdl.org>
	<Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
	<20050919122847.4322df95.akpm@osdl.org>
	<Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
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
> > 	list_for_each(walk, &cache_chain) {
> > 		kmem_cache_t *searchp;
> > 		struct list_head* p;
> > 		int tofree;
> > 		struct slab *slabp;
> > 
> > 		searchp = list_entry(walk, kmem_cache_t, next);
> > 
> > 		if (searchp->flags & SLAB_NO_REAP)
> > 			goto next;
> > 
> > 		check_irq_on();
> > 
> > 		l3 = searchp->nodelists[numa_node_id()];
> > 		if (l3->alien)
> > 			drain_alien_cache(searchp, l3);
> > ->preempt here
> > 		spin_lock_irq(&l3->list_lock);
> > 
> > 		drain_array_locked(searchp, ac_data(searchp), 0,
> > 				numa_node_id());
> > ->oops, wrong node.
> 
> This is called from keventd which exists per processor. Hmmm... This looks 
> as if it can change processors after all

Well no, it would be a big bug if a keventd thread were to change CPUs.

It's OK to rely upon the pinnedness of keventd I guess - a comment would be
nice.

> but the slab allocator depends on 
> it running on the right processor. So does the page allocator. sigh. What 
> is the point of having per processor workqueues if they do not stay on 
> the assigned processor?

They do.  I don't believe that preemption is the source of this BUG. 
(Petr, does CONFIG_PREEMPT=n fix it?)

> The fast fix for this case is to get the node number once and then use it 
> consistently.

If one is writing preempt-safe code then one should disable preemption
before copying the current CPU number into a local variable.

> But we really need to audit the slab and page allocator for 
> additional cases like this or disable preempt and check for the right 
> processor in cache_reap().

numa_node_id() must use smp_processor_id(), not raw_smp_processor_id(). 
Then all the runtime squawks need to be audited and fixed, or switched to
(new) raw_numa_node_id() if is is verified that a CPU/node switch at any
time is OK.


