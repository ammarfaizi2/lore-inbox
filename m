Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268502AbUJDVnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbUJDVnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268575AbUJDVhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:37:07 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:25035 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268594AbUJDVcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:32:06 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Mon, 4 Oct 2004 14:00:04 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UnbYBSTk0e8RnLT"
Message-Id: <200410041400.04385.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_UnbYBSTk0e8RnLT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This lets drivers standardize how they present their ability to issue
wakeups, and how they manage whether that ability should be used.

--Boundary-00=_UnbYBSTk0e8RnLT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="wake-core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wake-core.patch"

This adds basic driver model and sysfs support for device wakeup
capabilities.

 - adds two driver model pmcore wakeup bits:
     * can_wakeup, initialized using device_init_wakeup() in bus
       or device driver code
     * should_wakeup, tested by device_may_wakeup() during device
       power state transitions

 - make that new state observable and manageable by letting sysfs
   change the should_wakeup policy by writing the "wakeup" attribute

This patch doesn't add callers or change existing wakeup code like:

 - USB (these bits replace two existing usb-internal bits)
 - PCI (can_wakeup coming from PCI PM capability)
 - ACPI (this should probably replace the new /proc/acpi/wakeup)
 - Ethtool should just set WOL policies
 - ... probably there are others.

Patches for the USB and PCI exist already.

[ against 2.6.9-rc3 ]


--- 1.4/drivers/base/power/sysfs.c	Wed Jun  9 23:34:24 2004
+++ edited/drivers/base/power/sysfs.c	Mon Oct  4 12:22:13 2004
@@ -48,8 +48,71 @@
 static DEVICE_ATTR(state, 0644, state_show, state_store);
 
 
+/*
+ *	wakeup - Report/change current wakeup option for device
+ *
+ *	Some devices support "wakeup" events, which are hardware signals
+ *	used to activate devices in suspended or low power states.  Such
+ *	devices have one of two wakeup options:  "enabled" to issue the
+ *	events, otherwise "disabled".  The value is effective at the next
+ *	state change.  (Other devices have no value for this option.)
+ *
+ *	Familiar examples of devices that can issue wakeup events include
+ *	keyboards and mice (both PS2 and USB styles), power buttons, clocks,
+ *	"Wake-On-LAN" Ethernet links, modems, and more.  Sometimes these
+ *	events will wake the system from a suspend state, but often they
+ *	just wake up a single device that's been selectively suspended.
+ *
+ *	It is the responsibility of device drivers to enable (or disable)
+ *	wakeup signaling as part of changing device suspend or power states,
+ *	respecting the policy choice provided through the driver model.
+ *
+ *	Devices may not be able to generate wakeup events from all power
+ *	states.  Also, the events may be ignored in some configurations;
+ *	for example, they might need help from other devices.  Some drivers
+ *	use wakeup events internally, keeping their hardware in a low power
+ *	mode most of the time (even without a system-wide suspend state),
+ *	unless wakeup is disabled.
+ */
+
+static const char enabled[] = "enabled";
+static const char disabled[] = "disabled";
+
+static ssize_t wake_show(struct device * dev, char * buf)
+{
+	return sprintf(buf, "%s\n", device_can_wakeup(dev)
+		? (device_may_wakeup(dev) ? enabled : disabled)
+		: "");
+}
+
+static ssize_t wake_store(struct device * dev, const char * buf, size_t n)
+{
+	char *cp;
+	int len = n;
+
+	if (!device_can_wakeup(dev))
+		return -EINVAL;
+
+	cp = memchr(buf, '\n', n);
+	if (cp)
+		len = cp - buf;
+	if (len == sizeof enabled - 1
+			&& strncmp(buf, enabled, sizeof enabled - 1) == 0)
+		device_set_wakeup_enable(dev, 1);
+	else if (len == sizeof disabled - 1
+			&& strncmp(buf, disabled, sizeof disabled - 1) == 0)
+		device_set_wakeup_enable(dev, 0);
+	else
+		return -EINVAL;
+	return n;
+}
+
+static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
+
+
 static struct attribute * power_attrs[] = {
 	&dev_attr_state.attr,
+	&dev_attr_wakeup.attr,
 	NULL,
 };
 static struct attribute_group pm_attr_group = {
--- 1.19/include/linux/pm.h	Thu Sep 30 11:23:17 2004
+++ edited/include/linux/pm.h	Mon Oct  4 12:22:13 2004
@@ -237,6 +237,8 @@
 	atomic_t		pm_users;
 	struct device		* pm_parent;
 	struct list_head	entry;
+	unsigned		can_wakeup:1;
+	unsigned		should_wakeup:1;
 #endif
 };
 
@@ -247,6 +249,23 @@
 extern void device_power_up(void);
 extern void device_resume(void);
 
+/* wakeup changes take effect on device's next pm state change */
+#ifdef CONFIG_PM
+#define device_init_wakeup(dev,val) \
+	((dev)->power.can_wakeup = ((dev)->power.should_wakeup = !!(val)))
+#define device_set_wakeup_enable(dev,val) \
+	((dev)->power.should_wakeup = (dev)->power.can_wakeup ? !!(val) : 0)
+#define device_can_wakeup(dev) \
+	((dev)->power.can_wakeup)
+#define device_may_wakeup(dev) \
+	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
+
+#else /* !CONFIG_PM */
+#define device_init_wakeup(dev,val)		do()while(0)
+#define device_set_wakeup_enable(dev,val)	do()while(0)
+#define device_can_wakeup(dev)			(0)
+#define device_may_wakeup(dev)			(0)
+#endif
 
 #endif /* __KERNEL__ */
 

--Boundary-00=_UnbYBSTk0e8RnLT--
