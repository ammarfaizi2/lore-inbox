Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRKSIIa>; Mon, 19 Nov 2001 03:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273622AbRKSIIU>; Mon, 19 Nov 2001 03:08:20 -0500
Received: from zero.tech9.net ([209.61.188.187]:47878 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S273588AbRKSIIH>;
	Mon, 19 Nov 2001 03:08:07 -0500
Subject: Re: [RFC] tree-based bootmem
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20011117160134.A11913@holomorphy.com>
In-Reply-To: <20011117011415.B1180@holomorphy.com>
	<20011118001657.A467@ucw.cz>  <20011117160134.A11913@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 19 Nov 2001 03:08:07 -0500
Message-Id: <1006157288.869.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 12:16:57AM +0100, Martin Mares wrote:
> I don't understand why does it use segment trees instead of a simple
> linked list. Bootmem allocations are obviously not going to be time
> critical and shaving off a couple of ms during the boot process is
> not worth the extra complexity involved.
> 
> (Nevertheless, treaps are a very nice structure...)

I think there is merit in using segment trees here.  Previously I have
replied demonstrating the benefit of the finer granularity in
addressing, which results in a couple KB increase in total memory on my
machines.  This is not the greatest benefit, IMO.

What really stands out to me is the design; and I think segment trees
are applicable here.  While I doubt performance of the bootmem allocator
is ever a _terrible_ concern, it probably does have tight spots.

The beauty is in the implementation.  With a linked list implementation,
you have an exhaustive search and and at-worst O(n) insertion and
searching complexity.  We also don't end up with any clean way to say
"memory a belongs to x".  This is where the segment tree comes in, a
segment tree stores intervals: it is a binary tree where each node
represents an interval from a to b.  We only need to store nodes that
have allocated intervals of memory, and insertion is O(log n). 
Searching is even easier as you just walk the intervals until we get to
what we want.  Searching would be O(log(n+s)) where s is the number of
segments we had to walk.  OK, you know this, but my point is its is
quite applicable.  Besides a performance boost, we end up with a nice
way to interface with other code to work with bootmem and I think that
is the main benefit here.

Of course, the downside would be "good lord the complexity here is
grossly overkill" but I think this doesn't have that problem.

just my two bits, 

	Robert Love

