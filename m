Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136214AbREILIB>; Wed, 9 May 2001 07:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136244AbREILHl>; Wed, 9 May 2001 07:07:41 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:24292 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S136214AbREILHe>; Wed, 9 May 2001 07:07:34 -0400
Date: Wed, 9 May 2001 10:46:08 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles 
In-Reply-To: <15096.22053.524498.144383@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105090957420.31900-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 May 2001, David S. Miller wrote: 
> Actually, the change was made because it is illogical to try only
> once on multi-order pages.  Especially because we depend upon order
> 1 pages so much (every task struct allocated).  We depend upon them
> even more so on sparc64 (certain kinds of page tables need to be
> allocated as 1 order pages).
> 
> The old code failed _far_ too easily, it was unacceptable.
> 
> Why put some strange limit in there?  Whatever number you pick
> is arbitrary, and I can probably piece together an allocation
> state where the choosen limit is too small.

  Agreed, but some allocations of non-zero orders can fall back to other
schemes (such as an emergency buffer, or using vmalloc for a temp
buffer) and don't want to be trapped in __alloc_pages() for too long.

  Could introduce another allocation flag (__GFP_FAIL?) which is or'ed
with a __GFP_WAIT to limit the looping?

> So instead, you could test for the condition that prevents any
> possible forward progress, no?

  Yes, it is possible to trap when kswapd might not make any useful
progress for a failing non-zero ordered allocation, and to set a global
"force" flag (kswapd_force) to ensure it does something useful.
  For order-1 allocations, that would work.

  For order-2 (and above) it becomes much more difficult as the page
'reap' routines release/process pages based upon age and do not factor in
whether a page may/will buddy (now or in the near future).  This 'blind'
processing of pages can wipe a significant percentage of the page cache
when trying to build a buddy at a high order.

  Of course, no one should be doing really large order allocations and
expecting them to succeed.  But, if they are doing this, the allocation
should at least fail.

Mark

