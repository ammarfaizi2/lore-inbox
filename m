Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWCUQjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWCUQjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWCUQjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:39:03 -0500
Received: from waste.org ([64.81.244.121]:25779 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751759AbWCUQi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:38:59 -0500
Date: Tue, 21 Mar 2006 10:38:52 -0600
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14] RTC: Remove RTC UIP synchronization on x86
Message-ID: <20060321163852.GM31656@waste.org>
References: <2.132654658@selenic.com> <20060319181335.GA2389@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319181335.GA2389@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 06:13:36PM +0000, Pavel Machek wrote:
> Hi!
> 
> > Remove RTC UIP synchronization on x86
> > 
> > Reading the CMOS clock on x86 and some other arches currently takes up
> > to one second because it synchronizes with the CMOS second tick-over.
> > This delay shows up at boot time as well a resume time.
> > 
> > This is the currently the most substantial boot time delay for
> > machines that are working towards instant-on capability. Also, a quick
> > back of the envelope calculation (.5sec * 2M users * 1 boot a day * 10 years)
> > suggests it has cost Linux users in the neighborhood of a million
> > man-hours.
> 
> Heh, nice manipulation attempt. Note you are also introduced timing
> error of about 114 years total.

I'm sure you'll find the average RTC is off by significantly more than
a second anyway. _Or_ is regularly synced over network.
 
> > In my view, there are basically four cases to consider:
> > 
> > 1) networked, need precise walltime: use NTP
> > 2) networked, don't need precise walltime: use NTP anyway
> > 3) not networked, don't need sub-second precision walltime: don't care
> > 4) not networked, need sub-second precision walltime:
> >    get a network or a radio time source because RTC isn't good enough anyway
> 
> Eh, very nice, so I should get radio time source for my notebook?

Depends. Do you need sub-second precision on your wall time? If you're
currently depending on your RTC (not to mention the rest of the kernel
timekeeping system) to give you time of day that matches actual time
to fractions of a second without regular synchronization, you're
kidding yourself. 

All my machines seem to grow out of sync by about a minute per week if
ntpd stops running. That's almost a half second per hour.
 
> > So this patch series simply removes the synchronization in favor of a
> > simple seqlock-like approach using the seconds value.
> 
> What about polling RTC from timer interrupt or something like that, so
> that you get error in range of 5 msec instead of 500 msec? You can do
> the calibration in parallel, then...

I considered that and decided it wasn't worth the effort. People who
care (which ought to be the empty set) can run /sbin/hwclock.

-- 
Mathematics is the supreme nostalgia of our time.
