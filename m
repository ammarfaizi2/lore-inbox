Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319282AbSHVDMB>; Wed, 21 Aug 2002 23:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319283AbSHVDMB>; Wed, 21 Aug 2002 23:12:01 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:64517 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319282AbSHVDMA>;
	Wed, 21 Aug 2002 23:12:00 -0400
Date: Wed, 21 Aug 2002 20:10:36 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: gregkh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: PCI Cleanup
Message-ID: <20020822031036.GA3929@kroah.com>
References: <74760000.1029977971@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74760000.1029977971@w-hlinder>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 25 Jul 2002 02:07:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor comments:

On Wed, Aug 21, 2002 at 05:59:31PM -0700, Hanna Linder wrote:
> +static int gapspci_write(struct pci_bus *bus, unsigned int devfn,
> +				    int where, u32 val)

You forgot the size parameter.

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

Your formatting is a bit off here (the case statements should be one
level to the right.)

Other than that, looks good.

thanks,

greg k-h

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
