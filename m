Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTHVTzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTHVTzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:55:53 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:3778 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263444AbTHVTzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:55:37 -0400
Date: Fri, 22 Aug 2003 21:55:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, aj@suse.de, richard.brunner@amd.com,
       mark.langsdorf@amd.com, pavel@suse.cz
Subject: Re: Cpufreq for opteron
Message-ID: <20030822195515.GB2327@elf.ucw.cz>
References: <20030822135946.GA2194@elf.ucw.cz> <20030822144340.GE3111@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822144340.GE3111@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > + *
>  > + *  Based on the powernow-k7.c module written by Dave Jones.
>  > + *  (C) 2003 Dave Jones <davej@suse.de>
> 
> Please change this to
> "(C) 2003 Dave Jones <davej@codemonkey.org.uk> on behalf of SuSE Labs."
> Whilst that email address is dead, it was SuSE who sponsered me to do
> that work, so they should retain some credit.

Ok.

>  > +#include <linux/cpufreq.h>
>  > +#include <linux/slab.h>
>  > +#include <linux/string.h>
>  > +#include <linux/cpufreq.h>
> 
> cpufreq.h included twice.

Ok.

>  > +#undef DEBUG
>  > +#undef TRACE
>  > +
>  > +#define PFX "amd64-cpuf: "
> 
> Precedent on other cpufreq modules has been to use module name as PFX.
> (Ie, "powernow-k8:")

Ok.

>  > +#define VERSION "version 1.00.06 - August 13, 2003"
> 
> minor nit: pre-driver VERSION strings go stale quickly once merged to the
> kernel and people start adding small changes bypassing maintainer..

AMD wants it, so I'm leaving it in for now. When it goes out-of-date
it can be killed easily.

>  > +#ifdef CONFIG_SMP
>  > +#error cpufreq support is disabled for config_smp
>  > +#endif
> 
> Why ? The core itself should be safe now, if you know of problems,
> I'd like to know about them.  It's also extraneous given that you
> do a runtime test for >1 CPU in check_supported_cpu() and abort in
> that case.

I'll kill compile-time test and leave runtime test in for now.

>  > +#ifdef CONFIG_PREEMPT
>  > +#warning noone tested this on preempt system, beware
>  > +#endif
> 
> This is likely to be lots of 'fun'. The multiple stage state machine
> that the opteron powernow uses could be preempted at any stage.
> Might not be that big a deal for UP (except for any timing specific
> routines, that need explicit disable/enable around them). But for SMP,
> where you could wind up on a different CPU when you return to kernel
> space, 'bad shit' will happen. Good luck!

:-).

>  > +#ifdef LOG_CHANGES
...
>  > +static void __exit drv_exit(void);
> 
> Dump this lot in powernow-k8.h please, or better yet, remove them
> where possible.

I was able to kill most of these.

>  > +static int onbattery = 1;	/* Set if running on battery, reset otherwise. */
>  > +			   /* Of no relevance unless batterypstates <     */
>  > +			   /* numpstates, as defined in the PSB/PST.      */
> 
> Where is this set ? My guess is you're going to need ACPI hooks
> to do this, in which case it shouldn't be static.

This code is not used *for now*.

>  > +#define SEARCH_UP     1
>  > +#define SEARCH_DOWN   0
>  > +
>  > +#ifdef LOG_CHANGES
>  > +static char *pVIDs[] = {
>  > +	"1.550V", "1.525V", "1.500V",
>  > +	"1.475V", "1.450V", "1.425V", "1.400V",
>  > +	"1.375V", "1.350V", "1.325V", "1.300V",
>  > +	"1.275V", "1.250V", "1.225V", "1.200V",
>  > +	"1.175V", "1.150V", "1.125V", "1.100V",
>  > +	"1.075V", "1.050V", "1.025V", "1.000V",
>  > +	"0.975V", "0.950V", "0.925V", "0.900V",
>  > +	"0.875V", "0.850V", "0.825V", "0.800V",
>  > +	"off",	"error - impossible vid"
>  > +};
> 
> Passing these around as strings seems odd. See what powernow-k7 did.
> You have to do all the extra division & multiplying, but it's less
> icky IMO.

I'd prefer not to touch the driver too much at this point; I can only
compile-test it.

>  > +#ifdef DEBUG
>  > ... deletia 
>  > +#endif
> 
> There's a *lot* of this in this driver. Does it really need that much
> debugging info ? Additionally, the combination of dprintk, tprintk,
> printk (KERN_DEBUG  is really messy, and kind of defeats the point
> of having these macros. If they're not going to be consistent, don't
> use them at all.

Yep, I do not like those ?printk's too. Anyway, I killed most #ifdef
DEBUG, and converted it to BUG_ON(). That makes driver shorter and
easier to read. Hopefully not much new hardware will be buggy.

>  > +/* Field definitions within the FID VID High Status MSR : */
>  > +#define MSR_S_HI_MAX_WORKING_VID  0x001f0000
>  > +#define MSR_S_HI_START_VID        0x00001f00
>  > +#define MSR_S_HI_CURRENT_VID      0x0000001f
> 
> Are you intending to use the i386 driver on x86-64 using the symlink
> trick Andi did for some other parts of arch/i386/kernel/ ?

Yes.

>  > +#ifdef LOG_CHANGES
>  > +#define lprintk(msg...) printk(msg)
>  > +#else
>  > +#define lprintk(msg...) do { } while(0)
>  > +#endif
>  > +
>  > +#ifdef DEBUG
>  > +#define dprintk(msg...) printk(msg)
>  > +#else
>  > +#define dprintk(msg...) do { } while(0)
>  > +#endif
>  > +
>  > +#ifdef TRACE
>  > +#define tprintk(msg...) printk(msg)
>  > +#else
>  > +#define tprintk(msg...) do { } while(0)
>  > +#endif
> 
> See above, this lot seems to be adding more clutter than anything.
> The fact most of users are already inside ifdef blocks themselves
> doesn't help.

I converted lprintk and tprintk to dprintk. That should make it more
sane.

>  > +/* Attempt to force the BIOS to enable power management in the chipset if 
>  > + * it has not already done so. At least 1 BIOS is delaying the enablement 
>  > + * until ACPI init, which never happens without an ACPI enabled Linux 
>  > + * kernel. This can be regarded as a BIOS bug, but that is of little help 
>  > + * when you are facing the situation. Do not enable this code unless you 
>  > + * are sure as to what you are doing.                            */
>  > +#ifdef CHIPSET_HACK
....
>  > +#else
>  > +#define chipset_force_pm() do { } while(0)
>  > +#endif
> 
> This is gross. Get the DMI strings of the offending BIOS and add a quirk
> that cpufreq can fix up when it starts. No more ifdefs, and it'll also
> do the right thing on boxes with and without the bug.

Killed.

									Pavel
PS: Patch is being generated, expect it within 5 minutes.
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
