Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTDKV1z (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTDKV1z (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:27:55 -0400
Received: from [12.47.58.73] ([12.47.58.73]:6889 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261860AbTDKV1w (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:27:52 -0400
Date: Fri, 11 Apr 2003 14:39:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] first try for swap prefetch
Message-Id: <20030411143932.6bd0b08a.akpm@digeo.com>
In-Reply-To: <200304111352.05774.schlicht@uni-mannheim.de>
References: <200304101948.12423.schlicht@uni-mannheim.de>
	<20030410161826.04332890.akpm@digeo.com>
	<200304111352.05774.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 21:39:29.0156 (UTC) FILETIME=[D4B74C40:01C30072]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> > you can just do
> >
> > 	if (radix_tree_delete(...) != -ENOENT)
> > 		list_del(...)
> >
> > +		read_swap_cache_async(entry);
> 
> Sorry, but I think I can not. The list_del() needs the value returned by 
> radix_tree_lookup(), so I can not kick it...

OK, I'll change radix_tree_delete() to return the deleted object address if
it was found, else NULL.  That's a better API.

> Do you know how expensive the radix_tree_lookup() is? O(1) or O(log(n))?? For 
> my shame I do not really know that data structure... :-(

It is proportional to

	log_base_64(largest index which the tree has ever stored)

log_base_64: because each node has 64 slots.  Each time maxindex grows by a
factor of 64 we need to introduce a new level.

"largest index ever": because we do not (and cannot feasibly) reduce the
height when items are removed.

> > It might make sense to poke the speculative swapin code in the page-freeing
> > path too.
> 
> I wanted to do this but don't know which function is the correct one for this. 
> But I will search harder... or can you give me a hint?

free_pages_bulk() would probably suit.



diff -puN fs/nfs/write.c~radix_tree_delete-api-cleanup fs/nfs/write.c
diff -puN lib/radix-tree.c~radix_tree_delete-api-cleanup lib/radix-tree.c
--- 25/lib/radix-tree.c~radix_tree_delete-api-cleanup	Fri Apr 11 14:30:30 2003
+++ 25-akpm/lib/radix-tree.c	Fri Apr 11 14:30:30 2003
@@ -349,15 +349,18 @@ EXPORT_SYMBOL(radix_tree_gang_lookup);
  *	@index:		index key
  *
  *	Remove the item at @index from the radix tree rooted at @root.
+ *
+ *	Returns the address of the deleted item, or NULL if it was not present.
  */
-int radix_tree_delete(struct radix_tree_root *root, unsigned long index)
+void *radix_tree_delete(struct radix_tree_root *root, unsigned long index)
 {
 	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
 	unsigned int height, shift;
+	void *ret = NULL;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
-		return -ENOENT;
+		goto out;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	pathp->node = NULL;
@@ -365,7 +368,7 @@ int radix_tree_delete(struct radix_tree_
 
 	while (height > 0) {
 		if (*pathp->slot == NULL)
-			return -ENOENT;
+			goto out;
 
 		pathp[1].node = *pathp[0].slot;
 		pathp[1].slot = (struct radix_tree_node **)
@@ -375,8 +378,9 @@ int radix_tree_delete(struct radix_tree_
 		height--;
 	}
 
-	if (*pathp[0].slot == NULL)
-		return -ENOENT;
+	ret = *pathp[0].slot;
+	if (ret == NULL)
+		goto out;
 
 	*pathp[0].slot = NULL;
 	while (pathp[0].node && --pathp[0].node->count == 0) {
@@ -387,8 +391,8 @@ int radix_tree_delete(struct radix_tree_
 
 	if (root->rnode == NULL)
 		root->height = 0;  /* Empty tree, we can reset the height */
-
-	return 0;
+out:
+	return ret;
 }
 EXPORT_SYMBOL(radix_tree_delete);
 
diff -puN mm/filemap.c~radix_tree_delete-api-cleanup mm/filemap.c
diff -puN include/linux/radix-tree.h~radix_tree_delete-api-cleanup include/linux/radix-tree.h
--- 25/include/linux/radix-tree.h~radix_tree_delete-api-cleanup	Fri Apr 11 14:30:30 2003
+++ 25-akpm/include/linux/radix-tree.h	Fri Apr 11 14:30:30 2003
@@ -43,7 +43,7 @@ do {					\
 
 extern int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
 extern void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
-extern int radix_tree_delete(struct radix_tree_root *, unsigned long);
+extern void *radix_tree_delete(struct radix_tree_root *, unsigned long);
 extern unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);

_

