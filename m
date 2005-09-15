Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbVIOHET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbVIOHET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbVIOHEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:04:12 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:24666 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030433AbVIOHEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:01 -0400
Message-Id: <20050915070302.332672000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:35 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 04/28] Driver core: make parent class define subsystem
Content-Disposition: inline; filename=parent-class-defines-subsystem.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver core: make parent class define subsystem for its children

When there is a hierarchy of classes make parent class define
subsystem as reported in hotplug notifications. The full class
path is reported in a new CLASS environment variable.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -337,25 +337,35 @@ static int class_hotplug_filter(struct k
 static const char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
+	struct class *class = class_dev->class;
 
-	return class_dev->class->name;
+	while (class->parent)
+		class = class->parent;
+
+	return class->name;
 }
 
 static int class_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
 			 int num_envp, char *buffer, int buffer_size)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
+	const char *path;
 	int i = 0;
 	int length = 0;
 	int retval = 0;
 
 	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
 
+	path = kobject_get_path(&class_dev->class->subsys.kset.kobj, GFP_KERNEL);
+	add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+			    &length, "CLASS=%s", path);
+	kfree(path);
+
 	if (class_dev->dev) {
 		/* add physical device, backing this device  */
 		struct device *dev = class_dev->dev;
-		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 
+		path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
 				    &length, "PHYSDEVPATH=%s", path);
 		kfree(path);

