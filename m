Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266834AbUFXSGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266834AbUFXSGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUFXSGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:06:22 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14054
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266834AbUFXSCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:02:54 -0400
Date: Thu, 24 Jun 2004 20:02:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624180256.GR30687@dualathlon.random>
References: <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624173236.GP30687@dualathlon.random> <20040624173827.GH21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624173827.GH21066@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 10:38:27AM -0700, William Lee Irwin III wrote:
> On Thu, Jun 24, 2004 at 07:32:36PM +0200, Andrea Arcangeli wrote:
> > I did quite a few times and it was successfully merged in 2.4. Now I'd
> > need to forward port to 2.6.
> > I recall I recommended Andrew to merge the lower_zone_reserve_ratio
> > at some point during 2.5 or early 2.6 but apparently he implemented this
> > other thing called sysctl_lower_zone_protection. Note that now that I
> > look more into it, it seems sysctl_lower_zone_protection and
> > lower_zone_reserve_ratio have very little in common, I'm glad
> > sysctl_lower_zone_protection is disabled.  sysctl_lower_zone_protection
> > is just an improvement to the algorithm I dropped from 2.4 when
> > lowmem_zone_reserve_ratio was merged.  So in short enabling
> > sysctl_lower_zone_protection won't help, sysctl_lower_zone_protection
> > should be dropped enterely and replaced with lower_zone_reserve_ratio.
> 
> Could you refer me to an online source (e.g. Message-Id or URL) where
> the deficiencies in the incremental min and/or lower_zone_protection
> that the zone-to-zone watermarks address are described in detail?

I'm talking to Andrew about this very issue since december 2002, so I
mostly giveup except for a few reminders like this one today.

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=20021206145718.GL1567%40dualathlon.random&prev=/groups%3Fq%3Dlinus%2Bgoogle%2Bfix%2Bmin%2Bwatermarks%26hl%3D


I'm confident as people starts to run into the zone inbalance with 2.6
and as google upgrades to 2.6, eventually lowmem_zone_reserve_ratio will
be forward ported to 2.4.26 to 2.6.  I'm not the guy with >4G of ram
anyways, so it won't be myself having troubles with this ;).
Furthermore if you have some swap, the VM can normally relocate the
stuff (you've to be quite unlucky to be filled by pure ptes in the
lowmem zone but it can happen too, but certainly not in my or Andrew's
boxes where we have not more than 2M of ptes anytime allocated).
I already tried to merge this in a preventive-way without a real life
case of somebody cracking down on this trouble like it happened 2.4, but
now I'll only react if somebody has a real life case again in 2.6. This
lowmem vs dma zone thing would be helped very singificantly by the
lowmem_reserve_ratio and that's why I bring up this issue right now and
not one month ago. This is a matter of fact, with my algorithm the dma
zone would be completely preserved for __GFP_DMA allocations on the big
x86-64 boxes. Guaranteeing that no DMA zone will be wasted with ptes or
similar stuff that can very well go in the higher zones.

The "how many bytes" question in my above email is now addressed by the
sysctl_lower_zone_protection but that's still a very weak answer since
it doesn't work for not similar inbalances across different classzones
(i.e. huge dma, tiny lowmem, and even smaller highmem), and furthermore
it requires people to tune by themself in userspace, and they cannot
tune as well as lowmem_reserve_ratio would do since it's a fixed sysctl
for all classzone against classzone imbalances.
