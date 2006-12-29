Return-Path: <linux-kernel-owner+w=401wt.eu-S1755060AbWL2R0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbWL2R0W (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 12:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755059AbWL2R0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 12:26:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42201 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054AbWL2R0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 12:26:21 -0500
Date: Fri, 29 Dec 2006 09:25:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, kenneth.w.chen@intel.com,
       guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl, tbm@cyrius.com,
       arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <45950561.6040508@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612290915420.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <45950561.6040508@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Nick Piggin wrote:
> 
> > It still has a tiny tiny race (see the comment), but I bet nobody can really
> > hit it in real life anyway, and I know several ways to fix it, so I'm not
> > really _that_ worried about it.
> 
> Well the race isn't a data loss one, is it? Just a case where the
> pte may be dirty but the page dirty state not accounted for.

Right. We should be picking it up eventually, since it's still in the page 
tables, but if we've lost sight of the page dirtyness we won't react 
correctly to msync() and/or fdatasync(). So we don't _lose_ the data, we 
just might not write it out in a timely manner if we ever hit the race.

> Can we fix it by just putting the page_mkclean back inside the
> TestClearPageDirty check, and re-clearing PG_dirty after redoing
> the set_page_dirty?

I considered it, but quite frankly, if we did it that way, I'd really like 
to just fix the whole insane "set_page_dirty()" instead.

I think set_page_dirty() should be split up. One thing that confused me 
mentally was that almost all of the dirty handling was actualyl done only 
if PG_dirty wasn't already set, so the _bulk_ of set_page_dirty() really 
ends up being

	if (!TestSetPageDirty(page)) {
		.. we just marked the page dirty, it was clean before,
		   so we need to add it to the queues etc ..
	}

and that's the part that I (and probably others) always really thought 
about.

But then we have the _one_ thing that runs outside of that "do only once 
per dirty bit" logic, and it's the buffer dirtying. If we had had two 
separate operations for this all: "set_dirty_every_time()" and the regular 
"set_dirty()", I don't think this would have been nearly as confusing.

(And then the difference between "__set_page_dirty_nobuffers()" and 
"__set_page_dirty_buffers()" really boils down to one doing the 
"everytime" _and_ the "once per dirty" checks and the other one doing just 
the "once per dirty bit" act - and we could rename the damn things to 
something saner too).

If we split it up that way, then the whole clear_page_dirty_for_io() logic 
would boil down to

	if (TestClearPageDirty(page)) {
		if (page_mkclean(page))
			set_dirty_every_time();
		return 1;
	}
	return 0;

and we wouldn't even need to do any of the "clear dirty again" kind of 
idiocy, because the "set_dirty_every_time()" stuff is the one that doesn't 
even care about the state of the PG_dirty bit - it's done regardless, and 
doesn't really touch it.

That's what I wanted to do, but with the current "set_page_dirty()" setup, 
I think my patch makes reasonable sense.

		Linus
