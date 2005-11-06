Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVKFWmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVKFWmd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVKFWmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:42:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3858 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751259AbVKFWmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:42:32 -0500
Date: Sun, 6 Nov 2005 22:42:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: [RFC] IRQ type flags
Message-ID: <20051106224225.GC6274@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20051106084012.GB25134@flint.arm.linux.org.uk> <1131316897.1212.61.camel@localhost.localdomain> <20051106221643.GB6274@flint.arm.linux.org.uk> <1131317998.1212.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131317998.1212.63.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 10:59:58PM +0000, Alan Cox wrote:
> On Sul, 2005-11-06 at 22:16 +0000, Russell King wrote:
> > > This is actually true of some x86 hardware in the EISA space where there
> > > is a control register for level v edge that we sort of half deal with.
> > 
> > Thanks Alan.  Can I assume you're happy with the patch, even if x86
> > currently ignores the flags?
> 
> I'm certainly happy with it. Both the APIC and EISA IRQ control
> registers could even be made to honour it if anyone ever needed to.
> 
> Should platforms that don't support the flags be patched to error
> requests they don't support however ?

Good question - I'm not sure currently.  In the places where set_irq_type
is used on ARM, we're mainly interested in setting the input according
to rising/falling edge or high/low levels rather than switching between
edge and level mode.

We could do as you suggest, but my concern would be adding extra
complexity to drivers, causing them to do something like:

	ret = request_irq(..., SA_TRIGGER_HIGH, ...);
	if (ret == -E<whatever>)
		ret = request_irq(..., SA_TRIGGER_RISING, ...);

The alternative is:

	ret = request_irq(..., SA_TRIGGER_HIGH | SA_TRIGGER_RISING, ...);

at which point the driver is telling the IRQ layer what it can support,
and allowing the IRQ layer to select the most appropriate type given
the driver and hardware constraints.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
