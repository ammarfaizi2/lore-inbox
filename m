Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbVIPPKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbVIPPKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbVIPPKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:10:54 -0400
Received: from mx1.suse.de ([195.135.220.2]:8664 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932663AbVIPPKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:10:53 -0400
Date: Fri, 16 Sep 2005 17:10:52 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [ISDN] update hfc_usb driver
Message-ID: <20050916151052.GA8299@pingi3.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Bachem <info@colognechip.com>
  - cleanup source
  - remove nonfunctional code parts

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/hfc_usb.c |  292 +++++++++++++++++-------------------------
 drivers/isdn/hisax/hfc_usb.h |    6 +
 2 files changed, 121 insertions(+), 177 deletions(-)

c5ad93aa5042bcfef6e3acb1021d69a71e32d939
diff --git a/drivers/isdn/hisax/hfc_usb.c b/drivers/isdn/hisax/hfc_usb.c
--- a/drivers/isdn/hisax/hfc_usb.c
+++ b/drivers/isdn/hisax/hfc_usb.c
@@ -1,7 +1,7 @@
 /*
  * hfc_usb.c
  *
- * $Id: hfc_usb.c,v 4.34 2005/01/26 17:25:53 martinb1 Exp $
+ * $Id: hfc_usb.c,v 4.36 2005/04/08 09:55:13 martinb1 Exp $
  *
  * modular HiSax ISDN driver for Colognechip HFC-S USB chip
  *
@@ -44,12 +44,8 @@
 #include "hisax_if.h"
 #include "hfc_usb.h"
 
-/*
-* Version Information
-* (do not modify the CVS Makros $Revision: 4.34 $ and $Date: 2005/01/26 17:25:53 $ !)
-*/
 static const char *hfcusb_revision =
-    "Revision: 4.34 $ Date: 2005/01/26 17:25:53 $ ";
+    "$Revision: 4.36 $ $Date: 2005/04/08 09:55:13 $ ";
 
 /* Hisax debug support
 * use "modprobe debug=x" where x is bitfield of USB_DBG & ISDN_DBG
@@ -63,81 +59,89 @@ module_param(debug, uint, 0);
 static int hfc_debug;
 #endif
 
+/* private vendor specific data */
+typedef struct {
+	__u8 led_scheme;	// led display scheme
+	signed short led_bits[8];	// array of 8 possible LED bitmask settings
+	char *vend_name;	// device name
+} hfcsusb_vdata;
 
 /****************************************/
 /* data defining the devices to be used */
 /****************************************/
-static struct usb_device_id hfc_usb_idtab[] = {
-	{USB_DEVICE(0x0959, 0x2bd0)},	/* Colognechip USB eval TA */
-	{USB_DEVICE(0x0675, 0x1688)},	/* DrayTek miniVigor 128 USB ISDN TA */
-	{USB_DEVICE(0x07b0, 0x0007)},	/* Billion USB TA 2 */
-	{USB_DEVICE(0x0742, 0x2008)},	/* Stollmann USB TA */
-	{USB_DEVICE(0x0742, 0x2009)},	/* Aceex USB ISDN TA */
-	{USB_DEVICE(0x0742, 0x200A)},	/* OEM USB ISDN TA */
-	{USB_DEVICE(0x08e3, 0x0301)},	/* OliTec ISDN USB */
-	{USB_DEVICE(0x07fa, 0x0846)},	/* Bewan ISDN USB TA */
-	{USB_DEVICE(0x07fa, 0x0847)},	/* Djinn Numeris USB */
-	{USB_DEVICE(0x07b0, 0x0006)},	/* Twister ISDN USB TA */
-	{}			/* end with an all-zeroes entry */
+static struct usb_device_id hfcusb_idtab[] = {
+	{
+	 .idVendor = 0x0959,
+	 .idProduct = 0x2bd0,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_OFF, {4, 0, 2, 1},
+			   "ISDN USB TA (Cologne Chip HFC-S USB based)"}),
+	},
+	{
+	 .idVendor = 0x0675,
+	 .idProduct = 0x1688,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {1, 2, 0, 0},
+			   "DrayTek miniVigor 128 USB ISDN TA"}),
+	},
+	{
+	 .idVendor = 0x07b0,
+	 .idProduct = 0x0007,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {0x80, -64, -32, -16},
+			   "Billion tiny USB ISDN TA 128"}),
+	},
+	{
+	 .idVendor = 0x0742,
+	 .idProduct = 0x2008,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {4, 0, 2, 1},
+			   "Stollmann USB TA"}),
+	 },
+	{
+	 .idVendor = 0x0742,
+	 .idProduct = 0x2009,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {4, 0, 2, 1},
+			   "Aceex USB ISDN TA"}),
+	 },
+	{
+	 .idVendor = 0x0742,
+	 .idProduct = 0x200A,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {4, 0, 2, 1},
+			   "OEM USB ISDN TA"}),
+	 },
+	{
+	 .idVendor = 0x08e3,
+	 .idProduct = 0x0301,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {2, 0, 1, 4},
+			   "Olitec USB RNIS"}),
+	 },
+	{
+	 .idVendor = 0x07fa,
+	 .idProduct = 0x0846,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {0x80, -64, -32, -16},
+			   "Bewan Modem RNIS USB"}),
+	 },
+	{
+	 .idVendor = 0x07fa,
+	 .idProduct = 0x0847,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {0x80, -64, -32, -16},
+			   "Djinn Numeris USB"}),
+	 },
+	{
+	 .idVendor = 0x07b0,
+	 .idProduct = 0x0006,
+	 .driver_info = (unsigned long) &((hfcsusb_vdata)
+			  {LED_SCHEME1, {0x80, -64, -32, -16},
+			   "Twister ISDN TA"}),
+	 },
 };
 
-/* driver internal device specific data:
-*   VendorID, ProductID, Devicename, LED_SCHEME,
-*   LED's BitMask in HFCUSB_P_DATA Register : LED_USB, LED_S0, LED_B1, LED_B2
-*/
-static vendor_data vdata[] = {
-	/* CologneChip Eval TA */
-	{0x0959, 0x2bd0, "ISDN USB TA (Cologne Chip HFC-S USB based)",
-	 LED_OFF, {4, 0, 2, 1}
-	 }
-	,
-	/* DrayTek miniVigor 128 USB ISDN TA */
-	{0x0675, 0x1688, "DrayTek miniVigor 128 USB ISDN TA",
-	 LED_SCHEME1, {1, 2, 0, 0}
-	 }
-	,
-	/* Billion TA */
-	{0x07b0, 0x0007, "Billion tiny USB ISDN TA 128",
-	 LED_SCHEME1, {0x80, -64, -32, -16}
-	 }
-	,
-	/* Stollmann TA */
-	{0x0742, 0x2008, "Stollmann USB TA",
-	 LED_SCHEME1, {4, 0, 2, 1}
-	 }
-	,
-	/* Aceex USB ISDN TA */
-	{0x0742, 0x2009, "Aceex USB ISDN TA",
-	 LED_SCHEME1, {4, 0, 2, 1}
-	 }
-	,
-	/* OEM USB ISDN TA */
-	{0x0742, 0x200A, "OEM USB ISDN TA",
-	 LED_SCHEME1, {4, 0, 2, 1}
-	 }
-	,
-	/* Olitec TA  */
-	{0x08e3, 0x0301, "Olitec USB RNIS",
-	 LED_SCHEME1, {2, 0, 1, 4}
-	 }
-	,
-	/* Bewan TA   */
-	{0x07fa, 0x0846, "Bewan Modem RNIS USB",
-	 LED_SCHEME1, {0x80, -64, -32, -16}
-	 }
-	,
-	/* Bewan TA   */
-	{0x07fa, 0x0847, "Djinn Numeris USB",
-	 LED_SCHEME1, {0x80, -64, -32, -16}
-	 }
-	,
-	/* Twister ISDN TA   */
-	{0x07b0, 0x0006, "Twister ISDN TA",
-	 LED_SCHEME1, {0x80, -64, -32, -16}
-	 }
-	,
-	{0, 0, 0}		/* EOL element */
-};
 
 /***************************************************************/
 /* structure defining input+output fifos (interrupt/bulk mode) */
@@ -211,8 +215,6 @@ typedef struct hfcusb_data {
 	volatile __u8 l1_state;	/* actual l1 state */
 	struct timer_list t3_timer;	/* timer 3 for activation/deactivation */
 	struct timer_list t4_timer;	/* timer 4 for activation/deactivation */
-	struct timer_list led_timer;	/* timer flashing leds */
-
 } hfcusb_data;
 
 
@@ -227,7 +229,7 @@ symbolic(struct hfcusb_symbolic_list lis
 	for (i = 0; list[i].name != NULL; i++)
 		if (list[i].num == num)
 			return (list[i].name);
-	return "<unkown>";
+	return "<unkown ERROR>";
 }
 
 
@@ -335,93 +337,57 @@ set_led_bit(hfcusb_data * hfc, signed sh
 	}
 }
 
-/******************************************/
-/* invert B-channel LEDs if data is sent  */
-/******************************************/
-static void
-led_timer(hfcusb_data * hfc)
-{
-	static int cnt = 0;
-
-	if (cnt) {
-		if (hfc->led_b_active & 1)
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[2],
-				    0);
-		if (hfc->led_b_active & 2)
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[3],
-				    0);
-	} else {
-		if (!(hfc->led_b_active & 1) || hfc->led_new_data & 1)
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[2],
-				    1);
-		if (!(hfc->led_b_active & 2) || hfc->led_new_data & 2)
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[3],
-				    1);
-	}
-
-	write_led(hfc, hfc->led_state);
-	hfc->led_new_data = 0;
-
-	cnt = !cnt;
-
-	/* restart 4 hz timer */
-	if (!timer_pending(&hfc->led_timer)) {
-		add_timer(&hfc->led_timer);
-		hfc->led_timer.expires = jiffies + (LED_TIME * HZ) / 1000;
-	}
-}
-
 /**************************/
 /* handle LED requests    */
 /**************************/
 static void
 handle_led(hfcusb_data * hfc, int event)
 {
+	hfcsusb_vdata *driver_info =
+	    (hfcsusb_vdata *) hfcusb_idtab[hfc->vend_idx].driver_info;
+
 	/* if no scheme -> no LED action */
-	if (vdata[hfc->vend_idx].led_scheme == LED_OFF)
+	if (driver_info->led_scheme == LED_OFF)
 		return;
 
 	switch (event) {
 		case LED_POWER_ON:
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[0],
+			set_led_bit(hfc, driver_info->led_bits[0],
 				    0);
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[1],
+			set_led_bit(hfc, driver_info->led_bits[1],
 				    1);
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[2],
+			set_led_bit(hfc, driver_info->led_bits[2],
 				    1);
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[3],
+			set_led_bit(hfc, driver_info->led_bits[3],
 				    1);
 			break;
 		case LED_POWER_OFF:	/* no Power off handling */
 			break;
 		case LED_S0_ON:
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[1],
+			set_led_bit(hfc, driver_info->led_bits[1],
 				    0);
 			break;
 		case LED_S0_OFF:
-			set_led_bit(hfc, vdata[hfc->vend_idx].led_bits[1],
+			set_led_bit(hfc, driver_info->led_bits[1],
 				    1);
 			break;
 		case LED_B1_ON:
-			hfc->led_b_active |= 1;
+			set_led_bit(hfc, driver_info->led_bits[2],
+				    0);
 			break;
 		case LED_B1_OFF:
-			hfc->led_b_active &= ~1;
-			break;
-		case LED_B1_DATA:
-			hfc->led_new_data |= 1;
+			set_led_bit(hfc, driver_info->led_bits[2],
+				    1);
 			break;
 		case LED_B2_ON:
-			hfc->led_b_active |= 2;
+			set_led_bit(hfc, driver_info->led_bits[3],
+				    0);
 			break;
 		case LED_B2_OFF:
-			hfc->led_b_active &= ~2;
-			break;
-		case LED_B2_DATA:
-			hfc->led_new_data |= 2;
+			set_led_bit(hfc, driver_info->led_bits[3],
+				    1);
 			break;
 	}
-
 	write_led(hfc, hfc->led_state);
 }
 
@@ -725,14 +691,6 @@ tx_iso_complete(struct urb *urb, struct 
 				    current_len + 1;
 
 				tx_offset += (current_len + 1);
-				if (!transp_mode) {
-					if (fifon == HFCUSB_B1_TX)
-						handle_led(hfc,
-							   LED_B1_DATA);
-					if (fifon == HFCUSB_B2_TX)
-						handle_led(hfc,
-							   LED_B2_DATA);
-				}
 			} else {
 				urb->iso_frame_desc[k].offset =
 				    tx_offset++;
@@ -966,14 +924,6 @@ collect_rx_frame(usb_fifo * fifo, __u8 *
 			skb_trim(fifo->skbuff, 0);
 		}
 	}
-
-	/* LED flashing only in HDLC mode */
-	if (!transp_mode) {
-		if (fifon == HFCUSB_B1_RX)
-			handle_led(hfc, LED_B1_DATA);
-		if (fifon == HFCUSB_B2_RX)
-			handle_led(hfc, LED_B2_DATA);
-	}
 }
 
 /***********************************************/
@@ -1339,17 +1289,6 @@ usb_init(hfcusb_data * hfc)
 	hfc->t4_timer.data = (long) hfc;
 	hfc->t4_timer.function = (void *) l1_timer_expire_t4;
 
-	/* init the led timer */
-	init_timer(&hfc->led_timer);
-	hfc->led_timer.data = (long) hfc;
-	hfc->led_timer.function = (void *) led_timer;
-
-	/* trigger 4 hz led timer */
-	if (!timer_pending(&hfc->led_timer)) {
-		hfc->led_timer.expires = jiffies + (LED_TIME * HZ) / 1000;
-		add_timer(&hfc->led_timer);
-	}
-
 	/* init the background machinery for control requests */
 	hfc->ctrl_read.bRequestType = 0xc0;
 	hfc->ctrl_read.bRequest = 1;
@@ -1440,13 +1379,18 @@ hfc_usb_probe(struct usb_interface *intf
 	    attr, cfg_found, cidx, ep_addr;
 	int cmptbl[16], small_match, iso_packet_size, packet_size,
 	    alt_used = 0;
+	hfcsusb_vdata *driver_info;
 
 	vend_idx = 0xffff;
-	for (i = 0; vdata[i].vendor; i++) {
-		if (dev->descriptor.idVendor == vdata[i].vendor
-		    && dev->descriptor.idProduct == vdata[i].prod_id)
+	for (i = 0; hfcusb_idtab[i].idVendor; i++) {
+		if (dev->descriptor.idVendor == hfcusb_idtab[i].idVendor
+		    && dev->descriptor.idProduct ==
+		    hfcusb_idtab[i].idProduct) {
 			vend_idx = i;
+			continue;
+		}
 	}
+	
 #ifdef CONFIG_HISAX_DEBUG
 	DBG(USB_DBG,
 	    "HFC-USB: probing interface(%d) actalt(%d) minor(%d)\n", ifnum,
@@ -1457,10 +1401,6 @@ hfc_usb_probe(struct usb_interface *intf
 	       ifnum, iface->desc.bAlternateSetting, intf->minor);
 
 	if (vend_idx != 0xffff) {
-#ifdef CONFIG_HISAX_DEBUG
-		DBG(USB_DBG, "HFC-S USB: found vendor idx:%d  name:%s",
-		    vend_idx, vdata[vend_idx].vend_name);
-#endif
 		/* if vendor and product ID is OK, start probing alternate settings */
 		alt_idx = 0;
 		small_match = 0xffff;
@@ -1687,9 +1627,11 @@ hfc_usb_probe(struct usb_interface *intf
 			    usb_sndctrlpipe(context->dev, 0);
 			context->ctrl_urb = usb_alloc_urb(0, GFP_KERNEL);
 
-			printk(KERN_INFO
-			       "HFC-S USB: detected \"%s\"\n",
-			       vdata[vend_idx].vend_name);
+			driver_info =
+			    (hfcsusb_vdata *) hfcusb_idtab[vend_idx].
+			    driver_info;
+			printk(KERN_INFO "HFC-S USB: detected \"%s\"\n",
+			       driver_info->vend_name);
 #ifdef CONFIG_HISAX_DEBUG
 			DBG(USB_DBG,
 			    "HFC-S USB: Endpoint-Config: %s (if=%d alt=%d)\n",
@@ -1740,8 +1682,6 @@ hfc_usb_disconnect(struct usb_interface
 		del_timer(&context->t3_timer);
 	if (timer_pending(&context->t4_timer))
 		del_timer(&context->t4_timer);
-	if (timer_pending(&context->led_timer))
-		del_timer(&context->led_timer);
 	/* tell all fifos to terminate */
 	for (i = 0; i < HFCUSB_NUM_FIFOS; i++) {
 		if (context->fifos[i].usb_transfer_mode == USB_ISOC) {
@@ -1785,9 +1725,11 @@ hfc_usb_disconnect(struct usb_interface
 /* our driver information structure */
 /************************************/
 static struct usb_driver hfc_drv = {
-	.owner = THIS_MODULE,.name =
-	    "hfc_usb",.id_table = hfc_usb_idtab,.probe =
-	    hfc_usb_probe,.disconnect = hfc_usb_disconnect,
+	.owner = THIS_MODULE,
+	.name  = "hfc_usb",
+	.id_table = hfcusb_idtab,
+	.probe = hfc_usb_probe,
+	.disconnect = hfc_usb_disconnect,
 };
 static void __exit
 hfc_usb_exit(void)
@@ -1825,4 +1767,4 @@ module_exit(hfc_usb_exit);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(usb, hfc_usb_idtab);
+MODULE_DEVICE_TABLE(usb, hfcusb_idtab);
diff --git a/drivers/isdn/hisax/hfc_usb.h b/drivers/isdn/hisax/hfc_usb.h
--- a/drivers/isdn/hisax/hfc_usb.h
+++ b/drivers/isdn/hisax/hfc_usb.h
@@ -1,7 +1,7 @@
 /*
 * hfc_usb.h
 *
-* $Id: hfc_usb.h,v 4.1 2005/01/26 17:25:53 martinb1 Exp $
+* $Id: hfc_usb.h,v 4.2 2005/04/07 15:27:17 martinb1 Exp $ 
 */
 
 #ifndef __HFC_USB_H__
@@ -91,7 +91,7 @@
 /**********/
 /* macros */
 /**********/
-#define write_usb(a,b,c)usb_control_msg((a)->dev,(a)->ctrl_out_pipe,0,0x40,(c),(b),0,0,HFC_CTRL_TIMEOUT)
+#define write_usb(a,b,c)usb_control_msg((a)->dev,(a)->ctrl_out_pipe,0,0x40,(c),(b),NULL,0,HFC_CTRL_TIMEOUT)
 #define read_usb(a,b,c) usb_control_msg((a)->dev,(a)->ctrl_in_pipe,1,0xC0,0,(b),(c),1,HFC_CTRL_TIMEOUT)
 
 
@@ -186,6 +186,7 @@ static int validconf[][19] = {
 	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}	// EOL element
 };
 
+#ifdef CONFIG_HISAX_DEBUG
 // string description of chosen config
 static char *conf_str[] = {
 	"4 Interrupt IN + 3 Isochron OUT",
@@ -193,6 +194,7 @@ static char *conf_str[] = {
 	"4 Isochron IN + 3 Isochron OUT",
 	"3 Isochron IN + 3 Isochron OUT"
 };
+#endif
 
 
 typedef struct {
-- 
Karsten Keil
SuSE Labs
ISDN development
