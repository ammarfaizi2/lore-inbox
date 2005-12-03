Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVLCUwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVLCUwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 15:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLCUwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 15:52:06 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:64677 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751165AbVLCUwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 15:52:05 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][mm][Fix] swsusp: fix counting of highmem pages
Date: Sat, 3 Dec 2005 21:40:14 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@ucw.cz>, Andy Isaacson <adi@hexapodia.org>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512032140.15192.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes a problem with swsusp that causes suspend to
fail on systems with the highmem zone, if many highmem pages are in use.

It makes swsusp count the non-free highmem pages in a correct way
and, consequently, release a sufficient amount of memory before suspend.

Please apply (Pavel, please ack if you think the patch is ok).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/snapshot.c |   41 ++++++++++++++++++++++++++++-------------
 kernel/power/swsusp.c   |    3 ++-
 2 files changed, 30 insertions(+), 14 deletions(-)

Index: linux-2.6.15-rc3-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/snapshot.c	2005-12-03 00:14:49.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/snapshot.c	2005-12-03 00:40:33.000000000 +0100
@@ -37,6 +37,22 @@
 unsigned int nr_copy_pages;
 
 #ifdef CONFIG_HIGHMEM
+struct highmem_page {
+	char *data;
+	struct page *page;
+	struct highmem_page *next;
+};
+
+static inline unsigned int get_kmalloc_size(void)
+{
+#define CACHE(x) \
+	if (sizeof(struct highmem_page) <= x) \
+		return x;
+#include <linux/kmalloc_sizes.h>
+#undef CACHE
+	return sizeof(struct highmem_page);
+}
+
 unsigned int count_highmem_pages(void)
 {
 	struct zone *zone;
@@ -52,22 +68,15 @@
 				if (!pfn_valid(pfn))
 					continue;
 				page = pfn_to_page(pfn);
-				if (PageReserved(page))
-					continue;
-				if (PageNosaveFree(page))
-					continue;
-				n++;
+				if (!PageNosaveFree(page) && !PageReserved(page))
+					n++;
 			}
 		}
+	if (n > 0)
+		n += (n * get_kmalloc_size() + PAGE_SIZE - 1) / PAGE_SIZE + 1;
 	return n;
 }
 
-struct highmem_page {
-	char *data;
-	struct page *page;
-	struct highmem_page *next;
-};
-
 static struct highmem_page *highmem_copy;
 
 static int save_highmem_zone(struct zone *zone)
@@ -437,8 +446,14 @@
 
 static int enough_free_mem(unsigned int nr_pages)
 {
-	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
-	return nr_free_pages() > (nr_pages + PAGES_FOR_IO +
+	struct zone *zone;
+	unsigned int n = 0;
+
+	for_each_zone (zone)
+		if (!is_highmem(zone))
+			n += zone->free_pages;
+	pr_debug("swsusp: available memory: %u pages\n", n);
+	return n > (nr_pages + PAGES_FOR_IO +
 		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-03 00:14:49.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-03 21:25:07.000000000 +0100
@@ -635,7 +635,8 @@
 	printk("Shrinking memory...  ");
 	do {
 #ifdef FAST_FREE
-		tmp = count_data_pages() + count_highmem_pages();
+		tmp = 2 * count_highmem_pages();
+		tmp += tmp / 50 + count_data_pages();
 		tmp += (tmp + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
 			PAGES_FOR_IO;
 		for_each_zone (zone)
