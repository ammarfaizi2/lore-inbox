Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271535AbTGQSQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271556AbTGQSQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:16:09 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:18329 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271535AbTGQSPO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:15:14 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 17 Jul 2003 20:32:54 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] minor btaudio update
Message-ID: <20030717183254.GA21916@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch resynces the kernel btaudio driver with my latest
source.  It turnes the card specific insmod options into an
array, so it is possible to specify different ones per card
in case multiple cards are installed.  There are also some
no-op changes like updated comments and some whitespace
changes (s/TAB/spaces/).

  Gerd

diff -u linux-2.6.0-test1/sound/oss/btaudio.c linux/sound/oss/btaudio.c
--- linux-2.6.0-test1/sound/oss/btaudio.c	2003-07-17 18:55:20.987000611 +0200
+++ linux/sound/oss/btaudio.c	2003-07-17 19:13:33.674447383 +0200
@@ -1,7 +1,7 @@
 /*
-    btaudio - bt878 audio dma driver for linux 2.4.x
+    btaudio - bt878 audio dma driver for linux 2.4 / 2.5
 
-    (c) 2000-2002 Gerd Knorr <kraxel@bytesex.org>
+    (c) 2000-2003 Gerd Knorr <kraxel@bytesex.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -150,9 +150,10 @@
 	int rate;
 };
 
-static struct btaudio *btaudios = NULL;
-static unsigned int debug = 0;
-static unsigned int irq_debug = 0;
+static struct btaudio *btaudios  = NULL;
+static unsigned int btcount      = 0;
+static unsigned int debug        = 0;
+static unsigned int irq_debug    = 0;
 
 /* -------------------------------------------------------------- */
 
@@ -338,7 +339,7 @@
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
 		memset(&info,0,sizeof(info));
-                strncpy(info.id,"bt878",sizeof(info.id)-1);
+                strncpy(info.id,"bt878",sizeof(info.id));
                 strncpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -424,11 +425,11 @@
 }
 
 static struct file_operations btaudio_mixer_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.open		= btaudio_mixer_open,
-	.release	= btaudio_mixer_release,
-	.ioctl		= btaudio_mixer_ioctl,
+	.owner    = THIS_MODULE,
+	.llseek   = no_llseek,
+	.open     = btaudio_mixer_open,
+	.release  = btaudio_mixer_release,
+	.ioctl    = btaudio_mixer_ioctl,
 };
 
 /* -------------------------------------------------------------- */
@@ -789,25 +790,25 @@
 }
 
 static struct file_operations btaudio_digital_dsp_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.open		= btaudio_dsp_open_digital,
-	.release	= btaudio_dsp_release,
-	.read		= btaudio_dsp_read,
-	.write		= btaudio_dsp_write,
-	.ioctl		= btaudio_dsp_ioctl,
-	.poll		= btaudio_dsp_poll,
+	.owner   = THIS_MODULE,
+	.llseek  = no_llseek,
+	.open    = btaudio_dsp_open_digital,
+	.release = btaudio_dsp_release,
+	.read    = btaudio_dsp_read,
+	.write   = btaudio_dsp_write,
+	.ioctl   = btaudio_dsp_ioctl,
+	.poll    = btaudio_dsp_poll,
 };
 
 static struct file_operations btaudio_analog_dsp_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.open		= btaudio_dsp_open_analog,
-	.release	= btaudio_dsp_release,
-	.read		= btaudio_dsp_read,
-	.write		= btaudio_dsp_write,
-	.ioctl		= btaudio_dsp_ioctl,
-	.poll		= btaudio_dsp_poll,
+	.owner   = THIS_MODULE,
+	.llseek  = no_llseek,
+	.open    = btaudio_dsp_open_analog,
+	.release = btaudio_dsp_release,
+	.read    = btaudio_dsp_read,
+	.write   = btaudio_dsp_write,
+	.ioctl   = btaudio_dsp_ioctl,
+	.poll    = btaudio_dsp_poll,
 };
 
 /* -------------------------------------------------------------- */
@@ -828,7 +829,7 @@
 		stat  = btread(REG_INT_STAT);
 		astat = stat & btread(REG_INT_MASK);
 		if (!astat)
-			return IRQ_RETVAL(handled);
+			break;
 		handled = 1;
 		btwrite(astat,REG_INT_STAT);
 
@@ -865,29 +866,31 @@
 			btwrite(0, REG_INT_MASK);
 		}
 	}
-	return IRQ_NONE;
+	return IRQ_RETVAL(handled);
 }
 
 /* -------------------------------------------------------------- */
 
-static unsigned int dsp1 = -1;
-static unsigned int dsp2 = -1;
-static unsigned int mixer = -1;
+#define BTAUDIO_MAX 16
+
+static unsigned int dsp1[BTAUDIO_MAX]  = { [ 0 ... BTAUDIO_MAX-1 ] = -1 };
+static unsigned int dsp2[BTAUDIO_MAX]  = { [ 0 ... BTAUDIO_MAX-1 ] = -1 };
+static unsigned int mixer[BTAUDIO_MAX] = { [ 0 ... BTAUDIO_MAX-1 ] = -1 };
+static int digital[BTAUDIO_MAX] = { [ 0 ... BTAUDIO_MAX-1 ] = 1 };
+static int analog[BTAUDIO_MAX]  = { [ 0 ... BTAUDIO_MAX-1 ] = 1 };
+static int rate[BTAUDIO_MAX]    = { [ 0 ... BTAUDIO_MAX-1 ] = 0 };
 static int latency = -1;
-static int digital = 1;
-static int analog = 1;
-static int rate = 0;
 
 #define BTA_OSPREY200 1
 
 static struct cardinfo cards[] = {
 	[0] = {
-		.name	= "default",
-		.rate	= 32000,
+		.name = "default",
+		.rate = 32000,
 	},
 	[BTA_OSPREY200] = {
-		.name	= "Osprey 200",
-		.rate	= 44100,
+		.name = "Osprey 200",
+		.rate = 44100,
 	},
 };
 
@@ -899,6 +902,9 @@
 	unsigned char revision,lat;
 	int rc = -EBUSY;
 
+	if (BTAUDIO_MAX == btcount)
+		return -EBUSY;
+
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 	if (!request_mem_region(pci_resource_start(pci_dev,0),
@@ -932,8 +938,8 @@
 
 	/* sample rate */
 	bta->rate = card->rate;
-	if (rate)
-		bta->rate = rate;
+	if (rate[btcount])
+		bta->rate = rate[btcount];
 	
 	init_MUTEX(&bta->lock);
         init_waitqueue_head(&bta->readq);
@@ -955,7 +961,7 @@
 	/* init hw */
         btwrite(0, REG_GPIO_DMA_CTL);
         btwrite(0, REG_INT_MASK);
-        btwrite(~0x0UL, REG_INT_STAT);
+        btwrite(~(u32)0, REG_INT_STAT);
 	pci_set_master(pci_dev);
 
 	if ((rc = request_irq(bta->irq, btaudio_irq, SA_SHIRQ|SA_INTERRUPT,
@@ -966,9 +972,9 @@
 	}
 
 	/* register devices */
-	if (digital) {
+	if (digital[btcount]) {
 		rc = bta->dsp_digital =
-			register_sound_dsp(&btaudio_digital_dsp_fops,dsp1);
+			register_sound_dsp(&btaudio_digital_dsp_fops,dsp1[btcount]);
 		if (rc < 0) {
 			printk(KERN_WARNING
 			       "btaudio: can't register digital dsp (rc=%d)\n",rc);
@@ -977,9 +983,9 @@
 		printk(KERN_INFO "btaudio: registered device dsp%d [digital]\n",
 		       bta->dsp_digital >> 4);
 	}
-	if (analog) {
+	if (analog[btcount]) {
 		rc = bta->dsp_analog =
-			register_sound_dsp(&btaudio_analog_dsp_fops,dsp2);
+			register_sound_dsp(&btaudio_analog_dsp_fops,dsp2[btcount]);
 		if (rc < 0) {
 			printk(KERN_WARNING
 			       "btaudio: can't register analog dsp (rc=%d)\n",rc);
@@ -987,7 +993,8 @@
 		}
 		printk(KERN_INFO "btaudio: registered device dsp%d [analog]\n",
 		       bta->dsp_analog >> 4);
-		rc = bta->mixer_dev = register_sound_mixer(&btaudio_mixer_fops,mixer);
+		rc = bta->mixer_dev = register_sound_mixer(&btaudio_mixer_fops,
+							   mixer[btcount]);
 		if (rc < 0) {
 			printk(KERN_WARNING
 			       "btaudio: can't register mixer (rc=%d)\n",rc);
@@ -1000,6 +1007,7 @@
 	/* hook into linked list */
 	bta->next = btaudios;
 	btaudios = bta;
+	btcount++;
 
 	pci_set_drvdata(pci_dev,bta);
         return 0;
@@ -1027,7 +1035,7 @@
 	/* turn off all DMA / IRQs */
         btand(~15, REG_GPIO_DMA_CTL);
         btwrite(0, REG_INT_MASK);
-        btwrite(~0x0UL, REG_INT_STAT);
+        btwrite(~(u32)0, REG_INT_STAT);
 
 	/* unregister devices */
 	if (digital) {
@@ -1052,6 +1060,7 @@
 			; /* if (NULL == walk->next) BUG(); */
 		walk->next = bta->next;
 	}
+	btcount--;
 
 	pci_set_drvdata(pci_dev, NULL);
 	kfree(bta);
@@ -1062,31 +1071,31 @@
 
 static struct pci_device_id btaudio_pci_tbl[] __devinitdata = {
         {
-		.vendor		= PCI_VENDOR_ID_BROOKTREE,
-		.device		= 0x0878,
-		.subvendor	= 0x0070,
-		.subdevice	= 0xff01,
-		.driver_data	= BTA_OSPREY200,
+		.vendor       = PCI_VENDOR_ID_BROOKTREE,
+		.device       = 0x0878,
+		.subvendor    = 0x0070,
+		.subdevice    = 0xff01,
+		.driver_data  = BTA_OSPREY200,
 	},{
-		.vendor		= PCI_VENDOR_ID_BROOKTREE,
-		.device		= 0x0878,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
+		.vendor       = PCI_VENDOR_ID_BROOKTREE,
+		.device       = 0x0878,
+		.subvendor    = PCI_ANY_ID,
+		.subdevice    = PCI_ANY_ID,
 	},{
-		.vendor		= PCI_VENDOR_ID_BROOKTREE,
-		.device		= 0x0878,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
+		.vendor       = PCI_VENDOR_ID_BROOKTREE,
+		.device       = 0x0879,
+		.subvendor    = PCI_ANY_ID,
+		.subdevice    = PCI_ANY_ID,
         },{
 		/* --- end of list --- */
 	}
 };
 
 static struct pci_driver btaudio_pci_driver = {
-        .name		= "btaudio",
-        .id_table	= btaudio_pci_tbl,
-        .probe		= btaudio_probe,
-        .remove		=  __devexit_p(btaudio_remove),
+        .name     = "btaudio",
+        .id_table = btaudio_pci_tbl,
+        .probe    = btaudio_probe,
+        .remove   = __devexit_p(btaudio_remove),
 };
 
 static int btaudio_init_module(void)
@@ -1107,15 +1116,21 @@
 module_init(btaudio_init_module);
 module_exit(btaudio_cleanup_module);
 
-MODULE_PARM(dsp1,"i");
-MODULE_PARM(dsp2,"i");
-MODULE_PARM(mixer,"i");
-MODULE_PARM(debug,"i");
-MODULE_PARM(irq_debug,"i");
-MODULE_PARM(digital,"i");
-MODULE_PARM(analog,"i");
-MODULE_PARM(rate,"i");
-MODULE_PARM(latency,"i");
+MODULE_PARM(dsp1, "1-" __stringify(BTAUDIO_MAX) "i");
+MODULE_PARM_DESC(dsp1,"digital dsp nr");
+MODULE_PARM(dsp2, "1-" __stringify(BTAUDIO_MAX) "i");
+MODULE_PARM_DESC(dsp2,"analog dsp nr");
+MODULE_PARM(mixer, "1-" __stringify(BTAUDIO_MAX) "i");
+MODULE_PARM_DESC(mixer,"mixer nr");
+MODULE_PARM(debug, "i");
+MODULE_PARM(irq_debug, "i");
+MODULE_PARM(digital, "1-" __stringify(BTAUDIO_MAX) "i");
+MODULE_PARM_DESC(digital,"register digital dsp device");
+MODULE_PARM(analog, "1-" __stringify(BTAUDIO_MAX) "i");
+MODULE_PARM_DESC(analog,"register analog dsp device (and mixer)");
+MODULE_PARM(rate, "1-" __stringify(BTAUDIO_MAX) "i");
+MODULE_PARM_DESC(rate,"sample rate supported by the hardware");
+MODULE_PARM(latency, "i");
 MODULE_PARM_DESC(latency,"pci latency timer");
 
 MODULE_DEVICE_TABLE(pci, btaudio_pci_tbl);

-- 
sigfault
