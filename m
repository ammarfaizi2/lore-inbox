Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVAEC4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVAEC4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVAECz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:55:26 -0500
Received: from fmr17.intel.com ([134.134.136.16]:45978 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262191AbVAECwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:52:06 -0500
Subject: [PATCH 3/4]ACPI callback to get correct PCI device suspend state
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@suse.cz>
Content-Type: multipart/mixed; boundary="=-xPVoT0OXtcMyCbH9SxFJ"
Message-Id: <1104893454.5550.133.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 10:51:23 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xPVoT0OXtcMyCbH9SxFJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This is an ACPI callback to get correct PCI device suspend state. BIOS
sometimes reports a different device state from the maximum D-state
gotten from PCI config space.

Thanks,
Shaohua

Signed-off-by: Li Shaohua<shaohua.li@intel.com>
---

 2.5-root/drivers/pci/pci-acpi.c   |   19 +++++++++++++++++++
 2.5-root/drivers/pci/pci-driver.c |   29 ++++++++++++++++++++++-------
 2.5-root/drivers/pci/pci.h        |    3 +++
 3 files changed, 44 insertions(+), 7 deletions(-)

diff -puN drivers/pci/pci-acpi.c~acpi-pci-get-suspend-state-callback drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~acpi-pci-get-suspend-state-callback	2005-01-05 09:57:46.949890624 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-05 09:57:46.956889560 +0800
@@ -16,6 +16,7 @@
 #include <acpi/acpi_bus.h>
 
 #include <linux/pci-acpi.h>
+#include "pci.h"
 
 static u32 ctrlset_buf[3] = {0, 0, 0};
 static u32 global_ctrlsets = 0;
@@ -208,6 +209,23 @@ acpi_status pci_osc_control_set(u32 flag
 }
 EXPORT_SYMBOL(pci_osc_control_set);
 
+static int acpi_get_suspend_state(struct device *dev, u32 state)
+{
+	char dstate_str[] = "_S0D";
+	acpi_status status;
+	unsigned long val;
+
+	/* state is PM_SUSPEND_* */
+	if ((state >= PM_SUSPEND_MAX) || !DEVICE_ACPI_HANDLE(dev))
+		return -EINVAL;
+	dstate_str[2] += state;
+	status = acpi_evaluate_integer(DEVICE_ACPI_HANDLE(dev), dstate_str,
+		NULL, &val);
+	if (ACPI_SUCCESS(status))
+		return val;
+	return -ENODEV;
+}
+
 /* ACPI bus type */
 int pci_acpi_bind_device(struct device *dev, acpi_handle *handle)
 {
@@ -250,6 +268,7 @@ static int __init pci_acpi_init(void)
 	ret = register_acpi_bus_type(&pci_acpi_bus);
 	if (ret)
 		return 0;
+	platform_pci_get_suspend_state = acpi_get_suspend_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -puN drivers/pci/pci-driver.c~acpi-pci-get-suspend-state-callback drivers/pci/pci-driver.c
--- 2.5/drivers/pci/pci-driver.c~acpi-pci-get-suspend-state-callback	2005-01-05 09:57:46.951890320 +0800
+++ 2.5-root/drivers/pci/pci-driver.c	2005-01-05 09:57:46.956889560 +0800
@@ -284,13 +284,13 @@ static int pci_device_remove(struct devi
 	return 0;
 }
 
-static int pci_device_suspend(struct device * dev, u32 state)
+/*
+ * return value: failed < 0, success >= 0
+ */
+int (*platform_pci_get_suspend_state) (struct device *, u32) = NULL;
+static int pci_get_suspend_state(struct device *dev, u32 state)
 {
-	struct pci_dev * pci_dev = to_pci_dev(dev);
-	struct pci_driver * drv = pci_dev->driver;
-	u32 dev_state;
-	int i = 0;
-
+	int dev_state = -1;
 	/* Translate PM_SUSPEND_xx states to PCI device states */
 	static u32 state_conversion[] = {
 		[PM_SUSPEND_ON] = 0,
@@ -299,10 +299,25 @@ static int pci_device_suspend(struct dev
 		[PM_SUSPEND_DISK] = 3,
 	};
 
+	if (platform_pci_get_suspend_state)
+		dev_state = platform_pci_get_suspend_state(dev, state);
+	if (dev_state >= 0)
+		return dev_state;
 	if (state >= sizeof(state_conversion) / sizeof(state_conversion[1]))
 		return -EINVAL;
+	return state_conversion[state];
+}
 
-	dev_state = state_conversion[state];
+static int pci_device_suspend(struct device * dev, u32 state)
+{
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+	int dev_state;
+	int i = 0;
+
+	dev_state = pci_get_suspend_state(dev, state);
+	if (dev_state < 0)
+		return -EINVAL;
 	if (drv && drv->suspend)
 		i = drv->suspend(pci_dev, dev_state);
 	else
diff -puN drivers/pci/pci.h~acpi-pci-get-suspend-state-callback drivers/pci/pci.h
--- 2.5/drivers/pci/pci.h~acpi-pci-get-suspend-state-callback	2005-01-05 09:57:46.952890168 +0800
+++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:57:46.956889560 +0800
@@ -11,6 +11,9 @@ extern int pci_bus_alloc_resource(struct
 				  void (*alignf)(void *, struct resource *,
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
+/* Firmware callbacks */
+extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
+
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
_


--=-xPVoT0OXtcMyCbH9SxFJ
Content-Disposition: attachment; filename=p00003_acpi-pci-get-suspend-state-callback.patch
Content-Type: text/x-patch; name=p00003_acpi-pci-get-suspend-state-callback.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


An ACPI callback to get suspend state from firmware.

---

 2.5-root/drivers/pci/pci-acpi.c   |   19 +++++++++++++++++++
 2.5-root/drivers/pci/pci-driver.c |   29 ++++++++++++++++++++++-------
 2.5-root/drivers/pci/pci.h        |    3 +++
 3 files changed, 44 insertions(+), 7 deletions(-)

diff -puN drivers/pci/pci-acpi.c~acpi-pci-get-suspend-state-callback drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~acpi-pci-get-suspend-state-callback	2005-01-05 09:57:46.949890624 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-05 09:57:46.956889560 +0800
@@ -16,6 +16,7 @@
 #include <acpi/acpi_bus.h>
 
 #include <linux/pci-acpi.h>
+#include "pci.h"
 
 static u32 ctrlset_buf[3] = {0, 0, 0};
 static u32 global_ctrlsets = 0;
@@ -208,6 +209,23 @@ acpi_status pci_osc_control_set(u32 flag
 }
 EXPORT_SYMBOL(pci_osc_control_set);
 
+static int acpi_get_suspend_state(struct device *dev, u32 state)
+{
+	char dstate_str[] = "_S0D";
+	acpi_status status;
+	unsigned long val;
+
+	/* state is PM_SUSPEND_* */
+	if ((state >= PM_SUSPEND_MAX) || !DEVICE_ACPI_HANDLE(dev))
+		return -EINVAL;
+	dstate_str[2] += state;
+	status = acpi_evaluate_integer(DEVICE_ACPI_HANDLE(dev), dstate_str,
+		NULL, &val);
+	if (ACPI_SUCCESS(status))
+		return val;
+	return -ENODEV;
+}
+
 /* ACPI bus type */
 int pci_acpi_bind_device(struct device *dev, acpi_handle *handle)
 {
@@ -250,6 +268,7 @@ static int __init pci_acpi_init(void)
 	ret = register_acpi_bus_type(&pci_acpi_bus);
 	if (ret)
 		return 0;
+	platform_pci_get_suspend_state = acpi_get_suspend_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -puN drivers/pci/pci-driver.c~acpi-pci-get-suspend-state-callback drivers/pci/pci-driver.c
--- 2.5/drivers/pci/pci-driver.c~acpi-pci-get-suspend-state-callback	2005-01-05 09:57:46.951890320 +0800
+++ 2.5-root/drivers/pci/pci-driver.c	2005-01-05 09:57:46.956889560 +0800
@@ -284,13 +284,13 @@ static int pci_device_remove(struct devi
 	return 0;
 }
 
-static int pci_device_suspend(struct device * dev, u32 state)
+/*
+ * return value: failed < 0, success >= 0
+ */
+int (*platform_pci_get_suspend_state) (struct device *, u32) = NULL;
+static int pci_get_suspend_state(struct device *dev, u32 state)
 {
-	struct pci_dev * pci_dev = to_pci_dev(dev);
-	struct pci_driver * drv = pci_dev->driver;
-	u32 dev_state;
-	int i = 0;
-
+	int dev_state = -1;
 	/* Translate PM_SUSPEND_xx states to PCI device states */
 	static u32 state_conversion[] = {
 		[PM_SUSPEND_ON] = 0,
@@ -299,10 +299,25 @@ static int pci_device_suspend(struct dev
 		[PM_SUSPEND_DISK] = 3,
 	};
 
+	if (platform_pci_get_suspend_state)
+		dev_state = platform_pci_get_suspend_state(dev, state);
+	if (dev_state >= 0)
+		return dev_state;
 	if (state >= sizeof(state_conversion) / sizeof(state_conversion[1]))
 		return -EINVAL;
+	return state_conversion[state];
+}
 
-	dev_state = state_conversion[state];
+static int pci_device_suspend(struct device * dev, u32 state)
+{
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+	int dev_state;
+	int i = 0;
+
+	dev_state = pci_get_suspend_state(dev, state);
+	if (dev_state < 0)
+		return -EINVAL;
 	if (drv && drv->suspend)
 		i = drv->suspend(pci_dev, dev_state);
 	else
diff -puN drivers/pci/pci.h~acpi-pci-get-suspend-state-callback drivers/pci/pci.h
--- 2.5/drivers/pci/pci.h~acpi-pci-get-suspend-state-callback	2005-01-05 09:57:46.952890168 +0800
+++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:57:46.956889560 +0800
@@ -11,6 +11,9 @@ extern int pci_bus_alloc_resource(struct
 				  void (*alignf)(void *, struct resource *,
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
+/* Firmware callbacks */
+extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
+
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
_

--=-xPVoT0OXtcMyCbH9SxFJ--

