Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbTD1UAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 16:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTD1UAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 16:00:40 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:16063 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261261AbTD1UA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 16:00:29 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: [RFC] Page prefetch ver. 0.1 for 2.5.68-mm2
Date: Mon, 28 Apr 2003 22:12:16 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_2sYr+jSfyPpLbgI";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200304282212.39102.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_2sYr+jSfyPpLbgI
Content-Type: multipart/mixed;
  boundary="Boundary-01=_gsYr+1MBKZnvkJQ"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_gsYr+1MBKZnvkJQ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

This is a working version of the idea posted on the LKML a few weeks ago...

Currently it only works when loaded as a module. Then a kernel thread=20
'kprefetchd' is started which prefetches swap and buffer pages when there i=
s=20
free buffer memory. When the module is unloaded the kernel thread is stoppe=
d=20
again.

=46or me it works as expected and has no noticeable negative impact. But so=
me=20
benchmarks should be performed to ensure this...

Besides from the problem that this works only as a module, yet, there are a=
=20
few points which could be improved when I've got some spare time...
=46or example I should take care of the disk I/O usage before prefetching. =
The=20
list of swapped pages is growing too much, too. It can be seen be doing a
   grep swapped_entry /proc/slabinfo
An other point is that it doesn't work on NFS file systems as I set the fil=
e=20
pointer to NULL for do_page_chache_readahead().

And I'm open for any other further improvements.
I hope someone else likes that patch as much as I do... ;-)

Best regards
   Thomas Schlichter

P.S.: For those who want it I've got a patch that applies on vanilla 2.5.68=
,=20
too...

--Boundary-01=_gsYr+1MBKZnvkJQ
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="page_prefetch-2.5.68-mm2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="page_prefetch-2.5.68-mm2.diff"

diff -urP linux-2.5.68-mm2/arch/i386/Kconfig linux-2.5.68_patched/arch/i386=
/Kconfig
=2D-- linux-2.5.68-mm2/arch/i386/Kconfig	Mon Apr 28 20:41:41 2003
+++ linux-2.5.68_patched/arch/i386/Kconfig	Mon Apr 28 12:05:07 2003
@@ -373,6 +373,14 @@
 	depends on MK8 || MPENTIUM4
 	default y
=20
+config PAGE_PREFETCH
+	tristate "Prefetch swapped memory pages (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  This option enables the kernel to prefetch swapped memory pages
+	  when idle. This feature is experimental and known not to work
+	  with the NFS filesystem!
+
 config HUGETLB_PAGE
 	bool "Huge TLB Page Support"
 	help
diff -urP linux-2.5.68-mm2/fs/inode.c linux-2.5.68_patched/fs/inode.c
=2D-- linux-2.5.68-mm2/fs/inode.c	Sun Apr 20 04:51:13 2003
+++ linux-2.5.68_patched/fs/inode.c	Mon Apr 28 12:05:07 2003
@@ -18,6 +18,7 @@
 #include <linux/hash.h>
 #include <linux/swap.h>
 #include <linux/security.h>
+#include <linux/page_prefetch.h>
=20
 /*
  * This is needed for the following functions:
@@ -176,10 +177,12 @@
 	INIT_LIST_HEAD(&inode->i_data.clean_pages);
 	INIT_LIST_HEAD(&inode->i_data.dirty_pages);
 	INIT_LIST_HEAD(&inode->i_data.locked_pages);
+	INIT_LIST_HEAD(&inode->i_data.swapped_pages);
 	INIT_LIST_HEAD(&inode->i_data.io_pages);
 	INIT_LIST_HEAD(&inode->i_dentry);
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
+	INIT_RADIX_TREE(&inode->i_data.swap_tree, GFP_ATOMIC);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	spin_lock_init(&inode->i_data.page_lock);
 	init_MUTEX(&inode->i_data.i_shared_sem);
@@ -227,6 +230,7 @@
 =20
 void clear_inode(struct inode *inode)
 {
+	invalidate_swapped_list(&inode->i_data);
 	invalidate_inode_buffers(inode);
       =20
 	if (inode->i_data.nrpages)
diff -urP linux-2.5.68-mm2/include/linux/fs.h linux-2.5.68_patched/include/=
linux/fs.h
=2D-- linux-2.5.68-mm2/include/linux/fs.h	Sun Apr 20 04:48:56 2003
+++ linux-2.5.68_patched/include/linux/fs.h	Mon Apr 28 12:05:07 2003
@@ -312,11 +312,13 @@
 struct backing_dev_info;
 struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
+	struct radix_tree_root	swap_tree;	/* radix tree of swapped pages */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
 	spinlock_t		page_lock;	/* and rwlock protecting it */
 	struct list_head	clean_pages;	/* list of clean pages */
 	struct list_head	dirty_pages;	/* list of dirty pages */
 	struct list_head	locked_pages;	/* list of locked pages */
+	struct list_head	swapped_pages;	/* list of swapped pages */
 	struct list_head	io_pages;	/* being prepared for I/O */
 	unsigned long		nrpages;	/* number of total pages */
 	struct address_space_operations *a_ops;	/* methods */
diff -urP linux-2.5.68-mm2/include/linux/page_prefetch.h linux-2.5.68_patch=
ed/include/linux/page_prefetch.h
=2D-- linux-2.5.68-mm2/include/linux/page_prefetch.h	Thu Jan  1 01:00:00 19=
70
+++ linux-2.5.68_patched/include/linux/page_prefetch.h	Mon Apr 28 12:05:07 =
2003
@@ -0,0 +1,96 @@
+#ifndef _LINUX_PAGE_PREFETCH_H
+#define _LINUX_PAGE_PREFETCH_H
+
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/radix-tree.h>
+
+struct swapped_entry_t {
+	swp_entry_t		swp_entry;
+	struct address_space	*mapping;
+	struct list_head	mapping_list;
+	struct list_head	swapped_list;
+};
+
+struct swapped_root_t {
+	spinlock_t		lock;
+	unsigned int		count;
+	unsigned int		maxcount;
+	kmem_cache_t		*cache;
+	struct list_head	list;
+};
+
+extern struct swapped_root_t	swapped_root;
+
+static inline void add_to_swapped_list(struct address_space *mapping,
+							unsigned long index)
+{
+	struct swapped_entry_t *entry;
+	int error;
+
+	spin_lock(&swapped_root.lock);
+
+	if(swapped_root.count >=3D swapped_root.maxcount)
+	{
+		entry =3D list_entry(swapped_root.list.prev,
+				struct swapped_entry_t, swapped_list);
+		radix_tree_delete(&entry->mapping->swap_tree,
+				entry->swp_entry.val);
+		list_del(&entry->mapping_list);
+		list_del(&entry->swapped_list);
+		swapped_root.count--;
+	} else {
+		entry =3D kmem_cache_alloc(swapped_root.cache, GFP_ATOMIC);
+		if(!entry)
+			goto out_locked;
+	}
+
+	entry->swp_entry.val =3D index;
+	entry->mapping       =3D mapping;
+
+	error =3D radix_tree_insert(&mapping->swap_tree, index, entry);
+	if(!error) {
+		list_add(&entry->mapping_list, &mapping->swapped_pages);
+		list_add(&entry->swapped_list, &swapped_root.list);
+		swapped_root.count++;
+	} else {
+		kmem_cache_free(swapped_root.cache, entry);
+	}
+
+out_locked:
+	spin_unlock(&swapped_root.lock);
+}
+
+static inline void remove_from_swapped_list(struct address_space *mapping,
+							unsigned long index)
+{
+	struct swapped_entry_t *entry;
+
+	spin_lock(&swapped_root.lock);
+	entry =3D radix_tree_delete(&mapping->swap_tree, index);
+	if(entry) {
+		list_del(&entry->mapping_list);
+		list_del(&entry->swapped_list);
+		swapped_root.count--;
+		kmem_cache_free(swapped_root.cache, entry);
+	}
+	spin_unlock(&swapped_root.lock);
+}
+
+static inline void invalidate_swapped_list(struct address_space *mapping)
+{
+	spin_lock(&swapped_root.lock);
+	while(!list_empty(&mapping->swapped_pages)) {
+		struct swapped_entry_t *entry =3D list_entry(
+					mapping->swapped_pages.next,
+					struct swapped_entry_t, mapping_list);
+		radix_tree_delete(&mapping->swap_tree, entry->swp_entry.val);
+		list_del(&entry->mapping_list);
+		list_del(&entry->swapped_list);
+		swapped_root.count--;
+		kmem_cache_free(swapped_root.cache, entry);
+	}
+	spin_unlock(&swapped_root.lock);
+}
+
+#endif /* _LINUX_PAGE_PREFETCH_H */
diff -urP linux-2.5.68-mm2/include/linux/swap.h linux-2.5.68_patched/includ=
e/linux/swap.h
=2D-- linux-2.5.68-mm2/include/linux/swap.h	Sun Apr 20 04:48:49 2003
+++ linux-2.5.68_patched/include/linux/swap.h	Mon Apr 28 12:05:07 2003
@@ -155,6 +155,8 @@
 extern unsigned int nr_free_pages_pgdat(pg_data_t *pgdat);
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
+extern unsigned int nr_avail_buffer_pages(void);
+extern unsigned int nr_avail_pagecache_pages(void);
=20
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
diff -urP linux-2.5.68-mm2/kernel/ksyms.c linux-2.5.68_patched/kernel/ksyms=
=2Ec
=2D-- linux-2.5.68-mm2/kernel/ksyms.c	Mon Apr 28 20:41:52 2003
+++ linux-2.5.68_patched/kernel/ksyms.c	Mon Apr 28 12:05:07 2003
@@ -59,6 +59,7 @@
 #include <linux/time.h>
 #include <linux/backing-dev.h>
 #include <linux/percpu_counter.h>
+#include <linux/page_prefetch.h>
 #include <asm/checksum.h>
=20
 #if defined(CONFIG_PROC_FS)
@@ -71,6 +72,13 @@
 extern struct timezone sys_tz;
=20
 extern int panic_timeout;
+
+/* needed for page prefetch support */
+EXPORT_SYMBOL(swapped_root);
+EXPORT_SYMBOL(swapper_space);
+EXPORT_SYMBOL(swapin_readahead);
+EXPORT_SYMBOL(do_page_cache_readahead);
+EXPORT_SYMBOL(nr_avail_pagecache_pages);
=20
 /* process memory management */
 EXPORT_SYMBOL(do_mmap_pgoff);
diff -urP linux-2.5.68-mm2/mm/Makefile linux-2.5.68_patched/mm/Makefile
=2D-- linux-2.5.68-mm2/mm/Makefile	Sun Apr 20 04:50:05 2003
+++ linux-2.5.68_patched/mm/Makefile	Mon Apr 28 12:05:08 2003
@@ -12,3 +12,5 @@
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
=20
 obj-$(CONFIG_SWAP)	+=3D page_io.o swap_state.o swapfile.o
+
+obj-$(CONFIG_PAGE_PREFETCH)	+=3D page_prefetch.o
diff -urP linux-2.5.68-mm2/mm/filemap.c linux-2.5.68_patched/mm/filemap.c
=2D-- linux-2.5.68-mm2/mm/filemap.c	Mon Apr 28 20:41:52 2003
+++ linux-2.5.68_patched/mm/filemap.c	Mon Apr 28 12:06:39 2003
@@ -36,6 +36,7 @@
  * FIXME: remove all knowledge of the buffer layer from the core VM
  */
 #include <linux/buffer_head.h> /* for generic_osync_inode */
+#include <linux/page_prefetch.h>
=20
 #include <asm/uaccess.h>
 #include <asm/mman.h>
@@ -83,6 +84,7 @@
=20
 	BUG_ON(PageDirty(page) && !PageSwapCache(page));
=20
+	remove_from_swapped_list(mapping, page->index);
 	radix_tree_delete(&mapping->page_tree, page->index);
 	list_del(&page->list);
 	page->mapping =3D NULL;
@@ -222,8 +224,11 @@
 int add_to_page_cache(struct page *page, struct address_space *mapping,
 		pgoff_t offset, int gfp_mask)
 {
=2D	int error =3D radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	int error;
=20
+	remove_from_swapped_list(mapping, offset);
+
+	error =3D radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 	if (error =3D=3D 0) {
 		page_cache_get(page);
 		spin_lock(&mapping->page_lock);
diff -urP linux-2.5.68-mm2/mm/page_alloc.c linux-2.5.68_patched/mm/page_all=
oc.c
=2D-- linux-2.5.68-mm2/mm/page_alloc.c	Mon Apr 28 20:41:52 2003
+++ linux-2.5.68_patched/mm/page_alloc.c	Mon Apr 28 12:05:08 2003
@@ -852,6 +852,48 @@
 }
 #endif
=20
+static unsigned int nr_avail_zone_pages(int offset)
+{
+	pg_data_t *pgdat;
+	unsigned long avail =3D 0;
+
+	for_each_pgdat(pgdat) {
+		struct zonelist *zonelist =3D pgdat->node_zonelists + offset;
+		struct zone **zonep =3D zonelist->zones;
+		struct zone *zone;
+		unsigned long low =3D 0;
+
+		for (zone =3D *zonep++; zone; zone =3D *zonep++) {
+			unsigned long local_free =3D zone->free_pages;
+			unsigned long local_low  =3D zone->pages_low;
+		=09
+			low +=3D local_low;
+			if (local_free > low) {
+				avail =3D max(avail, local_free - low);
+			}
+			low +=3D local_low * sysctl_lower_zone_protection;
+		}
+	}
+
+	return avail;
+}
+
+/*
+ * Amount of available RAM allocatable within ZONE_DMA and ZONE_NORMAL
+ */
+unsigned int nr_avail_buffer_pages(void)
+{
+	return nr_avail_zone_pages(GFP_USER & GFP_ZONEMASK);
+}
+
+/*
+ * Amount of available RAM allocatable within all zones
+ */
+unsigned int nr_avail_pagecache_pages(void)
+{
+	return nr_avail_zone_pages(GFP_HIGHUSER & GFP_ZONEMASK);
+}
+
 #ifdef CONFIG_NUMA
 static void show_node(struct zone *zone)
 {
diff -urP linux-2.5.68-mm2/mm/page_prefetch.c linux-2.5.68_patched/mm/page_=
prefetch.c
=2D-- linux-2.5.68-mm2/mm/page_prefetch.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.68_patched/mm/page_prefetch.c	Mon Apr 28 12:05:08 2003
@@ -0,0 +1,114 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/page_prefetch.h>
+#include <linux/backing-dev.h>
+
+#define RESERVED_PAGES	256		/* let 1MByte of pagecache free */
+#define INTERVAL	60		/* (secs) Default is 1 minute */
+
+static int reserved_pages =3D RESERVED_PAGES;
+static int interval       =3D INTERVAL;
+
+MODULE_PARM(reserved_pages,"i");
+MODULE_PARM_DESC(reserved_pages,
+	"count of pagechache pages to let free (default 256)");
+
+MODULE_PARM(interval,"i");
+MODULE_PARM_DESC(interval,
+	"delay in seconds to wait between memory checks (default 60)");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Thomas Schlichter <thomas.schlichter@web.de>");
+MODULE_DESCRIPTION("prefetches swap pages when there is free memory");
+
+/*
+ *	Our timer
+ */
+static void prefetch_timer_handler(unsigned long data);
+static struct timer_list prefetch_timer =3D
+		TIMER_INITIALIZER(prefetch_timer_handler, 0, 0);
+
+/*
+ *	Our waitqueue
+ */
+static DECLARE_WAIT_QUEUE_HEAD(kprefetchd_wait);
+
+/*
+ *	If the timer expires...
+ */
+static void prefetch_timer_handler(unsigned long data)
+{
+	wake_up_interruptible(&kprefetchd_wait);
+	prefetch_timer.expires =3D jiffies + interval * HZ;
+	add_timer(&prefetch_timer);
+}
+
+static int running;
+
+/*
+ *	...wake up the kernel thread
+ */
+static int kprefetchd(void *data)
+{
+	DEFINE_WAIT(wait);
+
+	daemonize("kprefetchd");
+
+	while(running) {
+		prepare_to_wait(&kprefetchd_wait, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&kprefetchd_wait, &wait);
+
+		while(nr_avail_pagecache_pages() > reserved_pages) {
+			struct swapped_entry_t *entry;
+
+			spin_lock(&swapped_root.lock);
+
+			if(list_empty(&swapped_root.list)) {
+				spin_unlock(&swapped_root.lock);
+				break;
+			}
+
+			entry =3D list_entry(swapped_root.list.next,
+					struct swapped_entry_t, swapped_list);
+			radix_tree_delete(&entry->mapping->swap_tree,
+					entry->swp_entry.val);
+			list_del(&entry->mapping_list);
+			list_del(&entry->swapped_list);
+			swapped_root.count--;
+
+			spin_unlock(&swapped_root.lock);
+
+			if(entry->mapping =3D=3D &swapper_space) {
+				swapin_readahead(entry->swp_entry);
+			} else {
+				do_page_cache_readahead(entry->mapping,
+					NULL, entry->swp_entry.val,
+					entry->mapping->backing_dev_info->ra_pages);
+			}
+
+			kmem_cache_free(swapped_root.cache, entry);
+		}
+	}
+
+	return 0;
+}
+
+static int __init prefetch_init(void)
+{
+	running =3D 1;
+	kernel_thread(kprefetchd, NULL, CLONE_KERNEL);
+	prefetch_timer.expires =3D jiffies + interval * HZ;
+	add_timer(&prefetch_timer);
+	return 0;
+}
+
+static void __exit prefetch_exit(void)
+{
+	del_timer(&prefetch_timer);
+	running =3D 0;
+	wake_up_interruptible(&kprefetchd_wait);
+}
+
+module_init(prefetch_init);
+module_exit(prefetch_exit);
diff -urP linux-2.5.68-mm2/mm/swap.c linux-2.5.68_patched/mm/swap.c
=2D-- linux-2.5.68-mm2/mm/swap.c	Mon Apr 28 20:41:52 2003
+++ linux-2.5.68_patched/mm/swap.c	Mon Apr 28 12:05:08 2003
@@ -23,6 +23,13 @@
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
 #include <linux/percpu.h>
+#include <linux/page_prefetch.h>
+
+struct swapped_root_t swapped_root =3D {
+	.lock  =3D SPIN_LOCK_UNLOCKED,
+	.count =3D 0,
+	.list  =3D LIST_HEAD_INIT(swapped_root.list),
+};
=20
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -390,4 +397,17 @@
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	/*
+	 * Create kmem cache for swapped entries
+	 */
+ 	swapped_root.cache =3D kmem_cache_create("swapped_entry",
+		sizeof(struct swapped_entry_t), 0, 0, NULL, NULL);
+	if(!swapped_root.cache)
+		panic("swap_setup(): cannot create swapped_entry SLAB cache");
+
+	/*
+	 * Set max count of swapped entries
+	 */
+	 swapped_root.maxcount =3D nr_free_pagecache_pages();
 }
diff -urP linux-2.5.68-mm2/mm/swap_state.c linux-2.5.68_patched/mm/swap_sta=
te.c
=2D-- linux-2.5.68-mm2/mm/swap_state.c	Mon Apr 28 20:41:52 2003
+++ linux-2.5.68_patched/mm/swap_state.c	Mon Apr 28 12:05:08 2003
@@ -32,12 +32,14 @@
 extern struct address_space_operations swap_aops;
=20
 struct address_space swapper_space =3D {
+	.swap_tree	=3D RADIX_TREE_INIT(GFP_ATOMIC),
 	.page_tree	=3D RADIX_TREE_INIT(GFP_ATOMIC),
 	.page_lock	=3D SPIN_LOCK_UNLOCKED,
 	.clean_pages	=3D LIST_HEAD_INIT(swapper_space.clean_pages),
 	.dirty_pages	=3D LIST_HEAD_INIT(swapper_space.dirty_pages),
 	.io_pages	=3D LIST_HEAD_INIT(swapper_space.io_pages),
 	.locked_pages	=3D LIST_HEAD_INIT(swapper_space.locked_pages),
+	.swapped_pages	=3D LIST_HEAD_INIT(swapper_space.swapped_pages),
 	.host		=3D &swapper_inode,
 	.a_ops		=3D &swap_aops,
 	.backing_dev_info =3D &swap_backing_dev_info,
diff -urP linux-2.5.68-mm2/mm/vmscan.c linux-2.5.68_patched/mm/vmscan.c
=2D-- linux-2.5.68-mm2/mm/vmscan.c	Mon Apr 28 20:41:52 2003
+++ linux-2.5.68_patched/mm/vmscan.c	Mon Apr 28 12:05:08 2003
@@ -28,6 +28,7 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/page_prefetch.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -414,6 +415,8 @@
 free_it:
 		unlock_page(page);
 		ret++;
+		if(mapping)
+			add_to_swapped_list(mapping, page->index);
 		if (!pagevec_add(&freed_pvec, page))
 			__pagevec_release_nonlru(&freed_pvec);
 		continue;

--Boundary-01=_gsYr+1MBKZnvkJQ--

--Boundary-03=_2sYr+jSfyPpLbgI
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+rYs2YAiN+WRIZzQRAunSAJsFD5BJjo85w4PEkp6v5wbF4WINXACgw3EF
9txLZ9eL99BACZWxmv70tKo=
=K6xQ
-----END PGP SIGNATURE-----

--Boundary-03=_2sYr+jSfyPpLbgI--

