Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVH3VT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVH3VT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVH3VT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:19:58 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:6673 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932475AbVH3VT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:19:57 -0400
Date: Tue, 30 Aug 2005 23:20:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6] I2C: Drop I2C_DEVNAME and i2c_clientname
Message-Id: <20050830232008.3420f0f1.khali@linux-fr.org>
In-Reply-To: <1125360762.6186.29.camel@localhost>
References: <20050815195704.7b61206e.khali@linux-fr.org>
	<1124741348.4516.51.camel@localhost>
	<20050825001958.63b2525c.khali@linux-fr.org>
	<1125360762.6186.29.camel@localhost>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

> (...) it would be nice not to have a different I2C
> API for every single 2.6 version :-) It would be nice to change I2C
> API once and keep it stable for a while.

As nice as you seem to think it would be, I don't think it's not
realistic. For one thing, we don't necessarily know in advance what
changes will be needed. One month ago, I didn't even know that
I2C_DEVNAME and i2c_clientname were existing. For another, changes take
time to be dicussed, implemented and tested. Some changes depend on
others. We just can't buffer everything for a year and push everything
to Linus at once. Some of the changes, such as the i2c-isa killing or
the asynchronous i2c interface, are things some people really need, and
we can't ask them to wait for months or years.

The Linux 2.6 development model is designed around a relatively fast
move from -mm to Linus' tree, which implies incremental changes all the
time. I'm only doing that.

> > As time goes, the differences bwteen 2.4 and 2.6
> > will only increase. You seem to be trying to keep common driver code
> > across incompatible trees. I'm not surprised that it is a lot of
> > work. That's your choice, live with it.
>
> It is not just a matter of choice.

To me, it seems to be. No other part of the kernel does it as far as I
know. Or can you point me to other drivers that are part of the Linux
2.6 tree and include compatibility code for Linux 2.4? I am even
surprised that you are allowed to do it.

> (...) V4L stuff is mostly used by end
> users. There are a few professional users, like those working on CATV
> and video broadcasting. They don't have much knowledge and generally
> uses distro-provided kernels. It is not like I2C or PCI that most
> boards has something inside.
> Also: boards are country-specific. There are dozens of different analog
> standards. So, the same brand name (even the same model on some cases)
> have different tuners for different video standards.

I don't know what you are trying to demonstrate here, but all this is
completely unrelated with the decision of maintaining common driver code
rather than separate driver code. V4L is not different from other areas.
See how hard the framebuffer folks are struggling with the high number
of different graphics adapter setups for example. Same goes for SMBus
and hardware monitoring chips as far as I am concerned. Every mainboard
is different to some extent. And the list certainly doesn't stop there.
The difficulty to test the code on every existing piece of hardware
affects all driver authors and maintainers.

> For us to have people to test all variations, we need to provide
> backward support. Otherwise, we'll suffer a lot to test our patches,
> since nobody on V4L devel is currently payed for doing his job and
> don't have a lab with a bunch of cards and models.

Again, this ain't related with your decision to maintain a single set of
drivers for Linux 2.4 and Linux 2.6 rather than having different
drivers.

An example I know well is the lm_sensors project. As you may now, no
SMBus nor hardware monitoring driver is part of Linux 2.4. We are
maintaining drivers in a separate CVS repository. They are different
code from what we have in Linux 2.6. Still, we port the relevant changes
from one set of drivers to the other. Frankly, this ain't that
difficult, and works fine for over two years now. Maybe you should try.

I don't want to frighten you or anything, but there are changes to the
i2c subsystem which will affect compatibility in -mm, and these will hit
Linus' tree quite soon now. And I heard there are much much more in the
works, not even by me, that might go in 2.6.15.

> I have a question for you about I2C: why i2c_driver doesn't have a
> generic pointer to keep priv data (like i2c_adapter) ? 

It wouldn't make sense in the current i2c driver model (which is
probably broken, no need to argue.) i2c_driver holds the code (or
pointers to code) that is common to all chips using this driver. That
is, mostly administrative stuff. The instance-specific structure is
i2c_client. The common practice is to encapsulate the i2c_client
structure into a dedicated structure, and put all your private data in
this structure. See how this is done in drivers/hwmon/*.c.

Maybe it sounds strange to you because (I heard) the i2c subsystem
doesn't follow the usual driver model. But rest assured, I also heard
that some people wanted to fix that soon. I guess you (or others) can't
complain that the i2c subsystem is broken, and at the same time ask that
it be kept compatible with its current or even previous state.

> It would be nice to have such pointer (like have on other I2C
> structures), in order to support multiple tuners for each function.
> This is required for modern boards that have a TV analog tuner, a
> digital one and a radio chip, it would be nice to have such structure
> to keep a tuner table on it, and make easier to detect this.

I am most certainly wrong, but it looks to me like you are wanting to
store this data in the wrong place. I can't see how i2c_driver would be
relevant for that. Multiple tuners is a property of the board itself,
not a property of an individual chip, be it an I2C chip or not.

-- 
Jean Delvare
