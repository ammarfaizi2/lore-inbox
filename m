Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUDNFBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 01:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbUDNFBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 01:01:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13747 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263876AbUDNFBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 01:01:24 -0400
Date: Wed, 14 Apr 2004 00:01:12 -0500 (CDT)
From: Olof Johansson <olof@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
cc: Nathan Lynch <nathanl@austin.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Increase number of dynamic inodes in procfs (2.6.5)
In-Reply-To: <20040413170642.22894ebc.akpm@osdl.org>
Message-ID: <Pine.A41.4.44.0404132332170.80688-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Andrew Morton wrote:

> > and changes the inode number
> >  allocator to use a growable linked list of bitmaps.
>
> This open-codes a simple version of lib/idr.c.  Please use lib/idr.c
> instead.  There's an example in fs/super.c

The drawback of using lib/idr.c is the increased memory consumption for
keeping track of the pointers that are not used. For 100k entries that's
800KB lost (64-bit arch).

I've abstracted out Martin Bligh's and Ingo Molnar's scalable bitmap
allocator that is used by the PID allocator. I was planning on using it
for allocations of mmu_context ids on ppc64, but it seems like it could be
usable in this case too.

The code is a bit rough still, but if others could put it to use I
wouldn't mind cleaning it up. Snapshot inlined below, including the
conversion of the pid allocator to use it. I've kicked it around a bit but
not given it any serious testing yet. Comments are welcome.


-Olof

Olof Johansson                                        Office: 4F005/905
Linux on Power Development                            IBM Systems Group
Email: olof@austin.ibm.com                          Phone: 512-838-9858
All opinions are my own and not those of IBM

diff -Nru a/include/linux/largemap.h b/include/linux/largemap.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/largemap.h	Wed Mar 17 09:48:58 2004
@@ -0,0 +1,67 @@
+/*
+ * include/linux/largemap.h
+ * Scalable, time-bounded bitmap allocator.
+ *
+ * Based on the PID allocator:
+ *
+ * (C) 2002 William Irwin, IBM
+ * (C) 2002 Ingo Molnar, Red Hat
+ *
+ * Broken out into separate module, minor tweaks:
+ * Copyright (C) 2004 Olof Johansson, IBM Corporation
+ */
+
+#ifndef _LINUX_LARGEMAP_H
+#define _LINUX_LARGEMAP_H
+
+#include <asm/atomic.h>
+#include <asm/page.h>
+#include <asm/spinlock.h>
+
+/*
+ * block pages start out as NULL, they get allocated upon
+ * first use and are never deallocated. This way a low limit
+ * value does not cause lots of bitmaps to be allocated, but
+ * the scheme scales to up to 4 million entries, runtime.
+ */
+
+struct lm_block {
+	atomic_t nr_free;
+	void    *page;
+};
+
+struct largemap {
+	unsigned int    lm_last;     /* Last allocated entry */
+	unsigned int    lm_maxlimit; /* Total max size of bitmap */
+	spinlock_t      lm_lock;     /* Protects the array->page entries */
+	struct lm_block lm_array[0]; /* Bigger depending on map size */
+};
+
+
+#define BITS_PER_PAGE		(PAGE_SIZE*8)
+#define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
+
+
+/* Allocate one entry, returning the number of it.
+ * limit is the highest entry to check for if available, 0 = no limit.
+ */
+extern long lm_alloc(struct largemap *map, unsigned int limit);
+
+/* Free one entry */
+static inline void lm_free(struct largemap *map, int entry)
+{
+	int offset = entry & BITS_PER_PAGE_MASK;
+	struct lm_block *block = &map->lm_array[entry / BITS_PER_PAGE];
+
+	clear_bit(offset, block->page);
+	atomic_inc(&block->nr_free);
+}
+
+/* Allocate a bitmap. Takes max size and first actual entry to be available */
+extern struct largemap *lm_allocmap(unsigned long maxsize,
+				    unsigned long firstfree);
+
+/* Free a whole bitmap */
+extern void lm_freemap(struct largemap *map);
+
+#endif /* !_LINUX_LARGEMAP_H */
diff -Nru a/kernel/pid.c b/kernel/pid.c
--- a/kernel/pid.c	Wed Mar 17 09:48:57 2004
+++ b/kernel/pid.c	Wed Mar 17 09:48:57 2004
@@ -25,125 +25,27 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/hash.h>
+#include <linux/largemap.h>

 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
 static struct list_head *pid_hash[PIDTYPE_MAX];
 static int pidhash_shift;
+static struct largemap *pidmap;

 int pid_max = PID_MAX_DEFAULT;
 int last_pid;

-#define RESERVED_PIDS		300
-
-#define PIDMAP_ENTRIES		(PID_MAX_LIMIT/PAGE_SIZE/8)
-#define BITS_PER_PAGE		(PAGE_SIZE*8)
-#define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
-
-/*
- * PID-map pages start out as NULL, they get allocated upon
- * first use and are never deallocated. This way a low pid_max
- * value does not cause lots of bitmaps to be allocated, but
- * the scheme scales to up to 4 million PIDs, runtime.
- */
-typedef struct pidmap {
-	atomic_t nr_free;
-	void *page;
-} pidmap_t;
-
-static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
-	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
-
-static pidmap_t *map_limit = pidmap_array + PIDMAP_ENTRIES;
-
-static spinlock_t pidmap_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
-inline void free_pidmap(int pid)
+void free_pidmap(int pid)
 {
-	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
-	int offset = pid & BITS_PER_PAGE_MASK;
-
-	clear_bit(offset, map->page);
-	atomic_inc(&map->nr_free);
-}
-
-/*
- * Here we search for the next map that has free bits left.
- * Normally the next map has free PIDs.
- */
-static inline pidmap_t *next_free_map(pidmap_t *map, int *max_steps)
-{
-	while (--*max_steps) {
-		if (++map == map_limit)
-			map = pidmap_array;
-		if (unlikely(!map->page)) {
-			unsigned long page = get_zeroed_page(GFP_KERNEL);
-			/*
-			 * Free the page if someone raced with us
-			 * installing it:
-			 */
-			spin_lock(&pidmap_lock);
-			if (map->page)
-				free_page(page);
-			else
-				map->page = (void *)page;
-			spin_unlock(&pidmap_lock);
-
-			if (!map->page)
-				break;
-		}
-		if (atomic_read(&map->nr_free))
-			return map;
-	}
-	return NULL;
+	lm_free(pidmap, pid);
 }

 int alloc_pidmap(void)
 {
-	int pid, offset, max_steps = PIDMAP_ENTRIES + 1;
-	pidmap_t *map;
+	int pid = lm_alloc(pidmap, pid_max);
+	last_pid = pid;

-	pid = last_pid + 1;
-	if (pid >= pid_max)
-		pid = RESERVED_PIDS;
-
-	offset = pid & BITS_PER_PAGE_MASK;
-	map = pidmap_array + pid / BITS_PER_PAGE;
-
-	if (likely(map->page && !test_and_set_bit(offset, map->page))) {
-		/*
-		 * There is a small window for last_pid updates to race,
-		 * but in that case the next allocation will go into the
-		 * slowpath and that fixes things up.
-		 */
-return_pid:
-		atomic_dec(&map->nr_free);
-		last_pid = pid;
-		return pid;
-	}
-
-	if (!offset || !atomic_read(&map->nr_free)) {
-next_map:
-		map = next_free_map(map, &max_steps);
-		if (!map)
-			goto failure;
-		offset = 0;
-	}
-	/*
-	 * Find the next zero bit:
-	 */
-scan_more:
-	offset = find_next_zero_bit(map->page, BITS_PER_PAGE, offset);
-	if (offset >= BITS_PER_PAGE)
-		goto next_map;
-	if (test_and_set_bit(offset, map->page))
-		goto scan_more;
-
-	/* we got the PID: */
-	pid = (map - pidmap_array) * BITS_PER_PAGE + offset;
-	goto return_pid;
-
-failure:
-	return -1;
+	return pid;
 }

 inline struct pid *find_pid(enum pid_type type, int nr)
@@ -219,7 +121,7 @@
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		if (find_pid(type, nr))
 			return;
-	free_pidmap(nr);
+	lm_free(pidmap, nr);
 }

 task_t *find_task_by_pid(int nr)
@@ -294,13 +196,12 @@
 void __init pidmap_init(void)
 {
 	int i;
-
-	pidmap_array->page = (void *)get_zeroed_page(GFP_KERNEL);
-	set_bit(0, pidmap_array->page);
-	atomic_dec(&pidmap_array->nr_free);
+
+	/* Allocate pid 0 by defalt */
+	pidmap = lm_allocmap(PID_MAX_LIMIT, 1);

 	/*
-	 * Allocate PID 0, and hash it via all PID types:
+	 * Hash pid 0 via all PID types:
 	 */

 	for (i = 0; i < PIDTYPE_MAX; i++)
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Wed Mar 17 09:48:57 2004
+++ b/lib/Makefile	Wed Mar 17 09:48:57 2004
@@ -6,7 +6,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o
+	 bitmap.o extable.o largemap.o

 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru a/lib/largemap.c b/lib/largemap.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/largemap.c	Wed Mar 17 09:48:57 2004
@@ -0,0 +1,190 @@
+/*
+ * lib/largemap.c
+ * Scalable, time-bounded bitmap allocator.
+ *
+ * Based on the PID allocator:
+ *
+ * (C) 2002 William Irwin, IBM
+ * (C) 2002 Ingo Molnar, Red Hat
+ *
+ * Broken out into separate module, minor tweaks:
+ * Copyright (C) 2004 Olof Johansson, IBM Corporation
+ *
+ * We have a list of bitmap pages, which bitmaps represent the
+ * allocation space. Allocating and freeing entries is completely
+ * lockless.
+ * The worst-case allocation scenario when all but one out
+ * of entries possible are allocated already: the scanning of list
+ * entries and at most PAGE_SIZE bytes.
+ * The typical fastpath is a single successful setbit.
+ * Freeing is O(1).
+ */
+
+#include <asm/mmu_context.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/hash.h>
+#include <linux/largemap.h>
+
+/*
+ * Here we search for the next map that has free bits left.
+ * Normally the next map has a free entry.
+ *
+ * Before allocating a new page, we need to re-scan from the beginning
+ * to find pages with free entries first. Otherwise we'll keep growing
+ * as long as the last page in the array is filled, no matter if
+ * there's space before it or not.
+ */
+static inline int find_free_block(struct largemap *map, unsigned int limit)
+{
+	int i;
+	unsigned int start;
+
+	start = map->lm_last / BITS_PER_PAGE;
+
+ rescan:
+	for (i = start; i < limit; i++) {
+		if (!atomic_read(&map->lm_array[i].nr_free))
+			continue;
+
+		if (unlikely(!map->lm_array[i].page)) {
+			unsigned long page;
+
+			if (start != 0) {
+				/* Make sure all pages have been
+				 * searched.
+				 */
+				start = 0;
+				goto rescan;
+			}
+
+			page = get_zeroed_page(GFP_KERNEL);
+			/*
+			 * Free the page if someone raced with us
+			 * installing it:
+			 */
+			spin_lock(&map->lm_lock);
+			if (map->lm_array[i].page)
+				free_page(page);
+			else
+				map->lm_array[i].page = (void *)page;
+			spin_unlock(&map->lm_lock);
+
+			if (!map->lm_array[i].page) {
+				/* Allocation failed */
+				return -ENOMEM;
+			}
+		}
+		return i;
+	}
+
+	if (start != 0) {
+		start = 0;
+		goto rescan;
+	} else
+		return -ENOSPC;
+}
+
+long lm_alloc(struct largemap *map, unsigned int limit)
+{
+	int entry, offset, nextblock;
+	struct lm_block *block;
+
+	if (!limit)
+		limit = map->lm_maxlimit;
+
+	entry = map->lm_last + 1;
+	if (entry >= limit)
+		entry = 0;
+
+	BUG_ON(limit > map->lm_maxlimit);
+
+	offset = entry & BITS_PER_PAGE_MASK;
+	block = &map->lm_array[entry / BITS_PER_PAGE];
+
+	if (likely(block->page && !test_and_set_bit(offset, block->page))) {
+		/*
+		 * There is a small window for lm_last updates to race,
+		 * but in that case the next allocation will go into the
+		 * slowpath and that fixes things up.
+		 */
+return_entry:
+		atomic_dec(&block->nr_free);
+		map->lm_last = entry;
+		return entry;
+	}
+
+	if (!block->page || !atomic_read(&block->nr_free)) {
+next_block:
+		nextblock = find_free_block(map, (limit + BITS_PER_PAGE + 1) /
+					         BITS_PER_PAGE);
+		if (nextblock < 0)
+			goto failure;
+
+		block = &map->lm_array[nextblock];
+		offset = 0;
+	}
+
+scan_more:
+	offset = find_next_zero_bit(block->page, BITS_PER_PAGE, offset);
+	if (offset >= BITS_PER_PAGE)
+		goto next_block;
+	if (test_and_set_bit(offset, block->page))
+		goto scan_more;
+
+	/* we found and set a bit */
+	entry = (block - map->lm_array) * BITS_PER_PAGE + offset;
+	goto return_entry;
+
+failure:
+	return -1;
+}
+
+
+struct largemap *lm_allocmap(unsigned long maxsize, unsigned long firstfree)
+{
+	struct largemap *map;
+	int arraysize = (maxsize + PAGE_SIZE*8-1)/PAGE_SIZE/8;
+	int i;
+
+	/* We could get rid of the firstfree <= BITS_PER_PAGE
+	 * limitation by using a offset-member in the structure
+	 * instead, but with all current users firstfree is a low
+	 * value.
+	 */
+	BUG_ON(firstfree > BITS_PER_PAGE || firstfree > maxsize);
+
+	map = kmalloc(sizeof(struct largemap) +
+		      arraysize*sizeof(struct lm_block), GFP_KERNEL);
+
+	map->lm_maxlimit = maxsize;
+	map->lm_last = firstfree ? firstfree-1 : 0;
+	spin_lock_init(&map->lm_lock);
+
+	for (i = 0; i < arraysize; i++) {
+		map->lm_array[i].page = NULL;
+		atomic_set(&map->lm_array[i].nr_free, BITS_PER_PAGE);
+	}
+
+	map->lm_array[0].page = (void *)get_zeroed_page(GFP_KERNEL);
+
+	for (i = 0; i < firstfree; i++) {
+		set_bit(i, map->lm_array[0].page);
+		atomic_dec(&map->lm_array[0].nr_free);
+	}
+
+	return map;
+}
+
+void lm_freemap(struct largemap *map)
+{
+	int i;
+
+	for (i = 0; i < map->lm_maxlimit; i++)
+		if (map->lm_array[i].page)
+			free_page((unsigned long)map->lm_array[i].page);
+
+	kfree(map);
+}


