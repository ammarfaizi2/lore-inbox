Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSEWUGq>; Thu, 23 May 2002 16:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317000AbSEWUGp>; Thu, 23 May 2002 16:06:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52238 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316798AbSEWUGo>; Thu, 23 May 2002 16:06:44 -0400
Date: Thu, 23 May 2002 13:05:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
In-Reply-To: <20020523195757.GW21164@dualathlon.random>
Message-ID: <Pine.LNX.4.33.0205231300530.4338-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 May 2002, Andrea Arcangeli wrote:
> > 	munmap
> > 	.. speculation starts ..
> 
> the question is: can you explain how the speculative tlb fill can start?

Any indirect branch can be (and will be) predicted using the BTB. The
speculation starts before the BTB contents have actually been verified,
resulting in iTLB speculation.

Since the BTB can (and does) contain mostly user addresses (from previous
execution in user land), it's apparently quite common to speculatively
fetch user TLB entries even when you're in kernel mode.

(This is also, btw, probably anothre reason why you only see this bug in 
practice on a P4: much bigger BTB)

> see below.
> 
> > 	.. TLB looks up pgd entry ..
> > 	clear pgd entry
> > 	free pmd
> > 
> > 			alloc page - get old pmd
> > 			scribble on page
> > 
> > 	.. TLB looks up pmd entry ..
> > 	.. tlb fill ends ...
> > 	invalidate_tlb
> 	^^^^^^^^^^^^^^
> 
> I assume the userspace access could be imagined right after the
> invalidate_tlb in the above example, and that's the one supposed to
> trigger the speculative tlb fill but how can it pass the invalidate_tlb?
> see below.

It doesn't pass the invalidate_tlb.

By the time the invalidate_tlb happens, the TLB fill has already finished, 
and has already picked up garbage.

READ my explanation. The garbage can (and does) contain the Global bit, so
even though we then flush the TLB, the garbage remains.

> In all cases either the 2.4 fix is wrong,

No. Understand the patch, _then_ complain.

		Linus

