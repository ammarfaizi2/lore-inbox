Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263441AbTC2RcZ>; Sat, 29 Mar 2003 12:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263443AbTC2RcZ>; Sat, 29 Mar 2003 12:32:25 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:35249 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263441AbTC2RcY>; Sat, 29 Mar 2003 12:32:24 -0500
Date: Sat, 29 Mar 2003 18:43:28 +0100
From: Dominik Brodowski <linux@brodo.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia: fill device directory in sysfs with files
Message-ID: <20030329174328.GA25268@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds three files (manf_id, card_id, func_id) for any pcmcia
device registered with the sysfs core.

sysfs_output-1
 ds.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-29 18:00:43.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-29 18:34:10.000000000 +0100
@@ -267,6 +267,20 @@
 
 /*====================================================================*/
 
+#define show_one(file_name, object, test)	 			\
+static ssize_t show_##file_name 					\
+(struct device *dev, char *buf)						\
+{									\
+	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);		\
+	return p_dev->test ? sprintf (buf, "%x\n", p_dev->object) : 	\
+			sprintf(buf, "unknown\n");			\
+}	 								\
+DEVICE_ATTR(file_name, 0444, show_##file_name, NULL);
+
+show_one(func_id, funcid.func, has_funcid);
+show_one(manf_id, manfid.manf, has_manfid);
+show_one(card_id, manfid.card, has_manfid);
+
 static int pcmcia_add_card(struct pcmcia_bus_socket *s)
 {
 	struct pcmcia_device *p_dev;
@@ -368,6 +382,11 @@
 	}
 	list_add(&p_dev->socket_device_list, &s->devices_list);
 
+	/* add sysfs files */
+	device_create_file(&p_dev->dev, &dev_attr_func_id);
+	device_create_file(&p_dev->dev, &dev_attr_manf_id);
+	device_create_file(&p_dev->dev, &dev_attr_card_id);
+
 	/* if we got a multifunction device, we need to register more devices,
 	 * so go back up */
 	func++;
@@ -387,6 +406,11 @@
 	down(&s->devices_list_sem);
 	list_for_each_safe(p1, p2, &s->devices_list) {
 		struct pcmcia_device *p_dev = container_of(p1, struct pcmcia_device, socket_device_list);
+
+		device_remove_file(&p_dev->dev, &dev_attr_func_id);
+		device_remove_file(&p_dev->dev, &dev_attr_manf_id);
+		device_remove_file(&p_dev->dev, &dev_attr_card_id);
+
 		device_unregister(&p_dev->dev);
 		list_del(&p_dev->socket_device_list);
 		kfree(p_dev);
