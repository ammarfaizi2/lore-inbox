Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135226AbRDZJM3>; Thu, 26 Apr 2001 05:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135240AbRDZJMU>; Thu, 26 Apr 2001 05:12:20 -0400
Received: from chiara.elte.hu ([157.181.150.200]:26638 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135226AbRDZJMJ>;
	Thu, 26 Apr 2001 05:12:09 -0400
Date: Thu, 26 Apr 2001 10:10:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261043330.292-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.30.0104260955540.1546-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2001, Mike Galbraith wrote:

> 2.4.4.pre7.virgin
> real    11m33.589s

> 2.4.4.pre7.sillyness
> real    9m30.336s

very interesting. Looks like there are still reserves in the VM, for heavy
workloads. (and swapping is all about heavy workloads.)

it would be interesting to see why your patch has such a good effect.
(and it would be nice get the same improvement in a clean way.)

> -		if (!page->age)
> -			deactivate_page(page);
> +		age_page_down(page);

this one preserves the cache a bit more agressively.

>  	/* Always start by trying to penalize the process that is allocating memory */
>  	if (mm)
> -		retval = swap_out_mm(mm, swap_amount(mm));
> +		return swap_out_mm(mm, swap_amount(mm));

keep swap-out activity more focused to the process that is generating the
VM pressure. It might make sense to test this single change in isolation.
(While we cannot ignore to swap out other contexts under memory pressure,
we could do something to make it focused on the current MM a bit more.)

> +	static unsigned long lastscan;
> +
> +	if (lastscan == jiffies)
> +		return 0;

limit the runtime of refill_inactive_scan(). This is similar to Rik's
reclaim-limit+aging-tuning patch to linux-mm yesterday. could you try
Rik's patch with your patch except this jiffies hack, does it still
achieve the same improvement?

> +	int shortage = inactive_shortage();
>
> +	if (refill_inactive_scan(DEF_PRIORITY, 0) < shortage)
>  		/* If refill_inactive_scan failed, try to page stuff out.. */
>  		swap_out(DEF_PRIORITY, gfp_mask);
>
> +	return 0;

(i cannot see how this chunk affects the VM, AFAICS this too makes the
zapping of the cache less agressive.)

perhaps the best would be to first test Rik's patch on pre7-vanilla, it
should go in the same direction your changes go, i think?

	Ingo

