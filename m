Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTLAHSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTLAHSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:18:38 -0500
Received: from smtp800.mail.ukl.yahoo.com ([217.12.12.142]:32931 "HELO
	smtp800.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263472AbTLAHSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:18:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 2/3] Input: resume support for i8042 (atkbd & psmouse)
Date: Mon, 1 Dec 2003 02:17:14 -0500
User-Agent: KMail/1.5.4
Cc: Pavel Machek <pavel@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>
References: <200312010215.58533.dtor_core@ameritech.net>
In-Reply-To: <200312010215.58533.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312010217.16553.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1515, 2003-12-01 01:43:05-05:00, dtor_core@ameritech.net
  Input: Add reconnect method to atkbd to restore keyboard state
         after suspend (to be called from i8042 resume function)


 atkbd.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Dec  1 01:45:48 2003
+++ b/drivers/input/keyboard/atkbd.c	Mon Dec  1 01:45:48 2003
@@ -686,10 +686,60 @@
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
 }
 
+/*
+ * atkbd_reconnect() tries to restore keyboard in a sane state and is
+ * most likely called on resume.
+ */
+
+static int atkbd_reconnect(struct serio *serio)
+{
+	struct atkbd *atkbd = serio->private;
+	struct serio_dev *dev = serio->dev;
+	int i;
+
+        if (!dev) {
+                printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
+                return -1;
+        }
+
+	if (atkbd->write) {
+		if (atkbd_probe(atkbd))
+			return -1;
+		
+		atkbd->set = atkbd_set_3(atkbd);
+		atkbd_enable(atkbd);
+	} else {
+		atkbd->set = 2;
+		atkbd->id = 0xab00;
+	}
+
+	/* 
+	 * Here we probably should check if the keyboard has the same set that
+         * it had before and bail out if it's different. But this will most likely
+         * cause new keyboard device be created... and for the user it will look
+         * like keyboard is lost
+	 */
+
+	if (atkbd->set == 3)
+		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
+	else
+		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
+
+	for (i = 0; i < 512; i++)
+		if (atkbd->keycode[i] && atkbd->keycode[i] < 255)
+			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
+
+	printk(KERN_INFO "input: %s on %s (reconnected)\n", atkbd->name, serio->phys);
+
+	return 0;
+}
+
+
 
 static struct serio_dev atkbd_dev = {
 	.interrupt =	atkbd_interrupt,
 	.connect =	atkbd_connect,
+	.reconnect = 	atkbd_reconnect,
 	.disconnect =	atkbd_disconnect,
 	.cleanup =	atkbd_cleanup,
 };
