Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266779AbUFXRjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266779AbUFXRjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUFXRjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:39:52 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62178
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266779AbUFXRj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:39:26 -0400
Date: Thu, 24 Jun 2004 19:39:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Takashi Iwai <tiwai@suse.de>, Andi Kleen <ak@suse.de>, ak@muc.de,
       tripperda@nvidia.com, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624173927.GQ30687@dualathlon.random>
References: <m3acyu6pwd.fsf@averell.firstfloor.org> <20040623213643.GB32456@hygelac> <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DAF7DF.9020501@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 01:48:47AM +1000, Nick Piggin wrote:
> 2.6 has the "incremental min" thing. What is wrong with that?
> Though I think it is turned off by default.

I looked more into it and you can leave it turned off since it's not
going to work.

it's all in functions of z->pages_* and those are _global_ for all the
zones, and in turn they're absolutely meaningless.

the algorithm has nothing in common with lowmem_reverse_ratio, the
effect has a tinybit of similarity but the incremntal min thing is so
weak and so bad that it will either not help or it'll waste tons of
memory. Furthemore you cannot set a sysctl value that works for all
machines. The whole thing should be dropped and replaced with the fine
production quality lowmem_reserve_ratio in 2.4.26+

(the only broken thing of lowmem_reserve_ratio is that it cannot be
tuned, not even at boottime, a recompile is needed, but that's fixable
to tune it at boot time, and in theory at runtime too, but the point is
that no dyanmic tuning is required with it)


Please focus on this code of 2.4:

	/*
	 * We don't know if the memory that we're going to allocate will
	 * be freeable or/and it will be released eventually, so to
	 * avoid totally wasting several GB of ram we must reserve some
	 * of the lower zone memory (otherwise we risk to run OOM on the
	 * lower zones despite there's tons of freeable ram on the
	 * higher zones).
	 */
	zone_watermarks_t       watermarks[MAX_NR_ZONES];

typedef struct zone_watermarks_s {
	unsigned long min, low, high;
} zone_watermarks_t;

	class_idx = zone_idx(classzone);

	for (;;) {
		zone_t *z = *(zone++);
		if (!z)
			break;

		if (zone_free_pages(z, order) >
z->watermarks[class_idx].low) {
			page = rmqueue(z, order);
			if (page)
				return page;
		}
	}


		zone->watermarks[j].min = mask;
		zone->watermarks[j].low = mask*2;
		zone->watermarks[j].high = mask*3;
		/* now set the watermarks of the lower zones in the "j"
 * classzone */
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
			lower_zone_reserve = realsize /
lower_zone_reserve_ratio[idx];
			lower_zone->watermarks[j].min +=
lower_zone_reserve;
			lower_zone->watermarks[j].low +=
lower_zone_reserve;
			lower_zone->watermarks[j].high +=
lower_zone_reserve;

			realsize += lower_zone->realsize;
		}


The 2.6 algorithm controlled by the sysctl does nothing similar to the
above.
