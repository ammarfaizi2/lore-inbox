Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbULNXHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbULNXHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbULNXGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:06:11 -0500
Received: from alog0357.analogic.com ([208.224.222.133]:20608 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261718AbULNXEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:04:24 -0500
Date: Tue, 14 Dec 2004 18:00:55 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: Tony Lindgren <tony@atomide.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
In-Reply-To: <20041214220646.GC19218@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0412141751590.20391@chaos.analogic.com>
References: <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
 <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz>
 <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz>
 <1102970039.1281.415.camel@cog.beaverton.ibm.com> <20041213204933.GA4693@elf.ucw.cz>
 <20041214013924.GB14617@atomide.com> <20041214093735.GA1063@elf.ucw.cz>
 <20041214211814.GA31226@atomide.com> <20041214220646.GC19218@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Pavel Machek wrote:

> Hi!
>
>>>> The patch in question is at:
>>>>
>>>> http://linux-omap.bkbits.net:8080/main/user=tmlind/patch@1.2016.4.18?nav=!-|index.html|stats|!+|index.html|ChangeSet@-12w|cset@1.2016.4.18
>>>
>>> Wow, that's basically 8 lines of code plus driver for new
>>> hardware... Is it really that simple?
>>
>> Yeah, the key things are reprogramming the timer in the idle loop
>> based on next_timer_interrupt(), and calling timer_interrupt from
>> other interrupts as well :)
>>
>> Should we try a similar patch for x86/amd64? I'm not sure which timers
>> to use though? One should be programmable length for the interrupt,
>> and the other continuous for the timekeeping.
>
> Yes, it would certainly be interesting. 5% power savings, and no
> singing capacitors, while keeping HZ=1000. Sounds good to me.
>
> There are about 1000 timers available in PC, each having its own
> quirks. CMOS clock should be able to generate 1024Hz periodic timer
> (we currently do not use) and TSC we currently use for periodic timer
> should be usable in single-shot mode.
> 								Pavel
> --

If you use that RTC timer, it needs to be something that can be
turned OFF. Many embedded applications use that because its the
only timer that the OS doesn't muck with. It also has very low
noise which makes in a good timing source for IIR filters for
high precision, low data-rate data acquisition (like 24 bits).

Since it generates an edge, its interrupt can't be shared.
I certainly hope that you don't use it. One can read the
time without disturbing the interrupt rate. One just
needs to use the existing rtc_lock and not spin with
the lock being held.

Currently the kernel RTC software allocates the RTC interrupt
even though it doesn't use it. This makes it necessary to
compile the RTC as a module and then remove it when another
driver needs to use the RTC interrupt source.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
