Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWCCGDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWCCGDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWCCGDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:03:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:40860 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751822AbWCCGDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:03:33 -0500
Subject: [PATCH] powerpc: Fix old g5 issues with windfarm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 17:03:21 +1100
Message-Id: <1141365801.3888.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the windfarm sensor modules can initialize on old machines that
don't have full windfarm support like non-dual core desktop G5s.
Unfortunately, by doing so, they would trigger a bug in their matching
algorithm causing them to attach to the wrong bus, thus triggering
issues with the i2c core and breaking the thermal driver.

This patch fixes the probing issue (so that they will work when a
windfarm port is done to these machines) and also prevents for now
windfarm to load at all on these machines that still use therm_pm72 to
avoid wasting resources.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/macintosh/windfarm_lm75_sensor.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_lm75_sensor.c	2006-03-03 16:02:56.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_lm75_sensor.c	2006-03-03 16:41:01.000000000 +1100
@@ -25,9 +25,9 @@
 
 #include "windfarm.h"
 
-#define VERSION "0.1"
+#define VERSION "0.2"
 
-#define DEBUG
+#undef DEBUG
 
 #ifdef DEBUG
 #define DBG(args...)	printk(args)
@@ -113,6 +113,7 @@ static struct wf_lm75_sensor *wf_lm75_cr
 					     const char *loc)
 {
 	struct wf_lm75_sensor *lm;
+	int rc;
 
 	DBG("wf_lm75: creating  %s device at address 0x%02x\n",
 	    ds1775 ? "ds1775" : "lm75", addr);
@@ -139,9 +140,11 @@ static struct wf_lm75_sensor *wf_lm75_cr
 	lm->i2c.driver = &wf_lm75_driver;
 	strncpy(lm->i2c.name, lm->sens.name, I2C_NAME_SIZE-1);
 
-	if (i2c_attach_client(&lm->i2c)) {
-		printk(KERN_ERR "windfarm: failed to attach %s %s to i2c\n",
-		       ds1775 ? "ds1775" : "lm75", lm->i2c.name);
+	rc = i2c_attach_client(&lm->i2c);
+	if (rc) {
+		printk(KERN_ERR "windfarm: failed to attach %s %s to i2c,"
+		       " err %d\n", ds1775 ? "ds1775" : "lm75",
+		       lm->i2c.name, rc);
 		goto fail;
 	}
 
@@ -175,16 +178,22 @@ static int wf_lm75_attach(struct i2c_ada
 	     (dev = of_get_next_child(busnode, dev)) != NULL;) {
 		const char *loc =
 			get_property(dev, "hwsensor-location", NULL);
-		u32 *reg = (u32 *)get_property(dev, "reg", NULL);
-		DBG(" dev: %s... (loc: %p, reg: %p)\n", dev->name, loc, reg);
-		if (loc == NULL || reg == NULL)
+		u8 addr;
+
+		/* We must re-match the adapter in order to properly check
+		 * the channel on multibus setups
+		 */
+		if (!pmac_i2c_match_adapter(dev, adapter))
+			continue;
+		addr = pmac_i2c_get_dev_addr(dev);
+		if (loc == NULL || addr == 0)
 			continue;
 		/* real lm75 */
 		if (device_is_compatible(dev, "lm75"))
-			wf_lm75_create(adapter, *reg, 0, loc);
+			wf_lm75_create(adapter, addr, 0, loc);
 		/* ds1775 (compatible, better resolution */
 		else if (device_is_compatible(dev, "ds1775"))
-			wf_lm75_create(adapter, *reg, 1, loc);
+			wf_lm75_create(adapter, addr, 1, loc);
 	}
 	return 0;
 }
@@ -206,6 +215,11 @@ static int wf_lm75_detach(struct i2c_cli
 
 static int __init wf_lm75_sensor_init(void)
 {
+	/* Don't register on old machines that use therm_pm72 for now */
+	if (machine_is_compatible("PowerMac7,2") ||
+	    machine_is_compatible("PowerMac7,3") ||
+	    machine_is_compatible("RackMac3,1"))
+		return -ENODEV;
 	return i2c_add_driver(&wf_lm75_driver);
 }
 
Index: linux-work/drivers/macintosh/windfarm_max6690_sensor.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_max6690_sensor.c	2006-02-17 14:38:40.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_max6690_sensor.c	2006-03-03 16:40:05.000000000 +1100
@@ -17,7 +17,7 @@
 
 #include "windfarm.h"
 
-#define VERSION "0.1"
+#define VERSION "0.2"
 
 /* This currently only exports the external temperature sensor,
    since that's all the control loops need. */
@@ -81,7 +81,7 @@ static struct wf_sensor_ops wf_max6690_o
 static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr)
 {
 	struct wf_6690_sensor *max;
-	char *name = "u4-temp";
+	char *name = "backside-temp";
 
 	max = kzalloc(sizeof(struct wf_6690_sensor), GFP_KERNEL);
 	if (max == NULL) {
@@ -118,7 +118,6 @@ static int wf_max6690_attach(struct i2c_
 	struct device_node *busnode, *dev = NULL;
 	struct pmac_i2c_bus *bus;
 	const char *loc;
-	u32 *reg;
 
 	bus = pmac_i2c_adapter_to_bus(adapter);
 	if (bus == NULL)
@@ -126,16 +125,23 @@ static int wf_max6690_attach(struct i2c_
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
+		u8 addr;
+
+		/* We must re-match the adapter in order to properly check
+		 * the channel on multibus setups
+		 */
+		if (!pmac_i2c_match_adapter(dev, adapter))
+			continue;
 		if (!device_is_compatible(dev, "max6690"))
 			continue;
+		addr = pmac_i2c_get_dev_addr(dev);
 		loc = get_property(dev, "hwsensor-location", NULL);
-		reg = (u32 *) get_property(dev, "reg", NULL);
-		if (!loc || !reg)
+		if (loc == NULL || addr == 0)
 			continue;
-		printk("found max6690, loc=%s reg=%x\n", loc, *reg);
+		printk("found max6690, loc=%s addr=0x%02x\n", loc, addr);
 		if (strcmp(loc, "BACKSIDE"))
 			continue;
-		wf_max6690_create(adapter, *reg);
+		wf_max6690_create(adapter, addr);
 	}
 
 	return 0;
@@ -153,6 +159,11 @@ static int wf_max6690_detach(struct i2c_
 
 static int __init wf_max6690_sensor_init(void)
 {
+	/* Don't register on old machines that use therm_pm72 for now */
+	if (machine_is_compatible("PowerMac7,2") ||
+	    machine_is_compatible("PowerMac7,3") ||
+	    machine_is_compatible("RackMac3,1"))
+		return -ENODEV;
 	return i2c_add_driver(&wf_max6690_driver);
 }
 
Index: linux-work/drivers/macintosh/windfarm_pm112.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm112.c	2006-02-17 14:38:40.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pm112.c	2006-03-03 16:24:44.000000000 +1100
@@ -613,7 +613,7 @@ static void pm112_new_sensor(struct wf_s
 	} else if (!strcmp(sr->name, "slots-power")) {
 		if (slots_power == NULL && wf_get_sensor(sr) == 0)
 			slots_power = sr;
-	} else if (!strcmp(sr->name, "u4-temp")) {
+	} else if (!strcmp(sr->name, "backside-temp")) {
 		if (u4_temp == NULL && wf_get_sensor(sr) == 0)
 			u4_temp = sr;
 	} else
Index: linux-work/drivers/macintosh/windfarm_cpufreq_clamp.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_cpufreq_clamp.c	2005-11-09 11:49:03.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_cpufreq_clamp.c	2006-03-03 16:42:36.000000000 +1100
@@ -8,6 +8,8 @@
 #include <linux/wait.h>
 #include <linux/cpufreq.h>
 
+#include <asm/prom.h>
+
 #include "windfarm.h"
 
 #define VERSION "0.3"
@@ -74,6 +76,12 @@ static int __init wf_cpufreq_clamp_init(
 {
 	struct wf_control *clamp;
 
+	/* Don't register on old machines that use therm_pm72 for now */
+	if (machine_is_compatible("PowerMac7,2") ||
+	    machine_is_compatible("PowerMac7,3") ||
+	    machine_is_compatible("RackMac3,1"))
+		return -ENODEV;
+
 	clamp = kmalloc(sizeof(struct wf_control), GFP_KERNEL);
 	if (clamp == NULL)
 		return -ENOMEM;
Index: linux-work/drivers/macintosh/windfarm_core.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_core.c	2006-02-17 14:38:40.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_core.c	2006-03-03 16:43:06.000000000 +1100
@@ -35,6 +35,8 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 
+#include <asm/prom.h>
+
 #include "windfarm.h"
 
 #define VERSION "0.2"
@@ -465,6 +467,11 @@ static int __init windfarm_core_init(voi
 {
 	DBG("wf: core loaded\n");
 
+	/* Don't register on old machines that use therm_pm72 for now */
+	if (machine_is_compatible("PowerMac7,2") ||
+	    machine_is_compatible("PowerMac7,3") ||
+	    machine_is_compatible("RackMac3,1"))
+		return -ENODEV;
 	platform_device_register(&wf_platform_device);
 	return 0;
 }


