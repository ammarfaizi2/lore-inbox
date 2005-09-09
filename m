Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVIIUtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVIIUtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVIIUtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:49:11 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:20369 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1030335AbVIIUtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:49:09 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=MrLIn3D8e/x16fyJ193nGdTKxoCzaQmEP7IoKPSeCZYvdJiRa8lZ6+1XU7W89dkyc
	g+Dz7GFu9AYe6kvbCXZ8w==
Date: Fri, 09 Sep 2005 13:48:48 -0700
From: David Brownell <david-b@pacbell.net>
To: glikely@gmail.com
Subject: Re: SPI redux ... driver model support
Cc: linux-kernel@vger.kernel.org, dpervushin@ru.mvista.com,
       basicmark@yahoo.com
References: <20050907183843.14745.qmail@web30307.mail.mud.yahoo.com>
 <20050909030934.8419AE9DCC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <528646bc0509091040364ae7d4@mail.gmail.com>
In-Reply-To: <528646bc0509091040364ae7d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050909204848.E63B8E9DF1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 9 Sep 2005 11:40:39 -0600
> From: Grant Likely <glikely@gmail.com>
>
> On 9/8/05, David Brownell <david-b@pacbell.net> wrote:
> > That implies whoever is registering is actually going and creating the
> > SPI devices ... and doing it AFTER the controller driver is registered.
> > I actually have issues with each of those implications.
> > 
> > However, I was also aiming to support the model where the controller
> > drivers are modular, and the "add driver" and "declare hardware" steps
> > can go in any order.  That way things can work "just like other busses"
> > when you load the controller drivers ... and the approach is like the
> > familiar "boot firmware gives hardware description tables to the OS"
> > approach used by lots of _other_ hardware that probes poorly.  (Except
> > that Linux is likely taking over lots of that "boot firmware" role.)
>
> To clarify/confirm what your saying:
>
> (I'm going to make liberal use of  stars to hilight "devices" and
> "drivers" just to make sure that a critical word doesn't get
> transposed)

And given that you're not using quite the same terminology I am, I think
we agree here.  Good!  :)

In my terminology, which should be clear in the Kconfig:
 
   - There are two types of SPI bus controller: master (issues clock)
     and slave (receives clock).  Linux should plan to handle both.

   - On top of either type of controller driver would be a "protocol driver"
     that processes messages.  (Is there a better name to use for these?)
 
What you've called a "slave driver" is what I've called a "protocol master"
driver, talking to a slave device/chip.  What I'd call a "slave driver"
would be either a controller driver or a protocol driver; but in any case
it'd run on hardware that _receives_ the SPI clock.

A slave protocol driver for the EEPROM protocol could be tricky in Linux,
given the single bit turnaround between request and response; but the
master protocol driver would be simple.  Linux should easily be able to
implement data streaming protocol slaves, including things like exchanging
network packets as well as the more conventional streams of sensor data.


> There should be four parts to the SPI model:
> 1. SPI bus controller *devices*; attached to another bus *instance*
> (ie. platform, PCI, etc)
> 2. SPI bus controller *drivers*; registered with the other bus
> *subsystem* (platform, PCI, etc)
> 3. SPI slave *devices*; attached to a specifiec SPI bus *instance*
> 4. SPI slave *drivers*; registered with the SPI *subsystem*

Yes, with the proviso above:  "slave driver" here mean the thing that
talks to the slave through the SPI master controller driver.  (As you
noted in the PPC patches you sent, you were not addressing SPI slave
side support.)


> a. SPI bus controller *drivers* and slave *drivers* can be registered
> at any time in any order
> b. SPI bus controller *devices* can be attached to the bus subsystem at any time
> c. SPI bus controller *drivers* attach to bus controller *devices* to
> create new spi bus instances whenever the driver model makes a 'match'
> d. SPI slave devices can be attached to an SPI bus instance only after
> that bus instance is created.

Yes, where the "slave device" in this case is the Linux driver model
thing representing a software proxy for the physical slave hardware;
it's never a discrete chip I could point to on a board.


> e. SPI slave *drivers* attach to SPI slave *devices* when the driver
> model makes a match.  (let's call it an SPI slave instance)

I'd call that just another "struct device" that happens to be bound to
some "struct device_driver".  Being bound is optional in Linux, though
of course a device has limited utility until it's bound (since it's
not accessible to user or kernel code).


> f. Unregistration of any SPI bus controller *driver* or *device* will
> cause attached SPI bus instance(s) and any attached devices to go away

Right.  Modulo the usual sysfs/kobject reference counting and memory
management issues; the memory may linger for a while, though things
will not be visible in sysfs any more.


> g. Unregistration of any SPI slave *driver* or *device* will cause SPI
> slave instance to go away.
>
> [pretty much exactly how the driver model is supposed to work I guess  :)  ]

Exactly so!  Except actually for (g) ... unregistering a master protocol
driver (for an SPI slave chip) just leaves an unbound device.  Removing
the device implies first unbinding its driver though.


The goal here is that -- unlike I2C -- an SPI driver framework should
leverage the driver model and the "Principle of Least Astonishment", so
that driver concepts (and developer skills!!) from elsewhere in Linux will
transfer as directly as practical.


> Ideally controller drivers, controller devices, slave drivers and
> slave devices are all independent of each other.  The board setup code
> will probably take care of attaching devices to busses independent of
> the bus controller drivers and spi slave drivers.  Driver code is
> responsible for registering itself with the SPI subsystem.
>
> If this is what your saying, then I *strongly* second that opinion. 

Modulo the provisos above, yes -- that's exactly what I'm saying.

(As well as: let's get terminology settled.  I didn't make a big deal
of it in my original post, and am not deeply attached to what I used,
but it's important to remember that Linux can handle both master and
slave controllers, and that the drivers talking to each will not be
quite the same ... there are four types of SPI driver involved.)


> I've been dealing with the same problems on my project.  Just for
> kicks, here's another implementation to look at.
>
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019259.html
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019260.html
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019261.html
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019262.html
>
> It also is not based on i2c in any way and it tries ot follow the
> device model.  It solves my problem, but I've held off active work on
> it while looking at the other options being discussed here.

I noticed that.  Also the way your second patch needed some "board
specific hacks" that you didn't much like!  :)

Yet another SPI stack, linked from one of those threads, is I2C-ish:

  http://www.katix.org/spi.php

For me I think the high order bits involve "normal" driver model support
(which implies avoidng most borrowing from I2C); being sure that both
master and slave sides stay in the picture, and ensuring that the "SPI
master protocol drivers" can issue transfer requests from IRQ handlers
and any other contexts which happen to notice one is needed.

- Dave


