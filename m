Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSJ0IcB>; Sun, 27 Oct 2002 03:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJ0IcB>; Sun, 27 Oct 2002 03:32:01 -0500
Received: from h-66-166-207-249.SNVACAID.covad.net ([66.166.207.249]:21658
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262312AbSJ0Ib6>; Sun, 27 Oct 2002 03:31:58 -0500
Date: Sun, 27 Oct 2002 01:36:19 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org, axboe@suse.de,
       netwerk@valinux.com, jerdfelt@valinux.com, neilb@cse.unsw.edu.au,
       mikep@linuxtr.net, linux-tr@linux-tr.net, arjanv@redhat.com,
       henrique@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch(2.5.44 and 2.4.x): 6 files referenced pci_dev.driver_data instead of pci_{g,s}et_drv_data
Message-ID: <20021027013619.A5918@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Six driver in linux-2.5.44 directly reference
pci_dev.driver_data.  This patch makes them use pci_{get,set}_drv_data
instead.

	This patch is of more than just academic interest, as I intend
to submit a patch shortly for 2.5 that will eliminate
pci_dev.driver_data in favor of pci_dev.dev.driver_data.  By applying
these changes to both 2.5.44 and your 2.4 trees if you maintiain them,
it will be one less difference between 2.4 and 2.5 for you to think
about.

	I have verified that the updated drivers compile without any
warnings related to this change (one of IDE drivers has some other
warnings).  I have not otherwise tested these changes, but they should
compile to the same object code as before.

	I would appreciate it if you would apply these changes to your
respective drivers and forward the changes for your drivers to Linus.
If you would prefer that I send the changes to Linus or follow some
other course of action I can, but I think requires few of Linus's CPU
cycles when changes for a driver are emailed from that driver's
maintainer.  If I have failed to contact the appropriate maintainer,
please let me know.


Modified files				I think maintainers are...

drivers/block/umem.c			nettwerk@valinux.com
					jerdefelt@valinux.com
					neilb@cse.unsw.edu.au

drivers/ide/pci/hpt366.c		alan@lxorg.uk.uu.org.uk
drivers/ide/pci/siimage.c		andre@linux-ide.org
					axboe@suse.de

drivers/net/tokenring/3c359.c		mikep@linuxtr.net
					linux-tr@linux-tr.net

drivers/net/tulip/xircom_cb.c		arjanv@redhat.com

drivers/net/wan/pc300_drv.c		henrique@cyclades.com

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

--- linux-2.5.44/drivers/block/umem.c	2002-10-18 21:02:34.000000000 -0700
+++ linux/drivers/block/umem.c	2002-10-27 01:09:51.000000000 -0700
@@ -1039,11 +1039,11 @@
 	printk(KERN_INFO "MM%d: Window size %d bytes, IRQ %d\n", card->card_number,
 	       card->win_size, card->irq);
 
         spin_lock_init(&card->lock);
 
-	dev->driver_data = card;
+	pci_set_drvdata(dev, card);
 
 	if (pci_write_cmd != 0x0F) 	/* If not Memory Write & Invalidate */
 		pci_write_cmd = 0x07;	/* then Memory Write command */
 
 	if (pci_write_cmd & 0x08) { /* use Memory Write and Invalidate */
@@ -1098,11 +1098,11 @@
 --                              mm_pci_remove
 -----------------------------------------------------------------------------------
 */
 static void mm_pci_remove(struct pci_dev *dev)
 {
-	struct cardinfo *card = dev->driver_data;
+	struct cardinfo *card = pci_get_drvdata(dev);
 
 	tasklet_kill(&card->tasklet);
 	iounmap(card->csr_remap);
 	release_mem_region(card->csr_base, card->csr_len);
 #ifdef CONFIG_MM_MAP_MEMORY
--- linux-2.5.44/drivers/ide/pci/hpt366.c	2002-10-18 21:01:57.000000000 -0700
+++ linux/drivers/ide/pci/hpt366.c	2002-10-27 01:09:53.000000000 -0700
@@ -314,11 +314,11 @@
 	if (drive_fast & 0x80)
 		pci_write_config_byte(dev, regfast, drive_fast & ~0x80);
 #endif
 
 	reg2 = pci_bus_clock_list(speed,
-		(struct chipset_bus_clock_list_entry *) dev->driver_data);
+		(struct chipset_bus_clock_list_entry *) pci_get_drvdata(dev));
 	/*
 	 * Disable on-chip PIO FIFO/buffer
 	 *  (to avoid problems handling I/O errors later)
 	 */
 	pci_read_config_dword(dev, regtime, &reg1);
@@ -367,11 +367,11 @@
 	if (new_fast != drive_fast)
 		pci_write_config_byte(dev, regfast, new_fast);
 
 	list_conf = pci_bus_clock_list(speed, 
 				       (struct chipset_bus_clock_list_entry *)
-				       dev->driver_data);
+				       pci_get_drvdata(dev));
 
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
 	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
 	
 	if (speed < XFER_MW_DMA_0) {
@@ -399,11 +399,11 @@
 	drive_fast &= ~0x07;
 	pci_write_config_byte(dev, regfast, drive_fast);
 					
 	list_conf = pci_bus_clock_list(speed,
 			(struct chipset_bus_clock_list_entry *)
-					dev->driver_data);
+					pci_get_drvdata(dev));
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
 	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
 	if (speed < XFER_MW_DMA_0)
 		list_conf &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
 	pci_write_config_dword(dev, drive_pci, list_conf);
@@ -839,11 +839,11 @@
 	 * speed that we're running at. NOTE: the internal PLL will
 	 * result in slow reads when using a 33MHz PCI clock. we also
 	 * don't like to use the PLL because it will cause glitches
 	 * on PRST/SRST when the HPT state engine gets reset.
 	 */
-	if (dev->driver_data) 
+	if (pci_get_drvdata(dev)) 
 		goto init_hpt37X_done;
 	
 	/*
 	 * adjust PLL based upon PCI clock, enable it, and wait for
 	 * stabilization.
@@ -921,11 +921,11 @@
 		default:
 			pci_set_drvdata(dev, (void *) thirty_three_base_hpt366);
 			break;
 	}
 
-	if (!dev->driver_data)
+	if (!pci_get_drvdata(dev))
 	{
 		printk(KERN_ERR "hpt366: unknown bus timing.\n");
 		return -EOPNOTSUPP;
 	}
 	return 0;
--- linux-2.5.44/drivers/ide/pci/siimage.c	2002-10-18 21:01:48.000000000 -0700
+++ linux/drivers/ide/pci/siimage.c	2002-10-27 01:09:54.000000000 -0700
@@ -28,12 +28,12 @@
 static int n_siimage_devs;
 
 static char * print_siimage_get_info (char *buf, struct pci_dev *dev, int index)
 {
 	char *p		= buf;
-	u8 mmio		= (dev->driver_data != NULL) ? 1 : 0;
-	u32 bmdma	= (mmio) ? ((u32) dev->driver_data) :
+	u8 mmio		= (pci_get_drvdata(dev) != NULL) ? 1 : 0;
+	u32 bmdma	= (mmio) ? ((u32) pci_get_drvdata(dev)) :
 				    (pci_resource_start(dev, 4));
 
 	p += sprintf(p, "\nController: %d\n", index);
 	p += sprintf(p, "SiI%x Chipset.\n", dev->device);
 	if (mmio)
@@ -767,18 +767,18 @@
 
 	hwif->rqsize = 128;
 	if ((dev->device == PCI_DEVICE_ID_SII_3112) && (!(class_rev)))
 		hwif->rqsize = 16;
 
-	if (dev->driver_data == NULL)
+	if (pci_get_drvdata(dev) == NULL)
 		return;
 	init_mmio_iops_siimage(hwif);
 }
 
 static unsigned int __init ata66_siimage (ide_hwif_t *hwif)
 {
-	if (hwif->pci_dev->driver_data == NULL) {
+	if (pci_get_drvdata(hwif->pci_dev) == NULL) {
 		u8 ata66 = 0;
 		pci_read_config_byte(hwif->pci_dev, SELREG(0), &ata66);
 		return (ata66 & 0x01) ? 1 : 0;
 	}
 #ifndef CONFIG_TRY_MMIO_SIIMAGE
--- linux-2.5.44/drivers/net/tokenring/3c359.c	2002-10-18 21:02:34.000000000 -0700
+++ linux/drivers/net/tokenring/3c359.c	2002-10-27 01:09:55.000000000 -0700
@@ -1778,11 +1778,11 @@
 	return 0 ; 
 }
 
 static void __devexit xl_remove_one (struct pci_dev *pdev)
 {
-	struct net_device *dev = pdev->driver_data;
+	struct net_device *dev = pci_get_drvdata(pdev);
 	struct xl_private *xl_priv=(struct xl_private *)dev->priv;
 	
 	unregister_trdev(dev);
 	iounmap(xl_priv->xl_mmio) ; 
 	pci_release_regions(pdev) ; 
--- linux-2.5.44/drivers/net/tulip/xircom_cb.c	2002-10-18 21:02:28.000000000 -0700
+++ linux/drivers/net/tulip/xircom_cb.c	2002-10-27 01:09:56.000000000 -0700
@@ -297,11 +297,11 @@
 	dev->hard_start_xmit = &xircom_start_xmit;
 	dev->stop = &xircom_close;
 	dev->get_stats = &xircom_get_stats;
 	dev->priv = private;
 	dev->do_ioctl = &private_ioctl;
-	pdev->driver_data = dev;
+	pci_set_drvdata(pdev, dev);
 
 	
 	/* start the transmitter to get a heartbeat */
 	/* TODO: send 2 dummy packets here */
 	tranceiver_voodoo(private);
@@ -324,11 +324,11 @@
  Interrupts and such are already stopped in the "ifconfig ethX down"
  code.
  */
 static void __devexit xircom_remove(struct pci_dev *pdev)
 {
-	struct net_device *dev = pdev->driver_data;
+	struct net_device *dev = pci_get_drvdata(pdev);
 	struct xircom_private *card;
 	enter("xircom_remove");
 	if (dev!=NULL) {
 		card=dev->priv;
 		if (card!=NULL) {	
--- linux-2.5.44/drivers/net/wan/pc300_drv.c	2002-10-18 21:02:32.000000000 -0700
+++ linux/drivers/net/wan/pc300_drv.c	2002-10-27 01:09:57.000000000 -0700
@@ -3554,11 +3554,11 @@
 	       card->hw.rambase, card->hw.plxbase, card->hw.scabase,
 	       card->hw.falcbase);
 #endif
 
 	/* Set PCI drv pointer to the card structure */
-	pdev->driver_data = card;
+	pci_set_drvdata(pdev, card);
 
 	/* Set board type */
 	switch (device_id) {
 		case PCI_DEVICE_ID_PC300_TE_1:
 		case PCI_DEVICE_ID_PC300_TE_2:
@@ -3629,11 +3629,11 @@
 	return -ENODEV;
 }
 
 static void __devexit cpc_remove_one(struct pci_dev *pdev)
 {
-	pc300_t *card = (pc300_t *) pdev->driver_data;
+	pc300_t *card = pci_get_drvdata(pdev);
 
 	if (card->hw.rambase != 0) {
 		int i;
 
 		/* Disable interrupts on the PCI bridge */

--PEIAKu/WMn1b1Hv9--
