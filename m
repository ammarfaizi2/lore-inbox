Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTJWXq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTJWXq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:46:57 -0400
Received: from nedc.org ([149.175.1.5]:21663 "HELO lewis.lclark.edu")
	by vger.kernel.org with SMTP id S261898AbTJWXqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:46:51 -0400
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver
	conversion
From: Eric Anholt <eta@lclark.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       DRI <dri-devel@lists.sourceforge.net>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
Content-Type: text/plain
Message-Id: <1066952780.22390.15.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 23 Oct 2003 16:46:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 16:23, Linus Torvalds wrote:
> [ Jeff: is that PCI ROM enable _really_ that complicated? Ouch. Or is
>   there some helper function I missed? ]
> 
> On Thu, 23 Oct 2003, Jon Smirl wrote:
> >
> > I don't think DRM drivers are doing things correctly yet. DRM is missing the
> > code for marking PCI resources as being in use while DRM is using them. This
> > could lead to problems with hotplug.  XFree is also mapping PCI ROMs in without
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

However, the DRM is now using the old-style probing instead, because of
the radeonfb conflict.  In the case of the DRM, we want drivers to
coexist, at least when loaded in the FB then DRM order.  What should the
DRM be doing exactly in this case?  Is it exactly what Jon Smirl said,
or something else?

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


