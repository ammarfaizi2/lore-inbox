Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269328AbUICPWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269328AbUICPWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUICPTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:19:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:47510 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269416AbUICPRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:17:18 -0400
Date: Fri, 3 Sep 2004 17:17:10 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george@mvista.com, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       len.brown@intel.com, linux@dominikbrodowski.de, davidm@hpl.hp.com,
       ak@suse.de, paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
Message-ID: <20040903151710.GB12956@wotan.suse.de>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 02:07:19PM -0700, john stultz wrote:
> All,
> 	Here again is my updated time of day proposal. Also to follow is
> working code for i386. I wanted to get this out so folks could actually
> play around with the core architecture independent code. The i386
> specific bits function, but are unfinished. Thus they have been broken
> out and should mostly be ignored for this release.
> 
> I'd really appreciate any feedback or concerns about this proposal and
> the following code. 

Thanks for working on this. Some cleanup in this area was long overdue.

> Functions:
> ----------
> timeofday_hook()
> 	now = read();			/* read the timesource */
> 	ns = cyc2ns(now - offset_base); /* calc nsecs since last call */
> 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> 	system_time += ntp_ns;		/* add scaled value to system_time */
> 	ntp_advance(ns);		/* advance ntp state machine by ns */
> 	offset_base = now;		/* set new offset_base */
> 
> monotonic_clock()
> 	now = read();			/* read the timesource */
> 	ns = cyc2ns(now - offset_base);	/* calculate nsecs since last hook */
> 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> 	return system_time + ntp_ns; 	/* return system_time and scaled value


I am not sure why you have different hooks for timeofday and monotic.
It may be better to read the timeonly once and then convert to monotonic
or TOD.

> 					 */
> 
> settimeofday(desired)
> 	wall_offset = desired - monotonic_clock(); /* set wall offset */
> 
> gettimeofday()
> 	return wall_offset + monotonic_clock();	/* return current timeofday */


Hmm, I am missing something here, but how do you handle
the case where the timer interrupt uses HPET, but the offset
from last timer interrupt is determined using TSC.  But
some machines don't have a reliable TSC, so it may need
to use a different "offset" source.

I guess you would need two different drivers here? 

> o vsyscalls/userspace gettimeofday()
> 	- Mark functions and data w/  __vsyscall attribute
> 	- Use linker to put all __vsyscall data in the same set of pages

That won't work because the kernel needs to write to 
these variables (e.g. to update the wall time from the interrupt
handler). So in general you need two different mappings, one
read only for user space and another writable one for the kernel.

Regarding your patch, putting the delta in a virtual call
seems a bit of overkill. Is that really needed? That was
just from a quick grep, i haven't read it in detail.

-Andi
