Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbRBLIRV>; Mon, 12 Feb 2001 03:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRBLIRL>; Mon, 12 Feb 2001 03:17:11 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:44804 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129289AbRBLIQz>;
	Mon, 12 Feb 2001 03:16:55 -0500
Date: Mon, 12 Feb 2001 09:16:12 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: James Brents <James@nistix.com>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WOL failure after shutdown
In-Reply-To: <3A874C51.5030207@nistix.com>
Message-ID: <Pine.LNX.4.30.0102120903460.9447-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001, James Brents wrote:

> Sorry, I wrote that in a hurry. Its a 3Com PCI 3c905C Tornado. I can
> successfully use wakeonlan if I power off the machine immeadiatly after
> turning it on. Using the shutdown command, which it will when I need it
> to power back up, it will not work.
> Im using a wakeonlan cable to my motherboard as well, not using wake
> through PCI bus.
> Kernel is 2.4.1
> I appologize for not providing all required the specs in the original
> message.

Try this patch.  It is against the zero-copy version of the driver, but
I'm sure you can apply it, at least manually, to any 2.4 version.

Andrew, when can we expect to have WOL working in 2.4?

/Tobias


--- linux-2.4.1-zc1.orig/drivers/net/3c59x.c	Tue Jan 30 22:16:01 2001
+++ linux-2.4.1-zc1/drivers/net/3c59x.c	Wed Jan 31 08:46:00 2001
@@ -754,6 +754,7 @@
 static void set_rx_mode(struct net_device *dev);
 static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void vortex_tx_timeout(struct net_device *dev);
+static void acpi_wake(struct pci_dev *pdev);
 static void acpi_set_WOL(struct net_device *dev);

 /* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
@@ -1426,6 +1427,8 @@
 	int i;
 	int retval;

+	acpi_wake(vp->pdev);
+
 	/* Use the now-standard shared IRQ implementation. */
 	if ((retval = request_irq(dev->irq, vp->full_bus_master_rx ?
 				&boomerang_interrupt : &vortex_interrupt, SA_SHIRQ, dev->name, dev))) {
@@ -2647,12 +2650,6 @@
 	struct vortex_private *vp = (struct vortex_private *)dev->priv;
 	long ioaddr = dev->base_addr;

-	/* AKPM: This kills the 905 */
-	if (vortex_debug > 1) {
-		printk(KERN_INFO PFX "Wake-on-LAN functions disabled\n");
-	}
-	return;
-
 	/* Power up on: 1==Downloaded Filter, 2==Magic Packets, 4==Link Status. */
 	EL3WINDOW(7);
 	outw(2, ioaddr + 0x0c);
@@ -2663,6 +2660,34 @@
 	pci_write_config_word(vp->pdev, 0xe0, 0x8103);
 }

+/* Change from D3 (sleep) to D0 (active).
+   Problem: The Cyclone forgets all PCI config info during the transition! */
+static void acpi_wake(struct pci_dev *pdev)
+{
+	u32 base0, base1, romaddr;
+	u16 pci_command, pwr_command;
+	u8  pci_latency, pci_cacheline, irq;
+
+	pci_read_config_word(pdev, 0xe0, &pwr_command);
+	if ((pwr_command & 3) == 0)
+		return;
+	pci_read_config_word( pdev, PCI_COMMAND, &pci_command);
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &base0);
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_1, &base1);
+	pci_read_config_dword(pdev, PCI_ROM_ADDRESS, &romaddr);
+	pci_read_config_byte( pdev, PCI_LATENCY_TIMER, &pci_latency);
+	pci_read_config_byte( pdev, PCI_CACHE_LINE_SIZE, &pci_cacheline);
+	pci_read_config_byte( pdev, PCI_INTERRUPT_LINE, &irq);
+
+	pci_write_config_word( pdev, 0xe0, 0x0000);
+	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, base0);
+	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_1, base1);
+	pci_write_config_dword(pdev, PCI_ROM_ADDRESS, romaddr);
+	pci_write_config_byte( pdev, PCI_INTERRUPT_LINE, irq);
+	pci_write_config_byte( pdev, PCI_LATENCY_TIMER, pci_latency);
+	pci_write_config_byte( pdev, PCI_CACHE_LINE_SIZE, pci_cacheline);
+	pci_write_config_word( pdev, PCI_COMMAND, pci_command | 5);
+}

 static void __devexit vortex_remove_one (struct pci_dev *pdev)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
