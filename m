Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVKKADY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVKKADY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVKKADY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:03:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:4033 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932083AbVKKADX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:03:23 -0500
Message-ID: <4373DFC4.5020309@us.ibm.com>
Date: Thu, 10 Nov 2005 16:03:16 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] Create helper for kmem_cache_create()
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020109060301080900050708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020109060301080900050708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

There's a loop in kmem_cache_create() where we try to determine the best
page order for a slab.  It's a big, ugly loop, so let's move it to its own
function: calculate_slab_order().

-Matt

--------------020109060301080900050708
Content-Type: text/x-patch;
 name="calculate_slab_order.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="calculate_slab_order.patch"

There's a fairly ugly loop in kmem_cache_create() where we determine the
'optimal' size (page order) of cache's slabs.  Let's move this code into
it's own helper function to increase readability.

Thanks to Matthew Wilcox <matthew@wil.cx> for help with this patch.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:43:42.198046816 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:48:43.827192216 -0800
@@ -1463,6 +1463,53 @@ static inline void set_up_list3s(kmem_ca
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
+			break;	/* Acceptable internal fragmentation */
+	}
+
+	return left_over;
+}
+
+/**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
  * @size: The size of objects to be created in this cache.
@@ -1646,46 +1693,8 @@ kmem_cache_t *kmem_cache_create(const ch
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
-				       &left_over, &cachep->num);
-			if (break_flag)
-				break;
-			if (cachep->gfporder >= MAX_GFP_ORDER)
-				break;
-			if (!cachep->num)
-				goto next;
-			if (flags & CFLGS_OFF_SLAB &&
-			    cachep->num > offslab_limit) {
-				/* This num of objs will cause problems. */
-				cachep->gfporder--;
-				break_flag++;
-				goto cal_wastage;
-			}
-
-			/*
-			 * Large num of objs is good, but very large slabs are
-			 * currently bad for the gfp()s.
-			 */
-			if (cachep->gfporder >= slab_break_gfp_order)
-				break;
-
-			if ((left_over * 8) <= (PAGE_SIZE << cachep->gfporder))
-				break;  /* Acceptable internal fragmentation */
-next:
-			cachep->gfporder++;
-		} while (1);
-	}
+	} else
+		left_over = calculate_slab_order(cachep, size, align, flags);
 
 	if (!cachep->num) {
 		printk("kmem_cache_create: couldn't create cache %s.\n", name);

--------------020109060301080900050708--
