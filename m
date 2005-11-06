Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVKFXfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVKFXfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVKFXfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:35:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:743 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932362AbVKFXfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:35:53 -0500
Subject: Re: Fwd: [RFC] IRQ type flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051106224225.GC6274@flint.arm.linux.org.uk>
References: <20051106084012.GB25134@flint.arm.linux.org.uk>
	 <1131316897.1212.61.camel@localhost.localdomain>
	 <20051106221643.GB6274@flint.arm.linux.org.uk>
	 <1131317998.1212.63.camel@localhost.localdomain>
	 <20051106224225.GC6274@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 10:33:00 +1100
Message-Id: <1131319980.5229.119.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Good question - I'm not sure currently.  In the places where set_irq_type
> is used on ARM, we're mainly interested in setting the input according
> to rising/falling edge or high/low levels rather than switching between
> edge and level mode.
> 
> We could do as you suggest, but my concern would be adding extra
> complexity to drivers, causing them to do something like:
> 
> 	ret = request_irq(..., SA_TRIGGER_HIGH, ...);
> 	if (ret == -E<whatever>)
> 		ret = request_irq(..., SA_TRIGGER_RISING, ...);
> 
> The alternative is:
> 
> 	ret = request_irq(..., SA_TRIGGER_HIGH | SA_TRIGGER_RISING, ...);
> 
> at which point the driver is telling the IRQ layer what it can support,
> and allowing the IRQ layer to select the most appropriate type given
> the driver and hardware constraints.

We have similar things on ppc but dealt differently. The type of
interrupt sense supported depends on the PIC (and you can have more than
one PIC around). On Open Firmware based machines at least, the
device-tree tells us the sense setting to use on all devices in the
system, we program our PIC based on that information.

Your proposal though is interesting as it would allow individual to
override that setting (it may be broken, firmware occasionally are), and
would probably be useful for embedded PPCs as well.

However, I would suggest defining the absence of explicit trigger (0) as
a constant rather than 0 (SA_TRIGGER_DEFAULT), just for consistency.That
means using whatever the platform considers as a good default for this
interrupt. In addition, I would still add a get_irq_trigger() function
for a driver to enquire the kind of sense that was set by default by the
platfrom for a given irq line.

Ben.

