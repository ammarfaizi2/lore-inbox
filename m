Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUIVARg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUIVARg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 20:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUIVARg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 20:17:36 -0400
Received: from holomorphy.com ([207.189.100.168]:59082 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267189AbUIVARa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 20:17:30 -0400
Date: Tue, 21 Sep 2004 17:17:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040922001713.GK9106@holomorphy.com>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909192924.GA1672@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell <rlrevell@joe-job.com> wrote:
>> preemption latency trace v1.0.6 on 2.6.9-rc1-bk12-VP-R6
>> --------------------------------------------------
>>  latency: 605 us, entries: 5 (5)  [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
>>     -----------------
>>     | task: kswapd0/35, uid:0 nice:0 policy:0 rt_prio:0
>>     -----------------
>>  => started at: get_swap_page+0x23/0x490
>>  => ended at:   get_swap_page+0x13f/0x490
>> =======>
>> 00000001 0.000ms (+0.606ms): get_swap_page (add_to_swap)
>> 00000001 0.606ms (+0.000ms): sub_preempt_count (get_swap_page)
>> 00000001 0.606ms (+0.000ms): update_max_trace (check_preempt_timing)
>> 00000001 0.606ms (+0.000ms): _mmx_memcpy (update_max_trace)
>> 00000001 0.607ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

This appears to be the middle of the function, which is about right...


On Thu, Sep 09, 2004 at 09:29:24PM +0200, Ingo Molnar wrote:
> yep, the get_swap_page() latency. I can easily trigger 10+ msec
> latencies on a box with alot of swap by just letting stuff swap out. I
> had a quick look but there was no obvious way to break the lock. Maybe
> Andrew has better ideas? get_swap_page() is pretty stupid, it does a
> near linear search for a free slot in the swap bitmap - this not only is
> a latency issue but also an overhead thing as we do it for every other
> page that touches swap.
> rationale: this is pretty much the only latency that we still having
> during heavy VM load and it would Just Be Cool if we fixed this final
> one. audio daemons and apps like jackd use mlockall() so they are not
> affected by swapping.

I presume most of the time is due to scan_swap_map() and not much of the
rest of get_swap_page(). Dangling hierarchical bitmaps off of the
swap_info structures to accelerate the search sounds plausible, though
code reuse is largely infeasible due to memory allocation concerns (it
must be fully-populated during swaplist element creation). The space
overhead should be 1 bit per unsigned short at the first level and 1
bit per word for higher levels until the terms vanish. So that's
si->max*sum(i>=0,BITS_PER_LONG**i<=si->max)floor(si->max/BITS_PER_LONG**i)
<= si->max*/(1-1/BITS_PER_LONG) bits, or
si->max*sizeof(long)/(BITS_PER_LONG-1) bytes, which is
sizeof(long)/sizeof(short)/(BITS_PER_LONG-1) times the size of the
original swap map, which is 2/31 on 32-bit and 4/63 on 64-bit of the
size of the original swap map, both of which are just above 1/16 (1/496
above on 32-bit and 1/1008 above on 64-bit), so the space overhead
appears to be acceptable. A hierarchical bitmap should reduce the time
requirements for the search from O(sum(si) si->max) to
O(BITS_PER_LONG/lg(BITS_PER_LONG)). Sound reasonable?


-- wli
