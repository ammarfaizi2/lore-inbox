Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWDXVzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWDXVzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWDXVzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:55:38 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:44727 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750710AbWDXVzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:55:37 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH] swsusp: support creating bigger images
Date: Mon, 24 Apr 2006 23:55:07 +0200
User-Agent: KMail/1.9.1
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604242355.08111.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The appended patch allows swsusp to break the "50% of the normal zone" limit.
This is achieved by using the observation that pages mapped by frozen
userland tasks need not be copied before saving.

The pages mapped by the frozen tasks are selected by checking if
page_mapped(page) returns true for them and whether they are not mapped
by the current task.  These pages are included in the snapshot image without
copying, because we wouldn't be able to rollback the suspend if they were
modified before or in the process of saving the image.

[I'm tempted to treat the page cache pages in a similar way, for the following
reason: AFAIK the page cache pages are only modified during block I/O
operations (or when they are reclaimed, but that's covered below).  The only
process that can perform such operations after the suspend image has been
created is the current task (ie. the suspending process).  However, the
current task must not perform any filesystem operations after creating the
image or it would probably corrupt some filesystems and thus its page cache
pages related to filesystems are not modified during suspend.  Of course
it may perform block I/O operations using block devices directly (eg. it
does this to save the image), but then such operations cannot be started
_before_ creating the image and _continued_ after the image has been created
or there's a risk of leaving the block device in an inconsistent state if the
suspend is successful.]

Still, it seems to be possible, although very unlikely, that these pages will
be reclaimed by try_to_free_pages() if there's not enough memory while
saving the image (at least I couldn't convince myself that it was impossible).
Therefore the patch takes these pages out of reach of try_to_free_pages()
by (temporarily) moving them out of their respective LRU lists.  This is done
after the image has been created so the LRU lists have to be restored only
if the suspend fails.

With this patch applied I was able to save (and restore ;-)) ~800 MB suspend
images on a box with 1 GB of RAM.

[Please don't beat me very hard, just couldn't resist. ;-)]

Greetings,
Rafael

---
 include/linux/rmap.h    |    6 +
 kernel/power/power.h    |   10 +
 kernel/power/snapshot.c |  259 +++++++++++++++++++++++++++++++++++-------------
 kernel/power/swsusp.c   |   15 +-
 kernel/power/user.c     |    4 
 mm/rmap.c               |   19 +++
 6 files changed, 238 insertions(+), 75 deletions(-)

Index: linux-2.6.17-rc1-mm3/mm/rmap.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/mm/rmap.c	2006-04-22 10:34:33.000000000 +0200
+++ linux-2.6.17-rc1-mm3/mm/rmap.c	2006-04-23 00:41:19.000000000 +0200
@@ -851,3 +851,22 @@ int try_to_unmap(struct page *page, int 
 	return ret;
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+int page_mapped_by_current(struct page *page)
+{
+	struct vm_area_struct *vma;
+	int ret = 0;
+
+	spin_lock(&current->mm->page_table_lock);
+
+	for (vma = current->mm->mmap; vma; vma = vma->vm_next)
+		if (page_address_in_vma(page, vma) != -EFAULT) {
+			ret = 1;
+			break;
+		}
+
+	spin_unlock(&current->mm->page_table_lock);
+
+	return ret;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
Index: linux-2.6.17-rc1-mm3/include/linux/rmap.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/linux/rmap.h	2006-04-22 10:34:33.000000000 +0200
+++ linux-2.6.17-rc1-mm3/include/linux/rmap.h	2006-04-22 10:34:45.000000000 +0200
@@ -104,6 +104,12 @@ pte_t *page_check_address(struct page *,
  */
 unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+int page_mapped_by_current(struct page *);
+#else
+static inline int page_mapped_by_current(struct page *page) { return 0; }
+#endif /* CONFIG_SOFTWARE_SUSPEND */
+
 #else	/* !CONFIG_MMU */
 
 #define anon_vma_init()		do {} while (0)
Index: linux-2.6.17-rc1-mm3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/power/snapshot.c	2006-04-22 10:34:33.000000000 +0200
+++ linux-2.6.17-rc1-mm3/kernel/power/snapshot.c	2006-04-23 11:40:13.000000000 +0200
@@ -13,6 +13,8 @@
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
+#include <linux/rmap.h>
 #include <linux/suspend.h>
 #include <linux/smp_lock.h>
 #include <linux/delay.h>
@@ -78,7 +80,7 @@ static int save_arch_mem(void)
 	void *kaddr;
 	struct arch_saveable_page *tmp = arch_pages;
 
-	pr_debug("swsusp: Saving arch specific memory");
+	pr_debug("swsusp: Saving arch specific memory\n");
 	while (tmp) {
 		tmp->data = (void *)__get_free_page(GFP_ATOMIC);
 		if (!tmp->data)
@@ -251,6 +253,14 @@ int restore_special_mem(void)
 	return ret;
 }
 
+/* Represents a stacked allocated page to be used in the future */
+struct res_page {
+	struct res_page *next;
+	char padding[PAGE_SIZE - sizeof(void *)];
+};
+
+static struct res_page *page_list;
+
 static int pfn_is_nosave(unsigned long pfn)
 {
 	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
@@ -259,7 +269,7 @@ static int pfn_is_nosave(unsigned long p
 }
 
 /**
- *	saveable - Determine whether a page should be cloned or not.
+ *	saveable - Determine whether a page should be saved or not.
  *	@pfn:	The page
  *
  *	We save a page if it's Reserved, and not in the range of pages
@@ -267,9 +277,8 @@ static int pfn_is_nosave(unsigned long p
  *	isn't part of a free chunk of pages.
  */
 
-static int saveable(struct zone *zone, unsigned long *zone_pfn)
+static int saveable(unsigned long pfn)
 {
-	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
 	struct page *page;
 
 	if (!pfn_valid(pfn))
@@ -286,20 +295,46 @@ static int saveable(struct zone *zone, u
 	return 1;
 }
 
-unsigned int count_data_pages(void)
+/**
+ *	need_to_copy - determine if a page needs to be copied before saving.
+ *	Returns false if the page can be saved without copying.
+ */
+
+static int need_to_copy(struct page *page)
+{
+	if (!PageLRU(page) || PageCompound(page))
+		return 1;
+	if (page_mapped(page))
+		return page_mapped_by_current(page);
+
+	return 1;
+}
+
+unsigned int count_data_pages(unsigned int *total)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	unsigned int n = 0;
+	unsigned int n, m;
 
+	n = m = 0;
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			n += saveable(zone, &zone_pfn);
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+			unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+
+			if (saveable(pfn)) {
+				n++;
+				if (!need_to_copy(pfn_to_page(pfn)))
+					m++;
+			}
+		}
 	}
-	return n;
+	if (total)
+		*total = n;
+
+	return n - m;
 }
 
 static void copy_data_pages(struct pbe *pblist)
@@ -307,25 +342,51 @@ static void copy_data_pages(struct pbe *
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe *pbe, *p;
+	struct res_page *ptr;
 
 	pbe = pblist;
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
+
 		mark_free_pages(zone);
-		/* This is necessary for swsusp_free() */
+		/* This is necessary for free_image() */
 		for_each_pb_page (p, pblist)
 			SetPageNosaveFree(virt_to_page(p));
+
 		for_each_pbe (p, pblist)
-			SetPageNosaveFree(virt_to_page(p->address));
+			if (p->address && p->orig_address != p->address)
+				SetPageNosaveFree(virt_to_page(p->address));
+
+		ptr = page_list;
+		while (ptr) {
+			SetPageNosaveFree(virt_to_page(ptr));
+			ptr = ptr->next;
+		}
+
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-			if (saveable(zone, &zone_pfn)) {
+			unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+
+			if (saveable(pfn)) {
 				struct page *page;
-				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+
 				BUG_ON(!pbe);
+				page = pfn_to_page(pfn);
 				pbe->orig_address = (unsigned long)page_address(page);
-				/* copy_page is not usable for copying task structs. */
-				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				if (need_to_copy(page)) {
+					BUG_ON(!page_list);
+					pbe->address = (unsigned long)page_list;
+					page_list = page_list->next;
+					/*
+					 * copy_page is not usable for copying
+					 * task structs.
+					 */
+					memcpy((void *)pbe->address,
+						(void *)pbe->orig_address,
+						PAGE_SIZE);
+				} else {
+					pbe->address = pbe->orig_address;
+				}
 				pbe = pbe->next;
 			}
 		}
@@ -409,7 +470,7 @@ static inline void *alloc_image_page(gfp
 	res = (void *)get_zeroed_page(gfp_mask);
 	if (safe_needed)
 		while (res && PageNosaveFree(virt_to_page(res))) {
-			/* The page is unsafe, mark it for swsusp_free() */
+			/* The page is unsafe, mark it for free_image() */
 			SetPageNosave(virt_to_page(res));
 			unsafe_pages++;
 			res = (void *)get_zeroed_page(gfp_mask);
@@ -462,12 +523,74 @@ struct pbe *alloc_pagedir(unsigned int n
 	return pblist;
 }
 
+static LIST_HEAD(active_pages);
+static LIST_HEAD(inactive_pages);
+
+/**
+ *	protect_data_pages - move data pages that need to be protected from
+ *	being reclaimed out of their respective LRU lists
+ */
+
+static void protect_data_pages(struct pbe *pblist)
+{
+	struct pbe *p;
+
+	for_each_pbe (p, pblist)
+		if (p->address == p->orig_address) {
+			struct page *page = virt_to_page(p->address);
+			struct zone *zone = page_zone(page);
+
+			spin_lock(&zone->lru_lock);
+			if (PageActive(page)) {
+				del_page_from_active_list(zone, page);
+				list_add(&page->lru, &active_pages);
+			} else {
+				del_page_from_inactive_list(zone, page);
+				list_add(&page->lru, &inactive_pages);
+			}
+			spin_unlock(&zone->lru_lock);
+			ClearPageLRU(page);
+		}
+}
+
+/**
+ *	restore_active_inactive_lists - if suspend fails, the pages protected
+ *	with protect_data_pages() have to be moved back to their respective
+ *	lists
+ */
+
+static void restore_active_inactive_lists(void)
+{
+	struct page *page;
+	struct zone *zone;
+
+	while(!list_empty(&active_pages)) {
+		page = list_entry(active_pages.prev, struct page, lru);
+		zone = page_zone(page);
+		list_del(&page->lru);
+		SetPageLRU(page);
+		spin_lock_irq(&zone->lru_lock);
+		add_page_to_active_list(zone, page);
+		spin_unlock_irq(&zone->lru_lock);
+	}
+
+	while(!list_empty(&inactive_pages)) {
+		page = list_entry(inactive_pages.prev, struct page, lru);
+		zone = page_zone(page);
+		list_del(&page->lru);
+		SetPageLRU(page);
+		spin_lock_irq(&zone->lru_lock);
+		add_page_to_inactive_list(zone, page);
+		spin_unlock_irq(&zone->lru_lock);
+	}
+}
+
 /**
  * Free pages we allocated for suspend. Suspend pages are alocated
  * before atomic copy, so we need to free them after resume.
  */
 
-void swsusp_free(void)
+void free_image(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
@@ -490,6 +613,11 @@ void swsusp_free(void)
 	buffer = NULL;
 }
 
+void swsusp_free(void)
+{
+	free_image();
+	restore_active_inactive_lists();
+}
 
 /**
  *	enough_free_mem - Make sure we enough free memory to snapshot.
@@ -498,32 +626,28 @@ void swsusp_free(void)
  *	free pages.
  */
 
-static int enough_free_mem(unsigned int nr_pages)
+static int enough_free_mem(unsigned int nr_pages, unsigned int copy_pages)
 {
 	struct zone *zone;
-	unsigned int n = 0;
+	long n = 0;
+
+	pr_debug("swsusp: pages needed: %u + %lu + %lu, free: %u\n",
+		 copy_pages,
+		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
+		 EXTRA_PAGES, nr_free_pages());
 
 	for_each_zone (zone)
-		if (!is_highmem(zone))
+		if (!is_highmem(zone) && populated_zone(zone)) {
 			n += zone->free_pages;
-	pr_debug("swsusp: available memory: %u pages\n", n);
-	return n > (nr_pages + PAGES_FOR_IO +
-		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
-}
-
-static int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed)
-{
-	struct pbe *p;
+			n -= zone->lowmem_reserve[ZONE_NORMAL];
+		}
 
-	for_each_pbe (p, pblist) {
-		p->address = (unsigned long)alloc_image_page(gfp_mask, safe_needed);
-		if (!p->address)
-			return -ENOMEM;
-	}
-	return 0;
+	pr_debug("swsusp: available memory: %ld pages\n", n);
+	return n > (long)(copy_pages + EXTRA_PAGES +
+		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
-static struct pbe *swsusp_alloc(unsigned int nr_pages)
+static struct pbe *swsusp_alloc(unsigned int nr_pages, unsigned int copy_pages)
 {
 	struct pbe *pblist;
 
@@ -532,10 +656,19 @@ static struct pbe *swsusp_alloc(unsigned
 		return NULL;
 	}
 
-	if (alloc_data_pages(pblist, GFP_ATOMIC | __GFP_COLD, 0)) {
-		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
-		swsusp_free();
-		return NULL;
+	page_list = NULL;
+	while (copy_pages--) {
+		struct res_page *ptr;
+
+		ptr = alloc_image_page(GFP_ATOMIC | __GFP_COLD, 0);
+		if (!ptr) {
+			printk(KERN_ERR
+				"suspend: Allocating image pages failed.\n");
+			free_image();
+			return NULL;
+		}
+		ptr->next = page_list;
+		page_list = ptr;
 	}
 
 	return pblist;
@@ -543,25 +676,21 @@ static struct pbe *swsusp_alloc(unsigned
 
 asmlinkage int swsusp_save(void)
 {
-	unsigned int nr_pages;
+	unsigned int nr_pages, copy_pages;
 
 	pr_debug("swsusp: critical section: \n");
 
 	drain_local_pages();
-	nr_pages = count_data_pages();
-	printk("swsusp: Need to copy %u pages\n", nr_pages);
-
-	pr_debug("swsusp: pages needed: %u + %lu + %u, free: %u\n",
-		 nr_pages,
-		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
-		 PAGES_FOR_IO, nr_free_pages());
+	copy_pages = count_data_pages(&nr_pages);
+	printk("swsusp: Need to save %u pages\n", nr_pages);
+	printk("swsusp: %u pages to copy\n", copy_pages);
 
-	if (!enough_free_mem(nr_pages)) {
+	if (!enough_free_mem(nr_pages, copy_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free memory\n");
 		return -ENOMEM;
 	}
 
-	pagedir_nosave = swsusp_alloc(nr_pages);
+	pagedir_nosave = swsusp_alloc(nr_pages, copy_pages);
 	if (!pagedir_nosave)
 		return -ENOMEM;
 
@@ -571,6 +700,9 @@ asmlinkage int swsusp_save(void)
 	drain_local_pages();
 	copy_data_pages(pagedir_nosave);
 
+	/* Make sure the pages that we have not copied won't be reclaimed */
+	protect_data_pages(pagedir_nosave);
+
 	/*
 	 * End of critical section. From now on, we can write to memory,
 	 * but we should not touch disk. This specially means we must _not_
@@ -580,7 +712,7 @@ asmlinkage int swsusp_save(void)
 	nr_copy_pages = nr_pages;
 	nr_meta_pages = (nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
+	printk("swsusp: critical section/: done (%d pages)\n", nr_pages);
 	return 0;
 }
 
@@ -643,7 +775,7 @@ int snapshot_read_next(struct snapshot_h
 	if (handle->page > nr_meta_pages + nr_copy_pages)
 		return 0;
 	if (!buffer) {
-		/* This makes the buffer be freed by swsusp_free() */
+		/* This makes the buffer be freed by free_image() */
 		buffer = alloc_image_page(GFP_ATOMIC, 0);
 		if (!buffer)
 			return -ENOMEM;
@@ -799,13 +931,6 @@ static inline struct pbe *unpack_orig_ad
  *	of "safe" which will be used later
  */
 
-struct safe_page {
-	struct safe_page *next;
-	char padding[PAGE_SIZE - sizeof(void *)];
-};
-
-static struct safe_page *safe_pages;
-
 static int prepare_image(struct snapshot_handle *handle)
 {
 	int error = 0;
@@ -822,21 +947,21 @@ static int prepare_image(struct snapshot
 		if (!pblist)
 			error = -ENOMEM;
 	}
-	safe_pages = NULL;
+	page_list = NULL;
 	if (!error && nr_pages > unsafe_pages) {
 		nr_pages -= unsafe_pages;
 		while (nr_pages--) {
-			struct safe_page *ptr;
+			struct res_page *ptr;
 
-			ptr = (struct safe_page *)get_zeroed_page(GFP_ATOMIC);
+			ptr = (struct res_page *)get_zeroed_page(GFP_ATOMIC);
 			if (!ptr) {
 				error = -ENOMEM;
 				break;
 			}
 			if (!PageNosaveFree(virt_to_page(ptr))) {
 				/* The page is "safe", add it to the list */
-				ptr->next = safe_pages;
-				safe_pages = ptr;
+				ptr->next = page_list;
+				page_list = ptr;
 			}
 			/* Mark the page as allocated */
 			SetPageNosave(virt_to_page(ptr));
@@ -847,7 +972,7 @@ static int prepare_image(struct snapshot
 		pagedir_nosave = pblist;
 	} else {
 		handle->pbe = NULL;
-		swsusp_free();
+		free_image();
 	}
 	return error;
 }
@@ -871,8 +996,8 @@ static void *get_buffer(struct snapshot_
 	 * The "original" page frame has not been allocated and we have to
 	 * use a "safe" page frame to store the read page
 	 */
-	pbe->address = (unsigned long)safe_pages;
-	safe_pages = safe_pages->next;
+	pbe->address = (unsigned long)page_list;
+	page_list = page_list->next;
 	if (last)
 		last->next = pbe;
 	handle->last_pbe = pbe;
@@ -908,7 +1033,7 @@ int snapshot_write_next(struct snapshot_
 	if (handle->prev && handle->page > nr_meta_pages + nr_copy_pages)
 		return 0;
 	if (!buffer) {
-		/* This makes the buffer be freed by swsusp_free() */
+		/* This makes the buffer be freed by free_image() */
 		buffer = alloc_image_page(GFP_ATOMIC, 0);
 		if (!buffer)
 			return -ENOMEM;
Index: linux-2.6.17-rc1-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/power/power.h	2006-04-22 10:34:33.000000000 +0200
+++ linux-2.6.17-rc1-mm3/kernel/power/power.h	2006-04-22 10:34:45.000000000 +0200
@@ -48,7 +48,14 @@ extern dev_t swsusp_resume_device;
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
-extern unsigned int count_data_pages(void);
+#ifdef CONFIG_BLK_DEV_INITRD
+#define EXTRA_PAGES	(PAGES_FOR_IO + \
+			(2 * CONFIG_BLK_DEV_RAM_SIZE * 1024) / PAGE_SIZE)
+#else
+#define EXTRA_PAGES	PAGES_FOR_IO
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+extern unsigned int count_data_pages(unsigned int *total);
 
 struct snapshot_handle {
 	loff_t		offset;
@@ -111,6 +118,7 @@ extern int restore_special_mem(void);
 
 extern int swsusp_check(void);
 extern int swsusp_shrink_memory(void);
+extern void free_image(void);
 extern void swsusp_free(void);
 extern int swsusp_suspend(void);
 extern int swsusp_resume(void);
Index: linux-2.6.17-rc1-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/power/swsusp.c	2006-04-22 10:34:33.000000000 +0200
+++ linux-2.6.17-rc1-mm3/kernel/power/swsusp.c	2006-04-22 10:34:45.000000000 +0200
@@ -177,28 +177,29 @@ int swsusp_shrink_memory(void)
 	long size, tmp;
 	struct zone *zone;
 	unsigned long pages = 0;
-	unsigned int i = 0;
+	unsigned int to_save, i = 0;
 	char *p = "-\\|/";
 
 	printk("Shrinking memory...  ");
 	do {
 		size = 2 * count_special_pages();
-		size += size / 50 + count_data_pages();
-		size += (size + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
-			PAGES_FOR_IO;
+		size += size / 50 + count_data_pages(&to_save);
+		size += (to_save + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
+			EXTRA_PAGES;
 		tmp = size;
 		for_each_zone (zone)
 			if (!is_highmem(zone) && populated_zone(zone)) {
 				tmp -= zone->free_pages;
 				tmp += zone->lowmem_reserve[ZONE_NORMAL];
 			}
+		size = to_save * (PAGE_SIZE + sizeof(long));
 		if (tmp > 0) {
 			tmp = __shrink_memory(tmp);
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
-		} else if (size > image_size / PAGE_SIZE) {
-			tmp = __shrink_memory(size - (image_size / PAGE_SIZE));
+		} else if (size > image_size) {
+			tmp = __shrink_memory(size - image_size);
 			pages += tmp;
 		}
 		printk("\b%c", p[i++%4]);
@@ -261,7 +262,7 @@ int swsusp_resume(void)
 	 * very tight, so we have to free it as soon as we can to avoid
 	 * subsequent failures
 	 */
-	swsusp_free();
+	free_image();
 	restore_processor_state();
 	restore_special_mem();
 	touch_softlockup_watchdog();
Index: linux-2.6.17-rc1-mm3/kernel/power/user.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/power/user.c	2006-04-22 10:34:33.000000000 +0200
+++ linux-2.6.17-rc1-mm3/kernel/power/user.c	2006-04-22 10:34:45.000000000 +0200
@@ -153,6 +153,10 @@ static int snapshot_ioctl(struct inode *
 	case SNAPSHOT_UNFREEZE:
 		if (!data->frozen)
 			break;
+		if (data->ready) {
+			error = -EPERM;
+			break;
+		}
 		down(&pm_sem);
 		thaw_processes();
 		enable_nonboot_cpus();
