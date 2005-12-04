Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVLDABV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVLDABV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVLDABV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:01:21 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:47270 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932172AbVLDABU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:01:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][mm][Fix] swsusp: fix counting of highmem pages
Date: Sun, 4 Dec 2005 01:02:24 +0100
User-Agent: KMail/1.8.3
Cc: Andy Isaacson <adi@hexapodia.org>, LKML <linux-kernel@vger.kernel.org>
References: <200512032140.15192.rjw@sisk.pl> <200512040011.30274.rjw@sisk.pl> <20051203235046.GC5198@elf.ucw.cz>
In-Reply-To: <20051203235046.GC5198@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512040102.24668.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 4 of December 2005 00:50, Pavel Machek wrote:
}-- snip --{
> 
> Ah, okay, I see. As long as the include hack is gone, its okay with me.

All right.  Appended is the latest version.

Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/snapshot.c |   25 ++++++++++++++++++-------
 kernel/power/swsusp.c   |    3 ++-
 2 files changed, 20 insertions(+), 8 deletions(-)

Index: linux-2.6.15-rc3-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/snapshot.c	2005-12-03 00:14:49.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/snapshot.c	2005-12-04 00:35:14.000000000 +0100
@@ -37,6 +37,12 @@
 unsigned int nr_copy_pages;
 
 #ifdef CONFIG_HIGHMEM
+#if (PAGE_SIZE == 4096)
+#define KMALLOC_SIZE	32
+#else
+#define KMALLOC_SIZE	64
+#endif
+
 unsigned int count_highmem_pages(void)
 {
 	struct zone *zone;
@@ -52,13 +58,12 @@
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
+		n += (n * KMALLOC_SIZE + PAGE_SIZE - 1) / PAGE_SIZE + 1;
 	return n;
 }
 
@@ -437,8 +442,14 @@
 
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
