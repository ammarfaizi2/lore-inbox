Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVCLL0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVCLL0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 06:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVCLL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 06:26:11 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:34778
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261152AbVCLLSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 06:18:23 -0500
Date: Sat, 12 Mar 2005 11:18:19 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: wim@iguana.be, linux-kernel@vger.kernel.org
Subject: [PATCH] s3c2410 watchdog power management
Message-ID: <20050312111819.GA23857@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch from Dimitry Andric <dimitry.andric@tomtom.com>, updated
by Ben Dooks <ben-linux@fluff.org>. Patch is against 2.6.11-mm2

Add power management support to the s3c2410 watchdog, so that
it is shut-down over suspend, and re-initialised on resume.

Also add Dimitry to the list of authors.

Signed-off-by: Dimitry Andric <dimitry.andric@tomtom.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urN -X ../dontdiff linux-2.6.11-mm2/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.11-mm2-bjd1/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.11-mm2/drivers/char/watchdog/s3c2410_wdt.c	2005-03-02 07:38:10.000000000 +0000
+++ linux-2.6.11-mm2-bjd1/drivers/char/watchdog/s3c2410_wdt.c	2005-03-12 11:11:08.000000000 +0000
@@ -26,6 +26,7 @@
  *	05-Oct-2004	BJD	Added semaphore init to stop crashes on open
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
+ *	25-Jan-2005	DA	Added suspend/resume support
 */
 
 #include <linux/module.h>
@@ -484,15 +485,57 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM
+
+static unsigned long wtcon_save;
+static unsigned long wtdat_save;
+
+static int s3c2410wdt_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level == SUSPEND_POWER_DOWN) {
+		/* Save watchdog state, and turn it off. */
+		wtcon_save = readl(wdt_base + S3C2410_WTCON);
+		wtdat_save = readl(wdt_base + S3C2410_WTDAT);
+
+		/* Note that WTCNT doesn't need to be saved. */
+		s3c2410wdt_stop();
+	}
+
+	return 0;
+}
+
+static int s3c2410wdt_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON) {
+		/* Restore watchdog state. */
+
+		writel(wtdat_save, wdt_base + S3C2410_WTDAT);
+		writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
+		writel(wtcon_save, wdt_base + S3C2410_WTCON);
+
+		printk(KERN_INFO PFX "watchdog %sabled\n",
+		       (wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
+	}
+
+	return 0;
+}
+
+#else
+#define s3c2410wdt_suspend NULL
+#define s3c2410wdt_resume  NULL
+#endif /* CONFIG_PM */
+
+
 static struct device_driver s3c2410wdt_driver = {
 	.name		= "s3c2410-wdt",
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
+	.suspend	= s3c2410wdt_suspend,
+	.resume		= s3c2410wdt_resume,
 };
 
 
-
 static char banner[] __initdata = KERN_INFO "S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics\n";
 
 static int __init watchdog_init(void)
@@ -510,7 +553,8 @@
 module_init(watchdog_init);
 module_exit(watchdog_exit);
 
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, "
+	      "Dimitry Andric <dimitry.andric@tomtom.com>");
 MODULE_DESCRIPTION("S3C2410 Watchdog Device Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s3c2410-wdt-pm.patch"

diff -urN -X ../dontdiff linux-2.6.11-mm2/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.11-mm2-bjd1/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.11-mm2/drivers/char/watchdog/s3c2410_wdt.c	2005-03-02 07:38:10.000000000 +0000
+++ linux-2.6.11-mm2-bjd1/drivers/char/watchdog/s3c2410_wdt.c	2005-03-12 11:11:08.000000000 +0000
@@ -26,6 +26,7 @@
  *	05-Oct-2004	BJD	Added semaphore init to stop crashes on open
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
+ *	25-Jan-2005	DA	Added suspend/resume support
 */
 
 #include <linux/module.h>
@@ -484,15 +485,57 @@
 	return 0;
 }
 
+#ifdef CONFIG_PM
+
+static unsigned long wtcon_save;
+static unsigned long wtdat_save;
+
+static int s3c2410wdt_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level == SUSPEND_POWER_DOWN) {
+		/* Save watchdog state, and turn it off. */
+		wtcon_save = readl(wdt_base + S3C2410_WTCON);
+		wtdat_save = readl(wdt_base + S3C2410_WTDAT);
+
+		/* Note that WTCNT doesn't need to be saved. */
+		s3c2410wdt_stop();
+	}
+
+	return 0;
+}
+
+static int s3c2410wdt_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON) {
+		/* Restore watchdog state. */
+
+		writel(wtdat_save, wdt_base + S3C2410_WTDAT);
+		writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
+		writel(wtcon_save, wdt_base + S3C2410_WTCON);
+
+		printk(KERN_INFO PFX "watchdog %sabled\n",
+		       (wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
+	}
+
+	return 0;
+}
+
+#else
+#define s3c2410wdt_suspend NULL
+#define s3c2410wdt_resume  NULL
+#endif /* CONFIG_PM */
+
+
 static struct device_driver s3c2410wdt_driver = {
 	.name		= "s3c2410-wdt",
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
+	.suspend	= s3c2410wdt_suspend,
+	.resume		= s3c2410wdt_resume,
 };
 
 
-
 static char banner[] __initdata = KERN_INFO "S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics\n";
 
 static int __init watchdog_init(void)
@@ -510,7 +553,8 @@
 module_init(watchdog_init);
 module_exit(watchdog_exit);
 
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, "
+	      "Dimitry Andric <dimitry.andric@tomtom.com>");
 MODULE_DESCRIPTION("S3C2410 Watchdog Device Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

--zhXaljGHf11kAtnf--
