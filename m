Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbUBWVPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbUBWVNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:13:14 -0500
Received: from mail.convergence.de ([212.84.236.4]:48618 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261989AbUBWVFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:05:00 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 9/9] TTUSB-Budget DVB driver update
In-Reply-To: <10775702853317@convergence.de>
Message-Id: <10775702863321@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:05:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] dvb-ttusb-budget: Fixed i2c code to detect nearly all errors
- [DVB] dvb-ttusb-budget: Added "V 2.1" to prevent warning message on driver load
- [DVB] dvb-ttusb-budget: Some printks turned into dprintks
- [DVB] dvb-ttusb-budget: Removed __initdata. It is now possible in kernel 2.6 to compile the DVB drivers into a monolithic kernel.
- [DVB] dvb-ttusb-budget: Fix for failing urb submission under 2.6 kernels
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.3.p/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- xx-linux-2.6.3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-01-09 09:22:40.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-02-02 19:28:30.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/dvb/dmx.h>
 #include <linux/pci.h>
 
+#include "dvb_usb_compat.h"
 #include "dvb_functions.h"
 
 /*
@@ -223,6 +224,9 @@
 
 	err = ttusb_result(ttusb, b, 0x20);
 
+        /* check if the i2c transaction was successful */
+        if ((snd_len != b[5]) || (rcv_len != b[6])) return -EREMOTEIO;
+
 	if (rcv_len > 0) {
 
 		if (err || b[0] != 0x55 || b[1] != id) {
@@ -273,7 +277,7 @@
 				    snd_buf, snd_len, rcv_buf, rcv_len);
 
 		if (err < rcv_len) {
-			printk("%s: i == %i\n", __FUNCTION__, i);
+			dprintk("%s: i == %i\n", __FUNCTION__, i);
 			break;
 		}
 
@@ -432,7 +436,8 @@
 		get_version[7], get_version[8]);
 
 	if (memcmp(get_version + 4, "V 0.0", 5) &&
-	    memcmp(get_version + 4, "V 1.1", 5)) {
+	    memcmp(get_version + 4, "V 1.1", 5) &&
+   	    memcmp(get_version + 4, "V 2.1", 5)) {
 		printk
 		    ("%s: unknown STC version %c%c%c%c%c, please report!\n",
 		     __FUNCTION__, get_version[4], get_version[5],
@@ -932,7 +953,7 @@
 	struct ttusb *ttusb = (struct ttusb *) dvbdmxfeed->demux;
 	struct ttusb_channel *channel;
 
-	printk("ttusb_start_feed\n");
+	dprintk("ttusb_start_feed\n");
 
 	switch (dvbdmxfeed->type) {
 	case DMX_TYPE_TS:
@@ -1004,7 +1025,7 @@
 
 static int ttusb_setup_interfaces(struct ttusb *ttusb)
 {
-	usb_reset_configuration(ttusb->dev);
+	usb_set_configuration(ttusb->dev, 1);
 	usb_set_interface(ttusb->dev, 1, 1);
 
 	ttusb->bulk_out_pipe = usb_sndbulkpipe(ttusb->dev, 1);
@@ -1186,7 +1238,7 @@
 static struct usb_device_id ttusb_table[] = {
 	{USB_DEVICE(0xb48, 0x1003)},
 	{USB_DEVICE(0xb48, 0x1004)},	/* to be confirmed ????  */
-	{USB_DEVICE(0xb48, 0x1005)},	/* to be confirmed ????  */
+	{USB_DEVICE(0xb48, 0x1005)},
 	{}
 };
 
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h linux-2.6.3.p/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h
--- xx-linux-2.6.3/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h	2003-12-18 12:54:50.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/ttusb-budget/dvb-ttusb-dspbootcode.h	2004-02-02 19:28:30.000000000 +0100
@@ -1,7 +1,7 @@
 
 #include <asm/types.h>
 
-u8 dsp_bootcode [] __initdata = {
+u8 dsp_bootcode [] = {
 	0x08, 0xaa, 0x00, 0x18, 0x00, 0x03, 0x08, 0x00, 
 	0x00, 0x10, 0x00, 0x00, 0x01, 0x80, 0x18, 0x5f, 
 	0x00, 0x00, 0x01, 0x80, 0x77, 0x18, 0x2a, 0xeb, 


