Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTJXBuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 21:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTJXBuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 21:50:14 -0400
Received: from web14913.mail.yahoo.com ([216.136.225.240]:56587 "HELO
	web14913.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261932AbTJXBuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 21:50:05 -0400
Message-ID: <20031024015004.16330.qmail@web14913.mail.yahoo.com>
Date: Thu, 23 Oct 2003 18:50:04 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't it be better to add ROM enable/disable functions to the PCI driver
than to scatter it out into every driver? All of the framebuffer and DRM
drivers need to do this. I also seem to remember that there are more steps
needed if this is going to work on an ARM chip.

--- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> [ Jeff: is that PCI ROM enable _really_ that complicated? Ouch. Or is
>   there some helper function I missed? ]
> 
> On Thu, 23 Oct 2003, Jon Smirl wrote:
> >
> > I don't think DRM drivers are doing things correctly yet. DRM is missing
> the
> > code for marking PCI resources as being in use while DRM is using them.
> This
> > could lead to problems with hotplug.  XFree is also mapping PCI ROMs in
> without
> > informing the kernel and that can definitely cause problems.
> 
> Absolutely. Changing PCI configurations without telling the kernel _will_ 
> cause problems. Especially for hotplug systems, but it's also very iffy to 
> do if the card is behind a PCI bridge, since you have to take bridge 
> resources into account (and know which bridges are transparent, which are 
> not, etc etc). 
> 
> The kernel spends a lot of effort on getting this right, and even so it 
> fails every once in a while (devices that use IO or memory regions without 
> announcing them in the standard BAR's are quite common, and the kernel has 
> to have special quirk entries for things like that).
> 
> Few enough drivers actually want to enable the roms, but the code should 
> look something like
> 
> 	/* Assign space for ROM resource if not already assigned. Ugly. */
> 	if (!pci_resource_start(dev, PCI_ROM_RESOURCE))
> 		if (pci_assign_resource(dev, PCI_ROM_RESOURCE) < 0)
> 			return -ENOMEM;
> 
> 	/* Enable it. This is too ugly */
> 	if (!(pci_resource_flags(dev, PCI_ROM_RESOURCE) & PCI_ROM_ADDRESS_ENABLE)) {
> 		u32 val;
> 		pci_read_config_dword(dev, PCI_ROM_ADDRESS, &val);
> 		val |= PCI_ROM_ADDRESS_ENABLE;
> 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, val);
> 		pci_resource_flags(dev, PCI_ROM_RESOURCE) |= PCI_ROM_ADDRESS_ENABLE;
> 	}
> 
> 
> 	/* Enable the device, and regular resources */
> 	if (pci_enable_device(dev))
> 		return -ENODEV;
> 
> 	pci_set_master(dev);	/* If we want to */
> 	pci_set_mwi(dev);	/* If we want to */
> 
> (Yeah, that is more complex than it really should need to be. That's just 
> a sign of exactly how few device drivers tend to want to do this: the 
> usual helper stuff is all geared for the normal case).
> 
> > new style probe
> > if (new probe has device)
> >    mark resources in use
> 
> You shouldn't need to mark the resources in use. Just registering the 
> driver should do everything for you, including making sure that no other 
> driver will register that device.
> 
> Of course, if you are worried about mixing with drivers that use the old
> "find device and just use it", then yes, you'll need to mark the resources 
> in use. That can be as trivial as just doing a
> 
> 	if (pci_request_regions(dev, "drivername") < 0)
> 		return -EAIIEEEE!;
> 
> in the probe function (but then you need to remember to release them in 
> the drop function).
> 
> 			Linus
> 

The framebuffer drivers are doing it like this. Should they be replaced with
pci_request_regions?

	/* request the mem regions */
	if (!request_mem_region (rinfo->fb_base_phys,
				 pci_resource_len(pdev, 0), "radeonfb")) {
		printk (KERN_ERR "radeonfb: cannot reserve FB region\n");
		goto free_rinfo;
	}

	if (!request_mem_region (rinfo->mmio_base_phys,
				 pci_resource_len(pdev, 2), "radeonfb")) {
		printk (KERN_ERR "radeonfb: cannot reserve MMIO region\n");
		goto release_fb;
	}



=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
