Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVJ2AvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVJ2AvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVJ2AvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:51:21 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:43207 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750961AbVJ2AvU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:51:20 -0400
Date: Fri, 28 Oct 2005 18:51:19 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Roland Dreier <rolandd@cisco.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/v2] PCI: add pci_find_next_capability()
Message-ID: <20051029005119.GD21871@parisc-linux.org>
References: <52u0f1p3c9.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52u0f1p3c9.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 05:35:34PM -0700, Roland Dreier wrote:
> Signed-off-by: Roland Dreier <rolandd@cisco.com>

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

> 
> ---
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 259d247..b852959 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -62,11 +62,38 @@ pci_max_busnr(void)
>  	return max;
>  }
>  
> +static int __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn, u8 pos, int cap)
> +{
> +	u8 id;
> +	int ttl = 48;
> +
> +	while (ttl--) {
> +		pci_bus_read_config_byte(bus, devfn, pos, &pos);
> +		if (pos < 0x40)
> +			break;
> +		pos &= ~3;
> +		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID,
> +					 &id);
> +		if (id == 0xff)
> +			break;
> +		if (id == cap)
> +			return pos;
> +		pos += PCI_CAP_LIST_NEXT;
> +	}
> +	return 0;
> +}
> +
> +int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
> +{
> +	return __pci_find_next_cap(dev->bus, dev->devfn,
> +				   pos + PCI_CAP_LIST_NEXT, cap);
> +}
> +EXPORT_SYMBOL(pci_find_next_capability);
> +
>  static int __pci_bus_find_cap(struct pci_bus *bus, unsigned int devfn, u8 hdr_type, int cap)
>  {
>  	u16 status;
> -	u8 pos, id;
> -	int ttl = 48;
> +	u8 pos;
>  
>  	pci_bus_read_config_word(bus, devfn, PCI_STATUS, &status);
>  	if (!(status & PCI_STATUS_CAP_LIST))
> @@ -75,24 +102,15 @@ static int __pci_bus_find_cap(struct pci
>  	switch (hdr_type) {
>  	case PCI_HEADER_TYPE_NORMAL:
>  	case PCI_HEADER_TYPE_BRIDGE:
> -		pci_bus_read_config_byte(bus, devfn, PCI_CAPABILITY_LIST, &pos);
> +		pos = PCI_CAPABILITY_LIST;
>  		break;
>  	case PCI_HEADER_TYPE_CARDBUS:
> -		pci_bus_read_config_byte(bus, devfn, PCI_CB_CAPABILITY_LIST, &pos);
> +		pos = PCI_CB_CAPABILITY_LIST;
>  		break;
>  	default:
>  		return 0;
>  	}
> -	while (ttl-- && pos >= 0x40) {
> -		pos &= ~3;
> -		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID, &id);
> -		if (id == 0xff)
> -			break;
> -		if (id == cap)
> -			return pos;
> -		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_NEXT, &pos);
> -	}
> -	return 0;
> +	return __pci_find_next_cap(bus, devfn, pos, cap);
>  }
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7349058..8016d14 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -337,6 +337,7 @@ struct pci_dev *pci_find_device (unsigne
>  struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
>  struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
>  int pci_find_capability (struct pci_dev *dev, int cap);
> +int pci_find_next_capability (struct pci_dev *dev, u8 pos, int cap);
>  int pci_find_ext_capability (struct pci_dev *dev, int cap);
>  struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
>  
> @@ -546,6 +547,7 @@ static inline int pci_assign_resource(st
>  static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
>  static inline void pci_unregister_driver(struct pci_driver *drv) { }
>  static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
> +static inline int pci_find_next_capability (struct pci_dev *dev, u8 post, int cap) {return 0; }
>  static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
>  static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
>  
