Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277410AbRJEPZ5>; Fri, 5 Oct 2001 11:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277413AbRJEPZs>; Fri, 5 Oct 2001 11:25:48 -0400
Received: from [204.177.156.37] ([204.177.156.37]:5760 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S277410AbRJEPZi>; Fri, 5 Oct 2001 11:25:38 -0400
Date: Fri, 5 Oct 2001 16:27:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Bernd Harries <bha@gmx.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <3BBDB662.CB729213@gmx.de>
Message-ID: <Pine.LNX.4.21.0110051554020.1187-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Bernd Harries wrote:
> Hugh Dickins wrote:
> 
> > I don't
> > know whether you're following the mmap-makes-all-pages-present
> > model (using remap_page_range), or the fault-page-by-page model
> > (supplying your own nopage function). 
> 
> The nopage method. In Alessandro Rubini's book (p.391) I read, that
> I can't use remap_page_range() on pages optained by get_free_page().

I just looked that up.  Rubini is right that remap_page_range only
works as you'd want on reserved pages, and pages which fail the
VALID_PAGE(page) test (I'm trying to avoid saying "invalid pages"),
and there is a good reason for that.  But Rubini omits to mention
mem_map_reserve, which can be used (on pages you own exclusively)
to mark a page as temporarily reserved, so remap_page_range will
then work as you'd want on it (with mem_map_unreserve to undo later).

The mem_map_reserve, remap_page_range model is commoner in drivers
than the nopage model; but it is somewhat deprecated now, Linus for
one certainly preferring the nopage model; and the VM_RESERVED vma
flag can give pages that immunity from swap_out which mem_map_reserve
also confers.  You're not wrong to follow the nopage model.

> Hmm, the only thing that happens to them after munmap() is 
> free_pages(). I don't access the pages anymore. But maybe some code in free_pages does? Or decrements count to -1?

I've forgotten by now what your precise symptoms were.  But either
pages would be freed twice and allocated twice; or they would hit a
BUG() statement in second free or second allocation; neither good.

> > Either you should force page count 1 on each of the 
> > order-0-pages before you mmap them in (and raise count to 2);
> 
> by get_page(), right?

Fine; and I expect you'll need to undo it later by appropriate put_page()s.

> Ok, thanks a lot. So it's definitely insufficient how my minor 26 version handles the pages, right? If so, that's a statement I can live with.
> 
> And it was never ment that I could simply mmap the upper pages to userspace directly, without 'touching' each page, was it? 

Probably all the drivers which use higher order allocations are using
the older, mem_map_reserve + remap_page_range method; the reserved
bit preserves a page against freeing whatever its page count.  Maybe
you're the first to use the nopage method on a higher order allocation
(or maybe not, and there are already drivers working around it).

I wouldn't claim the way it is currently is ideal design: I think
you've hit a not entirely satisfactory but easily worked around oddity,

Hugh

