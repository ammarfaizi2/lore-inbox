Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWJJGtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWJJGtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWJJGtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:49:41 -0400
Received: from havoc.gtf.org ([69.61.125.42]:54157 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965038AbWJJGtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:49:40 -0400
Date: Tue, 10 Oct 2006 02:49:39 -0400
From: Jeff Garzik <jeff@garzik.org>
To: dmitry.torokhov@gmail.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] input: handle sysfs errors
Message-ID: <20061010064939.GA21385@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/input/keyboard/atkbd.c     |   25 ++++++++++++++++++++-----
 drivers/input/mouse/psmouse-base.c |   11 +++++++++--
 drivers/input/mouse/trackpoint.c   |    7 ++++++-
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index b6ef9ea..4d5c790 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -961,11 +961,16 @@ static int atkbd_connect(struct serio *s
 	atkbd_set_keycode_table(atkbd);
 	atkbd_set_device_attrs(atkbd);
 
-	device_create_file(&serio->dev, &atkbd_attr_extra);
-	device_create_file(&serio->dev, &atkbd_attr_scroll);
-	device_create_file(&serio->dev, &atkbd_attr_set);
-	device_create_file(&serio->dev, &atkbd_attr_softrepeat);
-	device_create_file(&serio->dev, &atkbd_attr_softraw);
+	err = device_create_file(&serio->dev, &atkbd_attr_extra);
+	if (err) goto fail_serio;
+	err = device_create_file(&serio->dev, &atkbd_attr_scroll);
+	if (err) goto fail_extra;
+	err = device_create_file(&serio->dev, &atkbd_attr_set);
+	if (err) goto fail_scroll;
+	err = device_create_file(&serio->dev, &atkbd_attr_softrepeat);
+	if (err) goto fail_set;
+	err = device_create_file(&serio->dev, &atkbd_attr_softraw);
+	if (err) goto fail_softrep;
 
 	atkbd_enable(atkbd);
 
@@ -973,6 +978,16 @@ static int atkbd_connect(struct serio *s
 
 	return 0;
 
+ fail_softrep:
+	device_remove_file(&serio->dev, &atkbd_attr_softrepeat);
+ fail_set:
+	device_remove_file(&serio->dev, &atkbd_attr_set);
+ fail_scroll:
+	device_remove_file(&serio->dev, &atkbd_attr_scroll);
+ fail_extra:
+	device_remove_file(&serio->dev, &atkbd_attr_extra);
+ fail_serio:
+	serio_close(serio);
  fail:	serio_set_drvdata(serio, NULL);
 	input_free_device(dev);
 	kfree(atkbd);
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 6f9b2c7..0bd349f 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1152,11 +1152,13 @@ static int psmouse_connect(struct serio 
 
 	input_register_device(psmouse->dev);
 
+	retval = sysfs_create_group(&serio->dev.kobj, &psmouse_attribute_group);
+	if (retval)
+		goto err_out;
+
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
-	sysfs_create_group(&serio->dev.kobj, &psmouse_attribute_group);
-
 	psmouse_activate(psmouse);
 
 	retval = 0;
@@ -1174,6 +1176,11 @@ out:
 
 	mutex_unlock(&psmouse_mutex);
 	return retval;
+err_out:
+	input_unregister_device(psmouse->dev);
+	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+	serio_close(serio);
+	goto out;
 }
 
 
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index ae5871a..8d639ff 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -293,6 +293,7 @@ int trackpoint_detect(struct psmouse *ps
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char firmware_id;
 	unsigned char button_info;
+	int rc;
 
 	if (trackpoint_start_protocol(psmouse, &firmware_id))
 		return -1;
@@ -318,7 +319,11 @@ int trackpoint_detect(struct psmouse *ps
 	trackpoint_defaults(priv);
 	trackpoint_sync(psmouse);
 
-	sysfs_create_group(&ps2dev->serio->dev.kobj, &trackpoint_attr_group);
+	rc=sysfs_create_group(&ps2dev->serio->dev.kobj, &trackpoint_attr_group);
+	if (rc) {
+		kfree(priv);
+		return -1;
+	}
 
 	printk(KERN_INFO "IBM TrackPoint firmware: 0x%02x, buttons: %d/%d\n",
 		firmware_id, (button_info & 0xf0) >> 4, button_info & 0x0f);
