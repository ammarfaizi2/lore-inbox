Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280165AbRJaLwC>; Wed, 31 Oct 2001 06:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280177AbRJaLvv>; Wed, 31 Oct 2001 06:51:51 -0500
Received: from firebird.planetinternet.be ([195.95.34.5]:19986 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S280165AbRJaLvq>; Wed, 31 Oct 2001 06:51:46 -0500
Date: Wed, 31 Oct 2001 12:52:05 +0100
From: Kurt Roeckx <Q@ping.be>
To: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Ian Maclaine-cross <iml@debian.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011031125204.A1126@ping.be>
In-Reply-To: <20011031113312.A8738@ilm.mech.unsw.edu.au> <20011031020538.A354@ping.be> <20011031135507.A9129@ilm.mech.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031135507.A9129@ilm.mech.unsw.edu.au>; from iml@ilm.mech.unsw.edu.au on Wed, Oct 31, 2001 at 01:55:07PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 01:55:07PM +1100, Ian Maclaine-cross wrote:
> On Wed, Oct 31, 2001 at 02:05:38AM +0100, Kurt Roeckx wrote:
> > On Wed, Oct 31, 2001 at 11:33:12AM +1100, Ian Maclaine-cross wrote:
> > > 
> > > PROBLEM: Linux updates RTC secretly when clock synchronizes.
> > > 
> > > When /usr/sbin/ntpd synchronizes the Linux kernel (or system) clock
> > > using the Network Time Protocol the kernel time is accurate to a few
> > > milliseconds. Linux then sets the Real Time (or Hardware or CMOS)
> > > Clock to this time at approximately 11 minute intervals. Typical RTCs
> > > drift less than 10 s/day so rebooting causes only millisecond errors.
> 
> When the machine reboots from a power interruption Internet connection
> may be unavailable (usual here). Ntpd can start synchronized to an RTC
> but time is inaccurate because hwclock has not adjusted it. When
> Internet connection reestablishes ntpd notices the time conflict and
> terminates.  Human intervention or cron lines can run ntpdate and then
> restart ntpd. This results in time of low quality.

I'm not really sure about this, but I think you need a *high*
offset, like in the order of an hour, before ntpd refused to
adjust.  I know it happely does 5 minutes.

> There are lots of high quality and cost hardware solutions.  The
> solution in my first post was a very small kernel patch to add an
> 11 minute update log so hwclock etc could adjust the time.  Any
> comments on my patch?

Note that hwclock does not adjust the clock if the error is
smaller than 1 second, or it already wrote to the RTC is the past 
23 hours.

It would only help if your box was down for more then a day.  In
that case it probably also drifted for more then a second.

I don't know how to set up ntpd to synch to the RTC clock, but I
doubt it would take the drift it has into account.

Also note that in case the kernel writes the time to the RTC
clock, hwclock can't calculate the drift it has properly because
it is calculated the time it writes to the RTC.

What you probably want to do is disable the kernel writing the
time to the RTC, and let hwclock do write the time to the RTC so
it can calculate the drift properly, and adjust for it during
startup.

Ntpd will also adjust the frequency of the system clock, and you
should get a reasonable accurate time.


Btw: Last time I looked at it (util-linux-2.11h), the calculation
of the driftfactor in hwclock was still pretty inaccurate.  I
once did send patch for it, but it doesn't seem to be included.
There also is an adjtime.patch included you could use.


Kurt

