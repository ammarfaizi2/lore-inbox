Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTKRS7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 13:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbTKRS7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 13:59:18 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:12738 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263762AbTKRS7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 13:59:16 -0500
Date: Tue, 18 Nov 2003 19:56:41 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>
Cc: "Ronny V. Vindenes" <s864@ii.uib.no>, linux-kernel@vger.kernel.org
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Message-ID: <20031118185641.GA6001@brodo.de>
References: <1069071092.3238.5.camel@localhost.localdomain> <20031117113650.67968a26.akpm@osdl.org> <1069097751.11437.1941.camel@cog.beaverton.ibm.com> <1069071092.3238.5.camel@localhost.localdomain> <20031117113650.67968a26.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069097751.11437.1941.camel@cog.beaverton.ibm.com> <20031117113650.67968a26.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 11:36:50AM -0800, Andrew Morton wrote:
> "Ronny V. Vindenes" <s864@ii.uib.no> wrote:
> >
> > > Your report has totally confused me.  Are you saying that the
> > jerkiness is
> > > caused by linus.patch?  Or not?  Pleas try again ;)
> > > 
> > 
> > I've found that neither linus.patch nor
> > context-switch-accounting-fix.patch is causing the problem, but rather
> > acpi-pm-timer-fixes.patch & acpi-pm-timer.patch
> > 
> > With these applied my cpu (athlon64) is detected as 0.0Mhz, bogomips
> > drops to 50% and anything cpu intensive destroys interactivity. Revert
> > them and performance is back at -mm2 level.
> 
> ah hah.  Thank you!
> 
> Probably the interactivity problems are due to the CPU scheduler thinking
> that the CPU runs at 0Hz.

Is this in "plain" test9 as well? can't find any reference to either
bogomips or to cpu_khz in any scheduler-related code in
2.6.0-test9-bk-as-of-yesterday.

>  If we can work out why the PM timer patch has
> broken the CPU clock speed detection then all should be well.

cpu_khz is done during init_tsc. The code is basically:

unsigned long eax=0, edx=1000, tsc_quotient;
tsc_quotient = calibrate_tsc();
if (tsc_quotient) {
	__asm__("divl %2" 
	:"=a" (cpu_khz), "=d" (edx)
	:"r" (tsc_quotient),
	"0" (eax), "1" (edx));
}

cpu_khz is only available (so far) if the TSC or HPET time sources are used,
and not when the PIT time source is used. So the scheduler tweak should have 
some sort of fall-back mechanism anyway, IMHO.

As for the bogomips question: I see different bogomips values for 
	tsc (~1.200)
	pit (~600) 
and	pmtmr (~8)
on my 600 MHz PIII Coppermine.

	Dominik
