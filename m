Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264977AbUDUGG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbUDUGG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265023AbUDUGG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:06:56 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:34988 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264977AbUDUGFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:41 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/15] New set of input patches: synaptics cleanup
Date: Wed, 21 Apr 2004 00:50:00 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210050.02396.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1902, 2004-04-20 22:22:49-05:00, dtor_core@ameritech.net
  Input: synaptics driver cleanup
         - pack all button data in 2 bytes instead of 48
         - adjust the way we extract button data
         - query extended capabilities if SYN_EXT_CAP_REQUESTS >= 1
           (was == 1) according to Synaptics' addendum to the interfacing
           guide
         - do not announce or report BTN_BACK/BTN_FORWARD unless touchpad
           has SYN_CAP_FOUR_BUTTON in its capability flags


 synaptics.c |  137 +++++++++++++++++++++++++-----------------------------------
 synaptics.h |   19 ++------
 2 files changed, 65 insertions(+), 91 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Apr 20 22:55:50 2004
+++ b/drivers/input/mouse/synaptics.c	Tue Apr 20 22:55:50 2004
@@ -118,17 +118,31 @@
 
 	if (synaptics_send_cmd(psmouse, SYN_QUE_CAPABILITIES, cap))
 		return -1;
-	priv->capabilities = (cap[0]<<16) | (cap[1]<<8) | cap[2];
+	priv->capabilities = (cap[0] << 16) | (cap[1] << 8) | cap[2];
 	priv->ext_cap = 0;
 	if (!SYN_CAP_VALID(priv->capabilities))
 		return -1;
 
-	if (SYN_EXT_CAP_REQUESTS(priv->capabilities)) {
+	/*
+	 * Unless capExtended is set the rest of the flags should be ignored
+	 */
+	if (!SYN_CAP_EXTENDED(priv->capabilities))
+		priv->capabilities = 0;
+
+	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 1) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB, cap)) {
 			printk(KERN_ERR "Synaptics claims to have extended capabilities,"
 			       " but I'm not able to read them.");
-		} else
-			priv->ext_cap = (cap[0]<<16) | (cap[1]<<8) | cap[2];
+		} else {
+			priv->ext_cap = (cap[0] << 16) | (cap[1] << 8) | cap[2];
+
+			/*
+			 * if nExtBtn is greater than 8 it should be considered
+			 * invalid and treated as 0
+			 */
+			if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) > 8)
+				priv->ext_cap &= 0xff0fff;
+		}
 	}
 	return 0;
 }
@@ -167,11 +181,10 @@
 
 	if (SYN_CAP_EXTENDED(priv->capabilities)) {
 		printk(KERN_INFO " Touchpad has extended capability bits\n");
-		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
-		    SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) <= 8)
+		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
 			printk(KERN_INFO " -> %d multi-buttons, i.e. besides standard buttons\n",
 			       (int)(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)));
-		else if (SYN_CAP_FOUR_BUTTON(priv->capabilities))
+		if (SYN_CAP_FOUR_BUTTON(priv->capabilities))
 			printk(KERN_INFO " -> four buttons\n");
 		if (SYN_CAP_MULTIFINGER(priv->capabilities))
 			printk(KERN_INFO " -> multifinger detection\n");
@@ -312,6 +325,8 @@
 
 static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
+	int i;
+
 	set_bit(EV_ABS, dev->evbit);
 	set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
 	set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
@@ -326,32 +341,15 @@
 
 	set_bit(BTN_LEFT, dev->keybit);
 	set_bit(BTN_RIGHT, dev->keybit);
-	set_bit(BTN_FORWARD, dev->keybit);
-	set_bit(BTN_BACK, dev->keybit);
-	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
-		switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
-		default:
-			/*
-			 * if nExtBtn is greater than 8 it should be considered
-			 * invalid and treated as 0
-			 */
-			break;
-		case 8:
-			set_bit(BTN_7, dev->keybit);
-			set_bit(BTN_6, dev->keybit);
-		case 6:
-			set_bit(BTN_5, dev->keybit);
-			set_bit(BTN_4, dev->keybit);
-		case 4:
-			set_bit(BTN_3, dev->keybit);
-			set_bit(BTN_2, dev->keybit);
-		case 2:
-			set_bit(BTN_1, dev->keybit);
-			set_bit(BTN_0, dev->keybit);
-			break;
-		}
+
+	if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
+		set_bit(BTN_FORWARD, dev->keybit);
+		set_bit(BTN_BACK, dev->keybit);
 	}
 
+	for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
+		set_bit(BTN_0 + i, dev->keybit);
+
 	clear_bit(EV_REL, dev->evbit);
 	clear_bit(REL_X, dev->relbit);
 	clear_bit(REL_Y, dev->relbit);
@@ -385,8 +383,8 @@
 	if (old_priv.identity != priv->identity ||
 	    old_priv.model_id != priv->model_id ||
 	    old_priv.capabilities != priv->capabilities ||
-    	    old_priv.ext_cap != priv->ext_cap)
-    		return -1;
+	    old_priv.ext_cap != priv->ext_cap)
+		return -1;
 
 	if (synaptics_set_mode(psmouse, 0)) {
 		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
@@ -432,8 +430,8 @@
 
 	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
 
-	if (SYN_CAP_EXTENDED(priv->capabilities) && SYN_CAP_PASS_THROUGH(priv->capabilities))
-       		synaptics_pt_create(psmouse);
+	if (SYN_CAP_PASS_THROUGH(priv->capabilities))
+		synaptics_pt_create(psmouse);
 
 	print_ident(priv);
 	set_input_params(&psmouse->dev, priv);
@@ -471,17 +469,14 @@
 
 		hw->left  = (buf[0] & 0x01) ? 1 : 0;
 		hw->right = (buf[0] & 0x02) ? 1 : 0;
-		if (SYN_CAP_EXTENDED(priv->capabilities) &&
-		    (SYN_CAP_FOUR_BUTTON(priv->capabilities))) {
-			hw->up = ((buf[3] & 0x01)) ? 1 : 0;
-			if (hw->left)
-				hw->up = !hw->up;
-			hw->down = ((buf[3] & 0x02)) ? 1 : 0;
-			if (hw->right)
-				hw->down = !hw->down;
+
+		if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
+			hw->up   = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
+			hw->down = ((buf[0] ^ buf[3]) & 0x02) ? 1 : 0;
 		}
+
 		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
-		    ((buf[3] & 2) ? !hw->right : hw->right)) {
+		    ((buf[0] ^ buf[3]) & 0x02)) {
 			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
 			default:
 				/*
@@ -490,17 +485,17 @@
 				 */
 				break;
 			case 8:
-				hw->b7 = ((buf[5] & 0x08)) ? 1 : 0;
-				hw->b6 = ((buf[4] & 0x08)) ? 1 : 0;
+				hw->ext_buttons |= ((buf[5] & 0x08)) ? 0x80 : 0;
+				hw->ext_buttons |= ((buf[4] & 0x08)) ? 0x40 : 0;
 			case 6:
-				hw->b5 = ((buf[5] & 0x04)) ? 1 : 0;
-				hw->b4 = ((buf[4] & 0x04)) ? 1 : 0;
+				hw->ext_buttons |= ((buf[5] & 0x04)) ? 0x20 : 0;
+				hw->ext_buttons |= ((buf[4] & 0x04)) ? 0x10 : 0;
 			case 4:
-				hw->b3 = ((buf[5] & 0x02)) ? 1 : 0;
-				hw->b2 = ((buf[4] & 0x02)) ? 1 : 0;
+				hw->ext_buttons |= ((buf[5] & 0x02)) ? 0x08 : 0;
+				hw->ext_buttons |= ((buf[4] & 0x02)) ? 0x04 : 0;
 			case 2:
-				hw->b1 = ((buf[5] & 0x01)) ? 1 : 0;
-				hw->b0 = ((buf[4] & 0x01)) ? 1 : 0;
+				hw->ext_buttons |= ((buf[5] & 0x01)) ? 0x02 : 0;
+				hw->ext_buttons |= ((buf[4] & 0x01)) ? 0x01 : 0;
 			}
 		}
 	} else {
@@ -525,6 +520,7 @@
 	struct synaptics_hw_state hw;
 	int num_fingers;
 	int finger_width;
+	int i;
 
 	synaptics_parse_hw_state(psmouse->packet, priv, &hw);
 
@@ -570,32 +566,17 @@
 	input_report_key(dev, BTN_TOOL_DOUBLETAP, num_fingers == 2);
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, num_fingers == 3);
 
-	input_report_key(dev, BTN_LEFT,    hw.left);
-	input_report_key(dev, BTN_RIGHT,   hw.right);
-	input_report_key(dev, BTN_FORWARD, hw.up);
-	input_report_key(dev, BTN_BACK,    hw.down);
-	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
-		switch(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
-		default:
-			/*
-			 * if nExtBtn is greater than 8 it should be considered
-			 * invalid and treated as 0
-			 */
-			break;
-		case 8:
-			input_report_key(dev, BTN_7,       hw.b7);
-			input_report_key(dev, BTN_6,       hw.b6);
-		case 6:
-			input_report_key(dev, BTN_5,       hw.b5);
-			input_report_key(dev, BTN_4,       hw.b4);
-		case 4:
-			input_report_key(dev, BTN_3,       hw.b3);
-			input_report_key(dev, BTN_2,       hw.b2);
-		case 2:
-			input_report_key(dev, BTN_1,       hw.b1);
-			input_report_key(dev, BTN_0,       hw.b0);
-			break;
-		}
+	input_report_key(dev, BTN_LEFT, hw.left);
+	input_report_key(dev, BTN_RIGHT, hw.right);
+
+	if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
+		input_report_key(dev, BTN_FORWARD, hw.up);
+		input_report_key(dev, BTN_BACK, hw.down);
+	}
+
+	for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
+		input_report_key(dev, BTN_0 + i, hw.ext_buttons & (1 << i));
+
 	input_sync(dev);
 }
 
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	Tue Apr 20 22:55:50 2004
+++ b/drivers/input/mouse/synaptics.h	Tue Apr 20 22:55:50 2004
@@ -50,7 +50,7 @@
 #define SYN_CAP_MULTIFINGER(c)		((c) & (1 << 1))
 #define SYN_CAP_PALMDETECT(c)		((c) & (1 << 0))
 #define SYN_CAP_VALID(c)		((((c) & 0x00ff00) >> 8) == 0x47)
-#define SYN_EXT_CAP_REQUESTS(c)		((((c) & 0x700000) >> 20) == 1)
+#define SYN_EXT_CAP_REQUESTS(c)		(((c) & 0x700000) >> 20)
 #define SYN_CAP_MULTI_BUTTON_NO(ec)	(((ec) & 0x00f000) >> 12)
 
 /* synaptics modes query bits */
@@ -86,18 +86,11 @@
 	int y;
 	int z;
 	int w;
-	int left;
-	int right;
-	int up;
-	int down;
-	int b0;
-	int b1;
-	int b2;
-	int b3;
-	int b4;
-	int b5;
-	int b6;
-	int b7;
+	unsigned int left:1;
+	unsigned int right:1;
+	unsigned int up:1;
+	unsigned int down:1;
+	unsigned char ext_buttons;
 };
 
 struct synaptics_data {
