Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUIOQvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUIOQvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266708AbUIOQsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:48:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27031 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266821AbUIOQrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:47:07 -0400
Date: Wed, 15 Sep 2004 09:46:06 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1095265942.29408.2847.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409150940420.1249@schroedinger.engr.sgi.com>
References: <1095265942.29408.2847.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, john stultz wrote:

> > struct time_source_t {
> > 	u8 type;
> > 	u8 shift;
> > 	u32 multiply;
> > 	void *address;
> > 	u64 mask;
> > 	int (*interrupt_at)(u64 counter_value);
> > };
>
> Could you explain the interrupt_at function further?

Generates a timer interrupt when a certain counter value has been reached.
This is a common feature of most clock chips that I am aware of.

> > 	make_time_source(1200000000, TIME_SOURCE_FUNCTION, cpu_time_filtered, 44, itm_setup);
>
> Out of curiosity, what happens in your fsyscall code in these cases
> where TIME_SOURCE_FUNCTION is used?

It backs out of the fast call track and does a regular call instead.

> > /* simulation of the old tick behavior */
> > tick(u64 when) {
> > 	/* do tick stuff */
> >
> > 	/* time base update .... */
> > 	time_source_adjust(0);
> > 	/* Schedule next timer tick */
> > 	event_new(when + NSEC_PER_SEC / HZ , tick,  when + NSEC_PER_SEC / HZ);
> > }
>
> Hmm. This is getting somewhat tangled in my mind. Who is calling tick()
> originally? How is event_run being called?

This is just some toying around with the concept. Maybe tick could be
called by the regular timer interrupt?

>
> > /* New tick would be scheduled by the ntp logic when a correction is needed.
> >  * ntp logic needs to decide when to skip a few nanosecond or slow down the clock or
> >  * make the clock run faster.
> >  * One way to do this is to accumulate a time difference to real time.
> >  * if this time difference is small and positive then skip time forward a bit.
> >  * if the time difference is negative then slow down the clock.
> >  * if the time difference is way too high then accelerate the clock
> >  */
>
> Well, this is still a bit vague.  do_adjtimex gives us 4 values we need
> to use in adjusting time. The parts-per-million (ppm - all of which are
> signed) tick adjustment value, the ppm frequency adjustment, the ppm
> offset adjustment, and the singleshot offset adjustment length (# of
> nsecs in which we apply the maximum ppm singleshot offset adjustment).
>
> How do these 4 values get translated to adjusting the time source?

I agree this is vague and I have no clue here. I hoped that you
could come up with some may to use these functions for adjtimex etc? I
would need some time to figure out how the adjusting works in order to
come up with a solution. I thought we agreed you do the NTP and time
adjustment things ;-) I have never touched that code....

> You might want to just swipe my timeofday-core patch and re-work the
> timesource.h interface to your liking (make it like time_source_t). That
> way you get all the NTP details as well as the interrupt separation for
> free.

Will have a look at it and put it together when I have some time.
