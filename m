Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVJKSAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVJKSAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVJKSAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:00:17 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:36776 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932247AbVJKSAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:00:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] swsusp: move snapshot functionality to separate file
Date: Tue, 11 Oct 2005 19:54:34 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200510111948.11242.rjw@sisk.pl>
In-Reply-To: <200510111948.11242.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510111954.35010.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch moves the functionality of swsusp related to creating
and handling the snapshot of memory to a separate file, snapshot.c

This should enable us to untangle the code in the future and eventually
to implement some parts of swsusp.c in the user space.

The patch does not change the code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.14-rc4/include/linux/suspend.h
===================================================================
--- linux-2.6.14-rc4.orig/include/linux/suspend.h	2005-10-11 19:38:18.000000000 +0200
+++ linux-2.6.14-rc4/include/linux/suspend.h	2005-10-11 19:38:48.000000000 +0200
@@ -74,4 +74,10 @@
 extern unsigned long get_usable_page(unsigned gfp_mask);
 extern void free_eaten_memory(void);
 
+/*
+ * XXX: We try to keep some more pages free so that I/O operations succeed
+ * without paging. Might this be more?
+ */
+#define PAGES_FOR_IO	512
+
 #endif /* _LINUX_SWSUSP_H */
Index: linux-2.6.14-rc4/kernel/power/Makefile
===================================================================
--- linux-2.6.14-rc4.orig/kernel/power/Makefile	2005-10-11 19:38:18.000000000 +0200
+++ linux-2.6.14-rc4/kernel/power/Makefile	2005-10-11 19:38:48.000000000 +0200
@@ -4,7 +4,7 @@
 endif
 
 obj-y				:= main.o process.o console.o pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
Index: linux-2.6.14-rc4/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc4.orig/kernel/power/power.h	2005-10-11 19:38:18.000000000 +0200
+++ linux-2.6.14-rc4/kernel/power/power.h	2005-10-11 19:38:48.000000000 +0200
@@ -53,3 +53,20 @@
 
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
+
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+extern unsigned int nr_copy_pages;
+extern suspend_pagedir_t *pagedir_nosave;
+extern suspend_pagedir_t *pagedir_save;
+
+extern asmlinkage int swsusp_arch_suspend(void);
+extern asmlinkage int swsusp_arch_resume(void);
+
+extern int restore_highmem(void);
+extern void free_pagedir(struct pbe *pblist);
+extern struct pbe * alloc_pagedir(unsigned nr_pages);
+extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
+extern int enough_swap(void);
Index: linux-2.6.14-rc4/kernel/power/snapshot.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14-rc4/kernel/power/snapshot.c	2005-10-11 19:38:48.000000000 +0200
@@ -0,0 +1,464 @@
+/*
+ * linux/kernel/power/swsusp.c
+ *
+ * This file is to realize architecture-independent
+ * machine suspend feature using pretty near only high-level routines
+ *
+ * Copyright (C) 1998-2005 Pavel Machek <pavel@suse.cz>
+ *
+ * This file is released under the GPLv2, and is based on swsusp.c.
+ *
+ */
+
+
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <linux/smp_lock.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/bitops.h>
+#include <linux/vt_kern.h>
+#include <linux/kbd_kern.h>
+#include <linux/keyboard.h>
+#include <linux/spinlock.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/swap.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/buffer_head.h>
+#include <linux/swapops.h>
+#include <linux/bootmem.h>
+#include <linux/syscalls.h>
+#include <linux/console.h>
+#include <linux/highmem.h>
+#include <linux/bio.h>
+#include <linux/mount.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+#include <asm/io.h>
+
+#include <linux/random.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+
+#include "power.h"
+
+
+
+
+#ifdef CONFIG_HIGHMEM
+struct highmem_page {
+	char *data;
+	struct page *page;
+	struct highmem_page *next;
+};
+
+static struct highmem_page *highmem_copy;
+
+static int save_highmem_zone(struct zone *zone)
+{
+	unsigned long zone_pfn;
+	mark_free_pages(zone);
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+		struct page *page;
+		struct highmem_page *save;
+		void *kaddr;
+		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+
+		if (!(pfn%1000))
+			printk(".");
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		/*
+		 * This condition results from rvmalloc() sans vmalloc_32()
+		 * and architectural memory reservations. This should be
+		 * corrected eventually when the cases giving rise to this
+		 * are better understood.
+		 */
+		if (PageReserved(page)) {
+			printk("highmem reserved page?!\n");
+			continue;
+		}
+		BUG_ON(PageNosave(page));
+		if (PageNosaveFree(page))
+			continue;
+		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
+		if (!save)
+			return -ENOMEM;
+		save->next = highmem_copy;
+		save->page = page;
+		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
+		if (!save->data) {
+			kfree(save);
+			return -ENOMEM;
+		}
+		kaddr = kmap_atomic(page, KM_USER0);
+		memcpy(save->data, kaddr, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		highmem_copy = save;
+	}
+	return 0;
+}
+#endif /* CONFIG_HIGHMEM */
+
+
+static int save_highmem(void)
+{
+#ifdef CONFIG_HIGHMEM
+	struct zone *zone;
+	int res = 0;
+
+	pr_debug("swsusp: Saving Highmem\n");
+	for_each_zone (zone) {
+		if (is_highmem(zone))
+			res = save_highmem_zone(zone);
+		if (res)
+			return res;
+	}
+#endif
+	return 0;
+}
+
+int restore_highmem(void)
+{
+#ifdef CONFIG_HIGHMEM
+	printk("swsusp: Restoring Highmem\n");
+	while (highmem_copy) {
+		struct highmem_page *save = highmem_copy;
+		void *kaddr;
+		highmem_copy = save->next;
+
+		kaddr = kmap_atomic(save->page, KM_USER0);
+		memcpy(kaddr, save->data, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		free_page((long) save->data);
+		kfree(save);
+	}
+#endif
+	return 0;
+}
+
+
+static int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+/**
+ *	saveable - Determine whether a page should be cloned or not.
+ *	@pfn:	The page
+ *
+ *	We save a page if it's Reserved, and not in the range of pages
+ *	statically defined as 'unsaveable', or if it isn't reserved, and
+ *	isn't part of a free chunk of pages.
+ */
+
+static int saveable(struct zone * zone, unsigned long * zone_pfn)
+{
+	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
+	struct page * page;
+
+	if (!pfn_valid(pfn))
+		return 0;
+
+	page = pfn_to_page(pfn);
+	BUG_ON(PageReserved(page) && PageNosave(page));
+	if (PageNosave(page))
+		return 0;
+	if (PageReserved(page) && pfn_is_nosave(pfn)) {
+		pr_debug("[nosave pfn 0x%lx]", pfn);
+		return 0;
+	}
+	if (PageNosaveFree(page))
+		return 0;
+
+	return 1;
+}
+
+static void count_data_pages(void)
+{
+	struct zone *zone;
+	unsigned long zone_pfn;
+
+	nr_copy_pages = 0;
+
+	for_each_zone (zone) {
+		if (is_highmem(zone))
+			continue;
+		mark_free_pages(zone);
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			nr_copy_pages += saveable(zone, &zone_pfn);
+	}
+}
+
+static void copy_data_pages(void)
+{
+	struct zone *zone;
+	unsigned long zone_pfn;
+	struct pbe *pbe = pagedir_nosave, *p;
+
+	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
+	for_each_zone (zone) {
+		if (is_highmem(zone))
+			continue;
+		mark_free_pages(zone);
+		/* This is necessary for swsusp_free() */
+		for_each_pb_page (p, pagedir_nosave)
+			SetPageNosaveFree(virt_to_page(p));
+		for_each_pbe(p, pagedir_nosave)
+			SetPageNosaveFree(virt_to_page(p->address));
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+			if (saveable(zone, &zone_pfn)) {
+				struct page * page;
+				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+				BUG_ON(!pbe);
+				pbe->orig_address = (unsigned long)page_address(page);
+				/* copy_page is not usable for copying task structs. */
+				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				pbe = pbe->next;
+			}
+		}
+	}
+	BUG_ON(pbe);
+}
+
+
+/**
+ *	free_pagedir - free pages allocated with alloc_pagedir()
+ */
+
+void free_pagedir(struct pbe *pblist)
+{
+	struct pbe *pbe;
+
+	while (pblist) {
+		pbe = (pblist + PB_PAGE_SKIP)->next;
+		ClearPageNosave(virt_to_page(pblist));
+		ClearPageNosaveFree(virt_to_page(pblist));
+		free_page((unsigned long)pblist);
+		pblist = pbe;
+	}
+}
+
+/**
+ *	fill_pb_page - Create a list of PBEs on a given memory page
+ */
+
+static inline void fill_pb_page(struct pbe *pbpage)
+{
+	struct pbe *p;
+
+	p = pbpage;
+	pbpage += PB_PAGE_SKIP;
+	do
+		p->next = p + 1;
+	while (++p < pbpage);
+}
+
+/**
+ *	create_pbe_list - Create a list of PBEs on top of a given chain
+ *	of memory pages allocated with alloc_pagedir()
+ */
+
+void create_pbe_list(struct pbe *pblist, unsigned nr_pages)
+{
+	struct pbe *pbpage, *p;
+	unsigned num = PBES_PER_PAGE;
+
+	for_each_pb_page (pbpage, pblist) {
+		if (num >= nr_pages)
+			break;
+
+		fill_pb_page(pbpage);
+		num += PBES_PER_PAGE;
+	}
+	if (pbpage) {
+		for (num -= PBES_PER_PAGE - 1, p = pbpage; num < nr_pages; p++, num++)
+			p->next = p + 1;
+		p->next = NULL;
+	}
+	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
+}
+
+static void *alloc_image_page(void)
+{
+	void *res = (void *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	if (res) {
+		SetPageNosave(virt_to_page(res));
+		SetPageNosaveFree(virt_to_page(res));
+	}
+	return res;
+}
+
+/**
+ *	alloc_pagedir - Allocate the page directory.
+ *
+ *	First, determine exactly how many pages we need and
+ *	allocate them.
+ *
+ *	We arrange the pages in a chain: each page is an array of PBES_PER_PAGE
+ *	struct pbe elements (pbes) and the last element in the page points
+ *	to the next page.
+ *
+ *	On each page we set up a list of struct_pbe elements.
+ */
+
+struct pbe * alloc_pagedir(unsigned nr_pages)
+{
+	unsigned num;
+	struct pbe *pblist, *pbe;
+
+	if (!nr_pages)
+		return NULL;
+
+	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
+	pblist = (struct pbe *)alloc_image_page();
+	/* FIXME: rewrite this ugly loop */
+	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
+        		pbe = pbe->next, num += PBES_PER_PAGE) {
+		pbe += PB_PAGE_SKIP;
+		pbe->next = (struct pbe *)alloc_image_page();
+	}
+	if (!pbe) { /* get_zeroed_page() failed */
+		free_pagedir(pblist);
+		pblist = NULL;
+        }
+	return pblist;
+}
+
+/**
+ * Free pages we allocated for suspend. Suspend pages are alocated
+ * before atomic copy, so we need to free them after resume.
+ */
+
+void swsusp_free(void)
+{
+	struct zone *zone;
+	unsigned long zone_pfn;
+
+	for_each_zone(zone) {
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			if (pfn_valid(zone_pfn + zone->zone_start_pfn)) {
+				struct page * page;
+				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+				if (PageNosave(page) && PageNosaveFree(page)) {
+					ClearPageNosave(page);
+					ClearPageNosaveFree(page);
+					free_page((long) page_address(page));
+				}
+			}
+	}
+}
+
+
+/**
+ *	enough_free_mem - Make sure we enough free memory to snapshot.
+ *
+ *	Returns TRUE or FALSE after checking the number of available
+ *	free pages.
+ */
+
+static int enough_free_mem(void)
+{
+	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
+	return nr_free_pages() > (nr_copy_pages + PAGES_FOR_IO +
+		nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE));
+}
+
+
+static int swsusp_alloc(void)
+{
+	struct pbe * p;
+
+	pagedir_nosave = NULL;
+
+	if (MAX_PBES < nr_copy_pages / PBES_PER_PAGE +
+	    !!(nr_copy_pages % PBES_PER_PAGE))
+		return -ENOSPC;
+
+	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
+		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
+		return -ENOMEM;
+	}
+	create_pbe_list(pagedir_save, nr_copy_pages);
+	pagedir_nosave = pagedir_save;
+
+	for_each_pbe (p, pagedir_save) {
+		p->address = (unsigned long)alloc_image_page();
+		if (!p->address) {
+			printk(KERN_ERR "suspend: Allocating image pages failed.\n");
+			swsusp_free();
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static int suspend_prepare_image(void)
+{
+	int error;
+
+	pr_debug("swsusp: critical section: \n");
+	if (save_highmem()) {
+		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
+		restore_highmem();
+		return -ENOMEM;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp: Need to copy %u pages\n", nr_copy_pages);
+
+	pr_debug("swsusp: pages needed: %u + %lu + %u, free: %u\n",
+		 nr_copy_pages,
+		 nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE),
+		 PAGES_FOR_IO, nr_free_pages());
+
+	if (!enough_free_mem()) {
+		printk(KERN_ERR "swsusp: Not enough free memory\n");
+		return -ENOMEM;
+	}
+
+	if (!enough_swap()) {
+		printk(KERN_ERR "swsusp: Not enough free swap\n");
+		return -ENOSPC;
+	}
+
+	error = swsusp_alloc();
+	if (error)
+		return error;
+
+	/* During allocating of suspend pagedir, new cold pages may appear.
+	 * Kill them.
+	 */
+	drain_local_pages();
+	copy_data_pages();
+
+	/*
+	 * End of critical section. From now on, we can write to memory,
+	 * but we should not touch disk. This specially means we must _not_
+	 * touch swap space! Except we must write out our image of course.
+	 */
+
+	printk("swsusp: critical section/: done (%d pages copied)\n", nr_copy_pages );
+	return 0;
+}
+
+
+asmlinkage int swsusp_save(void)
+{
+	return suspend_prepare_image();
+}
Index: linux-2.6.14-rc4/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc4.orig/kernel/power/swsusp.c	2005-10-11 19:38:18.000000000 +0200
+++ linux-2.6.14-rc4/kernel/power/swsusp.c	2005-10-11 19:38:48.000000000 +0200
@@ -5,7 +5,7 @@
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001-2004 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@suse.cz>
  *
  * This file is released under the GPLv2.
  *
@@ -84,16 +84,10 @@
 #define MAXKEY 32
 #define MAXIV  32
 
-/* References to section boundaries */
-extern const void __nosave_begin, __nosave_end;
-
-/* Variables to be preserved over suspend */
-static int nr_copy_pages_check;
-
 extern char resume_file[];
 
 /* Local variables that should not be affected by save */
-static unsigned int nr_copy_pages __nosavedata = 0;
+unsigned int nr_copy_pages __nosavedata = 0;
 
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume
@@ -109,7 +103,7 @@
    MMU hardware.
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-static suspend_pagedir_t *pagedir_save;
+suspend_pagedir_t *pagedir_save;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -124,12 +118,6 @@
 static struct swsusp_info swsusp_info;
 
 /*
- * XXX: We try to keep some more pages free so that I/O operations succeed
- * without paging. Might this be more?
- */
-#define PAGES_FOR_IO	512
-
-/*
  * Saving part...
  */
 
@@ -553,327 +541,6 @@
 }
 
 
-#ifdef CONFIG_HIGHMEM
-struct highmem_page {
-	char *data;
-	struct page *page;
-	struct highmem_page *next;
-};
-
-static struct highmem_page *highmem_copy;
-
-static int save_highmem_zone(struct zone *zone)
-{
-	unsigned long zone_pfn;
-	mark_free_pages(zone);
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-		struct page *page;
-		struct highmem_page *save;
-		void *kaddr;
-		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-
-		if (!(pfn%1000))
-			printk(".");
-		if (!pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		/*
-		 * This condition results from rvmalloc() sans vmalloc_32()
-		 * and architectural memory reservations. This should be
-		 * corrected eventually when the cases giving rise to this
-		 * are better understood.
-		 */
-		if (PageReserved(page)) {
-			printk("highmem reserved page?!\n");
-			continue;
-		}
-		BUG_ON(PageNosave(page));
-		if (PageNosaveFree(page))
-			continue;
-		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
-		if (!save)
-			return -ENOMEM;
-		save->next = highmem_copy;
-		save->page = page;
-		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
-		if (!save->data) {
-			kfree(save);
-			return -ENOMEM;
-		}
-		kaddr = kmap_atomic(page, KM_USER0);
-		memcpy(save->data, kaddr, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		highmem_copy = save;
-	}
-	return 0;
-}
-#endif /* CONFIG_HIGHMEM */
-
-
-static int save_highmem(void)
-{
-#ifdef CONFIG_HIGHMEM
-	struct zone *zone;
-	int res = 0;
-
-	pr_debug("swsusp: Saving Highmem\n");
-	for_each_zone (zone) {
-		if (is_highmem(zone))
-			res = save_highmem_zone(zone);
-		if (res)
-			return res;
-	}
-#endif
-	return 0;
-}
-
-static int restore_highmem(void)
-{
-#ifdef CONFIG_HIGHMEM
-	printk("swsusp: Restoring Highmem\n");
-	while (highmem_copy) {
-		struct highmem_page *save = highmem_copy;
-		void *kaddr;
-		highmem_copy = save->next;
-
-		kaddr = kmap_atomic(save->page, KM_USER0);
-		memcpy(kaddr, save->data, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		free_page((long) save->data);
-		kfree(save);
-	}
-#endif
-	return 0;
-}
-
-
-static int pfn_is_nosave(unsigned long pfn)
-{
-	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
-	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
-	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
-}
-
-/**
- *	saveable - Determine whether a page should be cloned or not.
- *	@pfn:	The page
- *
- *	We save a page if it's Reserved, and not in the range of pages
- *	statically defined as 'unsaveable', or if it isn't reserved, and
- *	isn't part of a free chunk of pages.
- */
-
-static int saveable(struct zone * zone, unsigned long * zone_pfn)
-{
-	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
-	struct page * page;
-
-	if (!pfn_valid(pfn))
-		return 0;
-
-	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
-	if (PageNosave(page))
-		return 0;
-	if (PageReserved(page) && pfn_is_nosave(pfn)) {
-		pr_debug("[nosave pfn 0x%lx]", pfn);
-		return 0;
-	}
-	if (PageNosaveFree(page))
-		return 0;
-
-	return 1;
-}
-
-static void count_data_pages(void)
-{
-	struct zone *zone;
-	unsigned long zone_pfn;
-
-	nr_copy_pages = 0;
-
-	for_each_zone (zone) {
-		if (is_highmem(zone))
-			continue;
-		mark_free_pages(zone);
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			nr_copy_pages += saveable(zone, &zone_pfn);
-	}
-}
-
-static void copy_data_pages(void)
-{
-	struct zone *zone;
-	unsigned long zone_pfn;
-	struct pbe *pbe = pagedir_nosave, *p;
-
-	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
-	for_each_zone (zone) {
-		if (is_highmem(zone))
-			continue;
-		mark_free_pages(zone);
-		/* This is necessary for swsusp_free() */
-		for_each_pb_page (p, pagedir_nosave)
-			SetPageNosaveFree(virt_to_page(p));
-		for_each_pbe(p, pagedir_nosave)
-			SetPageNosaveFree(virt_to_page(p->address));
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-			if (saveable(zone, &zone_pfn)) {
-				struct page * page;
-				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
-				BUG_ON(!pbe);
-				pbe->orig_address = (unsigned long)page_address(page);
-				/* copy_page is not usable for copying task structs. */
-				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-				pbe = pbe->next;
-			}
-		}
-	}
-	BUG_ON(pbe);
-}
-
-
-/**
- *	free_pagedir - free pages allocated with alloc_pagedir()
- */
-
-static inline void free_pagedir(struct pbe *pblist)
-{
-	struct pbe *pbe;
-
-	while (pblist) {
-		pbe = (pblist + PB_PAGE_SKIP)->next;
-		ClearPageNosave(virt_to_page(pblist));
-		ClearPageNosaveFree(virt_to_page(pblist));
-		free_page((unsigned long)pblist);
-		pblist = pbe;
-	}
-}
-
-/**
- *	fill_pb_page - Create a list of PBEs on a given memory page
- */
-
-static inline void fill_pb_page(struct pbe *pbpage)
-{
-	struct pbe *p;
-
-	p = pbpage;
-	pbpage += PB_PAGE_SKIP;
-	do
-		p->next = p + 1;
-	while (++p < pbpage);
-}
-
-/**
- *	create_pbe_list - Create a list of PBEs on top of a given chain
- *	of memory pages allocated with alloc_pagedir()
- */
-
-static void create_pbe_list(struct pbe *pblist, unsigned nr_pages)
-{
-	struct pbe *pbpage, *p;
-	unsigned num = PBES_PER_PAGE;
-
-	for_each_pb_page (pbpage, pblist) {
-		if (num >= nr_pages)
-			break;
-
-		fill_pb_page(pbpage);
-		num += PBES_PER_PAGE;
-	}
-	if (pbpage) {
-		for (num -= PBES_PER_PAGE - 1, p = pbpage; num < nr_pages; p++, num++)
-			p->next = p + 1;
-		p->next = NULL;
-	}
-	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
-}
-
-static void *alloc_image_page(void)
-{
-	void *res = (void *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-	if (res) {
-		SetPageNosave(virt_to_page(res));
-		SetPageNosaveFree(virt_to_page(res));
-	}
-	return res;
-}
-
-/**
- *	alloc_pagedir - Allocate the page directory.
- *
- *	First, determine exactly how many pages we need and
- *	allocate them.
- *
- *	We arrange the pages in a chain: each page is an array of PBES_PER_PAGE
- *	struct pbe elements (pbes) and the last element in the page points
- *	to the next page.
- *
- *	On each page we set up a list of struct_pbe elements.
- */
-
-static struct pbe * alloc_pagedir(unsigned nr_pages)
-{
-	unsigned num;
-	struct pbe *pblist, *pbe;
-
-	if (!nr_pages)
-		return NULL;
-
-	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
-	pblist = (struct pbe *)alloc_image_page();
-	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
-        		pbe = pbe->next, num += PBES_PER_PAGE) {
-		pbe += PB_PAGE_SKIP;
-		pbe->next = (struct pbe *)alloc_image_page();
-	}
-	if (!pbe) { /* get_zeroed_page() failed */
-		free_pagedir(pblist);
-		pblist = NULL;
-        }
-	return pblist;
-}
-
-/**
- * Free pages we allocated for suspend. Suspend pages are alocated
- * before atomic copy, so we need to free them after resume.
- */
-
-void swsusp_free(void)
-{
-	struct zone *zone;
-	unsigned long zone_pfn;
-
-	for_each_zone(zone) {
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			if (pfn_valid(zone_pfn + zone->zone_start_pfn)) {
-				struct page * page;
-				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
-				if (PageNosave(page) && PageNosaveFree(page)) {
-					ClearPageNosave(page);
-					ClearPageNosaveFree(page);
-					free_page((long) page_address(page));
-				}
-			}
-	}
-}
-
-/**
- *	enough_free_mem - Make sure we enough free memory to snapshot.
- *
- *	Returns TRUE or FALSE after checking the number of available
- *	free pages.
- */
-
-static int enough_free_mem(void)
-{
-	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
-	return nr_free_pages() > (nr_copy_pages + PAGES_FOR_IO +
-		nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE));
-}
-
-
 /**
  *	enough_swap - Make sure we have enough swap to save the image.
  *
@@ -884,7 +551,7 @@
  *	We should only consider resume_device.
  */
 
-static int enough_swap(void)
+int enough_swap(void)
 {
 	struct sysinfo i;
 
@@ -894,88 +561,6 @@
 		nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE));
 }
 
-static int swsusp_alloc(void)
-{
-	struct pbe * p;
-
-	pagedir_nosave = NULL;
-
-	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
-		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
-		return -ENOMEM;
-	}
-	create_pbe_list(pagedir_save, nr_copy_pages);
-	pagedir_nosave = pagedir_save;
-
-	for_each_pbe (p, pagedir_save) {
-		p->address = (unsigned long)alloc_image_page();
-		if (!p->address) {
-			printk(KERN_ERR "suspend: Allocating image pages failed.\n");
-			swsusp_free();
-			return -ENOMEM;
-		}
-	}
-
-	return 0;
-}
-
-static int suspend_prepare_image(void)
-{
-	int error;
-
-	pr_debug("swsusp: critical section: \n");
-	if (save_highmem()) {
-		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
-		restore_highmem();
-		return -ENOMEM;
-	}
-
-	drain_local_pages();
-	count_data_pages();
-	printk("swsusp: Need to copy %u pages\n", nr_copy_pages);
-	nr_copy_pages_check = nr_copy_pages;
-
-	pr_debug("swsusp: pages needed: %u + %lu + %u, free: %u\n",
-		 nr_copy_pages,
-		 nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE),
-		 PAGES_FOR_IO, nr_free_pages());
-
-	if (!enough_free_mem()) {
-		printk(KERN_ERR "swsusp: Not enough free memory\n");
-		return -ENOMEM;
-	}
-
-	if (MAX_PBES < nr_copy_pages / PBES_PER_PAGE +
-	    !!(nr_copy_pages % PBES_PER_PAGE)) {
-		printk(KERN_ERR "swsusp: Too many image pages\n");
-		return -ENOSPC;
-	}
-
-	if (!enough_swap()) {
-		printk(KERN_ERR "swsusp: Not enough free swap\n");
-		return -ENOSPC;
-	}
-
-	error = swsusp_alloc();
-	if (error)
-		return error;
-
-	/* During allocating of suspend pagedir, new cold pages may appear.
-	 * Kill them.
-	 */
-	drain_local_pages();
-	copy_data_pages();
-
-	/*
-	 * End of critical section. From now on, we can write to memory,
-	 * but we should not touch disk. This specially means we must _not_
-	 * touch swap space! Except we must write out our image of course.
-	 */
-
-	printk("swsusp: critical section/: done (%d pages copied)\n", nr_copy_pages );
-	return 0;
-}
-
 
 /* It is important _NOT_ to umount filesystems at this point. We want
  * them synced (in case something goes wrong) but we DO not want to mark
@@ -995,14 +580,6 @@
 }
 
 
-extern asmlinkage int swsusp_arch_suspend(void);
-extern asmlinkage int swsusp_arch_resume(void);
-
-
-asmlinkage int swsusp_save(void)
-{
-	return suspend_prepare_image();
-}
 
 int swsusp_suspend(void)
 {
@@ -1034,7 +611,6 @@
 		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	restore_highmem();
 	device_power_up();
 	local_irq_enable();

