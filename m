Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTIAUzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTIAUzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:55:38 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:28696 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263267AbTIAUzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:55:35 -0400
Date: Mon, 1 Sep 2003 21:57:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-Reply-To: <20030901041539.9FF942C082@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0309012053110.1817-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Rusty Russell wrote:
> 
> This is the latest version of my futex patch.  I think we're getting
> closer.

Miscellaneous comments:

1. Please leave mm/page_io.c out of it.  rw_swap_page_sync used to
be just for swapon to read the header page of a swap area: it seems
swapon no longer uses it, but kernel/power/swsusp.c has grabbed it.
It would be very much better if that had a bdev_write_page to match
its bdev_read_page, and we could delete rw_swap_page_sync; but that's
not for your patch (and I've no inclination to get into swsusp either).

rw_swap_page_sync is just a way of hacking page->mapping and page->index
temporarily, in order to make use of some lowlevel swapio routines.  If
futexes really need to be looked up at that stage of swsusp, you're in
trouble anyway.  And (though I may be quite wrong, not knowing swsusp)
it looks like doing futex_rehash there could actually introduce errors -
the page containing the corresponding struct futex_q would get suspended
to disk with mapping wrongly set to &swapper_space, so lookups would get
missed after resume.

2. Please leave mm/swap_state.c's move_to_swap_cache and move_from_swap_
cache out of it.  I already explained how those are for tmpfs files, and
it's only the file mapping and index you need to worry about, you won't
see a such page while it's assigned to swapper_space.  If you're anxious
to show that you've visited everywhere that modifies page->mapping, then
add a comment or BUG, but not code which could mislead people into
thinking futexes really need to be rehashed there.

3. Please remove reference to move_xxx_swap_cache from locking hierarchy
comment in mm/filemap.c.  And reference to swap_out_add_to_swap_cache:
probably meant to say move_to_page_cache (I'm not keen on that name,
too much like the unrelated _swap_cache pair, but never mind, it'll do).

4. You've added a comment line to mm/truncate.c truncate_complete_page,
but that's the wrong place for it.  If you are going to do something
about truncation, then you need to do it whether or not the page is
currently in cache: needs to be a mapping/indexrange thing not a struct
page* thing.  Do you need to do anything at all?  I hope not, but unsure.

5. If you're not doing anything in __remove_from_page_cache (rightly
trying to avoid hotpath), you do need to futex_rehash in mm/swap_state.c
__delete_from_swap_cache (last time I did say without the __s, but that
would miss an instance you need to catch).  That will handle the swapoff
case amongst others.

6. The futex_q has no reference count on struct address_space *mapping.
A task might set a futex in a shared file mapping, get a futex fd,
unmap the mapping, delete the file, poll the fd, and be woken for
events on whatever (if anything) next got a struct address_space at
that same address?  Is this a possible scenario, and is it a worry?

Hugh

