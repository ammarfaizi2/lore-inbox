Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWBVWfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWBVWfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWBVWfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:35:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34281 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751551AbWBVWfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:35:10 -0500
Date: Wed, 22 Feb 2006 14:34:48 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: alokk@calsoftinc.com, manfred@colorfullife.com,
       Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org
Subject: slab: Remove SLAB_NO_REAP option
Message-ID: <Pine.LNX.4.64.0602221428510.30219@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SLAB_NO_REAP is documented as an option that will cause this slab
not to be reaped under memory pressure. However, that is not what
happens. The only thing that SLAB_NO_REAP controls at the moment
is the reclaim of the unused slab elements that were allocated in
batch in cache_reap(). Cache_reap() is run every few seconds
independently of memory pressure.

Could we remove the whole thing? Its only used by three slabs 
anyways and I cannot find a reason for having this option.

There is an additional problem with SLAB_NO_REAP. If set then
the recovery of objects from alien caches is switched off.
Objects not freed on the same node where they were initially
allocated will only be reused if a certain amount of objects 
accumulates from one alien node (not very likely) or if the cache is 
explicitly shrunk. (Strangely __cache_shrink does not check for 
SLAB_NO_REAP)

Getting rid of SLAB_NO_REAP fixes the problems with alien cache
freeing.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc4/mm/slab.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/slab.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/mm/slab.c	2006-02-22 14:06:23.000000000 -0800
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
@@ -642,7 +642,7 @@ static struct kmem_cache cache_cache = {
 	.limit = BOOT_CPUCACHE_ENTRIES,
 	.shared = 1,
 	.buffer_size = sizeof(struct kmem_cache),
-	.flags = SLAB_NO_REAP,
+	.flags = 0,
 	.spinlock = SPIN_LOCK_UNLOCKED,
 	.name = "kmem_cache",
 #if DEBUG
@@ -1689,9 +1689,6 @@ static inline size_t calculate_slab_orde
  * %SLAB_RED_ZONE - Insert `Red' zones around the allocated memory to check
  * for buffer overruns.
  *
- * %SLAB_NO_REAP - Don't automatically reap this cache when we're under
- * memory pressure.
- *
  * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
  * cacheline.  This can be beneficial if you're counting cycles as closely
  * as davem.
@@ -3487,10 +3484,6 @@ static void cache_reap(void *unused)
 		struct slab *slabp;
 
 		searchp = list_entry(walk, struct kmem_cache, next);
-
-		if (searchp->flags & SLAB_NO_REAP)
-			goto next;
-
 		check_irq_on();
 
 		l3 = searchp->nodelists[numa_node_id()];
Index: linux-2.6.16-rc4/include/linux/slab.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/slab.h	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/include/linux/slab.h	2006-02-22 14:05:25.000000000 -0800
@@ -38,7 +38,6 @@ typedef struct kmem_cache kmem_cache_t;
 #define	SLAB_DEBUG_INITIAL	0x00000200UL	/* Call constructor (as verifier) */
 #define	SLAB_RED_ZONE		0x00000400UL	/* Red zone objs in a cache */
 #define	SLAB_POISON		0x00000800UL	/* Poison objects */
-#define	SLAB_NO_REAP		0x00001000UL	/* never reap from the cache */
 #define	SLAB_HWCACHE_ALIGN	0x00002000UL	/* align objs on a h/w cache lines */
 #define SLAB_CACHE_DMA		0x00004000UL	/* use GFP_DMA memory */
 #define SLAB_MUST_HWCACHE_ALIGN	0x00008000UL	/* force alignment */
Index: linux-2.6.16-rc4/drivers/scsi/iscsi_tcp.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/scsi/iscsi_tcp.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/drivers/scsi/iscsi_tcp.c	2006-02-22 14:08:46.000000000 -0800
@@ -3639,7 +3639,7 @@ iscsi_tcp_init(void)
 
 	taskcache = kmem_cache_create("iscsi_taskcache",
 			sizeof(struct iscsi_data_task), 0,
-			SLAB_HWCACHE_ALIGN | SLAB_NO_REAP, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!taskcache)
 		return -ENOMEM;
 
Index: linux-2.6.16-rc4/fs/ocfs2/super.c
===================================================================
--- linux-2.6.16-rc4.orig/fs/ocfs2/super.c	2006-02-17 14:23:45.000000000 -0800
+++ linux-2.6.16-rc4/fs/ocfs2/super.c	2006-02-22 14:08:17.000000000 -0800
@@ -959,7 +959,7 @@ static int ocfs2_initialize_mem_caches(v
 	ocfs2_lock_cache = kmem_cache_create("ocfs2_lock",
 					     sizeof(struct ocfs2_journal_lock),
 					     0,
-					     SLAB_NO_REAP|SLAB_HWCACHE_ALIGN,
+					     SLAB_HWCACHE_ALIGN,
 					     NULL, NULL);
 	if (!ocfs2_lock_cache)
 		return -ENOMEM;
