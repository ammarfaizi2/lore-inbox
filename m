Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUJWCzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUJWCzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 22:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269239AbUJVXZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:25:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:41887 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269181AbUJVXUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:20:39 -0400
Date: Fri, 22 Oct 2004 16:24:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-Id: <20041022162433.509341e4.akpm@osdl.org>
In-Reply-To: <20041022161744.GF14325@dualathlon.random>
References: <1098393346.7157.112.camel@localhost>
	<20041021144531.22dd0d54.akpm@osdl.org>
	<20041021223613.GA8756@dualathlon.random>
	<20041021160233.68a84971.akpm@osdl.org>
	<20041021232059.GE8756@dualathlon.random>
	<20041021164245.4abec5d2.akpm@osdl.org>
	<20041022003004.GA14325@dualathlon.random>
	<20041022012211.GD14325@dualathlon.random>
	<20041021190320.02dccda7.akpm@osdl.org>
	<20041022161744.GF14325@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> On Thu, Oct 21, 2004 at 07:03:20PM -0700, Andrew Morton wrote:
> > Yeah.  I think the only 100% reliable way to do this is:
> > 
> > 	lock_page()
> > 	unmap_mapping_range(page)
> > 	ClearPageUptodate(page);
> > 	invalidate(page);	/* Try to free the thing */
> > 	unlock_page(page);
> > 
> > (Can do it for a whole range of pages if we always agree to lock pages in
> > file-index-ascending order).
> > 
> > but hrm, we don't even have the locking there to prevent do_no_page() from
> > reinstantiating the pte immediately after the unmap_mapping_range().
> > 
> > So what to do?
> > 
> > - The patch you originally sent has a race window which can be made
> >   nonfatal by removing the BUGcheck in mpage_writepage().
> > 
> > - NFS should probably be taught to use unmap_mapping_range() regardless
> >   of what we do, so the existing-mmaps-hold-stale-data problem gets fixed
> >   up.
> > 
> > - invalidate_inode_pages2() isn't successfully invalidating the page if
> >   it has buffers.
> 
> I did it right in 2.4, somebody obviously broken the thing in 2.6. Now
> w.r.t. to ext2/ext3 I never heard a problem, and we nuke buffers
> regardless if the page is mapped or not (so this isn't a corner case).
> 
> define block_invalidate_page(page) discard_bh_page(page, 0, 0)
> 
> 	} else {
> 		if (page->buffers) {
> 			/* Restart after this page */
> 			list_del(head);
> 			list_add_tail(head, curr);
> 
> 			page_cache_get(page);
> 			spin_unlock(&pagecache_lock);
> 			block_invalidate_page(page);
> 		} else
> 			unlocked = 0;
> 
> 		ClearPageDirty(page);

This is incorrect for ext3 - we have to go through the a_ops to invalidate
the buffer_heads.  That's bad news for my (unmerged) 2.4 direct-io-for-ext3
patch.

> The guarantee is total in 2.4 w.r.t.  buffers, as worse it can generate
> an hearth attack to ext3 but it won't risk to lose coherency. Only 2.6
> broke the O_DIRECT vs buffered I/O coherency protocol.

Only for mmapped pages.  I believe that normal pagecache-vs-directIO is OK
in 2.6.

> The semantics of not uptodate pages mapped in the address space are as
> well understood and working fine in 2.4.

I'd prefer to continue to disallow the mapping of nonuptodate pages into
process address space.  It's indistinguishable from a security hole and I
think we can indeed preserve this invariant while fixing the mmap coherency
problem.

> >   This is the biggest problem, because the pages can trivially have
> >   buffers - just write()ing to them will attach buffers, if they're ext2-
> >   or ext3-backed.
> > 
> >   It means that a direct-IO write to a section of a file which is mmapped
> >   causes pagecache and disk to get out of sync.  Question is: do we care,
> >   or do we say "don't do that"?  Nobody seems to have noticed thus far and
> >   it's a pretty dopey thing to be doing.
> 
> this is a supported feature. People is writing with O_DIRECT and reading
> with buffered read and we must support that (think a database writing
> and a tar.gz reading). The coherency is a must after the O_DIRECT has
> completed. If people runs the operations at the same time the result is
> undefined. But by serializing the I/O at the userspace level (like
> stop_db(); tar.gz) we must provide guarantees to them.

If the page is not mapped into pagetables then we'll invalidate it OK even
if it's backed by ext3.  The only hole I can see is if someone comes in and
dirties the page via write() _after_ generic_file_direct_IO() has done its
filemap_write_and_wait().

And I agree that in that case we should propagate the
invalidate_complete_page() failure back to the diret-io write() caller.  I wonder
how - via a short write, or via -EFOO?

Probably we should sync all the ptes prior to a direct-io read as well.

> >   If we _do_ want to fix it, it seems the simplest approach would be to
> >   nuke the pte's in invalidate_inode_pages2().  And we'd need some "oh we
> >   raced - try again" loop in there to handle the "do_no_page()
> >   reinstantiated a pte" race.
> 
> the do_no_page don't need to be coherent. The pte is the last thing we
> can care about. The API only guarantees read/write syscalls to be
> coherent, mmap not.

I want to fix the mmap case too.  We currently have a half-fix for NFS
which doesn't work at all for (say) ext3.

> the only bug is the bh and it has to be fixed as easily as I did in 2.4.

No, we need to call into the filesystem to kill the buffer_heads.

> > Something like this?  Slow as a dog, but possibly correct ;)
> > 
> > 
> > void invalidate_inode_pages2(struct address_space *mapping)
> > {
> > 	struct pagevec pvec;
> > 	pgoff_t next = 0;
> > 	int i;
> > 
> > 	pagevec_init(&pvec, 0);
> > 	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
> > 		for (i = 0; i < pagevec_count(&pvec); i++) {
> > 			struct page *page = pvec.pages[i];
> > 
> > 			lock_page(page);
> > 			if (page->mapping == mapping) {	/* truncate race? */
> > 				wait_on_page_writeback(page);
> > 				next = page->index + 1;
> > 				while (page_mapped(page)) {
> > 					unmap_mapping_range(mapping,
> > 					  page->index << PAGE_CACHE_SHIFT,
> > 					  page->index << PAGE_CACHE_SHIFT+1,
> > 					  0);
> > 					clear_page_dirty(page);
> > 				}
> > 				invalidate_complete_page(mapping, page);
> > 			}
> > 			unlock_page(page);
> > 		}
> > 		pagevec_release(&pvec);
> > 		cond_resched();
> > 	}
> > }
> 
> You know the page_mapped path isn't really very important as far as we
> execute both clear_page_dirty and ClearPageUptodate.

It's important for NFS - it will allow mmaps to see server-side updates.

> We must provide the
> guarantee to the syscall. Leaving not updoate pages in the ptes is
> fine, the VM can deal with that. the semantics of that condition is that
> the page changed on disk due O_DIRECT from under us, so the page isn't
> uptodate anymore. If something we can argue about ext3 not being capable
> of dealing with a PG_update going away from under it, but the VM is
> capable of that, there is only one spot that must be aware about it
> (zap fix we posted to start the thread).
> 
> BTW, we have these fixes in our tree to make it work:
> 
> --- sles/mm/truncate.c.~1~	2004-05-18 19:24:40.000000000 +0200
> +++ sles/mm/truncate.c	2004-05-19 02:09:28.311781864 +0200
> @@ -260,9 +260,10 @@ void invalidate_inode_pages2(struct addr
>  			if (page->mapping == mapping) {	/* truncate race? */
>  				wait_on_page_writeback(page);
>  				next = page->index + 1;
> -				if (page_mapped(page))
> +				if (page_mapped(page)) {
> +					ClearPageUptodate(page);
>  					clear_page_dirty(page);
> -				else
> +				} else
>  					invalidate_complete_page(mapping, page);
>  			}
>  			unlock_page(page);

That's in 2.6.9.

> and then this fix for BLKFLSBUF:
> 
> diff -urNp linux-2.6.8/mm/truncate.c linux-2.6.8.SUSE/mm/truncate.c
> --- linux-2.6.8/mm/truncate.c	2004-09-21 15:39:37.850379202 +0200
> +++ linux-2.6.8.SUSE/mm/truncate.c	2004-09-21 15:39:54.733668309 +0200
> @@ -86,6 +86,12 @@ invalidate_complete_page(struct address_
>  		write_unlock_irq(&mapping->tree_lock);
>  		return 0;
>  	}
> +
> +	BUG_ON(PagePrivate(page));
> +	if (page_count(page) != 2) {
> +		write_unlock_irq(&mapping->tree_lock);
> +		return 0;
> +	}
>  	__remove_from_page_cache(page);
>  	write_unlock_irq(&mapping->tree_lock);
>  	ClearPageUptodate(page);
> @@ -306,7 +312,11 @@ void invalidate_inode_pages2(struct addr
>  					clear_page_dirty(page);
>  					ClearPageUptodate(page);
>  				} else {
> -					invalidate_complete_page(mapping, page);
> +					if (!invalidate_complete_page(mapping,
> +								      page)) {
> +						clear_page_dirty(page);
> +						ClearPageUptodate(page);
> +					}
>  				}
>  			}
>  			unlock_page(page);
> 

That's in 2.6.9 as well.  I need to think about this a bit more - the first
hunk is for read() versus BLKFLSBUF (if someone else is playing with the
page, leave it alone) whereas the second hunk is kinda buggy, because it
will reintroduce the EIO-in-read() error which the first hunk tried to fix.

(You're using an rwlock for tree_lock.  It's still unclear to me whether we
should go that way - it helps big SMP and hurts small SMP.  Did you perform
an evaluation of this?)

> 
> apparently those weren't submitted to mainline yet, that could have
> created some confusion on why we submitted the third patch that avoids
> the BUG in pdflush and it avoids to try writing to disk a page that is
> not uptodate anymore. Do you see why it's wrong to pass down to pdflush
> a page that isn't utpodate?

Sure.  That's why there's a BUG() there ;)

> That page must be re-read, it sure must not
> be written out. The semantics of mapped pages not uptodate are very well
> defined and they're pose no risk to the VM (modulo the bug in pdflush
> and this clear improvement in zap).
> 
> > The unmapping from pagetables means that invalidate_complete_page() will
> > generally successfully remove the page from pagecache.  That mostly fixes
> > the direct-write-of-mmapped-data coherency problem: the pages simply aren't
> > in pagecache any more so we'll surely redo physical I/O.
> 
> the direct-write-of-mmapped-data coherency is the last thing we can care
> about.

But we can fix it.

> Even before thinking about direct-write-of-mmapped-data we must
> fix direct-write-of-cached-data (assuming it's not mmapped cache). That
> is a showstopper bug,

I don't think we have a bug here.  After the sync(), ext3_releasepage()
will be able to release the buffers.  But we should check for failures.

The problem we're seeing is with mmapped pages.  In that case, clearing
PG_uptodate is insufficient and directly invalidating the buffer_heads will
probably kill ext3 and we're not allowed to assume that page->private
contains bh's anyway...

Probably it is sufficient to run try_to_release_page() in the page_mapped
leg of invalidate_inode_pages2(), and to check the return value.

> the direct-write-of-mmapped-data is "undefined" by
> the linux API. Garbage can end up in the pagecache as far as the kernel
> is concerned (all we guarantee is that no random page contents are
> delivered to userspace).
> 
> > But it's not 100% reliable because ->invalidatepage isn't 100% reliable and
> > it really sucks that we're offering behaviour which only works most of the
> > time :(
> 
> That don't need to ever work, I don't think we even need to add a pte
> shootdown, the behviour has never been provided by design. All we need
> to do is to fix the bh layer, and fixup the spots in zap to stop bugging
> out on dirty not uptodate pages, plus the above patches in this email,
> then it'll work as well as 2.4 and it will avoid to break apps. Note
> that this is a very serious matter, what happens is that oracle writes
> with O_DIRECT and when you do a tar.gz of the database the last block
> may be corrupt if it's not 512byte aligned if it was a partial page and
> it had partial bh. mysql uses O_DIRECT too.

The current buffered-vs-direct handling looks OK, as long as the pages
aren't mmapped, and as long as nobody dirties a page after
generic_file_direct_IO() has done filemap_write_and_wait().

For the former I'd like to unmap the pages.  For the latter we should check
the invalidate_complete_page() return value.

> I'm not particularly
> concerned about ext3, that can be fixed too, or we can add a new bitflag
> as you suggested to avoid fixing the filesystems to deal with that. But
> for the VM I'm confortable clearing the uptodate page is much simpler
> and it poses no risk to the VM. For the fs you may be very well right
> that the BH_reread_from_disk might be needed instead.
> 
> So let's forget the mmapped case and let's fix the bh screwup in 2.6.
> Then we can think at the mmapped case.

The "bh screwup" _is_ the mmapped case.  Maybe I said something different
yesterday - it's been a while since I looked in there.

> And to fix the mmapped case IMHO all we have to do is:
> 
> 	clear_page_dirty
> 	ClearPageUptodate
> 	unmap_page_range
> 
> Not the other way around. The uptodate bit must be clared before zapping
> the pte to force a reload.

Something like this...




- When invalidating pages, take care to shoot down any ptes which map them
  as well.

  This ensures that the next mmap access to the page will generate a major
  fault, so NFS's server-side modifications are picked up.

  This also allows us to call invalidate_complete_page() on all pages, so
  filesytems such as ext3 get a chance to invalidate the buffer_heads.

- Don't mark in-pagetable pages as non-uptodate any more.  That broke a
  previous guarantee that mapped-into-user-process pages are always uptodate.

- Check the return value of invalidate_complete_page().  It can fail if
  someone redirties a page after generic_file_direct_IO() write it back.

But we still have a problem.  If invalidate_inode_pages2() calls
unmap_mapping_range(), that can cause zap_pte_range() to dirty the pagecache
pages.  That will redirty the page's buffers and will cause
invalidate_complete_page() to fail.

So, in generic_file_direct_IO() we do a complete pte shootdown on the file
up-front, prior to writing back dirty pagecache.  This is only done for
O_DIRECT writes.  It _could_ be done for O_DIRECT reads too, providing full
mmap-vs-direct-IO coherency for both O_DIRECT reads and O_DIRECT writes, but
permitting the pte shootdown on O_DIRECT reads trivially allows people to nuke
other people's mapped pagecache.

NFS also uses invalidate_inode_pages2() for handling server-side modification
notifications.  But in the NFS case the clear_page_dirty() in
invalidate_inode_pages2() is sufficient, because NFS doesn't have to worry
about the "dirty buffers against a clean page" problem.  (I think)

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/fs.h |    2 -
 25-akpm/mm/filemap.c       |   19 ++++++++++---
 25-akpm/mm/truncate.c      |   63 +++++++++++++++++++++++++++------------------
 3 files changed, 55 insertions(+), 29 deletions(-)

diff -puN mm/truncate.c~invalidate_inode_pages-mmap-coherency-fix mm/truncate.c
--- 25/mm/truncate.c~invalidate_inode_pages-mmap-coherency-fix	Fri Oct 22 15:40:26 2004
+++ 25-akpm/mm/truncate.c	Fri Oct 22 16:05:26 2004
@@ -65,6 +65,8 @@ truncate_complete_page(struct address_sp
  * be marked dirty at any time too.  So we re-check the dirtiness inside
  * ->tree_lock.  That provides exclusion against the __set_page_dirty
  * functions.
+ *
+ * Returns non-zero if the page was successfully invalidated.
  */
 static int
 invalidate_complete_page(struct address_space *mapping, struct page *page)
@@ -281,50 +283,63 @@ unsigned long invalidate_inode_pages(str
 EXPORT_SYMBOL(invalidate_inode_pages);
 
 /**
- * invalidate_inode_pages2 - remove all unmapped pages from an address_space
+ * invalidate_inode_pages2 - remove all pages from an address_space
  * @mapping - the address_space
  *
- * invalidate_inode_pages2() is like truncate_inode_pages(), except for the case
- * where the page is seen to be mapped into process pagetables.  In that case,
- * the page is marked clean but is left attached to its address_space.
- *
- * The page is also marked not uptodate so that a subsequent pagefault will
- * perform I/O to bringthe page's contents back into sync with its backing
- * store.
+ * Any pages which are found to be mapped into pagetables are unmapped prior to
+ * invalidation.
  *
- * FIXME: invalidate_inode_pages2() is probably trivially livelockable.
+ * Returns -EIO if any pages could not be invalidated.
  */
-void invalidate_inode_pages2(struct address_space *mapping)
+int invalidate_inode_pages2(struct address_space *mapping)
 {
 	struct pagevec pvec;
 	pgoff_t next = 0;
 	int i;
+	int ret = 0;
+	int did_full_unmap = 0;
 
 	pagevec_init(&pvec, 0);
-	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
-		for (i = 0; i < pagevec_count(&pvec); i++) {
+	while (!ret && pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
-			if (page->mapping == mapping) {	/* truncate race? */
-				wait_on_page_writeback(page);
-				next = page->index + 1;
-				if (page_mapped(page)) {
-					clear_page_dirty(page);
-					ClearPageUptodate(page);
+			if (page->mapping != mapping) {	/* truncate race? */
+				unlock_page(page);
+				continue;
+			}
+			wait_on_page_writeback(page);
+			next = page->index + 1;
+			while (page_mapped(page)) {
+				if (!did_full_unmap) {
+					/*
+					 * Zap the rest of the file in one hit.
+					 * FIXME: invalidate_inode_pages2()
+					 * should take start/end offsets.
+					 */
+					unmap_mapping_range(mapping,
+						page->index << PAGE_CACHE_SHIFT,
+					  	-1, 0);
+					did_full_unmap = 1;
 				} else {
-					if (!invalidate_complete_page(mapping,
-								      page)) {
-						clear_page_dirty(page);
-						ClearPageUptodate(page);
-					}
+					/*
+					 * Just zap this page
+					 */
+					unmap_mapping_range(mapping,
+					  page->index << PAGE_CACHE_SHIFT,
+					  (page->index << PAGE_CACHE_SHIFT)+1,
+					  0);
 				}
 			}
+			clear_page_dirty(page);
+			if (!invalidate_complete_page(mapping, page))
+				ret = -EIO;
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
 		cond_resched();
 	}
+	return ret;
 }
-
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
diff -puN include/linux/fs.h~invalidate_inode_pages-mmap-coherency-fix include/linux/fs.h
--- 25/include/linux/fs.h~invalidate_inode_pages-mmap-coherency-fix	Fri Oct 22 15:54:50 2004
+++ 25-akpm/include/linux/fs.h	Fri Oct 22 15:54:58 2004
@@ -1404,7 +1404,7 @@ static inline void invalidate_remote_ino
 	    S_ISLNK(inode->i_mode))
 		invalidate_inode_pages(inode->i_mapping);
 }
-extern void invalidate_inode_pages2(struct address_space *mapping);
+extern int invalidate_inode_pages2(struct address_space *mapping);
 extern void write_inode_now(struct inode *, int);
 extern int filemap_fdatawrite(struct address_space *);
 extern int filemap_flush(struct address_space *);
diff -puN mm/filemap.c~invalidate_inode_pages-mmap-coherency-fix mm/filemap.c
--- 25/mm/filemap.c~invalidate_inode_pages-mmap-coherency-fix	Fri Oct 22 15:55:06 2004
+++ 25-akpm/mm/filemap.c	Fri Oct 22 16:17:19 2004
@@ -2214,7 +2214,8 @@ ssize_t generic_file_writev(struct file 
 EXPORT_SYMBOL(generic_file_writev);
 
 /*
- * Called under i_sem for writes to S_ISREG files
+ * Called under i_sem for writes to S_ISREG files.   Returns -EIO if something
+ * went wrong during pagecache shootdown.
  */
 ssize_t
 generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
@@ -2224,14 +2225,24 @@ generic_file_direct_IO(int rw, struct ki
 	struct address_space *mapping = file->f_mapping;
 	ssize_t retval;
 
+	/*
+	 * If it's a write, unmap all mmappings of the file up-front.  This
+	 * will cause any pte dirty bits to be propagated into the pageframes
+	 * for the subsequent filemap_write_and_wait().
+	 */
+	if (rw == WRITE && mapping_mapped(mapping))
+		unmap_mapping_range(mapping, 0, -1, 0);
+
 	retval = filemap_write_and_wait(mapping);
 	if (retval == 0) {
 		retval = mapping->a_ops->direct_IO(rw, iocb, iov,
 						offset, nr_segs);
-		if (rw == WRITE && mapping->nrpages)
-			invalidate_inode_pages2(mapping);
+		if (rw == WRITE && mapping->nrpages) {
+			int err = invalidate_inode_pages2(mapping);
+			if (err)
+				retval = err;
+		}
 	}
 	return retval;
 }
-
 EXPORT_SYMBOL_GPL(generic_file_direct_IO);
_

