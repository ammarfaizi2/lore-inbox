Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWJWErf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWJWErf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWJWErf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:47:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:57475 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751471AbWJWErf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:47:35 -0400
Subject: [PATCH] Call platform_notify_remove later
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20061020061618.GA9432@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain>
	 <20061020032624.GA7620@kroah.com>
	 <1161318564.10524.131.camel@localhost.localdomain>
	 <20061020044454.GA8627@kroah.com>
	 <1161322979.10524.143.camel@localhost.localdomain>
	 <20061020061618.GA9432@kroah.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 14:47:21 +1000
Message-Id: <1161578841.10524.373.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the call to platform_notify_remove() to after the call
to bus_remove_device(), where it belongs. It's bogus to notify the
platform of removal while drivers are still attached to the device and
possibly still operating since the platform might use this callback to
tear down some resources used by the driver (ACPI bits, iommu
table, ...)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note that Len Browned wrote "AFAICS, your change is logical and should
be fine." which I consider an ACK, though I didn't add an Acked-by
line :)

This patch should go in imho after 2.6.19 (it might even be considered a
bug fix for 2.6.19 but it's probably not bad enough, so let's have it
simmer in your tree and -mm for a little while).

This is orthogonal to my other patch adding a notifier which we can
continue discussing separately.

Index: linux-cell/drivers/base/core.c
===================================================================
--- linux-cell.orig/drivers/base/core.c	2006-10-06 13:48:02.000000000 +1000
+++ linux-cell/drivers/base/core.c	2006-10-18 11:53:50.000000000 +1000
@@ -608,12 +608,13 @@ void device_del(struct device * dev)
 	device_remove_groups(dev);
 	device_remove_attrs(dev);
 
+	bus_remove_device(dev);
+
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
-	bus_remove_device(dev);
 	device_pm_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
 


