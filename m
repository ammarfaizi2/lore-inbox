Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbUKCAXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUKCAXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUKBWn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:43:27 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:49145 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262486AbUKBWlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:41:44 -0500
Date: Tue, 02 Nov 2004 14:41:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@novell.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <235520000.1099435272@flay>
In-Reply-To: <20041102195007.GP3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102195007.GP3571@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Exactly. The disadvantage of the single list is that cold allocs can steal 
>> hot pages, which we believe are precious, and as CPUs get faster, will only 
>> get more so (insert McKenney's bog roll here).
> 
> a cold page can become hot anytime soon (just when the I/O has
> completed and we map it into userspace), 

See other email ... this makes non sense to me.

> plus you're throwing a the
> problem twice as much memory as I do to get the same boost.

Well .... depends on how we do it. Conceptually, I agree with you that
it's really one list. However, I'd like to stop the cold list stealing
from the hot, so I think it's easier to *implement* it as two lists,
because there's nothing in the standard list code to add a magic marker
on one element in the middle (though maybe you can think of a trick way
to do that). Moving things from one list to the other is pretty cheap
because we can use the splice operations.
 
>> Mmmm. Are you actually seeing lock contention on the buddy allocator on
>> a real benchmark? I haven't seen it since the advent of hot/cold pages.
>> Remember it's not global at all on the larger systems, since they're NUMA.
> 
> yes, the pgdat helps there. But certainly doing a single cli should be
> faster than a spinlock + buddy algorithms.

Yes, it's certainly faster to do that one operation - no dispute from me.
However, the question is whether it's worth trading off against the
cache-warmth of pages ... that's why we wrote it that way originally, to
preserve that.

> This is also to drop down the probability of having to call into the
> higher latency of the buddy allocator, this is why the per-cpu lists
> exists in UP too. so the more we can work inside the per-cpu lists the
> better. This is why the last thing I consider the per-cpu lists are
> for buffering. The buffering is really a "refill", because we were
> unlucky and no other free_page refilled it, so we've to enter the slow
> path.

yup, exactly.
 
>> Mmmm. I'm still very worried this'll exhaust ZONE_NORMAL on highmem systems,
> 
> See my patch, I've all the protection code on top of it. Andi as well
> was worried about that and he was right, but then I've fixed it.

OK, I'll go read it.
 
>> and keep remote pages around instead of returning them to their home node
>> on NUMA systems. Not sure that's really what we want, even if we gain a
> 
> in my early version of the code I had a:
> 
> +               for (i = 0; (z = zones[i]) != NULL; i++) {
> +#ifdef CONFIG_NUMA
> +                       /* discontigmem doesn't need this, only true numa needs this */
> +                       if (zones[0]->zone_pgdat != z->zone_pgdat)   
> +                               break
> +#endif
> 
> I dropped it from the latest just to make it a bit simpler and because I
> started to suspect on the new numa it might be faster to use the hot
> cache on remote memory, than cold cache on local memory. So effectively
> I believe removing the above was going to optimize x86-64 which is the
> only numa arch I run anyways. The above code can be made conditional
> under an #ifdef CONFIG_SLOW_NUMA of course.

Probably easier to make it a per-arch option to define, but yes, if one
arch works better one way, and others the other, we can make it optional
fairly easily in lots of ways. <insert traditional disagreement with
"new" vs "old" connotations here ...>
 
>> little in spinlock and immediate cache cost. Nor will it be easy to measure
>> since it'll only do anything under memory pressure, and the perf there is
>> notoriously unstable for measurement.
> 
> under mem pressure it's worthless to measure performance I agree.
> However the mainline code under mem pressure was very wrong and it could
> have generated early OOM kills by mistake on big boxes with lots of ram,
> since you prevented hot allocations to get ram from the cold quicklist
> (the breakage I noticed and fixed, and that you acknowledge at the top
> of the email) and that would lead to the VM freeing memory and the
> application going oom anyways.

Well, remember that the lists only contain a very small amount of memory
relative to the machine size anyway, so I'm not really worried about us
triggering early OOMs or whatever.

But however one chose to fix this, it'd require more specialization in
the allocator (knowing about hot/cold, or merging into one list), so not
sure how concerned Andrew is about that (see his other email on the subject)

