Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUENUQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUENUQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUENUQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 16:16:42 -0400
Received: from mout0.freenet.de ([194.97.50.131]:19402 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S262574AbUENUQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 16:16:38 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: akpm@digeo.com
Subject: [PATCH 2.6.6] bootmem.c cleanup
Date: Fri, 14 May 2004 22:05:27 +0200
User-Agent: KMail/1.6.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405142205.27214.mbuesch@freenet.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch does some cleanup in mm/bootmem.c .
It replaces some if (...) BUG(); with BUG_ON(...);,
and fixes a typo.

Some comment on my own patch:
BUG() already dumps the stack, so we needn't call
dump_stack() here, correct?
@@ -152,7 +147,6 @@
 
 	if(!size) {
 		printk("__alloc_bootmem_core(): zero-sized request\n");
-		dump_stack();
 		BUG();
 	}
 	BUG_ON(align & (align-1));

-- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]





--- linux-2.6.6/mm/bootmem.c.orig	2004-05-14 21:55:00.000000000 +0200
+++ linux-2.6.6/mm/bootmem.c	2004-05-14 21:55:15.000000000 +0200
@@ -82,14 +82,11 @@
 							PAGE_SIZE-1)/PAGE_SIZE;
 	unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;
 
-	if (!size) BUG();
+	BUG_ON(!size);
+	BUG_ON(sidx >= eidx);
+	BUG_ON((addr >> PAGE_SHIFT) >= bdata->node_low_pfn);
+	BUG_ON(end > bdata->node_low_pfn);
 
-	if (sidx >= eidx)
-		BUG();
-	if ((addr >> PAGE_SHIFT) >= bdata->node_low_pfn)
-		BUG();
-	if (end > bdata->node_low_pfn)
-		BUG();
 	for (i = sidx; i < eidx; i++)
 		if (test_and_set_bit(i, bdata->node_bootmem_map)) {
 #ifdef CONFIG_DEBUG_BOOTMEM
@@ -110,9 +107,8 @@
 	unsigned long eidx = (addr + size - bdata->node_boot_start)/PAGE_SIZE;
 	unsigned long end = (addr + size)/PAGE_SIZE;
 
-	if (!size) BUG();
-	if (end > bdata->node_low_pfn)
-		BUG();
+	BUG_ON(!size);
+	BUG_ON(end > bdata->node_low_pfn);
 
 	if (addr < bdata->last_success)
 		bdata->last_success = addr;
@@ -124,8 +120,7 @@
 	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
 
 	for (i = sidx; i < eidx; i++) {
-		if (!test_and_clear_bit(i, bdata->node_bootmem_map))
-			BUG();
+		BUG_ON(!test_and_clear_bit(i, bdata->node_bootmem_map));
 	}
 }
 
@@ -140,7 +135,7 @@
  *
  * alignment has to be a power of 2 value.
  *
- * NOTE:  This function is _not_ reenetrant.
+ * NOTE:  This function is _not_ reentrant.
  */
 static void * __init
 __alloc_bootmem_core(struct bootmem_data *bdata, unsigned long size,
@@ -152,7 +147,6 @@
 
 	if(!size) {
 		printk("__alloc_bootmem_core(): zero-sized request\n");
-		dump_stack();
 		BUG();
 	}
 	BUG_ON(align & (align-1));
@@ -246,8 +240,7 @@
 	 * Reserve the area now:
 	 */
 	for (i = start; i < start+areasize; i++)
-		if (unlikely(test_and_set_bit(i, bdata->node_bootmem_map)))
-			BUG();
+		BUG_ON(test_and_set_bit(i, bdata->node_bootmem_map));
 	memset(ret, 0, size);
 	return ret;
 }
@@ -260,7 +253,7 @@
 	unsigned long idx;
 	unsigned long *map; 
 
-	if (!bdata->node_bootmem_map) BUG();
+	BUG_ON(!bdata->node_bootmem_map);
 
 	count = 0;
 	/* first extant page of the node */
