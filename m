Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270342AbTHSMsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 08:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270386AbTHSMsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 08:48:46 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:12298 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S270342AbTHSMsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 08:48:43 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EISA bus update
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 19 Aug 2003 14:48:24 +0200
Message-ID: <wrp3cfxn78n.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The enclosed patch fixes a few things for the EISA bus :

- Don't leave resource name uninitialized if CONFIG_EISA_NAME is not
set.
- Print root device bus_id (so we know which bridge is probed).
- From Zwane Mwaikambo : Add a release method to virtual root, so it
stays quiet if probing fails (because some pci-eisa bridge have been
found before).

Please apply.

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1125  -> 1.1126 
#	drivers/eisa/eisa-bus.c	1.18    -> 1.19   
#	drivers/eisa/virtual_root.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/19	maz@hina.wild-wind.fr.eu.org	1.1126
# Don't leave resource name uninitialized if CONFIG_EISA_NAME is not set.
# Print root device bus_id (so we know which bridge is probed).
# From Zwane Mwaikambo :
# Add a release method to virtual root, so it stays quiet 
# if probing fails (because some pci-eisa bridge have been found before).
# --------------------------------------------
#
diff -Nru a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
--- a/drivers/eisa/eisa-bus.c	Tue Aug 19 14:44:43 2003
+++ b/drivers/eisa/eisa-bus.c	Tue Aug 19 14:44:43 2003
@@ -172,6 +172,7 @@
 {
 	char *sig;
         unsigned long sig_addr;
+	int i;
 
 	sig_addr = SLOT_ADDRESS (root, slot) + EISA_VENDOR_ID_OFFSET;
 
@@ -189,13 +190,13 @@
 	edev->dev.dma_mask = &edev->dma_mask;
 	sprintf (edev->dev.bus_id, "%02X:%02X", root->bus_nr, slot);
 
+	for (i = 0; i < EISA_MAX_RESOURCES; i++) {
 #ifdef CONFIG_EISA_NAMES
-	{
-	  int i;
-	  for (i = 0; i < EISA_MAX_RESOURCES; i++)
 		edev->res[i].name = edev->pretty_name;
-	}
+#else
+		edev->res[i].name = edev->id.sig;
 #endif
+	}
 
 	if (is_forced_dev (enable_dev, root, edev))
 		edev->state = EISA_CONFIG_ENABLED | EISA_CONFIG_FORCED;
@@ -274,7 +275,8 @@
         int i, c;
 	struct eisa_device *edev;
 
-        printk (KERN_INFO "EISA: Probing bus %d\n", root->bus_nr);
+        printk (KERN_INFO "EISA: Probing bus %d at %s\n",
+		root->bus_nr, root->dev->bus_id);
 
 	/* First try to get hold of slot 0. If there is no device
 	 * here, simply fail, unless root->force_probe is set. */
diff -Nru a/drivers/eisa/virtual_root.c b/drivers/eisa/virtual_root.c
--- a/drivers/eisa/virtual_root.c	Tue Aug 19 14:44:43 2003
+++ b/drivers/eisa/virtual_root.c	Tue Aug 19 14:44:43 2003
@@ -22,6 +22,7 @@
 #endif
 
 static int force_probe = EISA_FORCE_PROBE_DEFAULT;
+static void virtual_eisa_release (struct device *);
 
 /* The default EISA device parent (virtual root device).
  * Now use a platform device, since that's the obvious choice. */
@@ -29,6 +30,9 @@
 static struct platform_device eisa_root_dev = {
 	.name = "eisa",
 	.id   = 0,
+	.dev  = {
+		.release = virtual_eisa_release,
+	},
 };
 
 static struct eisa_root_device eisa_bus_root = {
@@ -38,6 +42,11 @@
 	.slots	       = EISA_MAX_SLOTS,
 	.dma_mask      = 0xffffffff,
 };
+
+static void virtual_eisa_release (struct device *dev)
+{
+	/* nothing really to do here */
+}
 
 static int virtual_eisa_root_init (void)
 {

-- 
Places change, faces change. Life is so very strange.
