Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263836AbUDZN6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUDZN6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUDZN6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:58:47 -0400
Received: from mail.convergence.de ([212.84.236.4]:49540 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263836AbUDZNmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:42:19 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 8/9] DVB: Misc. DVB USB driver updates
In-Reply-To: <1082986903219@convergence.de>
Message-Id: <10829869142261@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:42:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] ttusb-dec:
  - Add a parameter to dvb_filter_pes2ts function to specify whether the packet is a payload unit start or not
  - Use the hotplug firmware loader for 2.6 kernels instead of compiling the firmware into the module.
  - Correct the USB id of the DEC3000-s, add basic support
- [DVB] ttusb-budget:
  - Remove spurious discontinuity message when starting streaming
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.5-patched/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- xx-linux-2.6.5/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-04-23 22:02:54.000000000 +0200
@@ -9,7 +9,6 @@
  *	published by the Free Software Foundation; either version 2 of
  *	the License, or (at your option) any later version.
  */
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
@@ -108,9 +107,10 @@
 
 	int insync;
 
-	u16 cc;			/* MuxCounter - will increment on EVERY MUX PACKET */
+	int cc;			/* MuxCounter - will increment on EVERY MUX PACKET */
 	/* (including stuffing. yes. really.) */
 
+
 	u8 last_result[32];
 
 	struct ttusb_channel {
@@ -575,7 +575,7 @@
 
 	cc = (muxpack[len - 4] << 8) | muxpack[len - 3];
 	cc &= 0x7FFF;
-	if (cc != ttusb->cc)
+	if ((cc != ttusb->cc) && (ttusb->cc != -1))
 		printk("%s: cc discontinuity (%d frames missing)\n",
 		       __FUNCTION__, (cc - ttusb->cc) & 0x7FFF);
 	ttusb->cc = (cc + 1) & 0x7FFF;
@@ -787,7 +787,7 @@
 			ttusb_process_frame(ttusb, data, len);
 		}
 	}
-	usb_submit_urb(urb, GFP_ATOMIC);
+	usb_submit_urb(urb, GFP_KERNEL);
 }
 
 static void ttusb_free_iso_urbs(struct ttusb *ttusb)
@@ -852,6 +852,7 @@
 		return 0;
 	}
 
+	ttusb->cc = -1;
 	ttusb->insync = 0;
 	ttusb->mux_state = 0;
 
@@ -864,6 +865,7 @@
 		urb->complete = ttusb_iso_irq;
 		urb->pipe = ttusb->isoc_in_pipe;
 		urb->transfer_flags = URB_ISO_ASAP;
+		urb->interval = 1;
 		urb->number_of_packets = FRAMES_PER_ISO_BUF;
 		urb->transfer_buffer_length =
 		    ISO_FRAME_SIZE * FRAMES_PER_ISO_BUF;
@@ -1008,7 +1010,6 @@
 
 static int ttusb_setup_interfaces(struct ttusb *ttusb)
 {
-	usb_set_configuration(ttusb->dev, 1);
 	usb_set_interface(ttusb->dev, 1, 1);
 
 	ttusb->bulk_out_pipe = usb_sndbulkpipe(ttusb->dev, 1);
@@ -1077,6 +1078,8 @@
 
 	udev = interface_to_usbdev(intf);
 
+        if (intf->altsetting->desc.bInterfaceNumber != 1) return -ENODEV;
+
 	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
 		return -ENOMEM;
 
@@ -1101,8 +1104,7 @@
 
 	up(&ttusb->sem);
 
-	dvb_register_adapter(&ttusb->adapter,
-			     "Technotrend/Hauppauge Nova-USB");
+	dvb_register_adapter(&ttusb->adapter, "Technotrend/Hauppauge Nova-USB", THIS_MODULE);
 
 	dvb_register_i2c_bus(ttusb_i2c_xfer, ttusb, ttusb->adapter, 0);
 	dvb_add_frontend_ioctls(ttusb->adapter, ttusb_lnb_ioctl, NULL,
@@ -1169,9 +1169,6 @@
 
 	ttusb_stop_iso_xfer(ttusb);
 
-#if 0
-	devfs_remove(TTUSB_BUDGET_NAME);
-#endif
 	ttusb->dvb_demux.dmx.close(&ttusb->dvb_demux.dmx);
 	dvb_net_release(&ttusb->dvbnet);
 	dvb_dmxdev_release(&ttusb->dmxdev);
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.5-patched/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- xx-linux-2.6.5/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-04-23 21:58:20.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * TTUSB DEC Driver
  *
- * Copyright (C) 2003 Alex Woods <linux-dvb@giblets.org>
+ * Copyright (C) 2003-2004 Alex Woods <linux-dvb@giblets.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -20,16 +20,19 @@
  */
 
 #include <asm/semaphore.h>
-#include <linux/crc32.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
-#include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
+#if defined(CONFIG_CRC32) || defined(CONFIG_CRC32_MODULE)
+#include <linux/crc32.h>
+#else
+#warning "CRC checking of firmware not available"
+#endif
 #include <linux/init.h>
 
 #include "dmxdev.h"
@@ -99,6 +102,7 @@
 
 	u16			pid[DMX_PES_OTHER];
 	int			hi_band;
+	int			voltage;
 
 	/* USB bits */
 	struct usb_device	*udev;
@@ -205,22 +209,15 @@
 {
 	int result, actual_len, i;
 	u8 *b;
-	u8 *c;
+
+	dprintk("%s\n", __FUNCTION__);
 	
 	b = kmalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
 	if (!b)
 		return -ENOMEM;
-	c = kmalloc(COMMAND_PACKET_SIZE + 4, GFP_KERNEL);
-	if (!c) {
-		kfree(b);
-		return -ENOMEM;
-	}
-
-	dprintk("%s\n", __FUNCTION__);
 
 	if ((result = down_interruptible(&dec->usb_sem))) {
 		kfree(b);
-		kfree(c);
 		printk("%s: Failed to down usb semaphore.\n", __FUNCTION__);
 		return result;
 	}
@@ -248,11 +245,10 @@
 		       __FUNCTION__, result);
 		up(&dec->usb_sem);
 		kfree(b);
-		kfree(c);
 		return result;
 	}
 
-	result = usb_bulk_msg(dec->udev, dec->result_pipe, c,
+	result = usb_bulk_msg(dec->udev, dec->result_pipe, b,
 			      COMMAND_PACKET_SIZE + 4, &actual_len, HZ);
 
 	if (result) {
@@ -260,25 +256,23 @@
 		       __FUNCTION__, result);
 		up(&dec->usb_sem);
 		kfree(b);
-		kfree(c);
 		return result;
 	} else {
 		if (debug) {
 			printk("%s: result: ", __FUNCTION__);
 			for (i = 0; i < actual_len; i++)
-				printk("0x%02X ", c[i]);
+				printk("0x%02X ", b[i]);
 			printk("\n");
 		}
 
 		if (result_length)
-			*result_length = c[3];
-		if (cmd_result && c[3] > 0)
-			memcpy(cmd_result, &c[4], c[3]);
+			*result_length = b[3];
+		if (cmd_result && b[3] > 0)
+			memcpy(cmd_result, &b[4], b[3]);
 
 		up(&dec->usb_sem);
 
 		kfree(b);
-		kfree(c);
 		return 0;
 	}
 }
@@ -1171,9 +1164,10 @@
 	u16 firmware_csum = 0;
 	u16 firmware_csum_ns;
 	u32 firmware_size_nl;
+#if defined(CONFIG_CRC32) || defined(CONFIG_CRC32_MODULE)
 	u32 crc32_csum, crc32_check, tmp;
+#endif
 	const struct firmware *fw_entry = NULL;
-
 	dprintk("%s\n", __FUNCTION__);
 
 	if (request_firmware(&fw_entry, dec->firmware_name, &dec->udev->dev)) {
@@ -1186,7 +1180,7 @@
 	firmware_size = fw_entry->size;
 
 	if (firmware_size < 60) {
-		printk("%s: firmware size too small for DSP code (%zu < 60).\n",
+		printk("%s: firmware size too small for DSP code (%u < 60).\n",
 			__FUNCTION__, firmware_size);
 		return -1;
 	}
@@ -1194,6 +1188,7 @@
 	/* a 32 bit checksum over the first 56 bytes of the DSP Code is stored
 	   at offset 56 of file, so use it to check if the firmware file is
 	   valid. */
+#if defined(CONFIG_CRC32) || defined(CONFIG_CRC32_MODULE)
 	crc32_csum = crc32(~0L, firmware, 56) ^ ~0L;
 	memcpy(&tmp, &firmware[56], 4);
 	crc32_check = htonl(tmp);
@@ -1203,6 +1198,7 @@
 			__FUNCTION__, crc32_csum, crc32_check);
 		return -1;
 	}
+#endif
 	memcpy(idstring, &firmware[36], 20);
 	idstring[20] = '\0';
 	printk(KERN_INFO "ttusb_dec: found DSP code \"%s\".\n", idstring);
@@ -1287,6 +1283,7 @@
 			   give the box */
 			switch (model) {
 			case 0x00070008:
+			case 0x0007000c:
 				ttusb_dec_set_model(dec, TTUSB_DEC3000S);
 				break;
 			case 0x00070009:
@@ -1320,7 +1317,7 @@
 	dprintk("%s\n", __FUNCTION__);
 
 	if ((result = dvb_register_adapter(&dec->adapter,
-					   dec->model_name)) < 0) {
+					   dec->model_name, THIS_MODULE)) < 0) {
 		printk("%s: dvb_register_adapter failed: error %d\n",
 		       __FUNCTION__, result);
 
@@ -1518,10 +1514,6 @@
 		dprintk("%s: FE_INIT\n", __FUNCTION__);
 		break;
 
-	case FE_RESET:
-		dprintk("%s: FE_RESET\n", __FUNCTION__);
-		break;
-
 	default:
 		dprintk("%s: unknown IOCTL (0x%X)\n", __FUNCTION__, cmd);
 		return -EINVAL;
@@ -1591,13 +1582,13 @@
 			   0x00, 0x00, 0x00, 0x00,
 			   0x00, 0x00, 0x00, 0x00,
 			   0x00, 0x00, 0x00, 0x00,
-			   0x00, 0x00, 0x00, 0x0d,
+			   0x00, 0x00, 0x00, 0x00,
 			   0x00, 0x00, 0x00, 0x00,
 			   0x00, 0x00, 0x00, 0x00 };
 			u32 freq;
 			u32 sym_rate;
 			u32 band;
-
+		u32 lnb_voltage;
 
 			dprintk("%s: FE_SET_FRONTEND\n", __FUNCTION__);
 
@@ -1613,6 +1604,8 @@
 			memcpy(&b[12], &sym_rate, sizeof(u32));
 			band = htonl(dec->hi_band ? LOF_HI : LOF_LO);
 			memcpy(&b[24], &band, sizeof(u32));
+		lnb_voltage = htonl(dec->voltage);
+		memcpy(&b[28], &lnb_voltage, sizeof(u32));
 
 			ttusb_dec_send_command(dec, 0x71, sizeof(b), b, NULL, NULL);
 
@@ -1632,10 +1625,6 @@
 		dprintk("%s: FE_INIT\n", __FUNCTION__);
 		break;
 
-	case FE_RESET:
-		dprintk("%s: FE_RESET\n", __FUNCTION__);
-		break;
-
 	case FE_DISEQC_SEND_MASTER_CMD:
 		dprintk("%s: FE_DISEQC_SEND_MASTER_CMD\n", __FUNCTION__);
 		break;
@@ -1653,6 +1642,17 @@
 
 	case FE_SET_VOLTAGE:
 		dprintk("%s: FE_SET_VOLTAGE\n", __FUNCTION__);
+		switch ((fe_sec_voltage_t) arg) {
+		case SEC_VOLTAGE_13:
+			dec->voltage = 13;
+			break;
+		case SEC_VOLTAGE_18:
+			dec->voltage = 18;
+			break;
+		default:
+			return -EINVAL;
+			break;
+		}
 		break;
 
 	default:


