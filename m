Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422836AbWJRUOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422836AbWJRUOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422837AbWJRUJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:34794 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422840AbWJRUJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:33 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 9/16] driver core fixes: bus_add_device() cleanup on error
Date: Wed, 18 Oct 2006 13:09:00 -0700
Message-Id: <11612021733101-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021701905-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com> <11612021701905-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Correct cleanup in the error path of bus_add_device().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/bus.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index b90f6e6..d516f7d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -372,19 +372,30 @@ int bus_add_device(struct device * dev)
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
 		error = device_add_attrs(bus, dev);
 		if (error)
-			goto out;
+			goto out_put;
 		error = sysfs_create_link(&bus->devices.kobj,
 						&dev->kobj, dev->bus_id);
 		if (error)
-			goto out;
+			goto out_id;
 		error = sysfs_create_link(&dev->kobj,
 				&dev->bus->subsys.kset.kobj, "subsystem");
 		if (error)
-			goto out;
+			goto out_subsys;
 		error = sysfs_create_link(&dev->kobj,
 				&dev->bus->subsys.kset.kobj, "bus");
+		if (error)
+			goto out_deprecated;
 	}
-out:
+	return 0;
+
+out_deprecated:
+	sysfs_remove_link(&dev->kobj, "subsystem");
+out_subsys:
+	sysfs_remove_link(&bus->devices.kobj, dev->bus_id);
+out_id:
+	device_remove_attrs(bus, dev);
+out_put:
+	put_bus(dev->bus);
 	return error;
 }
 
-- 
1.4.2.4

