Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbUKEDnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbUKEDnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 22:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUKEDnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 22:43:39 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:55205 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262578AbUKEDnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 22:43:31 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>
Subject: [patch 2.6.10-rc1-bk] shrink struct device a bit
Date: Thu, 4 Nov 2004 20:37:31 -0700
User-Agent: KMail/1.6.2
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7VviBDwTZlxkARi"
Message-Id: <200411041937.31077.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_7VviBDwTZlxkARi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Two fields were duplicates of ones in the PM struct,
and weren't much used in any case.

- Dave

--Boundary-00=_7VviBDwTZlxkARi
Content-Type: text/x-diff;
  charset="us-ascii";
  name="shrink-1104.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="shrink-1104.patch"

This patch removes two fields from "struct device" that are duplicated
in "struct dev_pm_info":  power_state (which should probably vanish)
and "saved_state".  There were only two "real" uses of saved_state;
both are now switched over to use dev_pm_info.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- 1.131/include/linux/device.h	Mon Nov  1 12:46:20 2004
+++ edited/include/linux/device.h	Thu Nov  4 12:59:02 2004
@@ -268,12 +268,7 @@
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
 					   BIOS data relevant to device) */
 	struct dev_pm_info	power;
-	u32		power_state;	/* Current operating state. In
-					   ACPI-speak, this is D0-D3, D0
-					   being fully functional, and D3
-					   being off. */
 
-	unsigned char *saved_state;	/* saved device state */
 	u32		detach_state;	/* State to enter when device is
 					   detached from its driver. */
 
--- 1.1/arch/arm/common/locomo.c	Wed Jul  7 17:00:00 2004
+++ edited/arch/arm/common/locomo.c	Thu Nov  4 13:23:44 2004
@@ -629,9 +629,6 @@
 	if (lchip) {
 		__locomo_remove(lchip);
 		dev_set_drvdata(dev, NULL);
-
-		kfree(dev->saved_state);
-		dev->saved_state = NULL;
 	}
 
 	return 0;
--- 1.41/arch/arm/common/sa1111.c	Tue Sep 28 11:27:43 2004
+++ edited/arch/arm/common/sa1111.c	Thu Nov  4 13:30:27 2004
@@ -797,6 +797,8 @@
 	unsigned int	wakeen1;
 };
 
+#ifdef	CONFIG_PM
+
 static int sa1111_suspend(struct device *dev, u32 state, u32 level)
 {
 	struct sa1111 *sachip = dev_get_drvdata(dev);
@@ -808,11 +810,10 @@
 	if (level != SUSPEND_DISABLE)
 		return 0;
 
-	dev->saved_state = kmalloc(sizeof(struct sa1111_save_data), GFP_KERNEL);
-	if (!dev->saved_state)
+	save = kmalloc(sizeof(struct sa1111_save_data), GFP_KERNEL);
+	if (!save)
 		return -ENOMEM;
-
-	save = (struct sa1111_save_data *)dev->saved_state;
+	dev->power.saved_state = save;
 
 	spin_lock_irqsave(&sachip->lock, flags);
 
@@ -870,7 +871,7 @@
 	if (level != RESUME_ENABLE)
 		return 0;
 
-	save = (struct sa1111_save_data *)dev->saved_state;
+	save = (struct sa1111_save_data *)dev->power.saved_state;
 	if (!save)
 		return 0;
 
@@ -915,12 +916,18 @@
 
 	spin_unlock_irqrestore(&sachip->lock, flags);
 
-	dev->saved_state = NULL;
+	dev->power.saved_state = NULL;
 	kfree(save);
 
 	return 0;
 }
 
+#else	/* !CONFIG_PM */
+#define sa1111_resume	0
+#define sa1111_suspend	0
+#endif	/* !CONFIG_PM */
+
+
 static int sa1111_probe(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -943,8 +950,8 @@
 		__sa1111_remove(sachip);
 		dev_set_drvdata(dev, NULL);
 
-		kfree(dev->saved_state);
-		dev->saved_state = NULL;
+		kfree(dev->power.saved_state);
+		dev->power.saved_state = NULL;
 	}
 
 	return 0;
--- 1.22/arch/arm/mach-sa1100/neponset.c	Thu Mar 25 09:43:01 2004
+++ edited/arch/arm/mach-sa1100/neponset.c	Thu Nov  4 13:22:34 2004
@@ -173,6 +173,8 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM
+
 /*
  * LDM power management.
  */
@@ -184,12 +186,12 @@
 	if (level == SUSPEND_SAVE_STATE ||
 	    level == SUSPEND_DISABLE ||
 	    level == SUSPEND_POWER_DOWN) {
-		if (!dev->saved_state)
-			dev->saved_state = kmalloc(sizeof(unsigned int), GFP_KERNEL);
-		if (!dev->saved_state)
+		if (!dev->power.saved_state)
+			dev->power.saved_state = kmalloc(sizeof(unsigned int), GFP_KERNEL);
+		if (!dev->power.saved_state)
 			return -ENOMEM;
 
-		*(unsigned int *)dev->saved_state = NCR_0;
+		*(unsigned int *)dev->power.saved_state = NCR_0;
 	}
 
 	return 0;
@@ -198,15 +200,20 @@
 static int neponset_resume(struct device *dev, u32 level)
 {
 	if (level == RESUME_RESTORE_STATE || level == RESUME_ENABLE) {
-		if (dev->saved_state) {
-			NCR_0 = *(unsigned int *)dev->saved_state;
-			kfree(dev->saved_state);
-			dev->saved_state = NULL;
+		if (dev->power.saved_state) {
+			NCR_0 = *(unsigned int *)dev->power.saved_state;
+			kfree(dev->power.saved_state);
+			dev->power.saved_state = NULL;
 		}
 	}
 
 	return 0;
 }
+
+#else
+#define	neponset_suspend	0
+#define	neponset_resume	0
+#endif
 
 static struct device_driver neponset_device_driver = {
 	.name		= "neponset",

--Boundary-00=_7VviBDwTZlxkARi--
