Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVDVV1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVDVV1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVDVV1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:27:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8131 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262139AbVDVV1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:27:03 -0400
Date: Fri, 22 Apr 2005 17:26:56 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: [RFC] non-resident page management
Message-ID: <Pine.LNX.4.61.0504221725520.21085@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basic infrastructure to track non-resident pages. This code is
needed to support advanced page replacement algorithms like
CLOCK-Pro or CART.

Note that this code could use an actual hash function.

Links to the actual replacement algorithms can be found on:

http://wiki.linux-mm.org/wiki/AdvancedPageReplacement

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.11/include/linux/nonresident.h.nonres	2005-04-22 17:19:20.000000000 -0400
+++ linux-2.6.11/include/linux/nonresident.h	2005-04-22 17:20:31.000000000 -0400
@@ -0,0 +1,11 @@
+/*
+ * include/linux/nonresident.h
+ * (C) 2004,2005 Red Hat, Inc
+ * Written by Rik van Riel <riel@redhat.com>
+ * Released under the GPL, see the file COPYING for details.
+ *
+ * Keeps track of whether a non-resident page was recently evicted
+ * and should be immediately promoted to the active list.
+ */
+extern int recently_evicted(void *, unsigned long, short);
+extern int remember_page(void *, unsigned long, short);
--- linux-2.6.11/mm/nonresident.c.nonres	2005-04-22 17:19:13.000000000 -0400
+++ linux-2.6.11/mm/nonresident.c	2005-04-22 17:21:12.000000000 -0400
@@ -0,0 +1,130 @@
+/*
+ * mm/nonresident.c
+ * (C) 2004,2005 Red Hat, Inc
+ * Written by Rik van Riel <riel@redhat.com>
+ * Released under the GPL, see the file COPYING for details.
+ *
+ * Keeps track of whether a non-resident page was recently evicted
+ * and should be immediately promoted to the active list. This also
+ * helps automatically tune the inactive target.
+ *
+ * The pageout code stores a recently evicted page in this cache
+ * by calling remember_page(mapping/mm, offset/vaddr, generation)
+ * and can look it up in the cache by calling recently_evicted()
+ * with the same arguments.
+ *
+ * Note that there is no way to invalidate pages after eg. truncate
+ * or exit, we let the pages fall out of the non-resident set through
+ * normal replacement.
+ */
+#include <linux/mm.h>
+#include <linux/cache.h>
+#include <linux/spinlock.h>
+#include <linux/bootmem.h>
+#include <linux/jhash.h>
+// #include <linux/nonresident.h>
+
+static unsigned long nr_buckets;
+
+/*
+ * We fold the object generation number into the offset field, since
+ * that one has the most "free" bits on a 32 bit system.
+ */
+#define NR_GEN_SHIFT		(BITS_PER_LONG * 7 / 8)
+#define NR_OFFSET_MASK		((1 << NR_GEN_SHIFT) - 1)
+#define make_nr_oag(x,y)	(((x) & NR_OFFSET_MASK) + ((y) << NR_GEN_SHIFT))
+
+struct nr_page {
+	void * mapping;
+	unsigned long offset_and_gen;
+};
+
+/* Number of non-resident pages per hash bucket */
+#define NUM_NR ((L1_CACHE_BYTES - sizeof(spinlock_t))/sizeof(struct nr_page))
+
+struct nr_bucket
+{
+	spinlock_t lock;
+	struct nr_page pages[NUM_NR];
+} ____cacheline_aligned;
+
+/* The non-resident page hash table. */
+static struct nr_bucket * nr_hashtable;
+
+/* Wanted: a real hash function for 2 longs. */
+struct nr_bucket * nr_hash(void * mapping, unsigned long offset_and_gen)
+{
+	unsigned long bucket;
+	bucket = ((unsigned long)mapping + offset_and_gen) % nr_buckets;
+	return nr_hashtable + bucket;
+}
+
+static int nr_same(struct nr_page * first, struct nr_page * second)
+{
+	/* Chances are this nr_page belongs to a different mapping ... */
+	if (first->mapping != second->mapping)
+		return 0;
+
+	/* ... but if it matches the mapping, it's probably the same page. */
+	if (likely(first->offset_and_gen == second->offset_and_gen))
+		return 1;
+
+	return 0;
+}
+
+int recently_evicted(void * mapping, unsigned long offset, short gen)
+{
+	unsigned long offset_and_gen = make_nr_oag(offset, gen);
+	struct nr_bucket * nr_bucket = nr_hash(mapping, offset_and_gen);
+	struct nr_page wanted;
+	int state = -1;
+	int i;
+
+	wanted.offset_and_gen = offset_and_gen;
+	wanted.mapping = mapping;
+
+	spin_lock(&nr_bucket->lock);
+	for (i = 0; i < NUM_NR; i++) {
+		struct nr_page * found = &nr_bucket->pages[i];
+		if (nr_same(found, &wanted)) {
+			found->mapping = 0;
+			state = 1;
+		}
+	}
+	spin_unlock(&nr_bucket->lock);
+
+	return state;
+}
+
+int remember_page(void * mapping, unsigned long offset, short gen)
+{
+	unsigned long offset_and_gen = make_nr_oag(offset, gen);
+	struct nr_bucket * nr_bucket = nr_hash(mapping, offset_and_gen);
+	struct nr_page * victim;
+	int recycled = 0;
+	int i;
+
+	spin_lock(&nr_bucket->lock);
+	for (i = 0; i < NUM_NR; i++) {
+		victim = &nr_bucket->pages[i];
+		if (victim->mapping == 0)
+			goto assign;
+	}
+
+	/* Randomly recycle an nr_page. */
+	i = (offset ^ jiffies) % NUM_NR;
+	victim = &nr_bucket->pages[i];
+	recycled = 1;
+
+assign:
+	victim->mapping = mapping;
+	victim->offset_and_gen = offset_and_gen;
+	spin_unlock(&nr_bucket->lock);
+	return recycled;
+}
+
+void __init init_nonresident(unsigned long mempages)
+{
+	nr_buckets = mempages / NUM_NR;
+	nr_hashtable = alloc_bootmem(nr_buckets * sizeof(struct nr_bucket));
+}
--- linux-2.6.11/mm/Makefile.nonres	2005-04-22 17:19:49.000000000 -0400
+++ linux-2.6.11/mm/Makefile	2005-04-22 11:25:36.000000000 -0400
@@ -12,7 +12,8 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   prio_tree.o $(mmu-y)
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o \
+			   nonresident.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SHMEM) += shmem.o
