Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWFUTwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWFUTwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWFUTuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16026 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030245AbWFUTth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:37 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 9/22] [PATCH] platform_bus learns about modalias
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:52 -0700
Message-Id: <1150919192294-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509191893358-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This patch adds modalias support to platform devices, for simpler
hotplug/coldplug driven driver setup.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/platform.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 83f5c59..f807197 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
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
-- 
1.4.0

