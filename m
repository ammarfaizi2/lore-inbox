Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUHYWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUHYWuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUHYWrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:47:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:37787 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266466AbUHYWhE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:04 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733871723@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:27 -0700
Message-Id: <1093473387435@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.64.2, 2004/08/06 14:18:50-07:00, rml@ximian.com

[PATCH] KOBJECT: add kobject_get_path

Add a new kobject helper, kobject_get_path(), which is the greatest
function ever.

Signed-Off-By: Robert Love <rml@ximian.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/kobject.h |    2 ++
 lib/kobject.c           |   36 +++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-08-25 14:57:25 -07:00
+++ b/include/linux/kobject.h	2004-08-25 14:57:25 -07:00
@@ -58,6 +58,8 @@
 
 extern void kobject_hotplug(const char *action, struct kobject *);
 
+extern char * kobject_get_path(struct kset *, struct kobject *, int);
+
 struct kobj_type {
 	void (*release)(struct kobject *);
 	struct sysfs_ops	* sysfs_ops;
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-08-25 14:57:25 -07:00
+++ b/lib/kobject.c	2004-08-25 14:57:25 -07:00
@@ -58,14 +58,11 @@
 	return error;
 }
 
-
 static inline struct kobject * to_kobj(struct list_head * entry)
 {
 	return container_of(entry,struct kobject,entry);
 }
 
-
-#ifdef CONFIG_HOTPLUG
 static int get_kobj_path_length(struct kset *kset, struct kobject *kobj)
 {
 	int length = 1;
@@ -98,6 +95,31 @@
 	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
 }
 
+/**
+ * kobject_get_path - generate and return the path associated with a given kobj
+ * and kset pair.  The result must be freed by the caller with kfree().
+ *
+ * @kset:	kset in question, with which to build the path
+ * @kobj:	kobject in question, with which to build the path
+ * @gfp_mask:	the allocation type used to allocate the path
+ */
+char * kobject_get_path(struct kset *kset, struct kobject *kobj, int gfp_mask)
+{
+	char *path;
+	int len;
+
+	len = get_kobj_path_length(kset, kobj);
+	path = kmalloc(len, gfp_mask);
+	if (!path)
+		return NULL;
+	memset(path, 0x00, len);
+	fill_kobj_path(kset, kobj, path, len);
+
+	return path;
+}
+
+#ifdef CONFIG_HOTPLUG
+
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
 static unsigned long sequence_num;
@@ -112,7 +134,6 @@
 	char *scratch;
 	int i = 0;
 	int retval;
-	int kobj_path_length;
 	char *kobj_path = NULL;
 	char *name = NULL;
 	unsigned long seq;
@@ -163,12 +184,9 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
 
-	kobj_path_length = get_kobj_path_length (kset, kobj);
-	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);
+	kobj_path = kobject_get_path(kset, kobj, GFP_KERNEL);
 	if (!kobj_path)
 		goto exit;
-	memset (kobj_path, 0x00, kobj_path_length);
-	fill_kobj_path (kset, kobj, kobj_path, kobj_path_length);
 
 	envp [i++] = scratch;
 	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
@@ -626,7 +644,7 @@
 	}
 }
 
-
+EXPORT_SYMBOL(kobject_get_path);
 EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
 EXPORT_SYMBOL(kobject_unregister);

