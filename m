Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVAEC6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVAEC6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVAEC4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:56:42 -0500
Received: from fmr19.intel.com ([134.134.136.18]:23531 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262225AbVAECwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:52:10 -0500
Subject: [PATCH 4/4]An ACPI callback for pci_set_power_state
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@suse.cz>
Content-Type: multipart/mixed; boundary="=-HonJR+DY4pY3ZBYHtV7J"
Message-Id: <1104893456.5550.135.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 10:51:27 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HonJR+DY4pY3ZBYHtV7J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This is an ACPI callback for pci_set_power_state. Besides setting PCI
config space, changing device's power state sometimes requires to power
on device's power source and to invoke other firmware methods.

Thanks,
Shaohua

SIgned-off-by: Li Shaohua<shaohua.li@intel.com>
---

 2.5-root/drivers/acpi/bus.c     |    8 +++++++-
 2.5-root/drivers/pci/pci-acpi.c |   11 +++++++++++
 2.5-root/drivers/pci/pci.c      |   11 +++++++++--
 2.5-root/drivers/pci/pci.h      |    1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/bus.c~acpi-pci-set-power-state-callback drivers/acpi/bus.c
--- 2.5/drivers/acpi/bus.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.464923888 +0800
+++ 2.5-root/drivers/acpi/bus.c	2005-01-05 09:58:06.473922520 +0800
@@ -212,6 +212,12 @@ acpi_bus_set_power (
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Device is not power manageable\n"));
 		return_VALUE(-ENODEV);
 	}
+	/*
+	 * Get device's current power state if it's unknown
+	 * This means device power state isn't initialized or previous setting failed
+	 */
+	if (device->power.state == ACPI_STATE_UNKNOWN)
+		acpi_bus_get_power(device->handle, &device->power.state);
 	if (state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n", state));
 		return_VALUE(0);
@@ -231,7 +237,7 @@ acpi_bus_set_power (
 	 * On transitions to a high-powered state we first apply power (via
 	 * power resources) then evalute _PSx.  Conversly for transitions to
 	 * a lower-powered state.
-	 */ 
+	 */
 	if (state < device->power.state) {
 		if (device->power.flags.power_resources) {
 			result = acpi_power_transition(device, state);
diff -puN drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.466923584 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-05 09:58:06.472922672 +0800
@@ -226,6 +226,16 @@ static int acpi_get_suspend_state(struct
 	return -ENODEV;
 }
 
+static int acpi_set_power_state(struct pci_dev *dev, int state)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	if (!handle)
+		return -ENODEV;
+	return acpi_bus_set_power(handle, state);
+}
+
+
 /* ACPI bus type */
 int pci_acpi_bind_device(struct device *dev, acpi_handle *handle)
 {
@@ -269,6 +279,7 @@ static int __init pci_acpi_init(void)
 	if (ret)
 		return 0;
 	platform_pci_get_suspend_state = acpi_get_suspend_state;
+	platform_pci_set_power_state = acpi_set_power_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -puN drivers/pci/pci.c~acpi-pci-set-power-state-callback drivers/pci/pci.c
--- 2.5/drivers/pci/pci.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.467923432 +0800
+++ 2.5-root/drivers/pci/pci.c	2005-01-05 09:58:06.473922520 +0800
@@ -240,7 +240,7 @@ pci_find_parent_resource(const struct pc
  * -EIO if device does not support PCI PM.
  * 0 if we can successfully change the power state.
  */
-
+int (*platform_pci_set_power_state)(struct pci_dev *, int) = NULL;
 int
 pci_set_power_state(struct pci_dev *dev, int state)
 {
@@ -294,8 +294,15 @@ pci_set_power_state(struct pci_dev *dev,
 		msleep(10);
 	else if(state == 2 || dev->current_state == 2)
 		udelay(200);
-	dev->current_state = state;
 
+	/*
+	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
+	 * Firmware method after natice method ?
+	 */
+	if (platform_pci_set_power_state)
+		platform_pci_set_power_state(dev, state);
+
+	dev->current_state = state;
 	return 0;
 }
 
diff -puN drivers/pci/pci.h~acpi-pci-set-power-state-callback drivers/pci/pci.h
--- 2.5/drivers/pci/pci.h~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.469923128 +0800
+++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:58:06.473922520 +0800
@@ -13,6 +13,7 @@ extern int pci_bus_alloc_resource(struct
 				  void *alignf_data);
 /* Firmware callbacks */
 extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
+extern int (*platform_pci_set_power_state)(struct pci_dev *dev, int state);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
_


--=-HonJR+DY4pY3ZBYHtV7J
Content-Disposition: attachment; filename=p00004_acpi-pci-set-power-state-callback.patch
Content-Type: text/x-patch; name=p00004_acpi-pci-set-power-state-callback.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


An ACPI callback for PCI set power state

---

 2.5-root/drivers/acpi/bus.c     |    8 +++++++-
 2.5-root/drivers/pci/pci-acpi.c |   11 +++++++++++
 2.5-root/drivers/pci/pci.c      |   11 +++++++++--
 2.5-root/drivers/pci/pci.h      |    1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/bus.c~acpi-pci-set-power-state-callback drivers/acpi/bus.c
--- 2.5/drivers/acpi/bus.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.464923888 +0800
+++ 2.5-root/drivers/acpi/bus.c	2005-01-05 09:58:06.473922520 +0800
@@ -212,6 +212,12 @@ acpi_bus_set_power (
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Device is not power manageable\n"));
 		return_VALUE(-ENODEV);
 	}
+	/*
+	 * Get device's current power state if it's unknown
+	 * This means device power state isn't initialized or previous setting failed
+	 */
+	if (device->power.state == ACPI_STATE_UNKNOWN)
+		acpi_bus_get_power(device->handle, &device->power.state);
 	if (state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n", state));
 		return_VALUE(0);
@@ -231,7 +237,7 @@ acpi_bus_set_power (
 	 * On transitions to a high-powered state we first apply power (via
 	 * power resources) then evalute _PSx.  Conversly for transitions to
 	 * a lower-powered state.
-	 */ 
+	 */
 	if (state < device->power.state) {
 		if (device->power.flags.power_resources) {
 			result = acpi_power_transition(device, state);
diff -puN drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.466923584 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-05 09:58:06.472922672 +0800
@@ -226,6 +226,16 @@ static int acpi_get_suspend_state(struct
 	return -ENODEV;
 }
 
+static int acpi_set_power_state(struct pci_dev *dev, int state)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	if (!handle)
+		return -ENODEV;
+	return acpi_bus_set_power(handle, state);
+}
+
+
 /* ACPI bus type */
 int pci_acpi_bind_device(struct device *dev, acpi_handle *handle)
 {
@@ -269,6 +279,7 @@ static int __init pci_acpi_init(void)
 	if (ret)
 		return 0;
 	platform_pci_get_suspend_state = acpi_get_suspend_state;
+	platform_pci_set_power_state = acpi_set_power_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -puN drivers/pci/pci.c~acpi-pci-set-power-state-callback drivers/pci/pci.c
--- 2.5/drivers/pci/pci.c~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.467923432 +0800
+++ 2.5-root/drivers/pci/pci.c	2005-01-05 09:58:06.473922520 +0800
@@ -240,7 +240,7 @@ pci_find_parent_resource(const struct pc
  * -EIO if device does not support PCI PM.
  * 0 if we can successfully change the power state.
  */
-
+int (*platform_pci_set_power_state)(struct pci_dev *, int) = NULL;
 int
 pci_set_power_state(struct pci_dev *dev, int state)
 {
@@ -294,8 +294,15 @@ pci_set_power_state(struct pci_dev *dev,
 		msleep(10);
 	else if(state == 2 || dev->current_state == 2)
 		udelay(200);
-	dev->current_state = state;
 
+	/*
+	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
+	 * Firmware method after natice method ?
+	 */
+	if (platform_pci_set_power_state)
+		platform_pci_set_power_state(dev, state);
+
+	dev->current_state = state;
 	return 0;
 }
 
diff -puN drivers/pci/pci.h~acpi-pci-set-power-state-callback drivers/pci/pci.h
--- 2.5/drivers/pci/pci.h~acpi-pci-set-power-state-callback	2005-01-05 09:58:06.469923128 +0800
+++ 2.5-root/drivers/pci/pci.h	2005-01-05 09:58:06.473922520 +0800
@@ -13,6 +13,7 @@ extern int pci_bus_alloc_resource(struct
 				  void *alignf_data);
 /* Firmware callbacks */
 extern int (*platform_pci_get_suspend_state)(struct device *dev, u32 state);
+extern int (*platform_pci_set_power_state)(struct pci_dev *dev, int state);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
_

--=-HonJR+DY4pY3ZBYHtV7J--

