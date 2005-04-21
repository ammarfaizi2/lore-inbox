Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVDUIjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVDUIjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDUIcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:32:21 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:17830 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261479AbVDUHiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:38:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 21/22] W1: implement standard hotplug handler
Date: Thu, 21 Apr 2005 02:36:45 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Og1ZCiiTJs3JDQD"
Message-Id: <200504210236.46689.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Og1ZCiiTJs3JDQD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ahem.. Kmail just refuses send this on inline... Sorry.

--
Dmitry

--Boundary-00=_Og1ZCiiTJs3JDQD
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="w1-hotplug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="w1-hotplug.patch"

W1: implement W1 bus hotplug handler. Slave devices will define
    FID (family ID) end SN (serial number) environment variables.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c |   51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 44 insertions(+), 7 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -50,6 +50,10 @@ module_param_named(scan_interval, w1_sca
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
+struct device_driver w1_master_driver = {
+	.name = "master",
+};
+
 static int w1_bus_match(struct device *dev, struct device_driver *drv)
 {
 	/*
@@ -67,14 +71,46 @@ static int w1_bus_match(struct device *d
 	return 0;
 }
 
-static struct bus_type w1_bus_type = {
-	.name = "w1",
-	.match = w1_bus_match,
-};
+#ifdef CONFIG_HOTPLUG
+static int w1_hotplug(struct device *dev, char **envp, int num_envp,
+		      char *buffer, int buffer_size)
+{
+	struct w1_slave *slave;
+	int i = 0;
+	int len = 0;
 
-struct device_driver w1_master_driver = {
-	.name = "master",
-	.bus = &w1_bus_type,
+	if (!dev)
+		return -ENODEV;
+
+	if (dev->driver == &w1_master_driver)
+		return 0;
+
+	slave = to_w1_slave(dev);
+
+	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
+				"FID=%02X", slave->reg_num.family))
+		return -ENOMEM;
+
+	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
+				"SN=%024llX", slave->reg_num.id))
+		return -ENOMEM;
+
+	envp[i] = NULL;
+
+	return 0;
+}
+#else
+static int w1_hotplug(struct device *dev, char **envp, int num_envp,
+		      char *buffer, int buffer_size)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_HOTPLUG */
+
+static struct bus_type w1_bus_type = {
+	.name		= "w1",
+	.match		= w1_bus_match,
+	.hotplug	= w1_hotplug,
 };
 
 static ssize_t w1_slave_attribute_show_family(struct device *dev, char *buf)
@@ -541,6 +577,7 @@ static int w1_init(void)
 		return error;
 	}
 
+	w1_master_driver.bus = &w1_bus_type;
 	error = driver_register(&w1_master_driver);
 	if (error) {
 		printk(KERN_ERR

--Boundary-00=_Og1ZCiiTJs3JDQD--
