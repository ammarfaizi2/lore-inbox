Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVHDHyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVHDHyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 03:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVHDHyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 03:54:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261955AbVHDHyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 03:54:44 -0400
Date: Thu, 4 Aug 2005 08:54:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Budd <budorola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: 2.4.21: Sharing interrupts with serial console
Message-ID: <20050804085440.A22910@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Budd <budorola@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <92fc8b8105080318367f77fed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <92fc8b8105080318367f77fed1@mail.gmail.com>; from budorola@gmail.com on Wed, Aug 03, 2005 at 06:36:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 06:36:51PM -0700, Chris Budd wrote:
> 1.  The rs_init function in ./linux-2.4.21/drivers/char/serial.c
> explicitly states "The interrupt of the serial console port can't be
> shared."  Does this include *ALL* interrupts?  The code checks for
> sharing only with other serial devices, not *ALL* types of devices
> like I2C, RTC, etc.

I think you'll find that older versions of the serial driver did not
allow the IRQ to be shared by other devices.  It probably got changed
with the addition of PCI card support.

> 2.  While the presence of the comment about not sharing was nice, it
> does not explain "why?"

Connecting a level-active interrupt output to an edge-triggered
interrupt controller input is Bad News(tm) for missing interrupts.

The situation is as follows:
- serial port asserts interrupt output which triggers an interrupt
  to the CPU.  You enter the serial handler.

- Before you clear the serial interrupt, the other device sharing
  this interrupt asserts its interrupt output - so there was no
  edge transition.

- You complete service the serial port, and move on to service the
  other device.

- Before you clear it's interrupt, the serial port re-asserts its
  interrupt output, and again there was no edge transition as far
  as the interrupt controller can tell.

- You complete servicing the other device and leave return from
  interrupt mode.

>From this point on, neither device can cause an interrupt to be sent
to the CPU again.

The above is rather long to put in a comment.

> Why can't we share the serial console interrupt?
> The serial console seems to work when I alter serial.c to
> skip this check for the sharing of interrupts with the serial console.

If the interrupt is shared, it's possible for the interrupt handler to
service the serial port while it's being used to send a kernel message,
and thereby disrupt the kernel message output.

> 3.  Does the hardware platform matter?  We are running Linux 2.4.21 on
> an embedded XScale(ARM)-based board.

Depends how you've connected the serial port interrupt.  Edge triggered
inputs bad, level triggered good.

If your Intel hardware doesn't have level triggered input capabilities,
please apply customer pressure to Intel to ensure that they consider it
for their future ARM-based designs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
