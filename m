Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135242AbRDZJcC>; Thu, 26 Apr 2001 05:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135245AbRDZJbw>; Thu, 26 Apr 2001 05:31:52 -0400
Received: from www.wen-online.de ([212.223.88.39]:7944 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135242AbRDZJbo>;
	Thu, 26 Apr 2001 05:31:44 -0400
Date: Thu, 26 Apr 2001 11:31:06 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.30.0104260955540.1546-100000@elte.hu>
Message-ID: <Pine.LNX.4.33.0104261121390.313-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Ingo Molnar wrote:

> On Thu, 26 Apr 2001, Mike Galbraith wrote:
>
> > 2.4.4.pre7.virgin
> > real    11m33.589s
>
> > 2.4.4.pre7.sillyness
> > real    9m30.336s
>
> very interesting. Looks like there are still reserves in the VM, for heavy
> workloads. (and swapping is all about heavy workloads.)
>
> it would be interesting to see why your patch has such a good effect.
> (and it would be nice get the same improvement in a clean way.)

It's not good.. it's an ugly beaste from hell ;-)

> > -		if (!page->age)
> > -			deactivate_page(page);
> > +		age_page_down(page);
>
> this one preserves the cache a bit more agressively.

(intent)

>
> >  	/* Always start by trying to penalize the process that is allocating memory */
> >  	if (mm)
> > -		retval = swap_out_mm(mm, swap_amount(mm));
> > +		return swap_out_mm(mm, swap_amount(mm));
>
> keep swap-out activity more focused to the process that is generating the
> VM pressure. It might make sense to test this single change in isolation.
> (While we cannot ignore to swap out other contexts under memory pressure,
> we could do something to make it focused on the current MM a bit more.)

(also the intent.. make 'em pagein like a bugger to slow down cache munh)

> > +	static unsigned long lastscan;
> > +
> > +	if (lastscan == jiffies)
> > +		return 0;
>
> limit the runtime of refill_inactive_scan(). This is similar to Rik's
> reclaim-limit+aging-tuning patch to linux-mm yesterday. could you try
> Rik's patch with your patch except this jiffies hack, does it still
> achieve the same improvement?

No.  It livelocked on me with almost all active pages exausted.

> > +	int shortage = inactive_shortage();
> >
> > +	if (refill_inactive_scan(DEF_PRIORITY, 0) < shortage)
> >  		/* If refill_inactive_scan failed, try to page stuff out.. */
> >  		swap_out(DEF_PRIORITY, gfp_mask);
> >
> > +	return 0;
>
> (i cannot see how this chunk affects the VM, AFAICS this too makes the
> zapping of the cache less agressive.)

(more folks get snagged on write.. they can't eat cache so fast)

	-Mike

