Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUFXS1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUFXS1g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUFXS1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:27:36 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40681
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263831AbUFXS1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:27:32 -0400
Date: Thu, 24 Jun 2004 20:27:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624182737.GT30687@dualathlon.random>
References: <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624173236.GP30687@dualathlon.random> <20040624173827.GH21066@holomorphy.com> <20040624180256.GR30687@dualathlon.random> <20040624181311.GJ21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624181311.GJ21066@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 11:13:11AM -0700, William Lee Irwin III wrote:
> This sounds like the more precise fix would be enforcing a stricter
> fallback criterion for pinned allocations. Pinned userspace would need
> zone migration if it's done selectively like this.

yes and "the stricter fallback criterion" is precisely called
lower_zone_reserve_ratio and it's included in the 2.4 mainline kernel
and this "stricter fallback criterion" doesn't exist in 2.6 yet.

I do apply it to non-pinned pages too because wasting tons of cpu in
memcopies for migration is a bad idea compared to reseving 900M of
absolutely critical lowmem ram on a 64G box. So I find the
pinned/unpinned parameter worthless and I apply "the stricter fallback
criterion" to all allocations in the same way, which is a lot simpler,
doesn't require substantial vm changes to allow migration of ptes,
anonymous and mlocked memory w/o passing through some swapcache and
without clearng ptes and most important I believe it's a lot more
efficient than migrating with bulk memcopies. Even on a big x86-64
dealing with the migration complexity is worthless, reserving the full
16M of dma zone makes a lot more sense.

The lower_zone_reserve_ratio algorithm scales back to the size of the
zones automatically autotuned at boot time and the balance-setting are in
functions of the imbalances found at boot time. That's the fundamental
difference with the sysctl that is fixed, for all zones, and it has no
clue on the size of the zones etc...

So in short with little ram installed it will be like mainline 2.6, with
tons of ram installed it will make an huge difference and it will
reserve up to _whole_ classzones to the users that cannot use the higher
zones, but 16M on a 16G box is nothing so nobody will notice any
regression anyways, only the befits will be noticeable in the otherwise
unsolvable corner cases (yeah, you could try to migrate ptes and other
stuff to solve them but that's incredibily inefficient compared to
throwing 16M or 800M at the problem on respectively 16G or 64G machines,
etc..).

the number aren't math exact with the 2.4 code, but you get an idea of
the order of magnitude.

BTW, I think I'm not the only VM guy who agrees this algo is needed,
For istance I recall Rik once included the lower_zone_reserve_ratio
patch in one of his 2.4 patches too.
