Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVDCPBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVDCPBs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 11:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVDCPBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 11:01:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3034 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261782AbVDCPBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 11:01:44 -0400
Date: Sun, 3 Apr 2005 17:01:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050403150102.GA25442@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com> <20050402145351.GA11601@elte.hu> <20050402215332.79ff56cc.pj@engr.sgi.com> <20050403070415.GA18893@elte.hu> <20050403043420.212290a8.pj@engr.sgi.com> <20050403071227.666ac33d.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403071227.666ac33d.pj@engr.sgi.com>
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

> Three more observations.
> 
>  1) The slowest measure_one() calls are, not surprisingly, those for the
>     largest sizes.  At least on my test system of the moment, the plot
>     of cost versus size has one major maximum (a one hump camel, not two).
>     
>     Seems like if we computed from smallest size upward, instead of largest
>     downward, and stopped whenever two consecutive measurements were less
>     than say 70% of the max seen so far, then we could save a nice chunk
>     of the time.
> 
>     Of course, if two hump systems exist, this is not reliable on them.

yes, this is the approach i'm currently working on, but it's not 
reliable yet. (one of the systems i have drifts its cost into infinity 
after the hump, which shouldnt happen)

>  2) Trivial warning fix for printf format mismatch:

thx.

>  3) I was noticing that my test system was only showing a couple of 
>     distinct values for cpu_distance, even though it has 4 distinct 
>     distances for values of node_distance.  So I coded up a variant of 
>     cpu_distance that converts the problem to a node_distance problem, 
>     and got the following cost matrix:
> 
> =================================== begin ===================================
> Total of 8 processors activated (15515.64 BogoMIPS).
> ---------------------
> migration cost matrix (max_cache_size: 0, cpu: -1 MHz):
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
> cacheflush times [4]: 4.0 (4080540) 21.7 (21781380) 25.2 (25259428) 25.3 (25372682)

i'll first try the bottom-up approach to speed up detection (getting to
the hump is very fast most of the time). The hard part was to create a
workload that generates the hump reliably on a number of boxes - i'm
happy it works on ia64 too.

then we can let the arch override the cpu_distance() method, although i
do think that _if_ there is a significant hierarchy between CPUs it
should be represented via a matching sched-domains hierarchy, and the
full hierarchy should be tuned accordingly.

btw., the migration cost matrix we can later use to tune all the other 
sched-domains balancing related tunables as well - cache_hot_time is 
just the first obvious step. (which also happens to make the most 
difference.)

	Ingo
