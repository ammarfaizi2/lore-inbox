Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUHYFu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUHYFu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 01:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHYFu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 01:50:28 -0400
Received: from p508B6A77.dip.t-dialin.net ([80.139.106.119]:16211 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S268303AbUHYFuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 01:50:25 -0400
Date: Wed, 25 Aug 2004 07:49:40 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bjorn.helgaas@hp.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ioc3-eth.c: add missing pci_enable_device()
Message-ID: <20040825054940.GA23827@linux-mips.org>
References: <200408242225.i7OMPGLQ029847@hera.kernel.org> <412BE006.8040606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412BE006.8040606@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 08:40:38PM -0400, Jeff Garzik wrote:

> I don't see a "signed-off-by" line from Ralf.  I noticed you never 
> bothered to send this patch to me.  Did you send it to Ralf either?
> 
> ioc3 is _very_ strange device and not fully compliant to the PCI spec.
> 
> I would appreciate more review and testing before these patches go in, 
> particularly against net drivers.  pci_enable_device() is NOT just a 
> simple cleanup:
> 
> * each driver may (though unlikely) manage its PCI_COMMAND bits and/or 
> resources in a special way.  IDE driver is an example of where 
> pci_enable_device() _cannot_ be used.
> 
> * like ioc3, the hardware may be weird
> 
> * you must consider the case of two drivers for the same hardware VERY 
> carefully.  Consider:
> 
> 1) (DRV A) modprobe
> 2) (DRV A) pci_enable_device()
> 3) (DRV A) starts operation
> 
> 4) (DRV B) modprobe
> 5) (DRV B) pci_enable_device()
> 6) (DRV B) pci_request_regions() or request_region() fails (since driver 
> A owns the resources)
> 7) (DRV B) pci_disable_device()
> 
> 8) (DRV A) fails miserably, because you just disabled IO/MEM bits from 
> an _active_ driver.  BOOM.

... and that's similar to the hole into which IOC3 is falling.  IOC3 is a
multi function device - but not in sense of the PCI spec.  IOC3 provides a
standard ethernet interface with the usual gadgets like PHY interfacing.
It also contains a PS/2 keyboard / mouse interface (thanks to which my
headless Origin 200 has each 4 keyboard and mouse connectors!), a
486-style backside bus on which a standard PC SuperIO chip providing
the 16552s and a RTC chip are hooked up.  As things are right now each of
these functions is provided by a different driver and there is no
central coordination that ensures pci_disable_device() will only be called
by the time the last driver has finished it's business.  As consequence
until we can cleanly handle this is not calling pci_disable_device().

Since the original posting I also found that the original argument about
interrupt routing is bogus; in violation of the PCI spec IOC3 supports
multiple interrupt pins.  On IP27 (Origin, Onyx 2) they're all just wired
together re-establishing PCI compliance.  That's not the case on Octane
which needs special handling outside of what the normal PCI code provides.

  Ralf
