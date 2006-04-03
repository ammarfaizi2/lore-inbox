Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWDCAGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWDCAGV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 20:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWDCAGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 20:06:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23940 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751149AbWDCAGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 20:06:21 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 10:04:27 +1000
Message-ID: <17456.26251.867865.263872@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       trond.myklebust@fys.uio.no
Subject: Re: [andrea@suse.de: Re: [NFS] Problems with mmap consistency]
In-Reply-To: message from Andrew Morton on Saturday April 1
References: <20060331124141.GC18093@opteron.random>
	<20060401205522.76f300c5.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Saturday April 1, akpm@osdl.org wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > Hello,
> > 
> > Just a reminder, the below patch should be applied to mainline (it's
> > still missing according to my log).
> > 
> 
> There's basically no description of what the patch does here.  Patches
> which turn up in the middle of an email discussion tend to not get applied.
> Normally someone will send a new patch with a reworked description once the
> discussion has come to a conclusion.

I'll give it a go.  See below.

> 
> > 
> > I seem to remember I asked explanations on the "was_dirty" code in my
> > first email on the subject (before noticing you also worked on the nfs
> > part about at the same time ;), but I didn't get any answer.
> 
> It's all there in bk somewhere ;)
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm1/broken-out/invalidate_inode_pages-mmap-coherency-fix.patch
> 
> > I didn't check if this fixes the testcase, patch still untested sorry.
> > 
> 
> Did it?

Yep.

> 
> What was the testcase?

Olaf Kirch had something that we can dig up.

> 
> Two separate things are happening here.
> 
> a) We go all the way to the end of the range even if something went
>    wrong partway through.  Why?

"wrong" is not well defined in this context.  More precisely, the goal
of invalidate_inode_pages2 is to ensure that future reads are not
satisfied by the page cache.  The failure of invalidate_complete_page
does not necessarily imply that gaol has failed.  See changelog for
more discussion.

> 
> b) Remove the was_dirty logic.

This was a big problem.  Removing dirty data from the page_cache
before it has been written out causes data corruption.
The fact that nfs how has a ->releasepage which will fail
appropriately means that this isn't such a problem for nfs.  However
clearing and then possibly setting the flag back doesn't seem like a
race-free thing to do...

> 
>    That's there to address the unmap-dirtyied-the-page-and-buffers
>    problem described in the above changelog.  If that can happen then this
>    patch will end up giving us a page which is marked clean but which in
>    fact has dirty buffers.

So don't mark the page clean until the buffers are clean?

You will note the my changelog entry isn't completely definitive: it
leaves some questions unanswered.  So maybe the discussion is still
ongoing, and input is welcome.

NeilBrown

-------------------------------------
Fix problems with invalidate_inode_pages2{,_range}

invalidate_inode_page2 (or the _range version) is called to ensure
that future read requests will not be satisfied from the page cache,
but rather will cause data to be retrieved from whatever storage the
filesystem (host?) uses.

There are two general cases where it is used.
 1/ Network filesystem which determine that the cache is, or may be,
   out of date.  9p calls it after a write.  nfs calls it in
    nfs_revalidate_mapping which is called when any other piece of code
    decides that the data in the page cache might be out of date.
 2/ When directIO has performed a write bypassing the cache.  In this case
     the cache is clearly out of date and must be purged.


There are two ways the future reads can be disabled.  One is by removing
pages from the cache, and the other is by flagging them as not having
valid data (clear PG_uptodate).  The former is preferred.

There is a potential difficulty if a page is dirty.  This can happen
even if the mapping is flushed before the invalidate begins, as there
is generally no exclusion between the invalidate and write calls.  If
a page is found to be dirty is cannot be removed as this would result in
data loss.  We could clear the PG_uptodate bit however instead of
doing this in the generic code, it is left to the filesystem to do.
i.e. every page is passed to ->releasepage (if the Private flag is set).

The filesystem should do anything that is necessary to ensure that a
future read will not be served from the cache.

The current code is wrong in two respects.

 - it clears the 'dirty' bit without actually saving the data.  This
   can result in data loss (though if ->releasepage fails, which it
   probably would, the flag gets restored).
 - it gives up after the first ->releasepage call that fails.  This is
   inappropriate as a failure of ->releasepage doesn't mean that a
   subsequent read will return data from the cache, and so it doesn't 
   mean that the purpose of invalidate_inode_page2 has failed.

Possibly invalidate_inode_pages2 should clear the PG_uptodate bit if
invalidate_complete_page fails, however it might be safer to leave
that to the filesystem.  In this case, try_to_free_buffers should
possibly clear PG_uptodate.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./mm/truncate.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff ./mm/truncate.c~current~ ./mm/truncate.c
--- ./mm/truncate.c~current~	2006-04-03 09:36:40.000000000 +1000
+++ ./mm/truncate.c	2006-04-03 09:36:45.000000000 +1000
@@ -274,9 +274,14 @@ EXPORT_SYMBOL(invalidate_inode_pages);
  * @end: the page offset 'to' which to invalidate (inclusive)
  *
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
@@ -290,13 +295,12 @@ int invalidate_inode_pages2_range(struct
 
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
@@ -332,12 +336,9 @@ int invalidate_inode_pages2_range(struct
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
