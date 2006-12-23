Return-Path: <linux-kernel-owner+w=401wt.eu-S1753456AbWLWLiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbWLWLiI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 06:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbWLWLiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 06:38:07 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3826 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbWLWLiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 06:38:06 -0500
Date: Sat, 23 Dec 2006 11:37:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Message-ID: <20061223113752.GA28306@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
	Bill Gatliff <bgat@billgatliff.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
	Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
	Tony Lindgren <tony@atomide.com>,
	pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201304.03912.david-b@pacbell.net> <200612201313.22572.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612201313.22572.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 01:13:21PM -0800, David Brownell wrote:
> Arch-neutral GPIO calls for SA-1100.
> 
> From: Philipp Zabel <philipp.zabel@gmail.com>
> 
> +static inline unsigned gpio_to_irq(unsigned gpio)
> +{
> +	if (gpio < 11)
> +		return IRQ_GPIO0 + gpio;
> +	else
> +		return IRQ_GPIO11 - 11 + gpio;
> +}
> +
> +static inline unsigned irq_to_gpio(unsigned irq)
> +{
> +	if (irq < IRQ_GPIO11_27)
> +		return irq - IRQ_GPIO0;
> +	else
> +		return irq - IRQ_GPIO11 + 11;
> +}

Why do we need to convert between IRQ and PGIO numbers?  This is NOT
something that drivers should even care about - it's something that the
interrupt subsystem should know when being asked to claim an GPIO-based
IRQ.

That's something I worked hard to eliminate from the SA1100 drivers,
please don't reintroduce this silly idea again.

When the interrupt system is asked to claim a IRQ corresponding to a
GPIO, it should deal with all the stuff necessary to ensure that the
GPIO is in the required state.  Drivers should not be considering
converting IRQ numbers to GPIOs or vice versa.

Doing otherwise is just plain silly - are we expecting to add GPIO
support to all Linux drivers which could possibly be used on ARM, just
because their interrupt pin might possibly be connected to a GPIO?

Get real - if you're dealing with IRQs use _only_ IRQ numbers.  Don't
even think that drivers should be able to convert between IRQ and GPIO
numbers.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
