Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754540AbWKHLsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbWKHLsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754541AbWKHLsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:48:45 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:31204 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1754540AbWKHLso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:48:44 -0500
Date: Wed, 8 Nov 2006 12:48:23 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Brownell <david-b@pacbell.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, andrew@sanpeople.com
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Message-ID: <20061108124823.308ae3b4@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	<20061107122715.3022da2f@cad-250-152.norway.atmel.com>
	<20061107131014.535ab280.akpm@osdl.org>
	<20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2006 14:37:41 -0800
David Brownell <david-b@pacbell.net> wrote:
> On Tue, 7 Nov 2006 13:10:14 -0800
> quoth Andrew Morton <akpm@osdl.org>:
> > +EXPORT_SYMBOL(request_gpio);
> > +EXPORT_SYMBOL(free_gpio);
> 
> Well, those are clearly not *prefixed* with gpio_ ... :)

Heh, right. I guess I was thinking about request_irq/free_irq when I
chose those names. I'll change them.

> > +EXPORT_SYMBOL(gpio_set_value);
> > +EXPORT_SYMBOL(gpio_get_value);
> > +EXPORT_SYMBOL(gpio_set_output_enable);
> > +EXPORT_SYMBOL(gpio_set_pullup_enable);
> >
> > I wonder about this naming choice.  I'd have though that if/when
> > the kernel gets a generic GPIO driver or layer, these
> > avr32-specific symbols will need renaming.
> 
> I'd rather just see a "convention".  In some important cases, these
> calls should map to a handful of instructions to read or write chip
> registers. Talking about a "driver" or "layer" implies hundreds of
> instructions, which means people _will_ regularly need to bypass it
> for bitbanging.

Exactly. If we can decide on what the prototypes should look like and
which header they should be in, the architecture is free to implement
it any way it chooses. If speed is more important than
chip-independence, they can even be inlines accessing the hardware
directly.

> A convention for how to package those features would make sense, if
> for no other reason than to avoid "how does _this_ platform do it?"
> confusion. Most code touching GPIOs is platform-specific, but maybe
> not all of it... I can see it including:

The SPI driver in this series is an example of an at least somewhat
platform-independent driver touching GPIOs. MMC and CompactFlash drivers
also come to mind.

>     - GPIOs are identified by platform-specific unsigned integers;
>       in the range 0..INT_MAX (i.e. "negative" means
> reserved/invalid).
> 
>     - "#include <asm/arch/gpio.h>" (or <asm/gpio.h> ?) providing these
>       calls, which may be used from IRQ handlers:

Should probably be <asm/gpio.h> since not all arches actually have an
asm/arch directory. Nothing wrong with <asm/gpio.h> including
<asm/arch/gpio.h> though...

> 	* int gpio_get_value(unsigned gpio)
> 	    ... returning 0, 1, or negative errno (for invalid gpio)
> 	* int gpio_set_value(unsigned gpio, int is_set)
> 	    ... returning 0 or negative errno (for invalid gpio)
> 	* int gpio_set_direction(unsigned gpio, int is_in /* or
> is_out? */) ... returning 0 or negative errno (for invalid gpio)

I think set_output_enable makes more sense, but maybe it's just me.

> 	* int gpio_request(unsigned gpio)
> 	    ... returning 0 or negative errno (for invalid gpio or
> "busy")
> 	* int gpio_free(unsigned gpio)
> 	    ... returning 0 or negative errno (for invalid gpio)
> 	* and platform-specific additional mechanisms.
> 	    ... like open-drain drive modes, ganged get/set, etc
> 
> That should work OK for AVR32 (by demonstration!)

Definitely.

> and many ARMs
> (including OMAP, AT91, PXA, DaVinci, and more).  So well that
> providing those calls as inlined wrappers around existing calls would
> be trivial!

Yes, it looks to me that most platforms do basically the same thing
with different names.

> But it wouldn't handle the other common case of chips -- like a
> pcf8574 I2C gpio expander -- providing GPIO-like functionality
> through message passing infrastructure.  They might need a similar
> API; extgpio_*() maybe.  And the common case of "use GPIO N as an
> IRQ" merits thought too (for both "real" GPIOs and external ones like
> that pcf8574).

Handling chips like this would need some rethinking as they can be
added dynamically, so static pin numbers won't do. Handling this could
perhaps complicate the API enough to prevent people from adopting it...

> But pullups are not just a GPIO thing; they're a pin configuration
> thing (even on AT91 and AVR32) that can apply even if the pin is not
> usable as a GPIO (e.g. as on some non-Atmel platforms).  So that
> stuff certainly does not belong in generic infrastructure.

But maybe it could be done as part of the gpio_request() call, if we
specify an additional `flags' parameter? gpio_request() needs to know
about pin configuration anyway, as it needs to set up the pin for gpio.

> > h8300 uses h8300_free_gpio(), and there's also omap_free_gpio().
> > Perhaps this patch should have added avr32_free_gpio()?
> 
> If the parameters are the same -- GPIO IDs, unsigned integers with
> platforms-specific semantics -- I don't see much of a point in
> requiring a platform-specific convention for naming those functions.

I'll make a few adjustments to the avr32 api to make it conform with
your proposed api, as well as rename portmux_select_peripheral to
at32_select_peripheral (since it was never really intended to be
platform-independent).

Then I'll send a patch to do the same thing for at91, if Andrew V is ok
with it.

> But sticking to a consistent *prefix* convention would be healthy.
> Like gpio_request()/gpio_free(), as I stuck in the list above. :)

Point taken ;)

Haavard
