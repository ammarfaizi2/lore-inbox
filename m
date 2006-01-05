Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWAEObq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWAEObq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWAEObl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:31:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51984 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751337AbWAEObj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:31:39 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 4/29] Add ecard_bus_type probe/remove/shutdown methods
Date: Thu, 05 Jan 2006 14:31:29 +0000
Message-ID: <20060105142951.13.04@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/arm26/kernel/ecard.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/arm26/kernel/ecard.c linux/arch/arm26/kernel/ecard.c
--- linus/arch/arm26/kernel/ecard.c	Sun Nov  6 22:14:20 2005
+++ linux/arch/arm26/kernel/ecard.c	Sun Nov 13 15:52:04 2005
@@ -793,9 +793,11 @@ static void ecard_drv_shutdown(struct de
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
 	req.req = req_reset;
 	req.ec = ec;
 	ecard_call(&req);
@@ -804,9 +806,6 @@ static void ecard_drv_shutdown(struct de
 int ecard_register_driver(struct ecard_driver *drv)
 {
 	drv->drv.bus = &ecard_bus_type;
-	drv->drv.probe = ecard_drv_probe;
-	drv->drv.remove = ecard_drv_remove;
-	drv->drv.shutdown = ecard_drv_shutdown;
 
 	return driver_register(&drv->drv);
 }
@@ -832,8 +831,11 @@ static int ecard_match(struct device *_d
 }
 
 struct bus_type ecard_bus_type = {
-	.name	= "ecard",
-	.match	= ecard_match,
+	.name		= "ecard",
+	.match		= ecard_match,
+	.probe		= ecard_drv_probe,
+	.remove		= ecard_drv_remove,
+	.shutdown	= ecard_drv_shutdown,
 };
 
 static int ecard_bus_init(void)
