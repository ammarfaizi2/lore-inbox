Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWC3Hp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWC3Hp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWC3Hp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:45:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27670 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751312AbWC3HpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:45:25 -0500
Date: Thu, 30 Mar 2006 09:45:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330074534.GL13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329143758.607c1ccc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(going over the other comments, thanks a lot for taking a good look
Andrew!)

On Wed, Mar 29 2006, Andrew Morton wrote:
> - Please don't call it `len'.  VFS has to deal with "lengths" which can
>   be in units of PAGE_CACHE_SIZE, fs blocksize, 512-bytes sectors or bytes,
>   and it gets confusing.  Our liking for variable names like `len' and
>   `count' just makes it worse.
> 
>   If it's in units of pages then call it `npages'.  If it's in bytes then
>   call it `nbytes'.

Hmm well I usually use 'len' or something like that when it's a base
unit, like bytes. If it was in units of pages or something I agree it
would be confusing.

>   What _is_ it in units of, anyway?  I guess bytes, since it's size_t.
> 
>   I assume all this lenning:
> 
> 			unsigned int this_len;
> 
> 			this_len = buf->len;
> 			if (this_len > len)
> 				this_len = len;
> 
>   is dealing with bytes too.  You'll be wanting a size_t in there.

But buf->len is unsigned int to begin with.

> - I think the `size_t left' in do_splice_to() can overflow if f_pos is
>   sufficiently different from i_size.

They're both loff_t.

> - In pipe_to_file():
> 
>   - Shouldn't it be using GFP_HIGHUSER()?
> 
>   - local variable `index' should be unsigned long or, for clarity
>     value, pgoff_t.

Fixed.

>   - Incoming arg `pos' should be loff_t?

Fixed

>   - It's racy against truncate().  After running ->readpage and
>     lock_page(), need to check for page->mapping == NULL.

Indeed, fixed.

>   - There's a duplicate flush_dcache_page().

Doh, fixed.

>   - Why does it run write_one_page()???  (Don't tell me.  I'll work it
>     out when I see the commented version ;))

Can probably go, will re-check!

>   - I worry a bit about the assumption in one place that a non-zero
>     return from commit_write() indicates an error, whereas another place
>     assumes that a negative return is an error.  We had problems in the
>     past where some a_ops implementations decided to return small positive
>     numbers from prepare_write() or commit_write() a_ops, which broke
>     stuff.  They shouldn't be doing that now, but it's a thing to watch out
>     for.

I'll just check for < 0 and be safe.

>   - Bug.  If write_one_page() returned an error, it still unlocked the page.

Ok, I guess that could be a future but (it can't fail with !wait now).

> - In pipe_to_sendpage():
> 
>   - local variable `offset' is ulong, but elsewhere you've used uint. 
>     The latter is better.

Fixed.

>   - Again, incoming arg `len' is confusing.  I _think_ it's actually
>     "number of bytes to be moved from this page".  A comment which explains
>     these things would be nice, and perhaps a better name (bytes_to_send?)

It's bytes, yes. Comment added.

>   - Should incoming arg `pos' be loff_t?  That would give it some meaning.

Yes changed with the pipe_to_file() change since it modified the actor
typedef anyways.

>   - Why does it use PAGE_SIZE and PAGE_SHIFT rather than PAGE_CACHE_*?

Fixed, the other places used PAGE_CACHE_*.

> - In generic_file_splice_read():
> 
>   - nonatomic modification of f_pos.  Is i_mutex held?  (see
>     generic_file_llseek())

Fixed.

>   - Darnit, we carried `flags' this far and ended up not using it. 
>     (What _does_ flags do, anyway?  Reads on..)

It'll be passed to the actor next! Will probably change some of the
actor args into a little struct instead of passing so many variables.

> - In __generic_file_splice_read():
> 
>   - local variable `index' is ulong, could be pgoff_t (for clarity)

Fixed.

>   - local variable `offset' could be uint (it is uint elsewhere, and
>     might generate better code).

Fixed.

>   - local variable `pages' could be uint (but watch out for overflow!!).

Fixed.

>     A better name might be nr_pages (matches find_get_pages()).  Then,
>     local variable `array' can be renamed to `pages', which is all much
>     better.

Agree, fixed.

>   - whoa.  We move the pages into the pipe while they're still under
>     read I/O.  Is that deliberate?  (pls add nice comment).

It's fine, you need to call ->map() to get at it anways, which will lock
the page.

>   - These pages can get truncated at any time they're unlocked.  Does
>     the code cope with all that?

I guess page_cache_pipe_buf_map() needs the same ->mapping check?

>   - hm.  What happens if the pages which find_get_pages() returned are
>     not contiguous in pagecache?  I think your `pages' array gets all
>     jumbled up.

Hmm please expand.

> - In move_to_pipe()
> 
>   - Suggest you rename `pages' to `nr_pages', `array' to `pages'.  And
>     `i' to `page_nr'.

Done (except 'i').

>   - local var `bufs' could be renamed `nrbufs' to align with
>     pipe_inode_info and could be made uint.
> 
>   - Do we actually need local var `bufs'?  It seems to be caching info->nrbufs.

Cleaner that way, imho.

>   - release_pages() might be faster than one-at-a-time page_cache_release()

We should not hit that case very often. Not sure how to handle the
'cold' right now, so I'll just leave it.

-- 
Jens Axboe

