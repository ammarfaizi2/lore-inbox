Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbUKDLVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbUKDLVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUKDLTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:19:38 -0500
Received: from sd291.sivit.org ([194.146.225.122]:18393 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262168AbUKDLPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:15:33 -0500
Date: Thu, 4 Nov 2004 12:15:44 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/12] meye: cleanup init/exit paths
Message-ID: <20041104111544.GL3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2345, 2004-11-02 16:07:38+01:00, stelian@popies.net
  meye: cleanup init/exit paths
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 meye.c |  104 +++++++++++++++++++++++++++++------------------------------------
 1 files changed, 47 insertions(+), 57 deletions(-)

===================================================================

diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-04 11:26:57 +01:00
+++ b/drivers/media/video/meye.c	2004-11-04 11:26:58 +01:00
@@ -837,13 +837,14 @@
 	err = video_exclusive_open(inode,file);
 	if (err < 0)
 		return err;
-			
+
+	mchip_hic_stop();
+
 	if (mchip_dma_alloc()) {
 		printk(KERN_ERR "meye: mchip framebuffer allocation failed\n");
 		video_exclusive_release(inode,file);
 		return -ENOBUFS;
 	}
-	mchip_hic_stop();
 
 	for (i = 0; i < MEYE_MAX_BUFNBRS; i++)
 		meye.grab_buffer[i].state = MEYE_BUF_UNUSED;
@@ -1250,22 +1251,20 @@
 
 static int __devinit meye_probe(struct pci_dev *pcidev, 
 		                const struct pci_device_id *ent) {
-	int ret;
+	int ret = -EBUSY;
 	unsigned long mchip_adr;
 	u8 revision;
 
 	if (meye.mchip_dev != NULL) {
 		printk(KERN_ERR "meye: only one device allowed!\n");
-		ret = -EBUSY;
-		goto out1;
+		goto outnotdev;
 	}
 
 	meye.mchip_dev = pcidev;
 	meye.video_dev = video_device_alloc();
 	if (!meye.video_dev) {
 		printk(KERN_ERR "meye: video_device_alloc() failed!\n");
-		ret = -EBUSY;
-		goto out1;
+		goto outnotdev;
 	}
 
 	ret = -ENOMEM;
@@ -1295,46 +1294,42 @@
 
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1);
 
+	ret = -EIO;
 	if ((ret = pci_enable_device(meye.mchip_dev))) {
 		printk(KERN_ERR "meye: pci_enable_device failed\n");
-		goto out2;
+		goto outenabledev;
 	}
 
-	meye.mchip_irq = pcidev->irq;
 	mchip_adr = pci_resource_start(meye.mchip_dev,0);
 	if (!mchip_adr) {
 		printk(KERN_ERR "meye: mchip has no device base address\n");
-		ret = -EIO;
-		goto out3;
+		goto outregions;
 	}
 	if (!request_mem_region(pci_resource_start(meye.mchip_dev, 0),
-			        pci_resource_len(meye.mchip_dev, 0),
+				pci_resource_len(meye.mchip_dev, 0),
 				"meye")) {
-		ret = -EIO;
 		printk(KERN_ERR "meye: request_mem_region failed\n");
-		goto out3;
+		goto outregions;
+	}
+	meye.mchip_mmregs = ioremap(mchip_adr, MCHIP_MM_REGS);
+	if (!meye.mchip_mmregs) {
+		printk(KERN_ERR "meye: ioremap failed\n");
+		goto outremap;
 	}
 
-	pci_read_config_byte(meye.mchip_dev, PCI_REVISION_ID, &revision);
-
-	pci_set_master(meye.mchip_dev);
+	meye.mchip_irq = pcidev->irq;
+	if (request_irq(meye.mchip_irq, meye_irq,
+			SA_INTERRUPT | SA_SHIRQ, "meye", meye_irq)) {
+		printk(KERN_ERR "meye: request_irq failed\n");
+		goto outreqirq;
+	}
 
+	pci_read_config_byte(meye.mchip_dev, PCI_REVISION_ID, &revision);
 	pci_write_config_byte(meye.mchip_dev, PCI_CACHE_LINE_SIZE, 8);
 	pci_write_config_byte(meye.mchip_dev, PCI_LATENCY_TIMER, 64);
 
-	if ((ret = request_irq(meye.mchip_irq, meye_irq, 
-			       SA_INTERRUPT | SA_SHIRQ, "meye", meye_irq))) {
-		printk(KERN_ERR "meye: request_irq failed (ret=%d)\n", ret);
-		goto out4;
-	}
+	pci_set_master(meye.mchip_dev);
 
-	meye.mchip_mmregs = ioremap(mchip_adr, MCHIP_MM_REGS);
-	if (!meye.mchip_mmregs) {
-		printk(KERN_ERR "meye: ioremap failed\n");
-		ret = -EIO;
-		goto out5;
-	}
-	
 	/* Ask the camera to perform a soft reset. */
 	pci_write_config_word(meye.mchip_dev, MCHIP_PCI_SOFTRESET_SET, 1);
 
@@ -1353,20 +1348,11 @@
 	if (video_register_device(meye.video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
 
 		printk(KERN_ERR "meye: video_register_device failed\n");
-		ret = -EIO;
-		goto out6;
+		goto outvideoreg;
 	}
 	
-	printk(KERN_INFO "meye: Motion Eye Camera Driver v%d.%d.\n",
-	       MEYE_DRIVER_MAJORVERSION,
-	       MEYE_DRIVER_MINORVERSION);
-	printk(KERN_INFO "meye: mchip KL5A72002 rev. %d, base %lx, irq %d\n", 
-		revision, mchip_adr, meye.mchip_irq);
-
-	/* init all fields */
 	init_MUTEX(&meye.lock);
 	init_waitqueue_head(&meye.proc_list);
-
 	meye.picture.depth = 16;
 	meye.picture.palette = VIDEO_PALETTE_YUV422;
 	meye.picture.brightness = 32 << 10;
@@ -1375,11 +1361,12 @@
 	meye.picture.contrast = 32 << 10;
 	meye.picture.whiteness = 0;
 	meye.params.subsample = 0;
-	meye.params.quality = 7;
+	meye.params.quality = 8;
 	meye.params.sharpness = 32;
 	meye.params.agc = 48;
 	meye.params.picture = 0;
 	meye.params.framerate = 0;
+	
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERABRIGHTNESS, 32);
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERAHUE, 32);
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERACOLOR, 32);
@@ -1388,20 +1375,23 @@
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERAPICTURE, 0);
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERAAGC, 48);
 
+	printk(KERN_INFO "meye: Motion Eye Camera Driver v%s.\n",
+	       MEYE_DRIVER_VERSION);
+	printk(KERN_INFO "meye: mchip KL5A72002 rev. %d, base %lx, irq %d\n",
+	       revision, mchip_adr, meye.mchip_irq);
+
 	return 0;
-out6:
-	iounmap(meye.mchip_mmregs);
-out5:
+
+outvideoreg:
 	free_irq(meye.mchip_irq, meye_irq);
-out4:
+outreqirq:
+	iounmap(meye.mchip_mmregs);
+outremap:
 	release_mem_region(pci_resource_start(meye.mchip_dev, 0),
 			   pci_resource_len(meye.mchip_dev, 0));
-out3:
+outregions:
 	pci_disable_device(meye.mchip_dev);
-out2:
-	video_device_release(meye.video_dev);
-	meye.video_dev = NULL;
-
+outenabledev:
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
 	kfifo_free(meye.doneq);
 outkfifoalloc2:
@@ -1410,7 +1400,7 @@
 	vfree(meye.grab_temp);
 outvmalloc:
 	video_device_release(meye.video_dev);
-out1:
+outnotdev:
 	return ret;
 }
 
@@ -1434,9 +1424,6 @@
 
 	pci_disable_device(meye.mchip_dev);
 
-	if (meye.grab_fbuffer)
-		rvfree(meye.grab_fbuffer, gbuffers*gbufsize);
-
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
 
 	kfifo_free(meye.doneq);
@@ -1444,6 +1431,11 @@
 
 	vfree(meye.grab_temp);
 
+	if (meye.grab_fbuffer) {
+		rvfree(meye.grab_fbuffer, gbuffers*gbufsize);
+		meye.grab_fbuffer = NULL;
+	}
+
 	printk(KERN_INFO "meye: removed\n");
 }
 
@@ -1467,12 +1459,10 @@
 };
 
 static int __init meye_init(void) {
-	if (gbuffers < 2)
-		gbuffers = 2;
-	if (gbuffers > MEYE_MAX_BUFNBRS)
-		gbuffers = MEYE_MAX_BUFNBRS;
+	gbuffers = max(2, min((int)gbuffers, MEYE_MAX_BUFNBRS));
 	if (gbufsize < 0 || gbufsize > MEYE_MAX_BUFSIZE)
 		gbufsize = MEYE_MAX_BUFSIZE;
+	gbufsize = PAGE_ALIGN(gbufsize);
 	printk(KERN_INFO "meye: using %d buffers with %dk (%dk total) for capture\n",
 	       gbuffers, gbufsize/1024, gbuffers*gbufsize/1024);
 	return pci_module_init(&meye_driver);
