Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVJXDjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVJXDjO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 23:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVJXDjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 23:39:14 -0400
Received: from gold.veritas.com ([143.127.12.110]:6803 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750951AbVJXDjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 23:39:13 -0400
Date: Mon, 24 Oct 2005 04:38:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: clameter@sgi.com, rmk@arm.linux.org.uk, matthew@wil.cx, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
In-Reply-To: <20051023152245.4d1dc812.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0510240412350.22131@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
 <20051023142712.6c736dd3.akpm@osdl.org> <20051023152245.4d1dc812.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 03:39:13.0337 (UTC) FILETIME=[80687290:01C5D84C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2005, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >  Hugh Dickins <hugh@veritas.com> wrote:
> >  >
> >  > In this implementation, the spinlock is tucked inside the struct page of
> >  >  the page table page: with a BUILD_BUG_ON in case it overflows - which it
> >  >  would in the case of 32-bit PA-RISC with spinlock debugging enabled.
> > 
> >  eh?   It's going to overflow an unsigned long on x86 too:
> 
> Ah, I think I see what you've done: assume that .index, .lru and .virtual
> are unused on pagetable pages, so we can just overwrite them.

That's right (so I'm ignoring some of your earlier stabs).
Sorry, it's looking like my comment block was inadequate.

I'm also assuming that it'd be very quickly noticed, by bad_page
or otherwise, if anyone changes these fields, so that what it's
overwriting becomes significant.

Would it be better if pte_lock_init(page) explicitly initialize each
field from _page->index onwards, so that any search for uses of that
page field shows up pte_lock_init?  With the BUILD_BUG_ON adjusted
somehow so _page->virtual is excluded (I tend to erase that one from
my mind, but we most certainly don't want a spinlock overwriting it).

> ick.  I think I prefer the union, although it'll make struct page bigger
> for CONFIG_PREEMPT+CONFIG_SMP+NR_CPUS>=4.    hmm.

Hmm indeed.  Definitely not the tradeoff I chose or would choose.

Hugh
