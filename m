Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVD2UIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVD2UIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVD2UIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:08:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21942 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262921AbVD2UCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:02:22 -0400
Date: Fri, 29 Apr 2005 16:02:13 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org, Feng Chen <fchen@CS.WM.EDU>,
       Song Jiang <sjiang@lanl.gov>
Subject: [RFC] non resident page management, #4
Message-ID: <Pine.LNX.4.61.0504291556110.12094@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the 4th version of non the non resident page management
infrastructure.  This version shrinks the space used for each
non-resident page to just one word.

I also got rid of the spinlock and am using a clock hand instead,
so we can recycle the entries in each hash bucket in FIFO order.
This allowed me to tighten up the code a bit more, and write some
disgusting code to atomically get the next array entry ;)

As usual, this version is for feedback only and isn't actually
used for anything yet.

Signed-off-by: Rik van Riel <riel@redhat.com>

 include/linux/hash.h        |   13 ++++
 include/linux/nonresident.h |   12 ++++
 mm/Makefile                 |    3 -
 mm/nonresident.c            |  115 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 2 deletions(-)

--- /dev/null	2005-04-21 05:03:54.750000000 -0400
+++ linux-2.6.11/include/linux/nonresident.h	2005-04-28 17:52:27.000000000 -0400
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
+extern int recently_evicted(struct address_space *, unsigned long);
+extern int remember_page(struct address_space *, unsigned long);
+void init_nonresident(unsigned long);
--- linux-2.6.11/include/linux/hash.h.nonres	2005-03-02 02:38:32.000000000 -0500
+++ linux-2.6.11/include/linux/hash.h	2005-04-28 17:52:27.000000000 -0400
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
--- /dev/null	2005-04-21 05:03:54.750000000 -0400
+++ linux-2.6.11/mm/nonresident.c	2005-04-29 15:49:46.000000000 -0400
@@ -0,0 +1,115 @@
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
+#include <linux/prefetch.h>
+#include <linux/nonresident.h>
+
+static unsigned long nr_buckets;
+
+/* Number of non-resident pages per hash bucket */
+#define NUM_NR ((L1_CACHE_BYTES - sizeof(atomic_t))/sizeof(unsigned long))
+
+struct nr_bucket
+{
+	atomic_t hand;
+	unsigned long page[NUM_NR];
+} ____cacheline_aligned;
+
+/* The non-resident page hash table. */
+static struct nr_bucket * nr_hashtable;
+
+struct nr_bucket * nr_hash(void * mapping, unsigned long offset)
+{
+	unsigned long bucket;
+	unsigned long hash;
+
+	hash = hash_ptr_mul(mapping);
+	hash = 37 * hash + hash_long_mul(offset);
+	bucket = hash % nr_buckets;
+
+	return nr_hashtable + bucket;
+}
+
+static unsigned long nr_cookie(struct address_space * mapping, unsigned long offset)
+{
+	unsigned long cookie = hash_ptr_mul(mapping);
+	cookie = 37 * cookie + hash_long_mul(offset);
+
+	if (mapping->host) {
+		cookie = 37 * cookie + hash_long_mul(mapping->host->i_ino);
+	}
+
+	return cookie;
+}
+
+int recently_evicted(struct address_space * mapping, unsigned long offset)
+{
+	struct nr_bucket * nr_bucket;
+	unsigned long wanted;
+	int i;
+
+	prefetch(mapping->host);
+	nr_bucket = nr_hash(mapping, offset);
+
+	prefetch(nr_bucket);
+	wanted = nr_cookie(mapping, offset);
+
+	/* TODO: only consider most recent N entries behind hand */
+	for (i = 0; i < NUM_NR; i++) {
+		if (nr_bucket->page[i] == wanted) {
+			nr_bucket->page[i] = 0;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+int remember_page(struct address_space * mapping, unsigned long offset)
+{
+	struct nr_bucket * nr_bucket;
+	unsigned long nrpage;
+	int i;
+
+	prefetch(mapping->host);
+	nr_bucket = nr_hash(mapping, offset);
+
+	prefetchw(nr_bucket);
+	nrpage = nr_cookie(mapping, offset);
+
+	/* Atomically find the next array index. */
+	do {
+		i = atomic_inc_return(&nr_bucket->hand);
+	} while ((i >= NUM_NR) && atomic_set(&nr_bucket->hand, -1));
+
+	/* Return whether the entry was free or occupied. */
+	return xchg(&nr_bucket->page[i], nrpage);
+}
+
+/* We should remember as many non-resident pages as we have nr_physpages. */
+void __init init_nonresident(unsigned long mempages)
+{
+	nr_buckets = mempages / NUM_NR;
+	nr_hashtable = alloc_bootmem(nr_buckets * sizeof(struct nr_bucket));
+}
--- linux-2.6.11/mm/Makefile.nonres	2005-03-02 02:38:12.000000000 -0500
+++ linux-2.6.11/mm/Makefile	2005-04-28 17:52:27.000000000 -0400
@@ -12,7 +12,8 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   prio_tree.o $(mmu-y)
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o \
+			   nonresident.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SHMEM) += shmem.o
