Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280803AbRKTAhK>; Mon, 19 Nov 2001 19:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280804AbRKTAhB>; Mon, 19 Nov 2001 19:37:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6669 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280803AbRKTAgt>; Mon, 19 Nov 2001 19:36:49 -0500
Date: Mon, 19 Nov 2001 16:31:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ken Brownfield <brownfld@irridia.com>
cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <20011119182516.B10597@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.33.0111191621500.19753-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Ken Brownfield wrote:
> |
> | So is this pre6aa1, or pre6 + just the watermark patch?
>
> I'm currently using -pre6 with his separately-posted zone-watermark-1
> patch.  Sorry, I should have been clearer.

Good. That removes the other variables from the equation, ie it's not an
effect of some of the other tweaking in the -aa patches.

> Yeah, maybe a tiered default would be best, IMHO.  5MB on a 3GB box
> does, on the other hand, seem anemic.

Yeah, the 5MB _is_ anemic. It comes from the fact that we decide to never
bother having more than zone_balance_max[] pages free, even if we have
tons of memory. And zone_balance_max[] is fairly small, it limits us to
255 free pages per zone (for page_min - wth "page_low" being twice that).
So you get 3 zones, with 255*2 pages free max each, except the DMA zone
has much less just because it's smaller. Thus 5MB.

There's no real reason for having zone_balance_max[] at all - without it
we'd just always try to keep about 1/128th of memory free, which would be
about 24MB on a 3GB box. Which is probably not a bad idea.

With my "simplified-Andrea" patch, you should see slightly more than 5MB
free, but not a lot more. A HIGHMEM allocation now wants to leave an
"extra" 510 pages in NORMAL, and even more in the DMA zone, so you should
see something like maybe 12-15 MB free instead of 300MB.

(Wild hand-waving number, I'm too lazy to actually do the math, and I
haven't even tested that the simple patch works at all - I think I forgot
to mention that small detail ;)

		Linus

