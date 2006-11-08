Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161544AbWKHS6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161544AbWKHS6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161532AbWKHS6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:58:33 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:20683 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161544AbWKHS6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:58:32 -0500
Date: Wed, 8 Nov 2006 19:57:57 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, andrew@sanpeople.com, akpm@osdl.org
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Message-ID: <20061108195757.0d9e9dbc@cad-250-152.norway.atmel.com>
In-Reply-To: <20061108180059.845DE1DC95A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	<20061107122715.3022da2f@cad-250-152.norway.atmel.com>
	<20061107131014.535ab280.akpm@osdl.org>
	<20061107223741.62FA21DC801@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20061108124823.308ae3b4@cad-250-152.norway.atmel.com>
	<20061108180059.845DE1DC95A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 10:00:59 -0800
David Brownell <david-b@pacbell.net> wrote:

> > Exactly. If we can decide on what the prototypes should look like
> > and which header they should be in, the architecture is free to
> > implement it any way it chooses. If speed is more important than
> > chip-independence, they can even be inlines accessing the hardware
> > directly.
> 
> Yes.  And that set of prototypes I sketched would seem to suffice.

Indeed.

> Maybe the best way to proceed with such a thing is to change $SUBJECT
> and include a doc patch, then prepare some patches to submit.  The
> minimal patchset would cover AVR32 and AT91.  I'll light the fire
> involved with the doc patch; not all concerned parties will have
> been reading this thread.  Later in the week, unless someone makes
> a better suggestion.

That would be great. Thanks.

> Previously the discussions about generic GPIO support have foundered
> (IMO) on lack of "real" need for such a thing, short of a userspace
> API (which seems to me a low value thing, in most contexts, but which
> could be layered on top of the convention we've outlined).

I do actually have a userspace API patch as well, using configfs, but I
want to give it some more testing internally, to see how it works out
for real applications, before submitting it. It's probably a good idea
to get the in-kernel API in place first too.

> > >     - GPIOs are identified by platform-specific unsigned integers;
> > >       in the range 0..INT_MAX (i.e. "negative" means
> > >	  reserved/invalid).
> 
> Where, to be clear, "platform" includes things like which SOC chip,
> which external chips on the board (many x86 south bridges have GPIO
> pins, maybe not very flexible), how the FPGAs are programmed, etc.
> 
> There will also need to be a convention for mappings between the GPIO
> namespace and the IRQ namespace.  It's polite if that mapping is the
> identity mapping, but more often they're distinct, with GPIO 10 and
> IRQ 10 having the same numeric value.
> 
> So I'll propose gpio_to_irq() and irq_to_gpio() as the convention for
> that mapping; negative errno returned for "no such mapping".

Good idea. For identity mappings, they can simply be inlines
introducing no overhead at all.

> > > 	* int gpio_get_value(unsigned gpio)
> > > 	    ... returning 0, 1, or negative errno (for invalid
> > > gpio)
> > > 	* int gpio_set_value(unsigned gpio, int is_set)
> > > 	    ... returning 0 or negative errno (for invalid gpio)
> 
> Note that all these "negative errno" returns could be eliminated if
> we required the gpio to have been claimed in advance, which would
> reduce the cost of those calls.  Unfortunately such claim/release
> calls are not currently portable cross-platform.

I doubt that many callers will actually check the return value. If it
works once, it should work every time...

If you actually care about whether the pin id you got is usable, you
need to claim it anyway, as these functions won't check for any
conflicting usage.

> Also, it's going to be platform-specific whether an "output" gpio
> value can be read; and if so, whether that input value matches the
> selected output value.

Yeah, it might depend on which register you read (the at32/at91 gpio
controller has one that returns the value you wrote and one that returns
the actual state of the pins)

> > > 	* int gpio_set_direction(unsigned gpio, int is_in /* or
> > >           		is_out? */)
> > >         ... returning 0 or negative errno (for invalid gpio)
> >
> > I think set_output_enable makes more sense, but maybe it's just me.
> 
> It's just you.  :)
> 
> A "set enable" idiom is linguistically redundant too; "set" suffices,
> or "enable".  Both imply a need for an opposite "clear" or "disable.
> "Direction" is a more obvious notion; the parameter should likely be
> a symbol like GPIO_IN or GPIO_OUT.

Ok, fine with me.

> > Yes, it looks to me that most platforms do basically the same thing
> > with different names.
> 
> Though not all provide request/free calls, and there are those funky
> "advanced" features like open drain etc.

The request/free calls aren't really arch-specific, are they? I
implement the actual allocation mechanism using atomic bitops.

And like you said, the "advanced" features can still be
platform-specific. Getting a common api for just the "basic" gpio
operations would be a huge improvement IMO.

> You could do "real" GPIOs through such a "fat" API/layer, but the
> converse is not true.

Yeah, I suggest we handle the simple cases first and see how it works
out.

> > > But pullups are not just a GPIO thing; they're a pin configuration
> > > thing (even on AT91 and AVR32) that can apply even if the pin is
> > > not usable as a GPIO (e.g. as on some non-Atmel platforms).  So
> > > that stuff certainly does not belong in generic infrastructure.
> >
> > But maybe it could be done as part of the gpio_request() call, if we
> > specify an additional `flags' parameter? gpio_request() needs to
> > know about pin configuration anyway, as it needs to set up the pin
> > for gpio.
> 
> Nope, on several counts in addition to "it's not just for GPIOs":
> 
>   - First, not all platforms integrate such pullups; ISTR PXA doesn't,
>     and DaVinci.
> 
>   - Second, some platforms offer either pullups or pulldowns; newer
>     OMAPs offer that choice, for example.
> 
>   - Third, some platforms (like OMAP1) have lots of options about
>     how to pin out GPIOs (e.g. OMAP 5912 GPIO7 can be on any of three
>     different balls, and ball R13 can be GPIO36 -or- MPUIO0).  Plus
>     there are package options where the same "logical" pin is wired
>     out to different "physical" balls.

  - Fourth, only the board-specific code really knows whether there's
    an external pullup in place. If there is, turning on the internal
    pullup might result in a too strong pullup.

> Best all around to keep those issues completely orthogonal, IMO!

I agree.

> > I'll make a few adjustments to the avr32 api to make it conform with
> > your proposed api, as well as rename portmux_select_peripheral to
> > at32_select_peripheral (since it was never really intended to be
> > platform-independent).
> >
> > Then I'll send a patch to do the same thing for at91, if Andrew V
> > is ok with it.
> 
> Sounds good, and I'll draft a doc patch to send around to seed the
> discussion about other platforms adopting the same convention.

Great. I'll probably sit on the patches until you're done with the
docs, to make sure that we're talking about the same thing.

Haavard
