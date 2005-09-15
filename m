Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVIOGze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVIOGze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbVIOGxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:53:52 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:379 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030358AbVIOGvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:41 -0400
Message-Id: <20050915064946.039119000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:46:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 23/28] Input: show sysfs path in /proc/bus/input/devices
Content-Disposition: inline; filename=input-export-sysfs-name.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: show sysfs path in /proc/bus/input/devices

Show that sysfs and phys path are different objects.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -474,17 +474,21 @@ static int input_devices_read(char *buf,
 {
 	struct input_dev *dev;
 	struct input_handle *handle;
+	const char *path;
 
 	off_t at = 0;
 	int i, len, cnt = 0;
 
 	list_for_each_entry(dev, &input_dev_list, node) {
 
+		path = dev->dynalloc ? kobject_get_path(&dev->cdev.kobj, GFP_KERNEL) : NULL;
+
 		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
 			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
 
 		len += sprintf(buf + len, "N: Name=\"%s\"\n", dev->name ? dev->name : "");
 		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
+		len += sprintf(buf + len, "S: Sysfs=%s\n", path ? path : "");
 		len += sprintf(buf + len, "H: Handlers=");
 
 		list_for_each_entry(handle, &dev->h_list, d_node)
@@ -515,6 +519,8 @@ static int input_devices_read(char *buf,
 			if (cnt >= count)
 				break;
 		}
+
+		kfree(path);
 	}
 
 	if (&dev->node == &input_dev_list)

