Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVJMQyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVJMQyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 12:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVJMQyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 12:54:45 -0400
Received: from host-84-9-201-133.bulldogdsl.com ([84.9.201.133]:61059 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932092AbVJMQyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 12:54:44 -0400
Date: Thu, 13 Oct 2005 17:54:41 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: [PATCH] drivers/base - fix sparse warnings
Message-ID: <20051013165441.GA18360@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2614-base-sparse-fixes.patch"

diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/attribute_container.c linux-2.6.14-rc4-bjd2/drivers/base/attribute_container.c
--- linux-2.6.14-rc4-bjd1/drivers/base/attribute_container.c	2005-10-11 10:56:31.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/attribute_container.c	2005-10-13 15:30:01.000000000 +0100
@@ -19,6 +19,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 
+#include "base.h"
+
 /* This is a private structure used to tie the classdev and the
  * container .. it should never be visible outside this file */
 struct internal_container {
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/base.h linux-2.6.14-rc4-bjd2/drivers/base/base.h
--- linux-2.6.14-rc4-bjd1/drivers/base/base.h	2005-09-01 21:02:36.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/base.h	2005-10-13 15:26:56.000000000 +0100
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
 
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/cpu.c linux-2.6.14-rc4-bjd2/drivers/base/cpu.c
--- linux-2.6.14-rc4-bjd1/drivers/base/cpu.c	2005-09-01 21:02:36.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/cpu.c	2005-10-13 15:28:58.000000000 +0100
@@ -9,6 +9,7 @@
 #include <linux/topology.h>
 #include <linux/device.h>
 
+#include "base.h"
 
 struct sysdev_class cpu_sysdev_class = {
 	set_kset_name("cpu"),
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/firmware.c linux-2.6.14-rc4-bjd2/drivers/base/firmware.c
--- linux-2.6.14-rc4-bjd1/drivers/base/firmware.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/firmware.c	2005-10-13 15:28:08.000000000 +0100
@@ -11,6 +11,9 @@
 #include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/device.h>
+
+#include "base.h"
 
 static decl_subsys(firmware, NULL, NULL);
 
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/init.c linux-2.6.14-rc4-bjd2/drivers/base/init.c
--- linux-2.6.14-rc4-bjd1/drivers/base/init.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/init.c	2005-10-13 15:27:05.000000000 +0100
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
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd1/drivers/base/platform.c linux-2.6.14-rc4-bjd2/drivers/base/platform.c
--- linux-2.6.14-rc4-bjd1/drivers/base/platform.c	2005-10-11 10:56:31.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/base/platform.c	2005-10-13 15:28:31.000000000 +0100
@@ -17,6 +17,8 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 
+#include "base.h"
+
 struct device platform_bus = {
 	.bus_id		= "platform",
 };

--tThc/1wpZn/ma/RB--
