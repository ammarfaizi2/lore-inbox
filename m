Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUCOANT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 19:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUCOANT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 19:13:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20742
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262080AbUCOANR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 19:13:17 -0500
Date: Mon, 15 Mar 2004 01:14:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040315001400.GX30940@dualathlon.random>
References: <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp> <Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades> <20040314121503.13247112.akpm@osdl.org> <20040314230138.GV30940@dualathlon.random> <20040314152253.05c58ecc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314152253.05c58ecc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 03:22:53PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > 
> > > Having a magic knob is a weak solution: the majority of people who are
> > > affected by this problem won't know to turn it on.
> > 
> > that's why I turned it _on_ by default in my tree ;)
> 
> So maybe Marcelo should apply this patch, and also turn it on by default.

yes, I would suggest so. If anybody can find any swap-regression on
small UP machines then reporting to us on l-k will be welcome. So far
nobody could notice any swap difference at swap regime AFIK, and the
improvement for the fast path is dramatic on the big smp boxes.

> > There are workloads where adding anonymous pages to the lru is
> > suboptimal for both the vm (cache shrinking) and the fast path too
> > (lru_cache_add), not sure how 2.6 optimizes those bits, since with 2.6
> > you're forced to add those pages to the lru somehow and that implies
> > some form of locking.
> 
> Basically a bunch of tweeaks:
> 
> - Per-zone lru locks (which implicitly made them per-node)

the 16-ways weren't numa, and these days 16-ways HT (8-ways phys) are
not so uncommon anymore.

> 
> - Adding/removing sixteen pages for one taking of the lock.
> 
> - Making the lock irq-safe (it had to be done for other reasons, but
>   reduced contention by 30% on 4-way due to not having a CPU wander off to
>   service an interrupt while holding a critical lock).
> 
> - In page reclaim, snip 32 pages off the lru completely and drop the
>   lock while we go off and process them.

sounds good, thanks.

I don't see other ways to optimize it (and I never enjoyed too much the
per-zone lru since it has some downside too with a worst case on 2G
systems). peraphs a further optimization could be a transient per-cpu
lru refiled only by the page reclaim (so absolutely lazy while lots of
ram is free), but maybe that's already what you're doing when you say
"Adding/removing sixteen pages for one taking of the lock". Though the
fact you say "sixteen pages" sounds like it's not as lazy as it could
be.
