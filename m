Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbTL0FC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 00:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbTL0FC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 00:02:56 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:46547 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265321AbTL0FCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 00:02:53 -0500
Subject: Re: Page aging broken in 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20031227023752.GF1676@dualathlon.random>
References: <1072423739.15458.62.camel@gaston>
	 <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
	 <1072482941.15458.90.camel@gaston>
	 <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
	 <1072485899.15456.96.camel@gaston>
	 <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
	 <1072487027.15476.105.camel@gaston>
	 <20031227023752.GF1676@dualathlon.random>
Content-Type: text/plain
Message-Id: <1072501324.15477.116.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 16:02:05 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Returning to the "how to flush the tlb after clearing the young bit", at
> least on the x86 I find more desiderable to flush based on mm (in UP
> that's the most efficient and it provides an accurate behaviour, in SMP
> it maybe still to costly but sure a lot less costly than a broadcast per
> pte).  In 2.4 with the pagetable scan the flush per mm is
> strightforward and  it provides a very high probability of optimizing
> away an huge lot of spurious IPI broadcast. But even in 2.6 the vm is
> unmapping stuff with some aggressive clustering algorithm so that when
> it starts umapping stuff it drops quite some stuff and there's still a
> relevant probability that only a few mm have to be flushed, which in SMP
> can decrease a lot the need of IPIs.  Not sure how these flush_tlb_mm
> ideas translates for ppc though.

Since we use the hash as a TLB cache, we need to evict things from
it where you would do a flush_tlb. A flush_tlb_mm (or a range) is
fairly expensive. We have to calculate the hash value for each page
and evict them all. Also, the "nice" thing with this hash is since
we have the vsid's (kind of address space number), we can hold
many processes translations in there for a long time.

On the other hand, we don't need IPIs for any kind of flush (the
actual TLB flushes that we perform after evicting the hash entries
do broadcast in HW).

> The dirty and accessed bitflags instead are quite a different matter
> w.r.t to tlb flushing, we can't defer the tlb flush after atomically
> clearing the pte in smp while we clear the dirty bit. the tlb shootdown
> is the clustered version of that. the shootdown run a broadcast IPI
> not more than every 508 pte freed per mm. For the same reason we can try
> to coalesce the tlb flush post-clear-young with an mm flush, we can
> achieve a similar coalescing without the no need of an exact tlb
> shootdown like in the pte freeing



