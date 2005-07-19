Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVGSVu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVGSVu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVGSVu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:50:59 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:22545 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261707AbVGSVu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:50:56 -0400
Date: Tue, 19 Jul 2005 23:51:07 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (3/9)
Message-Id: <20050719235107.56ab70d2.khali@linux-fr.org>
In-Reply-To: <20050719233902.40282559.khali@linux-fr.org>
References: <20050719233902.40282559.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the 10 ISA hardware monitoring drivers (it87, lm78, pc87360,
sis5595, smsc47b397, smsc47m1, via686a, w83627hf, w83627ehf, w83781d) to
explicitely register with i2c-isa. For hybrid drivers (it87, lm78,
w83781d), we now have two separate instances of i2c_driver, one for the
I2C interface of the chip, and one for ISA interface. In the long run,
the one for ISA will be replaced with a different driver type.

At this point, all drivers are working again, except for missing
dependencies in Kconfig.

 drivers/hwmon/it87.c       |   29 +++++++++++++++++++++++++----
 drivers/hwmon/lm78.c       |   29 ++++++++++++++++++++++++++---
 drivers/hwmon/pc87360.c    |    5 +++--
 drivers/hwmon/sis5595.c    |    5 +++--
 drivers/hwmon/smsc47b397.c |    5 +++--
 drivers/hwmon/smsc47m1.c   |    5 +++--
 drivers/hwmon/via686a.c    |    5 +++--
 drivers/hwmon/w83627ehf.c  |    5 +++--
 drivers/hwmon/w83627hf.c   |    5 +++--
 drivers/hwmon/w83781d.c    |   28 +++++++++++++++++++++++++---
 10 files changed, 97 insertions(+), 24 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/it87.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/it87.c	2005-07-16 20:15:39.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon-sysfs.h>
@@ -242,6 +243,14 @@
 	.detach_client	= it87_detach_client,
 };
 
+static struct i2c_driver it87_isa_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "it87-isa",
+	.attach_adapter	= it87_attach_adapter,
+	.detach_client	= it87_detach_client,
+};
+
+
 static ssize_t show_in(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -741,7 +750,7 @@
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, IT87_EXTENT, it87_driver.name))
+		if (!request_region(address, IT87_EXTENT, it87_isa_driver.name))
 			goto ERROR0;
 
 	/* Probe whether there is anything available on this address. Already
@@ -787,7 +796,7 @@
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &it87_driver;
+	new_client->driver = is_isa ? &it87_isa_driver : &it87_driver;
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. */
@@ -1172,16 +1181,28 @@
 
 static int __init sm_it87_init(void)
 {
-	int addr;
+	int addr, res;
 
 	if (!it87_find(&addr)) {
 		normal_isa[0] = addr;
 	}
-	return i2c_add_driver(&it87_driver);
+
+	res = i2c_add_driver(&it87_driver);
+	if (res)
+		return res;
+
+	res = i2c_isa_add_driver(&it87_isa_driver);
+	if (res) {
+		i2c_del_driver(&it87_driver);
+		return res;
+	}
+
+	return 0;
 }
 
 static void __exit sm_it87_exit(void)
 {
+	i2c_isa_del_driver(&it87_isa_driver);
 	i2c_del_driver(&it87_driver);
 }
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/lm78.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm78.c	2005-07-16 20:17:04.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -177,6 +178,14 @@
 	.detach_client	= lm78_detach_client,
 };
 
+static struct i2c_driver lm78_isa_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "lm78-isa",
+	.attach_adapter	= lm78_attach_adapter,
+	.detach_client	= lm78_detach_client,
+};
+
+
 /* 7 Voltages */
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
@@ -488,7 +497,8 @@
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, LM78_EXTENT, lm78_driver.name)) {
+		if (!request_region(address, LM78_EXTENT,
+				    lm78_isa_driver.name)) {
 			err = -EBUSY;
 			goto ERROR0;
 		}
@@ -543,7 +553,7 @@
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &lm78_driver;
+	new_client->driver = is_isa ? &lm78_isa_driver : &lm78_driver;
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. */
@@ -791,11 +801,24 @@
 
 static int __init sm_lm78_init(void)
 {
-	return i2c_add_driver(&lm78_driver);
+	int res;
+
+	res = i2c_add_driver(&lm78_driver);
+	if (res)
+		return res;
+
+	res = i2c_isa_add_driver(&lm78_isa_driver);
+	if (res) {
+		i2c_del_driver(&lm78_driver);
+		return res;
+	}
+
+	return 0;
 }
 
 static void __exit sm_lm78_exit(void)
 {
+	i2c_isa_del_driver(&lm78_isa_driver);
 	i2c_del_driver(&lm78_driver);
 }
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/pc87360.c	2005-07-16 09:53:15.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/pc87360.c	2005-07-16 20:11:59.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
@@ -1344,12 +1345,12 @@
 		return -ENODEV;
 	}
 
-	return i2c_add_driver(&pc87360_driver);
+	return i2c_isa_add_driver(&pc87360_driver);
 }
 
 static void __exit pc87360_exit(void)
 {
-	i2c_del_driver(&pc87360_driver);
+	i2c_isa_del_driver(&pc87360_driver);
 }
 
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/sis5595.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/sis5595.c	2005-07-16 20:11:59.000000000 +0200
@@ -55,6 +55,7 @@
 #include <linux/ioport.h>
 #include <linux/pci.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -790,7 +791,7 @@
 	normal_isa[0] = addr;
 
 	s_bridge = pci_dev_get(dev);
-	if (i2c_add_driver(&sis5595_driver)) {
+	if (i2c_isa_add_driver(&sis5595_driver)) {
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}
@@ -817,7 +818,7 @@
 {
 	pci_unregister_driver(&sis5595_pci_driver);
 	if (s_bridge != NULL) {
-		i2c_del_driver(&sis5595_driver);
+		i2c_isa_del_driver(&sis5595_driver);
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}
--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47b397.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47b397.c	2005-07-16 20:11:59.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -350,12 +351,12 @@
 	if ((ret = smsc47b397_find(normal_isa)))
 		return ret;
 
-	return i2c_add_driver(&smsc47b397_driver);
+	return i2c_isa_add_driver(&smsc47b397_driver);
 }
 
 static void __exit smsc47b397_exit(void)
 {
-	i2c_del_driver(&smsc47b397_driver);
+	i2c_isa_del_driver(&smsc47b397_driver);
 }
 
 MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47m1.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47m1.c	2005-07-16 20:11:59.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -592,12 +593,12 @@
 		return -ENODEV;
 	}
 
-	return i2c_add_driver(&smsc47m1_driver);
+	return i2c_isa_add_driver(&smsc47m1_driver);
 }
 
 static void __exit sm_smsc47m1_exit(void)
 {
-	i2c_del_driver(&smsc47m1_driver);
+	i2c_isa_del_driver(&smsc47m1_driver);
 }
 
 MODULE_AUTHOR("Mark D. Studebaker <mdsxyz123@yahoo.com>");
--- linux-2.6.13-rc3.orig/drivers/hwmon/via686a.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/via686a.c	2005-07-16 20:11:59.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -846,7 +847,7 @@
 	normal_isa[0] = addr;
 
 	s_bridge = pci_dev_get(dev);
-	if (i2c_add_driver(&via686a_driver)) {
+	if (i2c_isa_add_driver(&via686a_driver)) {
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}
@@ -873,7 +874,7 @@
 {
 	pci_unregister_driver(&via686a_pci_driver);
 	if (s_bridge != NULL) {
-		i2c_del_driver(&via686a_driver);
+		i2c_isa_del_driver(&via686a_driver);
 		pci_dev_put(s_bridge);
 		s_bridge = NULL;
 	}
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83627hf.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83627hf.c	2005-07-16 20:11:59.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
@@ -1507,12 +1508,12 @@
 	}
 	normal_isa[0] = addr;
 
-	return i2c_add_driver(&w83627hf_driver);
+	return i2c_isa_add_driver(&w83627hf_driver);
 }
 
 static void __exit sensors_w83627hf_exit(void)
 {
-	i2c_del_driver(&w83627hf_driver);
+	i2c_isa_del_driver(&w83627hf_driver);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83781d.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83781d.c	2005-07-16 20:17:22.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
@@ -276,6 +277,14 @@
 	.detach_client = w83781d_detach_client,
 };
 
+static struct i2c_driver w83781d_isa_driver = {
+	.owner = THIS_MODULE,
+	.name = "w83781d-isa",
+	.attach_adapter = w83781d_attach_adapter,
+	.detach_client = w83781d_detach_client,
+};
+
+
 /* following are the sysfs callback functions */
 #define show_in_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
@@ -1002,7 +1011,7 @@
 	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT,
-				    w83781d_driver.name)) {
+				    w83781d_isa_driver.name)) {
 			dev_dbg(&adapter->dev, "Request of region "
 				"0x%x-0x%x for w83781d failed\n", address,
 				address + W83781D_EXTENT - 1);
@@ -1060,7 +1069,7 @@
 	new_client->addr = address;
 	init_MUTEX(&data->lock);
 	new_client->adapter = adapter;
-	new_client->driver = &w83781d_driver;
+	new_client->driver = is_isa ? &w83781d_isa_driver : &w83781d_driver;
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. */
@@ -1636,12 +1645,25 @@
 static int __init
 sensors_w83781d_init(void)
 {
-	return i2c_add_driver(&w83781d_driver);
+	int res;
+
+	res = i2c_add_driver(&w83781d_driver);
+	if (res)
+		return res;
+
+	res = i2c_isa_add_driver(&w83781d_isa_driver);
+	if (res) {
+		i2c_del_driver(&w83781d_driver);
+		return res;
+	}
+
+	return 0;
 }
 
 static void __exit
 sensors_w83781d_exit(void)
 {
+	i2c_isa_del_driver(&w83781d_isa_driver);
 	i2c_del_driver(&w83781d_driver);
 }
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83627ehf.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83627ehf.c	2005-07-16 20:14:00.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/i2c-isa.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -844,12 +845,12 @@
 	 && w83627ehf_find(0x4e, &normal_isa[0]))
 		return -ENODEV;
 
-	return i2c_add_driver(&w83627ehf_driver);
+	return i2c_isa_add_driver(&w83627ehf_driver);
 }
 
 static void __exit sensors_w83627ehf_exit(void)
 {
-	i2c_del_driver(&w83627ehf_driver);
+	i2c_isa_del_driver(&w83627ehf_driver);
 }
 
 MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");


-- 
Jean Delvare
