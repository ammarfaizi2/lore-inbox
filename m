Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268013AbTBWDBf>; Sat, 22 Feb 2003 22:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268015AbTBWDBe>; Sat, 22 Feb 2003 22:01:34 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:43947 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S268013AbTBWDBc>;
	Sat, 22 Feb 2003 22:01:32 -0500
Date: Sat, 22 Feb 2003 22:10:55 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Aditional PnP Changes for 2.5.62
Message-ID: <20030222221055.GD1212@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030222221004.GC1212@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222221004.GC1212@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1024  -> 1.1025 
#	drivers/pnp/resource.c	1.8     -> 1.9    
#	drivers/pnp/manager.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/22	ambx1@neo.rr.com	1.1025
# Resource Management Performance Fix
# 
# Fixes a typo in pnp_check_*_conflicts functions.  Without this fix the
# resource algorithm will work but will take longer to assign resources.
# 
# Also contains some minor reordering in pnp_activate_dev.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Sat Feb 22 22:04:48 2003
+++ b/drivers/pnp/manager.c	Sat Feb 22 22:04:48 2003
@@ -602,10 +602,6 @@
 		pnp_info("res: The PnP device '%s' is already active.", dev->dev.bus_id);
 		return -EBUSY;
 	}
-	spin_lock(&pnp_lock);	/* we lock just in case the device is being configured during this call */
-	dev->active = 1;
-	spin_unlock(&pnp_lock); /* once the device is claimed active we know it won't be configured so we can unlock */
-
 	/* If this condition is true, advanced configuration failed, we need to get this device up and running
 	 * so we use the simple config engine which ignores cold conflicts, this of course may lead to new failures */
 	if (!pnp_is_active(dev)) {
@@ -614,6 +610,11 @@
 			goto fail;
 		}
 	}
+
+	spin_lock(&pnp_lock);	/* we lock just in case the device is being configured during this call */
+	dev->active = 1;
+	spin_unlock(&pnp_lock); /* once the device is claimed active we know it won't be configured so we can unlock */
+
 	if (dev->config_mode & PNP_CONFIG_INVALID) {
 		pnp_info("res: Unable to activate the PnP device '%s' because its resource configuration is invalid.", dev->dev.bus_id);
 		goto fail;
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Sat Feb 22 22:04:48 2003
+++ b/drivers/pnp/resource.c	Sat Feb 22 22:04:48 2003
@@ -268,7 +268,7 @@
 	/* check for cold conflicts */
 	pnp_for_each_dev(tdev) {
 		/* Is the device configurable? */
-		if (tdev == dev || (mode ? !dev->active : dev->active))
+		if (tdev == dev || (mode ? !tdev->active : tdev->active))
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
 			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
@@ -339,7 +339,7 @@
 	/* check for cold conflicts */
 	pnp_for_each_dev(tdev) {
 		/* Is the device configurable? */
-		if (tdev == dev || (mode ? !dev->active : dev->active))
+		if (tdev == dev || (mode ? !tdev->active : tdev->active))
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
 			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
@@ -408,7 +408,7 @@
 	/* check for cold conflicts */
 	pnp_for_each_dev(tdev) {
 		/* Is the device configurable? */
-		if (tdev == dev || (mode ? !dev->active : dev->active))
+		if (tdev == dev || (mode ? !tdev->active : tdev->active))
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
 			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
@@ -490,7 +490,7 @@
 	/* check for cold conflicts */
 	pnp_for_each_dev(tdev) {
 		/* Is the device configurable? */
-		if (tdev == dev || (mode ? !dev->active : dev->active))
+		if (tdev == dev || (mode ? !tdev->active : tdev->active))
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
 			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
