Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbULHTLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbULHTLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbULHTLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:11:43 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:45483 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261323AbULHTLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:11:21 -0500
Subject: Re: [RFC] New timeofday proposal (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
In-Reply-To: <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1102533066.1281.81.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Dec 2004 11:11:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 10:25, Christoph Lameter wrote:
> On Tue, 7 Dec 2004, john stultz wrote:
> 
> > Features of this design:
> > ========================
> 
> > o Consolidates a large amount of code:
> > 	Allows for shared times source implementations, such as: i386, x86-64
> > and ia64 all use HPET, i386 and x86-64 both have ACPI PM timers, and
> > i386 and ia64 both have cyclone counters. Time sources are just drivers!
> 
> What I would to see also included here is to provide a clean posix
> interface to these drivers. IMHO the current char interfaces to clock
> drivers should be removed. Look at SGI's mmtimer implementation in
> 2.6.10-rc3. We have modified the posix interface to allow clock drivers to
> export their timer values via CLOCK_SGI_CYCLE and we are also
> now able to schedule hardware interrupts via timer_* posix functions
> utilizing CLOCK_SGI_CYCLE that are then delivered as signals to an
> application. Timer chips usually include time sources as well as the
> ability to generate periodic or single shot
> interrupts. There needs to be some way for clock drivers to cleanly
> interface with these. The API may be the posix subsystem but I do not
> like the quality of the code nor the current API for the clock drivers.

I'm not too familiar with the posix interfaces. I've been focused with
in-kernel uses at the moment. I'll try to take a look at the mmtimer
bits and see if I can better grasp your suggestion.

> The API for user space to clocks already exists through the posix
> standard. I would suggest to work with that standard for a way to deal
> with clocks under Linux.
> 
> > Brief Psudo-code to illustrate the design:
> > ==========================================
> >
> > monotonic_clock()
> > 	now = timesource_read();	/* read the timesource */
> > 	ns = cyc2ns(now - offset_base);	/* calculate nsecs since last hook */
> > 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> 
> These are not really functions right? timesource_read can be a direct
> memory read and the cyc2ns and ntp_scale can be reduced to some scaling
> factor?

Yep, timesource_read() and cyc2ns are static inlines which call the
timesource read function, or just read the MMIO'ed address depending on
the timesource type.


> > Points I'm glossing over for now:
> > ====================================================
> >
> > o ntp_scale(ns):  scales ns by NTP scaling factor
> > 	- see ntp.c for details
> > 	- costly, but correct.
> 
> Please do not call this function from monotonic_clock but provide some
> sort of scaling factor that is adjusted from time to time.

You're going to have to expand on this. I had considered only NTP
scaling the wall time, but for consistency it made more sense to me that
we also apply NTP scaling to the monotonic clock. This avoids different
notions of nanoseconds, one being the inaccurate unajusted system
nanoseconds and the other being the accurately ntp scaled wall time
nanoseconds. Trying to keep things sane.


> > o Some arches (arm, for example) do not have high res timing hardware
> > 	- In this case we can have a "jiffies" timesource
> > 		- cyc2ns(x) =  x*(NSEC_PER_SEC/HZ)
> > 		- doesn't work for tickless systems
> 
> In that case maybe the "ticks" are the timesource and not really tick
> processing per se.

If I understand you, yes. In this case the timer interrupt counter
(jiffies) is used as a free running counter. 

> There could be a separation between "increment counter" and tick processing.

Could you expand on this?

thanks for the review!
-john

