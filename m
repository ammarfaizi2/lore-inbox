Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUALXRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUALXQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:16:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:58838 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262784AbUALXOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:14:00 -0500
Date: Mon, 12 Jan 2004 15:13:57 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] restrict class names to valid file names
Message-Id: <20040112151357.5c9702b7.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to name network devices with names like "my/bogus" or "." or ".."
which leaves /sys/class/net/ a mess.  Since other subsystems could have the same
problem, it made sense to me to enforce some restrictions in the class device
layer.

A lateer patch fixes the network device registration path because the
sysfs registration takes place after the register_netdevice call has taken place.

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Mon Jan 12 15:11:55 2004
+++ b/drivers/base/class.c	Mon Jan 12 15:11:55 2004
@@ -87,10 +87,24 @@
 	subsys_put(&cls->subsys);
 }
 
+/* Restrict class names to valid file names */
+int 
+class_name_valid(const char *name)
+{
+	return !(name[0] == '\0'
+		 || (name[0] == '.' 
+		     && (name[1] == '\0' 
+			 || (name[1] == '.' && (name[2] == '\0'))))
+		 || strchr(name, '/'));
+}
+
 int class_register(struct class * cls)
 {
 	pr_debug("device class '%s': registering\n",cls->name);
 
+	if (!class_name_valid(cls->name))
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
 	kobject_set_name(&cls->subsys.kset.kobj,cls->name);
@@ -267,6 +281,9 @@
 	struct list_head * entry;
 	int error;
 
+	if (!class_name_valid(class_dev->class_id))
+		return -EINVAL;
+
 	class_dev = class_device_get(class_dev);
 	if (!class_dev || !strlen(class_dev->class_id))
 		return -EINVAL;
@@ -348,6 +365,9 @@
 
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
+	if (!class_name_valid(new_name))
+		return -EINVAL;
+
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
 		return -EINVAL;
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Jan 12 15:11:55 2004
+++ b/include/linux/device.h	Mon Jan 12 15:11:55 2004
@@ -157,6 +157,7 @@
 	void	(*release)(struct class_device *dev);
 };
 
+extern int class_name_valid(const char *);
 extern int class_register(struct class *);
 extern void class_unregister(struct class *);
 
