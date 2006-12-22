Return-Path: <linux-kernel-owner+w=401wt.eu-S1751655AbWLVR4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWLVR4f (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWLVR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:56:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33259 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbWLVR4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:56:34 -0500
Date: Fri, 22 Dec 2006 09:56:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Martin Michlmayr <tbm@cyrius.com>, Andrei Popa <andrei.popa@i-neo.ro>,
       Andrew Morton <akpm@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <1166793952.32117.29.camel@twins>
Message-ID: <Pine.LNX.4.64.0612220943360.3671@woody.osdl.org>
References: <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> 
 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> 
 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> 
 <20061221012721.68f3934b.akpm@osdl.org>  <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
  <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> 
 <20061222100004.GC10273@deprecation.cyrius.com>  <20061222021714.6a83fcac.akpm@osdl.org>
 <1166790275.6983.4.camel@localhost>  <20061222123249.GG13727@deprecation.cyrius.com>
  <20061222125920.GA16763@deprecation.cyrius.com> <1166793952.32117.29.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Dec 2006, Peter Zijlstra wrote:
> 
> fix page_mkclean_one()
> 
>  - add flush_cache_page() for all those virtual indexed cache
>    architectures.

I think the flush_cache_page() should be after we've actually flushed it 
from the TLB and re-inserted it (this is one reason why I did the 
"ptep_exchange()" version of this). Otherwise somebody can still write to 
the page _after_ the cache flush..

>  - handle s390.

Yeah, that looks like the proper way to handle that.

That said, it looks like we still see corruption. You may not, but Martin 
and Andrei still report problems, even with all the patches (including the 
last one from Andrew that avoids "dirty" going negative under some 
circumstances, and explains the "slow and/or never completed" case that 
Gordon and Martin saw).

The good news is that I think the code now is cleaner and more 
understandable. The bad news is that nothing we've ever tried seems to 
have fixed the _problem_.

And I don't think it's page_mkclean(). Especially not since the ARM people 
are seeing this under UP without PREEMPT. In that kind of schenario, the 
only possible races tend to be from things that actually block: 
"set_page_dirty()" (which blocks on IO in balancing), memory allocations, 
and obviously doing actual IO.

And it's not a virtual cache problem, since others see it on x86.

Of course, since it's quite possibly two different issues, maybe the 
virtual cache flush is required in order to force write-back to memory 
(which in turn is required for the DMA for the actual write!). So the ARM 
issue certainly could be due to the flush_cache_page() thing...

		Linus
