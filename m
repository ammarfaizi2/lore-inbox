Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVDWROj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVDWROj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 13:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVDWROj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 13:14:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26579 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261626AbVDWROK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 13:14:10 -0400
Date: Sat, 23 Apr 2005 13:13:16 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] non-resident page management
In-Reply-To: <1114255557.10805.2.camel@localhost>
Message-ID: <Pine.LNX.4.61.0504231310160.26710@chimarrao.boston.redhat.com>
References: <1114255557.10805.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2005, Pekka Enberg wrote:

> How about this? It computes hash for the two longs and combines them by
> addition and multiplication as suggested by [Bloch01].
> 
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

Looks good to me, here's a new version of the patch.

The next part of my cunning plan is to get rid of the object
generation number, and use a cryptographic hash of (offset,
mapping->host->i_ino, mapping->host->i_sb).  That way there's
only a small chance of false positives - assuming a perfect
hash, one false positive every 256MB of data, or 2^16 pages.

Unless there are filesystems that immediately reassign the same
inode number when creating a file after one got deleted - not
sure about that...

Anyway, here is the current code:

Signed-off-by: Rik van Riel <riel@redhat.com>

 include/linux/hash.h        |   13 +++-
 include/linux/nonresident.h |   12 +++
 mm/Makefile                 |    3 
 mm/nonresident.c            |  137 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 2 deletions(-)
--- linux-2.6.11/include/linux/nonresident.h.nonres	2005-04-22 17:19:20.000000000 -0400
+++ linux-2.6.11/include/linux/nonresident.h	2005-04-23 09:17:03.000000000 -0400
@@ -0,0 +1,12 @@
+/*
+ * include/linux/nonresident.h
+ * (C) 2004,2005 Red Hat, Inc
+ * Written by Rik van Riel <riel@redhat.com>
+ * Released under the GPL, see the file COPYING for details.
+ *
+ * Keeps track of whether a non-resident page was recently evicted
+ * and should be immediately promoted to the active list.
+ */
+extern int recently_evicted(void *, unsigned long, unsigned long);
+extern int remember_page(void *, unsigned long, unsigned long);
+void init_nonresident(unsigned long);
--- linux-2.6.11/include/linux/hash.h.nonres	2005-04-23 09:05:08.000000000 -0400
+++ linux-2.6.11/include/linux/hash.h	2005-04-23 09:11:13.000000000 -0400
@@ -23,7 +23,7 @@
 #error Define GOLDEN_RATIO_PRIME for your wordsize.
 #endif
 
-static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+static inline unsigned long hash_long_mul(unsigned long val)
 {
 	unsigned long hash = val;
 
@@ -46,6 +46,17 @@ static inline unsigned long hash_long(un
 	/* On some cpus multiply is faster, on others gcc will do shifts */
 	hash *= GOLDEN_RATIO_PRIME;
 #endif
+	return hash;
+}
+
+static inline unsigned long hash_ptr_mul(void *ptr)
+{
+	return hash_long_mul((unsigned long)ptr);
+}
+
+static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+{
+	unsigned long hash = hash_long_mul(val);
 
 	/* High bits are more random, so use them. */
 	return hash >> (BITS_PER_LONG - bits);
--- linux-2.6.11/mm/nonresident.c.nonres	2005-04-22 17:19:13.000000000 -0400
+++ linux-2.6.11/mm/nonresident.c	2005-04-23 13:09:03.000000000 -0400
@@ -0,0 +1,137 @@
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
+#include <linux/hash.h>
+#include <linux/nonresident.h>
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
+struct nr_bucket * nr_hash(void * mapping, unsigned long offset_and_gen)
+{
+	unsigned long bucket;
+	unsigned long hash;
+
+	hash = 17;
+	hash = 37 * hash + hash_ptr_mul(mapping);
+	hash = 37 * hash + hash_long_mul(offset_and_gen);
+	bucket = hash % nr_buckets;
+
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
+int recently_evicted(void * mapping, unsigned long offset, unsigned long gen)
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
+			found->mapping = NULL;
+			state = 1;
+			break;
+		}
+	}
+	spin_unlock(&nr_bucket->lock);
+
+	return state;
+}
+
+int remember_page(void * mapping, unsigned long offset, unsigned long gen)
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
+		if (victim->mapping == NULL)
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
+/* We should probably remember 2/3 of nr_physpages in non-resident pages */
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
