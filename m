Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTLSMby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTLSMby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:31:54 -0500
Received: from mail.convergence.de ([212.84.236.4]:32186 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262878AbTLSM2r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:47 -0500
Subject: [PATCH 10/12] Cleanup patch to remove 2.4 crud
In-Reply-To: <1071836923279@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:45 +0100
Message-Id: <10718369253490@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - cleanup patch
 - remove various LINUX_VERSION_CODE code paths
 - fix compile bug in new bt8xx/Makefile
diff -uNrwB --new-file linux-2.6.0-p2/drivers/media/dvb/bt8xx/bt878.c linux-2.6.0-p3/drivers/media/dvb/bt8xx/bt878.c
--- linux-2.6.0-p2/drivers/media/dvb/bt8xx/bt878.c	2003-12-18 15:10:41.000000000 +0100
+++ linux-2.6.0-p3/drivers/media/dvb/bt8xx/bt878.c	2003-12-18 15:43:01.000000000 +0100
@@ -44,11 +44,7 @@
 #include "dmxdev.h"
 #include "dvbdev.h"
 #include "bt878.h"
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
 #include "dst-bt878.h"
-#else
-#include "../frontends/dst-bt878.h"
-#endif
 
 #include "dvb_functions.h"
 
diff -uNrwB --new-file linux-2.6.0-p2/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.0-p3/drivers/media/dvb/ttpci/budget-ci.c
--- linux-2.6.0-p2/drivers/media/dvb/ttpci/budget-ci.c	2003-12-18 15:10:40.000000000 +0100
+++ linux-2.6.0-p3/drivers/media/dvb/ttpci/budget-ci.c	2003-12-18 15:43:12.000000000 +0100
@@ -35,12 +35,6 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-#include "input_fake.h"
-#endif
-
-
-
 struct budget_ci {
 	struct budget budget;
 	struct input_dev input_dev;
diff -uNrwB --new-file linux-2.6.0-p2/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.0-p3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- linux-2.6.0-p2/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2003-12-18 15:10:40.000000000 +0100
+++ linux-2.6.0-p3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2003-12-18 15:43:27.000000000 +0100
@@ -742,11 +742,7 @@
 	}
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static void ttusb_iso_irq(struct urb *urb)
-#else
 static void ttusb_iso_irq(struct urb *urb, struct pt_regs *ptregs)
-#endif
 {
 	struct ttusb *ttusb = urb->context;
 
@@ -787,9 +783,7 @@
 			ttusb_process_frame(ttusb, data, len);
 		}
 	}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	usb_submit_urb(urb, GFP_ATOMIC);
-#endif
 }
 
 static void ttusb_free_iso_urbs(struct ttusb *ttusb)
@@ -879,13 +873,6 @@
 		}
 	}
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	for (i = 0; i < ISO_BUF_COUNT; i++) {
-		int next = (i + 1) % ISO_BUF_COUNT;
-		ttusb->iso_urb[i]->next = ttusb->iso_urb[next];
-	}
-#endif
-
 	for (i = 0; i < ISO_BUF_COUNT; i++) {
 		if ((err = usb_submit_urb(ttusb->iso_urb[i], GFP_KERNEL))) {
 			ttusb_stop_iso_xfer(ttusb);
@@ -1076,22 +1063,6 @@
 };
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static void *ttusb_probe(struct usb_device *udev, unsigned int ifnum,
-		  const struct usb_device_id *id)
-{
-	struct ttusb *ttusb;
-	int result, channel;
-
-	if (ifnum != 0)
-		return NULL;
-
-	dprintk("%s: TTUSB DVB connected\n", __FUNCTION__);
-
-	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
-		return NULL;
-
-#else
 static int ttusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev;
@@ -1105,8 +1076,6 @@
 	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
 		return -ENOMEM;
 
-#endif
-
 	memset(ttusb, 0, sizeof(struct ttusb));
 
 	for (channel = 0; channel < TTUSB_MAXCHANNEL; ++channel) {
@@ -1180,35 +1149,22 @@
 			   S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP
 			   | S_IROTH | S_IWOTH, &stc_fops, ttusb);
 #endif
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	return (void *) ttusb;
-#else
+
 	usb_set_intfdata(intf, (void *) ttusb);
 
 	return 0;
-#endif
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static void ttusb_disconnect(struct usb_device *udev, void *data)
-{
-	struct ttusb *ttusb = data;
-#else
 static void ttusb_disconnect(struct usb_interface *intf)
 {
 	struct ttusb *ttusb = usb_get_intfdata(intf);
 
 	usb_set_intfdata(intf, NULL);
-#endif
 
 	ttusb->disconnecting = 1;
 
 	ttusb_stop_iso_xfer(ttusb);
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,69))
-#undef devfs_remove
-#define devfs_remove(x)	devfs_unregister(ttusb->stc_devfs_handle);
-#endif
 #if 0
 	devfs_remove(TTUSB_BUDGET_NAME);
 #endif
diff -uNrwB --new-file linux-2.6.0-p2/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.mod.c linux-2.6.0-p3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.mod.c
--- linux-2.6.0-p2/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.mod.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.mod.c	2003-12-18 15:43:27.000000000 +0100
@@ -0,0 +1,14 @@
+#include <linux/module.h>
+#include <linux/vermagic.h>
+#include <linux/compiler.h>
+
+MODULE_INFO(vermagic, VERMAGIC_STRING);
+
+static const char __module_depends[]
+__attribute_used__
+__attribute__((section(".modinfo"))) =
+"depends=dvb-core";
+
+MODULE_ALIAS("usb:v0B48p1003dl*dh*dc*dsc*dp*ic*isc*ip*");
+MODULE_ALIAS("usb:v0B48p1004dl*dh*dc*dsc*dp*ic*isc*ip*");
+MODULE_ALIAS("usb:v0B48p1005dl*dh*dc*dsc*dp*ic*isc*ip*");
diff -uNrwB --new-file linux-2.6.0-p2/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.0-p3/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.0-p2/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2003-12-18 15:10:40.000000000 +0100
+++ linux-2.6.0-p3/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2003-12-18 15:43:33.000000000 +0100
@@ -28,9 +28,7 @@
 #include <linux/usb.h>
 #include <linux/version.h>
 #include <linux/interrupt.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 #include <linux/firmware.h>
-#endif
 
 #include "dmxdev.h"
 #include "dvb_demux.h"
@@ -473,11 +471,7 @@
 	}
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static void ttusb_dec_process_urb(struct urb *urb)
-#else
 static void ttusb_dec_process_urb(struct urb *urb, struct pt_regs *ptregs)
-#endif
 {
 	struct ttusb_dec *dec = urb->context;
 
@@ -485,11 +479,8 @@
 		int i;
 
 		for (i = 0; i < FRAMES_PER_ISO_BUF; i++) {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-			struct iso_packet_descriptor *d;
-#else
 			struct usb_iso_packet_descriptor *d;
-#endif
+
 			u8 *b;
 			int length;
 			struct urb_frame *frame;
@@ -522,10 +513,8 @@
 				urb->status);
 	}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	if (dec->iso_stream_count)
 		usb_submit_urb(urb, GFP_ATOMIC);
-#endif
 }
 
 static void ttusb_dec_setup_urbs(struct ttusb_dec *dec)
@@ -542,12 +531,9 @@
 		urb->context = dec;
 		urb->complete = ttusb_dec_process_urb;
 		urb->pipe = dec->stream_pipe;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 		urb->transfer_flags = URB_ISO_ASAP;
 		urb->interval = 1;
-#else
-		urb->transfer_flags = USB_ISO_ASAP;
-#endif
+
 		urb->number_of_packets = FRAMES_PER_ISO_BUF;
 		urb->transfer_buffer_length = ISO_FRAME_SIZE *
 					      FRAMES_PER_ISO_BUF;
@@ -614,12 +600,8 @@
 		ttusb_dec_setup_urbs(dec);
 
 		for (i = 0; i < ISO_BUF_COUNT; i++) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 			if ((result = usb_submit_urb(dec->iso_urb[i],
 						     GFP_ATOMIC))) {
-#else
-			if ((result = usb_submit_urb(dec->iso_urb[i]))) {
-#endif
 				printk("%s: failed urb submission %d: "
 				       "error %d\n", __FUNCTION__, i, result);
 
@@ -641,10 +623,6 @@
 
 	up(&dec->iso_sem);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	ttusb_dec_set_streaming_interface(dec);
-#endif
-
 	return 0;
 }
 
@@ -775,11 +753,7 @@
 	for (i = 0; i < ISO_BUF_COUNT; i++) {
 		struct urb *urb;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 		if (!(urb = usb_alloc_urb(FRAMES_PER_ISO_BUF, GFP_ATOMIC))) {
-#else
-		if (!(urb = usb_alloc_urb(FRAMES_PER_ISO_BUF))) {
-#endif
 			ttusb_dec_free_iso_urbs(dec);
 			return -ENOMEM;
 		}
@@ -789,13 +763,6 @@
 
 	ttusb_dec_setup_urbs(dec);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	for (i = 0; i < ISO_BUF_COUNT; i++) {
-		int next = (i + 1) % ISO_BUF_COUNT;
-		dec->iso_urb[i]->next = dec->iso_urb[next];
-	}
-#endif
-
 	return 0;
 }
 
@@ -831,11 +798,6 @@
 	ttusb_dec_alloc_iso_urbs(dec);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include "dsp_dec2000t.h"
-#include "dsp_dec3000s.h"
-#endif
-
 static int ttusb_dec_boot_dsp(struct ttusb_dec *dec)
 {
 	int i, j, actual_len, result, size, trans_count;
@@ -848,13 +810,10 @@
 	u32 firmware_csum = 0;
 	u32 firmware_size_nl;
 	u32 firmware_csum_nl;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	const struct firmware *fw_entry = NULL;
-#endif
 
 	dprintk("%s\n", __FUNCTION__);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 	if (request_firmware(&fw_entry, dec->firmware_name, &dec->udev->dev)) {
 		printk(KERN_ERR "%s: Firmware (%s) unavailable.\n",
 		       __FUNCTION__, dec->firmware_name);
@@ -863,21 +822,13 @@
 
 	firmware = fw_entry->data;
 	firmware_size = fw_entry->size;
-#endif
+
 	switch (dec->model) {
 		case TTUSB_DEC2000T:
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-			firmware = &dsp_dec2000t[0];
-			firmware_size = sizeof(dsp_dec2000t);
-#endif
 			firmware_csum = 0x1bc86100;
 			break;
 
 		case TTUSB_DEC3000S:
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-			firmware = &dsp_dec3000s[0];
-			firmware_size = sizeof(dsp_dec3000s);
-#endif
 			firmware_csum = 0x00000000;
 			break;
 	}
@@ -1313,22 +1264,6 @@
 	dvb_unregister_frontend(dec->frontend_ioctl, &dec->i2c_bus);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static void *ttusb_dec_probe(struct usb_device *udev, unsigned int ifnum,
-			     const struct usb_device_id *id)
-{
-	struct ttusb_dec *dec;
-
-	dprintk("%s\n", __FUNCTION__);
-
-	if (ifnum != 0)
-		return NULL;
-
-	if (!(dec = kmalloc(sizeof(struct ttusb_dec), GFP_KERNEL))) {
-		printk("%s: couldn't allocate memory.\n", __FUNCTION__);
-		return NULL;
-	}
-#else
 static int ttusb_dec_probe(struct usb_interface *intf,
 			   const struct usb_device_id *id)
 {
@@ -1345,7 +1280,6 @@
 	}
 
 	usb_set_intfdata(intf, (void *)dec);
-#endif
 
 	memset(dec, 0, sizeof(struct ttusb_dec));
 
@@ -1377,26 +1311,16 @@
 
 	dec->active = 1;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	return (void *)dec;
-#else
 	ttusb_dec_set_streaming_interface(dec);
 
 	return 0;
-#endif
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static void ttusb_dec_disconnect(struct usb_device *udev, void *data)
-{
-	struct ttusb_dec *dec = data;
-#else
 static void ttusb_dec_disconnect(struct usb_interface *intf)
 {
 	struct ttusb_dec *dec = usb_get_intfdata(intf);
 
 	usb_set_intfdata(intf, NULL);
-#endif
 
 	dprintk("%s\n", __FUNCTION__);
 
diff -uNrwB --new-file linux-2.6.0-p2/drivers/media/dvb/ttusb-dec/ttusb_dec.mod.c linux-2.6.0-p3/drivers/media/dvb/ttusb-dec/ttusb_dec.mod.c
--- linux-2.6.0-p2/drivers/media/dvb/ttusb-dec/ttusb_dec.mod.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-p3/drivers/media/dvb/ttusb-dec/ttusb_dec.mod.c	2003-12-18 15:43:33.000000000 +0100
@@ -0,0 +1,13 @@
+#include <linux/module.h>
+#include <linux/vermagic.h>
+#include <linux/compiler.h>
+
+MODULE_INFO(vermagic, VERMAGIC_STRING);
+
+static const char __module_depends[]
+__attribute_used__
+__attribute__((section(".modinfo"))) =
+"depends=dvb-core";
+
+MODULE_ALIAS("usb:v0B48p1006dl*dh*dc*dsc*dp*ic*isc*ip*");
+MODULE_ALIAS("usb:v0B48p1008dl*dh*dc*dsc*dp*ic*isc*ip*");
diff -uNrwB --new-file linux-2.6.0.p/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6.0.p2/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- linux-2.6.0.p/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2003-12-18 19:56:34.000000000 +0100
+++ linux-2.6.0.p2/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2003-12-18 19:58:46.000000000 +0100
@@ -179,40 +179,6 @@
 	return 0;
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-/* with 2.6.x not needed thanks to the driver model + sysfs */
-
-extern struct i2c_adapter *bttv_get_i2c_adap(unsigned int card);
-
-static void __init dvb_bt8xx_get_adaps(void)
-{
-	struct dvb_bt8xx_card *card;
-	struct list_head *entry, *entry_safe;
-
-	list_for_each_safe(entry, entry_safe, &card_list) {
-		card = list_entry(entry, struct dvb_bt8xx_card, list);
-		card->i2c_adapter =  bttv_get_i2c_adap(card->bttv_nr);
-		if (!card->i2c_adapter) {
-			printk("dvb_bt8xx: unable to determine i2c adaptor of card %d, deleting\n", card->bttv_nr);
-
-			list_del(&card->list);
-			kfree(card);
-		}
-	}
-}
-
-static void dvb_bt8xx_i2c_adap_free(struct i2c_adapter *adap)
-{
-}
-
-static void __exit dvb_bt8xx_exit_adaps(void)
-{
-}
-
-#else
-
-/* More complicated. but cleaner better */
-
 static struct dvb_bt8xx_card *dvb_bt8xx_find_by_i2c_adap(struct i2c_adapter *adap)
 {
 	struct dvb_bt8xx_card *card;
@@ -308,7 +274,6 @@
 {
 	i2c_del_driver(&dvb_bt8xx_driver);
 }
-#endif
 
 static int __init dvb_bt8xx_load_card( struct dvb_bt8xx_card *card)
 {
diff -uNrwB --new-file linux-2.6.0.p/drivers/media/dvb/frontends/dst-bt878.h linux-2.6.0.p2/drivers/media/dvb/frontends/dst-bt878.h
--- linux-2.6.0.p/drivers/media/dvb/frontends/dst-bt878.h	2003-12-18 19:56:34.000000000 +0100
+++ linux-2.6.0.p2/drivers/media/dvb/frontends/dst-bt878.h	2003-12-18 19:59:02.000000000 +0100
@@ -1,3 +1,8 @@
+/*
+ * dst-bt878.h: part of the DST driver for the TwinHan DST Frontend
+ *
+ * Copyright (C) 2003 Jamie Honan
+ */
 
 struct dst_gpio_enable {
 	u32	mask;
@@ -27,7 +32,6 @@
 
 struct bt878 ;
 
-int
-bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp);
+int bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp);
 
 struct bt878 *bt878_find_by_dvb_adap(struct dvb_adapter *adap);
diff -ura linux-2.6.0/drivers/media/dvb/bt8xx/Makefile linux-2.6.0.p/drivers/media/dvb/bt8xx/Makefile
--- linux-2.6.0/drivers/media/dvb/bt8xx/Makefile	2003-12-19 10:57:46.000000000 +0100
+++ linux-2.6.0.p/drivers/media/dvb/bt8xx/Makefile	2003-12-19 10:57:31.000000000 +0100
@@ -1,5 +1,5 @@
 
 obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o
 
-EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video
+EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video -Idrivers/media/dvb/frontends
 

