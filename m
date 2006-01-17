Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWAQPwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWAQPwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWAQPwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:52:40 -0500
Received: from 81-179-245-126.dsl.pipex.com ([81.179.245.126]:17632 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750754AbWAQPwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:52:39 -0500
Date: Tue, 17 Jan 2006 15:52:27 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zone gfp_flags generate from ZONE_ constants
Message-ID: <20060117155227.GA16176@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zone gfp_flags generate from ZONE_ constants

Change the allocation of the __GFP_zone style zone modifiers so that
they are generated from the values of the ZONE_zone definitions.
Note that when no zone modifiers are specified select the default
zone, typically ZONE_NORMAL.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 gfp.h    |   22 ++++++++++++++++------
 mmzone.h |    2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)
diff -upN reference/include/linux/gfp.h current/include/linux/gfp.h
--- reference/include/linux/gfp.h
+++ current/include/linux/gfp.h
@@ -11,15 +11,25 @@ struct vm_area_struct;
 /*
  * GFP bitmasks..
  */
-/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
-#define __GFP_DMA	((__force gfp_t)0x01u)
-#define __GFP_HIGHMEM	((__force gfp_t)0x02u)
+
+/*
+ * Generate the zone modifier bit.  Zone ZONE_DEFAULT doesn't require a bit
+ * as the absence of all zone modifiers implies this zone.  Renormalise the
+ * zone number such that ZONE_DEFAULT is at the bottom and discard it.
+ * These must fit within the bitmask GFP_ZONEMASK defined in linux/mmzone.h.
+ */
+#define __ZONE_BIT(x) (((x) ^ ZONE_DEFAULT) - 1)
+#define ZONE_MODIFIER(x) ((__force gfp_t)(((x) == ZONE_DEFAULT)? (0) : \
+							1UL << __ZONE_BIT(x)))
+
+#define __GFP_DMA	ZONE_MODIFIER(ZONE_DMA)
+#define __GFP_HIGHMEM	ZONE_MODIFIER(ZONE_HIGHMEM)
 #ifdef CONFIG_DMA_IS_DMA32
-#define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
+#define __GFP_DMA32	ZONE_MODIFIER(ZONE_DMA)	/* ZONE_DMA is ZONE_DMA32 */
 #elif BITS_PER_LONG < 64
-#define __GFP_DMA32	((__force gfp_t)0x00)	/* ZONE_NORMAL is ZONE_DMA32 */
+#define __GFP_DMA32	ZONE_MODIFIER(ZONE_NORMAL) /* ZONE_NORMAL is ZONE_DMA32 */
 #else
-#define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
+#define __GFP_DMA32	ZONE_MODIFIER(ZONE_DMA32) /* Has own ZONE_DMA32 */
 #endif
 
 /*
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -77,6 +77,8 @@ struct per_cpu_pageset {
 #define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
 #define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
+/* Select the zone to use when no __GFP flags are selected. */
+#define ZONE_DEFAULT           ZONE_NORMAL
 
 /*
  * When a memory allocation must conform to specific limitations (such
