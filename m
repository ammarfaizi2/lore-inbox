Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUCVXIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUCVXIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:08:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32152 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261451AbUCVXIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:08:19 -0500
Message-ID: <405F71CB.7000902@pobox.com>
Date: Mon, 22 Mar 2004 18:07:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][RELEASE] megaraid 2.10.2 Driver
References: <0E3FA95632D6D047BA649F95DAB60E570230C77A@exa-atlanta.se.lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C77A@exa-atlanta.se.lsil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bagalkote, Sreenivas wrote:
> Hello,
> @@ -45,6 +46,10 @@
>  
>  #include "megaraid2.h"
>  
> +#ifdef LSI_CONFIG_COMPAT
> +#include <asm/ioctl32.h>
> +#endif
> +

For upstream, this should just be CONFIG_COMPAT I presume.


>  MODULE_AUTHOR ("LSI Logic Corporation");
>  MODULE_DESCRIPTION ("LSI Logic MegaRAID driver");
>  MODULE_LICENSE ("GPL");
> @@ -206,6 +211,10 @@
>  		 */
>  		major = register_chrdev(0, "megadev", &megadev_fops);
>  
> +		if (!major) {
> +			printk(KERN_WARNING
> +				"megaraid: failed to register char
> device.\n");
> +		}
>  		/*
>  		 * Register the Shutdown Notification hook in kernel
>  		 */
> @@ -214,6 +223,13 @@
>  				"MegaRAID Shutdown routine not
> registered!!\n");
>  		}
>  
> +#ifdef LSI_CONFIG_COMPAT
> +		/*
> +		 * Register the 32-bit ioctl conversion
> +		 */
> +		register_ioctl32_conversion(MEGAIOCCMD,
> megadev_compat_ioctl);
> +#endif
> +

ditto


> @@ -620,12 +638,15 @@
>  
>  		/* Set the Mode of addressing to 64 bit if we can */
>  		if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) == 8))
> {
> -			pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
> -			adapter->has_64bit_addr = 1;
> +			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) ==
> 0)
> +				adapter->has_64bit_addr = 1;
>  		}
> -		else  {
> -			pci_set_dma_mask(pdev, 0xffffffff);
> -			adapter->has_64bit_addr = 0;
> +		if (!adapter->has_64bit_addr)  {
> +			if (pci_set_dma_mask(pdev, 0xffffffff) != 0) {
> +				printk("megaraid%d: DMA not available.\n",
> +					host->host_no);
> +				goto fail_attach;
> +			}

Bug -- always set dma mask.  Do not conditionally _not_ call 
pci_set_dma_mask(), for the 64-bit case.

Minor:  add ULL to the constant.



> @@ -2549,7 +2575,9 @@
>  		/*
>  		 * Unregister the character device interface to the driver.
>  		 */
> -		unregister_chrdev(major, "megadev");
> +		if (major) {
> +			unregister_chrdev(major, "megadev");
> +		}

register_chrdev() returns a negative errno value on error, such as -EBUSY.


> @@ -4434,8 +4332,9 @@
>  				/*
>  				 * Get the user data
>  				 */
> -				if( copy_from_user(data, (char *)uxferaddr,
> -							pthru->dataxferlen)
> ) {
> +				if( copy_from_user(data,
> +						(char *)((ulong)uxferaddr),
> +						pthru->dataxferlen) ) {

ummmm what???    uxferaddr is u32.  why are you casting it to a pointer?


> @@ -4460,8 +4359,8 @@
>  			 * Is data going up-stream
>  			 */
>  			if( pthru->dataxferlen && (uioc.flags & UIOC_RD) ) {
> -				if( copy_to_user((char *)uxferaddr, data,
> -							pthru->dataxferlen)
> ) {
> +				if( copy_to_user((char *)((ulong)uxferaddr),
> +						data, pthru->dataxferlen) )
> {

ditto



> diff -Naur old/drivers/scsi/megaraid2.h new/drivers/scsi/megaraid2.h
> --- old/drivers/scsi/megaraid2.h	2004-03-22 17:28:38.000000000 -0500
> +++ new/drivers/scsi/megaraid2.h	2004-03-22 13:10:48.000000000 -0500
>  #ifndef PCI_VENDOR_ID_LSI_LOGIC
>  #define PCI_VENDOR_ID_LSI_LOGIC		0x1000
>  #endif

this can be removed.



> +#if defined (CONFIG_COMPAT) || defined ( __x86_64__)
> +#define LSI_CONFIG_COMPAT
> +#endif
> +#ifdef LSI_CONFIG_COMPAT
> +static int megadev_compat_ioctl(unsigned int, unsigned int, unsigned long,
> +	struct file *);
> +#endif

I don't see how this construct will work in all cases.  Hence my 
CONFIG_COMPAT command above.

	Jeff



