Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUHFUnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUHFUnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268291AbUHFUnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:43:09 -0400
Received: from peabody.ximian.com ([130.57.169.10]:38530 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268289AbUHFUlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:41:47 -0400
Subject: [patch] add kobject_get_path
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1091824013.7939.66.camel@betsy>
References: <1091824013.7939.66.camel@betsy>
Content-Type: text/plain
Date: Fri, 06 Aug 2004 16:41:43 -0400
Message-Id: <1091824903.7939.80.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg -

Hey, here is an alternative to exporting those two functions.

This patch, in lieu, creates a new function that performs the same steps
as in kset_hotplug() and presumably what every single user of the
previously exported functions would do: get the length, allocate memory,
and then build the path.

So just export a single function to do it right.  And use it in
kset_hotplug().  The function is prototyped as

	char * kobject_get_path(struct kset *kset, struct kobject *kobj,
				int gfp_mask)

I like this approach better.

Patch is against 2.6.8-rc3.

	Robert Love


Create a new kobject_get_path() helper function, which is super duper.
Signed-Off-By: Robert Love <rml@novell.com>

 include/linux/kobject.h |    2 ++
 lib/kobject.c           |   31 +++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff -urN linux-2.6.8-rc3-mm1/include/linux/kobject.h linux/include/linux/kobject.h
--- linux-2.6.8-rc3-mm1/include/linux/kobject.h	2004-08-06 14:03:04.882742673 -0400
+++ linux/include/linux/kobject.h	2004-08-06 16:25:02.797522366 -0400
@@ -58,6 +58,8 @@
 
 extern void kobject_hotplug(const char *action, struct kobject *);
 
+extern char * kobject_get_path(struct kset *, struct kobject *, int);
+
 struct kobj_type {
 	void (*release)(struct kobject *);
 	struct sysfs_ops	* sysfs_ops;
diff -urN linux-2.6.8-rc3-mm1/lib/kobject.c linux/lib/kobject.c
--- linux-2.6.8-rc3-mm1/lib/kobject.c	2004-08-06 14:03:06.229569894 -0400
+++ linux/lib/kobject.c	2004-08-06 16:36:03.834757764 -0400
@@ -103,6 +103,29 @@
 static unsigned long sequence_num;
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 
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
+	len = get_kobj_path_length (kset, kobj);
+	path = kmalloc (len, gfp_mask);
+	if (!path)
+		return NULL;
+	memset (path, 0x00, len);
+	fill_kobj_path (kset, kobj, path, len);
+
+	return path;
+}
+
 static void kset_hotplug(const char *action, struct kset *kset,
 			 struct kobject *kobj)
 {
@@ -112,7 +135,6 @@
 	char *scratch;
 	int i = 0;
 	int retval;
-	int kobj_path_length;
 	char *kobj_path = NULL;
 	char *name = NULL;
 	unsigned long seq;
@@ -163,12 +185,9 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
 
-	kobj_path_length = get_kobj_path_length (kset, kobj);
-	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);
+	kobj_path = kobject_get_path (kset, kobj, GFP_KERNEL);
 	if (!kobj_path)
 		goto exit;
-	memset (kobj_path, 0x00, kobj_path_length);
-	fill_kobj_path (kset, kobj, kobj_path, kobj_path_length);
 
 	envp [i++] = scratch;
 	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
@@ -626,7 +645,7 @@
 	}
 }
 
-
+EXPORT_SYMBOL(kobject_get_path);
 EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
 EXPORT_SYMBOL(kobject_unregister);


