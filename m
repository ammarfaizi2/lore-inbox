Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbUKMClB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbUKMClB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 21:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUKLXCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:02:52 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:49286 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262651AbUKLXAj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:39 -0500
X-Donotread: and you are reading this why?
Subject: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <20041112225850.GA6550@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:06 -0800
Message-Id: <1100300406618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2093, 2004/11/12 11:41:25-08:00, david-b@pacbell.net

[PATCH] driver core: shrink struct device a bit

This patch removes two fields from "struct device" that are duplicated
in "struct dev_pm_info":  power_state (which should probably vanish)
and "saved_state".  There were only two "real" uses of saved_state;
both are now switched over to use dev_pm_info.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/arm/common/locomo.c        |    3 ---
 arch/arm/common/sa1111.c        |   23 +++++++++++++++--------
 arch/arm/mach-sa1100/neponset.c |   23 +++++++++++++++--------
 include/linux/device.h          |    5 -----
 4 files changed, 30 insertions(+), 24 deletions(-)


diff -Nru a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
--- a/arch/arm/common/locomo.c	2004-11-12 14:53:41 -08:00
+++ b/arch/arm/common/locomo.c	2004-11-12 14:53:41 -08:00
@@ -627,9 +627,6 @@
 	if (lchip) {
 		__locomo_remove(lchip);
 		dev_set_drvdata(dev, NULL);
-
-		kfree(dev->saved_state);
-		dev->saved_state = NULL;
 	}
 
 	return 0;
diff -Nru a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
--- a/arch/arm/common/sa1111.c	2004-11-12 14:53:41 -08:00
+++ b/arch/arm/common/sa1111.c	2004-11-12 14:53:41 -08:00
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
+#define sa1111_resume	NULL
+#define sa1111_suspend	NULL
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
diff -Nru a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
--- a/arch/arm/mach-sa1100/neponset.c	2004-11-12 14:53:41 -08:00
+++ b/arch/arm/mach-sa1100/neponset.c	2004-11-12 14:53:41 -08:00
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
+#define	neponset_suspend	NULL
+#define	neponset_resume	NULL
+#endif
 
 static struct device_driver neponset_device_driver = {
 	.name		= "neponset",
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-11-12 14:53:41 -08:00
+++ b/include/linux/device.h	2004-11-12 14:53:41 -08:00
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
 

