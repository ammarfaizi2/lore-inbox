Return-Path: <linux-kernel-owner+w=401wt.eu-S932164AbWLLJ3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWLLJ3I (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWLLJ3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:29:07 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:31526 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932164AbWLLJ3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:29:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=jJILS1YlqDIQvtM5SNI1VVubWcr9v94Ti9mC1aRRRpdegZ/MtAF9RCHwr5HSyVDuu3Bf+KdCX8sbi0wBJspQgBaeeh4U9Cq8nWqOKQ4DsS1H7XdLVuaz7zotuHV8Ll7+Yytp8bprcAWi0/6ENqawDlU1dDBSNlZsP/EYIIF8zPo=
Message-ID: <457E764D.8000805@gmail.com>
Date: Tue, 12 Dec 2006 14:58:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: kobject_uevent() returns manageable value
Content-Type: multipart/mixed;
 boundary="------------020208030802010903030703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020208030802010903030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------020208030802010903030703
Content-Type: text/plain;
 name*0="0001-kobject-kobject_uevent-returns-manageable-value.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-kobject-kobject_uevent-returns-manageable-value.txt"

Since kobject_uevent() function does not return an integer value to
indicate if its operation was completed with success or not, it is
worth changing it in order to report a proper status (success or
error) instead of returning void.

CC: Mauricio Lin <mauriciolin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 include/linux/kobject.h |    8 ++++----
 lib/kobject_uevent.c    |   44 ++++++++++++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index d1c8d28..fc93c53 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -265,8 +265,8 @@ extern int __must_check subsys_create_file(struct subsystem * ,
 					struct subsys_attribute *);
 
 #if defined(CONFIG_HOTPLUG)
-void kobject_uevent(struct kobject *kobj, enum kobject_action action);
-void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
+int kobject_uevent(struct kobject *kobj, enum kobject_action action);
+int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 			char *envp[]);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,
@@ -274,8 +274,8 @@ int add_uevent_var(char **envp, int num_envp, int *cur_index,
 			const char *format, ...)
 	__attribute__((format (printf, 7, 8)));
 #else
-static inline void kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
-static inline void kobject_uevent_env(struct kobject *kobj,
+static inline int kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
+static inline int kobject_uevent_env(struct kobject *kobj,
 				      enum kobject_action action,
 				      char *envp[])
 { }
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index a192276..84272ed 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -63,8 +63,11 @@ static char *action_to_string(enum kobject_action action)
  * @action: action that is happening (usually KOBJ_MOVE)
  * @kobj: struct kobject that the action is happening to
  * @envp_ext: pointer to environmental data
+ *
+ * Returns 0 if kobject_uevent() is completed with success or the
+ * corresponding error when it fails.
  */
-void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
+int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 			char *envp_ext[])
 {
 	char **envp;
@@ -79,14 +82,16 @@ void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	u64 seq;
 	char *seq_buff;
 	int i = 0;
-	int retval;
+	int retval = 0;
 	int j;
 
 	pr_debug("%s\n", __FUNCTION__);
 
 	action_string = action_to_string(action);
-	if (!action_string)
-		return;
+	if (!action_string) {
+		pr_debug("kobject attempted to send uevent without action_string!\n");
+		return -EINVAL;
+	}
 
 	/* search the kset we belong to */
 	top_kobj = kobj;
@@ -95,31 +100,39 @@ void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 			top_kobj = top_kobj->parent;
 		} while (!top_kobj->kset && top_kobj->parent);
 	}
-	if (!top_kobj->kset)
-		return;
+	if (!top_kobj->kset) {
+		pr_debug("kobject attempted to send uevent without kset!\n");
+		return -EINVAL;
+	}
 
 	kset = top_kobj->kset;
 	uevent_ops = kset->uevent_ops;
 
 	/*  skip the event, if the filter returns zero. */
 	if (uevent_ops && uevent_ops->filter)
-		if (!uevent_ops->filter(kset, kobj))
-			return;
+		if (!uevent_ops->filter(kset, kobj)) {
+			pr_debug("kobject filter function caused the event to drop!\n");
+			return 0;
+		}
 
 	/* environment index */
 	envp = kzalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
-		return;
+		return -ENOMEM;
 
 	/* environment values */
 	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
-	if (!buffer)
+	if (!buffer) {
+		retval = -ENOMEM;
 		goto exit;
+	}
 
 	/* complete object path */
 	devpath = kobject_get_path(kobj, GFP_KERNEL);
-	if (!devpath)
+	if (!devpath) {
+		retval = -ENOENT;
 		goto exit;
+	}
 
 	/* originating subsystem */
 	if (uevent_ops && uevent_ops->name)
@@ -204,7 +217,7 @@ exit:
 	kfree(devpath);
 	kfree(buffer);
 	kfree(envp);
-	return;
+	return retval;
 }
 
 EXPORT_SYMBOL_GPL(kobject_uevent_env);
@@ -214,10 +227,13 @@ EXPORT_SYMBOL_GPL(kobject_uevent_env);
  *
  * @action: action that is happening (usually KOBJ_ADD and KOBJ_REMOVE)
  * @kobj: struct kobject that the action is happening to
+ *
+ * Returns 0 if kobject_uevent() is completed with success or the
+ * corresponding error when it fails.
  */
-void kobject_uevent(struct kobject *kobj, enum kobject_action action)
+int kobject_uevent(struct kobject *kobj, enum kobject_action action)
 {
-	kobject_uevent_env(kobj, action, NULL);
+	return kobject_uevent_env(kobj, action, NULL);
 }
 
 EXPORT_SYMBOL_GPL(kobject_uevent);
-- 
1.4.4.2.gdb98-dirty


--------------020208030802010903030703--
