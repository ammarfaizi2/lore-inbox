Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUIJFpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUIJFpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUIJFpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:45:31 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:8310 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268238AbUIJFpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:45:23 -0400
Message-ID: <414133EB.8020802@yahoo.com.au>
Date: Fri, 10 Sep 2004 14:56:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com>
In-Reply-To: <20040910000717.GR3106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> 
>>>Reducing arrival rates by an Omega(NR_CPUS) factor would probably help,
>>>though that may blow the stack on e.g. larger Altixen. Perhaps
>>>O(lg(NR_CPUS)), e.g. NR_CPUS > 1 ? 4*lg(NR_CPUS) : 4 etc., will suffice,
>>>though we may have debates about how to evaluate lg(n) at compile-time...
>>>Would be nice if calls to sufficiently simple __attribute__((pure))
>>>functions with constant args were considered constant expressions by gcc.
> 
> 
> On Thu, Sep 09, 2004 at 04:22:45PM -0700, Andrew Morton wrote:
> 
>>Yes, that sort of thing.
>>It wouldn't be surprising if increasing the pagevec up to 64 slots on big
>>ia64 SMP provided a useful increase in some fs-intensive workloads.
>>One needs to watch stack consumption though.
> 
> 
> Okay, Marcelo, looks like we need to do cache alignment work with a
> variable-size pagevec.
> 
> In order to attempt to compensate for arrival rates to zone->lru_lock
> increasing as O(num_cpus_online()), this patch resizes the pagevec to
> O(lg(NR_CPUS)) for lock amortization that adjusts better to the size of
> the system. Compiletested on ia64.
> 

Yuck. I don't like things like this to depend on NR_CPUS, because your
kernel may behave quite differently depending on the value. But in this
case I guess "quite differently" is probably "a little bit differently",
and practical reality may dictate that you need to do something like
this at compile time, and NR_CPUS is your best approximation.

That said, I *don't* think this should go in hastily.

First reason is that the lru lock is per zone, so the premise that
zone->lru_lock aquisitions increases O(cpus) is wrong for anything large
enough to care (ie. it will be NUMA). It is possible that a 512 CPU Altix
will see less lru_lock contention than an 8-way Intel box.

Secondly is that you'll might really start putting pressure on small L1
caches (eg. Itanium 2) if you bite off too much in one go. If you blow
it, you'll have to pull all the pages into cache again as you process
the pagevec.

I don't think the smallish loop overhead constant (mainly pulling a lock
and a couple of hot cachelines off another CPU) would gain much from
increasing these a lot, either. The overhead should already at least an
order of magnitude smaller than the actual work cost.

Lock contention isn't a good argument either, because it shouldn't
significantly change as you tradeoff hold vs frequency if we assume
that the lock transfer and other overheads aren't significant (which
should be a safe assumption at PAGEVEC_SIZE of >= 16, I think).

Probably a PAGEVEC_SIZE of 4 on UP would be an interesting test, because
your loop overheads get a bit smaller.
