Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292533AbSBTWBv>; Wed, 20 Feb 2002 17:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292535AbSBTWBk>; Wed, 20 Feb 2002 17:01:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292533AbSBTWBX>;
	Wed, 20 Feb 2002 17:01:23 -0500
Message-ID: <3C741C70.2FB0EA6B@zip.com.au>
Date: Wed, 20 Feb 2002 14:00:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] .text.exit linkage errors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A forward-port of all the .text.exit fixes which went into
2.4.   Also contains a couple of s/MINOR/minor/ changes.

.text.exit fixes in:

drivers/char/mwave/mwavedd.c
drivers/media/video/zr36120.c
sound/oss/cs4232.c
sound/oss/mpu401.c
drivers/mtd/maps/elan-104nc.c
drivers/mtd/maps/sbc_gxx.c
drivers/isdn/avmb1/capi.c
drivers/atm/firestream.c
drivers/char/synclink.c
drivers/net/tokenring/abyss.c
drivers/net/tokenring/tmspci.c
drivers/net/hamachi.c
drivers/net/rcpci45.c
sound/oss/i810_audio.c
sound/oss/trident.c
sound/oss/via82cxxx_audio.c
drivers/media/video/bttv-driver.c
drivers/net/wireless/orinoco_plx.c
drivers/video/radeonfb.c
drivers/char/wdt_pci.c

MINOR->minor fixes in:

sound/oss/rme96xx.c
sound/oss/sonicvibes.c


--- 2.5.5/drivers/char/mwave/mwavedd.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/char/mwave/mwavedd.c	Wed Feb 20 13:53:30 2002
@@ -461,7 +461,7 @@ static struct miscdevice mwave_misc_dev 
 * mwave_exit is called on module unload
 * mwave_exit is also used to clean up after an aborted mwave_init
 */
-static void __exit mwave_exit(void)
+static void mwave_exit(void)
 {
 	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
 
--- 2.5.5/drivers/media/video/zr36120.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/media/video/zr36120.c	Wed Feb 20 13:53:30 2002
@@ -2024,7 +2024,7 @@ int __init init_zoran(int card)
 }
 
 static
-void __exit release_zoran(int max)
+void release_zoran(int max)
 {
 	struct zoran *ztv;
 	int i;
--- 2.5.5/sound/oss/cs4232.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/sound/oss/cs4232.c	Wed Feb 20 13:53:30 2002
@@ -277,7 +277,7 @@ void __init attach_cs4232(struct address
 	}
 }
 
-void __exit unload_cs4232(struct address_info *hw_config)
+static void __exit unload_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base, irq = hw_config->irq;
 	int dma1 = hw_config->dma, dma2 = hw_config->dma2;
@@ -460,10 +460,12 @@ static int __init init_cs4232(void)
 	return 0;
 }
 
-int cs4232_isapnp_remove(struct pci_dev *dev, const struct isapnp_device_id *id)
+static int __exit cs4232_isapnp_remove(struct pci_dev *dev,
+			const struct isapnp_device_id *id)
 {
 	struct address_info *cfg = (struct address_info*)pci_get_drvdata(dev);
-	if (cfg) unload_cs4232(cfg);
+	if (cfg)
+		unload_cs4232(cfg);
 	pci_set_drvdata(dev,NULL);
 	dev->deactivate(dev);
 	return 0;
--- 2.5.5/sound/oss/mpu401.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/sound/oss/mpu401.c	Wed Feb 20 13:53:30 2002
@@ -1227,7 +1227,7 @@ int probe_mpu401(struct address_info *hw
 	return ok;
 }
 
-void __exit unload_mpu401(struct address_info *hw_config)
+void unload_mpu401(struct address_info *hw_config)
 {
 	void *p;
 	int n=hw_config->slots[1];
--- 2.5.5/drivers/mtd/maps/elan-104nc.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/mtd/maps/elan-104nc.c	Wed Feb 20 13:53:30 2002
@@ -213,7 +213,7 @@ static struct map_info elan_104nc_map = 
 /* MTD device for all of the flash. */
 static struct mtd_info *all_mtd;
 
-static void __exit cleanup_elan_104nc(void)
+static void cleanup_elan_104nc(void)
 {
 	if( all_mtd ) {
 		del_mtd_partitions( all_mtd );
--- 2.5.5/drivers/mtd/maps/sbc_gxx.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/mtd/maps/sbc_gxx.c	Wed Feb 20 13:53:30 2002
@@ -221,7 +221,7 @@ static struct map_info sbc_gxx_map = {
 /* MTD device for all of the flash. */
 static struct mtd_info *all_mtd;
 
-static void __exit cleanup_sbc_gxx(void)
+static void cleanup_sbc_gxx(void)
 {
 	if( all_mtd ) {
 		del_mtd_partitions( all_mtd );
--- 2.5.5/drivers/isdn/avmb1/capi.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/isdn/avmb1/capi.c	Wed Feb 20 13:53:30 2002
@@ -1535,7 +1535,7 @@ static void __exit proc_exit(void)
 /* -------- init function and module interface ---------------------- */
 
 
-static void __exit alloc_exit(void)
+static void alloc_exit(void)
 {
 	if (capidev_cachep) {
 		(void)kmem_cache_destroy(capidev_cachep);
--- 2.5.5/drivers/atm/firestream.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/atm/firestream.c	Wed Feb 20 13:53:30 2002
@@ -1530,7 +1530,7 @@ static void top_off_fp (struct fs_dev *d
 	fs_dprintk (FS_DEBUG_QUEUE, "Added %d entries. \n", n);
 }
 
-static void __exit free_queue (struct fs_dev *dev, struct queue *txq)
+static void __devexit free_queue (struct fs_dev *dev, struct queue *txq)
 {
 	func_enter ();
 
@@ -1546,7 +1546,7 @@ static void __exit free_queue (struct fs
 	func_exit ();
 }
 
-static void __exit free_freepool (struct fs_dev *dev, struct freepool *fp)
+static void __devexit free_freepool (struct fs_dev *dev, struct freepool *fp)
 {
 	func_enter ();
 
@@ -2088,7 +2088,7 @@ int __init init_PCI (void)
 #endif 
 */
 
-const static struct pci_device_id firestream_pci_tbl[] __devinitdata = {
+static struct pci_device_id firestream_pci_tbl[] __devinitdata = {
 	{ PCI_VENDOR_ID_FUJITSU_ME, PCI_DEVICE_ID_FUJITSU_FS50, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, FS_IS50},
 	{ PCI_VENDOR_ID_FUJITSU_ME, PCI_DEVICE_ID_FUJITSU_FS155, 
--- 2.5.5/drivers/char/synclink.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/char/synclink.c	Wed Feb 20 13:53:30 2002
@@ -941,7 +941,7 @@ static struct pci_driver synclink_pci_dr
 	name:		"synclink",
 	id_table:	synclink_pci_tbl,
 	probe:		synclink_init_one,
-	remove:		synclink_remove_one,
+	remove:		__devexit_p(synclink_remove_one),
 };
 
 static struct tty_driver serial_driver, callout_driver;
@@ -8220,7 +8220,7 @@ static int __init synclink_init_one (str
 	return 0;
 }
 
-static void __exit synclink_remove_one (struct pci_dev *dev)
+static void __devexit synclink_remove_one (struct pci_dev *dev)
 {
 }
 
--- 2.5.5/drivers/net/tokenring/abyss.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/net/tokenring/abyss.c	Wed Feb 20 13:53:30 2002
@@ -433,7 +433,7 @@ static int abyss_close(struct net_device
 	return 0;
 }
 
-static void __exit abyss_detach (struct pci_dev *pdev)
+static void __devexit abyss_detach (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	
@@ -451,7 +451,7 @@ static struct pci_driver abyss_driver = 
 	name:		"abyss",
 	id_table:	abyss_pci_tbl,
 	probe:		abyss_attach,
-	remove:		abyss_detach,
+	remove:		__devexit_p(abyss_detach),
 };
 
 static int __init abyss_init (void)
--- 2.5.5/drivers/net/tokenring/tmspci.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/net/tokenring/tmspci.c	Wed Feb 20 13:53:30 2002
@@ -220,7 +220,7 @@ static unsigned short tms_pci_setnselout
 	return val;
 }
 
-static void __exit tms_pci_detach (struct pci_dev *pdev)
+static void __devexit tms_pci_detach (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -238,7 +238,7 @@ static struct pci_driver tms_pci_driver 
 	name:		"tmspci",
 	id_table:	tmspci_pci_tbl,
 	probe:		tms_pci_attach,
-	remove:		tms_pci_detach,
+	remove:		__devexit_p(tms_pci_detach),
 };
 
 static int __init tms_pci_init (void)
--- 2.5.5/drivers/net/hamachi.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/net/hamachi.c	Wed Feb 20 13:53:30 2002
@@ -1978,7 +1978,7 @@ static int netdev_ioctl(struct net_devic
 }
 
 
-static void __exit hamachi_remove_one (struct pci_dev *pdev)
+static void __devexit hamachi_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -2008,7 +2008,7 @@ static struct pci_driver hamachi_driver 
 	name:		DRV_NAME,
 	id_table:	hamachi_pci_tbl,
 	probe:		hamachi_init_one,
-	remove:		hamachi_remove_one,
+	remove:		__devexit_p(hamachi_remove_one),
 };
 
 static int __init hamachi_init (void)
--- 2.5.5/drivers/net/rcpci45.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/net/rcpci45.c	Wed Feb 20 13:53:30 2002
@@ -115,7 +115,7 @@ static struct pci_device_id rcpci45_pci_
 MODULE_DEVICE_TABLE (pci, rcpci45_pci_table);
 MODULE_LICENSE("GPL");
 
-static void __exit
+static void __devexit
 rcpci45_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
@@ -267,7 +267,7 @@ static struct pci_driver rcpci45_driver 
 	name:		"rcpci45",
 	id_table:	rcpci45_pci_table,
 	probe:		rcpci45_init_one,
-	remove:		rcpci45_remove_one,
+	remove:		__devexit_p(rcpci45_remove_one),
 };
 
 static int __init
--- 2.5.5/sound/oss/i810_audio.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/sound/oss/i810_audio.c	Wed Feb 20 13:54:41 2002
@@ -2958,7 +2958,7 @@ static int __init i810_probe(struct pci_
 	return -ENODEV;
 }
 
-static void __exit i810_remove(struct pci_dev *pci_dev)
+static void __devexit i810_remove(struct pci_dev *pci_dev)
 {
 	int i;
 	struct i810_card *card = pci_get_drvdata(pci_dev);
@@ -3118,7 +3118,7 @@ static struct pci_driver i810_pci_driver
 	name:		I810_MODULE_NAME,
 	id_table:	i810_pci_tbl,
 	probe:		i810_probe,
-	remove:		i810_remove,
+	remove:		__devexit_p(i810_remove),
 #ifdef CONFIG_PM
 	suspend:	i810_pm_suspend,
 	resume:		i810_pm_resume,
--- 2.5.5/sound/oss/trident.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/sound/oss/trident.c	Wed Feb 20 13:53:34 2002
@@ -4149,7 +4149,7 @@ out_release_region:
 	goto out;
 }
 
-static void __exit trident_remove(struct pci_dev *pci_dev)
+static void __devexit trident_remove(struct pci_dev *pci_dev)
 {
 	int i;
 	struct trident_card *card = pci_get_drvdata(pci_dev);
@@ -4202,7 +4202,7 @@ static struct pci_driver trident_pci_dri
 	name:		TRIDENT_MODULE_NAME,
 	id_table:	trident_pci_tbl,
 	probe:		trident_probe,
-	remove:		trident_remove,
+	remove:		__devexit_p(trident_remove),
 	suspend:	trident_suspend,
 	resume:		trident_resume
 };
--- 2.5.5/sound/oss/via82cxxx_audio.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/sound/oss/via82cxxx_audio.c	Wed Feb 20 13:53:34 2002
@@ -311,7 +311,7 @@ static unsigned via_num_cards = 0;
  */
 
 static int via_init_one (struct pci_dev *dev, const struct pci_device_id *id);
-static void via_remove_one (struct pci_dev *pdev);
+static void __devexit via_remove_one (struct pci_dev *pdev);
 
 static ssize_t via_dsp_read(struct file *file, char *buffer, size_t count, loff_t *ppos);
 static ssize_t via_dsp_write(struct file *file, const char *buffer, size_t count, loff_t *ppos);
@@ -365,7 +365,7 @@ static struct pci_driver via_driver = {
 	name:		VIA_MODULE_NAME,
 	id_table:	via_pci_tbl,
 	probe:		via_init_one,
-	remove:		via_remove_one,
+	remove:		__devexit_p(via_remove_one),
 };
 
 
@@ -3271,7 +3271,7 @@ err_out:
 }
 
 
-static void __exit via_remove_one (struct pci_dev *pdev)
+static void __devexit via_remove_one (struct pci_dev *pdev)
 {
 	struct via_info *card;
 
--- 2.5.5/drivers/media/video/bttv-driver.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/media/video/bttv-driver.c	Wed Feb 20 13:53:35 2002
@@ -2794,7 +2794,7 @@ static void bttv_irq(int irq, void *dev_
  *	Scan for a Bt848 card, request the irq and map the io memory 
  */
 
-static void __devexit bttv_remove(struct pci_dev *pci_dev)
+static void bttv_remove(struct pci_dev *pci_dev)
 {
         u8 command;
         int j;
--- 2.5.5/drivers/net/wireless/orinoco_plx.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/net/wireless/orinoco_plx.c	Wed Feb 20 13:53:35 2002
@@ -279,7 +279,7 @@ static struct pci_driver orinoco_plx_dri
 	name:"orinoco_plx",
 	id_table:orinoco_plx_pci_id_table,
 	probe:orinoco_plx_init_one,
-	remove:orinoco_plx_remove_one,
+	remove:__devexit_p(orinoco_plx_remove_one),
 	suspend:0,
 	resume:0
 };
--- 2.5.5/drivers/video/radeonfb.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/video/radeonfb.c	Wed Feb 20 13:53:35 2002
@@ -619,7 +619,7 @@ static struct pci_driver radeonfb_driver
 	name:		"radeonfb",
 	id_table:	radeonfb_pci_table,
 	probe:		radeonfb_pci_register,
-	remove:		radeonfb_pci_unregister,
+	remove:		__devexit_p(radeonfb_pci_unregister),
 };
 
 
--- 2.5.5/drivers/char/wdt_pci.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/drivers/char/wdt_pci.c	Wed Feb 20 13:53:35 2002
@@ -558,7 +558,7 @@ out_reg:
 }
 
 
-static void __exit wdtpci_remove_one (struct pci_dev *pdev)
+static void __devexit wdtpci_remove_one (struct pci_dev *pdev)
 {
 	/* here we assume only one device will ever have
 	 * been picked up and registered by probe function */
@@ -583,7 +583,7 @@ static struct pci_driver wdtpci_driver =
 	name:		"wdt-pci",
 	id_table:	wdtpci_pci_tbl,
 	probe:		wdtpci_init_one,
-	remove:		wdtpci_remove_one,
+	remove:		__devexit_p(wdtpci_remove_one),
 };
 
 
--- 2.5.5/sound/oss/rme96xx.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/sound/oss/rme96xx.c	Wed Feb 20 13:53:35 2002
@@ -1162,7 +1162,7 @@ static int rme96xx_ioctl(struct inode *i
 
 static int rme96xx_open(struct inode *in, struct file *f)
 {
-	int minor = MINOR(in->i_rdev);
+	int minor = minor(in->i_rdev);
 	struct list_head *list;
 	int devnum = ((minor-3)/16) % devices; /* default = 0 */
 	rme96xx_info *s;
@@ -1490,7 +1490,7 @@ static struct file_operations rme96xx_au
 
 static int rme96xx_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct list_head *list;
 	rme96xx_info *s;
 
--- 2.5.5/sound/oss/sonicvibes.c~discard	Wed Feb 20 13:53:30 2002
+++ 2.5.5-akpm/sound/oss/sonicvibes.c	Wed Feb 20 13:53:35 2002
@@ -1235,7 +1235,7 @@ static int mixer_ioctl(struct sv_state *
 
 static int sv_open_mixdev(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct list_head *list;
 	struct sv_state *s;
 
@@ -1893,7 +1893,7 @@ static int sv_ioctl(struct inode *inode,
 
 static int sv_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned char fmtm = ~0, fmts = 0;
 	struct list_head *list;
@@ -2142,7 +2142,7 @@ static unsigned int sv_midi_poll(struct 
 
 static int sv_midi_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	struct list_head *list;
@@ -2364,7 +2364,7 @@ static int sv_dmfm_ioctl(struct inode *i
 
 static int sv_dmfm_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	struct list_head *list;
 	struct sv_state *s;


-
