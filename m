Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271421AbUJVQRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271421AbUJVQRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271422AbUJVQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:17:32 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:1244 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S271421AbUJVQQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:16:58 -0400
Date: Fri, 22 Oct 2004 18:17:44 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041022161744.GF14325@dualathlon.random>
References: <1098393346.7157.112.camel@localhost> <20041021144531.22dd0d54.akpm@osdl.org> <20041021223613.GA8756@dualathlon.random> <20041021160233.68a84971.akpm@osdl.org> <20041021232059.GE8756@dualathlon.random> <20041021164245.4abec5d2.akpm@osdl.org> <20041022003004.GA14325@dualathlon.random> <20041022012211.GD14325@dualathlon.random> <20041021190320.02dccda7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021190320.02dccda7.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 07:03:20PM -0700, Andrew Morton wrote:
> Yeah.  I think the only 100% reliable way to do this is:
> 
> 	lock_page()
> 	unmap_mapping_range(page)
> 	ClearPageUptodate(page);
> 	invalidate(page);	/* Try to free the thing */
> 	unlock_page(page);
> 
> (Can do it for a whole range of pages if we always agree to lock pages in
> file-index-ascending order).
> 
> but hrm, we don't even have the locking there to prevent do_no_page() from
> reinstantiating the pte immediately after the unmap_mapping_range().
> 
> So what to do?
> 
> - The patch you originally sent has a race window which can be made
>   nonfatal by removing the BUGcheck in mpage_writepage().
> 
> - NFS should probably be taught to use unmap_mapping_range() regardless
>   of what we do, so the existing-mmaps-hold-stale-data problem gets fixed
>   up.
> 
> - invalidate_inode_pages2() isn't successfully invalidating the page if
>   it has buffers.

I did it right in 2.4, somebody obviously broken the thing in 2.6. Now
w.r.t. to ext2/ext3 I never heard a problem, and we nuke buffers
regardless if the page is mapped or not (so this isn't a corner case).

define block_invalidate_page(page) discard_bh_page(page, 0, 0)

	} else {
		if (page->buffers) {
			/* Restart after this page */
			list_del(head);
			list_add_tail(head, curr);

			page_cache_get(page);
			spin_unlock(&pagecache_lock);
			block_invalidate_page(page);
		} else
			unlocked = 0;

		ClearPageDirty(page);

The guarantee is total in 2.4 w.r.t.  buffers, as worse it can generate
an hearth attack to ext3 but it won't risk to lose coherency. Only 2.6
broke the O_DIRECT vs buffered I/O coherency protocol.

The semantics of not uptodate pages mapped in the address space are as
well understood and working fine in 2.4.

>   This is the biggest problem, because the pages can trivially have
>   buffers - just write()ing to them will attach buffers, if they're ext2-
>   or ext3-backed.
> 
>   It means that a direct-IO write to a section of a file which is mmapped
>   causes pagecache and disk to get out of sync.  Question is: do we care,
>   or do we say "don't do that"?  Nobody seems to have noticed thus far and
>   it's a pretty dopey thing to be doing.

this is a supported feature. People is writing with O_DIRECT and reading
with buffered read and we must support that (think a database writing
and a tar.gz reading). The coherency is a must after the O_DIRECT has
completed. If people runs the operations at the same time the result is
undefined. But by serializing the I/O at the userspace level (like
stop_db(); tar.gz) we must provide guarantees to them.

>   If we _do_ want to fix it, it seems the simplest approach would be to
>   nuke the pte's in invalidate_inode_pages2().  And we'd need some "oh we
>   raced - try again" loop in there to handle the "do_no_page()
>   reinstantiated a pte" race.

the do_no_page don't need to be coherent. The pte is the last thing we
can care about. The API only guarantees read/write syscalls to be
coherent, mmap not.

the only bug is the bh and it has to be fixed as easily as I did in 2.4.

> Something like this?  Slow as a dog, but possibly correct ;)
> 
> 
> void invalidate_inode_pages2(struct address_space *mapping)
> {
> 	struct pagevec pvec;
> 	pgoff_t next = 0;
> 	int i;
> 
> 	pagevec_init(&pvec, 0);
> 	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
> 		for (i = 0; i < pagevec_count(&pvec); i++) {
> 			struct page *page = pvec.pages[i];
> 
> 			lock_page(page);
> 			if (page->mapping == mapping) {	/* truncate race? */
> 				wait_on_page_writeback(page);
> 				next = page->index + 1;
> 				while (page_mapped(page)) {
> 					unmap_mapping_range(mapping,
> 					  page->index << PAGE_CACHE_SHIFT,
> 					  page->index << PAGE_CACHE_SHIFT+1,
> 					  0);
> 					clear_page_dirty(page);
> 				}
> 				invalidate_complete_page(mapping, page);
> 			}
> 			unlock_page(page);
> 		}
> 		pagevec_release(&pvec);
> 		cond_resched();
> 	}
> }

You know the page_mapped path isn't really very important as far as we
execute both clear_page_dirty and ClearPageUptodate. We must provide the
guarantee to the syscall. Leaving not updoate pages in the ptes is
fine, the VM can deal with that. the semantics of that condition is that
the page changed on disk due O_DIRECT from under us, so the page isn't
uptodate anymore. If something we can argue about ext3 not being capable
of dealing with a PG_update going away from under it, but the VM is
capable of that, there is only one spot that must be aware about it
(zap fix we posted to start the thread).

BTW, we have these fixes in our tree to make it work:

--- sles/mm/truncate.c.~1~	2004-05-18 19:24:40.000000000 +0200
+++ sles/mm/truncate.c	2004-05-19 02:09:28.311781864 +0200
@@ -260,9 +260,10 @@ void invalidate_inode_pages2(struct addr
 			if (page->mapping == mapping) {	/* truncate race? */
 				wait_on_page_writeback(page);
 				next = page->index + 1;
-				if (page_mapped(page))
+				if (page_mapped(page)) {
+					ClearPageUptodate(page);
 					clear_page_dirty(page);
-				else
+				} else
 					invalidate_complete_page(mapping, page);
 			}
 			unlock_page(page);

and then this fix for BLKFLSBUF:

diff -urNp linux-2.6.8/mm/truncate.c linux-2.6.8.SUSE/mm/truncate.c
--- linux-2.6.8/mm/truncate.c	2004-09-21 15:39:37.850379202 +0200
+++ linux-2.6.8.SUSE/mm/truncate.c	2004-09-21 15:39:54.733668309 +0200
@@ -86,6 +86,12 @@ invalidate_complete_page(struct address_
 		write_unlock_irq(&mapping->tree_lock);
 		return 0;
 	}
+
+	BUG_ON(PagePrivate(page));
+	if (page_count(page) != 2) {
+		write_unlock_irq(&mapping->tree_lock);
+		return 0;
+	}
 	__remove_from_page_cache(page);
 	write_unlock_irq(&mapping->tree_lock);
 	ClearPageUptodate(page);
@@ -306,7 +312,11 @@ void invalidate_inode_pages2(struct addr
 					clear_page_dirty(page);
 					ClearPageUptodate(page);
 				} else {
-					invalidate_complete_page(mapping, page);
+					if (!invalidate_complete_page(mapping,
+								      page)) {
+						clear_page_dirty(page);
+						ClearPageUptodate(page);
+					}
 				}
 			}
 			unlock_page(page);



apparently those weren't submitted to mainline yet, that could have
created some confusion on why we submitted the third patch that avoids
the BUG in pdflush and it avoids to try writing to disk a page that is
not uptodate anymore. Do you see why it's wrong to pass down to pdflush
a page that isn't utpodate? That page must be re-read, it sure must not
be written out. The semantics of mapped pages not uptodate are very well
defined and they're pose no risk to the VM (modulo the bug in pdflush
and this clear improvement in zap).

> The unmapping from pagetables means that invalidate_complete_page() will
> generally successfully remove the page from pagecache.  That mostly fixes
> the direct-write-of-mmapped-data coherency problem: the pages simply aren't
> in pagecache any more so we'll surely redo physical I/O.

the direct-write-of-mmapped-data coherency is the last thing we can care
about. Even before thinking about direct-write-of-mmapped-data we must
fix direct-write-of-cached-data (assuming it's not mmapped cache). That
is a showstopper bug, the direct-write-of-mmapped-data is "undefined" by
the linux API. Garbage can end up in the pagecache as far as the kernel
is concerned (all we guarantee is that no random page contents are
delivered to userspace).

> But it's not 100% reliable because ->invalidatepage isn't 100% reliable and
> it really sucks that we're offering behaviour which only works most of the
> time :(

That don't need to ever work, I don't think we even need to add a pte
shootdown, the behviour has never been provided by design. All we need
to do is to fix the bh layer, and fixup the spots in zap to stop bugging
out on dirty not uptodate pages, plus the above patches in this email,
then it'll work as well as 2.4 and it will avoid to break apps. Note
that this is a very serious matter, what happens is that oracle writes
with O_DIRECT and when you do a tar.gz of the database the last block
may be corrupt if it's not 512byte aligned if it was a partial page and
it had partial bh. mysql uses O_DIRECT too. I'm not particularly
concerned about ext3, that can be fixed too, or we can add a new bitflag
as you suggested to avoid fixing the filesystems to deal with that. But
for the VM I'm confortable clearing the uptodate page is much simpler
and it poses no risk to the VM. For the fs you may be very well right
that the BH_reread_from_disk might be needed instead.

So let's forget the mmapped case and let's fix the bh screwup in 2.6.
Then we can think at the mmapped case.

And to fix the mmapped case IMHO all we have to do is:

	clear_page_dirty
	ClearPageUptodate
	unmap_page_range

Not the other way around. The uptodate bit must be clared before zapping
the pte to force a reload.
