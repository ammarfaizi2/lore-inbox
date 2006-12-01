Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162324AbWLAXaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162324AbWLAXaM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162266AbWLAX3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:29:35 -0500
Received: from cantor.suse.de ([195.135.220.2]:45709 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162273AbWLAXXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:46 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 27/36] Driver core: Call platform_notify_remove later
Date: Fri,  1 Dec 2006 15:21:57 -0800
Message-Id: <1165015415131-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154123942-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Move the call to platform_notify_remove() to after the call to
bus_remove_device(), where it belongs.  It's bogus to notify the platform
of removal while drivers are still attached to the device and possibly
still operating since the platform might use this callback to tear down
some resources used by the driver (ACPI bits, iommu table, ...)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f544adc..5d11bbd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -682,6 +682,7 @@ void device_del(struct device * dev)
 	device_remove_file(dev, &dev->uevent_attr);
 	device_remove_groups(dev);
 	device_remove_attrs(dev);
+	bus_remove_device(dev);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
@@ -691,7 +692,6 @@ void device_del(struct device * dev)
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
-	bus_remove_device(dev);
 	device_pm_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
-- 
1.4.4.1

