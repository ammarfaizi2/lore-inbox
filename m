Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSG2T7G>; Mon, 29 Jul 2002 15:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSG2T7F>; Mon, 29 Jul 2002 15:59:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317633AbSG2T7C>;
	Mon, 29 Jul 2002 15:59:02 -0400
Message-ID: <3D459ECE.C5BD53DE@zip.com.au>
Date: Mon, 29 Jul 2002 13:00:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] misc fixes
References: <3D439E09.3348E8D6@zip.com.au> <E17Z4v0-0002io-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
>...
> >
> > It is apparent that these problems will not be solved by tweaking -
> > some redesign is needed.  In the 2.5 timeframe the only practical
> > solution appears to be page table sharing, based on Daniel's February
> > work.  Daniel and Dave McCracken are working that.
> 
> Sadly, it turns out that there are no possibilities for page table sharing
> when forking from bash.  It turns out there are only about 200 pages being
> shared amonst three page tables (stack, text and .interp) and at least one
> page in each of these gets written during the exec, so all are unshared and
> hence there is no reduction in the number of pte chains that have to be
> created.  For forking from a larger parent, page table sharing has a
> measurable benefit, but not from these little guys.

Thanks for looking into this.
 
> But there is something massively wrong with this whole picture.  Your kickass
> 4 way is managing to set up and tear down only one pte chain node per
> microsecond, if I'm reading your benchmark results correctly.

s/kickass/slow as a wet sock/.

That little script which did 12,000 fork/exec/exits ran page_add_rmap
and page_remove_rmap about 4,000,000 times each, and total runtime
went from 30 seconds to 34.  So the combined overhead of both adding and
removing the reverse mapping is around a microsecond per page, yes.
That's four locked operations.

>  That's really
> horrible.  I think we need to revisit the locking.

Anton did some testing on a 4-way PPC.  Similar results, I think.
As an experiment he added a spinlock to the page structure and used
that instead of the PG_chainlock flag.  It helped a lot.  He thinks
that is because their spin_unlock() is not buslocked (like ia32).

Which tends to imply that a __clear_bit() in pte_chain_unlock()
will be beneficial.  I don't know how portable that would be though.

 
> The idea I'm playing with now is to address an array of locks based on
> something like:
> 
>         spin_lock(pte_chain_locks + ((page->index >> 4) & 0xff));
> 
> so that 16 consecutive filemap pages use the same lock and there is a limited
> total number of locks to keep cache pressure down.  Since we are creating the
> vast majority of the pte chain nodes while walking across page tables, this
> should give nice locality.

Something like that could help.

At some point, when the reverse map is as CPU efficient as we can make it,
we need to decide whether the remaining cost is worth the benefit.  I
wonder how to do that.
 
> For this to work, anon pages will need to have something in page->index.
> This isn't too much of a challenge.  A reasonable value to put in there is
> the creator's virtual address, shifted right, and perhaps mangled a little to
> reduce contention.

Well you want the likely-to-be-temporally-adjacent anon pages to
use the same lock.  So maybe

	page->index = some_global_int++;

Except ->index gets stomped on when the page gets added to swapcache.
Which means that the address of its lock will change.  I can't immediately
think of a fix for that.
