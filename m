Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282684AbRLFTxU>; Thu, 6 Dec 2001 14:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282695AbRLFTxL>; Thu, 6 Dec 2001 14:53:11 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:11903 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282684AbRLFTxA>; Thu, 6 Dec 2001 14:53:00 -0500
Date: Thu, 6 Dec 2001 14:52:50 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Patch for ymfpci in pre5
Message-ID: <20011206145250.A8791@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcelo:

Here's a change for ymfpci, hopefuly the last one before 2.4.17.
It should fix artsd (KDE sound). Also I am slipping a Kai's
region request along with it.

I've got some good Kai's fixes lined up for 2.4.18.
(well, unless you delay .17 so much that it makes sense
to push them before that :)

Greetings,
-- Pete

--- linux-2.4.17-pre5/drivers/sound/ymfpci.c	Thu Dec  6 11:23:44 2001
+++ linux-2.4.17-pre5-p3/drivers/sound/ymfpci.c	Thu Dec  6 11:44:40 2001
@@ -1443,13 +1443,14 @@
 {
 	struct ymf_state *state = (struct ymf_state *)file->private_data;
 	struct ymf_dmabuf *dmabuf;
+	int redzone;
 	unsigned long flags;
 	unsigned int mask = 0;
 
 	if (file->f_mode & FMODE_WRITE)
 		poll_wait(file, &state->wpcm.dmabuf.wait, wait);
-	// if (file->f_mode & FMODE_READ)
-	// 	poll_wait(file, &dmabuf->wait, wait);
+	if (file->f_mode & FMODE_READ)
+		poll_wait(file, &state->rpcm.dmabuf.wait, wait);
 
 	spin_lock_irqsave(&state->unit->reg_lock, flags);
 	if (file->f_mode & FMODE_READ) {
@@ -1458,12 +1459,21 @@
 			mask |= POLLIN | POLLRDNORM;
 	}
 	if (file->f_mode & FMODE_WRITE) {
+		redzone = ymf_calc_lend(state->format.rate);
+		redzone <<= state->format.shift;
+		redzone *= 3;
+
 		dmabuf = &state->wpcm.dmabuf;
 		if (dmabuf->mapped) {
 			if (dmabuf->count >= (signed)dmabuf->fragsize)
 				mask |= POLLOUT | POLLWRNORM;
 		} else {
-			if ((signed)dmabuf->dmasize >= dmabuf->count + (signed)dmabuf->fragsize)
+			/*
+			 * Don't select unless a full fragment is available.
+			 * Otherwise artsd does GETOSPACE, sees 0, and loops.
+			 */
+			if (dmabuf->count + redzone + dmabuf->fragsize
+			     <= dmabuf->dmasize)
 				mask |= POLLOUT | POLLWRNORM;
 		}
 	}
@@ -1498,6 +1508,7 @@
 		return -EAGAIN;
 	dmabuf->mapped = 1;
 
+/* P3 */ printk(KERN_INFO "ymfpci: using memory mapped sound, untested!\n");
 	return 0;
 }
 
@@ -2430,6 +2441,7 @@
 static int __devinit ymf_probe_one(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
 	u16 ctrl;
+	unsigned long base;
 	ymfpci_t *codec;
 
 	int err;
@@ -2438,6 +2450,7 @@
 		printk(KERN_ERR "ymfpci: pci_enable_device failed\n");
 		return err;
 	}
+	base = pci_resource_start(pcidev, 0);
 
 	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "ymfpci: no core\n");
@@ -2452,16 +2465,21 @@
 	codec->pci = pcidev;
 
 	pci_read_config_byte(pcidev, PCI_REVISION_ID, &codec->rev);
-	codec->reg_area_virt = ioremap(pci_resource_start(pcidev, 0), 0x8000);
-	if (codec->reg_area_virt == NULL) {
-		printk(KERN_ERR "ymfpci: unable to map registers\n");
+
+	if (request_mem_region(base, 0x8000, "ymfpci") == NULL) {
+		printk(KERN_ERR "ymfpci: unable to request mem region\n");
 		goto out_free;
 	}
 
+	if ((codec->reg_area_virt = ioremap(base, 0x8000)) == NULL) {
+		printk(KERN_ERR "ymfpci: unable to map registers\n");
+		goto out_release_region;
+	}
+
 	pci_set_master(pcidev);
 
 	printk(KERN_INFO "ymfpci: %s at 0x%lx IRQ %d\n",
-	    (char *)ent->driver_data, pci_resource_start(pcidev, 0), pcidev->irq);
+	    (char *)ent->driver_data, base, pcidev->irq);
 
 	ymfpci_aclink_reset(pcidev);
 	if (ymfpci_codec_ready(codec, 0, 1) < 0)
@@ -2491,8 +2509,7 @@
 
 	/* register /dev/dsp */
 	if ((codec->dev_audio = register_sound_dsp(&ymf_fops, -1)) < 0) {
-		printk(KERN_ERR "ymfpci%d: unable to register dsp\n",
-		    codec->dev_audio);
+		printk(KERN_ERR "ymfpci: unable to register dsp\n");
 		goto out_free_irq;
 	}
 
@@ -2538,6 +2555,8 @@
 	ymfpci_writel(codec, YDSXGR_STATUS, ~0);
  out_unmap:
 	iounmap(codec->reg_area_virt);
+ out_release_region:
+	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
  out_free:
 	kfree(codec);
 	return -ENODEV;
@@ -2561,6 +2580,7 @@
 	ctrl = ymfpci_readw(codec, YDSXGR_GLOBALCTRL);
 	ymfpci_writew(codec, YDSXGR_GLOBALCTRL, ctrl & ~0x0007);
 	iounmap(codec->reg_area_virt);
+	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
 	if (codec->iomidi) {
 		unload_uart401(&codec->mpu_data);
