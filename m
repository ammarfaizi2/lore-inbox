Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUE1Vc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUE1Vc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUE1V3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:29:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:21933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262063AbUE1V0q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:46 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core fixes for 2.6.7-rc1
In-Reply-To: <10857795543295@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 28 May 2004 14:25:55 -0700
Message-Id: <10857795552945@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.7.4, 2004/05/28 10:04:18-07:00, tpoynor@mvista.com

[PATCH] Device runtime suspend/resume fixes

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

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/runtime.c |    5 ++++-
 drivers/base/power/suspend.c |   23 ++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)


diff -Nru a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
--- a/drivers/base/power/runtime.c	Fri May 28 14:18:15 2004
+++ b/drivers/base/power/runtime.c	Fri May 28 14:18:15 2004
@@ -14,7 +14,10 @@
 {
 	if (!dev->power.power_state)
 		return;
-	resume_device(dev);
+	if (! resume_device(dev))
+		dev->power.power_state = 0;
+
+	return;
 }
 
 
diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	Fri May 28 14:18:15 2004
+++ b/drivers/base/power/suspend.c	Fri May 28 14:18:15 2004
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

