Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUCPNOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUCPNOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:14:06 -0500
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:10910 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261468AbUCPNOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:14:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Kurt Garloff <garloff@suse.de>
Subject: Re: dynamic sched timeslices
Date: Wed, 17 Mar 2004 00:13:37 +1100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org
References: <20040315224201.GX4452@tpkurt.garloff.de> <20040315154042.40c58c5b.akpm@osdl.org> <20040316113615.GK4452@tpkurt.garloff.de>
In-Reply-To: <20040316113615.GK4452@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403170013.38140.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004 10:36 pm, Kurt Garloff wrote:
> On Mon, Mar 15, 2004 at 03:40:42PM -0800, Andrew Morton wrote:
> > Your patch didn't come with any subjective or measured testing results.

> We've done some measurements with 2.4 and O(1):
> * HZ=1000 cost about 1.5% perf. on a kernel compile (plus problems
>   with lost timer ticks)
> * Seting the scheduling timeslices from 1ms--30ms rather than 10ms thr
>   300ms cost another ~3% kernel compile performance
> * Depending on the workload the effect can be larger. Numbercrunching
>   would come to mind.

2.4 O(1) effects do not directly apply with 2.6

Dropping Hz will save you performance for sure on 2.6.

Changing the timeslices in 2.6 will be disappointing, though. Although the 
apparent timeslice of nice 0 tasks is 102ms, interactive tasks round robin at 
10ms. If you drop the timeslice to 10ms you will not improve the interactive 
feel but you will speed up expiration instead which will almost certainly 
worsen interactive feel. If you drop timeslices below 10ms you will get 
significant cache trashing and drop in performance (which your 2.4 results 
confirm).

Increasing timeslices does benefit pure number crunching workloads. The 
benchmarking I've done using cache intensive workloads (which are the most 
likely to benefit) show you are chasing diminishing returns, though. You can 
mathematically model them based on the fact that keeping a task bound to a 
cpu instead of shifting it to another cpu on SMP saves about 2ms processing 
time on P4. Suffice to say the benefit is only worth it if you do nothing but 
cpu intensive things, and becomes virtually insignificant beyond 200ms. On 
other architecture with longer cache decays you will benefit more; 
arch/i386/mach-voyager seems the longest at 20ms.

>It's a classical throughput vs. latency tradeoff and the patch allows
>the user to set it. I'm sure some people are willing to have long
>timeslices in order to gain 5% and don't care about the sched latencies.

As you can see from the above it is not that clear cut.

Con
