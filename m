Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbUJ0J7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbUJ0J7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUJ0J6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:58:49 -0400
Received: from mail.convergence.de ([212.227.36.84]:30622 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262353AbUJ0Jvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:51:49 -0400
Message-ID: <417F6F87.5090703@linuxtv.org>
Date: Wed, 27 Oct 2004 11:51:03 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2/5] DVB: misc. updates to the dvb-core
References: <417F6EB2.2070807@linuxtv.org> <417F6F0D.9020109@linuxtv.org>
In-Reply-To: <417F6F0D.9020109@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------090201080409000409090608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201080409000409090608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------090201080409000409090608
Content-Type: text/plain;
 name="02-dvb-misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-dvb-misc.diff"

- [DVB] ttusb_dec: add new 2000T type model number
- [DVB] dvb_ca_en50221: properly zero out private pointer
- [DVB] dvb-bt8xx: properly use a mutex when starting/stopping the dma engine, remove card list, it's not need anymore
- [DVB] bt878: fix hex <=> dec typo (missing 0x prefix), mark remove bt878_remove() function __devexit_p
- [DVB] dvb-core: add dvb_net_debug module parameter, remove some dead code

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc1/Documentation/dvb/readme.txt linux-2.6.10-rc1-patched/Documentation/dvb/readme.txt
--- linux-2.6.10-rc1/Documentation/dvb/readme.txt	2004-10-25 14:03:49.000000000 +0200
+++ linux-2.6.10-rc1-patched/Documentation/dvb/readme.txt	2004-10-25 14:14:41.000000000 +0200
@@ -41,9 +41,9 @@
 various bt8xx based "budget" DVB cards
 (Nebula, Pinnacle PCTV, Twinhan DST)
 
-"vp7041.txt"
-contains detailed informations about the
-Visionplus VisionDTV USB-Ter DVB-T adapter.
+"README.dibusb"
+contains detailed information about adapters
+based on DiBcom reference design.
 
 "udev.txt"
 how to get DVB and udev up and running.
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.10-rc1-patched/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.10-rc1/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-10-25 14:07:50.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-10-25 14:14:44.000000000 +0200
@@ -1293,6 +1293,7 @@
 				ttusb_dec_set_model(dec, TTUSB_DEC3000S);
 				break;
 			case 0x00070009:
+			case 0x00070013:
 				ttusb_dec_set_model(dec, TTUSB_DEC2000T);
 				break;
 			case 0x00070011:
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/frontends/grundig_29504-401.c linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/grundig_29504-401.c
--- linux-2.6.10-rc1/drivers/media/dvb/frontends/grundig_29504-401.c	2004-10-25 14:07:57.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/grundig_29504-401.c	2004-10-25 14:14:43.000000000 +0200
@@ -4,7 +4,7 @@
 
     Copyright (C) 2001 Holger Waechtler <holger@convergence.de>
                        for Convergence Integrated Media GmbH
-                       Marko Kohtala <marko.kohtala@nokia.com>
+                       Marko Kohtala <marko.kohtala@luukku.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c linux-2.6.10-rc1-patched/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
--- linux-2.6.10-rc1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-10-25 14:07:54.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-10-25 14:14:42.000000000 +0200
@@ -1500,6 +1499,7 @@
 };
 
 static struct dvb_device dvbdev_ca = {
+        .priv	= NULL,
 	.users	= 1,
 	.readers= 1,
 	.writers= 1,
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6.10-rc1-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- linux-2.6.10-rc1/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-10-25 14:07:49.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-10-25 14:14:41.000000000 +0200
@@ -68,20 +68,21 @@
 {
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 	struct dvb_bt8xx_card *card = dvbdmx->priv;
+	int rc;
 
 	dprintk("dvb_bt8xx: start_feed\n");
 	
 	if (!dvbdmx->dmx.frontend)
 		return -EINVAL;
 
-	if (card->active)
-		return 0;
-		
-	card->active = 1;
-	
-//	bt878_start(card->bt, card->gpio_mode);
-
-	return 0;
+	down(&card->lock);
+	card->nfeeds++;
+	rc = card->nfeeds;
+	if (card->nfeeds == 1)
+		bt878_start(card->bt, card->gpio_mode,
+			    card->op_sync_orin, card->irq_err_ignore);
+	up(&card->lock);
+	return rc;
 }
 
 static int dvb_bt8xx_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
@@ -94,12 +95,11 @@
 	if (!dvbdmx->dmx.frontend)
 		return -EINVAL;
 		
-	if (!card->active)
-		return 0;
-
-//	bt878_stop(card->bt);
-
-	card->active = 0;
+	down(&card->lock);
+	card->nfeeds--;
+	if (card->nfeeds == 0)
+		bt878_stop(card->bt);
+	up(&card->lock);
 
 	return 0;
 }
@@ -207,8 +207,6 @@
 
 	tasklet_init(&card->bt->tasklet, dvb_bt8xx_task, (unsigned long) card);
 	
-	bt878_start(card->bt, card->gpio_mode, card->op_sync_orin, card->irq_err_ignore);
-
 	return 0;
 }
 
@@ -223,6 +221,7 @@
 		return -ENOMEM;
 
 	memset(card, 0, sizeof(*card));
+	init_MUTEX(&card->lock);
 	card->bttv_nr = sub->core->nr;
 	strncpy(card->card_name, sub->core->name, sizeof(sub->core->name));
 	card->i2c_adapter = &sub->core->i2c_adap;
@@ -230,6 +229,9 @@
 	switch(sub->core->type)
 	{
 	case BTTV_PINNACLESAT:
+#ifdef BTTV_DVICO_DVBT_LITE
+	case BTTV_DVICO_DVBT_LITE:
+#endif
 		card->gpio_mode = 0x0400C060;
 		card->op_sync_orin = 0;
 		card->irq_err_ignore = 0;
@@ -287,7 +289,10 @@
 	}
 
 	if (!(card->bt = dvb_bt8xx_878_match(card->bttv_nr, bttv_pci_dev))) {
-		printk("dvb_bt8xx: unable to determine DMA core of card %d\n", card->bttv_nr);
+		printk("dvb_bt8xx: unable to determine DMA core of card %d,\n",
+		       card->bttv_nr);
+		printk("dvb_bt8xx: if you have the ALSA bt87x audio driver "
+		       "installed, try removing it.\n");
 
 		kfree(card);
 		return -EFAULT;
@@ -321,7 +326,6 @@
 		dvb_dmx_release(&card->demux);
 		dvb_unregister_adapter(card->dvb_adapter);
 		
-		list_del(&card->list);
 		kfree(card);
 
 	return 0;
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/bt8xx/dvb-bt8xx.h linux-2.6.10-rc1-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.h
--- linux-2.6.10-rc1/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2004-10-25 14:07:49.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2004-10-25 14:14:41.000000000 +0200
@@ -28,8 +28,8 @@
 #include "bttv.h"
 
 struct dvb_bt8xx_card {
-	struct list_head list;
-	u8 active;
+	struct semaphore lock;
+	int nfeeds;
 	char card_name[32];
 	struct dvb_adapter *dvb_adapter;
 	struct bt878 *bt;

diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/bt8xx/bt878.c linux-2.6.10-rc1-patched/drivers/media/dvb/bt8xx/bt878.c
--- linux-2.6.10-rc1/drivers/media/dvb/bt8xx/bt878.c	2004-10-25 14:07:49.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/bt8xx/bt878.c	2004-10-25 14:14:41.000000000 +0200
@@ -511,7 +511,7 @@
 		printk("bt878(%d): unloading\n", bt->nr);
 
 	/* turn off all capturing, DMA and IRQs */
-	btand(~13, BT878_AGPIO_DMA_CTL);
+	btand(~0x13, BT878_AGPIO_DMA_CTL);
 
 	/* first disable interrupts before unmapping the memory! */
 	btwrite(0, BT878_AINT_MASK);
@@ -554,7 +554,7 @@
       .name 	= "bt878",
       .id_table = bt878_pci_tbl,
       .probe 	= bt878_probe,
-      .remove 	= __devexit_p(bt878_remove),
+      .remove 	= bt878_remove,
 };
 
 static int bt878_pci_driver_registered = 0;
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/dvb-core/dvb_net.c linux-2.6.10-rc1-patched/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.6.10-rc1/drivers/media/dvb/dvb-core/dvb_net.c	2004-10-25 14:07:55.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/dvb-core/dvb_net.c	2004-10-25 14:14:43.000000000 +0200
@@ -37,10 +37,18 @@
 #include <linux/uio.h>
 #include <asm/uaccess.h>
 #include <linux/crc32.h>
+#include <linux/version.h>
 
 #include "dvb_demux.h"
 #include "dvb_net.h"
 
+static int dvb_net_debug;
+module_param(dvb_net_debug, int, 0444);
+MODULE_PARM_DESC(dvb_net_debug, "enable debug messages");
+
+#define dprintk(x...) do { if (dvb_net_debug) printk(x); } while (0)
+
+
 static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 {
 	unsigned int j;
@@ -50,13 +58,6 @@
 }
 
 
-#if 1
-#define dprintk(x...) printk(x)
-#else
-#define dprintk(x...)
-#endif
-
-
 #define DVB_NET_MULTICAST_MAX 10
 
 #define isprint(c)	((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9'))
@@ -917,14 +922,6 @@
 }
 
 
-static int dvb_net_set_config(struct net_device *dev, struct ifmap *map)
-{
-	if (netif_running(dev))
-		return -EBUSY;
-	return 0;
-}
-
-
 static void wq_restart_net_feed (void *data)
 {
 	struct net_device *dev = data;
@@ -983,7 +979,6 @@
 	dev->hard_start_xmit	= dvb_net_tx;
 	dev->get_stats		= dvb_net_get_stats;
 	dev->set_multicast_list = dvb_net_set_multicast_list;
-	dev->set_config         = dvb_net_set_config;
 	dev->set_mac_address    = dvb_net_set_mac;
 	dev->mtu		= 4096;
 	dev->mc_count           = 0;

--------------090201080409000409090608--
