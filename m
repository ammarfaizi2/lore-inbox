Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUFXXJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUFXXJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbUFXXJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:09:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8340
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264677AbUFXXJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:09:16 -0400
Date: Fri, 25 Jun 2004 01:09:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624230919.GB30687@dualathlon.random>
References: <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624151130.4a444973.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624151130.4a444973.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 03:11:30PM -0700, Andrew Morton wrote:
> After setting lower_zone_protection to 10:
> 
> Active:111515 inactive:65009 dirty:116 writeback:0 unstable:0 free:3290 slab:75489 mapped:52247 pagetables:446
> DMA free:4172kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
> protections[]: 8 5156 5860
> Normal free:8736kB min:936kB low:1872kB high:2808kB active:352780kB inactive:224972kB present:901120kB
> protections[]: 0 468 1172
> HighMem free:252kB min:128kB low:256kB high:384kB active:93280kB inactive:35064kB present:130516kB
> protections[]: 0 0 64
> 
> It's a bit complex, and perhaps the relative levels of the various
> thresholds could be tightened up.

this is the algorithm I added to 2.4 to produce good protection levels (with
lower_zone_reserve_ratio supposedly tunable at boot time):

static int lower_zone_reserve_ratio[MAX_NR_ZONES-1] = { 256, 32 };


		zone->watermarks[j].min = mask;
		zone->watermarks[j].low = mask*2;
		zone->watermarks[j].high = mask*3;
		/* now set the watermarks of the lower zones in the "j" classzone */
		for (idx = j-1; idx >= 0; idx--) {
			zone_t * lower_zone = pgdat->node_zones + idx;
			unsigned long lower_zone_reserve;
			if (!lower_zone->size)
				continue;

			mask = lower_zone->watermarks[idx].min;
			lower_zone->watermarks[j].min = mask;
			lower_zone->watermarks[j].low = mask*2;
			lower_zone->watermarks[j].high = mask*3;

			/* now the brainer part */
			lower_zone_reserve = realsize / lower_zone_reserve_ratio[idx];
			lower_zone->watermarks[j].min += lower_zone_reserve;
			lower_zone->watermarks[j].low += lower_zone_reserve;
			lower_zone->watermarks[j].high += lower_zone_reserve;

			realsize += lower_zone->realsize;
		}

Your code must be inferior since it doesn't even allow to tune each zone
differently (you seems not to have a lower_zone_reserve_ratio[idx]). Not sure
why you dont' simply forward port the code from 2.4 instead of reinventing it.
