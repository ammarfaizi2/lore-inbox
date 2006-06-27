Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbWF0Qlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWF0Qlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161189AbWF0Qhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38890 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161177AbWF0Qh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:26 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/17] [PATCH] 64bit resource: fix up printks for resources in video drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:43 -0700
Message-Id: <11514260543854-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260513485-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/media/video/bt8xx/bttv-driver.c    |   10 ++++++----
 drivers/media/video/cx88/cx88-alsa.c       |    8 ++++----
 drivers/media/video/cx88/cx88-core.c       |    4 ++--
 drivers/media/video/cx88/cx88-mpeg.c       |    4 ++--
 drivers/media/video/cx88/cx88-video.c      |    4 ++--
 drivers/media/video/saa7134/saa7134-core.c |    8 ++++----
 6 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/media/video/bt8xx/bttv-driver.c b/drivers/media/video/bt8xx/bttv-driver.c
index 423e954..aa3203a 100644
--- a/drivers/media/video/bt8xx/bttv-driver.c
+++ b/drivers/media/video/bt8xx/bttv-driver.c
@@ -4019,8 +4019,9 @@ static int __devinit bttv_probe(struct p
 	if (!request_mem_region(pci_resource_start(dev,0),
 				pci_resource_len(dev,0),
 				btv->c.name)) {
-		printk(KERN_WARNING "bttv%d: can't request iomem (0x%lx).\n",
-		       btv->c.nr, pci_resource_start(dev,0));
+		printk(KERN_WARNING "bttv%d: can't request iomem (0x%llx).\n",
+		       btv->c.nr,
+		       (unsigned long long)pci_resource_start(dev,0));
 		return -EBUSY;
 	}
 	pci_set_master(dev);
@@ -4031,8 +4032,9 @@ static int __devinit bttv_probe(struct p
 	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
 	printk(KERN_INFO "bttv%d: Bt%d (rev %d) at %s, ",
 	       bttv_num,btv->id, btv->revision, pci_name(dev));
-	printk("irq: %d, latency: %d, mmio: 0x%lx\n",
-	       btv->c.pci->irq, lat, pci_resource_start(dev,0));
+	printk("irq: %d, latency: %d, mmio: 0x%llx\n",
+	       btv->c.pci->irq, lat,
+	       (unsigned long long)pci_resource_start(dev,0));
 	schedule();
 
 	btv->bt848_mmio=ioremap(pci_resource_start(dev,0), 0x1000);
diff --git a/drivers/media/video/cx88/cx88-alsa.c b/drivers/media/video/cx88/cx88-alsa.c
index 2194cbe..292a5e8 100644
--- a/drivers/media/video/cx88/cx88-alsa.c
+++ b/drivers/media/video/cx88/cx88-alsa.c
@@ -712,9 +712,9 @@ static int __devinit snd_cx88_create(str
 	pci_read_config_byte(pci, PCI_LATENCY_TIMER,  &chip->pci_lat);
 
 	dprintk(1,"ALSA %s/%i: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", core->name, devno,
+	       "latency: %d, mmio: 0x%llx\n", core->name, devno,
 	       pci_name(pci), chip->pci_rev, pci->irq,
-	       chip->pci_lat,pci_resource_start(pci,0));
+	       chip->pci_lat,(unsigned long long)pci_resource_start(pci,0));
 
 	chip->irq = pci->irq;
 	synchronize_irq(chip->irq);
@@ -766,8 +766,8 @@ static int __devinit cx88_audio_initdev(
 
 	strcpy (card->driver, "CX88x");
 	sprintf(card->shortname, "Conexant CX%x", pci->device);
-	sprintf(card->longname, "%s at %#lx",
-		card->shortname, pci_resource_start(pci, 0));
+	sprintf(card->longname, "%s at %#llx",
+		card->shortname,(unsigned long long)pci_resource_start(pci, 0));
 	strcpy (card->mixername, "CX88");
 
 	dprintk (0, "%s/%i: ALSA support for cx2388x boards\n",
diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
index 26f4c0f..973d3f3 100644
--- a/drivers/media/video/cx88/cx88-core.c
+++ b/drivers/media/video/cx88/cx88-core.c
@@ -1031,8 +1031,8 @@ static int get_ressources(struct cx88_co
 			       pci_resource_len(pci,0),
 			       core->name))
 		return 0;
-	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%lx\n",
-	       core->name,pci_resource_start(pci,0));
+	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx\n",
+	       core->name,(unsigned long long)pci_resource_start(pci,0));
 	return -EBUSY;
 }
 
diff --git a/drivers/media/video/cx88/cx88-mpeg.c b/drivers/media/video/cx88/cx88-mpeg.c
index a9d7795..2c12aca 100644
--- a/drivers/media/video/cx88/cx88-mpeg.c
+++ b/drivers/media/video/cx88/cx88-mpeg.c
@@ -420,9 +420,9 @@ int cx8802_init_common(struct cx8802_dev
 	pci_read_config_byte(dev->pci, PCI_CLASS_REVISION, &dev->pci_rev);
 	pci_read_config_byte(dev->pci, PCI_LATENCY_TIMER,  &dev->pci_lat);
 	printk(KERN_INFO "%s/2: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", dev->core->name,
+	       "latency: %d, mmio: 0x%llx\n", dev->core->name,
 	       pci_name(dev->pci), dev->pci_rev, dev->pci->irq,
-	       dev->pci_lat,pci_resource_start(dev->pci,0));
+	       dev->pci_lat,(unsigned long long)pci_resource_start(dev->pci,0));
 
 	/* initialize driver struct */
 	spin_lock_init(&dev->slock);
diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
index dcda529..8d5cf47 100644
--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -1847,9 +1847,9 @@ static int __devinit cx8800_initdev(stru
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
 	pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
 	printk(KERN_INFO "%s/0: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", core->name,
+	       "latency: %d, mmio: 0x%llx\n", core->name,
 	       pci_name(pci_dev), dev->pci_rev, pci_dev->irq,
-	       dev->pci_lat,pci_resource_start(pci_dev,0));
+	       dev->pci_lat,(unsigned long long)pci_resource_start(pci_dev,0));
 
 	pci_set_master(pci_dev);
 	if (!pci_dma_supported(pci_dev,0xffffffff)) {
diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
index f0c2111..da3007d 100644
--- a/drivers/media/video/saa7134/saa7134-core.c
+++ b/drivers/media/video/saa7134/saa7134-core.c
@@ -871,9 +871,9 @@ #endif
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
 	pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
 	printk(KERN_INFO "%s: found at %s, rev: %d, irq: %d, "
-	       "latency: %d, mmio: 0x%lx\n", dev->name,
+	       "latency: %d, mmio: 0x%llx\n", dev->name,
 	       pci_name(pci_dev), dev->pci_rev, pci_dev->irq,
-	       dev->pci_lat,pci_resource_start(pci_dev,0));
+	       dev->pci_lat,(unsigned long long)pci_resource_start(pci_dev,0));
 	pci_set_master(pci_dev);
 	if (!pci_dma_supported(pci_dev, DMA_32BIT_MASK)) {
 		printk("%s: Oops: no 32bit PCI DMA ???\n",dev->name);
@@ -905,8 +905,8 @@ #endif
 				pci_resource_len(pci_dev,0),
 				dev->name)) {
 		err = -EBUSY;
-		printk(KERN_ERR "%s: can't get MMIO memory @ 0x%lx\n",
-		       dev->name,pci_resource_start(pci_dev,0));
+		printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx\n",
+		       dev->name,(unsigned long long)pci_resource_start(pci_dev,0));
 		goto fail1;
 	}
 	dev->lmmio = ioremap(pci_resource_start(pci_dev,0), 0x1000);
-- 
1.4.0

