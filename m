Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWBWKKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWBWKKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWBWKK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:10:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2066 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751673AbWBWKK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:10:28 -0500
Date: Thu, 23 Feb 2006 10:10:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       linux-kernel@vger.kernel.org, magne@samfundet.no
Subject: Re: [PATCH] Problem with detecting the serial ports on a NetMos 9845
Message-ID: <20060223101018.GA8728@flint.arm.linux.org.uk>
Mail-Followup-To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
	linux-kernel@vger.kernel.org, magne@samfundet.no
References: <20060210174836.GA16968@uio.no> <20060215110034.GF21003@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215110034.GF21003@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello?  Did this patch fix all the reported problems?

On Wed, Feb 15, 2006 at 11:00:34AM +0000, Russell King wrote:
> On Fri, Feb 10, 2006 at 06:48:36PM +0100, Steinar H. Gunderson wrote:
> > We have a NetMos 9845 controller with four serial ports but no parallel port, 
> > and tried to use parport_serial driver with it. However, all it would say was
> > that it had detected a parallel port at 9710:9735, and then exit.
> > 
> > We tracked it down, and found two problems:
> > 
> >   - For some reason, it detects the 9845 as a 9735 -- it appears this is
> >     simply related to the ordering in parport_serial_pci_tbl[]. If we move
> >     the 9845 up above the 9735, it prints out 9710:9845, but no change in
> >     behaviour. (We didn't find out why this was the case; we left it alone
> >     since it didn't affect our problem.)
> 
> The driver debugging code is buggy.  Let's look:
> 
> enum parport_pc_pci_cards {
>         titan_110l = 0,
>         titan_210l,
>         netmos_9xx5_combo,
>         netmos_9855,
> ...
> 
> so, netmos_9xx5_combo has the value '2'.
> static struct pci_device_id parport_serial_pci_tbl[] = {
>         /* PCI cards */
>         { PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_110L,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
>         { PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
>         { PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
> 
> This is the second entry in this table - make a note of that.
> 
>         { PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9745,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
>         { PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
>         { PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
>         { PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
> 
> and this is the entry which your card matches, and uses netmos_9xx5_combo.
> ...
> 
> static int __devinit parport_register (struct pci_dev *dev,
>                                        const struct pci_device_id *id)
> {
>         int i = id->driver_data, n;
> 
> id->driver_data is the 7th value in the pci table above.  As we
> noted, this is netmos_9xx5_combo which has value '2', so i=2.
> ...
>                 printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
>                         "I/O at %#lx(%#lx)\n",
>                         parport_serial_pci_tbl[i].vendor,
>                         parport_serial_pci_tbl[i].device, io_lo, io_hi);
> 
> and so we index the pci device id table with something which is an
> index to a different table.  parport_serial_pci_tbl[2] happens to
> be the Netmos 9735 entry.
> 
> > --- linux-source-2.6.12-2.6.12/drivers/parport/parport_serial.c	2005-06-17 21:48:29.000000000 +0200
> > @@ -418,10 +419,13 @@
> >  		return err;
> >  	}
> >  
> > -	if (parport_register (dev, id)) {
> > +	err = parport_register (dev, id);
> > +	if (err < 0) {
> >  		pci_set_drvdata (dev, NULL);
> >  		kfree (priv);
> >  		return -ENODEV;
> > +	} else if (err) {
> > +		priv->num_par = 0;
> 
> num_par will be zero here anyway, so this else clause isn't gaining
> us anything.  Here's an alternative patch which should also fix your
> other issue:
> 
> diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
> --- a/drivers/parport/parport_serial.c
> +++ b/drivers/parport/parport_serial.c
> @@ -312,8 +312,7 @@ static int __devinit parport_register (s
>  {
>  	struct parport_pc_pci *card;
>  	struct parport_serial_private *priv = pci_get_drvdata (dev);
> -	int i = id->driver_data, n;
> -	int success = 0;
> +	int n, success = 0;
>  
>  	priv->par = cards[id->driver_data];
>  	card = &priv->par;
> @@ -344,10 +343,8 @@ static int __devinit parport_register (s
>                                          "hi" as an offset (see SYBA
>                                          def.) */
>  		/* TODO: test if sharing interrupts works */
> -		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
> -			"I/O at %#lx(%#lx)\n",
> -			parport_serial_pci_tbl[i].vendor,
> -			parport_serial_pci_tbl[i].device, io_lo, io_hi);
> +		dev_dbg(&dev->dev, "PCI parallel port detected: I/O at "
> +			"%#lx(%#lx)\n", io_lo, io_hi);
>  		port = parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
>  					      PARPORT_DMA_NONE, dev);
>  		if (port) {
> @@ -359,7 +356,7 @@ static int __devinit parport_register (s
>  	if (card->postinit_hook)
>  		card->postinit_hook (dev, card, !success);
>  
> -	return success ? 0 : 1;
> +	return 0;
>  }
>  
>  static int __devinit parport_serial_pci_probe (struct pci_dev *dev,
> 
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
