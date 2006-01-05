Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWAEOd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWAEOd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWAEOd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:33:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54544 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751337AbWAEOdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:33:40 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 8/29] Add logic module bus_type probe/remove methods
Date: Thu, 05 Jan 2006 14:33:35 +0000
Message-ID: <20060105142951.13.08@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/arm/mach-integrator/lm.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/arm/mach-integrator/lm.c linux/arch/arm/mach-integrator/lm.c
--- linus/arch/arm/mach-integrator/lm.c	Sun Nov  6 22:14:16 2005
+++ linux/arch/arm/mach-integrator/lm.c	Sun Nov 13 15:57:58 2005
@@ -22,20 +22,6 @@ static int lm_match(struct device *dev, 
 	return 1;
 }
 
-static struct bus_type lm_bustype = {
-	.name		= "logicmodule",
-	.match		= lm_match,
-//	.suspend	= lm_suspend,
-//	.resume		= lm_resume,
-};
-
-static int __init lm_init(void)
-{
-	return bus_register(&lm_bustype);
-}
-
-postcore_initcall(lm_init);
-
 static int lm_bus_probe(struct device *dev)
 {
 	struct lm_device *lmdev = to_lm_device(dev);
@@ -49,16 +35,30 @@ static int lm_bus_remove(struct device *
 	struct lm_device *lmdev = to_lm_device(dev);
 	struct lm_driver *lmdrv = to_lm_driver(dev->driver);
 
-	lmdrv->remove(lmdev);
+	if (lmdrv->remove)
+		lmdrv->remove(lmdev);
 	return 0;
 }
 
+static struct bus_type lm_bustype = {
+	.name		= "logicmodule",
+	.match		= lm_match,
+	.probe		= lm_bus_probe,
+	.remove		= lm_bus_remove,
+//	.suspend	= lm_bus_suspend,
+//	.resume		= lm_bus_resume,
+};
+
+static int __init lm_init(void)
+{
+	return bus_register(&lm_bustype);
+}
+
+postcore_initcall(lm_init);
+
 int lm_driver_register(struct lm_driver *drv)
 {
 	drv->drv.bus = &lm_bustype;
-	drv->drv.probe = lm_bus_probe;
-	drv->drv.remove = lm_bus_remove;
-
 	return driver_register(&drv->drv);
 }
 
