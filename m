Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTLAWsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264123AbTLAWsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:48:20 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:21700 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264113AbTLAWsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:48:18 -0500
Subject: Re: System clock and speedstepping
From: john stultz <johnstul@us.ibm.com>
To: Raffaele Sandrini <rasa@gmx.ch>
Cc: lkml <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <200311261943.38002.rasa@gmx.ch>
References: <200311261943.38002.rasa@gmx.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1070318452.23568.577.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Dec 2003 14:40:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-28 at 08:09, Raffaele Sandrini wrote:
> I'm running here a dell inspirion 5150 with a P4 with Kernel 2.6.0-t9.
> My problem is: If the laptop is running on bateries and the system is not idle 
> the system clock (i dont think the hardware clock too) runns min twice as 
> fast as it should (if not 4 times as fast as it should).

Hmmm. Can any of the cpufreq folks comment on this? I'm guessing
time_cpufreq_notifier() isn't updating fast_gettimeoffset_quotient
properly. I've never had a laptop that did cpufreq properly, so I've
never been able to test this. 

> I am able to step my CPU via the software interface CPUFREQ of the kernel (via 
> the P4 clockmod driver). After some playing around i recognized that if i set 
> the CPU freq to a very low value (e.g 100 MHZ) i get this msg on the console:
> <msg>
> Losing too many ticks!
> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> Falling back to a sane timesource.
> </msg>
> The funny thing is: After this msg the clock is running correct. I can set my 
> CPU freq to what i want and load my system as much i want with a corect 
> clock.

If the cpufreq code isn't working right, the system will seem to loose a
massive amount of timer ticks, which will be noted and we'll fall back
to using the PIT as a time source.  Although if you're seeing such heavy
skew, I'm surprised we don't trip that code earlier. 

> I don't know what "sane timesource" and "TSC" is. I also dont know where 
> exaclty the problem is. I solved for the moment with an init script which 
> checks if the laptop is running on bats and if so its stepping the system 
> down for a sec and up again to force the above error to come. I know that 
> this is a VERY dirty solution but i see know other way around this for the 
> moment :(.

The "sane timesource" is the PIT (programmable interval timer). The TSC
is the Time-Stamp-Counter which is basically a cycle counter on the cpu.
If you want to boot using the PIT instead of the TSC, you can override
the default time source by using  "clock=pit" as a boot option. However
hopefully the problem can be fixed by adjusting the cpufreq code. As I
don't have any such hardware, would you be interested in testing
possible patches?

thanks
-john


