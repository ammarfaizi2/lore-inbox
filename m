Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752299AbWCRHYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbWCRHYE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 02:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbWCRHYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 02:24:04 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:16589 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752249AbWCRHYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 02:24:01 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Sat, 18 Mar 2006 10:02:45 +0800."
             <3ACA40606221794F80A5670F0AF15F84041AC266@pdsmsx403> 
Date: Sat, 18 Mar 2006 07:23:56 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FKVn2-0007I5-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Which is why I think the minimal change is the diff above to
>> utils.c [to make acpi_evaluate_integer fake _TMP].  With that
>> change the system never hung.

> Good, this is exactly what I wanted.  How many times you tested with
> this hack without hang?

Sadly, I just tried it again and it hung.  But from looking at my old
emails and test results, I know why.  I made the previous tests with
only THM0 loaded.  The bisection began by loading only THM0 (by having
acpi_thermal_add() ignore THM[267]).  The hang still happened, so I
never tested whether THM[267] also have problems: chase one problem at
a time.

To test the theory, I recompiled to recreate the kernel with the
utils.c change [to make acpi_evaluate_integer fake _TMP] and with only
THM0 loaded (i.e. what I had tested and reported a few days ago).  It
didn't hang (10 cycles), which repeats my previous result.

> The short-term proper way could be:
> 1. add a global variable: acpi_in_suspend.
> 2. in acpi_pm_prepare:
>	a.call acpi_os_wait_events_complete()
> 	b.set acpi_in_suspend = YES.
>    in acpi_pm_finish :
> 	set acpi_in_suspend = NO.
> 3. in acpi_thermal_run:
> 	if (acpi_in_suspend == YES)
>		do nothing.

I tested the included diff to implement the above short-term fix.  It
also hung on the second sleep.  BUT, it's the same reason that the
utils.c change didn't help: because acpi_thermal_add() was loading
THM[0267].  After the usual modification to acpi_thermal_add() to have
it ignore THM[267], the system didn't hang (12 cycles).  Which is
progress.

So I conclude that this diff does fix the THM0 problem, but that at
least one other thermal zone has a problem, and the problem is not
_TMP.  Or at least, the problem is not the same one that THM0 has
(running thermal threads at suspend time), otherwise the diff would
fix it like it fixed THM0.

I guess I should try loading only one of THM2,6,7 to see which zones
besides THM0 produce a problem, and then narrow the problem to one
method within the zone.

-Sanjoy
