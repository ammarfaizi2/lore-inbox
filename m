Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWCUUig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWCUUig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWCUUig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:38:36 -0500
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:9874 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750871AbWCUUie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:38:34 -0500
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
In-Reply-To: Your message of "Tue, 21 Mar 2006 17:11:29 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417863@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Tue, 21 Mar 2006 15:37:23 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FLnbX-0001Ge-QW@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478d165aa9320335d714706eb2d7f09e1414c49d3b34b3ef2a4350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following tests all have acpi_evaluate_integer() hacked to return
_TMP=27C.

>> The kernel panic for the don't-load-THM2 kernel is very strange.  I
>> had another kernel panic while doing another set of tests, which I
>> also couldn't explain.  The only difference between the no-THM0 and
>> the no-THM2 kernels is:

> Could you just printk device->pnp? it could be null point (due to you
> hack?)

device->pnp is a struct and I couldn't figure out how to printk it, so
I just printk'ed device->pnp.bus_id (most of its other elements aren't
initialized by then anyway):

diff -r ac486e270597 -r 8b088512dd1d drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c	Sat Mar 18 08:35:34 2006 -0500
+++ b/drivers/acpi/thermal.c	Tue Mar 21 11:32:31 2006 -0500
@@ -1324,6 +1324,7 @@ static int acpi_thermal_add(struct acpi_
 
 	if (!device)
 		return_VALUE(-EINVAL);
+	printk(KERN_INFO PREFIX "pnp.bus_id=0x%x\n", (u32) device->pnp.bus_id);
 
 	tz = kmalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)

It produced nothing surprising:

ACPI: pnp.bus_id=0xe3ed7830
ACPI: pnp.bus_id=0xe3ed7430
ACPI: pnp.bus_id=0xe3ed7030
ACPI: pnp.bus_id=0xe3ed8c30
ACPI: pnp.bus_id=0xe3ed4030

for THM0,2,6,7, and _TZ.

So I still don't know why getting rid of THM2 in the kernel causes the
panic.

But while I had this kernel booted, I tried a few sleep cycles, and it
hung on the second one as expected (it's just the vanilla kernel&DSDT
with acpi_evaluate_integer() hacked to return _TMP=27C).

>> THM6			Hangs (4th cycle)
> Is it still hang at SMPI?

It looked like the usual hang, but I had debug_{layer,level}=0x10.  I
increased debug_layer to 0xFFFFFFFF it to see the function traces.
However, the hang didn't occur even after 15 cycles. So I rebooted with
debug_layer=0x10 and still couldn't reproduce the hang even after 12
cycles.  But the same kernel hung yesterday after 4 cycles [I save all
the kernels tagged by their revision hash], so I don't know what to
think about THM6.

>> THM2			"kernel panic! attempted to kill init"

> I guess, if you fake DSDT by completely removing THM2 you won't see
> this.

Right, it booted fine when I removed THM2 from the DSDT instead of from
the kernel.

>> So THM6 seems healthy, but THM0 and THM7 (and maybe THM2) interact
>> badly.  If I unload THM2, THM6, and THM7, then it's okay (previous
>> experiments with faking _TMP but with only THM0 loaded).  But
>> unloading THM6 is not enough.

> Please try to remove THM2 judge if it is JUST the problem of THM0 &&
> THM7.

I tried the kernel with THM2 taken out of the DSDT, and it was fine (so
the total change was that plus _TMP faked in acpi_evaluate_integer()).

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
