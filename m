Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVDDGt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVDDGt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDDGt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:49:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30175 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261425AbVDDGt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:49:29 -0400
Date: Mon, 4 Apr 2005 08:48:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, kenneth.w.chen@intel.com,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050404064832.GA23312@elte.hu>
References: <20050402215332.79ff56cc.pj@engr.sgi.com> <20050403070415.GA18893@elte.hu> <20050403043420.212290a8.pj@engr.sgi.com> <20050403071227.666ac33d.pj@engr.sgi.com> <20050403152413.GA26631@elte.hu> <20050403160807.35381385.pj@engr.sgi.com> <4250A195.5030306@yahoo.com.au> <20050403205558.753f2b55.pj@engr.sgi.com> <1112594184.5077.9.camel@npiggin-nld.site> <20050403233816.71a6dd4b.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403233816.71a6dd4b.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> Nick wrote:
> > In a sense, the information *is* already there - in node_distance.
> > What I think should be done is probably to use node_distance when
> > calculating costs, ...
> 
> Hmmm ... perhaps I'm confused, but this sure sounds like the alternative
> implementation of cpu_distance using node_distance that I submitted to
> this thread about 16 hours ago.

yes, it's that method.

> [...] It was using this alternative that got me the more varied 
> matrix:
> 
> ---------------------
>           [00]    [01]    [02]    [03]    [04]    [05]    [06]    [07]
> [00]:     -     4.0(0) 21.7(1) 21.7(1) 25.2(2) 25.2(2) 25.3(3) 25.3(3)
> [01]:   4.0(0)    -    21.7(1) 21.7(1) 25.2(2) 25.2(2) 25.3(3) 25.3(3)
> [02]:  21.7(1) 21.7(1)    -     4.0(0) 25.3(3) 25.3(3) 25.2(2) 25.2(2)
> [03]:  21.7(1) 21.7(1)  4.0(0)    -    25.3(3) 25.3(3) 25.2(2) 25.2(2)
> [04]:  25.2(2) 25.2(2) 25.3(3) 25.3(3)    -     4.0(0) 21.7(1) 21.7(1)
> [05]:  25.2(2) 25.2(2) 25.3(3) 25.3(3)  4.0(0)    -    21.7(1) 21.7(1)
> [06]:  25.3(3) 25.3(3) 25.2(2) 25.2(2) 21.7(1) 21.7(1)    -     4.0(0)
> [07]:  25.3(3) 25.3(3) 25.2(2) 25.2(2) 21.7(1) 21.7(1)  4.0(0)    -
> ---------------------

the problem i mentioned earlier is that there is no other use for the 
matrix right now than the domain hierarchy. And if there's no place in 
the domain hieararchy to put this info then the information is lost.

so we might be able to _measure_ a rank-3 matrix, but if the domain is 
only rank-2 then we'll have to discard one level of information.

we could try some hybride method of averaging 25.3 with 21.7 and putting 
that into the domain tree, but i'd be against it for the following 
reasons:

firstly, _if_ an extra level in the hierarchy makes a difference, we 
might as well add it to the domain tree - and that may bring other 
advantages (in terms of more finegrained balancing) in addition to 
better migration.

secondly, right now the cost measurement method and calculation is 
rather simple and has minimal assumptions, and i'd like to keep it so as 
long as possible. If an extra domain level gives problems or artifacts 
elsewhere then we should fix those problems if possible, and not 
complicate the cost calculation.

	Ingo
