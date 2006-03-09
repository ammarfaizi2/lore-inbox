Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWCIMm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWCIMm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCIMm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:42:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7872 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751181AbWCIMm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:42:57 -0500
Date: Thu, 9 Mar 2006 13:42:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [rfc] separate sharpsl_pm initialization from sysfs code
Message-ID: <20060309124237.GA3794@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On collie, battery sensing code is not on platform bus -- it is on
ucb1x00. Is this acceptable way to make sharpsl_pm useful for collie?
It separates code that is bus-independent, so collie can call only
code it needs.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/common/sharpsl_pm.c b/arch/arm/common/sharpsl_pm.c
index 978d32e..3482cc0 100644
--- a/arch/arm/common/sharpsl_pm.c
+++ b/arch/arm/common/sharpsl_pm.c
@@ -765,18 +787,13 @@ static void sharpsl_apm_get_power_status
 
 static struct pm_ops sharpsl_pm_ops = {
 	.pm_disk_mode	= PM_DISK_FIRMWARE,
 	.prepare	= pxa_pm_prepare,
 	.enter		= corgi_pxa_pm_enter,
 	.finish		= pxa_pm_finish,
 };
 
-static int __init sharpsl_pm_probe(struct platform_device *pdev)
+int sharpsl_pm_init(void)
 {
-	if (!pdev->dev.platform_data)
-		return -EINVAL;
-
-	sharpsl_pm.dev = &pdev->dev;
-	sharpsl_pm.machinfo = pdev->dev.platform_data;
 	sharpsl_pm.charge_mode = CHRG_OFF;
 	sharpsl_pm.flags = 0;
 
@@ -788,9 +807,6 @@ static int __init sharpsl_pm_probe(struc
 
 	sharpsl_pm.machinfo->init();
 
-	device_create_file(&pdev->dev, &dev_attr_battery_percentage);
-	device_create_file(&pdev->dev, &dev_attr_battery_voltage);
-
 	apm_get_power_status = sharpsl_apm_get_power_status;
 
 	pm_set_ops(&sharpsl_pm_ops);
@@ -800,13 +816,10 @@ static int __init sharpsl_pm_probe(struc
 	return 0;
 }
 
-static int sharpsl_pm_remove(struct platform_device *pdev)
+int sharpsl_pm_done(void)
 {
 	pm_set_ops(NULL);
 
-	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
-	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
-
 	sharpsl_pm.machinfo->exit();
 
 	del_timer_sync(&sharpsl_pm.chrg_full_timer);
@@ -815,6 +828,32 @@ static int sharpsl_pm_remove(struct plat
 	return 0;
 }
 
+static int __init sharpsl_pm_probe(struct platform_device *pdev)
+{
+	if (!pdev->dev.platform_data)
+		return -EINVAL;
+
+	sharpsl_pm.dev = &pdev->dev;
+	sharpsl_pm.machinfo = pdev->dev.platform_data;
+
+	sharpsl_pm_init();
+
+	device_create_file(&pdev->dev, &dev_attr_battery_percentage);
+	device_create_file(&pdev->dev, &dev_attr_battery_voltage);
+
+	return 0;
+}
+
+static int sharpsl_pm_remove(struct platform_device *pdev)
+{
+	sharpsl_pm_done();
+
+	device_remove_file(&pdev->dev, &dev_attr_battery_percentage);
+	device_remove_file(&pdev->dev, &dev_attr_battery_voltage);
+
+	return 0;
+}
+
 static struct platform_driver sharpsl_pm_driver = {
 	.probe		= sharpsl_pm_probe,
 	.remove		= sharpsl_pm_remove,

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
