Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSFNX5Z>; Fri, 14 Jun 2002 19:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSFNX5Y>; Fri, 14 Jun 2002 19:57:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8970 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314938AbSFNX5X>;
	Fri, 14 Jun 2002 19:57:23 -0400
Message-ID: <3D0A8207.1010608@mandrakesoft.com>
Date: Fri, 14 Jun 2002 19:53:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206141803260.31514-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> On Fri, 14 Jun 2002, Jeff Garzik wrote:
> 
> 
>>We already have pci_request_regions() and currently PCI drivers should 
>>use that.
> 
> 
> I have to admit I wasn't aware of that. It doesn't really help with the 
> problem which started this thread, though.
> 
> 
>>Auto-ioremap would be bad, though... you would wind up wasting address 
>>space for any case where MMIO areas are not 100% utilized (like network 
>>cards that require use of PIO due to hardware bugs, but still export an 
>>MMIO region for their NIC registers)
> 
> 
> auto-ioremap would be bad for pci_request_regions(), which just blindly 
> allocates all regions. Let's show an example of what I was thinking about, 
> though.
> 
> This is eepro100.c::eepro100_init_one() after the conversion
> - IMO it looks a lot simpler than the old code.
> 
> --------------------------------------------------------------
> #ifdef USE_IO
> 	ioaddr = pci_request_io(pdev, 1);
> 	if (!ioaddr)
> 		goto err_out_none;
> 
> 	if (speedo_debug > 2)
> 		printk("Found Intel i82557 PCI Speedo at I/O %#lx.\n", ioaddr);
> #else
> 	ioaddr = (unsigned long) pci_request_mmio(pdev, 0);
> 	if (!ioaddr)
> 		goto err_out_none;
> 
> 	if (speedo_debug > 2)
> 		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx.\n",
> 			   pci_resource_start(pdev, 0));
> #endif
> 	if (speedo_found1(pdev, ioaddr, cards_found, acpi_idle_state) == 0)
> 		cards_found++;
> 	else
> 		goto err_out_release;
> 
> 	return 0;
> 
> err_out_release:
> #ifdef USE_IO
> 	pci_release_io(pdev, 1);
> #else
> 	pci_release_mmio(pdev, 0, (void *)ioaddr);
> #endif
> err_out_none:
> 	return -ENODEV;
> --------------------------------------------------------------
> 
> We only request the regions we're going to use, so the others may even 
> stay unassigned and disabled.
> 
> So my idea looks something like this:
> 
> 	unsigned long
> 	pci_request_io(struct pci_dev *pdev, int nr);
> 
> 	void *
> 	pci_request_mmio(struct pci_dev *pdev, int nr);
> 
> 	void 
> 	pci_release_io(struct pci_dev *pdev, int nr);
> 
> 	void 
> 	pci_release_mmio(struct pci_dev *pdev, int nr, void *addr);
> 
> 	int 
> 	pci_request_irq(struct pci_dev *pdev,
> 			void (*handler)(int, void *, struct pt_regs *),
> 		        unsigned long flags, const char *name, void *dev);
> 
> 	void 
> 	pci_release_irq(struct pci_dev *pdev, void *dev);
> 
> These functions return directly what we need: an address for 
> in/out[bwl], a cookie for read/write[bwl] - well, and the irq
> which however is only for informational purposes.
> 
> It probably makes sense to split the pci_request_irq() into 
> pci_assign_irq() and pci_request_irq(), since we want to delay the
> pci_request_irq() until we really need it.
> 
> The advantages are:
> o saves the ioremap etc.
> o tells the PCI layer explicitly which resources we use, so
>   it doesn't have to take the all or nothing pci_enable_device()/
>   pci_request_resources() approach
> o adds appropriate printk(KERN_INFO) when request_region etc fails,
>   saving thousands of places where we need do the printk() by hand,
>   and fixing the other thousands of places where we don't printk() so the
>   user has no idea why the driver wouldn't load.


Thanks for the patch, I can see where you're headed more clearly.

Comments:
* You absolutely need a separate _assign_irq().  request_irq() and 
free_irq() are used today as the points which enable and disable an irq 
for a device.

* You want to keep pci_enable_device(), such that, in driver code it 
does not need to be moved.  This is an important hook for hotplug PCI 
and cardbus and such things, which need a point where they may enable 
the device as a whole.  One important function pci_enable_device() does 
now, for example, is bring the PCI device to D0 full-power-on state.

* Remember that you must handle two cases here:  1) BIOS-pre-assigned 
region values, and 2) on-the-fly assigned values.  Drivers needs to work 
transparently such that, on a desktop PCI system, pci_request_regions() 
is _really_ all the reservation they need.  And the same driver, using 
the same code, should handle cardbus and other systems that are having 
resources assigned to them dynamically.  I don't really care that much 
how's it's implemented behind-the-scenes, as long as the end-result 
driver code handles both these cases without a forest of "if's" and 
"ifdef's"

	Jeff


