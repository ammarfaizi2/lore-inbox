Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbUA2Oiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 09:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUA2Oiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 09:38:51 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:64387 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S265984AbUA2Oit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 09:38:49 -0500
Date: Thu, 29 Jan 2004 16:38:47 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1: process start times by procps
Message-ID: <20040129143847.GA4544@elektroni.ee.tut.fi>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040123194714.GA22315@elektroni.ee.tut.fi> <20040125110847.GA10824@elektroni.ee.tut.fi> <20040127155254.GA1656@elektroni.ee.tut.fi> <1075342912.1592.72.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075342912.1592.72.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for answering,

On Wed, Jan 28, 2004 at 06:21:52PM -0800, john stultz wrote:
> On Tue, 2004-01-27 at 07:52, Petri Kaukasoina wrote:
> > I made an experiment shown below. I know nothing about kernel programming,
> > so this is probably not correct, but at least btime seemed to stay constant.
> > (I don't believe this fixes procps, though. If HZ if off by 180 ppm then I
> > guess ps can't possibly get its calculations involving HZ right. But at
> > least the bootup time reported by procinfo stays constant.)
> 
> 
> Uh, what does your /etc/ntp/drift file show?

ntp.drift is -22.251 on linux-2.6.1. But on linux-2.4.24 it stabilizes at
about -5.4.

> The basic equation is: 
> btime ~= gettimeodfay() - uptime
>
> Thus if your time of day is adjusted by NTP, btime will change as well.
> Uptime is calculated calculated by jiffies/HZ, and HZ is not NTP
> adjusted, so if your system is running 180ppm too fast or slow, btime
> would be expected to change. 
> 

Yes, on linux-2.2.24 I can see that /proc/uptime is just the jiffies and
btime is current time - jiffies. But in linux-2.6.1 /proc/uptime is now
do_posix_clock_monotonic_gettime(), whatever that means, and /proc/uptime
gives a correct value. But btime is still gettimeofday-jiffies and it does
not stay constant. My patch changed btime to be
gettimeofday-do_posix_clock_monotonic_gettime() and after that it stays
constant.

In other words, on linux-2.2.24, if I print the current time with 'date +%s'
and subtract uptime (/proc/uptime) from that, I do get the same number that
is in the btime field in /proc/stat. But not on linux-2.6.1 without my
patch. (ntp running in both cases.)

> I'm not yet sure how that is related to the ps start time being wrong.

I guess it's not. The relative error was just the same in both. On
linux-2.2.24, ps start time is correct but on linux-2.6.1 it shows times in
future. How much in future, about minute per four days of uptime. But if I
multiply Hertz by e.g. 1.000172 in the ps source, then I get the right
results on linux-2.6.1.

I'll do an experiment and boot to linux-2.6.1 without ntpd next...

Thanks,

-Petri
