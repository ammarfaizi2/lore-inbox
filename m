Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269131AbUINCWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269131AbUINCWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269114AbUINCUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:20:18 -0400
Received: from holomorphy.com ([207.189.100.168]:4496 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268834AbUINCSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:18:49 -0400
Date: Mon, 13 Sep 2004 19:18:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040914021844.GN9106@holomorphy.com>
References: <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com> <4143D07E.3030408@yahoo.com.au> <20040912062703.GF2660@holomorphy.com> <4143E6C6.40908@yahoo.com.au> <20040912071948.GH2660@holomorphy.com> <20040912004256.59a74c28.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912004256.59a74c28.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> A large stream of faults to map in a file will blow L1 caches of the
>>  sizes you've mentioned at every kernel/user context switch. 256 distinct
>>  cachelines will very easily be referenced between faults. MAP_POPULATE
>>  and mlock() don't implement batching for either ->page_table_lock or
>>  ->tree_lock, so the pagevec point is moot in pagetable instantiation
>>  codepaths (though it probably shouldn't be).

On Sun, Sep 12, 2004 at 12:42:56AM -0700, Andrew Morton wrote:
> Instantiation via normal fault-in becomes lock-intensive once you have
> enough CPUs.  At low CPU count the page zeroing probably preponderates.

But that's mm->page_table_lock, for which pagevecs aren't used, and for
faulting there isn't a batch of work to do anyway, so other methods are
needed, e.g. more finegrained pte locking or lockless pagetable radix
trees. I'd favor going fully lockless, but haven't put any code down
for it myself.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> O_DIRECT writes and msync(..., ..., MS_SYNC) will use pagevecs on
>> ->tree_lock in a rapid-fire process-triggerable manner. Almost all
>> uses of pagevecs for ->lru_lock outside the scanner that I'm aware
>> of are not rapid-fire in nature (though there probably should be some).

On Sun, Sep 12, 2004 at 12:42:56AM -0700, Andrew Morton wrote:
> pagetable teardown (munmap, mremap, exit) is the place where pagevecs help
> ->lru_lock.  And truncate.

truncate is rare enough I didn't bother but that probably hurts it the
worst. I'd expect pte teardown to affect mostly anonymous pages, as
file-backed pages will have a reference from the mapping holding them
until either that's shot down or they're evicted via page replacement.


William Lee Irwin III <wli@holomorphy.com> wrote:
>>  IMHO pagevecs are somewhat underutilized.

On Sun, Sep 12, 2004 at 12:42:56AM -0700, Andrew Morton wrote:
> Possibly.  I wouldn't bother converting anything unless a profiler tells
> you to though.

mlock() is the case I have in hand, though I've only heard of it being
problematic on vendor kernels. MAP_POPULATE is underutilized in
userspace thus far, so I've not heard anything about it good or bad.


William Lee Irwin III <wli@holomorphy.com> wrote:
>>  Sorry, 4*lg(NR_CPUS) is 64 when lg(NR_CPUS) = 16, or 65536 cpus. 512x
>>  Altixen would have 4*lg(512) = 4*9 = 36. The 4*lg(NR_CPUS) sizing was
>>  rather conservative on behalf of users of stack-allocated pagevecs.

On Sun, Sep 12, 2004 at 12:42:56AM -0700, Andrew Morton wrote:
> It's pretty simple to diddle PAGEVEC_SIZE, run a few benchmarks.  If that
> makes no difference then the discussion is moot.  If it makes a significant
> difference then more investigation is warranted.

It only really applies when either the lock transfer time is high, such
as it is in NUMA architectures with high remote access latencies to
sufficiently distant nodes, or the arrival rates are high, such as they
are in unusual workloads, as the common cases (and even some of the
unusual ones) have already been addressed. Marcelo's original bits
about cache alignment are likely more pressing; my real hope was to get
some guess at the pagevec size based on NR_CPUS, align it upward to a
cacheline boundary, and subtract the size of the header information,
but as I found there are diminishing returns, and there are cache size
boundaries to be concerned about, I'd favor advancing marcelo's cache
alignment work prior to exploring larger batches' benefits.


-- wli
