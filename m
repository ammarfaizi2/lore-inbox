Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUDBW3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUDBW3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:29:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59378 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261231AbUDBW3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:29:00 -0500
Date: Fri, 2 Apr 2004 14:28:38 -0800
From: Todd Poynor <tpoynor@mvista.com>
To: mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Device suspend/resume fixes
Message-ID: <20040402222838.GB2423@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case some changes to device handling during suspend/resume are
welcome:

(1) Set device power state at runtime resume (as is done for runtime
suspend) so that a later suspend does not think the device is still
suspended.

(2) Move devices from active to off list only when suspending all
devices, not for runtime suspend, to match resume handling, and to
avoid reordering the device list (which is in order of registration
and suspend/resume works best that way).

(3) Flush signals between resume handlers in case a resume function
causes, for example, an ECHILD from modprobe or hotplug, so
interruptible APIs for the next handler aren't affected.


--- linux-2.6.4-orig/drivers/base/power/suspend.c	2004-03-11 14:57:55.000000000 -0800
+++ linux-2.6.4-pm/drivers/base/power/suspend.c	2004-04-02 14:07:31.188415120 -0800
@@ -42,13 +42,6 @@
 	if (dev->bus && dev->bus->suspend)
 		error = dev->bus->suspend(dev,state);
 
-	if (!error) {
-		list_del(&dev->power.entry);
-		list_add(&dev->power.entry,&dpm_off);
-	} else if (error == -EAGAIN) {
-		list_del(&dev->power.entry);
-		list_add(&dev->power.entry,&dpm_off_irq);
-	}
 	return error;
 }
 
@@ -81,12 +74,16 @@
 	while(!list_empty(&dpm_active)) {
 		struct list_head * entry = dpm_active.prev;
 		struct device * dev = to_device(entry);
-		if ((error = suspend_device(dev,state))) {
-			if (error != -EAGAIN)
-				goto Error;
-			else
-				error = 0;
-		}
+		error = suspend_device(dev,state);
+
+		if (!error) {
+			list_del(&dev->power.entry);
+			list_add(&dev->power.entry,&dpm_off);
+		} else if (error == -EAGAIN) {
+			list_del(&dev->power.entry);
+			list_add(&dev->power.entry,&dpm_off_irq);
+		} else
+			goto Error;
 	}
  Done:
 	up(&dpm_sem);
--- linux-2.6.4-orig/drivers/base/power/resume.c	2004-03-11 14:57:55.000000000 -0800
+++ linux-2.6.4-pm/drivers/base/power/resume.c	2004-04-02 14:07:29.425683096 -0800
@@ -37,6 +37,7 @@
 		list_del_init(entry);
 		resume_device(dev);
 		list_add_tail(entry,&dpm_active);
+		flush_signals(current);
 	}
 }
 
--- linux-2.6.4-orig/drivers/base/power/runtime.c	2004-03-11 15:02:22.000000000 -0800
+++ linux-2.6.4-pm/drivers/base/power/runtime.c	2004-04-02 14:23:31.400440704 -0800
@@ -12,9 +12,14 @@
 
 static void runtime_resume(struct device * dev)
 {
+	int error;
+
 	if (!dev->power.power_state)
 		return;
-	resume_device(dev);
+	if (!(error = resume_device(dev)))
+		dev->power.power_state = 0;
+
+	return error;
 }


-- 
Todd Poynor
MontaVista Software

