Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUCWAD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUCWAD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:03:57 -0500
Received: from mail0.lsil.com ([147.145.40.20]:64415 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261669AbUCWADP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:03:15 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C77B@exa-atlanta.se.lsil.com>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH][RELEASE] megaraid 2.10.2 Driver
Date: Mon, 22 Mar 2004 19:02:39 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

>>For upstream, this should just be CONFIG_COMPAT I presume.

For 2.6 kernels, this would be just CONFIG_COMPAT. Or have I
misunderstood your comment?

>>I don't see how this construct will work in all cases.  Hence my 
>>CONFIG_COMPAT command above.

We saw the need for ioctl compatibility in __x86_64__ cases so far.
What other cases will this not work in?

>>Bug -- always set dma mask.  Do not conditionally _not_ call 
>>pci_set_dma_mask(), for the 64-bit case.

The code does not __not__ call pci_set_dma_mask() conditionally.
It is always calling with either 64-bit or 32-bit mask.

>>ummmm what???    uxferaddr is u32.  why are you casting it to a pointer?

Both copy_to_user and copy_from_user take pointers, don't they?

Thank you,
Sreenivas

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Monday, March 22, 2004 6:08 PM
To: Bagalkote, Sreenivas
Cc: 'linux-kernel@vger.kernel.org'; 'linux-scsi@vger.kernel.org'
Subject: Re: [PATCH][RELEASE] megaraid 2.10.2 Driver


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
> +static int megadev_compat_ioctl(unsigned int, unsigned int, unsigned
long,
> +	struct file *);
> +#endif

I don't see how this construct will work in all cases.  Hence my 
CONFIG_COMPAT command above.

	Jeff


