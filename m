Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUIKVHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUIKVHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268322AbUIKVHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:07:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41146 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268330AbUIKVFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:05:04 -0400
Date: Fri, 10 Sep 2004 14:49:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040910174915.GA4750@logos.cnet>
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414133EB.8020802@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 02:56:11PM +1000, Nick Piggin wrote:
> William Lee Irwin III wrote:
> >William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> >>>Reducing arrival rates by an Omega(NR_CPUS) factor would probably help,
> >>>though that may blow the stack on e.g. larger Altixen. Perhaps
> >>>O(lg(NR_CPUS)), e.g. NR_CPUS > 1 ? 4*lg(NR_CPUS) : 4 etc., will suffice,
> >>>though we may have debates about how to evaluate lg(n) at compile-time...
> >>>Would be nice if calls to sufficiently simple __attribute__((pure))
> >>>functions with constant args were considered constant expressions by gcc.
> >
> >
> >On Thu, Sep 09, 2004 at 04:22:45PM -0700, Andrew Morton wrote:
> >
> >>Yes, that sort of thing.
> >>It wouldn't be surprising if increasing the pagevec up to 64 slots on big
> >>ia64 SMP provided a useful increase in some fs-intensive workloads.
> >>One needs to watch stack consumption though.
> >
> >
> >Okay, Marcelo, looks like we need to do cache alignment work with a
> >variable-size pagevec.
> >
> >In order to attempt to compensate for arrival rates to zone->lru_lock
> >increasing as O(num_cpus_online()), this patch resizes the pagevec to
> >O(lg(NR_CPUS)) for lock amortization that adjusts better to the size of
> >the system. Compiletested on ia64.
> >
> 
> Yuck. I don't like things like this to depend on NR_CPUS, because your
> kernel may behave quite differently depending on the value. But in this
> case I guess "quite differently" is probably "a little bit differently",
> and practical reality may dictate that you need to do something like
> this at compile time, and NR_CPUS is your best approximation.

For me Bill's patch (with the recursive thingie) is very cryptic. Its
just doing log2(n), it took me an hour to figure it out with his help.

> That said, I *don't* think this should go in hastily.
> 
> First reason is that the lru lock is per zone, so the premise that
> zone->lru_lock aquisitions increases O(cpus) is wrong for anything large
> enough to care (ie. it will be NUMA). It is possible that a 512 CPU Altix
> will see less lru_lock contention than an 8-way Intel box.

Oops, right. wli's patch is borked for NUMA. Clamping it at 64 should do fine.

> Secondly is that you'll might really start putting pressure on small L1
> caches (eg. Itanium 2) if you bite off too much in one go. If you blow
> it, you'll have to pull all the pages into cache again as you process
> the pagevec.

Whats the L1 cache size of Itanium2? Each page is huge compared to the pagevec
structure (you need a 64 item pagevec array on 64-bits to occupy the space of 
one 4KB page). So I think you wont blow up the cache even with a really big 
pagevec.

> I don't think the smallish loop overhead constant (mainly pulling a lock
> and a couple of hot cachelines off another CPU) would gain much from
> increasing these a lot, either. The overhead should already at least an
> order of magnitude smaller than the actual work cost.
> 
> Lock contention isn't a good argument either, because it shouldn't
> significantly change as you tradeoff hold vs frequency if we assume
> that the lock transfer and other overheads aren't significant (which
> should be a safe assumption at PAGEVEC_SIZE of >= 16, I think).
> 
> Probably a PAGEVEC_SIZE of 4 on UP would be an interesting test, because
> your loop overheads get a bit smaller.

Not very noticeable on reaim. I want to do more tests (different workloads, nr CPUs, etc).

                                                                                                                                                                                   
kernel: pagevec-4
plmid: 3304
Host: stp1-002
Reaim test
http://khack.osdl.org/stp/297484
kernel: 3304
Filesystem: ext3
Peak load Test: Maximum Jobs per Minute 992.40 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 987.72 (average of 3 runs)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

kernel: 2.6.9-rc1-mm4
plmid: 3294
Host: stp1-003
Reaim test
http://khack.osdl.org/stp/297485
kernel: 3294
Filesystem: ext3
Peak load Test: Maximum Jobs per Minute 989.85 (average of 3 runs)
Quick Convergence Test: Maximum Jobs per Minute 982.07 (average of 3 runs)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.





