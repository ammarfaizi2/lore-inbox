Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSBUACd>; Wed, 20 Feb 2002 19:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSBUACY>; Wed, 20 Feb 2002 19:02:24 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:23302 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S292588AbSBUACG>;
	Wed, 20 Feb 2002 19:02:06 -0500
From: Christer Weinigel <wingel@nano-system.com>
To: roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: SC1200 support?
Newsgroups: linux.kernel
In-Reply-To: <Pine.LNX.4.30.0202201423001.22702-100000@mustard.heime.net>
Message-Id: <20020221000202.363E6F5B@acolyte.hack.org>
Date: Thu, 21 Feb 2002 01:02:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
>I have this set-top box with a National Semiconductor Geode SC1200 chip
>with a built-in watch-dog plus a lot more.
>
>Does anyone know if there is any support for the sc1200-specific features
>in the current kernels, or if there are patches available?

Darn, I've been meaning to clean these patches up for a month or so,
but I haven't had the time yet.  I've made a snapshot of my CVS tree
that you can find at:

    http://www.nano-system.com/scx200/

These patches are for a box called the Nano Computer, a SC2200 based
system that I've been involved in the design of.  I've written drivers
for the Watchdog, an I2C bus, a MTD map driver and a few small fixes
and workarounds.  These drivers ought to work across the whole SCx200
line of processors.

First of all, the current snapshot is based upon Linux-2.4.17 + Keith
Owens kbuild-2.5 system.  To get something that you can use, download,
unpack and patch all the neccesary stuff:

    tar xvfz scx200-20020219.tar.gz
    cd nano/kernel
    tar xvfz linux-2.4.17.tar.gz
    cd linux
    bzcat kbuild-2.5-2.4.16-3.bz2 | patch -p1
    bzcat kbuild-2.5-2.4.17-1.bz2 | patch -p1

Then, to build a kernel use nano/kernel/build.sh which is just a shell
script that wraps the kbuild stuff:

    cd nano/kernel
    ./build.sh config
    ./build.sh

And, now for the drivers.

    nano/kernel/arch/i386/kernel/scx200.c -- probes for a SCx200 CPU
    and allocates some resources, and code to control the GPIO pins

    nano/kernel/arch/i386/kernel/scx200_nano.c -- board specific setup
    for the Nano Computer, it mostly sets up a few things that the
    BIOS hasn't set up the way I want them to be

    nano/kernel/nano/init/main.c -- has been modified to call
    scx200_init and scx200_nano_init

    nano/kernel/nano/drivers/char/scx200_watchdog.c -- a driver for
    the built in watchdog of a SCx200 CPU

    nano/kernel/nano/drivers/i2c/scx200_i2c.c -- a driver for an I2C
    bus using two GPIO pins

    nano/kernel/nano/drivers/mtd/maps/scx200_docflash.c -- a driver
    for using Intel Strataflash mapped via the DOCCS pin

    nano/kernel/nano/drivers/ide/* -- I've modified the CS5530 IDE
    driver to recognize the SCx200 IDE controller.  WARNING!  I'm not
    sure if this is a safe thing to do, the specifications for the
    CS5530 and the SCx200 look quite similar, but I might have missed
    something.  Remove this directory to be on the safe side.

    nano/kernel/nano/drivers/net/natsemi.c -- contains some debugging
    code and a fix to turn off wake-on-lan since it caused an
    interrupt storm if I did ifconfig eth0 down.  I belive this has
    been fixed in newer versions of the natsemi driver.

    nano/kernel/nano/include/linux/pci_ids.h -- updated with PCI IDs
    for the SCx200 CPUs.

    nano/kernel/nano/include/linux/scx200.h -- header file for the
    scx200.c functions.

    nano/kernel/sensors/* -- is just a copy of the lm75 and eeprom
    drivers from lm_sensors (the board I'm using have a serial eeprom
    and two temperature sensors)

It should be trivial to move these drivers to a newer Linux kernel and
to work without the kbuild stuff.

Any questions, suggestions or flames regarding the drivers are
welcome.  I'd be especially happy if someone can take a look at the
GPIO functions in scx200.h and tell me if they look ok.  I think I've
managed to build an interrupt safe way of touching the I/O ports, but
I might have missed something.

Hm, I'd better put this mail up as a README.txt at the same place.

  /Christer
