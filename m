Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbUCEO57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbUCEO57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:57:59 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21000
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262614AbUCEO56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:57:58 -0500
Date: Fri, 5 Mar 2004 15:58:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305145837.GZ4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305143210.GA11897@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 03:32:10PM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > [...] 8/16/32G boxes works perfectly with 3:1 with the stock 2.4 VM
> > (after you nuke rmap).
> 
> the mem_map[] on 32G is 400 MB (using the stock 2.4 struct page). This
> leaves ~500 MB for the lowmem zone. It's ridiculously easy to use up 500

yes, mem_map_t takes 384M that leaves us 879-384 = 495Mbyte of
zone-normal.

> MB of lowmem. 500 MB is a lowmem:RAM ratio of 1:60. With 4/4 you have 6
> times more lowmem. So starting at 32 GB (but often much earlier) the 3/1
> split breaks down. And you obviously it's a no-go at 64 GB.

It's a nogo for 64G but I would be really pleased to see a workload
triggering the zone-normal shortage in 32G, I've never seen any one. And
16G has even more margin.

Note that on a 32G box with my google-logic a correct kernel like latest
2.4 mainline reserves 100% of the zone-normal to allocations that cannot
go in highmem, plus the vm highmem fixes like bh and inode zone-normal
related reclaims. Without those logics it would be easy to run oom due
highmem allocations going into zone-normal but that's just a vm issue
and it's fixed (all fixes should be in mainline already).

> inbetween it all depends on the workload. If the 3:1 split works fine
> then sure, use it. There's no one kernel that fits all sizes.

yes, the inbetween definitely works fine but there's always plenty of
margin even on the 32G in all heavy workloads I've seen. I've not a
single pending report for 32G boxes, all the bugreports starts at >=48G
and that tells you those 32G users had a 198M of margin free to use for
the peak loads which are more than enough in practice. I agree it's not
a huge margin, but it's quite reasonable considering they've only 60-70%
of the zone-normal pinned during the workload.
