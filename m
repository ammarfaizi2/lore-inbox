Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbUCETM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 14:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbUCETM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 14:12:57 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13074
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262680AbUCETMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 14:12:54 -0500
Date: Fri, 5 Mar 2004 20:13:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305191329.GR4922@dualathlon.random>
References: <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <39960000.1078512175@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39960000.1078512175@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 10:42:55AM -0800, Martin J. Bligh wrote:
> > It's a nogo for 64G but I would be really pleased to see a workload
> > triggering the zone-normal shortage in 32G, I've never seen any one. And
> > 16G has even more margin.
> 
> The things I've seen consume ZONE_NORMAL (which aren't reclaimable) are:
> 
> 1. mem_map (obviously) (64GB = 704MB of mem_map)

I was asking 32G, that's half of that and it leaves 500M free. 64G is a
no-way with 3:1.

> 
> 2. Buffer_heads (much improved in 2.6, though not completely gone IIRC)

the vm is able to reclaim them before running oom, though it has a
performance cost.

> 3. Pagetables (pte_highmem helps, pmds are existant, but less of a problem,
> 10,000 tasks would be 117MB)

pmds seems 13M for 10000 tasks, but maybe I did the math wrong.

> 
> 4. Kernel stacks (10,000 tasks would be 78MB - 4K stacks would help obviously)

4k stacks then need to allocate the task struct in the heap, though it
still saves ram, but it's not very different.

> 
> 5. rmap chains - this is the real killer without objrmap (even 1000 tasks 
> sharing a 2GB shmem segment will kill you without large pages).

this overhead doesn't exist in 2.4.

> 6. vmas - wierdo Oracle things before remap_file_pages especially.

this is one of the main issues of 2.4.

> I may have forgotten some, but I think those were the main ones. 10,000 tasks
> is a little heavy, but it's easy to scale the numbers around. I guess my main
> point is that it's often as much to do with the number of tasks as it is
> with just the larger amount of memory - but bigger machines tend to run more
> tasks, so it often goes hand-in-hand.

yes, an 8-way with 32G it's unlikely that can scale up to 10000 tasks,
regardless, but maybe things change with a 32-way 32G.

The main thing you didn't mention is the overhead in the per-cpu data
structures, that alone generates an overhead of several dozen mbytes
only in the page allocator, without accounting the slab caches,
pagetable caches etc.. putting an high limit to the per-cpu caches
should make a 32-way 32G work fine with 3:1 too though. 8-way is
fine with 32G currently.

other relevant things are the fs stuff like file handles per task and
other pinned slab things.

> Also bear in mind that as memory gets tight, the reclaimable things like
> dcache and icache will get shrunk, which will hurt performance itself too,

for these workloads (the 10000 tasks are the workloads we know very
well) dcache/icache doesn't matter, and still I find 3:1 a more generic
kernel than 4:4 for random workloads too. And if you don't run the 10000
tasks workload then you've the normal-zone free to use for dcache
anyways.

> so some of the cost of 4/4 is paid back there too. Without shared pagetables,
> we may need highpte even on 4/4, which kind of sucks (can be 10% or so hit).

I think pte-highmem is definitely needed on 4:4 too, even if you use
hugetlbfs that won't cover PAE and the granular window which is quite a
lot of the ram.

Overall shared pageteables doesn't payoff for its complexity, rather
than sharing the pagetables it's better not to allocate them in the
first place ;) (hugetlbfs/largepages).

The pratical limit of the hardware was 5k tasks, not a kernel issue.
Your 10k example has never been tested, but obviously at some point a
limit will trigger (eventually the get_pid will stop finding a free pid
too ;)
