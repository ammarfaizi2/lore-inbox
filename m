Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936437AbWK3U6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936437AbWK3U6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936438AbWK3U6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:58:53 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:62639 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S936437AbWK3U6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:58:52 -0500
Message-ID: <456F4607.3000300@indt.org.br>
Date: Thu, 30 Nov 2006 16:58:47 -0400
From: Mauricio Lin <mauricio.lin@indt.org.br>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH 2.6.19] kobject: kobject_uevent() returns manageable value
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2006 20:58:35.0721 (UTC) FILETIME=[4D589390:01C714C2]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.19] kobject: kobject_uevent() returns manageable value

Since kobject_uevent() function does not return an integer value to
indicate if its operation was completed with success or not, it is
worth changing it in order to report a proper status (success or
error) instead of returning void.

Keep kobject_uevent() returning the status as integer provide a easier
way for detecting possible failure in the function. Using void
returning style may take people to waste more time to figure out if
the "send to" or "receive from" an event is a bug in the kernel or
user space. Furthermore, the current way to detect where the error is
taking place in the kobject_uevent() requires additional inclusion of
printk() in each "if" condition that can lead to failure.

Signed-off-by: Mauricio Lin <mauricio.lin@indt.org.br>

Index: kernel/linux-2.6.19-rc6/include/linux/kobject.h
===================================================================
--- linux-2.6.19-rc6.orig/include/linux/kobject.h	2006-11-29 16:15:19.000000000 -0400
+++ linux-2.6.19-rc6/include/linux/kobject.h	2006-11-29 16:22:40.000000000 -0400
@@ -263,14 +263,17 @@
 					struct subsys_attribute *);
 
 #if defined(CONFIG_HOTPLUG)
-void kobject_uevent(struct kobject *kobj, enum kobject_action action);
+int kobject_uevent(struct kobject *kobj, enum kobject_action action);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,
 			char *buffer, int buffer_size, int *cur_len,
 			const char *format, ...)
 	__attribute__((format (printf, 7, 8)));
 #else
-static inline void kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
+static inline int kobject_uevent(struct kobject *kobj, enum kobject_action action)
+{
+	return 0;
+}
 
 static inline int add_uevent_var(char **envp, int num_envp, int *cur_index,
 				      char *buffer, int buffer_size, int *cur_len, 
Index: kernel/linux-2.6.19-rc6/lib/kobject_uevent.c
===================================================================
--- linux-2.6.19-rc6.orig/lib/kobject_uevent.c	2006-11-29 16:15:12.000000000 -0400
+++ linux-2.6.19-rc6/lib/kobject_uevent.c	2006-11-29 16:31:16.000000000 -0400
@@ -60,8 +60,11 @@
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
 	char **envp;
 	char *buffer;
@@ -81,7 +84,7 @@
 
 	action_string = action_to_string(action);
 	if (!action_string)
-		return;
+		return -EINVAL;
 
 	/* search the kset we belong to */
 	top_kobj = kobj;
@@ -91,7 +94,7 @@
 		} while (!top_kobj->kset && top_kobj->parent);
 	}
 	if (!top_kobj->kset)
-		return;
+		return -EINVAL;
 
 	kset = top_kobj->kset;
 	uevent_ops = kset->uevent_ops;
@@ -99,22 +102,27 @@
 	/*  skip the event, if the filter returns zero. */
 	if (uevent_ops && uevent_ops->filter)
 		if (!uevent_ops->filter(kset, kobj))
-			return;
+			return -EINVAL;
 
 	/* environment index */
 	envp = kzalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
-		return;
+		return -ENOMEM;
 
 	/* environment values */
 	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
-	if (!buffer)
-		goto exit;
+	if (!buffer) {
+		kfree(envp);
+		return -ENOMEM;
+	}
 
 	/* complete object path */
 	devpath = kobject_get_path(kobj, GFP_KERNEL);
-	if (!devpath)
-		goto exit;
+	if (!devpath) {
+		kfree(envp);
+		kfree(buffer);
+		return -ENOMEM;
+	}
 
 	/* originating subsystem */
 	if (uevent_ops && uevent_ops->name)
@@ -179,7 +187,11 @@
 			}
 
 			NETLINK_CB(skb).dst_group = 1;
-			netlink_broadcast(uevent_sock, skb, 0, 1, GFP_KERNEL);
+			retval = netlink_broadcast(uevent_sock, skb, 0, 1,
+						   GFP_KERNEL);
+			if (retval)
+				pr_debug ("%s - netlink_broadcast() returned "
+					  "%d\n", __FUNCTION__, retval);
 		}
 	}
 #endif
@@ -198,7 +210,7 @@
 	kfree(devpath);
 	kfree(buffer);
 	kfree(envp);
-	return;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(kobject_uevent);
 
