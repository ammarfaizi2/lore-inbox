Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUEZALP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUEZALP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 20:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUEZALP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 20:11:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18419 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265269AbUEZALI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 20:11:08 -0400
Date: Tue, 25 May 2004 17:11:03 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: greg@kroah.com, mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Device runtime suspend/resume fixes
Message-ID: <20040526001103.GA4845@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1) Set device power state at runtime resume (as is done for runtime
suspend) so that a later suspend does not think the device is still
suspended (refusing to suspend it again).

(2) Move devices from the active list to the off list only when
suspending all devices as part of a system suspend, not for runtime
suspend.  This matches the resume code, which only moves devices from
off to active during system resume, such that runtime resume currently
doesn't move the suspended device back to the active list.  (This also
avoids reordering the device list for runtime suspends; the list is in
order of registration and suspend/resume works best that way -- granted,
more sweeping improvements in how device dependencies are accounted for
in the suspend/resume order are also needed someday.)

Runtime device suspend/resume is in some cases used frequently on
battery-powered embedded devices, to save additional power and to handle
device power state interactions with overall system power state on
certain platforms.

--- linux-2.6.6-orig/drivers/base/power/suspend.c	2004-05-10 11:22:58.000000000 -0700
+++ linux-2.6.6-pm/drivers/base/power/suspend.c	2004-05-23 00:07:51.000000000 -0700
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

--- linux-2.6.6-orig/drivers/base/power/runtime.c	2004-05-10 11:22:58.000000000 -0700
+++ linux-2.6.6-pm/drivers/base/power/runtime.c	2004-05-25 16:07:57.254838016 -0700
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
Todd
