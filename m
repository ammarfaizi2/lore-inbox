Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVKLU1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVKLU1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVKLU1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:27:42 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:59283 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964780AbVKLU11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:27:27 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFT][PATCH 3/3] swsusp: improve freeing of memory
Date: Sat, 12 Nov 2005 21:24:42 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>
References: <200511122113.22177.rjw@sisk.pl>
In-Reply-To: <200511122113.22177.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511122124.42675.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes swsusp free only as much memory as needed and not as much
as possible.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/suspend.h |    2 -
 kernel/power/disk.c     |   30 ++--------------------
 kernel/power/power.h    |   20 ++++++++++++--
 kernel/power/snapshot.c |   65 ++++++++++++++++++++++++++++++++++++++++++++----
 kernel/power/swsusp.c   |   45 ++++++++++++++++++++++++++++++++-
 5 files changed, 125 insertions(+), 37 deletions(-)

Index: linux-2.6.14-mm2/kernel/power/disk.c
===================================================================
--- linux-2.6.14-mm2.orig/kernel/power/disk.c	2005-11-12 12:07:47.000000000 +0100
+++ linux-2.6.14-mm2/kernel/power/disk.c	2005-11-12 12:10:54.000000000 +0100
@@ -24,6 +24,7 @@
 
 extern suspend_disk_method_t pm_disk_mode;
 
+extern int swsusp_shrink_memory(void);
 extern int swsusp_suspend(void);
 extern int swsusp_write(struct pbe *pblist, unsigned int nr_pages);
 extern int swsusp_check(void);
@@ -73,31 +74,6 @@
 static int in_suspend __nosavedata = 0;
 
 
-/**
- *	free_some_memory -  Try to free as much memory as possible
- *
- *	... but do not OOM-kill anyone
- *
- *	Notice: all userland should be stopped at this point, or
- *	livelock is possible.
- */
-
-static void free_some_memory(void)
-{
-	unsigned int i = 0;
-	unsigned int tmp;
-	unsigned long pages = 0;
-	char *p = "-\\|/";
-
-	printk("Freeing memory...  ");
-	while ((tmp = shrink_all_memory(10000))) {
-		pages += tmp;
-		printk("\b%c", p[i++ % 4]);
-	}
-	printk("\bdone (%li pages freed)\n", pages);
-}
-
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -127,8 +103,8 @@
 	}
 
 	/* Free memory before shutting down devices. */
-	free_some_memory();
-	return 0;
+	if (!(error = swsusp_shrink_memory()))
+		return 0;
 thaw:
 	thaw_processes();
 	enable_nonboot_cpus();
Index: linux-2.6.14-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.14-mm2.orig/kernel/power/power.h	2005-11-12 12:07:47.000000000 +0100
+++ linux-2.6.14-mm2/kernel/power/power.h	2005-11-12 12:10:54.000000000 +0100
@@ -49,18 +49,32 @@
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
 
-
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
 extern unsigned int nr_copy_pages;
-extern suspend_pagedir_t *pagedir_nosave;
-extern suspend_pagedir_t *pagedir_save;
+extern struct pbe *pagedir_nosave;
+
+/*
+ * This compilation switch determines the way in which memory will be freed
+ * during suspend.  If defined, only as much memory will be freed as needed
+ * to complete the suspend.  Otherwise, the largest possible amount of memory
+ * will be freed.
+ */
+#define OPPORTUNISTIC_SHRINKING		1
+
+/*
+ * During suspend, on each attempt to free some more memory SHRINK_BITE
+ * is used as the number of pages to free
+ */
+#define SHRINK_BITE	10000
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
+extern unsigned int count_data_pages(void);
 extern void free_pagedir(struct pbe *pblist);
+extern void release_eaten_pages(void);
 extern struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed);
 extern void swsusp_free(void);
 extern int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed);
Index: linux-2.6.14-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-mm2.orig/kernel/power/snapshot.c	2005-11-12 12:07:47.000000000 +0100
+++ linux-2.6.14-mm2/kernel/power/snapshot.c	2005-11-12 12:10:54.000000000 +0100
@@ -37,6 +37,31 @@
 unsigned int nr_copy_pages = 0;
 
 #ifdef CONFIG_HIGHMEM
+unsigned int count_highmem_pages(void)
+{
+	struct zone *zone;
+	unsigned long zone_pfn;
+	unsigned int n = 0;
+
+	for_each_zone (zone)
+		if (is_highmem(zone)) {
+			mark_free_pages(zone);
+			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; zone_pfn++) {
+				struct page *page;
+				unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+				if (!pfn_valid(pfn))
+					continue;
+				page = pfn_to_page(pfn);
+				if (PageReserved(page))
+					continue;
+				if (PageNosaveFree(page))
+					continue;
+				n++;
+			}
+		}
+	return n;
+}
+
 struct highmem_page {
 	char *data;
 	struct page *page;
@@ -152,17 +177,15 @@
 	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
-	if (PageReserved(page) && pfn_is_nosave(pfn)) {
-		pr_debug("[nosave pfn 0x%lx]", pfn);
+	if (PageReserved(page) && pfn_is_nosave(pfn))
 		return 0;
-	}
 	if (PageNosaveFree(page))
 		return 0;
 
 	return 1;
 }
 
-static unsigned count_data_pages(void)
+unsigned int count_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
@@ -267,6 +290,35 @@
 }
 
 /**
+ *	On resume it is necessary to trace and eventually free the unsafe
+ *	pages that have been allocated, because they are needed for I/O
+ *	(on x86-64 we likely will "eat" these pages once again while
+ *	creating the temporary page translation tables)
+ */
+
+struct eaten_page {
+	struct eaten_page	*next;
+	char			padding[PAGE_SIZE - sizeof(void *)];
+};
+
+static struct eaten_page *eaten_pages = NULL;
+
+void release_eaten_pages(void)
+{
+	struct eaten_page *p, *q;
+
+	p = eaten_pages;
+	while (p) {
+		q = p->next;
+		/* We don't want swsusp_free() to free this page again */
+		ClearPageNosave(virt_to_page(p));
+		free_page((unsigned long)p);
+		p = q;
+	}
+	eaten_pages = NULL;
+}
+
+/**
  *	@safe_needed - on resume, for storing the PBE list and the image,
  *	we can only use memory pages that do not conflict with the pages
  *	which had been used before suspend.
@@ -284,9 +336,12 @@
 	if (safe_needed)
 		do {
 			res = (void *)get_zeroed_page(gfp_mask);
-			if (res && PageNosaveFree(virt_to_page(res)))
+			if (res && PageNosaveFree(virt_to_page(res))) {
 				/* This is for swsusp_free() */
 				SetPageNosave(virt_to_page(res));
+				((struct eaten_page *)res)->next = eaten_pages;
+				eaten_pages = res;
+			}
 		} while (res && PageNosaveFree(virt_to_page(res)));
 	else
 		res = (void *)get_zeroed_page(gfp_mask);
Index: linux-2.6.14-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-mm2.orig/kernel/power/swsusp.c	2005-11-12 12:07:47.000000000 +0100
+++ linux-2.6.14-mm2/kernel/power/swsusp.c	2005-11-12 12:10:54.000000000 +0100
@@ -74,11 +74,13 @@
 #include "power.h"
 
 #ifdef CONFIG_HIGHMEM
+unsigned int count_highmem_pages(void);
 int save_highmem(void);
 int restore_highmem(void);
 #else
 static int save_highmem(void) { return 0; }
 static int restore_highmem(void) { return 0; }
+static unsigned int count_highmem_pages(void) { return 0; }
 #endif
 
 extern char resume_file[];
@@ -616,6 +618,45 @@
 	return error;
 }
 
+/**
+ *	swsusp_shrink_memory -  Try to free as much memory as needed
+ *
+ *	... but do not OOM-kill anyone
+ *
+ *	Notice: all userland should be stopped before it is called, or
+ *	livelock is possible.
+ */
+
+int swsusp_shrink_memory(void)
+{
+	unsigned long cnt = SHRINK_BITE;
+	long tmp;
+	unsigned long pages = 0;
+	unsigned int i = 0;
+	char *p = "-\\|/";
+
+	printk("Shrinking memory...  ");
+	do {
+#ifdef OPPORTUNISTIC_SHRINKING
+		cnt = count_data_pages() + count_highmem_pages();
+		cnt += (cnt + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
+			PAGES_FOR_IO;
+		tmp = cnt - nr_free_pages();
+		if (tmp > 0) {
+			cnt = shrink_all_memory(SHRINK_BITE);
+			pages += cnt;
+		}
+#else
+		tmp = shrink_all_memory(SHRINK_BITE);
+		pages += tmp;
+#endif
+		printk("\b%c", p[i++%4]);
+	} while (tmp > 0 && cnt > 0);
+	printk("\bdone (%lu pages freed)\n", pages);
+
+	return tmp > 0 ? -ENOMEM : 0;
+}
+
 int swsusp_suspend(void)
 {
 	int error;
@@ -1035,8 +1076,10 @@
 		/* Allocate memory for the image and read the data from swap */
 		if (!error)
 			error = alloc_data_pages(pblist, GFP_ATOMIC, 1);
-		if (!error)
+		if (!error) {
+			release_eaten_pages();
 			error = load_image_data(pblist, &handle, nr_pages);
+		}
 		if (!error)
 			*pblist_ptr = pblist;
 	}
Index: linux-2.6.14-mm2/include/linux/suspend.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/suspend.h	2005-11-12 12:07:47.000000000 +0100
+++ linux-2.6.14-mm2/include/linux/suspend.h	2005-11-12 12:10:54.000000000 +0100
@@ -73,6 +73,6 @@
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
  */
-#define PAGES_FOR_IO	512
+#define PAGES_FOR_IO	1024
 
 #endif /* _LINUX_SWSUSP_H */
