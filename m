Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTHZEDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTHZEDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:03:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:64184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262573AbTHZEDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:03:23 -0400
Date: Mon, 25 Aug 2003 21:06:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030825210606.5912bac4.akpm@osdl.org>
In-Reply-To: <20030826031940.0CDDD2C243@lists.samba.org>
References: <20030826031940.0CDDD2C243@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Hi Andrew, Ingo,
> 
> 	Ingo was (rightfully) concerned about the amount of memory
> which could be pinned using FUTEX_FD.  This solution doesn't keep
> pages pinned any more: it hashes on mapping + offset, or for anonomous
> pages, uses a callback to move them out and back into the hash table
> as they are swapped out and in.

I have a bad feeling about this.  We shall see...

> 	Searching the (256-bucket) hash table to find potential pages
> is fairly slow, but we're swapping anyway, so it's lost in the noise.
> The hash table is usually fairly empty.
> 
> 	My only concern is for a race between swapping a page in and
> it being accessed, but I think I have the callbacks in the right place
> in the swap code: more VM-aware eyes welcome.

Looks to be OK: as long as the page is locked you can't go far wrong.

But end_swap_bio_read() is called from interrupt context.  Hence the
spinlock you have in there needs to become IRQ safe.

Two issues:

a) what to do about futexes in file-backed pages?  At present the
   attacker can pin arbitrary amount of memory by backing it with a file.

   Your solution won't scale to solving this, because we need to perform
   a futex lookup on every add_to_page_cache().  (Well, it will scale
   fairly well because add_to_page_cache() is ratelimited by the IO speed. 
   But it will still suck quite a bit for some people).

b) Assuming a) is solved: futexes which are backed by tmpfs.  tmpfs
   (which is a study in conceptual baroquenness) will rewrite page->mapping
   as pages are moved between tmpfs inodes and swapper_space.  I _think_
   lock_page() is sufficient to serialise against this.  If not, both
   ->page_locks are needed.

   This of course will break your hashing scheme.  Hooks in
   move_to_swap_cache() and move_from_swap_cache() are needed.


So what to do?  One option is to just not pin the pages at all: let them be
reclaimed and/or swapped out.  Let the kernel fault them in.  We have all
the stuff to do this over in fs/aio.c, with use_mm().

It does mean that the futex code would have to change its representation of
a futex's location from page/offset to mm/vaddr, and the futex code would
need to hook into the exit path, similar to exit_aio().

Or create RLIM_NRFUTEX.


