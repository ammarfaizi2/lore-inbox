Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbUKXNtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbUKXNtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbUKXNsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:48:36 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:1686 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262650AbUKXNLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:11:14 -0500
Subject: Suspend 2 merge: 37/51: Memory pool support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101298427.5805.338.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:00:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the memory pool support. It handles all pages freed and
allocated between the preparation of the image and the completion of
resuming, except prior to restoring the original kernel at resume time.
It is designed for speed and to match the fact that suspend2 just about
exclusively uses order 0 allocations. ("Just about" is why a couple of
order one and two allocations are also available).

diff -ruN 827-memory-pool-old/kernel/power/memory_pool.c 827-memory-pool-new/kernel/power/memory_pool.c
--- 827-memory-pool-old/kernel/power/memory_pool.c	1970-01-01 10:00:00.000000000 +1000
+++ 827-memory-pool-new/kernel/power/memory_pool.c	2004-11-16 22:17:29.000000000 +1100
@@ -0,0 +1,378 @@
+/*
+ * kernel/power/memory_pool.c
+ *  
+ * Copyright (C) 2003,2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains routines for managing the memory pool during software suspend
+ * operation.
+ * 
+ * The memory pool is a pool of pages from which page allocations
+ * are satisfied while we are suspending, and into which freed pages are
+ * released. In this way, we can keep the image size static and consistent
+ * while still using normal I/O routines to save the image and while saving
+ * the image in two parts.
+ * 
+ * During suspend, almost all of the page allocations are order zero. Provision
+ * is made for one order one and one order two allocation. This provision is 
+ * utilised by the swapwriter for allocating memory which is used for structures
+ * containing header page. (It could be made to use order zero allocations; this
+ * just hasn't been done yet).
+ */
+
+#define SUSPEND_MEMORY_POOL_C
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+
+#include "suspend.h"
+#include "plugins.h"
+#include "pageflags.h"
+
+/* We keep high memory pages that are freed, but don't use them */
+struct memory_pool {
+	struct list_head contents[MAX_ORDER];
+	int level[MAX_ORDER];
+};
+
+static struct memory_pool normal_pool, highmem_pool;
+
+static int suspend_pool_level_limit[MAX_ORDER];
+static spinlock_t suspend_memory_pool_lock = SPIN_LOCK_UNLOCKED;
+
+static int min_pool_level = 0;
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+/* display_memory_pool_pages()
+ *
+ * Description:	Display the current contents of the memory pool.
+ */	
+static void __display_memory_pool_pages(struct memory_pool * pool)
+{
+	int order;
+
+	for (order = 0; order < MAX_ORDER; order++) {
+		struct page * page;
+		int index = 0;
+		suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1,
+				"- Order %d:\n", order);
+		list_for_each_entry(page, &pool->contents[order], lru) {
+			suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1,
+					"[%p] ", page);
+			index++;
+			if (!(index%8))
+				suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1,
+					"\n");
+		}
+
+		if (pool->level[order])
+			suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1,
+					"(%d entries)\n", pool->level[order]);
+		else
+			suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1,
+					"(empty)\n");
+	}
+}
+
+void display_memory_pool_pages(void)
+{
+	if (!TEST_DEBUG_STATE(SUSPEND_MEM_POOL))
+		return;
+
+	suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1, "Memory pool:\n");
+	suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1, "Normal pages:\n");
+	__display_memory_pool_pages(&normal_pool);
+	suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1, "High pages:\n");
+	__display_memory_pool_pages(&highmem_pool);
+}
+#else
+#define display_memory_pool_pages() do { } while(0)
+#endif
+
+__init void initialise_pool(struct memory_pool * pool)
+{
+	int i;
+
+	for (i = 0; i < MAX_ORDER; i++) {
+		pool->level[i] = 0;
+		INIT_LIST_HEAD(&pool->contents[i]);
+	}
+
+	suspend_pool_level_limit[1] = 1;
+	suspend_pool_level_limit[2] = 1;
+}
+
+__init void suspend_memory_pool_init(void)
+{
+	/* Initialise lists */
+	initialise_pool(&normal_pool);
+	initialise_pool(&highmem_pool);
+}
+
+/* get_from_pool()
+ *
+ * Description: Remove head of a pool list
+ */
+
+static struct page * get_from_pool(struct memory_pool * pool, int order)
+{
+	struct page * page;
+	int j;
+
+	if (!pool->level[order])
+		return 0;
+
+	page = list_entry(pool->contents[order].next, struct page, lru);
+	list_del_init(&page->lru);
+	pool->level[order]--;
+
+	for (j = 0; j < (1 << order); j++)
+		ClearPageChecksumIgnore(page + j);
+
+	if (page_count(page) != 1)
+		printk("Error getting page %p from memory pool. "
+			"Page count is %d (should be 1).\n",
+			page,
+			page_count(page));
+
+	BUG_ON(PageLRU(page) || PageActive(page));
+
+	display_memory_pool_pages();
+	suspend_message(SUSPEND_MEM_POOL, SUSPEND_MEDIUM, 0,
+			"\r%4d %4d %4d.",
+			normal_pool.level[0],
+			normal_pool.level[1],
+			normal_pool.level[2]);
+
+	return page;
+}
+
+/* add_to_pool()
+ *
+ * Description: Insert new head in a pool list
+ */
+
+static void add_to_pool(struct memory_pool * pool, int order, struct page * this)
+{
+	int j;
+
+	pool->level[order]++;
+	list_add(&this->lru, &pool->contents[order]);
+	for (j = 0; j < (1 << order); j++)
+		SetPageChecksumIgnore(this + j);
+	
+	display_memory_pool_pages();
+	suspend_message(SUSPEND_MEM_POOL, SUSPEND_MEDIUM, 0,
+			"\r%4d %4d %4d.",
+			normal_pool.level[0],
+			normal_pool.level[1],
+			normal_pool.level[2]);
+}
+
+/* suspend_memory_pool_level()
+ *
+ * Description:	Returns the number of pages currently in the pool.
+ * Returns:	Int.		Number of pages in the pool.
+ */
+int suspend_memory_pool_level(int only_lowmem)
+{
+	int order, sum = 0;
+
+	for (order = 0; order < MAX_ORDER; order++)
+		sum += normal_pool.level[order] * (1 << order);
+
+	if (!only_lowmem)
+		for (order = 0; order < MAX_ORDER; order++)
+			sum += highmem_pool.level[order] * (1 << order);
+	return sum;
+}
+
+/* fill_suspend_memory_pool()
+ *
+ * Description:	Fill the memory pool from the main free memory pool in the
+ * 		first instance, or grabbed pages if that fails.
+ * 		We allocate @sizesought order 0 pages, plus 1 each
+ * 		of the higher order allocations.
+ * Arguments:	int.		Number of order zero pages requested.
+ * Returns:	int.		Number of order zero pages obtained.
+ */
+int fill_suspend_memory_pool(int sizesought)
+{
+	int i = 0, order, orig_state = 
+		test_suspend_state(SUSPEND_USE_MEMORY_POOL);
+	unsigned long *this = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&suspend_memory_pool_lock, flags);
+
+	/* Pools must not be active for this to work */
+	clear_suspend_state(SUSPEND_USE_MEMORY_POOL);
+
+	suspend_pool_level_limit[0] = sizesought;
+
+	for (order = MAX_ORDER; order >= 0; order--) {
+		int wanted = suspend_pool_level_limit[order] -
+			normal_pool.level[order];
+		for (i = normal_pool.level[order]; 
+				i < suspend_pool_level_limit[order]; i++) {
+			this = (unsigned long *) get_grabbed_pages(order);
+			if (!this) {
+				suspend_message(SUSPEND_MEM_POOL, SUSPEND_ERROR, 1,
+					"%d order %d pages wanted for suspend "
+					"memory pool, got %d.\n",
+					wanted, order, i - 1);
+				break;
+			}
+			add_to_pool(&normal_pool, order, virt_to_page(this));
+		}
+	}
+
+	if (orig_state)
+		set_suspend_state(SUSPEND_USE_MEMORY_POOL);
+
+	min_pool_level = normal_pool.level[0];
+
+	spin_unlock_irqrestore(&suspend_memory_pool_lock, flags);
+
+	return 0;
+}
+
+/* empty_suspend_memory_pool()
+ *
+ * Description:	Drain our memory pool.
+ */
+void __empty_suspend_memory_pool(struct memory_pool * pool)
+{
+	int order;
+	struct page * this;
+
+	for (order = 0; order < MAX_ORDER; order++)
+		while ((this = get_from_pool(pool, order)))
+			__free_pages(this, order);
+
+	suspend_message(SUSPEND_MEM_POOL, SUSPEND_LOW, 1,
+		"Min pool level was %d/%d.\n", min_pool_level, suspend_pool_level_limit[0]);
+}
+
+void empty_suspend_memory_pool(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&suspend_memory_pool_lock, flags);
+
+	display_memory_pool_pages();
+	
+	/* Pool must not be active for this to work */
+	clear_suspend_state(SUSPEND_USE_MEMORY_POOL);
+
+	__empty_suspend_memory_pool(&normal_pool);
+	__empty_suspend_memory_pool(&highmem_pool);
+	
+	spin_unlock_irqrestore(&suspend_memory_pool_lock, flags);
+}
+
+/* get_suspend_pool_pages()
+ * 
+ * Description:	Our equivalent to __alloc_pages (minus zone mask).
+ * 		May be called from interrupt context.
+ * Arguments:	unsigned int:	Mask. We really only care about __GFP_WAIT.
+ * 				We're giving normal zone pages regardless.
+ * 		order:		The number of pages (1 << order) wanted.
+ * Returns:	struct page *:	Pointer (possibly NULL) to pages allocated.
+ */
+struct page * get_suspend_pool_pages(unsigned int gfp_mask, unsigned int order)
+{
+	unsigned long flags;
+	struct page * page;
+
+	if (order > 0) {
+		spin_lock_irqsave(&suspend_memory_pool_lock, flags);
+		if (!normal_pool.level[order]) {
+			printk("No order %d allocation available.\n",
+					order);
+			display_memory_pool_pages();
+			spin_unlock_irqrestore(
+					&suspend_memory_pool_lock,
+					flags);
+			return NULL;
+		}
+		goto check_and_return;
+	}
+
+try_again:
+	if ((!normal_pool.level[order]) && (!(gfp_mask & __GFP_WAIT))) {
+		spin_lock_irqsave(&suspend_memory_pool_lock, flags);
+		display_memory_pool_pages();
+		spin_unlock_irqrestore(&suspend_memory_pool_lock, flags);
+		return NULL;
+	}
+
+	while(!normal_pool.level[order]) {
+		if (active_writer->ops.writer.wait_on_io)
+			active_writer->ops.writer.wait_on_io(0);
+		schedule();
+	}
+
+	spin_lock_irqsave(&suspend_memory_pool_lock, flags);
+	if (!normal_pool.level[order]) {
+		spin_unlock_irqrestore(&suspend_memory_pool_lock, flags);
+		goto try_again;
+	}
+check_and_return:
+	page = get_from_pool(&normal_pool, order);
+	
+	if (normal_pool.level[0] < min_pool_level)
+		min_pool_level = normal_pool.level[0];
+	if (!normal_pool.level[0])
+		printk("Normal pool empty.\n");
+
+	spin_unlock_irqrestore(&suspend_memory_pool_lock, flags);
+	
+	return page;
+}
+
+/* free_suspend_pool_pages()
+ *
+ * Description:	Our equivalent to  __free_pages. Put freed pages into the pool.
+ * 		HighMem pages do still get freed to the normal pool because they
+ * 		aren't going to affect the consistency of our image - worse case,
+ * 		we write a few free pages.
+ * Arguments:	Struct page *:	First page to be freed.
+ * 		Unsigned int:	Size of allocation being freed.
+ */
+void free_suspend_pool_pages(struct page *page, unsigned int order)
+{
+	unsigned long flags;
+	int i;
+	struct memory_pool * pool = &normal_pool;
+
+	suspend_message(SUSPEND_MEM_POOL, SUSPEND_VERBOSE, 1, 
+		"Freeing page %p (%p), order %d.\n",
+		page_address(page), page, order);
+	
+	if (PageHighMem(page))
+		pool = &highmem_pool;
+
+#ifdef CONFIG_MMU
+	set_page_count(page, 1);
+#else
+	for (i = 0; i < (1 << order); i++)
+		set_page_count(page + i, 1);
+#endif
+	if (pool == &normal_pool) {
+		char * address = page_address(page);
+		for (i = 0; i < (1 << order); i++) {
+			clear_page(address);
+			address += PAGE_SIZE;
+		}
+	}
+
+	spin_lock_irqsave(&suspend_memory_pool_lock, flags);
+	add_to_pool(pool, order, page);
+	spin_unlock_irqrestore(&suspend_memory_pool_lock, flags);
+	return;
+}
+
+EXPORT_SYMBOL(suspend_memory_pool_level);


