Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbUKBUBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUKBUBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUKBTwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:52:03 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:60331 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261610AbUKBTuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:50:11 -0500
Date: Tue, 2 Nov 2004 20:50:07 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041102195007.GP3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11900000.1099410137@[10.10.2.4]>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 07:42:18AM -0800, Martin J. Bligh wrote:
> the current code appears to be broken - what it's meant to do is refill 

agreed. 

> Though I'm less than convinced in retrospect that there was any point in
> having low watermarks, rather than running it down to zero. Andrew, can

there is not point for low watermark as far as I can tell.

Both the above and this have been fixed in my patch.

> Exactly. The disadvantage of the single list is that cold allocs can steal 
> hot pages, which we believe are precious, and as CPUs get faster, will only 
> get more so (insert McKenney's bog roll here).

a cold page can become hot anytime soon (just when the I/O has
completed and we map it into userspace), plus you're throwing a the
problem twice as much memory as I do to get the same boost.

> Mmmm. Are you actually seeing lock contention on the buddy allocator on
> a real benchmark? I haven't seen it since the advent of hot/cold pages.
> Remember it's not global at all on the larger systems, since they're NUMA.

yes, the pgdat helps there. But certainly doing a single cli should be
faster than a spinlock + buddy algorithms.

This is also to drop down the probability of having to call into the
higher latency of the buddy allocator, this is why the per-cpu lists
exists in UP too. so the more we can work inside the per-cpu lists the
better. This is why the last thing I consider the per-cpu lists are
for buffering. The buffering is really a "refill", because we were
unlucky and no other free_page refilled it, so we've to enter the slow
path.

> Mmmm. I'm still very worried this'll exhaust ZONE_NORMAL on highmem systems,

See my patch, I've all the protection code on top of it. Andi as well
was worried about that and he was right, but then I've fixed it.

> and keep remote pages around instead of returning them to their home node
> on NUMA systems. Not sure that's really what we want, even if we gain a

in my early version of the code I had a:

+               for (i = 0; (z = zones[i]) != NULL; i++) {
+#ifdef CONFIG_NUMA
+                       /* discontigmem doesn't need this, only true numa needs this */
+                       if (zones[0]->zone_pgdat != z->zone_pgdat)   
+                               break
+#endif

I dropped it from the latest just to make it a bit simpler and because I
started to suspect on the new numa it might be faster to use the hot
cache on remote memory, than cold cache on local memory. So effectively
I believe removing the above was going to optimize x86-64 which is the
only numa arch I run anyways. The above code can be made conditional
under an #ifdef CONFIG_SLOW_NUMA of course.

> little in spinlock and immediate cache cost. Nor will it be easy to measure
> since it'll only do anything under memory pressure, and the perf there is
> notoriously unstable for measurement.

under mem pressure it's worthless to measure performance I agree.
However the mainline code under mem pressure was very wrong and it could
have generated early OOM kills by mistake on big boxes with lots of ram,
since you prevented hot allocations to get ram from the cold quicklist
(the breakage I noticed and fixed, and that you acknowledge at the top
of the email) and that would lead to the VM freeing memory and the
application going oom anyways.
