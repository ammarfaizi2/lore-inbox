Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUHFU3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUHFU3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268264AbUHFU2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:28:09 -0400
Received: from peabody.ximian.com ([130.57.169.10]:27266 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268283AbUHFU1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:27:00 -0400
Subject: [patch] export, rename fill_kobj_path and get_kobj_path_length
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 06 Aug 2004 16:26:53 -0400
Message-Id: <1091824013.7939.66.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Per our discussion, the following patch exports fill_kobj_path and
get_kobj_path_length and adds them to kobject.h.

I also renamed them to kobject_get_path_len and kobject_fill_path,
respectively, to match the name space.

I need these for a kobject-based kevent.  Others may find them
fascinating as well.

	Robert Love


Export some internal kobject helpers.
Signed-Off-By: Robert Love <rml@ximian.com>

 include/linux/kobject.h |    3 +++
 lib/kobject.c           |   12 +++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff -urN linux-2.6.8-rc3-mm1/include/linux/kobject.h linux-rml/include/linux/kobject.h
--- linux-2.6.8-rc3-mm1/include/linux/kobject.h	2004-08-06 14:03:04.882742673 -0400
+++ linux-rml/include/linux/kobject.h	2004-08-06 15:50:32.518075100 -0400
@@ -58,6 +58,9 @@
 
 extern void kobject_hotplug(const char *action, struct kobject *);
 
+extern int kobject_get_path_len(struct kset *, struct kobject *);
+extern void kobject_fill_path(struct kset *, struct kobject *, char *, int);
+
 struct kobj_type {
 	void (*release)(struct kobject *);
 	struct sysfs_ops	* sysfs_ops;
diff -urN linux-2.6.8-rc3-mm1/lib/kobject.c linux-rml/lib/kobject.c
--- linux-2.6.8-rc3-mm1/lib/kobject.c	2004-08-06 14:03:06.229569894 -0400
+++ linux-rml/lib/kobject.c	2004-08-06 16:11:14.450737875 -0400
@@ -66,7 +66,7 @@
 
 
 #ifdef CONFIG_HOTPLUG
-static int get_kobj_path_length(struct kset *kset, struct kobject *kobj)
+int kobject_get_path_len(struct kset *kset, struct kobject *kobj)
 {
 	int length = 1;
 	struct kobject * parent = kobj;
@@ -82,7 +82,8 @@
 	return length;
 }
 
-static void fill_kobj_path(struct kset *kset, struct kobject *kobj, char *path, int length)
+void kobject_fill_path(struct kset *kset, struct kobject *kobj, char *path,
+		       int length)
 {
 	struct kobject * parent;
 
@@ -163,12 +164,12 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
 
-	kobj_path_length = get_kobj_path_length (kset, kobj);
+	kobj_path_length = kobject_get_path_len (kset, kobj);
 	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);
 	if (!kobj_path)
 		goto exit;
 	memset (kobj_path, 0x00, kobj_path_length);
-	fill_kobj_path (kset, kobj, kobj_path, kobj_path_length);
+	kobject_fill_path (kset, kobj, kobj_path, kobj_path_length);
 
 	envp [i++] = scratch;
 	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
@@ -626,7 +627,8 @@
 	}
 }
 
-
+EXPORT_SYMBOL(kobject_get_path_len);
+EXPORT_SYMBOL(kobject_fill_path);
 EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
 EXPORT_SYMBOL(kobject_unregister);


