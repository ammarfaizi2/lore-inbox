Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWDNULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWDNULd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWDNULK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:11:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:397 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965120AbWDNULF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:11:05 -0400
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/7] pm: print name of failed suspend function
In-Reply-To: <11450453961276-git-send-email-greg@kroah.com>
X-Mailer: git-send-email
Date: Fri, 14 Apr 2006 13:09:57 -0700
Message-Id: <11450453973283-git-send-email-greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print more diagnostic info to help identify the source of power management
suspend failures.

Example:

usb_hcd_pci_suspend(): pci_set_power_state+0x0/0x1af() returns -22
pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x11b() returns -22
suspend_device(): pci_device_suspend+0x0/0x34() returns -22

Work-in-progress.  It needs lots more suspend_report_result() calls sprinkled
everywhere.

Cc: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/power/suspend.c |   12 ++++++++++++
 drivers/pci/pci-driver.c     |    6 ++++--
 drivers/pci/pci.c            |    6 ++++--
 drivers/usb/core/hcd-pci.c   |    7 +++----
 include/linux/pm.h           |    8 ++++++++
 5 files changed, 31 insertions(+), 8 deletions(-)

026694920579590c73b5c56705d543568ed5ad41
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index bdb6066..662209d 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -10,6 +10,8 @@
 
 #include <linux/vt_kern.h>
 #include <linux/device.h>
+#include <linux/kallsyms.h>
+#include <linux/pm.h>
 #include "../base.h"
 #include "power.h"
 
@@ -58,6 +60,7 @@ int suspend_device(struct device * dev, 
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
 		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
+		suspend_report_result(dev->bus->suspend, error);
 	}
 	up(&dev->sem);
 	return error;
@@ -169,3 +172,12 @@ int device_power_down(pm_message_t state
 
 EXPORT_SYMBOL_GPL(device_power_down);
 
+void __suspend_report_result(const char *function, void *fn, int ret)
+{
+	if (ret) {
+		printk(KERN_ERR "%s(): ", function);
+		print_fn_descriptor_symbol("%s() returns ", (unsigned long)fn);
+		printk("%d\n", ret);
+	}
+}
+EXPORT_SYMBOL_GPL(__suspend_report_result);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f22f69a..1456759 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -271,10 +271,12 @@ static int pci_device_suspend(struct dev
 	struct pci_driver * drv = pci_dev->driver;
 	int i = 0;
 
-	if (drv && drv->suspend)
+	if (drv && drv->suspend) {
 		i = drv->suspend(pci_dev, state);
-	else
+		suspend_report_result(drv->suspend, i);
+	} else {
 		pci_save_state(pci_dev);
+	}
 	return i;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bea1ad1..042fa52 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -307,9 +307,11 @@ pci_set_power_state(struct pci_dev *dev,
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
 	 */
-	if (state != PCI_D0 && dev->current_state > state)
+	if (state != PCI_D0 && dev->current_state > state) {
+		printk(KERN_ERR "%s(): %s: state=%d, current state=%d\n",
+			__FUNCTION__, pci_name(dev), state, dev->current_state);
 		return -EINVAL;
-	else if (dev->current_state == state) 
+	} else if (dev->current_state == state)
 		return 0;        /* we're already there */
 
 	/* find PCI PM capability in list */
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 0d2193b..66b7840 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -213,11 +213,9 @@ int usb_hcd_pci_suspend (struct pci_dev 
 
 	if (hcd->driver->suspend) {
 		retval = hcd->driver->suspend(hcd, message);
-		if (retval) {
-			dev_dbg (&dev->dev, "PCI pre-suspend fail, %d\n",
-				retval);
+		suspend_report_result(hcd->driver->suspend, retval);
+		if (retval)
 			goto done;
-		}
 	}
 	synchronize_irq(dev->irq);
 
@@ -263,6 +261,7 @@ int usb_hcd_pci_suspend (struct pci_dev 
 		 * some device state (e.g. as part of clock reinit).
 		 */
 		retval = pci_set_power_state (dev, PCI_D3hot);
+		suspend_report_result(pci_set_power_state, retval);
 		if (retval == 0) {
 			int wake = device_can_wakeup(&hcd->self.root_hub->dev);
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 6df2585..66be589 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -199,6 +199,12 @@ extern int device_suspend(pm_message_t s
 
 extern int dpm_runtime_suspend(struct device *, pm_message_t);
 extern void dpm_runtime_resume(struct device *);
+extern void __suspend_report_result(const char *function, void *fn, int ret);
+
+#define suspend_report_result(fn, ret)					\
+	do {								\
+		__suspend_report_result(__FUNCTION__, fn, ret);		\
+	} while (0)
 
 #else /* !CONFIG_PM */
 
@@ -219,6 +225,8 @@ static inline void dpm_runtime_resume(st
 {
 }
 
+#define suspend_report_result(fn, ret) do { } while (0)
+
 #endif
 
 /* changes to device_may_wakeup take effect on the next pm state change.
-- 
1.2.6


