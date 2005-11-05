Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVKESU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVKESU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVKESUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:20:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33297 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932179AbVKESUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:20:33 -0500
Date: Sat, 5 Nov 2005 18:20:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert drivers/misc/hdpuftrs
Message-ID: <20051105182024.GU14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform drivers to use struct platform_driver

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/misc/hdpuftrs/hdpu_cpustate.c b/drivers/misc/hdpuftrs/hdpu_cpustate.c
--- b/drivers/misc/hdpuftrs/hdpu_cpustate.c
+++ b/drivers/misc/hdpuftrs/hdpu_cpustate.c
@@ -27,8 +27,8 @@
 
 #define SKY_CPUSTATE_VERSION		"1.1"
 
-static int hdpu_cpustate_probe(struct device *ddev);
-static int hdpu_cpustate_remove(struct device *ddev);
+static int hdpu_cpustate_probe(struct platform_device *pdev);
+static int hdpu_cpustate_remove(struct platform_device *pdev);
 
 struct cpustate_t cpustate;
 
@@ -159,11 +159,12 @@
 	return len;
 }
 
-static struct device_driver hdpu_cpustate_driver = {
-	.name = HDPU_CPUSTATE_NAME,
-	.bus = &platform_bus_type,
+static struct platform_driver hdpu_cpustate_driver = {
 	.probe = hdpu_cpustate_probe,
 	.remove = hdpu_cpustate_remove,
+	.driver = {
+		.name = HDPU_CPUSTATE_NAME,
+	},
 };
 
 /*
@@ -188,9 +189,8 @@
 	&cpustate_fops
 };
 
-static int hdpu_cpustate_probe(struct device *ddev)
+static int hdpu_cpustate_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(ddev);
 	struct resource *res;
 	struct proc_dir_entry *proc_de;
 	int ret;
@@ -218,7 +218,7 @@
 	return 0;
 }
 
-static int hdpu_cpustate_remove(struct device *ddev)
+static int hdpu_cpustate_remove(struct platform_device *pdev)
 {
 
 	cpustate.set_addr = NULL;
@@ -233,13 +233,13 @@
 static int __init cpustate_init(void)
 {
 	int rc;
-	rc = driver_register(&hdpu_cpustate_driver);
+	rc = platform_driver_register(&hdpu_cpustate_driver);
 	return rc;
 }
 
 static void __exit cpustate_exit(void)
 {
-	driver_unregister(&hdpu_cpustate_driver);
+	platform_driver_unregister(&hdpu_cpustate_driver);
 }
 
 module_init(cpustate_init);
diff -u b/drivers/misc/hdpuftrs/hdpu_nexus.c b/drivers/misc/hdpuftrs/hdpu_nexus.c
--- b/drivers/misc/hdpuftrs/hdpu_nexus.c
+++ b/drivers/misc/hdpuftrs/hdpu_nexus.c
@@ -23,19 +23,20 @@
 
 #include <linux/platform_device.h>
 
-static int hdpu_nexus_probe(struct device *ddev);
-static int hdpu_nexus_remove(struct device *ddev);
+static int hdpu_nexus_probe(struct platform_device *pdev);
+static int hdpu_nexus_remove(struct platform_device *pdev);
 
 static struct proc_dir_entry *hdpu_slot_id;
 static struct proc_dir_entry *hdpu_chassis_id;
 static int slot_id = -1;
 static int chassis_id = -1;
 
-static struct device_driver hdpu_nexus_driver = {
-	.name = HDPU_NEXUS_NAME,
-	.bus = &platform_bus_type,
+static struct platform_driver hdpu_nexus_driver = {
 	.probe = hdpu_nexus_probe,
 	.remove = hdpu_nexus_remove,
+	.driver = {
+		.name = HDPU_NEXUS_NAME,
+	},
 };
 
 int hdpu_slot_id_read(char *buffer, char **buffer_location, off_t offset,
@@ -56,9 +57,8 @@
 	return sprintf(buffer, "%d\n", chassis_id);
 }
 
-static int hdpu_nexus_probe(struct device *ddev)
+static int hdpu_nexus_probe(struct platform_device *pdev)
 {
-	struct platform_device *pdev = to_platform_device(ddev);
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -81,7 +81,7 @@
 	return 0;
 }
 
-static int hdpu_nexus_remove(struct device *ddev)
+static int hdpu_nexus_remove(struct platform_device *pdev)
 {
 	slot_id = -1;
 	chassis_id = -1;
@@ -95,13 +95,13 @@
 static int __init nexus_init(void)
 {
 	int rc;
-	rc = driver_register(&hdpu_nexus_driver);
+	rc = platform_driver_register(&hdpu_nexus_driver);
 	return rc;
 }
 
 static void __exit nexus_exit(void)
 {
-	driver_unregister(&hdpu_nexus_driver);
+	platform_driver_unregister(&hdpu_nexus_driver);
 }
 
 module_init(nexus_init);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
