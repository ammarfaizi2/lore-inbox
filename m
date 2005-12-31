Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbVLaW12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVLaW12 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVLaW12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 17:27:28 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:44168 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965058AbVLaW12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 17:27:28 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 23:26:59 +0100
In-reply-to: <200512319343.965475189bla@anxur.fi.muni.cz>
Subject: [PATCH 1/4] media-video: Pci probing for stradis driver
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, laredo@gnu.org,
       mchehab@brturbo.com.br, video4linux-list@redhat.com,
       Greg KH <greg@kroah.com>
Message-Id: <20051231222657.7422F22AEE7@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pci probing for stradis driver

Pci probing functions added, some functions were rewrited.
Use PCI_DEVICE macro.
dev_* used for printing when pci_dev available.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 820bd12326966a092c066d4e91bd9d94029c207c
tree 0fc43d38166de3c1b0adac8becac1350e1c09bfa
parent bfa07669d3c622d43a425742d46d95ee80cb02a9
author <ku@bellona.(none)> Sat, 31 Dec 2005 21:35:57 +0100
committer <ku@bellona.(none)> Sat, 31 Dec 2005 21:35:57 +0100

 drivers/media/video/saa7146.h |    1 
 drivers/media/video/stradis.c |  201 +++++++++++++++++++++++------------------
 2 files changed, 115 insertions(+), 87 deletions(-)

diff --git a/drivers/media/video/saa7146.h b/drivers/media/video/saa7146.h
--- a/drivers/media/video/saa7146.h
+++ b/drivers/media/video/saa7146.h
@@ -73,7 +73,6 @@ struct saa7146
         unsigned int nr;
 	unsigned long irq;          /* IRQ used by SAA7146 card */
 	unsigned short id;
-	struct pci_dev *dev;
 	unsigned char revision;
 	unsigned char boardcfg[64];	/* 64 bytes of config from eeprom */
 	unsigned long saa7146_adr;   /* bus address of IO mem from PCI BIOS */
diff --git a/drivers/media/video/stradis.c b/drivers/media/video/stradis.c
--- a/drivers/media/video/stradis.c
+++ b/drivers/media/video/stradis.c
@@ -1991,12 +1991,10 @@ static struct video_device saa_template 
 	.minor		= -1,
 };
 
-static int configure_saa7146(struct pci_dev *dev, int num)
+static int __devinit configure_saa7146(struct pci_dev *pdev, int num)
 {
 	int result;
-	struct saa7146 *saa;
-
-	saa = &saa7146s[num];
+	struct saa7146 *saa = &saa7146s[num];
 	
 	saa->endmarkhead = saa->endmarktail = 0;
 	saa->win.x = saa->win.y = 0;
@@ -2013,7 +2011,6 @@ static int configure_saa7146(struct pci_
 	saa->picture.contrast = 38768;
 	saa->picture.colour = 32768;
 	saa->cap = 0;
-	saa->dev = dev;
 	saa->nr = num;
 	saa->playmode = VID_PLAY_NORMAL;
 	memset(saa->boardcfg, 0, 64);	/* clear board config area */
@@ -2033,14 +2030,14 @@ static int configure_saa7146(struct pci_
 	init_waitqueue_head(&saa->vidq);
 	spin_lock_init(&saa->lock);
 
-	if (pci_enable_device(dev))
+	if (pci_enable_device(pdev))
 		return -EIO;
 	
-	saa->id = dev->device;
-	saa->irq = dev->irq;
+	saa->id = pdev->device;
+	saa->irq = pdev->irq;
 	saa->video_dev.minor = -1;
-	saa->saa7146_adr = pci_resource_start(dev, 0);
-	pci_read_config_byte(dev, PCI_CLASS_REVISION, &saa->revision);
+	saa->saa7146_adr = pci_resource_start(pdev, 0);
+	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &saa->revision);
 
 	saa->saa7146_mem = ioremap(saa->saa7146_adr, 0x200);
 	if (!saa->saa7146_mem)
@@ -2051,16 +2048,15 @@ static int configure_saa7146(struct pci_
 	result = request_irq(saa->irq, saa7146_irq,
 		       SA_SHIRQ | SA_INTERRUPT, "stradis", (void *) saa);
 	if (result == -EINVAL)
-		printk(KERN_ERR "stradis%d: Bad irq number or handler\n",
-		       num);
+		dev_err(&pdev->dev, "%d: Bad irq number or handler\n", num);
 	if (result == -EBUSY)
-		printk(KERN_ERR "stradis%d: IRQ %ld busy, change your PnP"
-		       " config in BIOS\n", num, saa->irq);
+		dev_err(&pdev->dev, "%d: IRQ %ld busy, change your PnP config "
+			"in BIOS\n", num, saa->irq);
 	if (result < 0) {
 		iounmap(saa->saa7146_mem);
 		return result;
 	}
-	pci_set_master(dev);
+	pci_set_master(pdev);
 	if (video_register_device(&saa->video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
 		iounmap(saa->saa7146_mem);
 		return -1;
@@ -2068,10 +2064,11 @@ static int configure_saa7146(struct pci_
 	return 0;
 }
 
-static int init_saa7146(int i)
+static int __devinit init_saa7146(int i, struct device *dev)
 {
 	struct saa7146 *saa = &saa7146s[i];
 
+	memset(saa, 0, sizeof(*saa));
 	saa->user = 0;
 	/* reset the saa7146 */
 	saawrite(0xffff0000, SAA7146_MC1);
@@ -2104,7 +2101,7 @@ static int init_saa7146(int i)
 
 	/* allocate 32k dma buffer + 4k for page table */
 	if ((saa->dmadebi = kmalloc(32768 + 4096, GFP_KERNEL)) == NULL) {
-		printk(KERN_ERR "stradis%d: debi kmalloc failed\n", i);
+		dev_err(dev, "%d: debi kmalloc failed\n", i);
 		return -1;
 	}
 #if 0
@@ -2117,19 +2114,19 @@ static int init_saa7146(int i)
 	saa->audtail = saa->vidtail = saa->osdtail = 0;
 	if (saa->vidbuf == NULL)
 		if ((saa->vidbuf = vmalloc(524288)) == NULL) {
-			printk(KERN_ERR "stradis%d: malloc failed\n", saa->nr);
+			dev_err(dev, "%d: malloc failed\n", saa->nr);
 			return -ENOMEM;
 		}
 	if (saa->audbuf == NULL)
 		if ((saa->audbuf = vmalloc(65536)) == NULL) {
-			printk(KERN_ERR "stradis%d: malloc failed\n", saa->nr);
+			dev_err(dev, "%d: malloc failed\n", saa->nr);
 			vfree(saa->vidbuf);
 			saa->vidbuf = NULL;
 			return -ENOMEM;
 		}
 	if (saa->osdbuf == NULL)
 		if ((saa->osdbuf = vmalloc(131072)) == NULL) {
-			printk(KERN_ERR "stradis%d: malloc failed\n", saa->nr);
+			dev_err(dev, "%d: malloc failed\n", saa->nr);
 			vfree(saa->vidbuf);
 			vfree(saa->audbuf);
 			saa->vidbuf = saa->audbuf = NULL;
@@ -2137,7 +2134,7 @@ static int init_saa7146(int i)
 		}
 	/* allocate 81920 byte buffer for clipping */
 	if ((saa->dmavid2 = kmalloc(VIDEO_CLIPMAP_SIZE, GFP_KERNEL)) == NULL) {
-		printk(KERN_ERR "stradis%d: clip kmalloc failed\n", saa->nr);
+		dev_err(dev, "%d: clip kmalloc failed\n", saa->nr);
 		vfree(saa->vidbuf);
 		vfree(saa->audbuf);
 		vfree(saa->osdbuf);
@@ -2159,89 +2156,121 @@ static int init_saa7146(int i)
 	return 0;
 }
 
-static void release_saa(void)
+static void stradis_release_saa(struct pci_dev *pdev)
 {
 	u8 command;
-	int i;
-	struct saa7146 *saa;
+	int i = (int)pci_get_drvdata(pdev);
+	struct saa7146 *saa = &saa7146s[i];
 
-	for (i = 0; i < saa_num; i++) {
-		saa = &saa7146s[i];
+	/* turn off all capturing, DMA and IRQs */
+	saawrite(0xffff0000, SAA7146_MC1);	/* reset chip */
+	saawrite(0, SAA7146_MC2);
+	saawrite(0, SAA7146_IER);
+	saawrite(0xffffffffUL, SAA7146_ISR);
+
+	/* disable PCI bus-mastering */
+	pci_read_config_byte(pdev, PCI_COMMAND, &command);
+	command &= ~PCI_COMMAND_MASTER;
+	pci_write_config_byte(pdev, PCI_COMMAND, command);
+
+	/* unmap and free memory */
+	saa->audhead = saa->audtail = saa->osdhead = 0;
+	saa->vidhead = saa->vidtail = saa->osdtail = 0;
+	vfree(saa->vidbuf);
+	vfree(saa->audbuf);
+	vfree(saa->osdbuf);
+	kfree(saa->dmavid2);
+	saa->audbuf = saa->vidbuf = saa->osdbuf = NULL;
+	saa->dmavid2 = NULL;
+	kfree(saa->dmadebi);
+	kfree(saa->dmavid1);
+	kfree(saa->dmavid3);
+	kfree(saa->dmaa1in);
+	kfree(saa->dmaa1out);
+	kfree(saa->dmaa2in);
+	kfree(saa->dmaa2out);
+	kfree(saa->dmaRPS1);
+	kfree(saa->dmaRPS2);
+	free_irq(saa->irq, saa);
+	if (saa->saa7146_mem)
+		iounmap(saa->saa7146_mem);
+	if (saa->video_dev.minor != -1)
+		video_unregister_device(&saa->video_dev);
+}
 
-		/* turn off all capturing, DMA and IRQs */
-		saawrite(0xffff0000, SAA7146_MC1);	/* reset chip */
-		saawrite(0, SAA7146_MC2);
-		saawrite(0, SAA7146_IER);
-		saawrite(0xffffffffUL, SAA7146_ISR);
-
-		/* disable PCI bus-mastering */
-		pci_read_config_byte(saa->dev, PCI_COMMAND, &command);
-		command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_byte(saa->dev, PCI_COMMAND, command);
-
-		/* unmap and free memory */
-		saa->audhead = saa->audtail = saa->osdhead = 0;
-		saa->vidhead = saa->vidtail = saa->osdtail = 0;
-		vfree(saa->vidbuf);
-		vfree(saa->audbuf);
-		vfree(saa->osdbuf);
-		kfree(saa->dmavid2);
-		saa->audbuf = saa->vidbuf = saa->osdbuf = NULL;
-		saa->dmavid2 = NULL;
-		kfree(saa->dmadebi);
-		kfree(saa->dmavid1);
-		kfree(saa->dmavid3);
-		kfree(saa->dmaa1in);
-		kfree(saa->dmaa1out);
-		kfree(saa->dmaa2in);
-		kfree(saa->dmaa2out);
-		kfree(saa->dmaRPS1);
-		kfree(saa->dmaRPS2);
-		free_irq(saa->irq, saa);
-		if (saa->saa7146_mem)
-			iounmap(saa->saa7146_mem);
-		if (saa->video_dev.minor != -1)
-			video_unregister_device(&saa->video_dev);
+static int __devinit stradis_probe(struct pci_dev *pdev,
+	const struct pci_device_id *ent)
+{
+	int retval = -EINVAL;
+
+	if (saa_num >= SAA7146_MAX)
+		goto err;
+
+	if (!pdev->subsystem_vendor)
+		dev_info(&pdev->dev, "%d: rev1 decoder\n", saa_num);
+	else
+		dev_info(&pdev->dev, "%d: SDM2xx found\n", saa_num); 
+
+	pci_set_drvdata(pdev, (void *)saa_num);
+
+	retval = configure_saa7146(pdev, saa_num);
+	if (retval) {
+		dev_err(&pdev->dev, "%d: error in configuring\n", saa_num);
+		goto err;
+	}
+
+	if (init_saa7146(saa_num, &pdev->dev) < 0) {
+		dev_err(&pdev->dev, "%d: error in initialization\n", saa_num);
+		retval = -EIO;
+		goto errrel;
 	}
+
+	saa_num++;
+
+	return 0;
+errrel:
+	stradis_release_saa(pdev);
+err:
+	return retval;
+}
+
+static void __devexit stradis_remove(struct pci_dev *pdev)
+{
+	stradis_release_saa(pdev);
 }
 
+static struct pci_device_id stradis_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_PHILIPS_SAA7146) },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, stradis_pci_tbl);
+
+static struct pci_driver stradis_driver = {
+	.name		= "stradis",
+	.id_table	= stradis_pci_tbl,
+	.probe		= stradis_probe,
+	.remove		= __devexit_p(stradis_remove)
+};
 
-static int __init stradis_init (void)
+int __init stradis_init(void)
 {
-	struct pci_dev *dev = NULL;
-	int result = 0, i;
+	int retval;
 
 	saa_num = 0;
+	
+	retval = pci_register_driver(&stradis_driver);
+	if (retval)
+		printk(KERN_ERR "stradis: Unable to register pci driver.\n");
 
-	while ((dev = pci_find_device(PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_PHILIPS_SAA7146, dev))) {
-		if (!dev->subsystem_vendor)
-			printk(KERN_INFO "stradis%d: rev1 decoder\n", saa_num);
-		else
-			printk(KERN_INFO "stradis%d: SDM2xx found\n", saa_num); 
-		result = configure_saa7146(dev, saa_num++);
-		if (result)
-			return result;
-	}
-	if (saa_num)
-		printk(KERN_INFO "stradis: %d card(s) found.\n", saa_num);
-	else
-		return -EINVAL;
-	for (i = 0; i < saa_num; i++)
-		if (init_saa7146(i) < 0) {
-			release_saa();
-			return -EIO;
-		}
-	return 0;
+	return retval;
 }
 
 
-static void __exit stradis_exit (void)
+void __exit stradis_exit(void)
 {
-	release_saa();
+	pci_unregister_driver(&stradis_driver);
 	printk(KERN_INFO "stradis: module cleanup complete\n");
 }
 
-
 module_init(stradis_init);
 module_exit(stradis_exit);
-
