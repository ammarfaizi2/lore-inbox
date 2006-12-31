Return-Path: <linux-kernel-owner+w=401wt.eu-S1030437AbWLaTkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWLaTkj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 14:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWLaTkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 14:40:39 -0500
Received: from sitemail2.everyone.net ([216.200.145.36]:54235 "EHLO
	omta14.mta.everyone.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030437AbWLaTkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 14:40:39 -0500
X-Greylist: delayed 1737 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 14:40:38 EST
X-Eon-Dm: dm16
X-Eon-Sig: AQHOS7NFmAtsF8LSCgIAAAAC,95b92e3a4259f92c7b0f53a3f69bed68
Date: Sun, 31 Dec 2006 14:11:37 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.20-rc1 0/6] arch-neutral GPIO calls
Message-ID: <20061231191137.GA5290@double.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Based on earlier discussion, I'm sending a refresh of the generic GPIO
> patch, with several (ARM based) implementations in separate patches:

Hi Dave,

I'm very interested in seeing an abstraction for gpios.  Over the last
several months, I've been working on getting Linux running on my phone
- see www.handhelds.org for more information.  These types of ARM
based PDAs and phones are riddled with GPIOs, and there is frequent
code duplication when two machines have to do similar functionality
with different gpios.

Unfortunately, I fear the implementation you propose is not robust
enough to handle the cases I need to handle.  In particular, I think a
"struct gpio" instead of "int gpio" is needed to describe a gpio pin.

Some background - on the phone I use, it has the standard PXA27x
gpios, a gpio extender chip (egpio) which is connected via the memory
bus, and a micro-controller attached via an i2c like bus.  Other
phones will commonly have the PXA27x, "egpio", and an "asic3" chip.
With the sale of the PXA line, it seems Samsung and TI based ARM chips
(and their corresponding GPIOs) will be on the rise.

As you know, basic functionality like setting a LED, detecting a
button press, requesting an irq, etc. are common with GPIOs regardless
of which platform, or which gpio chip, is in use.

The concern I have with your current implementation is that I don't
see a way to flexibly add in support for additional gpio pins on a
machine by machine basis.  The code does do a good job of abstracting
gpios based on the primary architecture (eg, PXA vs OMAP), but not on
a chip basis (eg, PXA vs ASIC3).

Specifically, once the code pulls in "<asm/gpio.h>" it will get the
PXA gpio code, but this will only allow access to the arch gpios, not
the machine specific gpios.  Also, one of the goals of the developers
at handhelds.org is to have one kernel for many different phones --
from a userspace point of view they don't generally differ very much.
As such, this isn't a matter of just having each "machine" override
the gpio.h file at compile time; it really needs to be done at
runtime.

I understand that the existing code works entirely on integers.
However, I fear this is at attribute of the problem, not of the
solution.

> - Core patch, doc + <asm-arm/gpio.h> + <asm-generic/gpio.h>
> - OMAP implementation
> - AT91 implementation
> - PXA implementation
> - SA1100 implementation
> - S3C2410 implementation

Your patch clearly shows that the existing implementations are using
integers.  I think there is a simple way to reuse the existing
implementations.  For example on pxa one could do something like:

============= include/linux/gpio.h

struct gpio_ops {
        int (*gpio_direction_input)(struct *gpio);
        ...
};

struct gpio {
     struct gpio_ops *ops;
};

============= arch/arm/mach-pxa/gpio.c

struct gpio pxa_gpios[120] = {
        {.ops = pxa_gpio_ops}, ...
};

int pxa_gpio_direction_input(struct *gpio) {
        int pxa_gpio = gpio - pxa_gpios;
        pxa_gpio_mode(pxa_gpio | GPIO_IN);
        return 0;
}

...

> Other than clarifications, the main change in the doc is defining
> new calls safe for use with GPIOs on things like pcf8574 I2C gpio
> expanders; those new calls can sleep, but are otherwise the same as
> the spinlock-safe versions. The implementations above implement that
> as a wrapper (the asm-generic header) around the spinlock-safe calls.

As above, I'm confused how these expanders would work in practice.
The expanders would be present on a machine by machine basis but the
code seems to be implemented on an arch by arch basis.  Perhaps an
example would help me.

Please CC me on replies.

Cheers,
-Kevin
