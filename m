Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUICIRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUICIRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUICIOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:14:23 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:18653 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S269377AbUICIKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:10:12 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: george@mvista.com
Date: Fri, 03 Sep 2004 10:07:50 +0200
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] new timeofday i386 hooks (v.A0)
CC: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Message-ID: <41384277.1310.82E30C@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <4137CC85.4040802@mvista.com>
References: <1094159492.14662.325.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+93187@20040903.080215Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Sep 2004 at 18:44, George Anzinger wrote:

> john stultz wrote:
> > All,
> > 	This patch implements the minimal i386 architecture hooks to enable the
> > new time of day subsystem code. It applies on top of my
> > linux-2.6.9-rc1_timeofday-core_A0 patch and with this patch applied, you
> > can test the new time of day subsystem on i386. Basically it adds the
> > call to timeofday_interrupt_hook() and cuts alot of code out of the
> > build. The only new code is the sync_persistant_clock() function which
> > is mostly ripped out of do_timer_interrupt(). Pretty un-interesting.
> > 
> > I look forward to your comments and feedback.
> > 
> > thanks
> > -john
> > 
> > linux-2.6.9-rc1_timeofday-i386_A0.patch
> > =======================================
> > diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
> > --- a/arch/i386/Kconfig	2004-09-02 13:29:59 -07:00
> > +++ b/arch/i386/Kconfig	2004-09-02 13:29:59 -07:00
> > @@ -14,6 +14,10 @@
> >  	  486, 586, Pentiums, and various instruction-set-compatible chips by
> >  	  AMD, Cyrix, and others.
> >  
> > +config NEWTOD
> > +	bool
> > +	default y
> > +
> >  config MMU
> >  	bool
> >  	default y
> > diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> > --- a/arch/i386/kernel/time.c	2004-09-02 13:29:59 -07:00
> > +++ b/arch/i386/kernel/time.c	2004-09-02 13:29:59 -07:00
> > @@ -67,6 +67,8 @@
> >  
> >  #include "io_ports.h"
> >  
> > +#include <linux/timeofday.h>
> > +
> >  extern spinlock_t i8259A_lock;
> >  int pit_latch_buggy;              /* extern */
> >  
> > @@ -87,6 +89,7 @@
> >  
> >  struct timer_opts *cur_timer = &timer_none;
> >  
> > +#ifndef CONFIG_NEWTOD
> >  /*
> >   * This version of gettimeofday has microsecond resolution
> >   * and better than microsecond precision on fast x86 machines with TSC.
> > @@ -169,6 +172,7 @@
> >  }
> >  
> >  EXPORT_SYMBOL(do_settimeofday);
> > +#endif
> >  
> >  static int set_rtc_mmss(unsigned long nowtime)
> >  {
> > @@ -194,12 +198,39 @@
> >   *		Note: This function is required to return accurate
> >   *		time even in the absence of multiple timer ticks.
> >   */
> > +#ifndef CONFIG_NEWTOD
> >  unsigned long long monotonic_clock(void)
> >  {
> >  	return cur_timer->monotonic_clock();
> >  }
> >  EXPORT_SYMBOL(monotonic_clock);
> > +#endif
> >  
> > +void sync_persistant_clock(struct timespec ts)
> > +{
> > +	/*
> > +	 * If we have an externally synchronized Linux clock, then update
> > +	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
> > +	 * called as close as possible to 500 ms before the new second starts.
> > +	 */
> > +	if (ts.tv_sec > last_rtc_update + 660 &&
> > +	    (ts.tv_nsec / 1000)
> > +			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
> > +	    (ts.tv_nsec / 1000)
> > +			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
> > +		/* horrible...FIXME */
> > +		if (efi_enabled) {
> > +	 		if (efi_set_rtc_mmss(ts.tv_sec) == 0)
> > +				last_rtc_update = ts.tv_sec;
> > +			else
> > +				last_rtc_update = ts.tv_sec - 600;
> > +		} else if (set_rtc_mmss(ts.tv_sec) == 0)
> > +			last_rtc_update = ts.tv_sec;
> > +		else
> > +			last_rtc_update = ts.tv_sec - 600; /* do it again in 60 s */
> > +	}
> > +
> I have wondered, and continue to do so, why this is not a timer driven function. 

I think it depends on how reliable timers are regarding in-time triggering. This 
code has to be executed on-time to make sense. Really.

>   It just seems silly to check this every interrupt when we have low overhead 
> timers for just this sort of thing.
> 
> I wonder about the load calc in the same way...

That's completely different.

...

Regards,
Ulrich


