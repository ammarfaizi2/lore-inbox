Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVJIFcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVJIFcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 01:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVJIFcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 01:32:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44779 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932207AbVJIFcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 01:32:47 -0400
Date: Sun, 9 Oct 2005 06:32:43 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC] gfp flags annotations - part 2
Message-ID: <20051009053243.GG7992@ftp.linux.org.uk>
References: <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	- renamed __bitwise to __bitwise__
	- made __bitwise conditional on __CHECK_ENDIAN__
	- made gfp_t __bitwise__
	- added -Wbitwise to CHECKFLAGS
As the result, default sparse run will pick gfp warnings without picking
endianness ones; to get those use CF=-D__CHECK_ENDIAN__.

That allows to do gfp annotations without drowning in endianness ones -
endianness annotations are nowhere near complete and generate too much
noise.
	- __GFP_... definitions got a force-cast to gfp_t
	- new helper - gfp_zone(gfp) gives zone number.

Impact on the things seen by gcc - none; the only thing that survives
preprocessor is addition of cast to unsigned int on several explicitly
unsigned constants.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN base/Makefile bitwise/Makefile
--- base/Makefile	2005-09-30 20:59:37.000000000 -0400
+++ bitwise/Makefile	2005-10-09 01:20:14.000000000 -0400
@@ -334,7 +334,7 @@
 PERL		= perl
 CHECK		= sparse
 
-CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ $(CF)
+CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise $(CF)
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
diff -urN base/fs/buffer.c bitwise/fs/buffer.c
--- base/fs/buffer.c	2005-10-08 21:04:47.000000000 -0400
+++ bitwise/fs/buffer.c	2005-10-09 01:20:14.000000000 -0400
@@ -502,7 +502,7 @@
 	yield();
 
 	for_each_pgdat(pgdat) {
-		zones = pgdat->node_zonelists[GFP_NOFS&GFP_ZONEMASK].zones;
+		zones = pgdat->node_zonelists[gfp_zone(GFP_NOFS)].zones;
 		if (*zones)
 			try_to_free_pages(zones, GFP_NOFS);
 	}
diff -urN base/include/linux/gfp.h bitwise/include/linux/gfp.h
--- base/include/linux/gfp.h	2005-10-08 21:04:47.000000000 -0400
+++ bitwise/include/linux/gfp.h	2005-10-09 01:20:14.000000000 -0400
@@ -12,8 +12,8 @@
  * GFP bitmasks..
  */
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
-#define __GFP_DMA	0x01u
-#define __GFP_HIGHMEM	0x02u
+#define __GFP_DMA	((__force gfp_t)0x01u)
+#define __GFP_HIGHMEM	((__force gfp_t)0x02u)
 
 /*
  * Action modifiers - doesn't change the zoning
@@ -26,24 +26,24 @@
  *
  * __GFP_NORETRY: The VM implementation must not retry indefinitely.
  */
-#define __GFP_WAIT	0x10u	/* Can wait and reschedule? */
-#define __GFP_HIGH	0x20u	/* Should access emergency pools? */
-#define __GFP_IO	0x40u	/* Can start physical IO? */
-#define __GFP_FS	0x80u	/* Can call down to low-level FS? */
-#define __GFP_COLD	0x100u	/* Cache-cold page required */
-#define __GFP_NOWARN	0x200u	/* Suppress page allocation failure warning */
-#define __GFP_REPEAT	0x400u	/* Retry the allocation.  Might fail */
-#define __GFP_NOFAIL	0x800u	/* Retry for ever.  Cannot fail */
-#define __GFP_NORETRY	0x1000u	/* Do not retry.  Might fail */
-#define __GFP_NO_GROW	0x2000u	/* Slab internal usage */
-#define __GFP_COMP	0x4000u	/* Add compound page metadata */
-#define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
-#define __GFP_NOMEMALLOC 0x10000u /* Don't use emergency reserves */
-#define __GFP_NORECLAIM  0x20000u /* No realy zone reclaim during allocation */
-#define __GFP_HARDWALL   0x40000u /* Enforce hardwall cpuset memory allocs */
+#define __GFP_WAIT	((__force gfp_t)0x10u)	/* Can wait and reschedule? */
+#define __GFP_HIGH	((__force gfp_t)0x20u)	/* Should access emergency pools? */
+#define __GFP_IO	((__force gfp_t)0x40u)	/* Can start physical IO? */
+#define __GFP_FS	((__force gfp_t)0x80u)	/* Can call down to low-level FS? */
+#define __GFP_COLD	((__force gfp_t)0x100u)	/* Cache-cold page required */
+#define __GFP_NOWARN	((__force gfp_t)0x200u)	/* Suppress page allocation failure warning */
+#define __GFP_REPEAT	((__force gfp_t)0x400u)	/* Retry the allocation.  Might fail */
+#define __GFP_NOFAIL	((__force gfp_t)0x800u)	/* Retry for ever.  Cannot fail */
+#define __GFP_NORETRY	((__force gfp_t)0x1000u)/* Do not retry.  Might fail */
+#define __GFP_NO_GROW	((__force gfp_t)0x2000u)/* Slab internal usage */
+#define __GFP_COMP	((__force gfp_t)0x4000u)/* Add compound page metadata */
+#define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
+#define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
+#define __GFP_NORECLAIM  ((__force gfp_t)0x20000u) /* No realy zone reclaim during allocation */
+#define __GFP_HARDWALL   ((__force gfp_t)0x40000u) /* Enforce hardwall cpuset memory allocs */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
-#define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
+#define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
@@ -64,6 +64,7 @@
 
 #define GFP_DMA		__GFP_DMA
 
+#define gfp_zone(mask) ((__force int)((mask) & (__force gfp_t)GFP_ZONEMASK))
 
 /*
  * There is only one page-allocator function, and two main namespaces to
@@ -94,7 +95,7 @@
 		return NULL;
 
 	return __alloc_pages(gfp_mask, order,
-		NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK));
+		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
 }
 
 #ifdef CONFIG_NUMA
diff -urN base/include/linux/types.h bitwise/include/linux/types.h
--- base/include/linux/types.h	2005-10-08 21:04:47.000000000 -0400
+++ bitwise/include/linux/types.h	2005-10-09 01:20:14.000000000 -0400
@@ -151,7 +151,12 @@
  */
 
 #ifdef __CHECKER__
-#define __bitwise __attribute__((bitwise))
+#define __bitwise__ __attribute__((bitwise))
+#else
+#define __bitwise__
+#endif
+#ifdef __CHECK_ENDIAN__
+#define __bitwise __bitwise__
 #else
 #define __bitwise
 #endif
@@ -166,7 +171,7 @@
 #endif
 
 #ifdef __KERNEL__
-typedef unsigned __nocast gfp_t;
+typedef unsigned __bitwise__ gfp_t;
 #endif
 
 struct ustat {
diff -urN base/mm/mempolicy.c bitwise/mm/mempolicy.c
--- base/mm/mempolicy.c	2005-10-08 21:04:47.000000000 -0400
+++ bitwise/mm/mempolicy.c	2005-10-09 01:20:14.000000000 -0400
@@ -700,7 +700,7 @@
 	case MPOL_BIND:
 		/* Lower zones don't get a policy applied */
 		/* Careful: current->mems_allowed might have moved */
-		if ((gfp & GFP_ZONEMASK) >= policy_zone)
+		if (gfp_zone(gfp) >= policy_zone)
 			if (cpuset_zonelist_valid_mems_allowed(policy->v.zonelist))
 				return policy->v.zonelist;
 		/*FALL THROUGH*/
@@ -712,7 +712,7 @@
 		nd = 0;
 		BUG();
 	}
-	return NODE_DATA(nd)->node_zonelists + (gfp & GFP_ZONEMASK);
+	return NODE_DATA(nd)->node_zonelists + gfp_zone(gfp);
 }
 
 /* Do dynamic interleaving for a process */
@@ -757,7 +757,7 @@
 	struct page *page;
 
 	BUG_ON(!node_online(nid));
-	zl = NODE_DATA(nid)->node_zonelists + (gfp & GFP_ZONEMASK);
+	zl = NODE_DATA(nid)->node_zonelists + gfp_zone(gfp);
 	page = __alloc_pages(gfp, order, zl);
 	if (page && page_zone(page) == zl->zones[0]) {
 		zone_pcp(zl->zones[0],get_cpu())->interleave_hit++;
diff -urN base/mm/page_alloc.c bitwise/mm/page_alloc.c
--- base/mm/page_alloc.c	2005-10-08 21:04:47.000000000 -0400
+++ bitwise/mm/page_alloc.c	2005-10-09 01:20:14.000000000 -0400
@@ -1089,7 +1089,7 @@
  */
 unsigned int nr_free_buffer_pages(void)
 {
-	return nr_free_zone_pages(GFP_USER & GFP_ZONEMASK);
+	return nr_free_zone_pages(gfp_zone(GFP_USER));
 }
 
 /*
@@ -1097,7 +1097,7 @@
  */
 unsigned int nr_free_pagecache_pages(void)
 {
-	return nr_free_zone_pages(GFP_HIGHUSER & GFP_ZONEMASK);
+	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER));
 }
 
 #ifdef CONFIG_HIGHMEM
