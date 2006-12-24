Return-Path: <linux-kernel-owner+w=401wt.eu-S1754176AbWLXIpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbWLXIpW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 03:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbWLXIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 03:45:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51488 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176AbWLXIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 03:45:21 -0500
Date: Sun, 24 Dec 2006 00:43:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> 
 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> 
 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> 
 <20061222100004.GC10273@deprecation.cyrius.com>  <20061222021714.6a83fcac.akpm@osdl.org>
  <1166790275.6983.4.camel@localhost>  <20061222123249.GG13727@deprecation.cyrius.com>
  <20061222125920.GA16763@deprecation.cyrius.com>  <1166793952.32117.29.camel@twins>
  <20061222192027.GJ4229@deprecation.cyrius.com>
 <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2006, Gordon Farquharson wrote:
> 
> Is there any way to provide any debugging information that may help
> solve the problem ?

I think we have people working on this. I know I'm trying to even come up 
with an idea of what is going on. I don't think we know yet.

> Would it help to know the nature of the corruption e.g. an analysis
> of the corruption in the file ?

I actually think we know that, because Andrei already gave details. The 
corruption seems to be basically a few pages that get zeroes at the end 
rather than the expected contents. That's consistent with the page being 
written out once, but then _not_ getting written out again despite being 
dirtied some more.

But if you see ay other pattern, please holler, because that would be 
interesting.

> BTW, I decided to try Linus's test program [1] on ARM (I don't think
> that anybody had tried it on ARM before).

You get the expected results, and in fact, I'd be very surprised if you 
didn't. It's something subtler than that going on.

I now _suspect_ that we're talking about something like

 - we started a writeout. The IO is still pending, and the page was 
   marked clean and is now in the "writeback" phase.
 - a write happens to the page, and the page gets marked dirty again. 
   Marking the page dirty also marks all the _buffers_ in the page dirty, 
   but they were actually already dirty, because the IO hasn't completed 
   yet.
 - the IO from the _previous_ write completes, and marks the buffers clean 
   again.

And no, thatr's not actually what is going on. The thing is, we actually 
clear the buffer dirty bits when we start the IO, not when we end it, but 
I think it is going to be this _kind_ of situation, where we missed 
something, and marked it clean too late, and thus cleared a dirty bit.

I don't think it's a page table issue any more, it just doesn't look 
likely with the ARM UP corruption. It's also not apparently even on a 
cacheline boundary, so it probably is really a dirty bit that got cleared 
wrogn due to some race with IO.

But right now we're all clueless. I personally suspect it's not even a new 
bug: it's probably an old bug that simply didn't matter before.
	
			Linus

