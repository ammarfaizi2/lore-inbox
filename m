Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTIUTJA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 15:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTIUTJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 15:09:00 -0400
Received: from smtp5.hy.skanova.net ([195.67.199.134]:3297 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262425AbTIUTIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 15:08:51 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [PATCH 2/2] synaptics: Code cleanup
From: Peter Osterlund <petero2@telia.com>
Date: 21 Sep 2003 21:08:47 +0200
Message-ID: <m2k782t0w0.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch containing some cleanups in synaptics.c. It doesn't change
any behavior. From Dmitry Torokhov. Please apply.


 linux-petero/drivers/input/mouse/synaptics.c |  161 ++++++++++++++-------------
 1 files changed, 85 insertions(+), 76 deletions(-)

diff -puN drivers/input/mouse/synaptics.c~synaptics-cleanup drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~synaptics-cleanup	2003-09-21 14:55:18.000000000 +0200
+++ linux-petero/drivers/input/mouse/synaptics.c	2003-09-21 20:55:37.000000000 +0200
@@ -36,7 +36,7 @@
  * Use the Synaptics extended ps/2 syntax to write a special command byte.
  * special command: 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
  *                  is the command. A 0xF3 or 0xE9 must follow (see synaptics_send_cmd
- *                  and synaptics_set_mode)
+ *                  and synaptics_mode_cmd)
  */
 static int synaptics_special_cmd(struct psmouse *psmouse, unsigned char command)
 {
@@ -69,7 +69,7 @@ static int synaptics_send_cmd(struct psm
 /*
  * Set the synaptics touchpad mode byte by special commands
  */
-static int synaptics_set_mode(struct psmouse *psmouse, unsigned char mode)
+static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
 {
 	unsigned char param[1];
 
@@ -96,13 +96,14 @@ static int synaptics_reset(struct psmous
  * Read the model-id bytes from the touchpad
  * see also SYN_MODEL_* macros
  */
-static int synaptics_model_id(struct psmouse *psmouse, unsigned long int *model_id)
+static int synaptics_model_id(struct psmouse *psmouse)
 {
+	struct synaptics_data *priv = psmouse->private;
 	unsigned char mi[3];
 
 	if (synaptics_send_cmd(psmouse, SYN_QUE_MODEL, mi))
 		return -1;
-	*model_id = (mi[0]<<16) | (mi[1]<<8) | mi[2];
+	priv->model_id = (mi[0]<<16) | (mi[1]<<8) | mi[2];
 	return 0;
 }
 
@@ -110,23 +111,24 @@ static int synaptics_model_id(struct psm
  * Read the capability-bits from the touchpad
  * see also the SYN_CAP_* macros
  */
-static int synaptics_capability(struct psmouse *psmouse, unsigned long int *capability, unsigned long int *ext_cap)
+static int synaptics_capability(struct psmouse *psmouse)
 {
+	struct synaptics_data *priv = psmouse->private;
 	unsigned char cap[3];
 
 	if (synaptics_send_cmd(psmouse, SYN_QUE_CAPABILITIES, cap))
 		return -1;
-	*capability = (cap[0]<<16) | (cap[1]<<8) | cap[2];
-	*ext_cap = 0;
-	if (!SYN_CAP_VALID(*capability))
+	priv->capabilities = (cap[0]<<16) | (cap[1]<<8) | cap[2];
+	priv->ext_cap = 0;
+	if (!SYN_CAP_VALID(priv->capabilities))
 		return -1;
 
-	if (SYN_EXT_CAP_REQUESTS(*capability)) {
+	if (SYN_EXT_CAP_REQUESTS(priv->capabilities)) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB, cap)) {
 			printk(KERN_ERR "Synaptics claims to have extended capabilities,"
 			       " but I'm not able to read them.");
 		} else
-			*ext_cap = (cap[0]<<16) | (cap[1]<<8) | cap[2];
+			priv->ext_cap = (cap[0]<<16) | (cap[1]<<8) | cap[2];
 	}
 	return 0;
 }
@@ -135,14 +137,15 @@ static int synaptics_capability(struct p
  * Identify Touchpad
  * See also the SYN_ID_* macros
  */
-static int synaptics_identify(struct psmouse *psmouse, unsigned long int *ident)
+static int synaptics_identify(struct psmouse *psmouse)
 {
+	struct synaptics_data *priv = psmouse->private;
 	unsigned char id[3];
 
 	if (synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id))
 		return -1;
-	*ident = (id[0]<<16) | (id[1]<<8) | id[2];
-	if (SYN_ID_IS_SYNAPTICS(*ident))
+	priv->identity = (id[0]<<16) | (id[1]<<8) | id[2];
+	if (SYN_ID_IS_SYNAPTICS(priv->identity))
 		return 0;
 	return -1;
 }
@@ -179,7 +182,7 @@ static void print_ident(struct synaptics
 	}
 }
 
-static int query_hardware(struct psmouse *psmouse)
+static int synaptics_query_hardware(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 	int retries = 0;
@@ -188,11 +191,11 @@ static int query_hardware(struct psmouse
 	while ((retries++ < 3) && synaptics_reset(psmouse))
 		printk(KERN_ERR "synaptics reset failed\n");
 
-	if (synaptics_identify(psmouse, &priv->identity))
+	if (synaptics_identify(psmouse))
 		return -1;
-	if (synaptics_model_id(psmouse, &priv->model_id))
+	if (synaptics_model_id(psmouse))
 		return -1;
-	if (synaptics_capability(psmouse, &priv->capabilities, &priv->ext_cap))
+	if (synaptics_capability(psmouse))
 		return -1;
 
 	mode = SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
@@ -200,7 +203,7 @@ static int query_hardware(struct psmouse
 		mode |= SYN_BIT_DISABLE_GESTURE;
 	if (SYN_CAP_EXTENDED(priv->capabilities))
 		mode |= SYN_BIT_W_MODE;
-	if (synaptics_set_mode(psmouse, mode))
+	if (synaptics_mode_cmd(psmouse, mode))
 		return -1;
 
 	return 0;
@@ -286,7 +289,7 @@ int synaptics_pt_init(struct psmouse *ps
 	/* adjust the touchpad to child's choice of protocol */
 	child = port->private;
 	if (child && child->type >= PSMOUSE_GENPS) {
-		if (synaptics_set_mode(psmouse, (SYN_BIT_ABSOLUTE_MODE |
+		if (synaptics_mode_cmd(psmouse, (SYN_BIT_ABSOLUTE_MODE |
 					 	 SYN_BIT_HIGH_RATE |
 					 	 SYN_BIT_DISABLE_GESTURE |
 						 SYN_BIT_FOUR_BYTE_CLIENT |
@@ -311,46 +314,27 @@ static inline void set_abs_params(struct
 	set_bit(axis, dev->absbit);
 }
 
-int synaptics_init(struct psmouse *psmouse)
+static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
-	struct synaptics_data *priv;
-
-#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
-	return -1;
-#endif
-	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
-	if (!priv)
-		return -1;
-	memset(priv, 0, sizeof(struct synaptics_data));
-
-	priv->out_of_sync = 0;
-
-	if (query_hardware(psmouse)) {
-		printk(KERN_ERR "Unable to query/initialize Synaptics hardware.\n");
-		goto init_fail;
-	}
-
-	print_ident(priv);
-
 	/*
 	 * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
 	 * which says that they should be valid regardless of the actual size of
 	 * the sensor.
 	 */
-	set_bit(EV_ABS, psmouse->dev.evbit);
-	set_abs_params(&psmouse->dev, ABS_X, 1472, 5472, 0, 0);
-	set_abs_params(&psmouse->dev, ABS_Y, 1408, 4448, 0, 0);
-	set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 255, 0, 0);
-
-	set_bit(EV_MSC, psmouse->dev.evbit);
-	set_bit(MSC_GESTURE, psmouse->dev.mscbit);
-
-	set_bit(EV_KEY, psmouse->dev.evbit);
-	set_bit(BTN_LEFT, psmouse->dev.keybit);
-	set_bit(BTN_RIGHT, psmouse->dev.keybit);
-	set_bit(BTN_FORWARD, psmouse->dev.keybit);
-	set_bit(BTN_BACK, psmouse->dev.keybit);
-	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
+	set_bit(EV_ABS, dev->evbit);
+	set_abs_params(dev, ABS_X, 1472, 5472, 0, 0);
+	set_abs_params(dev, ABS_Y, 1408, 4448, 0, 0);
+	set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
+
+	set_bit(EV_MSC, dev->evbit);
+	set_bit(MSC_GESTURE, dev->mscbit);
+
+	set_bit(EV_KEY, dev->evbit);
+	set_bit(BTN_LEFT, dev->keybit);
+	set_bit(BTN_RIGHT, dev->keybit);
+	set_bit(BTN_FORWARD, dev->keybit);
+	set_bit(BTN_BACK, dev->keybit);
+	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
 		switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
 		default:
 			/*
@@ -359,22 +343,46 @@ int synaptics_init(struct psmouse *psmou
 			 */
 			break;
 		case 8:
-			set_bit(BTN_7, psmouse->dev.keybit);
-			set_bit(BTN_6, psmouse->dev.keybit);
+			set_bit(BTN_7, dev->keybit);
+			set_bit(BTN_6, dev->keybit);
 		case 6:
-			set_bit(BTN_5, psmouse->dev.keybit);
-			set_bit(BTN_4, psmouse->dev.keybit);
+			set_bit(BTN_5, dev->keybit);
+			set_bit(BTN_4, dev->keybit);
 		case 4:
-			set_bit(BTN_3, psmouse->dev.keybit);
-			set_bit(BTN_2, psmouse->dev.keybit);
+			set_bit(BTN_3, dev->keybit);
+			set_bit(BTN_2, dev->keybit);
 		case 2:
-			set_bit(BTN_1, psmouse->dev.keybit);
-			set_bit(BTN_0, psmouse->dev.keybit);
+			set_bit(BTN_1, dev->keybit);
+			set_bit(BTN_0, dev->keybit);
 			break;
 		}
-	clear_bit(EV_REL, psmouse->dev.evbit);
-	clear_bit(REL_X, psmouse->dev.relbit);
-	clear_bit(REL_Y, psmouse->dev.relbit);
+	}
+
+	clear_bit(EV_REL, dev->evbit);
+	clear_bit(REL_X, dev->relbit);
+	clear_bit(REL_Y, dev->relbit);
+}
+
+int synaptics_init(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv;
+
+#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
+	return -1;
+#endif
+
+	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
+	if (!priv)
+		return -1;
+	memset(priv, 0, sizeof(struct synaptics_data));
+
+	if (synaptics_query_hardware(psmouse)) {
+		printk(KERN_ERR "Unable to query/initialize Synaptics hardware.\n");
+		goto init_fail;
+	}
+
+	print_ident(priv);
+	set_input_params(&psmouse->dev, priv);
 
 	return 0;
 
@@ -388,7 +396,7 @@ void synaptics_disconnect(struct psmouse
 	struct synaptics_data *priv = psmouse->private;
 
 	if (psmouse->type == PSMOUSE_SYNAPTICS && priv) {
-		synaptics_set_mode(psmouse, 0);
+		synaptics_mode_cmd(psmouse, 0);
 		if (priv->ptport) {
 			serio_unregister_slave_port(priv->ptport);
 			kfree(priv->ptport);
@@ -582,19 +590,20 @@ void synaptics_process_byte(struct psmou
 		}
 		break;
 	default:
-		if (psmouse->pktcnt >= 6) { /* Full packet received */
-			if (priv->out_of_sync) {
-				priv->out_of_sync = 0;
-				printk(KERN_NOTICE "Synaptics driver resynced.\n");
-			}
+		if (psmouse->pktcnt < 6)
+			break;		    /* Wait for full packet */
 
-			if (priv->ptport && synaptics_is_pt_packet(psmouse->packet))
-				synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
-			else
-				synaptics_process_packet(psmouse);
-
-			psmouse->pktcnt = 0;
+		if (priv->out_of_sync) {
+			priv->out_of_sync = 0;
+			printk(KERN_NOTICE "Synaptics driver resynced.\n");
 		}
+
+		if (priv->ptport && synaptics_is_pt_packet(psmouse->packet))
+			synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
+		else
+			synaptics_process_packet(psmouse);
+
+		psmouse->pktcnt = 0;
 		break;
 	}
 	return;

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
