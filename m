Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274872AbRJFDgT>; Fri, 5 Oct 2001 23:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274908AbRJFDgK>; Fri, 5 Oct 2001 23:36:10 -0400
Received: from sushi.toad.net ([162.33.130.105]:48360 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274872AbRJFDfw>;
	Fri, 5 Oct 2001 23:35:52 -0400
Subject: Linux should not set the "PnP OS" boot flag
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-thinkpad@www.bm-soft.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 05 Oct 2001 23:35:53 -0400
Message-Id: <1002339356.814.45.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My problem was: After running a recent 2.4.x kernel, on a subsequent
boot of Linux, all configurable devices (internal modem, audio chip,
parallel, serial and IR ports) were disabled.  This would causes
oopses in my sound device drivers.

My workarounds were:
(1) to reinitialize the BIOS prior to booting, or,
(2) to run "setpnp on" on all the configurable devices early in
    the boot sequence.

I just now figured out what was going on.  When the PnP BIOS is
going to boot a non-PnP OS, it configures all configurable devices
itself.  When the PnP BIOS is going to boot a PnP OS (which it
tells from a "boot flag") it leaves configurable devices, other
than those needed to boot the OS, unconfigured.  Recent Linux
kernels have set the "boot flag" indicating that the OS being booted
is a PnP OS.

Unfortunately, Linux isn't really a "PnP OS".  The kernel alone
doesn't configure the devices.  One has to use setpnp to do that.

On the ThinkPad there is an additional solution:
(3) Disable QuickBoot in EasySetup Config (the BIOS setup program)

The PnP BIOS mode in which it refrains from configuring the
configurable devices (because it thinks it's booting a PnP OS)
is called "QuickBoot" on the ThinkPad.  Recent Linux kernels switch
on QuickBoot.  However if QuickBoot is disabled in EasySetup then
the boot flag is ignored and the PnP BIOS goes ahead and configures
the devices itself.  One can still use setpnp to reconfigure the
devices, so this doesn't create a problem.

The best solution, though, is
(4) to modify Linux so that it doesn't set the QuickBoot boot flag.
The problem isn't just that Linux isn't a PnP OS.  It's that Linux
can't possibly know in a multi-boot setup WHICH OS is going to be
booted _next_.  So it just shouldn't futz with that boot flag.
Instead, control over the flag should be given to the user via
a /proc entry or something like that.  I append a short patch
to remove the bit of code that sets the boot flag.  (I see where
the function also zeroes out the sbf value if it appears not to be
a valid value.  That seems rather rash to me, but I leave it
alone because I don't understand why it's there.)

Thanks to ebiederm@xmission.com for pointing me to the bootflag
code, of whose existence I was until recently unaware.

--
Thomas Hood

The patch:
--- linux-2.4.10-ac5/arch/i386/kernel/bootflag.c	Fri Oct  5 14:57:10 2001
+++ linux-2.4.10-ac5-fix/arch/i386/kernel/bootflag.c	Fri Oct  5 23:20:43 2001
@@ -119,7 +119,7 @@
 	u8 v = sbf_read();
 	if(!sbf_value_valid(v))
 		v = 0;
-#if defined(CONFIG_PNPBIOS)
+#if 0            // WAS: #if defined(CONFIG_PNPBIOS)
 	/* Tell the BIOS to fast init as we are a PnP OS */
 	v |= (1<<0);	/* Set PNPOS flag */
 #endif


