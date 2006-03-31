Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWCaMlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWCaMlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWCaMlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:41:45 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:24409 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1751369AbWCaMlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:41:44 -0500
Date: Fri, 31 Mar 2006 14:41:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: [andrea@suse.de: Re: [NFS] Problems with mmap consistency]
Message-ID: <20060331124141.GC18093@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just a reminder, the below patch should be applied to mainline (it's
still missing according to my log).

Thanks.

----- Forwarded message from Andrea Arcangeli <andrea@suse.de> -----

Date: Fri, 24 Feb 2006 05:01:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, nfs@lists.sourceforge.net
Subject: Re: [NFS] Problems with mmap consistency

Hello, 

On Fri, Feb 17, 2006 at 10:15:30AM -0500, Trond Myklebust wrote:
> On Fri, 2006-02-17 at 11:57 +0100, Olaf Kirch wrote:
> > It seems the problem is that there is still a fairly big race window
> > in this code - after unmap_mapping_range returns, we're waiting for
> > all dirty pages to be flushed to the server. A lot can happen while
> > we wait - for instance, some other process may modify a page that
> > has already been written. This modification will be lost during
> > the subsequent invalidate_inode_pages2 call.
> > 
> > Is there a simple VM mechanism that could be used to prevent this,
> > or does it need some extra logic to block a process in nfs_readpage
> > while we're revalidating?
> 
> No. I believe I have discussed this with Andrea and others before.

Yep.

> We need to add a VM helper that will invalidate the page cache and flush
> dirty pages atomically (such a thing does not yet exist).

Such thing will hardly exist if page faults can mark pages dirty at any
time mostly lockless. Things may change for the better if we start
taking the page lock in do_no_page but I doubt we'll serialize
atomically against the whole disk-bound fdatawriteandwait.

I think it's enough to make invalidate_inode_pages2 non destructive.
Then we can wonder if we should join
unmap_mapping*+fdatasyncandwait+invalidate_inode_pages2 in a single
function (so they look more atomic even if they're not internally), or
something like that, but currently there are reasons why they're split
(notably O_DIRECT needs the invalidate only for writes, for o_direct
reads not).

If a buffered write happens at the same time of a direct write and it's
making pages dirty again after our fdatasyncandwait, there's no
guarantee anyway because the two syscalls are parallel. So I guess we
could just change invalidate_inode_pages2 not to be destructive, then
the race will go away, and an nfs invalidate won't nuke the newly
written data anymore (even if the newly written data is written between
the fdatasyncwait and invalidate_inode_pages2).

Basically this way dirty pages gets higher prio, and they can't be
dropped anymore. They can only be flushed safely to disk. That's enough
for O_DIRECT coherency protocol and it should fix nfs.

I seem to remember I asked explanations on the "was_dirty" code in my
first email on the subject (before noticing you also worked on the nfs
part about at the same time ;), but I didn't get any answer.

I didn't check if this fixes the testcase, patch still untested sorry.

Thanks.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

Index: sp3/mm/truncate.c
--- sp3/mm/truncate.c.~1~	2006-02-23 06:31:14.000000000 +0100
+++ sp3/mm/truncate.c	2006-02-24 04:36:02.000000000 +0100
@@ -246,9 +246,14 @@ EXPORT_SYMBOL(invalidate_inode_pages);
  * @start: the page offset 'from' which to invalidate
  * @end: the page offset 'to' which to invalidate (inclusive)
  * Any pages which are found to be mapped into pagetables are unmapped prior to
- * invalidation.
+ * invalidation. invalidate_inode_pages2_range is non destructive and it can't
+ * lose dirty data (if dirty data exists -EIO will be returned). It's up to
+ * the caller to call unmap_mapping_range and filemap_write_and_wait before
+ * invalidate_inode_pages2 if needed.
  *
- * Returns -EIO if any pages could not be invalidated.
+ * Returns -EIO if any pages could not be invalidated. Before returning -EIO
+ * it tries invalidating all pages in the range, it doesn't stop at the first
+ * page invalidation failure.
  */
 int invalidate_inode_pages2_range(struct address_space *mapping,
 			pgoff_t start, pgoff_t end)
@@ -262,13 +267,12 @@ int invalidate_inode_pages2_range(struct
 
 	pagevec_init(&pvec, 0);
 	next = start;
-	while (next <= end && !ret && !wrapped &&
+	while (next <= end && !wrapped &&
 		pagevec_lookup(&pvec, mapping, next,
 			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
-		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
+		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			pgoff_t page_index;
-			int was_dirty;
 
 			lock_page(page);
 			if (page->mapping != mapping) {
@@ -304,12 +308,9 @@ int invalidate_inode_pages2_range(struct
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
-			was_dirty = test_clear_page_dirty(page);
-			if (!invalidate_complete_page(mapping, page)) {
-				if (was_dirty)
-					set_page_dirty(page);
+
+			if (!invalidate_complete_page(mapping, page))
 				ret = -EIO;
-			}
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);

----- End forwarded message -----
