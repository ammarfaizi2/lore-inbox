Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTA1BMm>; Mon, 27 Jan 2003 20:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTA1BMm>; Mon, 27 Jan 2003 20:12:42 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:6539 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264729AbTA1BMm>;
	Mon, 27 Jan 2003 20:12:42 -0500
Date: Tue, 28 Jan 2003 02:21:59 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301280121.CAA13798@harpo.it.uu.se>
To: ak@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
       torvalds@transmeta.com
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 23:25:27 +0100, Pavel Machek wrote:
>This switches apic code to driver model, cleans code up a lot, and
>makes S3 while apic is used work. Please apply,

Please don't apply this. It breaks stuff:

1. apic_suspend() unconditionally calls disable_apic_nmi_watchdog()
   apic_resume() unconditionally calls setup_apic_nmi_watchdog()
   apic_pm_state.perfctr_pmdev removed

   - You're calling local-APIC NMI watchdog procedures even if
     the local-APIC NMI watchdog isn't active. Bad.
   - You're hardcoding that the local-APIC NMI watchdog is the
     only possible sub-client of the local APIC. Not true.
   - perfctr_pmdev exists precisely to handle both these cases
     in a clean way.

2. You unconditionally register apic_driver with its suspend/resume
   methods through a device_initcall().

   This breaks if a UP_APIC or SMP kernel runs on a CPU with no or
   an unusable local APIC. apic_pm_init2() does a runtime check
   for successful init before doing a pm_register().

3. You severed the link between the PM API and the local APIC.

   This breaks APM suspend when the local APIC is enabled. The
   machine will hang (or immediately resume). I tested this, and
   the driver model "stuff" simply doesn't do the right thing yet.

I you just want SOFTWARE_SUSPEND to work, why not simply post the
appropriate PM_SUSPEND and PM_RESUME events?
That should work without any changes to apic.c or nmi.c.

/Mikael
