Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVGJME4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVGJME4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 08:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVGJME4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 08:04:56 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6828 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261910AbVGJMD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 08:03:59 -0400
Date: Sun, 10 Jul 2005 14:04:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Stelian Pop <stelian@popies.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Message-ID: <20050710120425.GC3018@ucw.cz>
References: <20050708101731.GM18608@sd291.sivit.org> <1120821481.5065.2.camel@localhost> <20050708121005.GN18608@sd291.sivit.org> <20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33bqnr3y9.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 12:48:30AM +0200, Peter Osterlund wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > Btw, what I don't completely understand is why you need linear
> > regression, when you're not trying to detect motion or something like
> > that. Basic floating average, or even simpler filtering like the input
> > core uses for fuzz could work well enough I believe.
> 
> Indeed, this function doesn't make much sense:
> 
> +static inline int smooth_history(int x0, int x1, int x2, int x3)
> +{
> +	return x0 - ( x0 * 3 + x1 - x2 - x3 * 3 ) / 10;
> +}
> 
> In the X driver, a derivative estimate is computed from the last 4
> absolute positions, and in that case the least squares estimate is
> given by the factors [.3 .1 -.1 -.3]. However, in this case you want
> to compute an absolute position estimate from the last 4 absolute
> positions, and in this case the least squares estimate is given by the
> factors [.25 .25 .25 .25], ie a floating average. If the function is
> changed to this:
> 
> +static inline int smooth_history(int x0, int x1, int x2, int x3)
> +{
> +	return (x0 + x1 + x2 + x3) / 4;
> +}
> 
> the standard deviation of the noise will be reduced by a factor of 2
> compared to the unfiltered values. With the old smooth_history()
> function, the noise reduction will only be a factor of 1.29.
 
Using a function like

	return (x_old * 3 + x) / 4;

eliminates the need for a FIFO, and has similar (if not better)
properties to floating average, because its coefficients are
[ .25 .18 .14 .10 ... ].

Setting

	absfuzz[ABS_X] = some number;

activates the abovementioned filtering (with additional cutoff and fast
motion compensation) directly in input.c, which should eliminate a lot
of the code in the appletouch driver.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
