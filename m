Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbWBUA4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbWBUA4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWBUA4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:56:14 -0500
Received: from digitalimplant.org ([64.62.235.95]:15550 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1161243AbWBUAzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:55:48 -0500
Date: Mon, 20 Feb 2006 16:55:44 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com, "" <akpm@osdl.org>, "" <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@osdl.org>
Subject: [PATCH 3/4] [pm] Minor updates to core suspend/resume functions
Message-ID: <Pine.LNX.4.50.0602201653580.21145-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- Check the real state the device and parent are in compared
  to the the real state requested, instead of just checking
  that the event types are the same.

- Update debug and error messages to display the real states.

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/base/power/resume.c  |   11 +++++++----
 drivers/base/power/runtime.c |   11 ++++++-----
 drivers/base/power/suspend.c |   31 ++++++++++++++++++-------------
 3 files changed, 31 insertions(+), 22 deletions(-)

applies-to: fbdd2cb3f266f8a55b4dd147e487b59c3f214a97
57c9fcbb8ef7a5c52a23f44bb6037d7d99d0b170
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 317edbf..7f0bd09 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -25,16 +25,19 @@ int resume_device(struct device * dev)

 	down(&dev->sem);
 	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state.event) {
-		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
-			dev->power.power_state.event,
+	    && dev->power.pm_parent->power.power_state.state) {
+		dev_err(dev, "PM: resume from state %u, parent %s still in state %u\n",
+			dev->power.power_state.state,
 			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state.event);
+			dev->power.pm_parent->power.power_state.state);
 	}
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
 		error = dev->bus->resume(dev);
 	}
+	dev->power.prev_state = dev->power.power_state;
+	dev->power.power_state.state = 0;
+	dev->power.power_state.event = PM_EVENT_ON;
 	up(&dev->sem);
 	return error;
 }
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 96370ec..d224761 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -45,19 +45,20 @@ EXPORT_SYMBOL(dpm_runtime_resume);
  *	@state:	State to enter.
  */

-int dpm_runtime_suspend(struct device * dev, pm_message_t state)
+int dpm_runtime_suspend(struct device * dev, pm_message_t msg)
 {
 	int error = 0;

 	down(&dpm_sem);
-	if (dev->power.power_state.event == state.event)
+	if (dev->power.power_state.event == msg.event &&
+	    dev->power.power_state.state == msg.state)
 		goto Done;

-	if (dev->power.power_state.event)
+	if (dev->power.power_state.event != PM_EVENT_ON)
 		runtime_resume(dev);

-	if (!(error = suspend_device(dev, state)))
-		dev->power.power_state = state;
+	if (!(error = suspend_device(dev, msg)))
+		dev->power.power_state = msg;
  Done:
 	up(&dpm_sem);
 	return error;
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 8660779..2389821 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -34,29 +34,34 @@
  *	@state:	Power state device is entering.
  */

-int suspend_device(struct device * dev, pm_message_t state)
+int suspend_device(struct device * dev, pm_message_t msg)
 {
+	struct device * pm_parent;
 	int error = 0;

 	down(&dev->sem);
-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state.event, state.event);
-	}
+	dev_dbg(dev, "Suspend [Event %d: %u --> %u]\n",
+		msg.event dev->power.power_state.state, msg.state);
+
+	pm_parent = dev->power.pm_parent;
 	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state.event) {
-		dev_err(dev,
-			"PM: suspend %d->%d, parent %s already %d\n",
-			dev->power.power_state.event, state.event,
-			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state.event);
+	    && dev->power.pm_parent->power.power_state.state) {
+		dev_err(dev,
+			"Suspend [Event %d: %u --> %u], parent %s already in [State %u]\n",
+			msg.event, dev->power.power_state.state, msg.state,
+			pm_parent->bus_id, pm_parent->power.power_state.state);
 	}

 	dev->power.prev_state = dev->power.power_state;

-	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
+	if (dev->bus && dev->bus->suspend) {
 		dev_dbg(dev, "suspending\n");
-		error = dev->bus->suspend(dev, state);
+		error = dev->bus->suspend(dev, msg);
+	}
+
+	if (!error) {
+		dev->power.prev_state = dev->power.power_state;
+		dev->power.power_state = msg;
 	}
 	up(&dev->sem);
 	return error;
---
0.99.9.GIT
