Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbUJYNpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbUJYNpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbUJYNn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:43:57 -0400
Received: from mail6.iserv.net ([204.177.184.156]:46024 "EHLO mail6.iserv.net")
	by vger.kernel.org with ESMTP id S261814AbUJYNmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:42:13 -0400
Message-ID: <417D0180.5040401@didntduck.org>
Date: Mon, 25 Oct 2004 09:37:04 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: shaohua li <shaoh.li@gmail.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, greg@kroah.com
Subject: Re: [PATCH] call 'pci_dev_put' after pci_get_device
References: <288dbef704102502474fdd0c84@mail.gmail.com>
In-Reply-To: <288dbef704102502474fdd0c84@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shaohua li wrote:
> Hi,
> Some code didn't call 'pci_dev_put' after pci_get_device. Below is an
> incomplete list.
> 
> Thanks,
> Shaohua

If pci_get_device() is passed in a non-NULL dev it internally does a 
pci_dev_put().  So if you do a complete while loop (ie. no breaks, gotos 
or returns), pci_dev_put() is unnecessary.

> 
> Signed-off-by: Li Shaohua <shaoh.li@gmail.com>
> 
> ===== drivers/pci/pci.c 1.73 vs edited =====
> --- 1.73/drivers/pci/pci.c	2004-10-07 00:42:55 +08:00
> +++ edited/drivers/pci/pci.c	2004-10-25 17:30:36 +08:00
> @@ -734,6 +734,7 @@ static int __devinit pci_init(void)
>  
>  	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
>  		pci_fixup_device(pci_fixup_final, dev);
> +		pci_dev_put(dev);
>  	}
>  	return 0;
>  }
> ===== drivers/pci/quirks.c 1.55 vs edited =====
> --- 1.55/drivers/pci/quirks.c	2004-10-20 00:54:38 +08:00
> +++ edited/drivers/pci/quirks.c	2004-10-25 17:29:48 +08:00
> @@ -38,6 +38,7 @@ static void __devinit quirk_passive_rele
>  			dlc |= 1<<1;
>  			pci_write_config_byte(d, 0x82, dlc);
>  		}
> +		pci_dev_put(d);
>  	}
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release
> );
> ===== drivers/pci/setup-irq.c 1.5 vs edited =====
> --- 1.5/drivers/pci/setup-irq.c	2004-10-07 00:44:51 +08:00
> +++ edited/drivers/pci/setup-irq.c	2004-10-25 17:29:08 +08:00
> @@ -67,5 +67,6 @@ pci_fixup_irqs(u8 (*swizzle)(struct pci_
>  	struct pci_dev *dev = NULL;
>  	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
>  		pdev_fixup_irq(dev, swizzle, map_irq);
> +		pci_dev_put(dev);
>  	}
>  }

