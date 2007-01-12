Return-Path: <linux-kernel-owner+w=401wt.eu-S1161097AbXALVyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbXALVyA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbXALVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:54:00 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4523 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161097AbXALVyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:54:00 -0500
Date: Fri, 12 Jan 2007 21:53:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [PATCH] Fix some ARM builds due to HID brokenness
Message-ID: <20070112215351.GD24451@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
	linux-input@atrey.karlin.mff.cuni.cz, Adrian Bunk <bunk@stusta.de>
References: <20070112210015.GA2923@dyn-67.arm.linux.org.uk> <20070112214216.GC24451@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112214216.GC24451@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 09:42:16PM +0000, Russell King wrote:
> On Fri, Jan 12, 2007 at 09:00:15PM +0000, Russell King wrote:
> > Could we please have this (or a proper fix) in before 2.6.20 to resolve
> > the regression please?
> 
> Actually, this remaining regression is not caused by this patch not being
> integrated, but this:
> 
> config USB_HID
>         tristate "USB Human Interface Device (full HID) support"
>         default y
>         depends on USB
>         select HID
> 
> So... we have USB_HID _newly_ selected in configurations which didn't
> have it before, which overrides CONFIG_HID and builds HID without
> input support.
> 
> Relevant lines from "make ep93xx_defconfig" output:
> 
> Generic input layer (needed for keyboard, mouse, ...) (INPUT) [N/m/y/?] n
> Support for Host-side USB (USB) [Y/n/m/?] y
> USB Human Interface Device (full HID) support (USB_HID) [Y/n/m/?] (NEW) y
> 
> Can USB_HID also depend on INPUT ?

Nevertheless, here's a patch to solve more of the same that my original
patch attempted to solve.  The original patch is still required.  Seems
to solve the final instance of this problem here.

diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
index 258a5d0..c7d8875 100644
--- a/drivers/usb/input/Kconfig
+++ b/drivers/usb/input/Kconfig
@@ -7,7 +7,7 @@ comment "USB Input Devices"
 config USB_HID
 	tristate "USB Human Interface Device (full HID) support"
 	default y
-	depends on USB
+	depends on USB && INPUT
 	select HID
 	---help---
 	  Say Y here if you want full HID support to connect USB keyboards,


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
