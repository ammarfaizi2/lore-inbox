Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVHWLag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVHWLag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVHWLag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:30:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34736 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932134AbVHWLag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:30:36 -0400
Date: Tue, 23 Aug 2005 13:30:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124737075.22195.114.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508230134210.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508162337130.3728@scrub.home>
  <1124241449.8630.137.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0508182213100.3728@scrub.home>  <1124505151.22195.78.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508202204240.3728@scrub.home> <1124737075.22195.114.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Aug 2005, john stultz wrote:

> The reason why we calculate the interval_length in the continuous
> timesource case is because we are not assuming anything about the
> frequency that the timekeeping_periodic_hook() is called.

The problem with your patch is that it doesn't allow making such 
assumptions.
Anyway, it's rather simple, if you want to update the time asynchronously:

	cycle_offset = get_cycles() - last_update;

	while (cycle_offset >= update_cycles) {
		cycle_offset -= update_cycles;
		last_update += update_cycles;
		// at init: system_update = update_cycles * mult;
		system_time += system_update;
		xtime += [tick_nsec, time_adj];
	}

	error = system_time - (xtime.tv_nsec << shift);

	if (abs(error) > update_cycles/2) {
		mult_adj = (error +- update_cycles/2) / update_cycles;
		mult += mult_adj;
		system_update += mult_adj * update_cycles;
		system_time -= mult_adj * cycle_offset;
		error -= mult_adj * cycle_offset;
	}

	if (xtime.tv_nsec + (error >> shift) > NSEC_PER_SEC) {
		system_time -= NSEC_PER_SEC << shift;
		second_overflow();
	}

Since we usually don't have to adjust for the error all at once, it should 
be possible to precalculate some of it in adjtimex/second_overflow and 
turn mult_adj into a mult_adj_shift.
I didn't really check the math here in detail, so there should be enough 
errors left :), but I hope it's enough to show the idea (especially how to 
do it without mult/divide).

There are now variations of this possible, the initial cycle_offset can be 
constant, this happens if it's regularly  called from an interrupt (and 
it's sufficient for UP systems). We could also completely ignore the 
error, so that the core calculation of the above results in the familiar:

	xtime += [tick_nsec, time_adj];
	if (xtime.tv_nsec > NSEC_PER_SEC)
		second_overflow();

Another variation would be useful for ppc64 (or maybe any 64bit arch, but 
ppc64 has already the matching gettimeofday). In this case we don't use a 
timespec based xtime and don't scale it to ns, but use 64bit values 
instead scaled to seconds.
The last one may become a bit of a challenge to keep as much as possible 
code common without abusing the preprocessor too much. In any case some 
functions will differ completely anyway, especially gettimeofday will be 
optimized differently depending on the arch/clock requirements, OTOH
introducing a common gettimeofday (that would even require a 64bit 
divide) would be a huge mistake.

bye, Roman
