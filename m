Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWD0Tyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWD0Tyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWD0Tyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:54:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:35027 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750933AbWD0Tya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:54:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [RFC][PATCH] swsusp: support creating bigger images (rev. 2)
Date: Thu, 27 Apr 2006 21:53:46 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200604242355.08111.rjw@sisk.pl> <444DF9B3.7080600@yahoo.com.au> <200604251739.13377.rjw@sisk.pl>
In-Reply-To: <200604251739.13377.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604272153.47566.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 25 April 2006 17:39, Rafael J. Wysocki wrote:
}-- snip --{
> 
> Thanks a lot for the comments.  I'll do my best to follow your suggestions
> in the next version of the patch.

The corrected version of the patch is appended.

A short summary of changes:
- the code that refers to the mm internals moved to mm/rmap.c and mm/vmscan.c
- added some comments (if you think more are needed or the existing ones should
be clarified, please let me know)
- the PageLRU flags are set/reset under spinlocks

Could you please have a look at it?

Greetings,
Rafael

---
 include/linux/rmap.h    |    8 +
 include/linux/swap.h    |    4 
 kernel/power/power.h    |   10 +-
 kernel/power/snapshot.c |  225 +++++++++++++++++++++++++++++++++---------------
 kernel/power/swsusp.c   |   15 +--
 kernel/power/user.c     |    4 
 mm/rmap.c               |   40 ++++++++
 mm/vmscan.c             |   63 +++++++++++++
 8 files changed, 293 insertions(+), 76 deletions(-)

Index: linux-2.6.17-rc2-mm1/mm/rmap.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/mm/rmap.c
+++ linux-2.6.17-rc2-mm1/mm/rmap.c
@@ -851,3 +851,43 @@ int try_to_unmap(struct page *page, int 
 	return ret;
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static int page_mapped_by_task(struct page *page, struct task_struct *task)
+{
+	struct vm_area_struct *vma;
+	int ret = 0;
+
+	spin_lock(&task->mm->page_table_lock);
+
+	for (vma = task->mm->mmap; vma; vma = vma->vm_next)
+		if (page_address_in_vma(page, vma) != -EFAULT) {
+			ret = 1;
+			break;
+		}
+
+	spin_unlock(&task->mm->page_table_lock);
+
+	return ret;
+}
+
+/**
+ *	page_to_copy - determine if a page can be included in the
+ *	suspend image without copying (returns false if that's the case).
+ *
+ *	It is safe to include the page in the suspend image without
+ *	copying if (a) it's on the LRU and (b) it's mapped by a frozen task
+ *	(all tasks except for the current task should be frozen when it's
+ *	called).  Otherwise the page should be copied for this purpose
+ *	(compound pages are avoided for simplicity).
+ */
+
+int page_to_copy(struct page *page)
+{
+	if (!PageLRU(page) || PageCompound(page))
+		return 1;
+	if (page_mapped(page))
+		return page_mapped_by_task(page, current);
+
+	return 1;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
Index: linux-2.6.17-rc2-mm1/include/linux/rmap.h
===================================================================
--- linux-2.6.17-rc2-mm1.orig/include/linux/rmap.h
+++ linux-2.6.17-rc2-mm1/include/linux/rmap.h
@@ -104,6 +104,14 @@ pte_t *page_check_address(struct page *,
  */
 unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/*
+ * Used to determine if the page can be included in the suspend image without
+ * copying
+ */
+int page_to_copy(struct page *);
+#endif
+
 #else	/* !CONFIG_MMU */
 
 #define anon_vma_init()		do {} while (0)
Index: linux-2.6.17-rc2-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/kernel/power/snapshot.c
+++ linux-2.6.17-rc2-mm1/kernel/power/snapshot.c
@@ -13,6 +13,7 @@
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/rmap.h>
 #include <linux/suspend.h>
 #include <linux/smp_lock.h>
 #include <linux/delay.h>
@@ -261,6 +262,14 @@ int restore_special_mem(void)
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
@@ -269,7 +278,7 @@ static int pfn_is_nosave(unsigned long p
 }
 
 /**
- *	saveable - Determine whether a page should be cloned or not.
+ *	saveable - Determine whether a page should be saved or not.
  *	@pfn:	The page
  *
  *	We save a page if it's Reserved, and not in the range of pages
@@ -277,9 +286,8 @@ static int pfn_is_nosave(unsigned long p
  *	isn't part of a free chunk of pages.
  */
 
-static int saveable(struct zone *zone, unsigned long *zone_pfn)
+static int saveable(unsigned long pfn)
 {
-	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
 	struct page *page;
 
 	if (!pfn_valid(pfn))
@@ -296,46 +304,103 @@ static int saveable(struct zone *zone, u
 	return 1;
 }
 
-unsigned int count_data_pages(void)
+/**
+ *	count_data_pages - returns the number of pages that need to be copied
+ *	in order to be included in the suspend snapshot image.  If @total is
+ *	not null, the total number of pages that should be included in the
+ *	snapshot image is stored in the location pointed to by it.
+ */
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
+				if (!page_to_copy(pfn_to_page(pfn)))
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
 
+/**
+ *	copy_data_pages - populates the page backup list @pblist with
+ *	the addresses of the pages that should be included in the
+ *	suspend snapshot image.  The pages that cannot be included in the
+ *	image without copying are copied into empty page frames allocated
+ *	earlier and available from the list page_list (the addresses of
+ *	these page frames are also stored in the page backup list).
+ *
+ *	This function is only called from the critical section, ie. when
+ *	processes are frozen, there's only one CPU online and local IRQs
+ *	are disabled on it.
+ */
+
 static void copy_data_pages(struct pbe *pblist)
 {
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
+				if (page_to_copy(page)) {
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
@@ -419,7 +484,7 @@ static inline void *alloc_image_page(gfp
 	res = (void *)get_zeroed_page(gfp_mask);
 	if (safe_needed)
 		while (res && PageNosaveFree(virt_to_page(res))) {
-			/* The page is unsafe, mark it for swsusp_free() */
+			/* The page is unsafe, mark it for free_image() */
 			SetPageNosave(virt_to_page(res));
 			unsafe_pages++;
 			res = (void *)get_zeroed_page(gfp_mask);
@@ -474,11 +539,32 @@ static struct pbe *alloc_pagedir(unsigne
 }
 
 /**
+ *	protect_data_pages - move data pages that need to be protected from
+ *	being reclaimed (ie. those included in the suspend image without
+ *	copying) out of their respective LRU lists.  This is done after the
+ *	image has been created so the LRU lists only have to be restored if
+ *	the suspend fails.
+ *
+ *	This function is only called from the critical section, ie. when
+ *	processes are frozen, there's only one CPU online and local IRQs
+ *	are disabled on it.
+ */
+
+static void protect_data_pages(struct pbe *pblist)
+{
+	struct pbe *p;
+
+	for_each_pbe (p, pblist)
+		if (p->address == p->orig_address)
+			move_out_of_lru(virt_to_page(p->address));
+}
+
+/**
  * Free pages we allocated for suspend. Suspend pages are alocated
  * before atomic copy, so we need to free them after resume.
  */
 
-void swsusp_free(void)
+void free_image(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
@@ -501,6 +587,11 @@ void swsusp_free(void)
 	buffer = NULL;
 }
 
+void swsusp_free(void)
+{
+	free_image();
+	restore_active_inactive_lists();
+}
 
 /**
  *	enough_free_mem - Make sure we enough free memory to snapshot.
@@ -509,32 +600,33 @@ void swsusp_free(void)
  *	free pages.
  */
 
-static int enough_free_mem(unsigned int nr_pages)
+static int enough_free_mem(unsigned int nr_pages, unsigned int copy_pages)
 {
 	struct zone *zone;
-	unsigned int n = 0;
+	long n = 0;
+
+	pr_debug("swsusp: pages needed: %u + %lu + %lu\n",
+		 copy_pages,
+		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
+		 EXTRA_PAGES);
 
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
+			/*
+			 * We're going to use atomic allocations, so we
+			 * shouldn't count the lowmem reserves in the lower
+			 * zones as available to us
+			 */
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
 
@@ -543,10 +635,19 @@ static struct pbe *swsusp_alloc(unsigned
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
@@ -554,25 +655,21 @@ static struct pbe *swsusp_alloc(unsigned
 
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
 
@@ -582,6 +679,9 @@ asmlinkage int swsusp_save(void)
 	drain_local_pages();
 	copy_data_pages(pagedir_nosave);
 
+	/* Make sure the pages that we have not copied won't be reclaimed */
+	protect_data_pages(pagedir_nosave);
+
 	/*
 	 * End of critical section. From now on, we can write to memory,
 	 * but we should not touch disk. This specially means we must _not_
@@ -591,7 +691,7 @@ asmlinkage int swsusp_save(void)
 	nr_copy_pages = nr_pages;
 	nr_meta_pages = (nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
+	printk("swsusp: critical section/: done (%d pages)\n", nr_pages);
 	return 0;
 }
 
@@ -654,7 +754,7 @@ int snapshot_read_next(struct snapshot_h
 	if (handle->page > nr_meta_pages + nr_copy_pages)
 		return 0;
 	if (!buffer) {
-		/* This makes the buffer be freed by swsusp_free() */
+		/* This makes the buffer be freed by free_image() */
 		buffer = alloc_image_page(GFP_ATOMIC, 0);
 		if (!buffer)
 			return -ENOMEM;
@@ -810,13 +910,6 @@ static inline struct pbe *unpack_orig_ad
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
@@ -833,21 +926,21 @@ static int prepare_image(struct snapshot
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
@@ -858,7 +951,7 @@ static int prepare_image(struct snapshot
 		pagedir_nosave = pblist;
 	} else {
 		handle->pbe = NULL;
-		swsusp_free();
+		free_image();
 	}
 	return error;
 }
@@ -882,8 +975,8 @@ static void *get_buffer(struct snapshot_
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
@@ -919,7 +1012,7 @@ int snapshot_write_next(struct snapshot_
 	if (handle->prev && handle->page > nr_meta_pages + nr_copy_pages)
 		return 0;
 	if (!buffer) {
-		/* This makes the buffer be freed by swsusp_free() */
+		/* This makes the buffer be freed by free_image() */
 		buffer = alloc_image_page(GFP_ATOMIC, 0);
 		if (!buffer)
 			return -ENOMEM;
Index: linux-2.6.17-rc2-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.17-rc2-mm1.orig/kernel/power/power.h
+++ linux-2.6.17-rc2-mm1/kernel/power/power.h
@@ -48,7 +48,14 @@ extern dev_t swsusp_resume_device;
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
-extern unsigned int count_data_pages(void);
+#if (defined(CONFIG_BLK_DEV_INITRD) && defined(CONFIG_BLK_DEV_RAM))
+#define EXTRA_PAGES	(PAGES_FOR_IO + \
+			(2 * CONFIG_BLK_DEV_RAM_SIZE * 1024) / PAGE_SIZE)
+#else
+#define EXTRA_PAGES	PAGES_FOR_IO
+#endif
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
Index: linux-2.6.17-rc2-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/kernel/power/swsusp.c
+++ linux-2.6.17-rc2-mm1/kernel/power/swsusp.c
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
Index: linux-2.6.17-rc2-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/kernel/power/user.c
+++ linux-2.6.17-rc2-mm1/kernel/power/user.c
@@ -153,6 +153,10 @@ static int snapshot_ioctl(struct inode *
 	case SNAPSHOT_UNFREEZE:
 		if (!data->frozen)
 			break;
+		if (data->ready && in_suspend) {
+			error = -EPERM;
+			break;
+		}
 		down(&pm_sem);
 		thaw_processes();
 		enable_nonboot_cpus();
Index: linux-2.6.17-rc2-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/mm/vmscan.c
+++ linux-2.6.17-rc2-mm1/mm/vmscan.c
@@ -1437,7 +1437,68 @@ out:
 
 	return ret;
 }
-#endif
+
+static LIST_HEAD(saved_active_pages);
+static LIST_HEAD(saved_inactive_pages);
+
+/**
+ *	move_out_of_lru - software suspend includes some pages in the
+ *	suspend snapshot image without copying and these pages should be
+ *	procected from being reclaimed, which can be done by (temporarily)
+ *	moving them out of their respective LRU lists
+ *
+ *	It is to be called with local IRQs disabled.
+ */
+
+void move_out_of_lru(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+
+	spin_lock(&zone->lru_lock);
+	if (PageActive(page)) {
+		del_page_from_active_list(zone, page);
+		list_add(&page->lru, &saved_active_pages);
+	} else {
+		del_page_from_inactive_list(zone, page);
+		list_add(&page->lru, &saved_inactive_pages);
+	}
+	ClearPageLRU(page);
+	spin_unlock(&zone->lru_lock);
+}
+
+
+/**
+ *	restore_active_inactive_lists - used by the software suspend to move
+ *	the pages taken out of the LRU by take_page_out_of_lru() back to
+ *	their respective active/inactive lists (if the suspend fails)
+ */
+
+void restore_active_inactive_lists(void)
+{
+	struct page *page;
+	struct zone *zone;
+
+	while(!list_empty(&saved_active_pages)) {
+		page = lru_to_page(&saved_active_pages);
+		zone = page_zone(page);
+		list_del(&page->lru);
+		spin_lock_irq(&zone->lru_lock);
+		SetPageLRU(page);
+		add_page_to_active_list(zone, page);
+		spin_unlock_irq(&zone->lru_lock);
+	}
+
+	while(!list_empty(&saved_inactive_pages)) {
+		page = lru_to_page(&saved_inactive_pages);
+		zone = page_zone(page);
+		list_del(&page->lru);
+		spin_lock_irq(&zone->lru_lock);
+		SetPageLRU(page);
+		add_page_to_inactive_list(zone, page);
+		spin_unlock_irq(&zone->lru_lock);
+	}
+}
+#endif /* CONFIG_PM */
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* It's optimal to keep kswapds on the same CPUs as their memory, but
Index: linux-2.6.17-rc2-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc2-mm1.orig/include/linux/swap.h
+++ linux-2.6.17-rc2-mm1/include/linux/swap.h
@@ -184,7 +184,9 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern unsigned long try_to_free_pages(struct zone **, gfp_t);
-extern unsigned long shrink_all_memory(unsigned long nr_pages);
+extern unsigned long shrink_all_memory(unsigned long);
+extern void move_out_of_lru(struct page *page);
+extern void restore_active_inactive_lists(void);
 extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
 
