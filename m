Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWINHkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWINHkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWINHkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:40:04 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:36830 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751430AbWINHkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:40:02 -0400
Date: Thu, 14 Sep 2006 09:40:22 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [07/12] driver core fixes: bus_add_device() cleanup on error
Message-ID: <20060914094022.5f40e746@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1158168423.14312.16.camel@localhost>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
	<20060913183851.17a7ead6@gondolin.boeblingen.de.ibm.com>
	<1158168423.14312.16.camel@localhost>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 10:27:02 -0700,
Joe Perches <joe@perches.com> wrote:

> better to have a separate error return and a no error return

How about this one?

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Correct cleanup in the error path of bus_add_device().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 bus.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc6/drivers/base/bus.c	2006-09-14 09:32:16.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/bus.c	2006-09-14 09:35:30.000000000 +0200
@@ -372,19 +372,31 @@ int bus_add_device(struct device * dev)
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
+			goto out_create;
+		put_bus(dev->bus);
 	}
-out:
+	return 0;
+
+out_create:
+	sysfs_remove_link(&dev->kobj, "subsystem");
+out_subsys:
+	sysfs_remove_link(&bus->devices.kobj, dev->bus_id);
+out_id:
+	device_remove_attrs(bus, dev);
+out_put:
+	put_bus(dev->bus);
 	return error;
 }
 
