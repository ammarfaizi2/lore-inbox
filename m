Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288611AbSA2PzQ>; Tue, 29 Jan 2002 10:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288622AbSA2PzL>; Tue, 29 Jan 2002 10:55:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:9399 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S288611AbSA2Pyv>;
	Tue, 29 Jan 2002 10:54:51 -0500
Date: Tue, 29 Jan 2002 16:54:44 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-kernel@vger.kernel.org, linux-mm@nl.linux.org
Cc: velco@fadata.bg
Subject: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020129165444.A26626@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-kernel@vger.kernel.org, linux-mm@nl.linux.org,
	velco@fadata.bg
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've ported my hacked up version of Momchil Velikov's radix tree
radix tree pagecache to 2.5.3-pre{5,6}.

The changes over the 2.4.17 version are:

  o use mempool to avoid OOM situation involving radix nodes.
  o remove add_to_page_cache_locked, it was unused in the 2.4.17 patch.
  o unify add_to_page and add_to_page_unique

It gives nice scalability improvements on big machines and drops the
memory usage on small ones (if you consider my 64MB Athlon small :)).

The patch is at

	ftp://ftp.kernel.org:/pub/linux/kernel/people/hch/patches/v2.5/2.5.3-pre5/linux-2.5.3-ratpagecache.patch.gz
	ftp://ftp.kernel.org:/pub/linux/kernel/people/hch/patches/v2.5/2.5.3-pre5/linux-2.5.3-ratpagecache.patch.bz2

or below.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/rd.c linux-vger/drivers/block/rd.c
--- /datenklo/ref/linux-vger/drivers/block/rd.c	Sun Jan 13 00:05:09 2002
+++ linux-vger/drivers/block/rd.c	Tue Jan 29 03:05:40 2002
@@ -156,7 +156,6 @@
 
 	do {
 		int count;
-		struct page ** hash;
 		struct page * page;
 		char * src, * dst;
 		int unlock = 0;
@@ -166,8 +165,7 @@
 			count = size;
 		size -= count;
 
-		hash = page_hash(mapping, index);
-		page = __find_get_page(mapping, index, hash);
+		page = find_get_page(mapping, index);
 		if (!page) {
 			page = grab_cache_page(mapping, index);
 			err = -ENOMEM;
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/fs/inode.c linux-vger/fs/inode.c
--- /datenklo/ref/linux-vger/fs/inode.c	Fri Jan 25 13:12:03 2002
+++ linux-vger/fs/inode.c	Tue Jan 29 03:05:40 2002
@@ -144,6 +144,7 @@
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
 	sema_init(&inode->i_zombie, 1);
+	INIT_RAT_ROOT(&inode->i_data.page_tree, GFP_ATOMIC);
 	spin_lock_init(&inode->i_data.i_shared_lock);
 }
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/include/linux/fs.h linux-vger/include/linux/fs.h
--- /datenklo/ref/linux-vger/include/linux/fs.h	Fri Jan 25 13:15:19 2002
+++ linux-vger/include/linux/fs.h	Tue Jan 29 03:05:40 2002
@@ -21,6 +21,7 @@
 #include <linux/cache.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/rat.h>
 
 #include <asm/atomic.h>
 #include <asm/bitops.h>
@@ -378,6 +379,7 @@
 };
 
 struct address_space {
+	struct rat_root		page_tree;	/* radix tree of all pages */
 	struct list_head	clean_pages;	/* list of clean pages */
 	struct list_head	dirty_pages;	/* list of dirty pages */
 	struct list_head	locked_pages;	/* list of locked pages */
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/include/linux/mm.h linux-vger/include/linux/mm.h
--- /datenklo/ref/linux-vger/include/linux/mm.h	Wed Jan 16 21:49:08 2002
+++ linux-vger/include/linux/mm.h	Tue Jan 29 03:05:40 2002
@@ -149,15 +149,12 @@
 	struct list_head list;		/* ->mapping has some page lists. */
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
-	struct page *next_hash;		/* Next page sharing our hash bucket in
-					   the pagecache hash table. */
 	atomic_t count;			/* Usage count, see below. */
 	unsigned long flags;		/* atomic flags, some possibly
 					   updated asynchronously */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by pagemap_lru_lock !! */
 	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
-	struct page **pprev_hash;	/* Complement to *next_hash. */
 	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
@@ -225,9 +222,8 @@
  * using the page->list list_head. These fields are also used for
  * freelist managemet (when page->count==0).
  *
- * There is also a hash table mapping (mapping,index) to the page
- * in memory if present. The lists for this hash table use the fields
- * page->next_hash and page->pprev_hash.
+ * There is also a per-mapping radix tree mapping index to the page
+ * in memory if present. The tree is rooted at mapping->root.  
  *
  * All process pages can do I/O:
  * - inode pages may need to be read from disk,
@@ -461,6 +457,24 @@
 		return 0;
 }
 
+static inline void add_page_to_inode_queue(struct address_space *mapping, struct page * page)
+{
+	struct list_head *head = &mapping->clean_pages;
+
+	mapping->nrpages++;
+	list_add(&page->list, head);
+	page->mapping = mapping;
+}
+
+static inline void remove_page_from_inode_queue(struct page * page)
+{
+	struct address_space * mapping = page->mapping;
+
+	mapping->nrpages--;
+	list_del(&page->list);
+	page->mapping = NULL;
+}
+
 struct zone_t;
 /* filemap.c */
 extern void remove_inode_page(struct page *);
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/include/linux/pagemap.h linux-vger/include/linux/pagemap.h
--- /datenklo/ref/linux-vger/include/linux/pagemap.h	Mon Nov 12 18:19:18 2001
+++ linux-vger/include/linux/pagemap.h	Tue Jan 29 03:18:57 2002
@@ -41,53 +41,22 @@
  */
 #define page_cache_entry(x)	virt_to_page(x)
 
-extern unsigned int page_hash_bits;
-#define PAGE_HASH_BITS (page_hash_bits)
-#define PAGE_HASH_SIZE (1 << PAGE_HASH_BITS)
-
-extern atomic_t page_cache_size; /* # of pages currently in the hash table */
-extern struct page **page_hash_table;
-
-extern void page_cache_init(unsigned long);
-
-/*
- * We use a power-of-two hash table to avoid a modulus,
- * and get a reasonable hash by knowing roughly how the
- * inode pointer and indexes are distributed (ie, we
- * roughly know which bits are "significant")
- *
- * For the time being it will work for struct address_space too (most of
- * them sitting inside the inodes). We might want to change it later.
- */
-static inline unsigned long _page_hashfn(struct address_space * mapping, unsigned long index)
-{
-#define i (((unsigned long) mapping)/(sizeof(struct inode) & ~ (sizeof(struct inode) - 1)))
-#define s(x) ((x)+((x)>>PAGE_HASH_BITS))
-	return s(i+index) & (PAGE_HASH_SIZE-1);
-#undef i
-#undef s
-}
-
-#define page_hash(mapping,index) (page_hash_table+_page_hashfn(mapping,index))
-
-extern struct page * __find_get_page(struct address_space *mapping,
-				unsigned long index, struct page **hash);
-#define find_get_page(mapping, index) \
-	__find_get_page(mapping, index, page_hash(mapping, index))
-extern struct page * __find_lock_page (struct address_space * mapping,
-				unsigned long index, struct page **hash);
+extern atomic_t page_cache_size; /* # of pages currently in the page cache */
+
+extern struct page * find_get_page(struct address_space *mapping,
+				unsigned long index);
+extern struct page * find_lock_page(struct address_space *mapping,
+				unsigned long index);
+extern struct page * find_trylock_page(struct address_space *mapping,
+				unsigned long index);
 extern struct page * find_or_create_page(struct address_space *mapping,
 				unsigned long index, unsigned int gfp_mask);
 
+extern int add_to_page_cache(struct page * page, struct address_space *mapping,
+				unsigned long index);
+
 extern void FASTCALL(lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
-#define find_lock_page(mapping, index) \
-	__find_lock_page(mapping, index, page_hash(mapping, index))
-extern struct page *find_trylock_page(struct address_space *, unsigned long);
-
-extern void add_to_page_cache(struct page * page, struct address_space *mapping, unsigned long index);
-extern void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index);
-extern int add_to_page_cache_unique(struct page * page, struct address_space *mapping, unsigned long index, struct page **hash);
 
 extern void ___wait_on_page(struct page *);
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/include/linux/rat.h linux-vger/include/linux/rat.h
--- /datenklo/ref/linux-vger/include/linux/rat.h	Thu Jan  1 01:00:00 1970
+++ linux-vger/include/linux/rat.h	Tue Jan 29 03:05:40 2002
@@ -0,0 +1,26 @@
+#ifndef _LINUX_RAT_H
+#define _LINUX_RAT_H
+
+struct rat_node;
+
+#define RAT_SLOT_RESERVED	((void *)~0UL)
+
+struct rat_root {
+	unsigned int	height;
+	int		gfp_mask;
+	struct rat_node	*rnode;
+};
+
+#define INIT_RAT_ROOT(root, mask)	\
+do {					\
+	(root)->height = 0;		\
+	(root)->gfp_mask = (mask);	\
+	(root)->rnode = NULL;		\
+} while (0)
+
+extern int rat_reserve(struct rat_root *, unsigned long, void ***);
+extern int rat_insert(struct rat_root *, unsigned long, void *);
+extern void *rat_lookup(struct rat_root *, unsigned long);
+extern int rat_delete(struct rat_root *, unsigned long);
+
+#endif /* _LINUX_RAT_H */
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/include/linux/swap.h linux-vger/include/linux/swap.h
--- /datenklo/ref/linux-vger/include/linux/swap.h	Wed Jan 16 21:49:11 2002
+++ linux-vger/include/linux/swap.h	Tue Jan 29 03:05:40 2002
@@ -96,7 +96,7 @@
 struct task_struct;
 struct vm_area_struct;
 struct sysinfo;
-
+struct address_space;
 struct zone_t;
 
 /* linux/mm/swap.c */
@@ -126,6 +126,9 @@
 extern int add_to_swap_cache(struct page *, swp_entry_t);
 extern void __delete_from_swap_cache(struct page *page);
 extern void delete_from_swap_cache(struct page *page);
+extern int move_to_swap_cache(struct page *page, swp_entry_t entry);
+extern int move_from_swap_cache(struct page *page, unsigned long index,
+		struct address_space *mapping);
 extern void free_page_and_swap_cache(struct page *page);
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t);
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/init/main.c linux-vger/init/main.c
--- /datenklo/ref/linux-vger/init/main.c	Fri Jan 25 13:16:04 2002
+++ linux-vger/init/main.c	Tue Jan 29 03:05:40 2002
@@ -69,6 +69,7 @@
 extern void sbus_init(void);
 extern void sysctl_init(void);
 extern void signals_init(void);
+extern void ratcache_init(void) __init;
 
 extern void free_initmem(void);
 
@@ -377,7 +378,7 @@
 	proc_caches_init();
 	vfs_caches_init(mempages);
 	buffer_init(mempages);
-	page_cache_init(mempages);
+	ratcache_init();
 #if defined(CONFIG_ARCH_S390)
 	ccwcache_init();
 #endif
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/kernel/ksyms.c linux-vger/kernel/ksyms.c
--- /datenklo/ref/linux-vger/kernel/ksyms.c	Fri Jan 25 13:16:04 2002
+++ linux-vger/kernel/ksyms.c	Tue Jan 29 03:05:40 2002
@@ -218,8 +218,6 @@
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_ro_fops);
 EXPORT_SYMBOL(generic_buffer_fdatasync);
-EXPORT_SYMBOL(page_hash_bits);
-EXPORT_SYMBOL(page_hash_table);
 EXPORT_SYMBOL(file_lock_list);
 EXPORT_SYMBOL(locks_init_lock);
 EXPORT_SYMBOL(locks_copy_lock);
@@ -254,8 +252,8 @@
 EXPORT_SYMBOL(__pollwait);
 EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
-EXPORT_SYMBOL(__find_get_page);
-EXPORT_SYMBOL(__find_lock_page);
+EXPORT_SYMBOL(find_get_page);
+EXPORT_SYMBOL(find_lock_page);
 EXPORT_SYMBOL(grab_cache_page);
 EXPORT_SYMBOL(grab_cache_page_nowait);
 EXPORT_SYMBOL(read_cache_page);
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/lib/Makefile linux-vger/lib/Makefile
--- /datenklo/ref/linux-vger/lib/Makefile	Wed Jan 16 21:49:17 2002
+++ linux-vger/lib/Makefile	Tue Jan 29 03:05:40 2002
@@ -8,9 +8,10 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o rat.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
+	 bust_spinlocks.o rbtree.o rat.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/lib/rat.c linux-vger/lib/rat.c
--- /datenklo/ref/linux-vger/lib/rat.c	Thu Jan  1 01:00:00 1970
+++ linux-vger/lib/rat.c	Tue Jan 29 03:05:40 2002
@@ -0,0 +1,294 @@
+/*
+ * Copyright (C) 2001 Momchil Velikov
+ * Portions Copyright (C) 2001 Christoph Hellwig
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2, or (at
+ * your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mempool.h>
+#include <linux/module.h>
+#include <linux/rat.h>
+#include <linux/slab.h>
+
+
+/*
+ * Radix tree node definition.
+ */
+#define RAT_MAP_SHIFT		7
+#define RAT_MAP_SIZE		(1UL << RAT_MAP_SHIFT)
+#define RAT_MAP_MASK		(RAT_MAP_SIZE-1)
+
+struct rat_node {
+	unsigned int	count;
+	void		*slots[RAT_MAP_SIZE];
+};
+
+struct rat_path {
+	struct rat_node *node, **slot;
+};
+
+#define RAT_INDEX_BITS	(8/* CHAR_BIT */ * sizeof(unsigned long))
+
+/*
+ * Radix tree node cache.
+ */
+#define POOL_SIZE	32
+
+static kmem_cache_t *ratnode_cachep;
+static mempool_t *ratnode_pool;
+
+#define ratnode_alloc(root) \
+	mempool_alloc(ratnode_pool, (root)->gfp_mask)
+#define ratnode_free(node) \
+	mempool_free((node), ratnode_pool);
+
+
+/*
+ *	Return the maximum key which can be store into a
+ *	radix tree with height HEIGHT.
+ */
+static inline unsigned long rat_maxindex(unsigned int height)
+{
+	unsigned int tmp = height * RAT_MAP_SHIFT;
+	unsigned long index = (~0UL >> (RAT_INDEX_BITS - tmp - 1)) >> 1;
+
+	if (tmp >= RAT_INDEX_BITS)
+		index = ~0UL;
+	return index;
+}
+
+
+/*
+ *	Extend a radix tree so it can store key @index.
+ */
+static int rat_extend(struct rat_root *root, unsigned long index)
+{
+	struct rat_node *node;
+	unsigned int height;
+
+	/* Figure out what the height should be.  */
+	height = root->height + 1;
+	while (index > rat_maxindex(height))
+		height++;
+
+	if (root->rnode) {
+		do {
+			if (!(node = ratnode_alloc(root)))
+				return -ENOMEM;
+
+			/* Increase the height.  */
+			node->slots[0] = root->rnode;
+			if (root->rnode)
+				node->count = 1;
+			root->rnode = node;
+			root->height++;
+		} while (height > root->height);
+	} else 
+		root->height = height;
+
+	return 0;
+}
+
+
+/**
+ *	rat_reserve    -    reserve space in a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@pslot:		pointer to reserved slot
+ *
+ *	Reserve a slot in a radix tree for the key @index.
+ */
+int rat_reserve(struct rat_root *root, unsigned long index, void ***pslot)
+{
+	struct rat_node *node = NULL, *tmp, **slot;
+	unsigned int height, shift;
+	int error;
+
+	/* Make sure the tree is high enough.  */
+	if (index > rat_maxindex(root->height)) {
+		error = rat_extend(root, index);
+		if (error)
+			return error;
+	}
+    
+	slot = &root->rnode;
+	height = root->height;
+	shift = (height-1) * RAT_MAP_SHIFT;
+
+	while (height > 0) {
+		if (*slot == NULL) {
+			/* Have to add a child node.  */
+			if (!(tmp = ratnode_alloc(root)))
+				return -ENOMEM;
+			*slot = tmp;
+			if (node)
+				node->count++;
+		}
+
+		/* Go a level down.  */
+		node = *slot;
+		slot = (struct rat_node **)
+			(node->slots + ((index >> shift) & RAT_MAP_MASK));
+		shift -= RAT_MAP_SHIFT;
+		height--;
+	}
+
+	if (*slot != NULL)
+		return -EEXIST;
+	if (node)
+		node->count++;
+
+	*pslot = (void **)slot;
+	**pslot = RAT_SLOT_RESERVED;
+	return 0;
+}
+
+EXPORT_SYMBOL(rat_reserve);
+
+
+/**
+ *	rat_insert    -    insert into a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@item:		item to insert
+ *
+ *	Insert an item into the radix tree at position @index.
+ */
+int rat_insert(struct rat_root *root, unsigned long index, void *item)
+{
+	void **slot;
+	int error;
+
+	error = rat_reserve(root, index, &slot);
+	if (!error)
+		*slot = item;
+	return error;
+}
+
+EXPORT_SYMBOL(rat_insert);
+
+
+/**
+ *	rat_lookup    -    perform lookup operation on a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup them item at the position @index in the radix tree @root.
+ */
+void *rat_lookup(struct rat_root *root, unsigned long index)
+{
+	unsigned int height, shift;
+	struct rat_node **slot;
+
+	height = root->height;
+	if (index > rat_maxindex(height))
+		return NULL;
+
+	shift = (height-1) * RAT_MAP_SHIFT;
+	slot = &root->rnode;
+
+	while (height > 0) {
+		if (*slot == NULL)
+			return NULL;
+
+		slot = (struct rat_node **)
+			((*slot)->slots + ((index >> shift) & RAT_MAP_MASK));
+		shift -= RAT_MAP_SHIFT;
+		height--;
+	}
+
+	return (void *) *slot;
+}
+
+EXPORT_SYMBOL(rat_lookup);
+
+
+/**
+ *	rat_delete    -    delete an item from a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Remove the item at @index from the radix tree rooted at @root.
+ */
+int rat_delete(struct rat_root *root, unsigned long index)
+{
+	struct rat_path path[RAT_INDEX_BITS/RAT_MAP_SHIFT + 2], *pathp = path;
+	unsigned int height, shift;
+
+	height = root->height;
+	if (index > rat_maxindex(height))
+		return -ENOENT;
+
+	shift = (height-1) * RAT_MAP_SHIFT;
+	pathp->node = NULL;
+	pathp->slot = &root->rnode;
+
+	while (height > 0) {
+		if (*pathp->slot == NULL)
+			return -ENOENT;
+
+		pathp[1].node = *pathp[0].slot;
+		pathp[1].slot = (struct rat_node **)
+		    (pathp[1].node->slots + ((index >> shift) & RAT_MAP_MASK));
+		pathp++;
+		shift -= RAT_MAP_SHIFT;
+		height--;
+	}
+
+	if (*pathp[0].slot == NULL)
+		return -ENOENT;
+
+	*pathp[0].slot = NULL;
+	while (pathp[0].node && --pathp[0].node->count == 0) {
+		pathp--;
+		*pathp[0].slot = NULL;
+		ratnode_free(pathp[1].node);
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(rat_delete);
+
+
+static void ratnode_ctor(void *node, kmem_cache_t *cachep, unsigned long flags)
+{
+	memset(node, 0, sizeof(struct rat_node));
+}
+
+static void *ratnode_pool_alloc(int gfp_mask, void *data)
+{
+	return kmem_cache_alloc(ratnode_cachep, gfp_mask);
+}
+
+static void ratnode_pool_free(void *node, void *data)
+{
+	kmem_cache_free(ratnode_cachep, node);
+}
+
+void __init ratcache_init(void)
+{
+	ratnode_cachep = kmem_cache_create("ratnode", sizeof(struct rat_node),
+			0, SLAB_HWCACHE_ALIGN, ratnode_ctor, NULL);
+	if (!ratnode_cachep)
+		panic ("Failed to create ratnode cache\n");
+	ratnode_pool = mempool_create(POOL_SIZE, ratnode_pool_alloc,
+			ratnode_pool_free, NULL);
+	if (!ratnode_pool)
+		panic ("Failed to create ratnode pool\n");
+}
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/mm/filemap.c linux-vger/mm/filemap.c
--- /datenklo/ref/linux-vger/mm/filemap.c	Fri Jan 25 13:16:04 2002
+++ linux-vger/mm/filemap.c	Tue Jan 29 03:32:41 2002
@@ -44,69 +44,16 @@
  */
 
 atomic_t page_cache_size = ATOMIC_INIT(0);
-unsigned int page_hash_bits;
-struct page **page_hash_table;
 
-spinlock_t pagecache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 /*
- * NOTE: to avoid deadlocking you must never acquire the pagemap_lru_lock 
- *	with the pagecache_lock held.
- *
- * Ordering:
- *	swap_lock ->
- *		pagemap_lru_lock ->
- *			pagecache_lock
+ * The deadlock-free ordering of lock acquisition is:
+ *	pagemap_lru_lock ==> mapping_lock
  */
 spinlock_t pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 #define CLUSTER_PAGES		(1 << page_cluster)
 #define CLUSTER_OFFSET(x)	(((x) >> page_cluster) << page_cluster)
 
-static void FASTCALL(add_page_to_hash_queue(struct page * page, struct page **p));
-static void add_page_to_hash_queue(struct page * page, struct page **p)
-{
-	struct page *next = *p;
-
-	*p = page;
-	page->next_hash = next;
-	page->pprev_hash = p;
-	if (next)
-		next->pprev_hash = &page->next_hash;
-	if (page->buffers)
-		PAGE_BUG(page);
-	atomic_inc(&page_cache_size);
-}
-
-static inline void add_page_to_inode_queue(struct address_space *mapping, struct page * page)
-{
-	struct list_head *head = &mapping->clean_pages;
-
-	mapping->nrpages++;
-	list_add(&page->list, head);
-	page->mapping = mapping;
-}
-
-static inline void remove_page_from_inode_queue(struct page * page)
-{
-	struct address_space * mapping = page->mapping;
-
-	mapping->nrpages--;
-	list_del(&page->list);
-	page->mapping = NULL;
-}
-
-static inline void remove_page_from_hash_queue(struct page * page)
-{
-	struct page *next = page->next_hash;
-	struct page **pprev = page->pprev_hash;
-
-	if (next)
-		next->pprev_hash = pprev;
-	*pprev = next;
-	page->pprev_hash = NULL;
-	atomic_dec(&page_cache_size);
-}
-
 /*
  * Remove a page from the page cache and free it. Caller has to make
  * sure the page is locked and that nobody else uses it - or that usage
@@ -115,18 +62,20 @@
 void __remove_inode_page(struct page *page)
 {
 	if (PageDirty(page)) BUG();
+	rat_delete(&page->mapping->page_tree, page->index);
 	remove_page_from_inode_queue(page);
-	remove_page_from_hash_queue(page);
+	atomic_dec(&page_cache_size);
 }
 
 void remove_inode_page(struct page *page)
 {
+	struct address_space *mapping = page->mapping;
 	if (!PageLocked(page))
 		PAGE_BUG(page);
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	__remove_inode_page(page);
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 static inline int sync_page(struct page *page)
@@ -147,10 +96,10 @@
 		struct address_space *mapping = page->mapping;
 
 		if (mapping) {
-			spin_lock(&pagecache_lock);
+			spin_lock(&mapping->i_shared_lock);
 			list_del(&page->list);
 			list_add(&page->list, &mapping->dirty_pages);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 
 			if (mapping->host)
 				mark_inode_dirty_pages(mapping->host);
@@ -170,11 +119,12 @@
 {
 	struct list_head *head, *curr;
 	struct page * page;
+	struct address_space *mapping = inode->i_mapping;
 
-	head = &inode->i_mapping->clean_pages;
+	head = &mapping->clean_pages;
 
 	spin_lock(&pagemap_lru_lock);
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	curr = head->next;
 
 	while (curr != head) {
@@ -205,7 +155,7 @@
 		continue;
 	}
 
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	spin_unlock(&pagemap_lru_lock);
 }
 
@@ -244,8 +194,9 @@
 	page_cache_release(page);
 }
 
-static int FASTCALL(truncate_list_pages(struct list_head *, unsigned long, unsigned *));
-static int truncate_list_pages(struct list_head *head, unsigned long start, unsigned *partial)
+static int FASTCALL(truncate_list_pages(struct address_space *, struct list_head *, unsigned long, unsigned *));
+static int truncate_list_pages(struct address_space *mapping,
+	struct list_head *head, unsigned long start, unsigned *partial)
 {
 	struct list_head *curr;
 	struct page * page;
@@ -274,7 +225,7 @@
 				/* Restart on this page */
 				list_add(head, curr);
 
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			unlocked = 1;
 
  			if (!failed) {
@@ -295,7 +246,7 @@
 				schedule();
 			}
 
-			spin_lock(&pagecache_lock);
+			spin_lock(&mapping->i_shared_lock);
 			goto restart;
 		}
 		curr = curr->prev;
@@ -319,24 +270,28 @@
 	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
 	int unlocked;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	do {
-		unlocked = truncate_list_pages(&mapping->clean_pages, start, &partial);
-		unlocked |= truncate_list_pages(&mapping->dirty_pages, start, &partial);
-		unlocked |= truncate_list_pages(&mapping->locked_pages, start, &partial);
+		unlocked = truncate_list_pages(mapping, &mapping->clean_pages,
+						start, &partial);
+		unlocked |= truncate_list_pages(mapping, &mapping->dirty_pages,
+						start, &partial);
+		unlocked |= truncate_list_pages(mapping, &mapping->locked_pages,
+						start, &partial);
 	} while (unlocked);
 	/* Traversed all three lists without dropping the lock */
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
-static inline int invalidate_this_page2(struct page * page,
+static inline int invalidate_this_page2(struct address_space *mapping,
+					struct page * page,
 					struct list_head * curr,
 					struct list_head * head)
 {
 	int unlocked = 1;
 
 	/*
-	 * The page is locked and we hold the pagecache_lock as well
+	 * The page is locked and we hold the mapping lock as well
 	 * so both page_count(page) and page->buffers stays constant here.
 	 */
 	if (page_count(page) == 1 + !!page->buffers) {
@@ -345,7 +300,7 @@
 		list_add_tail(head, curr);
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 		truncate_complete_page(page);
 	} else {
 		if (page->buffers) {
@@ -354,7 +309,7 @@
 			list_add_tail(head, curr);
 
 			page_cache_get(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			block_invalidate_page(page);
 		} else
 			unlocked = 0;
@@ -366,8 +321,8 @@
 	return unlocked;
 }
 
-static int FASTCALL(invalidate_list_pages2(struct list_head *));
-static int invalidate_list_pages2(struct list_head *head)
+static int FASTCALL(invalidate_list_pages2(struct address_space *mapping, struct list_head *));
+static int invalidate_list_pages2(struct address_space *mapping, struct list_head *head)
 {
 	struct list_head *curr;
 	struct page * page;
@@ -381,7 +336,7 @@
 		if (!TryLockPage(page)) {
 			int __unlocked;
 
-			__unlocked = invalidate_this_page2(page, curr, head);
+			__unlocked = invalidate_this_page2(mapping, page, curr, head);
 			UnlockPage(page);
 			unlocked |= __unlocked;
 			if (!__unlocked) {
@@ -394,7 +349,7 @@
 			list_add(head, curr);
 
 			page_cache_get(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			unlocked = 1;
 			wait_on_page(page);
 		}
@@ -405,7 +360,7 @@
 			schedule();
 		}
 
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 		goto restart;
 	}
 	return unlocked;
@@ -420,32 +375,13 @@
 {
 	int unlocked;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	do {
-		unlocked = invalidate_list_pages2(&mapping->clean_pages);
-		unlocked |= invalidate_list_pages2(&mapping->dirty_pages);
-		unlocked |= invalidate_list_pages2(&mapping->locked_pages);
+		unlocked = invalidate_list_pages2(mapping, &mapping->clean_pages);
+		unlocked |= invalidate_list_pages2(mapping, &mapping->dirty_pages);
+		unlocked |= invalidate_list_pages2(mapping, &mapping->locked_pages);
 	} while (unlocked);
-	spin_unlock(&pagecache_lock);
-}
-
-static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
-{
-	goto inside;
-
-	for (;;) {
-		page = page->next_hash;
-inside:
-		if (!page)
-			goto not_found;
-		if (page->mapping != mapping)
-			continue;
-		if (page->index == offset)
-			break;
-	}
-
-not_found:
-	return page;
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 /*
@@ -483,13 +419,14 @@
 	return error;
 }
 
-static int do_buffer_fdatasync(struct list_head *head, unsigned long start, unsigned long end, int (*fn)(struct page *))
+static int do_buffer_fdatasync(struct address_space *mapping,
+	struct list_head *head, unsigned long start, unsigned long end, int (*fn)(struct page *))
 {
 	struct list_head *curr;
 	struct page *page;
 	int retval = 0;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 	curr = head->next;
 	while (curr != head) {
 		page = list_entry(curr, struct page, list);
@@ -502,7 +439,7 @@
 			continue;
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 		lock_page(page);
 
 		/* The buffers could have been free'd while we waited for the page lock */
@@ -510,11 +447,11 @@
 			retval |= fn(page);
 
 		UnlockPage(page);
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 		curr = page->list.next;
 		page_cache_release(page);
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 
 	return retval;
 }
@@ -525,17 +462,18 @@
  */
 int generic_buffer_fdatasync(struct inode *inode, unsigned long start_idx, unsigned long end_idx)
 {
+	struct address_space *mapping = inode->i_mapping;
 	int retval;
 
 	/* writeout dirty buffers on pages from both clean and dirty lists */
-	retval = do_buffer_fdatasync(&inode->i_mapping->dirty_pages, start_idx, end_idx, writeout_one_page);
-	retval |= do_buffer_fdatasync(&inode->i_mapping->clean_pages, start_idx, end_idx, writeout_one_page);
-	retval |= do_buffer_fdatasync(&inode->i_mapping->locked_pages, start_idx, end_idx, writeout_one_page);
+	retval = do_buffer_fdatasync(mapping, &mapping->dirty_pages, start_idx, end_idx, writeout_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->clean_pages, start_idx, end_idx, writeout_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->locked_pages, start_idx, end_idx, writeout_one_page);
 
 	/* now wait for locked buffers on pages from both clean and dirty lists */
-	retval |= do_buffer_fdatasync(&inode->i_mapping->dirty_pages, start_idx, end_idx, waitfor_one_page);
-	retval |= do_buffer_fdatasync(&inode->i_mapping->clean_pages, start_idx, end_idx, waitfor_one_page);
-	retval |= do_buffer_fdatasync(&inode->i_mapping->locked_pages, start_idx, end_idx, waitfor_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->dirty_pages, start_idx, end_idx, waitfor_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->clean_pages, start_idx, end_idx, waitfor_one_page);
+	retval |= do_buffer_fdatasync(mapping, &mapping->locked_pages, start_idx, end_idx, waitfor_one_page);
 
 	return retval;
 }
@@ -580,7 +518,7 @@
 {
 	int (*writepage)(struct page *) = mapping->a_ops->writepage;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 
         while (!list_empty(&mapping->dirty_pages)) {
 		struct page *page = list_entry(mapping->dirty_pages.next, struct page, list);
@@ -592,7 +530,7 @@
 			continue;
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 
 		lock_page(page);
 
@@ -603,9 +541,9 @@
 			UnlockPage(page);
 
 		page_cache_release(page);
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 /**
@@ -617,7 +555,7 @@
  */
 void filemap_fdatawait(struct address_space * mapping)
 {
-	spin_lock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
 
         while (!list_empty(&mapping->locked_pages)) {
 		struct page *page = list_entry(mapping->locked_pages.next, struct page, list);
@@ -629,83 +567,57 @@
 			continue;
 
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 
 		___wait_on_page(page);
 
 		page_cache_release(page);
-		spin_lock(&pagecache_lock);
+		spin_lock(&mapping->i_shared_lock);
 	}
-	spin_unlock(&pagecache_lock);
-}
-
-/*
- * Add a page to the inode page cache.
- *
- * The caller must have locked the page and 
- * set all the page flags correctly..
- */
-void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index)
-{
-	if (!PageLocked(page))
-		BUG();
-
-	page->index = index;
-	page_cache_get(page);
-	spin_lock(&pagecache_lock);
-	add_page_to_inode_queue(mapping, page);
-	add_page_to_hash_queue(page, page_hash(mapping, index));
-	spin_unlock(&pagecache_lock);
-
-	lru_cache_add(page);
+	spin_unlock(&mapping->i_shared_lock);
 }
 
 /*
  * This adds a page to the page cache, starting out as locked,
  * owned by us, but unreferenced, not uptodate and with no errors.
  */
-static inline void __add_to_page_cache(struct page * page,
-	struct address_space *mapping, unsigned long offset,
-	struct page **hash)
+static int __add_to_page_cache(struct page * page, struct address_space *mapping,
+				      unsigned long offset)
 {
 	unsigned long flags;
+	int error;
 
-	flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_dirty | 1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked);
-	page->flags = flags | (1 << PG_locked);
 	page_cache_get(page);
+	if ((error = rat_insert(&mapping->page_tree, offset, page)))
+		goto fail;
+	flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error |
+				1 << PG_dirty | 1 << PG_referenced |
+				1 << PG_arch_1 | 1 << PG_checked);
+	page->flags = flags | (1 << PG_locked);
 	page->index = offset;
 	add_page_to_inode_queue(mapping, page);
-	add_page_to_hash_queue(page, hash);
-}
 
-void add_to_page_cache(struct page * page, struct address_space * mapping, unsigned long offset)
-{
-	spin_lock(&pagecache_lock);
-	__add_to_page_cache(page, mapping, offset, page_hash(mapping, offset));
-	spin_unlock(&pagecache_lock);
-	lru_cache_add(page);
+	atomic_inc(&page_cache_size);
+	return 0;
+fail:
+	page_cache_release(page);
+	return error;
 }
 
-int add_to_page_cache_unique(struct page * page,
-	struct address_space *mapping, unsigned long offset,
-	struct page **hash)
+int add_to_page_cache(struct page *page, struct address_space *mapping,
+		      unsigned long offset)
 {
-	int err;
-	struct page *alias;
-
-	spin_lock(&pagecache_lock);
-	alias = __find_page_nolock(mapping, offset, *hash);
-
-	err = 1;
-	if (!alias) {
-		__add_to_page_cache(page,mapping,offset,hash);
-		err = 0;
-	}
+	int error;
 
-	spin_unlock(&pagecache_lock);
-	if (!err)
-		lru_cache_add(page);
-	return err;
+	spin_lock(&mapping->i_shared_lock);
+	if ((error = __add_to_page_cache(page, mapping, offset)))
+		goto fail;
+	spin_unlock(&mapping->i_shared_lock);
+	lru_cache_add(page);
+	return 0;
+fail:
+	spin_unlock(&mapping->i_shared_lock);
+	return -ENOMEM;
 }
 
 /*
@@ -716,12 +628,12 @@
 static int page_cache_read(struct file * file, unsigned long offset)
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	struct page **hash = page_hash(mapping, offset);
 	struct page *page; 
+	int error;
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	page = rat_lookup(&mapping->page_tree, offset);
+	spin_unlock(&mapping->i_shared_lock);
 	if (page)
 		return 0;
 
@@ -729,11 +641,18 @@
 	if (!page)
 		return -ENOMEM;
 
-	if (!add_to_page_cache_unique(page, mapping, offset, hash)) {
-		int error = mapping->a_ops->readpage(file, page);
+	while ((error = add_to_page_cache(page, mapping, offset)) == -ENOMEM) {
+		/* Yield for kswapd, and try again */
+		__set_current_state(TASK_RUNNING);
+		yield();
+	}
+
+	if (!error) {
+		error = mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
 		return error;
 	}
+
 	/*
 	 * We arrive here in the unlikely event that someone 
 	 * raced with us and added our page to the cache first.
@@ -837,8 +756,7 @@
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */
-struct page * __find_get_page(struct address_space *mapping,
-			      unsigned long offset, struct page **hash)
+struct page * find_get_page(struct address_space *mapping, unsigned long offset)
 {
 	struct page *page;
 
@@ -846,11 +764,11 @@
 	 * We scan the hash list read-only. Addition to and removal from
 	 * the hash-list needs a held write-lock.
 	 */
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
+	spin_lock(&mapping->i_shared_lock);
+	page = rat_lookup(&mapping->page_tree, offset);
 	if (page)
 		page_cache_get(page);
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	return page;
 }
 
@@ -860,15 +778,14 @@
 struct page *find_trylock_page(struct address_space *mapping, unsigned long offset)
 {
 	struct page *page;
-	struct page **hash = page_hash(mapping, offset);
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(mapping, offset, *hash);
+	spin_lock(&mapping->i_shared_lock);
+	page = rat_lookup(&mapping->page_tree, offset);
 	if (page) {
 		if (TryLockPage(page))
 			page = NULL;
 	}
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&mapping->i_shared_lock);
 	return page;
 }
 
@@ -877,9 +794,9 @@
  * will return with it held (but it may be dropped
  * during blocking operations..
  */
-static struct page * FASTCALL(__find_lock_page_helper(struct address_space *, unsigned long, struct page *));
-static struct page * __find_lock_page_helper(struct address_space *mapping,
-					unsigned long offset, struct page *hash)
+static struct page * FASTCALL(find_lock_page_helper(struct address_space *, unsigned long));
+static struct page * find_lock_page_helper(struct address_space *mapping,
+					unsigned long offset)
 {
 	struct page *page;
 
@@ -888,13 +805,13 @@
 	 * the hash-list needs a held write-lock.
 	 */
 repeat:
-	page = __find_page_nolock(mapping, offset, hash);
+	page = rat_lookup(&mapping->page_tree, offset);
 	if (page) {
 		page_cache_get(page);
 		if (TryLockPage(page)) {
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			lock_page(page);
-			spin_lock(&pagecache_lock);
+			spin_lock(&mapping->i_shared_lock);
 
 			/* Has the page been re-allocated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
@@ -911,39 +828,40 @@
  * Same as the above, but lock the page too, verifying that
  * it's still valid once we own it.
  */
-struct page * __find_lock_page (struct address_space *mapping,
-				unsigned long offset, struct page **hash)
+struct page * find_lock_page(struct address_space *mapping, unsigned long offset)
 {
 	struct page *page;
 
-	spin_lock(&pagecache_lock);
-	page = __find_lock_page_helper(mapping, offset, *hash);
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	page = find_lock_page_helper(mapping, offset);
+	spin_unlock(&mapping->i_shared_lock);
+
 	return page;
 }
 
 /*
  * Same as above, but create the page if required..
  */
-struct page * find_or_create_page(struct address_space *mapping, unsigned long index, unsigned int gfp_mask)
+struct page * find_or_create_page(struct address_space *mapping,
+				  unsigned long index, unsigned int gfp_mask)
 {
 	struct page *page;
-	struct page **hash = page_hash(mapping, index);
 
-	spin_lock(&pagecache_lock);
-	page = __find_lock_page_helper(mapping, index, *hash);
-	spin_unlock(&pagecache_lock);
+	spin_lock(&mapping->i_shared_lock);
+	page = find_lock_page_helper(mapping, index);
+	spin_unlock(&mapping->i_shared_lock);
 	if (!page) {
 		struct page *newpage = alloc_page(gfp_mask);
 		if (newpage) {
-			spin_lock(&pagecache_lock);
-			page = __find_lock_page_helper(mapping, index, *hash);
+			spin_lock(&mapping->i_shared_lock);
+			page = find_lock_page_helper(mapping, index);
 			if (likely(!page)) {
-				page = newpage;
-				__add_to_page_cache(page, mapping, index, hash);
-				newpage = NULL;
+				if (!__add_to_page_cache(newpage, mapping, index)) {
+					page = newpage;
+					newpage = NULL;
+				}
 			}
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			if (newpage == NULL)
 				lru_cache_add(page);
 			else 
@@ -970,10 +888,9 @@
  */
 struct page *grab_cache_page_nowait(struct address_space *mapping, unsigned long index)
 {
-	struct page *page, **hash;
+	struct page *page;
 
-	hash = page_hash(mapping, index);
-	page = __find_get_page(mapping, index, hash);
+	page = find_get_page(mapping, index);
 
 	if ( page ) {
 		if ( !TryLockPage(page) ) {
@@ -998,7 +915,7 @@
 	if ( unlikely(!page) )
 		return NULL;	/* Failed to allocate a page */
 
-	if ( unlikely(add_to_page_cache_unique(page, mapping, index, hash)) ) {
+	if (unlikely(add_to_page_cache(page, mapping, index)) ) {
 		/* Someone else grabbed the page already. */
 		page_cache_release(page);
 		return NULL;
@@ -1323,7 +1240,7 @@
 	}
 
 	for (;;) {
-		struct page *page, **hash;
+		struct page *page;
 		unsigned long end_index, nr, ret;
 
 		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
@@ -1342,15 +1259,14 @@
 		/*
 		 * Try to find the data in the page cache..
 		 */
-		hash = page_hash(mapping, index);
 
-		spin_lock(&pagecache_lock);
-		page = __find_page_nolock(mapping, index, *hash);
+		spin_lock(&mapping->i_shared_lock);
+		page = rat_lookup(&mapping->page_tree, index);
 		if (!page)
 			goto no_cached_page;
 found_page:
 		page_cache_get(page);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 
 		if (!Page_Uptodate(page))
 			goto page_not_up_to_date;
@@ -1444,7 +1360,7 @@
 		 * We get here with the page cache lock held.
 		 */
 		if (!cached_page) {
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			cached_page = page_cache_alloc(mapping);
 			if (!cached_page) {
 				desc->error = -ENOMEM;
@@ -1455,8 +1371,8 @@
 			 * Somebody may have added the page while we
 			 * dropped the page cache lock. Check for that.
 			 */
-			spin_lock(&pagecache_lock);
-			page = __find_page_nolock(mapping, index, *hash);
+			spin_lock(&mapping->i_shared_lock);
+			page = rat_lookup(&mapping->page_tree, index);
 			if (page)
 				goto found_page;
 		}
@@ -1464,9 +1380,13 @@
 		/*
 		 * Ok, add the new page to the hash-queues...
 		 */
+		if (__add_to_page_cache(cached_page, mapping, index) == -ENOMEM) {
+			spin_unlock (&mapping->i_shared_lock);
+			desc->error = -ENOMEM;
+			break;
+		}
 		page = cached_page;
-		__add_to_page_cache(page, mapping, index, hash);
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&mapping->i_shared_lock);
 		lru_cache_add(page);		
 		cached_page = NULL;
 
@@ -1866,7 +1786,7 @@
 	struct file *file = area->vm_file;
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	struct inode *inode = mapping->host;
-	struct page *page, **hash;
+	struct page *page;
 	unsigned long size, pgoff, endoff;
 
 	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
@@ -1888,9 +1808,8 @@
 	/*
 	 * Do we have something in the page cache already?
 	 */
-	hash = page_hash(mapping, pgoff);
 retry_find:
-	page = __find_get_page(mapping, pgoff, hash);
+	page = find_get_page(mapping, pgoff);
 	if (!page)
 		goto no_cached_page;
 
@@ -2575,13 +2494,13 @@
 {
 	unsigned char present = 0;
 	struct address_space * as = vma->vm_file->f_dentry->d_inode->i_mapping;
-	struct page * page, ** hash = page_hash(as, pgoff);
+	struct page * page;
 
-	spin_lock(&pagecache_lock);
-	page = __find_page_nolock(as, pgoff, *hash);
+	spin_lock(&as->i_shared_lock);
+	page = rat_lookup(&as->page_tree, pgoff);
 	if ((page) && (Page_Uptodate(page)))
 		present = 1;
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&as->i_shared_lock);
 
 	return present;
 }
@@ -2724,20 +2643,24 @@
 				int (*filler)(void *,struct page*),
 				void *data)
 {
-	struct page **hash = page_hash(mapping, index);
 	struct page *page, *cached_page = NULL;
 	int err;
 repeat:
-	page = __find_get_page(mapping, index, hash);
+	page = find_get_page(mapping, index);
 	if (!page) {
 		if (!cached_page) {
 			cached_page = page_cache_alloc(mapping);
 			if (!cached_page)
 				return ERR_PTR(-ENOMEM);
 		}
-		page = cached_page;
-		if (add_to_page_cache_unique(page, mapping, index, hash))
+		err = add_to_page_cache(cached_page, mapping, index);
+		if (err == -EEXIST)
 			goto repeat;
+		if (err < 0) {
+			page_cache_release(cached_page);
+			return ERR_PTR(err);
+		}
+		page = cached_page;
 		cached_page = NULL;
 		err = filler(data, page);
 		if (err < 0) {
@@ -2792,19 +2715,23 @@
 static inline struct page * __grab_cache_page(struct address_space *mapping,
 				unsigned long index, struct page **cached_page)
 {
-	struct page *page, **hash = page_hash(mapping, index);
+	int err;
+	struct page *page;
 repeat:
-	page = __find_lock_page(mapping, index, hash);
+	page = find_lock_page(mapping, index);
 	if (!page) {
 		if (!*cached_page) {
 			*cached_page = page_cache_alloc(mapping);
 			if (!*cached_page)
 				return NULL;
 		}
-		page = *cached_page;
-		if (add_to_page_cache_unique(page, mapping, index, hash))
+		err = add_to_page_cache(*cached_page, mapping, index);
+		if (err == -EEXIST)
 			goto repeat;
-		*cached_page = NULL;
+		if (err == 0) {
+			page = *cached_page;
+			*cached_page = NULL;
+		}
 	}
 	return page;
 }
@@ -3064,30 +2991,3 @@
 		status = generic_osync_inode(inode, OSYNC_METADATA);
 	goto out_status;
 }
-
-void __init page_cache_init(unsigned long mempages)
-{
-	unsigned long htable_size, order;
-
-	htable_size = mempages;
-	htable_size *= sizeof(struct page *);
-	for(order = 0; (PAGE_SIZE << order) < htable_size; order++)
-		;
-
-	do {
-		unsigned long tmp = (PAGE_SIZE << order) / sizeof(struct page *);
-
-		page_hash_bits = 0;
-		while((tmp >>= 1UL) != 0UL)
-			page_hash_bits++;
-
-		page_hash_table = (struct page **)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while(page_hash_table == NULL && --order > 0);
-
-	printk("Page-cache hash table entries: %d (order: %ld, %ld bytes)\n",
-	       (1 << page_hash_bits), order, (PAGE_SIZE << order));
-	if (!page_hash_table)
-		panic("Failed to allocate page hash table\n");
-	memset((void *)page_hash_table, 0, PAGE_HASH_SIZE * sizeof(struct page *));
-}
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/mm/shmem.c linux-vger/mm/shmem.c
--- /datenklo/ref/linux-vger/mm/shmem.c	Fri Jan 25 13:16:06 2002
+++ linux-vger/mm/shmem.c	Tue Jan 29 03:20:18 2002
@@ -366,7 +366,7 @@
 	swp_entry_t *ptr;
 	unsigned long idx;
 	int offset;
-	
+
 	idx = 0;
 	spin_lock (&info->lock);
 	offset = shmem_clear_swp (entry, info->i_direct, SHMEM_NR_DIRECT);
@@ -385,11 +385,8 @@
 	spin_unlock (&info->lock);
 	return 0;
 found:
-	delete_from_swap_cache(page);
-	add_to_page_cache(page, info->vfs_inode.i_mapping, offset + idx);
-	SetPageDirty(page);
-	SetPageUptodate(page);
-	info->swapped--;
+	if (!move_from_swap_cache(page, offset + idx, info->vfs_inode.i_mapping))
+		info->swapped--;
 	spin_unlock(&info->lock);
 	return 1;
 }
@@ -426,6 +423,7 @@
 	struct address_space *mapping;
 	unsigned long index;
 	struct inode *inode;
+	int error;
 
 	if (!PageLocked(page))
 		BUG();
@@ -438,7 +436,6 @@
 	info = SHMEM_I(inode);
 	if (info->locked)
 		return fail_writepage(page);
-getswap:
 	swap = get_swap_page();
 	if (!swap.val)
 		return fail_writepage(page);
@@ -451,21 +448,12 @@
 	if (entry->val)
 		BUG();
 
-	/* Remove it from the page cache */
-	remove_inode_page(page);
-	page_cache_release(page);
-
-	/* Add it to the swap cache */
-	if (add_to_swap_cache(page, swap) != 0) {
-		/*
-		 * Raced with "speculative" read_swap_cache_async.
-		 * Add page back to page cache, unref swap, try again.
-		 */
-		add_to_page_cache_locked(page, mapping, index);
+	error = move_to_swap_cache(page, swap);
+	if (error) {
 		spin_unlock(&info->lock);
 		swap_free(swap);
-		goto getswap;
-	}
+		return fail_writepage(page);
+	} 
 
 	*entry = swap;
 	info->swapped++;
@@ -520,8 +508,6 @@
 	
 	shmem_recalc_inode(inode);
 	if (entry->val) {
-		unsigned long flags;
-
 		/* Look it up and read it in.. */
 		page = find_get_page(&swapper_space, entry->val);
 		if (!page) {
@@ -546,16 +532,15 @@
 			goto repeat;
 		}
 
-		/* We have to this with page locked to prevent races */
+		/* We have to do this with page locked to prevent races */
 		if (TryLockPage(page)) 
 			goto wait_retry;
 
+		if (move_from_swap_cache(page, idx, mapping))
+			goto nomem_retry;
+
 		swap_free(*entry);
 		*entry = (swp_entry_t) {0};
-		delete_from_swap_cache(page);
-		flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_referenced) | (1 << PG_arch_1));
-		page->flags = flags | (1 << PG_dirty);
-		add_to_page_cache_locked(page, mapping, idx);
 		info->swapped--;
 		spin_unlock (&info->lock);
 	} else {
@@ -579,7 +564,11 @@
 			return ERR_PTR(-ENOMEM);
 		clear_highpage(page);
 		inode->i_blocks += BLOCKS_PER_PAGE;
-		add_to_page_cache (page, mapping, idx);
+		while (add_to_page_cache(page, mapping, idx) == -ENOMEM) {
+			/* Yield for kswapd, and try again */
+			__set_current_state(TASK_RUNNING);
+			yield();
+		}
 	}
 
 	/* We have the page */
@@ -594,6 +583,16 @@
 	wait_on_page(page);
 	page_cache_release(page);
 	goto repeat;
+
+nomem_retry:
+	spin_unlock (&info->lock);
+	UnlockPage (page);
+	page_cache_release (page);
+
+	/* Yield for kswapd, and try again */
+	__set_current_state(TASK_RUNNING);
+	yield();
+	goto repeat;
 }
 
 static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/mm/swap_state.c linux-vger/mm/swap_state.c
--- /datenklo/ref/linux-vger/mm/swap_state.c	Mon Nov 12 18:19:54 2001
+++ linux-vger/mm/swap_state.c	Tue Jan 29 03:30:00 2002
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/rat.h>
 
 #include <asm/pgtable.h>
 
@@ -37,11 +38,12 @@
 };
 
 struct address_space swapper_space = {
-	LIST_HEAD_INIT(swapper_space.clean_pages),
-	LIST_HEAD_INIT(swapper_space.dirty_pages),
-	LIST_HEAD_INIT(swapper_space.locked_pages),
-	0,				/* nrpages	*/
-	&swap_aops,
+	page_tree:	{0, GFP_ATOMIC, NULL},
+	clean_pages:	LIST_HEAD_INIT(swapper_space.clean_pages),
+	dirty_pages:	LIST_HEAD_INIT(swapper_space.dirty_pages),
+	locked_pages:	LIST_HEAD_INIT(swapper_space.locked_pages),
+	a_ops:		&swap_aops,
+	i_shared_lock:	SPIN_LOCK_UNLOCKED,
 };
 
 #ifdef SWAP_CACHE_INFO
@@ -69,17 +71,20 @@
 
 int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
+	int error;
+
 	if (page->mapping)
 		BUG();
 	if (!swap_duplicate(entry)) {
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
-	if (add_to_page_cache_unique(page, &swapper_space, entry.val,
-			page_hash(&swapper_space, entry.val)) != 0) {
+
+	error = add_to_page_cache(page, &swapper_space, entry.val);
+	if (error) {
 		swap_free(entry);
 		INC_CACHE_INFO(exist_race);
-		return -EEXIST;
+		return error;
 	}
 	if (!PageLocked(page))
 		BUG();
@@ -121,14 +126,100 @@
 
 	entry.val = page->index;
 
-	spin_lock(&pagecache_lock);
+	spin_lock(&swapper_space.i_shared_lock);
 	__delete_from_swap_cache(page);
-	spin_unlock(&pagecache_lock);
+	spin_unlock(&swapper_space.i_shared_lock);
 
 	swap_free(entry);
 	page_cache_release(page);
 }
 
+int move_to_swap_cache(struct page *page, swp_entry_t entry)
+{
+	struct address_space *mapping = page->mapping;
+	void **pslot;
+	int err;
+
+	if (!mapping)
+		BUG();
+
+	if (!swap_duplicate(entry)) {
+		INC_CACHE_INFO(noent_race);
+		return -ENOENT;
+	}
+
+	spin_lock(&swapper_space.i_shared_lock);
+	spin_lock(&mapping->i_shared_lock);
+
+	err = rat_reserve(&swapper_space.page_tree, entry.val, &pslot);
+	if (!err) {
+		/* Remove it from the page cache */
+		__remove_inode_page(page);
+
+		/* Add it to the swap cache */
+		*pslot = page;
+		page->flags = ((page->flags & ~(1 << PG_uptodate | 1 << PG_error
+						| 1 << PG_dirty  | 1 << PG_referenced
+						| 1 << PG_arch_1 | 1 << PG_checked))
+			       | (1 << PG_locked));
+		page->index = entry.val;
+		add_page_to_inode_queue(&swapper_space, page);
+		atomic_inc(&page_cache_size);
+	}
+
+	spin_unlock(&mapping->i_shared_lock);
+	spin_unlock(&swapper_space.i_shared_lock);
+
+	if (!err) {
+		INC_CACHE_INFO(add_total);
+		return 0;
+	}
+
+	swap_free(entry);
+
+	if (err == -EEXIST)
+		INC_CACHE_INFO(exist_race);
+
+	return err;
+}
+
+int move_from_swap_cache(struct page *page, unsigned long index,
+		struct address_space *mapping)
+{
+	void **pslot;
+	int err;
+
+	if (!PageLocked(page))
+		BUG();
+
+	spin_lock(&swapper_space.i_shared_lock);
+	spin_lock(&mapping->i_shared_lock);
+
+	err = rat_reserve(&mapping->page_tree, index, &pslot);
+	if (!err) {
+		swp_entry_t entry;
+
+		block_flushpage(page, 0);
+		entry.val = page->index;
+		__delete_from_swap_cache(page);
+		swap_free(entry);
+
+		*pslot = page;
+		page->flags = ((page->flags & ~(1 << PG_uptodate | 1 << PG_error
+						| 1 << PG_referenced | 1 << PG_arch_1
+						| 1 << PG_checked))
+			       | (1 << PG_dirty));
+		page->index = index;
+		add_page_to_inode_queue (mapping, page);
+		atomic_inc(&page_cache_size);
+	}
+
+	spin_lock(&mapping->i_shared_lock);
+	spin_lock(&swapper_space.i_shared_lock);
+
+	return err;
+}
+
 /* 
  * Perform a free_page(), also freeing any swap cache associated with
  * this page if it is the last user of the page. Can not do a lock_page,
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/mm/swapfile.c linux-vger/mm/swapfile.c
--- /datenklo/ref/linux-vger/mm/swapfile.c	Fri Jan 25 13:16:06 2002
+++ linux-vger/mm/swapfile.c	Tue Jan 29 03:05:40 2002
@@ -239,10 +239,10 @@
 		/* Is the only swap cache user the cache itself? */
 		if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
-			spin_lock(&pagecache_lock);
+			spin_lock(&swapper_space.i_shared_lock);
 			if (page_count(page) - !!page->buffers == 2)
 				retval = 1;
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&swapper_space.i_shared_lock);
 		}
 		swap_info_put(p);
 	}
@@ -307,13 +307,13 @@
 	retval = 0;
 	if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
-		spin_lock(&pagecache_lock);
+		spin_lock(&swapper_space.i_shared_lock);
 		if (page_count(page) - !!page->buffers == 2) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		spin_unlock(&pagecache_lock);
+		spin_unlock(&swapper_space.i_shared_lock);
 	}
 	swap_info_put(p);
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/mm/vmscan.c linux-vger/mm/vmscan.c
--- /datenklo/ref/linux-vger/mm/vmscan.c	Fri Jan 25 13:16:06 2002
+++ linux-vger/mm/vmscan.c	Tue Jan 29 03:12:59 2002
@@ -137,10 +137,16 @@
 		 * (adding to the page cache will clear the dirty
 		 * and uptodate bits, so we need to do it again)
 		 */
-		if (add_to_swap_cache(page, entry) == 0) {
+		switch (add_to_swap_cache(page, entry)) {
+		case 0:
 			SetPageUptodate(page);
 			set_page_dirty(page);
 			goto set_swap_pte;
+		case -ENOMEM:
+			swap_free(entry);
+			goto preserve;
+		default:
+			break;
 		}
 		/* Raced with "speculative" read_swap_cache_async */
 		swap_free(entry);
@@ -338,6 +344,7 @@
 static int shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int priority)
 {
 	struct list_head * entry;
+	struct address_space *mapping;
 	int max_scan = nr_inactive_pages / priority;
 	int max_mapped = nr_pages << (9 - priority);
 
@@ -392,7 +399,9 @@
 			continue;
 		}
 
-		if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping) {
+		mapping = page->mapping;
+
+		if (PageDirty(page) && is_page_cache_freeable(page) && mapping) {
 			/*
 			 * It is not critical here to write it only if
 			 * the page is unmapped beause any direct writer
@@ -403,7 +412,7 @@
 			 */
 			int (*writepage)(struct page *);
 
-			writepage = page->mapping->a_ops->writepage;
+			writepage = mapping->a_ops->writepage;
 			if ((gfp_mask & __GFP_FS) && writepage) {
 				ClearPageDirty(page);
 				SetPageLaunder(page);
@@ -430,7 +439,7 @@
 			page_cache_get(page);
 
 			if (try_to_release_page(page, gfp_mask)) {
-				if (!page->mapping) {
+				if (!mapping) {
 					/*
 					 * We must not allow an anon page
 					 * with no buffers to be visible on
@@ -467,13 +476,22 @@
 			}
 		}
 
-		spin_lock(&pagecache_lock);
+		/*
+		 * Page is locked, so mapping can't change under our
+		 * feet.
+		 */
+		if (!mapping) {
+			UnlockPage (page);
+			goto page_mapped;
+		}
+
+		spin_lock(&mapping->i_shared_lock);
 
 		/*
 		 * this is the non-racy check for busy page.
 		 */
-		if (!page->mapping || !is_page_cache_freeable(page)) {
-			spin_unlock(&pagecache_lock);
+		if (!is_page_cache_freeable(page)) {
+			spin_unlock(&mapping->i_shared_lock);
 			UnlockPage(page);
 page_mapped:
 			if (--max_mapped >= 0)
@@ -493,7 +511,7 @@
 		 * the page is freeable* so not in use by anybody.
 		 */
 		if (PageDirty(page)) {
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			UnlockPage(page);
 			continue;
 		}
@@ -501,12 +519,12 @@
 		/* point of no return */
 		if (likely(!PageSwapCache(page))) {
 			__remove_inode_page(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 		} else {
 			swp_entry_t swap;
 			swap.val = page->index;
 			__delete_from_swap_cache(page);
-			spin_unlock(&pagecache_lock);
+			spin_unlock(&mapping->i_shared_lock);
 			swap_free(swap);
 		}
 
