Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271203AbUJVCMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271203AbUJVCMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271195AbUJVCHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:07:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:20363 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271169AbUJVCFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:05:18 -0400
Date: Thu, 21 Oct 2004 19:03:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-Id: <20041021190320.02dccda7.akpm@osdl.org>
In-Reply-To: <20041022012211.GD14325@dualathlon.random>
References: <1098393346.7157.112.camel@localhost>
	<20041021144531.22dd0d54.akpm@osdl.org>
	<20041021223613.GA8756@dualathlon.random>
	<20041021160233.68a84971.akpm@osdl.org>
	<20041021232059.GE8756@dualathlon.random>
	<20041021164245.4abec5d2.akpm@osdl.org>
	<20041022003004.GA14325@dualathlon.random>
	<20041022012211.GD14325@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> On Fri, Oct 22, 2004 at 02:30:04AM +0200, Andrea Arcangeli wrote:
> > If you want to shootdown ptes before clearing the bitflag, that's fine
> 
> small correction s/before/after/. doing the pte shootdown before
> clearing the uptodate bitflag, would still not guarantee to read
> uptodate data after the invalidate (a minor page fault could still
> happen between the shootdown and the clear_bit; while after clearing the
> uptodate bit a major fault hitting the disk and refreshing the pagecache
> contents will be guaranteed - modulo bhs, well at least nfs is sure ok
> in that respect ;).

Yeah.  I think the only 100% reliable way to do this is:

	lock_page()
	unmap_mapping_range(page)
	ClearPageUptodate(page);
	invalidate(page);	/* Try to free the thing */
	unlock_page(page);

(Can do it for a whole range of pages if we always agree to lock pages in
file-index-ascending order).

but hrm, we don't even have the locking there to prevent do_no_page() from
reinstantiating the pte immediately after the unmap_mapping_range().

So what to do?

- The patch you originally sent has a race window which can be made
  nonfatal by removing the BUGcheck in mpage_writepage().

- NFS should probably be taught to use unmap_mapping_range() regardless
  of what we do, so the existing-mmaps-hold-stale-data problem gets fixed
  up.

- invalidate_inode_pages2() isn't successfully invalidating the page if
  it has buffers.

  This is the biggest problem, because the pages can trivially have
  buffers - just write()ing to them will attach buffers, if they're ext2-
  or ext3-backed.

  It means that a direct-IO write to a section of a file which is mmapped
  causes pagecache and disk to get out of sync.  Question is: do we care,
  or do we say "don't do that"?  Nobody seems to have noticed thus far and
  it's a pretty dopey thing to be doing.

  If we _do_ want to fix it, it seems the simplest approach would be to
  nuke the pte's in invalidate_inode_pages2().  And we'd need some "oh we
  raced - try again" loop in there to handle the "do_no_page()
  reinstantiated a pte" race.

Fun.

Something like this?  Slow as a dog, but possibly correct ;)


void invalidate_inode_pages2(struct address_space *mapping)
{
	struct pagevec pvec;
	pgoff_t next = 0;
	int i;

	pagevec_init(&pvec, 0);
	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
		for (i = 0; i < pagevec_count(&pvec); i++) {
			struct page *page = pvec.pages[i];

			lock_page(page);
			if (page->mapping == mapping) {	/* truncate race? */
				wait_on_page_writeback(page);
				next = page->index + 1;
				while (page_mapped(page)) {
					unmap_mapping_range(mapping,
					  page->index << PAGE_CACHE_SHIFT,
					  page->index << PAGE_CACHE_SHIFT+1,
					  0);
					clear_page_dirty(page);
				}
				invalidate_complete_page(mapping, page);
			}
			unlock_page(page);
		}
		pagevec_release(&pvec);
		cond_resched();
	}
}

The unmapping from pagetables means that invalidate_complete_page() will
generally successfully remove the page from pagecache.  That mostly fixes
the direct-write-of-mmapped-data coherency problem: the pages simply aren't
in pagecache any more so we'll surely redo physical I/O.

But it's not 100% reliable because ->invalidatepage isn't 100% reliable and
it really sucks that we're offering behaviour which only works most of the
time :(


