Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVF1SWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVF1SWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVF1SWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:22:37 -0400
Received: from fmr19.intel.com ([134.134.136.18]:35458 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262184AbVF1SW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:22:27 -0400
Subject: Re: [patch 2/2] i386/x86_64: collect host bridge resources v2
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: rajesh.shah@intel.com, gregkh@suse.de, ak@suse.de, len.brown@intel.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, acpi-devel@lists.sourceforge.net
In-Reply-To: <20050628155152.A24551@jurassic.park.msu.ru>
References: <20050602224147.177031000@csdlinux-1>
	 <20050602224327.051278000@csdlinux-1>
	 <20050628155152.A24551@jurassic.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jun 2005 11:21:54 -0700
Message-Id: <1119982914.19258.6.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 28 Jun 2005 18:21:56.0002 (UTC) FILETIME=[43DF4820:01C57C0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 15:51 +0400, Ivan Kokshaysky wrote:
> [This refers to "gregkh-pci-pci-collect-host-bridge-resources-02.patch"
> which went into 2.6.12-mm1 and -mm2]
> 
> On Thu, Jun 02, 2005 at 03:41:49PM -0700, rajesh.shah@intel.com wrote:
> > This patch reads and stores host bridge resources reported by
> > ACPI BIOS for i386 and x86_64 systems.  This is needed since
> > ACPI hotplug code now uses the PCI core for resource management. 
> 
> That patch introduces two major problems.
> 
> 1. The new root bus resources aren't properly inserted into global
>    resource tree (missing request_resource calls). This leads to
>    completely messed up PCI setup, especially with
>    pci_assign_unassigned_resources() call, as seen in -mm1 (mm2 is
>    also unsafe, though).
> 
> 2. Transparent bridge handling is broken, no matter is it old code
>    in Linus' tree or the new one in -mm. At the point then
>    pcibios_setup_root_windows() is called, the "transparent"
>    resource pointers have been already set up in pci_read_bridge_bases()
>    (typically to ioport_resource and iomem_resource), so after changing
>    the root bus windows these pointers are wrong.
> 
> The appended patch fixes that. Just compare /proc/ioports and /proc/iomem
> with and without it. ;-)
> 


I gave this patch a try (against mm2), and found that I now get many
errors on boot up complaining about not being able to allocate PCI
resources due to resource collisions, and then the system begins to
complain about lost interrupts on hda, and is never able to mount the
root filesystem.
Kristen


> Ivan.
> 
> --- 2.6.12-mm2/arch/i386/pci/acpi.c	2005-06-28 13:30:24.000000000 +0400
> +++ linux/arch/i386/pci/acpi.c	2005-06-28 14:13:51.000000000 +0400
> @@ -107,10 +107,22 @@ verify_root_windows(struct pci_bus *bus)
>  			continue;
>  		switch (bus->resource[i]->flags & type_mask) {
>  			case IORESOURCE_IO:
> -				num_io++;
> +				if (!request_resource(&ioport_resource,
> +						      bus->resource[i]))
> +					num_io++;
> +				else {
> +					kfree(bus->resource[i]);
> +					bus->resource[i] = NULL;
> +				}
>  				break;
>  			case IORESOURCE_MEM:
> -				num_mem++;
> +				if (!request_resource(&iomem_resource,
> +						      bus->resource[i]))
> +					num_mem++;
> +				else {
> +					kfree(bus->resource[i]);
> +					bus->resource[i] = NULL;
> +				}
>  				break;
>  			default:
>  				break;
> @@ -126,6 +138,21 @@ verify_root_windows(struct pci_bus *bus)
>  }
>  
>  static void __devinit
> +fixup_transparent_bridges(struct list_head *bus_list)
> +{
> +	int i;
> +	struct pci_bus *b;
> +
> +	list_for_each_entry(b, bus_list, node) {
> +		if (b->self && b->self->transparent) {
> +			for (i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
> +				b->resource[i] = b->parent->resource[i - 3];
> +		}
> +		fixup_transparent_bridges(&b->children);
> +	}
> +}
> +
> +static void __devinit
>  pcibios_setup_root_windows(struct pci_bus *bus, acpi_handle handle)
>  {
>  	int i;
> @@ -147,6 +174,21 @@ pcibios_setup_root_windows(struct pci_bu
>  			kfree(bus->resource[i]);
>  			bus->resource[i] = bres[i];
>  		}
> +	} else {
> +		/* Squeeze out unused resource pointers. */
> +		int idx = 0;
> +
> +		for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
> +			if (bus->resource[i])
> +				bus->resource[idx++] = bus->resource[i];
> +		}
> +		for (; idx < PCI_BUS_NUM_RESOURCES; idx++)
> +			bus->resource[idx] = NULL;
> +
> +		/* The root bus resources have been changed. Fix up the
> +		   resource pointers of buses behind "transparent" bridges
> +		   as well. */
> +		fixup_transparent_bridges(&bus->children);
>  	}
>  }
>  
