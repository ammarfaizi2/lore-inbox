Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVCHVas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVCHVas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVCHVas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:30:48 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:7856 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262379AbVCHV2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:28:36 -0500
Date: Tue, 8 Mar 2005 22:29:09 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
Message-ID: <20050308212909.GA18376@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110265919.13607.261.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> ha scritto:
> Ok, so here is a first, totally untested draft for the kernel side
> of the VGA arbiter.

Hi Ben,
I've a few comments:

> Index: linux-work/drivers/pci/vga.c
> ===================================================================
> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/drivers/pci/vga.c        2005-03-08 18:04:57.000000000 +1100
[...]
> +#ifndef __ARCH_HAS_VGA_DISABLE_RESOURCES
> +static inline void vga_disable_resources(struct pci_dev *pdev,
> +                                        unsigned int rsrc,
> +                                        unsigned int change_bridge)
> +{
> +       struct pci_bus *bus;
> +       struct pci_dev *bridge;
> +       u16 cmd;
> +
> +       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +       if (rsrc & VGA_RSRC_IO)
> +               cmd &= ~PCI_COMMAND_IO;
> +       if (rsrc & VGA_RSRC_MEM)
> +               cmd &= ~PCI_COMMAND_MEMORY;
> +       pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +       if (!change_bridge)
> +               return;
> +
> +       bus = pdev->bus;
> +       while (bus) {
> +               bridge = bus->self;
> +               if (bridge) {
> +                       pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
> +                       if (!(cmd & PCI_BRIDGE_CTL_VGA))
> +                               continue;

This seems wrong: if the condition is true the loop will restart with
the same bus device and will never stop. I think you should do:

                        if (cmd & PCI_BRIDGE_CTL_VGA) {
                                cmd &= ~PCI_BRIDGE_CTL_VGA;
                                pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
                        }

> +                       cmd &= ~PCI_BRIDGE_CTL_VGA;
> +                       pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
> +               }
> +               bus = bus->parent;
> +       }
> +}
> +#endif
> +
> +#ifndef __ARCH_HAS_VGA_ENABLE_RESOURCES
> +static inline void vga_enable_resources(struct pci_dev *pdev,
> +                                        unsigned int rsrc)
> +{
> +       struct pci_bus *bus;
> +       struct pci_dev *bridge;
> +       u16 cmd;
> +
> +       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +       if (rsrc & VGA_RSRC_IO)
> +               cmd |= PCI_COMMAND_IO;
> +       if (rsrc & VGA_RSRC_MEM)
> +               cmd |= PCI_COMMAND_MEMORY;
> +       pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +       bus = pdev->bus;
> +       while (bus) {
> +               bridge = bus->self;
> +               if (bridge) {
> +                       pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
> +                       if (cmd & PCI_BRIDGE_CTL_VGA)
> +                               continue;

Same here.

> +                       cmd |= PCI_BRIDGE_CTL_VGA;
> +                       pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
> +               }
> +               bus = bus->parent;
> +       }
> +}
> +#endif

> +/*
> + * Currently, we assume that the "initial" setup of the system is
> + * sane, that is we don't come up with conflicting devices, which
> + * would be annoying. We could double check and be better at
> + * deciding who is the default here, but we don't. 
> + */
> +void vga_arbiter_add_pci_device(struct pci_dev *pdev)
> +{
> +       struct vga_device *vgadev;
> +       unsigned long flags;
> +       struct pci_bus *bus;
> +       struct pci_dev *bridge;
> +       u16 cmd;
> +
> +       /* Only deal with VGA class devices */
> +       if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> +               return;
> +
> +       /* Allocate structure */
> +       vgadev = kmalloc(sizeof(struct vga_device), GFP_KERNEL);

Not checking return value of kmalloc, this is evil :P
Also it may be worth to change return type in order to signal the error.

> +       memset(vgadev, 0, sizeof(*vgadev));
> +
> +       /* Take lock & check for duplicates */
> +       spin_lock_irqsave(&vga_lock, flags);
> +       if (vgadev_find(pdev) != NULL) {
> +               WARN_ON(1);
> +               goto fail;
> +       }
> +       vgadev->pdev = pdev;
> +
> +       /* By default, assume we decode everything */
> +       vgadev->decodes = VGA_RSRC_IO | VGA_RSRC_MEM;
> +
> +       /* Mark that we "own" resources based on our enables, we will
> +        * clear that below if the bridge isn't forwarding
> +        */
> +       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +       if (cmd & PCI_COMMAND_IO)
> +               vgadev->owns |= VGA_RSRC_IO;
> +       if (cmd & PCI_COMMAND_MEMORY)
> +               vgadev->owns |= VGA_RSRC_MEM;
> +
> +       /* Check if VGA cycles can get down to us */
> +       bus = pdev->bus;
> +       while (bus) {
> +               bridge = bus->self;
> +               if (bridge) {
> +                       u16 l;
> +                       pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &l);
> +                       if (!(l & PCI_BRIDGE_CTL_VGA)) {
> +                               vgadev->owns = 0;
> +                               break;
> +                       }
> +               }
> +               bus = bus->parent;
> +       }
> +
> +       /* Deal with VGA default device. Use first enabled one
> +        * by default if arch doesn't have it's own hook
> +        */
> +#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
> +       if (vga_default == NULL && (vgadev->owns & VGA_RSRC_MEM) &&
> +           (vgadev->owns & VGA_RSRC_IO))
> +               vga_default = pdev;
> +
> +#endif
> +
> +       /* Add to the list */
> +       list_add(&vgadev->list, &vga_list);
> +       spin_unlock_irqrestore(&vga_lock, flags);

Missing return?

> + fail:
> +       spin_unlock_irqrestore(&vga_lock, flags);
> +       kfree(vgadev);
> +}
> +
> +void vga_arbiter_del_pci_device(struct pci_dev *pdev)
> +{
> +       struct vga_device *vgadev;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&vga_lock, flags);
> +       vgadev = vgadev_find(pdev);
> +       if (vgadev == NULL)
> +               goto bail;
> +       if (vgadev->locks)
> +               __vga_put(vgadev, vgadev->locks);
> +       list_del(&vgadev->list);
> + bail:
> +       spin_unlock_irqrestore(&vga_lock, flags);
> +       if (vgadev)
> +               kfree(vgadev);

kfree(NULL) is fine, no need to check for null pointer.

> +}


Luca
-- 
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel
