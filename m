Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030770AbWKUJLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030770AbWKUJLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030771AbWKUJLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:11:19 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:48579 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030770AbWKUJLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:11:16 -0500
Date: Tue, 21 Nov 2006 10:11:03 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation
Message-ID: <20061121101103.47add0cf@dhcp-252-105.norway.atmel.com>
In-Reply-To: <200611201347.10331.david-b@pacbell.net>
References: <200611111541.34699.david-b@pacbell.net>
	<20061116155455.3833f3a4@cad-250-152.norway.atmel.com>
	<200611201347.10331.david-b@pacbell.net>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 13:47:08 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Thursday 16 November 2006 6:54 am, Haavard Skinnemoen wrote:

> > I'm still not sure about how to implement the
> > gpio_request()/gpio_free() calls, though.
> 
> Simplest would be to manipulate a bitmask:
> 
>   gpio_request() --> return test_and_set_bit(...) ? -EBUSY : 0;
>   gpio_free() --> clear_bit(...)

Yeah, I'm fine with this part.

> Or if you want to track the identifiers and provide a debugfs dump
> of the active GPIOs and their status, use an array of strings (and
> spinlock its updates) or nuls as "fat bits", instead of a bit array.  

Might be useful. Maybe we should add a "struct device" parameter to
gpio_request() as well, to allow platforms to associate pins with the
devices using them through sysfs? Or perhaps just to generate an
appropriate name (otherwise, each driver would have to generate a
unique string by themselves, for each device it controls.)

> > Since they're not supposed to 
> > do any port configuration, I think I might convert them to no-ops
> > and do the allocation (and warn about conflicts) when configuring
> > the port multiplexer.
> 
> What they're supposed to do is report conflicts between two
> drivers which both think they own the GPIO ... as errors.
> 
> That's different from pin mux setup, which for most embedded
> systems is just making sure the SOC is configured to match
> what Linux expects.  The boot loader usualy does some of that,
> but it's probably not validated to do more than reliably boot
> an operating system ... so pin muxing can't realistically
> report anything as an error.  At best, it's a suggestion to
> update the bootloader someday.

I think I understand now. I have to use separate bitmasks for GPIO and
port mux setup.

If gpio_request() could do port mux configuration, one bitmask would be
enough to trap all errors. But after reading the rest of this thread,
I think separating the gpio and portmux APIs is a good idea, so I'm not
going to try to do this. Although I might set a bit in both masks when
configuring a pin for peripheral I/O, just to indicate that it isn't
usable for gpio at all.

> >	 Since the pin will be configured for one particular usage, 
> > having multiple drivers try to use it will cause problems and
> > handing it out to the first driver that comes along will not really
> > solve anything...
> 
> No, but letting the second one report the fatal error is a big help.
> And heck, you've got reasonable chance the first driver will work,
> if the second doesn't interfere with it!  (Or maybe it's the other
> way around.  At least you'd have logged a fatal error message ...)

You're right.

> > Of course, if other arches want gpio_request()/gpio_free(), I'm all
> > for keeping them.
> 
> I thought you were someone who _wanted_ this mechanism?
> Or were you instead thinking of a pin mux mechanism?

Yes and yes ;)

Which is of course the source of all this confusion. I just had to
realize that the final definition of gpio_request was I little bit
different than I originally expected. This means that gpio_request() is
no longer _essential_ on avr32 (which corresponds nicely with its
classification as "optional" in your api proposal) but very nice to
have.

> > +int gpio_request(unsigned int gpio, const char *label)
> > +{
> > +	struct pio_device *pio;
> > +	unsigned int pin;
> > +
> > +	pio = gpio_to_pio(gpio);
> > +	if (!pio)
> > +		return -ENODEV;
> > +
> > +	pin = gpio & 0x1f;
> > +	if (test_and_set_bit(pin, &pio->alloc_mask))
> > +		return -EBUSY;
> > +
> > +	pio_writel(pio, PER, 1 << pin);
> 
> Enabling the pin as a GPIO is a pin mux responsibility, not
> a "keep drivers from stepping all over each other" thing.

Agreed. I'll change this.

> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(gpio_request);
> > +
> > +void gpio_free(unsigned int gpio)
> > +{
> > +	struct pio_device *pio;
> > +	unsigned int pin;
> > +
> > +	pio = gpio_to_pio(gpio);
> > +	BUG_ON(!pio);
> 
> Don't use BUG_ON in new code ... in this case it'd be best to just
> warn and return.  Notice by the way that this isn't an inverse of
> the gpio_request(), since you aren't taking the pin back from the
> GPIO controller.

Ok, I'll drop the BUG_ON(). There's really no way to take the pin back
from the GPIO controller, as "gpio" is just one of three states where
the other two assigns the pin to a specific peripheral. Leaving the pin
configured for gpio seemed the best solution.

But I'm going to remove the port configuration stuff anyway, so it
doesn't matter.

> > +#define GPIO_PIOA_BASE	(0)
> > +#define GPIO_PIN_PA0	(GPIO_PIOA_BASE +  0)
> > +#define GPIO_PIN_PA1	(GPIO_PIOA_BASE +  1)
> > +#define GPIO_PIN_PA2	(GPIO_PIOA_BASE +  2)
> > ...
> 
> Someone had the suggestion to reduce the number of #defines
> by doing someting like
> 
>   #define GPIO_PIN_PA(N) (GPIO_PIOA_BASE + (N))
>   #define GPIO_PIN_PB(N) (GPIO_PIOB_BASE + (N))
>   #define GPIO_PIN_PC(N) (GPIO_PIOC_BASE + (N))
>   #define GPIO_PIN_PD(N) (GPIO_PIOD_BASE + (N))
> 
> I kind of like that, even if it's not such a direct match to
> Atmel's documentation.

I kind of like it too. It's a direct enough match for me.

> Aren't you going to want to add AVR-specific extensions so that
> drivers (or more typically, board init code) can manage pullups
> and input de-glitching?

Yeah, I will definitely do that, but I thought that was supposed to be
part of the portmux api?

Haavard
