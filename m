Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVKAPcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVKAPcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVKAPcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:32:36 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:41363 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750893AbVKAPcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:32:35 -0500
Date: Tue, 1 Nov 2005 10:32:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Paul Mackerras <paulus@samba.org>, <akpm@osdl.org>,
       David Brownell <david-b@pacbell.net>,
       Greg Kroah-Hartman <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't touch USB controllers with MMIO disabled in quirks
In-Reply-To: <Pine.LNX.4.64.0510312026300.27915@g5.osdl.org>
Message-ID: <Pine.LNX.4.44L0.0511011029040.5081-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Linus Torvalds wrote:

> Well, this can't be right, because depending on which controller type it 
> is, the handoff code uses PIO, not MMIO. In fact, a uhci controller 
> wouldn't necessarily ever have PCI_COMMAND_MEMORY set afaik, since it 
> doesn't even _have_ MMIO.
> 
> Would something like the appended work instead?
> 
> 		Linus
> 
> ---
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index b7fd3f6..b1aa350 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -138,11 +138,23 @@ reset_needed:
>  }
>  EXPORT_SYMBOL_GPL(uhci_check_and_reset_hc);
>  
> +static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
> +{
> +	u16 cmd;
> +	return !pci_read_config_word(pdev, PCI_COMMAND, &cmd) && (cmd & mask);
> +}
> +
> +#define pio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_IO)
> +#define mmio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_MEMORY)
> +
>  static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
>  {
>  	unsigned long base = 0;
>  	int i;
>  
> +	if (!pio_enabled(pdev))
> +		return;
> +

In theory, is it possible for a UHCI controller still to be running, doing 
DMA and/or generating interrupts, even if PCI_COMMAND_IO isn't set?  If it 
is, is there anything wrong with enabling the device fully in order to 
shut it off?

Or is this scenario not worth worrying about?

Alan Stern

