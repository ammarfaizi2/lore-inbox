Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVITIcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVITIcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVITIcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:32:00 -0400
Received: from [203.199.144.195] ([203.199.144.195]:36488 "EHLO
	ganesha.intranet.calsoftinc.com") by vger.kernel.org with ESMTP
	id S964900AbVITIb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:31:59 -0400
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
From: Alok Kataria <alokk@calsoftinc.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, vandrove@vc.cvut.cz,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       Ravikiran G Thirumalai <kiran@scalex86.org>
In-Reply-To: <20050919221614.6c01c2d1.akpm@osdl.org>
References: <4329A6A3.7080506@vc.cvut.cz>
	 <20050916023005.4146e499.akpm@osdl.org> <432AA00D.4030706@vc.cvut.cz>
	 <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz>
	 <20050919112912.18daf2eb.akpm@osdl.org>
	 <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
	 <20050919122847.4322df95.akpm@osdl.org>
	 <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
	 <20050919221614.6c01c2d1.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-9ObeemAfbQbh1AULtL67"
Message-Id: <1127205260.3536.23.camel@alok.intranet.calsoftinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 20 Sep 2005 14:04:20 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9ObeemAfbQbh1AULtL67
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached is a patch which stores the numa_node_id in a local variable
after disabling interrupts, in the cache_reap code path.
I was not able to reproduce the bug that Petr was talking about, but if
the cache reap threads do schedule across cpu's which might be the
problem here then this should just fix it. 

Andrew, i also have a patch which fixes the CPU_DOWN code path, which i
will send u later. 

Thanks & Regards,
Alok.
On Tue, 2005-09-20 at 10:46, Andrew Morton wrote:
> Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> > On Mon, 19 Sep 2005, Andrew Morton wrote:
> > 
> > > 	list_for_each(walk, &cache_chain) {
> > > 		kmem_cache_t *searchp;
> > > 		struct list_head* p;
> > > 		int tofree;
> > > 		struct slab *slabp;
> > > 
> > > 		searchp = list_entry(walk, kmem_cache_t, next);
> > > 
> > > 		if (searchp->flags & SLAB_NO_REAP)
> > > 			goto next;
> > > 
> > > 		check_irq_on();
> > > 
> > > 		l3 = searchp->nodelists[numa_node_id()];
> > > 		if (l3->alien)
> > > 			drain_alien_cache(searchp, l3);
> > > ->preempt here
> > > 		spin_lock_irq(&l3->list_lock);
> > > 
> > > 		drain_array_locked(searchp, ac_data(searchp), 0,
> > > 				numa_node_id());
> > > ->oops, wrong node.
> > 
> > This is called from keventd which exists per processor. Hmmm... This looks 
> > as if it can change processors after all
> 
> Well no, it would be a big bug if a keventd thread were to change CPUs.
> 
> It's OK to rely upon the pinnedness of keventd I guess - a comment would be
> nice.
> 
> > but the slab allocator depends on 
> > it running on the right processor. So does the page allocator. sigh. What 
> > is the point of having per processor workqueues if they do not stay on 
> > the assigned processor?
> 
> They do.  I don't believe that preemption is the source of this BUG. 
> (Petr, does CONFIG_PREEMPT=n fix it?)
> 
> > The fast fix for this case is to get the node number once and then use it 
> > consistently.
> 
> If one is writing preempt-safe code then one should disable preemption
> before copying the current CPU number into a local variable.
> 
> > But we really need to audit the slab and page allocator for 
> > additional cases like this or disable preempt and check for the right 
> > processor in cache_reap().
> 
> numa_node_id() must use smp_processor_id(), not raw_smp_processor_id(). 
> Then all the runtime squawks need to be audited and fixed, or switched to
> (new) raw_numa_node_id() if is is verified that a CPU/node switch at any
> time is OK.
> 
-- 
There are two ways of constructing a software design. One way is to make
it so simple that there are obviously no deficiencies. And the other way
is to make it so complicated that there are no obvious deficiencies.


--=-9ObeemAfbQbh1AULtL67
Content-Disposition: attachment; filename=cache_reap_nodeid.patch
Content-Type: text/x-patch; name=cache_reap_nodeid.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>

Index: linux-2.6.13/mm/slab.c
===================================================================
--- linux-2.6.13.orig/mm/slab.c	2005-09-13 20:56:33.040284000 +0530
+++ linux-2.6.13/mm/slab.c	2005-09-20 13:22:08.328464250 +0530
@@ -3273,7 +3273,7 @@
 	list_for_each(walk, &cache_chain) {
 		kmem_cache_t *searchp;
 		struct list_head* p;
-		int tofree;
+		int tofree, nodeid;
 		struct slab *slabp;
 
 		searchp = list_entry(walk, kmem_cache_t, next);
@@ -3283,13 +3283,19 @@
 
 		check_irq_on();
 
-		l3 = searchp->nodelists[numa_node_id()];
+		nodeid = numa_node_id();
+		l3 = searchp->nodelists[nodeid];
 		if (l3->alien)
 			drain_alien_cache(searchp, l3);
-		spin_lock_irq(&l3->list_lock);
+
+		local_irq_disable();
+		nodeid = numa_node_id();
+                l3 = searchp->nodelists[nodeid];
+
+		spin_lock(&l3->list_lock);
 
 		drain_array_locked(searchp, ac_data(searchp), 0,
-				numa_node_id());
+				nodeid);
 
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
@@ -3298,7 +3304,7 @@
 
 		if (l3->shared)
 			drain_array_locked(searchp, l3->shared, 0,
-				numa_node_id());
+				nodeid);
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
@@ -3327,7 +3333,8 @@
 			spin_lock_irq(&l3->list_lock);
 		} while(--tofree > 0);
 next_unlock:
-		spin_unlock_irq(&l3->list_lock);
+		spin_unlock(&l3->list_lock);
+		local_irq_enable();
 next:
 		cond_resched();
 	}

--=-9ObeemAfbQbh1AULtL67--

