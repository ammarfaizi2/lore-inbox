Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbULZSIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbULZSIj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULZSIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:08:38 -0500
Received: from gprs213-131.eurotel.cz ([160.218.213.131]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261720AbULZSIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:08:19 -0500
Date: Sun, 26 Dec 2004 19:08:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: apic and 8254 wraparound ...
Message-ID: <20041226180806.GA1334@elf.ucw.cz>
References: <20041224001144.GA5192@mail.13thfloor.at> <1103845033.15193.6.camel@localhost.localdomain> <20041224200022.GA14956@mail.13thfloor.at> <1103917238.18115.11.camel@localhost.localdomain> <20041225224843.GA32726@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225224843.GA32726@mail.13thfloor.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > When you read one 8bit value from an 8254 timer the values latch for
> > read so that when you read the other half of the 16bit value you get the
> > value from the moment of the first read. On 
> > neptune that didn't work right so you got halves of two differing
> > samples. That means the error would be worst case a bit under 300 (257
> > for the wrap + a few for timing)
> 
> okay, I still wasn't able to find the documentation 
> at the intel site, but I could extrapolate the issue
> from your explanation (thanks by the way)
> 
> get_8254_timer_count() reads lo byte first, then the 
> high byte, so assuming that the latch doesn't work
> as expected on intel 430 NX and LX chipsets, can 
> result in the following type of error:
> 
> counter >= 2^8 * N, 	LO is read (for example 0)
> counter is decremented
> counter <  2^8 * N  	HI is read (N - 1)
> 
> so the read value will be exactly 2^8 lower than
> expected (assumed that the counter doesn't do more
> than 256 counts between the two inb_p()s)
> 
> second the wrap-around will always happen _after_
> the counter reached zero, so we can further assume
> that the prev_count, has to be lower than 2^8, when
> we observe a wraparound (otherwise we don't care)
> 
> let's further assume the counter does not decrement
> more than 2^7 between two consecutive gets, then we
> can change the wraparound check to something like
> this:
> 
>         curr_count = get_8254_timer_count();
> 
> 	do {
>         	prev_count = curr_count;
> 	redo:
>         	curr_count = get_8254_timer_count();
> 
> 		/* workaround for broken Mercury/Neptune */
> 		if (prev_count - current_count >= 256)
> 	    		goto redo;
> 
> 		/* ignore values far off from zero */
>     		if (prev_count > 128)
> 	    		continue;
> 
> 	} while (prev_count >= curr_count)
> 
> 
> basically the check for (prev_count > 128) can be
> removed but it feels a little more comfortable ...
> 
> would such change be acceptable for mainline?

Not sure... Reading time is quite performance critical; doing it twice
would be bad. It should be acceptable if it was only done on
Mercury/Neptune systems.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
