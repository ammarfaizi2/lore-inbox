Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966462AbWKTWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966462AbWKTWQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966373AbWKTWQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:16:12 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:40535 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966866AbWKTWPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=F9f9s4J2rZuwLtQsmdCCbeap4QfMm4rb9t5ssgHs8V3Gjw8GymOfRV+aVPNIrkHMF+BxV8soJC2dVYaYPujpcOuIGFgdgeRhxVbR5wRVtkaeD06PYZ+SwXwS7ia1o4dnlxho+elVn9u430FX5aLseRj0zjkfe+xvGoOCW3uqpNM=  ;
X-YMail-OSG: _Z8X3sYVM1lmVZbLA2KmV2aHacFAkqEQFkacRNsmYlAARQpUKJ9rL_XOZpPLjQSTA_xlm9Qz7ozoBqYZjEgT1Xoh9kTyiTncgnodXsYe6CdlmvRWJTjXmpYwFCkLrW_oWZciJHxwRafU71G2XPXa4GABpCMi6ZT96v8-
From: David Brownell <david-b@pacbell.net>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation
Date: Mon, 20 Nov 2006 13:47:08 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <20061116155455.3833f3a4@cad-250-152.norway.atmel.com>
In-Reply-To: <20061116155455.3833f3a4@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201347.10331.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 6:54 am, Haavard Skinnemoen wrote:
> On Sat, 11 Nov 2006 15:41:32 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > Below, find what I think is a useful proposal, trivially
> > implementable on many ARMs (at91, omap, pxa, ep93xx, ixp2000,
> > pnx4008, davinci, more) as well as the new AVR32.
> 
> FYI, here's the AVR32 implementation of the API you propose. Thanks for
> writing this up, Dave.
> 
> I'm still not sure about how to implement the
> gpio_request()/gpio_free() calls, though.

Simplest would be to manipulate a bitmask:

  gpio_request() --> return test_and_set_bit(...) ? -EBUSY : 0;
  gpio_free() --> clear_bit(...)

Or if you want to track the identifiers and provide a debugfs dump
of the active GPIOs and their status, use an array of strings (and
spinlock its updates) or nuls as "fat bits", instead of a bit array.  


> Since they're not supposed to 
> do any port configuration, I think I might convert them to no-ops and
> do the allocation (and warn about conflicts) when configuring the port
> multiplexer.

What they're supposed to do is report conflicts between two
drivers which both think they own the GPIO ... as errors.

That's different from pin mux setup, which for most embedded
systems is just making sure the SOC is configured to match
what Linux expects.  The boot loader usualy does some of that,
but it's probably not validated to do more than reliably boot
an operating system ... so pin muxing can't realistically
report anything as an error.  At best, it's a suggestion to
update the bootloader someday.


>	 Since the pin will be configured for one particular usage, 
> having multiple drivers try to use it will cause problems and handing
> it out to the first driver that comes along will not really solve
> anything...

No, but letting the second one report the fatal error is a big help.
And heck, you've got reasonable chance the first driver will work,
if the second doesn't interfere with it!  (Or maybe it's the other
way around.  At least you'd have logged a fatal error message ...)

 
> Of course, if other arches want gpio_request()/gpio_free(), I'm all for
> keeping them.

I thought you were someone who _wanted_ this mechanism?
Or were you instead thinking of a pin mux mechanism?

There can be no arch-neutral pin muxing that takes just
a GPIO number as input (which is how gpio_request works).
The reason is that there are platforms which need muxing,
and which have multiple options as to which pin a given
GPIO goes out on (and contrariwise, which GPIO is coupled
to a given pin). 


> +int gpio_request(unsigned int gpio, const char *label)
> +{
> +	struct pio_device *pio;
> +	unsigned int pin;
> +
> +	pio = gpio_to_pio(gpio);
> +	if (!pio)
> +		return -ENODEV;
> +
> +	pin = gpio & 0x1f;
> +	if (test_and_set_bit(pin, &pio->alloc_mask))
> +		return -EBUSY;
> +
> +	pio_writel(pio, PER, 1 << pin);

Enabling the pin as a GPIO is a pin mux responsibility, not
a "keep drivers from stepping all over each other" thing.

Admittedly, the GPIO controller in those Atmel chips (AVR32,
AT91) does have a one-to-one mapping for muxable pins and GPIOs,
but that's not a portable notion.


> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(gpio_request);
> +
> +void gpio_free(unsigned int gpio)
> +{
> +	struct pio_device *pio;
> +	unsigned int pin;
> +
> +	pio = gpio_to_pio(gpio);
> +	BUG_ON(!pio);

Don't use BUG_ON in new code ... in this case it'd be best to just
warn and return.  Notice by the way that this isn't an inverse of
the gpio_request(), since you aren't taking the pin back from the
GPIO controller.




> +#define GPIO_PIOA_BASE	(0)
> +#define GPIO_PIN_PA0	(GPIO_PIOA_BASE +  0)
> +#define GPIO_PIN_PA1	(GPIO_PIOA_BASE +  1)
> +#define GPIO_PIN_PA2	(GPIO_PIOA_BASE +  2)
> ...

Someone had the suggestion to reduce the number of #defines
by doing someting like

  #define GPIO_PIN_PA(N) (GPIO_PIOA_BASE + (N))
  #define GPIO_PIN_PB(N) (GPIO_PIOB_BASE + (N))
  #define GPIO_PIN_PC(N) (GPIO_PIOC_BASE + (N))
  #define GPIO_PIN_PD(N) (GPIO_PIOD_BASE + (N))

I kind of like that, even if it's not such a direct match to
Atmel's documentation.


> --- /dev/null
> +++ b/include/asm-avr32/arch-at32ap/gpio.h
> @@ -0,0 +1,25 @@
> +#ifndef __ASM_AVR32_GPIO_H
> +#define __ASM_AVR32_GPIO_H
> +
> +#include <linux/compiler.h>
> +#include <asm/irq.h>
> +
> +int __must_check gpio_request(unsigned int gpio, const char *label);
> +void gpio_free(unsigned int gpio);
> +
> +int gpio_direction_input(unsigned int gpio);
> +int gpio_direction_output(unsigned int gpio);
> +int gpio_get_value(unsigned int gpio);
> +void gpio_set_value(unsigned int gpio, int value);
> +
> +static inline int gpio_to_irq(unsigned int gpio)
> +{
> +	return gpio + GPIO_IRQ_BASE;
> +}
> +
> +static inline int irq_to_gpio(unsigned int irq)
> +{
> +	return irq - GPIO_IRQ_BASE;
> +}
> +
> +#endif /* __ASM_AVR32_GPIO_H */

Aren't you going to want to add AVR-specific extensions so that
drivers (or more typically, board init code) can manage pullups
and input de-glitching?

- Dave

