Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTL0Ax6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTL0Ax6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:53:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:63906 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265287AbTL0Ax4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:53:56 -0500
Date: Fri, 26 Dec 2003 16:53:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: Page aging broken in 2.6
In-Reply-To: <1072485899.15456.96.camel@gaston>
Message-ID: <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston>  <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
  <1072482941.15458.90.camel@gaston>  <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
 <1072485899.15456.96.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Dec 2003, Benjamin Herrenschmidt wrote:
> > 
> > The dirty handling already does the TLB flush (in that case it's a 
> > correctness issue, not a hint). So it's only ptep_test_and_clear_young() 
> > that matters.
> 
> Yes, but it would be possible to optimize it some way on our
> beloved hash tables ;) (By marking the entry read-only in the
> hash instead of evicting it). Maybe not worth the pain though...

I don't think you should evict it, since
 - you know the value it should have
 - if you do the hash lookup anyway, you might as well just update the 
   entry.

And it's not "read-only" - it's the "A" bit, not the "W" bit you should be 
clearing in "ptep_test_and_clear_young()".

> Except that we may expect all "referencing" PTEs to have the accessed
> bit cleared, no ? Or if we have lots of users we'll end up getting lots
> of positive results while after the page was actually referenced... I
> don't know if this would be a real problem though.

I'll let Rik and Andrea argue that part - it's entirely possible that 
getting lots of positive results is a _good_ thing, if the same page is 
mapped multiple times. That would just make us less eager to unmap it, 
which sounds like potentially the right thign to do (it's also how the old 
non-rmap code worked, and I know Rik thought it was "unfair", but 
whatever).

> Ok, right now, Anton is testing a patch from paulus where we do our
> own flush batching and do the flush inside ptep_test_and_clear_* That
> will at least fix the problem for us now.

Yeah, and it's unlikely to be a performance problem anyway. That function 
should be called only when we're low on memory..

		Linus
