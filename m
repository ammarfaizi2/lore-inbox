Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287932AbSAMBd3>; Sat, 12 Jan 2002 20:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSAMBdT>; Sat, 12 Jan 2002 20:33:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26884 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287932AbSAMBdL>; Sat, 12 Jan 2002 20:33:11 -0500
Subject: Re: [PATCH][RFC] unchecked request_region's in drivers/net
To: srwalter@yahoo.com (Steven Walter)
Date: Sun, 13 Jan 2002 01:44:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020112183542.A5557@hapablap.dyn.dhs.org> from "Steven Walter" at Jan 12, 2002 06:35:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZhk-0003jZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any objection to this being merged in both 2.4 and 2.5?

It would be nice to get them correct first. Can you split out the ones which
just fix

	if (check_region....)
	{
	}
	request_region

with no intervening logic and submit those first ?


> -	if (check_region(dev->base_addr, SER12_EXTENT))
> +	if (!request_region(dev->base_addr, SER12_EXTENT,
> +				"baycom_ser_fdx"))
>  		return -EACCES;
>  	memset(&bc->modem, 0, sizeof(bc->modem));
>  	bc->hdrv.par.bitrate = bc->baud;
> @@ -431,7 +432,6 @@
>  	if (request_irq(dev->irq, ser12_interrupt, SA_INTERRUPT | SA_SHIRQ,
>  			"baycom_ser_fdx", dev))
>  		return -EBUSY;

This path fails to free the region

>  	if (request_irq(dev->irq, ser12_interrupt, SA_INTERRUPT | SA_SHIRQ,
>  			"baycom_ser12", dev))
>  		return -EBUSY;
> -	request_region(dev->base_addr, SER12_EXTENT, "baycom_ser12");

Ditto

> -		}
>  		if (request_irq(dev->irq, COMX_interrupt, 0, dev->name, 
>  		   (void *)dev)) {
>  			printk(KERN_ERR "comx-hw-comx: unable to obtain irq %d\n", dev->irq);
>  			return -EAGAIN;

Ditto

>  	for (; (i < maxSlots) && (dev != NULL); iobase += EWRK3_IOP_INC, i++) {
> -		if (!check_region(iobase, EWRK3_TOTAL_SIZE)) {
> +		if (request_region(iobase, EWRK3_TOTAL_SIZE, dev->name)) {
>  			if (DevicePresent(iobase) == 0) {

Here you keep forgeting to free the regions

> diff -Nru clean-2.4.17//drivers/net/wan/sealevel.c linux/drivers/net/wan/sealevel.c
> --- clean-2.4.17//drivers/net/wan/sealevel.c	Mon Nov  5 19:23:14 2001
> +++ linux/drivers/net/wan/sealevel.c	Thu Dec 27 14:18:21 2001
> @@ -219,12 +219,11 @@
>  	 *	Get the needed I/O space
>  	 */
>  	 
> -	if(check_region(iobase, 8))
> +	if(!request_region(iobase, 8, "Sealevel 4021"))
>  	{	
>  		printk(KERN_WARNING "sealevel: I/O 0x%X already in use.\n", iobase);
>  		return NULL;
>  	}
> -	request_region(iobase, 8, "Sealevel 4021");
>  	
>  	b=(struct slvl_board *)kmalloc(sizeof(struct slvl_board), GFP_KERNEL);
>  	if(!b)

This one I'm maintainer of and approve
