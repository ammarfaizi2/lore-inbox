Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136693AbRA1Mj6>; Sun, 28 Jan 2001 07:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136811AbRA1Mjs>; Sun, 28 Jan 2001 07:39:48 -0500
Received: from front7m.grolier.fr ([195.36.216.57]:38542 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S136693AbRA1Mjn> convert rfc822-to-8bit; Sun, 28 Jan 2001 07:39:43 -0500
Date: Sun, 28 Jan 2001 12:38:50 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.rutgers.edu
Subject: Re: [PATCH] make drivers/scsi/sym53c8xx.c check request_region's
 return code (241p9)]
In-Reply-To: <20010125212655.D603@jaquet.dk>
Message-ID: <Pine.LNX.4.10.10101281225370.1206-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jan 2001, Rasmus Andersen wrote:

> Hi.
> 
> I apparently forgot to cc the lists on this one. Replies should be cc'ed
> to groudier@club-internet.fr also.
> 
> Thanks.

The change should not harm, but request_region() is very unlikely to fail
here. Reason is that the drivers previously perform a check_region() in
order to synchronyze with any other driver that may have attached the same
device (candidates are : sym53c8xx, ncr53c8xx, 53c7,8xx)

By the way, as PCI only device drivers, the [sym|ncr]53c8xx drivers want
to use MMIO and not normal IO. The 'normal IO' path is here for archs that
donnot want to accept MMIO. Note that there are a couple of strangenesses
here:

1) The FreeBSD sym driver (derived from sym53c8xx) works with MMIO on
   FreeBSD/Alpha, but the sym53c8xx fails MMIO under Linux/Alpha.
2) Power/PC port wants drivers to use normal IOs even on machines that
   only have MMIO.

(2) looks rather a weirdness than a strangeness. :-)

Gérard.

> ----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----
> 
> Date: Tue, 23 Jan 2001 23:37:14 +0100
> From: Rasmus Andersen <rasmus@jaquet.dk>
> To: groudier@club-internet.fr
> Subject: [PATCH] make drivers/scsi/sym53c8xx.c check request_region's return code (241p9)
> User-Agent: Mutt/1.2.4i
> 
> Hi.
> 
> The following patch makes drivers/scsi/sym53c8xx.c check the return
> code of request_region. It applies cleanly against ac10 and 241p9.
> 
> Please comment.
> 
> 
> 
> --- linux-ac10-clean/drivers/scsi/sym53c8xx.c	Mon Jan  1 19:23:21 2001
> +++ linux-ac10/drivers/scsi/sym53c8xx.c	Sun Jan 21 21:40:54 2001
> @@ -5817,7 +5817,11 @@
>  	*/
>  
>  	if (device->slot.io_port) {
> -		request_region(device->slot.io_port, np->base_ws, NAME53C8XX);
> +		if (!request_region(device->slot.io_port, np->base_ws, 
> +				    NAME53C8XX)) {
> +			printk(KERN_ERR "Cannot mmap IO range.\n");
> +			goto attach_error;
> +		}
>  		np->base_io = device->slot.io_port;
>  	}
> 
> --- linux-ac10-clean/drivers/scsi/sym53c8xx_comm.h	Mon Oct 16 21:56:50 2000
> +++ linux-ac10/drivers/scsi/sym53c8xx_comm.h	Mon Jan 22 21:56:46 2001
> @@ -1799,7 +1799,8 @@
>  	**    Get access to chip IO registers
>  	*/
>  #ifdef NCR_IOMAPPED
> -	request_region(devp->slot.io_port, 128, NAME53C8XX);
> +	if (!request_region(devp->slot.io_port, 128, NAME53C8XX))
> +		return;
>  	devp->slot.base_io = devp->slot.io_port;
>  #else
>  	devp->slot.reg = (struct ncr_reg *) remap_pci_mem(devp->slot.base, 128);
> 
> 
> -- 
> Regards,
>         Rasmus(rasmus@jaquet.dk)
> 
> It isn't pollution that's harming the environment. It's the impurities in
> our air and water that are doing it.  -Former U.S. Vice-President Dan
> Quayle
> 
> ----- End forwarded message -----
> 
> -- 
> Regards,
>         Rasmus(rasmus@jaquet.dk)
> 
> Freedom of the press is limited to those who own one.
>                                  - A.J. Liebling 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
