Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268506AbUILHVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268506AbUILHVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268511AbUILHVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:21:25 -0400
Received: from holomorphy.com ([207.189.100.168]:56451 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268506AbUILHUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:20:12 -0400
Date: Sun, 12 Sep 2004 00:19:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040912071948.GH2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com> <4143D07E.3030408@yahoo.com.au> <20040912062703.GF2660@holomorphy.com> <4143E6C6.40908@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4143E6C6.40908@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> No, I'd expect zone->lru_lock to be taken most often for lru_cache_add()
>> and lru_cache_del().

On Sun, Sep 12, 2004 at 04:03:50PM +1000, Nick Piggin wrote:
> Well "lru_cache_del" will be often coming from the scanner.
> lru_cache_add should be being performed on newly allocated pages,
> which should be node local most of the time.

I presume page scanning to be rare outside memory-starved systems. I
would expect lru_cache_del() in the scanner to originate from evictions
of inodes in some odd cases, and from process or virtual area
destruction in the case of anonymous memory.


William Lee Irwin III wrote:
>> There can be no adequate compile-time metric of L1 cache size. 64B
>> cachelines with 16KB caches sounds a bit small, 256 entries, which is
>> even smaller than TLB's on various systems.

On Sun, Sep 12, 2004 at 04:03:50PM +1000, Nick Piggin wrote:
> Although I'm pretty sure that is what Itanium 2 has. P4s may even
> have 128B lines and 16K L1 IIRC.

Pathetic and not particularly intelligent on the cpu designers' parts.
The L1 cache should be large enough to cover at least two base pages
and have at least as many entries as the TLB.


William Lee Irwin III wrote:
>> In general a hard cap at the L1 cache size would be beneficial for
>> operations done in tight loops, but there is no adequate detection
>> method. Also recall that the page structures things will be touched
>> regardless if they are there to be touched in a sufficiently large
>> pagevec.  Various pagevecs are meant to amortize locking done in
>> scenarios where there is no relationship between calls. Again,
>> lru_cache_add() and lru_cache_del() are the poster children. These
>> operations are often done for one page at a time in some long codepath,
>> e.g. fault handlers, and the pagevec is merely deferring the work until
>> enough has accumulated. radix_tree_gang_lookup() and mpage_readpages()
>> OTOH execute the operations to be done under the locks in tight loops,
>> where the lock acquisitions are to be done immediately by the same caller.
>> This differentiation between the characteristics of pagevec users
>> happily matches the cases where they're used on-stack and per-cpu.
>> In the former case, larger pagevecs are desirable, as the cachelines
>> will not be L1-hot regardless; in the latter, L1 size limits apply.

On Sun, Sep 12, 2004 at 04:03:50PM +1000, Nick Piggin wrote:
> Possibly, I don't know. Performing a large stream of faults to
> map in a file could easily keep all pages of a small pagevec
> in cache.
> Anyway, the point I'm making is just that you don't want to be
> expanding this thing just because you can. If all else is equal,
> a smaller size is obviously preferable. So obviously, simple
> testing is required - but I don't think I need to be telling you
> that ;)

A large stream of faults to map in a file will blow L1 caches of the
sizes you've mentioned at every kernel/user context switch. 256 distinct
cachelines will very easily be referenced between faults. MAP_POPULATE
and mlock() don't implement batching for either ->page_table_lock or
->tree_lock, so the pagevec point is moot in pagetable instantiation
codepaths (though it probably shouldn't be).

O_DIRECT writes and msync(..., ..., MS_SYNC) will use pagevecs on
->tree_lock in a rapid-fire process-triggerable manner. Almost all
uses of pagevecs for ->lru_lock outside the scanner that I'm aware
of are not rapid-fire in nature (though there probably should be some).
IMHO pagevecs are somewhat underutilized.


William Lee Irwin III wrote:
>> 4*lg(NR_CPUS) is 64 for 16x-31x boxen. No constant number suffices.
>> Adaptation to systems and the usage cases would be an improvement.

On Sun, Sep 12, 2004 at 04:03:50PM +1000, Nick Piggin wrote:
> Ignore my comments about disliking compile time sizing: the main
> thing is to just find improvements, and merge-worthy implementation
> can follow.

Sorry, 4*lg(NR_CPUS) is 64 when lg(NR_CPUS) = 16, or 65536 cpus. 512x
Altixen would have 4*lg(512) = 4*9 = 36. The 4*lg(NR_CPUS) sizing was
rather conservative on behalf of users of stack-allocated pagevecs.


-- wli
