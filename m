Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317753AbSGVRzN>; Mon, 22 Jul 2002 13:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317754AbSGVRzM>; Mon, 22 Jul 2002 13:55:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42228 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317753AbSGVRzL>; Mon, 22 Jul 2002 13:55:11 -0400
Subject: Re: [PATCH] low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <3D3B94AF.27A254EA@zip.com.au>
References: <1027196427.1116.753.camel@sinai> 
	<3D3B94AF.27A254EA@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Jul 2002 10:58:04 -0700
Message-Id: <1027360686.932.33.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 22:14, Andrew Morton wrote:

> This adds probably-unneeded extra work - we shouldn't go
> dropping the lock unless that is actually required.  ie:
> poll ->need_resched first.    Possible?

Sure.  What do you think of this?

	spin_lock(&mm->page_table_lock);

	while (size) {
		block = (size > ZAP_BLOCK_SIZE) ? ZAP_BLOCK_SIZE : size;
		end = address + block;

		flush_cache_range(vma, address, end);
		tlb = tlb_gather_mmu(mm, 0);
		unmap_page_range(tlb, vma, address, end);
		tlb_finish_mmu(tlb, address, end);

		if (need_resched()) {
			/*
			 * If we need to reschedule we will do so
			 * here if we do not hold any other locks.
			 */
			spin_unlock(&mm->page_table_lock);
			spin_lock(&mm->page_table_lock);
		}

		address += block;
		size -= block;
	}

	spin_unlock(&mm->page_table_lock);

My only issue with the above is it is _ugly_ compared to the more
natural loop.  I.e., this looks much more like explicit lock breaking /
conditional rescheduling whereas the original loop just happens to
acquire and release the lock on each iteration.  Sure, same effect, but
I think its says something toward the maintainability and cleanliness of
the function.

One thing about the "overhead" here - the main overhead would be the
lock bouncing in between cachelines on SMP afaict.  However, either (a)
there is no SMP contention or (b) there is and dropping the lock
regardless may be a good idea.  Thoughts?

Hm, the above also ends up checking need_resched twice (the explicit
need_resched() and again on the final unlock)... we can fix that by
manually calling _raw_spin_unlock and then preempt_schedule, but that
could also result in a (much longer) needless call to preempt_schedule
if an intervening interrupt serviced the request first. 

But maybe that is just me... like this better?  I can redo the patch as
the above.

	Robert Love

