Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTL0Apv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTL0Apv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:45:51 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:63407 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265285AbTL0Apq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:45:46 -0500
Subject: Re: Page aging broken in 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston>
	 <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
	 <1072482941.15458.90.camel@gaston>
	 <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
Content-Type: text/plain
Message-Id: <1072485899.15456.96.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 11:44:59 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-27 at 11:35, Linus Torvalds wrote:
> On Sat, 27 Dec 2003, Benjamin Herrenschmidt wrote:
> > 
> > Or do what I propose here, that is have ptep_test_and_clear_* be
> > responsible for the flush on archs where it is necessary, but then
> > it would be nice to have more than the ptep as an argument...
> 
> The dirty handling already does the TLB flush (in that case it's a 
> correctness issue, not a hint). So it's only ptep_test_and_clear_young() 
> that matters.

Yes, but it would be possible to optimize it some way on our
beloved hash tables ;) (By marking the entry read-only in the
hash instead of evicting it). Maybe not worth the pain though...

> I don't know whather that ever ends up being performance-critical, and I
> don't see what else could be passed into it. We literally don't _have_
> anythign else than the pte.

Ok, figured that out.

> But the ppc architecture could easily decide to walk the hash tables and
> invalidate in ptep_test_and_clear_young(). And if it ends up being a
> performance issue, it _appears_ that all users of "page_referenced()" 
> (which is the only thing that does this) are actually using the return 
> value as just a boolean. And it's entirely possible that we should break 
> out of "page_referenced()" on the _first_ hit of "yes, this has been 
> referenced".

Except that we may expect all "referencing" PTEs to have the accessed
bit cleared, no ? Or if we have lots of users we'll end up getting lots
of positive results while after the page was actually referenced... I
don't know if this would be a real problem though.

> That would make it much less CPU-intensive to make
> "ptep_test_and_clear_young()" slightly heavier to execute. It would also 
> cause "page_referenced()" to not clear _all_ mapped reference bits at the 
> same time - which might unfairly cause multi-used pages to stay in memory. 
> On the other hand, that might be the _right_ behaviour.
> 
> Rik? Andrea? 
> 
> Worth testing, perhaps.

Ok, right now, Anton is testing a patch from paulus where we do our
own flush batching and do the flush inside ptep_test_and_clear_* That
will at least fix the problem for us now.

Ben.


