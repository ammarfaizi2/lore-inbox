Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVA3Kd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVA3Kd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVA3Kd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:33:56 -0500
Received: from av4-2-sn3.vrr.skanova.net ([81.228.9.112]:52909 "EHLO
	av4-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261665AbVA3KdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:33:23 -0500
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/4] Enable hardware tapping for ALPS touchpads
References: <m34qgz9pj5.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Jan 2005 11:33:17 +0100
In-Reply-To: <m34qgz9pj5.fsf@telia.com>
Message-ID: <m3zmyr8avm.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When hardware tapping is disabled on an ALPS touchpad, the touchpad
generates exactly the same data for a single tap and a fast double
tap.  The effect is that the second tap in the double tap sequence is
lost.

To fix this problem, this patch enables hardware tapping and converts
the resulting tap and gesture bits to standard finger pressure values
(z), which is what mousedev.c and the userspace X driver expects.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mouse/alps.c |   53 +++++++++++++++++++++++++-------
 linux-petero/drivers/input/mouse/alps.h |    4 ++
 2 files changed, 47 insertions(+), 10 deletions(-)

diff -puN drivers/input/mouse/alps.c~alps-hwtaps drivers/input/mouse/alps.c
--- linux/drivers/input/mouse/alps.c~alps-hwtaps	2005-01-30 11:22:30.000000000 +0100
+++ linux-petero/drivers/input/mouse/alps.c	2005-01-30 11:22:30.000000000 +0100
@@ -78,10 +78,12 @@ struct alps_model_info {
 
 static void alps_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
 {
+	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = &psmouse->dev;
 	int x, y, z;
 	int left = 0, right = 0, middle = 0;
+	int ges, fin;
 
 	input_regs(dev, regs);
 
@@ -123,6 +125,27 @@ static void alps_process_packet(struct p
 		return;
 	}
 
+	ges = packet[2] & 1;		    /* gesture bit */
+	fin = packet[2] & 2;		    /* finger bit */
+
+	/* Convert hardware tap to a reasonable Z value */
+	if (ges && !fin)
+		z = 40;
+
+	/*
+	 * A "tap and drag" operation is reported by the hardware as a transition
+	 * from (!fin && ges) to (fin && ges). This should be translated to the
+	 * sequence Z>0, Z==0, Z>0, so the Z==0 event has to be generated manually.
+	 */
+	if (ges && fin && !priv->prev_fin) {
+		input_report_abs(dev, ABS_X, x);
+		input_report_abs(dev, ABS_Y, y);
+		input_report_abs(dev, ABS_PRESSURE, 0);
+		input_report_key(dev, BTN_TOOL_FINGER, 0);
+		input_sync(dev);
+	}
+	priv->prev_fin = fin;
+
 	if (z > 30) input_report_key(dev, BTN_TOUCH, 1);
 	if (z < 25) input_report_key(dev, BTN_TOUCH, 0);
 
@@ -133,7 +156,6 @@ static void alps_process_packet(struct p
 	input_report_abs(dev, ABS_PRESSURE, z);
 	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
 
-	left  |= (packet[2]     ) & 1;
 	left  |= (packet[3]     ) & 1;
 	right |= (packet[3] >> 1) & 1;
 	if (packet[0] == 0xff) {
@@ -335,7 +357,7 @@ static int alps_reconnect(struct psmouse
 		return -1;
 
 	if (param[0] & 0x04)
-		alps_tap_mode(psmouse, 0);
+		alps_tap_mode(psmouse, 1);
 
 	if (alps_absolute_mode(psmouse)) {
 		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
@@ -351,40 +373,47 @@ static int alps_reconnect(struct psmouse
 static void alps_disconnect(struct psmouse *psmouse)
 {
 	psmouse_reset(psmouse);
+	kfree(psmouse->private);
 }
 
 int alps_init(struct psmouse *psmouse)
 {
+	struct alps_data *priv;
 	unsigned char param[4];
 	int model;
 
+	psmouse->private = priv = kmalloc(sizeof(struct alps_data), GFP_KERNEL);
+	if (!priv)
+		goto init_fail;
+	memset(priv, 0, sizeof(struct alps_data));
+
 	if ((model = alps_get_model(psmouse)) < 0)
-		return -1;
+		goto init_fail;
 
 	printk(KERN_INFO "ALPS Touchpad (%s) detected\n",
 		model == ALPS_MODEL_GLIDEPOINT ? "Glidepoint" : "Dualpoint");
 
 	if (model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 1))
-		return -1;
+		goto init_fail;
 
 	if (alps_get_status(psmouse, param)) {
 		printk(KERN_ERR "alps.c: touchpad status report request failed\n");
-		return -1;
+		goto init_fail;
 	}
 
 	if (param[0] & 0x04) {
-		printk(KERN_INFO "  Disabling hardware tapping\n");
-		if (alps_tap_mode(psmouse, 0))
-			printk(KERN_WARNING "alps.c: Failed to disable hardware tapping\n");
+		printk(KERN_INFO "  Enabling hardware tapping\n");
+		if (alps_tap_mode(psmouse, 1))
+			printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
 	}
 
 	if (alps_absolute_mode(psmouse)) {
 		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
-		return -1;
+		goto init_fail;
 	}
 
 	if (model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 0))
-		return -1;
+		goto init_fail;
 
 	psmouse->dev.evbit[LONG(EV_REL)] |= BIT(EV_REL);
 	psmouse->dev.relbit[LONG(REL_X)] |= BIT(REL_X);
@@ -408,6 +437,10 @@ int alps_init(struct psmouse *psmouse)
 	psmouse->pktsize = 6;
 
 	return 0;
+
+init_fail:
+	kfree(priv);
+	return -1;
 }
 
 int alps_detect(struct psmouse *psmouse, int set_properties)
diff -puN drivers/input/mouse/alps.h~alps-hwtaps drivers/input/mouse/alps.h
--- linux/drivers/input/mouse/alps.h~alps-hwtaps	2005-01-30 11:22:30.000000000 +0100
+++ linux-petero/drivers/input/mouse/alps.h	2005-01-30 11:22:30.000000000 +0100
@@ -14,4 +14,8 @@
 int alps_detect(struct psmouse *psmouse, int set_properties);
 int alps_init(struct psmouse *psmouse);
 
+struct alps_data {
+	int prev_fin;			    /* Finger bit from previous packet */
+};
+
 #endif
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
