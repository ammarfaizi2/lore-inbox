Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTKRTXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 14:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTKRTXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 14:23:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:42386 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263771AbTKRTXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 14:23:16 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: Andrew Morton <akpm@osdl.org>, "Ronny V. Vindenes" <s864@ii.uib.no>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031118185641.GA6001@brodo.de>
References: <1069071092.3238.5.camel@localhost.localdomain>
	 <20031117113650.67968a26.akpm@osdl.org>
	 <1069097751.11437.1941.camel@cog.beaverton.ibm.com>
	 <1069071092.3238.5.camel@localhost.localdomain>
	 <20031117113650.67968a26.akpm@osdl.org>  <20031118185641.GA6001@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1069183103.11432.2108.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Nov 2003 11:18:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-18 at 10:56, Dominik Brodowski wrote:
> On Mon, Nov 17, 2003 at 11:36:50AM -0800, Andrew Morton wrote:
> > 
> > Probably the interactivity problems are due to the CPU scheduler thinking
> > that the CPU runs at 0Hz.
> 
> Is this in "plain" test9 as well? can't find any reference to either
> bogomips or to cpu_khz in any scheduler-related code in
> 2.6.0-test9-bk-as-of-yesterday.

Well, in smp_tune_scheduling() we initialize some scheduler tunables
based on cpu_khz, but in those cases we have safe fallbacks. cpu_khz not
being initialized is a somewhat minor issue. 

The big issue is sched_clock() was written to only support the TSC (and
to fall back to jiffies if cpu_has_tsc was false or we were using a
CONFIG_NUMA compiled kernel).  

The problem is however that it uses functions from the TSC timesource to
convert cycles to nsecs. Those functions do not work unless the TSC is
being used as a timesource. That is why the ACPI PM and PIT were having
problems (likely cyclone as well). 

Thomas' patch to only use the TSC if the TSC timesource is being used
fixes the issue. I'm playing with a patch that may help systems using
other time sources, but needs more testing.


> >  If we can work out why the PM timer patch has
> > broken the CPU clock speed detection then all should be well.
> 
> cpu_khz is done during init_tsc. The code is basically:
> 
> unsigned long eax=0, edx=1000, tsc_quotient;
> tsc_quotient = calibrate_tsc();
> if (tsc_quotient) {
> 	__asm__("divl %2" 
> 	:"=a" (cpu_khz), "=d" (edx)
> 	:"r" (tsc_quotient),
> 	"0" (eax), "1" (edx));
> }
> 
> cpu_khz is only available (so far) if the TSC or HPET time sources are used,
> and not when the PIT time source is used. So the scheduler tweak should have 
> some sort of fall-back mechanism anyway, IMHO.

The Cyclone timesource also initializes cpu_khz, and I sent out a patch
that made it share the initialization code w/ the ACPI PM time source. 

See: 
http://www.ussg.iu.edu/hypermail/linux/kernel/0311.2/0250.html

But you're correct, there are proper fallbacks for the PIT case where
cpu_khz isn't calibrated. 


> As for the bogomips question: I see different bogomips values for 
> 	tsc (~1.200)
> 	pit (~600) 
> and	pmtmr (~8)
> on my 600 MHz PIII Coppermine.

BogoMIPS is just based on loops_per_jiffy, which is calculated in
calibrate_delay(). Its name is deceiving and the output is just
cosmetic. Probably should be changed, but its historical, so I'm
hesitant. 

However, the both the pit and pmtmr should be using a very similar loop
delay function which should result in the same BogoMIPS value. I'll look
into it. 

thanks
-john

