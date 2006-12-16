Return-Path: <linux-kernel-owner+w=401wt.eu-S1753794AbWLPVaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbWLPVaM (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 16:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbWLPVaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 16:30:12 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:56994 "EHLO
	amsfep11-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753794AbWLPVaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 16:30:10 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: Martin Michlmayr <tbm@cyrius.com>,
       Marc Haber <mh+linux-kernel@zugschlus.de>, Jan Kara <jack@suse.cz>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612161909460.25272@blonde.wat.veritas.com>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
	 <4578465D.7030104@cfl.rr.com>
	 <20061209092639.GA15443@torres.l21.ma.zugschlus.de>
	 <20061216184310.GA891@unjust.cyrius.com>
	 <Pine.LNX.4.64.0612161909460.25272@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 22:29:41 +0100
Message-Id: <1166304581.10372.18.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-16 at 19:18 +0000, Hugh Dickins wrote:
> On Sat, 16 Dec 2006, Martin Michlmayr wrote:
> > * Marc Haber <mh+linux-kernel@zugschlus.de> [2006-12-09 10:26]:
> > > Unfortunately, I am lacking the knowledge needed to do this in an
> > > informed way. I am neither familiar enough with git nor do I possess
> > > the necessary C powers.
> > 
> > I wonder if what you're seein is related to
> > http://lkml.org/lkml/2006/12/16/73
> > 
> > You said that you don't see any corruption with 2.6.18.  Can you try
> > to apply the patch from
> > http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d08b3851da41d0ee60851f2c75b118e1f7a5fc89
> > to 2.6.18 to see if the corruption shows up?
> 
> I did wonder about the very first hunk of Peter's patch, where the
> mapping->private_lock is unlocked earlier now in try_to_free_buffers,
> before the clear_page_dirty.  I'm not at all familiar with that area,
> I wonder if Jan has looked at that change, and might be able to say
> whether it's good or not (earlier he worried about his JBD changes,
> but they wouldn't be implicated if just 2.6.18+Peter's gives trouble).

fs/buffers.c:2775

/*
 * try_to_free_buffers() checks if all the buffers on this particular page
 * are unused, and releases them if so.
 *
 * Exclusion against try_to_free_buffers may be obtained by either
 * locking the page or by holding its mapping's private_lock.
 *
 * If the page is dirty but all the buffers are clean then we need to
 * be sure to mark the page clean as well.  This is because the page
 * may be against a block device, and a later reattachment of buffers
 * to a dirty page will set *all* buffers dirty.  Which would corrupt
 * filesystem data on the same device.
 *
 * The same applies to regular filesystem pages: if all the buffers are
 * clean then we set the page clean and proceed.  To do that, we require
 * total exclusion from __set_page_dirty_buffers().  That is obtained with
 * private_lock.
 *
 * try_to_free_buffers() is non-blocking.
 */

Note the 3th paragraph. Would I have opened up a race by moving that
unlock upwards, such that it is possible to re-attach buffers to the
page before having it marked clean; which according to this text will
mark those buffers dirty and cause data corruption?

Hmm, how to go about something like this:

---
Moving the cleaning of the page out from under the private_lock opened
up a window where newly attached buffer might still see the page dirty
status and were thus marked (incorrectly) dirty themselves; resulting in
filesystem data corruption.

Close this by moving the cleaning of the page inside of the private_lock
scope again. However it is not possible to call page_mkclean() from
within the private_lock (this violates locking order); thus introduce a
variant of test_clear_page_dirty() that does not call page_mkclean() and
call it ourselves when we did do clean the page and call it outside of
the private_lock.

This is still safe because the page is still locked by means of
PG_locked.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/buffer.c                |   11 +++++++++--
 include/linux/page-flags.h |    1 +
 mm/page-writeback.c        |   10 ++++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

Index: linux-2.6-git/fs/buffer.c
===================================================================
--- linux-2.6-git.orig/fs/buffer.c	2006-12-16 22:18:24.000000000 +0100
+++ linux-2.6-git/fs/buffer.c	2006-12-16 22:22:17.000000000 +0100
@@ -42,6 +42,7 @@
 #include <linux/bitops.h>
 #include <linux/mpage.h>
 #include <linux/bit_spinlock.h>
+#include <linux/rmap.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void invalidate_bh_lrus(void);
@@ -2832,6 +2833,7 @@ int try_to_free_buffers(struct page *pag
 	struct address_space * const mapping = page->mapping;
 	struct buffer_head *buffers_to_free = NULL;
 	int ret = 0;
+	int must_clean = 0;
 
 	BUG_ON(!PageLocked(page));
 	if (PageWriteback(page))
@@ -2844,7 +2846,6 @@ int try_to_free_buffers(struct page *pag
 
 	spin_lock(&mapping->private_lock);
 	ret = drop_buffers(page, &buffers_to_free);
-	spin_unlock(&mapping->private_lock);
 	if (ret) {
 		/*
 		 * If the filesystem writes its buffers by hand (eg ext3)
@@ -2858,9 +2859,15 @@ int try_to_free_buffers(struct page *pag
 		 * the page's buffers clean.  We discover that here and clean
 		 * the page also.
 		 */
-		if (test_clear_page_dirty(page))
+		if (__test_clear_page_dirty(page, 0)) {
 			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
+			if (mapping_cap_account_dirty(mapping))
+				must_clean = 1;
+		}
 	}
+	spin_unlock(&mapping->private_lock);
+	if (must_clean)
+		page_mkclean(page);
 out:
 	if (buffers_to_free) {
 		struct buffer_head *bh = buffers_to_free;
Index: linux-2.6-git/include/linux/page-flags.h
===================================================================
--- linux-2.6-git.orig/include/linux/page-flags.h	2006-12-16 22:19:56.000000000 +0100
+++ linux-2.6-git/include/linux/page-flags.h	2006-12-16 22:20:07.000000000 +0100
@@ -253,6 +253,7 @@ static inline void SetPageUptodate(struc
 
 struct page;	/* forward declaration */
 
+int __test_clear_page_dirty(struct page *page, int do_clean);
 int test_clear_page_dirty(struct page *page);
 int test_clear_page_writeback(struct page *page);
 int test_set_page_writeback(struct page *page);
Index: linux-2.6-git/mm/page-writeback.c
===================================================================
--- linux-2.6-git.orig/mm/page-writeback.c	2006-12-16 22:18:18.000000000 +0100
+++ linux-2.6-git/mm/page-writeback.c	2006-12-16 22:19:42.000000000 +0100
@@ -854,7 +854,7 @@ EXPORT_SYMBOL(set_page_dirty_lock);
  * Clear a page's dirty flag, while caring for dirty memory accounting. 
  * Returns true if the page was previously dirty.
  */
-int test_clear_page_dirty(struct page *page)
+int __test_clear_page_dirty(struct page *page, int do_clean)
 {
 	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
@@ -872,7 +872,8 @@ int test_clear_page_dirty(struct page *p
 		 * page is locked, which pins the address_space
 		 */
 		if (mapping_cap_account_dirty(mapping)) {
-			page_mkclean(page);
+			if (do_clean)
+				page_mkclean(page);
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 		}
 		return 1;
@@ -880,6 +881,11 @@ int test_clear_page_dirty(struct page *p
 	write_unlock_irqrestore(&mapping->tree_lock, flags);
 	return 0;
 }
+
+int test_clear_page_dirty(struct page *page)
+{
+	return __test_clear_page_dirty(page, 1);
+}
 EXPORT_SYMBOL(test_clear_page_dirty);
 
 /*


