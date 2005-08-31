Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVHaH7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVHaH7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVHaH7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:59:54 -0400
Received: from web30308.mail.mud.yahoo.com ([68.142.200.101]:44624 "HELO
	web30308.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932483AbVHaH7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:59:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G6+JNvcIcMe8dR0DJxsbPUNiIvOai23IFJDtfTW/eZudaDZ+/rC1LLEVaGE2pddcW3hqqV2fedn29jO4oG7aByqUFOucps9VgG6KAkezBmp4Y2WBgIMXNt5OGw6WQ/88AXYUp2LeILgF1GvrZZGzgBdGK2dNDucVhifpBhUPH5s=  ;
Message-ID: <20050831075944.35664.qmail@web30308.mail.mud.yahoo.com>
Date: Wed, 31 Aug 2005 08:59:44 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI redux ... driver model support
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com, basicmark@yahoo.com
In-Reply-To: <20050830024216.9AFEDC10BE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> The last couple times SPI frameworks came up here,
> some of the feedback
> included "make it use the driver model properly;
> don't be like I2C".
> 
> In hopes that it'll be useful, here's a small SPI
> core with driver model
> support driven from board-specific tables listing
> devices.  I expect the
> I/O call(s) could stand to change; but at least this
> one starts out right,
> based on async I/O.  (There's a synchronous call;
> it's a trivial wrapper.)
> 
>  arch/arm/Kconfig       |    2 
>  drivers/Kconfig        |    2 
>  drivers/Makefile       |    1 
>  drivers/spi/Kconfig    |  302
> +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/spi/Makefile   |   32 ++++
>  drivers/spi/spi_init.c |  233
> ++++++++++++++++++++++++++++++++++
>  include/linux/spi.h    |  179
> ++++++++++++++++++++++++++
>  7 files changed, 751 insertions(+)
> 
> Here's one instance of the sysfs "spi_host" class:
> 
> 	[root@argon sys]# cd /sys/class
> 	[root@argon class]# ls
> 	i2c-adapter/   misc/          pcmcia_socket/
> spi_host/      usb_host/
> 	input/         mtd/           scsi_device/   tty/  
>         vc/
> 	mem/           net/           scsi_host/     usb/
> 	[root@argon class]# ls spi_host
> 	spi2/
> 	[root@argon class]# ls -l spi_host/spi2
> 	drwxr-xr-x    2 root     root            0 Aug 29
> 18:46 ./
> 	drwxr-xr-x    3 root     root            0 Dec 31 
> 1969 ../
> 	lrwxrwxrwx    1 root     root            0 Aug 29
> 18:46 device ->
> ../../../devices/platform/omap-uwire/
> 	[root@argon class]#
> 
> Here are the real sysfs objects for that host and
> its single child
> (on chipselect 0).  Notice that the device exists,
> but is waiting for
> driver-modelized ads7846 support (touchscreen and
> other sensors):
> 
> 	[root@argon class]# cd
> /sys/devices/platform/omap-uwire
> 	[root@argon omap-uwire]# ls
> 	bus@            driver@         power/         
> spi2.0-ads7846/
> 	[root@argon omap-uwire]# ls -l spi*
> 	lrwxrwxrwx    1 root     root            0 Aug 29
> 18:46 bus -> ../../../../bus/spi/
> 	-r--r--r--    1 root     root         4096 Aug 29
> 18:46 modalias
> 	drwxr-xr-x    2 root     root            0 Aug 29
> 18:46 power/
> 	[root@argon omap-uwire]# cat spi*/modalias
> 	ads7846
> 	[root@argon omap-uwire]#
> 
> For your viewing pleasure, and without the broadast
> flag that would
> prevent further redistribution, a patch is appended.
> 
> - Dave
> 
> 
> -----------------------------------------	SNIP!!
> This is the start of a small SPI framework that
> started fresh, so it
> doesn't continue the "i2c driver model mess".

-= snip =-

Well I guess great minds think alike ;-). After
looking though my SPI core layer I released that it in
no way reflected the new driver model (not surprising
as it was a copy of i2c-core.c) and I would probably
get laughed off the kernel mailing list if I sent it
as was ;-).  
I am now writing a new spi-core.c which uses the new
driver model.

For registering an adapter:
1) Register an adapter that has a cs table showing
where devices sit on the adapter.
2) This causes spi-core to enumerate the devices on
the cs table and register them.

For un-registering an adapter:
1) Unregister an adapter
2) This causes spi-core to remove all the children of
the adapter

I have a test adapter and a couple of test devices and
am currently debugging a usage count problem. I will
send a patch once I have a working system.

Mark




		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
