Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUATBQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265423AbUATBOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:14:48 -0500
Received: from mail.kroah.org ([65.200.24.183]:36809 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265363AbUATBMz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:55 -0500
Subject: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <20040120011036.GA6162@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:38 -0800
Message-Id: <10745611583988@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1495, 2004/01/19 16:21:50-08:00, dtor_core@ameritech.net

[PATCH] kobject: make kobject hotplug function public

make kobject hotplug mechanism public so that others may call it.


 include/linux/kobject.h |    1 
 lib/kobject.c           |   49 ++++++++++++++++++++----------------------------
 2 files changed, 22 insertions(+), 28 deletions(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Mon Jan 19 17:05:23 2004
+++ b/include/linux/kobject.h	Mon Jan 19 17:05:23 2004
@@ -56,6 +56,7 @@
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
+extern void kobject_hotplug(const char *action, struct kobject *);
 
 struct kobj_type {
 	void (*release)(struct kobject *);
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Mon Jan 19 17:05:23 2004
+++ b/lib/kobject.c	Mon Jan 19 17:05:23 2004
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

