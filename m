Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSKVOSZ>; Fri, 22 Nov 2002 09:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbSKVOSZ>; Fri, 22 Nov 2002 09:18:25 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:5260 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S264883AbSKVOSS>; Fri, 22 Nov 2002 09:18:18 -0500
Date: Fri, 22 Nov 2002 15:25:18 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.5.48+bk] meye driver update
Message-ID: <20021122152518.C21526@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates the MotionEye camera driver to the latest version.

The most important changes are:
	- allocate buffers on open(), not module load;
	- correct some failed allocation paths;
	- use wait_event;
	- C99 structs inits;

Linus, please apply.

Stelian.

===== Documentation/video4linux/meye.txt 1.4 vs edited =====
--- 1.4/Documentation/video4linux/meye.txt	Mon Jul 15 19:03:08 2002
+++ edited/Documentation/video4linux/meye.txt	Fri Nov  8 15:32:10 2002
@@ -1,6 +1,7 @@
 Vaio Picturebook Motion Eye Camera Driver Readme
 ------------------------------------------------
-	Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+	Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+	Copyright (C) 2001-2002 Alcôve <www.alcove.com>
 	Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
 
 This driver enable the use of video4linux compatible applications with the
@@ -52,7 +53,7 @@
 				or
 			xawtv -c /dev/video0 -geometry 320x240
 
-	motioneye (<http://www.alcove-labs.org/en/software/meye/>)
+	motioneye (<http://popies.net/meye/>)
 		for getting ppm or jpg snapshots, mjpeg video
 
 Private API:
===== include/linux/meye.h 1.1 vs edited =====
--- 1.1/include/linux/meye.h	Tue Feb  5 20:10:31 2002
+++ edited/include/linux/meye.h	Fri Nov  8 15:26:15 2002
@@ -1,7 +1,9 @@
 /* 
  * Motion Eye video4linux driver for Sony Vaio PictureBook
  *
- * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+ * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ *
+ * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
  * Copyright (C) 2000 Andrew Tridgell <tridge@valinux.com>
  *
===== drivers/media/video/meye.h 1.5 vs edited =====
--- 1.5/drivers/media/video/meye.h	Fri May  3 01:16:53 2002
+++ edited/drivers/media/video/meye.h	Mon Nov 18 11:54:26 2002
@@ -1,7 +1,9 @@
 /* 
  * Motion Eye video4linux driver for Sony Vaio PictureBook
  *
- * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+ * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ *
+ * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
  * Copyright (C) 2000 Andrew Tridgell <tridge@valinux.com>
  *
@@ -29,7 +31,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	4
+#define MEYE_DRIVER_MINORVERSION	5
 
 /****************************************************************************/
 /* Motion JPEG chip registers                                               */
===== drivers/media/video/meye.c 1.12 vs edited =====
--- 1.12/drivers/media/video/meye.c	Thu May 23 18:07:44 2002
+++ edited/drivers/media/video/meye.c	Fri Nov 22 15:01:02 2002
@@ -1,7 +1,9 @@
 /* 
  * Motion Eye video4linux driver for Sony Vaio PictureBook
  *
- * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
+ * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ *
+ * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
  * Copyright (C) 2000 Andrew Tridgell <tridge@valinux.com>
  *
@@ -169,16 +171,28 @@
 	meye.mchip_ptable[MCHIP_NB_PAGES] = pci_alloc_consistent(meye.mchip_dev, 
 								 PAGE_SIZE, 
 								 &meye.mchip_dmahandle);
-	if (!meye.mchip_ptable[MCHIP_NB_PAGES])
+	if (!meye.mchip_ptable[MCHIP_NB_PAGES]) {
+		meye.mchip_dmahandle = 0;
 		return -1;
+	}
 
 	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		meye.mchip_ptable[i] = pci_alloc_consistent(meye.mchip_dev, 
 							    PAGE_SIZE,
 							    pt);
-		if (!meye.mchip_ptable[i])
+		if (!meye.mchip_ptable[i]) {
+			int j;
+			pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+			for (j = 0; j < i; ++j) {
+				pci_free_consistent(meye.mchip_dev,
+						    PAGE_SIZE,
+						    meye.mchip_ptable[j], *pt);
+				pt++;
+			}
+			meye.mchip_dmahandle = 0;
 			return -1;
+		}
 		pt++;
 	}
 	return 0;
@@ -189,11 +203,13 @@
 	int i;
 
 	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
-	for (i = 0; i < MCHIP_NB_PAGES; i++)
+	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		if (meye.mchip_ptable[i])
 			pci_free_consistent(meye.mchip_dev, 
 					    PAGE_SIZE, 
 					    meye.mchip_ptable[i], *pt);
+		pt++;
+	}
 
 	if (meye.mchip_ptable[MCHIP_NB_PAGES])
 		pci_free_consistent(meye.mchip_dev, 
@@ -569,6 +585,16 @@
 	mchip_load_tables();
 }
 
+/* sets the DMA parameters into the chip */
+static void mchip_dma_setup(u32 dma_addr) {
+	int i;
+
+	mchip_set(MCHIP_MM_PT_ADDR, dma_addr);
+	for (i = 0; i < 4; i++)
+		mchip_set(MCHIP_MM_FIR(i), 0);
+	meye.mchip_fnum = 0;
+}
+
 /* setup for DMA transfers - also zeros the framebuffer */
 static int mchip_dma_alloc(void) {
 	if (!meye.mchip_dmahandle)
@@ -579,18 +605,10 @@
 
 /* frees the DMA buffer */
 static void mchip_dma_free(void) {
-	if (meye.mchip_dmahandle)
+	if (meye.mchip_dmahandle) {
+		mchip_dma_setup(0);
 		ptable_free();
-}
-
-/* sets the DMA parameters into the chip */
-static void mchip_dma_setup(void) {
-	int i;
-
-	mchip_set(MCHIP_MM_PT_ADDR, meye.mchip_dmahandle);
-	for (i = 0; i < 4; i++)
-		mchip_set(MCHIP_MM_FIR(i), 0);
-	meye.mchip_fnum = 0;
+	}
 }
 
 /* stop any existing HIC action and wait for any dma to complete then
@@ -698,7 +716,7 @@
 	
 	mchip_hic_stop();
 	mchip_subsample();
-	mchip_dma_setup();
+	mchip_dma_setup(meye.mchip_dmahandle);
 
 	mchip_set(MCHIP_HIC_MODE, MCHIP_HIC_MODE_STILL_CAP);
 	mchip_set(MCHIP_HIC_CMD, MCHIP_HIC_CMD_START);
@@ -741,7 +759,7 @@
 	mchip_hic_stop();
 	mchip_subsample();
 	mchip_set_framerate();
-	mchip_dma_setup();
+	mchip_dma_setup(meye.mchip_dmahandle);
 
 	meye.mchip_mode = MCHIP_HIC_MODE_CONT_OUT;
 
@@ -801,7 +819,7 @@
 	mchip_vrj_setup(0x3f);
 	mchip_subsample();
 	mchip_set_framerate();
-	mchip_dma_setup();
+	mchip_dma_setup(meye.mchip_dmahandle);
 
 	meye.mchip_mode = MCHIP_HIC_MODE_CONT_COMP;
 
@@ -823,7 +841,7 @@
 	while (1) {
 		v = mchip_get_frame();
 		if (!(v & MCHIP_MM_FIR_RDY))
-			goto out;
+			return;
 		switch (meye.mchip_mode) {
 
 		case MCHIP_HIC_MODE_CONT_OUT:
@@ -856,12 +874,11 @@
 
 		default:
 			/* do not free frame, since it can be a snap */
-			goto out;
+			return;
 		} /* switch */
 
 		mchip_free_frame();
 	}
-out:
 }
 
 /****************************************************************************/
@@ -889,6 +906,7 @@
 
 static int meye_release(struct inode *inode, struct file *file) {
 	mchip_hic_stop();
+	mchip_dma_free();
 	video_exclusive_release(inode,file);
 	return 0;
 }
@@ -957,7 +975,6 @@
 
 	case VIDIOCSYNC: {
 		int *i = arg;
-		DECLARE_WAITQUEUE(wait, current);
 
 		if (*i < 0 || *i >= gbuffers)
 			return -EINVAL;
@@ -967,18 +984,9 @@
 		case MEYE_BUF_UNUSED:
 			return -EINVAL;
 		case MEYE_BUF_USING:
-			add_wait_queue(&meye.grabq.proc_list, &wait);
-			current->state = TASK_INTERRUPTIBLE;
-			while (meye.grab_buffer[*i].state == MEYE_BUF_USING) {
-				schedule();
-				if(signal_pending(current)) {
-					remove_wait_queue(&meye.grabq.proc_list, &wait);
-					current->state = TASK_RUNNING;
-					return -EINTR;
-				}
-			}
-			remove_wait_queue(&meye.grabq.proc_list, &wait);
-			current->state = TASK_RUNNING;
+			if (wait_event_interruptible(meye.grabq.proc_list,
+						     (meye.grab_buffer[*i].state != MEYE_BUF_USING)))
+				return -EINTR;
 			/* fall through */
 		case MEYE_BUF_DONE:
 			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
@@ -1095,7 +1103,6 @@
 
 	case MEYEIOC_SYNC: {
 		int *i = arg;
-		DECLARE_WAITQUEUE(wait, current);
 
 		if (*i < 0 || *i >= gbuffers)
 			return -EINVAL;
@@ -1105,18 +1112,9 @@
 		case MEYE_BUF_UNUSED:
 			return -EINVAL;
 		case MEYE_BUF_USING:
-			add_wait_queue(&meye.grabq.proc_list, &wait);
-			current->state = TASK_INTERRUPTIBLE;
-			while (meye.grab_buffer[*i].state == MEYE_BUF_USING) {
-				schedule();
-				if(signal_pending(current)) {
-					remove_wait_queue(&meye.grabq.proc_list, &wait);
-					current->state = TASK_RUNNING;
-					return -EINTR;
-				}
-			}
-			remove_wait_queue(&meye.grabq.proc_list, &wait);
-			current->state = TASK_RUNNING;
+			if (wait_event_interruptible(meye.grabq.proc_list,
+						     (meye.grab_buffer[*i].state != MEYE_BUF_USING)))
+				return -EINTR;
 			/* fall through */
 		case MEYE_BUF_DONE:
 			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
@@ -1211,20 +1209,20 @@
 }
 
 static struct file_operations meye_fops = {
-	owner:		THIS_MODULE,
-	open:		meye_open,
-	release:	meye_release,
-	mmap:		meye_mmap,
-	ioctl:		meye_ioctl,
-	llseek:		no_llseek,
+	.owner		= THIS_MODULE,
+	.open		= meye_open,
+	.release	= meye_release,
+	.mmap		= meye_mmap,
+	.ioctl		= meye_ioctl,
+	.llseek		= no_llseek,
 };
 
 static struct video_device meye_template = {
-	owner:		THIS_MODULE,
-	name:		"meye",
-	type:		VID_TYPE_CAPTURE,
-	hardware:	VID_HARDWARE_MEYE,
-	fops:		&meye_fops,
+	.owner		= THIS_MODULE,
+	.name		= "meye",
+	.type		= VID_TYPE_CAPTURE,
+	.hardware	= VID_HARDWARE_MEYE,
+	.fops		= &meye_fops,
 };
 
 static int __devinit meye_probe(struct pci_dev *pcidev, 
@@ -1244,15 +1242,9 @@
 	meye.mchip_dev = pcidev;
 	memcpy(&meye.video_dev, &meye_template, sizeof(meye_template));
 
-	if (mchip_dma_alloc()) {
-		printk(KERN_ERR "meye: mchip framebuffer allocation failed\n");
-		ret = -ENOMEM;
-		goto out2;
-	}
-
 	if ((ret = pci_enable_device(meye.mchip_dev))) {
 		printk(KERN_ERR "meye: pci_enable_device failed\n");
-		goto out3;
+		goto out2;
 	}
 
 	meye.mchip_irq = pcidev->irq;
@@ -1260,14 +1252,14 @@
 	if (!mchip_adr) {
 		printk(KERN_ERR "meye: mchip has no device base address\n");
 		ret = -EIO;
-		goto out4;
+		goto out3;
 	}
 	if (!request_mem_region(pci_resource_start(meye.mchip_dev, 0),
 			        pci_resource_len(meye.mchip_dev, 0),
 				"meye")) {
 		ret = -EIO;
 		printk(KERN_ERR "meye: request_mem_region failed\n");
-		goto out4;
+		goto out3;
 	}
 
 	pci_read_config_byte(meye.mchip_dev, PCI_REVISION_ID, &revision);
@@ -1280,14 +1272,14 @@
 	if ((ret = request_irq(meye.mchip_irq, meye_irq, 
 			       SA_INTERRUPT | SA_SHIRQ, "meye", meye_irq))) {
 		printk(KERN_ERR "meye: request_irq failed (ret=%d)\n", ret);
-		goto out5;
+		goto out4;
 	}
 
 	meye.mchip_mmregs = ioremap(mchip_adr, MCHIP_MM_REGS);
 	if (!meye.mchip_mmregs) {
 		printk(KERN_ERR "meye: ioremap failed\n");
 		ret = -EIO;
-		goto out6;
+		goto out5;
 	}
 	
 	/* Ask the camera to perform a soft reset. */
@@ -1309,7 +1301,7 @@
 
 		printk(KERN_ERR "meye: video_register_device failed\n");
 		ret = -EIO;
-		goto out7;
+		goto out6;
 	}
 	
 	printk(KERN_INFO "meye: Motion Eye Camera Driver v%d.%d.\n",
@@ -1343,17 +1335,15 @@
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERAAGC, 48);
 
 	return 0;
-out7:
-	iounmap(meye.mchip_mmregs);
 out6:
-	free_irq(meye.mchip_irq, meye_irq);
+	iounmap(meye.mchip_mmregs);
 out5:
+	free_irq(meye.mchip_irq, meye_irq);
+out4:
 	release_mem_region(pci_resource_start(meye.mchip_dev, 0),
 			   pci_resource_len(meye.mchip_dev, 0));
-out4:
-	pci_disable_device(meye.mchip_dev);
 out3:
-	mchip_dma_free();
+	pci_disable_device(meye.mchip_dev);
 out2:
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
 out1:
@@ -1371,7 +1361,6 @@
 
 	free_irq(meye.mchip_irq, meye_irq);
 
-
 	iounmap(meye.mchip_mmregs);
 
 	release_mem_region(pci_resource_start(meye.mchip_dev, 0),
@@ -1398,10 +1387,10 @@
 MODULE_DEVICE_TABLE(pci, meye_pci_tbl);
 
 static struct pci_driver meye_driver = {
-	name:		"meye",
-	id_table:	meye_pci_tbl,
-	probe:		meye_probe,
-	remove:		__devexit_p(meye_remove),
+	.name		= "meye",
+	.id_table	= meye_pci_tbl,
+	.probe		= meye_probe,
+	.remove		= __devexit_p(meye_remove),
 };
 
 static int __init meye_init_module(void) {
@@ -1441,7 +1430,7 @@
 __setup("meye=", meye_setup);
 #endif
 
-MODULE_AUTHOR("Stelian Pop <stelian.pop@fr.alcove.com>");
+MODULE_AUTHOR("Stelian Pop <stelian@popies.net>");
 MODULE_DESCRIPTION("video4linux driver for the MotionEye camera");
 MODULE_LICENSE("GPL");
 
	
	
-- 
Stelian Pop <stelian@popies.net>
