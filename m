Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbUKQWiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbUKQWiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUKQWff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:35:35 -0500
Received: from 2-227.coreds.net ([207.55.227.2]:58353 "EHLO data.mvista.com")
	by vger.kernel.org with ESMTP id S262579AbUKQWa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:30:58 -0500
Message-ID: <419BD0FF.4020602@mvista.com>
Date: Wed, 17 Nov 2004 14:30:23 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: john stultz <johnstul@us.ibm.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@brodo.de,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: summary (Re: [patch] prefer TSC over PM Timer)
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>  <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org> <1100705495.32698.38.camel@localhost.localdomain> <Pine.LNX.4.61.0411170946410.9434@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.61.0411170946410.9434@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> ok thanks everyone... i've been educated, and attempted to summarize the 
> situation.
> 
> if timer_pm is fixed to read the PM timer only once on non-broken systems 
> then it is generally the best choice.  it is only at a ~3x disadvantage 
> compared to tsc/lapic in that case.
> 
> until/unless C3 and deeper resync tsc then it's best not to default to tsc 
> even on transmeta.  it would require some co-ordination between timer_tsc 
> and ACPI code to know if C3/etc. are enabled, i don't see that 
> co-ordination there now.  so it really does seem like adding "clock=tsc" 
> to boot is best left to installers/users/not-the-kernel for now.
> 
> here's my device summary:
> 
> PIT:
> - many slow i/o accesses to read
> - works everywhere
> 
> PM:
> - minimum one slow i/o access to read
> - measurements on a handful of systems show one PM timer read
>   costs ~3x a TSC read.
> - kernel presently uses 3 reads as a bug workaround, but can be
>   reduced to one read.
> - works on ~all hardware less than a few years old

Both the PIT and PM use the same 14.3181818MHz "rock" which is chosen for time 
keeping.  As such the PIT & PM should be considered the "GOLD" standard for time 
keeping.
> 
> TSC:
> - fast read
> - on most systems this varies with power mgmt -- and some power mgmt
>   occurs "behind-the-scenes" without kernel awareness
> - cpufreq is better and better at tracking the changes (but not on SMP?)
> - 2.6.10-rc2 disables even more behind-the-scenes power mgmt
> - stops counting in C3 (solved? with PIT/PM/RTC read coming out of C3)
> - drift possible across nodes in NUMA

The TSC frequency is unknown.  During boot an attempt is made to calibrate it by 
comparing it with the PIT.  This attempt is flawed by the I/O delays in 
accessing the PIT and so will be off by 5 or more counts per tick (measured on 
an 800 MHZ box, and this was done after changing the calibration time to the max 
PIT count, ~50ms, and attempting to pair the beginning and ending I/O 
instructions so as to, as much as possible, negate the I/O delays).  It is also 
not driven by a time keeping "rock" and may also be varied to lower EMI 
radiation (isn't time keeping interesting).
> 
> local APIC:
> - fast read (approx same as TSC)
> - enabling lapic causes some dell laptops to crash
> - stops counting in C3 (solvable with PIT/PM/RTC read coming out of C3)
> - shared with scheduler -- easy to manage today
> - can't be shared with scheduler if we add variable scheduler ticks
>   (can't read CCR and write ICR atomically -- potential to drift)
> - local apic timer ticks are the best choice for scheduling on SMP
>   because it allows all the CPU schedulers to be skewed and avoid
>   lock conflicts.
Actually doing this is problematic as it skews the timer expire time.  With the 
per cpu timer lists in 2.6 there is very little lock contention.  I think we can 
safely dismiss the lock issue.
> - drift possible across nodes in NUMA?

The APIC timer is again on a different "rock" which is not designed for time 
keeping and, again, is calibrated at boot up against the "GOLD" standard PIT.

IMHO, the best time keeping we can get in and x86 box is to:

a) set up the PIT up to do the 1/HZ ticks (once set up we do not need to touch 
it again so the I/O access issues become mute),

b) select either the TSC (if we think it is stable) or the pm_timer to do the 
short term between tick interpolation and also to detect and correct for PIT 
interrupt overrun (like we missed a tick or two).  We should prefer the TSC here 
because of speed and that it is read every gettimeofday() access.

c) Use the PIT interrupt (followed by an IPI from the PIT interrupt handler for 
SMP systems) to do the scheduler and timer list servicing.  (We really do want 
the timer list to be serviced as close to the jiffies++ as possible.)

d) Use the APIC timer for both finer (as in High Resolution Timers, HRT) and 
courser timing (as in variable scheduler ticks, VST).

The current HRT patch (see signature) does a, b, and c.  I am currently working 
on d.
> 
> HPET:
> - at the moment i know nothing about it (none of my systems have it)

Well, we do know that it is in I/O space and all that that implies...
> 
> let me know if i've missed anything.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

