Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWJUJsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWJUJsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 05:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWJUJsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 05:48:16 -0400
Received: from www.osadl.org ([213.239.205.134]:49085 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030386AbWJUJsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 05:48:15 -0400
Subject: Re: various laptop nagles - any suggestions?   (note:
	2.6.19-rc2-mm1 but applies to multiple kernels)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, teunis <teunis@wintersgift.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <20061020182527.a07666a4.akpm@osdl.org>
References: <4537A25D.6070205@wintersgift.com>
	 <20061019194157.1ed094b9.akpm@osdl.org> <4538F9AD.8000806@wintersgift.com>
	 <20061020110746.0db17489.akpm@osdl.org>
	 <1161368034.5274.278.camel@localhost.localdomain>
	 <20061020112627.04a4035a.akpm@osdl.org>
	 <1161370015.5274.282.camel@localhost.localdomain>
	 <20061020121537.dea13469.akpm@osdl.org> <20061020203731.GA22407@elte.hu>
	 <20061020135450.6794a2bb.akpm@osdl.org> <20061020205651.GA26801@elte.hu>
	 <20061020182527.a07666a4.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 11:49:07 +0200
Message-Id: <1161424147.5274.400.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 18:25 -0700, Andrew Morton wrote:
> On Fri, 20 Oct 2006 22:56:51 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > Oh.  I thought the problem was that the timer stops when the CPU is 
> > > idle. Maybe I misremembered.  I'll try `idle=poll'.
> > 
> > hm, wouldnt in that case the box not boot at all? But yeah, idle=poll 
> > would be nice.
> 
> idle=poll fixes it.  The fan gets a bit noisy though ;)

So this is one of the boxen where C2 is actually C3 and lapic stops in
C3 mode. Probably BIOS magic.

What's the output of /proc/acpi/processor/CPU0/power ?

> Perhaps a suitable test would be to set up a PIT interrupt, do a hlt, see
> if the APIC timer counter has increased appropriately.

Yeah, but it has to be done later in the boot process. Looking into this
right now.

> I got this:
> 
> [   43.709238] TSC appears to be running slowly. Marking it as unstable
> 
> How come?  It also happens with HIGH_RES_TIMERS=n and NO_HZ=n.  It only
> seems to happen when idle=poll is given.

Should happen always as the TSC is driven by the CPU clock and you have
CPUFREQ enabled.

> > could you also boot with apic=verbose and send us the full bootlog?
>
> http://userweb.kernel.org/~akpm/apic.txt

[   11.515305] calibrating APIC timer ...
[   11.618612] ..... tt1-tt2 831283
[   11.618614] ..... mult: 35701101
[   11.618616] ..... calibration result: 532021
[   11.618619] ..... CPU clock speed is 1995.0325 MHz.
[   11.618622] ..... host bus clock speed is 133.0021 MHz.

That looks reasonable. It really boils down to the lapic not working
when going idle.

	tglx


