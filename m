Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVCPSh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVCPSh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVCPSfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:35:51 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:4295 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262734AbVCPSez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:34:55 -0500
Message-ID: <42387C2E.4040106@colorfullife.com>
Date: Wed, 16 Mar 2005 19:34:22 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: [PATCH] NUMA Slab Allocator
References: <20050315204110.6664771d.akpm@osdl.org>
In-Reply-To: <20050315204110.6664771d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Do you have profile data from your modification? Which percentage of the 
allocations is node-local, which percentage is from foreign nodes? 
Preferably per-cache. It shouldn't be difficult to add statistics 
counters to your patch.
And: Can you estaimate which percentage is really accessed node-local 
and which percentage are long-living structures that are accessed from 
all cpus in the system?
I had discussions with guys from IBM and SGI regarding a numa allocator, 
and we decided that we need profile data before we can decide if we need 
one:
- A node-local allocator reduces the inter-node traffic, because the 
callers get node-local memory
- A node-local allocator increases the inter-node traffic, because 
objects that are kfree'd on the wrong node must be returned to their 
home node.

> static inline void __cache_free (kmem_cache_t *cachep, void* objp)
> {
>  struct array_cache *ac = ac_data(cachep);
>+ struct slab *slabp;
>
>  check_irq_off();
>  objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
>
>- if (likely(ac->avail < ac->limit)) {
>+ /* Make sure we are not freeing a object from another
>+  * node to the array cache on this cpu.
>+  */
>+ slabp = GET_PAGE_SLAB(virt_to_page(objp));
>  
>
This line is quite slow, and should be performed only for NUMA builds, 
not for non-numa builds. Some kind of wrapper is required.

>+ if(unlikely(slabp->nodeid != numa_node_id())) {
>+  STATS_INC_FREEMISS(cachep);
>+  int nodeid = slabp->nodeid;
>+  spin_lock(&(cachep->nodelists[nodeid])->list_lock);
>  
>
This line is very dangerous: Every wrong-node allocation causes a 
spin_lock operation. I fear that the cache line traffic for the spinlock 
might kill the performance for some workloads. I personally think that 
batching is required, i.e. each cpu stores wrong-node objects in a 
seperate per-cpu array, and then the objects are returned as a block to 
their home node.

>-/*
>- * NUMA: different approach needed if the spinlock is moved into
>- * the l3 structure
>  
>
You have moved the cache spinlock into the l3 structure. Have you 
compared both approaches?
A global spinlock has the advantage that batching is possible in 
free_block: Acquire global spinlock, return objects to all nodes in the 
system, release spinlock. A node-local spinlock would mean less 
contention [multiple spinlocks instead of one global lock], but far more 
spin_lock/unlock calls.

IIRC the conclusion from our discussion was, that there are at least 
four possible implementations:
- your version
- Add a second per-cpu array for off-node allocations. __cache_free 
batches, free_block then returns. Global spinlock or per-node spinlock. 
A patch with a global spinlock is in
http://www.colorfullife.com/~manfred/Linux-kernel/slab/patch-slab-numa-2.5.66
per-node spinlocks would require a restructuring of free_block.
- Add per-node array for each cpu for wrong node allocations. Allows 
very fast batch return: each array contains memory just from one node, 
usefull if per-node spinlocks are used.
- do nothing. Least overhead within slab.

I'm fairly certains that "do nothing" is the right answer for some 
caches. For example the dentry-cache: The object lifetime is seconds to 
minutes, the objects are stored in a global hashtable. They will be 
touched from all cpus in the system, thus guaranteeing that 
kmem_cache_alloc returns node-local memory won't help. But the added 
overhead within slab.c will hurt.

--
    Manfred
