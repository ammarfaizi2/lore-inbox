Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSHVIXX>; Thu, 22 Aug 2002 04:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSHVIXX>; Thu, 22 Aug 2002 04:23:23 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:22818 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S318426AbSHVIXV> convert rfc822-to-8bit; Thu, 22 Aug 2002 04:23:21 -0400
Date: Thu, 22 Aug 2002 12:11:41 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: groudier@localhost.my.domain
To: Hanna Linder <hannal@us.ibm.com>
cc: gregkh@us.ibm.com, <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PCI Cleanup
In-Reply-To: <74760000.1029977971@w-hlinder>
Message-ID: <20020822115025.B2502-100000@localhost.my.domain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Aug 2002, Hanna Linder wrote:

> Here is the first part of the sh port of the pci_ops
> changes. If anyone can compile this for Sega let me
> know if there are any problems.

The 'val' pointer is declared 'u32 *', then casted 'u8 *' or 'u16 *' if
needed. The compiler will not warn you. But user that wants to operate on
u8 or u16 has to cast the 'val' argument to 'u32 *' and should get a
warning from any decent C compiler. The normal C-way for such
'sorry-typed' argument is 'void *val', IMO.

  Gérard.

> Thanks.
>
> Hanna Linder
> hannal@us.ibm.com
>
> ps -this patches against bk://linuxusb.bkbits.net/pci_hp-2.5
>
> -----
>
> diff -Nru a/arch/sh/kernel/pci-dc.c b/arch/sh/kernel/pci-dc.c
> --- a/arch/sh/kernel/pci-dc.c	Wed Aug 21 17:55:02 2002
> +++ b/arch/sh/kernel/pci-dc.c	Wed Aug 21 17:55:02 2002
> @@ -31,76 +31,58 @@
>  	{0, 0, 0, NULL}
>  };
>
> -#define BBA_SELECTED(dev) (dev->bus->number==0 && dev->devfn==0)
> +#define BBA_SELECTED(bus,devfn) (bus->number==0 && devfn==0)
>
> -static int gapspci_read_config_byte(struct pci_dev *dev, int where,
> -                                    u8 * val)
> +static int gapspci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 * val)
>  {
> -	if (BBA_SELECTED(dev))
> -		*val = inb(GAPSPCI_BBA_CONFIG+where);
> -	else
> -                *val = 0xff;
> -
> +	switch (size) {
> +	case 1:
> +		if (BBA_SELECTED(bus, devfn))
> +			*val = (u8)inb(GAPSPCI_BBA_CONFIG+where);
> +		else
> +			*val = (u8)0xff;
> +		break;
> +	case 2:
> +		if (BBA_SELECTED(bus, devfn))
> +			*val = (u16)inw(GAPSPCI_BBA_CONFIG+where);
> +		else
> +			*val = (u16)0xffff;
> +		break;
> +	case 4:
> +		if (BBA_SELECTED(bus, devfn))
> +			*val = inl(GAPSPCI_BBA_CONFIG+where);
> +		else
> +			*val = 0xffffffff;
> +		break;
> +	}
>  	return PCIBIOS_SUCCESSFUL;
>  }
>
> -static int gapspci_read_config_word(struct pci_dev *dev, int where,
> -                                    u16 * val)
> -{
> -        if (BBA_SELECTED(dev))
> -		*val = inw(GAPSPCI_BBA_CONFIG+where);
> -	else
> -                *val = 0xffff;
> -
> -        return PCIBIOS_SUCCESSFUL;
> -}
> -
> -static int gapspci_read_config_dword(struct pci_dev *dev, int where,
> -                                     u32 * val)
> -{
> -        if (BBA_SELECTED(dev))
> -		*val = inl(GAPSPCI_BBA_CONFIG+where);
> -	else
> -                *val = 0xffffffff;
> -
> -        return PCIBIOS_SUCCESSFUL;
> -}
> -
> -static int gapspci_write_config_byte(struct pci_dev *dev, int where,
> -                                     u8 val)
> -{
> -        if (BBA_SELECTED(dev))
> -		outb(val, GAPSPCI_BBA_CONFIG+where);
> -
> -        return PCIBIOS_SUCCESSFUL;
> -}
> -
> -
> -static int gapspci_write_config_word(struct pci_dev *dev, int where,
> -                                     u16 val)
> -{
> -        if (BBA_SELECTED(dev))
> -		outw(val, GAPSPCI_BBA_CONFIG+where);
> -
> -        return PCIBIOS_SUCCESSFUL;
> -}
> -
> -static int gapspci_write_config_dword(struct pci_dev *dev, int where,
> -                                      u32 val)
> +static int gapspci_write(struct pci_bus *bus, unsigned int devfn,
> +				    int where, u32 val)
>  {
> -        if (BBA_SELECTED(dev))
> -		outl(val, GAPSPCI_BBA_CONFIG+where);
> -
> -        return PCIBIOS_SUCCESSFUL;
> +	if (BBA_SELECTED(bus, devfn)) {
> +		switch (size) {
> +	case 1:
> +		if (BBA_SELECTED(bus, devfn))
> +			outb((u8)val, GAPSPCI_BBA_CONFIG+where);
> +		break;
> +	case 2:
> +		if (BBA_SELECTED(bus, devfn))
> +			outw((u16)val, GAPSPCI_BBA_CONFIG+where);
> +		break;
> +	case 4:
> +		if (BBA_SELECTED(bus, devfn))
> +			outl(val, GAPSPCI_BBA_CONFIG+where);
> +		break;
> +		}
> +	}
> +	return PCIBIOS_SUCCESSFUL;
>  }
>
>  static struct pci_ops pci_config_ops = {
> -        gapspci_read_config_byte,
> -        gapspci_read_config_word,
> -        gapspci_read_config_dword,
> -        gapspci_write_config_byte,
> -        gapspci_write_config_word,
> -        gapspci_write_config_dword
> +	.read = 	gapspci_read,
> +	.write = 	gapspci_write,
>  };
>
>
> @@ -143,7 +125,7 @@
>
>  	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
>  		dev = pci_dev_b(ln);
> -		if (!BBA_SELECTED(dev)) continue;
> +		if (!BBA_SELECTED(bus, dev->devfn)) continue;
>
>  		printk("PCI: MMIO fixup to %s\n", dev->name);
>  		dev->resource[1].start=0x01001700;
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

