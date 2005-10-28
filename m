Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVJ1Gst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVJ1Gst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVJ1Gss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:48:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:17642 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965111AbVJ1GbG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:06 -0400
Cc: ben-linux@fluff.org
Subject: [PATCH] drivers/base - fix sparse warnings
In-Reply-To: <11304810273085@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:27 -0700
Message-Id: <11304810272122@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] drivers/base - fix sparse warnings

There are a number of sparse warnings from the latest sparse
snapshot being generated from the drivers/base build. The
main culprits are due to the initialisation functions not
being declared in a header file.

Also, the firmware.c file should include <linux/device.h>
to get the prototype of  firmware_register() and
firmware_unregister().

This patch moves the init function declerations from the
init.c file to the base.h, and ensures it is included in
all the relevant c sources. It also adds <linux/device.h>
to the included headers for firmware.c.

The patch does not solve all the sparse errors generated,
but reduces the count significantly.

drivers/base/core.c:161:1: warning: symbol 'devices_subsys' was not declared. Should it be static?
drivers/base/core.c:417:12: warning: symbol 'devices_init' was not declared. Should it be static?
drivers/base/sys.c:253:6: warning: symbol 'sysdev_shutdown' was not declared. Should it be static?
drivers/base/sys.c:326:5: warning: symbol 'sysdev_suspend' was not declared. Should it be static?
drivers/base/sys.c:428:5: warning: symbol 'sysdev_resume' was not declared. Should it be static?
drivers/base/sys.c:450:12: warning: symbol 'system_bus_init' was not declared. Should it be static?
drivers/base/bus.c:133:1: warning: symbol 'bus_subsys' was not declared. Should it be static?
drivers/base/bus.c:667:12: warning: symbol 'buses_init' was not declared. Should it be static?
drivers/base/class.c:759:12: warning: symbol 'classes_init' was not declared. Should it be static?
drivers/base/platform.c:313:12: warning: symbol 'platform_bus_init' was not declared. Should it be static?
drivers/base/cpu.c:110:12: warning: symbol 'cpu_dev_init' was not declared. Should it be static?
drivers/base/firmware.c:17:5: warning: symbol 'firmware_register' was not declared. Should it be static?
drivers/base/firmware.c:23:6: warning: symbol 'firmware_unregister' was not declared. Should it be static?
drivers/base/firmware.c:28:12: warning: symbol 'firmware_init' was not declared. Should it be static?
drivers/base/init.c:28:13: warning: symbol 'driver_init' was not declared. Should it be static?
drivers/base/dmapool.c:174:10: warning: implicit cast from nocast type
drivers/base/attribute_container.c:439:1: warning: symbol 'attribute_container_init' was not declared. Should it be static?
drivers/base/power/runtime.c:76:6: warning: symbol 'dpm_set_power_state' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e9821c685cbf2d72f6d692117e83ff9b71c3315b
tree dd96f48d3337746850b8c382aa71410036a3d519
parent 104d94a7ef01bb62f2be1d59c7580c1a6f3478d5
author Ben Dooks <ben-linux@fluff.org> Thu, 13 Oct 2005 17:54:41 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:07 -0700

 drivers/base/attribute_container.c |    2 ++
 drivers/base/base.h                |   12 ++++++++++++
 drivers/base/cpu.c                 |    1 +
 drivers/base/firmware.c            |    3 +++
 drivers/base/init.c                |   10 ++--------
 drivers/base/platform.c            |    2 ++
 6 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index 6b2eb6f..2a7d7ae 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -19,6 +19,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
+#include "base.h"
+
 /* This is a private structure used to tie the classdev and the
  * container .. it should never be visible outside this file */
 struct internal_container {
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 783752b..e3b548d 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -1,3 +1,15 @@
+
+/* initialisation functions */
+
+extern int devices_init(void);
+extern int buses_init(void);
+extern int classes_init(void);
+extern int firmware_init(void);
+extern int platform_bus_init(void);
+extern int system_bus_init(void);
+extern int cpu_dev_init(void);
+extern int attribute_container_init(void);
+
 extern int bus_add_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index b79badd..081c927 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -9,6 +9,7 @@
 #include <linux/topology.h>
 #include <linux/device.h>
 
+#include "base.h"
 
 struct sysdev_class cpu_sysdev_class = {
 	set_kset_name("cpu"),
diff --git a/drivers/base/firmware.c b/drivers/base/firmware.c
index 88ab044..cb1b98a 100644
--- a/drivers/base/firmware.c
+++ b/drivers/base/firmware.c
@@ -11,6 +11,9 @@
 #include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/device.h>
+
+#include "base.h"
 
 static decl_subsys(firmware, NULL, NULL);
 
diff --git a/drivers/base/init.c b/drivers/base/init.c
index a76ae5a..84e604e 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -10,14 +10,8 @@
 #include <linux/device.h>
 #include <linux/init.h>
 
-extern int devices_init(void);
-extern int buses_init(void);
-extern int classes_init(void);
-extern int firmware_init(void);
-extern int platform_bus_init(void);
-extern int system_bus_init(void);
-extern int cpu_dev_init(void);
-extern int attribute_container_init(void);
+#include "base.h"
+
 /**
  *	driver_init - initialize driver model.
  *
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 361e204..a1a56ff 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -17,6 +17,8 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 
+#include "base.h"
+
 struct device platform_bus = {
 	.bus_id		= "platform",
 };

