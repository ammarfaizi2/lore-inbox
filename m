Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbTAQTPF>; Fri, 17 Jan 2003 14:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbTAQTPF>; Fri, 17 Jan 2003 14:15:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24071 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267642AbTAQTO7>; Fri, 17 Jan 2003 14:14:59 -0500
Date: Fri, 17 Jan 2003 19:23:56 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Initcall / device model meltdown?
Message-ID: <20030117192356.F13888@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The initcall/device model seems to be quite fragile at the moment with
respect to not oopsing the kernel.

On many StrongARM-based systems, a multifunction chip addressed through
a serial bus is used to provide touchscreen, audio and additional digital
IO.  Currently, there are many sub-drivers, some of which are modular
themselves, and some which depend on each other.  They currently live
under drivers/misc, for want of a better location.  They are all
initialised using module_init(), via the device model driver_register()
function.

The input drivers are also modular, and provide a device class
(input_devclass), which is registered using module_init().

One of the multifunction device drivers is a touchscreen driver, which
should obviously be part of the input device class.

Both the input core and the multifunction chip drivers are using
module_init(), the order in which these are initialised is link-order
specific, and it happens that drivers/input is initialised really late
during boot, after drivers/misc.

Since the device model requires any object to be initialised before it
is used, this causes an oops from devclass_add_driver().

We appear to have two conflicting requirements here:

1. the device model requires a certain initialisation order.
2. modules need to use module_init() which means the initialisation order
   is link-order dependent, despite our multi-level initialisation system.

Obviously one solution would be to spread the drivers for this
multifunction chip throughout the kernel tree (ie, by function not
by device) so the touchscreen driver would live under drivers/input.

However, then we need to make sure that the multifunction chip's
bus type is initialised before any of the other subsystems, and of
course, the bus type is initialised using module_init() since it
lives in a module...

I think we need to re-think what we're doing with the initialisation
handling and the device model before these sorts of problems get out
of hand.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

