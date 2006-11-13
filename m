Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755251AbWKMUPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbWKMUPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbWKMUPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:15:45 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:57273 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755251AbWKMUPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:15:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=IAuJOLiz9P35RrA6IAUwIiwgpom1zj5Iu2tNbJ4vtFc+jKMbH74eRokc6z83XuHPABY3hIX797UpCuqtZk67Wy43PYmJLk+j0A2H2/fE5XH0MTHKdqB0b7L/u7q8ZtSfg+hEkoRryljCsUDVW1ZOP+DQb7qeQ5rRi44YDzVxuO8=  ;
X-YMail-OSG: QKP4Z.sVM1kBBAo6HiJyv5yW7PfIHbR3Wb4sN_3Pfgq.E4FmQkrAAULAxLEp3.hhHsTWV_QKBrw0Ft3CnpJJJkyjEWaX6yDPmrO6Y3lQPYPOJhZoqqBR1HrvNIS_dacIzxTvXvmB.hVaeKgeI4lSeRtZ7yvQjAYt88I-
From: David Brownell <david-b@pacbell.net>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 13 Nov 2006 12:15:39 -0800
User-Agent: KMail/1.7.1
Cc: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611131121.23944.david-b@pacbell.net> <4558CAE4.1020202@billgatliff.com>
In-Reply-To: <4558CAE4.1020202@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131215.39888.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 11:43 am, Bill Gatliff wrote:
> >
> >This API absolutely allows for multiple GPIO controllers ... all it does
> >is say "here are the numbers, handle them".  The platform's implementation
> >of the API is allowed to map to the relevant controller.
> 
> I think what Paul is saying here is that because your reference 
> implementation was "arch-omap" instead of "board-<something>", if I add 
> a PLD with some MMIO GPIO lines then I have to hack global OMAP code.  

Well, "example" implementation.

Linux doesn't handle PLDs as well as it might.  One example in the current
kernel is the original PXA reference platform, Intel's "Lubbock".  It's got
an FPGA with essential IRQs.  Look at the mess involved in coupling those
IRQs into the system ... not just adding a new irq_chip (easy!), but the
way the global PXA IRQ headers need to know about it.

Part of this is just that NR_IRQs is a global constant, and it's not
possible to allocate new IRQ banks after a kernel is built.  Like by
plugging in a few I2C chips with IRQ-capable GPIOs ...

Now, I think the way OMAP handles GPIOs could handle "add an FPGA" pretty
cleanly.  That is admittedly a platform-specific implementation issue ...
but then, so is "add an FPGA".  And in any case, It should be very clear
that such implementation issues don't need to affect the API, and that
right now only the API is being proposed.


> Maybe we should codify an approach for that now, i.e. add to the 
> reference implementation some code that hands off out-of-range GPIO 
> lines to a function in the machine descriptor:
> 
> 
> +static inline int gpio_direction_input(unsigned gpio)
> +	{ if (gpio < OMAP_MAX_ARCH_GPIO) return __gpio_set_direction(gpio, 1);
> +	  else if(mdesc->platform_gpio_set_direction) platform_gpio_set_direction(gpio, 1); }
> 
> 
> ... conveniently neglecting the way you find mdesc.  :)

Nah; look at arch/arm/plat-omap/gpio.c and ignore the mess, but observe
that what you see there is essentially a bunch of "gpio controller"
classes using the ugly "switch(type)" dispatch scheme instead of the
prettier "type->op()" dispatch scheme.  All that stuff needs to be
cleaner, but for now it'd suffice to add a new FPGA typecode.


> I do have a question now.  Is there any reason to consider shared GPIO 
> lines?  If so, then the request_gpio() would need a flag GPIO_SHARED or 
> something.

If two drivers agree to share a line -- how, why? -- they can come to a
private agreement.  We lack even a good example of why drivers would
want to share, much less knowledge that it's a general problem!

- Dave

