Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVLTIxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVLTIxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVLTIxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:53:09 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:8633 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750865AbVLTIxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:53:08 -0500
Date: Tue, 20 Dec 2005 17:52:08 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: [Patch] New zone ZONE_EASY_RECLAIM take 4. (define gfp_easy_relcaim)[1/8]
Cc: Joel Schopp <jschopp@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20051220172720.1B08.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This defines __GFP flag for new zone (with GFP_DMA32).

take3 -> take 4:
  take 3's modification was not enough. 
  __GFP_DMA32 is moved from 0x04 to 0x02 when it has own number
  to make it easier.
  __GFP_HIGHMEM and __GFP_EASY_RECLAIM become fixed value.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: zone_reclaim/include/linux/gfp.h
===================================================================
--- zone_reclaim.orig/include/linux/gfp.h	2005-12-16 11:28:15.000000000 +0900
+++ zone_reclaim/include/linux/gfp.h	2005-12-19 20:20:51.000000000 +0900
@@ -11,17 +11,21 @@ struct vm_area_struct;
 /*
  * GFP bitmasks..
  */
-/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
+/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low four bits) */
 #define __GFP_DMA	((__force gfp_t)0x01u)
-#define __GFP_HIGHMEM	((__force gfp_t)0x02u)
+
 #ifdef CONFIG_DMA_IS_DMA32
 #define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
 #elif BITS_PER_LONG < 64
 #define __GFP_DMA32	((__force gfp_t)0x00)	/* ZONE_NORMAL is ZONE_DMA32 */
 #else
-#define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
+#define __GFP_DMA32	((__force gfp_t)0x02)	/* Has own ZONE_DMA32 */
 #endif
 
+#define __GFP_HIGHMEM	((__force gfp_t)0x04u)
+#define __GFP_EASY_RECLAIM ((__force gfp_t)0x08u)
+
+
 /*
  * Action modifiers - doesn't change the zoning
  *
@@ -64,7 +68,7 @@ struct vm_area_struct;
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
-			 __GFP_HIGHMEM)
+			 __GFP_HIGHMEM | __GFP_EASY_RECLAIM)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
Index: zone_reclaim/include/linux/mmzone.h
===================================================================
--- zone_reclaim.orig/include/linux/mmzone.h	2005-12-16 11:28:15.000000000 +0900
+++ zone_reclaim/include/linux/mmzone.h	2005-12-19 20:16:29.000000000 +0900
@@ -93,7 +93,7 @@ struct per_cpu_pageset {
  *
  * NOTE! Make sure this matches the zones in <linux/gfp.h>
  */
-#define GFP_ZONEMASK	0x07
+#define GFP_ZONEMASK	0x0f
 #define GFP_ZONETYPES	5
 
 /*

-- 
Yasunori Goto 


