Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWC2Wfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWC2Wfk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWC2Wfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:35:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46791 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751075AbWC2Wfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:35:39 -0500
Date: Wed, 29 Mar 2006 14:37:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060329143758.607c1ccc.akpm@osdl.org>
In-Reply-To: <20060329122841.GC8186@suse.de>
References: <20060329122841.GC8186@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Hi,
> 
> Since my initial posting back in December, I've had some private queries
> about the state of splice support. The state was pretty much that it was
> a little broken, if one attempted to do file | file splicing. The
> original patch migrated pages from one file to another in this case,
> which got vm ugly really quickly. And it wasn't always the right thing
> to do, since it would mean that splicing file1 to file2 would move
> file1's page cache to file2. Sometimes this is what you want, sometimes
> it is not.
> 
> So that was removed to make things work fully. It can later be
> reintroduced (and controlled with the splice flags passed in, whether to
> 'loan' or 'gift' source pages to use a McVoy term) if need be.
> 
> Apart from that change, I added splice to socket support. It then
> becomes a full sendfile() replacement (unless I broke something). I'm
> attaching the current patch against 2.6.16-git, and also three test apps
> that you can use as a reference or just to play with this. The apps are:
> 

- splice() take a size_t length.  Should it be taking a 64-bit length?

- splice() doesn't check for (len < 0), like read() and write() do. 
  Should it?

- Please don't call it `len'.  VFS has to deal with "lengths" which can
  be in units of PAGE_CACHE_SIZE, fs blocksize, 512-bytes sectors or bytes,
  and it gets confusing.  Our liking for variable names like `len' and
  `count' just makes it worse.

  If it's in units of pages then call it `npages'.  If it's in bytes then
  call it `nbytes'.

  What _is_ it in units of, anyway?  I guess bytes, since it's size_t.

  I assume all this lenning:

			unsigned int this_len;

			this_len = buf->len;
			if (this_len > len)
				this_len = len;

  is dealing with bytes too.  You'll be wanting a size_t in there.

- why is the `flags' arg to sys_splice() unsigned long?  Can it be `int'?

- what does `flags' do, anyway?  The whole thing is undocumented and
  almost uncommented.

- the tmp_page trick in anon_pipe_buf_release() seems to be unrelated to
  the splice() work.  It should be a separate patch and any peformance
  testing (needed, please) should be decoupled from that change.

- I think the `size_t left' in do_splice_to() can overflow if f_pos is
  sufficiently different from i_size.

- All the operations do foo(in, out, ...).  It's a bit more conventional
  to do foo(out, in, ...).

- The logic in do_splice() hurts my brain.  "if `in' is a pipe then
  splice from `in-as-a-pipe' to `out' else if `out' is a pipe then splice
  from `in' to 'out-as-a-pipe'.  Make sense, I guess, but I do wonder "what
  would happen if those tests were reversed?".  Nothing, I guess.

- In pipe_to_file():

  - Shouldn't it be using GFP_HIGHUSER()?

  - local variable `index' should be unsigned long or, for clarity
    value, pgoff_t.

  - Incoming arg `pos' should be loff_t?

  - It's racy against truncate().  After running ->readpage and
    lock_page(), need to check for page->mapping == NULL.

  - There's a duplicate flush_dcache_page().

  - Why does it run write_one_page()???  (Don't tell me.  I'll work it
    out when I see the commented version ;))

  - I worry a bit about the assumption in one place that a non-zero
    return from commit_write() indicates an error, whereas another place
    assumes that a negative return is an error.  We had problems in the
    past where some a_ops implementations decided to return small positive
    numbers from prepare_write() or commit_write() a_ops, which broke
    stuff.  They shouldn't be doing that now, but it's a thing to watch out
    for.

  - Bug.  If write_one_page() returned an error, it still unlocked the page.

- In pipe_to_sendpage():

  - local variable `offset' is ulong, but elsewhere you've used uint. 
    The latter is better.

  - Again, incoming arg `len' is confusing.  I _think_ it's actually
    "number of bytes to be moved from this page".  A comment which explains
    these things would be nice, and perhaps a better name (bytes_to_send?)

  - Should incoming arg `pos' be loff_t?  That would give it some meaning.

  - Why does it use PAGE_SIZE and PAGE_SHIFT rather than PAGE_CACHE_*?

- In generic_file_splice_read():

  - nonatomic modification of f_pos.  Is i_mutex held?  (see
    generic_file_llseek())

  - Darnit, we carried `flags' this far and ended up not using it. 
    (What _does_ flags do, anyway?  Reads on..)

- In __generic_file_splice_read():

  - local variable `index' is ulong, could be pgoff_t (for clarity)

  - local variable `offset' could be uint (it is uint elsewhere, and
    might generate better code).

    A better name might be offset_in_page.

  - local variable `pages' could be uint (but watch out for overflow!!).

    A better name might be nr_pages (matches find_get_pages()).  Then,
    local variable `array' can be renamed to `pages', which is all much
    better.

  - While we're in the spirit, local var `i' would be better named
    `page_nr' or something.

  - Shouldn't it be using GFP_HIGHUSER?

  - whoa.  We move the pages into the pipe while they're still under
    read I/O.  Is that deliberate?  (pls add nice comment).

  - These pages can get truncated at any time they're unlocked.  Does
    the code cope with all that?

  - hm.  What happens if the pages which find_get_pages() returned are
    not contiguous in pagecache?  I think your `pages' array gets all
    jumbled up.

- In move_to_pipe()

  - gargh, another `offset' and `len'.  No idea what they're doing, so
    am unable to determine whether ulong is an appropriate type.  Am keenly
    looking forward to the commented version!

  - Suggest you rename `pages' to `nr_pages', `array' to `pages'.  And
    `i' to `page_nr'.

  - local var `bufs' could be renamed `nrbufs' to align with
    pipe_inode_info and could be made uint.

  - Do we actually need local var `bufs'?  It seems to be caching info->nrbufs.

  - release_pages() might be faster than one-at-a-time page_cache_release()


Anyway, that's all just low-level stuff.

What does the feature do?  How would one use it in an application?  Is it
intended that it be generalised to other kinds of address_spaces?  If so,
which ones, and what implementation problems might we expect?

(And I still don't know what `flags' does!)
