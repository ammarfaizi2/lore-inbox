Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbTL0JBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 04:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265350AbTL0JBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 04:01:46 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:18124 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S265346AbTL0JBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 04:01:44 -0500
Date: Sat, 27 Dec 2003 09:01:42 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Rohit Seth <rohit.seth@intel.com>
Subject: Re: 2.6.0 Huge pages not working as expected
Message-ID: <20031227090142.GA8777@axis.demon.co.uk>
References: <20031226105433.GA25970@axis.demon.co.uk> <20031226115647.GH27687@holomorphy.com> <20031226201011.GA32316@axis.demon.co.uk> <Pine.LNX.4.58.0312261226560.14874@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312261226560.14874@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 12:33:58PM -0800, Linus Torvalds wrote:
> On Fri, 26 Dec 2003, Nick Craig-Wood wrote:
> > 
> > The results are just about the same - a slight slowdown for
> > hugepages...
> 
> I don't think you are really testing the TLB - you are testing the data 
> cache.
> 
> And the thing is, using huge pages will mean that the pages are 1:1
> mapped, and thus get "perfectly" cache-coloured, while the anonymous mmap 
> will give you random placement.

Mmmm, yes.

> And what you are seeing is likely the fact that random placement is 
> guaranteed to not have any worst-case behaviour. While perfect 
> cache-coloring very much _does_ have worst-case schenarios, and you're 
> likely triggering one of them.
> 
> In particular, using a pure power-of-two stride means that you are
> limiting your cache to a certain subset of the full result with the
> perfect coloring.
> 
> This, btw, is why I don't like page coloring: it does give nicely
> reproducible results, but it does not necessarily improve performance.  
> Random placement has a lot of advantages, one of which is a lot smoother
> performance degradation - which I personally think is a good thing.
> 
> Try your program with non-power-of-two, and non-page-aligned strides. I
> suspect the results will change (but I suspect that the TLB wins will 
> still be pretty much in the noise compared to the actual data cache 
> effects).

Yes you are right and I should have thought have that as I know that
FFTs often have a bit of padding on each row to make them a non power
of two to avoid this effect!

Here are the results again with a some non power of two strides run on
a P4.  Apart from the variable results the hugetlb ones are always
less than the small page ones.

Memory from /dev/zero
Testing memory at 0x42400000
span =        1, time =     12.103 ms, total = -973807672
span =        2, time =     21.051 ms, total = -973807672
span =        3, time =     28.391 ms, total = -973807672
span =        5, time =     44.004 ms, total = -973807672
span =        7, time =     60.622 ms, total = -973807672
span =       11, time =     96.537 ms, total = -973807672
span =       13, time =    116.335 ms, total = -973807672
span =       17, time =    153.163 ms, total = -973807672
span =       33, time =    276.764 ms, total = -973807672
span =       77, time =    282.419 ms, total = -973807672
span =      119, time =    287.168 ms, total = -973807672
span =      221, time =    298.292 ms, total = -973807672
span =      561, time =    343.215 ms, total = -973807672
span =      963, time =    418.078 ms, total = -973807672
span =     1309, time =    446.026 ms, total = -973807672
span =     2023, time =    253.098 ms, total = -973807672
span =     4335, time =     68.616 ms, total = -973807672

Memory from hugetlbfs
Testing memory at 0x41400000
span =        1, time =     12.059 ms, total = -973807672
span =        2, time =     20.745 ms, total = -973807672
span =        3, time =     28.324 ms, total = -973807672
span =        5, time =     43.683 ms, total = -973807672
span =        7, time =     60.228 ms, total = -973807672
span =       11, time =     95.680 ms, total = -973807672
span =       13, time =    115.695 ms, total = -973807672
span =       17, time =    152.603 ms, total = -973807672
span =       33, time =    275.821 ms, total = -973807672
span =       77, time =    280.759 ms, total = -973807672
span =      119, time =    285.515 ms, total = -973807672
span =      221, time =    295.163 ms, total = -973807672
span =      561, time =    335.941 ms, total = -973807672
span =      963, time =    411.387 ms, total = -973807672
span =     1309, time =    433.168 ms, total = -973807672
span =     2023, time =    119.780 ms, total = -973807672
span =     4335, time =     32.085 ms, total = -973807672

Isn't modern memory management fun ;-)

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
