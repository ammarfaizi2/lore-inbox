Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUC0QJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 11:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUC0QJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 11:09:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:2806 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261798AbUC0QJP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 11:09:15 -0500
Message-ID: <4065A726.50506@mvista.com>
Date: Sat, 27 Mar 2004 08:09:10 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Praedor Atrebates <praedor@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: System clock speed too high - 2.6.3 kernel
References: <200403261430.18629.praedor@yahoo.com> <4064A4B7.5030103@mvista.com> <200403261657.22738.praedor@yahoo.com>
In-Reply-To: <200403261657.22738.praedor@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Praedor Atrebates wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Friday 26 March 2004 04:46 pm, George Anzinger held forth thus:
> 
>>Praedor Atrebates wrote:
>>
>>>In doing a web search on system clock speeds being too high, I found
>>>entries describing exactly what I am experiencing in the linux-kernel
>>>list archives, but have not yet found a resolution.
>>>
>>>I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad
>>>1412 laptop, celeron 366, 512MB RAM.  I am finding that my system clock
>>>is ticking away at a rate of about 3:1 vs reality, ie, I count ~3 seconds
>>>on the system clock for every 1 real second.  I am running ntpd but this
>>>is unable to keep up with the rate of system clock passage.
> 
> [...]
> 
>>Try this in the boot command line "clock=pmtmr".  If that fails, then try
>>"clock=pit".
> 
> 
> What is the difference between the two settings?  I used the latter and it 
> worked (didn't try "clock=pmtmr").
> 
There are three clock sources in the x86 kernel, the PIT (programmable interrupt 
timer), the TSC, and the pmtimer (power management timer).

The PIT has been in the hardware since, well, day one.  It almost always works 
and it is clocked by a special Xtal.  The down side is it is accessed with 8-bit 
I/O instructions and so is dog slow to change or look at.

The TSC (time stamp counter) is a newer thing so is not available on all 
hardware although, now, most boxes that don't have TSCs are in land fills :). 
It is accessed via a machine register.  It is usually the cpu clock and so is a 
direct indicator of the cpu speed.  The boot report of cpu speed comes from a 
comparison of the TSC and the PIT, and, in fact this comparison is used to 
calibrate the TSC so it can be used to interpolate between PIT interrupts.  So, 
even here, the PIT is still the tick generator, while the TSC is used to replace 
the reading of the PIT to interpolate between interrupts.  The down side is that 
prior to the pentium 4, the TSC frequency was exactly the processor clock and 
was subject to change to control heat and power usage in the cpu.  I.e. the TSC 
was slowed down to cool the cpu (and to save power).  This makes it an 
unreliable time source for those cpus that do this, in particular lap tops that 
are very much into saving power.

The pmtimer is part of the ACPI hardware.  It is clocked by the same xtal as the 
PIT.  It does not interrupt, so again, the PIT is the interrupt source for time 
ticks.  It has a resolution of three times the PIT (same clock, different 
divider).  It is called the power management timer as it is was designed to 
provide a stable time reference for all power states (except off, of course), so 
is not subject to the slow downs the TSC is.  The down side is that it is 
accessed with an I/O instruction and so is slow.  I have measured a 3 times 
difference in gettimeofday() on an 800MHZ PIII between the TSC and the pmtimer, 
for example.  (And this was with just one read of the pmtimer per 
gettimeofday(), were as the kernel now does three because some hardware gets it 
wrong.)

So, you may ask, if the PIT is the interrupt source, why does the pmtimer being 
off cause my clock to run fast?  It would seem that only the interpolation 
between ticks would be fast, not the whole clock.  The answer to this is the 
"lost tick" detection code.  This code uses the pmtimer or the TSC to check for 
lost ticks and adjusts the clock based on this.

Questions?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

