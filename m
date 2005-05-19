Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVESUum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVESUum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVESUum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:50:42 -0400
Received: from soundwarez.org ([217.160.171.123]:40377 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261250AbVESUue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:50:34 -0400
Date: Thu, 19 May 2005 22:50:32 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: David Zeuthen <davidz@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: restore event order for device_add()
Message-ID: <20050519205032.GA3301@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of the split of the kobject-registration and the
corresponding hotplug event, the order of events for device_add() has
changed. This restores the old order, cause it confused some userspace
applications.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -248,6 +248,7 @@ int device_add(struct device *dev)
 
 	if ((error = kobject_add(&dev->kobj)))
 		goto Error;
+	kobject_hotplug(&dev->kobj, KOBJ_ADD);
 	if ((error = device_pm_add(dev)))
 		goto PMError;
 	if ((error = bus_add_device(dev)))
@@ -260,14 +261,13 @@ int device_add(struct device *dev)
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
-
-	kobject_hotplug(&dev->kobj, KOBJ_ADD);
  Done:
 	put_device(dev);
 	return error;
  BusError:
 	device_pm_remove(dev);
  PMError:
+	kobject_hotplug(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
  Error:
 	if (parent)

