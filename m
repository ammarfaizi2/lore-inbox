Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTHXMIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTHXMIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:08:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60690 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263529AbTHXMIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:08:10 -0400
Date: Sun, 24 Aug 2003 13:08:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       torvalds@osdl.org
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030824130807.C16635@flint.arm.linux.org.uk>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	torvalds@osdl.org
References: <20030822210800.GA4403@elf.ucw.cz> <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain> <20030823114738.B25729@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030823114738.B25729@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Aug 23, 2003 at 11:47:38AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, another issue.

UCB1x00 devices.  I now have two implementations of drivers for these
devices, one trying to use the device/driver model and failing badly
with only half the functionality supported.  The other one is based
around one class, one class device, and several class interfaces.

What we have for the class model is:

  MCP driver (on platform bus) ----> UCB1x00 device

  UCB1x00 core driver ---> UCB1x00 class device contained within core driver
                           data structure

Then we have the UCB1x00 touchscreen, audio, random platform specific
GPIO drivers (0 to 13), random ADC drivers (0 to 4) which are class
interfaces.  The GPIO signals get used as interrupts, key inputs
(so would be an input device driver), another (slow) control bus,
or random device control.

The advantage with the class implementation is that you can register
as many class interfaces as you like against one class device - so
the UCB1x00 driver itself doesn't have to worry about the platform
specific details.  Those can be handled by a separate per-platform
"interface".

The class implementation seems to be better, but I'm hitting a snag -
power management.  The touchscreen and audio needs suspend/resume
support to work correctly (so DMA can be shut down, and touchscreen
threads woken up to ensure we aren't missing an interrupt.)

Unfortunately, the class model doesn't provide this functionality.

The device model does, but that then gives us a problem - how to handle
all the platform specific implementation details (ie, gpio and adc
drivers) sanely.  We can't create 17 struct devices just to let
platform specific drivers bind to what they need - that'd be insane
in terms of the overhead (struct bus_type + n * struct device
+ m * struct device_driver) but it does get us power management.

And one big UCB1x00 driver would be stuffed full of ifdefs, with
sound, input, and other random subsystem drivers all rolled into one.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

