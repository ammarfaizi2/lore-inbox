Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVCJBQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVCJBQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVCJBNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:13:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:41119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262604AbVCJAmW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:22 -0500
Cc: gregkh@suse.de
Subject: [PATCH] kset: make ksets have a spinlock, and use that to lock their lists
In-Reply-To: <11104148852544@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:45 -0800
Message-Id: <111041488554@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2048, 2005/03/09 09:53:28-08:00, gregkh@suse.de

[PATCH] kset: make ksets have a spinlock, and use that to lock their lists

Do this instead of using the rwsem of a subsys.
Smaller, faster, and I'm trying to get rid of the rwsem in the subsys.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/kobject.h |    2 ++
 lib/kobject.c           |   13 +++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2005-03-09 16:28:52 -08:00
+++ b/include/linux/kobject.h	2005-03-09 16:28:52 -08:00
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/sysfs.h>
+#include <linux/spinlock.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
 #include <linux/kobject_uevent.h>
@@ -102,6 +103,7 @@
 	struct subsystem	* subsys;
 	struct kobj_type	* ktype;
 	struct list_head	list;
+	spinlock_t		list_lock;
 	struct kobject		kobj;
 	struct kset_hotplug_ops	* hotplug_ops;
 };
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2005-03-09 16:28:52 -08:00
+++ b/lib/kobject.c	2005-03-09 16:28:52 -08:00
@@ -140,9 +140,9 @@
 static void unlink(struct kobject * kobj)
 {
 	if (kobj->kset) {
-		down_write(&kobj->kset->subsys->rwsem);
+		spin_lock(&kobj->kset->list_lock);
 		list_del_init(&kobj->entry);
-		up_write(&kobj->kset->subsys->rwsem);
+		spin_unlock(&kobj->kset->list_lock);
 	}
 	kobject_put(kobj);
 }
@@ -168,13 +168,13 @@
 		 kobj->kset ? kobj->kset->kobj.name : "<NULL>" );
 
 	if (kobj->kset) {
-		down_write(&kobj->kset->subsys->rwsem);
+		spin_lock(&kobj->kset->list_lock);
 
 		if (!parent)
 			parent = kobject_get(&kobj->kset->kobj);
 
 		list_add_tail(&kobj->entry,&kobj->kset->list);
-		up_write(&kobj->kset->subsys->rwsem);
+		spin_unlock(&kobj->kset->list_lock);
 	}
 	kobj->parent = parent;
 
@@ -380,6 +380,7 @@
 {
 	kobject_init(&k->kobj);
 	INIT_LIST_HEAD(&k->list);
+	spin_lock_init(&k->list_lock);
 }
 
 
@@ -444,7 +445,7 @@
 	struct list_head * entry;
 	struct kobject * ret = NULL;
 
-	down_read(&kset->subsys->rwsem);
+	spin_lock(&kset->list_lock);
 	list_for_each(entry,&kset->list) {
 		struct kobject * k = to_kobj(entry);
 		if (kobject_name(k) && !strcmp(kobject_name(k),name)) {
@@ -452,7 +453,7 @@
 			break;
 		}
 	}
-	up_read(&kset->subsys->rwsem);
+	spin_unlock(&kset->list_lock);
 	return ret;
 }
 

