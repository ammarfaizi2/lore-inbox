Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWFHVXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWFHVXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 17:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWFHVXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 17:23:33 -0400
Received: from tim.rpsys.net ([194.106.48.114]:54967 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965017AbWFHVXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 17:23:33 -0400
Subject: Re: [linux-usb-devel] [PATCH] limit power budget on spitz
From: Richard Purdie <rpurdie@rpsys.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@suse.cz>,
       Russell King <rmk+lkml@arm.linux.org.uk>, lenz@cs.wisc.edu,
       David Liontooth <liontooth@cogweb.net>,
       Oliver Neukum <oliver@neukum.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200606081338.07489.david-b@pacbell.net>
References: <447EB0DC.4040203@cogweb.net>
	 <200606081126.20142.david-b@pacbell.net>
	 <1149797216.16945.234.camel@localhost.localdomain>
	 <200606081338.07489.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 22:22:54 +0100
Message-Id: <1149801774.11412.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 13:38 -0700, David Brownell wrote: 
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3547/1
> 
> OK, I see now.  Simple enough, better than the original.  Go for it.
> 
> There was a PXA issue I was alluding to that's still open, though.
> It's the way there's no selectivity about what platform devices are
> registered ... even kernels running on boards where OHCI isn't hooked
> up to anything will be registering an OHCI controller, as one of many
> examples.  Won't affect this particular case, but in general that'd
> be nice to see fixed.

As I understood the code, if you don't have platform_data set, it will
abort in the probe function so it depends what you mean by register. An
OHCI controller never gets created without platform_data.

You're right that the PXA platform device is always registered. FWIW,
there is no platform in mainline that doesn't have OHCI present so this
isn't a major problem at the moment.

The easiest solution might be to move the ohci device registration into
pxa_set_ohci_info (in pxa27x.c). I gave in and appended a patch (compile
tested only so far).

Cheers,

Richard


Only register the PXA OHCI platform device on platforms which provide
the platform data.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/arch/arm/mach-pxa/pxa27x.c
===================================================================
--- git.orig/arch/arm/mach-pxa/pxa27x.c	2006-06-08 20:50:15.000000000 +0100
+++ git/arch/arm/mach-pxa/pxa27x.c	2006-06-08 22:08:49.000000000 +0100
@@ -200,15 +200,5 @@
 void __init pxa_set_ohci_info(struct pxaohci_platform_data *info)
 {
 	ohci_device.dev.platform_data = info;
+	platform_device_register(&ohci_device);
 }
-
-static struct platform_device *devices[] __initdata = {
-	&ohci_device,
-};
-
-static int __init pxa27x_init(void)
-{
-	return platform_add_devices(devices, ARRAY_SIZE(devices));
-}
-
-subsys_initcall(pxa27x_init);


