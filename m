Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWCUIsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWCUIsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 03:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWCUIsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 03:48:31 -0500
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:6086 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1750910AbWCUIsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 03:48:30 -0500
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
In-Reply-To: Your message of "Tue, 21 Mar 2006 09:38:42 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417262@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Tue, 21 Mar 2006 03:47:45 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FLcWn-0001DM-Af@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478d165aa9320335d71c0cec0ff8fad3700f77ca0dbd638c082350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With _TMP faked in the kernel and one whole zone ignored, this is what I
get:

Zone to ignore	|	Result
------------------------------------------------------------------------
THM0			OK (10 cycles)
THM2			"kernel panic! attempted to kill init"
THM6			Hangs (4th cycle)
THM7			OK (8 cycles)

So THM6 seems healthy, but THM0 and THM7 (and maybe THM2) interact
badly.  If I unload THM2, THM6, and THM7, then it's okay (previous
experiments with faking _TMP but with only THM0 loaded).  But unloading
THM6 is not enough.

The kernel panic for the don't-load-THM2 kernel is very strange.  I had
another kernel panic while doing another set of tests, which I also
couldn't explain.  The only difference between the no-THM0 and the
no-THM2 kernels is:

diff -r b7ad6c906aba -r 213308f0ec31 drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c	Tue Mar 21 02:23:30 2006 -0500
+++ b/drivers/acpi/thermal.c	Tue Mar 21 02:36:42 2006 -0500
@@ -1324,7 +1324,7 @@ static int acpi_thermal_add(struct acpi_
 
 	if (!device)
 		return_VALUE(-EINVAL);
-	if (strcmp("THM2", device->pnp.bus_id) == 0) {
+	if (strcmp("THM0", device->pnp.bus_id) == 0) {
 	    printk(KERN_INFO PREFIX "thermal_add: ignoring %s\n",
 		   device->pnp.bus_id);
 	    return_VALUE(-EINVAL);


-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
