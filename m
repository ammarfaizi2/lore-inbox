Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272918AbTHPN6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 09:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272921AbTHPN6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 09:58:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55779 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S272918AbTHPN6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 09:58:30 -0400
Date: Sat, 16 Aug 2003 15:00:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: "Sergey S. Kostyliov" <rathamahata@php4.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre6aa1
In-Reply-To: <Pine.LNX.4.44.0308161339160.1236-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0308161456170.1284-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003, Hugh Dickins wrote:
> 
> Or, as in the patch Sergey is currently testing below, shmem_truncate
> must be prepared to truncate_inode_pages again.  That's the approach
> I originally implemented in 2.5, but I grew disgusted with it every
> time I thought of partial truncation trundling twice through
> truncate_inode_pages (it can easily be avoided when nrpages == 0,
> but that's unlikely in partial truncation).
> 
> So VM_PAGEIN flag stuff to restrict it to when it might be necessary;
> extended to cover other races when reading the page at the same time
> as truncating (though I think generic_file_read has a window of this
> kind that we've never worried about).  I expect to split the patch
> into several before sending Marcelo and Andrew.

And here is the patch I claimed to be below.
If you apply it to anything other than 2.4.22-pre6aa1,
please be careful to check that it has applied correctly.
Originally I made a patch against 2.4.22-pre6, and then applied to
2.4.22-pre6aa1: but I have never seen patch make such a mess of it!

Hugh

--- 2.4.22-pre6aa1/mm/shmem.c	Thu Jul 31 15:23:58 2003
+++ linux/mm/shmem.c	Mon Aug 11 21:00:55 2003
@@ -92,6 +92,9 @@
 
 #define VM_ACCT(size)    (PAGE_CACHE_ALIGN(size) >> PAGE_SHIFT)
 
+/* info->flags needs a VM_flag to handle pagein/truncate race efficiently */
+#define VM_PAGEIN	 VM_READ
+
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
 
@@ -435,6 +438,18 @@
 
 	BUG_ON(info->swapped > info->next_index);
 	spin_unlock(&info->lock);
+
+	if (inode->i_mapping->nrpages && (info->flags & VM_PAGEIN)) {
+		/*
+		 * Call truncate_inode_pages again: racing shmem_unuse_inode
+		 * may have swizzled a page in from swap since vmtruncate or
+		 * generic_delete_inode did it, before we lowered next_index.
+		 * Also, though shmem_getpage checks i_size before adding to
+		 * cache, no recheck after: so fix the narrow window there too.
+		 */
+		truncate_inode_pages(inode->i_mapping, inode->i_size);
+	}
+
 	if (freed)
 		shmem_free_blocks(inode, freed);
 }
@@ -459,6 +474,19 @@
 					attr->ia_size>>PAGE_CACHE_SHIFT,
 						&page, SGP_READ);
 			}
+			/*
+			 * Reset VM_PAGEIN flag so that shmem_truncate can
+			 * detect if any pages might have been added to cache
+			 * after truncate_inode_pages.  But we needn't bother
+			 * if it's being fully truncated to zero-length: the
+			 * nrpages check is efficient enough in that case.
+			 */
+			if (attr->ia_size) {
+				struct shmem_inode_info *info = SHMEM_I(inode);
+				spin_lock(&info->lock);
+				info->flags &= ~VM_PAGEIN;
+				spin_unlock(&info->lock);
+			}
 		}
 	}
 
@@ -511,7 +539,6 @@
 	struct address_space *mapping;
 	swp_entry_t *ptr;
 	unsigned long idx;
-	unsigned long limit;
 	int offset;
 
 	idx = 0;
@@ -543,13 +570,9 @@
 	inode = info->inode;
 	mapping = inode->i_mapping;
 	delete_from_swap_cache(page);
-
-	/* Racing against delete or truncate? Must leave out of page cache */
-	limit = (inode->i_state & I_FREEING)? 0:
-		(inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-
-	if (idx >= limit || add_to_page_cache_unique(page,
-			mapping, idx, page_hash(mapping, idx)) == 0) {
+	if (add_to_page_cache_unique(page,
+		 	mapping, idx, page_hash(mapping, idx)) == 0) {
+		info->flags |= VM_PAGEIN;
 		ptr[offset].val = 0;
 		info->swapped--;
 	} else if (add_to_swap_cache(page, entry) != 0)
@@ -634,6 +657,7 @@
 		 * Add page back to page cache, unref swap, try again.
 		 */
 		add_to_page_cache_locked(page, mapping, index);
+		info->flags |= VM_PAGEIN;
 		spin_unlock(&info->lock);
 		swap_free(swap);
 		goto getswap;
@@ -809,6 +833,7 @@
 			swap_free(swap);
 		} else if (add_to_page_cache_unique(swappage,
 			mapping, idx, page_hash(mapping, idx)) == 0) {
+			info->flags |= VM_PAGEIN;
 			entry->val = 0;
 			info->swapped--;
 			spin_unlock(&info->lock);
@@ -868,6 +893,7 @@
 					goto failed;
 				goto repeat;
 			}
+			info->flags |= VM_PAGEIN;
 		}
 
 		spin_unlock(&info->lock);

