Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbTDJRgn (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbTDJRgn (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:36:43 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:13461 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264116AbTDJRgd (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 13:36:33 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] first try for swap prefetch
Date: Thu, 10 Apr 2003 19:47:58 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_c5al+cGA9PmOjGs";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200304101948.12423.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_c5al+cGA9PmOjGs
Content-Type: multipart/mixed;
  boundary="Boundary-01=_O5al+0q1EZXTEiO"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_O5al+0q1EZXTEiO
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

as mentioned a few days ago I was going to try to implement a swap prefetch=
 to=20
better utilize the free memory. Now here is my first try. This version work=
s=20
only as a module and tests for free pagecahe memory in a interval specified=
=20
as a module parameter.

As I tested this I saw that many of the page reloads do not come from the s=
wap=20
space but from buffers that got moved away. I could easily save which buffe=
rs=20
have been removed but I don't know how to read them back to the pagecache...

An other thing I saw was that anywhere in the kernel there must be some cod=
e=20
which always tries to hold some memory pages free, even if there are cached=
=20
pages that just can be freed as they are not modified... Perhaps that code=
=20
should be changed...

I hope someone may give me some hints or show me obvious mistakes I made...=
=20
;-)

Thank you!

Best regards
   Thomas
--Boundary-01=_O5al+0q1EZXTEiO
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="swap_prefetch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="swap_prefetch.diff"

diff -urP linux-2.5.67/arch/i386/Kconfig linux-2.5.67_patched/arch/i386/Kco=
nfig
=2D-- linux-2.5.67/arch/i386/Kconfig	Mon Apr  7 19:30:43 2003
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
diff -urP linux-2.5.67/include/linux/swap.h linux-2.5.67_patched/include/li=
nux/swap.h
=2D-- linux-2.5.67/include/linux/swap.h	Mon Apr  7 19:30:35 2003
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
+++ linux-2.5.67_patched/include/linux/swap_prefetch.h	Thu Apr 10 18:36:40 =
2003
@@ -0,0 +1,52 @@
+#ifndef _LINUX_SWAP_PREFETCH_H
+#define _LINUX_SWAP_PREFETCH_H
+
+#include <linux/swap.h>
+#include <linux/radix-tree.h>
+
+struct swapped_entry_t {
+	struct list_head list;
+	swp_entry_t entry;
+};
+
+struct swapped_root_t {
+	spinlock_t lock;
+	struct list_head list;
+	struct radix_tree_root tree;
+};
+
+extern struct swapped_root_t swapped_root;
+
+static inline void add_to_swapped_list(swp_entry_t entry)
+{
+	struct swapped_entry_t * swapped_entry;
+	int ret;
+
+	swapped_entry =3D kmalloc(sizeof(*swapped_entry), GFP_ATOMIC);
+	if(swapped_entry) {
+		swapped_entry->entry =3D entry;
+		spin_lock(&swapped_root.lock);
+		ret =3D radix_tree_insert(&swapped_root.tree, entry.val, swapped_entry);
+		if(ret =3D=3D 0)
+			list_add(&swapped_entry->list, &swapped_root.list);
+		else
+			kfree(swapped_entry);
+		spin_unlock(&swapped_root.lock);
+	}
+}
+
+static inline void remove_from_swapped_list(swp_entry_t entry)
+{
+	struct swapped_entry_t * swapped_entry;
+
+	spin_lock(&swapped_root.lock);
+	swapped_entry =3D radix_tree_lookup(&swapped_root.tree, entry.val);
+	if(swapped_entry) {
+		list_del(&swapped_entry->list);
+		radix_tree_delete(&swapped_root.tree, entry.val);
+		kfree(swapped_entry);
+	}
+	spin_unlock(&swapped_root.lock);
+}
+
+#endif /* _LINUX_SWAP_PREFETCH_H */
diff -urP linux-2.5.67/kernel/ksyms.c linux-2.5.67_patched/kernel/ksyms.c
=2D-- linux-2.5.67/kernel/ksyms.c	Mon Apr  7 19:30:34 2003
+++ linux-2.5.67_patched/kernel/ksyms.c	Thu Apr 10 17:47:36 2003
@@ -58,6 +58,7 @@
 #include <linux/ptrace.h>
 #include <linux/time.h>
 #include <linux/backing-dev.h>
+#include <linux/swap_prefetch.h>
 #include <asm/checksum.h>
=20
 #if defined(CONFIG_PROC_FS)
@@ -70,6 +71,11 @@
 extern struct timezone sys_tz;
=20
 extern int panic_timeout;
+
+/* needed for swap prefetch support */
+EXPORT_SYMBOL(swapped_root);
+EXPORT_SYMBOL(nr_avail_pagecache_pages);
+EXPORT_SYMBOL(read_swap_cache_async);
=20
 /* process memory management */
 EXPORT_SYMBOL(do_mmap_pgoff);
diff -urP linux-2.5.67/mm/Makefile linux-2.5.67_patched/mm/Makefile
=2D-- linux-2.5.67/mm/Makefile	Mon Apr  7 19:31:52 2003
+++ linux-2.5.67_patched/mm/Makefile	Thu Apr 10 17:47:36 2003
@@ -12,3 +12,5 @@
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
=20
 obj-$(CONFIG_SWAP)	+=3D page_io.o swap_state.o swapfile.o
+
+obj-$(CONFIG_SWAP_PREFETCH)	+=3D swap_prefetch.o
diff -urP linux-2.5.67/mm/page_alloc.c linux-2.5.67_patched/mm/page_alloc.c
=2D-- linux-2.5.67/mm/page_alloc.c	Mon Apr  7 19:30:39 2003
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
diff -urP linux-2.5.67/mm/swap_prefetch.c linux-2.5.67_patched/mm/swap_pref=
etch.c
=2D-- linux-2.5.67/mm/swap_prefetch.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67_patched/mm/swap_prefetch.c	Thu Apr 10 18:33:06 2003
@@ -0,0 +1,79 @@
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/swap_prefetch.h>
+
+#define INTERVAL	60		/* (secs) Default is 1 minute */
+
+static int interval       =3D INTERVAL;
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
+	while(nr_avail_pagecache_pages() !=3D 0) {
+		struct swapped_entry_t *swapped_entry;
+		swp_entry_t entry;
+
+		spin_lock(&swapped_root.lock);
+		if(list_empty(&swapped_root.list)) {
+			spin_unlock(&swapped_root.lock);
+			break;
+		}
+		swapped_entry =3D list_entry(swapped_root.list.next,
+					struct swapped_entry_t, list);
+		entry =3D swapped_entry->entry;
+		spin_unlock(&swapped_root.lock);
+
+		read_swap_cache_async(entry);
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
=2D-- linux-2.5.67/mm/swap_state.c	Mon Apr  7 19:31:11 2003
+++ linux-2.5.67_patched/mm/swap_state.c	Thu Apr 10 18:32:32 2003
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>	/* block_sync_page() */
+#include <linux/swap_prefetch.h>
=20
 #include <asm/pgtable.h>
=20
@@ -49,6 +50,12 @@
 	.private_list	=3D LIST_HEAD_INIT(swapper_space.private_list),
 };
=20
+struct swapped_root_t swapped_root =3D {
+	.lock =3D SPIN_LOCK_UNLOCKED,
+	.list =3D LIST_HEAD_INIT(swapped_root.list),
+	.tree =3D RADIX_TREE_INIT(GFP_ATOMIC),
+};
+
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
=20
 static struct {
@@ -344,6 +351,8 @@
 {
 	struct page *found_page, *new_page =3D NULL;
 	int err;
+
+	remove_from_swapped_list(entry);
=20
 	do {
 		/*
diff -urP linux-2.5.67/mm/vmscan.c linux-2.5.67_patched/mm/vmscan.c
=2D-- linux-2.5.67/mm/vmscan.c	Mon Apr  7 19:30:43 2003
+++ linux-2.5.67_patched/mm/vmscan.c	Thu Apr 10 18:31:02 2003
@@ -27,6 +27,7 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/swap_prefetch.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -402,6 +403,7 @@
 			swp_entry_t swap =3D { .val =3D page->index };
 			__delete_from_swap_cache(page);
 			write_unlock(&mapping->page_lock);
+			add_to_swapped_list(swap);
 			swap_free(swap);
 			__put_page(page);	/* The pagecache ref */
 			goto free_it;

--Boundary-01=_O5al+0q1EZXTEiO--

--Boundary-03=_c5al+cGA9PmOjGs
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+la5cYAiN+WRIZzQRAv6mAKCJYrtMP/6vu/NF2S+MvIM+rMq5uwCg4RhV
judPjIQoUhl7OvEtWFlvfNg=
=5Lgx
-----END PGP SIGNATURE-----

--Boundary-03=_c5al+cGA9PmOjGs--

