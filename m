Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbTA1JQx>; Tue, 28 Jan 2003 04:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbTA1JQx>; Tue, 28 Jan 2003 04:16:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31244 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263326AbTA1JQv>; Tue, 28 Jan 2003 04:16:51 -0500
Date: Tue, 28 Jan 2003 10:26:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
       torvalds@transmeta.com
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030128092609.GA8191@atrey.karlin.mff.cuni.cz>
References: <200301280121.CAA13798@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301280121.CAA13798@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >This switches apic code to driver model, cleans code up a lot, and
> >makes S3 while apic is used work. Please apply,
> 
> Please don't apply this. It breaks stuff:
> 
> 1. apic_suspend() unconditionally calls disable_apic_nmi_watchdog()
>    apic_resume() unconditionally calls setup_apic_nmi_watchdog()
>    apic_pm_state.perfctr_pmdev removed
> 
>    - You're calling local-APIC NMI watchdog procedures even if
>      the local-APIC NMI watchdog isn't active. Bad.

Fixed.

>    - You're hardcoding that the local-APIC NMI watchdog is the
>      only possible sub-client of the local APIC. Not true.
>    - perfctr_pmdev exists precisely to handle both these cases
>      in a clean way.

While being as ugly as night, which is even noted in sources:

-       /* 'perfctr_pmdev' is here because the current (2.4.1) PM
-          callback system doesn't handle hierarchical dependencies */

Nothing prevents more clients from registering as subtrees to APIC. I
did not do that for NMI watchdog because it is hardcoded in Makefile,
anyway.

> 2. You unconditionally register apic_driver with its suspend/resume
>    methods through a device_initcall().
> 
>    This breaks if a UP_APIC or SMP kernel runs on a CPU with no or
>    an unusable local APIC. apic_pm_init2() does a runtime check
>    for successful init before doing a pm_register().

Fixed.

> 3. You severed the link between the PM API and the local APIC.
> 
>    This breaks APM suspend when the local APIC is enabled. The
>    machine will hang (or immediately resume). I tested this, and
>    the driver model "stuff" simply doesn't do the right thing yet.

I'll fix APM to call device model methods.

> I you just want SOFTWARE_SUSPEND to work, why not simply post the
> appropriate PM_SUSPEND and PM_RESUME events?
> That should work without any changes to apic.c or nmi.c.

Because PM_SUSPEND/PM_RESUME is ugly and can not be made to work
(devices are hierarchical, and PM_SUSPEND/PM_RESUME system does not
honour that).
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
