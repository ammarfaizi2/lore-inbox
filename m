Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVHKWsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVHKWsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVHKWsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:48:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62972 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932518AbVHKWsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:48:13 -0400
Subject: [PATCH 2/2] sparsemem extreme: hotplug preparation
To: akpm@osdl.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 11 Aug 2005 15:48:09 -0700
References: <20050811224807.D1B56AC2@kernel.beaverton.ibm.com>
In-Reply-To: <20050811224807.D1B56AC2@kernel.beaverton.ibm.com>
Message-Id: <20050811224809.998979DE@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This splits up sparse_index_alloc() into two pieces.  This is needed
because we'll allocate the memory for the second level in a different
place from where we actually consume it to keep the allocation from
happening underneath a lock

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/linux/mmzone.h |    1 
 memhotplug-dave/mm/sparse.c            |   52 ++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 13 deletions(-)

diff -puN mm/sparse.c~A6-extreme-hotplug-prepare mm/sparse.c
--- memhotplug/mm/sparse.c~A6-extreme-hotplug-prepare	2005-08-11 15:46:18.000000000 -0700
+++ memhotplug-dave/mm/sparse.c	2005-08-11 15:46:18.000000000 -0700
@@ -6,6 +6,7 @@
 #include <linux/mmzone.h>
 #include <linux/bootmem.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include <asm/dma.h>
 
 /*
@@ -22,27 +23,52 @@ struct mem_section mem_section[NR_SECTIO
 #endif
 EXPORT_SYMBOL(mem_section);
 
-static void sparse_alloc_root(unsigned long root, int nid)
-{
 #ifdef CONFIG_SPARSEMEM_EXTREME
-	mem_section[root] = alloc_bootmem_node(NODE_DATA(nid), PAGE_SIZE);
-#endif
+static struct mem_section *sparse_index_alloc(int nid)
+{
+	struct mem_section *section = NULL;
+	unsigned long array_size = SECTIONS_PER_ROOT *
+				   sizeof(struct mem_section);
+
+	section = alloc_bootmem_node(NODE_DATA(nid), array_size);
+
+	if (section)
+		memset(section, 0, array_size);
+
+	return section;
 }
 
-static void sparse_index_init(unsigned long section, int nid)
+static int sparse_index_init(unsigned long section_nr, int nid)
 {
-	unsigned long root = SECTION_NR_TO_ROOT(section);
+	static spinlock_t index_init_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long root = SECTION_NR_TO_ROOT(section_nr);
+	struct mem_section *section;
+	int ret = 0;
 
-	if (mem_section[root])
-		return;
+	section = sparse_index_alloc(nid);
+	/*
+	 * This lock keeps two different sections from
+	 * reallocating for the same index
+	 */
+	spin_lock(&index_init_lock);
 
-	sparse_alloc_root(root, nid);
+	if (mem_section[root]) {
+		ret = -EEXIST;
+		goto out;
+	}
 
-	if (mem_section[root])
-		memset(mem_section[root], 0, PAGE_SIZE);
-	else
-		panic("memory_present: NO MEMORY\n");
+	mem_section[root] = section;
+out:
+	spin_unlock(&index_init_lock);
+	return ret;
+}
+#else /* !SPARSEMEM_EXTREME */
+static inline int sparse_index_init(unsigned long section_nr, int nid)
+{
+	return 0;
 }
+#endif
+
 /* Record a memory area against a node. */
 void memory_present(int nid, unsigned long start, unsigned long end)
 {
diff -puN include/linux/mmzone.h~A6-extreme-hotplug-prepare include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~A6-extreme-hotplug-prepare	2005-08-11 15:46:18.000000000 -0700
+++ memhotplug-dave/include/linux/mmzone.h	2005-08-11 15:46:18.000000000 -0700
@@ -588,6 +588,7 @@ static inline int pfn_valid(unsigned lon
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
+#define sparse_index_init(_sec, _nid)  do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_NODES_SPAN_OTHER_NODES
_
