Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWBRCDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWBRCDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWBRCDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:03:39 -0500
Received: from digitalimplant.org ([64.62.235.95]:62403 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1750706AbWBRCDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:03:38 -0500
Date: Fri, 17 Feb 2006 18:03:30 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@osdl.org>
Subject: [PATCH 1/5] [pm] Fix locking of device suspend/resume functions
Message-ID: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the unneeded down()/up() calls from
suspend_device() and resume_device(). Those functions
are already called under the dpm_sem, making this code
unconditionally deadlock in SMP kernels.

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/base/power/resume.c  |    3 ---
 drivers/base/power/suspend.c |    2 --
 2 files changed, 0 insertions(+), 5 deletions(-)

applies-to: 55ce8c6305fc70b1b544ce7365abd6054e9b5f61
1bf4a2adaa1588c3d68038f56e1f7c9cb96a3af9
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 317edbf..478e116 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -23,7 +23,6 @@ int resume_device(struct device * dev)
 {
 	int error = 0;

-	down(&dev->sem);
 	if (dev->power.pm_parent
 			&& dev->power.pm_parent->power.power_state.event) {
 		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
@@ -35,12 +34,10 @@ int resume_device(struct device * dev)
 		dev_dbg(dev,"resuming\n");
 		error = dev->bus->resume(dev);
 	}
-	up(&dev->sem);
 	return error;
 }


-
 void dpm_resume(void)
 {
 	down(&dpm_list_sem);
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 8660779..a59158c 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -38,7 +38,6 @@ int suspend_device(struct device * dev,
 {
 	int error = 0;

-	down(&dev->sem);
 	if (dev->power.power_state.event) {
 		dev_dbg(dev, "PM: suspend %d-->%d\n",
 			dev->power.power_state.event, state.event);
@@ -58,7 +57,6 @@ int suspend_device(struct device * dev,
 		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
 	}
-	up(&dev->sem);
 	return error;
 }

---
0.99.9.GIT
