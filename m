Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292408AbSBPQcQ>; Sat, 16 Feb 2002 11:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292405AbSBPQcH>; Sat, 16 Feb 2002 11:32:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12806 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292413AbSBPQcB>; Sat, 16 Feb 2002 11:32:01 -0500
Subject: Re: Missed jiffies
To: tyson@rwii.com (Tyson D Sawyer)
Date: Sat, 16 Feb 2002 16:46:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com> from "Tyson D Sawyer" at Feb 16, 2002 10:16:46 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16c7yN-0006a2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My system looses about 8 seconds every 20 minutes.  This is reported
> by ntp and verified by comparing 'date' to 'hwclock --show' and a wall
> clock.
> 
> My system is a x86 Dell laptop with HZ=1024.
> 
> I am quite certain that the issue is the System Management Interrupt
> (SMI).

Possibly and if it is you can't really do much about it.

> I don't know that there is a solution for all systems, however, at
> least on pentium systems it seems possible to use the TSC to catch

Most vendor systems don't have SMI problems that bad, you can normally hit
the 100Hz or 1Khz tick quite reliably.

> tsc_remainder += last_tsc_low-tsc_low;

The tsc is not a constant on some laptops, and may not be present, or not
be reliable.

> What strategies might be employed to prevent degraded system
> performance since this code is in a criticle path?

Adding a time slew is a well understood problem - the NTP code and papers
cover some very efficient implementation techniques. If you can work out
the drift then drifting back is extremely efficient and the kernel already
implements the needed PLL.

> Have I competely missed something, the kernel already takes care of
> this and I have the problem all wrong?

You have it pretty much right. We have several time sources on a PC -
the rtc (variable rate, not always present), the cmos clock (low res and
on many modern machines horribly inaccurate due to the use of low grade
components), the acpi timers (on newer machines only, high resolution
constant rate, unknown accuracy). 

ACPI may help here but lots of vendors implement their ACPI subsystem using
I/O cycles to jump into SMM mode so its game over again.

> This problem also comes up with IDE access with dma off and I've
> seen reports of it when using frame buffers.

The frame buffer one is fixed for newer kernels. The IDE one is a physical
constraint on some older IDE controllers. See man hdparm.

Alan
