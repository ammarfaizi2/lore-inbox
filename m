Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTIKRUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbTIKRTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:19:32 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:17079 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261411AbTIKRQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:16:54 -0400
Date: Thu, 11 Sep 2003 19:16:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/7): xpram driver.
Message-ID: <20030911171611.GD5637@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Get xpram working on 64 bit.
 - Fix printk format strings.
 - Use new-style module_param.

diffstat:
 drivers/s390/block/xpram.c |   44 ++++++++++++++++++++++++++------------------
 1 files changed, 26 insertions(+), 18 deletions(-)

diff -urN linux-2.6/drivers/s390/block/xpram.c linux-2.6-s390/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	Mon Sep  8 21:50:18 2003
+++ linux-2.6-s390/drivers/s390/block/xpram.c	Thu Sep 11 19:21:24 2003
@@ -26,11 +26,13 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/version.h>
 #include <linux/ctype.h>  /* isdigit, isxdigit */
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/sysdev.h>
@@ -58,23 +60,23 @@
 }; 
 
 typedef struct {
-	unsigned long	size;		/* size of xpram segment in pages */
-	unsigned long	offset;		/* start page of xpram segment */
+	unsigned int	size;		/* size of xpram segment in pages */
+	unsigned int	offset;		/* start page of xpram segment */
 } xpram_device_t;
 
 static xpram_device_t xpram_devices[XPRAM_MAX_DEVS];
-static int xpram_sizes[XPRAM_MAX_DEVS];
+static unsigned int xpram_sizes[XPRAM_MAX_DEVS];
 static struct gendisk *xpram_disks[XPRAM_MAX_DEVS];
-static unsigned long xpram_pages;
+static unsigned int xpram_pages;
 static int xpram_devs;
 
 /*
  * Parameter parsing functions.
  */
 static int devs = XPRAM_DEVS;
-static unsigned long sizes[XPRAM_MAX_DEVS];
+static unsigned int sizes[XPRAM_MAX_DEVS];
 
-MODULE_PARM(devs,"i");
+module_param(devs, int, 0);
 MODULE_PARM(sizes,"1-" __MODULE_STRING(XPRAM_MAX_DEVS) "i"); 
 
 MODULE_PARM_DESC(devs, "number of devices (\"partitions\"), " \
@@ -149,7 +151,7 @@
  *           -EIO:         if pgin failed
  *           -ENXIO:       if xpram has vanished
  */
-static int xpram_page_in (unsigned long page_addr, unsigned long xpage_index)
+static int xpram_page_in (unsigned long page_addr, unsigned int xpage_index)
 {
 	int cc;
 
@@ -180,7 +182,7 @@
 		return -ENXIO;
 	}
 	if (cc == 1) {
-		PRINT_ERR("page in failed for page index %ld.\n",
+		PRINT_ERR("page in failed for page index %u.\n",
 			  xpage_index);
 		return -EIO;
 	}
@@ -197,7 +199,7 @@
  *           -EIO:         if pgout failed
  *           -ENXIO:       if xpram has vanished
  */
-static long xpram_page_out (unsigned long page_addr, unsigned long xpage_index)
+static long xpram_page_out (unsigned long page_addr, unsigned int xpage_index)
 {
 	int cc;
 
@@ -228,7 +230,7 @@
 		return -ENXIO;
 	}
 	if (cc == 1) {
-		PRINT_ERR("page out failed for page index %ld.\n",
+		PRINT_ERR("page out failed for page index %u.\n",
 			  xpage_index);
 		return -EIO;
 	}
@@ -244,6 +246,8 @@
 	int rc;
 
 	mem_page = (unsigned long) __get_free_page(GFP_KERNEL);
+	if (!mem_page)
+		return -ENOMEM;
 	rc = xpram_page_in(mem_page, 0);
 	free_page(mem_page);
 	return rc ? -ENXIO : 0;
@@ -254,13 +258,15 @@
  */
 static unsigned long __init xpram_highest_page_index(void)
 {
-	unsigned long page_index, add_bit;
+	unsigned int page_index, add_bit;
 	unsigned long mem_page;
 
 	mem_page = (unsigned long) __get_free_page(GFP_KERNEL);
+	if (!mem_page)
+		return 0;
 
 	page_index = 0;
-	add_bit = 1ULL << (sizeof(unsigned long)*8 - 1);
+	add_bit = 1ULL << (sizeof(unsigned int)*8 - 1);
 	while (add_bit > 0) {
 		if (xpram_page_in(mem_page, page_index | add_bit) == 0)
 			page_index |= add_bit;
@@ -279,7 +285,7 @@
 {
 	xpram_device_t *xdev = bio->bi_bdev->bd_disk->private_data;
 	struct bio_vec *bvec;
-	unsigned long index;
+	unsigned int index;
 	unsigned long page_addr;
 	unsigned long bytes;
 	int i;
@@ -290,6 +296,8 @@
 	if ((bio->bi_size >> 12) > xdev->size)
 		/* Request size is no page-aligned. */
 		goto fail;
+	if ((bio->bi_sector >> 3) > 0xffffffffU - xdev->offset)
+		goto fail;
 	index = (bio->bi_sector >> 3) + xdev->offset;
 	bio_for_each_segment(bvec, bio, i) {
 		page_addr = (unsigned long)
@@ -382,13 +390,13 @@
 	PRINT_INFO("  number of devices (partitions): %d \n", xpram_devs);
 	for (i = 0; i < xpram_devs; i++) {
 		if (xpram_sizes[i])
-			PRINT_INFO("  size of partition %d: %d kB\n",
+			PRINT_INFO("  size of partition %d: %u kB\n",
 				   i, xpram_sizes[i]);
 		else
 			PRINT_INFO("  size of partition %d to be set "
 				   "automatically\n",i);
 	}
-	PRINT_DEBUG("  memory needed (for sized partitions): %ld kB\n",
+	PRINT_DEBUG("  memory needed (for sized partitions): %lu kB\n",
 		    mem_needed);
 	PRINT_DEBUG("  partitions to be sized automatically: %d\n",
 		    mem_auto_no);
@@ -407,7 +415,7 @@
 	if (mem_auto_no) {
 		mem_auto = ((pages - mem_needed / 4) / mem_auto_no) * 4;
 		PRINT_INFO("  automatically determined "
-			   "partition size: %ld kB\n", mem_auto);
+			   "partition size: %lu kB\n", mem_auto);
 		for (i = 0; i < xpram_devs; i++)
 			if (xpram_sizes[i] == 0)
 				xpram_sizes[i] = mem_auto;
@@ -499,8 +507,8 @@
 		return -ENODEV;
 	}
 	xpram_pages = xpram_highest_page_index();
-	PRINT_INFO("  %li pages expanded memory found (%li KB).\n",
-		   xpram_pages, xpram_pages*4);
+	PRINT_INFO("  %u pages expanded memory found (%lu KB).\n",
+		   xpram_pages, (unsigned long) xpram_pages*4);
 	rc = xpram_setup_sizes(xpram_pages);
 	if (rc)
 		return rc;
