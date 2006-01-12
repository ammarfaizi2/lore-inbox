Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWALM2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWALM2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWALM2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:28:43 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:9094 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030374AbWALM2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:28:42 -0500
Date: Thu, 12 Jan 2006 13:28:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/10] NTP: add ntp_update_frequency
In-Reply-To: <1137020731.2890.74.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0601121324510.30994@scrub.home>
References: <Pine.LNX.4.61.0512220021210.30900@scrub.home>
 <1137020731.2890.74.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Jan 2006, john stultz wrote:

> > This introduces ntp_update_frequency and deinlines ntp_clear() (as it's
> > not performance critical).
> > It also changes how tick_nsec is calculated from tick_usec, instead of
> > scaling it using TICK_USEC_TO_NSEC it's simply shifted by the difference.
> > Since ntp doesn't change the tick value, the result in practice is the
> > same, but it's easier to change this into a clock parameter, which can
> > be calculated during boot.
> > 
> 
> One last thing, shouldn't this patch kill TICK_USEC_TO_NSEC ?

If it's the only user it could be removed, but jiffies.h can still be 
cleaned up in a separate pass.

> > @@ -334,10 +334,11 @@ int do_adjtimex(struct timex *txc)
> >  		    time_freq = max(time_freq, -time_tolerance);
> >  		} /* STA_PLL */
> >  	    } /* txc->modes & ADJ_OFFSET */
> > -	    if (txc->modes & ADJ_TICK) {
> > +	    if (txc->modes & ADJ_TICK)
> >  		tick_usec = txc->tick;
> > -		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
> > -	    }
> > +
> > +	    if (txc->modes & ADJ_TICK)
> > +		    ntp_update_frequency();
> 
> Why the extra conditional instead of just adding ntp_update_frequency()
> inside the braces?

This changes in the next patch. :)

> > +void ntp_update_frequency(void)
> > +{
> > +	tick_nsec = tick_usec * 1000;
> > +	tick_nsec -= NSEC_PER_SEC / HZ - TICK_NSEC;
> > +}
> 
> Could you add another "john is slow and forgetful" comment here?

Ok.

bye, Roman
