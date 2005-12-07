Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVLGVox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVLGVox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbVLGVox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:44:53 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:33215 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030364AbVLGVox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:44:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][mm] swsusp: limit image size
Date: Wed, 7 Dec 2005 22:46:05 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512072246.06222.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch limits the size of the suspend image to approx. 500 MB,
which should improve the overall performance of swsusp on systems with
more than 1 GB of RAM.

It introduces the constant IMAGE_SIZE that can be set to the preferred size
of the image (in MB) and modifies the memory-shrinking part of
swsusp to take this constant into account (500 is the default value
of IMAGE_SIZE).

Please apply (Pavel, please ack if that's ok).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h  |    8 +++-----
 kernel/power/swsusp.c |   17 ++++++++---------
 2 files changed, 11 insertions(+), 14 deletions(-)

Index: linux-2.6.15-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/power.h	2005-12-05 22:07:12.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/power.h	2005-12-07 22:16:55.000000000 +0100
@@ -53,12 +53,10 @@
 extern struct pbe *pagedir_nosave;
 
 /*
- * This compilation switch determines the way in which memory will be freed
- * during suspend.  If defined, only as much memory will be freed as needed
- * to complete the suspend, which will make it go faster.  Otherwise, the
- * largest possible amount of memory will be freed.
+ * Preferred image size in MB (set it to zero to get the smallest
+ * image possible)
  */
-#define FAST_FREE	1
+#define IMAGE_SIZE	500
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
Index: linux-2.6.15-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/swsusp.c	2005-12-05 22:07:12.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/swsusp.c	2005-12-07 14:15:40.000000000 +0100
@@ -626,7 +626,7 @@
 
 int swsusp_shrink_memory(void)
 {
-	long tmp;
+	long size, tmp;
 	struct zone *zone;
 	unsigned long pages = 0;
 	unsigned int i = 0;
@@ -634,11 +634,11 @@
 
 	printk("Shrinking memory...  ");
 	do {
-#ifdef FAST_FREE
-		tmp = 2 * count_highmem_pages();
-		tmp += tmp / 50 + count_data_pages();
-		tmp += (tmp + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
+		size = 2 * count_highmem_pages();
+		size += size / 50 + count_data_pages();
+		size += (size + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
 			PAGES_FOR_IO;
+		tmp = size;
 		for_each_zone (zone)
 			if (!is_highmem(zone))
 				tmp -= zone->free_pages;
@@ -647,11 +647,10 @@
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
+		} else if (size > (IMAGE_SIZE * 1024 * 1024) / PAGE_SIZE) {
+			tmp = shrink_all_memory(SHRINK_BITE);
+			pages += tmp;
 		}
-#else
-		tmp = shrink_all_memory(SHRINK_BITE);
-		pages += tmp;
-#endif
 		printk("\b%c", p[i++%4]);
 	} while (tmp > 0);
 	printk("\bdone (%lu pages freed)\n", pages);

