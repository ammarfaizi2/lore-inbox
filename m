Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVKQNIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVKQNIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVKQNIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:08:00 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:61595 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750793AbVKQNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:07:59 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17276.32953.27465.648452@gargle.gargle.HOWL>
Date: Thu, 17 Nov 2005 16:08:09 +0300
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, theonetruekenny@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Newsgroups: gmane.linux.kernel
In-Reply-To: <20051116183808.GA5642@infradead.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	<1132163057.8811.15.camel@lade.trondhjem.org>
	<20051116100053.44d81ae2.akpm@osdl.org>
	<1132166062.8811.30.camel@lade.trondhjem.org>
	<20051116183808.GA5642@infradead.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Wed, Nov 16, 2005 at 01:34:22PM -0500, Trond Myklebust wrote:
 > > Not really. The pages aren't flushed at this time. We the point is to
 > > gather several pages and coalesce them into one over-the-wire RPC call.
 > > That means we cannot really do it from inside ->writepage().
 > > 
 > > We do start the actual RPC calls in ->writepages(), though.
 > 
 > This is a problem we have in various filesystems.  Except for really
 > bad OOM situations the filesystem should never get a writeout request
 > for a single file.  We should really stop having ->writepage called by
 > the VM and move this kind of batching code into the VM.  I'm runnin into
 > similar issues for XFS and unwritten/delayed extent conversion once again.

Simplistic version if such batching is implemented in the patch below
(also available at

http://linuxhacker.ru/~nikita/patches/2.6.15-rc1/05-cluster-pageout.patch

it depends on page_referenced-move-dirty patch from the same place)

This version pokes into address_space radix tree to find a cluster of
pages suitable for page-out and then calls ->writepage() on pages in
that cluster in the proper order. This relies on the underlying layer
(e.g., block device) to perform request coalescing.

My earlier attempts to do this through ->writepages() were all racy,
because at some point ->writepages() has to release a lock at the
original page around which the cluster is built, and that lock is the
only thing that protects inode/address_space from the destruction. As
was already noted by Andrew, one cannot use igrab/iput in the VM scanner
to deal with that.

I still think it's possible to do higher layer batching, but that would
require more extensive changes to both VM scanner and ->writepages().

 > 

Nikita.
--
Implement pageout clustering at the VM level.

With this patch VM scanner calls pageout_cluster() instead of
->writepage(). pageout_cluster() tries to find a group of dirty pages around
target page, called "pivot" page of the cluster. If group of suitable size is
found, ->writepages() is called for it, otherwise, page_cluster() falls back
to ->writepage().

This is supposed to help in work-loads with significant page-out of
file-system pages from tail of the inactive list (for example, heavy dirtying
through mmap), because file system usually writes multiple pages more
efficiently. Should also be advantageous for file-systems doing delayed
allocation, as in this case they will allocate whole extents at once.

Few points:

 - swap-cache pages are not clustered (although they can be, but by
   page->private rather than page->index)

 - only kswapd does clustering, because direct reclaim path should be low
   latency.

 - Original version of this patch added new fields to struct writeback_control
   and expected ->writepages() to interpret them. This led to hard-to-fix races
   against inode reclamation. Current version simply calls ->writepage() in the
   "correct" order, i.e., in the order of increasing page indices.

Signed-off-by: Nikita Danilov <nikita@clusterfs.com>


 mm/shmem.c  |   14 ++++++-
 mm/vmscan.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

diff -puN mm/vmscan.c~cluster-pageout mm/vmscan.c
--- git-linux/mm/vmscan.c~cluster-pageout	2005-11-13 21:25:15.000000000 +0300
+++ git-linux-nikita/mm/vmscan.c	2005-11-13 21:25:15.000000000 +0300
@@ -360,6 +360,116 @@ static void send_page_to_kpgout(struct p
 	spin_unlock(&kpgout_queue_lock);
 }
 
+enum {
+	PAGE_CLUSTER_WING = 16,
+	PAGE_CLUSTER_SIZE = 2 * PAGE_CLUSTER_WING,
+};
+
+static int page_fits_cluster(struct address_space *mapping, struct page *page)
+{
+	int result;
+
+	if (page != NULL && !PageActive(page) && !TestSetPageLocked(page)) {
+		/*
+		 * unlock ->tree_lock to avoid lock inversion with
+		 * ->i_mmap_lock in page_referenced().
+		 */
+		read_unlock_irq(&mapping->tree_lock);
+		result =
+			/* try_to_unmap(page) == SWAP_SUCCESS && */
+			PageDirty(page) && !PageWriteback(page) &&
+			!page_referenced(page, 1,
+					 page_zone(page)->temp_priority <= 0,
+					 1);
+		if (result == 0)
+			unlock_page(page);
+		read_lock_irq(&mapping->tree_lock);
+	} else
+		result = 0;
+	return result;
+}
+
+static void call_writepage(struct page *page, struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	if (clear_page_dirty_for_io(page)) {
+		int result;
+
+		BUG_ON(!PageLocked(page));
+		BUG_ON(PageWriteback(page));
+
+		result = mapping->a_ops->writepage(page, wbc);
+		if (result == WRITEPAGE_ACTIVATE)
+			unlock_page(page);
+	}
+}
+
+int __pageout_cluster(struct page *page, struct address_space *mapping,
+		      struct writeback_control *wbc)
+{
+	int result;
+	int used;
+
+	pgoff_t punct;
+	pgoff_t start;
+	pgoff_t end;
+
+	struct page *pages_out[PAGE_CLUSTER_WING];
+	struct page *scan;
+
+	BUG_ON(PageAnon(page));
+
+	punct = page->index;
+	read_lock_irq(&mapping->tree_lock);
+	for (start = punct - 1, used = 0;
+	     start < punct && punct - start <= PAGE_CLUSTER_WING; start --) {
+		scan = radix_tree_lookup(&mapping->page_tree, start);
+		if (!page_fits_cluster(mapping, scan))
+			/*
+			 * no suitable page, stop cluster at this point
+			 */
+			break;
+		pages_out[used ++] = scan;
+		if ((start % PAGE_CLUSTER_SIZE) == 0)
+			/*
+			 * we reached aligned page.
+			 */
+			break;
+	}
+	read_unlock_irq(&mapping->tree_lock);
+
+	while (used > 0)
+		call_writepage(pages_out[--used], mapping, wbc);
+
+	result = mapping->a_ops->writepage(page, wbc);
+
+	for (end = punct + 1;
+	     end > punct && end - start < PAGE_CLUSTER_SIZE; ++ end) {
+		int enough;
+
+		/*
+		 * XXX nikita: consider find_get_pages_tag()
+		 */
+		read_lock_irq(&mapping->tree_lock);
+		scan = radix_tree_lookup(&mapping->page_tree, end);
+		enough = !page_fits_cluster(mapping, scan);
+		read_unlock_irq(&mapping->tree_lock);
+		if (enough)
+			break;
+		call_writepage(scan, mapping, wbc);
+	}
+	return result;
+}
+
+static int pageout_cluster(struct page *page, struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	if (PageSwapCache(page)	|| !current_is_kswapd())
+		return mapping->a_ops->writepage(page, wbc);
+	else
+		return __pageout_cluster(page, mapping, wbc);
+}
+
 /*
  * Called by shrink_list() for each dirty page. Calls ->writepage().
  */
@@ -445,7 +555,7 @@ static pageout_t pageout(struct page *pa
 
 		ClearPageSkipped(page);
 		SetPageReclaim(page);
-		res = mapping->a_ops->writepage(page, &wbc);
+		res = pageout_cluster(page, mapping, &wbc);
 
 		if (res < 0)
 			handle_write_error(mapping, page, res);
diff -puN include/linux/writeback.h~cluster-pageout include/linux/writeback.h
diff -puN fs/mpage.c~cluster-pageout fs/mpage.c
diff -puN mm/shmem.c~cluster-pageout mm/shmem.c
--- git-linux/mm/shmem.c~cluster-pageout	2005-11-13 21:25:15.000000000 +0300
+++ git-linux-nikita/mm/shmem.c	2005-11-13 21:25:15.000000000 +0300
@@ -45,6 +45,7 @@
 #include <linux/swapops.h>
 #include <linux/mempolicy.h>
 #include <linux/namei.h>
+#include <linux/rmap.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <asm/pgtable.h>
@@ -813,7 +814,18 @@ static int shmem_writepage(struct page *
 	struct inode *inode;
 
 	BUG_ON(!PageLocked(page));
-	BUG_ON(page_mapped(page));
+
+	/*
+	 * If shmem_writepage() is called on mapped page, a problem arises for
+	 * a tmpfs file mapped shared into different mms. Viz. shmem_writepage
+	 * changes the tmpfs-file identity of the page to swap identity: so if
+	 * it's unmapped later, the instances would then become private (to be
+	 * COWed) instead of shared.
+	 *
+	 * Just unmap page.
+	 */
+	if (page_mapped(page) && try_to_unmap(page) != SWAP_SUCCESS)
+		goto redirty;
 
 	mapping = page->mapping;
 	index = page->index;

_
