Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUEKBDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUEKBDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 21:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUEKBDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 21:03:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53752 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263000AbUEKBAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 21:00:21 -0400
Date: Mon, 10 May 2004 18:00:15 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Hotplug events for system suspend/resume
Message-ID: <20040511010015.GA21831@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generate synchronous hotplug events for system suspend and resume
events, via the power subsystem.  Recent discussions have indicated
various methods for notification of these events are in use today; this
is an attempt to move these into the generic power subsystem.  The patch
relies on the "synchronous hotplug events via kobject" patch sent
previously.

I fumbled around with the best to way to hook this into kobject.
Subsystems apparently aren't setup to generate hotplug events directly,
only kobjects below a subsystem may issue hotplug events.  A notifier
kobject has been created within the power subsystem for this purpose.
Any advice welcome.

Thanks -- Todd

--- linux-2.6.6-orig/kernel/power/main.c	2004-05-10 11:26:35.000000000 -0700
+++ linux-2.6.6-pm/kernel/power/main.c	2004-05-10 17:25:30.000000000 -0700
@@ -25,6 +25,9 @@
 
 struct pm_ops * pm_ops = NULL;
 u32 pm_disk_mode = PM_DISK_SHUTDOWN;
+int pm_state = PM_SUSPEND_ON;
+
+static void power_notify(void);
 
 /**
  *	pm_set_ops - Set the global power method table. 
@@ -150,20 +153,26 @@
 		goto Unlock;
 	}
 
+	pm_state = state;
+	power_notify();
+
 	if (state == PM_SUSPEND_DISK) {
 		error = pm_suspend_disk();
-		goto Unlock;
+		goto NotifyUnlock;
 	}
 
 	pr_debug("PM: Preparing system for suspend\n");
 	if ((error = suspend_prepare(state)))
-		goto Unlock;
+		goto NotifyUnlock;
 
 	pr_debug("PM: Entering state.\n");
 	error = suspend_enter(state);
 
 	pr_debug("PM: Finishing up.\n");
 	suspend_finish(state);
+ NotifyUnlock:
+	pm_state = PM_SUSPEND_ON;
+	power_notify();
  Unlock:
 	up(&pm_sem);
 	return error;
@@ -186,8 +195,28 @@
 }
 
 
+static int power_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+			 int num_envp, char *buffer, int buffer_size)
+{
+	int i = 0;
+	int length = 0;
 
-decl_subsys(power,NULL,NULL);
+	envp[i++] = buffer;
+	length += scnprintf (buffer, buffer_size - length, "STATE=%s",
+			     pm_states[pm_state] ? pm_states[pm_state] : "on");
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+
+	envp[i] = 0;
+	return 0;
+}
+
+static struct kset_hotplug_ops power_hotplug_ops = {
+	.hotplug =	power_hotplug,
+};
+
+decl_subsys(power,NULL,&power_hotplug_ops);
 
 
 /**
@@ -247,12 +276,28 @@
 	.attrs = g,
 };
 
+struct power_notifier {
+	struct kobject kobj;
+};
+
+static struct power_notifier power_notifier;
+
+static void power_notify()
+{
+	kobject_hotplug_wait("state-change", &power_notifier.kobj);
+}
 
 static int __init pm_init(void)
 {
 	int error = subsystem_register(&power_subsys);
 	if (!error)
 		error = sysfs_create_group(&power_subsys.kset.kobj,&attr_group);
+	if (!error) {
+		kobj_set_kset_s(&power_notifier, power_subsys);
+		error = kobject_set_name(&power_notifier.kobj, "notifier");
+		if (! error)
+			kobject_register(&power_notifier.kobj);
+	}
 	return error;
 }

