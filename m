Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTFKEIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 00:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTFKEIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 00:08:38 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:35969
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264072AbTFKEIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 00:08:36 -0400
Date: Wed, 11 Jun 2003 00:09:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ted.Wen@ite.com.tw
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ITE887x parport_serial driver
In-Reply-To: <DC62C613C2F7274C9D361EA476413476437546@itemail1.internal.ite.com.tw>
Message-ID: <Pine.LNX.4.50.0306102358340.19137-100000@montezuma.mastecende.com>
References: <DC62C613C2F7274C9D361EA476413476437546@itemail1.internal.ite.com.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003 Ted.Wen@ite.com.tw wrote:

> In parport_serial , I request a irq and request region to initialize 887x ,
> so I must run a additional ite887x_removecheck function to check it.
> Some type of 887x  only with serial or only with parport , so that 
> sometimes the port num would be 0 .
>  I want the driver can proceed with runing even the card with no parport , or with on serial.
> ( the original driver return -ENODEV while fail in parport_register or serial_register )
>  I set success = 1 while the port num =0 in the tables , to avoid fail from parport register or serial register.

Still a few things to work out, basically it would be nice to remove any 
none generic functions out of generic ones. Can't you add postremove 
hooks?

> I also fix a bug while printk the parport information.
> The original driver printk parport_serial_pci_tb[i].vendor , 
>   the index "i" is be used to cards[i].....but parport_serial_pci_tbl and cards are not match.
> The bug will show wrong message wile printk parport information,
>  so I fix it to be dev->vendor , to show the correct message.

Thanks that looks correct.

> +ite887x_removecheck(struct pci_dev *dev)
> +{
> +	if (dev->vendor == PCI_VENDOR_ID_ITE
> +	    && dev->device == PCI_DEVICE_ID_ITE_8872) {
> +		free_irq(dev->irq, dev);
> +		release_region(ITE887x_INTA[rm_ite++], 0x8);
> +	}
> +}

This would be the post remove hook function for ITE

> +	if (board->num_ports == 0)
> +		success = 1;
>
>  	for (k = 0; k < board->num_ports; k++) {
>  		int line;
>  		serial_req.irq = dev->irq;

I understand what you're doing there but i'll think about a way to avoid 
the serial_register instead.

> @@ -308,6 +483,8 @@
>  	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
>  		return -ENODEV;
>  
> +	if (cards[i].numports == 0)
> +		success = 1;
>  	for (n = 0; n < cards[i].numports; n++) {
>  		struct parport *port;
>  		int lo = cards[i].addr[n].lo;

Ditto.

> @@ -324,8 +501,8 @@
>  		/* TODO: test if sharing interrupts works */
>  		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
>  			"I/O at %#lx(%#lx)\n",
> -			parport_serial_pci_tbl[i].vendor,
> -			parport_serial_pci_tbl[i].device, io_lo, io_hi);
> +			dev->vendor,
> +			dev->device, io_lo, io_hi);
>  		port = parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
>  					      PARPORT_DMA_NONE, dev);

Nice catch.

>  		if (port) {
> @@ -359,6 +536,7 @@
>  		return err;
>  	}
>  
> +	ite887x_index = id->driver_data;
>  	if (parport_register (dev, id)) {
>  		pci_set_drvdata (dev, NULL);
>  		kfree (priv);
> @@ -395,6 +573,7 @@
>  	for (i = 0; i < priv->num_par; i++)
>  		parport_pc_unregister_port (priv->port[i]);
>  
> +	ite887x_removecheck(dev);
>  	kfree (priv);
>  	return;

Perhaps you can add a hook so that devices can do cleanup in 
parport_serial_pci_remove, in the same vein as the preinit hooks.

Thanks,
	Zwane
-- 
function.linuxpower.ca
