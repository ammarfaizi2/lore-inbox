Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbSJOD1Q>; Mon, 14 Oct 2002 23:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbSJOD1Q>; Mon, 14 Oct 2002 23:27:16 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:12467 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S262328AbSJOD1N>;
	Mon, 14 Oct 2002 23:27:13 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Add extended attributes to ext2/3
From: tytso@mit.edu
Message-Id: <E181IS8-0001DQ-00@snap.thunk.org>
Date: Mon, 14 Oct 2002 23:33:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Enclosed please find patches to add extended attribute support
to the ext2 and ext3 filesystems.  It is a port of Andreas Gruenbacher's
patches, which have been quite well tested at this point.  Full support
for extended attributes have been in e2fsprogs for quite some time.  In
addition, if CONFIG_EXT[23]_FS_ATTR is not enabled, the code path
changes are quite minimal, and hence this should be a very low-risk
patch.  Please apply.

These patches are a prerequisite for the port of Andreas Gruenbacher's
ACL patches, which will follow shortly.

This first patch creates a generic interface for registering caches with
the VM subsystem so that they can react appropriately to memory
pressure.

						- Ted


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
#
# cache_def.h               |   15 +++++++++++++++
# include/linux/cache_def.h |   15 +++++++++++++++
# kernel/ksyms.c            |    3 +++
# mm/vmscan.c               |   35 +++++++++++++++++++++++++++++++++++
# 4 files changed, 68 insertions(+)
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/14	tytso@snap.thunk.org	1.783
# Port of (updated) 0.8.50 cache-def patch.  (Fixed to take the BKL where necessary)
# 
# --------------------------------------------
#
diff -Nru a/cache_def.h b/cache_def.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/cache_def.h	Mon Oct 14 23:20:54 2002
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
diff -Nru a/include/linux/cache_def.h b/include/linux/cache_def.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/cache_def.h	Mon Oct 14 23:20:54 2002
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
--- a/kernel/ksyms.c	Mon Oct 14 23:20:54 2002
+++ b/kernel/ksyms.c	Mon Oct 14 23:20:54 2002
@@ -31,6 +31,7 @@
 #include <linux/genhd.h>
 #include <linux/blkpg.h>
 #include <linux/swap.h>
+#include <linux/cache_def.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
 #include <linux/iobuf.h>
@@ -103,6 +104,8 @@
 EXPORT_SYMBOL(kmem_cache_alloc);
 EXPORT_SYMBOL(kmem_cache_free);
 EXPORT_SYMBOL(kmem_cache_size);
+EXPORT_SYMBOL(register_cache);
+EXPORT_SYMBOL(unregister_cache);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Mon Oct 14 23:20:54 2002
+++ b/mm/vmscan.c	Mon Oct 14 23:20:54 2002
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
+#include <linux/cache_def.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
@@ -76,6 +77,39 @@
 #define shrink_dqcache_memory(ratio, gfp_mask) do { } while (0)
 #endif
 
+static DECLARE_MUTEX(other_caches_sem);
+static LIST_HEAD(cache_definitions);
+
+void register_cache(struct cache_definition *cache)
+{
+	down(&other_caches_sem);
+	list_add(&cache->link, &cache_definitions);
+	up(&other_caches_sem);
+}
+
+void unregister_cache(struct cache_definition *cache)
+{
+	down(&other_caches_sem);
+	list_del(&cache->link);
+	up(&other_caches_sem);
+}
+
+static void shrink_other_caches(int ratio, int gfp_mask)
+{
+	struct list_head *p;
+
+	down(&other_caches_sem);
+	p = cache_definitions.prev;
+	while (p != &cache_definitions) {
+		struct cache_definition *cache =
+			list_entry(p, struct cache_definition, link);
+
+		cache->shrink(ratio, gfp_mask);
+		p = p->prev;
+	}
+	up(&other_caches_sem);
+}
+
 /* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page * page)
 {
@@ -594,6 +628,7 @@
 	shrink_dcache_memory(shrink_ratio, gfp_mask);
 	shrink_icache_memory(shrink_ratio, gfp_mask);
 	shrink_dqcache_memory(shrink_ratio, gfp_mask);
+	shrink_other_caches(shrink_ratio, gfp_mask);
 }
 
 /*
