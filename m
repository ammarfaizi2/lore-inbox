Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUFQTpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUFQTpk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUFQTpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:45:40 -0400
Received: from imap.gmx.net ([213.165.64.20]:61416 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261943AbUFQTpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:45:35 -0400
X-Authenticated: #20450766
Date: Thu, 17 Jun 2004 21:27:59 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] check_/request_region fixes & request for enlightenment
In-Reply-To: <Pine.LNX.4.56.0406162245320.11954@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.60.0406172036001.3926@poirot.grange>
References: <Pine.LNX.4.56.0406162245320.11954@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Jesper Juhl wrote:

> in the isp16.c case the region is free'ed in isp16_exit(), but one thing I

That looks like a bug - release_region() without request_region().

> don't understand is is I'm supposed to preserve the pointer returned by
> request_region and later pass that to release_region as well to make sure
> the right resource is free'ed? I see __release_region() taking 3
> parameters, but the release_region #define only takes two??? Could someone
> explain to me how that works?

No. You pass the same address and size you used to request the region.

> For now I assumed the current release_region in isp16_exit() is OK, and
> the code compiles fine with my changes, but I can't test it since I don't
> have the hardware.
> Here's the patch against 2.6.7 for that file - comments are very welcome :

You also have to release_region() in all failure-cases in the 
isp16_init(). Also, I think, if the region is busy you should return 
-EBUSY, but there I am not too sure.

> --- linux-2.6.7-orig/drivers/cdrom/isp16.c	2004-06-16 07:20:04.000000000 +0200
> +++ linux-2.6.7/drivers/cdrom/isp16.c	2004-06-16 22:36:52.000000000 +0200
> @@ -121,7 +121,7 @@ int __init isp16_init(void)
> 		return (0);
> 	}
>
> -	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
> +	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE, "isp16")) {
> 		printk("ISP16: i/o ports already in use.\n");
> 		return (-EIO);
> 	}
>
>
> Now, in trm290.c it seems that the region it tries to access is already
> requested in probe_hwif() in ide-probe.c, so the check_region is only used
> as an extra check to print an error message.  I see no code in trm290.c
> that ever tries to release the region, is that wrong, or does it simply
> rely on the code in ide-probe.c to release the region for it?
> How can it be that the check_region doesn't always fail if it has already
> been locked in ide-probe.c ?  And if it doesn't always fail, shouldn't the

It is requested later:

trm290_init_one
   ide_setup_pci_device

first calls

     do_ide_setup_pci_device
       ide_pci_setup_ports
         d->init_hwif(hwif) = init_hwif_trm290
           ***check_region***

then it calls

     probe_hwif_init
       probe_hwif
         ide_hwif_request_regions

where regions are requested. So, I would just completely through "check 
region" away. A bit uncomfortable is that the driver seems to need to 
configure the chip with the address:

 			hwif->OUTW(compat|1, hwif->config_data);
 			new = hwif->INW(hwif->config_data);

and that doesn't look very nice before request_region(). And there's no 
other hook between request_region() in probe_hwif and the first use of the 
chip, so, I am not quite sure if it is safe here to just blindly configure 
the chip with the port address...

Please, corect me anybody if I am wrong.

Guennadi

> driver release it itself right after doing it's check (now) with
> request_region?
>
> Here's what I came up with initially - just replacing check_region with
> request_region - but I have a feeling it's not that simple.
> Would anyone care to clarify?
>
> --- linux-2.6.7-orig/drivers/ide/pci/trm290.c	2004-06-16 07:19:01.000000000 +0200
> +++ linux-2.6.7/drivers/ide/pci/trm290.c	2004-06-16 22:57:24.000000000 +0200
> @@ -373,12 +373,12 @@ void __devinit init_hwif_trm290(ide_hwif
> 			/* leave lower 10 bits untouched */
> 			compat += (next_offset += 0x400);
> #  if 1
> -			if (check_region(compat + 2, 1))
> -				printk(KERN_ERR "%s: check_region failure at 0x%04x\n",
> +			if (!request_region(compat + 2, 1, "trm290"))
> +				printk(KERN_ERR "%s: request_region failure at 0x%04x\n",
> 					hwif->name, (compat + 2));
> 			/*
> 			 * The region check is not needed; however.........
> -			 * Since this is the checked in ide-probe.c,
> +			 * Since this is checked in ide-probe.c,
> 			 * this is only an assignment.
> 			 */
> #  endif
>
>
> I've been digging for a while looking for some documentation on this, but
> found nothing more than brief mentions about it in Documentation/
> Searching lkml archives and reading the
> check_region/request_region code provided enough info to give me the
> understanding I described above, but if someone has knowledge of some
> documentation/explanation on this I'd love a pointer so I can read up.
>
>
> --
> Jesper Juhl <juhl-lkml@dif.dk>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

---
Guennadi Liakhovetski

