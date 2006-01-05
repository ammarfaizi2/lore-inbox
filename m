Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWAEObQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWAEObQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWAEObP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:31:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8714 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751326AbWAEObG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:31:06 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 3/29] Add ecard_bus_type probe/remove/shutdown methods
Date: Thu, 05 Jan 2006 14:30:57 +0000
Message-ID: <20060105142951.13.03@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/arm/kernel/ecard.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/arm/kernel/ecard.c linux/arch/arm/kernel/ecard.c
--- linus/arch/arm/kernel/ecard.c	Sun Nov  6 22:14:13 2005
+++ linux/arch/arm/kernel/ecard.c	Sun Nov 13 15:52:20 2005
@@ -1146,9 +1146,11 @@ static void ecard_drv_shutdown(struct de
 	struct ecard_driver *drv = ECARD_DRV(dev->driver);
 	struct ecard_request req;
 
-	if (drv->shutdown)
-		drv->shutdown(ec);
-	ecard_release(ec);
+	if (dev->driver) {
+		if (drv->shutdown)
+			drv->shutdown(ec);
+		ecard_release(ec);
+	}
 
 	/*
 	 * If this card has a loader, call the reset handler.
@@ -1163,9 +1165,6 @@ static void ecard_drv_shutdown(struct de
 int ecard_register_driver(struct ecard_driver *drv)
 {
 	drv->drv.bus = &ecard_bus_type;
-	drv->drv.probe = ecard_drv_probe;
-	drv->drv.remove = ecard_drv_remove;
-	drv->drv.shutdown = ecard_drv_shutdown;
 
 	return driver_register(&drv->drv);
 }
@@ -1194,6 +1193,9 @@ struct bus_type ecard_bus_type = {
 	.name		= "ecard",
 	.dev_attrs	= ecard_dev_attrs,
 	.match		= ecard_match,
+	.probe		= ecard_drv_probe,
+	.remove		= ecard_drv_remove,
+	.shutdown	= ecard_drv_shutdown,
 };
 
 static int ecard_bus_init(void)
