Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUFXWv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUFXWv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUFXWse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:48:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58259
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265811AbUFXWpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:45:30 -0400
Date: Fri, 25 Jun 2004 00:45:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de, ak@muc.de,
       tripperda@nvidia.com, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624224529.GA30687@dualathlon.random>
References: <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624220823.GO21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624220823.GO21066@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 03:08:23PM -0700, William Lee Irwin III wrote:
> The prolonged memory pressure and so on are things that we've
> unfortunately had to wait until extended runtime in production to see. =(

Luckily this problem doesn't fall in this scenario and it's trivial to
reproduce if you've >= 2G of ram. I still have here the testcase google
sent me years ago when this problem seen the light during 2.4.1x. They
used mlock, but it's even simpler to reproduce it with a single malloc +
bzero (note: no mlock). The few mbytes of lowmem left won't last long if
you load some big app after that.

> The underutilization bit is actually why I keep going on and on about
> the pinned pagecache relocation; it resolves a portion of the problem
> of pinned pages in lower zones without underutilizing RAM, then once

I also don't like the underutilization but I believe it's a price
everybody has to pay if you buy x86. On x86-64 the cost of the insurance
is much lower, max 16M wasted, and absolutely nothing wasted if you've
an amd system (all amd systems have a real iommu that avoids having to
mess with the physical ram addresses).

it's like an health insurance, you can avoid to pay it but it might not
turn out to be a good idea for everyone not pay for it. At least you
should give the choice to the people to be able to pay for it and to
have it, and the sysctl is not going to work. It's relatively very cheap
as Andrew said, if you've very few mbytes of lowmemory you're going to
pay very few kbytes for it. But I think we should force everyone to have
it like I did in 2.4 and absolutely nobody complained, infact if
something somebody could complain _without_ it. Sure nobody cares about
800M of ram on a 64G machine when they risk to swap-slowdown (and vfs
caches overshrink) and in the worst case to lockup without swap without
the "insurance". I don't think one should be forced to have swap on a
64G box if the userspace apps have a very well defined high bound of ram
utilization.  There will be always a limit anyways that is ram+swap, so
ideally if we had infinite money it would _always_ better to replace
swap with more ram and to never have swap, swap still make sense only
because disk is still cheaper than ram (watch MRAM). So a VM that
destabilizes without swap is not a VM that I can avoid to fix and to me
it remains a major bug even if nobody will ever notice it because we
don't have that much cheap ram yet.

About the ability to tune it at least at boot time, I always wanted it
and I added the setup_lower_zone_reserve parameter, but that is parsed
too late, so it doesn't work due a minor implementation detail ;), like
also setup_mem_frac apparently doesn't work too.
