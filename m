Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUAVKoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUAVKoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:44:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:55716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266221AbUAVKoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:44:15 -0500
Date: Thu, 22 Jan 2004 02:44:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       ak@colin2.muc.de, vladimir.kondratiev@intel.com,
       harinarayanan.seshadri@intel.com, sundarapandian.durairaj@intel.com
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-Id: <20040122024456.38e07c49.akpm@osdl.org>
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
References: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com> wrote:
>
> This is the patch on PCI Express Enhanced configuration for 2.6.0 test11
> ...
> Please review this and send in your comments.

A bit of triviata:

> diff -Naur linux-2.6.0/arch/i386/Kconfig
> linux_pciexpress/arch/i386/Kconfig
> --- linux-2.6.0/arch/i386/Kconfig	2003-12-18 08:28:16.000000000
> +0530

Your mailer wordwrapped it.  This seems to be a favourite pastime at Intel
;) You need to struggle with your email client for a while, or give up and
use attachments.

> +++ linux_pciexpress/arch/i386/kernel/acpi/boot.c	2004-01-12
> 14:14:22.000000000 +0530
> @@ -93,6 +93,29 @@
>  	return ((unsigned char *) base + offset);
>  }
>  
> +#ifdef CONFIG_PCI_EXPRESS
> +extern u32 mmcfg_base_address;

extern declarations should go in .h files, not in .c.

> +static int __init acpi_parse_mcfg
> +			 (unsigned long phys_addr, unsigned long size)
> +{
> +	struct acpi_table_mcfg	*mcfg = NULL;
> +
> +	if (!phys_addr || !size)
> +		return -EINVAL;
> +
> +	mcfg = (struct acpi_table_mcfg *) __acpi_map_table
> +						(phys_addr, size);
> +	if (!mcfg) {
> +		printk(KERN_WARNING PREFIX "Unable to map MCFG\n");
> +		return -ENODEV;
> +	}
> +	if (mcfg->base_address)
> +		mmcfg_base_address = (u32)mcfg->base_address;

Is it OK to chop this u64 down to u32?  If so, why was it u64?

> +#ifdef CONFIG_PCI_EXPRESS
> +	else if (!strcmp(str, "no_pcie")) {
> +		pci_probe &= !PCI_PROBE_ENHANCED;
> +		return NULL;
> +	}

should that be a `!' operator?  Or `~'?

>  /*
> + *We map full Page size on each request. Incidently that's the size we
> + *have for config space too.
> + */

Conventionally we put a space after the "*" in comments.


> +/*
> + *Variable used to store the virtual  address of fixed PTE
> + */
> +char * mmcfg_virt_addr;

But we don't put spaces after this sort of asterisk.

> +
> +static int pci_express_conf_read(int seg, int bus,
> +		int devfn, int reg, int len, u32 *value)
> +{
> +	if (!value || ((u32)bus > 255) || ((u32)devfn > 255) 
> +		|| ((u32)reg > 4095)){

If you're casting these so as to catch negative ints the cast should be to
`unsigned', not `u32'.  Or, better, make this function simply take unsigned
args if negative values are nonsensical.


> +	/* Shoot misalligned transaction now */

Spellling error here.

> +	if (reg & (len-1)){

Space before the {

> +		printk(KERN_ERR "pci_express_conf_read: \
> +					misalligned transaction\n");

This string has a bunch of tabs in the middle.

Remove the `\' and do

		printk(KERN_ERR "pci_express_conf_read: "
				"misalligned transaction\n");


> +static int pci_express_conf_write(int seg, int bus, 
> +			int devfn, int reg, int len, u32 value)
> +{
> +	if (((u32)bus > 255) || ((u32)devfn > 255) 
> +		|| ((u32)reg > 4095)){

See above.

> +		printk(KERN_ERR "pci_express_conf_write: \
> +					Invalid Parameter\n");

tabs

> +	/* Shoot misalligned transaction now */

spelling

> +	if (reg & (len-1)){
> +		printk(KERN_ERR "pci_express_conf_write: \
> +					misalligned transaction\n");

tabs

> +	if (mmcfg_base_address == 0){

space

> +		printk(KERN_INFO 
> +		      "MCFG table entry is not found in ACPI
> tables....\n \
> +		       PCI Express not supported in this platform....\n
> \
> +		       Not enabling Enhanced Configuration....\n");

Use compile-time string concatentation here as well.

>  static int proc_initialized;	/* = 0 */

The comment here isn't really needed: initalisaton of BSS is kernel
folklore.

>  
> +static int pci_cfg_space_size (struct pci_dev *dev)

No space before the opening parenthesis.

> + 		size = pci_cfg_space_size (dev);

Ditto

> +extern u32 mmcfg_base_address;
> +extern spinlock_t pci_config_lock;
> +extern char * mmcfg_virt_addr;

These should all be in header files.

> +
> +static __inline__ void pci_exp_set_dev_base (int bus, int devfn)
> +static __inline__ void pci_express_read(int bus, int devfn, int reg, 

`inline', not __inline__

> +		int len, u32 *value)
> +{
> +	unsigned long flags;
> +	spin_lock_irqsave(&pci_config_lock, flags);
> +	pci_exp_set_dev_base(bus, devfn);
> + 	switch (len) {
> +        case 1:
> +		*value = (u8)readb((unsigned long) mmcfg_virt_addr +
> reg);
> +		break;
> +        case 2:
> +		*value = (u16)readw((unsigned long) mmcfg_virt_addr +
> reg);
> +		break;
> +        case 4:
> +		*value = (u32)readl((unsigned long) mmcfg_virt_addr +
> reg);

Are these casts needed?

> +static __inline__ void pci_express_write(int bus, int devfn, int reg, 

inline

> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pci_config_lock, flags);
> +	pci_exp_set_dev_base(bus, devfn);
> +	switch (len) {
> +		case 1:
> +			writeb(value,(unsigned long)mmcfg_virt_addr +
> reg);
> +			break;
> +		case 2:
> +			writew(value,(unsigned long)mmcfg_virt_addr +
> reg);
> +			break;
> +	        case 4:
> +			writel(value,(unsigned long)mmcfg_virt_addr +
> reg);
> +	                break;
> +     	}

Are these casts needed?

