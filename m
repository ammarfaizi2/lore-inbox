Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTLPRKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTLPRKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:10:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261947AbTLPRKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:10:19 -0500
Message-ID: <3FDF3C6C.9030609@pobox.com>
Date: Tue, 16 Dec 2003 12:10:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
CC: Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>  <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com>
In-Reply-To: <3FDEDC77.9010203@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev wrote:

Definitely looks a lot better, thanks.

Still a few problems to consider...


> diff -dur linux-2.4.23/arch/i386/config.in linux-2.4.23-pciexp/arch/i386/config.in
> --- linux-2.4.23/arch/i386/config.in	2003-11-28 20:26:19.000000000 +0200
> +++ linux-2.4.23-pciexp/arch/i386/config.in	2003-12-16 11:18:46.000000000 +0200
> @@ -292,6 +292,15 @@
>        fi
>        if [ "$CONFIG_PCI_GODIRECT" = "y" -o "$CONFIG_PCI_GOANY" = "y" ]; then
>           define_bool CONFIG_PCI_DIRECT y
> +         bool 'PCI-Express support' CONFIG_PCI_EXPRESS
> +         if [ "$CONFIG_PCI_EXPRESS" = "y" ]; then
> +            bool 'Enable PCI-E custom base address' CONFIG_PCIEXP_USE_CUSTOM_BASE
> +            if [ "$CONFIG_PCIEXP_USE_CUSTOM_BASE" = "y" ]; then
> +               hex 'PCI-Express base address' CONFIG_PCI_EXPRESS_BASE 0xe
> +            else
> +               define_hex CONFIG_PCI_EXPRESS_BASE 0xe
> +            fi
> +         fi
>        fi
>     fi
>     bool 'ISA bus support' CONFIG_ISA

This is OK for development...   But until (if ever?) there is a standard 
way to detect PCI Express, I think it is better to maintain a list of 
chipsets that support PCI Express.

Users are really going to hate this, once the first chipset comes out 
that uses a non-standard address.


> diff -dur linux-2.4.23/arch/i386/kernel/pci-pc.c linux-2.4.23-pciexp/arch/i386/kernel/pci-pc.c
> --- linux-2.4.23/arch/i386/kernel/pci-pc.c	2003-11-28 20:26:19.000000000 +0200
> +++ linux-2.4.23-pciexp/arch/i386/kernel/pci-pc.c	2003-12-16 12:00:46.000000000 +0200

> +/**
> + * I don't know how to detect it properly.
> + * assume it is PCI-E, sanity_check will
> + * stop me if it is not.
> + * 
> + * Also, this function supposed to set rrbar_phys
> + */
> +static int is_pcie_platform(void)
> +{ return 1; }
> +
> +/**
> + * Initializes PCI Express method for config space access.
> + * 
> + * There is no standard method to recognize presence of PCI Express,
> + * thus we will assume it is PCI-E, and rely on sanity check to
> + * deassert PCI-E presense. If PCI-E not present,
> + * there is no physical RAM on RRBAR address, and we should read
> + * something like 0xff.
> + * 
> + * @return 1 if OK, 0 if error
> + */

Well, I agree with the comment, but that's not what the code does.

Where is your check for 0xff?

Further, is_pcie_platform() unconditionally returns 1... and is only 
used once, in PCI-Ex-specific code.


> +static int pci_express_init(void)
> +{
> +	rrbar_window_virt = (void*)fix_to_virt(FIX_PCIE_CONFIG);
> +	if (!is_pcie_platform())
> +		return 0;
> +	/**
> +	 * adjust mapping for 1-st device (00:00.0)
> +	 * to match pcie_last_accessed_device
> +	 */
> +	set_fixmap_nocache(FIX_PCIE_CONFIG, rrbar_phys);
> +	return 1;
> +}

Longer term, we want to provide some way to have the read/write routines 
generic, but support arch-specific mapping methods, I would think...

64-bit arches probably wouldn't need a spinlock at all for each access, 
I bet, since it's just a single MMIO read or write.


> +/**
> + * Shuts down PCI-E resources.
> + */
> +static inline void pci_express_fini(void)
> +{}
> +
> +/**
> + * Adjust window for the device.
> + * pci_config_lock should be held
> + */
> +static inline void pci_exp_set_dev_base(int bus, int dev, int fn)
> +{
> +	u32 dev_base = (bus << 20) | (dev << 15) | (fn << 12);
> +	if (dev_base != pcie_last_accessed_device) {
> +		pcie_last_accessed_device = dev_base;
> +		set_fixmap_nocache(FIX_PCIE_CONFIG, rrbar_phys | dev_base);
> +	}
> +}
> +
> +static int pci_exp_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
> +{
> +	unsigned long flags;
> +	void *addr = rrbar_window_virt + reg;
> +	if (((unsigned)bus > 255 || (unsigned)dev > 31
> +	  || (unsigned)fn > 7 || (unsigned)reg > 4095)) 
> +		return -EINVAL;
> +	switch (len) {
> +	case 2:
> +		if (reg & 1)
> +			return -EINVAL;
> +		break;
> +	case 4:
> +		if (reg & 3)
> +			return -EINVAL;
> +		break;
> +	}
> +	spin_lock_irqsave(&pci_config_lock, flags);
> +	pci_exp_set_dev_base(bus, dev, fn);
> +	switch (len) {
> +	case 1:
> +		*value = readb(addr);
> +		break;
> +	case 2:
> +		*value = readw(addr);
> +		break;
> +	case 4:
> +		*value = readl(addr);
> +		break;
> +	}
> +	spin_unlock_irqrestore(&pci_config_lock, flags);
> +	return 0;
> +}
> +
> +static int pci_exp_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
> +{
> +	unsigned long flags;
> +	void *addr = rrbar_window_virt + reg;
> +	if (((unsigned)bus > 255 || (unsigned)dev > 31
> +	  || (unsigned)fn > 7 || (unsigned)reg > 4095)) 
> +		return -EINVAL;
> +	switch (len) {
> +	case 2:
> +		if (reg & 1)
> +			return -EINVAL;
> +		break;
> +	case 4:
> +		if (reg & 3)
> +			return -EINVAL;
> +		break;
> +	}

I don't see that read and write should ever return an error.

The above EINVAL conditions are a BUG().


> +	spin_lock_irqsave(&pci_config_lock, flags);
> +	pci_exp_set_dev_base(bus, dev, fn);
> +	switch (len) {
> +	case 1:
> +		writeb(value, addr);
> +		break;
> +	case 2:
> +		writew(value, addr);
> +		break;
> +	case 4:
> +		writel(value, addr);
> +		break;
> +	}
> +	/* dummy read to flush PCI write */
> +	readb(addr);

This is going to choke some hardware, I guarantee.

You always want to make sure your flush is of the same size at the 
write.  Reading a byte from an address that the hardware defines as 
"32-bit writes only" can get ugly real quick ;-)




> diff -dur linux-2.4.23/drivers/pci/proc.c linux-2.4.23-pciexp/drivers/pci/proc.c
> --- linux-2.4.23/drivers/pci/proc.c	2002-11-29 01:53:14.000000000 +0200
> +++ linux-2.4.23-pciexp/drivers/pci/proc.c	2003-12-15 11:48:16.000000000 +0200
> @@ -16,7 +16,10 @@
>  #include <asm/uaccess.h>
>  #include <asm/byteorder.h>
>  
> -#define PCI_CFG_SPACE_SIZE 256
> +/**
> + * For PCI Express, it will be set to 4096 during PCI init
> + */
> +int pci_cfg_space_size=256;
>  
>  static loff_t
>  proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
> @@ -31,12 +34,12 @@
>  		new = file->f_pos + off;
>  		break;
>  	case 2:
> -		new = PCI_CFG_SPACE_SIZE + off;
> +		new = pci_cfg_space_size + off;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> -	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
> +	if (new < 0 || new > pci_cfg_space_size)
>  		return -EINVAL;
>  	return (file->f_pos = new);
>  }
> @@ -57,7 +60,7 @@
>  	 */
>  
>  	if (capable(CAP_SYS_ADMIN))
> -		size = PCI_CFG_SPACE_SIZE;
> +		size = pci_cfg_space_size;
>  	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
>  		size = 128;
>  	else
> @@ -132,12 +135,12 @@
>  	int pos = *ppos;
>  	int cnt;
>  
> -	if (pos >= PCI_CFG_SPACE_SIZE)
> +	if (pos >= pci_cfg_space_size)
>  		return 0;
> -	if (nbytes >= PCI_CFG_SPACE_SIZE)
> -		nbytes = PCI_CFG_SPACE_SIZE;
> -	if (pos + nbytes > PCI_CFG_SPACE_SIZE)
> -		nbytes = PCI_CFG_SPACE_SIZE - pos;
> +	if (nbytes >= pci_cfg_space_size)
> +		nbytes = pci_cfg_space_size;
> +	if (pos + nbytes > pci_cfg_space_size)
> +		nbytes = pci_cfg_space_size - pos;
>  	cnt = nbytes;
>  
>  	if (!access_ok(VERIFY_READ, buf, cnt))
> @@ -389,7 +392,7 @@
>  		return -ENOMEM;
>  	e->proc_fops = &proc_bus_pci_operations;
>  	e->data = dev;
> -	e->size = PCI_CFG_SPACE_SIZE;
> +	e->size = pci_cfg_space_size;
>  	return 0;
>  }
>  

Something I missed in the previous emails comments:

The above seems wrong, to blindly assume PCI-Ex means PCI config space 
will always be 4k.  What about downstream PCI bridges, and ancient 
devices with only 256 bytes of config registers?

It really seems like the config space size should be per-device or per-bus.

	Jeff



