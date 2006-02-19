Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWBSNWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWBSNWk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 08:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWBSNWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 08:22:40 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:21771 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932431AbWBSNWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 08:22:40 -0500
Date: Sun, 19 Feb 2006 14:23:11 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Cc: Greg KH <greg@kroah.com>, Philippe Seewer <philippe.seewer@bfh.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: Stuck creating sysfs hooks for a driver..
Message-Id: <20060219142311.ba0f8a38.khali@linux-fr.org>
In-Reply-To: <43F46319.9090400@designergraphix.com>
References: <43F2DE34.60101@designergraphix.com>
	<20060215221301.GA25941@kroah.com>
	<43F46319.9090400@designergraphix.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaiwan,

> One thing i'd like to point out though, Greg: the LM70 is an 
> SPI/Microwire based system and not i2c; so straight away, the i2c 
> interface by itself will not be used...; also, the specific board 
> (LM70CILD-3, which i've written the 2.4 driver for & am now porting to 
> 2.6), comes with a built-in parport interface..so that's what the driver 
> takes into account of course..

You must stay away from writing a driver for the board itself. What you
must write is in fact two different drivers:

1* A driver for the SPI interface of your board (basically a parallel
port <-> SPI bridge). This driver will expose the device as an SPI bus
to the rest of the kernel. This driver doesn't care about what chip is
plugged on it.

2* A driver for the LM70 temperature sensor chip, which doesn't care
about the chip location. This driver will use generic SPI commands as
offered by the spi kernel interface.

This modular approach makes it possible to then reuse each of the
drivers. If you later have a similar board for a different chip, the
first driver will still work (assuming the new board uses SPI and the
same wiring conventions). If you later have an LM70 chip on a different
physical interface, the second driver will still work.

You should take a look at how this was done for the Analog Devices
ADM1032 evaluation board, as this is really similar, except that the
ADM1032 uses I2C/SMBus instead of SPI.

The board itself is driven by the i2c-parport driver. This driver
exposes the board as a generic i2c interface to the rest of the kernel.
The bit-banging logic is common to various I2C bus driver and can be
found in i2c-algo-bit. The i2c-parport really only defines which bits
must be played with to control the I2C bus lines. SPI has an equivalent
helper driver named spi_bitbang. I've never used it myself but it must
be very similar. So your first driver would be similar to i2c-parport
except that it would use spi_bitbang instead of i2c-algo-bit. There
doesn't seem to be any in-tree user of spi_bitbang right now so you are
walking a relatively new path. Maybe the spi folks will be able to
guide you.

The ADM1032 chip is driven by the lm90 driver (National Semiconductor's
LM90 and Analog Devices' ADM1032 are fully compatible). This driver
uses the generic i2c/smbus interface. Thanks to this, it works with the
chip on the parallel port evaluation board, but also with compatible
chips found in laptops or desktop SMBus. Your lm70 driver would be
similar, except that it would use spi commands instead of i2c/smbus
commands. The sysfs interface should be very similar, except that yours
would be more simple if the LM70 is a single temperature chip.

> Also it's a relatively simple temperature sensor - it does not seem to 
> support hysteresis temperature, i/p voltages, etc. I'm saying all this 
> as the sysfs interface i envision is just a simple read-only hook: the 
> o/p value (after a little userspace massaging) is the temperature in 
> Celsius correct to 0.25 degrees. So it looks to me that this particular 
> driver necessitates a kind-of "custom" entry under /sys/class/hwmon with 
> it's own userspace support. Do I move ahead in this direction?

No, just do what every other hardware monitoring chip does, so that
support can be added for the lm70 chip in libsensors - then you win
instant support in all hardware monitoring application which rely on
libsensors, and even a few which do not.

It's really not a matter of how many features a chip has. Look at the
lm75 or w83l785ts driver, you'll see they have very few features as
well. It's a matter of having a common standard for exporting the
values to user-space, so that the same library or application can
handle all sources with minimum effort.

Thanks,
-- 
Jean Delvare
