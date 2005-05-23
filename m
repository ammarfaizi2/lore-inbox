Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVEWXIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVEWXIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVEWXIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:08:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:28822 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261177AbVEWWnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 18:43:35 -0400
Date: Mon, 23 May 2005 15:50:26 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kay.sievers@vrfy.org
Subject: [PATCH] driver core: restore event order for device_add()
Message-ID: <20050523225026.GA531@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply this to your 2.6.12-rc4 git tree, the SCSI, HAL, and
udev people need to restore the original order of hotplug events (as
2.6.11 and before kernels provide) until they work out the details of
how to do this better.

----------

From: Kay Sievers <kay.sievers@vrfy.org>
As a result of the split of the kobject-registration and the
corresponding hotplug event, the order of events for device_add() has
changed. This restores the old order, cause it confused some userspace
applications.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/base/core.c	2005-05-23 14:59:20.000000000 -0700
+++ gregkh-2.6/drivers/base/core.c	2005-05-23 14:59:23.000000000 -0700
@@ -245,6 +245,7 @@
 
 	if ((error = kobject_add(&dev->kobj)))
 		goto Error;
+	kobject_hotplug(&dev->kobj, KOBJ_ADD);
 	if ((error = device_pm_add(dev)))
 		goto PMError;
 	if ((error = bus_add_device(dev)))
@@ -257,14 +258,13 @@
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
