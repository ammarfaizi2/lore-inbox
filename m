Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268472AbUILFYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268472AbUILFYF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUILFYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:24:05 -0400
Received: from holomorphy.com ([207.189.100.168]:20099 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268463AbUILFXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:23:17 -0400
Date: Sat, 11 Sep 2004 22:23:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040912052308.GE2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <41439884.8040909@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41439884.8040909@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>> For me Bill's patch (with the recursive thingie) is very cryptic. Its
>> just doing log2(n), it took me an hour to figure it out with his help.

On Sun, Sep 12, 2004 at 10:29:56AM +1000, Nick Piggin wrote:
> Having it depend on NR_CPUS should be avoided if possible.
> But yeah in this case I guess you can't easily make it work
> at runtime.

With some work it could be tuned at boot-time.


Marcelo Tosatti wrote:
>> Oops, right. wli's patch is borked for NUMA. Clamping it at 64 should do 
>> fine.

On Sun, Sep 12, 2004 at 10:29:56AM +1000, Nick Piggin wrote:
> Is 16 any good? ;)

There are nontrivial differences in the optimal batching factor
dependent on the distribution of hold times and interarrival times. The
strongest dependencies of all are on ratio of the lock transfer time to
the interarrival time and the lock transfer time itself. These appear
routinely in numerous odd places in the expressions for expected
response time, and the latter often as a constant of proportionality.


On Sun, Sep 12, 2004 at 10:29:56AM +1000, Nick Piggin wrote:
>> Whats the L1 cache size of Itanium2? Each page is huge compared to the 
>> pagevec structure (you need a 64 item pagevec array on 64-bits to
>> occupy the space of one 4KB page). So I think you wont blow up the
>> cache even with a really big pagevec.

On Sun, Sep 12, 2004 at 10:29:56AM +1000, Nick Piggin wrote:
> I think it is 16K data cache. It is not the pagevec structure that you
> are worried about, but all the cachelines from all the pages you put
> into it. If you put 64 pages in it, that's 8K with a 128byte cacheline
> size (the structure will be ~512 bytes on a 64-bit arch).
> And if you touch one other cacheline per page, there's 16K.
> So I'm just making up numbers, but the point is you obviously want to
> keep it as small as possible unless you can demonstrate improvements.

It's unclear what you're estimating the size of. PAGEVEC_SIZE of 62
yields a 512B pagevec, for 4 cachelines exclusive to the cpu (or if
stack allocated, the task). The pagevecs themselves are not shared,
so the TLB entries for per-cpu pagevecs span surrouding per-cpu data,
not other cpus' pagevecs, and the TLB entries for stack-allocated
pagevecs are in turn shared with other stack-allocated data.


Marcelo Tosatti wrote:
>> Not very noticeable on reaim. I want to do more tests (different 
>> workloads, nr CPUs, etc).

On Sun, Sep 12, 2004 at 10:29:56AM +1000, Nick Piggin wrote:
> Would be good.

On Sun, Sep 12, 2004 at 10:29:56AM +1000, Nick Piggin wrote:
> To get a best case argument for increasing the size of the structure, I 
> guess you'll want to setup tests to put the maximum contention on the
> lru_lock. That would mean big non NUMAs (eg. OSDL's stp8 systems),
> lots of page reclaim so you'll have to fill up the caches, and lots
> of read()'ing.

mapping->tree_lock is affected as well as zone->lru_lock. The workload
obviously has to touch the relevant locks for pagevecs to be relevant;
however, the primary factor in the effectiveness of pagevecs is the
lock transfer time, which is not likely to vary significantly on boxen
such as the OSDL STP machines. You should use a workload stressing
mapping->tree_lock via codepaths using radix_tree_gang_lookup() and
getting runtime on OSDL's NUMA-Q or otherwise asking SGI to test its
effects, otherwise you're dorking around with boxen with identical
characteristics as far as batched locking is concerned.


-- wli
