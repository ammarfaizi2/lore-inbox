Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUENUoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUENUoy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 16:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUENUoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 16:44:54 -0400
Received: from mout2.freenet.de ([194.97.50.155]:31643 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261685AbUENUov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 16:44:51 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.6] bootmem.c cleanup
Date: Fri, 14 May 2004 22:43:45 +0200
User-Agent: KMail/1.6.2
References: <200405142205.27214.mbuesch@freenet.de> <20040514133353.236acf3a.akpm@osdl.org>
In-Reply-To: <20040514133353.236acf3a.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405142243.45647.mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 May 2004 22:33, you wrote:
> Please don't put expressions whihc actually change state inside BUG_ON(). 
> Someone may decide to make BUG_ON() a no-op to save space.
> 
> I'm not aware of anyone actually trying that, but it's a good objective.

Ok, so what about the following?

-- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]




--- linux-2.6.6/mm/bootmem.c.orig	2004-05-14 21:55:00.000000000 +0200
+++ linux-2.6.6/mm/bootmem.c	2004-05-14 22:42:48.000000000 +0200
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
@@ -124,7 +120,7 @@
 	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
 
 	for (i = sidx; i < eidx; i++) {
-		if (!test_and_clear_bit(i, bdata->node_bootmem_map))
+		if (unlikely(!test_and_clear_bit(i, bdata->node_bootmem_map)))
 			BUG();
 	}
 }
@@ -140,7 +136,7 @@
  *
  * alignment has to be a power of 2 value.
  *
- * NOTE:  This function is _not_ reenetrant.
+ * NOTE:  This function is _not_ reentrant.
  */
 static void * __init
 __alloc_bootmem_core(struct bootmem_data *bdata, unsigned long size,
@@ -152,7 +148,6 @@
 
 	if(!size) {
 		printk("__alloc_bootmem_core(): zero-sized request\n");
-		dump_stack();
 		BUG();
 	}
 	BUG_ON(align & (align-1));
@@ -260,7 +255,7 @@
 	unsigned long idx;
 	unsigned long *map; 
 
-	if (!bdata->node_bootmem_map) BUG();
+	BUG_ON(!bdata->node_bootmem_map);
 
 	count = 0;
 	/* first extant page of the node */
