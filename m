Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVJ1GiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVJ1GiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVJ1GhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:37:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:39914 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965137AbVJ1GbW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:22 -0400
Cc: david-b@pacbell.net
Subject: [PATCH] driver model wakeup flags
In-Reply-To: <11304810223093@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:22 -0700
Message-Id: <1130481022955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver model wakeup flags

This is a refresh of an earlier patch to add "wakeup" support to the
PM core model.  This provides per-device bus-neutral control of the
use of wakeup events.

  * "struct device_pm_info" has two bits that are initialized as
    part of setting up the enclosing struct device:
      - "can_wakeup", reflecting hardware capabilities
      - "may_wakeup", the policy setting (when CONFIG_PM)

  * There's a writeable sysfs "wakeup" file, with one of two values:
      - "enabled", when the policy is to allow wakeup
      - "disabled", when the policy is not to allow it
      - "" if the device can't currently issue wakeups

By default, wakeup is enabled on all devices that support it.  If its
driver doesn't support it ... treat it as a bug.  :)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 79eef3cfd105168a2115fff06971af8efa27db82
tree 078336166c58694cab5086cc6b69443226985445
parent 409d93787e8cfec603d512c2925f8580c32a9d0a
author David Brownell <david-b@pacbell.net> Mon, 12 Sep 2005 19:39:34 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:59 -0700

 drivers/base/core.c        |    1 +
 drivers/base/power/sysfs.c |   73 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h         |   26 +++++++++++++++-
 3 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6ab73f5..3110919 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -225,6 +225,7 @@ void device_initialize(struct device *de
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
+	device_init_wakeup(dev, 0);
 }
 
 /**
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 8d04fb4..89c5787 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -48,8 +48,81 @@ static ssize_t state_store(struct device
 static DEVICE_ATTR(state, 0644, state_show, state_store);
 
 
+/*
+ *	wakeup - Report/change current wakeup option for device
+ *
+ *	Some devices support "wakeup" events, which are hardware signals
+ *	used to activate devices from suspended or low power states.  Such
+ *	devices have one of three values for the sysfs power/wakeup file:
+ *
+ *	 + "enabled\n" to issue the events;
+ *	 + "disabled\n" not to do so; or
+ *	 + "\n" for temporary or permanent inability to issue wakeup.
+ *
+ *	(For example, unconfigured USB devices can't issue wakeups.)
+ *
+ *	Familiar examples of devices that can issue wakeup events include
+ *	keyboards and mice (both PS2 and USB styles), power buttons, modems,
+ *	"Wake-On-LAN" Ethernet links, GPIO lines, and more.  Some events
+ *	will wake the entire system from a suspend state; others may just
+ *	wake up the device (if the system as a whole is already active).
+ *	Some wakeup events use normal IRQ lines; other use special out
+ *	of band signaling.
+ *
+ *	It is the responsibility of device drivers to enable (or disable)
+ *	wakeup signaling as part of changing device power states, respecting
+ *	the policy choices provided through the driver model.
+ *
+ *	Devices may not be able to generate wakeup events from all power
+ *	states.  Also, the events may be ignored in some configurations;
+ *	for example, they might need help from other devices that aren't
+ *	active, or which may have wakeup disabled.  Some drivers rely on
+ *	wakeup events internally (unless they are disabled), keeping
+ *	their hardware in low power modes whenever they're unused.  This
+ *	saves runtime power, without requiring system-wide sleep states.
+ */
+
+static const char enabled[] = "enabled";
+static const char disabled[] = "disabled";
+
+static ssize_t
+wake_show(struct device * dev, struct device_attribute *attr, char * buf)
+{
+	return sprintf(buf, "%s\n", device_can_wakeup(dev)
+		? (device_may_wakeup(dev) ? enabled : disabled)
+		: "");
+}
+
+static ssize_t
+wake_store(struct device * dev, struct device_attribute *attr,
+	const char * buf, size_t n)
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
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 5cfb076..7897cf5 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -219,7 +219,9 @@ typedef struct pm_message {
 
 struct dev_pm_info {
 	pm_message_t		power_state;
+	unsigned		can_wakeup:1;
 #ifdef	CONFIG_PM
+	unsigned		should_wakeup:1;
 	pm_message_t		prev_state;
 	void			* saved_state;
 	atomic_t		pm_users;
@@ -236,13 +238,35 @@ extern void device_resume(void);
 
 #ifdef CONFIG_PM
 extern int device_suspend(pm_message_t state);
-#else
+
+#define device_set_wakeup_enable(dev,val) \
+	((dev)->power.should_wakeup = !!(val))
+#define device_may_wakeup(dev) \
+	(device_can_wakeup(dev) && (dev)->power.should_wakeup)
+
+#else /* !CONFIG_PM */
+
 static inline int device_suspend(pm_message_t state)
 {
 	return 0;
 }
+
+#define device_set_wakeup_enable(dev,val)	do{}while(0)
+#define device_may_wakeup(dev)			(0)
+
 #endif
 
+/* changes to device_may_wakeup take effect on the next pm state change.
+ * by default, devices should wakeup if they can.
+ */
+#define device_can_wakeup(dev) \
+	((dev)->power.can_wakeup)
+#define device_init_wakeup(dev,val) \
+	do { \
+		device_can_wakeup(dev) = !!(val); \
+		device_set_wakeup_enable(dev,val); \
+	} while(0)
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PM_H */

