Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVCVCQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVCVCQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVCVCOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:14:36 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:45707 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262348AbVCVBgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:18 -0500
Message-Id: <20050322013500.610850000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:19 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttusb-dec-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 46/48] ttusb_dec: cleanup
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup patch from Peter Beutner:

o unregister the input device on disconnect
  and move cleanup stuff of the RC to own function
o keymap should be static not const
o set up keymap correctly and completly for input device
  plus a more cosmetic one:
o usb endpoints are only 4bit numbers[0...15], the 8th bit
  only specifies the direction and is set by the snd/rcvxxxpipe() macro

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 ttusb_dec.c |   49 +++++++++++++++++++++++++++++--------------------
 1 files changed, 29 insertions(+), 20 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-dec/ttusb_dec.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-03-22 00:18:46.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-03-22 00:29:05.000000000 +0100
@@ -58,10 +58,10 @@ MODULE_PARM_DESC(enable_rc, "Turn on/off
 #define DRIVER_NAME		"TechnoTrend/Hauppauge DEC USB"
 
 #define COMMAND_PIPE		0x03
-#define RESULT_PIPE		0x84
-#define IN_PIPE			0x88
+#define RESULT_PIPE		0x04
+#define IN_PIPE			0x08
 #define OUT_PIPE		0x07
-#define IRQ_PIPE		0x8A
+#define IRQ_PIPE		0x0A
 
 #define COMMAND_PACKET_SIZE	0x3c
 #define ARM_PACKET_SIZE		0x1000
@@ -170,7 +170,7 @@ struct filter_info {
 	struct list_head	filter_info_list;
 };
 
-const uint16_t  rc_keys[] = {
+static u16 rc_keys[] = {
 	KEY_POWER,
 	KEY_MUTE,
 	KEY_1,
@@ -1191,8 +1191,9 @@ static void ttusb_init_rc( struct ttusb_
 
 	dec->rc_input_dev.name = "ttusb_dec remote control";
 	dec->rc_input_dev.evbit[0] = BIT(EV_KEY);
-	dec->rc_input_dev.keycodesize = sizeof(unsigned char);
-	dec->rc_input_dev.keycodemax = KEY_MAX;
+	dec->rc_input_dev.keycodesize = sizeof(u16);
+	dec->rc_input_dev.keycodemax = 0x1a;
+	dec->rc_input_dev.keycode = rc_keys;
 
 	 for (i = 0; i < sizeof(rc_keys)/sizeof(rc_keys[0]); i++)
                 set_bit(rc_keys[i], dec->rc_input_dev.keybit);
@@ -1498,6 +1499,26 @@ static void ttusb_dec_exit_dvb(struct tt
 	dvb_unregister_adapter(dec->adapter);
 }
 
+static void ttusb_dec_exit_rc(struct ttusb_dec *dec)
+{
+
+	dprintk("%s\n", __FUNCTION__);
+	/* we have to check whether the irq URB is already submitted.
+	  * As the irq is submitted after the interface is changed,
+	  * this is the best method i figured out.
+	  * Any others?*/
+	if(dec->interface == TTUSB_DEC_INTERFACE_IN)
+		usb_kill_urb(dec->irq_urb);
+
+	usb_free_urb(dec->irq_urb);
+
+	usb_buffer_free(dec->udev,IRQ_PACKET_SIZE,
+		           dec->irq_buffer, dec->irq_dma_handle);
+
+	input_unregister_device(&dec->rc_input_dev);
+}
+
+
 static void ttusb_dec_exit_usb(struct ttusb_dec *dec)
 {
 	int i;
@@ -1510,20 +1531,6 @@ static void ttusb_dec_exit_usb(struct tt
 		usb_kill_urb(dec->iso_urb[i]);
 
 	ttusb_dec_free_iso_urbs(dec);
-
-	if(enable_rc) {
-		/* we have to check whether the irq URB is already submitted.
-		 * As the irq is submitted after the interface is changed,
-		 * this is the best method i figured out.
-		 * Any other possibilities?*/
-		if(dec->interface == TTUSB_DEC_INTERFACE_IN)
-			usb_kill_urb(dec->irq_urb);
-
-		usb_free_urb(dec->irq_urb);
-
-		usb_buffer_free(dec->udev,IRQ_PACKET_SIZE,
-					dec->irq_buffer, dec->irq_dma_handle);
-	}
 }
 
 static void ttusb_dec_exit_tasklet(struct ttusb_dec *dec)
@@ -1663,6 +1670,8 @@ static void ttusb_dec_disconnect(struct 
 	if (dec->active) {
 		ttusb_dec_exit_tasklet(dec);
 		ttusb_dec_exit_filters(dec);
+		if(enable_rc)
+			ttusb_dec_exit_rc(dec);
 		ttusb_dec_exit_usb(dec);
 		ttusb_dec_exit_dvb(dec);
 	}

--

