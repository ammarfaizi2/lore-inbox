Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWE2Rhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWE2Rhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 13:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWE2Rhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 13:37:37 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:29025 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751098AbWE2Rhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 13:37:36 -0400
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.17-rc3] platform_bus learns about modalias
Date: Mon, 29 May 2006 10:37:33 -0700
User-Agent: KMail/1.7.1
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200605011116.02250.david-b@pacbell.net>
In-Reply-To: <200605011116.02250.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eFzeEJajN0OvaiP"
Message-Id: <200605291037.34305.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_eFzeEJajN0OvaiP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 01 May 2006 11:16 am, David Brownell wrote:
> This is one of the most significant busses not to support the $MODALIAS
> and /sys/devices/.../modalias conventions.

Here's a replacement patch, against RC5.  The modalias file itself
should have a newline termination, and on some platforms the min()
invocation caused compiler trouble (hence a build patch found in
the MM tree).

- Dave


--Boundary-00=_eFzeEJajN0OvaiP
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
--- g26.orig/drivers/base/platform.c	2006-05-24 19:16:50.000000000 -0700
+++ g26/drivers/base/platform.c	2006-05-24 21:15:52.000000000 -0700
@@ -452,6 +452,37 @@ void platform_driver_unregister(struct p
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
+	int len = snprintf(buf, PAGE_SIZE, "%s\n", pdev->name);
+
+	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
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
@@ -496,7 +527,9 @@ static int platform_resume(struct device
 
 struct bus_type platform_bus_type = {
 	.name		= "platform",
+	.dev_attrs	= platform_dev_attrs,
 	.match		= platform_match,
+	.uevent		= platform_uevent,
 	.suspend	= platform_suspend,
 	.resume		= platform_resume,
 };

--Boundary-00=_eFzeEJajN0OvaiP--
