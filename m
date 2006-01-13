Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422888AbWAMTw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWAMTw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422918AbWAMTwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:52:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:55956 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422886AbWAMTue convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:34 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add logic module bus_type probe/remove methods
In-Reply-To: <1137181808236@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:09 -0800
Message-Id: <11371818092544@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add logic module bus_type probe/remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5c0784c350516856ed15deb6adf6b053bf427792
tree 283a9078a98288b2f8352d8d6999ac32ffb05f5d
parent 306955be37dd1b1f232f19766227ccccb83f7873
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:33:35 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:05 -0800

 arch/arm/mach-integrator/lm.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-integrator/lm.c b/arch/arm/mach-integrator/lm.c
index 5b41e3a..622cdc4 100644
--- a/arch/arm/mach-integrator/lm.c
+++ b/arch/arm/mach-integrator/lm.c
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
 

