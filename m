Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVCXWMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVCXWMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVCXWMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:12:48 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:43408 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261166AbVCXWMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:12:42 -0500
Subject: Re: [PATCH] Netmos parallel/serial/combo support
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-parport@lists.infradead.org
In-Reply-To: <424325A7.2010101@tls.msk.ru>
References: <1111533253.22819.2.camel@eeyore>  <424325A7.2010101@tls.msk.ru>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 15:12:29 -0700
Message-Id: <1111702349.25455.15.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 23:40 +0300, Michael Tokarev wrote:
> So, do you expect 9[78]35 cards to work? ;)

Yes, I expect them all to work.  Thanks very much for testing yours!

> With this patch applied, my 9835 card now works when loading 8250_pci
> module.  But things does not completely work still.
> 
> I've a 9835 card with two serial and no parallel ports:
> 
> 0000:01:00.0 0700: 9710:9835 (rev 01) (prog-if 02)
>          Subsystem: 1000:0002
>          Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>          Interrupt: pin A routed to IRQ 193
>          Region 0: I/O ports at a400 [size=8]
>          Region 1: I/O ports at a000 [size=8]
>          Region 2: I/O ports at 9800 [size=8]
>          Region 3: I/O ports at 9400 [size=8]
>          Region 4: I/O ports at 9000 [size=8]
>          Region 5: I/O ports at 8800 [size=16]
> 
> When I first load 8250_pci, it correctly detects one onboard
> serial port (ttyS0) and two ports on the card (ttyS4 and ttyS5):
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 193
> ttyS4 at I/O 0xa400 (irq = 193) is a 16550A
> ttyS5 at I/O 0xa000 (irq = 193) is a 16550A
> 
> When I load parport_pc after loading 8250_pci, it correctly detects
> onboard parallel port and nothing more:
> 
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378, irq 7 [PCSPP]

Everything looks good so far.

> But after reloading parport_pc, it does not see the built-in
> port anymore; more, after unloading 8250_pci and 8250,
> parport_pc finds one parallel port -- on this netmos
> card only (there's no parallel port on this card):
> 
> PCI parallel port detected: 9710:9835, I/O at 0x9800(0x9400)
> parport0: PC-style at 0x9800 (0x9400) [PCSPP,TRISTATE]

Hmmm...  Do you have an init script or something that pokes
9835 into /sys/bus/pci/drivers/parport_pc/new_id?  If not,
I don't see how parport_pc could claim your 9835, since it's
not compiled into parport_pc_pci_tbl.  It looks like you
should be able to turn off the new_id functionality by
disabling CONFIG_HOTPLUG.

> When parport_pc loaded, 8250[_pci] can't detect the two
> serial ports it detected previously:

That's because there's only one PCI device, and parport_pc
already claimed it.

Can you add some printks to figure out how parport_pc claims
your board?  For example, the patch below might be a start:

--- 2.6.12-rc1-mm1-netmos/drivers/parport/parport_pc.c.orig	2005-03-24 13:27:02.000000000 -0700
+++ 2.6.12-rc1-mm1-netmos/drivers/parport/parport_pc.c	2005-03-24 13:31:40.000000000 -0700
@@ -2930,10 +2930,13 @@
 		return -ENODEV;
 	}
 
+	printk("parport_pc: dev %s i %d numports %d\n", pci_name(dev), i,
+		cards[i].numports);
 	for (n = 0; n < cards[i].numports; n++) {
 		int lo = cards[i].addr[n].lo;
 		int hi = cards[i].addr[n].hi;
 		unsigned long io_lo, io_hi;
+		printk("parport_pc:   port %d lo %d hi %d\n", n, lo, hi);
 		io_lo = pci_resource_start (dev, lo);
 		io_hi = 0;
 		if ((hi >= 0) && (hi <= 6))
--- 2.6.12-rc1-mm1-netmos/drivers/parport/parport_serial.c.orig	2005-03-24 13:39:29.000000000 -0700
+++ 2.6.12-rc1-mm1-netmos/drivers/parport/parport_serial.c	2005-03-24 13:45:23.000000000 -0700
@@ -358,6 +358,8 @@
 	    card->preinit_hook (dev, card, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
 		return -ENODEV;
 
+	printk("parport_serial: dev %s i %d numports %d\n", pci_name(dev), i,
+		card->numports);
 	for (n = 0; n < card->numports; n++) {
 		struct parport *port;
 		int lo = card->addr[n].lo;
@@ -372,6 +374,7 @@
 			break;
 		}
 
+		printk("parport_serial:   port %d lo %d hi %d\n", n, lo, hi);
 		io_lo = pci_resource_start (dev, lo);
 		io_hi = 0;
 		if ((hi >= 0) && (hi <= 6))



