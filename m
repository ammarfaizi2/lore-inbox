Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbULHS2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbULHS2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbULHS2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:28:05 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:43675 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261273AbULHS16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:27:58 -0500
Date: Wed, 8 Dec 2004 10:25:23 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george@mvista.com, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, len.brown@intel.com,
       linux@dominikbrodowski.de, davidm@hpl.hp.com, ak@suse.de,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] New timeofday proposal (v.A1)
In-Reply-To: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, john stultz wrote:

> Features of this design:
> ========================

> o Consolidates a large amount of code:
> 	Allows for shared times source implementations, such as: i386, x86-64
> and ia64 all use HPET, i386 and x86-64 both have ACPI PM timers, and
> i386 and ia64 both have cyclone counters. Time sources are just drivers!

What I would to see also included here is to provide a clean posix
interface to these drivers. IMHO the current char interfaces to clock
drivers should be removed. Look at SGI's mmtimer implementation in
2.6.10-rc3. We have modified the posix interface to allow clock drivers to
export their timer values via CLOCK_SGI_CYCLE and we are also
now able to schedule hardware interrupts via timer_* posix functions
utilizing CLOCK_SGI_CYCLE that are then delivered as signals to an
application. Timer chips usually include time sources as well as the
ability to generate periodic or single shot
interrupts. There needs to be some way for clock drivers to cleanly
interface with these. The API may be the posix subsystem but I do not
like the quality of the code nor the current API for the clock drivers.

The API for user space to clocks already exists through the posix
standard. I would suggest to work with that standard for a way to deal
with clocks under Linux.

> Brief Psudo-code to illustrate the design:
> ==========================================
>
> monotonic_clock()
> 	now = timesource_read();	/* read the timesource */
> 	ns = cyc2ns(now - offset_base);	/* calculate nsecs since last hook */
> 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */

These are not really functions right? timesource_read can be a direct
memory read and the cyc2ns and ntp_scale can be reduced to some scaling
factor?

> Points I'm glossing over for now:
> ====================================================
>
> o ntp_scale(ns):  scales ns by NTP scaling factor
> 	- see ntp.c for details
> 	- costly, but correct.

Please do not call this function from monotonic_clock but provide some
sort of scaling factor that is adjusted from time to time.

> o What is the cost of throwing around 64bit values for everything?
> 	- Do we need an arch specific time structure that varies size
> accordingly?

I think 64 bit values are fine but then I work for a 64 bit company and
this may just be the contextual predisposition.

> o Some arches (arm, for example) do not have high res timing hardware
> 	- In this case we can have a "jiffies" timesource
> 		- cyc2ns(x) =  x*(NSEC_PER_SEC/HZ)
> 		- doesn't work for tickless systems

In that case maybe the "ticks" are the timesource and not really tick
processing per se.
There could be a separation between "increment counter" and tick processing.
