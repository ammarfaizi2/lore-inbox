Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310634AbSCHBdD>; Thu, 7 Mar 2002 20:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310636AbSCHBcx>; Thu, 7 Mar 2002 20:32:53 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:23450 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S310634AbSCHBcr>; Thu, 7 Mar 2002 20:32:47 -0500
Date: Fri, 8 Mar 2002 01:32:23 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: a faster way to gettimeofday? rdtsc strangeness
Message-ID: <20020308013222.B14779@kushida.apsleyroad.org>
In-Reply-To: <E16iz57-0002SW-00@the-village.bc.nu> <1015515815.4373.61.camel@pc-16.office.scali.no> <a68bo4$b18$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a68bo4$b18$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Mar 07, 2002 at 10:32:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> > Can /proc/cpuinfo really be trusted in figuring out how long a cycle is?
> 
> It uses RDTSC, so yes.

Yes and no.  The kernel's measurement isn't as accurate as it could be.

I have some code which calibrates TSC cycles against gettimeofday().

Considering that gettimeofday() works by using the kernel's frequency
estimate that it shows in /proc/cpuinfo, the results from the code
should match /proc/cpuinfo very precisely ndeed.

However, over a million gettimeofday() calls, the frequency of the 100Hz
tick would tend to dominate the result, showing any error in the
kernel's estimate which appears in /proc/cpuinfo (which is derived from
measuring the length of a 100Hz tick in TSC cycles).

With 10^6 gettimeofday() calls, and linear regression through the set of
measurements when an interrupt didn't happen (checked by reading TSC
before and after the system call and filtering on the minimum), I get
superb results on a FreeBSD box:

	Kernel reports clock frequency:  746.154 MHz
	Measured clock frequency:        746.154 MHz

On various Linux boxes, however:

	Kernel reports clock frequency:  596.924 MHz
	Measured clock frequency:        596.929 MHz

	Kernel reports clock frequency:  866.708 MHz
	Measured clock frequency:        866.675 MHz

	Kernel reports clock frequency:  664.597 MHz
	Measured clock frequency:        664.582 MHz

	Kernel reports clock frequency:  366.601 MHz
	Measured clock frequency:        366.584 MHz

As you can see, the kernel consistently overestimates the CPU clock
frequency, or more precisely it overestimates the number of cycles in a
"100Hz" system clock tick.  This is something that could be improved in
the kernel code, as FreeBSD demonstrates.  Note that the clock frequency
probably varies by a similar order of magnitude to this error due to
thermal and power variation anyway.  But it would be nice if the
measurements matched as they do in FreeBSD!

I have one of those laptops that Alan mentioned which does change the
CPU clock rate.  It's a Toshiba 4070CDT, here running in fast then slow
mode:

	Kernel reports clock frequency:  366.601 MHz
	Measured clock frequency:        366.584 MHz

	Kernel reports clock frequency:  366.601 MHz
	Measured clock frequency:        184.503 MHz

It can switch between fast and slow modes while a program is running,
which occurs either when you press a special key combination, or the
mains power cuts off.

enjoy,
-- Jamie
