Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUIIWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUIIWpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUIIWpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:45:50 -0400
Received: from holomorphy.com ([207.189.100.168]:7092 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266703AbUIIWpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:45:45 -0400
Date: Thu, 9 Sep 2004 15:45:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, felipe_alfaro@linuxmail.org,
       mista.tapas@gmx.net, kr@cybsft.com, Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040909224535.GN3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
	felipe_alfaro@linuxmail.org, mista.tapas@gmx.net, kr@cybsft.com,
	Mark_H_Johnson@Raytheon.com
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu> <20040909130526.2b015999.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909130526.2b015999.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>> yep, the get_swap_page() latency. I can easily trigger 10+ msec
>> latencies on a box with alot of swap by just letting stuff swap out. I
>> had a quick look but there was no obvious way to break the lock. Maybe
>> Andrew has better ideas? get_swap_page() is pretty stupid, it does a
>> near linear search for a free slot in the swap bitmap - this not only is
>> a latency issue but also an overhead thing as we do it for every other
>> page that touches swap.

On Thu, Sep 09, 2004 at 01:05:26PM -0700, Andrew Morton wrote:
> Someone needs to get down and redesign the swap block allocator.  I bet
> latency improvements would fall out of that automatically.
> The main problem is that swap blocks are now physically clustered according
> to the page lru ordering, which doesn't have much relationship to
> process-virtual-address-ordering.
> The swap allocator made sense when we were doing a virtual scan.  It
> doesn't make much sense now.

Something odd is going on, in part because I get *blistering* IO speeds
running benchmarks like dbench, tiobench, et al on tmpfs with striped
swap. In fact, IO speeds markedly faster than any other filesystem I've
ever tried, by about 30MB/s (i.e. wirespeed, where others fall about
37.5% short of it). Virtual alignment issues do hurt, but the core
allocation algorithm appears to be better than good, it's astounding.


On Thu, Sep 09, 2004 at 01:05:26PM -0700, Andrew Morton wrote:
> I did a patch a while back which switches the swapspace allocator over to
> perform program-virtual-address clustering, but it didn't help much in
> brief testing and I haven't got back onto it.
> And contrary to my above assertion, I don't think it'll help latency ;)
> A short-term bodge would be to scan the map without locks held, take the
> lock just to actually claim the block, retry if we raced.  Use swapon_sem
> to avoid races.  After checking that we never perform GFP_WAIT allocations
> while holding swapon_sem.
> The whole thing needs work.

Well, yes, dbench on tmpfs isn't really the load we're shooting for.


-- wli
