Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVKCJHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVKCJHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 04:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVKCJHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 04:07:35 -0500
Received: from tim.rpsys.net ([194.106.48.114]:41182 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751248AbVKCJHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 04:07:34 -0500
Subject: Re: [RFC] The driver model, I2C and gpio provision on Sharp
	SL-C1000 (Akita)
From: Richard Purdie <rpurdie@rpsys.net>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, andy@hexapodia.org
In-Reply-To: <200511022306.48405.david-b@pacbell.net>
References: <200511022306.48405.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 09:07:23 +0000
Message-Id: <1131008844.8523.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 23:06 -0800, David Brownell wrote:
> Likewise on many OMAP boards, which tend to have the power management
> and other essential features on I2C.
> 
> Some board-specific init code ends up needing to run after the probe()
> logic of the tps6501x driver ... like for example, using a GPIO (!)
> there to power up the Ethernet controller which may be needed for the
> root filesystem.  (At least on many development systems!)
> 
> You can see where that leads:  we patched the i2c subsystem so that
> it runs at subsys_initcall ... and also the omap_i2c driver, and
> the tps65010 driver.  No other drivers need to be changed, just the
> ones involved in that board's power management.

Its not as simple as this in my case. Yes, you can patch the maxim i2c
driver and the pxa i2c controller to run at subsys_initcall level which
is fine. akita-ioexp has to run at a higher level (fs_initcall) as it
will run before the i2c subsystem (being in arch as against drivers).

I don't think is feasible to go through the LCD, IrDA and sound
subsystems trying to guarantee what init levels they're going to access
the gpios at once you start getting to fs_initcall level.

This could be a case for putting akita-ioexp into drivers/i2c/chips but
see my other thoughts below...

> Richard:
> 
> > I had to turn akita-ioexp into a platform device to get the suspend
> > signal which is used to flush the workqueue. With a platform device
> > available at machine init time, I can insert it as a parent of the corgi
> > device chain which means its one of the last devices to be suspended.
> 
> By doing all that stuff as "subsys_initcall", the relevant I2C gpio
> hardware will be also be suspended "late" ... without such a fake
> platform device.  Unless you're doing selective suspend, details of
> the device tree matter less than the order used to create devices.

I'd like to keep the device tree correct, then if anyone does want to
selectively suspend things, it will work and it also works if someone
decides to change the device init order around at some later date and
not everything will break.

I'm coming to the view that I should merge the max7310 i2c driver into
akita-ioexp and lose the general case driver for the following reasons:

1. Having a header file around for two functions seems excessive and I
can't see any alternative
2. The MAX7310 has 56 different i2c addresses and no way of detecting
the presence of the chip. Autoprobing on akita means you end up with the
sound codec being taken by the max7310 driver. I don't like to think
what it would do on other systems.
3. There's no interdependency between two drivers and hence it should be
more robust.
4. I can lose the workqueue "find the i2c client" routine as the driver
can know when the i2c device has been detected and the client setup.
(the workqueue is still needed to act on gpio requests in case they come
from interrupt context but the driver becomes simpler and of a more sane
design).

Richard

