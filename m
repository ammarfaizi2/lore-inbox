Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWEYFp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWEYFp1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWEYFp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:45:27 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:8831 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965051AbWEYFp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:45:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=QYdXPxR/YY+Gsh78TeBhRISikeDOskD2yTV0q66N5e0XBGqvHKejD8NJkyb7Ip1QFLIDom/BigF9OdDhIAQR9NF/zLaKx3q79v4ELraSOb7VDluj8ecmePPQZwvDgEZymdAKSQVcPNs5fBxSZplVp0MR0qoT0j02VbI8CZeDuMM=  ;
Message-ID: <44754472.1030906@yahoo.com.au>
Date: Thu, 25 May 2006 15:45:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: Re: + radixtree-look-aside-cache.patch added to -mm tree]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, this didn't get to lkml. Sorry 'bout that.

-------- Original Message --------
Subject: 	Re: + radixtree-look-aside-cache.patch added to -mm tree
Date: 	Thu, 25 May 2006 15:18:07 +1000
From: 	Nick Piggin <nickpiggin@yahoo.com.au>
To: 	akpm@osdl.org
CC: 	wfg@mail.ustc.edu.cn, clameter@sgi.com
References: 	<200605242345.k4ONjqnE004454@shell0.pdx.osdl.net>



akpm@osdl.org wrote:

>The patch titled
>
>     radixtree: look-aside cache
>
>has been added to the -mm tree.  Its filename is
>
>     radixtree-look-aside-cache.patch
>
>See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
>out what to do about this
>
>------------------------------------------------------
>Subject: radixtree: look-aside cache
>From: Wu Fengguang <wfg@mail.ustc.edu.cn>
>
>
>Introduce a set of lookup functions to radix tree for the read-ahead logic.
>Other access patterns with high locality may also benefit from them.
>


Your radix tree stuff doesn't _seem_ like a bad idea, but I would be
much more comfortable if it was in a completely different patchset.
Ie. implement your readahead stuff using the current radix-tree API,
then show eg. 15% CPU reduction on workload X when using look-aside
cache for blah.

It is more complexity, and the intention might be nice, but it might
not actually help as much (or at all) as you think: eg. it might
increase cache footprint and actually slow things down.

[edit] there are a couple of bugs in the patch itself, too (see below)

>
>- radix_tree_lookup_parent(root, index, level)
>	Perform partial lookup, return the @level'th parent of the slot at
>	@index.
>
>- radix_tree_cache_xxx()
>	Init/Query the cache.
>- radix_tree_cache_lookup(root, cache, index)
>	Perform lookup with the aid of a look-aside cache.
>	For sequential scans, it has a time complexity of 64*O(1) + 1*O(logN).
>
>	Typical usage:
>
>   void func() {
>  +       struct radix_tree_cache cache;
>  +
>  +       radix_tree_cache_init(&cache);
>          read_lock_irq(&mapping->tree_lock);
>          for(;;) {
>  -               page = radix_tree_lookup(&mapping->page_tree, index);
>  +               page = radix_tree_cache_lookup(&mapping->page_tree, &cache, index);
>          }
>          read_unlock_irq(&mapping->tree_lock);
>   }
>

Still not really convinced with this. I can't see why you shouldn't just
use a gang lookup or "scan" type function. Let's take your real example:

+static pgoff_t find_segtail_backward(struct address_space *mapping,
+					pgoff_t index, unsigned long max_scan)
+{
+	struct radix_tree_cache cache;
+	struct page *page;
+	pgoff_t origin;
+
+	origin = index;
+	if (max_scan > index)
+		max_scan = index;
+
+	cond_resched();

BTW. cond_resched here? It should normally be in the caller if they expect
really high latency.

+	radix_tree_cache_init(&cache);
+	read_lock_irq(&mapping->tree_lock);
+	for (; origin - index < max_scan;) {
+		page = radix_tree_cache_lookup(&mapping->page_tree,
+							&cache, --index);
+		if (page) {
+			read_unlock_irq(&mapping->tree_lock);
+			return index + 1;
+		}
+	}
+	read_unlock_irq(&mapping->tree_lock);


This should just be a scan_page_backward (not scan_hole), should it not?
I didn't find other usages of the radix tree cache after a quick scan, but
if you point them out, let's see if they can't be replaced with something
else.


>
>Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>
>

Can't remember if I exactly acked it, but stuff has changed a bit, so it is
a nack for the moment ;)

>Signed-off-by: Christoph Lameter <clameter@sgi.com>
>Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> include/linux/radix-tree.h |   83 +++++++++++++++++++++++++++
> lib/radix-tree.c           |  104 ++++++++++++++++++++++++++---------
> 2 files changed, 161 insertions(+), 26 deletions(-)
>
>diff -puN include/linux/radix-tree.h~radixtree-look-aside-cache include/linux/radix-tree.h
>--- 25/include/linux/radix-tree.h~radixtree-look-aside-cache	Wed May 24 16:48:44 2006
>+++ 25-akpm/include/linux/radix-tree.h	Wed May 24 16:48:44 2006
>@@ -26,12 +26,29 @@
> #define RADIX_TREE_MAX_TAGS 2
> 
> /* root tags are stored in gfp_mask, shifted by __GFP_BITS_SHIFT */
>+#ifdef __KERNEL__
>+#define RADIX_TREE_MAP_SHIFT	(CONFIG_BASE_SMALL ? 4 : 6)
>+#else
>+#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
>+#endif
>+
>+#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
>+#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
>+
> struct radix_tree_root {
> 	unsigned int		height;
> 	gfp_t			gfp_mask;
> 	struct radix_tree_node	*rnode;
> };
> 
>+/*
>+ * Lookaside cache to support access patterns with strong locality.
>+ */
>+struct radix_tree_cache {
>+	unsigned long first_index;
>+	struct radix_tree_node *tree_node;
>+};
>+
> #define RADIX_TREE_INIT(mask)	{					\
> 	.height = 0,							\
> 	.gfp_mask = (mask),						\
>@@ -49,9 +66,14 @@ do {									\
> } while (0)
> 
> int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
>-void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
>-void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
>+void *radix_tree_lookup_parent(struct radix_tree_root *, unsigned long,
>+							unsigned int);
>+void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long);
> void *radix_tree_delete(struct radix_tree_root *, unsigned long);
>+unsigned int radix_tree_cache_count(struct radix_tree_cache *cache);
>+void *radix_tree_cache_lookup_parent(struct radix_tree_root *root,
>+				struct radix_tree_cache *cache,
>+				unsigned long index, unsigned int level);
>

Nitpick: I don't really like the name lookup_parent. No better suggestions
though ;)

But the function seems really nasty for an exported API: callers should
have no concept of the internals of the data structure. If you just need
it to implement these inline functions, maybe prepend it with a double
underscore.


>diff -puN lib/radix-tree.c~radixtree-look-aside-cache lib/radix-tree.c
>--- 25/lib/radix-tree.c~radixtree-look-aside-cache	Wed May 24 16:48:44 2006
>+++ 25-akpm/lib/radix-tree.c	Wed May 24 16:48:44 2006
>@@ -308,36 +308,90 @@ int radix_tree_insert(struct radix_tree_
> }
> EXPORT_SYMBOL(radix_tree_insert);
> 
>-static inline void **__lookup_slot(struct radix_tree_root *root,
>-				   unsigned long index)
>+/**
>+ *	radix_tree_lookup_parent    -    low level lookup routine
>+ *	@root:		radix tree root
>+ *	@index:		index key
>+ *	@level:		stop at that many levels from the tree leaf
>+ *
>+ *	Lookup the @level'th parent of the slot at @index in radix tree @root.
>+ *	The return value is:
>+ *	@level == 0:      page at @index;
>+ *	@level == 1:      the corresponding bottom level tree node;
>+ *	@level < height:  (@level-1)th parent node of the bottom node
>+ *			  that contains @index;
>+ *	@level >= height: the root node.
>+ */
>+void *radix_tree_lookup_parent(struct radix_tree_root *root,
>+				unsigned long index, unsigned int level)
> {
> 	unsigned int height, shift;
>-	struct radix_tree_node **slot;
>+	struct radix_tree_node *slot;
> 
> 	height = root->height;
> 
> 	if (index > radix_tree_maxindex(height))
> 		return NULL;
> 
>-	if (height == 0 && root->rnode)
>-		return (void **)&root->rnode;
>-
> 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
>-	slot = &root->rnode;
>+	slot = root->rnode;
> 
>

This couldn't work: we have direct data now in -mm (unless that's been 
thrown out).

>-	while (height > 0) {
>-		if (*slot == NULL)
>+	while (height > level) {
>+		if (slot == NULL)
> 			return NULL;
> 
>-		slot = (struct radix_tree_node **)
>-			((*slot)->slots +
>-				((index >> shift) & RADIX_TREE_MAP_MASK));
>+		slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
> 		shift -= RADIX_TREE_MAP_SHIFT;
> 		height--;
> 	}
> 
>-	return (void **)slot;
>+	return slot;
>+}
>+EXPORT_SYMBOL(radix_tree_lookup_parent);
>+
>+/**
>+ *	radix_tree_cache_lookup_parent    -    cached lookup node
>+ *	@root:		radix tree root
>+ *	@cache:		look-aside cache
>+ *	@index:		index key
>+ *
>+ *	Lookup the item at the position @index in the radix tree @root,
>+ *	and return the node @level levels from the bottom in the search path.
>+ *
>+ *	@cache stores the last accessed upper level tree node by this
>+ *	function, and is always checked first before searching in the tree.
>+ *	It can improve speed for access patterns with strong locality.
>+ *
>+ *	NOTE:
>+ *	- The cache becomes invalid on leaving the lock;
>+ *	- Do not intermix calls with different @level.
>+ */
>+void *radix_tree_cache_lookup_parent(struct radix_tree_root *root,
>+				struct radix_tree_cache *cache,
>+				unsigned long index, unsigned int level)
>+{
>+	struct radix_tree_node *node;
>+        unsigned long i;
>+        unsigned long mask;
>+
>+        if (level >= root->height)
>+                return radix_tree_lookup_parent(root, index, level);
>+
>+        i = (index >> (level * RADIX_TREE_MAP_SHIFT)) & RADIX_TREE_MAP_MASK;
>+        mask = (~0UL) << ((level + 1) * RADIX_TREE_MAP_SHIFT);
>+
>+	if ((index & mask) == cache->first_index)
>+                return cache->tree_node->slots[i];
>+
>+	node = radix_tree_lookup_parent(root, index, level + 1);
>+	if (!node)
>+		return 0;
>+
>+	cache->tree_node = node;
>+	cache->first_index = (index & mask);
>+        return node->slots[i];
> }
>+EXPORT_SYMBOL(radix_tree_cache_lookup_parent);
> 
> /**
>  *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
>@@ -349,25 +403,27 @@ static inline void **__lookup_slot(struc
>  */
> void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
> {
>-	return __lookup_slot(root, index);
>+	struct radix_tree_node *node;
>+
>+	node = radix_tree_lookup_parent(root, index, 1);
>+	return node->slots + (index & RADIX_TREE_MAP_MASK);
> }
> EXPORT_SYMBOL(radix_tree_lookup_slot);
>

radix_tree_lookup_parent can return NULL, right? Oops.



Send instant messages to your online friends http://au.messenger.yahoo.com 
