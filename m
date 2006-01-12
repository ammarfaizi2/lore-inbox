Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWALNBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWALNBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 08:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWALNBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 08:01:33 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:20358 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030395AbWALNBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 08:01:32 -0500
Date: Thu, 12 Jan 2006 14:01:28 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/10] NTP: convert time_offset to nsec
In-Reply-To: <1137022168.2890.93.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0601121330260.30994@scrub.home>
References: <Pine.LNX.4.61.0512220022350.30906@scrub.home>
 <1137022168.2890.93.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Jan 2006, john stultz wrote:

> >  		        if (mtemp < MAXSEC) {
> > -			    ltemp *= mtemp;
> > -			    time_freq += shift_right(ltemp,(time_constant +
> > +			    freq_adj = (s64)ltemp * mtemp;
> > +			    time_freq += shift_right(freq_adj,(time_constant +
> >  						       time_constant +
> >  						       SHIFT_KF - SHIFT_USEC));
> >  			} else /* calibration interval too long (p. 12) */
> 
> While you're there, mind changing mtemp to adjtime_interval or something
> more clear? Probably something similar to ltemp as well.

Ok, but I think I'll rename existing variables in separate patch.

> > @@ -332,6 +340,7 @@ int do_adjtimex(struct timex *txc)
> >  		    }
> >  		    time_freq = min(time_freq, time_tolerance);
> >  		    time_freq = max(time_freq, -time_tolerance);
> > +		    time_offset = (time_offset / HZ) << SHIFT_HZ;
> 
> time_offset has already been bounded and set. Mind commenting on what
> this is doing?

This scales the time_offset value so that later at every tick you add 
only (time_offset >> SHIFT_HZ) and after HZ ticks time is changed by 
time_offset and so makes the crude compensation later completely 
unnecessary.

> > +	if (time_offset < 0) {
> > +		ltemp = -time_offset;
> > +		if (!(time_status & STA_FLL))
> > +			ltemp >>= SHIFT_KG + time_constant;
> > +		if (ltemp > (((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC))
> > +			ltemp = ((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC;
> > +		time_offset += ltemp;
> > +		tick_nsec_curr -= ltemp >> SHIFT_HZ;
> > +		time_adj_curr -= (ltemp << (SHIFT_SCALE - SHIFT_HZ)) & (FINENSEC - 1);
> > +		if (time_adj_curr < 0) {
> > +			tick_nsec_curr--;
> > +			time_adj_curr += FINENSEC;
> > +		}
> > +	} else {
> > +		ltemp = time_offset;
> > +		if (!(time_status & STA_FLL))
> > +			ltemp >>= SHIFT_KG + time_constant;
> > +		if (ltemp > (((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC))
> > +			ltemp = ((MAXPHASE / HZ) << SHIFT_HZ) / MINSEC;
> > +		time_offset -= ltemp;
> > +		tick_nsec_curr += ltemp >> SHIFT_HZ;
> > +		time_adj_curr += (ltemp << (SHIFT_SCALE - SHIFT_HZ)) & (FINENSEC - 1);
> > +		if (time_adj_curr >= FINENSEC) {
> > +			tick_nsec_curr++;
> > +			time_adj_curr -= FINENSEC;
> > +		}
> > +	}
> 
> Again, more comments would help.
> 
> Also, these big "if negative, lot of coding adding else lots of code
> subtracting" switches strike me as code duplication. It may not be as
> efficient, but would you consider re-working this to save off the sign,
> doing the math once and then applying the sign back? Parts of the above
> already do this. See also the shift_right() macro.

This part will change at some point anyway, when tick_nsec_curr/ 
time_adj_curr are merged to a single 64 bit value, until then I prefer to 
keep it a bit more verbose, but also a bit more efficient.

bye, Roman
