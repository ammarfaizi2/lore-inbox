Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbULUQqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbULUQqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbULUQqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:46:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:1255 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261803AbULUQo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:44:57 -0500
Date: Tue, 21 Dec 2004 10:44:51 -0600
From: Brent Casavant <bcasavan@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] alloc_large_system_hash: NUMA interleaving
Message-ID: <Pine.SGI.4.61.0412211044000.48124@kzerza.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second resend: First attempt didn't make it to lkml.

Resend: Submitting for inclusion, as this patch series drew no objections
from interested parties, and required no changes.

The following patch against 2.6.10-rc3 modifies alloc_large_system_hash
to enable the use of vmalloc to alleviate boottime allocation imbalances
on NUMA systems.

Both the 2/3 and 3/3 portions of this set of patches depend on
this patch (1/3).

Due to limited vmalloc space on some architectures (i.e. x86),
the use of vmalloc is enabled by default only on NUMA IA64 kernels.
There should be no problem enabling this change for any other
interested NUMA architecture.

Note also one small bug fix introduced here -- the "table" automatic
variable in alloc_large_system_hash is now initialized to NULL.  One
test case tripped over this bug.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c	2004-12-10 18:09:56.325929784 -0600
+++ linux/mm/page_alloc.c	2004-12-10 18:10:39.618232395 -0600
@@ -32,6 +32,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/nodemask.h>
+#include <linux/vmalloc.h>
 
 #include <asm/tlbflush.h>
 
@@ -2023,27 +2024,42 @@
 	return 0;
 }
 
+__initdata int hashdist = HASHDIST_DEFAULT;
+
+#ifdef CONFIG_NUMA
+static int __init set_hashdist(char *str)
+{
+	if (!str)
+		return 0;
+	hashdist = simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("hashdist=", set_hashdist);
+#endif
+
 /*
  * allocate a large system hash table from bootmem
  * - it is assumed that the hash table must contain an exact power-of-2
  *   quantity of entries
+ * - limit is the number of hash buckets, not the total allocation size
  */
 void *__init alloc_large_system_hash(const char *tablename,
 				     unsigned long bucketsize,
 				     unsigned long numentries,
 				     int scale,
-				     int consider_highmem,
+				     int flags,
 				     unsigned int *_hash_shift,
-				     unsigned int *_hash_mask)
+				     unsigned int *_hash_mask,
+				     unsigned long limit)
 {
-	unsigned long long max;
+	unsigned long long max = limit;
 	unsigned long log2qty, size;
-	void *table;
+	void *table = NULL;
 
 	/* allow the kernel cmdline to have a say */
 	if (!numentries) {
 		/* round applicable memory size up to nearest megabyte */
-		numentries = consider_highmem ? nr_all_pages : nr_kernel_pages;
+		numentries = (flags & HASH_HIGHMEM) ? nr_all_pages : nr_kernel_pages;
 		numentries += (1UL << (20 - PAGE_SHIFT)) - 1;
 		numentries >>= 20 - PAGE_SHIFT;
 		numentries <<= 20 - PAGE_SHIFT;
@@ -2057,9 +2073,11 @@
 	/* rounded up to nearest power of 2 in size */
 	numentries = 1UL << (long_log2(numentries) + 1);
 
-	/* limit allocation size to 1/16 total memory */
-	max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
-	do_div(max, bucketsize);
+	/* limit allocation size to 1/16 total memory by default */
+	if (max == 0) {
+		max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
+		do_div(max, bucketsize);
+	}
 
 	if (numentries > max)
 		numentries = max;
@@ -2068,7 +2086,16 @@
 
 	do {
 		size = bucketsize << log2qty;
-		table = alloc_bootmem(size);
+		if (flags & HASH_EARLY)
+			table = alloc_bootmem(size);
+		else if (hashdist)
+			table = __vmalloc(size, GFP_ATOMIC, PAGE_KERNEL);
+		else {
+			unsigned long order;
+			for (order = 0; ((1UL << order) << PAGE_SHIFT) < size; order++)
+				;
+			table = (void*) __get_free_pages(GFP_ATOMIC, order);
+		}
 	} while (!table && size > PAGE_SIZE && --log2qty);
 
 	if (!table)
Index: linux/fs/inode.c
===================================================================
--- linux.orig/fs/inode.c	2004-12-10 18:09:40.416477252 -0600
+++ linux/fs/inode.c	2004-12-10 18:10:39.626044070 -0600
@@ -1333,9 +1333,10 @@
 					sizeof(struct hlist_head),
 					ihash_entries,
 					14,
-					0,
+					HASH_EARLY,
 					&i_hash_shift,
-					&i_hash_mask);
+					&i_hash_mask,
+					0);
 
 	for (loop = 0; loop < (1 << i_hash_shift); loop++)
 		INIT_HLIST_HEAD(&inode_hashtable[loop]);
Index: linux/fs/dcache.c
===================================================================
--- linux.orig/fs/dcache.c	2004-12-10 18:09:55.313341416 -0600
+++ linux/fs/dcache.c	2004-12-10 18:10:39.630926367 -0600
@@ -1579,9 +1579,10 @@
 					sizeof(struct hlist_head),
 					dhash_entries,
 					13,
-					0,
+					HASH_EARLY,
 					&d_hash_shift,
-					&d_hash_mask);
+					&d_hash_mask,
+					0);
 
 	for (loop = 0; loop < (1 << d_hash_shift); loop++)
 		INIT_HLIST_HEAD(&dentry_hashtable[loop]);
Index: linux/include/linux/bootmem.h
===================================================================
--- linux.orig/include/linux/bootmem.h	2004-12-10 18:05:25.365287838 -0600
+++ linux/include/linux/bootmem.h	2004-12-10 18:10:39.642643879 -0600
@@ -74,8 +74,23 @@
 					    unsigned long bucketsize,
 					    unsigned long numentries,
 					    int scale,
-					    int consider_highmem,
+					    int flags,
 					    unsigned int *_hash_shift,
-					    unsigned int *_hash_mask);
+					    unsigned int *_hash_mask,
+					    unsigned long limit);
+
+#define HASH_HIGHMEM	0x00000001	/* Consider highmem? */
+#define HASH_EARLY	0x00000002	/* Allocating during early boot? */
+
+/* Only NUMA needs hash distribution.
+ * IA64 is known to have sufficient vmalloc space.
+ */
+#if defined(CONFIG_NUMA) && defined(CONFIG_IA64)
+#define HASHDIST_DEFAULT 1
+#else
+#define HASHDIST_DEFAULT 0
+#endif
+extern int hashdist;		/* Distribute hashes across NUMA nodes? */
+
 
 #endif /* _LINUX_BOOTMEM_H */

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
