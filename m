Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVCIWZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVCIWZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCIWUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:20:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:40131 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262093AbVCIWHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:07:49 -0500
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pekka Enberg <penberg@gmail.com>
Cc: xorg@freedesktop.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>, penberg@cs.helsinki.fi
In-Reply-To: <84144f0205030902451571def3@mail.gmail.com>
References: <1110265919.13607.261.camel@gaston>
	 <84144f0205030902451571def3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 09:02:50 +1100
Message-Id: <1110405770.32524.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 12:45 +0200, Pekka Enberg wrote:
> Hi Benjamin,
> 
> Few coding style nitpicks follow.
> 
> On Tue, 08 Mar 2005 18:11:59 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > Index: linux-work/include/linux/pci.h
> > ===================================================================
> > --- linux-work.orig/include/linux/pci.h	2005-01-24 17:09:57.000000000 +1100
> > +++ linux-work/include/linux/pci.h	2005-03-08 15:26:25.000000000 +1100
> > @@ -1064,5 +1064,6 @@
> >  #define PCIPCI_VSFX		16
> >  #define PCIPCI_ALIMAGIK		32
> >  
> > +
> >  #endif /* __KERNEL__ */
> >  #endif /* LINUX_PCI_H */
> 
> Please drop whitespace noise from the patch.

Oh sure, will do. I'm not about to submit anything yet anyway, and it
will go through a cleanup phase. The above is just residual of quilt
picking up a file where I added something, then removed it.

> > Index: linux-work/drivers/pci/vga.c
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-work/drivers/pci/vga.c	2005-03-08 18:04:57.000000000 +1100
> > @@ -0,0 +1,403 @@
> > +static LIST_HEAD(		vga_list);
> 
> Please remove whitespace damage.
> 
> > +static spinlock_t	       	vga_lock;
> > +static DECLARE_WAIT_QUEUE_HEAD(	vga_wait_queue);

The above isn't whitespace damage, it's aligning of the 3 variable
names properly in a column :) I dislike those DECLARE_*() macros because
of that btw. That one is a matter of style, I'm experiencing a bit with
this, but it's definitely intentional.

> 
> Please consolidate both while loops into one function. One possible way would
> be to do:
> 
> static void vga_update_bus(struct pci_bus *bus, unsigned int enable)
> {
> 	while (bus) {
> 		bridge = bus->self;
> 		if (bridge) {
> 			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
> 			if (cmd & PCI_BRIDGE_CTL_VGA)
> 				continue;
> 			if (enable)
> 				cmd |= PCI_BRIDGE_CTL_VGA;
> 			else
> 				cmd &= ~PCI_BRIDGE_CTL_VGA;
> 			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
> 		}
> 		bus = bus->parent;
> 	}
> }

I think you are beeing anal here, but I'll think about it ;)

> > +/*
> > + * Currently, we assume that the "initial" setup of the system is
> > + * sane, that is we don't come up with conflicting devices, which
> > + * would be annoying. We could double check and be better at
> > + * deciding who is the default here, but we don't. 
> > + */
> > +void vga_arbiter_add_pci_device(struct pci_dev *pdev)
> > +{
> > +	struct vga_device *vgadev;
> > +	unsigned long flags;
> > +	struct pci_bus *bus;
> > +	struct pci_dev *bridge;
> > +	u16 cmd;
> > +
> > +	/* Only deal with VGA class devices */
> > +	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> > +		return;
> > +
> > +	/* Allocate structure */
> > +	vgadev = kmalloc(sizeof(struct vga_device), GFP_KERNEL);
> > +	memset(vgadev, 0, sizeof(*vgadev));
> 
> Please consider using kcalloc() here.

Will do.

Ben.


