Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbULYWst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbULYWst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbULYWss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 17:48:48 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:56032 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261589AbULYWso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 17:48:44 -0500
Date: Sat, 25 Dec 2004 23:48:43 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: apic and 8254 wraparound ...
Message-ID: <20041225224843.GA32726@mail.13thfloor.at>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ingo Molnar <mingo@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041224001144.GA5192@mail.13thfloor.at> <1103845033.15193.6.camel@localhost.localdomain> <20041224200022.GA14956@mail.13thfloor.at> <1103917238.18115.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103917238.18115.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 07:40:38PM +0000, Alan Cox wrote:
> On Gwe, 2004-12-24 at 20:00, Herbert Poetzl wrote:
> > somehow I'm unable to locate it, I can see the 
> > 430TX and 430HX but not the 430NX and 430LX ...
> > 
> > do you have an url for me?
> 
> Not to hand, its under the retired chipset stuff. The details are as
> follows from memory
> 
> When you read one 8bit value from an 8254 timer the values latch for
> read so that when you read the other half of the 16bit value you get the
> value from the moment of the first read. On 
> neptune that didn't work right so you got halves of two differing
> samples. That means the error would be worst case a bit under 300 (257
> for the wrap + a few for timing)

okay, I still wasn't able to find the documentation 
at the intel site, but I could extrapolate the issue
from your explanation (thanks by the way)

get_8254_timer_count() reads lo byte first, then the 
high byte, so assuming that the latch doesn't work
as expected on intel 430 NX and LX chipsets, can 
result in the following type of error:

counter >= 2^8 * N, 	LO is read (for example 0)
counter is decremented
counter <  2^8 * N  	HI is read (N - 1)

so the read value will be exactly 2^8 lower than
expected (assumed that the counter doesn't do more
than 256 counts between the two inb_p()s)

second the wrap-around will always happen _after_
the counter reached zero, so we can further assume
that the prev_count, has to be lower than 2^8, when
we observe a wraparound (otherwise we don't care)

let's further assume the counter does not decrement
more than 2^7 between two consecutive gets, then we
can change the wraparound check to something like
this:

        curr_count = get_8254_timer_count();

	do {
        	prev_count = curr_count;
	redo:
        	curr_count = get_8254_timer_count();

		/* workaround for broken Mercury/Neptune */
		if (prev_count - current_count >= 256)
	    		goto redo;

		/* ignore values far off from zero */
    		if (prev_count > 128)
	    		continue;

	} while (prev_count >= curr_count)


basically the check for (prev_count > 128) can be
removed but it feels a little more comfortable ...

would such change be acceptable for mainline?

TIA,
Herbert

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
