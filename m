Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVJ2Uzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVJ2Uzi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVJ2Uy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:54:59 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:4783 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932193AbVJ2Uyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:54:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH 6/6] swsusp: improve freeing of memory
Date: Sat, 29 Oct 2005 22:46:50 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
References: <200510292158.11089.rjw@sisk.pl>
In-Reply-To: <200510292158.11089.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510292246.50685.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the bonus patch not functionally related to the previous patches
that speeds up swsusp substantially (on my box swsusp is two times
faster with it) and makes the system be much more responsive after
resume.

However, it only makes sense if the limit imposed by the size of the
swsusp_info structure is lifted, which is done in one of the previous
patches.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/suspend.h |    2 -
 kernel/power/disk.c     |   30 ++----------------------
 kernel/power/power.h    |    1 
 kernel/power/snapshot.c |    6 +---
 kernel/power/swsusp.c   |   60 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+), 32 deletions(-)

Index: linux-2.6.14-rc5-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/disk.c	2005-10-29 14:01:27.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/disk.c	2005-10-29 14:12:12.000000000 +0200
@@ -24,6 +24,7 @@
 
 extern suspend_disk_method_t pm_disk_mode;
 
+extern int swsusp_shrink_memory(void);
 extern int swsusp_suspend(void);
 extern int swsusp_write(void);
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
Index: linux-2.6.14-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/power.h	2005-10-29 14:12:07.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/power.h	2005-10-29 14:12:12.000000000 +0200
@@ -58,6 +58,7 @@
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
+extern unsigned count_data_pages(void);
 extern void swsusp_free(void);
 
 extern unsigned snapshot_pages_to_save(void);
Index: linux-2.6.14-rc5-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/snapshot.c	2005-10-29 14:12:07.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/snapshot.c	2005-10-29 14:12:12.000000000 +0200
@@ -67,17 +67,15 @@
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
+unsigned count_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
Index: linux-2.6.14-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/swsusp.c	2005-10-29 14:12:07.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/swsusp.c	2005-10-29 14:12:12.000000000 +0200
@@ -77,6 +77,30 @@
 #include "power.h"
 
 #ifdef CONFIG_HIGHMEM
+static unsigned count_highmem_pages(void)
+{
+	struct zone *zone;
+	unsigned n = 0;
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
@@ -163,10 +187,46 @@
 	return 0;
 }
 #else
+static unsigned count_highmem_pages(void) { return 0; }
 static int save_highmem(void) { return 0; }
 static int restore_highmem(void) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
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
+	unsigned long cnt;
+	long tmp;
+	unsigned long pages = 0;
+	unsigned int i = 0;
+	char *p = "-\\|/";
+
+	printk("Shrinking memory...  ");
+	do {
+		cnt = count_data_pages() + count_highmem_pages();
+		cnt += (cnt + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
+			PAGES_FOR_IO;
+		tmp = cnt - nr_free_pages();
+		if (tmp > 0) {
+			tmp = 10000;
+			cnt = shrink_all_memory(tmp);
+			pages += cnt;
+		}
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
Index: linux-2.6.14-rc5-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/suspend.h	2005-10-29 14:01:27.000000000 +0200
+++ linux-2.6.14-rc5-mm1/include/linux/suspend.h	2005-10-29 14:42:16.000000000 +0200
@@ -73,6 +73,6 @@
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
  */
-#define PAGES_FOR_IO	512
+#define PAGES_FOR_IO	1024
 
 #endif /* _LINUX_SWSUSP_H */
