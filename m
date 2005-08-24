Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVHXPun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVHXPun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVHXPun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:50:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:47081 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751080AbVHXPul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:50:41 -0400
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
From: John Rose <johnrose@austin.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: paulus@samba.org, benh@kernel.crashing.org, akpm@osdl.org,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050823234747.GI18113@austin.ibm.com>
References: <20050823231817.829359000@bilge>
	 <20050823232143.003048000@bilge>  <20050823234747.GI18113@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1124898331.24668.33.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 24 Aug 2005 10:45:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linas-

I like the idea of splitting the recovery stuff into its own driver.  A
few comments on the last reorg patch:

> Index: linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh.c
...
> +static int
> +eeh_slot_availability(struct device_node *dn)
...
> +void eeh_restore_bars(struct device_node *dn)

Inconsistent spacing in new code... </nit>

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.13-rc6-git9/arch/ppc64/kernel/eeh_driver.c	2005-08-23 14:34:44.000000000 -0500
> @@ -0,0 +1,361 @@
> +/*
> + * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.

This probably isn't the right header description for this file :)

> +
> +/**
> + * rpaphp_find_slot - find and return the slot holding the device
> + * @dev: pci device for which we want the slot structure.
> + */
> +static struct slot *rpaphp_find_slot(struct pci_dev *dev)
> +{
> +	struct list_head *tmp, *n;
> +	struct slot	*slot;
> +
> +	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
> +		struct pci_bus *bus;
> +
> +		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
> +
> +		/* PHB's don't have bridges. */
> +		bus = slot->bus;
> +		if (bus == NULL)
> +			continue;
> +
> +		/* The PCI device could be the slot itself. */
> +		if (bus->self == dev)
> +			return slot;
> +
> +		if (pci_search_bus_for_dev (bus, dev))
> +			return slot;
> +	}
> +	return NULL;
> +}

This function breaks if rpaphp is compiled as a module.  It's probably
bad for kernel code to depend on symbols exported from modules.  This
raises two larger questions: Where should this new driver sit, and
should it be possible to compile it as a module as well?

> +/* ------------------------------------------------------- */
> +/**
> + * handle_eeh_events -- reset a PCI device after hard lockup.
> + *
...
> +int eeh_reset_device (struct pci_dev *dev, struct device_node *dn, int reconfig)

Header doesn't match the function :)

> +{
> +	struct hotplug_slot *frozen_slot= NULL;
> +	struct hotplug_slot_ops *frozen_ops= NULL;
> +
> +	if (!dev)
> +		return 1;
> +
> +	if (reconfig) {
> +		frozen_slot = pci_hp_find_slot(dev);
> +		if (frozen_slot)
> +			frozen_ops = frozen_slot->ops;
> +	}
> +
> +	if (frozen_ops) frozen_ops->disable_slot (frozen_slot);
> +
> +	/* Reset the pci controller. (Asserts RST#; resets config space).
> +	 * Reconfigure bridges and devices */
> +	rtas_set_slot_reset (dn->child);
> +
> +	/* Walk over all functions on this device */
> +	struct device_node *peer = dn->child;
> +	while (peer) {
> +		rtas_configure_bridge(peer);
> +		eeh_restore_bars(peer);
> +		peer = peer->sibling;
> +	}
> +
> +	/* Give the system 5 seconds to finish running the user-space
> +	 * hotplug scripts, e.g. ifdown for ethernet.  Yes, this is a hack,
> +	 * but if we don't do this, weird things happen.
> +	 */
> +	if (frozen_ops) {
> +		ssleep (5);
> +		frozen_ops->enable_slot (frozen_slot);
> +	}
> +	return 0;
> +}

This dependence on struct hotplug_slot might be problematic as we
restrict the registration of "PCI hotplug" slots to exclude PHBs, VIO,
and embedded slots.  Noticed your comment to this effect.  I can work
with you offline on this.

> +
> +/* The longest amount of time to wait for a pci device
> + * to come back on line, in seconds.
> + */
> +#define MAX_WAIT_FOR_RECOVERY 15
> +
> +int handle_eeh_events (struct eeh_event *event)
> +{
> +	
...
> +	frozen_device = pci_bus_to_OF_node(dev->bus);
> +	if (!frozen_device)
> +	{
> +		printk (KERN_ERR "EEH: Cannot find PCI controller for %s\n",
> +				pci_name(dev));
> +
> +		return 1;
> +	}
> +	BUG_ON (frozen_device->phb==NULL);
> +
> +	/* We get "permanent failure" messages on empty slots.
> +	 * These are false alarms. Empty slots have no child dn. */
> +	if ((event->state == pci_channel_io_perm_failure) && (frozen_device == NULL))

The second part of this conditional will never be true, as this has just
been checked above.

> +       if (frozen_device)
> +               freeze_count = frozen_device->eeh_freeze_count;

This conditional will always be true, as this has also ben checked
above.

> Index: linux-2.6.13-rc6-git9/include/asm-ppc64/prom.h
> ===================================================================
> --- linux-2.6.13-rc6-git9.orig/include/asm-ppc64/prom.h	2005-08-19 15:11:39.000000000 -0500
> +++ linux-2.6.13-rc6-git9/include/asm-ppc64/prom.h	2005-08-23 13:31:52.000000000 -0500
> @@ -135,11 +135,17 @@
>  	int	busno;			/* for pci devices */
>  	int	bussubno;		/* for pci devices */
>  	int	devfn;			/* for pci devices */
> -	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
> -	int	eeh_config_addr;
> +	int   eeh_mode;      /* See eeh.h for possible EEH_MODEs */
> +	int   eeh_config_addr;
> +	int   eeh_check_count;    /* number of times device driver ignored error */
> +	int   eeh_freeze_count;   /* number of times this device froze up. */
> +	int   eeh_is_bridge;      /* device is pci-to-pci bridge */
> +
>  	int	pci_ext_config_space;	/* for pci devices */
>  	struct  pci_controller *phb;	/* for pci devices */
>  	struct	iommu_table *iommu_table;	/* for phb's or bridges */
> +	struct   pci_dev *pcidev;    /* back-pointer to the pci device */
> +	u32      config_space[16]; /* saved PCI config space */
>  
>  	struct	property *properties;
>  	struct	device_node *parent;

How about a pointer to a struct of EEH fields?  Folks are touchy about
adding anything PCI-specific to device nodes, especially since most DNs
aren't PCI at all.

Thanks-
John

