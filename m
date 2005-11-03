Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVKCHGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVKCHGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 02:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVKCHGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 02:06:50 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:2195 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751188AbVKCHGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 02:06:50 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] The driver model, I2C and gpio provision on Sharp SL-C1000 (Akita)
Date: Wed, 2 Nov 2005 23:06:48 -0800
User-Agent: KMail/1.7.1
Cc: andy@hexapodia.org, Richard Purdie <rpurdie@rpsys.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022306.48405.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It seems that making i2c init early is only sane choice. I realize PC people
> > will hate it...

What do you mean by "early"?  Other than maybe linking it earlier
in the drivers/Makefile, and probably running some arch-specific i2c
controller (and certain i2c chip) drivers at subsys_initcall rather
than at device_initcall ... does the 2.6.14 kernel need changes?


> > but apart from that, why is it impractical? 
> 
> FWIW, I have also run into this "I need I2C early in boot, but it's not
> inited until late" on SiByte ...

Likewise on many OMAP boards, which tend to have the power management
and other essential features on I2C.

Some board-specific init code ends up needing to run after the probe()
logic of the tps6501x driver ... like for example, using a GPIO (!)
there to power up the Ethernet controller which may be needed for the
root filesystem.  (At least on many development systems!)

You can see where that leads:  we patched the i2c subsystem so that
it runs at subsys_initcall ... and also the omap_i2c driver, and
the tps65010 driver.  No other drivers need to be changed, just the
ones involved in that board's power management.


Richard:

> I had to turn akita-ioexp into a platform device to get the suspend
> signal which is used to flush the workqueue. With a platform device
> available at machine init time, I can insert it as a parent of the corgi
> device chain which means its one of the last devices to be suspended.

By doing all that stuff as "subsys_initcall", the relevant I2C gpio
hardware will be also be suspended "late" ... without such a fake
platform device.  Unless you're doing selective suspend, details of
the device tree matter less than the order used to create devices.

- Dave

