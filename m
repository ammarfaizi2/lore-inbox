Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUI2GvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUI2GvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUI2GtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:49:00 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:36206 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268235AbUI2GsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/8] Psmouse rate and resolution handlers
Date: Wed, 29 Sep 2004 01:42:31 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290141.48766.dtor_core@ameritech.net>
In-Reply-To: <200409290141.48766.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290142.33707.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1948, 2004-09-28 00:07:10-05:00, dtor_core@ameritech.net
  Input: psmouse - add set_rate and set_resolution handlers to make
         adding new protocols easier and remove special knowledge
         from psmouse-base.c
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 logips2pp.c    |   22 ++++++++++++++--------
 logips2pp.h    |    1 -
 psmouse-base.c |   43 ++++++++++++++++++++-----------------------
 psmouse.h      |    8 +++++++-
 synaptics.c    |   37 +++++++++++++++++++++++++++----------
 synaptics.h    |    1 +
 6 files changed, 69 insertions(+), 43 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-09-29 01:15:50 -05:00
+++ b/drivers/input/mouse/logips2pp.c	2004-09-29 01:15:50 -05:00
@@ -137,15 +137,19 @@
  * also good reasons to use it, let the user decide).
  */
 
-void ps2pp_set_800dpi(struct psmouse *psmouse)
+static void ps2pp_set_resolution(struct psmouse *psmouse, unsigned int resolution)
 {
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param = 3;
-
-	ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
-	ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
-	ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
-	ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
+	if (resolution > 400) {
+		struct ps2dev *ps2dev = &psmouse->ps2dev;
+		unsigned char param = 3;
+
+		ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+		ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+		ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+		ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
+		psmouse->resolution = 800;
+	} else
+		psmouse_set_resolution(psmouse, resolution);
 }
 
 static struct ps2pp_info *get_model_info(unsigned char model)
@@ -299,6 +303,8 @@
 		if (set_properties) {
 			psmouse->vendor = "Logitech";
 			psmouse->model = model;
+			if (protocol == PSMOUSE_PS2PP)
+				psmouse->set_resolution = ps2pp_set_resolution;
 
 			if (buttons < 3)
 				clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
diff -Nru a/drivers/input/mouse/logips2pp.h b/drivers/input/mouse/logips2pp.h
--- a/drivers/input/mouse/logips2pp.h	2004-09-29 01:15:50 -05:00
+++ b/drivers/input/mouse/logips2pp.h	2004-09-29 01:15:50 -05:00
@@ -12,7 +12,6 @@
 #define _LOGIPS2PP_H
 
 void ps2pp_process_packet(struct psmouse *psmouse);
-void ps2pp_set_800dpi(struct psmouse *psmouse);
 int ps2pp_init(struct psmouse *psmouse, int set_properties);
 
 #endif
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-09-29 01:15:50 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-09-29 01:15:50 -05:00
@@ -36,11 +36,11 @@
 module_param_named(proto, psmouse_proto, charp, 0);
 MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
 
-int psmouse_resolution = 200;
+static unsigned int psmouse_resolution = 200;
 module_param_named(resolution, psmouse_resolution, uint, 0);
 MODULE_PARM_DESC(resolution, "Resolution, in dpi.");
 
-unsigned int psmouse_rate = 100;
+static unsigned int psmouse_rate = 100;
 module_param_named(rate, psmouse_rate, uint, 0);
 MODULE_PARM_DESC(rate, "Report rate, in reports per second.");
 
@@ -521,38 +521,29 @@
  * Here we set the mouse resolution.
  */
 
-static void psmouse_set_resolution(struct psmouse *psmouse)
+void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution)
 {
-	unsigned char param[1];
+	unsigned char params[] = { 0, 1, 2, 2, 3 };
 
-	if (psmouse->type == PSMOUSE_PS2PP && psmouse_resolution > 400) {
-		ps2pp_set_800dpi(psmouse);
-		return;
-	}
-
-	if (!psmouse_resolution || psmouse_resolution >= 200)
-		param[0] = 3;
-	else if (psmouse_resolution >= 100)
-		param[0] = 2;
-	else if (psmouse_resolution >= 50)
-		param[0] = 1;
-	else if (psmouse_resolution)
-		param[0] = 0;
+	if (resolution == 0 || resolution > 200)
+		resolution = 200;
 
-	ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(&psmouse->ps2dev, &params[resolution / 50], PSMOUSE_CMD_SETRES);
+	psmouse->resolution = 25 << params[resolution / 50];
 }
 
 /*
  * Here we set the mouse report rate.
  */
 
-static void psmouse_set_rate(struct psmouse *psmouse)
+static void psmouse_set_rate(struct psmouse *psmouse, unsigned int rate)
 {
 	unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
 	int i = 0;
 
-	while (rates[i] > psmouse_rate) i++;
-	ps2_command(&psmouse->ps2dev, rates + i, PSMOUSE_CMD_SETRATE);
+	while (rates[i] > rate) i++;
+	ps2_command(&psmouse->ps2dev, &rates[i], PSMOUSE_CMD_SETRATE);
+	psmouse->rate = rates[i];
 }
 
 /*
@@ -568,8 +559,8 @@
  */
 
 	if (psmouse_max_proto != PSMOUSE_PS2) {
-		psmouse_set_rate(psmouse);
-		psmouse_set_resolution(psmouse);
+		psmouse->set_rate(psmouse, psmouse->rate);
+		psmouse->set_resolution(psmouse, psmouse->resolution);
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
 	}
 
@@ -709,6 +700,8 @@
 		goto out;
 	}
 
+	psmouse->rate = psmouse_rate;
+	psmouse->resolution = psmouse_resolution;
 	psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
 	if (!psmouse->vendor)
 		psmouse->vendor = "Generic";
@@ -716,6 +709,10 @@
 		psmouse->name = "Mouse";
 	if (!psmouse->protocol_handler)
 		psmouse->protocol_handler = psmouse_process_byte;
+	if (!psmouse->set_rate)
+		psmouse->set_rate = psmouse_set_rate;
+	if (!psmouse->set_resolution)
+		psmouse->set_resolution = psmouse_set_resolution;
 
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-09-29 01:15:50 -05:00
+++ b/drivers/input/mouse/psmouse.h	2004-09-29 01:15:50 -05:00
@@ -50,7 +50,13 @@
 	char devname[64];
 	char phys[32];
 
+	unsigned int rate;
+	unsigned int resolution;
+
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
+	void (*set_rate)(struct psmouse *psmouse, unsigned int rate);
+	void (*set_resolution)(struct psmouse *psmouse, unsigned int resolution);
+
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
 
@@ -73,8 +79,8 @@
 
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
+void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
 
 extern int psmouse_smartscroll;
-extern unsigned int psmouse_rate;
 
 #endif /* _PSMOUSE_H */
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-09-29 01:15:50 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-09-29 01:15:50 -05:00
@@ -193,23 +193,37 @@
 	return 0;
 }
 
-static int synaptics_set_mode(struct psmouse *psmouse, int mode)
+static int synaptics_set_absolute_mode(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 
-	mode |= SYN_BIT_ABSOLUTE_MODE;
-	if (psmouse_rate >= 80)
-		mode |= SYN_BIT_HIGH_RATE;
+	priv->mode = SYN_BIT_ABSOLUTE_MODE;
 	if (SYN_ID_MAJOR(priv->identity) >= 4)
-		mode |= SYN_BIT_DISABLE_GESTURE;
+		priv->mode |= SYN_BIT_DISABLE_GESTURE;
 	if (SYN_CAP_EXTENDED(priv->capabilities))
-		mode |= SYN_BIT_W_MODE;
-	if (synaptics_mode_cmd(psmouse, mode))
+		priv->mode |= SYN_BIT_W_MODE;
+
+	if (synaptics_mode_cmd(psmouse, priv->mode))
 		return -1;
 
 	return 0;
 }
 
+static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	if (rate >= 80) {
+		priv->mode |= SYN_BIT_HIGH_RATE;
+		psmouse->rate = 80;
+	} else {
+		priv->mode &= ~SYN_BIT_HIGH_RATE;
+		psmouse->rate = 40;
+	}
+
+	synaptics_mode_cmd(psmouse, priv->mode);
+}
+
 /*****************************************************************************
  *	Synaptics pass-through PS/2 port support
  ****************************************************************************/
@@ -247,10 +261,12 @@
 static void synaptics_pt_activate(struct psmouse *psmouse)
 {
 	struct psmouse *child = psmouse->ps2dev.serio->child->private;
+	struct synaptics_data *priv = psmouse->private;
 
 	/* adjust the touchpad to child's choice of protocol */
 	if (child && child->type >= PSMOUSE_GENPS) {
-		if (synaptics_set_mode(psmouse, SYN_BIT_FOUR_BYTE_CLIENT))
+		priv->mode |= SYN_BIT_FOUR_BYTE_CLIENT;
+		if (synaptics_mode_cmd(psmouse, priv->mode))
 			printk(KERN_INFO "synaptics: failed to enable 4-byte guest protocol\n");
 	}
 }
@@ -552,7 +568,7 @@
 	    old_priv.ext_cap != priv->ext_cap)
 		return -1;
 
-	if (synaptics_set_mode(psmouse, 0)) {
+	if (synaptics_set_absolute_mode(psmouse)) {
 		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
 		return -1;
 	}
@@ -590,7 +606,7 @@
 		goto init_fail;
 	}
 
-	if (synaptics_set_mode(psmouse, 0)) {
+	if (synaptics_set_absolute_mode(psmouse)) {
 		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
 		goto init_fail;
 	}
@@ -604,6 +620,7 @@
 	set_input_params(&psmouse->dev, priv);
 
 	psmouse->protocol_handler = synaptics_process_byte;
+	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
 
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	2004-09-29 01:15:50 -05:00
+++ b/drivers/input/mouse/synaptics.h	2004-09-29 01:15:50 -05:00
@@ -104,6 +104,7 @@
 	/* Data for normal processing */
 	int old_w;				/* Previous w value */
 	unsigned char pkt_type;			/* packet type - old, new, etc */
+	unsigned char mode;			/* current mode byte */
 };
 
 #endif /* _SYNAPTICS_H */
