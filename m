Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162270AbWLAXe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162270AbWLAXe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162253AbWLAXWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:22:54 -0500
Received: from mx1.suse.de ([195.135.220.2]:12429 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162241AbWLAXWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:33 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/36] CONFIG_SYSFS_DEPRECATED - bus symlinks
Date: Fri,  1 Dec 2006 15:21:36 -0800
Message-Id: <11650153432284-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153392022-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Turn off the bus symlinks if CONFIG_SYSFS_DEPRECATED is enabled

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ed3e8a2..472810f 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -355,6 +355,21 @@ static void device_remove_attrs(struct b
 	}
 }
 
+#ifdef CONFIG_SYSFS_DEPRECATED
+static int make_deprecated_bus_links(struct device *dev)
+{
+	return sysfs_create_link(&dev->kobj,
+				 &dev->bus->subsys.kset.kobj, "bus");
+}
+
+static void remove_deprecated_bus_links(struct device *dev)
+{
+	sysfs_remove_link(&dev->kobj, "bus");
+}
+#else
+static inline int make_deprecated_bus_links(struct device *dev) { return 0; }
+static inline void remove_deprecated_bus_links(struct device *dev) { }
+#endif
 
 /**
  *	bus_add_device - add device to bus
@@ -381,8 +396,7 @@ int bus_add_device(struct device * dev)
 				&dev->bus->subsys.kset.kobj, "subsystem");
 		if (error)
 			goto out_subsys;
-		error = sysfs_create_link(&dev->kobj,
-				&dev->bus->subsys.kset.kobj, "bus");
+		error = make_deprecated_bus_links(dev);
 		if (error)
 			goto out_deprecated;
 	}
@@ -436,7 +450,7 @@ void bus_remove_device(struct device * d
 {
 	if (dev->bus) {
 		sysfs_remove_link(&dev->kobj, "subsystem");
-		sysfs_remove_link(&dev->kobj, "bus");
+		remove_deprecated_bus_links(dev);
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
 		if (dev->is_registered) {
-- 
1.4.4.1

