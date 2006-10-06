Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWJFFgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWJFFgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWJFFgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:36:02 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:17334 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932202AbWJFFff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:35 -0400
Subject: [PATCH 6/9] sound/pci/rme9652/hdsp.c: ioremap balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:08:56 +0530
Message-Id: <1160113136.19143.137.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 hdsp.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/pci/rme9652/hdsp.c linux-2.6.19-rc1/sound/pci/rme9652/hdsp.c
--- linux-2.6.19-rc1-orig/sound/pci/rme9652/hdsp.c	2006-10-05 14:01:05.000000000 +0530
+++ linux-2.6.19-rc1/sound/pci/rme9652/hdsp.c	2006-10-05 16:54:38.000000000 +0530
@@ -4936,6 +4936,7 @@ static int __devinit snd_hdsp_create(str
 
 	if (request_irq(pci->irq, snd_hdsp_interrupt, IRQF_DISABLED|IRQF_SHARED, "hdsp", (void *)hdsp)) {
 		snd_printk(KERN_ERR "Hammerfall-DSP: unable to use IRQ %d\n", pci->irq);
+		iounmap(hdsp->iobase);
 		return -EBUSY;
 	}
 
@@ -4943,8 +4944,10 @@ static int __devinit snd_hdsp_create(str
 	hdsp->precise_ptr = 1;
 	hdsp->use_midi_tasklet = 1;
 
-	if ((err = snd_hdsp_initialize_memory(hdsp)) < 0)
+	if ((err = snd_hdsp_initialize_memory(hdsp)) < 0) {
+		iounmap(hdsp->iobase);
 		return err;
+	}
 	
 	if (!is_9652 && !is_9632) {
 		/* we wait 2 seconds to let freshly inserted cardbus cards do their hardware init */
@@ -4964,8 +4967,10 @@ static int __devinit snd_hdsp_create(str
 #endif
 			/* no iobox connected, we defer initialization */
 			snd_printk(KERN_INFO "Hammerfall-DSP: card initialization pending : waiting for firmware\n");
-			if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0)
+			if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
+				iounmap(hdsp->iobase);
 				return err;
+			}
 			return 0;
 		} else {
 			snd_printk(KERN_INFO "Hammerfall-DSP: Firmware already present, initializing card.\n");	    
@@ -4976,8 +4981,10 @@ static int __devinit snd_hdsp_create(str
 		}
 	}
 	
-	if ((err = snd_hdsp_enable_io(hdsp)) != 0)
+	if ((err = snd_hdsp_enable_io(hdsp)) != 0) {
+		iounmap(hdsp->iobase);
 		return err;
+	}
 	
 	if (is_9652)
 	        hdsp->io_type = H9652;
@@ -4985,16 +4992,20 @@ static int __devinit snd_hdsp_create(str
 	if (is_9632)
 		hdsp->io_type = H9632;
 
-	if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0)
+	if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
+		iounmap(hdsp->iobase);
 		return err;
+	}
 	
 	snd_hdsp_initialize_channels(hdsp);
 	snd_hdsp_initialize_midi_flush(hdsp);
 
 	hdsp->state |= HDSP_FirmwareLoaded;	
 
-	if ((err = snd_hdsp_create_alsa_devices(card, hdsp)) < 0)
+	if ((err = snd_hdsp_create_alsa_devices(card, hdsp)) < 0) {
+		iounmap(hdsp->iobase);
 		return err;
+	}
 
 	return 0;	
 }


