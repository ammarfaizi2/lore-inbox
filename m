Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTLNUqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTLNUqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:46:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40110 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262540AbTLNUqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:46:31 -0500
Message-ID: <3FDCCC12.20808@pobox.com>
Date: Sun, 14 Dec 2003 15:46:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com>
In-Reply-To: <3FDCC171.9070902@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev wrote:
> Please, ignore previous submission with the same subject. Patch file 
> attached was wrong one. Now correct patch attached.
> 
> Hi,
> PCI-Express platforms will soon appear on the market. It is worth to
> support it.
> 
> Following is patch for 2.4.23 kernel. I tested it on my host, it works
> properly.
> I did it for i386 only, I have no other architecture to test.
> 
> It was patch on the same subject from* Seshadri, Harinarayanan*
> (/harinarayanan.seshadri@intel.com/
> <mailto:harinarayanan.seshadri@intel.com>)
> http://www.cs.helsinki.fi/linux/linux-kernel/2003-17/0247.html
> My version differ in several aspects: it is for 2.4 (vs. 2.6); it do not
> ioremap/unmap page for each transaction.
> 
> How about inclusion in 2.4.24?
> 
> I am not subscribed to lkml, thus please CC me
> (Vladimir Kondratiev <vladimir.kondratiev@intel.com>) in replies.


The patch could use some cleaning up, for coding style.  The general 
style is documented in CodingStyle file in the kernel source tree.  But 
also, you should consider the "golden rule of style" for programmers: 
When modifying a file, follow the same formatting as is found in the 
rest of the file.

Particularly:
* use a single tab to indent at each level
* use whitespace liberally.  avoid "foo=bar".  prefer "foo = bar".



> +/**
> + * PCI Express routines
> + * "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>
> + */
> +/**
> + * RRBAR (memory base for PCI-E config space) resides here.
> + * Initialized to default address. Actually, it is platform specific, and
> + * value may vary.
> + * I don't know how to detect it properly, it is chipset specific.
> + */
> +static u32 rrbar_phys=0xe0000000UL;
> +/**
> + * RRBAR is always 256M
> + */
> +static u32 rrbar_size=0x10000000UL;

Insert spaces in the assignment statements.


> +/**
> + * Virtual address for RRBAR
> + */
> +static void* rrbar_virt=NULL;

Do not bother initializing static variables to zero.  This just wastes 
bss space, since these variables are automatically zeroed for you, anyway.


> +/**
> + * It used to be #define, but I am going to change it.
> + */
> +extern int PCI_CFG_SPACE_SIZE;

Hopefully this is temporary...  variables should not be ALL CAPS.  If 
you change it to a variable, also change its case.


> +/**
> + * Initializes PCI Express method for config space access.
> + * 
> + * There is no standard method to recognize presence of PCI Express,
> + * thus we will assume it is PCI-E, and rely on sanity check to
> + * deassert PCI-E presense. If PCI-E not present,
> + * there is no physical RAM on RRBAR address, and we should read
> + * something like 0xff.
> + * 
> + * Creates mapping for whole 256M area.
> + * 
> + * @return 1 if OK, 0 if error
> + */
> +static int pci_express_init(void)
> +{
> +  /* TODO: check PCI-Ex presense */

Um, this sounds critical.  We should not merge this patch until this 
'TODO' is complete, in my opinion.


> +  rrbar_virt=ioremap(rrbar_phys,rrbar_size);

add whitespace

> +  if (!rrbar_virt) return 0;

add a line break between two statements

> +  return 1;
> +}
> +
> +/**
> + * Shuts down PCI-E resources.
> + */
> +static void pci_express_fini(void)
> +{
> +  if (rrbar_virt) {
> +    iounmap(rrbar_virt);
> +  }
> +}
> +
> +static int pci_exp_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)

I think these arguments should be 'unsigned int', not 'int'.

Let's be proactive, and protect against signed/unsigned problems now, 
before they appear.


> +{
> +  void* addr=rrbar_virt+(bus << 20)+(dev << 15)+(fn << 12)+reg;

Why do you prefer '+' to '|' here?

'|' normally has less side effects.


> +  if ((bus > 255 || dev > 31 || fn > 7 || reg > 4095)) 
> +    return -EINVAL;
> +  switch (len) {
> +  case 1:
> +    *value=readb(addr);
> +    break;
> +  case 2:
> +    if (reg&1) return -EINVAL;
> +    *value=readw(addr);
> +    break;
> +  case 4:
> +    if (reg&3) return -EINVAL;
> +    *value=readl(addr);
> +    break;
> +  }
> +  return 0;
> +}
> +
> +static int pci_exp_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
> +{
> +  void* addr=rrbar_virt+(bus << 20)+(dev << 15)+(fn << 12)+reg;
> +  if ((bus > 255 || dev > 31 || fn > 7 || reg > 4095)) 
> +    return -EINVAL;
> +  switch (len) {
> +  case 1:
> +    writeb(value,addr);
> +    break;
> +  case 2:
> +    if (reg&1) return -EINVAL;
> +    writew(value,addr);
> +    break;
> +  case 4:
> +    if (reg&3) return -EINVAL;
> +    writel(value,addr);
> +    break;
> +  }
> +  return 0;
> +}

ditto, comments above:  formatting, whitespace, signed/unsigned, logical or.

Further, PCI posting:  a writeb() / writew() / writel() will not be 
flushed immediately to the processor.  The CPU and/or PCI bridge may 
post (delay/combine) such writes.  I do not think this is a desireable 
effect, for PCI config register accesses.


> +static int pci_exp_read_config_byte(struct pci_dev *dev, int where, u8 *value)
> +{
> +  int result; 
> +  u32 data;
> +  result = pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
> +			PCI_FUNC(dev->devfn), where, 1, &data);
> +  *value = (u8)data;
> +  return result;
> +}
> +
> +static int pci_exp_read_config_word(struct pci_dev *dev, int where, u16 *value)
> +{
> +  int result; 
> +  u32 data;
> +  result = pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
> +			PCI_FUNC(dev->devfn), where, 2, &data);
> +  *value = (u16)data;
> +  return result;
> +}
> +
> +static int pci_exp_read_config_dword(struct pci_dev *dev, int where, u32 *value)
> +{
> +  return pci_exp_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
> +		      PCI_FUNC(dev->devfn), where, 4, value);
> +}
> +
> +static int pci_exp_write_config_byte(struct pci_dev *dev, int where, u8 value)
> +{
> +  return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
> +		       PCI_FUNC(dev->devfn), where, 1, value);
> +}
> +
> +static int pci_exp_write_config_word(struct pci_dev *dev, int where, u16 value)
> +{
> +  return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
> +		       PCI_FUNC(dev->devfn), where, 2, value);
> +}
> +
> +static int pci_exp_write_config_dword(struct pci_dev *dev, int where, u32 value)
> +{
> +  return pci_exp_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
> +		       PCI_FUNC(dev->devfn), where, 4, value);
> +}

As with other code, define a macro that creates these functions.  Then 
add a series of lines such as

DEF_PCIEX_READ(word, 2)
DEF_PCIEX_READ(dword, 4)
...


> +static struct pci_ops pci_express_conf = {
> +  pci_exp_read_config_byte,
> +  pci_exp_read_config_word,
> +  pci_exp_read_config_dword,
> +  pci_exp_write_config_byte,
> +  pci_exp_write_config_word,
> +  pci_exp_write_config_dword
> +};
>  
>  /*
>   * Before we decide to use direct hardware access mechanisms, we try to do some
> @@ -465,6 +614,21 @@
>  
>  	__save_flags(flags); __cli();
>  
> +    /**
> +     * Check if PCI-express access work
> +     */
> +    if (pci_express_init()) {
> +        if (pci_sanity_check(&pci_express_conf)) {
> +            PCI_CFG_SPACE_SIZE=4096;
> +			__restore_flags(flags);
> +			printk(KERN_INFO "PCI: Using configuration type PCI Express\n");
> +			request_mem_region(rrbar_phys, rrbar_size, "PCI-Express config space");
> +			return &pci_express_conf;
> +        } else {
> +            pci_express_fini();
> +        }
> +    }
> +
>  	/*
>  	 * Check if configuration type 1 works.
>  	 */
> @@ -1398,16 +1562,18 @@
>  #endif
>  
>  #ifdef CONFIG_PCI_DIRECT
> -	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2)) 
> +	if ((pci_probe & (PCI_PROBE_CONF1 | PCI_PROBE_CONF2 | PCI_PROBE_EXP)) 
>  		&& (tmp = pci_check_direct())) {
>  		pci_root_ops = tmp;
>  		if (pci_root_ops == &pci_direct_conf1) {
>  			pci_config_read = pci_conf1_read;
>  			pci_config_write = pci_conf1_write;
> -		}
> -		else {
> +		} else if (pci_root_ops == &pci_direct_conf2) {
>  			pci_config_read = pci_conf2_read;
>  			pci_config_write = pci_conf2_write;
> +		} else if (pci_root_ops == &pci_express_conf) {
> +			pci_config_read = pci_exp_read;
> +			pci_config_write = pci_exp_write;
>  		}
>  	}
>  #endif
> @@ -1489,6 +1655,10 @@
>  		pci_probe = PCI_PROBE_CONF2 | PCI_NO_CHECKS;
>  		return NULL;
>  	}
> +	else if (!strcmp(str, "exp")) {
> +		pci_probe = PCI_PROBE_EXP | PCI_NO_CHECKS;
> +		return NULL;
> +	}
>  #endif
>  	else if (!strcmp(str, "rom")) {
>  		pci_probe |= PCI_ASSIGN_ROMS;
> diff -bBdur linux-2.4.23/drivers/pci/proc.c linux-2.4.23-pciexp/drivers/pci/proc.c
> --- linux-2.4.23/drivers/pci/proc.c	2002-11-29 01:53:14.000000000 +0200
> +++ linux-2.4.23-pciexp/drivers/pci/proc.c	2003-12-14 14:18:58.000000000 +0200
> @@ -16,7 +16,7 @@
>  #include <asm/uaccess.h>
>  #include <asm/byteorder.h>
>  
> -#define PCI_CFG_SPACE_SIZE 256
> +int PCI_CFG_SPACE_SIZE=256;

ditto comment at the top...  when changing to a variable, make it lowercase.

	Jeff



