Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVLVUBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVLVUBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 15:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbVLVUBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 15:01:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:64970 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965177AbVLVUBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 15:01:33 -0500
Date: Thu, 22 Dec 2005 11:58:14 -0800
From: Greg KH <greg@kroah.com>
To: Mark Maule <maule@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20051222195814.GA14332@kroah.com>
References: <20051222171616.8240.37671.12506@lnx-maule.americas.sgi.com> <20051222171621.8240.71918.22618@lnx-maule.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222171621.8240.71918.22618@lnx-maule.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 11:15:13AM -0600, Mark Maule wrote:
> Abstract portions of the MSI core for platforms that do not use standard
> APIC interrupt controllers.  This is implemented through a new arch-specific
> msi setup routine, and a set of msi ops which can be set on a per platform
> basis.
> 
> Signed-off-by: Mark Maule <maule@sgi.com>

Hm, care to CC: the linux-pci and pci maintainer next time?  And you
also might want to run this by the original MSI authors...

And you might want to cc: the ppc64 developers, as they are looking into
how to add MSI support to their platform, and are doing much of this
same "make MSI be more arch neutral" work.  They need to agree with
these changes before I can accept them.

> --- msi.orig/drivers/pci/msi.c	2005-12-13 12:22:42.784269607 -0600
> +++ msi/drivers/pci/msi.c	2005-12-21 22:59:09.200800164 -0600
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

Please put the return type on the same line as the function, especially
as the rest of the pci code is this way...

> +{
> +	msi_ops = ops;
> +	return 0;

Why return anything as this will always succeed?  Just make it a void
function please.

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

No extra space after "!" please.

> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ msi/drivers/pci/msi-apic.c	2005-12-22 11:09:37.022232088 -0600
> @@ -0,0 +1,102 @@
> +/*
> + * MSI hooks for standard x86 apic
> + */

No copyright notice?  People to blame/authors names?

> +#include <linux/pci.h>
> +
> +#include "msi.h"
> +
> +/*
> + * Shifts for APIC-based data
> + */
> +
> +#define MSI_DATA_VECTOR_SHIFT		0
> +#define	    MSI_DATA_VECTOR(v)		(((u8)v) << MSI_DATA_VECTOR_SHIFT)
> +
> +#define MSI_DATA_DELIVERY_SHIFT		8
> +#define     MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_SHIFT)
> +#define     MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_SHIFT)
> +
> +#define MSI_DATA_LEVEL_SHIFT		14
> +#define     MSI_DATA_LEVEL_DEASSERT	(0 << MSI_DATA_LEVEL_SHIFT)
> +#define     MSI_DATA_LEVEL_ASSERT	(1 << MSI_DATA_LEVEL_SHIFT)
> +
> +#define MSI_DATA_TRIGGER_SHIFT		15
> +#define     MSI_DATA_TRIGGER_EDGE	(0 << MSI_DATA_TRIGGER_SHIFT)
> +#define     MSI_DATA_TRIGGER_LEVEL	(1 << MSI_DATA_TRIGGER_SHIFT)
> +
> +/*
> + * Shift/mask fields for APIC-based bus address
> + */
> +
> +#define MSI_ADDR_HEADER			0xfee00000
> +
> +#define MSI_ADDR_DESTID_MASK		0xfff0000f
> +#define     MSI_ADDR_DESTID_CPU(cpu)	((cpu) << MSI_TARGET_CPU_SHIFT)
> +
> +#define MSI_ADDR_DESTMODE_SHIFT		2
> +#define     MSI_ADDR_DESTMODE_PHYS	(0 << MSI_ADDR_DESTMODE_SHIFT)
> +#define	    MSI_ADDR_DESTMODE_LOGIC	(1 << MSI_ADDR_DESTMODE_SHIFT)
> +
> +#define MSI_ADDR_REDIRECTION_SHIFT	3
> +#define     MSI_ADDR_REDIRECTION_CPU	(0 << MSI_ADDR_REDIRECTION_SHIFT)
> +#define     MSI_ADDR_REDIRECTION_LOWPRI	(1 << MSI_ADDR_REDIRECTION_SHIFT)
> +
> +
> +static void
> +msi_target_apic(unsigned int vector,
> +		unsigned int dest_cpu,
> +		u32 *address_hi,	/* in/out */
> +		u32 *address_lo)	/* in/out */

Please put this on one line, like mentioned above (within line limits).
If you want to comment the parameters, do it in the proper kerneldoc
way.

> +struct msi_ops msi_apic_ops = {
> +	.setup = msi_setup_apic,
> +	.teardown = msi_teardown_apic,
> +#ifdef CONFIG_SMP
> +	.target = msi_target_apic,
> +#endif

Why ifdef this for SMP?

>  struct msi_desc {
>  	struct {
>  		__u8	type	: 5; 	/* {0: unused, 5h:MSI, 11h:MSI-X} */
> @@ -138,7 +77,7 @@
>  		__u8	reserved: 1; 	/* reserved			  */
>  		__u8	entry_nr;    	/* specific enabled entry 	  */
>  		__u8	default_vector; /* default pre-assigned vector    */
> -		__u8	current_cpu; 	/* current destination cpu	  */
> +		__u8	unused; 	/* formerly unused destination cpu*/

Can't you just remove this?  Or where does this structure come from?

> +struct msi_ops {

pci_msi_ops?  As you have seen, there are other uses of "MSI" in the
kernel :)

> +	int	(*setup)    (struct pci_dev *pdev, unsigned int vector,
> +			     u32 *addr_hi, u32 *addr_lo, u32 *data);
> +	void	(*teardown) (unsigned int vector);
> +#ifdef CONFIG_SMP
> +	void	(*target)   (unsigned int vector, unsigned int cpu,
> +			     u32 *addr_hi, u32 *addr_lo);
> +#endif

Again, why the ifdef here?

> +};
> +
>  #ifndef CONFIG_PCI_MSI
>  static inline void pci_scan_msi_device(struct pci_dev *dev) {}
>  static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
> @@ -486,6 +496,7 @@
>  	struct msix_entry *entries, int nvec) {return -1;}
>  static inline void pci_disable_msix(struct pci_dev *dev) {}
>  static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
> +static inline int msi_register(struct msi_ops *ops) {return -1;}

pci_msi_register() please.

thanks,

greg k-h
