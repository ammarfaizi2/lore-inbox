Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVCVCgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVCVCgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVCVCfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:35:33 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:54667 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262353AbVCVBgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:32 -0500
Message-Id: <20050322013458.545671000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:04 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttusb-dec-ir.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 31/48] ttusb_dec: IR support
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add IR support added by Peter Beutner

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 ttusb_dec.c |  153 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 150 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-dec/ttusb_dec.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-03-22 00:15:50.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-03-22 00:18:46.000000000 +0100
@@ -2,6 +2,7 @@
  * TTUSB DEC Driver
  *
  * Copyright (C) 2003-2004 Alex Woods <linux-dvb@giblets.org>
+ * IR support by Peter Beutner <p.beutner@gmx.net>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -32,6 +33,7 @@
 #include <linux/firmware.h>
 #include <linux/crc32.h>
 #include <linux/init.h>
+#include <linux/input.h>
 
 #include "dmxdev.h"
 #include "dvb_demux.h"
@@ -42,11 +44,14 @@
 
 static int debug;
 static int output_pva;
+static int enable_rc;
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off debugging (default:off).");
 module_param(output_pva, int, 0444);
 MODULE_PARM_DESC(output_pva, "Output PVA from dvr device (default:off)");
+module_param(enable_rc, int, 0644);
+MODULE_PARM_DESC(enable_rc, "Turn on/off IR remote control(default: off)");
 
 #define dprintk	if (debug) printk
 
@@ -56,9 +61,11 @@ MODULE_PARM_DESC(output_pva, "Output PVA
 #define RESULT_PIPE		0x84
 #define IN_PIPE			0x88
 #define OUT_PIPE		0x07
+#define IRQ_PIPE		0x8A
 
 #define COMMAND_PACKET_SIZE	0x3c
 #define ARM_PACKET_SIZE		0x1000
+#define IRQ_PACKET_SIZE		0x8
 
 #define ISO_BUF_COUNT		0x04
 #define FRAMES_PER_ISO_BUF	0x04
@@ -107,9 +114,13 @@ struct ttusb_dec {
 	unsigned int			result_pipe;
 	unsigned int			in_pipe;
 	unsigned int			out_pipe;
+	unsigned int			irq_pipe;
 	enum ttusb_dec_interface	interface;
 	struct semaphore		usb_sem;
 
+	void			*irq_buffer;
+	struct urb		*irq_urb;
+	dma_addr_t		irq_dma_handle;
 	void			*iso_buffer;
 	dma_addr_t		iso_dma_handle;
 	struct urb		*iso_urb[ISO_BUF_COUNT];
@@ -142,6 +153,8 @@ struct ttusb_dec {
 	struct list_head	filter_info_list;
 	spinlock_t		filter_info_list_lock;
 
+	struct input_dev	rc_input_dev;
+
 	int			active; /* Loaded successfully */
 };
 
@@ -157,9 +170,83 @@ struct filter_info {
 	struct list_head	filter_info_list;
 };
 
+const uint16_t  rc_keys[] = {
+	KEY_POWER,
+	KEY_MUTE,
+	KEY_1,
+	KEY_2,
+	KEY_3,
+	KEY_4,
+	KEY_5,
+	KEY_6,
+	KEY_7,
+	KEY_8,
+	KEY_9,
+	KEY_0,
+	KEY_CHANNELUP,
+	KEY_VOLUMEDOWN,
+	KEY_OK,
+	KEY_VOLUMEUP,
+	KEY_CHANNELDOWN,
+	KEY_PREVIOUS,
+	KEY_ESC,
+	KEY_RED,
+	KEY_GREEN,
+	KEY_YELLOW,
+	KEY_BLUE,
+	KEY_OPTION,
+	KEY_M,
+	KEY_RADIO
+};
+
 static void ttusb_dec_set_model(struct ttusb_dec *dec,
 				enum ttusb_dec_model model);
 
+static void ttusb_dec_handle_irq( struct urb *urb, struct pt_regs *regs)
+{
+	struct ttusb_dec * dec = urb->context;
+	char *buffer = dec->irq_buffer;
+	int retval;
+
+	switch(urb->status) {
+		case 0: /*success*/
+			break;
+		case -ECONNRESET:
+		case -ENOENT:
+		case -ESHUTDOWN:
+		case -ETIMEDOUT:
+			/* this urb is dead, cleanup */
+			dprintk("%s:urb shutting down with status: %d\n",
+					__FUNCTION__, urb->status);
+			return;
+		default:
+			dprintk("%s:nonzero status received: %d\n",
+					__FUNCTION__,urb->status);
+			goto exit;
+	}
+
+	if( (buffer[0] == 0x1) && (buffer[2] == 0x15) )  {
+		/* IR - Event */
+		/* this is an fact a bit too simple implementation;
+		 * the box also reports a keyrepeat signal
+		 * (with buffer[3] == 0x40) in an intervall of ~100ms.
+		 * But to handle this correctly we had to imlemenent some
+		 * kind of timer which signals a 'key up' event if no
+		 * keyrepeat signal is recieved for lets say 200ms.
+		 * this should/could be added later ...
+		 * for now lets report each signal as a key down and up*/
+		dprintk("%s:rc signal:%d\n", __FUNCTION__, buffer[4]);
+		input_report_key(&dec->rc_input_dev,rc_keys[buffer[4]-1],1);
+		input_report_key(&dec->rc_input_dev,rc_keys[buffer[4]-1],0);
+		input_sync(&dec->rc_input_dev);
+	}
+
+exit:	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if(retval)
+		printk("%s - usb_commit_urb failed with result: %d\n",
+			__FUNCTION__, retval);
+}
+
 static u16 crc16(u16 crc, const u8 *buf, size_t len)
 {
 	u16 tmp;
@@ -1095,6 +1182,30 @@ static void ttusb_dec_init_tasklet(struc
 		     (unsigned long)dec);
 }
 
+static void ttusb_init_rc( struct ttusb_dec *dec)
+{
+	u8 b[] = { 0x00, 0x01 };
+	int i;
+
+	init_input_dev(&dec->rc_input_dev);
+
+	dec->rc_input_dev.name = "ttusb_dec remote control";
+	dec->rc_input_dev.evbit[0] = BIT(EV_KEY);
+	dec->rc_input_dev.keycodesize = sizeof(unsigned char);
+	dec->rc_input_dev.keycodemax = KEY_MAX;
+
+	 for (i = 0; i < sizeof(rc_keys)/sizeof(rc_keys[0]); i++)
+                set_bit(rc_keys[i], dec->rc_input_dev.keybit);
+
+	input_register_device(&dec->rc_input_dev);
+
+	if(usb_submit_urb(dec->irq_urb,GFP_KERNEL)) {
+		printk("%s: usb_submit_urb failed\n",__FUNCTION__);
+	}
+	/* enable irq pipe */
+	ttusb_dec_send_command(dec,0xb0,sizeof(b),b,NULL,NULL);
+}
+
 static void ttusb_dec_init_v_pes(struct ttusb_dec *dec)
 {
 	dprintk("%s\n", __FUNCTION__);
@@ -1105,7 +1216,7 @@ static void ttusb_dec_init_v_pes(struct 
 	dec->v_pes[3] = 0xe0;
 }
 
-static void ttusb_dec_init_usb(struct ttusb_dec *dec)
+static int ttusb_dec_init_usb(struct ttusb_dec *dec)
 {
 	dprintk("%s\n", __FUNCTION__);
 
@@ -1116,8 +1227,26 @@ static void ttusb_dec_init_usb(struct tt
 	dec->result_pipe = usb_rcvbulkpipe(dec->udev, RESULT_PIPE);
 	dec->in_pipe = usb_rcvisocpipe(dec->udev, IN_PIPE);
 	dec->out_pipe = usb_sndisocpipe(dec->udev, OUT_PIPE);
+	dec->irq_pipe = usb_rcvintpipe(dec->udev, IRQ_PIPE);
+
+	if(enable_rc) {
+		dec->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
+		if(!dec->irq_urb) {
+			return -ENOMEM;
+		}
+		dec->irq_buffer = usb_buffer_alloc(dec->udev,IRQ_PACKET_SIZE,
+					SLAB_ATOMIC, &dec->irq_dma_handle);
+		if(!dec->irq_buffer) {
+			return -ENOMEM;
+		}
+		usb_fill_int_urb(dec->irq_urb, dec->udev,dec->irq_pipe,
+				 dec->irq_buffer, IRQ_PACKET_SIZE,
+				 ttusb_dec_handle_irq, dec, 1);
+		dec->irq_urb->transfer_dma = dec->irq_dma_handle;
+		dec->irq_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	}
 
-	ttusb_dec_alloc_iso_urbs(dec);
+	return ttusb_dec_alloc_iso_urbs(dec);
 }
 
 static int ttusb_dec_boot_dsp(struct ttusb_dec *dec)
@@ -1381,6 +1510,20 @@ static void ttusb_dec_exit_usb(struct tt
 		usb_kill_urb(dec->iso_urb[i]);
 
 	ttusb_dec_free_iso_urbs(dec);
+
+	if(enable_rc) {
+		/* we have to check whether the irq URB is already submitted.
+		 * As the irq is submitted after the interface is changed,
+		 * this is the best method i figured out.
+		 * Any other possibilities?*/
+		if(dec->interface == TTUSB_DEC_INTERFACE_IN)
+			usb_kill_urb(dec->irq_urb);
+
+		usb_free_urb(dec->irq_urb);
+
+		usb_buffer_free(dec->udev,IRQ_PACKET_SIZE,
+					dec->irq_buffer, dec->irq_dma_handle);
+	}
 }
 
 static void ttusb_dec_exit_tasklet(struct ttusb_dec *dec)
@@ -1462,7 +1605,8 @@ static int ttusb_dec_probe(struct usb_in
 
 	dec->udev = udev;
 
-	ttusb_dec_init_usb(dec);
+	if (ttusb_dec_init_usb(dec))
+		return 0;
 	if (ttusb_dec_init_stb(dec)) {
 		ttusb_dec_exit_usb(dec);
 		return 0;
@@ -1502,6 +1646,9 @@ static int ttusb_dec_probe(struct usb_in
 
 	ttusb_dec_set_interface(dec, TTUSB_DEC_INTERFACE_IN);
 
+	if(enable_rc)
+		ttusb_init_rc(dec);
+
 	return 0;
 }
 

--

