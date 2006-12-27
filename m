Return-Path: <linux-kernel-owner+w=401wt.eu-S964990AbWL1IiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWL1IiT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWL1IiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:38:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3796 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964994AbWL1IiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:38:18 -0500
Date: Wed, 27 Dec 2006 17:49:54 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 1/6] GPIO core
Message-ID: <20061227174953.GB4088@ucw.cz>
References: <200611111541.34699.david-b@pacbell.net> <200612201304.03912.david-b@pacbell.net> <200612201308.41900.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612201308.41900.david-b@pacbell.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> +Identifying GPIOs
> +-----------------
> +GPIOs are identified by unsigned integers in the range 0..MAX_INT.  That
> +reserves "negative" numbers for other purposes like marking signals as
> +"not available on this board", or indicating faults.
> +
> +Platforms define how they use those integers, and usually #define symbols
> +for the GPIO lines so that board-specific setup code directly corresponds
> +to the relevant schematics.  In contrast, drivers should only use GPIO

Perhaps these should not be integers, then?

typedef struct { int mydata } pin_t; prevents people from looking
inside, allows you to typecheck, and allows expansion in (unlikely) case where
more than int is needed? ...hotpluggable gpio pins?

> +Spinlock-Safe GPIO access
> +-------------------------
> +Most GPIO controllers can be accessed with memory read/write instructions.
> +That doesn't need to sleep, and can safely be done from inside IRQ handlers.
> +
> +Use these calls to access such GPIOs:
> +
> +	/* GPIO INPUT:  return zero or nonzero */
> +	int gpio_get_value(unsigned gpio);
> +
> +	/* GPIO OUTPUT */
> +	void gpio_set_value(unsigned gpio, int value);
> +
> +The values are boolean, zero for low, nonzero for high.  When reading the
> +value of an output pin, the value returned should be what's seen on the
> +pin ... that won't always match the specified output value, because of
> +issues including wire-OR and output latencies.
> +
> +The get/set calls have no error returns because "invalid GPIO" should have
> +been reported earlier in gpio_set_direction().  However, note that not all
> +platforms can read the value of output pins; those that can't should always
> +return zero.
>  Also, these calls will be ignored for GPIOs that can't safely
> +be accessed wihtout sleeping (see below).

'Silently ignored' is ugly. BUG() would be okay there.

> +Platforms that support this type of GPIO distinguish them from other GPIOs
> +by returning nonzero from this call:
> +
> +	int gpio_cansleep(unsigned gpio);

This is ugly :-(. But I don't see easy way around...


> +GPIOs mapped to IRQs
> +--------------------
> +GPIO numbers are unsigned integers; so are IRQ numbers.  These make up
> +two logically distinct namespaces (GPIO 0 need not use IRQ 0).  You can
> +map between them using calls like:
> +
> +	/* map GPIO numbers to IRQ numbers */
> +	int gpio_to_irq(unsigned gpio);
> +
> +	/* map IRQ numbers to GPIO numbers */
> +	int irq_to_gpio(unsigned irq);

. Don't we have irq_t already? 

> +Those return either the corresponding number in the other namespace, or
> +else a negative errno code if the mapping can't be done.  (For example,
> +some GPIOs can't used as IRQs.)  It is an unchecked error to use a GPIO
> +number that hasn't been marked as an input using gpio_set_direction(), or

It should be valid to do irqs on outputs, if those outputs are really
tristates (wire-or or how you call it?)?

							Pavel

-- 
Thanks for all the (sleeping) penguins.
