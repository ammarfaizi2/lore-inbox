Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUFMWI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUFMWI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 18:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUFMWI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 18:08:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24450 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261206AbUFMWHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 18:07:38 -0400
Date: Sun, 13 Jun 2004 19:07:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Ryan Underwood <nemesis-lists@icequake.net>,
       Willy Tarreau <willy@w.ods.org>, twaugh@redhat.com
Subject: Re: Request: Netmos support in parport_serial for 2.4.27
Message-ID: <20040613220727.GB4771@logos.cnet>
References: <20040613111949.GB6564@dbz.icequake.net> <20040613123950.GA3332@logos.cnet> <Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesper, 

Two more things.

It seems v2.6 also lacks support for this boards:

grep PCI_DEVICE_ID_NETMOS_ *
pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9735     0x9735
pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9835     0x9835
[marcelo@localhost linux]$

Care to prepare a v2.6 version?

And two, do we really need to move parport_serial.c to drivers/char in v2.4 ? 

Thanks again

On Sun, Jun 13, 2004 at 10:30:35PM +0200, Jesper Juhl wrote:
> On Sun, 13 Jun 2004, Marcelo Tosatti wrote:
> 
> > n Sun, Jun 13, 2004 at 06:19:49AM -0500, Ryan Underwood wrote:
> > >
> > > Hi,
> > >
> > > There's been a patch floating around for a while now to add Netmos
> > > support to parport_serial.  It has been submitted numerous times but it
> > > seems that nobody notices it. :)
> > >
> > > Can it be reviewed for inclusion before 2.4.27?  I have a few systems
> > > with these cards and it would be very nice to have them up to snuff.
> > >
> > > The patch against 2.4.20 can be found here:
> > > http://winterwolf.co.uk/linuxsw
> >
> > Hi Ryan,
> >
> > Care to submit the patch inlined in another email message?
> >
> 
> Here are the original patches from http://winterwolf.co.uk/linuxsw
> An attempt of mine to update them for 2.4.27-pre5 can be found elsewhere
> in this thread.
> 
> 
> Kind regards,
> Jesper Juhl <juhl-lkml@dif.dk>
> 
> 
> 00_parport_serial.patch :
> 
> diff -urN orig/linux-2.4.20-pre9/drivers/char/ChangeLog linux-2.4.20-pre9/drivers/char/ChangeLog
> --- orig/linux-2.4.20-pre9/drivers/char/ChangeLog	Tue Aug 14 01:37:33 2001
> +++ linux-2.4.20-pre9/drivers/char/ChangeLog	Sat Oct  5 17:58:35 2002
> @@ -1,3 +1,8 @@
> +2002-09-21  Marek Michalkiewicz  <marekm@amelek.gda.pl>
> +
> +	* parport_serial.c: Move from ../parport/ here, must be initialised
> +	after serial.c for register_serial to work.
> +
>  2001-08-11  Tim Waugh  <twaugh@redhat.com>
> 
>  	* serial.c (get_pci_port): Deal with awkward Titan cards.
> diff -urN orig/linux-2.4.20-pre9/drivers/char/Makefile linux-2.4.20-pre9/drivers/char/Makefile
> --- orig/linux-2.4.20-pre9/drivers/char/Makefile	Sat Oct  5 17:43:27 2002
> +++ linux-2.4.20-pre9/drivers/char/Makefile	Sat Oct  5 17:58:35 2002
> @@ -153,6 +153,7 @@
> 
>  obj-$(CONFIG_VT) += vt.o vc_screen.o consolemap.o consolemap_deftbl.o $(CONSOLE) selection.o
>  obj-$(CONFIG_SERIAL) += $(SERIAL)
> +obj-$(CONFIG_PARPORT_SERIAL) += parport_serial.o
>  obj-$(CONFIG_SERIAL_HCDP) += hcdp_serial.o
>  obj-$(CONFIG_SERIAL_21285) += serial_21285.o
>  obj-$(CONFIG_SERIAL_SA1100) += serial_sa1100.o
> diff -urN orig/linux-2.4.20-pre9/drivers/char/parport_serial.c linux-2.4.20-pre9/drivers/char/parport_serial.c
> --- orig/linux-2.4.20-pre9/drivers/char/parport_serial.c	Thu Jan  1 01:00:00 1970
> +++ linux-2.4.20-pre9/drivers/char/parport_serial.c	Sat Oct  5 17:58:35 2002
> @@ -0,0 +1,426 @@
> +/*
> + * Support for common PCI multi-I/O cards (which is most of them)
> + *
> + * Copyright (C) 2001  Tim Waugh <twaugh@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + *
> + * Multi-function PCI cards are supposed to present separate logical
> + * devices on the bus.  A common thing to do seems to be to just use
> + * one logical device with lots of base address registers for both
> + * parallel ports and serial ports.  This driver is for dealing with
> + * that.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/parport.h>
> +#include <linux/parport_pc.h>
> +#include <linux/serial.h>
> +#include <linux/serialP.h>
> +#include <linux/list.h>
> +
> +#include <asm/serial.h>
> +
> +enum parport_pc_pci_cards {
> +	titan_110l = 0,
> +	titan_210l,
> +	avlab_1s1p,
> +	avlab_1s1p_650,
> +	avlab_1s1p_850,
> +	avlab_1s2p,
> +	avlab_1s2p_650,
> +	avlab_1s2p_850,
> +	avlab_2s1p,
> +	avlab_2s1p_650,
> +	avlab_2s1p_850,
> +	siig_1s1p_10x,
> +	siig_2s1p_10x,
> +	siig_2p1s_20x,
> +	siig_1s1p_20x,
> +	siig_2s1p_20x,
> +};
> +
> +
> +/* each element directly indexed from enum list, above */
> +static struct parport_pc_pci {
> +	int numports;
> +	struct { /* BAR (base address registers) numbers in the config
> +                    space header */
> +		int lo;
> +		int hi; /* -1 if not there, >6 for offset-method (max
> +                           BAR is 6) */
> +	} addr[4];
> +
> +	/* If set, this is called immediately after pci_enable_device.
> +	 * If it returns non-zero, no probing will take place and the
> +	 * ports will not be used. */
> +	int (*preinit_hook) (struct pci_dev *pdev, int autoirq, int autodma);
> +
> +	/* If set, this is called after probing for ports.  If 'failed'
> +	 * is non-zero we couldn't use any of the ports. */
> +	void (*postinit_hook) (struct pci_dev *pdev, int failed);
> +} cards[] __devinitdata = {
> +	/* titan_110l */		{ 1, { { 3, -1 }, } },
> +	/* titan_210l */		{ 1, { { 3, -1 }, } },
> +	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
> +	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
> +	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
> +	/* avlab_1s2p     */		{ 2, { { 1, 2}, { 3, 4 },} },
> +	/* avlab_1s2p_650 */		{ 2, { { 1, 2}, { 3, 4 },} },
> +	/* avlab_1s2p_850 */		{ 2, { { 1, 2}, { 3, 4 },} },
> +	/* avlab_2s1p     */		{ 1, { { 2, 3}, } },
> +	/* avlab_2s1p_650 */		{ 1, { { 2, 3}, } },
> +	/* avlab_2s1p_850 */		{ 1, { { 2, 3}, } },
> +	/* siig_1s1p_10x */		{ 1, { { 3, 4 }, } },
> +	/* siig_2s1p_10x */		{ 1, { { 4, 5 }, } },
> +	/* siig_2p1s_20x */		{ 2, { { 1, 2 }, { 3, 4 }, } },
> +	/* siig_1s1p_20x */		{ 1, { { 1, 2 }, } },
> +	/* siig_2s1p_20x */		{ 1, { { 2, 3 }, } },
> +};
> +
> +static struct pci_device_id parport_serial_pci_tbl[] __devinitdata = {
> +	/* PCI cards */
> +	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_110L,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
> +	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
> +	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
> +	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
> +	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
> +	{ 0x14db, 0x2112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_850},
> +	{ 0x14db, 0x2140, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s2p},
> +	{ 0x14db, 0x2141, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s2p_650},
> +	{ 0x14db, 0x2142, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s2p_850},
> +	{ 0x14db, 0x2160, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p},
> +	{ 0x14db, 0x2161, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p_650},
> +	{ 0x14db, 0x2162, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p_850},
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_550,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_650,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_850,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_550,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_650,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_850,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_550,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_650,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_850,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_550,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_650,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_20x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_850,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_20x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_550,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_650,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
> +	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
> +
> +	{ 0, } /* terminate list */
> +};
> +MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
> +
> +struct pci_board_no_ids {
> +	int flags;
> +	int num_ports;
> +	int base_baud;
> +	int uart_offset;
> +	int reg_shift;
> +	int (*init_fn)(struct pci_dev *dev, struct pci_board_no_ids *board,
> +			int enable);
> +	int first_uart_offset;
> +};
> +
> +static int __devinit siig10x_init_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
> +{
> +	return pci_siig10x_fn(dev, NULL, enable);
> +}
> +
> +static int __devinit siig20x_init_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
> +{
> +	return pci_siig20x_fn(dev, NULL, enable);
> +}
> +
> +static struct pci_board_no_ids pci_boards[] __devinitdata = {
> +	/*
> +	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
> +	 * Offset to get to next UART's registers,
> +	 * Register shift to use for memory-mapped I/O,
> +	 * Initialization function, first UART offset
> +	 */
> +
> +// Cards not tested are marked n/t
> +// If you have one of these cards and it works for you, please tell me..
> +
> +/* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
> +/* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
> +/* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> +/* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> +/* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> +/* avlab_1s2p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> +/* avlab_1s2p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> +/* avlab_1s2p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> +/* avlab_2s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
> +/* avlab_2s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
> +/* avlab_2s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
> +/* siig_1s1p_10x */	{ SPCI_FL_BASE2, 1, 460800, 0, 0, siig10x_init_fn },
> +/* siig_2s1p_10x */	{ SPCI_FL_BASE2, 1, 921600, 0, 0, siig10x_init_fn },
> +/* siig_2p1s_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
> +/* siig_1s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
> +/* siig_2s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
> +};
> +
> +struct parport_serial_private {
> +	int num_ser;
> +	int line[20];
> +	struct pci_board_no_ids ser;
> +	int num_par;
> +	struct parport *port[PARPORT_MAX];
> +};
> +
> +static int __devinit get_pci_port (struct pci_dev *dev,
> +				   struct pci_board_no_ids *board,
> +				   struct serial_struct *req,
> +				   int idx)
> +{
> +	unsigned long port;
> +	int base_idx;
> +	int max_port;
> +	int offset;
> +
> +	base_idx = SPCI_FL_GET_BASE(board->flags);
> +	if (board->flags & SPCI_FL_BASE_TABLE)
> +		base_idx += idx;
> +
> +	if (board->flags & SPCI_FL_REGION_SZ_CAP) {
> +		max_port = pci_resource_len(dev, base_idx) / 8;
> +		if (idx >= max_port)
> +			return 1;
> +	}
> +
> +	offset = board->first_uart_offset;
> +
> +	/* Timedia/SUNIX uses a mixture of BARs and offsets */
> +	/* Ugh, this is ugly as all hell --- TYT */
> +	if(dev->vendor == PCI_VENDOR_ID_TIMEDIA )  /* 0x1409 */
> +		switch(idx) {
> +			case 0: base_idx=0;
> +				break;
> +			case 1: base_idx=0; offset=8;
> +				break;
> +			case 2: base_idx=1;
> +				break;
> +			case 3: base_idx=1; offset=8;
> +				break;
> +			case 4: /* BAR 2*/
> +			case 5: /* BAR 3 */
> +			case 6: /* BAR 4*/
> +			case 7: base_idx=idx-2; /* BAR 5*/
> +		}
> +
> +	port =  pci_resource_start(dev, base_idx) + offset;
> +
> +	if ((board->flags & SPCI_FL_BASE_TABLE) == 0)
> +		port += idx * (board->uart_offset ? board->uart_offset : 8);
> +
> +	if (pci_resource_flags (dev, base_idx) & IORESOURCE_IO) {
> +		int high_bits_offset = ((sizeof(long)-sizeof(int))*8);
> +		req->port = port;
> +		if (high_bits_offset)
> +			req->port_high = port >> high_bits_offset;
> +		else
> +			req->port_high = 0;
> +		return 0;
> +	}
> +	req->io_type = SERIAL_IO_MEM;
> +	req->iomem_base = ioremap(port, board->uart_offset);
> +	req->iomem_reg_shift = board->reg_shift;
> +	req->port = 0;
> +	return req->iomem_base ? 0 : 1;
> +}
> +
> +/* Register the serial port(s) of a PCI card. */
> +static int __devinit serial_register (struct pci_dev *dev,
> +				      const struct pci_device_id *id)
> +{
> +	struct pci_board_no_ids *board = &pci_boards[id->driver_data];
> +	struct parport_serial_private *priv = pci_get_drvdata (dev);
> +	struct serial_struct serial_req;
> +	int base_baud;
> +	int k;
> +	int success = 0;
> +
> +	priv->ser = *board;
> +	if (board->init_fn && ((board->init_fn) (dev, board, 1) != 0))
> +		return 1;
> +
> +	base_baud = board->base_baud;
> +	if (!base_baud)
> +		base_baud = BASE_BAUD;
> +	memset (&serial_req, 0, sizeof (serial_req));
> +
> +	for (k = 0; k < board->num_ports; k++) {
> +		int line;
> +		serial_req.irq = dev->irq;
> +		if (get_pci_port (dev, board, &serial_req, k))
> +			break;
> +		serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
> +		serial_req.baud_base = base_baud;
> +		line = register_serial (&serial_req);
> +		if (line < 0) {
> +			printk (KERN_DEBUG
> +				"parport_serial: register_serial failed\n");
> +			continue;
> +		}
> +		priv->line[priv->num_ser++] = line;
> +		success = 1;
> +	}
> +
> +	return success ? 0 : 1;
> +}
> +
> +/* Register the parallel port(s) of a PCI card. */
> +static int __devinit parport_register (struct pci_dev *dev,
> +				       const struct pci_device_id *id)
> +{
> +	struct parport_serial_private *priv = pci_get_drvdata (dev);
> +	int i = id->driver_data, n;
> +	int success = 0;
> +
> +	if (cards[i].preinit_hook &&
> +	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
> +		return -ENODEV;
> +
> +	for (n = 0; n < cards[i].numports; n++) {
> +		struct parport *port;
> +		int lo = cards[i].addr[n].lo;
> +		int hi = cards[i].addr[n].hi;
> +		unsigned long io_lo, io_hi;
> +		io_lo = pci_resource_start (dev, lo);
> +		io_hi = 0;
> +		if ((hi >= 0) && (hi <= 6))
> +			io_hi = pci_resource_start (dev, hi);
> +		else if (hi > 6)
> +			io_lo += hi; /* Reinterpret the meaning of
> +                                        "hi" as an offset (see SYBA
> +                                        def.) */
> +		/* TODO: test if sharing interrupts works */
> +		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
> +			"I/O at %#lx(%#lx)\n",
> +			parport_serial_pci_tbl[i].vendor,
> +			parport_serial_pci_tbl[i].device, io_lo, io_hi);
> +		port = parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
> +					      PARPORT_DMA_NONE, dev);
> +		if (port) {
> +			priv->port[priv->num_par++] = port;
> +			success = 1;
> +		}
> +	}
> +
> +	if (cards[i].postinit_hook)
> +		cards[i].postinit_hook (dev, !success);
> +
> +	return success ? 0 : 1;
> +}
> +
> +static int __devinit parport_serial_pci_probe (struct pci_dev *dev,
> +					       const struct pci_device_id *id)
> +{
> +	struct parport_serial_private *priv;
> +	int err;
> +
> +	priv = kmalloc (sizeof *priv, GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->num_ser = priv->num_par = 0;
> +	pci_set_drvdata (dev, priv);
> +
> +	err = pci_enable_device (dev);
> +	if (err) {
> +		pci_set_drvdata (dev, NULL);
> +		kfree (priv);
> +		return err;
> +	}
> +
> +	if (parport_register (dev, id)) {
> +		pci_set_drvdata (dev, NULL);
> +		kfree (priv);
> +		return -ENODEV;
> +	}
> +
> +	if (serial_register (dev, id)) {
> +		int i;
> +		for (i = 0; i < priv->num_par; i++)
> +			parport_pc_unregister_port (priv->port[i]);
> +		pci_set_drvdata (dev, NULL);
> +		kfree (priv);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __devexit parport_serial_pci_remove (struct pci_dev *dev)
> +{
> +	struct parport_serial_private *priv = pci_get_drvdata (dev);
> +	int i;
> +
> +	// Serial ports
> +	for (i = 0; i < priv->num_ser; i++) {
> +		unregister_serial (priv->line[i]);
> +
> +		if (priv->ser.init_fn)
> +			(priv->ser.init_fn) (dev, &priv->ser, 0);
> +	}
> +	pci_set_drvdata (dev, NULL);
> +
> +	// Parallel ports
> +	for (i = 0; i < priv->num_par; i++)
> +		parport_pc_unregister_port (priv->port[i]);
> +
> +	kfree (priv);
> +	return;
> +}
> +
> +static struct pci_driver parport_serial_pci_driver = {
> +	name:		"parport_serial",
> +	id_table:	parport_serial_pci_tbl,
> +	probe:		parport_serial_pci_probe,
> +	remove:		__devexit_p(parport_serial_pci_remove),
> +};
> +
> +
> +static int __init parport_serial_init (void)
> +{
> +	return pci_module_init (&parport_serial_pci_driver);
> +}
> +
> +static void __exit parport_serial_exit (void)
> +{
> +	pci_unregister_driver (&parport_serial_pci_driver);
> +	return;
> +}
> +
> +MODULE_AUTHOR("Tim Waugh <twaugh@redhat.com>");
> +MODULE_DESCRIPTION("Driver for common parallel+serial multi-I/O PCI cards");
> +MODULE_LICENSE("GPL");
> +
> +module_init(parport_serial_init);
> +module_exit(parport_serial_exit);
> diff -urN orig/linux-2.4.20-pre9/drivers/parport/ChangeLog linux-2.4.20-pre9/drivers/parport/ChangeLog
> --- orig/linux-2.4.20-pre9/drivers/parport/ChangeLog	Sat Aug  3 02:39:44 2002
> +++ linux-2.4.20-pre9/drivers/parport/ChangeLog	Sat Oct  5 17:58:35 2002
> @@ -1,3 +1,8 @@
> +2002-09-21  Marek Michalkiewicz  <marekm@amelek.gda.pl>
> +
> +	* parport_serial.c: Move from here to ../char/, must be initialised
> +	after serial.c for register_serial to work.
> +
>  2002-04-25  Tim Waugh  <twaugh@redhat.com>
> 
>  	* parport_serial.c, parport_pc.c: Move some SIIG cards around.
> diff -urN orig/linux-2.4.20-pre9/drivers/parport/Makefile linux-2.4.20-pre9/drivers/parport/Makefile
> --- orig/linux-2.4.20-pre9/drivers/parport/Makefile	Fri Sep 14 01:04:43 2001
> +++ linux-2.4.20-pre9/drivers/parport/Makefile	Sat Oct  5 17:58:35 2002
> @@ -22,7 +22,6 @@
> 
>  obj-$(CONFIG_PARPORT)		+= parport.o
>  obj-$(CONFIG_PARPORT_PC)	+= parport_pc.o
> -obj-$(CONFIG_PARPORT_SERIAL)	+= parport_serial.o
>  obj-$(CONFIG_PARPORT_PC_PCMCIA)+= parport_cs.o
>  obj-$(CONFIG_PARPORT_AMIGA)	+= parport_amiga.o
>  obj-$(CONFIG_PARPORT_MFC3)	+= parport_mfc3.o
> diff -urN orig/linux-2.4.20-pre9/drivers/parport/parport_serial.c linux-2.4.20-pre9/drivers/parport/parport_serial.c
> --- orig/linux-2.4.20-pre9/drivers/parport/parport_serial.c	Sat Aug  3 02:39:44 2002
> +++ linux-2.4.20-pre9/drivers/parport/parport_serial.c	Thu Jan  1 01:00:00 1970
> @@ -1,426 +0,0 @@
> -/*
> - * Support for common PCI multi-I/O cards (which is most of them)
> - *
> - * Copyright (C) 2001  Tim Waugh <twaugh@redhat.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
> - *
> - *
> - * Multi-function PCI cards are supposed to present separate logical
> - * devices on the bus.  A common thing to do seems to be to just use
> - * one logical device with lots of base address registers for both
> - * parallel ports and serial ports.  This driver is for dealing with
> - * that.
> - *
> - */
> -
> -#include <linux/types.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/pci.h>
> -#include <linux/parport.h>
> -#include <linux/parport_pc.h>
> -#include <linux/serial.h>
> -#include <linux/serialP.h>
> -#include <linux/list.h>
> -
> -#include <asm/serial.h>
> -
> -enum parport_pc_pci_cards {
> -	titan_110l = 0,
> -	titan_210l,
> -	avlab_1s1p,
> -	avlab_1s1p_650,
> -	avlab_1s1p_850,
> -	avlab_1s2p,
> -	avlab_1s2p_650,
> -	avlab_1s2p_850,
> -	avlab_2s1p,
> -	avlab_2s1p_650,
> -	avlab_2s1p_850,
> -	siig_1s1p_10x,
> -	siig_2s1p_10x,
> -	siig_2p1s_20x,
> -	siig_1s1p_20x,
> -	siig_2s1p_20x,
> -};
> -
> -
> -/* each element directly indexed from enum list, above */
> -static struct parport_pc_pci {
> -	int numports;
> -	struct { /* BAR (base address registers) numbers in the config
> -                    space header */
> -		int lo;
> -		int hi; /* -1 if not there, >6 for offset-method (max
> -                           BAR is 6) */
> -	} addr[4];
> -
> -	/* If set, this is called immediately after pci_enable_device.
> -	 * If it returns non-zero, no probing will take place and the
> -	 * ports will not be used. */
> -	int (*preinit_hook) (struct pci_dev *pdev, int autoirq, int autodma);
> -
> -	/* If set, this is called after probing for ports.  If 'failed'
> -	 * is non-zero we couldn't use any of the ports. */
> -	void (*postinit_hook) (struct pci_dev *pdev, int failed);
> -} cards[] __devinitdata = {
> -	/* titan_110l */		{ 1, { { 3, -1 }, } },
> -	/* titan_210l */		{ 1, { { 3, -1 }, } },
> -	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
> -	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
> -	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
> -	/* avlab_1s2p     */		{ 2, { { 1, 2}, { 3, 4 },} },
> -	/* avlab_1s2p_650 */		{ 2, { { 1, 2}, { 3, 4 },} },
> -	/* avlab_1s2p_850 */		{ 2, { { 1, 2}, { 3, 4 },} },
> -	/* avlab_2s1p     */		{ 1, { { 2, 3}, } },
> -	/* avlab_2s1p_650 */		{ 1, { { 2, 3}, } },
> -	/* avlab_2s1p_850 */		{ 1, { { 2, 3}, } },
> -	/* siig_1s1p_10x */		{ 1, { { 3, 4 }, } },
> -	/* siig_2s1p_10x */		{ 1, { { 4, 5 }, } },
> -	/* siig_2p1s_20x */		{ 2, { { 1, 2 }, { 3, 4 }, } },
> -	/* siig_1s1p_20x */		{ 1, { { 1, 2 }, } },
> -	/* siig_2s1p_20x */		{ 1, { { 2, 3 }, } },
> -};
> -
> -static struct pci_device_id parport_serial_pci_tbl[] __devinitdata = {
> -	/* PCI cards */
> -	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_110L,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
> -	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
> -	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
> -	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
> -	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
> -	{ 0x14db, 0x2112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_850},
> -	{ 0x14db, 0x2140, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s2p},
> -	{ 0x14db, 0x2141, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s2p_650},
> -	{ 0x14db, 0x2142, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s2p_850},
> -	{ 0x14db, 0x2160, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p},
> -	{ 0x14db, 0x2161, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p_650},
> -	{ 0x14db, 0x2162, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p_850},
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_550,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_650,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_850,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_550,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_650,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_850,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_550,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_650,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_850,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_550,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_650,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_20x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_850,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_20x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_550,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_650,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
> -	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
> -
> -	{ 0, } /* terminate list */
> -};
> -MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
> -
> -struct pci_board_no_ids {
> -	int flags;
> -	int num_ports;
> -	int base_baud;
> -	int uart_offset;
> -	int reg_shift;
> -	int (*init_fn)(struct pci_dev *dev, struct pci_board_no_ids *board,
> -			int enable);
> -	int first_uart_offset;
> -};
> -
> -static int __devinit siig10x_init_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
> -{
> -	return pci_siig10x_fn(dev, NULL, enable);
> -}
> -
> -static int __devinit siig20x_init_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
> -{
> -	return pci_siig20x_fn(dev, NULL, enable);
> -}
> -
> -static struct pci_board_no_ids pci_boards[] __devinitdata = {
> -	/*
> -	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
> -	 * Offset to get to next UART's registers,
> -	 * Register shift to use for memory-mapped I/O,
> -	 * Initialization function, first UART offset
> -	 */
> -
> -// Cards not tested are marked n/t
> -// If you have one of these cards and it works for you, please tell me..
> -
> -/* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
> -/* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
> -/* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> -/* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> -/* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> -/* avlab_1s2p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> -/* avlab_1s2p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> -/* avlab_1s2p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> -/* avlab_2s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
> -/* avlab_2s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
> -/* avlab_2s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
> -/* siig_1s1p_10x */	{ SPCI_FL_BASE2, 1, 460800, 0, 0, siig10x_init_fn },
> -/* siig_2s1p_10x */	{ SPCI_FL_BASE2, 1, 921600, 0, 0, siig10x_init_fn },
> -/* siig_2p1s_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
> -/* siig_1s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
> -/* siig_2s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
> -};
> -
> -struct parport_serial_private {
> -	int num_ser;
> -	int line[20];
> -	struct pci_board_no_ids ser;
> -	int num_par;
> -	struct parport *port[PARPORT_MAX];
> -};
> -
> -static int __devinit get_pci_port (struct pci_dev *dev,
> -				   struct pci_board_no_ids *board,
> -				   struct serial_struct *req,
> -				   int idx)
> -{
> -	unsigned long port;
> -	int base_idx;
> -	int max_port;
> -	int offset;
> -
> -	base_idx = SPCI_FL_GET_BASE(board->flags);
> -	if (board->flags & SPCI_FL_BASE_TABLE)
> -		base_idx += idx;
> -
> -	if (board->flags & SPCI_FL_REGION_SZ_CAP) {
> -		max_port = pci_resource_len(dev, base_idx) / 8;
> -		if (idx >= max_port)
> -			return 1;
> -	}
> -
> -	offset = board->first_uart_offset;
> -
> -	/* Timedia/SUNIX uses a mixture of BARs and offsets */
> -	/* Ugh, this is ugly as all hell --- TYT */
> -	if(dev->vendor == PCI_VENDOR_ID_TIMEDIA )  /* 0x1409 */
> -		switch(idx) {
> -			case 0: base_idx=0;
> -				break;
> -			case 1: base_idx=0; offset=8;
> -				break;
> -			case 2: base_idx=1;
> -				break;
> -			case 3: base_idx=1; offset=8;
> -				break;
> -			case 4: /* BAR 2*/
> -			case 5: /* BAR 3 */
> -			case 6: /* BAR 4*/
> -			case 7: base_idx=idx-2; /* BAR 5*/
> -		}
> -
> -	port =  pci_resource_start(dev, base_idx) + offset;
> -
> -	if ((board->flags & SPCI_FL_BASE_TABLE) == 0)
> -		port += idx * (board->uart_offset ? board->uart_offset : 8);
> -
> -	if (pci_resource_flags (dev, base_idx) & IORESOURCE_IO) {
> -		int high_bits_offset = ((sizeof(long)-sizeof(int))*8);
> -		req->port = port;
> -		if (high_bits_offset)
> -			req->port_high = port >> high_bits_offset;
> -		else
> -			req->port_high = 0;
> -		return 0;
> -	}
> -	req->io_type = SERIAL_IO_MEM;
> -	req->iomem_base = ioremap(port, board->uart_offset);
> -	req->iomem_reg_shift = board->reg_shift;
> -	req->port = 0;
> -	return req->iomem_base ? 0 : 1;
> -}
> -
> -/* Register the serial port(s) of a PCI card. */
> -static int __devinit serial_register (struct pci_dev *dev,
> -				      const struct pci_device_id *id)
> -{
> -	struct pci_board_no_ids *board = &pci_boards[id->driver_data];
> -	struct parport_serial_private *priv = pci_get_drvdata (dev);
> -	struct serial_struct serial_req;
> -	int base_baud;
> -	int k;
> -	int success = 0;
> -
> -	priv->ser = *board;
> -	if (board->init_fn && ((board->init_fn) (dev, board, 1) != 0))
> -		return 1;
> -
> -	base_baud = board->base_baud;
> -	if (!base_baud)
> -		base_baud = BASE_BAUD;
> -	memset (&serial_req, 0, sizeof (serial_req));
> -
> -	for (k = 0; k < board->num_ports; k++) {
> -		int line;
> -		serial_req.irq = dev->irq;
> -		if (get_pci_port (dev, board, &serial_req, k))
> -			break;
> -		serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
> -		serial_req.baud_base = base_baud;
> -		line = register_serial (&serial_req);
> -		if (line < 0) {
> -			printk (KERN_DEBUG
> -				"parport_serial: register_serial failed\n");
> -			continue;
> -		}
> -		priv->line[priv->num_ser++] = line;
> -		success = 1;
> -	}
> -
> -	return success ? 0 : 1;
> -}
> -
> -/* Register the parallel port(s) of a PCI card. */
> -static int __devinit parport_register (struct pci_dev *dev,
> -				       const struct pci_device_id *id)
> -{
> -	struct parport_serial_private *priv = pci_get_drvdata (dev);
> -	int i = id->driver_data, n;
> -	int success = 0;
> -
> -	if (cards[i].preinit_hook &&
> -	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
> -		return -ENODEV;
> -
> -	for (n = 0; n < cards[i].numports; n++) {
> -		struct parport *port;
> -		int lo = cards[i].addr[n].lo;
> -		int hi = cards[i].addr[n].hi;
> -		unsigned long io_lo, io_hi;
> -		io_lo = pci_resource_start (dev, lo);
> -		io_hi = 0;
> -		if ((hi >= 0) && (hi <= 6))
> -			io_hi = pci_resource_start (dev, hi);
> -		else if (hi > 6)
> -			io_lo += hi; /* Reinterpret the meaning of
> -                                        "hi" as an offset (see SYBA
> -                                        def.) */
> -		/* TODO: test if sharing interrupts works */
> -		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
> -			"I/O at %#lx(%#lx)\n",
> -			parport_serial_pci_tbl[i].vendor,
> -			parport_serial_pci_tbl[i].device, io_lo, io_hi);
> -		port = parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
> -					      PARPORT_DMA_NONE, dev);
> -		if (port) {
> -			priv->port[priv->num_par++] = port;
> -			success = 1;
> -		}
> -	}
> -
> -	if (cards[i].postinit_hook)
> -		cards[i].postinit_hook (dev, !success);
> -
> -	return success ? 0 : 1;
> -}
> -
> -static int __devinit parport_serial_pci_probe (struct pci_dev *dev,
> -					       const struct pci_device_id *id)
> -{
> -	struct parport_serial_private *priv;
> -	int err;
> -
> -	priv = kmalloc (sizeof *priv, GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -	priv->num_ser = priv->num_par = 0;
> -	pci_set_drvdata (dev, priv);
> -
> -	err = pci_enable_device (dev);
> -	if (err) {
> -		pci_set_drvdata (dev, NULL);
> -		kfree (priv);
> -		return err;
> -	}
> -
> -	if (parport_register (dev, id)) {
> -		pci_set_drvdata (dev, NULL);
> -		kfree (priv);
> -		return -ENODEV;
> -	}
> -
> -	if (serial_register (dev, id)) {
> -		int i;
> -		for (i = 0; i < priv->num_par; i++)
> -			parport_pc_unregister_port (priv->port[i]);
> -		pci_set_drvdata (dev, NULL);
> -		kfree (priv);
> -		return -ENODEV;
> -	}
> -
> -	return 0;
> -}
> -
> -static void __devexit parport_serial_pci_remove (struct pci_dev *dev)
> -{
> -	struct parport_serial_private *priv = pci_get_drvdata (dev);
> -	int i;
> -
> -	// Serial ports
> -	for (i = 0; i < priv->num_ser; i++) {
> -		unregister_serial (priv->line[i]);
> -
> -		if (priv->ser.init_fn)
> -			(priv->ser.init_fn) (dev, &priv->ser, 0);
> -	}
> -	pci_set_drvdata (dev, NULL);
> -
> -	// Parallel ports
> -	for (i = 0; i < priv->num_par; i++)
> -		parport_pc_unregister_port (priv->port[i]);
> -
> -	kfree (priv);
> -	return;
> -}
> -
> -static struct pci_driver parport_serial_pci_driver = {
> -	name:		"parport_serial",
> -	id_table:	parport_serial_pci_tbl,
> -	probe:		parport_serial_pci_probe,
> -	remove:		__devexit_p(parport_serial_pci_remove),
> -};
> -
> -
> -static int __init parport_serial_init (void)
> -{
> -	return pci_module_init (&parport_serial_pci_driver);
> -}
> -
> -static void __exit parport_serial_exit (void)
> -{
> -	pci_unregister_driver (&parport_serial_pci_driver);
> -	return;
> -}
> -
> -MODULE_AUTHOR("Tim Waugh <twaugh@redhat.com>");
> -MODULE_DESCRIPTION("Driver for common parallel+serial multi-I/O PCI cards");
> -MODULE_LICENSE("GPL");
> -
> -module_init(parport_serial_init);
> -module_exit(parport_serial_exit);
> 
> 
> 01_netmos.patch :
> 
> diff -urN linux-2.4.20-pre9-00_parport_serial/drivers/char/parport_serial.c linux-2.4.20-pre9/drivers/char/parport_serial.c
> --- linux-2.4.20-pre9-00_parport_serial/drivers/char/parport_serial.c	Sat Oct  5 17:58:35 2002
> +++ linux-2.4.20-pre9/drivers/char/parport_serial.c	Sat Oct  5 18:15:14 2002
> @@ -32,6 +32,8 @@
>  enum parport_pc_pci_cards {
>  	titan_110l = 0,
>  	titan_210l,
> +	netmos_9735,
> +	netmos_9835,
>  	avlab_1s1p,
>  	avlab_1s1p_650,
>  	avlab_1s1p_850,
> @@ -70,6 +72,8 @@
>  } cards[] __devinitdata = {
>  	/* titan_110l */		{ 1, { { 3, -1 }, } },
>  	/* titan_210l */		{ 1, { { 3, -1 }, } },
> +	/* netmos_9735 (not tested) */	{ 1, { { 2, -1 }, } },
> +	/* netmos_9835 */		{ 1, { { 2, -1 }, } },
>  	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
>  	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
>  	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
> @@ -92,6 +96,10 @@
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
>  	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
> +	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
> +	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
>  	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
>  	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
>  	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
> @@ -171,6 +179,8 @@
> 
>  /* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
>  /* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
> +/* netmos_9735 (n/t)*/	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
> +/* netmos_9835 */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
>  /* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
>  /* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
>  /* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
> diff -urN linux-2.4.20-pre9-00_parport_serial/drivers/parport/ChangeLog linux-2.4.20-pre9/drivers/parport/ChangeLog
> --- linux-2.4.20-pre9-00_parport_serial/drivers/parport/ChangeLog	Sat Oct  5 17:58:35 2002
> +++ linux-2.4.20-pre9/drivers/parport/ChangeLog	Sat Oct  5 18:23:05 2002
> @@ -3,6 +3,10 @@
>  	* parport_serial.c: Move from here to ../char/, must be initialised
>  	after serial.c for register_serial to work.
> 
> +	2001-10-11  Tim Waugh  <twaugh@redhat.com>
> +	* parport_pc.c, parport_serial.c: Support for NetMos cards.
> +	Patch originally from Michael Reinelt <reinelt@eunet.at>.
> +
>  2002-04-25  Tim Waugh  <twaugh@redhat.com>
> 
>  	* parport_serial.c, parport_pc.c: Move some SIIG cards around.
> diff -urN linux-2.4.20-pre9-00_parport_serial/drivers/parport/parport_pc.c linux-2.4.20-pre9/drivers/parport/parport_pc.c
> --- linux-2.4.20-pre9-00_parport_serial/drivers/parport/parport_pc.c	Sat Oct  5 17:43:32 2002
> +++ linux-2.4.20-pre9/drivers/parport/parport_pc.c	Sat Oct  5 18:12:20 2002
> @@ -2699,6 +2699,10 @@
>  	oxsemi_840,
>  	aks_0100,
>  	mobility_pp,
> +	netmos_9705,
> +	netmos_9805,
> +	netmos_9815,
> +	netmos_9855,
>  };
> 
> 
> @@ -2768,6 +2772,10 @@
>  	/* oxsemi_840 */		{ 1, { { 0, -1 }, } },
>  	/* aks_0100 */			{ 1, { { 0, 1 }, } },
>  	/* mobility_pp */		{ 1, { { 0, 1 }, } },
> +	/* netmos_9705 */               { 1, { { 0, -1 }, } }, /* untested */
> +	/* netmos_9805 */               { 1, { { 0, -1 }, } }, /* untested */
> +	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
> +	/* netmos_9855 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
>  };
> 
>  static struct pci_device_id parport_pc_pci_tbl[] __devinitdata = {
> @@ -2836,6 +2844,15 @@
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_840 },
>  	{ PCI_VENDOR_ID_AKS, PCI_DEVICE_ID_AKS_ALADDINCARD,
>  	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, aks_0100 },
> +	/* NetMos communication controllers */
> +	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9705,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9705 },
> +	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9805,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9805 },
> +	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9815,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9815 },
> +	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
>  	{ 0, } /* terminate list */
>  };
>  MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
> diff -urN linux-2.4.20-pre9-00_parport_serial/include/linux/pci_ids.h linux-2.4.20-pre9/include/linux/pci_ids.h
> --- linux-2.4.20-pre9-00_parport_serial/include/linux/pci_ids.h	Sat Oct  5 17:43:41 2002
> +++ linux-2.4.20-pre9/include/linux/pci_ids.h	Sat Oct  5 18:09:44 2002
> @@ -1791,8 +1791,12 @@
>  #define PCI_DEVICE_ID_HOLTEK_6565	0x6565
> 
>  #define PCI_VENDOR_ID_NETMOS		0x9710
> +#define PCI_DEVICE_ID_NETMOS_9705	0x9705
>  #define PCI_DEVICE_ID_NETMOS_9735	0x9735
> +#define PCI_DEVICE_ID_NETMOS_9805	0x9805
> +#define PCI_DEVICE_ID_NETMOS_9815	0x9815
>  #define PCI_DEVICE_ID_NETMOS_9835	0x9835
> +#define PCI_DEVICE_ID_NETMOS_9855	0x9855
> 
>  #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
>  #define PCI_SUBDEVICE_ID_EXSYS_4014	0x4014
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
