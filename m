Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTISK0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbTISK0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:26:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18574 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261476AbTISK0u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:26:50 -0400
Subject: [PATCH 1/11] input: Restore synaptics pad mode on module unload
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:40 +0200
Message-Id: <10639672004187@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1339, 2003-09-19 00:20:17-07:00, petero2@telia.com
  synaptics.c, psmouse-base.c:
    input: Restore synaptics pad mode on module unload.


 psmouse-base.c |    3 ++-
 synaptics.c    |    7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:16:53 2003
+++ b/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:16:53 2003
@@ -478,9 +478,10 @@
 static void psmouse_disconnect(struct serio *serio)
 {
 	struct psmouse *psmouse = serio->private;
+	if (psmouse->type == PSMOUSE_SYNAPTICS)
+		synaptics_disconnect(psmouse);
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
-	synaptics_disconnect(psmouse);
 	kfree(psmouse);
 }
 
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Fri Sep 19 12:16:53 2003
+++ b/drivers/input/mouse/synaptics.c	Fri Sep 19 12:16:53 2003
@@ -144,7 +144,7 @@
 static void print_ident(struct synaptics_data *priv)
 {
 	printk(KERN_INFO "Synaptics Touchpad, model: %ld\n", SYN_ID_MODEL(priv->identity));
-	printk(KERN_INFO " Firware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
+	printk(KERN_INFO " Firmware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
 	       SYN_ID_MINOR(priv->identity));
 
 	if (SYN_MODEL_ROT180(priv->model_id))
@@ -228,7 +228,7 @@
 	/*
 	 * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
 	 * which says that they should be valid regardless of the actual size of
-	 * the senser.
+	 * the sensor.
 	 */
 	set_bit(EV_ABS, psmouse->dev.evbit);
 	set_abs_params(&psmouse->dev, ABS_X, 1472, 5472, 0, 0);
@@ -258,6 +258,9 @@
 void synaptics_disconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
+
+	/* Restore touchpad to power on default state */
+	synaptics_set_mode(psmouse, 0);
 
 	kfree(priv);
 }

