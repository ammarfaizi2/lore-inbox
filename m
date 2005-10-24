Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVJXERX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVJXERX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 00:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVJXERW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 00:17:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750969AbVJXERW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 00:17:22 -0400
Date: Sun, 23 Oct 2005 21:16:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: clameter@sgi.com, rmk@arm.linux.org.uk, matthew@wil.cx, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
Message-Id: <20051023211630.44459ff7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0510240412350.22131@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
	<20051023142712.6c736dd3.akpm@osdl.org>
	<20051023152245.4d1dc812.akpm@osdl.org>
	<Pine.LNX.4.61.0510240412350.22131@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Sun, 23 Oct 2005, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >  Hugh Dickins <hugh@veritas.com> wrote:
> > >  >
> > >  > In this implementation, the spinlock is tucked inside the struct page of
> > >  >  the page table page: with a BUILD_BUG_ON in case it overflows - which it
> > >  >  would in the case of 32-bit PA-RISC with spinlock debugging enabled.
> > > 
> > >  eh?   It's going to overflow an unsigned long on x86 too:
> > 
> > Ah, I think I see what you've done: assume that .index, .lru and .virtual
> > are unused on pagetable pages, so we can just overwrite them.
> 
> That's right (so I'm ignoring some of your earlier stabs).
> Sorry, it's looking like my comment block was inadequate.
> 
> I'm also assuming that it'd be very quickly noticed, by bad_page
> or otherwise, if anyone changes these fields, so that what it's
> overwriting becomes significant.

Well it won't necesarily be noticed quickly - detecting an overflow depends
upon the right settings of CONFIG_PREEMPT, CONFIG_SMP, CONFIG_NR_CPUS,
WANT_PAGE_VIRTUAL, CONFIG_PAGE_OWNER and appropriate selection of
architecture and the absence of additional spinlock debugging patches and
the absence of reworked struct page layout!

I'm rather surprised that no architectures are already using page.mapping,
.index, .lru or .virtual in pte pages.

> Would it be better if pte_lock_init(page) explicitly initialize each
> field from _page->index onwards, so that any search for uses of that
> page field shows up pte_lock_init?  With the BUILD_BUG_ON adjusted
> somehow so _page->virtual is excluded (I tend to erase that one from
> my mind, but we most certainly don't want a spinlock overwriting it).
> 
> > ick.  I think I prefer the union, although it'll make struct page bigger
> > for CONFIG_PREEMPT+CONFIG_SMP+NR_CPUS>=4.    hmm.
> 
> Hmm indeed.  Definitely not the tradeoff I chose or would choose.

It's not that bad, really.  I do think that this approach is just too
dirty, sorry.  We can avoid it by moving something else into the union. 
lru, perhaps?
