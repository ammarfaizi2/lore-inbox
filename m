Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275570AbRJAVb3>; Mon, 1 Oct 2001 17:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275571AbRJAVbK>; Mon, 1 Oct 2001 17:31:10 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:23313 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S275570AbRJAVbE>; Mon, 1 Oct 2001 17:31:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>, linux-kernel@vger.kernel.org
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
Date: Mon, 1 Oct 2001 23:31:20 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3.0.6.32.20011001203320.02381600@pop.tiscalinet.it>
In-Reply-To: <3.0.6.32.20011001203320.02381600@pop.tiscalinet.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011001213122Z16541-2757+2712@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 1, 2001 08:33 pm, Lorenzo Allegrucci wrote:
> Disclaimer:
> I don't know if this "benchmark" is meaningful or not, but anyhow..
> 
> As workload I used qsort() on an array of 90000000 32 bit ints.
> (trivial code to the end of my email).
> 
> The VSIZE of the resulting process is about 343Mb.
> Tested machine has 256Mb of RAM + 200Mb of swap.
> Same srand() in all tests.
> 
> Below are linux-2.4.10 results
> 
> run 1:
> real    4m54.728s
> user    2m47.910s
> sys     0m2.520s
> 
> run 2:
> real    4m55.109s
> user    2m46.050s
> sys     0m2.530s
> 
> kswapd CPU time: 3 seconds
> qs RSS always on 238-240M, very stable never below 235M.
> 
> .. and 2.4.10-ac2 results
> 
> run 1:
> real    6m2.139s
> user    2m44.390s
> sys     0m3.210s
> 
> run 2:
> real    6m57.140s
> user    2m47.050s
> sys     0m3.560s
> 
> kswapd CPU time: 20 seconds
> qs RSS never above 204M, average value 150M.
> 
> 
> Comments?

Nice test, it's simpl and fairly easy to analyze.  It provides a nice mix of 
nonlocalized and localized memory activity, in that order.

The first pass of the quicksort will make one pass over all of memory with a 
working set within the array at any given time of just two pages, 
corresponding to the pattern of exchanges.  Somewhat more than the available 
physical memory will be dirtied, causing some swapouts.  A prescient mm would 
page back in each of those swapped out pages exactly once later in the sort, 
by choosing all the eviction victims from the set of pages that will not be 
used in the next recursive semi-sort.  I can't imagine any general-purpose 
page replacement policy that would be this smart, so we should assume that a 
good page replacement algorithm will evict about 50% more dirty pages than 
the prescient algorithm.

There is some danger that any given page replacement algorithm might 
accidently behave the same as the prescient algorithm.  I can't think of a 
good way to test for this other than by knowing how much physical memory is 
actually available for the array and becoming suspicious if the mm does 
better than expected according to the above analysis.  Odds are, the mm won't 
get lucky, but it could.

Aside from obvious bugs, one mm stategy can beat another by making more 
memory available for caching the array data and by closely approaching 150% 
of the number of swapouts that the prescient algorithm would make.

Andrea's mm apparently did better than Rik's, but you were too polite to 
point that out ;-)  Some additional statistics would help tell us why: 
swapin/swapout counts, and run time with no swapping, which you would have to 
obtain using a smaller data size and an artificial memory limit.  It would 
also be nice to know the maximum array size that can be sorted with no or 
minimal swapping, which tells us how much cache the mm is able to make 
available for program data.  Ideally, that would amount to nearly all of 
physical memory since very little else is going on.

--
Daniel
