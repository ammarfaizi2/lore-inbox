Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSJHSCc>; Tue, 8 Oct 2002 14:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSJHSCc>; Tue, 8 Oct 2002 14:02:32 -0400
Received: from thunk.org ([140.239.227.29]:14787 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261337AbSJHSCa>;
	Tue, 8 Oct 2002 14:02:30 -0400
To: linux-kernel@vger.kernel.org
cc: ext2-devel@lists.sourceforge.net
Subject: [RFC] [PATCH 1/4] Add extended attributes to ext2/3
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E17yymB-00021j-00@think.thunk.org>
Date: Tue, 08 Oct 2002 14:08:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the first of four patches which add extended attribute support
to the ext2 and ext3 filesystems.  It is a port of Andreas Gruenbacher's
patches, which have been well tested and in a number of distributions
(including RH 8, if I'm not mistaken) already.  I just ported it to 2.5
(these patches are versus 2.5.40).  As always, since I touched the code
last, any problems in it are my fault.  :-) 

These patches are prerequisite for the port of the Andreas Gruenbacher's
ACL patches to 2.5, which I'm currently working on.  But given the short
time-frame before feature freeze, I'd like to get these out for review
ASAP.  Please comment and bleed on them.

This first patch creates a generic interface for registering caches with
the VM subsystem so that they can react appropriately to memory
pressure.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
#
# include/linux/cache_def.h |   15 +++++++++++++++
# kernel/ksyms.c            |    3 +++
# mm/vmscan.c               |   29 +++++++++++++++++++++++++++++
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	tytso@think.thunk.org	1.665
# Port of the 0.8.50 cache-def patch.
# --------------------------------------------
#
diff -Nru a/include/linux/cache_def.h b/include/linux/cache_def.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/cache_def.h	Tue Oct  8 13:52:08 2002
@@ -0,0 +1,15 @@
+/*
+ * linux/cache_def.h
+ * Handling of caches defined in drivers, filesystems, ...
+ *
+ * Copyright (C) 2002 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+struct cache_definition {
+	const char *name;
+	void (*shrink)(int, unsigned int);
+	struct list_head link;
+};
+
+extern void register_cache(struct cache_definition *);
+extern void unregister_cache(struct cache_definition *);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Oct  8 13:52:08 2002
+++ b/kernel/ksyms.c	Tue Oct  8 13:52:08 2002
@@ -31,6 +31,7 @@
 #include <linux/genhd.h>
 #include <linux/blkpg.h>
 #include <linux/swap.h>
+#include <linux/cache_def.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
 #include <linux/iobuf.h>
@@ -106,6 +107,8 @@
 EXPORT_SYMBOL(kmem_cache_alloc);
 EXPORT_SYMBOL(kmem_cache_free);
 EXPORT_SYMBOL(kmem_cache_size);
+EXPORT_SYMBOL(register_cache);
+EXPORT_SYMBOL(unregister_cache);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Tue Oct  8 13:52:08 2002
+++ b/mm/vmscan.c	Tue Oct  8 13:52:08 2002
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
+#include <linux/cache_def.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
@@ -76,6 +77,33 @@
 #define shrink_dqcache_memory(ratio, gfp_mask) do { } while (0)
 #endif
 
+static LIST_HEAD(cache_definitions);
+
+/* BKL must be held */
+void register_cache(struct cache_definition *cache)
+{
+	list_add(&cache->link, &cache_definitions);
+}
+
+/* BLK must be held */
+void unregister_cache(struct cache_definition *cache)
+{
+	list_del(&cache->link);
+}
+
+static void shrink_other_caches(int ratio, int gfp_mask)
+{
+	struct list_head *p = cache_definitions.prev;
+
+	while (p != &cache_definitions) {
+		struct cache_definition *cache =
+			list_entry(p, struct cache_definition, link);
+
+		cache->shrink(ratio, gfp_mask);  /* BLK held */
+		p = p->prev;
+	}
+}
+
 /* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page * page)
 {
@@ -614,6 +642,7 @@
 	shrink_dcache_memory(ratio, gfp_mask);
 	shrink_icache_memory(ratio, gfp_mask);
 	shrink_dqcache_memory(ratio, gfp_mask);
+	shrink_other_caches(ratio, gfp_mask);
 	return nr_pages;
 }
 
