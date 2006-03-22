Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932894AbWCVWgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbWCVWgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWCVWgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:36:13 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:35823 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932898AbWCVWgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:36:05 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223531.12658.86032.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 26/34] mm: clockpro-nonresident.patch
Date: Wed, 22 Mar 2006 23:36:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Rik van Riel <riel@redhat.com>

Track non-resident pages through a simple hashing scheme.  This way
the space overhead is limited to 1 u32 per page, or 0.1% space overhead
and lookups are one cache miss.

Aside from seeing whether or not a page was recently evicted, we can
also take a reasonable guess at how many other pages were evicted since
this page was evicted.

TODO: make the entries unsigned long, currently we're limited to 
1^32*NUM_NR*PAGE_SIZE bytes of memory. Event though this would end up
being 1008 TB of memory, I suspect the hash function to go crap at around
4 to 16 TB.

Signed-off-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/nonresident.h |   12 +++
 mm/nonresident.c            |  167 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

Index: linux-2.6/mm/nonresident.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/mm/nonresident.c	2006-03-13 20:45:26.000000000 +0100
@@ -0,0 +1,167 @@
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
+ * by calling remember_page(mapping/mm, index/vaddr, generation)
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
+#include <linux/kernel.h>
+
+/* Number of non-resident pages per hash bucket. Never smaller than 15. */
+#if (L1_CACHE_BYTES < 64)
+#define NR_BUCKET_BYTES 64
+#else
+#define NR_BUCKET_BYTES L1_CACHE_BYTES
+#endif
+#define NUM_NR ((NR_BUCKET_BYTES - sizeof(atomic_t))/sizeof(u32))
+
+struct nr_bucket
+{
+	atomic_t hand;
+	u32 page[NUM_NR];
+} ____cacheline_aligned;
+
+/* The non-resident page hash table. */
+static struct nr_bucket * nonres_table;
+static unsigned int nonres_shift;
+static unsigned int nonres_mask;
+
+static struct nr_bucket * nr_hash(void * mapping, unsigned long index)
+{
+	unsigned long bucket;
+	unsigned long hash;
+
+	hash = hash_ptr(mapping, BITS_PER_LONG);
+	hash = 37 * hash + hash_long(index, BITS_PER_LONG);
+	bucket = hash & nonres_mask;
+
+	return nonres_table + bucket;
+}
+
+static u32 nr_cookie(struct address_space * mapping, unsigned long index)
+{
+	unsigned long cookie = hash_ptr(mapping, BITS_PER_LONG);
+	cookie = 37 * cookie + hash_long(index, BITS_PER_LONG);
+
+	if (mapping && mapping->host) {
+		cookie = 37 * cookie + hash_long(mapping->host->i_ino, BITS_PER_LONG);
+	}
+
+	return (u32)(cookie >> (BITS_PER_LONG - 32));
+}
+
+unsigned long nonresident_get(struct address_space * mapping, unsigned long index)
+{
+	struct nr_bucket * nr_bucket;
+	int distance;
+	u32 wanted;
+	int i;
+
+	prefetch(mapping->host);
+	nr_bucket = nr_hash(mapping, index);
+
+	prefetch(nr_bucket);
+	wanted = nr_cookie(mapping, index);
+
+	for (i = 0; i < NUM_NR; i++) {
+		if (nr_bucket->page[i] == wanted) {
+			nr_bucket->page[i] = 0;
+			/* Return the distance between entry and clock hand. */
+			distance = atomic_read(&nr_bucket->hand) + NUM_NR - i;
+			distance %= NUM_NR;
+			return (distance << nonres_shift) + (nr_bucket - nonres_table);
+		}
+	}
+
+	return ~0UL;
+}
+
+u32 nonresident_put(struct address_space * mapping, unsigned long index)
+{
+	struct nr_bucket * nr_bucket;
+	u32 nrpage;
+	int i;
+
+	prefetch(mapping->host);
+	nr_bucket = nr_hash(mapping, index);
+
+	prefetchw(nr_bucket);
+	nrpage = nr_cookie(mapping, index);
+
+	/* Atomically find the next array index. */
+	preempt_disable();
+retry:
+	i = atomic_inc_return(&nr_bucket->hand);
+	if (unlikely(i >= NUM_NR)) {
+		if (i == NUM_NR)
+			atomic_set(&nr_bucket->hand, -1);
+		goto retry;
+	}
+	preempt_enable();
+
+	/* Statistics may want to know whether the entry was in use. */
+	return xchg(&nr_bucket->page[i], nrpage);
+}
+
+unsigned long fastcall nonresident_total(void)
+{
+	return NUM_NR << nonres_shift;
+}
+
+/*
+ * For interactive workloads, we remember about as many non-resident pages
+ * as we have actual memory pages.  For server workloads with large inter-
+ * reference distances we could benefit from remembering more.
+ */
+static __initdata unsigned long nonresident_factor = 1;
+void __init nonresident_init(void)
+{
+	int target;
+	int i;
+
+	/*
+	 * Calculate the non-resident hash bucket target. Use a power of
+	 * two for the division because alloc_large_system_hash rounds up.
+	 */
+	target = nr_all_pages * nonresident_factor;
+	target /= (sizeof(struct nr_bucket) / sizeof(u32));
+
+	nonres_table = alloc_large_system_hash("Non-resident page tracking",
+					sizeof(struct nr_bucket),
+					target,
+					0,
+					HASH_EARLY | HASH_HIGHMEM,
+					&nonres_shift,
+					&nonres_mask,
+					0);
+
+	for (i = 0; i < (1 << nonres_shift); i++)
+		atomic_set(&nonres_table[i].hand, 0);
+}
+
+static int __init set_nonresident_factor(char * str)
+{
+	if (!str)
+		return 0;
+	nonresident_factor = simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("nonresident_factor=", set_nonresident_factor);
Index: linux-2.6/include/linux/nonresident.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/linux/nonresident.h	2006-03-13 20:45:26.000000000 +0100
@@ -0,0 +1,12 @@
+#ifndef _LINUX_NONRESIDENT_H_
+#define _LINUX_NONRESIDENT_H_
+
+#ifdef __KERNEL__
+
+extern void nonresident_init(void);
+extern unsigned long nonresident_get(struct address_space *, unsigned long);
+extern u32 nonresident_put(struct address_space *, unsigned long);
+extern unsigned long fastcall nonresident_total(void);
+
+#endif /* __KERNEL */
+#endif /* _LINUX_NONRESIDENT_H_ */
