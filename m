Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTLZXaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbTLZX2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:28:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265265AbTLZX2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:28:17 -0500
Date: Fri, 26 Dec 2003 15:28:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Ertl <anton@mips.complang.tuwien.ac.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
In-Reply-To: <2003Dec26.224803@a0.complang.tuwien.ac.at>
Message-ID: <Pine.LNX.4.58.0312261515550.14874@home.osdl.org>
References: <2003Dec26.224803@a0.complang.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003, Anton Ertl wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> >
> >And what you are seeing is likely the fact that random placement is 
> >guaranteed to not have any worst-case behaviour.
> 
> You probably just put the "not" in the wrong place, but just in case
> you meant it: Random replacement does not give such a guarantee.

No, I meant what I said.

Random placement is the _only_ algorithm guaranteed to have no 
pathological worst-case behaviour.

>							  You
> can get the same worst-case behaviour as with page colouring, since
> you can get the same mapping.  It's just unlikely.

"pathological worst-case" is something that is repeatable. For example, 
the test-case above is a pathological worst-case schenario for a 
direct-mapped cache. 

> Well, even if, on average, it has no performance impact,
> reproducibility is a good reason to like it.  Is it good enough to
> implement it?  I'll leave that to you.

Well, since random (or, more accurately in this case, "pseudo-random") has 
a number of things going for it, and is a lot faster and cheaper to 
implement, I don't see the point of cache coloring.

That's doubly true since any competent CPU will have at least four-way 
associativity these days.

> However, the main question I want to look at here is: Does it improve
> performance, on average?  I think it does, because of spatial
> locality.

Hey, the discussion in this case showed how it _deproves_ performance (at 
least if my theory was correct - and it should be easily testable and I 
bet it is).

Also, the work has been done to test things, and cache coloring definitely
makes performance _worse_. It does so exactly because it artifically
limits your page choices, causing problems at multiple levels (not just at
the cache, like this example, but also in page allocators and freeing).

So basically, cache coloring results in:
 - some nice benchmarks (mainly the kind that walk memory very 
   predictably, notably FP kernels)
 - mostly worse performance in "real life"
 - more complex code
 - much worse memory pressure

My strong opinion is that it is worthless except possibly as a performance
tuning tool, but even there the repeatability is a false advantage: if you
do performance tuning using cache coloring, there is nothing that
guarantees that your tuning was _correct_ for the real world case.

In short, you may be doing your performance tuning such that it tunes for
or against one of the (known) pathological cases of the layout, nothing
more.

But hey, some people disagree with me. That's their right. It's not 
unconstitutional to be wrong ;)

			Linus
