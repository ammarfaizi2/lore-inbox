Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTDQPuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTDQPuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:50:50 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:20099 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261789AbTDQPui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:50:38 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: [RFC] second try for swap prefetch (does Oops!)
Date: Thu, 17 Apr 2003 18:02:13 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200304101948.12423.schlicht@uni-mannheim.de> <200304120705.26408.schlicht@uni-mannheim.de> <20030411223718.4ba9c024.akpm@digeo.com>
In-Reply-To: <20030411223718.4ba9c024.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_QAtn+zhdXztB/KK";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304171802.24434.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_QAtn+zhdXztB/KK
Content-Type: multipart/mixed;
  boundary="Boundary-01=_FAtn+pRbPw5Vwm5"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_FAtn+pRbPw5Vwm5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

in the patch attached I improved the memory usage for my data structures by=
=20
using a kmem_cache. Also I do not use a single radix-tree for the pointers =
to=20
the list anymore but every mapping gets its own... So I should be able to=20
prefetch not only from the swap space but from other disk-places, too.

But exactly this does not work and I need some help with this...
If I do add pages from the swaper_space mapping to the prefetch list=20
everything works perfectly. But as soon as I add all pages with a mapping t=
o=20
the list I get the Oops attached... :-(

It happens in the radix_tree_delete call from the swap_prefetch work handle=
r.=20
So I think I access an invalid (perhaps not initialized?) radix tree... But=
=20
why I wonder is that this entry was properly inserted to the tree, because=
=20
else it would never had been inserted to the list!

So I am only very confused..!

Thanks for your help!

   Thomas Schlichter

On April 12, Andrew Morton wrote:
> Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
> > How can I get the file pointer for a buffered page with the information
> > available in the kswapd (minly the page struct)??
>
> You can't, really.  There can be any number of file*'s pointing at an
> inode.

OK, I understand...

> The pagefault handler will find it by find_vma(faulting_address)->vm_file.
> Other codepaths use syscalls, and the user passed the file* in.
>
> You can call page_cache_readahead() with a NULL file*.  That'll mostly wo=
rk
> except for the odd filesytem like NFS which will oops.  But it's good
> enough for testing and development.

That's the way I try it now... ;-)

> Or you could cook up a local file struct along the lines of
> fs/nfsd/vfs.c:nfsd_read(), but I would not like to lead a young person
> that way ;)

Thx... ;-)
--Boundary-01=_FAtn+pRbPw5Vwm5
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="swap_prefetch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="swap_prefetch.diff"

diff -urP linux-2.5.67/arch/i386/Kconfig linux-2.5.67_patched/arch/i386/Kco=
nfig
=2D-- linux-2.5.67/arch/i386/Kconfig	Thu Apr 10 19:25:40 2003
+++ linux-2.5.67_patched/arch/i386/Kconfig	Thu Apr 10 17:47:36 2003
@@ -373,6 +373,13 @@
 	depends on MK8 || MPENTIUM4
 	default y
=20
+config SWAP_PREFETCH
+	tristate "Prefetch swapped memory"
+	depends on SWAP
+	help
+	  This option enables the kernel to prefetch swapped memory pages
+	  when idle.
+
 config HUGETLB_PAGE
 	bool "Huge TLB Page Support"
 	help
diff -urP linux-2.5.67/fs/inode.c linux-2.5.67_patched/fs/inode.c
=2D-- linux-2.5.67/fs/inode.c	Mon Apr  7 19:32:58 2003
+++ linux-2.5.67_patched/fs/inode.c	Sat Apr 12 03:30:39 2003
@@ -180,6 +180,7 @@
 	INIT_LIST_HEAD(&inode->i_dentry);
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
+	INIT_RADIX_TREE(&inode->i_data.swap_tree, GFP_ATOMIC);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	rwlock_init(&inode->i_data.page_lock);
 	init_MUTEX(&inode->i_data.i_shared_sem);
diff -urP linux-2.5.67/include/linux/fs.h linux-2.5.67_patched/include/linu=
x/fs.h
=2D-- linux-2.5.67/include/linux/fs.h	Mon Apr  7 19:30:58 2003
+++ linux-2.5.67_patched/include/linux/fs.h	Sat Apr 12 03:31:24 2003
@@ -312,6 +312,7 @@
 struct backing_dev_info;
 struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
+	struct radix_tree_root	swap_tree;	/* radix tree of swapped pages */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
 	rwlock_t		page_lock;	/* and rwlock protecting it */
 	struct list_head	clean_pages;	/* list of clean pages */
diff -urP linux-2.5.67/include/linux/swap.h linux-2.5.67_patched/include/li=
nux/swap.h
=2D-- linux-2.5.67/include/linux/swap.h	Thu Apr 10 19:25:40 2003
+++ linux-2.5.67_patched/include/linux/swap.h	Thu Apr 10 18:36:33 2003
@@ -155,6 +155,8 @@
 extern unsigned int nr_free_pages_pgdat(pg_data_t *pgdat);
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
+extern unsigned int nr_avail_buffer_pages(void);
+extern unsigned int nr_avail_pagecache_pages(void);
=20
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
diff -urP linux-2.5.67/include/linux/swap_prefetch.h linux-2.5.67_patched/i=
nclude/linux/swap_prefetch.h
=2D-- linux-2.5.67/include/linux/swap_prefetch.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67_patched/include/linux/swap_prefetch.h	Wed Apr 16 16:00:09 =
2003
@@ -0,0 +1,57 @@
+#ifndef _LINUX_SWAP_PREFETCH_H
+#define _LINUX_SWAP_PREFETCH_H
+
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/radix-tree.h>
+
+struct swapped_entry_t {
+	struct list_head	head;
+	swp_entry_t		swp_entry;
+	struct address_space	*mapping;
+};
+
+struct swapped_list_t {
+	spinlock_t		lock;
+	struct list_head	head;
+	kmem_cache_t		*cache;
+};
+
+extern struct swapped_list_t	swapped_list;
+
+static inline void add_to_swapped_list(struct address_space *mapping,
+							unsigned long index)
+{
+	struct swapped_entry_t *entry;
+	int error;
+=20
+	entry =3D kmem_cache_alloc(swapped_list.cache, GFP_ATOMIC);
+	if(entry) {
+		entry->swp_entry.val =3D index;
+		entry->mapping       =3D mapping;
+
+		spin_lock(&swapped_list.lock);
+		error =3D radix_tree_insert(&mapping->swap_tree, index, entry);
+		if(!error)
+			list_add(&entry->head, &swapped_list.head);
+		else
+			kmem_cache_free(swapped_list.cache, entry);
+		spin_unlock(&swapped_list.lock);
+	}
+}
+
+static inline void remove_from_swapped_list(struct address_space *mapping,
+							unsigned long index)
+{
+	struct swapped_entry_t *entry;
+
+	spin_lock(&swapped_list.lock);
+	entry =3D radix_tree_delete(&mapping->swap_tree, index);
+	if(entry) {
+		list_del(&entry->head);
+		kmem_cache_free(swapped_list.cache, entry);
+	}
+	spin_unlock(&swapped_list.lock);
+}
+
+#endif /* _LINUX_SWAP_PREFETCH_H */
diff -urP linux-2.5.67/kernel/ksyms.c linux-2.5.67_patched/kernel/ksyms.c
=2D-- linux-2.5.67/kernel/ksyms.c	Thu Apr 10 19:25:40 2003
+++ linux-2.5.67_patched/kernel/ksyms.c	Mon Apr 14 01:51:51 2003
@@ -58,6 +58,7 @@
 #include <linux/ptrace.h>
 #include <linux/time.h>
 #include <linux/backing-dev.h>
+#include <linux/swap_prefetch.h>
 #include <asm/checksum.h>
=20
 #if defined(CONFIG_PROC_FS)
@@ -70,6 +71,13 @@
 extern struct timezone sys_tz;
=20
 extern int panic_timeout;
+
+/* needed for swap prefetch support */
+EXPORT_SYMBOL(swapped_list);
+EXPORT_SYMBOL(swapper_space);
+EXPORT_SYMBOL(swapin_readahead);
+EXPORT_SYMBOL(do_page_cache_readahead);
+EXPORT_SYMBOL(nr_avail_pagecache_pages);
=20
 /* process memory management */
 EXPORT_SYMBOL(do_mmap_pgoff);
diff -urP linux-2.5.67/mm/Makefile linux-2.5.67_patched/mm/Makefile
=2D-- linux-2.5.67/mm/Makefile	Thu Apr 10 19:25:40 2003
+++ linux-2.5.67_patched/mm/Makefile	Thu Apr 10 17:47:36 2003
@@ -12,3 +12,5 @@
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
=20
 obj-$(CONFIG_SWAP)	+=3D page_io.o swap_state.o swapfile.o
+
+obj-$(CONFIG_SWAP_PREFETCH)	+=3D swap_prefetch.o
diff -urP linux-2.5.67/mm/filemap.c linux-2.5.67_patched/mm/filemap.c
=2D-- linux-2.5.67/mm/filemap.c	Mon Apr  7 19:31:02 2003
+++ linux-2.5.67_patched/mm/filemap.c	Wed Apr 16 16:04:40 2003
@@ -16,8 +16,7 @@
 #include <linux/fs.h>
 #include <linux/aio.h>
 #include <linux/kernel_stat.h>
=2D#include <linux/mm.h>
=2D#include <linux/swap.h>
+#include <linux/swap_prefetch.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -84,6 +83,7 @@
=20
 	BUG_ON(PageDirty(page) && !PageSwapCache(page));
=20
+	remove_from_swapped_list(mapping, page->index);
 	radix_tree_delete(&mapping->page_tree, page->index);
 	list_del(&page->list);
 	page->mapping =3D NULL;
@@ -223,8 +223,11 @@
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
 		write_lock(&mapping->page_lock);
diff -urP linux-2.5.67/mm/page_alloc.c linux-2.5.67_patched/mm/page_alloc.c
=2D-- linux-2.5.67/mm/page_alloc.c	Thu Apr 10 19:25:40 2003
+++ linux-2.5.67_patched/mm/page_alloc.c	Thu Apr 10 17:47:36 2003
@@ -787,6 +787,48 @@
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
diff -urP linux-2.5.67/mm/swap.c linux-2.5.67_patched/mm/swap.c
=2D-- linux-2.5.67/mm/swap.c	Mon Apr  7 19:31:05 2003
+++ linux-2.5.67_patched/mm/swap.c	Sat Apr 12 03:19:53 2003
@@ -13,9 +13,8 @@
  * Buffermem limits added 12.3.98, Rik van Riel.
  */
=20
=2D#include <linux/mm.h>
 #include <linux/kernel_stat.h>
=2D#include <linux/swap.h>
+#include <linux/swap_prefetch.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
@@ -24,6 +23,11 @@
 #include <linux/buffer_head.h>
 #include <linux/percpu.h>
=20
+struct swapped_list_t swapped_list =3D {
+	.lock =3D SPIN_LOCK_UNLOCKED,
+	.head =3D LIST_HEAD_INIT(swapped_list.head),
+};
+
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
=20
@@ -390,4 +394,12 @@
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	/*
+	 * Create kmem cache for swapped entries
+	 */
+ 	swapped_list.cache =3D kmem_cache_create("swapped_entry",
+		sizeof(struct swapped_entry_t), 0, 0, NULL, NULL);
+	if(!swapped_list.cache)
+		panic("swap_setup(): cannot create swapped_entry SLAB cache");
 }
diff -urP linux-2.5.67/mm/swap_prefetch.c linux-2.5.67_patched/mm/swap_pref=
etch.c
=2D-- linux-2.5.67/mm/swap_prefetch.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67_patched/mm/swap_prefetch.c	Thu Apr 17 00:29:40 2003
@@ -0,0 +1,88 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/swap_prefetch.h>
+
+#define RESERVED_PAGES	50		/* let 200 kByte of pagecache free */
+#define INTERVAL	60		/* (secs) Default is 1 minute */
+
+static int reserved_pages =3D RESERVED_PAGES;
+static int interval       =3D INTERVAL;
+
+MODULE_PARM(reserved_pages,"i");
+MODULE_PARM_DESC(reserved_pages,
+	"count of pagechache pages to let free (default 50)");
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
+ *	Our work
+ */
+static void prefetch_work_handler(void *data);
+static DECLARE_WORK(prefetch_work, prefetch_work_handler, 0);
+
+/*
+ *	If the timer expires..
+ */
+static void prefetch_timer_handler(unsigned long data)
+{
+	schedule_work(&prefetch_work);
+	prefetch_timer.expires =3D jiffies + interval * HZ;
+	add_timer(&prefetch_timer);
+}
+
+/*
+ *	..do the work
+ */
+static void prefetch_work_handler(void *data)
+{
+	printk(KERN_INFO "Available pages before: %d\n", nr_avail_pagecache_pages=
());
+
+	while(nr_avail_pagecache_pages() > reserved_pages) {
+		struct swapped_entry_t *entry;
+
+		spin_lock(&swapped_list.lock);
+		if(list_empty(&swapped_list.head)) {
+			spin_unlock(&swapped_list.lock);
+			break;
+		}
+		entry =3D list_entry(swapped_list.head.next, struct swapped_entry_t, hea=
d);
+		radix_tree_delete(&entry->mapping->swap_tree, entry->swp_entry.val);
+		list_del(&entry->head);
+		spin_unlock(&swapped_list.lock);
+
+		if(entry->mapping =3D=3D &swapper_space)
+			swapin_readahead(entry->swp_entry);
+		else
+			do_page_cache_readahead(entry->mapping, NULL, entry->swp_entry.val, 1);
+		kmem_cache_free(swapped_list.cache, entry);
+	}
+
+	printk(KERN_INFO "Available pages after: %d\n", nr_avail_pagecache_pages(=
));
+}
+
+static int __init prefetch_init(void)
+{
+	prefetch_timer_handler(0);
+	return 0;
+}
+
+static void __exit prefetch_exit(void)
+{
+	del_timer(&prefetch_timer);
+}
+
+module_init(prefetch_init);
+module_exit(prefetch_exit);
diff -urP linux-2.5.67/mm/swap_state.c linux-2.5.67_patched/mm/swap_state.c
=2D-- linux-2.5.67/mm/swap_state.c	Thu Apr 10 19:25:40 2003
+++ linux-2.5.67_patched/mm/swap_state.c	Sat Apr 12 03:29:59 2003
@@ -33,6 +33,7 @@
 extern struct address_space_operations swap_aops;
=20
 struct address_space swapper_space =3D {
+	.swap_tree	=3D RADIX_TREE_INIT(GFP_ATOMIC),
 	.page_tree	=3D RADIX_TREE_INIT(GFP_ATOMIC),
 	.page_lock	=3D RW_LOCK_UNLOCKED,
 	.clean_pages	=3D LIST_HEAD_INIT(swapper_space.clean_pages),
diff -urP linux-2.5.67/mm/vmscan.c linux-2.5.67_patched/mm/vmscan.c
=2D-- linux-2.5.67/mm/vmscan.c	Thu Apr 10 19:25:40 2003
+++ linux-2.5.67_patched/mm/vmscan.c	Thu Apr 17 14:41:17 2003
@@ -11,10 +11,9 @@
  *  Multiqueue VM started 5.8.00, Rik van Riel.
  */
=20
=2D#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
=2D#include <linux/swap.h>
+#include <linux/swap_prefetch.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
@@ -417,6 +416,9 @@
 		ret++;
 		if (!pagevec_add(&freed_pvec, page))
 			__pagevec_release_nonlru(&freed_pvec);
+		if (mapping)
+//		if (mapping =3D=3D &swapper_space)
+			add_to_swapped_list(mapping, page->index);
 		continue;
=20
 activate_locked:

--Boundary-01=_FAtn+pRbPw5Vwm5
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ksymoops.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="ksymoops.txt"

ksymoops 2.4.2 on i586 2.5.67.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.67/ (default)
     -m /boot/System.map-2.5.67 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 64815c28
c02018e8
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02018e8>]    Tainted: P =20
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: 64815c28   ebx: c12b9f3c   ecx: 8b21ca84   edx: 64815c24
esi: 8b21ca7e   edi: 00000001   ebp: c12b9f6c   esp: c12b9f20
ds: 007b   es: 007b   ss: 0068
Stack: c2e34c6c c03840e0 c12b8000 c1daf716 00000000 00000000 ceeb5570 64815=
c24=20
       64815c28 00000282 c2e34c50 c2e34c50 c03840e0 c12b8000 00000000 00000=
000=20
       000003d4 00002a76 c12b9f74 c12b9f88 d4b0415f ceeb5568 00000001 c12b8=
000=20
 [<d4b0415f>] prefetch_work_handler+0x12f/0x210 [swap_prefetch]
 [<d4b04d80>] prefetch_work+0x0/0x60 [swap_prefetch]
 [<c0139dcf>] worker_thread+0x28f/0x438
 [<c0139b40>] worker_thread+0x0/0x438
 [<d4b04030>] prefetch_work_handler+0x0/0x210 [swap_prefetch]
 [<c0122d38>] default_wake_function+0x0/0x18
 [<c0122d38>] default_wake_function+0x0/0x18
 [<c01081e5>] kernel_thread_helper+0x5/0xc
Code: 8b 10 85 d2 74 6a 89 f8 89 f1 d3 e8 83 e0 3f 8d 44 82 04 89=20

>>EIP; c02018e8 <radix_tree_delete+4c/c8>   <=3D=3D=3D=3D=3D
Code;  c02018e8 <radix_tree_delete+4c/c8>
00000000 <_EIP>:
Code;  c02018e8 <radix_tree_delete+4c/c8>   <=3D=3D=3D=3D=3D
   0:   8b 10                     mov    (%eax),%edx   <=3D=3D=3D=3D=3D
Code;  c02018ea <radix_tree_delete+4e/c8>
   2:   85 d2                     test   %edx,%edx
Code;  c02018ec <radix_tree_delete+50/c8>
   4:   74 6a                     je     70 <_EIP+0x70> c0201958 <radix_tre=
e_delete+bc/c8>
Code;  c02018ee <radix_tree_delete+52/c8>
   6:   89 f8                     mov    %edi,%eax
Code;  c02018f0 <radix_tree_delete+54/c8>
   8:   89 f1                     mov    %esi,%ecx
Code;  c02018f2 <radix_tree_delete+56/c8>
   a:   d3 e8                     shr    %cl,%eax
Code;  c02018f4 <radix_tree_delete+58/c8>
   c:   83 e0 3f                  and    $0x3f,%eax
Code;  c02018f6 <radix_tree_delete+5a/c8>
   f:   8d 44 82 04               lea    0x4(%edx,%eax,4),%eax
Code;  c02018fa <radix_tree_delete+5e/c8>
  13:   89 00                     mov    %eax,(%eax)


1 warning and 1 error issued.  Results may not be reliable.

--Boundary-01=_FAtn+pRbPw5Vwm5--

--Boundary-03=_QAtn+zhdXztB/KK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ntAQYAiN+WRIZzQRAvGZAJ9tpOCZ0cj8lWkvZ5IclwsFox8nLQCfcM7Z
SDdU7aVHivJZokAHyU8ZzmE=
=lPJh
-----END PGP SIGNATURE-----

--Boundary-03=_QAtn+zhdXztB/KK--

