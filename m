Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWFXWkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWFXWkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWFXWkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:40:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57308 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751137AbWFXWkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:40:12 -0400
Message-ID: <449DBF48.2050607@garzik.org>
Date: Sat, 24 Jun 2006 18:40:08 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: akpm@osdl.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       enrico.scholz@informatik.tu-chemnitz.de, greg@kroah.com, rl@hellgate.ch
Subject: Re: + via-rhine-on-epia-pd-needs.patch added to -mm tree
References: <200606242219.k5OMIxxY006085@shell0.pdx.osdl.net>
In-Reply-To: <200606242219.k5OMIxxY006085@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> The patch titled
> 
>      via-rhine on epia-pd needs irq-quirk
> 
> has been added to the -mm tree.  Its filename is
> 
>      via-rhine-on-epia-pd-needs.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: via-rhine on epia-pd needs irq-quirk
> From: <enrico.scholz@informatik.tu-chemnitz.de>
> 
> 
> See http://bugzilla.kernel.org/show_bug.cgi?id=6744
> 
> VT6102 [Rhine-II] needs a routing of IRQ 9 to IRQ 11.
> 
> Without it, I get
> 
> | irq 9: nobody cared (try booting with the "irqpoll" option)
> | <c0136636> __report_bad_irq+0x36/0x80  <c01367ee> note_interrupt+0x16e/0x1a0
> | <c01c7f12> acpi_ev_sci_xrupt_handler+0x12/0x20  <c01361a3> handle_IRQ_event+0x23/0x50
> | <c013623f> __do_IRQ+0x6f/0xa0  <c0105246> do_IRQ+0x36/0x50
> | =======================
> | <c010362a> common_interrupt+0x1a/0x20  <c0118fec> __do_softirq+0x2c/0x80
> | <c0110520> do_page_fault+0x0/0x556  <c0105298> do_softirq+0x38/0x40
> | =======================
> | <c0105256> do_IRQ+0x46/0x50  <c010362a> common_interrupt+0x1a/0x20
> | <c0110520> do_page_fault+0x0/0x556  <c0110651> do_page_fault+0x131/0x556
> | <c0110520> do_page_fault+0x0/0x556  <c010374f> error_code+0x4f/0x60
> | handlers:
> | [<c01c2be0>] (acpi_irq+0x0/0x20)
> | Disabling IRQ #9
> 
> Cc: Greg KH <greg@kroah.com>
> Cc: Roger Luethi <rl@hellgate.ch>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/pci/quirks.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN drivers/pci/quirks.c~via-rhine-on-epia-pd-needs drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c~via-rhine-on-epia-pd-needs
> +++ a/drivers/pci/quirks.c
> @@ -662,6 +662,7 @@ static void quirk_via_irq(struct pci_dev
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, 0x3065,   quirk_via_irq);
>  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
>  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
>  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);

It strikes me as very unwise to do this.  I know that some VIA Rhine 
exist on a PCI card, which is a valid case where this quirk should -not- 
be executed.

The VIA quirk is only for on-motherboard devices, which have special PCI 
interrupt line behavior (makes some internal PIC connections).

How can we solve this conditionally?  I agree this is needed...  for 
on-mobo devices.  But 0x3065 is not always glued in, AFAIK.

	Jeff


