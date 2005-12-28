Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVL1Alp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVL1Alp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVL1Alh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:41:37 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:35261 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932422AbVL1AlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:41:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM <linux-pm@osdl.org>
Subject: [RFC/RFT][PATCH -mm 4/4] swsusp: move highmem-handling code to swsusp.c
Date: Wed, 28 Dec 2005 01:36:53 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200512280108.47253.rjw@sisk.pl>
In-Reply-To: <200512280108.47253.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512280136.56663.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves all of the highmem-related functions from snapshot.c to
swsusp.c.

These functions are only called by the code in swsusp.c and are not related
to the snapshot-handling code, so they can be moved from snapshot.c,
especially that swsusp.c is much smaller after the swap-writing/reading
code has been moved to another file.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/snapshot.c |  113 ------------------------------------------------
 kernel/power/swsusp.c   |  113 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 110 insertions(+), 116 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/snapshot.c	2005-12-28 01:16:43.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/snapshot.c	2005-12-28 01:18:06.000000000 +0100
@@ -38,119 +38,6 @@ struct pbe *pagedir_nosave;
 unsigned int nr_copy_pages;
 unsigned int nr_meta_pages;
 
-#ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void)
-{
-	struct zone *zone;
-	unsigned long zone_pfn;
-	unsigned int n = 0;
-
-	for_each_zone (zone)
-		if (is_highmem(zone)) {
-			mark_free_pages(zone);
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; zone_pfn++) {
-				struct page *page;
-				unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-				if (!pfn_valid(pfn))
-					continue;
-				page = pfn_to_page(pfn);
-				if (PageReserved(page))
-					continue;
-				if (PageNosaveFree(page))
-					continue;
-				n++;
-			}
-		}
-	return n;
-}
-
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
-
-int save_highmem(void)
-{
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
-	return 0;
-}
-
-int restore_highmem(void)
-{
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
-	return 0;
-}
-#endif
-
 static int pfn_is_nosave(unsigned long pfn)
 {
 	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2005-12-28 01:18:04.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2005-12-28 01:34:59.000000000 +0100
@@ -63,9 +63,116 @@ unsigned int image_size = 500;
 int in_suspend __nosavedata = 0;
 
 #ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void);
-int save_highmem(void);
-int restore_highmem(void);
+static unsigned int count_highmem_pages(void)
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
+
+static int save_highmem(void)
+{
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
+	return 0;
+}
+
+static int restore_highmem(void)
+{
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
+	return 0;
+}
 #else
 static int save_highmem(void) { return 0; }
 static int restore_highmem(void) { return 0; }
