Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTL2Lzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 06:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTL2Lzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 06:55:33 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:39948 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263269AbTL2LzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 06:55:16 -0500
Date: Mon, 29 Dec 2003 11:55:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-kernel@vger.kernel.org,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20031229115513.A27636@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
	linux-kernel@vger.kernel.org,
	"Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
	"Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>
References: <6B09584CC3D2124DB45C3B592414FA8308C898@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA8308C898@bgsmsx402.gar.corp.intel.com>; from sundarapandian.durairaj@intel.com on Mon, Dec 29, 2003 at 05:02:39PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 05:02:39PM +0530, Durairaj, Sundarapandian wrote:
> Hi All,
> 
> This is the patch on PCI Express Enhanced configuration for 2.6.0 test11
> kernel following up to the Vladamir (Vladimir.Kondratiev@intel.com) and
> HariNarayanan (Harinarayanan.Seshadri@intel.com) patches . I tested it
> on our i386 platform. 
> 
> This patch also implements a mechanism for the kernel to find the
> chipset specific mmcfg base address. The kernel will detect the base
> address of the chipset through the ACPI table entry and based on that
> the PCI subsystem will be initialized.  
> 
> Please review this and send in your comments.

The patch is b0rked due to linewrapping.  This means a) you need to fix the
mailer and b) make sure you wrap lines after 80 chars as to the coding style.

More comments below:

>  
> +config PCI_EXP_ENHANCED
> +	bool "PCI_EXPRESS (EXPERIMENTAL)" 
> +	depends on EXPERIMENTAL 

Should probably depend on ACPI if you're using ACPI tables to parse.

> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +extern u64 mmcfg_base_address;

Should probably go into a header.

> +static int __init
> +acpi_parse_mcfg (
> +	unsigned long		phys_addr,
> +	unsigned long		size)

Slightly strange coding style, should be

static int __init acpi_parse_mcfg(unsigned long phys_addr, unsigned long size)

> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +	result = acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
> +	if (!result) {
> +		printk(KERN_WARNING PREFIX "MCFG not present\n");
> +		return 0;
> +	}
> +	else if (result < 0) {

	} else if (result < 0) {

> +		printk(KERN_ERR PREFIX "Error parsing MCFG\n");
> +		return result;
> +	}
> +	else if (result > 1) 

	} else if (result > 1)

> +#endif /*CONFIG_PCI_EXP_ENHANCED*/

#endif /* CONFIG_PCI_EXP_ENHANCED */

> +/* mmcfg base address will be initalised by the os initalisation 
> + * code on PCI Express capable platform 
> + */
> +static int is_pci_exp_platform(void )

static int is_pci_exp_platform(void)

> +{
> +/* 
> +	At the time of initialisation of  the os would have 
> +	scanned for mcfg table and set this variable to appropriate 
> +	value If PCI Express not supported the variable 
> +	will have 0 value
> +*/
> +	if (mmcfg_base_address == 0){

	if (mmcfg_base_address == 0) {

also the comment is formatted wrongly, the grammar doesn't make sense to me
(but I'm not native speaker), and it looks slightly superflous..

Also why do you need this function at all instead of checking for
mmcfg_base_address beeing non-NULL directly?
	
> +		printk(KERN_INFO "MCFG table entry is not found in ACPI
> tables....\n");
> +		printk(KERN_INFO " PCI Express not supported in this
> platform....\n");
> +		printk(KERN_INFO " Not enabling Enhanced
> Configuration....\n");

This printk is a bit verbose for this beeing quite normal for 99.999% of
the PCs currently out there..

> +/*
> + Variable used to store the base address of the last pciexpress device 
> +  accessed.
> + */

/*
 * Base address of the last pciexpress device accessed.
 */

> +unsigned long pci_exp_set_dev_base (int bus, int dev, int fn)

unsigned long pci_exp_set_dev_base (int bus, int dev, int fn)

> +	if (dev_base != pcie_last_accessed_device){
> +		pcie_last_accessed_device = dev_base;
> +		set_fixmap (FIX_PCIE_MCFG, dev_base);

again, please no whitespace here

> +	 unsigned long flags;
> +	 unsigned long base_address;
> +	 char * virt_addr;
> +	 int dev = PCI_SLOT (devfn);
> +	 int fn  = PCI_FUNC (devfn);
> + 
> +  if (!value || ((u32)bus > 255) || ((u32)dev > 31) || ((u32)fn > 7) ||
> ((u32)reg > 4095))
> +  	return -EINVAL;

Indentation over this function is rather broken.  Please read through
Documentation/CodingStyle in the source tree and fix up accordingly.

>  static int __init pci_direct_init(void)
>  {
>  	struct resource *region, *region2;
> +	unsigned long flags;
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +	local_irq_save(flags);
> +	/*
> +	 *	Check if platform we are running is pci express capable
> +	 */
> +	 if( is_pci_exp_platform() != 0){

Again, codingstyle is quite strange.  with that function the comment is
rather superflous.  With the abstraction removed as I suggested above
it'll make sense again, though.

> +++ linux-2.6_pciexpress/drivers/acpi/tables.c	2003-12-24
> 18:34:38.048354440 +0530
> @@ -58,6 +58,9 @@
>  	[ACPI_SSDT]		= "SSDT",
>  	[ACPI_SPMI]		= "SPMI",
>  	[ACPI_HPET]		= "HPET",
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +	[ACPI_MCFG]		= "MCFG",
> +#endif

Is there a problem with just having this table always declared?

> 18:34:41.249867736 +0530
> @@ -18,11 +18,23 @@
>  
>  #define PCI_CFG_SPACE_SIZE 256
>  
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +#define PCI_CFG_SPACE_EXP_SIZE 4096
> +#endif

No ifdef around this, please

>  static loff_t
>  proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
>  {
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +	const struct inode *ino = file->f_dentry->d_inode;
> +	const struct proc_dir_entry *dp = PDE(ino);
> +	struct pci_dev *dev = dp->data;
> +	/* Find whether the device is PCI Express device */
> +	int is_pci_express_dev =  pci_find_capability(dev,
> PCI_CAP_ID_EXP);
> +#endif /*CONFIG_PCI_EXP_ENHANCED*/
>  	loff_t new = -1;
>  
>  	lock_kernel();
> @@ -34,12 +46,22 @@
>  		new = file->f_pos + off;
>  		break;
>  	case 2:
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +		if (is_pci_express_dev)
> +			new = PCI_CFG_SPACE_EXP_SIZE + off;
> +		else
> +#endif /*CONFIG_PCI_EXP_ENHANCED*/
>  		new = PCI_CFG_SPACE_SIZE + off;
>  		break;
>  	}
>  	unlock_kernel();
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +	if (is_pci_express_dev && (new < 0 || new >
> PCI_CFG_SPACE_EXP_SIZE))
> +		return -EINVAL;
> +#else
>  	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
>  		return -EINVAL;
> +#endif /*CONFIG_PCI_EXP_ENHANCED */
>  	return (file->f_pos = new);
>  }

This code is too ugly to live.  you should just add a cfg_space_size
member to struct pci_dev and do the checks only once based on that one.

>  	if (capable(CAP_SYS_ADMIN))
> -		size = PCI_CFG_SPACE_SIZE;
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +		if (pci_find_capability(dev,PCI_CAP_ID_EXP))
> +			size = PCI_CFG_SPACE_EXP_SIZE;
> +		else
> +#endif /*CONFIG_PCI_EXP_ENHANCED */

Shouldn't this be conditional on whether we actually use the
pci express config sppaces accessorts?  Also for that small ifdefs
it's superflous to have the comment after the endif.

but with the cfg_space_size member in struct pci_dev all this shoud
just go away..

> 18:34:21.000000000 +0530
> @@ -317,6 +317,15 @@
>  	char				ec_id[0];
>  } __attribute__ ((packed));
>  
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +struct acpi_table_mcfg {
> +	struct acpi_table_header 	header;
> +	u8	reserved[8];
> +	u64	base_address;
> +} __attribute__ ((packed));
> +#endif

No ifdef needed again, unused struct declaration don't harm,
ifdefs do OTOH.

>  enum acpi_table_id {
> @@ -338,6 +347,9 @@
>  	ACPI_SSDT,
>  	ACPI_SPMI,
>  	ACPI_HPET,
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +	ACPI_MCFG,
> +#endif

Same comment as above.
