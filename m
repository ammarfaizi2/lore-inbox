Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754634AbWKHSBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbWKHSBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbWKHSBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:01:33 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:41867 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1754634AbWKHSBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:01:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=YDyv14nXrROFqduLvktAUcYIWpqRNGzLVhqLy+9okYQbKbkGSBS3S9YQ1C7oOBYc4iFrPayIuf2NDg/B5CXQjZhPXlNcKd3BaTLKbft+g5ButRR/drJnEbWVAL8wrSEwu3mF11YycLhZNArhrV8synpJsdCbRTB96iUAm3zMZaM=  ;
Date: Wed, 08 Nov 2006 10:00:59 -0800
From: David Brownell <david-b@pacbell.net>
To: hskinnemoen@atmel.com
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Cc: linux-kernel@vger.kernel.org, andrew@sanpeople.com, akpm@osdl.org
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
 <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
 <20061107131014.535ab280.akpm@osdl.org>
 <20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
 <20061108124823.308ae3b4@cad-250-152.norway.atmel.com>
In-Reply-To: <20061108124823.308ae3b4@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061108180059.845DE1DC95A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'd rather just see a "convention".  In some important cases, these
> > calls should map to a handful of instructions to read or write chip
> > registers. Talking about a "driver" or "layer" implies hundreds of
> > instructions, which means people _will_ regularly need to bypass it
> > for bitbanging.
>
> Exactly. If we can decide on what the prototypes should look like and
> which header they should be in, the architecture is free to implement
> it any way it chooses. If speed is more important than
> chip-independence, they can even be inlines accessing the hardware
> directly.

Yes.  And that set of prototypes I sketched would seem to suffice.

Maybe the best way to proceed with such a thing is to change $SUBJECT
and include a doc patch, then prepare some patches to submit.  The
minimal patchset would cover AVR32 and AT91.  I'll light the fire
involved with the doc patch; not all concerned parties will have
been reading this thread.  Later in the week, unless someone makes
a better suggestion.


> > A convention for how to package those features would make sense, if
> > for no other reason than to avoid "how does _this_ platform do it?"
> > confusion. Most code touching GPIOs is platform-specific, but maybe
> > not all of it... I can see it including:
>
> The SPI driver in this series is an example of an at least somewhat
> platform-independent driver touching GPIOs. MMC and CompactFlash drivers
> also come to mind.

Whoops, yes that's very true.  It is in fact the reason why _now_ we
may actually need such a cross-platform convention, and are having
this thread ... one is needed that works on both AVR32 and AT91, but
previously the main needs have been within a single architecture.

Previously the discussions about generic GPIO support have foundered (IMO)
on lack of "real" need for such a thing, short of a userspace API (which
seems to me a low value thing, in most contexts, but which could be
layered on top of the convention we've outlined).


> >     - GPIOs are identified by platform-specific unsigned integers;
> >       in the range 0..INT_MAX (i.e. "negative" means
> >	  reserved/invalid).

Where, to be clear, "platform" includes things like which SOC chip,
which external chips on the board (many x86 south bridges have GPIO
pins, maybe not very flexible), how the FPGAs are programmed, etc.

There will also need to be a convention for mappings between the GPIO
namespace and the IRQ namespace.  It's polite if that mapping is the
identity mapping, but more often they're distinct, with GPIO 10 and
IRQ 10 having the same numeric value.

So I'll propose gpio_to_irq() and irq_to_gpio() as the convention for
that mapping; negative errno returned for "no such mapping".


> >     - "#include <asm/arch/gpio.h>" (or <asm/gpio.h> ?) providing these
> >       calls, which may be used from IRQ handlers:
>
> Should probably be <asm/gpio.h> since not all arches actually have an
> asm/arch directory. Nothing wrong with <asm/gpio.h> including
> <asm/arch/gpio.h> though...

Right.


> > 	* int gpio_get_value(unsigned gpio)
> > 	    ... returning 0, 1, or negative errno (for invalid gpio)
> > 	* int gpio_set_value(unsigned gpio, int is_set)
> > 	    ... returning 0 or negative errno (for invalid gpio)

Note that all these "negative errno" returns could be eliminated if
we required the gpio to have been claimed in advance, which would
reduce the cost of those calls.  Unfortunately such claim/release
calls are not currently portable cross-platform.

Also, it's going to be platform-specific whether an "output" gpio
value can be read; and if so, whether that input value matches the
selected output value.


> > 	* int gpio_set_direction(unsigned gpio, int is_in /* or
> >           		is_out? */)
> >         ... returning 0 or negative errno (for invalid gpio)
>
> I think set_output_enable makes more sense, but maybe it's just me.

It's just you.  :)

A "set enable" idiom is linguistically redundant too; "set" suffices,
or "enable".  Both imply a need for an opposite "clear" or "disable.
"Direction" is a more obvious notion; the parameter should likely be
a symbol like GPIO_IN or GPIO_OUT.


> > 	* int gpio_request(unsigned gpio)
> > 	    ... returning 0 or negative errno (for invalid gpio or
> >	    "busy")
> > 	* int gpio_free(unsigned gpio)
> > 	    ... returning 0 or negative errno (for invalid gpio)
> > 	* and platform-specific additional mechanisms.
> > 	    ... like open-drain drive modes, ganged get/set, etc
> > 
> > That should work OK for AVR32 (by demonstration!)
>
> Definitely.
>
> > and many ARMs
> > (including OMAP, AT91, PXA, DaVinci, and more).  So well that
> > providing those calls as inlined wrappers around existing calls would
> > be trivial!
>
> Yes, it looks to me that most platforms do basically the same thing
> with different names.

Though not all provide request/free calls, and there are those funky
"advanced" features like open drain etc.


> > But it wouldn't handle the other common case of chips -- like a
> > pcf8574 I2C gpio expander -- providing GPIO-like functionality
> > through message passing infrastructure.  They might need a similar
> > API; extgpio_*() maybe.  And the common case of "use GPIO N as an
> > IRQ" merits thought too (for both "real" GPIOs and external ones like
> > that pcf8574).
>
> Handling chips like this would need some rethinking as they can be
> added dynamically, so static pin numbers won't do. Handling this could
> perhaps complicate the API enough to prevent people from adopting it...

CPLD based GPIOs could be added dynamically too, but one hopes that's
not common.  Such dynamic GPIOs might be better off using struct pointers
as GPIO ids, with methods (or an ops vector) in the struct and structural 
addressing ... e.g. "GPIO3 on this chip".  (And its chained IRQ ...)

You could do "real" GPIOs through such a "fat" API/layer, but the converse
is not true.


> > But pullups are not just a GPIO thing; they're a pin configuration
> > thing (even on AT91 and AVR32) that can apply even if the pin is not
> > usable as a GPIO (e.g. as on some non-Atmel platforms).  So that
> > stuff certainly does not belong in generic infrastructure.
>
> But maybe it could be done as part of the gpio_request() call, if we
> specify an additional `flags' parameter? gpio_request() needs to know
> about pin configuration anyway, as it needs to set up the pin for gpio.

Nope, on several counts in addition to "it's not just for GPIOs":

  - First, not all platforms integrate such pullups; ISTR PXA doesn't,
    and DaVinci.

  - Second, some platforms offer either pullups or pulldowns; newer
    OMAPs offer that choice, for example.

  - Third, some platforms (like OMAP1) have lots of options about
    how to pin out GPIOs (e.g. OMAP 5912 GPIO7 can be on any of three
    different balls, and ball R13 can be GPIO36 -or- MPUIO0).  Plus
    there are package options where the same "logical" pin is wired
    out to different "physical" balls.

Best all around to keep those issues completely orthogonal, IMO!


> > > h8300 uses h8300_free_gpio(), and there's also omap_free_gpio().
> > > Perhaps this patch should have added avr32_free_gpio()?
> > 
> > If the parameters are the same -- GPIO IDs, unsigned integers with
> > platforms-specific semantics -- I don't see much of a point in
> > requiring a platform-specific convention for naming those functions.
>
> I'll make a few adjustments to the avr32 api to make it conform with
> your proposed api, as well as rename portmux_select_peripheral to
> at32_select_peripheral (since it was never really intended to be
> platform-independent).
>
> Then I'll send a patch to do the same thing for at91, if Andrew V is ok
> with it.

Sounds good, and I'll draft a doc patch to send around to seed the
discussion about other platforms adopting the same convention.

- Dave

