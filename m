Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUHKUgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUHKUgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268244AbUHKUfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:35:05 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:34774 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S268232AbUHKUdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:33:53 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Date: Wed, 11 Aug 2004 14:33:50 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408101646.57542.bjorn.helgaas@hp.com> <20040810235621.GZ26174@fs.tum.de>
In-Reply-To: <20040810235621.GZ26174@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111433.50641.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 5:56 pm, Adrian Bunk wrote:
> On Tue, Aug 10, 2004 at 04:46:57PM -0600, Bjorn Helgaas wrote:
> > On Tuesday 10 August 2004 11:32 am, Adrian Bunk wrote:
> > > On Tue, Aug 10, 2004 at 09:59:18AM -0600, Bjorn Helgaas wrote:
> > > > On Tuesday 10 August 2004 9:09 am, Adrian Bunk wrote:
> > > > > 2.6.8-rc3-mm1 boots fine on my computer.
> > > > > 2.6.8-rc4-mm1 doesn't boot.
> > > > > 2.6.8-rc4-mm1 with pci=routeirq boots.
> > 
> It happens before the
>   floppy0: no floppy controllers found
> line.
> 
> Could there be a problem because the floppy driver doesn't find 
> anything (there's currently no floppy drive in my computer)?

Not only is your machine floppy drive-less, but the driver thinks you
don't even have a floppy *controller*, which I assume is separate
from the actual drive.

What mainboard do you have?  Does it boot without "pci=routeirq"
if you turn CONFIG_BLK_DEV_FD off?

The code in the floppy_init() -> user_reset_fdc() -> WAIT() ->
wait_til_done() -> reset_fdc() path looks pretty scary if there
really is no controller out there.  I'd feel much better if
we at least tried to use ACPI to figure out whether we have
a controller before we try to talk to it.

All that aside, I still don't see how the pci=routeirq change
would affect the floppy driver.  It does request_irq(6, ...),
and it is interesting that you have this:

    ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
    ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6

which is for your NIC.  But the floppy controller isn't a PCI
device, so the LNKD enable shouldn't matter to it.

Let's see... you're using the PIC model.  Maybe the floppy driver
depends on the ACPI_IRQ_MODEL_PIC stuff in acpi_register_gsi()?
Can you post the contents of /proc/interrupts with the floppy
driver and "pci=routeirq"?  It seems weird to have the floppy
and the NIC share an IRQ, but it looks like that's what should
be happening.

Bjorn
