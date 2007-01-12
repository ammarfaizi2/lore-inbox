Return-Path: <linux-kernel-owner+w=401wt.eu-S1161086AbXALVm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbXALVm0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbXALVm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:42:26 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3669 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161086AbXALVmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:42:25 -0500
Date: Fri, 12 Jan 2007 21:42:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [PATCH] Fix some ARM builds due to HID brokenness
Message-ID: <20070112214216.GC24451@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
	linux-input@atrey.karlin.mff.cuni.cz, Adrian Bunk <bunk@stusta.de>
References: <20070112210015.GA2923@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112210015.GA2923@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 09:00:15PM +0000, Russell King wrote:
> Could we please have this (or a proper fix) in before 2.6.20 to resolve
> the regression please?

Actually, this remaining regression is not caused by this patch not being
integrated, but this:

config USB_HID
        tristate "USB Human Interface Device (full HID) support"
        default y
        depends on USB
        select HID

So... we have USB_HID _newly_ selected in configurations which didn't
have it before, which overrides CONFIG_HID and builds HID without
input support.

Relevant lines from "make ep93xx_defconfig" output:

Generic input layer (needed for keyboard, mouse, ...) (INPUT) [N/m/y/?] n
Support for Host-side USB (USB) [Y/n/m/?] y
USB Human Interface Device (full HID) support (USB_HID) [Y/n/m/?] (NEW) y

Can USB_HID also depend on INPUT ?

> ----- Forwarded message from Russell King <rmk+lkml@arm.linux.org.uk> -----
> 
> Date: Fri, 22 Dec 2006 17:09:16 +0000
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> To: Linux Kernel List <linux-kernel@vger.kernel.org>
> Cc: jkosina@suse.cz, linux-input@atrey.karlin.mff.cuni.cz
> Subject: [PATCH] Fix some ARM builds due to HID brokenness
> 
> The new location for HID is extremely annoying:
> 
> 1. the help text implies that you need to enable it for any
>    keyboard or mouse attached to the system.  This is not
>    correct.
> 
> 2. it defaults to 'y'.  When you have input deselected, this
>    causes the kernel to fail to link:
> 
> drivers/built-in.o: In function `usb_hidinput_input_event':
> hid-input.c:(.text+0x55054): undefined reference to `input_ff_event'
> drivers/built-in.o: In function `hidinput_hid_event':
> hid-input.c:(.text+0x6446c): undefined reference to `input_event'
> hid-input.c:(.text+0x644f8): undefined reference to `input_event'
> hid-input.c:(.text+0x64550): undefined reference to `input_event'
> hid-input.c:(.text+0x64590): undefined reference to `input_event'
> hid-input.c:(.text+0x645b8): undefined reference to `input_event'
> drivers/built-in.o: In function `hidinput_disconnect':
> hid-input.c:(.text+0x64624): undefined reference to `input_unregister_device'
> drivers/built-in.o: In function `hidinput_report_event':
> hid-input.c:(.text+0x64670): undefined reference to `input_event'
> drivers/built-in.o: In function `hidinput_connect':
> hid-input.c:(.text+0x64824): undefined reference to `input_allocate_device'
> hid-input.c:(.text+0x675e0): undefined reference to `input_register_device'
> hid-input.c:(.text+0x67698): undefined reference to `input_free_device'
> hid-input.c:(.text+0x676b8): undefined reference to `input_register_device'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Fix the second problem by making it depend on INPUT.  The first
> problem is left as an exercise for the HID maintainers to solve.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 96d4a0b..1ccc222 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -6,6 +6,7 @@ menu "HID Devices"
>  
>  config HID
>  	tristate "Generic HID support"
> +	depends on INPUT
>  	default y
>  	---help---
>  	  Say Y here if you want generic HID support to connect keyboards,
> 
> ----- End forwarded message -----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
