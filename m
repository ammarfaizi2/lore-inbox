Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292802AbSBZUO5>; Tue, 26 Feb 2002 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292779AbSBZUOu>; Tue, 26 Feb 2002 15:14:50 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:62728 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S292802AbSBZUOD>; Tue, 26 Feb 2002 15:14:03 -0500
Date: Tue, 26 Feb 2002 21:14:00 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: george anzinger <george@mvista.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc] enable uptime display > 497 days on 32 bit
In-Reply-To: <3C7BE53E.BB789BC6@mvista.com>
Message-ID: <Pine.LNX.4.33.0202262052550.16224-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, george anzinger wrote:

> Tim Schmielau wrote:
> > 
> > This is a polished version of the patch that came out of the
> > "[Patch] Re: Nasty suprise with uptime" thread last november.
> > 
[...]
> > Before submitting the patch to Marcelo for 2.4.19-pre, I'd like to get
> > some comments, especially on the following points:
> > 
> >   1. Does the patch, in particular the introduction of get_jiffies64(),
> >      interfere with the high-res-timers project
> >      (http://sourceforge.net/projects/high-res-timers) in any bad way?
> 
> Well, since you asked (thank you), the high-res-timers patch needs to
> get the full 64-bit uptime to implement CLOCK_MONOTONIC.  Also, since
> the timers in the kernel are, in fact clocked by CLOCK_MONOTONIC (read
> jiffies) the code has to resolve any wall clock time (i.e.
> CLOCK_REALTIME) into CLOCK_MONOTONIC as part of the timer_settimer()
> call.  This means that the 64-bit jiffies is used "often" in this code. 
> In discussions on the list with Linus, he suggested that the jiffies
> counter be expanded to 64-bits in a particular way, i.e. by #define
> jiffie ... taking into account the endian and 64/32 bitness of the
> particular platform.  I think this is what I implemented in the
> high-res-timers patch.  This implementation allows almost all users to
> continue to work with 32-bit jiffies while providing a 64-bit value for
> those who need it.  Unlike this patch, it keeps the 64-bit rational
> (i.e. always current) by doing a 64-bit add which adds an "adc" (add
> carry to memory) to the timer interrupt path.  This update is already
> SMP protected so no additional locking is required on update.  Reading
> it CAN be done with out locking if it is done with care (read high, low,
> high, if high1 != high2 do it again) or a read lock can be taken.
> 
> The only down side I see to the suggested 64-bit jiffies as implemented
> in the high-res-timers patch is the name space collision issue around
> the #define of jiffies.  I think I have found almost all of these,
> however, it is hard to come up with a .config that compiles ALL paths
> (especially considering the various archs).

Well, my intention was not to push this patch into high-res-timers.

Rather, once this patch may have made it into the kernel, the
high-res-timers patch should back out the simple 64 bit jiffies stuff,
i.e. init_jiffieswrap_timer(), check_jiffieswrap() and get_jiffies64(),
and do all this in its own way, just provide a new get_jiffies64() 
function that does the (read high, low, high; compare) stuff.

If you see problems with the get_jiffies64() interface, or prefer another 
name, please say so.

Since you did not raise any hard objections, I count this as an "you moron 
put some extra work on me, but I can stand it, so it's OK with me" ;-)

Thanks,
Tim

