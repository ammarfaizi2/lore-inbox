Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUFXS57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUFXS57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUFXS42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:56:28 -0400
Received: from holomorphy.com ([207.189.100.168]:50827 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264726AbUFXSvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:51:17 -0400
Date: Thu, 24 Jun 2004 11:50:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624185055.GL21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
	Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
	discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624173236.GP30687@dualathlon.random> <20040624173827.GH21066@holomorphy.com> <20040624180256.GR30687@dualathlon.random> <20040624181311.GJ21066@holomorphy.com> <20040624182737.GT30687@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624182737.GT30687@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:27:37PM +0200, Andrea Arcangeli wrote:
> yes and "the stricter fallback criterion" is precisely called
> lower_zone_reserve_ratio and it's included in the 2.4 mainline kernel
> and this "stricter fallback criterion" doesn't exist in 2.6 yet.
> I do apply it to non-pinned pages too because wasting tons of cpu in
> memcopies for migration is a bad idea compared to reseving 900M of
> absolutely critical lowmem ram on a 64G box. So I find the
> pinned/unpinned parameter worthless and I apply "the stricter fallback
> criterion" to all allocations in the same way, which is a lot simpler,
> doesn't require substantial vm changes to allow migration of ptes,
> anonymous and mlocked memory w/o passing through some swapcache and
> without clearng ptes and most important I believe it's a lot more
> efficient than migrating with bulk memcopies. Even on a big x86-64
> dealing with the migration complexity is worthless, reserving the full
> 16M of dma zone makes a lot more sense.

Not sure what's going on here. I suppose I had different expectations,
e.g. not attempting to relocate kernel allocations, but rather failing
them outright after the threshold is exceeded. No matter, it just saves
me the trouble of implementing it. I understood the migration to be a
method of last resort, not preferred to admission control.


On Thu, Jun 24, 2004 at 08:27:37PM +0200, Andrea Arcangeli wrote:
> The lower_zone_reserve_ratio algorithm scales back to the size of the
> zones automatically autotuned at boot time and the balance-setting are in
> functions of the imbalances found at boot time. That's the fundamental
> difference with the sysctl that is fixed, for all zones, and it has no
> clue on the size of the zones etc...

I wasn't involved with this, so unfortunately I don't have an explanation
of why these semantics were considered useful.


On Thu, Jun 24, 2004 at 08:27:37PM +0200, Andrea Arcangeli wrote:
> So in short with little ram installed it will be like mainline 2.6, with
> tons of ram installed it will make an huge difference and it will
> reserve up to _whole_ classzones to the users that cannot use the higher
> zones, but 16M on a 16G box is nothing so nobody will notice any
> regression anyways, only the befits will be noticeable in the otherwise
> unsolvable corner cases (yeah, you could try to migrate ptes and other
> stuff to solve them but that's incredibily inefficient compared to
> throwing 16M or 800M at the problem on respectively 16G or 64G machines,
> etc..).
> the number aren't math exact with the 2.4 code, but you get an idea of
> the order of magnitude.

This sounds like you're handing back hard allocation failures to
unpinned allocations when zone fallbacks are meant to be discouraged.
Given this, I think I understand where some of the concerns about
merging it came from, though I'd certainly rather have underutilized
memory than workload failures.

I suspect one concern about this is that it may cause premature
workload failures. My own review of the code has determined this to
be a minor concern. Rather, I believe it's better to fail the
allocations earlier than to allow the workload to slowly accumulate
pinned pages in lower zones, even at the cost of underutilizing lower
zones. This belief may not be universal.


On Thu, Jun 24, 2004 at 08:27:37PM +0200, Andrea Arcangeli wrote:
> BTW, I think I'm not the only VM guy who agrees this algo is needed,
> For istance I recall Rik once included the lower_zone_reserve_ratio
> patch in one of his 2.4 patches too.

One of the reasons I've not seen this in practice is that the stress
tests I'm running aren't going on for extended periods of time, where
fallback of pinned allocations to lower zones would be a progressively
more noticeable problem as they accumulate.



-- wli
