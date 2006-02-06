Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWBFUb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWBFUb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWBFUbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:31:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:29117 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964795AbWBFU3h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:37 -0500
Cc: bunk@stusta.de
Subject: [PATCH] drivers/base/: proper prototypes
In-Reply-To: <1139257758710@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:18 -0800
Message-Id: <1139257758363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] drivers/base/: proper prototypes

This patch contains the following changes:
- move prototypes to base.h
- sys.c should #include "base.h" for getting the prototype of it's
  global function system_bus_init()

Note that hidden in this patch there's a bugfix:

Caller and callee disagreed regarding the return type of
sysdev_shutdown().

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f67d115fe48f494d4b7f4f2024217fe52578915f
tree 80c9ef160714e121b582a901d00bf792373780d3
parent e485981e52b476c1b6a00873c2f8b75b3168718f
author Adrian Bunk <bunk@stusta.de> Thu, 19 Jan 2006 17:30:17 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:17 -0800

 drivers/base/base.h           |    4 ++++
 drivers/base/power/resume.c   |    3 +--
 drivers/base/power/shutdown.c |    2 +-
 drivers/base/power/suspend.c  |    3 +--
 drivers/base/sys.c            |    3 +++
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index e3b548d..5735b38 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -19,6 +19,10 @@ extern void bus_remove_driver(struct dev
 extern void driver_detach(struct device_driver * drv);
 extern int driver_probe_device(struct device_driver *, struct device *);
 
+extern void sysdev_shutdown(void);
+extern int sysdev_suspend(pm_message_t state);
+extern int sysdev_resume(void);
+
 static inline struct class_device *to_class_dev(struct kobject *obj)
 {
 	return container_of(obj, struct class_device, kobj);
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 0a7aa07..317edbf 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -9,10 +9,9 @@
  */
 
 #include <linux/device.h>
+#include "../base.h"
 #include "power.h"
 
-extern int sysdev_resume(void);
-
 
 /**
  *	resume_device - Restore state for one device.
diff --git a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
index c2475f3..8826a5b 100644
--- a/drivers/base/power/shutdown.c
+++ b/drivers/base/power/shutdown.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <asm/semaphore.h>
 
+#include "../base.h"
 #include "power.h"
 
 #define to_dev(node) container_of(node, struct device, kobj.entry)
@@ -28,7 +29,6 @@ extern struct subsystem devices_subsys;
  * they only get one called once when interrupts are disabled.
  */
 
-extern int sysdev_shutdown(void);
 
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 5050176..8660779 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -9,10 +9,9 @@
  */
 
 #include <linux/device.h>
+#include "../base.h"
 #include "power.h"
 
-extern int sysdev_suspend(pm_message_t state);
-
 /*
  * The entries in the dpm_active list are in a depth first order, simply
  * because children are guaranteed to be discovered after parents, and
diff --git a/drivers/base/sys.c b/drivers/base/sys.c
index 66ed8f2..6fc23ab 100644
--- a/drivers/base/sys.c
+++ b/drivers/base/sys.c
@@ -21,8 +21,11 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pm.h>
+#include <linux/device.h>
 #include <asm/semaphore.h>
 
+#include "base.h"
+
 extern struct subsystem devices_subsys;
 
 #define to_sysdev(k) container_of(k, struct sys_device, kobj)

