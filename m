Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753783AbWKGWhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbWKGWhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbWKGWhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:37:47 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:51616 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753783AbWKGWhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:37:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=1Lr2KBKgduXAm2MJ2jO8gW+Inlaz2d+hH2CcFZaBgDY3oLm8Hg8XK86/4FWP+l+jqgcP4shibWZ8CKbj4U/wA40Qej0DasVrlMIYCIp6sv4UqmHz+asRw081WSgb3U2jNgO+HZSNhuIhIfxV4Rz7NAOGnwV8jgjg4LoGitj2/4U=  ;
Date: Tue, 07 Nov 2006 14:37:41 -0800
From: David Brownell <david-b@pacbell.net>
To: hskinnemoen@atmel.com, akpm@osdl.org
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Cc: linux-kernel@vger.kernel.org, andrew@sanpeople.com
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
 <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
 <20061107131014.535ab280.akpm@osdl.org>
In-Reply-To: <20061107131014.535ab280.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 13:10:14 -0800
quoth Andrew Morton <akpm@osdl.org>:
>
> On Tue, 7 Nov 2006 12:27:15 +0100
> Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
>
> > Add a simple GPIO framework for AVR32. This should be fairly similar
> > to the AT91 GPIO API, but there are still a couple of differences:
> > 
> >   * Naming. We prefix all functions with gpio_ instead of at91_
> >   * request_gpio() and free_gpio() should be called to make sure
> >     the required pins are available, but it will still work if you
> >     don't.
>
> +EXPORT_SYMBOL(request_gpio);
> +EXPORT_SYMBOL(free_gpio);

Well, those are clearly not *prefixed* with gpio_ ... :)


> +EXPORT_SYMBOL(gpio_set_value);
> +EXPORT_SYMBOL(gpio_get_value);
> +EXPORT_SYMBOL(gpio_set_output_enable);
> +EXPORT_SYMBOL(gpio_set_pullup_enable);
>
> I wonder about this naming choice.  I'd have though that if/when the kernel
> gets a generic GPIO driver or layer, these avr32-specific symbols will need
> renaming.

I'd rather just see a "convention".  In some important cases, these calls
should map to a handful of instructions to read or write chip registers.
Talking about a "driver" or "layer" implies hundreds of instructions,
which means people _will_ regularly need to bypass it for bitbanging.

A convention for how to package those features would make sense, if for
no other reason than to avoid "how does _this_ platform do it?" confusion.
Most code touching GPIOs is platform-specific, but maybe not all of it...
I can see it including:

    - GPIOs are identified by platform-specific unsigned integers;
      in the range 0..INT_MAX (i.e. "negative" means reserved/invalid).

    - "#include <asm/arch/gpio.h>" (or <asm/gpio.h> ?) providing these
      calls, which may be used from IRQ handlers:

	* int gpio_get_value(unsigned gpio)
	    ... returning 0, 1, or negative errno (for invalid gpio)
	* int gpio_set_value(unsigned gpio, int is_set)
	    ... returning 0 or negative errno (for invalid gpio)
	* int gpio_set_direction(unsigned gpio, int is_in /* or is_out? */)
	    ... returning 0 or negative errno (for invalid gpio)
	* int gpio_request(unsigned gpio)
	    ... returning 0 or negative errno (for invalid gpio or "busy")
	* int gpio_free(unsigned gpio)
	    ... returning 0 or negative errno (for invalid gpio)
	* and platform-specific additional mechanisms.
	    ... like open-drain drive modes, ganged get/set, etc

That should work OK for AVR32 (by demonstration!) and many ARMs (including
OMAP, AT91, PXA, DaVinci, and more).  So well that providing those calls as
inlined wrappers around existing calls would be trivial!

But it wouldn't handle the other common case of chips -- like a pcf8574 I2C
gpio expander -- providing GPIO-like functionality through message passing
infrastructure.  They might need a similar API; extgpio_*() maybe.  And
the common case of "use GPIO N as an IRQ" merits thought too (for both
"real" GPIOs and external ones like that pcf8574).


But pullups are not just a GPIO thing; they're a pin configuration thing
(even on AT91 and AVR32) that can apply even if the pin is not usable as
a GPIO (e.g. as on some non-Atmel platforms).  So that stuff certainly
does not belong in generic infrastructure.


> h8300 uses h8300_free_gpio(), and there's also omap_free_gpio().  Perhaps
> this patch should have added avr32_free_gpio()?

If the parameters are the same -- GPIO IDs, unsigned integers with
platforms-specific semantics -- I don't see much of a point in
requiring a platform-specific convention for naming those functions.

But sticking to a consistent *prefix* convention would be healthy.
Like gpio_request()/gpio_free(), as I stuck in the list above. :)

- Dave

