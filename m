Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUEJUsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUEJUsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUEJUsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:48:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39407 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261602AbUEJUsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:48:18 -0400
Date: Mon, 10 May 2004 13:48:13 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: greg@kroah.com, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Synchronous hotplug for kobjects
Message-ID: <20040510204813.GA20691@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed recently, it's expected to be useful to generate
synchronous hotplug events from the kobject subsystem in certain
situations.  This patch adds a kobject_hotplug_wait function that issues
a synchronous call.  The function should be used for appropriate actions
that require synchronous semantics; please note many hotplug events
would suffer severe performance degradation if issued synchronously, and
one should exercise caution in choosing to use this function.

--- linux-2.6.6-orig/include/linux/kobject.h	2004-05-10 11:23:55.000000000 -0700
+++ linux-2.6.6-pm/include/linux/kobject.h	2004-05-10 11:41:25.000000000 -0700
@@ -57,6 +57,7 @@
 extern void kobject_put(struct kobject *);
 
 extern void kobject_hotplug(const char *action, struct kobject *);
+extern void kobject_hotplug_wait(const char *action, struct kobject *);
 
 struct kobj_type {
 	void (*release)(struct kobject *);
--- linux-2.6.6-orig/lib/kobject.c	2004-05-10 11:26:35.000000000 -0700
+++ linux-2.6.6-pm/lib/kobject.c	2004-05-10 13:20:35.389369032 -0700
@@ -104,7 +104,7 @@
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 
 static void kset_hotplug(const char *action, struct kset *kset,
-			 struct kobject *kobj)
+			 struct kobject *kobj, int wait)
 {
 	char *argv [3];
 	char **envp = NULL;
@@ -185,9 +185,9 @@
 		}
 	}
 
-	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
-		  envp[0], envp[1], envp[2], envp[3], envp[4]);
-	retval = call_usermodehelper (argv[0], argv, envp, 0);
+	pr_debug ("%s: %s %s %s %s %s %s %s %d\n", __FUNCTION__, argv[0], argv[1],
+		  envp[0], envp[1], envp[2], envp[3], envp[4], wait);
+	retval = call_usermodehelper (argv[0], argv, envp, wait);
 	if (retval)
 		pr_debug ("%s - call_usermodehelper returned %d\n",
 			  __FUNCTION__, retval);
@@ -199,7 +199,8 @@
 	return;
 }
 
-void kobject_hotplug(const char *action, struct kobject *kobj)
+static void kobject_hotplug_flags(const char *action, struct kobject *kobj,
+				  int wait)
 {
 	struct kobject * top_kobj = kobj;
 
@@ -212,13 +213,27 @@
 	}
 
 	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
-		kset_hotplug(action, top_kobj->kset, kobj);
+		kset_hotplug(action, top_kobj->kset, kobj, wait);
+}
+
+void kobject_hotplug(const char *action, struct kobject *kobj)
+{
+	kobject_hotplug_flags(action, kobj, 0);
+}
+
+void kobject_hotplug_wait(const char *action, struct kobject *kobj)
+{
+	kobject_hotplug_flags(action, kobj, 1);
 }
 #else
 void kobject_hotplug(const char *action, struct kobject *kobj)
 {
 	return;
 }
+void kobject_hotplug_wait(const char *action, struct kobject *kobj)
+{
+	return;
+}
 #endif	/* CONFIG_HOTPLUG */
 
 /**



-- 
Todd Poynor
MontaVista Software
