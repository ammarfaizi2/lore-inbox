Return-Path: <linux-kernel-owner+w=401wt.eu-S932583AbWLSBDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWLSBDw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 20:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWLSBDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 20:03:52 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:56176 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbWLSBDv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 20:03:51 -0500
Date: Mon, 18 Dec 2006 20:03:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19 file content corruption on ext3
In-reply-to: <1166485691.6977.6.camel@localhost>
To: linux-kernel@vger.kernel.org, andrei.popa@i-neo.ro
Cc: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Message-id: <200612182003.48277.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <1166314399.7018.6.camel@localhost>
 <Pine.LNX.4.64.0612181426390.3479@woody.osdl.org>
 <1166485691.6977.6.camel@localhost>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 18:48, Andrei Popa wrote:
>On Mon, 2006-12-18 at 14:32 -0800, Linus Torvalds wrote:
>> On Mon, 18 Dec 2006, Andrei Popa wrote:
>> > > This should be fairly easy to test: just change every single ", 1"
>> > > case in the patch to ", 0".
>> > >
>> > > What happens for you in that case?
>> >
>> > I have file corruption.
>>
>> Magic. And btw, _thanks_ for being such a great tester.
>>
>> So now I have one more thng for you to try, it you can bother:
>>
>> There's exactly two call sites that call "page_mkclean()" (an dthat is
>> the only thing in turn that calls "page_mkclean_one()", which we
>> already determined will cause the corruption).
>>
>> Both of them do
>>
>> 	if (mapping_cap_account_dirty(mapping)) {
>> 			..
>>
>> things, although they do slightly different things inside that if in
>> your patched kernel.
>>
>> Can you just TOTALLY DISABLE that case for the test_clear_page_dirty()
>> case? Just do an "#if 0 .. #endif" around that whole if-statement,
>> leaving the _only_ thing that actually calls "page_mkclean()" to be
>> the "clear_page_dirty_for_io()" call.
>>
>> Do you still see corruption?
>
>nope, no file corruption at all.
>
Goody I says to nobody in particular, I'll go build this...
>
>diff --git a/fs/buffer.c b/fs/buffer.c
>index d1f1b54..263f88e 100644
>--- a/fs/buffer.c
>+++ b/fs/buffer.c
>@@ -2834,7 +2834,7 @@ int try_to_free_buffers(struct page *pag
> 	int ret = 0;
>
> 	BUG_ON(!PageLocked(page));
>-	if (PageWriteback(page))
>+	if (PageDirty(page) || PageWriteback(page))
> 		return 0;
>
> 	if (mapping == NULL) {		/* can this still happen? */
>@@ -2845,22 +2845,6 @@ int try_to_free_buffers(struct page *pag
> 	spin_lock(&mapping->private_lock);
> 	ret = drop_buffers(page, &buffers_to_free);
> 	spin_unlock(&mapping->private_lock);
>-	if (ret) {
>-		/*
>-		 * If the filesystem writes its buffers by hand (eg ext3)
>-		 * then we can have clean buffers against a dirty page.  We
>-		 * clean the page here; otherwise later reattachment of buffers
>-		 * could encounter a non-uptodate page, which is unresolvable.
>-		 * This only applies in the rare case where try_to_free_buffers
>-		 * succeeds but the page is not freed.
>-		 *
>-		 * Also, during truncate, discard_buffer will have marked all
>-		 * the page's buffers clean.  We discover that here and clean
>-		 * the page also.
>-		 */
>-		if (test_clear_page_dirty(page))
>-			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
>-	}
> out:
> 	if (buffers_to_free) {
> 		struct buffer_head *bh = buffers_to_free;
>diff --git a/fs/cifs/file.c b/fs/cifs/file.c
>index 0f05cab..2d8bbbb 100644
>--- a/fs/cifs/file.c
>+++ b/fs/cifs/file.c
>@@ -1245,7 +1245,7 @@ retry:
> 				wait_on_page_writeback(page);
>
> 			if (PageWriteback(page) ||
>-					!test_clear_page_dirty(page)) {
>+					!test_clear_page_dirty(page, 0)) {
> 				unlock_page(page);
> 				break;
> 			}
>diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>index 1387749..da2bdb1 100644
>--- a/fs/fuse/file.c
>+++ b/fs/fuse/file.c
>@@ -484,7 +484,7 @@ static int fuse_commit_write(struct file
> 		spin_unlock(&fc->lock);
>
> 		if (offset == 0 && to == PAGE_CACHE_SIZE) {
>-			clear_page_dirty(page);
>+			clear_page_dirty(page, 0);
> 			SetPageUptodate(page);
> 		}
> 	}
>diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>index ed2c223..9f82cd0 100644
>--- a/fs/hugetlbfs/inode.c
>+++ b/fs/hugetlbfs/inode.c
>@@ -176,7 +176,7 @@ static int hugetlbfs_commit_write(struct
>
> static void truncate_huge_page(struct page *page)
> {
>-	clear_page_dirty(page);
>+	clear_page_dirty(page, 0);
> 	ClearPageUptodate(page);
> 	remove_from_page_cache(page);
> 	put_page(page);
>diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
>index b1a1c72..5e29b37 100644
>--- a/fs/jfs/jfs_metapage.c
>+++ b/fs/jfs/jfs_metapage.c
>@@ -773,7 +773,7 @@ #if MPS_PER_PAGE == 1
>
> 	/* Retest mp->count since we may have released page lock */
> 	if (test_bit(META_discard, &mp->flag) && !mp->count) {
>-		clear_page_dirty(page);
>+		clear_page_dirty(page, 0);
> 		ClearPageUptodate(page);
> 	}
> #else
>diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
>index 47e7027..a97e198 100644
>--- a/fs/reiserfs/stree.c
>+++ b/fs/reiserfs/stree.c
>@@ -1459,7 +1459,7 @@ static void unmap_buffers(struct page *p
> 				bh = next;
> 			} while (bh != head);
> 			if (PAGE_SIZE == bh->b_size) {
>-				clear_page_dirty(page);
>+				clear_page_dirty(page, 0);
> 			}
> 		}
> 	}
>diff --git a/fs/xfs/linux-2.6/xfs_aops.c b/fs/xfs/linux-2.6/xfs_aops.c
>index b56eb75..44ac434 100644
>--- a/fs/xfs/linux-2.6/xfs_aops.c
>+++ b/fs/xfs/linux-2.6/xfs_aops.c
>@@ -343,7 +343,7 @@ xfs_start_page_writeback(
> 	ASSERT(!PageWriteback(page));
> 	set_page_writeback(page);
> 	if (clear_dirty)
>-		clear_page_dirty(page);
>+		clear_page_dirty(page, 0);
> 	unlock_page(page);
> 	if (!buffers) {
> 		end_page_writeback(page);
>diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>index 4830a3b..175ab3c 100644
>--- a/include/linux/page-flags.h
>+++ b/include/linux/page-flags.h
>@@ -253,13 +253,13 @@ #define ClearPageUncached(page)	clear_bi
>
> struct page;	/* forward declaration */
>
>-int test_clear_page_dirty(struct page *page);
>+int test_clear_page_dirty(struct page *page, int must_clean_ptes);
> int test_clear_page_writeback(struct page *page);
> int test_set_page_writeback(struct page *page);
>
>-static inline void clear_page_dirty(struct page *page)
>+static inline void clear_page_dirty(struct page *page, int
>must_clean_ptes)
above looks wrapped to me so I fixed it to one line
> {
>-	test_clear_page_dirty(page);
>+	test_clear_page_dirty(page, must_clean_ptes);
> }
>
> static inline void set_page_writeback(struct page *page)
>diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>index 237107c..f2a157d 100644
>--- a/mm/page-writeback.c
>+++ b/mm/page-writeback.c
>@@ -848,7 +848,7 @@ EXPORT_SYMBOL(set_page_dirty_lock);
>  * Clear a page's dirty flag, while caring for dirty memory
>accounting.
Likewise here, malformed patch otherwise
>  * Returns true if the page was previously dirty.
>  */
>-int test_clear_page_dirty(struct page *page)
>+int test_clear_page_dirty(struct page *page, int must_clean_ptes)
> {
> 	struct address_space *mapping = page_mapping(page);
> 	unsigned long flags;
>@@ -857,6 +857,8 @@ int test_clear_page_dirty(struct page *p
> 		return TestClearPageDirty(page);
>
> 	write_lock_irqsave(&mapping->tree_lock, flags);
>+
>+#if 0
> 	if (TestClearPageDirty(page)) {
> 		radix_tree_tag_clear(&mapping->page_tree,
> 				page_index(page), PAGECACHE_TAG_DIRTY);
>@@ -866,11 +868,19 @@ int test_clear_page_dirty(struct page *p
> 		 * page is locked, which pins the address_space
> 		 */
> 		if (mapping_cap_account_dirty(mapping)) {
>-			page_mkclean(page);
>+			int cleaned = page_mkclean(page);
>+			if (!must_clean_ptes && cleaned){
>+			WARN_ON(1);
>+			set_page_dirty(page);
>+			}
>+
> 			dec_zone_page_state(page, NR_FILE_DIRTY);
> 		}
> 		return 1;
> 	}
>+
>+#endif
>+
> 	write_unlock_irqrestore(&mapping->tree_lock, flags);
> 	return 0;
> }
>diff --git a/mm/rmap.c b/mm/rmap.c
>diff --git a/mm/truncate.c b/mm/truncate.c
>index 9bfb8e8..9a01d9e 100644
>--- a/mm/truncate.c
>+++ b/mm/truncate.c
>@@ -70,7 +70,7 @@ truncate_complete_page(struct address_sp
> 	if (PagePrivate(page))
> 		do_invalidatepage(page, 0);
>
>-	if (test_clear_page_dirty(page))
>+	if (test_clear_page_dirty(page, 0))
> 		task_io_account_cancelled_write(PAGE_CACHE_SIZE);
> 	ClearPageUptodate(page);
> 	ClearPageMappedToDisk(page);
>@@ -386,7 +386,7 @@ int invalidate_inode_pages2_range(struct
> 					  PAGE_CACHE_SIZE, 0);
> 				}
> 			}
>-			was_dirty = test_clear_page_dirty(page);
>+			was_dirty = test_clear_page_dirty(page, 0);
> 			if (!invalidate_complete_page2(mapping, page)) {
> 				if (was_dirty)
> 					set_page_dirty(page);
>
I think I must have screwed the moose.  Following along in this thread, 
I'd patched things back and forth till I figured I'd better do a fresh 
tree, so starting with the full 2.6.19 tarball, I applied the 2.6.20-rc1 
patch, then the above patch, which should be the only thing different 
from what I'm running right now, which is the commented line in rmap.c, 
otherwise as it unpacked.

But:
In file included from include/linux/mm.h:230,
                 from include/linux/rmap.h:10,
                 from init/main.c:47:
include/linux/page-flags.h:260: error: expected declaration specifiers 
or ‘...’ before ‘in’
include/linux/page-flags.h: In function ‘clear_page_dirty’:
include/linux/page-flags.h:262: error: ‘must_clean_ptes’ undeclared (first 
use in this function)
include/linux/page-flags.h:262: error: (Each undeclared identifier is 
reported only once
include/linux/page-flags.h:262: error: for each function it appears in.)
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

There were 2 places where this patch is word wrapped, and this was one of 
them:

-static inline void clear_page_dirty(struct page *page)
+static inline void clear_page_dirty(struct page *page, int
must_clean_ptes)

The other one was in a comment, which screwed the patch and needed fixed 
too.  Is it fubared someplace else I missed?  Or am I in fact being 
bitten by this bug?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
