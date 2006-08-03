Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWHCHRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWHCHRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWHCHRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:17:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932355AbWHCHRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:17:47 -0400
Date: Thu, 3 Aug 2006 00:17:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: partial reiser4 review comments
Message-Id: <20060803001741.4ee9ff72.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm only partway through this, but let me unload my observations thus far. 
I still need to find a chunk of time for a file-by-file walkthrough and
it's unobvious where that chunk will come from at present :(


reiser4 as found in 2.6.18-rc2-mm1.

- set_page_dirty_internal() pokes around in VFS internals.  Use
  __set_page_dirty_no_buffers() or create a new library function in
  mm/page-writeback.c.

  In particular, it gets the radix-tree dirty tagging out of sync.

- running igrab() in the writepage() path is really going to hammer
  inode_lock.  Something else will need to be done here.

- The preferred way of solving the above would be to mark the page as
  PageWriteback() with set_page_writeback() prior to unlocking it.  That'll
  pin the page and the inode.  It does require that the page actually get
  written later on.  If we cannot do that then more thought is needed.

- wbq.sem should be using a completion for the "wait until entd finishes",
  not a semaphore.  Because there's a teeny theoretical race when using
  semaphores this way which completions were designed to avoid.  (The waker
  can still be playing with the semaphore when it has gone out of scope on the
  wakee's stack).

- write_page_by_ent(): the "spin until entd thread" thing is gross.

  This function is really lock-intensive.

- If poss, use wake_up_process() rather than wake_up().  That'll save some
  locking.

- Running iput() in entd() is a bit surprising.  iirc there are various ways
  in which this can recur into the filesystem, perform I/O, etc.  I guess it
  works..

  But again, it will hammer inode_lock.

- entd_flush(): bug:

	rq->wbc->range_start = rq->page->index << PAGE_CACHE_SHIFT;

  this can overflow on 32-bit.  Need to cast rq->page->index to loff_t.

- the writeout logic in entd_flush() is interesting (as in "holy cow"). 
  It's very central and really needs some good comments describing what's
  going on in there - what problems are being solved, which decisions were
  taken and why, etc.

  The big comment in page_cache.c is useful.  Please maintain it well.

  Boy, it has some old stuff in it.

- writeout() is a poor name for a global function.  Even things like
  "txn_restart" are a bit generic-sounding.  Low-risk, but the kernel's
  getting bigger...

  If it were mine, I'd prefix all these symbols with "r4_".

  prepare_to_sleep(), page_io(), drop_page(), statfs_type(),
  pre_commit_hook(), etc, etc, etc, etc.  Much namespace pollution.

- reiser4_wait_page_writeback() needs commenting.

- reading the comment in txnmgr.c regarding MAP_SHARED pages: a number of
  things have changed since then.  We have page-becoming-writeable
  notifications and probably soon we'll always take a pagefault when a
  MAP_SHARED page transitions from pte-clean to pte-dirty (although I wouldn't
  recommend that a filesystem rely upon the latter for a while yet).

- invalidate_list() is a poorly-chosen global identifier.  We already have
  an invalidate_list() in fs/inode.c, too.

  Please audit all of reiser4's global identifiers (use nm *.o) for suitable
  naming choices.

- semaphores are deprecated.  Please switch to mutexes and/or completions
  where appropriate and possible.

- page_cache.c: yes, mpage_end_io_write() and mpage_end_io_read() are pretty
  generic - we might as well export them.

- drop_page() is a worry.  Why _does_ reiser4 need to remove pages from
  pagecache?  That isn't a filesystem function.

  drop_page() appears to leave the no-longer-present page tagged as dirty in
  the radix-tree.

- truncate_jnodes_range() looks wrong to me.  When we populate gang[], there
  can be any number of NULL entries placed in it.  But the loop which iterates
  across the now-populated gang[] will bale out when it its the _first_ NULL
  entry.  Any following entries will have a leaked jref() against them.

- reiser4_invalidate_pages() is a mix of reiser4 things and of
  things-which-the-vfs-is-supposed-to-do.  It is uncommented and I am unable
  to work out why it was necessary to do this, and hence what we can do about
  it.

- reiser4_readpages() shouldn't need to clean up the remaining pages on
  *pages.  read_cache_pages() does that now.

- <wonders what formatted and unformatted nodes are> A brief glossary might
  help.

- REISER4_ERROR_CODE_BASE actually overlaps real errnos (see
  include/linux/errno.h).  Suggest that it be changed to 1000000 or something.

- blocknr_set_add() modifies a list_head without any apparent locking. 
  Certainly without any _documented_ locking...

  Ditto blocknr_set_destroy().  I'm sure there's locking, but it's harder
  than it should be to work out what it is.  Given that proper locking is in
  place, the filesystem seems to use list_*_careful() a lot more than is
  necessary?

- It would be clearer to remove `struct blocknr_set' and just use list_head.

- Waaaaaaaaaaaaaaay too many typedefs.

- There are many coding-style nits.  One I will mention is very large number
  of unneeded braces:

	if (foo) {
		bar();
	}

  it'd be nice to fix these up sometime.


- General comment: the lack of support for extended attributes, access
  control lists and direct-io is a big problem and it's getting bigger.  I
  don't see how a vendor could support reiser4 without these features and
  permanent lack of vendor support will hurt.

  What's the plan here?


