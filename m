Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759292AbWLAJwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759292AbWLAJwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759293AbWLAJwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:52:00 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:1246 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1759292AbWLAJv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:51:59 -0500
Date: Fri, 1 Dec 2006 10:51:40 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation [take
 2]
Message-ID: <20061201105140.513fe5ac@dhcp-252-105.norway.atmel.com>
In-Reply-To: <200611301105.01108.david-b@pacbell.net>
References: <200611111541.34699.david-b@pacbell.net>
	<200611211103.43757.david-b@pacbell.net>
	<20061128133618.0e6932fc@dhcp-252-105.norway.atmel.com>
	<200611301105.01108.david-b@pacbell.net>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 11:05:00 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Tuesday 28 November 2006 4:36 am, Haavard Skinnemoen wrote:
> > Here's another go at an implementation of the arch-neutral GPIO API
> > for AVR32. I've also thrown in the pin configuration stuff so that
> > you can see how all the pieces fit together.
> 
> That looks good, but it was probably better in a "portmux.h" header.
> (Although the at32_* prefixes help a lot!)  You don't use the flags
> AT32_GPIO_PULLUP etc, either.

Indeed, seems like I forgot to actually use those flags. The idea is
that the pinmux configuration functions set up the initial pin state to
avoid any toggling or floating before they are fully configured. This is
how I intended to use them in at32_select_gpio():

	pio_writel(pio, PUER, mask);
	if (flags & AT32_GPIOF_HIGH)
		pio_writel(pio, SODR, mask);
	else
		pio_writel(pio, CODR, mask);
	if (flags & AT32_GPIOF_OUTPUT)
		pio_writel(pio, OER, mask);
	else
		pio_writel(pio, ODR, mask);

	pio_writel(pio, PER, mask);
	if (!(flags & AT32_GPIOF_PULLUP))
		pio_writel(pio, PUDR, mask);

	/* It's now allowed to use request_gpio on this pin */
	clear_bit(pin_index, &pio->gpio_mask);

> Other than that pinmux confusion, this looks pretty much OK to me.
> The GPIO stuff matches the proposal.

That's good to hear.

> > Even though it is possible to tell from the hardware whether a pin
> > is set up for GPIO, I decided to use two allocation bitmasks per pio
> > controller to keep track of what the pins are used for: pinmux_mask
> > and gpio_mask.
> > 
> > pinmux_mask indicates which pins have been configured for usage
> > either by a peripheral or GPIO. If the corresponding bit is set
> > when trying to configure a pin, a warning will be printed along
> > with a stack dump (no BUG anymore.)
> 
> That is, pins without that set are still configured how the bootloader
> left them ... possibly as they were left by system reset.  On some
> systems it might be desirable to warn when the mode Linux wants isn't
> what the bootloader left, so that all the muxing code can be left out
> of Linux. (Not that it can save much on AT91 or AVR32, but the
> bootloader was probably writing those registers anyway, and saving
> codespace and boot time tends to be a Good Thing.)  Or so that Linux
> can't, oh, change the state of the GPIO that keeps the saw switched
> off.  ;)

I always figured it's best to start from a clean slate and not depend
on the bootloader to set up things the way Linux wants it. If there's
a saw connected, the board code better make sure that it stays switched
off (which should be easy to do using the "initial state" flags
mentioned above.)

> I notice you didn't have a way to return pins to an "unclaimed" state
> though, which would probably be disadvantageous in some cases.  I
> don't agree with the arguments made by Paul Mundt that such usage
> would be a common thing ... but on the other hand, I bet you'd get
> complaints from various folk if you make re-muxing excessively
> painful.

I'll add functions for "unclaiming" pins whenever someone complains,
ok? I don't want to add functions that aren't going to be used any time
soon, and unclaiming pins probably won't be enough -- we need a
mechanism to tell the driver for the device using those pins to
deinitialize itself as well.

> > gpio_mask indicates which pins are available for GPIO. It starts
> > out as all ones, and whenever a pin is configured for GPIO, the
> > corresponding bit is cleared. gpio_request() test_and_set()s a bit
> > in the mask corresponding to the pin being requested, and if it's
> > already set (either because it hasn't been configured or because
> > it's been requested by a different driver), gpio_request() returns
> > an error value.
> 
> Sounds OK.  You are thus _requiring_ the pin muxing to have been
> done before the gpio pin is requested ... sort of complicates the
> "Linux uses bootloader's pin muxing" model.

Right. I never really thought much about that model, but I imagine
we'll have to make sure the bootloader sets up a sane configuration
before we start depending on it. So I'd rather keep this requirement at
least for now.

If we decide to move the pin muxing responsibility to the bootloader, I
think we need a transitional phase where Linux sanity-checks the
configuration and warns (and possibly fixes up) the PIO if it's not set
up as expected.

> >  static inline void configure_usart0_pins(void)
> >  {
> > -	portmux_set_func(PIOA,  8, FUNC_B);	/* RXD	*/
> > -	portmux_set_func(PIOA,  9, FUNC_B);	/* TXD	*/
> > +	select_peripheral(PA(8), PERIPH_B, 0);	/*
> > RXD	*/
> > +	select_peripheral(PA(9), PERIPH_B, 0);	/*
> > TXD	*/
> 
> A constant like PULLUP_OFF would be clearer in these cases.

Yeah, but I really want to fit everything on a single line. I'll see if
I can spare some room for it.

Although...there are several flags that can be set here. Should I
define OUTPUT_OFF and LOW as well? I sort of think it makes sense to
specify "0" as "nothing special".

> > +void __init at32_select_periph(unsigned int pin, unsigned int
> > periph,
> > +			       int use_pullup)
> 
> Declared as "flags" elsewhere, not "use_pullup"...

Right. I messed up the header guards, so gcc didn't warm me that the
definitions were different from the declarations. I guess I should start
building stuff with -Wmissing-prototypes to catch mistakes like this.
The declarations in gpio.h are the correct ones.

Anyway, I obviously agree with your plan to get the GPIO API merged
into mainline. I'll fix this patch and submit one for AT91 as well.

Haavard
