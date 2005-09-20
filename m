Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbVITN6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVITN6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVITN6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:58:19 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:6379 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932628AbVITN6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:58:18 -0400
Message-ID: <43301578.8040305@vc.cvut.cz>
Date: Tue, 20 Sep 2005 15:58:16 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Lameter <clameter@engr.sgi.com>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
References: <4329A6A3.7080506@vc.cvut.cz>	<20050916023005.4146e499.akpm@osdl.org>	<432AA00D.4030706@vc.cvut.cz>	<20050916230809.789d6b0b.akpm@osdl.org>	<432EE103.5020105@vc.cvut.cz>	<20050919112912.18daf2eb.akpm@osdl.org>	<Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>	<20050919122847.4322df95.akpm@osdl.org>	<Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com> <20050919221614.6c01c2d1.akpm@osdl.org>
In-Reply-To: <20050919221614.6c01c2d1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christoph Lameter <clameter@engr.sgi.com> wrote:
> 
>>On Mon, 19 Sep 2005, Andrew Morton wrote:
>>
>>
>>>	list_for_each(walk, &cache_chain) {
>>>		kmem_cache_t *searchp;
>>>		struct list_head* p;
>>>		int tofree;
>>>		struct slab *slabp;
>>>
>>>		searchp = list_entry(walk, kmem_cache_t, next);
>>>
>>>		if (searchp->flags & SLAB_NO_REAP)
>>>			goto next;
>>>
>>>		check_irq_on();
>>>
>>>		l3 = searchp->nodelists[numa_node_id()];
>>>		if (l3->alien)
>>>			drain_alien_cache(searchp, l3);
>>>->preempt here
>>>		spin_lock_irq(&l3->list_lock);
>>>
>>>		drain_array_locked(searchp, ac_data(searchp), 0,
>>>				numa_node_id());
>>>->oops, wrong node.
>>
>>This is called from keventd which exists per processor. Hmmm... This looks 
>>as if it can change processors after all
> 
> 
> Well no, it would be a big bug if a keventd thread were to change CPUs.
> 
> It's OK to rely upon the pinnedness of keventd I guess - a comment would be
> nice.
> 
> 
>>but the slab allocator depends on 
>>it running on the right processor. So does the page allocator. sigh. What 
>>is the point of having per processor workqueues if they do not stay on 
>>the assigned processor?
> 
> 
> They do.  I don't believe that preemption is the source of this BUG. 
> (Petr, does CONFIG_PREEMPT=n fix it?)

No, it does not.  I've even added printks here and there to show node number,
and everything works as it should.  Maybe there are some problems with
numa_node_id() and migrating between processors when memory gets released,
I do not know.

Only thing I know that if I'll add WARN_ON below to the free_block(), it
triggers...

@free_block
   slabp = GET_PAGE_SLAB(virt_to_page(objp));
   nodeid = slabp->nodeid;
+  WARN_ON(nodeid != numa_node_id());             <<<<<
   l3 = cachep->nodelist[nodeid];
   list_del(&slabp->list);
   objnr = (objp - slabp->s_mem) / cachep->objsize;
   check_spinlock_acquired_node(cachep, nodeid);
   check_slabp(cachep, slabp);

... saying that keventd/0 tries to operate on
slab belonging to node#1, while having acquired lock for cachep belonging
to node #0.  Due to this check_spinlock_acquired_node(cachep, nodeid) fails
(check_spinlock_acquired_node(cachep, 0) would succeed).
								Petr

