Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSGVSjL>; Mon, 22 Jul 2002 14:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317165AbSGVSjL>; Mon, 22 Jul 2002 14:39:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26884 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317026AbSGVSjJ>;
	Mon, 22 Jul 2002 14:39:09 -0400
Message-ID: <3D3C517F.6BD3650A@zip.com.au>
Date: Mon, 22 Jul 2002 11:40:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] low-latency zap_page_range
References: <3D3B94AF.27A254EA@zip.com.au> <1027360686.932.33.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Sun, 2002-07-21 at 22:14, Andrew Morton wrote:
> 
> > This adds probably-unneeded extra work - we shouldn't go
> > dropping the lock unless that is actually required.  ie:
> > poll ->need_resched first.    Possible?
> 
> Sure.  What do you think of this?
> 
>         spin_lock(&mm->page_table_lock);
> 
>         while (size) {
>                 block = (size > ZAP_BLOCK_SIZE) ? ZAP_BLOCK_SIZE : size;
>                 end = address + block;
> 
>                 flush_cache_range(vma, address, end);
>                 tlb = tlb_gather_mmu(mm, 0);
>                 unmap_page_range(tlb, vma, address, end);
>                 tlb_finish_mmu(tlb, address, end);
> 
>                 if (need_resched()) {
>                         /*
>                          * If we need to reschedule we will do so
>                          * here if we do not hold any other locks.
>                          */
>                         spin_unlock(&mm->page_table_lock);
>                         spin_lock(&mm->page_table_lock);
>                 }
> 
>                 address += block;
>                 size -= block;
>         }
> 
>         spin_unlock(&mm->page_table_lock);
> 
> My only issue with the above is it is _ugly_ compared to the more
> natural loop.  I.e., this looks much more like explicit lock breaking /
> conditional rescheduling whereas the original loop just happens to
> acquire and release the lock on each iteration.  Sure, same effect, but
> I think its says something toward the maintainability and cleanliness of
> the function.

Disagree, really.  It's not a thing of beauty, but it is completely
obvious what the code is doing and why it is doing it.  There are
no subtle side-effects and the whole lot can be understood from a
single screenful.  Unmaintainable code is code which requires you
to spend days crawling all over the tree working out what it's doing
any why it's doing it.  It's awkward, but it's simple, and I wouldn't
get very worked up over it personally.

> One thing about the "overhead" here - the main overhead would be the
> lock bouncing in between cachelines on SMP afaict.  However, either (a)
> there is no SMP contention or (b) there is and dropping the lock
> regardless may be a good idea.  Thoughts?

Hard call.   In general I suspect it's best to hold onto a lock
for as long as possible, get a lot of work done rather than
reacquiring it all the time.  But there are some locks which are
occasionally held for a very long time and are often held for very
short periods.  Such as this one (mm->page_table_lock) and pagemap_lru_lock.
In those cases, dropping the lock to let someone else get in, out and
away may help.  But not as much as a little bit of locking redesign...

> Hm, the above also ends up checking need_resched twice (the explicit
> need_resched() and again on the final unlock)... we can fix that by
> manually calling _raw_spin_unlock and then preempt_schedule, but that
> could also result in a (much longer) needless call to preempt_schedule
> if an intervening interrupt serviced the request first.

zap_page_range is sometimes called under another lock, (eg, vmtruncate_list).
So there's nothing useful to be done there.  Perhaps you should test
->preempt_count as well - if it's greater than one then don't bother with
the lock dropping.

This, btw, probably means that your code won't be very effective yet: large
truncates will still exhibit poor latency.  However, truncate _is_ something
which we can improve algorithmically.  One possibility is to implement a
radix tree split function: split the radix tree into two trees along the
truncation point, clean up the end and then drop the bulk of the pages
outside locks.

However that's probably going a bit far - my preferred approach would
be to implement a radix tree gang-lookup function.  "Find me the next
N pages above index I".  No more list-walking in truncate.  We can use
gang-lookup nicely in truncate, in readahead and in writeback.  But no
immediate plans on that one, alas.

-
