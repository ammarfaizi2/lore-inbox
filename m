Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVCIKuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVCIKuR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVCIKuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:50:16 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:62946 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261567AbVCIKpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:45:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FG5vkNVO+EQBysJeLXaABPC4RUwxXPLQgMs+dMAhKkClk6N6ymUnKVFJRWVOFHFtgMexXcSsZjdZdOxUmmAhhKHZBrcCNtTpXu7fejh0M4DaruNtOfGhSL0X1XEfGJV9lVObcJNql97/gT2grLgRqN36fJxq2gcyNpVRp4zHPRg=
Message-ID: <84144f0205030902451571def3@mail.gmail.com>
Date: Wed, 9 Mar 2005 12:45:32 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
Cc: xorg@freedesktop.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>, penberg@cs.helsinki.fi
In-Reply-To: <1110265919.13607.261.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110265919.13607.261.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Few coding style nitpicks follow.

On Tue, 08 Mar 2005 18:11:59 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Index: linux-work/include/linux/pci.h
> ===================================================================
> --- linux-work.orig/include/linux/pci.h	2005-01-24 17:09:57.000000000 +1100
> +++ linux-work/include/linux/pci.h	2005-03-08 15:26:25.000000000 +1100
> @@ -1064,5 +1064,6 @@
>  #define PCIPCI_VSFX		16
>  #define PCIPCI_ALIMAGIK		32
>  
> +
>  #endif /* __KERNEL__ */
>  #endif /* LINUX_PCI_H */

Please drop whitespace noise from the patch.

> Index: linux-work/drivers/pci/vga.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/drivers/pci/vga.c	2005-03-08 18:04:57.000000000 +1100
> @@ -0,0 +1,403 @@
> +static LIST_HEAD(		vga_list);

Please remove whitespace damage.

> +static spinlock_t	       	vga_lock;
> +static DECLARE_WAIT_QUEUE_HEAD(	vga_wait_queue);

Ditto.

> +/* Architecture can override enabling/disabling of a given
> + * device resources here
> + */
> +#ifndef __ARCH_HAS_VGA_DISABLE_RESOURCES
> +static inline void vga_disable_resources(struct pci_dev *pdev,
> +					 unsigned int rsrc,
> +					 unsigned int change_bridge)
> +{
> +	struct pci_bus *bus;
> +	struct pci_dev *bridge;
> +	u16 cmd;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	if (rsrc & VGA_RSRC_IO)
> +		cmd &= ~PCI_COMMAND_IO;
> +	if (rsrc & VGA_RSRC_MEM)
> +		cmd &= ~PCI_COMMAND_MEMORY;
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	if (!change_bridge)
> +		return;
> +
> +	bus = pdev->bus;
> +	while (bus) {
> +		bridge = bus->self;
> +		if (bridge) {
> +			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
> +			if (!(cmd & PCI_BRIDGE_CTL_VGA))
> +				continue;
> +			cmd &= ~PCI_BRIDGE_CTL_VGA;
> +			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
> +		}
> +		bus = bus->parent;

See comment below.

> +	}
> +}
> +#endif
> +
> +#ifndef __ARCH_HAS_VGA_ENABLE_RESOURCES
> +static inline void vga_enable_resources(struct pci_dev *pdev,
> +					 unsigned int rsrc)
> +{
> +	struct pci_bus *bus;
> +	struct pci_dev *bridge;
> +	u16 cmd;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	if (rsrc & VGA_RSRC_IO)
> +		cmd |= PCI_COMMAND_IO;
> +	if (rsrc & VGA_RSRC_MEM)
> +		cmd |= PCI_COMMAND_MEMORY;
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	bus = pdev->bus;
> +	while (bus) {
> +		bridge = bus->self;
> +		if (bridge) {
> +			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
> +			if (cmd & PCI_BRIDGE_CTL_VGA)
> +				continue;
> +			cmd |= PCI_BRIDGE_CTL_VGA;
> +			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
> +		}
> +		bus = bus->parent;

Please consolidate both while loops into one function. One possible way would
be to do:

static void vga_update_bus(struct pci_bus *bus, unsigned int enable)
{
	while (bus) {
		bridge = bus->self;
		if (bridge) {
			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
			if (cmd & PCI_BRIDGE_CTL_VGA)
				continue;
			if (enable)
				cmd |= PCI_BRIDGE_CTL_VGA;
			else
				cmd &= ~PCI_BRIDGE_CTL_VGA;
			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
		}
		bus = bus->parent;
	}
}

> +/*
> + * Currently, we assume that the "initial" setup of the system is
> + * sane, that is we don't come up with conflicting devices, which
> + * would be annoying. We could double check and be better at
> + * deciding who is the default here, but we don't. 
> + */
> +void vga_arbiter_add_pci_device(struct pci_dev *pdev)
> +{
> +	struct vga_device *vgadev;
> +	unsigned long flags;
> +	struct pci_bus *bus;
> +	struct pci_dev *bridge;
> +	u16 cmd;
> +
> +	/* Only deal with VGA class devices */
> +	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
> +		return;
> +
> +	/* Allocate structure */
> +	vgadev = kmalloc(sizeof(struct vga_device), GFP_KERNEL);
> +	memset(vgadev, 0, sizeof(*vgadev));

Please consider using kcalloc() here.

                                          Pekka
