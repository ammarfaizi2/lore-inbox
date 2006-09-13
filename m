Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWIMWMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWIMWMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 18:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWIMWMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 18:12:46 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:13000 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1751228AbWIMWMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 18:12:45 -0400
Date: Wed, 13 Sep 2006 15:14:35 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Do not use mempolicy for kmalloc_node
Message-ID: <20060913221435.GA4359@localhost.localdomain>
References: <20060912144518.GA4653@localhost.localdomain> <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com> <20060912195246.GA4039@localhost.localdomain> <Pine.LNX.4.64.0609121251160.12388@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609121251160.12388@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 12:52:14PM -0700, Christoph Lameter wrote:
> On Tue, 12 Sep 2006, Ravikiran G Thirumalai wrote:
> 
> > On Tue, Sep 12, 2006 at 10:36:54AM -0700, Christoph Lameter wrote:
> > > On Tue, 12 Sep 2006, Ravikiran G Thirumalai wrote:
> > > 
> > > ... 
> > > This is not complete. Please see the discussion on GFP_THISNODE and the 
> > > related patch to fix this issue 
> > > http://marc.theaimsgroup.com/?l=linux-mm&m=115505682122540&w=2
> > 
> > Hmm, I see, but with the above patch, if we ignore mempolicy for 
> > __GFP_THISNODE slab caches at alternate_node_alloc (which is pretty much 
> > all the slab caches) then we would be ignoring memplocies altogether no?
> 
> We are implementing memory policies in the slab layer. I.e. we 
> are taking slab objects round robin from the per node lists of the 
> slab.

Christoph,
As discussed offline, cpuset constraints and mempolicy constraints still
get applied to kmalloc_node in current mainline as well as the patch pointed
above.  Here is the fix we agreed upon.  Please ack it if you can :)

Thanks,
Kiran


Slab should follow the specified cpuset constraints/mem policy constraints
for kmalloc allocations, which it does.  However, for kmalloc_node 
allocations, slab should serve the object from the requested node 
irrespective of memory policy. This seems to be broken in slab code.  
Following patch fixes this.

Patch just moves out the cpuset/mempolicy base allocation from ____cache_alloc
to __cache_alloc.  __cache_alloc is used for general purpose allocation, 
and cpuset/mempolicy constraints should be considered there.  Whereas, 
____cache_alloc should always be used to allocate objects from the
array_cache of the executing CPU 

Signed-off-by: Alok N Kataria <alok.kataria@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.18-rc6/mm/slab.c
===================================================================
--- linux-2.6.18-rc6.orig/mm/slab.c	2006-09-13 14:19:25.000000000 -0700
+++ linux-2.6.18-rc6/mm/slab.c	2006-09-13 14:21:19.000000000 -0700
@@ -2963,19 +2963,11 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
+/* Allocate object from the array cache of the executing cpu */
 static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
-
-#ifdef CONFIG_NUMA
-	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
-		objp = alternate_node_alloc(cachep, flags);
-		if (objp != NULL)
-			return objp;
-	}
-#endif
-
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
 	if (likely(ac->avail)) {
@@ -2989,15 +2981,29 @@ static inline void *____cache_alloc(stru
 	return objp;
 }
 
+/* 
+ * Allocate object from the appropriate node as per mempolicy/cpuset
+ * constraints
+ */
 static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
 						gfp_t flags, void *caller)
 {
 	unsigned long save_flags;
 	void *objp;
-
 	cache_alloc_debugcheck_before(cachep, flags);
-
 	local_irq_save(save_flags);
+
+#ifdef CONFIG_NUMA
+	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
+		objp = alternate_node_alloc(cachep, flags);
+		if (objp != NULL) {
+			local_irq_restore(save_flags);
+			prefetchw(objp);
+			return objp;
+		}
+	}
+#endif
+
 	objp = ____cache_alloc(cachep, flags);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
@@ -3303,9 +3309,10 @@ void *kmem_cache_alloc_node(struct kmem_
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
 
-	if (nodeid == -1 || nodeid == numa_node_id() ||
-			!cachep->nodelists[nodeid])
+	if (nodeid == numa_node_id())
 		ptr = ____cache_alloc(cachep, flags);
+	else if (nodeid == -1 || !cachep->nodelists[nodeid])
+		ptr = __cache_alloc(cachep, flags, __builtin_return_address(0));
 	else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
