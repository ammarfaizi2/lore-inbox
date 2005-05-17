Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVEQWUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVEQWUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVEQWTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:19:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:41893 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262012AbVEQWMV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:12:21 -0400
Cc: david-b@pacbell.net
Subject: [PATCH] Driver Core: pm diagnostics update, check for errors
In-Reply-To: <20050517221136.GA29232@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 17 May 2005 15:12:25 -0700
Message-Id: <1116367945543@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: pm diagnostics update, check for errors

This patch includes various tweaks in the messaging that appears during
system pm state transitions:

  * Warn about certain illegal calls in the device tree, like resuming
    child before parent or suspending parent before child.  This could
    happen easily enough through sysfs, or in some cases when drivers
    use device_pm_set_parent().

  * Be more consistent about dev_dbg() tracing ... do it for resume() and
    shutdown() too, and never if the driver doesn't have that method.

  * Say which type of system sleep state is being entered.

Except for the warnings, these only affect debug messaging.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 82428b62aa6294ea640c7e920a9224ecaf46db65
tree f9e9bfd1f86f739ee16968378057060417f52bb4
parent ff0d2f90fdc4b564d47a7c26b16de81a16cfa28e
author David Brownell <david-b@pacbell.net> Mon, 09 May 2005 08:07:00 -0700
committer Greg KH <gregkh@suse.de> Tue, 17 May 2005 14:54:54 -0700

 drivers/base/power/resume.c   |   11 ++++++++++-
 drivers/base/power/shutdown.c |   13 +++++++------
 drivers/base/power/suspend.c  |   17 +++++++++++++++--
 kernel/power/main.c           |    6 +++---
 4 files changed, 35 insertions(+), 12 deletions(-)

Index: drivers/base/power/resume.c
===================================================================
--- 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/drivers/base/power/resume.c  (mode:100644)
+++ f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/power/resume.c  (mode:100644)
@@ -22,8 +22,17 @@
 
 int resume_device(struct device * dev)
 {
-	if (dev->bus && dev->bus->resume)
+	if (dev->power.pm_parent
+			&& dev->power.pm_parent->power.power_state) {
+		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
+			dev->power.power_state,
+			dev->power.pm_parent->bus_id,
+			dev->power.pm_parent->power.power_state);
+	}
+	if (dev->bus && dev->bus->resume) {
+		dev_dbg(dev,"resuming\n");
 		return dev->bus->resume(dev);
+	}
 	return 0;
 }
 
Index: drivers/base/power/shutdown.c
===================================================================
--- 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/drivers/base/power/shutdown.c  (mode:100644)
+++ f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/power/shutdown.c  (mode:100644)
@@ -25,8 +25,10 @@
 		return 0;
 
 	if (dev->detach_state == DEVICE_PM_OFF) {
-		if (dev->driver && dev->driver->shutdown)
+		if (dev->driver && dev->driver->shutdown) {
+			dev_dbg(dev, "shutdown\n");
 			dev->driver->shutdown(dev);
+		}
 		return 0;
 	}
 	return dpm_runtime_suspend(dev, dev->detach_state);
@@ -52,13 +54,12 @@
 	struct device * dev;
 
 	down_write(&devices_subsys.rwsem);
-	list_for_each_entry_reverse(dev, &devices_subsys.kset.list, kobj.entry) {
-		pr_debug("shutting down %s: ", dev->bus_id);
+	list_for_each_entry_reverse(dev, &devices_subsys.kset.list,
+				kobj.entry) {
 		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("Ok\n");
+			dev_dbg(dev, "shutdown\n");
 			dev->driver->shutdown(dev);
-		} else
-			pr_debug("Ignored.\n");
+		}
 	}
 	up_write(&devices_subsys.rwsem);
 
Index: drivers/base/power/suspend.c
===================================================================
--- 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/drivers/base/power/suspend.c  (mode:100644)
+++ f9e9bfd1f86f739ee16968378057060417f52bb4/drivers/base/power/suspend.c  (mode:100644)
@@ -39,12 +39,25 @@
 {
 	int error = 0;
 
-	dev_dbg(dev, "suspending\n");
+	if (dev->power.power_state) {
+		dev_dbg(dev, "PM: suspend %d-->%d\n",
+			dev->power.power_state, state);
+	}
+	if (dev->power.pm_parent
+			&& dev->power.pm_parent->power.power_state) {
+		dev_err(dev,
+			"PM: suspend %d->%d, parent %s already %d\n",
+			dev->power.power_state, state,
+			dev->power.pm_parent->bus_id,
+			dev->power.pm_parent->power.power_state);
+	}
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && !dev->power.power_state) {
+		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
+	}
 
 	return error;
 }
Index: kernel/power/main.c
===================================================================
--- 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/kernel/power/main.c  (mode:100644)
+++ f9e9bfd1f86f739ee16968378057060417f52bb4/kernel/power/main.c  (mode:100644)
@@ -156,14 +156,14 @@
 		goto Unlock;
 	}
 
-	pr_debug("PM: Preparing system for suspend\n");
+	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
 
-	pr_debug("PM: Entering state.\n");
+	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
 	error = suspend_enter(state);
 
-	pr_debug("PM: Finishing up.\n");
+	pr_debug("PM: Finishing wakeup.\n");
 	suspend_finish(state);
  Unlock:
 	up(&pm_sem);

