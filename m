Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161441AbWG2EYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbWG2EYy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 00:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbWG2EYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 00:24:54 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:40356 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1751381AbWG2EYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 00:24:54 -0400
Date: Fri, 28 Jul 2006 21:26:32 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, alokk@calsoftinc.com
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
Message-ID: <20060729042632.GA3840@localhost.localdomain>
References: <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com> <1154117501.10196.2.camel@localhost.localdomain> <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com> <1154118476.10196.5.camel@localhost.localdomain> <1154118947.10196.10.camel@localhost.localdomain> <Pine.LNX.4.64.0607281332190.20754@schroedinger.engr.sgi.com> <1154119658.10196.17.camel@localhost.localdomain> <Pine.LNX.4.64.0607281344410.20754@schroedinger.engr.sgi.com> <20060728211227.GB3739@localhost.localdomain> <Pine.LNX.4.64.0607281422370.21238@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607281422370.21238@schroedinger.engr.sgi.com>
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

On Fri, Jul 28, 2006 at 02:26:16PM -0700, Christoph Lameter wrote:
> On Fri, 28 Jul 2006, Ravikiran G Thirumalai wrote:
> 
> > Why should there be any problem taking the remote l3 lock?  If the remote
> > node does not have cpu that does not mean we cannot take a lock from the
> > local node!!! 
> > 
> > I think current git does not teach lockdep to ignore recursion for
> > array_cache->lock when the array_cache->lock are from different cases.  As
> > Arjan pointed out, I can see that l3->list_lock is special cased, but I
> > cannot find where array_cache->lock is taken care of.
> 
> Ok.
>  
> > Again, if this is indeed a problem (recursion) machine should not boot even,
> > when compiled without lockdep, tglx, can you please verify this?
> 
> We seem to be fine on that level.
> 

Since false positives due to off slab slab management seem to occur
often of late, how about adding some comments to slab.c?

Thanks,
Kiran

---

Adds some comments to slab.c.

Also, checks if we get a valid slabp_cache for off slab slab-descriptors.
We should always get this. If we don't, then in that case we,
will have to disable off-slab descriptors for this cache and do the 
calculations again. This is a rare case,  so add a BUG_ON, for now, 
just in case.


Signed-off-by: Alok N Kataria <alok.kataria@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.18-rc2.git/mm/slab.c
===================================================================
--- linux-2.6.18-rc2.git.orig/mm/slab.c	2006-07-28 17:43:04.000000000 -0700
+++ linux-2.6.18-rc2.git/mm/slab.c	2006-07-28 18:13:31.000000000 -0700
@@ -2200,8 +2200,17 @@ kmem_cache_create (const char *name, siz
 		cachep->gfpflags |= GFP_DMA;
 	cachep->buffer_size = size;
 
-	if (flags & CFLGS_OFF_SLAB)
+	if (flags & CFLGS_OFF_SLAB) {
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);
+		/*
+		 * This is a possibility for one of the malloc_sizes caches.
+		 * But since we go off slab only for object size greater than
+		 * PAGE_SIZE/8, and malloc_sizes gets created in ascending order,
+		 * this should not happen at all.
+		 * But leave a BUG_ON for some lucky dude.
+		 */
+		BUG_ON(!cachep->slabp_cache);
+	}
 	cachep->ctor = ctor;
 	cachep->dtor = dtor;
 	cachep->name = name;
@@ -2435,7 +2444,17 @@ int kmem_cache_destroy(struct kmem_cache
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 
-/* Get the memory for a slab management obj. */
+/*
+ * Get the memory for a slab management obj.
+ * For a slab cache when the slab descriptor is off-slab, slab descriptors
+ * always come from malloc_sizes caches.  The slab descriptor cannot 
+ * come from the same cache which is getting created because,
+ * when we are searching for an appropriate cache for these
+ * descriptors in kmem_cache_create, we search through the malloc_sizes array.
+ * If we are creating a malloc_sizes cache here it would not be visible to
+ * kmem_find_general_cachep till the initialization is complete.
+ * Hence we cannot have slabp_cache same as the original cache.
+ */
 static struct slab *alloc_slabmgmt(struct kmem_cache *cachep, void *objp,
 				   int colour_off, gfp_t local_flags,
 				   int nodeid)
@@ -3119,6 +3138,12 @@ static void free_block(struct kmem_cache
 		if (slabp->inuse == 0) {
 			if (l3->free_objects > l3->free_limit) {
 				l3->free_objects -= cachep->num;
+				/* No need to drop any previously held
+				 * lock here, even if we have a off-slab slab
+				 * descriptor it is guaranteed to come from
+				 * a different cache, refer to comments before
+				 * alloc_slabmgmt.
+				 */
 				slab_destroy(cachep, slabp);
 			} else {
 				list_add(&slabp->list, &l3->slabs_free);
