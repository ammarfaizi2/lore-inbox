Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289299AbSBSCIg>; Mon, 18 Feb 2002 21:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289297AbSBSCI1>; Mon, 18 Feb 2002 21:08:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42139 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289314AbSBSCIK>;
	Mon, 18 Feb 2002 21:08:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 03:12:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>,
        Rik van Riel <riel@conectiva.com.br>, <mingo@redhat.com>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181749110.24597-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181749110.24597-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16czlc-0000yu-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 02:53 am, Linus Torvalds wrote:
> On Tue, 19 Feb 2002, Daniel Phillips wrote:
> >
> > Somebody might read fault, changing an entry when we're in the middle of
> > copying it and might might do a duplicated read fault.
> 
> You're confusing the mm->mmap_sem with the page_table_lock.
> 
> The mm semaphore is really a read-write semaphore, and yes, there can be
> multiple faulters active at the same time readin gin pages.
> 
> But the page_table_lock is 100% exclusive, and while you hold the
> page_table_lock there is absolutely _not_ going to be any concurrent page
> faulting.

Sure there can be, because we only hold the mm->page_table_lock for this,
somebody could be faulting through another mm sharing the page table.  For
this reason I believe I have to look at the page table count, and unless
it's one, I have to do some extra exclusion.

> (NOTE! Sure, there might be another mm that has the same pmd shared, but
> that one is going to do an unshare before it actually touches anything in
> the pmd, so it's NOT going to change the values in the original pmd).

Actually, I was planning to keep the tables shared, even through swapin/
swapout.  The data remains valid for all mm's, whether it's in ram or in
swap.

> So I'm personally convinced that the locking shouldn't be needed at all,
> if you just make sure that you do things in the right order (that, of
> course, might need some memory barriers, which had better be implied by
> the atomic dec-and-test anyway).

You've convinced me that it can be considerably streamlined, which is
great, but it can't all go, and even now there's some missing.

-- 
Daniel
