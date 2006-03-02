Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWCBXJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWCBXJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWCBXJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:09:27 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:31669 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751161AbWCBXJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:26 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 2/9] mpu401: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:22 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.22977.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/sound/drivers/mpu401/mpu401.c
===================================================================
--- work-mm4.orig/sound/drivers/mpu401/mpu401.c	2006-02-01 16:24:33.000000000 -0700
+++ work-mm4/sound/drivers/mpu401/mpu401.c	2006-02-14 16:50:34.000000000 -0700
@@ -59,7 +59,8 @@
 MODULE_PARM_DESC(irq, "IRQ # for MPU-401 device.");
 
 static struct platform_device *platform_devices[SNDRV_CARDS];
-static int pnp_registered = 0;
+static int pnp_registered;
+static unsigned int snd_mpu401_devices;
 
 static int snd_mpu401_create(int dev, struct snd_card **rcard)
 {
@@ -197,6 +198,7 @@
 		}
 		snd_card_set_dev(card, &pnp_dev->dev);
 		pnp_set_drvdata(pnp_dev, card);
+		snd_mpu401_devices++;
 		++dev;
 		return 0;
 	}
@@ -234,12 +236,11 @@
 
 static int __init alsa_card_mpu401_init(void)
 {
-	int i, err, devices;
+	int i, err;
 
 	if ((err = platform_driver_register(&snd_mpu401_driver)) < 0)
 		return err;
 
-	devices = 0;
 	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
 		struct platform_device *device;
 #ifdef CONFIG_PNP
@@ -253,14 +254,13 @@
 			goto errout;
 		}
 		platform_devices[i] = device;
-		devices++;
+		snd_mpu401_devices++;
 	}
-	if ((err = pnp_register_driver(&snd_mpu401_pnp_driver)) >= 0) {
+	err = pnp_register_driver(&snd_mpu401_pnp_driver);
+	if (!err)
 		pnp_registered = 1;
-		devices += err;
-	}
 
-	if (!devices) {
+	if (!snd_mpu401_devices) {
 #ifdef MODULE
 		printk(KERN_ERR "MPU-401 device not found or device busy\n");
 #endif
