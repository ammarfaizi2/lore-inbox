Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVA3KgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVA3KgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVA3KgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:36:06 -0500
Received: from av3-1-sn4.m-sp.skanova.net ([81.228.10.114]:20139 "EHLO
	av3-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261666AbVA3KfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:35:24 -0500
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/4] Fix "pointer jumps to corner of screen" problem on ALPS Glidepoint touchpads.
References: <m34qgz9pj5.fsf@telia.com> <m3zmyr8avm.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Jan 2005 11:35:12 +0100
In-Reply-To: <m3zmyr8avm.fsf@telia.com>
Message-ID: <m3vf9f8asf.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only parse a "z == 127" packet as a relative Dualpoint stick packet if
the touchpad actually is a Dualpoint device.  The Glidepoint models
don't have a stick, and can report z == 127 for a very wide finger. If
such a packet is parsed as a stick packet, the mouse pointer will
typically jump to one corner of the screen.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mouse/alps.c |   20 ++++++++++----------
 linux-petero/drivers/input/mouse/alps.h |    1 +
 2 files changed, 11 insertions(+), 10 deletions(-)

diff -puN drivers/input/mouse/alps.c~alps-glidepoint-has-no-stick drivers/input/mouse/alps.c
--- linux/drivers/input/mouse/alps.c~alps-glidepoint-has-no-stick	2005-01-30 11:22:32.000000000 +0100
+++ linux-petero/drivers/input/mouse/alps.c	2005-01-30 11:22:32.000000000 +0100
@@ -109,7 +109,8 @@ static void alps_process_packet(struct p
 	y = (packet[4] & 0x7f) | ((packet[3] & 0x70)<<(7-4));
 	z = packet[5];
 
-	if (z == 127) {	/* DualPoint stick is relative, not absolute */
+	if ((priv->model == ALPS_MODEL_DUALPOINT) && (z == 127)) {
+		/* DualPoint stick, relative packet */
 		if (x > 383)
 			x = x - 768;
 		if (y > 255)
@@ -344,13 +345,13 @@ static int alps_tap_mode(struct psmouse 
 
 static int alps_reconnect(struct psmouse *psmouse)
 {
-	int model;
+	struct alps_data *priv = psmouse->private;
 	unsigned char param[4];
 
-	if ((model = alps_get_model(psmouse)) < 0)
+	if ((priv->model = alps_get_model(psmouse)) < 0)
 		return -1;
 
-	if (model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 1))
+	if (priv->model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 1))
 		return -1;
 
 	if (alps_get_status(psmouse, param))
@@ -364,7 +365,7 @@ static int alps_reconnect(struct psmouse
 		return -1;
 	}
 
-	if (model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 0))
+	if (priv->model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 0))
 		return -1;
 
 	return 0;
@@ -380,20 +381,19 @@ int alps_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv;
 	unsigned char param[4];
-	int model;
 
 	psmouse->private = priv = kmalloc(sizeof(struct alps_data), GFP_KERNEL);
 	if (!priv)
 		goto init_fail;
 	memset(priv, 0, sizeof(struct alps_data));
 
-	if ((model = alps_get_model(psmouse)) < 0)
+	if ((priv->model = alps_get_model(psmouse)) < 0)
 		goto init_fail;
 
 	printk(KERN_INFO "ALPS Touchpad (%s) detected\n",
-		model == ALPS_MODEL_GLIDEPOINT ? "Glidepoint" : "Dualpoint");
+		priv->model == ALPS_MODEL_GLIDEPOINT ? "Glidepoint" : "Dualpoint");
 
-	if (model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 1))
+	if (priv->model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 1))
 		goto init_fail;
 
 	if (alps_get_status(psmouse, param)) {
@@ -412,7 +412,7 @@ int alps_init(struct psmouse *psmouse)
 		goto init_fail;
 	}
 
-	if (model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 0))
+	if (priv->model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 0))
 		goto init_fail;
 
 	psmouse->dev.evbit[LONG(EV_REL)] |= BIT(EV_REL);
diff -puN drivers/input/mouse/alps.h~alps-glidepoint-has-no-stick drivers/input/mouse/alps.h
--- linux/drivers/input/mouse/alps.h~alps-glidepoint-has-no-stick	2005-01-30 11:22:32.000000000 +0100
+++ linux-petero/drivers/input/mouse/alps.h	2005-01-30 11:22:32.000000000 +0100
@@ -15,6 +15,7 @@ int alps_detect(struct psmouse *psmouse,
 int alps_init(struct psmouse *psmouse);
 
 struct alps_data {
+	int model;			    /* Glidepoint or Dualpoint */
 	int prev_fin;			    /* Finger bit from previous packet */
 };
 
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
