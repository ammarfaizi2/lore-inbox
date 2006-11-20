Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966873AbWKTWRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966873AbWKTWRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966862AbWKTWRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:17:24 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:49238 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966837AbWKTWPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=qcRnF0Ep8fs4tnJ36yAerjZajpwo2f7KllawJIROIr3FJBibpZdwEytdo76i8+Ax+aSqjyQ0+XLucLQD8Q9hJrqCOLQ0mog74Wexn1S0aKb0hH2CZJ0skysRjX2w5Mv+yhz/0hvuZVP3xv+PuLkvW4jpsQ/w+Y53vL4xhcfbqyk=  ;
X-YMail-OSG: EDDdeQMVM1nhiWptvx7WwOyf0K7E5ux8YHftBgkAu.iAwfdUHvvuqynKVSh8lurmF4XGVfxiIzfcRqmXoOO8f.LOwUNPfA9vpHNG9Yln9ttPKP_Ekfr3BA--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.19-rc6 4/6] ACPI exports RTC extensions through platform_data
Date: Mon, 20 Nov 2006 10:27:34 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>
References: <200611201014.41980.david-b@pacbell.net>
In-Reply-To: <200611201014.41980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611201027.34641.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define platform_data for the MC146818 based RTCs, currently just holding
extensions standardized by ACPI (but available on some ACPI-neutral clones).

Update ACPI to export that RTC extension information through platform_data
to the PNP or platform bus device node.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/include/linux/mc146818rtc.h
===================================================================
--- g26.orig/include/linux/mc146818rtc.h	2006-11-20 10:03:06.000000000 -0800
+++ g26/include/linux/mc146818rtc.h	2006-11-20 10:10:45.000000000 -0800
@@ -18,6 +18,18 @@
 #ifdef __KERNEL__
 #include <linux/spinlock.h>		/* spinlock_t */
 extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
+
+/* Some RTCs extend the mc146818 register set to support alarms of more
+ * than 24 hours in the future; or dates that include a century code.
+ * And sometimes the RTC alarm can wake the system from suspend-to-disk.
+ * This platform_data structure can pass this information to the driver.
+ */
+struct cmos_rtc_board_info {
+	u8	rtc_day_alarm;		/* zero, or register index */
+	u8	rtc_mon_alarm;		/* zero, or register index */
+	u8	rtc_century;		/* zero, or register index */
+	u8	wake_from_std;		/* true iff alarm wakes from STD */
+};
 #endif
 
 /**********************************************************************
Index: g26/drivers/acpi/glue.c
===================================================================
--- g26.orig/drivers/acpi/glue.c	2006-11-20 10:03:06.000000000 -0800
+++ g26/drivers/acpi/glue.c	2006-11-20 10:10:45.000000000 -0800
@@ -358,3 +358,107 @@ static int __init init_acpi_device_notif
 }
 
 arch_initcall(init_acpi_device_notify);
+
+
+#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
+
+/* Every ACPI platform has a mc146818 compatible "cmos rtc".  We want
+ * to find its device node, so we can pass ACPI-specific config data
+ * to its driver.  So we'll just probe for that device -- with a dummy
+ * driver, using the relevant bus -- before the RTC driver initializes.
+ */
+#include <linux/mc146818rtc.h>
+
+static struct cmos_rtc_board_info rtc_info;
+
+static struct device *rtc_dev __initdata;
+static char drvname[] __initdata = "rtc_cmos";
+
+
+#ifdef CONFIG_PNPACPI
+
+/* PNP devices are registered in a subsys_initcall();
+ * ACPI specifies the PNP IDs to use.
+ */
+#include <linux/pnp.h>
+
+static struct pnp_device_id rtc_ids[] __initdata = {
+	{ .id = "PNP0b00", },
+	{ .id = "PNP0b01", },
+	{ .id = "PNP0b02", },
+	{ },
+};
+
+static int __init
+rtc_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
+{
+	rtc_dev = &pnp->dev;
+	return -ENXIO;
+}
+
+static struct pnp_driver cmos_pnp_driver __initdata = {
+	.name		= drvname,
+	.id_table	= rtc_ids,
+	.probe		= rtc_pnp_probe,
+};
+
+static struct device *__init get_rtc_dev(void)
+{
+	if (pnp_register_driver(&cmos_pnp_driver) == 0)
+		pnp_unregister_driver(&cmos_pnp_driver);
+	return rtc_dev;
+}
+
+#else
+
+/* We expect platforms to register an RTC device, conventionally at or
+ * near arch_initcall().  That should work even without ACPI.  The driver
+ * name matters; it must match the driver.
+ */
+#include <linux/platform_device.h>
+
+static int __init rtc_platform_probe(struct platform_device *pdev)
+{
+	rtc_dev = &pdev->dev;
+	return -ENXIO;
+}
+
+static struct platform_driver rtc_platform_driver __initdata = {
+	.driver = {
+		.name		= drvname,
+	},
+	.probe		= rtc_platform_probe,
+};
+
+static struct device *__init get_rtc_dev(void)
+{
+	if (platform_driver_register(&rtc_platform_driver) == 0)
+		platform_driver_unregister(&rtc_platform_driver);
+	return rtc_dev;
+}
+
+#endif
+
+static int __init acpi_rtc_init(void)
+{
+	struct device *dev = get_rtc_dev();
+
+	if (dev) {
+		rtc_info.rtc_day_alarm = acpi_gbl_FADT->day_alrm;
+		rtc_info.rtc_mon_alarm = acpi_gbl_FADT->mon_alrm;
+		rtc_info.rtc_century = acpi_gbl_FADT->century;
+
+		/* REVISIT iff revision > FADT2_REVISION_ID ? */
+		rtc_info.wake_from_std = acpi_gbl_FADT->rtcs4;
+
+		dev->platform_data = &rtc_info;
+
+		/* RTC always wakes from S1/S2/S3, and often S4/STD */
+		device_init_wakeup(dev, 1);
+	} else
+		pr_debug("ACPI: RTC unavailable?\n");
+	return 0;
+}
+fs_initcall(acpi_rtc_init);
+
+#endif

