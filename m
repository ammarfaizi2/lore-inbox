Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280812AbRKTAtC>; Mon, 19 Nov 2001 19:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280807AbRKTAsv>; Mon, 19 Nov 2001 19:48:51 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:35043 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S280805AbRKTAsl>; Mon, 19 Nov 2001 19:48:41 -0500
Message-ID: <A9B0C3C90A46D411951400A0C9F4F67103BA576E@pdsmsx33.pd.intel.com>
From: "Yan, Noah" <noah.yan@intel.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>,
        Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: RE: [VM] 2.4.14/15-pre4 too "swap-happy"?
Date: Tue, 20 Nov 2001 08:48:15 +0800
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

Just want to know is there any research/development work now on Linux kernel for IA-64, such as Intel Itanium?

Best Regards,
Noah Yan

SC/Automation Group 
Shanghai Site Manufacturing Computing/IT
Intel Technology (China) Ltd.

IDD: (86 21) 50481818 - 31579
Fax: (86 21) 50481212
Email: noah.yan@intel.com

-----Original Message-----
From: Linus Torvalds [mailto:torvalds@transmeta.com]
Sent: 2001?11?20? 8:31
To: Ken Brownfield
Cc: linux-kernel@vger.kernel.org; Andrea Arcangeli
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?



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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
