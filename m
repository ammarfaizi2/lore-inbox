Return-Path: <linux-kernel-owner+w=401wt.eu-S1753238AbWLQXkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbWLQXkt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 18:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbWLQXkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 18:40:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40969 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238AbWLQXks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 18:40:48 -0500
Date: Sun, 17 Dec 2006 15:40:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrei.popa@i-neo.ro
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061217154026.219b294f.akpm@osdl.org>
In-Reply-To: <1166362772.8593.2.camel@localhost>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006 15:39:32 +0200
Andrei Popa <andrei.popa@i-neo.ro> wrote:

> I was mistaken, I'm still having file corruption with rtorrent.
> 

Well I'm not very optimistic, but if people could try this, please...



From: Andrew Morton <akpm@osdl.org>

try_to_free_buffers() clears the page's dirty state if it successfully removed
the page's buffers.

  Background for this:

  - a process does a one-byte-write to a file on a 64k pagesize, 4k
    blocksize ext3 filesystem.  The page is now PageDirty, !PgeUptodate and
    has one dirty buffer and 15 not uptodate buffers.

  - kjournald writes the dirty buffer.  The page is now PageDirty,
    !PageUptodate and has a mix of clean and not uptodate buffers.

  - try_to_free_buffers() removes the page's buffers.  It MUST now clear
    PageDirty.  If we were to leave the page dirty then we'd have a dirty, not
    uptodate page with no buffer_heads.

    We're screwed: we cannot write the page because we don't know which
    sections of it contain garbage.  We cannot read the page because we don't
    know which sections of it contain modified data.  We cannot free the page
    because it is dirty.


Peter's "mm: tracking shared dirty pages"
(d08b3851da41d0ee60851f2c75b118e1f7a5fc89) modified clear_page_dirty() so that
it also clears the page's pte mapping's dirty flags, arranging for a
subsequent userspace modification of the page to cause a fault.

That change to clear_page_dirty() was correct for when it is called on the
writeback path.  Here, we effectively do:

	ClearPageDirty()
	pte_mkclean()
	submit-the-writeout

if a page-dirtying via write() or via pte's happens after the ClearPageDirty()
or the pte_mkclean() then the page is redirtied while writeout is in flight
and the page will again need writing; no probs.

But that change to clear_page_dirty() was incorrect for when it is called on
the try_to_free_buffers() path.  Here, we want to preserve any pte-dirtiness
because we're not going to write the page to backing store.  We need to keep
a record of any userspace modification to the page.

One way of addressing this would be to bale from try_to_free_buffers() if the
page is mapped into pagetables.  However that is racy, because the pagefault
path doesn't lock the page when establishing a pte against it (I which it did
- it would solve a lot of nasties).

So this patch instead arranges for clear_page_dirty() to not clean the pte's
when it is called on the try_to_free_buffers() path.

clear_page_dirty() had several callers and it's not immediately obvious to me
what the appropriate behaviour is in each case.  Could maintainers please take
a look?

>From my quick reading, all callers of try_to_free_buffers() have already
unmapped the page from pagetables, and given that the reported ext3 corruption
happens on uniprocessor, non-preempt kernels, I doubt if this patch will fix
things.

But even if it is true that try_to_free_buffers() callers unmap the page
first, this fix is still needed, because a minor fault could reestablish pte's
in the meanwhile.

Note that with this change, we can now restore try_to_free_buffers()'s
->private_lock to cover the test_clear_page_dirty().  If we indeed need to do
that, it'll be in a separate patch.

(Need to think about this some more.  How can a page be pte-dirty, but not
have dirty buffers?  We're supposed to clean the pte's when we write the
page, and we dirty the page and buffers when userspace dirties the pte...)


Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: <reiserfs-dev@namesys.com>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: David Chinner <dgc@sgi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/buffer.c                 |    2 +-
 fs/cifs/file.c              |    2 +-
 fs/fuse/file.c              |    2 +-
 fs/hugetlbfs/inode.c        |    2 +-
 fs/jfs/jfs_metapage.c       |    2 +-
 fs/reiserfs/stree.c         |    2 +-
 fs/xfs/linux-2.6/xfs_aops.c |    2 +-
 include/linux/page-flags.h  |    6 +++---
 mm/page-writeback.c         |    5 +++--
 mm/truncate.c               |    4 ++--
 10 files changed, 15 insertions(+), 14 deletions(-)

diff -puN fs/buffer.c~try_to_free_buffers-dont-clear-pte-dirty-bits fs/buffer.c
--- a/fs/buffer.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/fs/buffer.c
@@ -2858,7 +2858,7 @@ int try_to_free_buffers(struct page *pag
 		 * the page's buffers clean.  We discover that here and clean
 		 * the page also.
 		 */
-		if (test_clear_page_dirty(page))
+		if (test_clear_page_dirty(page, 0))
 			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
 	}
 out:
diff -puN fs/fuse/file.c~try_to_free_buffers-dont-clear-pte-dirty-bits fs/fuse/file.c
--- a/fs/fuse/file.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/fs/fuse/file.c
@@ -484,7 +484,7 @@ static int fuse_commit_write(struct file
 		spin_unlock(&fc->lock);
 
 		if (offset == 0 && to == PAGE_CACHE_SIZE) {
-			clear_page_dirty(page);
+			clear_page_dirty(page, 0);
 			SetPageUptodate(page);
 		}
 	}
diff -puN fs/hugetlbfs/inode.c~try_to_free_buffers-dont-clear-pte-dirty-bits fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/fs/hugetlbfs/inode.c
@@ -176,7 +176,7 @@ static int hugetlbfs_commit_write(struct
 
 static void truncate_huge_page(struct page *page)
 {
-	clear_page_dirty(page);
+	clear_page_dirty(page, 1);
 	ClearPageUptodate(page);
 	remove_from_page_cache(page);
 	put_page(page);
diff -puN fs/jfs/jfs_metapage.c~try_to_free_buffers-dont-clear-pte-dirty-bits fs/jfs/jfs_metapage.c
--- a/fs/jfs/jfs_metapage.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/fs/jfs/jfs_metapage.c
@@ -773,7 +773,7 @@ void release_metapage(struct metapage * 
 
 	/* Retest mp->count since we may have released page lock */
 	if (test_bit(META_discard, &mp->flag) && !mp->count) {
-		clear_page_dirty(page);
+		clear_page_dirty(page, 1);
 		ClearPageUptodate(page);
 	}
 #else
diff -puN fs/reiserfs/stree.c~try_to_free_buffers-dont-clear-pte-dirty-bits fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/fs/reiserfs/stree.c
@@ -1459,7 +1459,7 @@ static void unmap_buffers(struct page *p
 				bh = next;
 			} while (bh != head);
 			if (PAGE_SIZE == bh->b_size) {
-				clear_page_dirty(page);
+				clear_page_dirty(page, 0);
 			}
 		}
 	}
diff -puN fs/xfs/linux-2.6/xfs_aops.c~try_to_free_buffers-dont-clear-pte-dirty-bits fs/xfs/linux-2.6/xfs_aops.c
--- a/fs/xfs/linux-2.6/xfs_aops.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/fs/xfs/linux-2.6/xfs_aops.c
@@ -343,7 +343,7 @@ xfs_start_page_writeback(
 	ASSERT(!PageWriteback(page));
 	set_page_writeback(page);
 	if (clear_dirty)
-		clear_page_dirty(page);
+		clear_page_dirty(page, 1);
 	unlock_page(page);
 	if (!buffers) {
 		end_page_writeback(page);
diff -puN include/linux/page-flags.h~try_to_free_buffers-dont-clear-pte-dirty-bits include/linux/page-flags.h
--- a/include/linux/page-flags.h~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/include/linux/page-flags.h
@@ -253,13 +253,13 @@ static inline void SetPageUptodate(struc
 
 struct page;	/* forward declaration */
 
-int test_clear_page_dirty(struct page *page);
+int test_clear_page_dirty(struct page *page, int must_clean_ptes);
 int test_clear_page_writeback(struct page *page);
 int test_set_page_writeback(struct page *page);
 
-static inline void clear_page_dirty(struct page *page)
+static inline void clear_page_dirty(struct page *page, int must_clean_ptes)
 {
-	test_clear_page_dirty(page);
+	test_clear_page_dirty(page, must_clean_ptes);
 }
 
 static inline void set_page_writeback(struct page *page)
diff -puN mm/page-writeback.c~try_to_free_buffers-dont-clear-pte-dirty-bits mm/page-writeback.c
--- a/mm/page-writeback.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/mm/page-writeback.c
@@ -848,7 +848,7 @@ EXPORT_SYMBOL(set_page_dirty_lock);
  * Clear a page's dirty flag, while caring for dirty memory accounting. 
  * Returns true if the page was previously dirty.
  */
-int test_clear_page_dirty(struct page *page)
+int test_clear_page_dirty(struct page *page, int must_clean_ptes)
 {
 	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
@@ -866,7 +866,8 @@ int test_clear_page_dirty(struct page *p
 		 * page is locked, which pins the address_space
 		 */
 		if (mapping_cap_account_dirty(mapping)) {
-			page_mkclean(page);
+			if (must_clean_ptes)
+				page_mkclean(page);
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 		}
 		return 1;
diff -puN mm/truncate.c~try_to_free_buffers-dont-clear-pte-dirty-bits mm/truncate.c
--- a/mm/truncate.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/mm/truncate.c
@@ -70,7 +70,7 @@ truncate_complete_page(struct address_sp
 	if (PagePrivate(page))
 		do_invalidatepage(page, 0);
 
-	if (test_clear_page_dirty(page))
+	if (test_clear_page_dirty(page, 1))
 		task_io_account_cancelled_write(PAGE_CACHE_SIZE);
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
@@ -386,7 +386,7 @@ int invalidate_inode_pages2_range(struct
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
-			was_dirty = test_clear_page_dirty(page);
+			was_dirty = test_clear_page_dirty(page, 0);
 			if (!invalidate_complete_page2(mapping, page)) {
 				if (was_dirty)
 					set_page_dirty(page);
diff -puN fs/cifs/file.c~try_to_free_buffers-dont-clear-pte-dirty-bits fs/cifs/file.c
--- a/fs/cifs/file.c~try_to_free_buffers-dont-clear-pte-dirty-bits
+++ a/fs/cifs/file.c
@@ -1245,7 +1245,7 @@ retry:
 				wait_on_page_writeback(page);
 
 			if (PageWriteback(page) ||
-					!test_clear_page_dirty(page)) {
+					!test_clear_page_dirty(page, 1)) {
 				unlock_page(page);
 				break;
 			}
_

