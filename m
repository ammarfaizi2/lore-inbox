Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUCESn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbUCESn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:43:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:4535 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262676AbUCESn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:43:27 -0500
Date: Fri, 05 Mar 2004 10:42:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>
cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <39960000.1078512175@flay>
In-Reply-To: <20040305145837.GZ4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's a nogo for 64G but I would be really pleased to see a workload
> triggering the zone-normal shortage in 32G, I've never seen any one. And
> 16G has even more margin.

The things I've seen consume ZONE_NORMAL (which aren't reclaimable) are:

1. mem_map (obviously) (64GB = 704MB of mem_map)

2. Buffer_heads (much improved in 2.6, though not completely gone IIRC)

3. Pagetables (pte_highmem helps, pmds are existant, but less of a problem,
10,000 tasks would be 117MB)

4. Kernel stacks (10,000 tasks would be 78MB - 4K stacks would help obviously)

5. rmap chains - this is the real killer without objrmap (even 1000 tasks 
sharing a 2GB shmem segment will kill you without large pages).

6. vmas - wierdo Oracle things before remap_file_pages especially.

I may have forgotten some, but I think those were the main ones. 10,000 tasks
is a little heavy, but it's easy to scale the numbers around. I guess my main
point is that it's often as much to do with the number of tasks as it is
with just the larger amount of memory - but bigger machines tend to run more
tasks, so it often goes hand-in-hand.

Also bear in mind that as memory gets tight, the reclaimable things like
dcache and icache will get shrunk, which will hurt performance itself too,
so some of the cost of 4/4 is paid back there too. Without shared pagetables,
we may need highpte even on 4/4, which kind of sucks (can be 10% or so hit).

M.
