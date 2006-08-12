Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWHLOPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWHLOPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWHLOPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:15:46 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:31092 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932523AbWHLOPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:15:23 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Indan Zupancic <indan@nul.nu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Sat, 12 Aug 2006 16:14:35 +0200
Message-Id: <20060812141435.30842.16758.sendpatchset@lappy>
In-Reply-To: <20060812141415.30842.78695.sendpatchset@lappy>
References: <20060812141415.30842.78695.sendpatchset@lappy>
Subject: [RFC][PATCH 2/4] SROG allocator
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A simple memory allocator with a horrid name.
(if someone knows the proper name of this thing, please speak up.
It's too trivial to not be described somewhere)

Its use is for cases where you have multiple objects of various sizes
that have similar livetimes and should release pages as soon as possible.

In a few words, it allocates pages and packs the objects in them, the
pages are kept on a list and the free space blocks are kept in address
order. On free insertion sort is used and front and back merges are tried.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

---
 include/linux/srog.h |   14 ++
 mm/Makefile          |    3 
 mm/srog.c            |  290 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/srog.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/linux/srog.h	2006-08-12 11:49:10.000000000 +0200
@@ -0,0 +1,14 @@
+#ifndef _LINUX_SROG_H_
+#define _LINUX_SROG_H_
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+
+extern void *srog_alloc(void *srogp, unsigned long size, gfp_t gfp_mask);
+extern void srog_free(void *srogp, void *obj);
+extern void srog_link(void *srogp1, void *srogp2);
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_SSROG_H_ */
Index: linux-2.6/mm/Makefile
===================================================================
--- linux-2.6.orig/mm/Makefile	2006-08-12 11:49:05.000000000 +0200
+++ linux-2.6/mm/Makefile	2006-08-12 11:49:10.000000000 +0200
@@ -10,7 +10,8 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o swap.o truncate.o vmscan.o \
-			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
+			   prio_tree.o util.o mmzone.o vmstat.o srog.o \
+			   $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
Index: linux-2.6/mm/srog.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/mm/srog.c	2006-08-12 11:54:27.000000000 +0200
@@ -0,0 +1,289 @@
+/*
+ * mm/srog.c
+ *
+ * Written by Peter Zijlstra <a.p.zijlstra@chello.nl>
+ * Released under the GPLv2, see the file COPYING for details.
+ *
+ * Small Related Object Group Allocator
+ *
+ * Trivial allocator that has to release pages ASAP and pack objects
+ * of various sizes. It need not be fast, just reliable and relative
+ * small.
+ *
+ * The approach is a list of pages (need not be 0-order), each of
+ * these pages are subdivided on demand. The free blocks in each
+ * of these pages are kept in address order.
+ *
+ * On free, the block tries to merge with the previous and next block.
+ *
+ * When a page is found to be empty, its taken off the list and returned
+ * to the system.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+
+/**
+ *	srog_free_area - structure describing a free block of memory
+ *	@size: size of the block
+ *	@next: pointer to the next free block
+ */
+struct srog_free_area {
+	unsigned int size;
+	union {
+		struct srog_free_area *next;
+		char obj[0];
+	};
+};
+
+#define SROG_MAGIC	0xf00fde3d
+
+/**
+ *	srog_head - structure managing a page
+ *	@list: list of all related pages
+ *	@free: first free area descriptor
+ *	@order: allocation order of this page
+ *	@gfp_mask: allocation flags
+ *	@magic: simple sanity check
+ */
+struct srog_head {
+	struct list_head list;
+	struct srog_free_area free;
+	unsigned int order;
+	gfp_t gfp_mask;
+	unsigned int magic;
+};
+
+#define ceiling_log2(x)	fls_long((x) - 1)
+
+#define SROG_SIZE(srog) \
+	((PAGE_SIZE << (srog)->order) - sizeof(struct srog_head))
+
+/**
+ *	__srog_alloc - allocate a new page and initialize the head
+ *	@size: minimum size that must fit
+ *	@gfp_mask: allocation flags
+ */
+static struct srog_head *__srog_alloc(unsigned long size, gfp_t gfp_mask)
+{
+	unsigned long pages;
+	unsigned int order;
+	struct page *page;
+	struct srog_head *srog = NULL;
+
+	size += sizeof(struct srog_head);
+
+	pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	order = ceiling_log2(pages);
+
+	page = alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order);
+	if (!page)
+		goto out;
+
+	srog = (struct srog_head *)pfn_to_kaddr(page_to_pfn(page));
+
+	INIT_LIST_HEAD(&srog->list);
+	srog->order = order;
+	srog->free.next = (struct srog_free_area *)(srog + 1);
+	srog->free.size = 0; /* avoid back merge */
+	srog->free.next->next = NULL;
+	srog->free.next->size = SROG_SIZE(srog);
+	srog->gfp_mask = gfp_mask;
+	srog->magic = SROG_MAGIC;
+
+out:
+	return srog;
+}
+
+#define next_srog(s) list_entry((s)->list.next, typeof(*(s)), list)
+
+#define INC_PTR(p, a) ((typeof(p))(((void *)p) + a))
+
+/*
+ * Tricky macro; will go funny on higher order allocations.
+ */
+#define PTR_TO_SROG(p) ((struct srog_head *)((unsigned long)(p) & PAGE_MASK))
+
+/**
+ *	srog_alloc - allocate an object from a SROG; possibly creating one
+ *	@srogp: pointer to a SROG to use; NULL means create new one
+ *	@gfp_mask: allocation flags to use on create
+ *
+ *	Create a SROG when needed.
+ *
+ *	Allocate an object of requested size from the free space, if
+ *	not enough free space is found, add another page to this SROG.
+ */
+void *srog_alloc(void *srogp, unsigned long size, gfp_t gfp_mask)
+{
+	struct srog_head *srog = PTR_TO_SROG(srogp);
+	struct srog_head *srog_iter;
+	void *obj = NULL;
+
+	/*
+	 * Minimum size requirement, we need to store a free area
+	 * descriptor in there. Increment size with one int to store
+	 * the object size in and make sure we stay aligned.
+	 */
+	size = max(size, (unsigned long)sizeof(struct srog_free_area));
+	size += sizeof(unsigned int);
+	size = ALIGN(size, sizeof(void *));
+
+	if (!srog)
+		srog = __srog_alloc(size, gfp_mask);
+	if (!srog)
+		goto out;
+
+	BUG_ON(srog->magic != SROG_MAGIC);
+
+	srog_iter = srog;
+do_alloc:
+	do {
+		/*
+		 * Walk the free block list, take the first block that
+		 * is large enough to accommodate the requested size.
+		 */
+		struct srog_free_area *sfa, *prev = &srog_iter->free;
+		for (sfa = prev->next; sfa; prev = sfa, sfa = sfa->next) {
+			if (sfa->size < size)
+				continue;
+
+			obj = (void *)sfa->obj;
+			sfa->size -= size;
+
+			/*
+			 * Any remaining space is split into a new free block.
+			 */
+			if (sfa->size) {
+				struct srog_free_area *new_sfa =
+					INC_PTR(sfa, size);
+				new_sfa->next = sfa->next;
+				new_sfa->size = sfa->size;
+				prev->next = new_sfa;
+			} else {
+				prev->next = sfa->next;
+			}
+
+			sfa->size = size;
+			goto out;
+		}
+
+		srog_iter = next_srog(srog_iter);
+	} while (srog_iter != srog);
+
+	if (!obj) {
+		struct srog_head *new_srog;
+		/*
+		 * We cannot fail allocation when we just created a new SROG.
+		 */
+		BUG_ON(!srogp);
+
+		new_srog = __srog_alloc(size, srog->gfp_mask);
+		list_add(&new_srog->list, &srog->list);
+		srog_iter = new_srog;
+		goto do_alloc;
+	}
+
+out:
+	return obj;
+}
+EXPORT_SYMBOL_GPL(srog_alloc);
+
+#define OBJ_SIZE_REF(o) (((unsigned int *)(o)) - 1)
+#define OBJ_SFA(o) ((struct srog_free_area *)OBJ_SIZE_REF(o))
+
+/**
+ *	srog_free - free an object
+ *	@srogp: pointer to an early SROG object; may be NULL.
+ *	@obj: object to free.
+ */
+void srog_free(void *srogp, void *obj)
+{
+	struct srog_head *srog = PTR_TO_SROG(srogp);
+	struct srog_free_area *sfa, *prev, *new_sfa;
+
+	if (!srog)
+		srog = PTR_TO_SROG(obj);
+
+	BUG_ON(srog->magic != SROG_MAGIC);
+
+	/*
+	 * Walk the page list when the object does not belong to this page.
+	 */
+	if (((unsigned long)(obj - (void *)srog)) >
+			(PAGE_SIZE << srog->order)) {
+		struct srog_head *srog_iter;
+		list_for_each_entry(srog_iter, &srog->list, list) {
+			if (((unsigned long)(obj - (void *)srog_iter)) <=
+					(PAGE_SIZE << srog_iter->order)) {
+				srog = srog_iter;
+				break;
+			}
+		}
+	}
+
+	/*
+	 * It doesn't seem to belong here at all!?
+	 */
+	BUG_ON(((unsigned long)(obj - (void *)srog)) >
+			(PAGE_SIZE << srog->order));
+
+	/*
+	 * Insertion sort.
+	 */
+	for (prev = &srog->free, sfa = prev->next;
+			sfa; prev = sfa, sfa = sfa->next) {
+		if ((void*)prev < obj)
+			break;
+	}
+
+	new_sfa = OBJ_SFA(obj);
+	new_sfa->next = sfa;
+	prev->next = new_sfa;
+
+	/*
+	 * Merge forward.
+	 */
+	if (INC_PTR(new_sfa, new_sfa->size) == sfa) {
+		new_sfa->size += sfa->size;
+		new_sfa->next = sfa->next;
+	}
+
+	/*
+	 * Merge backward.
+	 */
+	if (INC_PTR(prev, prev->size) == new_sfa) {
+		prev->size += new_sfa->size;
+		prev->next = new_sfa->next;
+	}
+
+	/*
+	 * If the page just became unused, free it.
+	 */
+	if (srog->free.next->size == SROG_SIZE(srog)) {
+		list_del(&srog->list);
+		free_pages((unsigned long)srog, srog->order);
+	}
+}
+EXPORT_SYMBOL_GPL(srog_free);
+
+/**
+ *	srog_link - link two seperatly allocated SROGs into one
+ *	@srogp1: pointer into one SROG
+ *	@srogp2: pointer into another SROG
+ */
+void srog_link(void *srogp1, void *srogp2)
+{
+	struct srog_head *srog1 = PTR_TO_SROG(srogp1);
+	struct srog_head *srog2 = PTR_TO_SROG(srogp2);
+
+	BUG_ON(srog1->magic != SROG_MAGIC);
+	BUG_ON(srog2->magic != SROG_MAGIC);
+
+	__list_splice(&srog2->list, &srog1->list);
+}
+EXPORT_SYMBOL_GPL(srog_link);
