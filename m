Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVHaPfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVHaPfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVHaPfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:35:04 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:32582 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S964840AbVHaPfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:35:02 -0400
Subject: Re: [PATCH 2.6] I2C: Drop I2C_DEVNAME and i2c_clientname
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com,
       Greg KH <greg@kroah.com>
In-Reply-To: <20050830232008.3420f0f1.khali@linux-fr.org>
References: <20050815195704.7b61206e.khali@linux-fr.org>
	 <1124741348.4516.51.camel@localhost>
	 <20050825001958.63b2525c.khali@linux-fr.org>
	 <1125360762.6186.29.camel@localhost>
	 <20050830232008.3420f0f1.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 31 Aug 2005 12:34:58 -0300
Message-Id: <1125502498.9401.99.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-6mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2005-08-30 às 23:20 +0200, Jean Delvare escreveu:
> Hi Mauro,
> 
> > (...) it would be nice not to have a different I2C
> > API for every single 2.6 version :-) It would be nice to change I2C
> > API once and keep it stable for a while.

> The Linux 2.6 development model is designed around a relatively fast
> move from -mm to Linus' tree, which implies incremental changes all the
> time. I'm only doing that.
	It is ok to change code, but, IMHO, API should be more stable.

> An example I know well is the lm_sensors project. As you may now, no
> SMBus nor hardware monitoring driver is part of Linux 2.4. We are
> maintaining drivers in a separate CVS repository. They are different
> code from what we have in Linux 2.6. Still, we port the relevant changes
> from one set of drivers to the other. Frankly, this ain't that
> difficult, and works fine for over two years now. Maybe you should try.
	This is a good idea. We may try it for 2.4. But it is not feasible to
have one separate CVS tree for every 2.6.x. So, for 2.6.x we have to
handle with several ifdefs for each change on I2C API (other kernel
stuff are more stable).
> 
> I don't want to frighten you or anything, but there are changes to the
> i2c subsystem which will affect compatibility in -mm, and these will hit
> Linus' tree quite soon now. And I heard there are much much more in the
> works, not even by me, that might go in 2.6.15.
	It would be nice if this won't break compatibility with previous
versions of 2.6.
> 
> > I have a question for you about I2C: why i2c_driver doesn't have a
> > generic pointer to keep priv data (like i2c_adapter) ? 
> 
> It wouldn't make sense in the current i2c driver model (which is
> probably broken, no need to argue.) i2c_driver holds the code (or
> pointers to code) that is common to all chips using this driver. That
> is, mostly administrative stuff. The instance-specific structure is
> i2c_client. The common practice is to encapsulate the i2c_client
> structure into a dedicated structure, and put all your private data in
> this structure. See how this is done in drivers/hwmon/*.c.
> 
> Maybe it sounds strange to you because (I heard) the i2c subsystem
> doesn't follow the usual driver model. But rest assured, I also heard
> that some people wanted to fix that soon. I guess you (or others) can't
> complain that the i2c subsystem is broken, and at the same time ask that
> it be kept compatible with its current or even previous state.
> 
> > It would be nice to have such pointer (like have on other I2C
> > structures), in order to support multiple tuners for each function.
> > This is required for modern boards that have a TV analog tuner, a
> > digital one and a radio chip, it would be nice to have such structure
> > to keep a tuner table on it, and make easier to detect this.
> 
> I am most certainly wrong, but it looks to me like you are wanting to
> store this data in the wrong place. I can't see how i2c_driver would be
> relevant for that. Multiple tuners is a property of the board itself,
> not a property of an individual chip, be it an I2C chip or not.
I2C at V4L was modelled this way by Gerd Knorr (and, btw, it looks ok to
me):

chipset_specific-i2c.c (for example, saa7134-i2c.c):
	Handles chipset-specific details (for bt8xx, cx88, saa7134, ...)

It contains:

i2c_adapter - with card specific implementation
i2c_algorithm - with I2C-specific I/O modes (if needed)

	It handles one adapter by PCI device.

tuner-core.c:
	Handles tuner generic code. The same tuner can be present on different
boards, with different chipsets.

i2c_driver - with tuner probing part (attach_adapter). This does a I2C
scanning to check what tuners are present at hardware.
i2c_client - with tuner specific code.

	It handles one i2c_driver by PCI device and one or more i2c_client by
i2c_adapter.

	Since 2.6.12, we do support more than one tuner at tuner-core. It was
needed because the same board may have a radio, analog_tv and/or
digital_tv that can be just one tuner for all or separate tuners. If
separate, it is common that they have also separated addresses. On this
case, one I2C command is provided to switch to the second one).

	It should be noticed that there are some newer I2C radio chips, yet not
supported, that uses two separated I2C addresses (one for normal
programming and another mostly for RDS).

	The current I2C approach replicates an Object Oriented structure. So,
i2_driver handles a callback to a probe structure, but doesn't provide
any mechanisms to pass parameters the the I2C objects, or to receive
values. So, the attach routine provided by tuner-core (tuner_attach)
cannot know for sure if the detected device was a Radio only tuner, a TV
only tuner or a generic one. The same PCI device cannot have more than
tuner of the same type active. So, autodetection code have a static var
to help  to identify what types were already detected. It would be nice
to have a way to eliminate the static var and have some data *at* driver
structure to handle what is the active tuner for that function.

	It would be nice also to have a command call to the driver structure,
so that the driver can send the commands to the specific client.

	As an example, we currently do (at chipset_specific level):

        i2c_clients_command(&dev->i2c_adap, command, arg);

	Generating a "spam" to every I2C tuner.

	At the tuner-core, we need to filter the command to the specific tuner
(radio, for example). If the tuner is not radio, return. 

	This generates extra cycles and some mess to understand what's
happening.

	It would be better to do:

	i2c_driver_command(&dev->i2c_adap, command, arg);

	and, at i2c_driver:
        i2c_client_command(i2c_client, command, arg);

	But this would require some data structure at driver level to store an
driver list.
	

> 
Cheers, 
Mauro.

