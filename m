Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbVKCPi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVKCPi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVKCPi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:38:58 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:11451 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030346AbVKCPi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:38:57 -0500
From: David Brownell <david-b@pacbell.net>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [RFC] The driver model, I2C and gpio provision on Sharp SL-C1000 (Akita)
Date: Thu, 3 Nov 2005 07:38:53 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200511022306.48405.david-b@pacbell.net> <1131008844.8523.35.camel@localhost.localdomain>
In-Reply-To: <1131008844.8523.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511030738.53844.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 1:07 am, Richard Purdie wrote:
> 
> Its not as simple as this in my case. Yes, you can patch the maxim i2c
> driver and the pxa i2c controller to run at subsys_initcall level which
> is fine. akita-ioexp has to run at a higher level (fs_initcall) as it
> will run before the i2c subsystem (being in arch as against drivers).

The general policy is that the "arch" directories shouldn't have drivers;
they should live in the "drivers" directories.  Then there are still issues
of how board-specific code should be handled; hooking via platform_data
doesn't quite solve all the important cases.

And of course I2C doesn't even support platform_data for board-specific data.
Which means that adding board-specific code to I2C drivers is all but inevitable.
(Or in the extreme, making drivers board-specific not general-purpose.)


> I'd like to keep the device tree correct, then if anyone does want to
> selectively suspend things, it will work and it also works if someone
> decides to change the device init order around at some later date and
> not everything will break.

Don't assume that the device tree _model_ is ready to handle selective
suspend yet.  For one thing, the pm_parent mechanism is unusable, and
that was originally intended to be the way to handle exceptions like
these (where the "control tree" doesn't match the "power tree", or
however you want to describe it).

I expect that by the time selective suspend is generally usable, the
driver model support for it will have evolved substantially.  In any
case, it's not worth too much effort just now to try and make it work.


> I'm coming to the view that I should merge the max7310 i2c driver into
> akita-ioexp and lose the general case driver for the following reasons:
> 
> 1. Having a header file around for two functions seems excessive and I
> can't see any alternative

I'd have said that for the tps6501x, but its header now exports
more like seven functions.  Only a few are for GPIOs; and that
doesn't even handle (yet!) the various IRQ sources!

A general purpose driver for max7310 (and similar I2C GPIO chips)
should handle IRQs from input pins, too.


> 2. The MAX7310 has 56 different i2c addresses and no way of detecting
> the presence of the chip. Autoprobing on akita means you end up with the
> sound codec being taken by the max7310 driver. I don't like to think
> what it would do on other systems.

IMO this is a general problem with the I2C framework.  It should be
possible for board-specific init logic to (a) declare what devices
exist, (b) what drivers they'll use, and (c) provide platform_data
specific to that device, which could include board-specific callbacks.

The closest I think you can come now is to provide driver options
on the kernel command line, like max7310.force, instead of trying
to probe those way-too-many addresses.  That can handle (a) and (b)
but not (c); and it's an awkward way to handle static config data.

A related solution is for the driver init code to patch the i2c probe
table based on what board is present (machine_is_akita etc) before
registering that I2C driver.  That's less error prone than relying
on command line parameters.  And again, that ignores (c).


> 3. There's no interdependency between two drivers and hence it should be
> more robust.
> 4. I can lose the workqueue "find the i2c client" routine as the driver
> can know when the i2c device has been detected and the client setup.

Yeah, the max7310 probe() could benefit from platform data holding a callback
used to register a handle to that chip.  The workqueue wouldn't be needed
since the callback could just provide the right device.


> (the workqueue is still needed to act on gpio requests in case they come
> from interrupt context but the driver becomes simpler and of a more sane
> design).

The TPS6501x driver currently just uses keventd rather than a dedicated
workqueue.  But again, this is a general problem in the I2C framework;
if it had an asynch message model with completion callbacks, it'd be
easy to issue requests from irq contexts, and task-synchronous calls could
just use "struct completion" to wait for the callback.


That SPI framework code I did was specifically paying attention to those
driver (and I/O) model issues, so it doesn't have the same glitches.
The core I/O model is asynchronous, and board-specific code can provice
platform_data and other hooks that'll kick in on device creation.  I'd
hope that once that all shakes out, the I2C stack can start to adopt the
same sort of fixes.

- Dave



> Richard
> 
