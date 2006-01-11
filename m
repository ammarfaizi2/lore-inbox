Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWAKUVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWAKUVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWAKUVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:21:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:34510 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964808AbWAKUVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:21:41 -0500
Date: Wed, 11 Jan 2006 12:21:23 -0800
From: Greg KH <greg@kroah.com>
To: Mark Maule <maule@sgi.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060111202123.GC4367@kroah.com>
References: <20060111155251.12460.71269.12163@attica.americas.sgi.com> <20060111155256.12460.26048.32596@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111155256.12460.26048.32596@attica.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:52:56AM -0600, Mark Maule wrote:
> Abstract portions of the MSI core for platforms that do not use standard
> APIC interrupt controllers.  This is implemented through a new arch-specific
> msi setup routine, and a set of msi ops which can be set on a per platform
> basis.

Ah, much better, just a few more minor comments below:


> 
> Signed-off-by: Mark Maule <maule@sgi.com>
> 
> Index: linux-maule/drivers/pci/msi.c
> ===================================================================
> --- linux-maule.orig/drivers/pci/msi.c	2006-01-10 11:48:01.000000000 -0800
> +++ linux-maule/drivers/pci/msi.c	2006-01-10 13:40:45.000000000 -0800
> @@ -23,8 +23,6 @@
>  #include "pci.h"
>  #include "msi.h"
>  
> -#define MSI_TARGET_CPU		first_cpu(cpu_online_map)
> -
>  static DEFINE_SPINLOCK(msi_lock);
>  static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
>  static kmem_cache_t* msi_cachep;
> @@ -40,6 +38,15 @@
>  u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
>  #endif
>  
> +static struct msi_ops *msi_ops;
> +
> +int
> +msi_register(struct msi_ops *ops)
> +{
> +	msi_ops = ops;
> +	return 0;
> +}
> +
>  static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
>  {
>  	memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
> @@ -92,7 +99,7 @@
>  static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask)
>  {
>  	struct msi_desc *entry;
> -	struct msg_address address;
> +	u32 address_hi, address_lo;
>  	unsigned int irq = vector;
>  	unsigned int dest_cpu = first_cpu(cpu_mask);
>  
> @@ -108,28 +115,36 @@
>     		if (!(pos = pci_find_capability(entry->dev, PCI_CAP_ID_MSI)))
>  			return;
>  
> +		pci_read_config_dword(entry->dev, msi_upper_address_reg(pos),
> +			&address_hi);
>  		pci_read_config_dword(entry->dev, msi_lower_address_reg(pos),
> -			&address.lo_address.value);
> -		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
> -		address.lo_address.value |= (cpu_physical_id(dest_cpu) <<
> -									MSI_TARGET_CPU_SHIFT);
> -		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
> +			&address_lo);
> +
> +		msi_ops->target(vector, dest_cpu, &address_hi, &address_lo);
> +
> +		pci_write_config_dword(entry->dev, msi_upper_address_reg(pos),
> +			address_hi);
>  		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
> -			address.lo_address.value);
> +			address_lo);
>  		set_native_irq_info(irq, cpu_mask);
>  		break;
>  	}
>  	case PCI_CAP_ID_MSIX:
>  	{
> -		int offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
> -			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET;
> +		int offset_hi =
> +			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
> +				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET;
> +		int offset_lo =
> +			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
> +				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET;
> +
> +		address_hi = readl(entry->mask_base + offset_hi);
> +		address_lo = readl(entry->mask_base + offset_lo);
>  
> -		address.lo_address.value = readl(entry->mask_base + offset);
> -		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
> -		address.lo_address.value |= (cpu_physical_id(dest_cpu) <<
> -									MSI_TARGET_CPU_SHIFT);
> -		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
> -		writel(address.lo_address.value, entry->mask_base + offset);
> +		msi_ops->target(vector, dest_cpu, &address_hi, &address_lo);
> +
> +		writel(address_hi, entry->mask_base + offset_hi);
> +		writel(address_lo, entry->mask_base + offset_lo);
>  		set_native_irq_info(irq, cpu_mask);
>  		break;
>  	}
> @@ -249,30 +264,6 @@
>  	.set_affinity	= set_msi_irq_affinity
>  };
>  
> -static void msi_data_init(struct msg_data *msi_data,
> -			  unsigned int vector)
> -{
> -	memset(msi_data, 0, sizeof(struct msg_data));
> -	msi_data->vector = (u8)vector;
> -	msi_data->delivery_mode = MSI_DELIVERY_MODE;
> -	msi_data->level = MSI_LEVEL_MODE;
> -	msi_data->trigger = MSI_TRIGGER_MODE;
> -}
> -
> -static void msi_address_init(struct msg_address *msi_address)
> -{
> -	unsigned int	dest_id;
> -	unsigned long	dest_phys_id = cpu_physical_id(MSI_TARGET_CPU);
> -
> -	memset(msi_address, 0, sizeof(struct msg_address));
> -	msi_address->hi_address = (u32)0;
> -	dest_id = (MSI_ADDRESS_HEADER << MSI_ADDRESS_HEADER_SHIFT);
> -	msi_address->lo_address.u.dest_mode = MSI_PHYSICAL_MODE;
> -	msi_address->lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
> -	msi_address->lo_address.u.dest_id = dest_id;
> -	msi_address->lo_address.value |= (dest_phys_id << MSI_TARGET_CPU_SHIFT);
> -}
> -
>  static int msi_free_vector(struct pci_dev* dev, int vector, int reassign);
>  static int assign_msi_vector(void)
>  {
> @@ -367,6 +358,20 @@
>  		return status;
>  	}
>  
> +	if ((status = msi_arch_init()) < 0) {
> +		pci_msi_enable = 0;
> +		printk(KERN_WARNING
> +		       "PCI: MSI arch init failed.  MSI disabled.\n");
> +		return status;
> +	}
> +
> +	if (! msi_ops) {
> +		printk(KERN_WARNING
> +		       "PCI: MSI ops not registered. MSI disabled.\n");
> +		status = -EINVAL;
> +		return status;
> +	}
> +
>  	if ((status = msi_cache_init()) < 0) {
>  		pci_msi_enable = 0;
>  		printk(KERN_WARNING "PCI: MSI cache init failed\n");
> @@ -510,9 +515,11 @@
>   **/
>  static int msi_capability_init(struct pci_dev *dev)
>  {
> +	int status;
>  	struct msi_desc *entry;
> -	struct msg_address address;
> -	struct msg_data data;
> +	u32 address_lo;
> +	u32 address_hi;
> +	u32 data;
>  	int pos, vector;
>  	u16 control;
>  
> @@ -539,23 +546,26 @@
>  		entry->mask_base = (void __iomem *)(long)msi_mask_bits_reg(pos,
>  				is_64bit_address(control));
>  	}
> +	/* Configure MSI capability structure */
> +	status = msi_ops->setup(dev, vector,
> +				&address_hi,
> +				&address_lo,
> +				&data);
> +	if (status < 0) {
> +		kmem_cache_free(msi_cachep, entry);
> +		return status;
> +	}
>  	/* Replace with MSI handler */
>  	irq_handler_init(PCI_CAP_ID_MSI, vector, entry->msi_attrib.maskbit);
> -	/* Configure MSI capability structure */
> -	msi_address_init(&address);
> -	msi_data_init(&data, vector);
> -	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
> -				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
> -	pci_write_config_dword(dev, msi_lower_address_reg(pos),
> -			address.lo_address.value);
> +
> +	pci_write_config_dword(dev, msi_lower_address_reg(pos), address_lo);
>  	if (is_64bit_address(control)) {
>  		pci_write_config_dword(dev,
> -			msi_upper_address_reg(pos), address.hi_address);
> -		pci_write_config_word(dev,
> -			msi_data_reg(pos, 1), *((u32*)&data));
> +			msi_upper_address_reg(pos), address_hi);
> +		pci_write_config_word(dev, msi_data_reg(pos, 1), data);
>  	} else
> -		pci_write_config_word(dev,
> -			msi_data_reg(pos, 0), *((u32*)&data));
> +		pci_write_config_word(dev, msi_data_reg(pos, 0), data);
> +
>  	if (entry->msi_attrib.maskbit) {
>  		unsigned int maskbits, temp;
>  		/* All MSIs are unmasked by default, Mask them all */
> @@ -590,13 +600,15 @@
>  				struct msix_entry *entries, int nvec)
>  {
>  	struct msi_desc *head = NULL, *tail = NULL, *entry = NULL;
> -	struct msg_address address;
> -	struct msg_data data;
> +	u32 address_hi;
> +	u32 address_lo;
> +	u32 data;
>  	int vector, pos, i, j, nr_entries, temp = 0;
>  	u32 phys_addr, table_offset;
>   	u16 control;
>  	u8 bir;
>  	void __iomem *base;
> +	int status;
>  
>     	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
>  	/* Request & Map MSI-X table region */
> @@ -643,18 +655,20 @@
>  		/* Replace with MSI-X handler */
>  		irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
>  		/* Configure MSI-X capability structure */
> -		msi_address_init(&address);
> -		msi_data_init(&data, vector);
> -		entry->msi_attrib.current_cpu =
> -			((address.lo_address.u.dest_id >>
> -			MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
> -		writel(address.lo_address.value,
> +		status = msi_ops->setup(dev, vector,
> +					&address_hi,
> +					&address_lo,
> +					&data);
> +		if (status < 0)
> +			break;
> +
> +		writel(address_lo,
>  			base + j * PCI_MSIX_ENTRY_SIZE +
>  			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
> -		writel(address.hi_address,
> +		writel(address_hi,
>  			base + j * PCI_MSIX_ENTRY_SIZE +
>  			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
> -		writel(*(u32*)&data,
> +		writel(data,
>  			base + j * PCI_MSIX_ENTRY_SIZE +
>  			PCI_MSIX_ENTRY_DATA_OFFSET);
>  		attach_msi_entry(entry, vector);
> @@ -789,6 +803,8 @@
>  	void __iomem *base;
>  	unsigned long flags;
>  
> +	msi_ops->teardown(vector);
> +
>  	spin_lock_irqsave(&msi_lock, flags);
>  	entry = msi_desc[vector];
>  	if (!entry || entry->dev != dev) {
> Index: linux-maule/include/asm-i386/msi.h
> ===================================================================
> --- linux-maule.orig/include/asm-i386/msi.h	2006-01-10 11:47:42.000000000 -0800
> +++ linux-maule/include/asm-i386/msi.h	2006-01-10 11:58:55.000000000 -0800
> @@ -12,4 +12,11 @@
>  #define LAST_DEVICE_VECTOR		232
>  #define MSI_TARGET_CPU_SHIFT	12
>  
> +static inline int msi_arch_init(void)
> +{
> +	extern struct msi_ops msi_apic_ops;
> +	msi_register(&msi_apic_ops);
> +	return 0;
> +}

Don't have an extern in a function, it belongs in a .h file somewhere
that describes it and everyone can see it.  Otherwise this gets stale
and messy over time.

> +/*
> + * Generic callouts used on most archs/platforms.  Override with
> + * msi_register_callouts()
> + */

Care to use kerneldoc here and define exactly what is needed for these
function pointers?  And you are still calling them "callouts" here :)

> +struct msi_ops msi_apic_ops = {
> +	.setup = msi_setup_apic,
> +	.teardown = msi_teardown_apic,
> +#ifdef CONFIG_SMP
> +	.target = msi_target_apic,
> +#endif

Why the #ifdef?  Just drop it, it makes the code cleaner.

Care to redo this?

thanks,

greg k-h
