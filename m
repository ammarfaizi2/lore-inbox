Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVAaTnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVAaTnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVAaTnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:43:41 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29866 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261327AbVAaTkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:40:06 -0500
Message-ID: <41FE8994.4040802@us.ibm.com>
Date: Mon, 31 Jan 2005 13:40:04 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: brking@us.ibm.com
CC: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Subject: Re: pci: Arch hook to determine config space size
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050128185234.GB21760@infradead.org> <20050129040647.GA6261@kroah.com> <41FE82B6.9060407@us.ibm.com>
In-Reply-To: <41FE82B6.9060407@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian King wrote:
> Greg KH wrote:
> 
>> On Fri, Jan 28, 2005 at 06:52:34PM +0000, Christoph Hellwig wrote:
>>
>>>> +int __attribute__ ((weak)) pcibios_exp_cfg_space(struct pci_dev 
>>>> *dev) { return 1; }
>>>
>>>
>>> - prototypes belong to headers
>>> - weak linkage is the perfect way for total obsfucation
>>>
>>> please make this a regular arch hook
>>
>>
>>
>> I agree.  Also, when sending PCI related patches, please cc the
>> linux-pci mailing list.

CC'ing the linux-pci mailing list...

-brian

> How about this?
> 
> 
> ------------------------------------------------------------------------
> 
> 
> When working with a PCI-X Mode 2 adapter on a PCI-X Mode 1 PPC64
> system, the current code used to determine the config space size
> of a device results in a PCI Master abort and an EEH error, resulting
> in the device being taken offline. This patch adds an arch hook so
> that individual archs can indicate if the underlying system supports
> expanded config space accesses or not.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>
> ---
> 
>  linux-2.6.11-rc2-bk9-bjking1/arch/alpha/kernel/pci.c            |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/arm/kernel/bios32.c           |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/frv/mb93090-mb00/pci-frv.c    |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/i386/pci/common.c             |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/ia64/pci/pci.c                |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/m68knommu/kernel/comempci.c   |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/mips/pci/pci.c                |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/mips/pmc-sierra/yosemite/ht.c |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/parisc/kernel/pci.c           |    1 
>  linux-2.6.11-rc2-bk9-bjking1/arch/ppc/kernel/pci.c              |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/iSeries_pci.c    |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pci.c            |   18 ++++++++++
>  linux-2.6.11-rc2-bk9-bjking1/arch/sh/boards/mpc1211/pci.c       |    1 
>  linux-2.6.11-rc2-bk9-bjking1/arch/sh/boards/overdrive/galileo.c |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/sh/drivers/pci/pci.c          |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/sh64/kernel/pcibios.c         |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/sparc/kernel/pcic.c           |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/sparc64/kernel/pci.c          |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/arch/v850/kernel/rte_mb_a_pci.c    |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/drivers/pci/probe.c                |    2 +
>  linux-2.6.11-rc2-bk9-bjking1/include/linux/pci.h                |    1 
>  21 files changed, 55 insertions(+)
> 
> diff -puN drivers/pci/probe.c~pci_get_cfg_size_all drivers/pci/probe.c
> --- linux-2.6.11-rc2-bk9/drivers/pci/probe.c~pci_get_cfg_size_all	2005-01-31 11:16:22.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/drivers/pci/probe.c	2005-01-31 11:22:07.000000000 -0600
> @@ -653,6 +653,8 @@ static int pci_cfg_space_size(struct pci
>  			goto fail;
>  	}
>  
> +	if (!pcibios_exp_cfg_space(dev))
> +		goto fail;
>  	if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
>  		goto fail;
>  	if (status == 0xffffffff)
> diff -puN arch/alpha/kernel/pci.c~pci_get_cfg_size_all arch/alpha/kernel/pci.c
> --- linux-2.6.11-rc2-bk9/arch/alpha/kernel/pci.c~pci_get_cfg_size_all	2005-01-31 11:16:33.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/alpha/kernel/pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -202,6 +202,8 @@ pcibios_setup(char *str)
>  	return str;
>  }
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> +
>  #ifdef ALPHA_RESTORE_SRM_SETUP
>  static struct pdev_srm_saved_conf *srm_saved_configs;
>  
> diff -puN arch/arm/kernel/bios32.c~pci_get_cfg_size_all arch/arm/kernel/bios32.c
> --- linux-2.6.11-rc2-bk9/arch/arm/kernel/bios32.c~pci_get_cfg_size_all	2005-01-31 11:16:43.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/arm/kernel/bios32.c	2005-01-31 11:22:27.000000000 -0600
> @@ -67,6 +67,8 @@ void pcibios_report_status(u_int status_
>  	}
>  }
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> +
>  /*
>   * We don't use this to fix the device, but initialisation of it.
>   * It's not the correct use for this, but it works.
> diff -puN arch/frv/mb93090-mb00/pci-frv.c~pci_get_cfg_size_all arch/frv/mb93090-mb00/pci-frv.c
> --- linux-2.6.11-rc2-bk9/arch/frv/mb93090-mb00/pci-frv.c~pci_get_cfg_size_all	2005-01-31 11:16:55.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/frv/mb93090-mb00/pci-frv.c	2005-01-31 11:22:27.000000000 -0600
> @@ -286,3 +286,5 @@ void pcibios_set_master(struct pci_dev *
>  	printk(KERN_DEBUG "PCI: Setting latency timer of device %s to %d\n", pci_name(dev), lat);
>  	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
>  }
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/i386/pci/common.c~pci_get_cfg_size_all arch/i386/pci/common.c
> --- linux-2.6.11-rc2-bk9/arch/i386/pci/common.c~pci_get_cfg_size_all	2005-01-31 11:17:01.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/i386/pci/common.c	2005-01-31 11:22:27.000000000 -0600
> @@ -249,3 +249,5 @@ int pcibios_enable_device(struct pci_dev
>  
>  	return pcibios_enable_irq(dev);
>  }
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/ia64/pci/pci.c~pci_get_cfg_size_all arch/ia64/pci/pci.c
> --- linux-2.6.11-rc2-bk9/arch/ia64/pci/pci.c~pci_get_cfg_size_all	2005-01-31 11:17:09.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/ia64/pci/pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -744,3 +744,5 @@ int pci_vector_resources(int last, int n
>  
>  	return count;
>  }
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/m68knommu/kernel/comempci.c~pci_get_cfg_size_all arch/m68knommu/kernel/comempci.c
> --- linux-2.6.11-rc2-bk9/arch/m68knommu/kernel/comempci.c~pci_get_cfg_size_all	2005-01-31 11:17:23.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/m68knommu/kernel/comempci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -987,3 +987,5 @@ void pci_free_consistent(struct pci_dev 
>  }
>  
>  /*****************************************************************************/
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/mips/pci/pci.c~pci_get_cfg_size_all arch/mips/pci/pci.c
> --- linux-2.6.11-rc2-bk9/arch/mips/pci/pci.c~pci_get_cfg_size_all	2005-01-31 11:17:33.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/mips/pci/pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -300,3 +300,5 @@ char *pcibios_setup(char *str)
>  {
>  	return str;
>  }
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/mips/pmc-sierra/yosemite/ht.c~pci_get_cfg_size_all arch/mips/pmc-sierra/yosemite/ht.c
> --- linux-2.6.11-rc2-bk9/arch/mips/pmc-sierra/yosemite/ht.c~pci_get_cfg_size_all	2005-01-31 11:17:44.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/mips/pmc-sierra/yosemite/ht.c	2005-01-31 11:22:27.000000000 -0600
> @@ -451,4 +451,6 @@ unsigned __init int pcibios_assign_all_b
>          return 0;
>  }
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> +
>  #endif /* CONFIG_HYPERTRANSPORT */
> diff -puN arch/parisc/kernel/pci.c~pci_get_cfg_size_all arch/parisc/kernel/pci.c
> --- linux-2.6.11-rc2-bk9/arch/parisc/kernel/pci.c~pci_get_cfg_size_all	2005-01-31 11:17:50.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/parisc/kernel/pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -330,6 +330,7 @@ int pcibios_enable_device(struct pci_dev
>  	return 0;
>  }
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
>  
>  /* PA-RISC specific */
>  void pcibios_register_hba(struct pci_hba_data *hba)
> diff -puN arch/ppc/kernel/pci.c~pci_get_cfg_size_all arch/ppc/kernel/pci.c
> --- linux-2.6.11-rc2-bk9/arch/ppc/kernel/pci.c~pci_get_cfg_size_all	2005-01-31 11:18:02.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/ppc/kernel/pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -1728,6 +1728,8 @@ void pci_iounmap(struct pci_dev *dev, vo
>  EXPORT_SYMBOL(pci_iomap);
>  EXPORT_SYMBOL(pci_iounmap);
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> +
>  /*
>   * Null PCI config access functions, for the case when we can't
>   * find a hose.
> diff -puN arch/ppc64/kernel/iSeries_pci.c~pci_get_cfg_size_all arch/ppc64/kernel/iSeries_pci.c
> --- linux-2.6.11-rc2-bk9/arch/ppc64/kernel/iSeries_pci.c~pci_get_cfg_size_all	2005-01-31 11:18:09.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/iSeries_pci.c	2005-01-31 11:22:20.000000000 -0600
> @@ -348,6 +348,8 @@ void pcibios_fixup_resources(struct pci_
>  	PPCDBG(PPCDBG_BUSWALK, "fixup_resources pdev %p\n", pdev);
>  }   
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 0; }
> +
>  /*
>   * Loop through each node function to find usable EADs bridges.  
>   */
> diff -puN arch/ppc64/kernel/pci.c~pci_get_cfg_size_all arch/ppc64/kernel/pci.c
> --- linux-2.6.11-rc2-bk9/arch/ppc64/kernel/pci.c~pci_get_cfg_size_all	2005-01-31 11:18:13.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/ppc64/kernel/pci.c	2005-01-31 11:22:20.000000000 -0600
> @@ -467,6 +467,24 @@ void pcibios_add_platform_entries(struct
>  
>  #ifdef CONFIG_PPC_MULTIPLATFORM
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev)
> +{
> +	int *type;
> +	struct device_node *dn;
> +	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> +
> +	if (!hose)
> +		return 0;
> +
> +	dn = (struct device_node *) hose->arch_data;
> +	type = (int *)get_property(dn, "ibm,pci-config-space-type", NULL);
> +
> +	if (type && *type == 1)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  #define ISA_SPACE_MASK 0x1
>  #define ISA_SPACE_IO 0x1
>  
> diff -puN arch/sh/boards/mpc1211/pci.c~pci_get_cfg_size_all arch/sh/boards/mpc1211/pci.c
> --- linux-2.6.11-rc2-bk9/arch/sh/boards/mpc1211/pci.c~pci_get_cfg_size_all	2005-01-31 11:18:24.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/sh/boards/mpc1211/pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -294,3 +294,4 @@ void pcibios_align_resource(void *data, 
>  	}
>  }
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/sh/boards/overdrive/galileo.c~pci_get_cfg_size_all arch/sh/boards/overdrive/galileo.c
> --- linux-2.6.11-rc2-bk9/arch/sh/boards/overdrive/galileo.c~pci_get_cfg_size_all	2005-01-31 11:18:33.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/sh/boards/overdrive/galileo.c	2005-01-31 11:22:27.000000000 -0600
> @@ -586,3 +586,5 @@ void pcibios_set_master(struct pci_dev *
>  	printk("PCI: Setting latency timer of device %s to %d\n", pci_name(dev), lat);
>  	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
>  }
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/sh/drivers/pci/pci.c~pci_get_cfg_size_all arch/sh/drivers/pci/pci.c
> --- linux-2.6.11-rc2-bk9/arch/sh/drivers/pci/pci.c~pci_get_cfg_size_all	2005-01-31 11:18:49.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/sh/drivers/pci/pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -153,3 +153,5 @@ void __init pcibios_update_irq(struct pc
>  {
>  	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>  }
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/sh64/kernel/pcibios.c~pci_get_cfg_size_all arch/sh64/kernel/pcibios.c
> --- linux-2.6.11-rc2-bk9/arch/sh64/kernel/pcibios.c~pci_get_cfg_size_all	2005-01-31 11:19:47.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/sh64/kernel/pcibios.c	2005-01-31 11:22:27.000000000 -0600
> @@ -166,3 +166,5 @@ void __init pcibios_update_irq(struct pc
>  {
>  	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>  }
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/sparc/kernel/pcic.c~pci_get_cfg_size_all arch/sparc/kernel/pcic.c
> --- linux-2.6.11-rc2-bk9/arch/sparc/kernel/pcic.c~pci_get_cfg_size_all	2005-01-31 11:19:52.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/sparc/kernel/pcic.c	2005-01-31 11:22:27.000000000 -0600
> @@ -1033,3 +1033,5 @@ void insl(void * __iomem addr, void *dst
>  }
>  
>  subsys_initcall(pcic_init);
> +
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> diff -puN arch/sparc64/kernel/pci.c~pci_get_cfg_size_all arch/sparc64/kernel/pci.c
> --- linux-2.6.11-rc2-bk9/arch/sparc64/kernel/pci.c~pci_get_cfg_size_all	2005-01-31 11:20:02.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/sparc64/kernel/pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -809,4 +809,6 @@ int pcibios_prep_mwi(struct pci_dev *dev
>  	return 0;
>  }
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> +
>  #endif /* !(CONFIG_PCI) */
> diff -puN arch/v850/kernel/rte_mb_a_pci.c~pci_get_cfg_size_all arch/v850/kernel/rte_mb_a_pci.c
> --- linux-2.6.11-rc2-bk9/arch/v850/kernel/rte_mb_a_pci.c~pci_get_cfg_size_all	2005-01-31 11:20:15.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/arch/v850/kernel/rte_mb_a_pci.c	2005-01-31 11:22:27.000000000 -0600
> @@ -337,6 +337,8 @@ void pcibios_set_master (struct pci_dev 
>  {
>  }
>  
> +int pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
> +
>  
>  /* Mother-A SRAM memory allocation.  This is a simple first-fit allocator.  */
>  
> diff -puN include/linux/pci.h~pci_get_cfg_size_all include/linux/pci.h
> --- linux-2.6.11-rc2-bk9/include/linux/pci.h~pci_get_cfg_size_all	2005-01-31 11:20:30.000000000 -0600
> +++ linux-2.6.11-rc2-bk9-bjking1/include/linux/pci.h	2005-01-31 11:22:07.000000000 -0600
> @@ -723,6 +723,7 @@ extern struct list_head pci_devices;	/* 
>  void pcibios_fixup_bus(struct pci_bus *);
>  int pcibios_enable_device(struct pci_dev *, int mask);
>  char *pcibios_setup (char *str);
> +int pcibios_exp_cfg_space(struct pci_dev *dev);
>  
>  /* Used only when drivers/pci/setup.c is used */
>  void pcibios_align_resource(void *, struct resource *,
> _


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
