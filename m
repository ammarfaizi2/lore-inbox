Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVGKLA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVGKLA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 07:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGKLA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 07:00:28 -0400
Received: from styx.suse.cz ([82.119.242.94]:7894 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261626AbVGKLAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 07:00:25 -0400
Date: Mon, 11 Jul 2005 13:00:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>
Cc: Peter Osterlund <petero2@telia.com>, Andrew Morton <akpm@osdl.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Message-ID: <20050711110024.GA23333@ucw.cz>
References: <20050708101731.GM18608@sd291.sivit.org> <1120821481.5065.2.camel@localhost> <20050708121005.GN18608@sd291.sivit.org> <20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com> <20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com> <1121078371.12621.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121078371.12621.36.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 12:39:31PM +0200, Stelian Pop wrote:
 
> > > Using a function like
> > > 
> > > 	return (x_old * 3 + x) / 4;
> > > 
> > > eliminates the need for a FIFO, and has similar (if not better)
> > > properties to floating average, because its coefficients are
> > > [ .25 .18 .14 .10 ... ].
> > 
> > Agreed.
> 
> Except that this does not work well enough.

I guess the quick motion compensation in input bites you. The above
equation should do even more smoothing than regular 4-point floating
average.

> There are two problems I encountered in this driver:
> * fuzz problems (keeping the finger at the same place makes the pointer
> dance around its position). This is solved by the input core's fuzz
> treatment, as I already set the fuzz to 16 in the code.

OK.

> * hickup problems (moving the finger generates non linear points,
> something like 1 1 1 3 3 3 4 4 4 instead of 1 1 1 2 2 3 3 4 4). And here
> the floating average approach works better than the input core's method.
> (this could probably be solved also by changing the way the absolute
> coordinate is calculated from the sensor array in atp_calculate_abs, but
> I haven't been able to find a better linear function).

I of course won't object to the floating average in the driver if you
say it's needed, I'm just wondering what happens here, because the input
core should smooth this out as well, and if it doesn't, there may be a
problem somewhere.

> > Also, it might be a good idea to compute an ABS_PRESSURE value instead
> > of hardcoding it to 100. I think the psum variable in
> > atp_calculate_abs() can be used, possibly after rescaling.
> 
> I already thought about this, one problem is that the sensors do not
> report the pressure but only the amount of surface touched. A person
> with thick fingers will always generate higher pressures then one with
> thin ones, no matter how hard they push on the touchpad.

That's what all other touchpads do.

> I don't think this value is reliable enough to be reported to the
> userspace as ABS_PRESSURE...

I believe it'd still be more useful than a two-value (0 and 100) output.


> +			/*
> +			 * in the future, we could add here code to search for
> +			 * a second finger...
> +			 * for now, scrolling using the synaptics X driver is
> +			 * much more simpler to achieve.
> +			 */

This could be quite useful, too, for right and middle button taps (2 and
3 fingers) - since the Macs lack these buttons.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
