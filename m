Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTI3G20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTI3G20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:28:26 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:53095 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263144AbTI3G2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:28:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/6] Add black list to handler<->device matching
Date: Tue, 30 Sep 2003 01:15:55 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, petero2@telia.com, linux-kernel@vger.kernel.org
References: <200309300052.49908.dtor_core@ameritech.net> <200309300106.20744.dtor_core@ameritech.net> <200309300112.50076.dtor_core@ameritech.net>
In-Reply-To: <200309300112.50076.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309300114.57761.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: Introduce an optional blacklist field in input_handler structure.
       When loading a new device or a new handler try to match device
       against handler's black list before doing match on required 
       attributes.
       This allows to get rid of "surprises" in connect functions, IMO
       connect should only fail when it physically can not connect, not
       because it decides it does not like device.


 drivers/input/input.c  |   14 ++++++++------
 drivers/input/joydev.c |   14 ++++++++++----
 include/linux/input.h  |    1 +
 3 files changed, 19 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Tue Sep 30 01:13:54 2003
+++ b/drivers/input/input.c	Tue Sep 30 01:13:54 2003
@@ -447,9 +447,10 @@
 	list_add_tail(&dev->node, &input_dev_list);
 
 	list_for_each_entry(handler, &input_handler_list, node)
-		if ((id = input_match_device(handler->id_table, dev)))
-			if ((handle = handler->connect(handler, dev, id)))
-				input_link_handle(handle);
+		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
+			if ((id = input_match_device(handler->id_table, dev)))
+				if ((handle = handler->connect(handler, dev, id)))
+					input_link_handle(handle);
 
 #ifdef CONFIG_HOTPLUG
 	input_call_hotplug("add", dev);
@@ -507,9 +508,10 @@
 	list_add_tail(&handler->node, &input_handler_list);
 	
 	list_for_each_entry(dev, &input_dev_list, node)
-		if ((id = input_match_device(handler->id_table, dev)))
-			if ((handle = handler->connect(handler, dev, id)))
-				input_link_handle(handle);
+		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
+			if ((id = input_match_device(handler->id_table, dev)))
+				if ((handle = handler->connect(handler, dev, id)))
+					input_link_handle(handle);
 
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Tue Sep 30 01:13:54 2003
+++ b/drivers/input/joydev.c	Tue Sep 30 01:13:54 2003
@@ -380,10 +380,6 @@
 	struct joydev *joydev;
 	int i, j, t, minor;
 
-	/* Avoid tablets */
-        if (test_bit(EV_KEY, dev->evbit) && test_bit(BTN_TOUCH, dev->keybit))
-		return NULL;
-
 	for (minor = 0; minor < JOYDEV_MINORS && joydev_table[minor]; minor++);
 	if (minor == JOYDEV_MINORS) {
 		printk(KERN_ERR "joydev: no more free joydev devices\n");
@@ -464,6 +460,15 @@
 		joydev_free(joydev);
 }
 
+static struct input_device_id joydev_blacklist[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT(EV_KEY) },
+		.keybit = { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
+	}, 	/* Avoid itouchpads, touchscreens and tablets */
+	{ }, 	/* Terminating entry */
+};
+
 static struct input_device_id joydev_ids[] = {
 	{
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
@@ -493,6 +498,7 @@
 	.minor =	JOYDEV_MINOR_BASE,
 	.name =		"joydev",
 	.id_table =	joydev_ids,
+	.blacklist = 	joydev_blacklist,
 };
 
 static int __init joydev_init(void)
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Sep 30 01:13:54 2003
+++ b/include/linux/input.h	Tue Sep 30 01:13:54 2003
@@ -870,6 +870,7 @@
 	char *name;
 
 	struct input_device_id *id_table;
+	struct input_device_id *blacklist;
 
 	struct list_head	h_list;
 	struct list_head	node;

