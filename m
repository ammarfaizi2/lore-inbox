Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWANMrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWANMrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWANMqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:46:11 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10402 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751235AbWANMqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:46:05 -0500
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Date: Sat, 14 Jan 2006 14:46:04 +0200
Message-Id: <20060114122415.163755000@localhost>
References: <20060114122249.246354000@localhost>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [patch 04/10] slab: cache_estimate cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

This patch cleans up cache_estimate() in mm/slab.c and improves the
algorithm from O(n) to O(1). We first calculate the maximum number of
objects a slab can hold after struct slab and kmem_bufctl_t for each
object has been given enough space. After that, to respect alignment
rules, we decrease the number of objects if necessary. As required
padding is at most align-1 and memory of obj_size is at least align,
it is always enough to decrease number of objects by one.

The optimization was originally made by Balbir Singh with more 
improvements from Steven Rostedt. Manfred Spraul provider further
modifications: no loop at all for the off-slab case and added comments
to explain the background.

Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   87 ++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 25 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -700,32 +700,69 @@ kmem_cache_t *kmem_find_general_cachep(s
 }
 EXPORT_SYMBOL(kmem_find_general_cachep);
 
-/* Cal the num objs, wastage, and bytes left over for a given slab size. */
-static void cache_estimate(unsigned long gfporder, size_t size, size_t align,
-			   int flags, size_t *left_over, unsigned int *num)
+static size_t slab_mgmt_size(size_t nr_objs, size_t align)
 {
-	int i;
-	size_t wastage = PAGE_SIZE << gfporder;
-	size_t extra = 0;
-	size_t base = 0;
-
-	if (!(flags & CFLGS_OFF_SLAB)) {
-		base = sizeof(struct slab);
-		extra = sizeof(kmem_bufctl_t);
-	}
-	i = 0;
-	while (i * size + ALIGN(base + i * extra, align) <= wastage)
-		i++;
-	if (i > 0)
-		i--;
-
-	if (i > SLAB_LIMIT)
-		i = SLAB_LIMIT;
-
-	*num = i;
-	wastage -= i * size;
-	wastage -= ALIGN(base + i * extra, align);
-	*left_over = wastage;
+	return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
+}
+
+/* Calculate the number of objects and left-over bytes for a given
+   buffer size. */
+static void cache_estimate(unsigned long gfporder, size_t buffer_size,
+			   size_t align, int flags, size_t *left_over,
+			   unsigned int *num)
+{
+	int nr_objs;
+	size_t mgmt_size;
+	size_t slab_size = PAGE_SIZE << gfporder;
+
+	/*
+	 * The slab management structure can be either off the slab or
+	 * on it. For the latter case, the memory allocated for a
+	 * slab is used for:
+	 *
+	 * - The struct slab
+	 * - One kmem_bufctl_t for each object
+	 * - Padding to respect alignment of @align
+	 * - @buffer_size bytes for each object
+	 *
+	 * If the slab management structure is off the slab, then the
+	 * alignment will already be calculated into the size. Because
+	 * the slabs are all pages aligned, the objects will be at the
+	 * correct alignment when allocated.
+	 */
+	if (flags & CFLGS_OFF_SLAB) {
+		mgmt_size = 0;
+		nr_objs = slab_size / buffer_size;
+
+		if (nr_objs > SLAB_LIMIT)
+			nr_objs = SLAB_LIMIT;
+	} else {
+		/*
+		 * Ignore padding for the initial guess. The padding
+		 * is at most @align-1 bytes, and @buffer_size is at
+		 * least @align. In the worst case, this result will
+		 * be one greater than the number of objects that fit
+		 * into the memory allocation when taking the padding
+		 * into account.
+		 */
+		nr_objs = (slab_size - sizeof(struct slab)) /
+			  (buffer_size + sizeof(kmem_bufctl_t));
+
+		/*
+		 * This calculated number will be either the right
+		 * amount, or one greater than what we want.
+		 */
+		if (slab_mgmt_size(nr_objs, align) + nr_objs*buffer_size
+		       > slab_size)
+			nr_objs--;
+
+		if (nr_objs > SLAB_LIMIT)
+			nr_objs = SLAB_LIMIT;
+
+		mgmt_size = slab_mgmt_size(nr_objs, align);
+	}
+	*num = nr_objs;
+	*left_over = slab_size - nr_objs*buffer_size - mgmt_size;
 }
 
 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)

--

