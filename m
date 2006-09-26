Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWIZFjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWIZFjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWIZFja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:30 -0400
Received: from ns.suse.de ([195.135.220.2]:59105 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751405AbWIZFjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:23 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 25/47] PM: platform_bus and late_suspend/early_resume
Date: Mon, 25 Sep 2006 22:37:45 -0700
Message-Id: <11592491643725-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491611339-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Teach platform_bus about the new suspend_late/resume_early PM calls,
issued with IRQs off.  Do we really need sysdev and friends any more,
or can janitors start switching its users over to platform_device so
we can do a minor code-ectomy?

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/platform.c         |   30 ++++++++++++++++++++++++++++--
 include/linux/platform_device.h |    2 ++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 2b8755d..940ce41 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -505,12 +505,36 @@ static int platform_match(struct device 
 	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
 }
 
-static int platform_suspend(struct device * dev, pm_message_t state)
+static int platform_suspend(struct device *dev, pm_message_t mesg)
 {
 	int ret = 0;
 
 	if (dev->driver && dev->driver->suspend)
-		ret = dev->driver->suspend(dev, state);
+		ret = dev->driver->suspend(dev, mesg);
+
+	return ret;
+}
+
+static int platform_suspend_late(struct device *dev, pm_message_t mesg)
+{
+	struct platform_driver *drv = to_platform_driver(dev->driver);
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+	int ret = 0;
+
+	if (dev->driver && drv->suspend_late)
+		ret = drv->suspend_late(pdev, mesg);
+
+	return ret;
+}
+
+static int platform_resume_early(struct device *dev)
+{
+	struct platform_driver *drv = to_platform_driver(dev->driver);
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+	int ret = 0;
+
+	if (dev->driver && drv->resume_early)
+		ret = drv->resume_early(pdev);
 
 	return ret;
 }
@@ -531,6 +555,8 @@ struct bus_type platform_bus_type = {
 	.match		= platform_match,
 	.uevent		= platform_uevent,
 	.suspend	= platform_suspend,
+	.suspend_late	= platform_suspend_late,
+	.resume_early	= platform_resume_early,
 	.resume		= platform_resume,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 782090c..29cd6de 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -49,6 +49,8 @@ struct platform_driver {
 	int (*remove)(struct platform_device *);
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
+	int (*suspend_late)(struct platform_device *, pm_message_t state);
+	int (*resume_early)(struct platform_device *);
 	int (*resume)(struct platform_device *);
 	struct device_driver driver;
 };
-- 
1.4.2.1

