Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRA2Wvw>; Mon, 29 Jan 2001 17:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRA2Wvn>; Mon, 29 Jan 2001 17:51:43 -0500
Received: from front4.grolier.fr ([194.158.96.54]:9178 "EHLO front4.grolier.fr")
	by vger.kernel.org with ESMTP id <S129390AbRA2Wvd> convert rfc822-to-8bit;
	Mon, 29 Jan 2001 17:51:33 -0500
Date: Mon, 29 Jan 2001 22:50:31 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] make sym53c8xx.c and ncr53c8xx.c call pci_enable_device
 (241p11)
In-Reply-To: <20010129230041.N603@jaquet.dk>
Message-ID: <Pine.LNX.4.10.10101292235170.2036-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You missed that SYMBIOS devices can be attached by RAID firmware and,
that, in such situation, the kernel should avoid tampering the SYMBIOS
device. The [ncr|sym]53c8xx drivers are aware of that, and donnot attach
SYMBIOS devices owned by RAID.

If the pci_enable_device() thing is to be added to the drivers, it must
preferently be placed after the checking against RAID attachement.

(look for 0x52414944 in the driver source which is the signature tested by
the drivers, or look into beta SYM-2).

Gérard.

On Mon, 29 Jan 2001, Rasmus Andersen wrote:

> Hi.
> 
> The following patch makes drivers/scsi/sym53c8xx.c and (by way of
> sym53c8xx_comm.h::sym53c8xx__detect) ncr53c8xx.c do a
> pci_enable_device after finding a device.
> 
> It applies against ac12 and 241p11.
> 
> Comments?
> 
> 
> --- linux-ac11-clean/drivers/scsi/sym53c8xx.c	Mon Jan  1 19:23:21 2001
> +++ linux-ac11/drivers/scsi/sym53c8xx.c	Thu Jan 25 23:12:06 2001
> @@ -13294,6 +13294,8 @@
>  			++j;
>  			continue;
>  		}
> +		if (pci_enable_device(pcidev))
> +			continue;
>  		/* Some HW as the HP LH4 may report twice PCI devices */
>  		for (i = 0; i < count ; i++) {
>  			if (devtbl[i].slot.bus	     == PciBusNumber(pcidev) && 
> --- linux-ac11-clean/drivers/scsi/sym53c8xx_comm.h	Mon Oct 16 21:56:50 2000
> +++ linux-ac11/drivers/scsi/sym53c8xx_comm.h	Fri Jan 26 22:54:19 2001
> @@ -2754,6 +2754,8 @@
>  			++j;
>  			continue;
>  		}
> +		if (pci_enable_device(pcidev))
> +			continue;
>  		/* Some HW as the HP LH4 may report twice PCI devices */
>  		for (i = 0; i < count ; i++) {
>  			if (devtbl[i].slot.bus	     == PciBusNumber(pcidev) && 
> 
> -- 
> Regards,
>         Rasmus(rasmus@jaquet.dk)
> 
> When C++ is your hammer, everything looks like a thumb.      Steven M. Haflich
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
