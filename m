Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUGNUZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUGNUZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUGNUZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:25:47 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:6499 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263062AbUGNUZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:25:36 -0400
Date: Wed, 14 Jul 2004 21:25:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmaplock 2/6 SLAB_DESTROY_BY_RCU
In-Reply-To: <40F447B8.5080208@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0407142048290.2132-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004, Manfred Spraul wrote:
> Hugh Dickins wrote:
> >I wonder if you're seeing some other use than I intended.
> >
> No, I just tried to reworden your idea and I obviously failed.
> Previously, I always assumed that the free call had to be delayed, but 
> you have shown that this is wrong: If a rcu user can detect that an 
> object changed its identity (or if he doesn't care), then it's not 
> necessary to delay the free call, it's sufficient to delay the object 
> destruction. And since the slab cache is an object cache delaying 
> destruction causes virtually no overhead at all.

Actually, I now see it is a different use that you're seeing.  You're
thinking of how a subsystem which uses RCU might manage its kmem_cache,
that SLAB_DESTROY_BY_RCU might allow it to free directly where before
it had to leave freeing to RCU callback.  Yes, it could be used that
way, though I don't know if that's particularly useful - if the
subsystem uses RCU anyway, isn't it easy to let RCU do the freeing?

My reason for adding the flag is different: for a subsystem which is
almost entirely ignorant of RCU, which has good and simple locking for
its structures from one direction, but sometimes needs to approach
them from another direction, where it's hard to get the lock safely:
once it holds the spinlock within the structure, it's stabilized; but
at any instant prior to getting that spinlock, the structure containing
it might be freed.  SLAB_DESTROY_BY_RCU on the cache, with rcu_read_lock
while trying to get to that spinlock, can solve this.

> A second restriction is that it must be possible to recover from 
> identity changes. I think this rules out the dentry cache - the hash 
> chains point to wrong positions after a free/alloc/reuse cycle, it's not 
> possible to recover from that.

Yes, I don't think SLAB_DESTROY_BY_RCU should be splashed around all over.
Another reason, it slightly delays the freeing of pages from its caches,
so is probably not appropriate for those major caches which vmscan needs
to be able to shrink (and know how much it has shrunk).

> This would introduce a concept of a half destroyed object. I think it's 
> a bad idea, too easy to introduce bugs.

Fair enough.

> The correct fix would be to move the whole slab_destroy call into the 
> rcu callback instead of just the kmem_cache_free call, but locking would 
> be tricky

Yes, I didn't want or need to get into that.  Keep it simple for now.

> - kmem_cache_destroy would have to wait for completion of 
> outstanding rcu calls, etc.

I think it already needs that wait if SLAB_DESTROY_BY_RCU (unless we
change kmem_freepages to take several args, such as order, instead of
peeking at cachep->gfporder).  I didn't worry about that before, since
I didn't need to use kmem_cache_destroy: but I can see you prefer to
guard your territory properly, so I've now added a synchronize_kernel.

> Thus I'd propose a quick fix (fail if there is a dtor - are there any 
> slab caches with dtors at all?) and in the long run slab_destroy should 
> be moved into the rcu callback.

Okay.  My current patch to 2.6.8-rc1-mm1 slab.h and slab.c below.

Thanks a lot for considering this, Manfred.

Hugh

--- 2.6.8-rc1-mm1/include/linux/slab.h	2004-07-14 06:11:52.566031480 +0100
+++ linux/include/linux/slab.h	2004-07-14 19:02:37.217301704 +0100
@@ -45,6 +45,7 @@ typedef struct kmem_cache_s kmem_cache_t
 #define SLAB_RECLAIM_ACCOUNT	0x00020000UL	/* track pages allocated to indicate
 						   what is reclaimable later*/
 #define SLAB_PANIC		0x00040000UL	/* panic if kmem_cache_create() fails */
+#define SLAB_DESTROY_BY_RCU	0x00080000UL	/* defer freeing pages to RCU */
 
 /* flags passed to a constructor func */
 #define	SLAB_CTOR_CONSTRUCTOR	0x001UL		/* if not set, then deconstructor */
--- 2.6.8-rc1-mm1/mm/slab.c	2004-07-14 06:11:52.864986032 +0100
+++ linux/mm/slab.c	2004-07-14 19:02:37.233299272 +0100
@@ -91,6 +91,7 @@
 #include	<linux/cpu.h>
 #include	<linux/sysctl.h>
 #include	<linux/module.h>
+#include	<linux/rcupdate.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -139,11 +140,13 @@
 			 SLAB_POISON | SLAB_HWCACHE_ALIGN | \
 			 SLAB_NO_REAP | SLAB_CACHE_DMA | \
 			 SLAB_MUST_HWCACHE_ALIGN | SLAB_STORE_USER | \
-			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC)
+			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
+			 SLAB_DESTROY_BY_RCU)
 #else
 # define CREATE_MASK	(SLAB_HWCACHE_ALIGN | SLAB_NO_REAP | \
 			 SLAB_CACHE_DMA | SLAB_MUST_HWCACHE_ALIGN | \
-			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC)
+			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
+			 SLAB_DESTROY_BY_RCU)
 #endif
 
 /*
@@ -190,6 +193,28 @@ struct slab {
 };
 
 /*
+ * struct slab_rcu
+ *
+ * slab_destroy on a SLAB_DESTROY_BY_RCU cache uses this structure to
+ * arrange for kmem_freepages to be called via RCU.  This is useful if
+ * we need to approach a kernel structure obliquely, from its address
+ * obtained without the usual locking.  We can lock the structure to
+ * stabilize it and check it's still at the given address, only if we
+ * can be sure that the memory has not been meanwhile reused for some
+ * other kind of object (which our subsystem's lock might corrupt).
+ *
+ * rcu_read_lock before reading the address, then rcu_read_unlock after
+ * taking the spinlock within the structure expected at that address.
+ *
+ * We assume struct slab_rcu can overlay struct slab when destroying.
+ */
+struct slab_rcu {
+	struct rcu_head		head;
+	kmem_cache_t		*cachep;
+	void			*addr;
+};
+
+/*
  * struct array_cache
  *
  * Per cpu structures
@@ -883,6 +908,16 @@ static void kmem_freepages(kmem_cache_t 
 		atomic_sub(1<<cachep->gfporder, &slab_reclaim_pages);
 }
 
+static void kmem_rcu_free(struct rcu_head *head)
+{
+	struct slab_rcu *slab_rcu = (struct slab_rcu *) head;
+	kmem_cache_t *cachep = slab_rcu->cachep;
+
+	kmem_freepages(cachep, slab_rcu->addr);
+	if (OFF_SLAB(cachep))
+		kmem_cache_free(cachep->slabp_cache, slab_rcu);
+}
+
 #if DEBUG
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
@@ -1036,6 +1071,8 @@ static void check_poison_obj(kmem_cache_
  */
 static void slab_destroy (kmem_cache_t *cachep, struct slab *slabp)
 {
+	void *addr = slabp->s_mem - slabp->colouroff;
+
 #if DEBUG
 	int i;
 	for (i = 0; i < cachep->num; i++) {
@@ -1071,10 +1108,19 @@ static void slab_destroy (kmem_cache_t *
 		}
 	}
 #endif
-	
-	kmem_freepages(cachep, slabp->s_mem-slabp->colouroff);
-	if (OFF_SLAB(cachep))
-		kmem_cache_free(cachep->slabp_cache, slabp);
+
+	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU)) {
+		struct slab_rcu *slab_rcu;
+
+		slab_rcu = (struct slab_rcu *) slabp;
+		slab_rcu->cachep = cachep;
+		slab_rcu->addr = addr;
+		call_rcu(&slab_rcu->head, kmem_rcu_free);
+	} else {
+		kmem_freepages(cachep, addr);
+		if (OFF_SLAB(cachep))
+			kmem_cache_free(cachep->slabp_cache, slabp);
+	}
 }
 
 /**
@@ -1149,9 +1195,15 @@ kmem_cache_create (const char *name, siz
 	 */
 	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
 		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
-	flags |= SLAB_POISON;
+	if (!(flags & SLAB_DESTROY_BY_RCU))
+		flags |= SLAB_POISON;
 #endif
+	if (flags & SLAB_DESTROY_BY_RCU)
+		BUG_ON(flags & SLAB_POISON);
 #endif
+	if (flags & SLAB_DESTROY_BY_RCU)
+		BUG_ON(dtor);
+
 	/*
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
@@ -1563,6 +1615,9 @@ int kmem_cache_destroy (kmem_cache_t * c
 		return 1;
 	}
 
+	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU))
+		synchronize_kernel();
+
 	/* no cpu_online check required here since we clear the percpu
 	 * array on cpu offline and set this to NULL.
 	 */

