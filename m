Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbRBGXOI>; Wed, 7 Feb 2001 18:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129698AbRBGXN7>; Wed, 7 Feb 2001 18:13:59 -0500
Received: from [194.73.73.138] ([194.73.73.138]:47251 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129135AbRBGXNu>;
	Wed, 7 Feb 2001 18:13:50 -0500
Date: Wed, 7 Feb 2001 23:13:34 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remaining net/ pci_enable_device cleanups.
Message-ID: <Pine.LNX.4.31.0102072310240.29253-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff, l-k,

 Here's my current diff resynced against ac5. This catches
all the remaining cases in drivers/net except for starfire
(which you posted a bigger patch for).

Oh, there's also a kmalloc change in macsonic.c that I've
had hanging around for a while.

If this looks ok, I'll split it into chunks for Alan & the
appropriate maintainers.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs


diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/defxx.c linux-dj/drivers/net/defxx.c
--- linux/drivers/net/defxx.c	Wed Feb  7 21:55:56 2001
+++ linux-dj/drivers/net/defxx.c	Wed Feb  7 22:34:27 2001
@@ -393,6 +393,7 @@
  *
  * Arguments:
  *   pdev - pointer to pci device information (NULL for EISA)
+ *   ioaddr - pointer to port (NULL for PCI)
  *
  * Functional Description:
  *
@@ -426,6 +427,13 @@
 	 */
 	dev = init_fddidev( NULL, sizeof(*bp));

+	/* Enable PCI device. */
+	if (pdev != NULL) {
+		if (pci_enable_device (pdev))
+			goto err_out;
+		ioaddr = pci_resource_start (pdev, 1);
+	}
+
 	if (!dev) {
 		printk (KERN_ERR "defxx: unable to allocate fddidev, aborting\n");
 		return -ENOMEM;
@@ -461,8 +469,6 @@
 		bp->bus_type = DFX_BUS_TYPE_PCI;
 		bp->pci_dev = pdev;
 		pdev->driver_data = dev;
-		if (pci_enable_device (pdev))
-			goto err_out_region;
 		pci_set_master (pdev);
 	}

@@ -481,7 +487,7 @@

 static int __devinit dfx_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	return  dfx_init_one_pci_or_eisa(pdev, pci_resource_start (pdev, 1));
+	return  dfx_init_one_pci_or_eisa(pdev, NULL);
 }

 static int __init dfx_eisa_init(void)
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/dgrs.c linux-dj/drivers/net/dgrs.c
--- linux/drivers/net/dgrs.c	Wed Feb  7 21:55:56 2001
+++ linux-dj/drivers/net/dgrs.c	Wed Feb  7 22:17:37 2001
@@ -1368,6 +1368,17 @@

 		while ((pdev = pci_find_device(SE6_PCI_VENDOR_ID, SE6_PCI_DEVICE_ID, pdev)) != NULL)
 		{
+			/*
+			 * Get and check the bus-master and latency values.
+			 * Some PCI BIOSes fail to set the master-enable bit,
+			 * and the latency timer must be set to the maximum
+			 * value to avoid data corruption that occurs when the
+			 * timer expires during a transfer.  Yes, it's a bug.
+			 */
+			if (pci_enable_device(pdev))
+				continue;
+			pci_set_master(pdev);
+
 			plxreg = pci_resource_start (pdev, 0);
 			io = pci_resource_start (pdev, 1);
 			mem = pci_resource_start (pdev, 2);
@@ -1391,17 +1402,6 @@
 			pci_write_config_dword(pdev, 0x30, plxdma + 1);
 			pci_read_config_dword(pdev, 0x30, &plxdma);
 			plxdma &= ~15;
-
-			/*
-			 * Get and check the bus-master and latency values.
-			 * Some PCI BIOSes fail to set the master-enable bit,
-			 * and the latency timer must be set to the maximum
-			 * value to avoid data corruption that occurs when the
-			 * timer expires during a transfer.  Yes, it's a bug.
-			 */
-			if (pci_enable_device(pdev))
-				continue;
-			pci_set_master(pdev);

 			dgrs_found_device(io, mem, irq, plxreg, plxdma);

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/dmfe.c linux-dj/drivers/net/dmfe.c
--- linux/drivers/net/dmfe.c	Wed Feb  7 21:55:56 2001
+++ linux-dj/drivers/net/dmfe.c	Wed Feb  7 22:18:18 2001
@@ -356,6 +356,11 @@

 	DMFE_DBUG(0, "dmfe_probe()", 0);

+	/* Enable Master/IO access, Disable memory access */
+	if (pci_enable_device(pdev))
+		goto err_out;
+	pci_set_master(pdev);
+
 	pci_iobase = pci_resource_start(pdev, 0);
 	pci_irqline = pdev->irq;

@@ -371,11 +376,6 @@
 		printk(KERN_ERR "dmfe: I/O base is zero\n");
 		goto err_out;
 	}
-
-	/* Enable Master/IO access, Disable memory access */
-	if (pci_enable_device(pdev))
-		goto err_out;
-	pci_set_master(pdev);

 #if 0	/* pci_{enable_device,set_master} sets minimum latency for us now */

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/eepro100.c linux-dj/drivers/net/eepro100.c
--- linux/drivers/net/eepro100.c	Wed Feb  7 21:55:56 2001
+++ linux-dj/drivers/net/eepro100.c	Wed Feb  7 22:00:35 2001
@@ -557,6 +557,17 @@
 	if (speedo_debug > 0  &&  did_version++ == 0)
 		printk(version);

+	/* save power state b4 pci_enable_device overwrites it */
+	pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
+	if (pm) {
+		u16 pwr_command;
+		pci_read_config_word(pdev, pm + PCI_PM_CTRL, &pwr_command);
+		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
+	}
+
+	if (pci_enable_device(pdev))
+		goto err_out_none;
+
 	if (!request_region(pci_resource_start(pdev, 1),
 			pci_resource_len(pdev, 1), "eepro100")) {
 		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
@@ -586,17 +597,6 @@
 		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx, IRQ %d.\n",
 			   pci_resource_start(pdev, 0), irq);
 #endif
-
-	/* save power state b4 pci_enable_device overwrites it */
-	pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
-	if (pm) {
-		u16 pwr_command;
-		pci_read_config_word(pdev, pm + PCI_PM_CTRL, &pwr_command);
-		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
-	}
-
-	if (pci_enable_device(pdev))
-		goto err_out_free_mmio_region;

 	pci_set_master(pdev);

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/epic100.c linux-dj/drivers/net/epic100.c
--- linux/drivers/net/epic100.c	Wed Feb  7 21:55:56 2001
+++ linux-dj/drivers/net/epic100.c	Wed Feb  7 22:15:22 2001
@@ -341,7 +341,7 @@
 	static int printed_version;
 	long ioaddr;
 	int chip_idx = (int) ent->driver_data;
-	const int irq = pdev->irq;
+	int irq;
 	struct net_device *dev;
 	struct epic_private *ep;
 	int i, option = 0, duplex = 0;
@@ -354,10 +354,11 @@
 		printk (KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
 			version, version2, version3);

-	i = pci_enable_device(pdev);
-	if (i)
+	if (pci_enable_device(pdev))
 		return i;
-
+
+	irq = pdev->irq;
+
 	if ((pci_resource_len(pdev, 0) < pci_id_tbl[chip_idx].io_size) ||
 	    (pci_resource_len(pdev, 1) < pci_id_tbl[chip_idx].io_size)) {
 		printk (KERN_ERR "card %d: no PCI region space\n", card_idx);
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/macsonic.c linux-dj/drivers/net/macsonic.c
--- linux/drivers/net/macsonic.c	Wed Feb  7 21:55:56 2001
+++ linux-dj/drivers/net/macsonic.c	Wed Feb  7 22:00:35 2001
@@ -135,7 +135,7 @@
 		unsigned long desc_base, desc_top;
 		if ((lp->sonic_desc =
 		     kmalloc(SIZEOF_SONIC_DESC
-			     * SONIC_BUS_SCALE(lp->dma_bitmode), GFP_DMA)) == NULL) {
+			     * SONIC_BUS_SCALE(lp->dma_bitmode), GFP_KERNEL | GFP_DMA)) == NULL) {
 			printk(KERN_ERR "%s: couldn't allocate descriptor buffers\n", dev->name);
 		}
 		desc_base = (unsigned long) lp->sonic_desc;
@@ -165,7 +165,7 @@

 	/* FIXME, maybe we should use skbs */
 	if ((lp->rba = (char *)
-	     kmalloc(SONIC_NUM_RRS * SONIC_RBSIZE, GFP_DMA)) == NULL) {
+	     kmalloc(SONIC_NUM_RRS * SONIC_RBSIZE, GFP_KERNEL | GFP_DMA)) == NULL) {
 		printk(KERN_ERR "%s: couldn't allocate receive buffers\n", dev->name);
 		kfree(lp->sonic_desc);
 		lp->sonic_desc = NULL;
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/natsemi.c linux-dj/drivers/net/natsemi.c
--- linux/drivers/net/natsemi.c	Wed Feb  7 21:55:56 2001
+++ linux-dj/drivers/net/natsemi.c	Wed Feb  7 22:03:05 2001
@@ -368,7 +368,7 @@
 {
 	struct net_device *dev;
 	struct netdev_private *np;
-	int i, option, irq = pdev->irq, chip_idx = ent->driver_data;
+	int i, option, irq, chip_idx = ent->driver_data;
 	static int find_cnt = -1;
 	static int printed_version;
 	unsigned long ioaddr, iosize;
@@ -380,11 +380,14 @@

 	find_cnt++;
 	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
+
+	if (pci_enable_device(pdev))
+		return -EIO;
+
+	irq = pdev->irq;
 	ioaddr = pci_resource_start(pdev, pcibar);
 	iosize = pci_resource_len(pdev, pcibar);

-	if (pci_enable_device(pdev))
-		return -EIO;
 	if (natsemi_pci_info[chip_idx].flags & PCI_USES_MASTER)
 		pci_set_master(pdev);

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/pcnet32.c linux-dj/drivers/net/pcnet32.c
--- linux/drivers/net/pcnet32.c	Wed Feb  7 21:55:57 2001
+++ linux-dj/drivers/net/pcnet32.c	Wed Feb  7 22:00:35 2001
@@ -482,7 +482,12 @@

     printk(KERN_INFO "pcnet32_probe_pci: found device %#08x.%#08x\n", ent->vendor, ent->device);

-    ioaddr = pci_resource_start (pdev, 0);
+	if ((err = pci_enable_device(pdev)) < 0) {
+	printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
+	return err;
+	}
+
+	ioaddr = pci_resource_start (pdev, 0);
     printk(KERN_INFO "    ioaddr=%#08lx  resource_flags=%#08lx\n", ioaddr, pci_resource_flags (pdev, 0));
     if (!ioaddr) {
         printk (KERN_ERR "no PCI IO resources, aborting\n");
@@ -494,11 +499,6 @@
 	return -ENODEV;
     }

-    if ((err = pci_enable_device(pdev)) < 0) {
-	printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
-	return err;
-    }
-
     pci_set_master(pdev);

     return pcnet32_probe1(ioaddr, pdev->irq, 1, card_idx, pdev);
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/rcpci45.c linux-dj/drivers/net/rcpci45.c
--- linux/drivers/net/rcpci45.c	Wed Feb  7 21:55:57 2001
+++ linux-dj/drivers/net/rcpci45.c	Wed Feb  7 22:13:56 2001
@@ -159,9 +159,8 @@
     int error = -ENOMEM;
     static int card_idx = -1;
     struct net_device *dev;
-    unsigned long pci_start = pci_resource_start(pdev,0);
-    unsigned long pci_len = pci_resource_len(pdev,0);
-
+    unsigned long pci_start, pci_len;
+

     card_idx++;

@@ -180,6 +179,13 @@
 	goto err_out;
     }

+    if (pci_enable_device(pdev)) {
+        printk(KERN_ERR "(rcpci45 driver:) %d: unable to enable pci device, aborting\n",card_idx);
+	goto err_out;
+    }
+    pci_start = pci_resource_start(pdev,0);
+    pci_len = pci_resource_len(pdev,0);
+
     pdev->driver_data = dev;

     pDpa = dev->priv;
@@ -216,11 +222,6 @@
      */
     if (request_mem_region(pci_start, pci_len, dev->name) == NULL) {
         printk(KERN_ERR "(rcpci45 driver:) %d: resource 0x%lx @ 0x%lx busy, aborting\n",card_idx, pci_start, pci_len);
-	goto err_out_free_msgbuf;
-    }
-
-    if (pci_enable_device(pdev)) {
-        printk(KERN_ERR "(rcpci45 driver:) %d: unable to enable pci device, aborting\n",card_idx);
 	goto err_out_free_msgbuf;
     }

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/rtl8129.c linux-dj/drivers/net/rtl8129.c
--- linux/drivers/net/rtl8129.c	Wed Feb  7 21:55:57 2001
+++ linux-dj/drivers/net/rtl8129.c	Wed Feb  7 22:08:47 2001
@@ -350,11 +350,11 @@

 		pdev = pci_find_slot(pci_bus, pci_device_fn);

-		ioaddr = pci_resource_start(pdev, 0);
-		irq = pdev->irq;
-
 		if (pci_enable_device(pdev))
 			continue;
+
+		ioaddr = pci_resource_start(pdev, 0);
+		irq = pdev->irq;

 		if ((pci_tbl[chip_idx].flags & PCI_USES_IO) &&
 			check_region(ioaddr, pci_tbl[chip_idx].io_size))
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/sis900.c linux-dj/drivers/net/sis900.c
--- linux/drivers/net/sis900.c	Wed Feb  7 21:55:57 2001
+++ linux-dj/drivers/net/sis900.c	Wed Feb  7 22:08:04 2001
@@ -252,9 +252,9 @@
 static int __devinit sis900_probe (struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
 {
 	struct sis900_private *sis_priv;
-	long ioaddr = pci_resource_start(pci_dev, 0);
+	long ioaddr;
 	struct net_device *net_dev;
-	int irq = pci_dev->irq;
+	int irq;
 	int i, ret = 0;
 	u8 revision;
 	char *card_name = card_names[pci_id->driver_data];
@@ -269,6 +269,9 @@
 	if (pci_enable_device (pci_dev))
 		return -ENODEV;
 	pci_set_master(pci_dev);
+
+	irq = pci_dev->irq;
+	ioaddr = pci_resource_start(pci_dev, 0);

 	net_dev = init_etherdev(NULL, sizeof(struct sis900_private));
 	if (!net_dev)
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/sundance.c linux-dj/drivers/net/sundance.c
--- linux/drivers/net/sundance.c	Mon Dec 11 21:38:29 2000
+++ linux-dj/drivers/net/sundance.c	Wed Feb  7 22:03:56 2001
@@ -379,13 +379,15 @@
 	struct netdev_private *np;
 	static int card_idx;
 	int chip_idx = ent->driver_data;
-	int irq = pdev->irq;
+	int irq;
 	int i, option = card_idx < MAX_UNITS ? options[card_idx] : 0;
 	long ioaddr;

 	if (pci_enable_device(pdev))
 		return -EIO;
 	pci_set_master(pdev);
+
+	irq = pdev->irq;

 	dev = init_etherdev(NULL, sizeof(*np));
 	if (!dev)
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/winbond-840.c linux-dj/drivers/net/winbond-840.c
--- linux/drivers/net/winbond-840.c	Wed Feb  7 21:56:00 2001
+++ linux-dj/drivers/net/winbond-840.c	Wed Feb  7 22:05:21 2001
@@ -377,13 +377,15 @@
 	struct netdev_private *np;
 	static int find_cnt;
 	int chip_idx = ent->driver_data;
-	int irq = pdev->irq;
+	int irq;
 	int i, option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
 	long ioaddr;

 	if (pci_enable_device(pdev))
 		return -EIO;
 	pci_set_master(pdev);
+
+	irq = pdev->irq;

 	if(!pci_dma_supported(pdev,0xFFFFffff)) {
 		printk(KERN_WARNING "Winbond-840: Device %s disabled due to DMA limitations.\n",

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
