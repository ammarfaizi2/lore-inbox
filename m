Return-Path: <linux-kernel-owner+w=401wt.eu-S964885AbWLTE4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWLTE4Q (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 23:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWLTE4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 23:56:15 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:49874 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964885AbWLTE4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 23:56:14 -0500
Date: Wed, 20 Dec 2006 04:56:04 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Message-ID: <20061220045604.GA20234@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191919.36813.david-b@pacbell.net> <20061220034315.GA19440@srcf.ucam.org> <200612192015.14587.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612192015.14587.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: [PATCH 1/2] Fix /sys/device/.../power/state
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes in the PM system made it impossible to perform runtime 
suspend of any PCI or platform devices. This patch restores the 
functionality for any devices that don't require any of their suspend or 
resume code to be run with interrupts disabled.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f9c903b..6bf1218 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -597,6 +597,16 @@ static int platform_resume(struct device * dev)
 	return ret;
 }
 
+static int platform_pm_has_noirq_stage(struct device * dev)
+{
+	int ret = 0;
+	struct platform_driver *drv = to_platform_driver(dev->driver);
+
+	if (dev->driver && (drv->resume_early || drv->suspend_late))
+		ret = 1;
+	return ret;
+}
+
 struct bus_type platform_bus_type = {
 	.name		= "platform",
 	.dev_attrs	= platform_dev_attrs,
@@ -606,6 +616,7 @@ struct bus_type platform_bus_type = {
 	.suspend_late	= platform_suspend_late,
 	.resume_early	= platform_resume_early,
 	.resume		= platform_resume,
+	.pm_has_noirq_stage = platform_pm_has_noirq_stage,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 2d47517..03d3f81 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -46,7 +46,8 @@ static ssize_t state_store(struct device * dev, struct device_attribute *attr, c
 	int error = -EINVAL;
 
 	/* disallow incomplete suspend sequences */
-	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
+	if (dev->bus && dev->bus->pm_has_noirq_stage 
+	    && dev->bus->pm_has_noirq_stage(dev))
 		return error;
 
 	state.event = PM_EVENT_SUSPEND;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e5ae3a0..c0e4e7a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -351,6 +351,17 @@ static int pci_device_resume(struct device * dev)
 	return error;
 }
 
+static int pci_device_pm_has_noirq_stage(struct device * dev)
+{
+	int error = 0;
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+
+	if (drv && (drv->resume_early || drv->suspend_late))
+		error = 1;
+	return error;
+}
+
 static int pci_device_resume_early(struct device * dev)
 {
 	int error = 0;
@@ -569,6 +580,7 @@ struct bus_type pci_bus_type = {
 	.suspend_late	= pci_device_suspend_late,
 	.resume_early	= pci_device_resume_early,
 	.resume		= pci_device_resume,
+	.pm_has_noirq_stage = pci_device_pm_has_noirq_stage,
 	.shutdown	= pci_device_shutdown,
 	.dev_attrs	= pci_dev_attrs,
 };
diff --git a/include/linux/device.h b/include/linux/device.h
index 49ab53c..1c663c4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -59,6 +59,7 @@ struct bus_type {
 	int (*suspend)(struct device * dev, pm_message_t state);
 	int (*suspend_late)(struct device * dev, pm_message_t state);
 	int (*resume_early)(struct device * dev);
+	int (*pm_has_noirq_stage)(struct device * dev);
 	int (*resume)(struct device * dev);
 };
-- 
Matthew Garrett | mjg59@srcf.ucam.org
