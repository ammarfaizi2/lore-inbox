Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVCHWvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVCHWvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVCHWvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:51:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:63922 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261575AbVCHWuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:50:50 -0500
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050308212909.GA18376@dreamland.darkstar.lan>
References: <20050308212909.GA18376@dreamland.darkstar.lan>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 09:46:20 +1100
Message-Id: <1110321980.13607.294.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 22:29 +0100, Kronos wrote:

> > +       bus = pdev->bus;
> > +       while (bus) {
> > +               bridge = bus->self;
> > +               if (bridge) {
> > +                       pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
> > +                       if (!(cmd & PCI_BRIDGE_CTL_VGA))
> > +                               continue;
> 
> This seems wrong: if the condition is true the loop will restart with
> the same bus device and will never stop. I think you should do:

Yup. I always try to avoid nesting if's tho, which is why I wrote it
that way :) But yes, it should be fixed.

> > +
> > +       /* Only deal with VGA class devices */
> > +       if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> > +               return;
> > +
> > +       /* Allocate structure */
> > +       vgadev = kmalloc(sizeof(struct vga_device), GFP_KERNEL);
> 
> Not checking return value of kmalloc, this is evil :P
> Also it may be worth to change return type in order to signal the error.

Yah, yah, I know :) will fix. I'm not sure there is point signaling the
error to the PCI layer. It won't do anything good with it.

> > +#endif
> > +
> > +       /* Add to the list */
> > +       list_add(&vgadev->list, &vga_list);
> > +       spin_unlock_irqrestore(&vga_lock, flags);
> 
> Missing return?

Yup.

> > + fail:
> > +       spin_unlock_irqrestore(&vga_lock, flags);
> > +       kfree(vgadev);
> > +}
> > +
> > +void vga_arbiter_del_pci_device(struct pci_dev *pdev)
> > +{
> > +       struct vga_device *vgadev;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&vga_lock, flags);
> > +       vgadev = vgadev_find(pdev);
> > +       if (vgadev == NULL)
> > +               goto bail;
> > +       if (vgadev->locks)
> > +               __vga_put(vgadev, vgadev->locks);
> > +       list_del(&vgadev->list);
> > + bail:
> > +       spin_unlock_irqrestore(&vga_lock, flags);
> > +       if (vgadev)
> > +               kfree(vgadev);
> 
> kfree(NULL) is fine, no need to check for null pointer.
> 
Hehe, yes, but I don't like it :)

Thanks. I spotted a few other issues (I was quite tired yesterday when I
finished this code). I'll do another pass on it today. One thing is: I
don't have x86 hardware, or at least, nothing where I can have 2 VGA
cards in (I may have access to an old laptop). So I'll need help &
testers at one point.

Ben.


