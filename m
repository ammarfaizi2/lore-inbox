Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSGVSrI>; Mon, 22 Jul 2002 14:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317730AbSGVSrI>; Mon, 22 Jul 2002 14:47:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52465 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315923AbSGVSrH>; Mon, 22 Jul 2002 14:47:07 -0400
Subject: Re: [PATCH] low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <3D3C517F.6BD3650A@zip.com.au>
References: <3D3B94AF.27A254EA@zip.com.au> <1027360686.932.33.camel@sinai> 
	<3D3C517F.6BD3650A@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Jul 2002 11:50:06 -0700
Message-Id: <1027363806.931.64.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 11:40, Andrew Morton wrote:

> Disagree, really.  It's not a thing of beauty, but it is completely
> obvious what the code is doing and why it is doing it.  There are
> no subtle side-effects and the whole lot can be understood from a
> single screenful.  Unmaintainable code is code which requires you
> to spend days crawling all over the tree working out what it's doing
> any why it's doing it.  It's awkward, but it's simple, and I wouldn't
> get very worked up over it personally.

I agree with your points although I do not find the previous version any
less of this.

> Hard call.   In general I suspect it's best to hold onto a lock
> for as long as possible, get a lot of work done rather than
> reacquiring it all the time.  But there are some locks which are
> occasionally held for a very long time and are often held for very
> short periods.  Such as this one (mm->page_table_lock) and pagemap_lru_lock.
> In those cases, dropping the lock to let someone else get in, out and
> away may help.  But not as much as a little bit of locking redesign...

Agreed.

> zap_page_range is sometimes called under another lock, (eg, vmtruncate_list).
> So there's nothing useful to be done there.  Perhaps you should test
> ->preempt_count as well - if it's greater than one then don't bother with
> the lock dropping.

Hrm, this means cond_resched_lock() is out of the question here, then.

We could use break_spin_locks() but that would mean we drop the lock w/o
checking for need_resched (or wrap it in need_resched() and then we
check twice).

Finally, we could take your approach, change cond_resched_lock() to be:

	if (need_resched() && preempt_count() == 1) {
		spin_unlock_no_resched(lock);
		__cond_resched();
		spin_lock(lock);
	}

but then we need to break the function up into a preempt and a
non-preempt version as preempt_count() unconditionally returns 0 with
!CONFIG_PREEMPT.  Right now the functions I posted do the right thing on
any combination of UP, SMP, and preempt.

Thoughts?

> This, btw, probably means that your code won't be very effective yet: large
> truncates will still exhibit poor latency.  However, truncate _is_ something
> which we can improve algorithmically.  One possibility is to implement a
> radix tree split function: split the radix tree into two trees along the
> truncation point, clean up the end and then drop the bulk of the pages
> outside locks.

I would _much_ prefer to tackle these issues via better algorithms...
your suggestion for truncate is good.

Note that I make an exception here (part of my argument for a preemptive
kernel was no more need to do "hackish" conditional scheduling and lock
breaking) because there really is not much you can do to this
algorithm.  It does a lot of work on potentially a lot of data and the
cleanest solution we have is to just break it up into chunks.

	Robert Love

