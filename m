Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTH0GRv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbTH0GRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:17:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:63962 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263140AbTH0GRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:17:48 -0400
Date: Tue, 26 Aug 2003 23:20:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030826232039.626f5a4c.akpm@osdl.org>
In-Reply-To: <20030827051853.181C92C0C1@lists.samba.org>
References: <20030825210606.5912bac4.akpm@osdl.org>
	<20030827051853.181C92C0C1@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> In message <20030825210606.5912bac4.akpm@osdl.org> you write:
>  > But end_swap_bio_read() is called from interrupt context.  Hence the
>  > spinlock you have in there needs to become IRQ safe.
> 
>  OK, I've fixed that, with conservative assumptions (so it doesn't
>  assume context).  Or is _bh sufficient?

spin_lock_irq/irqsave is correct.

>  > Two issues:
>  > 
>  > a) what to do about futexes in file-backed pages?  At present the
>  >    attacker can pin arbitrary amount of memory by backing it with a file.
> 
>  At present == 2.6.0-test4?  In 2.6.0-test4, the attacker can pin one
>  page per process (OK), or on per FD using FUTEX_FD (not OK).  This
>  patch changes it so that pages are *never* pinned, whatever is backing
>  them.

oh, OK.

>  >    Your solution won't scale to solving this, because we need to perform
>  >    a futex lookup on every add_to_page_cache().  (Well, it will scale
>  >    fairly well because add_to_page_cache() is ratelimited by the IO speed. 
>  >    But it will still suck quite a bit for some people).
> 
>  I assumed that for non-anonymous pages the mapping + index was always
>  a unique identifier, even as they were swapped out.  We need a
>  persistent unique identifier for a page, OR a callback to
>  unhash/rehash it when the identifier changes.  Hence mapping + index
>  where mapping != NULL, and the struct page and callbacks for swap
>  pages.  Using the callbacks for wherever else page->mapping changes is
>  simple (but may be slow).

swap_writepage() and end_swap_bio_read() are not really companion
functions.  The page is in use and may be mapped into user pagetables
during swap_writepage().  It won't actually be freed up for a very long
time, if at all.

I guess this means that there could be a large number of futexes which are
considered "swapped out" which are in fact not swapped out at all.  

I'm starting to dimly understand what this code does.  You get 2/10 for
patch explanation ;)

I think a better place to rehash the futex would be at the point where the
page is added to and removed from swapcache.

When the page is in swapcache it has stable ->mapping and ->index and can
be treated in the same way as file-backed MAP_SHARED memory.

If this works then the places to be looking are:

__delete_from_swap_cache(): page moves from swapcache to anon

add_to_swap(): page moves from anon to swapcache.

move_to_swap_cache(): file-backed to swapcache

move_from_swap_cache(): swapcache to file-backed.


The locking you have there in move_to_swap_cache() and
move_from_swap_cache() look wrong.  Take move_to_swap_cache(): there is a
window in which the page has mapping==&swapper_space, but it is hashed over
in futex land by the old tmpfs mapping.  A futex lookup which is concurrent
with move_to_swap_cache() will fail to find the futex.

I think that to resolve this you need to take futex_lock while swizzling
the mapping and index in move_to_swap_cache():

	spin_lock(&swapper_space.page_lock);
	spin_lock(&mapping->page_lock);
+	spin_lock(&futex_lock);

	err = radix_tree_insert(&swapper_space.page_tree, entry.val, page);
	if (!err) {
		__remove_from_page_cache(page);
		___add_to_page_cache(page, &swapper_space, entry.val);
+		__futex_rehash(page);
	}

+	spin_unlock(&futex_lock);
	spin_unlock(&mapping->page_lock);
	spin_unlock(&swapper_space.page_lock);

Similarly, all places which change the page's hash keys (mapping and index)
need to be locked against the futex lookup code.

None of the above four functions are performance-critical; they already take
a ton of global locks.


Alternative: just use swapper_space.page_lock when you're doing futex
lookups.  That will pin down the ->mapping and ->index of anonymous,
swapcache and tmpfs pages.


Please make sure it builds with CONFIG_SWAP=n

Please make sure it builds with CONFIG_FUTEX=n (sorry)

Please augment the lock ranking comment at the top of filemap.c


If a futex resides in a pagecache page which is then truncated, a
futex_wake() should really send the caller a SIGBUS; it looks like the code
will return -EFAULT, which is good enough.  Any waiters on that futex will
not be wakeable, but they will be killable.

