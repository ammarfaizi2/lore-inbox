Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVKRR0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVKRR0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVKRR0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:26:32 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:45806 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932362AbVKRR0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:26:17 -0500
Subject: [PATCH 4/5] slab: extract slab order calculation to separate function
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       manfred@colorfullife.com
Content-Type: text/plain
Message-Id: <iq5uuh.o9kcui.7v9w5djupiovhrqo6are97fi6.beaver@cs.helsinki.fi>
In-Reply-To: <iq5uuc.zmsv6.a6p8qowodnwx9kaa8jonhv8n3.beaver@cs.helsinki.fi>
Date: Fri, 18 Nov 2005 19:20:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch moves the ugly loop that determines the 'optimal' size (page
order) of cache slabs from kmem_cache_create() to a separate function
and cleans it up a bit.

Thanks to Matthew Wilcox for the help with this patch.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c |   89 +++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -1479,6 +1479,53 @@ static inline void set_up_list3s(kmem_ca
 }
 
 /**
+ * calculate_slab_order - calculate size (page order) of slabs and the number
+ *                        of objects per slab.
+ *
+ * This could be made much more intelligent.  For now, try to avoid using
+ * high order pages for slabs.  When the gfp() functions are more friendly
+ * towards high-order requests, this should be changed.
+ */
+static inline size_t calculate_slab_order(kmem_cache_t *cachep, size_t size,
+					  size_t align, gfp_t flags)
+{
+	size_t left_over = 0;
+
+	for ( ; ; cachep->gfporder++) {
+		unsigned int num;
+		size_t remainder;
+
+		if (cachep->gfporder > MAX_GFP_ORDER) {
+			cachep->num = 0;
+			break;
+		}
+
+		cache_estimate(cachep->gfporder, size, align, flags,
+			       &remainder, &num);
+		if (!num)
+			continue;
+		/* More than offslab_limit objects will cause problems */
+		if (flags & CFLGS_OFF_SLAB && cachep->num > offslab_limit)
+			break;
+
+		cachep->num = num;
+		left_over = remainder;
+
+		/*
+		 * Large number of objects is good, but very large slabs are
+		 * currently bad for the gfp()s.
+		 */
+		if (cachep->gfporder >= slab_break_gfp_order)
+			break;
+
+		if ((left_over * 8) <= (PAGE_SIZE << cachep->gfporder))
+			/* Acceptable internal fragmentation */
+			break;
+	}
+	return left_over;
+}
+
+/**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
@@ -1687,46 +1734,8 @@ kmem_cache_create (const char *name, siz
 		cachep->gfporder = 0;
 		cache_estimate(cachep->gfporder, size, align, flags,
 					&left_over, &cachep->num);
-	} else {
-		/*
-		 * Calculate size (in pages) of slabs, and the num of objs per
-		 * slab.  This could be made much more intelligent.  For now,
-		 * try to avoid using high page-orders for slabs.  When the
-		 * gfp() funcs are more friendly towards high-order requests,
-		 * this should be changed.
-		 */
-		do {
-			unsigned int break_flag = 0;
-cal_wastage:
-			cache_estimate(cachep->gfporder, size, align, flags,
-						&left_over, &cachep->num);
-			if (break_flag)
-				break;
-			if (cachep->gfporder >= MAX_GFP_ORDER)
-				break;
-			if (!cachep->num)
-				goto next;
-			if (flags & CFLGS_OFF_SLAB &&
-					cachep->num > offslab_limit) {
-				/* This num of objs will cause problems. */
-				cachep->gfporder--;
-				break_flag++;
-				goto cal_wastage;
-			}
-
-			/*
-			 * Large num of objs is good, but v. large slabs are
-			 * currently bad for the gfp()s.
-			 */
-			if (cachep->gfporder >= slab_break_gfp_order)
-				break;
-
-			if ((left_over*8) <= (PAGE_SIZE<<cachep->gfporder))
-				break;	/* Acceptable internal fragmentation. */
-next:
-			cachep->gfporder++;
-		} while (1);
-	}
+	} else
+		left_over = calculate_slab_order(cachep, size, align, flags);
 
 	if (!cachep->num) {
 		printk("kmem_cache_create: couldn't create cache %s.\n", name);
