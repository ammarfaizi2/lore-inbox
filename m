Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSGKStF>; Thu, 11 Jul 2002 14:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSGKStE>; Thu, 11 Jul 2002 14:49:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54012 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317855AbSGKStD>;
	Thu, 11 Jul 2002 14:49:03 -0400
Message-ID: <3D2DD3A8.74392EC5@mvista.com>
Date: Thu, 11 Jul 2002 11:51:20 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: Lincoln Dale <ltd@cisco.com>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <5.1.0.14.2.20020711102614.0209de60@mira-sjcm-3.cisco.com> <3D2D6D9C.CA7A17FC@daimi.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
> 
> Lincoln Dale wrote:
> >
> > (or a highly-accurate single-fire timer)?
> 
> That would be my preference, at least on hardware where it can
> be done efficient and accurate.
> 
> The x86 PIT can be programmed in one-shot mode, but the delay
> cannot be programmed to be more than approximately 55msec. For
> longer delays we'd have to get interrupted prematurely just
> to reprogram the PIT for another delay. This is of course no
> worse than an interrupt every 1 or 10 msec we actually don't
> need.
> 
> Another problem is that a PIT in one shot mode cannot meassure
> time accurately. Each interrupt will arrive slightly off the
> wanted time. For the interrupt itself this is no big deal, but
> for meassuring time they will accumulate, so you'd see a clock
> drifting beyond anything acceptable.
> 
> The answer here is that we need something else for meassuring
> time, I guess the TSC would be appropriate. If doing all clock
> meassurements using the TSC the clock would no longer drift in
> case of lost timer interrupts. The TSC frequency can be
> meassured at boot time, and if done smart enough that variable
> can be made into a knob that ntpd can control to adjust the
> clock speed instead of a jumping clock once in a while. If we
> are smart enough we can get walltime more accurate than it has
> ever been seen before. :-)

The high-res-timers patch does most of this (all but the ntp
knob).  It allows you to use either the TSC or the ACPI pm
timer to keep clock time.  The former is fast, but some
systems are known to "mess" with the TSC as part of power
management.  The pm timer, being I/O, takes more time to
read, but is not "messed" with.
> 
> The problems remaining know are:
> 1) Reprogramming the PIT is slow and inaccurate, we'd like
>    better hardware for producing timer interrupts. (I think I
>    read somewhere that an APIC could help us here.)

Actually the "best" option would be something like the
decrementer in the PPC.  It can be set to generate an
interrupt at just about any time.  Another HW register
(64-bits) keeps track of (effectively) decrementer clocks
since boot and can be used as the clock source.  The best
solution  in the x86 platform, would be an additional
register that either counts down at TSC speed to an
interrupt OR compares to the TSC and interrupts on compare. 
It should be a cpu register to avoid the latencies of
accessing an I/O register.

> 2) We will be meassuring time in a lot of different units,
>    which needs to be converted. The PIT using 1/1193180 sec,
>    the TSC using a varying unit, and finally the user/kernel
>    interface using secs, msecs, usecs, nsecs.

Not really a big problem.  The conversion constants are
computed once (or at ntp correction) and from then on all
one does is mpy and shift instructions to do the
conversion.  (Again, see the HRT patch.)

> 3) On SMP hardware we will be using different TSCs on
>    different CPUs. Having TSCs in sync might get more imporant
>    than on current kernels.
> 4) We are introducing new hardware requirements.
> 
> I'd like to see oneshot timer interrupts as a compile time
> option on any architecture that is capable of doing it. But of
> course it is not easy.

As I imply above, the one shot, if done as an I/O device, is
less than optimal.  Better is the PPC decrementer.
> 
> Have I missed something somewhere?
> 

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
