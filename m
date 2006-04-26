Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWDZQcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWDZQcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWDZQcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:32:07 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58802 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964812AbWDZQcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:32:05 -0400
Date: Wed, 26 Apr 2006 11:31:51 -0500
From: Dean Nelson <dcn@sgi.com>
To: akpm@osdl.org
Cc: tony.luck@intel.com, avolkov@varma-el.com, jes@sgi.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       paulus@samba.org, holt@sgi.com
Subject: Re: [PATCH] change gen_pool allocator to not touch managed memory
Message-ID: <20060426163151.GA8037@sgi.com>
References: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com> <20060424181626.09966912.akpm@osdl.org> <20060425155051.GA19248@sgi.com> <444F3990.5030100@sgi.com> <20060426132803.GA30360@sgi.com> <444F78AB.6030803@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444F78AB.6030803@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch modifies the gen_pool allocator (lib/genalloc.c) to
utilize a bitmap scheme instead of the buddy scheme. The purpose of this
change is to eliminate the touching of the actual memory being allocated.

Since the change modifies the interface, a change to the uncached
allocator (arch/ia64/kernel/uncached.c) is also required.

Signed-off-by: Dean Nelson <dcn@sgi.com>

---

On Wed, Apr 26, 2006 at 03:42:03PM +0200, Jes Sorensen wrote:
> 
> In this case I think adding the vmalloc call is overkill, I would simply
> make it call kmalloc_node() unconditionally for all sizes and let it
> fail if that situation occurs, given how unlikely it is.

I'm dropping the call to vmalloc_node().

> >>> Index: linux-2.6/arch/ia64/sn/kernel/sn2/cache.c
> 
> I would expect this part of the patch to be able to go in as is,
> straight away so I don't think it should be a problem. It's not a big
> deal whether we do it one way or another to me.

For simplicity, I'm keeping this file's changes with the patch.


Andrew, the following patch replaces my all prior versions of this patch
which were added to the -mm tree with the filename of

        change-gen_pool-allocator-to-not-touch-managed-memory.patch

Thanks,
Dean


 arch/ia64/kernel/uncached.c     |  198 ++++++++++++++-------------
 arch/ia64/sn/kernel/sn2/cache.c |   15 +-
 include/linux/genalloc.h        |   35 ++--
 lib/genalloc.c                  |  263 ++++++++++++++++--------------------
 4 files changed, 251 insertions(+), 260 deletions(-)


Index: linux-2.6/lib/genalloc.c
===================================================================
--- linux-2.6.orig/lib/genalloc.c	2006-04-26 09:13:22.256905048 -0500
+++ linux-2.6/lib/genalloc.c	2006-04-26 09:58:30.491095297 -0500
@@ -4,10 +4,6 @@
  * Uses for this includes on-device special memory, uncached memory
  * etc.
  *
- * This code is based on the buddy allocator found in the sym53c8xx_2
- * driver Copyright (C) 1999-2001  Gerard Roudier <groudier@free.fr>,
- * and adapted for general purpose use.
- *
  * Copyright 2005 (C) Jes Sorensen <jes@trained-monkey.org>
  *
  * This source code is licensed under the GNU General Public License,
@@ -15,172 +11,155 @@
  */
 
 #include <linux/module.h>
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/spinlock.h>
 #include <linux/genalloc.h>
 
-#include <asm/page.h>
-
 
-struct gen_pool *gen_pool_create(int nr_chunks, int max_chunk_shift,
-				 unsigned long (*fp)(struct gen_pool *),
-				 unsigned long data)
+/*
+ * Create a new special memory pool.
+ *
+ * @min_alloc_order: log base 2 of number of bytes each bitmap bit represents
+ * @nid: node id of the node the pool structure should be allocated on, or -1
+ */
+struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
 {
-	struct gen_pool *poolp;
-	unsigned long tmp;
-	int i;
-
-	/*
-	 * This is really an arbitrary limit, +10 is enough for
-	 * IA64_GRANULE_SHIFT, aka 16MB. If anyone needs a large limit
-	 * this can be increased without problems.
-	 */
-	if ((max_chunk_shift > (PAGE_SHIFT + 10)) ||
-	    ((max_chunk_shift < ALLOC_MIN_SHIFT) && max_chunk_shift))
-		return NULL;
-
-	if (!max_chunk_shift)
-		max_chunk_shift = PAGE_SHIFT;
-
-	poolp = kmalloc(sizeof(struct gen_pool), GFP_KERNEL);
-	if (!poolp)
-		return NULL;
-	memset(poolp, 0, sizeof(struct gen_pool));
-	poolp->h = kmalloc(sizeof(struct gen_pool_link) *
-			   (max_chunk_shift - ALLOC_MIN_SHIFT + 1),
-			   GFP_KERNEL);
-	if (!poolp->h) {
-		printk(KERN_WARNING "gen_pool_alloc() failed to allocate\n");
-		kfree(poolp);
-		return NULL;
-	}
-	memset(poolp->h, 0, sizeof(struct gen_pool_link) *
-	       (max_chunk_shift - ALLOC_MIN_SHIFT + 1));
+	struct gen_pool *pool;
 
-	spin_lock_init(&poolp->lock);
-	poolp->get_new_chunk = fp;
-	poolp->max_chunk_shift = max_chunk_shift;
-	poolp->private = data;
-
-	for (i = 0; i < nr_chunks; i++) {
-		tmp = poolp->get_new_chunk(poolp);
-		printk(KERN_INFO "allocated %lx\n", tmp);
-		if (!tmp)
-			break;
-		gen_pool_free(poolp, tmp, (1 << poolp->max_chunk_shift));
+	pool = kmalloc_node(sizeof(struct gen_pool), GFP_KERNEL, nid);
+	if (pool != NULL) {
+		rwlock_init(&pool->lock);
+		INIT_LIST_HEAD(&pool->chunks);
+		pool->min_alloc_order = min_alloc_order;
 	}
-
-	return poolp;
+	return pool;
 }
 EXPORT_SYMBOL(gen_pool_create);
 
 
 /*
- *  Simple power of two buddy-like generic allocator.
- *  Provides naturally aligned memory chunks.
+ * Add a new chunk of memory to the specified pool.
+ *
+ * @pool: pool to add new memory chunk to
+ * @addr: starting address of memory chunk to add to pool
+ * @size: size in bytes of the memory chunk to add to pool
+ * @nid: node id of the node the chunk structure and bitmap should be
+ *       allocated on, or -1
  */
-unsigned long gen_pool_alloc(struct gen_pool *poolp, int size)
+int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
+		 int nid)
 {
-	int j, i, s, max_chunk_size;
-	unsigned long a, flags;
-	struct gen_pool_link *h = poolp->h;
+	struct gen_pool_chunk *chunk;
+	int nbits = size >> pool->min_alloc_order;
+	int nbytes = sizeof(struct gen_pool_chunk) +
+				(nbits + BITS_PER_BYTE - 1) / BITS_PER_BYTE;
+
+	chunk = kmalloc_node(nbytes, GFP_KERNEL, nid);
+	if (unlikely(chunk == NULL))
+		return -1;
+
+	memset(chunk, 0, nbytes);
+	spin_lock_init(&chunk->lock);
+	chunk->start_addr = addr;
+	chunk->end_addr = addr + size;
+
+	write_lock(&pool->lock);
+	list_add(&chunk->next_chunk, &pool->chunks);
+	write_unlock(&pool->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(gen_pool_add);
 
-	max_chunk_size = 1 << poolp->max_chunk_shift;
 
-	if (size > max_chunk_size)
+/*
+ * Allocate the requested number of bytes from the specified pool.
+ * Uses a first-fit algorithm.
+ *
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ */
+unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
+{
+	struct list_head *_chunk;
+	struct gen_pool_chunk *chunk;
+	unsigned long addr, flags;
+	int order = pool->min_alloc_order;
+	int nbits, bit, start_bit, end_bit;
+
+	if (size == 0)
 		return 0;
 
-	size = max(size, 1 << ALLOC_MIN_SHIFT);
-	i = fls(size - 1);
-	s = 1 << i;
-	j = i -= ALLOC_MIN_SHIFT;
-
-	spin_lock_irqsave(&poolp->lock, flags);
-	while (!h[j].next) {
-		if (s == max_chunk_size) {
-			struct gen_pool_link *ptr;
-			spin_unlock_irqrestore(&poolp->lock, flags);
-			ptr = (struct gen_pool_link *)poolp->get_new_chunk(poolp);
-			spin_lock_irqsave(&poolp->lock, flags);
-			h[j].next = ptr;
-			if (h[j].next)
-				h[j].next->next = NULL;
-			break;
-		}
-		j++;
-		s <<= 1;
-	}
-	a = (unsigned long) h[j].next;
-	if (a) {
-		h[j].next = h[j].next->next;
-		/*
-		 * This should be split into a seperate function doing
-		 * the chunk split in order to support custom
-		 * handling memory not physically accessible by host
-		 */
-		while (j > i) {
-			j -= 1;
-			s >>= 1;
-			h[j].next = (struct gen_pool_link *) (a + s);
-			h[j].next->next = NULL;
+	nbits = (size + (1UL << order) - 1) >> order;
+
+	read_lock(&pool->lock);
+	list_for_each(_chunk, &pool->chunks) {
+		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
+
+		end_bit = (chunk->end_addr - chunk->start_addr) >> order;
+		end_bit -= nbits + 1;
+
+		spin_lock_irqsave(&chunk->lock, flags);
+		bit = -1;
+		while (bit + 1 < end_bit) {
+			bit = find_next_zero_bit(chunk->bits, end_bit, bit + 1);
+			if (bit >= end_bit)
+				break;
+
+			start_bit = bit;
+			if (nbits > 1) {
+				bit = find_next_bit(chunk->bits, bit + nbits,
+							bit + 1);
+				if (bit - start_bit < nbits)
+					continue;
+			}
+
+			addr = chunk->start_addr +
+					    ((unsigned long)start_bit << order);
+			while (nbits--)
+				__set_bit(start_bit++, &chunk->bits);
+			spin_unlock_irqrestore(&chunk->lock, flags);
+			read_unlock(&pool->lock);
+			return addr;
 		}
+		spin_unlock_irqrestore(&chunk->lock, flags);
 	}
-	spin_unlock_irqrestore(&poolp->lock, flags);
-	return a;
+	read_unlock(&pool->lock);
+	return 0;
 }
 EXPORT_SYMBOL(gen_pool_alloc);
 
 
 /*
- *  Counter-part of the generic allocator.
+ * Free the specified memory back to the specified pool.
+ *
+ * @pool: pool to free to
+ * @addr: starting address of memory to free back to pool
+ * @size: size in bytes of memory to free
  */
-void gen_pool_free(struct gen_pool *poolp, unsigned long ptr, int size)
+void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
 {
-	struct gen_pool_link *q;
-	struct gen_pool_link *h = poolp->h;
-	unsigned long a, b, flags;
-	int i, s, max_chunk_size;
-
-	max_chunk_size = 1 << poolp->max_chunk_shift;
-
-	if (size > max_chunk_size)
-		return;
-
-	size = max(size, 1 << ALLOC_MIN_SHIFT);
-	i = fls(size - 1);
-	s = 1 << i;
-	i -= ALLOC_MIN_SHIFT;
-
-	a = ptr;
-
-	spin_lock_irqsave(&poolp->lock, flags);
-	while (1) {
-		if (s == max_chunk_size) {
-			((struct gen_pool_link *)a)->next = h[i].next;
-			h[i].next = (struct gen_pool_link *)a;
-			break;
-		}
-		b = a ^ s;
-		q = &h[i];
-
-		while (q->next && q->next != (struct gen_pool_link *)b)
-			q = q->next;
-
-		if (!q->next) {
-			((struct gen_pool_link *)a)->next = h[i].next;
-			h[i].next = (struct gen_pool_link *)a;
+	struct list_head *_chunk;
+	struct gen_pool_chunk *chunk;
+	unsigned long flags;
+	int order = pool->min_alloc_order;
+	int bit, nbits;
+
+	nbits = (size + (1UL << order) - 1) >> order;
+
+	read_lock(&pool->lock);
+	list_for_each(_chunk, &pool->chunks) {
+		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
+
+		if (addr >= chunk->start_addr && addr < chunk->end_addr) {
+			BUG_ON(addr + size > chunk->end_addr);
+			spin_lock_irqsave(&chunk->lock, flags);
+			bit = (addr - chunk->start_addr) >> order;
+			while (nbits--)
+				__clear_bit(bit++, &chunk->bits);
+			spin_unlock_irqrestore(&chunk->lock, flags);
 			break;
 		}
-		q->next = q->next->next;
-		a = a & b;
-		s <<= 1;
-		i++;
 	}
-	spin_unlock_irqrestore(&poolp->lock, flags);
+	BUG_ON(nbits > 0);
+	read_unlock(&pool->lock);
 }
 EXPORT_SYMBOL(gen_pool_free);
Index: linux-2.6/include/linux/genalloc.h
===================================================================
--- linux-2.6.orig/include/linux/genalloc.h	2006-04-26 09:13:22.256905048 -0500
+++ linux-2.6/include/linux/genalloc.h	2006-04-26 09:13:24.632674518 -0500
@@ -4,37 +4,32 @@
  * Uses for this includes on-device special memory, uncached memory
  * etc.
  *
- * This code is based on the buddy allocator found in the sym53c8xx_2
- * driver, adapted for general purpose use.
- *
  * This source code is licensed under the GNU General Public License,
  * Version 2.  See the file COPYING for more details.
  */
 
-#include <linux/spinlock.h>
 
-#define ALLOC_MIN_SHIFT		5 /* 32 bytes minimum */
 /*
- *  Link between free memory chunks of a given size.
+ *  General purpose special memory pool descriptor.
  */
-struct gen_pool_link {
-	struct gen_pool_link *next;
+struct gen_pool {
+	rwlock_t lock;
+	struct list_head chunks;	/* list of chunks in this pool */
+	int min_alloc_order;		/* minimum allocation order */
 };
 
 /*
- *  Memory pool descriptor.
+ *  General purpose special memory pool chunk descriptor.
  */
-struct gen_pool {
+struct gen_pool_chunk {
 	spinlock_t lock;
-	unsigned long (*get_new_chunk)(struct gen_pool *);
-	struct gen_pool *next;
-	struct gen_pool_link *h;
-	unsigned long private;
-	int max_chunk_shift;
+	struct list_head next_chunk;	/* next chunk in pool */
+	unsigned long start_addr;	/* starting address of memory chunk */
+	unsigned long end_addr;		/* ending address of memory chunk */
+	unsigned long bits[0];		/* bitmap for allocating memory chunk */
 };
 
-unsigned long gen_pool_alloc(struct gen_pool *poolp, int size);
-void gen_pool_free(struct gen_pool *mp, unsigned long ptr, int size);
-struct gen_pool *gen_pool_create(int nr_chunks, int max_chunk_shift,
-				 unsigned long (*fp)(struct gen_pool *),
-				 unsigned long data);
+extern struct gen_pool *gen_pool_create(int, int);
+extern int gen_pool_add(struct gen_pool *, unsigned long, size_t, int);
+extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
+extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
Index: linux-2.6/arch/ia64/kernel/uncached.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/uncached.c	2006-04-26 09:13:22.260904660 -0500
+++ linux-2.6/arch/ia64/kernel/uncached.c	2006-04-26 11:05:15.431021964 -0500
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2001-2005 Silicon Graphics, Inc.  All rights reserved.
+ * Copyright (C) 2001-2006 Silicon Graphics, Inc.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -29,15 +29,8 @@
 #include <asm/tlbflush.h>
 #include <asm/sn/arch.h>
 
-#define DEBUG	0
 
-#if DEBUG
-#define dprintk			printk
-#else
-#define dprintk(x...)		do { } while (0)
-#endif
-
-void __init efi_memmap_walk_uc (efi_freemem_callback_t callback);
+extern void __init efi_memmap_walk_uc(efi_freemem_callback_t, void *);
 
 #define MAX_UNCACHED_GRANULES	5
 static int allocated_granules;
@@ -60,6 +53,7 @@
 static void uncached_ipi_mc_drain(void *data)
 {
 	int status;
+
 	status = ia64_pal_mc_drain();
 	if (status)
 		printk(KERN_WARNING "ia64_pal_mc_drain() failed with %i on "
@@ -67,30 +61,35 @@
 }
 
 
-static unsigned long
-uncached_get_new_chunk(struct gen_pool *poolp)
+/*
+ * Add a new chunk of uncached memory pages to the specified pool.
+ *
+ * @pool: pool to add new chunk of uncached memory to
+ * @nid: node id of node to allocate memory from, or -1
+ *
+ * This is accomplished by first allocating a granule of cached memory pages
+ * and then converting them to uncached memory pages.
+ */
+static int uncached_add_chunk(struct gen_pool *pool, int nid)
 {
 	struct page *page;
-	void *tmp;
 	int status, i;
-	unsigned long addr, node;
+	unsigned long c_addr, uc_addr;
 
 	if (allocated_granules >= MAX_UNCACHED_GRANULES)
-		return 0;
+		return -1;
+
+	/* attempt to allocate a granule's worth of cached memory pages */
 
-	node = poolp->private;
-	page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO,
+	page = alloc_pages_node(nid, GFP_KERNEL | __GFP_ZERO,
 				IA64_GRANULE_SHIFT-PAGE_SHIFT);
+	if (!page)
+		return -1;
 
-	dprintk(KERN_INFO "get_new_chunk page %p, addr %lx\n",
-		page, (unsigned long)(page-vmem_map) << PAGE_SHIFT);
+	/* convert the memory pages from cached to uncached */
 
-	/*
-	 * Do magic if no mem on local node! XXX
-	 */
-	if (!page)
-		return 0;
-	tmp = page_address(page);
+	c_addr = (unsigned long)page_address(page);
+	uc_addr = c_addr - PAGE_OFFSET + __IA64_UNCACHED_OFFSET;
 
 	/*
 	 * There's a small race here where it's possible for someone to
@@ -100,76 +99,90 @@
 	for (i = 0; i < (IA64_GRANULE_SIZE / PAGE_SIZE); i++)
 		SetPageUncached(&page[i]);
 
-	flush_tlb_kernel_range(tmp, tmp + IA64_GRANULE_SIZE);
+	flush_tlb_kernel_range(uc_addr, uc_adddr + IA64_GRANULE_SIZE);
 
 	status = ia64_pal_prefetch_visibility(PAL_VISIBILITY_PHYSICAL);
-
-	dprintk(KERN_INFO "pal_prefetch_visibility() returns %i on cpu %i\n",
-		status, raw_smp_processor_id());
-
 	if (!status) {
 		status = smp_call_function(uncached_ipi_visibility, NULL, 0, 1);
 		if (status)
-			printk(KERN_WARNING "smp_call_function failed for "
-			       "uncached_ipi_visibility! (%i)\n", status);
+			goto failed;
 	}
 
+	preempt_disable();
+
 	if (ia64_platform_is("sn2"))
-		sn_flush_all_caches((unsigned long)tmp, IA64_GRANULE_SIZE);
+		sn_flush_all_caches(uc_addr, IA64_GRANULE_SIZE);
 	else
-		flush_icache_range((unsigned long)tmp,
-				   (unsigned long)tmp+IA64_GRANULE_SIZE);
+		flush_icache_range(uc_addr, uc_addr + IA64_GRANULE_SIZE);
+
+	/* flush the just introduced uncached translation from the TLB */
+	local_flush_tlb_all();
+
+	preempt_enable();
 
 	ia64_pal_mc_drain();
 	status = smp_call_function(uncached_ipi_mc_drain, NULL, 0, 1);
 	if (status)
-		printk(KERN_WARNING "smp_call_function failed for "
-		       "uncached_ipi_mc_drain! (%i)\n", status);
+		goto failed;
 
-	addr = (unsigned long)tmp - PAGE_OFFSET + __IA64_UNCACHED_OFFSET;
+	/*
+	 * The chunk of memory pages has been converted to uncached so now we
+	 * can add it to the pool.
+	 */
+	status = gen_pool_add(pool, uc_addr, IA64_GRANULE_SIZE, nid);
+	if (status)
+		goto failed;
 
 	allocated_granules++;
-	return addr;
+	return 0;
+
+	/* failed to convert or add the chunk so give it back to the kernel */
+failed:
+	for (i = 0; i < (IA64_GRANULE_SIZE / PAGE_SIZE); i++)
+		ClearPageUncached(&page[i]);
+
+	free_pages(c_addr, IA64_GRANULE_SHIFT-PAGE_SHIFT);
+	return -1;
 }
 
 
 /*
  * uncached_alloc_page
  *
+ * @starting_nid: node id of node to start with, or -1
+ *
  * Allocate 1 uncached page. Allocates on the requested node. If no
  * uncached pages are available on the requested node, roundrobin starting
- * with higher nodes.
+ * with the next higher node.
  */
-unsigned long
-uncached_alloc_page(int nid)
+unsigned long uncached_alloc_page(int starting_nid)
 {
-	unsigned long maddr;
+	unsigned long uc_addr;
+	struct gen_pool *pool;
+	int nid;
 
-	maddr = gen_pool_alloc(uncached_pool[nid], PAGE_SIZE);
+	if (unlikely(starting_nid >= MAX_NUMNODES))
+		return 0;
 
-	dprintk(KERN_DEBUG "uncached_alloc_page returns %lx on node %i\n",
-		maddr, nid);
+	if (starting_nid < 0)
+		starting_nid = numa_node_id();
+	nid = starting_nid;
 
-	/*
-	 * If no memory is availble on our local node, try the
-	 * remaining nodes in the system.
-	 */
-	if (!maddr) {
-		int i;
+	do {
+		if (!node_online(nid))
+			continue;
+		pool = uncached_pool[nid];
+		if (pool == NULL)
+			continue;
+		do {
+			uc_addr = gen_pool_alloc(pool, PAGE_SIZE);
+			if (uc_addr != 0)
+				return uc_addr;
+		} while (uncached_add_chunk(pool, nid) == 0);
 
-		for (i = MAX_NUMNODES - 1; i >= 0; i--) {
-			if (i == nid || !node_online(i))
-				continue;
-			maddr = gen_pool_alloc(uncached_pool[i], PAGE_SIZE);
-			dprintk(KERN_DEBUG "uncached_alloc_page alternate search "
-				"returns %lx on node %i\n", maddr, i);
-			if (maddr) {
-				break;
-			}
-		}
-	}
+	} while ((nid = (nid + 1) % MAX_NUMNODES) != starting_nid);
 
-	return maddr;
+	return 0;
 }
 EXPORT_SYMBOL(uncached_alloc_page);
 
@@ -177,21 +190,22 @@
 /*
  * uncached_free_page
  *
+ * @uc_addr: uncached address of page to free
+ *
  * Free a single uncached page.
  */
-void
-uncached_free_page(unsigned long maddr)
+void uncached_free_page(unsigned long uc_addr)
 {
-	int node;
-
-	node = paddr_to_nid(maddr - __IA64_UNCACHED_OFFSET);
+	int nid = paddr_to_nid(uc_addr - __IA64_UNCACHED_OFFSET);
+	struct gen_pool *pool = uncached_pool[nid];
 
-	dprintk(KERN_DEBUG "uncached_free_page(%lx) on node %i\n", maddr, node);
+	if (unlikely(pool == NULL))
+		return;
 
-	if ((maddr & (0XFUL << 60)) != __IA64_UNCACHED_OFFSET)
-		panic("uncached_free_page invalid address %lx\n", maddr);
+	if ((uc_addr & (0XFUL << 60)) != __IA64_UNCACHED_OFFSET)
+		panic("uncached_free_page invalid address %lx\n", uc_addr);
 
-	gen_pool_free(uncached_pool[node], maddr, PAGE_SIZE);
+	gen_pool_free(pool, uc_addr, PAGE_SIZE);
 }
 EXPORT_SYMBOL(uncached_free_page);
 
@@ -199,43 +213,39 @@
 /*
  * uncached_build_memmap,
  *
+ * @uc_start: uncached starting address of a chunk of uncached memory
+ * @uc_end: uncached ending address of a chunk of uncached memory
+ * @arg: ignored, (NULL argument passed in on call to efi_memmap_walk_uc())
+ *
  * Called at boot time to build a map of pages that can be used for
  * memory special operations.
  */
-static int __init
-uncached_build_memmap(unsigned long start, unsigned long end, void *arg)
+static int __init uncached_build_memmap(unsigned long uc_start,
+					unsigned long uc_end, void *arg)
 {
-	long length = end - start;
-	int node;
-
-	dprintk(KERN_ERR "uncached_build_memmap(%lx %lx)\n", start, end);
+	int nid = paddr_to_nid(uc_start - __IA64_UNCACHED_OFFSET);
+	struct gen_pool *pool = uncached_pool[nid];
+	size_t size = uc_end - uc_start;
 
 	touch_softlockup_watchdog();
-	memset((char *)start, 0, length);
 
-	node = paddr_to_nid(start - __IA64_UNCACHED_OFFSET);
-
-	for (; start < end ; start += PAGE_SIZE) {
-		dprintk(KERN_INFO "sticking %lx into the pool!\n", start);
-		gen_pool_free(uncached_pool[node], start, PAGE_SIZE);
+	if (pool != NULL) {
+		memset((char *)uc_start, 0, size);
+		(void) gen_pool_add(pool, uc_start, size, nid);
 	}
-
 	return 0;
 }
 
 
-static int __init uncached_init(void) {
-	int i;
+static int __init uncached_init(void)
+{
+	int nid;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (!node_online(i))
-			continue;
-		uncached_pool[i] = gen_pool_create(0, IA64_GRANULE_SHIFT,
-						   &uncached_get_new_chunk, i);
+	for_each_online_node(nid) {
+		uncached_pool[nid] = gen_pool_create(PAGE_SHIFT, nid);
 	}
 
-	efi_memmap_walk_uc(uncached_build_memmap);
-
+	efi_memmap_walk_uc(uncached_build_memmap, NULL);
 	return 0;
 }
 
Index: linux-2.6/arch/ia64/sn/kernel/sn2/cache.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/sn2/cache.c	2006-04-26 09:13:22.260904660 -0500
+++ linux-2.6/arch/ia64/sn/kernel/sn2/cache.c	2006-04-26 09:13:24.644673353 -0500
@@ -3,11 +3,12 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  * 
- * Copyright (C) 2001-2003 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2001-2003, 2006 Silicon Graphics, Inc. All rights reserved.
  *
  */
 #include <linux/module.h>
 #include <asm/pgalloc.h>
+#include <asm/sn/arch.h>
 
 /**
  * sn_flush_all_caches - flush a range of address from all caches (incl. L4)
@@ -17,18 +18,24 @@
  * Flush a range of addresses from all caches including L4. 
  * All addresses fully or partially contained within 
  * @flush_addr to @flush_addr + @bytes are flushed
- * from the all caches.
+ * from all caches.
  */
 void
 sn_flush_all_caches(long flush_addr, long bytes)
 {
-	flush_icache_range(flush_addr, flush_addr+bytes);
+	unsigned long addr = flush_addr;
+
+	/* SHub1 requires a cached address */
+	if (is_shub1() && (addr & RGN_BITS) == RGN_BASE(RGN_UNCACHED))
+		addr = (addr - RGN_BASE(RGN_UNCACHED)) + RGN_BASE(RGN_KERNEL);
+
+	flush_icache_range(addr, addr + bytes);
 	/*
 	 * The last call may have returned before the caches
 	 * were actually flushed, so we call it again to make
 	 * sure.
 	 */
-	flush_icache_range(flush_addr, flush_addr+bytes);
+	flush_icache_range(addr, addr + bytes);
 	mb();
 }
 EXPORT_SYMBOL(sn_flush_all_caches);
