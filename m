Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWCNJsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWCNJsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWCNJsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:48:47 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:9177 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP
	id S1751778AbWCNJsq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:48:46 -0500
Date: Tue, 14 Mar 2006 10:43:54 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: Re: sis96x compiled in by error: delay of one minute at boot
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <9M1JwY7o.1142329434.1027530.khali@localhost>
In-Reply-To: <20060313223824.79218.qmail@web26915.mail.ukl.yahoo.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Etienne Lorrain" <etienne_lorrain@yahoo.fr>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Tue, 14 Mar 2006 10:43:55 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Etienne,

On 2006-03-13, Etienne Lorrain wrote:
> > > I just forgot to remove CONFIG_I2C_SIS96X=y in my kernel (minimum
> > > support possible for my PC hardware based on VIA, no module at all)
> > > and get a one minute delay at boot when trying to probe this non
> > > existing device in 2.6.16-rc5.
> > > Maybe the abscence test should be quicker.
> >
> > The SIS96x SMBus is a PCI chip, so if it doesn't exist in a given
> > system, no code at all should be executed. So I have a hard time
> > believing it takes one minute. How do you know for sure that _this_
> > driver causing the delay? Did you actually try to rebuild without
> > CONFIG_I2C_SIS96X?
>
> Sorry, I was just assuming that while probing I2C hardware one per one,
> if one line is diplayed for each driver I do not have - then the kernel
> will at least display one line if it found something.

This is the way it should work, but unfortunately our i2c bus drivers
don't follow these rules. Almost all of them keep quiet when loaded
(except for i2c-sis96x, as you found out by yourself) but they also keep
quiet (unless debug is enabled) when a supported device is found, which
is not so good.

Mark, can you provide a patch to your i2c-sis96x driver so that it'll
keep quiet when no supported device is found?

We should probably have these drivers display something when they find a
supported chip. There are many drivers affected though (we have 41 real
i2c bus drivers by now) and many of them would need to be fixed, it
represents much more work if we want to do it properly. If anyone wants
to take his/her chance...

> I have this lspci:
> (...)
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> (...)
> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge

Off-topic, but it's quite strange. Your south bridge cannot be a VT8237R
and a VT8235 at the same time...

> And the fault on an ubuntu 5.10 system when using linux-2.6.16-rc5 is:
> (...)
> Mar 10 19:39:12 ubuntu kernel: [   42.264394] i2c /dev entries driver
> Mar 10 19:39:12 ubuntu kernel: [   42.267552] i2c-parport: using default
> base 0x378
> Mar 10 19:39:12 ubuntu kernel: [   42.270260] i2c-pca-isa: i/o base
> 0x000330. irq 10
> Mar 10 19:39:12 ubuntu kernel: [   42.273590] i2c-sis96x version 1.0.0
> Mar 10 19:39:12 ubuntu kernel: [  119.507926]  : Detection failed at step 3

This message is from the w83792d driver. This is a debug message, it
shouldn't be displayed here; the driver needs to be fixed.

> Mar 10 19:39:12 ubuntu kernel: [  119.755830] hdaps: supported laptop not
> found!
> Mar 10 19:39:12 ubuntu kernel: [  119.758363] hdaps: driver init failed
> (ret=-6)!

> So I did the long way of disabling each I2C driver one per one, the last
> is the one, as usual:
>  [*] ALI1535
>  [*] ALI1563
>  [*] ALI15x3
>  [*] AMD 756/766/768/8111 and nVidia nForce
>  [*]   SMBus multiplexing on the Tyan S4882
>  [*] AMD 8111
>  [*] Intel 82801 (ICH)
>  [*] Intel 810/815
>  [*] Intel PIIX4
>  [*] Nvidia nForce2, nForce3 and nForce4
>  [*] Parallel port adapter (light)
>  [*] S3/VIA (Pro)Savage
>  [*] S3 Savage 4
>  [*] NatSemi SCx200 ACCESS.bus
>  [*] SiS 5595
>  [*] SiS 630/730
>  [ ] SiS 96x
>  [ ] VIA 82C586B
>  [ ] VIA 82C596/82C686/823x
>  [ ] Voodoo 3
>  [ ] PCA9564 on an ISA bus
>
> Removing the last PCA9564 gives me:
> Mar 13 21:46:48 ubuntu kernel: [   47.699704] input: AT Translated Set 2
> keyboard as /class/input/input1
> Mar 13 21:46:48 ubuntu kernel: [   47.702667] input: PC Speaker
> as /class/input/input2
> Mar 13 21:46:48 ubuntu kernel: [   47.705445] i2c /dev entries driver
> Mar 13 21:46:48 ubuntu kernel: [   47.708637] i2c-parport: using default
> base 0x378
> Mar 13 21:46:48 ubuntu kernel: [   70.366096] hdaps: supported laptop not
> found!
> Mar 13 21:46:48 ubuntu kernel: [   70.368750] hdaps: driver init failed
> (ret=-6)!

You should also drop "Parallel port adapter (light)", it might cause
the same kind of delays and probably explains (part of) the 23 second
delay remaining.

> Which is a strong improvement. Note that I do not have an ISA bus on
> this machine...

I bet you do. You certainly don't have an ISA *slot*, but you must have
an ISA bus. Legacy devices (PS/2 keyboard and mouse, serial and parallel
ports...) and super-I/O (LPC) chips still use it.

> Following a bit:
> removing "Dallas Semiconductor DS1337 and DS1339 Real Time Clock" does
> nothing removing "EEPROM reader" changes to:
> Mar 13 22:12:54 ubuntu kernel: [   45.365457] input: PC Speaker
> as /class/input/input2
> Mar 13 22:12:54 ubuntu kernel: [   45.368197] i2c /dev entries driver
> Mar 13 22:12:54 ubuntu kernel: [   61.957048] rtc8564: cant init ctrl1
> Mar 13 22:12:54 ubuntu kernel: [   61.997032]  : Detection failed at step 3
> Mar 13 22:12:54 ubuntu kernel: [   62.132994] hdaps: supported laptop not
> found!
> Mar 13 22:12:54 ubuntu kernel: [   62.135578] hdaps: driver init failed
> (ret=-6)!
>
> Removing "Philips PCF8574 and PCF8574A" and "Philips PCF8591" (and "Epson
> 8564 RTC chip" because of the previous error message) so no more anything
> in "Miscellaneous I2C Chip support" and just the "VIA 82C586B" in "I2C
> Hardware Bus support", I get:
>
> Mar 13 22:21:42 ubuntu kernel: [   72.252791] input: PC Speaker
> as /class/input/input2
> Mar 13 22:21:42 ubuntu kernel: [   72.255555] i2c /dev entries driver
> Mar 13 22:21:42 ubuntu kernel: [   72.258868] hdaps: supported laptop
> not found!
> Mar 13 22:21:42 ubuntu kernel: [   72.261560] hdaps: driver init failed
> (ret=-6)!
>
> Adding (embedded centric) drivers for (embedded centric) company which
> respect international copyright regulations (and so the GPL) is OK; but
> not if that delays so much booting...

You should continue your hunting session in Device drivers > Hardware
Monitoring support. Many of these drivers are for i2c chips, which are
sometimes hard to detect, so we do a lot of probes at load time. I guess
that you have them all built into your kernel, which is bad idea. You
really should only include the ones your embedded systems have a chance
to ever include. Your big boot delay is most certainly caused by these
in combination of the i2c-parport-light bus driver.

When loading an i2c chip driver, the driver will scan all available i2c
busses, and on each bus it'll probe all addresses where the chip could
be. If you have some stuck i2c bus (which happens when using drivers
like i2c-parport-light or i2c-pca-isa when you don't have the
hardware), the probing on these i2c busses will be *very* slow (you have
to wait for the timeout on every transaction). So if you include each
and every hardware monitoring driver into your kernel, many of which are
i2c chip drivers, you end up with lots of probes done at boot time and
this takes a lot of time.

So, if modules are not an option, you really should discard all hardware
monitoring drivers you know you won't need (the sensors-detect script
can tell you which drivers you need).

That being said, the key problem being stuck i2c busses, it's even more
important to get rid of these. You can use "i2cdetect -l" to list all
detected i2c bus, so you'll see if you have any unwanted bus left. If
you do, you'll have to find out where the drivers hide in the
configuration menu, and unselect them.

Hope that helps,
--
Jean Delvare
