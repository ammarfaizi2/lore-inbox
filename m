Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWACUL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWACUL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWACUL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:11:57 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:49812 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S964782AbWACULy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:11:54 -0500
Date: Tue, 3 Jan 2006 12:11:53 -0800
Message-Id: <200601032011.k03KBp9E022738@zeus1.kernel.org>
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From penberg@localhost Tue Jan  3 22:10:07 2006
Message-Id: <20060103201006.596588000@localhost>
References: <20060103200922.395307000@localhost>
Date: Tue, 03 Jan 2006 22:09:26 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
 manfred@colorfullife.com,
 colpatch@us.ibm.com,
 rostedt@goodmis.org,
 clameter@sgi.com,
 penberg@cs.helsinki.fi
Subject: [patch 4/9] slab: cache_estimate cleanup
Content-Disposition: inline; filename=slab/slab-cache_estimate-cleanup.patch

From: Steven Rostedt <rostedt@goodmis.org>

This patch cleans up cache_estimate in mm/slab.c and improves the algorithm
by taking an initial guess before executing the while loop. The optimization
was originally made by Balbir Singh with further improvements from Steven
Rostedt. Manfred Spraul provider further modifications: no loop at all for
the off-slab case and explain the background.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   89 ++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 25 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -700,32 +700,71 @@ kmem_cache_t *kmem_find_general_cachep(s
 }
 EXPORT_SYMBOL(kmem_find_general_cachep);
 
-/* Cal the num objs, wastage, and bytes left over for a given slab size. */
-static void cache_estimate(unsigned long gfporder, size_t size, size_t align,
-		 int flags, size_t *left_over, unsigned int *num)
+static size_t slab_mgmt_size(size_t nr_objs, size_t align)
 {
-	int i;
-	size_t wastage = PAGE_SIZE<<gfporder;
-	size_t extra = 0;
-	size_t base = 0;
-
-	if (!(flags & CFLGS_OFF_SLAB)) {
-		base = sizeof(struct slab);
-		extra = sizeof(kmem_bufctl_t);
-	}
-	i = 0;
-	while (i*size + ALIGN(base+i*extra, align) <= wastage)
-		i++;
-	if (i > 0)
-		i--;
-
-	if (i > SLAB_LIMIT)
-		i = SLAB_LIMIT;
-
-	*num = i;
-	wastage -= i*size;
-	wastage -= ALIGN(base+i*extra, align);
-	*left_over = wastage;
+	return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
+}
+
+/* Calculate the number of objects and left-over bytes for a given
+   object size. */
+static void cache_estimate(unsigned long gfporder, size_t obj_size,
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
+	 * - Padding, to achieve alignment of @align
+	 * - @obj_size bytes for each object
+	 */
+	if (flags & CFLGS_OFF_SLAB) {
+		mgmt_size = 0;
+		nr_objs = slab_size / obj_size;
+
+		if (nr_objs > SLAB_LIMIT)
+			nr_objs = SLAB_LIMIT;
+	} else {
+		/* Ignore padding for the initial guess.  The padding
+		 * is at most @align-1 bytes, and @size is at least
+		 * @align. In the worst case, this result will be one
+		 * greater than the number of objects that fit into
+		 * the memory allocation when taking the padding into
+		 * account.
+		 */
+		nr_objs = (slab_size - sizeof(struct slab)) /
+			  (obj_size + sizeof(kmem_bufctl_t));
+
+		/*
+		 * Now take the padding into account and increase the
+		 * number of objects/slab until it doesn't fit
+		 * anymore.
+		 */
+		while (slab_mgmt_size(nr_objs, align) + nr_objs*obj_size
+		       <= slab_size)
+			nr_objs++;
+
+		/*
+		 * Reduce it by one which the maximum number of objects that
+		 * fit in the slab.
+		 */
+		if (nr_objs > 0)
+			nr_objs--;
+
+		if (nr_objs > SLAB_LIMIT)
+			nr_objs = SLAB_LIMIT;
+
+		mgmt_size = slab_mgmt_size(nr_objs, align);
+	}
+	*num = nr_objs;
+	*left_over = slab_size - nr_objs*obj_size - mgmt_size;
 }
 
 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)

--

