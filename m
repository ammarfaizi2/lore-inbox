Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWEAVFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWEAVFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWEAVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:05:05 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:60782 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932260AbWEAVFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:05:04 -0400
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6.17-rc3] platform_bus learns about modalias
Date: Mon, 1 May 2006 11:16:01 -0700
User-Agent: KMail/1.7.1
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iBlVEMz9554EHZG"
Message-Id: <200605011116.02250.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_iBlVEMz9554EHZG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is one of the most significant busses not to support the $MODALIAS
and /sys/devices/.../modalias conventions.

--Boundary-00=_iBlVEMz9554EHZG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="plat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="plat.patch"

This patch adds modalias support to platform devices, for simpler
hotplug/coldplug driven driver setup.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/base/platform.c
===================================================================
--- g26.orig/drivers/base/platform.c	2006-04-30 19:25:25.000000000 -0700
+++ g26/drivers/base/platform.c	2006-05-01 10:30:54.000000000 -0700
@@ -452,6 +452,40 @@ void platform_driver_unregister(struct p
 EXPORT_SYMBOL_GPL(platform_driver_unregister);
 
 
+/* modalias support enables more hands-off userspace setup:
+ * (a) environment variable lets new-style hotplug events work once system is
+ *     fully running:  "modprobe $MODALIAS"
+ * (b) sysfs attribute lets new-style coldplug recover from hotplug events
+ *     mishandled before system is fully running:  "modprobe $(cat modalias)"
+ */
+static ssize_t
+modalias_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+	unsigned		len = strlen(pdev->name);
+
+	len = min(len, (size_t)(PAGE_SIZE - 1));
+	memcpy(buf, pdev->name, len);
+	buf[PAGE_SIZE - 1] = 0;
+	return len;
+}
+
+static struct device_attribute platform_dev_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
+static int platform_uevent(struct device *dev, char **envp, int num_envp,
+		char *buffer, int buffer_size)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+
+	envp[0] = buffer;
+	snprintf(buffer, buffer_size, "MODALIAS=%s", pdev->name);
+	return 0;
+}
+
+
 /**
  *	platform_match - bind platform device to platform driver.
  *	@dev:	device.
@@ -496,7 +530,9 @@ static int platform_resume(struct device
 
 struct bus_type platform_bus_type = {
 	.name		= "platform",
+	.dev_attrs	= platform_dev_attrs,
 	.match		= platform_match,
+	.uevent		= platform_uevent,
 	.suspend	= platform_suspend,
 	.resume		= platform_resume,
 };

--Boundary-00=_iBlVEMz9554EHZG--
