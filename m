Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261681AbSJHSxn>; Tue, 8 Oct 2002 14:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSJHSxn>; Tue, 8 Oct 2002 14:53:43 -0400
Received: from ns.suse.de ([213.95.15.193]:13838 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261681AbSJHSxl> convert rfc822-to-8bit;
	Tue, 8 Oct 2002 14:53:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: tytso@mit.edu
Subject: Re: [Ext2-devel] Re: [RFC] [PATCH 1/4] Add extended attributes to ext2/3
Date: Tue, 8 Oct 2002 20:59:21 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, <ext2-devel@lists.sourceforge.net>,
       Rik van Riel <riel@conectiva.com.br>
References: <Pine.LNX.4.44L.0210081519490.1648-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0210081519490.1648-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210082059.21556.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 20:21, Rik van Riel wrote:
> On Tue, 8 Oct 2002 tytso@mit.edu wrote:
> > This first patch creates a generic interface for registering caches with
> > the VM subsystem so that they can react appropriately to memory
> > pressure.
> >
> > +/* BKL must be held */
>
> ... but it isn't.  Also, kswapd isn't holding the bkl while
> traversing the list.
>
> > +void register_cache(struct cache_definition *cache)
> > +{
> > +	list_add(&cache->link, &cache_definitions);
> > +}
>
> I suspect you'll want a semaphore for the cache_definitions
> list.

My apologies. This has slipped me; I had in fact added a semaphore in a 
different branch. Here is a fixed version.

--Andreas.

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
@@ -614,6 +648,7 @@
 	shrink_dcache_memory(ratio, gfp_mask);
 	shrink_icache_memory(ratio, gfp_mask);
 	shrink_dqcache_memory(ratio, gfp_mask);
+	shrink_other_caches(ratio, gfp_mask);
 	return nr_pages;
 }

