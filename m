Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268436AbUILE5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268436AbUILE5K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 00:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268438AbUILE5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 00:57:10 -0400
Received: from holomorphy.com ([207.189.100.168]:5251 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268436AbUILE4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 00:56:42 -0400
Date: Sat, 11 Sep 2004 21:56:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040912045636.GA2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910174915.GA4750@logos.cnet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>> In order to attempt to compensate for arrival rates to zone->lru_lock
>>> increasing as O(num_cpus_online()), this patch resizes the pagevec to
>>> O(lg(NR_CPUS)) for lock amortization that adjusts better to the size of
>>> the system. Compiletested on ia64.

On Fri, Sep 10, 2004 at 02:56:11PM +1000, Nick Piggin wrote:
>> Yuck. I don't like things like this to depend on NR_CPUS, because your
>> kernel may behave quite differently depending on the value. But in this
>> case I guess "quite differently" is probably "a little bit differently",
>> and practical reality may dictate that you need to do something like
>> this at compile time, and NR_CPUS is your best approximation.

On Fri, Sep 10, 2004 at 02:49:15PM -0300, Marcelo Tosatti wrote:
> For me Bill's patch (with the recursive thingie) is very cryptic. Its
> just doing log2(n), it took me an hour to figure it out with his help.

Feel free to suggest other ways to discover lg(n) at compile-time.


On Fri, Sep 10, 2004 at 02:56:11PM +1000, Nick Piggin wrote:
>> That said, I *don't* think this should go in hastily.
>> First reason is that the lru lock is per zone, so the premise that
>> zone->lru_lock aquisitions increases O(cpus) is wrong for anything large
>> enough to care (ie. it will be NUMA). It is possible that a 512 CPU Altix
>> will see less lru_lock contention than an 8-way Intel box.

On Fri, Sep 10, 2004 at 02:49:15PM -0300, Marcelo Tosatti wrote:
> Oops, right. wli's patch is borked for NUMA. Clamping it at 64 should
> do fine.

No, it DTRT. Batching does not directly compensate for increases in
arrival rates, rather most directly compensates for increases to lock
transfer times, which do indeed increase on systems with large numbers
of cpus.


On Fri, Sep 10, 2004 at 02:56:11PM +1000, Nick Piggin wrote:
>> Secondly is that you'll might really start putting pressure on small L1
>> caches (eg. Itanium 2) if you bite off too much in one go. If you blow
>> it, you'll have to pull all the pages into cache again as you process
>> the pagevec.

On Fri, Sep 10, 2004 at 02:49:15PM -0300, Marcelo Tosatti wrote:
> Whats the L1 cache size of Itanium2? Each page is huge compared to the pagevec
> structure (you need a 64 item pagevec array on 64-bits to occupy the space of 
> one 4KB page). So I think you wont blow up the cache even with a really big 
> pagevec.

A 511 item pagevec is 4KB on 64-bit machines.


On Fri, Sep 10, 2004 at 02:56:11PM +1000, Nick Piggin wrote:
>> I don't think the smallish loop overhead constant (mainly pulling a lock
>> and a couple of hot cachelines off another CPU) would gain muc from
>> increasing these a lot, either. The overhead should already at least an
>> order of magnitude smaller than the actual work cost.
>> Lock contention isn't a good argument either, because it shouldn't
>> significantly change as you tradeoff hold vs frequency if we assume
>> that the lock transfer and other overheads aren't significant (which
>> should be a safe assumption at PAGEVEC_SIZE of >= 16, I think).
>> Probably a PAGEVEC_SIZE of 4 on UP would be an interesting test, because
>> your loop overheads get a bit smaller.

On Fri, Sep 10, 2004 at 02:49:15PM -0300, Marcelo Tosatti wrote:
> Not very noticeable on reaim. I want to do more tests (different
> workloads, nr CPUs, etc).

The results I got suggest the tests will not be significantly different
unless the machines differ significantly in the overhead of acquiring a
cacheline in an exclusive state.


On Fri, Sep 10, 2004 at 02:49:15PM -0300, Marcelo Tosatti wrote:
> kernel: pagevec-4
> plmid: 3304
> Host: stp1-002
> Reaim test
> http://khack.osdl.org/stp/297484
> kernel: 3304
> Filesystem: ext3
> Peak load Test: Maximum Jobs per Minute 992.40 (average of 3 runs)
> Quick Convergence Test: Maximum Jobs per Minute 987.72 (average of 3 runs)
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> kernel: 2.6.9-rc1-mm4
> plmid: 3294
> Host: stp1-003
> Reaim test
> http://khack.osdl.org/stp/297485
> kernel: 3294
> Filesystem: ext3
> Peak load Test: Maximum Jobs per Minute 989.85 (average of 3 runs)
> Quick Convergence Test: Maximum Jobs per Minute 982.07 (average of 3 runs)
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.

Unsurprising. If the expected response time given batching factor K is
T(K) (which also depends on the lock transfer time) T(K)/(K*T(1)) may
have nontrivial maxima and minima in K. I've tried for the expected
waiting time of a few queues (e.g. M/M/1) and verified it's not a
degradation for them, though I've not gone over it in generality
(G/G/m is hard to get results of any kind for anyway). I refrained from
posting a lengthier discussion of the results.


-- wli
