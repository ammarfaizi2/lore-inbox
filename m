Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVHWRPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVHWRPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVHWRPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:15:53 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:34750 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932233AbVHWRPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:15:52 -0400
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: luben_tuikov@adaptec.com, jim.houston@ccur.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050822150942.4f0c46df.akpm@osdl.org>
References: <20050822003325.33507.qmail@web51613.mail.yahoo.com>
	 <1124680540.5068.37.camel@mulgrave> <20050821205214.2a75b3cf.akpm@osdl.org>
	 <1124720938.5211.13.camel@mulgrave> <1124747615.5211.34.camel@mulgrave>
	 <20050822150942.4f0c46df.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 12:15:38 -0500
Message-Id: <1124817338.5108.17.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 15:09 -0700, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > Of course, if we're going to go to all this trouble, the next question
> >  that arises naturally is why not just reuse the radix-tree code to
> >  implement idr anyway ... ?
> 
> Yes, we could probably have gone that way.  radix-tree would need some
> enhancements for the find-next-above thing.

Yes, that's particularly simple (example patch below).  However, radix-
tree needs to grow a bitmap index for whether its slots are occupied for
this to be made efficient (it would also help with the gang lookups
too)---at the moment it's O(N); it could be made O(log(N)).

> radix-tree has some features (tags, gang-lookup, gang-lookup-by-tag) which
> idr doesn't.  Fitting them all into the one storage API would be nice, I
> guess.  radix-tree does potentially use more memory, although that'll only
> be significant for collections which are both large and sparse.

And by definition, idr is trying to discourage sparsity in the
collections.

> Still, people can use either facility at present.  The person who does any
> such consolidation would do the kernel-wide migration at the same time.

True.  We only seem to have 8 in tree users ... that's not a huge number
to convert.

James

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -62,10 +62,20 @@ unsigned int
 radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
 		unsigned long first_index, unsigned int max_items, int tag);
 int radix_tree_tagged(struct radix_tree_root *root, int tag);
+int radix_tree_get_new_above(struct radix_tree_root *root, void *item,
+			     unsigned long starting_index,
+			     unsigned long *index);
 
 static inline void radix_tree_preload_end(void)
 {
 	preempt_enable();
 }
 
+static inline int radix_tree_get_new(struct radix_tree_root *root, void *item,
+				     unsigned long *index)
+{
+	return radix_tree_get_new_above(root, item, 0, index);
+}
+
+
 #endif /* _LINUX_RADIX_TREE_H */
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -133,6 +133,7 @@ int radix_tree_preload(int gfp_mask)
 out:
 	return ret;
 }
+EXPORT_SYMBOL(radix_tree_preload);
 
 static inline void tag_set(struct radix_tree_node *node, int tag, int offset)
 {
@@ -483,7 +484,9 @@ __lookup(struct radix_tree_root *root, v
 		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
 
 		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
-			if (slot->slots[i] != NULL)
+			if (max_items == 0 && slot->slots[i] == NULL)
+				goto out;
+			else if (max_items != 0 && slot->slots[i] != NULL)
 				break;
 			index &= ~((1UL << shift) - 1);
 			index += 1UL << shift;
@@ -498,7 +501,9 @@ __lookup(struct radix_tree_root *root, v
 
 			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
 				index++;
-				if (slot->slots[j]) {
+				if (max_items == 0 && slot->slots[j] == NULL)
+					goto out;
+				if (max_items != 0 && slot->slots[j]) {
 					results[nr_found++] = slot->slots[j];
 					if (nr_found == max_items)
 						goto out;
@@ -551,6 +556,28 @@ radix_tree_gang_lookup(struct radix_tree
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup);
 
+/**
+ * radix_tree_get_new_above - insert item into first available slot
+ *
+ * @root:	radix tree root
+ * @item:	item to insert
+ * @starting_index: index to begin the search for a new slot from
+ * @index:	actual index found for inserting the item
+ *
+ * Performs an index-ascending scan of the tree for an empty slot.  Places
+ * @item in the first empty slot and sets @index to its position.
+ */
+int radix_tree_get_new_above(struct radix_tree_root *root, void *item,
+			     unsigned long starting_index,
+			     unsigned long *index)
+{
+	if (item == NULL)
+		item = (void *)1UL;
+	__lookup(root, NULL, starting_index, 0, index);
+	return radix_tree_insert(root, *index, item);
+}
+EXPORT_SYMBOL(radix_tree_get_new_above);
+
 /*
  * FIXME: the two tag_get()s here should use find_next_bit() instead of
  * open-coding the search.



