Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbVKDAl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbVKDAl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbVKDAl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:41:27 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:28847 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1161006AbVKDAl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:41:27 -0500
Message-ID: <436AAE32.5080108@stesmi.com>
Date: Fri, 04 Nov 2005 01:41:22 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: John Lenz <lenz@cs.wisc.edu>, Robert Schwebel <robert@schwebel.de>,
       Robert Schwebel <r.schwebel@pengutronix.de>, vojtech@suse.cz,
       rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: best way to handle LEDs
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de> <38523.192.168.0.12.1130986361.squirrel@192.168.0.2> <20051103081522.GA21663@flint.arm.linux.org.uk> <20051103095725.GA703@openzaurus.ucw.cz> <20051103144904.GG28038@flint.arm.linux.org.uk> <20051103163532.GC24846@elf.ucw.cz>
In-Reply-To: <20051103163532.GC24846@elf.ucw.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
> Hi!
> 
> 
>>>>>Except the led code that is being proposed CAN sit on top of a generic
>>>>>GPIO layer.
>>>>
>>>>I also have issues with a generic GPIO layer.  As I mentioned in the
>>>>past, there's serious locking issues with any generic abstraction of
>>>>GPIOs.
>>>>
>>>>1. You want to be able to change GPIO state from interrupts.  This
>>>>   implies you can not sleep in GPIO state changing functions.
>>>>
>>>>2. Some GPIOs are implemented on I2C devices.  This means that to
>>>>   change state, you must sleep.
>>>
>>>Can't you just busywait? Yes, it is ugly in general, but perhaps it
>>>is better than alternatives...
>>
>>Does the i2c layer support busy waiting or are you suggesting something
>>else?
> 
> 
> I'm suggesting that adding busy wait support to i2c is probably good
> idea. GPIOs are on many small machines, and there are machine
> (spitz/akita?) that differ mainly in "where GPIO lines are
> connected". That cries for GPIO layer.
> 							Pavel

Wouldn't it make sense to make either two register functions or one
that takes an extra argument?

register_led(.., .., ..)
and
register_led_irq(.., .., ..)
?

Then register_led() will call register_gpio() and
register_led_irq() will call register_gpio_irq().

If the low level driver (and everything else) can't
be put into busywaiting mode the register_gpio_irq()
will fail which will make register_led_irq() fail.

Naturally it can be
register_led(.., .., ..., use_irq)
and
register_gpio(.., .., .., use_irq)

I haven't looked at the API's so this is just theoretical
on my behalf, but it should solve some issues.

If a driver really really can't be busywait for some reason
then it will fail, otherwise it will switch to busywaiting
instead of sleeping.

Or am I just talking out of my ass?

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDaq4yBrn2kJu9P78RAuh7AJ4wK/+xoMYyfdOXEtY0+LqMNxYuuACgtuDH
GhjBeXxbnW2SaQ4x7hlZg6w=
=hl/m
-----END PGP SIGNATURE-----
