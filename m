Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUHFU6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUHFU6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268294AbUHFU55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:57:57 -0400
Received: from peabody.ximian.com ([130.57.169.10]:47234 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268284AbUHFU4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:56:05 -0400
Subject: Re: [patch] add kobject_get_path
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040806205022.GA26135@kroah.com>
References: <1091824013.7939.66.camel@betsy>
	 <1091824903.7939.80.camel@betsy>  <20040806205022.GA26135@kroah.com>
Content-Type: text/plain
Date: Fri, 06 Aug 2004 16:56:03 -0400
Message-Id: <1091825763.7939.84.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 13:50 -0700, Greg KH wrote:

> I do too.  One problem though, get_kobj_path_length and fill_kobj_path
> are only built if CONFIG_HOTPLUG is enabled.  Care to respin this patch
> by moving the functions outside of that #define?

Hrm, did not notice that.  kobject_get_path() was inside there, too.

I presume these functions are still meaningful if !CONFIG_HOTPLUG?

Here we go.  Thanks,

	Robert Love


Add a new kobject helper, kobject_get_path(), which is the greatest
function ever.
Signed-Off-By: Robert Love <rml@ximian.com>

 include/linux/kobject.h |    2 ++
 lib/kobject.c           |   36 +++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

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
+++ linux/lib/kobject.c	2004-08-06 16:53:24.484278248 -0400
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
+	kobj_path = kobject_get_path (kset, kobj, GFP_KERNEL);
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


