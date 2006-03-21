Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWCUXLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWCUXLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWCUXLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:11:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8934 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751832AbWCUXLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:11:09 -0500
Date: Tue, 21 Mar 2006 15:10:52 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, alokk@calsoftinc.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: slab: Add transfer_objects() function
Message-ID: <Pine.LNX.4.64.0603211509180.14245@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

transfer_objects() can be used to transfer objects between various object
caches of the slab allocator. It is currently only used during __cache_alloc() to
retrieve elements from the shared array. We will be using it soon to transfer
elements from the alien caches to the remote shared array.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc6-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/mm/slab.c	2006-03-21 14:52:47.000000000 -0800
+++ linux-2.6.16-rc6-mm2/mm/slab.c	2006-03-21 14:53:40.000000000 -0800
@@ -901,6 +901,30 @@ static struct array_cache *alloc_arrayca
 	return nc;
 }
 
+/*
+ * Transfer objects in one arraycache to another.
+ * Locking must be handled by the caller.
+ *
+ * Return the number of entries transferred.
+ */
+static int transfer_objects(struct array_cache *to,
+		struct array_cache *from, int max)
+{
+	/* Figure out how many entries to transfer */
+	int nr = min(min(from->avail, max), to->limit - to->avail);
+
+	if (!nr)
+		return 0;
+
+	memcpy(to->entry + to->avail, from->entry + from->avail -nr,
+			sizeof(void *) *nr);
+
+	from->avail -= nr;
+	to->avail += nr;
+	to->touched = 1;
+	return nr;
+}
+
 #ifdef CONFIG_NUMA
 static void *__cache_alloc_node(struct kmem_cache *, gfp_t, int);
 static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
@@ -2684,20 +2708,10 @@ retry:
 	BUG_ON(ac->avail > 0 || !l3);
 	spin_lock(&l3->list_lock);
 
-	if (l3->shared) {
-		struct array_cache *shared_array = l3->shared;
-		if (shared_array->avail) {
-			if (batchcount > shared_array->avail)
-				batchcount = shared_array->avail;
-			shared_array->avail -= batchcount;
-			ac->avail = batchcount;
-			memcpy(ac->entry,
-			       &(shared_array->entry[shared_array->avail]),
-			       sizeof(void *) * batchcount);
-			shared_array->touched = 1;
-			goto alloc_done;
-		}
-	}
+	/* See if we can refill from the shared array */
+	if (l3->shared && transfer_objects(ac, l3->shared, batchcount))
+		goto alloc_done;
+
 	while (batchcount > 0) {
 		struct list_head *entry;
 		struct slab *slabp;
