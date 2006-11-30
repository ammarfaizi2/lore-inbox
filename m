Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967853AbWK3TOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967853AbWK3TOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967855AbWK3TOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:14:14 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:23426 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S967853AbWK3TON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:14:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=VM9ObvdkJZFLvhLvtd6CY5n4jDRmGYRHsXDhzEGUBNfULAvoawaNPYhhLK9rfeR1Vj7d2qu03i8pWdOLhlnF5x5VnSRUsmkmTC+y/0dyXYAzjTSb5BsNygex76laQcuVn6fOmU50Q4ahTjQ6nsABY3TnURYKDu/ooiWLfuWmEVY=  ;
X-YMail-OSG: 4nCWydUVM1myPmtwQ69wab8noHslRqro.bTF.G6MQJ8oJSxAcAeZZyu2FD4ZeymbtOUK6YvaFEnzIH2xrNw5uLSnjnVz8pEX1ZIg7puPpj9j7ycBoV7UpQ--
From: David Brownell <david-b@pacbell.net>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation [take 2]
Date: Thu, 30 Nov 2006 11:05:00 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611211103.43757.david-b@pacbell.net> <20061128133618.0e6932fc@dhcp-252-105.norway.atmel.com>
In-Reply-To: <20061128133618.0e6932fc@dhcp-252-105.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301105.01108.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 November 2006 4:36 am, Haavard Skinnemoen wrote:
> Here's another go at an implementation of the arch-neutral GPIO API for
> AVR32. I've also thrown in the pin configuration stuff so that you can
> see how all the pieces fit together.

That looks good, but it was probably better in a "portmux.h" header.
(Although the at32_* prefixes help a lot!)  You don't use the flags
AT32_GPIO_PULLUP etc, either.

Other than that pinmux confusion, this looks pretty much OK to me.
The GPIO stuff matches the proposal.


> Even though it is possible to tell from the hardware whether a pin is
> set up for GPIO, I decided to use two allocation bitmasks per pio
> controller to keep track of what the pins are used for: pinmux_mask and
> gpio_mask.
> 
> pinmux_mask indicates which pins have been configured for usage either
> by a peripheral or GPIO. If the corresponding bit is set when trying to
> configure a pin, a warning will be printed along with a stack dump (no
> BUG anymore.)

That is, pins without that set are still configured how the bootloader
left them ... possibly as they were left by system reset.  On some systems
it might be desirable to warn when the mode Linux wants isn't what the
bootloader left, so that all the muxing code can be left out of Linux.
(Not that it can save much on AT91 or AVR32, but the bootloader was probably
writing those registers anyway, and saving codespace and boot time tends
to be a Good Thing.)  Or so that Linux can't, oh, change the state of
the GPIO that keeps the saw switched off.  ;)

I notice you didn't have a way to return pins to an "unclaimed" state
though, which would probably be disadvantageous in some cases.  I don't
agree with the arguments made by Paul Mundt that such usage would be a
common thing ... but on the other hand, I bet you'd get complaints from
various folk if you make re-muxing excessively painful.


> gpio_mask indicates which pins are available for GPIO. It starts out as
> all ones, and whenever a pin is configured for GPIO, the corresponding
> bit is cleared. gpio_request() test_and_set()s a bit in the mask
> corresponding to the pin being requested, and if it's already set
> (either because it hasn't been configured or because it's been
> requested by a different driver), gpio_request() returns an error value.

Sounds OK.  You are thus _requiring_ the pin muxing to have been
done before the gpio pin is requested ... sort of complicates the
"Linux uses bootloader's pin muxing" model.


> The pin configuration API is AVR32-specific for now.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> ---
>  arch/avr32/mach-at32ap/at32ap7000.c        |  144 ++++++++++-----------
>  arch/avr32/mach-at32ap/pio.c               |  186 ++++++++++++++++++++++++++--
>  include/asm-avr32/arch-at32ap/at32ap7000.h |   26 ++++
>  include/asm-avr32/arch-at32ap/gpio.h       |   39 ++++++
>  include/asm-avr32/arch-at32ap/irq.h        |   11 ++
>  include/asm-avr32/arch-at32ap/portmux.h    |   16 ---
>  include/asm-avr32/gpio.h                   |    6 +
>  include/asm-avr32/irq.h                    |    8 +-
>  8 files changed, 333 insertions(+), 103 deletions(-)
> 

> @@ -569,26 +561,26 @@ DEV_CLK(usart, atmel_usart3, pba, 6);
>  
>  static inline void configure_usart0_pins(void)
>  {
> -	portmux_set_func(PIOA,  8, FUNC_B);	/* RXD	*/
> -	portmux_set_func(PIOA,  9, FUNC_B);	/* TXD	*/
> +	select_peripheral(PA(8), PERIPH_B, 0);	/* RXD	*/
> +	select_peripheral(PA(9), PERIPH_B, 0);	/* TXD	*/

A constant like PULLUP_OFF would be clearer in these cases.


> +void __init at32_select_periph(unsigned int pin, unsigned int periph,
> +			       int use_pullup)

Declared as "flags" elsewhere, not "use_pullup"...


> +void __init at32_select_gpio(unsigned int pin, int enable_output,
> +			     int use_pullup)


> +/*
> + * Set up pin multiplexing, called from board init only.
> + *
> + * The following flags determine the initial state of the pin.
> + */
> +#define AT32_GPIOF_PULLUP	0x00000001	/* Enable pull-up */
> +#define AT32_GPIOF_OUTPUT	0x00000002	/* Enable output driver */
> +#define AT32_GPIOF_HIGH		0x00000004	/* Set output high */
> +
> +void at32_select_periph(unsigned int pin, unsigned int periph,
> +			unsigned long flags);
> +void at32_select_gpio(unsigned int pin, unsigned long flags);
