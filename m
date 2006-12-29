Return-Path: <linux-kernel-owner+w=401wt.eu-S1755065AbWL2WRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbWL2WRV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755061AbWL2WRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:17:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59285 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977AbWL2WRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:17:19 -0500
Date: Fri, 29 Dec 2006 14:16:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-Id: <20061229141632.51c8c080.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
	<20061228114517.3315aee7.akpm@osdl.org>
	<Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
	<20061228.143815.41633302.davem@davemloft.net>
	<3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
	<Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 02:48:35 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> +	if (mapping && mapping_cap_account_dirty(mapping)) {
> +		/*
> +		 * Yes, Virginia, this is indeed insane.
> +		 *
> +		 * We use this sequence to make sure that
> +		 *  (a) we account for dirty stats properly
> +		 *  (b) we tell the low-level filesystem to
> +		 *      mark the whole page dirty if it was
> +		 *      dirty in a pagetable. Only to then
> +		 *  (c) clean the page again and return 1 to
> +		 *      cause the writeback.
> +		 *
> +		 * This way we avoid all nasty races with the
> +		 * dirty bit in multiple places and clearing
> +		 * them concurrently from different threads.
> +		 *
> +		 * Note! Normally the "set_page_dirty(page)"
> +		 * has no effect on the actual dirty bit - since
> +		 * that will already usually be set. But we
> +		 * need the side effects, and it can help us
> +		 * avoid races.
> +		 *
> +		 * We basically use the page "master dirty bit"
> +		 * as a serialization point for all the different
> +		 * threds doing their things.
> +		 *
> +		 * FIXME! We still have a race here: if somebody
> +		 * adds the page back to the page tables in
> +		 * between the "page_mkclean()" and the "TestClearPageDirty()",
> +		 * we might have it mapped without the dirty bit set.
> +		 */
> +		if (page_mkclean(page))
> +			set_page_dirty(page);
> +		if (TestClearPageDirty(page)) {
>  			dec_zone_page_state(page, NR_FILE_DIRTY);
> +			return 1;
>  		}

- Presumably reiser3's ordered-data mode has the same problem.  And ext4,
  of course.  Dunno about other filesytems.

- The above change means that we do extra writeout.  If a page is dirtied
  once, kjournald will write it and then pdflush will come along and
  needlessly write it again.

  But otoh, if a mapping is being repeatedly dirtied, kjournald will
  write the page once per 30 seconds (dirty_expire_centisecs) and pdflush
  will write the page once per 30 seconds as well.  But we _should_ be
  writing it once per five seconds (kjournald commit interval).  So we're
  still ahead ;)

- Poor old IO accounting broke again.

- People were saying that ext2 and ext3,data=writeback were also showing
  corruption.  What's up with that?

- For a long time I've wanted to nuke the current ext3/jbd ordered-data
  implementation altogether, and just make kjournald call into the
  standard writeback code to do a standard suberblock->inodes->pages walk.

  I think it'd be fairly straightforward to do.  We'd need to teach the
  writeback code to be able to skip dirty pages which don't have a disk
  mapping, so that kjournald doesn't end up waiting for kjournald to free
  up journal space..

  Would need to avoid possible deadlocks where someone calls
  ext3_force_commit() or otherwise does a synchronous commit while holding
  VFS locks.

  reiser3 and ext4 could be converted too.

  Not a short-term project, but this would avoid the problem.

- It's pretty obnoxious that the VM now sets a clean page "dirty" and
  then proceeds to modify its contents.  It would be nice to stop doing
  that.

  We could stop marking the page dirty in do_wp_page() and create a new
  VM counter "NR_PTE_DIRTY", which means

    "number of mapping_cap_account_dirty() pages which have a dirty pte
    pointing at them".

  Or, perhaps

    "number of dirty ptes which point at mapping_cap_account_dirty() pages".

  Which can be larger, but the writeout code will probably cope.

  Then we take NR_PTE_DIRTY into account in the dirty-page balancing act.
  So

  - do_wp_page() will still run balance_dirty_pages()

  - but it would no longer run set_page_dirty().

  - But it needs to run mark_inode_dirty() so the fs-writeback code
    notices the file.

  - And mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) becomes insufficient.

  The tricky part here is "how do we do the writeback"?  The
  pte-dirty,!PageDirty pages aren't tagged as dirty in the radix-tree and
  writeback needs to find them so that it can effectively do an msync() on
  them.  Walking all the mm's and vma's would be insane.  Visiting all the
  pages in the file would also probably be insane.

  Perhaps this can be solved by adding a new radix-tree tag which means
  "this page might have dirty ptes pointing at it".  For each file
  writeback would do a radix-tree walk of these pages,
  cleaning-and-write-protecting ptes, marking the corresponding pages
  dirty and clearing their PAGECACHE_TAG_PTE_DIRTY tags.

  Then we can fix the mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)
  problem by doing

    mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
	mapping_tagged(mapping, PAGECACHE_TAG_PTE_DIRTY)

  or, better,

	mapping_tagged(mapping,
		(1<<PAGECACHE_TAG_DIRTY)|(1<<PAGECACHE_TAG_PTE_DIRTY))

  perhaps.

  The msync() code would need to be taught to call the
  PAGECACHE_TAG_PTE_DIRTY walker for the appropriate page range.


  This is also not a quick-fix.

