Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVGYF70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVGYF70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVGYF5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:46 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:64861 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261668AbVGYFzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:43 -0400
Message-Id: <20050725054532.819973000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 16/24] ALPS: fix enabling tapping mode
Content-Disposition: inline; filename=alps-fix-enabling-tapping.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Osterlund <petero2@telia.com>

Input: ALPS - unconditionally enable tapping mode

The condition in alps_init() was also inverted and the driver
was enabling tapping mode only if it was already enabled.

Signed-off-by: Peter Osterlund <petero2@telia.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c |   25 +++++++------------------
 1 files changed, 7 insertions(+), 18 deletions(-)

Index: work/drivers/input/mouse/alps.c
===================================================================
--- work.orig/drivers/input/mouse/alps.c
+++ work/drivers/input/mouse/alps.c
@@ -2,7 +2,7 @@
  * ALPS touchpad PS/2 mouse driver
  *
  * Copyright (c) 2003 Neil Brown <neilb@cse.unsw.edu.au>
- * Copyright (c) 2003 Peter Osterlund <petero2@telia.com>
+ * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
  * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
  * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
  *
@@ -350,7 +350,6 @@ static int alps_tap_mode(struct psmouse 
 static int alps_reconnect(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	unsigned char param[4];
 	int version;
 
 	psmouse_reset(psmouse);
@@ -361,14 +360,13 @@ static int alps_reconnect(struct psmouse
 	if ((priv->i->flags & ALPS_PASS) && alps_passthrough_mode(psmouse, 1))
 		return -1;
 
-	if (alps_get_status(psmouse, param))
+	if (alps_tap_mode(psmouse, 1)) {
+		printk(KERN_WARNING "alps.c: Failed to reenable hardware tapping\n");
 		return -1;
-
-	if (!(param[0] & 0x04))
-		alps_tap_mode(psmouse, 1);
+	}
 
 	if (alps_absolute_mode(psmouse)) {
-		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
+		printk(KERN_ERR "alps.c: Failed to reenable absolute mode\n");
 		return -1;
 	}
 
@@ -389,7 +387,6 @@ static void alps_disconnect(struct psmou
 int alps_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv;
-	unsigned char param[4];
 	int version;
 
 	psmouse->private = priv = kmalloc(sizeof(struct alps_data), GFP_KERNEL);
@@ -403,16 +400,8 @@ int alps_init(struct psmouse *psmouse)
 	if ((priv->i->flags & ALPS_PASS) && alps_passthrough_mode(psmouse, 1))
 		goto init_fail;
 
-	if (alps_get_status(psmouse, param)) {
-		printk(KERN_ERR "alps.c: touchpad status report request failed\n");
-		goto init_fail;
-	}
-
-	if (param[0] & 0x04) {
-		printk(KERN_INFO "alps.c: Enabling hardware tapping\n");
-		if (alps_tap_mode(psmouse, 1))
-			printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
-	}
+	if (alps_tap_mode(psmouse, 1))
+		printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
 
 	if (alps_absolute_mode(psmouse)) {
 		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");

