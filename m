Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268863AbUHLWqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268863AbUHLWqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268857AbUHLWqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:46:37 -0400
Received: from fmr02.intel.com ([192.55.52.25]:51398 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S268850AbUHLWoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:44:13 -0400
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
From: Len Brown <len.brown@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200408121550.15892.bjorn.helgaas@hp.com>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com>
	 <1092259920.5021.117.camel@dhcppc4>
	 <200408121550.15892.bjorn.helgaas@hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092350580.7765.190.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Aug 2004 18:43:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 17:50, Bjorn Helgaas wrote:
> On Wednesday 11 August 2004 3:32 pm, Len Brown wrote:
> > I've never understood this floppy IRQ6 business.
> > Apparently it requests IRQ6, but doesn't show up in /proc/interrupts
> 
> floppy_init() requests IRQ6, but then frees it before returning.  It
> looks like the driver only holds onto it while the device is actually
> open, which explains why it doesn't usually show up in
> /proc/interrupts.

ah, the mysterious floppy.c -- explained;-)

> Len later wrote:
> > I assert it is a BIOS bug for the BIOS to set LNKD to
> > IRQ6 if there is a floppy present and enabled; but fair
> > game if there is no floppy.  Though perhaps floppy.c
> > doesn't understand that.
> 
> Adrian has the floppies disabled in the BIOS, so maybe it's
> legit to use IRQ6 for the NIC PCI interrupt.  But floppy.c
> doesn't check for anything like that as far as I can see.
> 
> The fact that floppy.c seems to be able to poke the controller
> and get an interrupt back (with "pci=routeirq") suggests to me
> that the floppy controller responds even when disabled in the
> BIOS, and that it actually expects IRQ6 to be level-triggered,
> but the BIOS is leaving it configured as edge-triggered.

I expect that the the bug is that floppy.c, like other motherboard
devices, should take advantage of ACPI for device resource
enumeration.  This is one of the gaps I described at OLS,
and it is embodied in this bug report:
http://bugzilla.kernel.org/show_bug.cgi?id=2733

My expectation is that if the SETUP option is changed to
enable the floppy (the controller is probably burried inside
an LPC super-io or south bridge, even if there is no physical
drive in the box) Then we should see

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
turn into

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)

with the * moving off of 6 (11 in this example) showing that
the BIOS selected a different active IRQ for this link.

Or even
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 *11 12 14 15)

Where IRQ6 is not in the possible-list, which would prevent
Linux from setting the device to that IRQ even if we wanted to.
(and again, the '*' on some other IRQ, 11 in this example)

Adrian, if you enable your not-present floppy in the BIOS,
what does Linux do?

thanks,
-Len


