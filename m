Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWBUTZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWBUTZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 14:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWBUTZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 14:25:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:14311 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932554AbWBUTZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 14:25:40 -0500
Subject: Re: RFC: Block reservation for hugetlbfs
From: Dave Hansen <haveblue@us.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060221022124.GA18535@localhost.localdomain>
References: <20060221022124.GA18535@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-Y7n3GgVAuI5zKb0KRI2m"
Date: Tue, 21 Feb 2006 11:25:36 -0800
Message-Id: <1140549936.8693.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y7n3GgVAuI5zKb0KRI2m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-02-21 at 13:21 +1100, David Gibson wrote:
> The patch below is a draft attempt to address this problem, by
> strictly reserving a number of physical hugepages for hugepages inodes
> which have been mapped, but not instatiated.  MAP_SHARED mappings are
> thus "safe" - they will fail on mmap(), not later with a SIGBUS.
> MAP_PRIVATE mappings can still SIGBUS.
...
> +	read_lock_irq(&inode->i_mapping->tree_lock);
> +	for (pg = inode->i_blocks; pg < npages; pg++) {
> +		page = radix_tree_lookup(&mapping->page_tree, pg);
> +		if (! page)
> +			change_in_reserve++;
> +	}
> +
> +	for (pg = npages; pg < inode->i_blocks; pg++) {
> +		page = radix_tree_lookup(&mapping->page_tree, pg);
> +		if (! page)
> +			change_in_reserve--;
> +	}
> +	spin_lock(&hugetlb_lock);

I'm a bit confused by this.  The for loops goes through and looks for
pages that have indexes greater than the current i_blocks, but less than
the number of pages requested by this reservation.  With demand
faulting, can there be holes in the file?  Will this code account for
them?

I think this would also be a bit more clear if the two for loops were a
bit more explicit in what they are doing.  The first is growing the
reservation when "npages > inode->i_blocks" and the second is shrinking
the reservation when "npages < inode->i_blocks", right?  Is this
completely clear from the code? ;)

Also, since the operation you are performing is actually counting pages
in the radix tree at certain indexes, would it be sane to have a patch
such as the (completely untested) attached one to do just that, but in
the radix code?

-- Dave


--=-Y7n3GgVAuI5zKb0KRI2m
Content-Disposition: attachment; filename=radix-tree-count.patch
Content-Type: text/x-patch; name=radix-tree-count.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 memhotplug-dave/lib/radix-tree.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff -puN lib/radix-tree.c~radix-tree-count lib/radix-tree.c
--- memhotplug/lib/radix-tree.c~radix-tree-count	2006-02-21 10:50:25.000000000 -0800
+++ memhotplug-dave/lib/radix-tree.c	2006-02-21 10:51:00.000000000 -0800
@@ -538,7 +538,9 @@ __lookup(struct radix_tree_root *root, v
 	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
 		index++;
 		if (slot->slots[i]) {
-			results[nr_found++] = slot->slots[i];
+			if (results)
+				results[nr_found] = slot->slots[i];
+			nr_found++;
 			if (nr_found == max_items)
 				goto out;
 		}
@@ -559,6 +561,9 @@ out:
  *	them at *@results and returns the number of items which were placed at
  *	*@results.
  *
+ *	If *@results is NULL, the function will return a count of pages found,
+ *	without any actual results.
+ *
  *	The implementation is naive.
  */
 unsigned int
@@ -572,10 +577,13 @@ radix_tree_gang_lookup(struct radix_tree
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
+		void *cur_result = NULL;
 
 		if (cur_index > max_index)
 			break;
-		nr_found = __lookup(root, results + ret, cur_index,
+		if (results)
+			cur_result = results + ret;
+		nr_found = __lookup(root, cur_result, cur_index,
 					max_items - ret, &next_index);
 		ret += nr_found;
 		if (next_index == 0)
@@ -586,6 +594,13 @@ radix_tree_gang_lookup(struct radix_tree
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup);
 
+unsigned int
+radix_tree_lookup_count(struct radix_tree_root *root
+			unsigned long first_index)
+{
+	return radix_tree_gang_lookup(root, NULL, first_index, ~0);
+}
+
 /*
  * FIXME: the two tag_get()s here should use find_next_bit() instead of
  * open-coding the search.
_

--=-Y7n3GgVAuI5zKb0KRI2m--

