Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUCETzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 14:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbUCETzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 14:55:38 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:35246 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262063AbUCETzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 14:55:35 -0500
Date: Fri, 05 Mar 2004 11:55:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <56050000.1078516505@flay>
In-Reply-To: <20040305191329.GR4922@dualathlon.random>
References: <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <39960000.1078512175@flay> <20040305191329.GR4922@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The things I've seen consume ZONE_NORMAL (which aren't reclaimable) are:
>> 
>> 1. mem_map (obviously) (64GB = 704MB of mem_map)
> 
> I was asking 32G, that's half of that and it leaves 500M free. 64G is a
> no-way with 3:1.

Yup.

>> 2. Buffer_heads (much improved in 2.6, though not completely gone IIRC)
> 
> the vm is able to reclaim them before running oom, though it has a
> performance cost.

Didn't used to in SLES8 at least. maybe it does in 2.6 now, I know Andrew
worked on that a lot.
 
>> 3. Pagetables (pte_highmem helps, pmds are existant, but less of a problem,
>> 10,000 tasks would be 117MB)
> 
> pmds seems 13M for 10000 tasks, but maybe I did the math wrong.

3 pages per task = 12K per task = 120,000Kb. Or that's the way I figured
it at least.

>> 4. Kernel stacks (10,000 tasks would be 78MB - 4K stacks would help obviously)
> 
> 4k stacks then need to allocate the task struct in the heap, though it
> still saves ram, but it's not very different.

In 2.6, I think the task struct is outside the kernel stack either way.
Maybe you were pointing out something else? not sure.
 
> The main thing you didn't mention is the overhead in the per-cpu data
> structures, that alone generates an overhead of several dozen mbytes
> only in the page allocator, without accounting the slab caches,
> pagetable caches etc.. putting an high limit to the per-cpu caches
> should make a 32-way 32G work fine with 3:1 too though. 8-way is
> fine with 32G currently.

Humpf. Do you have a hard figure on how much it actually is per cpu?
 
> other relevant things are the fs stuff like file handles per task and
> other pinned slab things.

Yeah, that was a huge one we forgot ... sysfs. Particularly with large
numbers of disks, IIRC, though other resources might generate similar
issues.

> I think pte-highmem is definitely needed on 4:4 too, even if you use
> hugetlbfs that won't cover PAE and the granular window which is quite a
> lot of the ram.
> 
> Overall shared pageteables doesn't payoff for its complexity, rather
> than sharing the pagetables it's better not to allocate them in the
> first place ;) (hugetlbfs/largepages).

That might be another approach, yes ... some more implicit allocation 
stuff would help here - modifying ISV apps is a PITA to get done, and 
takes *forever*. Adam wrote some patches that are sitting in my tree,
some of which were ported forward from SLES8. But then we get into
massive problems with them not being swappable, so you need capabilities,
etc, etc. Ugh.

> The pratical limit of the hardware was 5k tasks, not a kernel issue.
> Your 10k example has never been tested, but obviously at some point a
> limit will trigger (eventually the get_pid will stop finding a free pid
> too ;)

You mean with the 8cpu box you mentioned above? Yes, probably 5K. Larger 
boxes will get progressively scarier ;-)

What scares me more is that we can sit playing counting games all day,
but there's always something we will forget. So I'm not keen on playing
brinkmanship games with customers systems ;-)

M.
