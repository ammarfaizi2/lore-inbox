Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVLaXmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVLaXmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 18:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVLaXmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 18:42:35 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:36548 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751086AbVLaXme
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 18:42:34 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun,  1 Jan 2006 00:42:09 +0100
In-reply-to: <200512319343.965475189bla@anxur.fi.muni.cz>
Subject: [PATCH 2/4] media-video: Stradis video little cleanup
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, laredo@gnu.org,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Message-Id: <20051231234207.614A522AF08@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stradis video little cleanup
[dependent on stradis pci probing]

Unused function removed. Used container_of instead of for loop. Another
small changes

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 6d24424eab688faf0fe3f195f84df783764a6393
tree 1afb53874e275abbb666bce1bfbbbe469df6dc7f
parent 820bd12326966a092c066d4e91bd9d94029c207c
author <ku@bellona.(none)> Sat, 31 Dec 2005 22:37:07 +0100
committer <ku@bellona.(none)> Sat, 31 Dec 2005 22:37:07 +0100

 drivers/media/video/stradis.c |  170 ++++++++++++++++-------------------------
 1 files changed, 68 insertions(+), 102 deletions(-)

diff --git a/drivers/media/video/stradis.c b/drivers/media/video/stradis.c
--- a/drivers/media/video/stradis.c
+++ b/drivers/media/video/stradis.c
@@ -309,41 +309,6 @@ static u32 debiread(struct saa7146 *saa,
 	return result;
 }
 
-#if 0 /* unused */
-/* MUST be a multiple of 8 bytes and 8-byte aligned and < 32768 bytes */
-/* data copied into saa->dmadebi buffer, caller must re-enable interrupts */
-static void ibm_block_dram_read(struct saa7146 *saa, int address, int bytes)
-{
-	int i, j;
-	u32 *buf;
-	buf = (u32 *) saa->dmadebi;
-	if (bytes > 0x7000)
-		bytes = 0x7000;
-	saawrite(0, SAA7146_IER);	/* disable interrupts */
-	for (i=0; i < 10000 &&
-		(debiread(saa, debNormal, IBM_MP2_DRAM_CMD_STAT, 2)
-		& 0x8000); i++)
-		saaread(SAA7146_MC2);
-	if (i == 10000)
-		printk(KERN_ERR "stradis%d: dram_busy never cleared\n",
-			saa->nr);
-	debiwrite(saa, debNormal, IBM_MP2_SRC_ADDR, (address<<16) |
-		(address>>16), 4);
-	debiwrite(saa, debNormal, IBM_MP2_BLOCK_SIZE, bytes, 2);
-	debiwrite(saa, debNormal, IBM_MP2_CMD_STAT, 0x8a10, 2);
-	for (j = 0; j < bytes/4; j++) {
-		for (i = 0; i < 10000 &&
-			(!(debiread(saa, debNormal, IBM_MP2_DRAM_CMD_STAT, 2)
-			& 0x4000)); i++)
-			saaread(SAA7146_MC2);
-		if (i == 10000)
-			printk(KERN_ERR "stradis%d: dram_ready never set\n",
-				saa->nr);
-		buf[j] = debiread(saa, debNormal, IBM_MP2_DRAM_DATA, 4);
-	}
-}
-#endif /* unused */
-
 static void do_irq_send_data(struct saa7146 *saa)
 {
 	int split, audbytes, vidbytes;
@@ -1935,21 +1900,11 @@ static ssize_t saa_write(struct file *fi
 
 static int saa_open(struct inode *inode, struct file *file)
 {
-	struct saa7146 *saa = NULL;
-	unsigned int minor = iminor(inode);
-	int i;
+	struct video_device *vdev = video_devdata(file);
+	struct saa7146 *saa = container_of(vdev, struct saa7146, video_dev);
 
-	for (i = 0; i < SAA7146_MAX; i++) {
-		if (saa7146s[i].video_dev.minor == minor) {
-			saa = &saa7146s[i];
-		}
-	}
-	if (saa == NULL) {
-		return -ENODEV;
-	}
 	file->private_data = saa;
 
-	//saa->video_dev.busy = 0; /* old hack to support multiple open */
 	saa->user++;
 	if (saa->user > 1)
 		return 0;	/* device open already, don't reset */
@@ -1961,7 +1916,7 @@ static int saa_release(struct inode *ino
 {
 	struct saa7146 *saa = file->private_data;
 	saa->user--;
-	//saa->video_dev.busy = 0; /* old hack to support multiple open */
+
 	if (saa->user > 0)	/* still someone using device */
 		return 0;
 	saawrite(0x007f0000, SAA7146_MC1);	/* stop all overlay dma */
@@ -1993,8 +1948,8 @@ static struct video_device saa_template 
 
 static int __devinit configure_saa7146(struct pci_dev *pdev, int num)
 {
-	int result;
-	struct saa7146 *saa = &saa7146s[num];
+	int retval;
+	struct saa7146 *saa = pci_get_drvdata(pdev);
 	
 	saa->endmarkhead = saa->endmarktail = 0;
 	saa->win.x = saa->win.y = 0;
@@ -2030,8 +1985,11 @@ static int __devinit configure_saa7146(s
 	init_waitqueue_head(&saa->vidq);
 	spin_lock_init(&saa->lock);
 
-	if (pci_enable_device(pdev))
-		return -EIO;
+	retval = pci_enable_device(pdev);
+	if (retval) {
+		dev_err(&pdev->dev, "%d: pci_enable_device failed!\n", num);
+		goto err;
+	}
 	
 	saa->id = pdev->device;
 	saa->irq = pdev->irq;
@@ -2040,33 +1998,44 @@ static int __devinit configure_saa7146(s
 	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &saa->revision);
 
 	saa->saa7146_mem = ioremap(saa->saa7146_adr, 0x200);
-	if (!saa->saa7146_mem)
-		return -EIO;
+	if (saa->saa7146_mem == NULL) {
+		dev_err(&pdev->dev, "%d: ioremap failed!\n", num);
+		retval = -EIO;
+		goto err;
+	}
 
 	memcpy(&saa->video_dev, &saa_template, sizeof(saa_template));
 	saawrite(0, SAA7146_IER);	/* turn off all interrupts */
-	result = request_irq(saa->irq, saa7146_irq,
-		       SA_SHIRQ | SA_INTERRUPT, "stradis", (void *) saa);
-	if (result == -EINVAL)
+
+	retval = request_irq(saa->irq, saa7146_irq, SA_SHIRQ | SA_INTERRUPT,
+		"stradis", saa);
+	if (retval == -EINVAL)
 		dev_err(&pdev->dev, "%d: Bad irq number or handler\n", num);
-	if (result == -EBUSY)
+	else if (retval == -EBUSY)
 		dev_err(&pdev->dev, "%d: IRQ %ld busy, change your PnP config "
 			"in BIOS\n", num, saa->irq);
-	if (result < 0) {
-		iounmap(saa->saa7146_mem);
-		return result;
-	}
+	if (retval < 0)
+		goto errio;
+
 	pci_set_master(pdev);
-	if (video_register_device(&saa->video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
-		iounmap(saa->saa7146_mem);
-		return -1;
+	retval = video_register_device(&saa->video_dev, VFL_TYPE_GRABBER,
+		video_nr);
+       	if (retval < 0) {
+		dev_err(&pdev->dev, "%d: error in registering video device!\n",
+			num);
+		goto errio;
 	}
+
 	return 0;
+errio:
+	iounmap(saa->saa7146_mem);
+err:
+	return retval;
 }
 
-static int __devinit init_saa7146(int i, struct device *dev)
+static int __devinit init_saa7146(struct pci_dev *pdev)
 {
-	struct saa7146 *saa = &saa7146s[i];
+	struct saa7146 *saa = pci_get_drvdata(pdev);
 
 	memset(saa, 0, sizeof(*saa));
 	saa->user = 0;
@@ -2101,8 +2070,8 @@ static int __devinit init_saa7146(int i,
 
 	/* allocate 32k dma buffer + 4k for page table */
 	if ((saa->dmadebi = kmalloc(32768 + 4096, GFP_KERNEL)) == NULL) {
-		dev_err(dev, "%d: debi kmalloc failed\n", i);
-		return -1;
+		dev_err(&pdev->dev, "%d: debi kmalloc failed\n", saa->nr);
+		goto err;
 	}
 #if 0
 	saa->pagedebi = saa->dmadebi + 32768;	/* top 4k is for mmu */
@@ -2112,37 +2081,23 @@ static int __devinit init_saa7146(int i,
 #endif
 	saa->audhead = saa->vidhead = saa->osdhead = 0;
 	saa->audtail = saa->vidtail = saa->osdtail = 0;
-	if (saa->vidbuf == NULL)
-		if ((saa->vidbuf = vmalloc(524288)) == NULL) {
-			dev_err(dev, "%d: malloc failed\n", saa->nr);
-			return -ENOMEM;
-		}
-	if (saa->audbuf == NULL)
-		if ((saa->audbuf = vmalloc(65536)) == NULL) {
-			dev_err(dev, "%d: malloc failed\n", saa->nr);
-			vfree(saa->vidbuf);
-			saa->vidbuf = NULL;
-			return -ENOMEM;
-		}
-	if (saa->osdbuf == NULL)
-		if ((saa->osdbuf = vmalloc(131072)) == NULL) {
-			dev_err(dev, "%d: malloc failed\n", saa->nr);
-			vfree(saa->vidbuf);
-			vfree(saa->audbuf);
-			saa->vidbuf = saa->audbuf = NULL;
-			return -ENOMEM;
-		}
+	if (saa->vidbuf == NULL && (saa->vidbuf = vmalloc(524288)) == NULL) {
+		dev_err(&pdev->dev, "%d: malloc failed\n", saa->nr);
+		goto err;
+	}
+	if (saa->audbuf == NULL && (saa->audbuf = vmalloc(65536)) == NULL) {
+		dev_err(&pdev->dev, "%d: malloc failed\n", saa->nr);
+		goto errvid;
+	}
+	if (saa->osdbuf == NULL && (saa->osdbuf = vmalloc(131072)) == NULL) {
+		dev_err(&pdev->dev, "%d: malloc failed\n", saa->nr);
+		goto erraud;
+	}
 	/* allocate 81920 byte buffer for clipping */
-	if ((saa->dmavid2 = kmalloc(VIDEO_CLIPMAP_SIZE, GFP_KERNEL)) == NULL) {
-		dev_err(dev, "%d: clip kmalloc failed\n", saa->nr);
-		vfree(saa->vidbuf);
-		vfree(saa->audbuf);
-		vfree(saa->osdbuf);
-		saa->vidbuf = saa->audbuf = saa->osdbuf = NULL;
-		saa->dmavid2 = NULL;
-		return -1;
+	if ((saa->dmavid2 = kzalloc(VIDEO_CLIPMAP_SIZE, GFP_KERNEL)) == NULL) {
+		dev_err(&pdev->dev, "%d: clip kmalloc failed\n", saa->nr);
+		goto errosd;
 	}
-	memset(saa->dmavid2, 0x00, VIDEO_CLIPMAP_SIZE);	/* clip everything */
 	/* setup clipping registers */
 	saawrite(virt_to_bus(saa->dmavid2), SAA7146_BASE_EVEN2);
 	saawrite(virt_to_bus(saa->dmavid2) + 128, SAA7146_BASE_ODD2);
@@ -2153,14 +2108,25 @@ static int __devinit init_saa7146(int i,
 	saawrite(((SAA7146_MC2_UPLD_DMA2) << 16) | SAA7146_MC2_UPLD_DMA2,
 		 SAA7146_MC2);
 	I2CBusScan(saa);
+
 	return 0;
+errosd:
+	vfree(saa->osdbuf);
+	saa->osdbuf = NULL;
+erraud:
+	vfree(saa->audbuf);
+	saa->audbuf = NULL;
+errvid:
+	vfree(saa->vidbuf);
+	saa->vidbuf = NULL;
+err:
+	return -ENOMEM;
 }
 
 static void stradis_release_saa(struct pci_dev *pdev)
 {
 	u8 command;
-	int i = (int)pci_get_drvdata(pdev);
-	struct saa7146 *saa = &saa7146s[i];
+	struct saa7146 *saa = pci_get_drvdata(pdev);
 
 	/* turn off all capturing, DMA and IRQs */
 	saawrite(0xffff0000, SAA7146_MC1);	/* reset chip */
@@ -2211,7 +2177,7 @@ static int __devinit stradis_probe(struc
 	else
 		dev_info(&pdev->dev, "%d: SDM2xx found\n", saa_num); 
 
-	pci_set_drvdata(pdev, (void *)saa_num);
+	pci_set_drvdata(pdev, &saa7146s[saa_num]);
 
 	retval = configure_saa7146(pdev, saa_num);
 	if (retval) {
@@ -2219,7 +2185,7 @@ static int __devinit stradis_probe(struc
 		goto err;
 	}
 
-	if (init_saa7146(saa_num, &pdev->dev) < 0) {
+	if (init_saa7146(pdev) < 0) {
 		dev_err(&pdev->dev, "%d: error in initialization\n", saa_num);
 		retval = -EIO;
 		goto errrel;
