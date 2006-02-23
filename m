Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWBWLe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWBWLe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWBWLe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:34:58 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16567 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750907AbWBWLe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:34:57 -0500
Date: Thu, 23 Feb 2006 13:34:21 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: Alok Kataria <alok.kataria@calsoftinc.com>, clameter@engr.sgi.com,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
In-Reply-To: <20060223020957.478d4cc1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
 <20060223020957.478d4cc1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Andrew Morton wrote:
> I'm very much hoping that it is not needed.  Would prefer to just toss the
> whole thing away.
> 
> What's it supposed to do anyway?  Keep wholly-unused pages hanging about in
> each slab cache?  If so, it may well be a net loss - it'd be better to push
> those pages back into the page allocator so they can get reused for
> something else while they're possibly still in-cache.  Similarly, it's
> better to fall back to the page allocator for a new slab page because
> that's more likely to give us a cache-hot one.

We need _something_ to avoid excessive scanning of cache_cache. It takes a 
hell of a lot insmod/rmmod to actually free a full page. Maybe something 
like this (totally untested) patch?

				Pekka

Index: 2.6-git/drivers/scsi/iscsi_tcp.c
===================================================================
--- 2.6-git.orig/drivers/scsi/iscsi_tcp.c
+++ 2.6-git/drivers/scsi/iscsi_tcp.c
@@ -3639,7 +3639,7 @@ iscsi_tcp_init(void)
 
 	taskcache = kmem_cache_create("iscsi_taskcache",
 			sizeof(struct iscsi_data_task), 0,
-			SLAB_HWCACHE_ALIGN | SLAB_NO_REAP, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!taskcache)
 		return -ENOMEM;
 
Index: 2.6-git/fs/ocfs2/super.c
===================================================================
--- 2.6-git.orig/fs/ocfs2/super.c
+++ 2.6-git/fs/ocfs2/super.c
@@ -959,7 +959,7 @@ static int ocfs2_initialize_mem_caches(v
 	ocfs2_lock_cache = kmem_cache_create("ocfs2_lock",
 					     sizeof(struct ocfs2_journal_lock),
 					     0,
-					     SLAB_NO_REAP|SLAB_HWCACHE_ALIGN,
+					     SLAB_HWCACHE_ALIGN,
 					     NULL, NULL);
 	if (!ocfs2_lock_cache)
 		return -ENOMEM;
Index: 2.6-git/include/linux/slab.h
===================================================================
--- 2.6-git.orig/include/linux/slab.h
+++ 2.6-git/include/linux/slab.h
@@ -38,7 +38,6 @@ typedef struct kmem_cache kmem_cache_t;
 #define	SLAB_DEBUG_INITIAL	0x00000200UL	/* Call constructor (as verifier) */
 #define	SLAB_RED_ZONE		0x00000400UL	/* Red zone objs in a cache */
 #define	SLAB_POISON		0x00000800UL	/* Poison objects */
-#define	SLAB_NO_REAP		0x00001000UL	/* never reap from the cache */
 #define	SLAB_HWCACHE_ALIGN	0x00002000UL	/* align objs on a h/w cache lines */
 #define SLAB_CACHE_DMA		0x00004000UL	/* use GFP_DMA memory */
 #define SLAB_MUST_HWCACHE_ALIGN	0x00008000UL	/* force alignment */
Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -170,12 +170,12 @@
 #if DEBUG
 # define CREATE_MASK	(SLAB_DEBUG_INITIAL | SLAB_RED_ZONE | \
 			 SLAB_POISON | SLAB_HWCACHE_ALIGN | \
-			 SLAB_NO_REAP | SLAB_CACHE_DMA | \
+			 SLAB_CACHE_DMA | \
 			 SLAB_MUST_HWCACHE_ALIGN | SLAB_STORE_USER | \
 			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
 			 SLAB_DESTROY_BY_RCU)
 #else
-# define CREATE_MASK	(SLAB_HWCACHE_ALIGN | SLAB_NO_REAP | \
+# define CREATE_MASK	(SLAB_HWCACHE_ALIGN | \
 			 SLAB_CACHE_DMA | SLAB_MUST_HWCACHE_ALIGN | \
 			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
 			 SLAB_DESTROY_BY_RCU)
@@ -642,7 +642,6 @@ static struct kmem_cache cache_cache = {
 	.limit = BOOT_CPUCACHE_ENTRIES,
 	.shared = 1,
 	.buffer_size = sizeof(struct kmem_cache),
-	.flags = SLAB_NO_REAP,
 	.spinlock = SPIN_LOCK_UNLOCKED,
 	.name = "kmem_cache",
 #if DEBUG
@@ -1689,9 +1688,6 @@ static inline size_t calculate_slab_orde
  * %SLAB_RED_ZONE - Insert `Red' zones around the allocated memory to check
  * for buffer overruns.
  *
- * %SLAB_NO_REAP - Don't automatically reap this cache when we're under
- * memory pressure.
- *
  * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
  * cacheline.  This can be beneficial if you're counting cycles as closely
  * as davem.
@@ -3487,8 +3483,7 @@ static void cache_reap(void *unused)
 		struct slab *slabp;
 
 		searchp = list_entry(walk, struct kmem_cache, next);
-
-		if (searchp->flags & SLAB_NO_REAP)
+		if (searchp == &cache_cache)
 			goto next;
 
 		check_irq_on();
