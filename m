Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTL0Fau (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 00:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbTL0Fau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 00:30:50 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:9111 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265325AbTL0Faj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 00:30:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [2.6 PATCH/RFC] Firmware loader fixes - take 2 (patch 2/2)
Date: Sat, 27 Dec 2003 00:30:18 -0500
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manuel Estrada Sainz <ranty@debian.org>,
       Patrick Mochel <mochel@osdl.org>
References: <200312210137.41343.dtor_core@ameritech.net> <200312270025.24160.dtor_core@ameritech.net> <200312270028.26952.dtor_core@ameritech.net>
In-Reply-To: <200312270028.26952.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312270030.21195.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1528, 2003-12-25 23:08:12-05:00, dtor_core@ameritech.net
  Firmware loader:
   - make kobject hotplug mechanism public
   - do not call hotplug until firmware class device is completely
     instantiated


 drivers/base/firmware_class.c |    6 +++++
 include/linux/kobject.h       |    1 
 lib/kobject.c                 |   49 ++++++++++++++++++------------------------
 3 files changed, 28 insertions(+), 28 deletions(-)


===================================================================



diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	Sat Dec 27 00:27:38 2003
+++ b/drivers/base/firmware_class.c	Sat Dec 27 00:27:38 2003
@@ -25,6 +25,7 @@
 #define FW_STATE_LOADED		0
 #define FW_STATE_LOADING	1
 #define FW_STATE_NEW		2
+#define FW_STATE_READY		3
 
 static int loading_timeout = 10;	/* In seconds */
 
@@ -81,6 +82,9 @@
 	int i = 0;
 	char *scratch = buffer;
 
+	if (fw_priv->state != FW_STATE_READY)
+		return -ENODEV;
+
 	if (buffer_size < (FIRMWARE_NAME_MAX + 10))
 		return -ENOMEM;
 	if (num_envp < 1)
@@ -356,6 +360,7 @@
 		goto err_out_unregister;
 	}
 
+	fw_priv->state = FW_STATE_READY;
 	*class_dev_p = class_dev;
 	return 0;
 
@@ -402,6 +407,7 @@
 		add_timer(&fw_priv->timeout);
 	}
 
+	kobject_hotplug("add", &class_dev->kobj);
 	wait_for_completion(&fw_priv->completion);
 
 	del_timer(&fw_priv->timeout);
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Sat Dec 27 00:27:38 2003
+++ b/include/linux/kobject.h	Sat Dec 27 00:27:38 2003
@@ -56,6 +56,7 @@
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
+extern void kobject_hotplug(const char *action, struct kobject *);
 
 struct kobj_type {
 	void (*release)(struct kobject *);
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Sat Dec 27 00:27:38 2003
+++ b/lib/kobject.c	Sat Dec 27 00:27:38 2003
@@ -198,9 +198,24 @@
 	kfree(envp);
 	return;
 }
+
+void kobject_hotplug(const char *action, struct kobject *kobj)
+{
+	struct kobject * top_kobj = kobj;
+
+	/* If this kobj does not belong to a kset,
+	   try to find a parent that does. */
+	if (!top_kobj->kset && top_kobj->parent) {
+		do {
+			top_kobj = top_kobj->parent;
+		} while (!top_kobj->kset && top_kobj->parent);
+	}
+
+	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
+		kset_hotplug(action, top_kobj->kset, kobj);
+}
 #else
-static void kset_hotplug(const char *action, struct kset *kset,
-			 struct kobject *kobj)
+void kobject_hotplug(const char *action, struct kobject *kobj)
 {
 	return;
 }
@@ -248,7 +263,6 @@
 {
 	int error = 0;
 	struct kobject * parent;
-	struct kobject * top_kobj;
 
 	if (!(kobj = kobject_get(kobj)))
 		return -ENOENT;
@@ -277,18 +291,9 @@
 		if (parent)
 			kobject_put(parent);
 	} else {
-		/* If this kobj does not belong to a kset,
-		   try to find a parent that does. */
-		top_kobj = kobj;
-		if (!top_kobj->kset && top_kobj->parent) {
-			do {
-				top_kobj = top_kobj->parent;
-			} while (!top_kobj->kset && top_kobj->parent);
-		}
-	
-		if (top_kobj->kset && top_kobj->kset->hotplug_ops)
-			kset_hotplug("add", top_kobj->kset, kobj);
+		kobject_hotplug("add", kobj);
 	}
+
 	return error;
 }
 
@@ -396,20 +401,7 @@
 
 void kobject_del(struct kobject * kobj)
 {
-	struct kobject * top_kobj;
-
-	/* If this kobj does not belong to a kset,
-	   try to find a parent that does. */
-	top_kobj = kobj;
-	if (!top_kobj->kset && top_kobj->parent) {
-		do {
-			top_kobj = top_kobj->parent;
-		} while (!top_kobj->kset && top_kobj->parent);
-	}
-
-	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
-		kset_hotplug("remove", top_kobj->kset, kobj);
-
+	kobject_hotplug("remove", kobj);
 	sysfs_remove_dir(kobj);
 	unlink(kobj);
 }
@@ -638,6 +630,7 @@
 EXPORT_SYMBOL(kobject_unregister);
 EXPORT_SYMBOL(kobject_get);
 EXPORT_SYMBOL(kobject_put);
+EXPORT_SYMBOL(kobject_hotplug);
 
 EXPORT_SYMBOL(kset_register);
 EXPORT_SYMBOL(kset_unregister);
