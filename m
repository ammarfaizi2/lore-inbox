Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWIVJgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWIVJgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWIVJgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:36:49 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:37854 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751122AbWIVJgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:36:45 -0400
Date: Fri, 22 Sep 2006 11:37:08 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [5/9] driver core fixes: bus_add_device() cleanup on error
Message-ID: <20060922113708.4489017c@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Correct cleanup in the error path of bus_add_device().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/bus.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- linux-2.6-CH.orig/drivers/base/bus.c
+++ linux-2.6-CH/drivers/base/bus.c
@@ -387,18 +387,29 @@ int bus_add_device(struct device * dev)
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
 		error = make_deprecated_bus_links(dev);
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
 
