Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265302AbTL0DgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 22:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbTL0DgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 22:36:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44427
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265302AbTL0DgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 22:36:22 -0500
Date: Sat, 27 Dec 2003 04:36:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohit.seth@intel.com>
Subject: Re: 2.6.0 Huge pages not working as expected
Message-ID: <20031227033620.GG1676@dualathlon.random>
References: <20031226105433.GA25970@axis.demon.co.uk> <20031226115647.GH27687@holomorphy.com> <20031226201011.GA32316@axis.demon.co.uk> <Pine.LNX.4.58.0312261226560.14874@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312261226560.14874@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 12:33:58PM -0800, Linus Torvalds wrote:
> This, btw, is why I don't like page coloring: it does give nicely
> reproducible results, but it does not necessarily improve performance.  

static page coloring doesn't mean you've to map 1:1 (though with the
largepages there's no choice but 1:1 ;).

the best algorithm giving three digit percent improvements I tested with
Sebastien Cabaniols on some alpha last year is the below mode == 1 (the
mode is selectable both at runtime or boot time):

+       /*
+        * If pfn is negative just try to distribute the page colors globally
+        * with a dynamic page coloring.
+        */
+       color = pfn;
+       switch (page_coloring_mode) {
+       case 0:
+               break;
+       case 1:
+               /* when == 1 optimize FFT (avoids some cache trashing) */
+               color = color + (color / page_colors);
+               break;
+       }
+       if (pfn < 0)
+               color = global_color;


the perfect static page coloring 1:1 (mode == 0) was the worst IIRC at
some math algorithm walking matrix horizontally and vertically at the
same time, especially if every raw is a page or similar multiple, for
the reasons you just said. But the mode == 1 was the very best, much
better than random and 1:1.

> Random placement has a lot of advantages, one of which is a lot smoother

well, at least on the alpha the above mode = 1 is reproducibly a lot
better (we're talking about a wall time 2/3 times shorter IIRC) than
random placement. The l2 is huge and one way cache associative, we
couldn't reproduce the same results on a alpha with tiny caches and
16-way set associative or similar. Note the above has nothing to do with
the patches I've seen floating around for the last years.  Those are all
dynamic page coloring, the above does dynamic coloring of the kernel
code only, and it makes sure the dynamic coloring of the kernel is never
strict, while it can be strict for userspace optionally (strict means,
shrink the cache hard until if finds the asked color, which is a must
have feature on the alpha for the math apps with tiny vm working set and
lots of ram, though I'm sure the 'strict' mode would make no sense on
the x86, except during pure benchmarking where reproducible results are
valuable). It also colors the pagecache with the inode offset (plus a
random offset from the inode pointer IIRC).

I guess gcc developers and most other cpu-benchmarking efforts would
benefit from an algorithm like the above (plus the strict mode in the
same patch), so they can remove some (at least theoretical) noise from
the nightly spec runs. this ignoring the benfits on the non x86 archs.

The current patch is for 2.2 with an horrible API (it uses a kernel
module to set those params instead of a sysctl, despite all the real
code is linked into the kernel), while developing it I only focused on
the algorithms and the final behaviour in production. the engine to ask
the allocator a page of the right color works O(1) with the number of
free pages and it's from Jason.  the allocator engine is completely
shared between my implementation and the other patches floating around.
The engine was so well designed and correctly implemented that there was
no reason for me to touch it.  Really the implementation of the engine
could be cleaner but I didn't bother to clean it up.
