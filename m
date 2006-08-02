Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWHBTI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWHBTI5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHBTI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:08:57 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:20667 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S932168AbWHBTI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:08:56 -0400
Date: Wed, 2 Aug 2006 12:10:29 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, alokk@calsoftinc.com
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
Message-ID: <20060802191029.GA4958@localhost.localdomain>
References: <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com> <1154117501.10196.2.camel@localhost.localdomain> <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com> <1154118476.10196.5.camel@localhost.localdomain> <1154118947.10196.10.camel@localhost.localdomain> <Pine.LNX.4.64.0607281332190.20754@schroedinger.engr.sgi.com> <1154119658.10196.17.camel@localhost.localdomain> <Pine.LNX.4.64.0607281344410.20754@schroedinger.engr.sgi.com> <20060728211227.GB3739@localhost.localdomain> <1154121608.10196.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154121608.10196.24.camel@localhost.localdomain>
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

On Fri, Jul 28, 2006 at 11:20:08PM +0200, Thomas Gleixner wrote:
> On Fri, 2006-07-28 at 14:12 -0700, Ravikiran G Thirumalai wrote:
> > On Fri, Jul 28, 2006 at 01:48:33PM -0700, Christoph Lameter wrote:
> > > On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> > > 
> > > ...
> > > One cpu with two nodes?
> > > 
> > > > [    0.000000] Bootmem setup node 0 0000000000000000-0000000080000000
> > > > [    0.000000] Bootmem setup node 1 0000000080000000-00000000fbff0000
> > > 
> > > Right two nodes. We may have a special case here of one cpu having to 
> > > manage remote memory. Alien cache freeing is likely screwed up in that 
> > > case because we cannot have the idea of one processor local to the node 
> > > doing the alien cache draining . We have to take the remote lock (no cpu 
> > > dedicate to that node).
> > 
> > Why should there be any problem taking the remote l3 lock?  If the remote
> > node does not have cpu that does not mean we cannot take a lock from the
> > local node!!! 
> > 
> > I think current git does not teach lockdep to ignore recursion for
> > array_cache->lock when the array_cache->lock are from different cases.  As
> > Arjan pointed out, I can see that l3->list_lock is special cased, but I
> > cannot find where array_cache->lock is taken care of.
> > 
> > Again, if this is indeed a problem (recursion) machine should not boot even,
> > when compiled without lockdep, tglx, can you please verify this?
> 
> It boots witjh lockdep disabled, so lockdep needs some education, which
> is not that easy in this case.
> 

Here's an attempt to educate lockdep about alien cache lock. tglx, can you
confirm if this fixes the false positive?  This is just an extension of the
l3 lock lesson :).

Note: With this approach, lockdep forgets its education for alien caches
if all cpus of a node go down and come back up.  But taking care of 
that scenario will make things uglier....not sure if it is worth it.

Thanks,
Kiran


Place the alien array cache locks of on slab malloc slab caches on a seperate 
lockdep class.  This avoids false positives from lockdep

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.18-rc3-x460/mm/slab.c
===================================================================
--- linux-2.6.18-rc3-x460.orig/mm/slab.c	2006-07-30 21:27:28.000000000 -0700
+++ linux-2.6.18-rc3-x460/mm/slab.c	2006-08-01 18:01:51.000000000 -0700
@@ -682,23 +682,43 @@
  * The locking for this is tricky in that it nests within the locks
  * of all other slabs in a few places; to deal with this special
  * locking we put on-slab caches into a separate lock-class.
+ *
+ * We set lock class for alien array caches which are up during init.
+ * The lock annotation will be lost if all cpus of a node goes down and 
+ * then comes back up during hotplug
  */
-static struct lock_class_key on_slab_key;
+static struct lock_class_key on_slab_l3_key;
+static struct lock_class_key on_slab_alc_key;
+
+static inline void init_lock_keys(void)
 
-static inline void init_lock_keys(struct cache_sizes *s)
 {
 	int q;
+	struct cache_sizes *s = malloc_sizes;
 
-	for (q = 0; q < MAX_NUMNODES; q++) {
-		if (!s->cs_cachep->nodelists[q] || OFF_SLAB(s->cs_cachep))
-			continue;
-		lockdep_set_class(&s->cs_cachep->nodelists[q]->list_lock,
-				  &on_slab_key);
+	while (s->cs_size != ULONG_MAX) {
+		for_each_node(q) {
+			struct array_cache **alc;
+			int r;
+			struct kmem_list3 *l3 = s->cs_cachep->nodelists[q];
+			if (!l3 || OFF_SLAB(s->cs_cachep))
+				continue;
+			lockdep_set_class(&l3->list_lock, &on_slab_l3_key);
+			alc = l3->alien;
+			if (!alc)
+				continue;
+			for_each_node(r) {
+				if (alc[r])
+					lockdep_set_class(&alc[r]->lock,
+					     &on_slab_alc_key);
+			}
+		}
+		s++;
 	}
 }
 
 #else
-static inline void init_lock_keys(struct cache_sizes *s)
+static inline void init_lock_keys()
 {
 }
 #endif
@@ -1422,7 +1442,6 @@
 					ARCH_KMALLOC_FLAGS|SLAB_PANIC,
 					NULL, NULL);
 		}
-		init_lock_keys(sizes);
 
 		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
 					sizes->cs_size,
@@ -1495,6 +1514,10 @@
 		mutex_unlock(&cache_chain_mutex);
 	}
 
+	/* Annotate slab for lockdep -- annotate the malloc caches */
+	init_lock_keys();
+	
+
 	/* Done! */
 	g_cpucache_up = FULL;
 
