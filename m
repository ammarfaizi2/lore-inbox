Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVCLLbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVCLLbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 06:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCLLbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 06:31:09 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:32171
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261712AbVCLL3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 06:29:14 -0500
Date: Sat, 12 Mar 2005 11:29:11 +0000
From: Ben Dooks <ben@fluff.org.uk>
To: wim@iguana.be, linux-kernel@vger.kernel.org
Cc: dimitry.andric@tomtom.com
Subject: [PATCH] s3c2410 watchdog - replace reboot notifier
Message-ID: <20050312112911.GA24366@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch from Dimitry Andric <dimitry.andric@tomtom.com>

Change to using platfrom driver's .shutdown method instead
of an reboot notifier

Signed-off-by: Dimitry Andric <dimitry.andric@tomtom.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urN -X ../dontdiff linux-2.6.11-mm2-bjd1/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.11-mm2-bjd2/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.11-mm2-bjd1/drivers/char/watchdog/s3c2410_wdt.c	2005-03-12 11:11:08.000000000 +0000
+++ linux-2.6.11-mm2-bjd2/drivers/char/watchdog/s3c2410_wdt.c	2005-03-12 11:23:18.000000000 +0000
@@ -27,6 +27,7 @@
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
  *	25-Jan-2005	DA	Added suspend/resume support
+ *				Replaced reboot notifier with .shutdown method
 */
 
 #include <linux/module.h>
@@ -37,8 +38,6 @@
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/fs.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -323,20 +322,6 @@
 	}
 }
 
-/*
- *	Notifier for system down
- */
-
-static int s3c2410wdt_notify_sys(struct notifier_block *this, unsigned long code,
-			      void *unused)
-{
-	if(code==SYS_DOWN || code==SYS_HALT) {
-		/* Turn the WDT off */
-		s3c2410wdt_stop();
-	}
-	return NOTIFY_DONE;
-}
-
 /* kernel interface */
 
 static struct file_operations s3c2410wdt_fops = {
@@ -354,10 +339,6 @@
 	.fops		= &s3c2410wdt_fops,
 };
 
-static struct notifier_block s3c2410wdt_notifier = {
-	.notifier_call	= s3c2410wdt_notify_sys,
-};
-
 /* interrupt handler code */
 
 static irqreturn_t s3c2410wdt_irq(int irqno, void *param,
@@ -438,18 +419,10 @@
 		}
 	}
 
-	ret = register_reboot_notifier(&s3c2410wdt_notifier);
-	if (ret) {
-		printk (KERN_ERR PFX "cannot register reboot notifier (%d)\n",
-			ret);
-		return ret;
-	}
-
 	ret = misc_register(&s3c2410wdt_miscdev);
 	if (ret) {
 		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
 			WATCHDOG_MINOR, ret);
-		unregister_reboot_notifier(&s3c2410wdt_notifier);
 		return ret;
 	}
 
@@ -485,6 +458,11 @@
 	return 0;
 }
 
+static void s3c2410wdt_shutdown(struct device *dev)
+{
+	s3c2410wdt_stop();	
+}
+
 #ifdef CONFIG_PM
 
 static unsigned long wtcon_save;
@@ -531,6 +509,7 @@
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
+	.shutdown	= s3c2410wdt_shutdown,
 	.suspend	= s3c2410wdt_suspend,
 	.resume		= s3c2410wdt_resume,
 };
@@ -547,7 +526,6 @@
 static void __exit watchdog_exit(void)
 {
 	driver_unregister(&s3c2410wdt_driver);
-	unregister_reboot_notifier(&s3c2410wdt_notifier);
 }
 
 module_init(watchdog_init);

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s3c2410-wdt-shutdown.patch"

diff -urN -X ../dontdiff linux-2.6.11-mm2-bjd1/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.11-mm2-bjd2/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.11-mm2-bjd1/drivers/char/watchdog/s3c2410_wdt.c	2005-03-12 11:11:08.000000000 +0000
+++ linux-2.6.11-mm2-bjd2/drivers/char/watchdog/s3c2410_wdt.c	2005-03-12 11:23:18.000000000 +0000
@@ -27,6 +27,7 @@
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
  *	25-Jan-2005	DA	Added suspend/resume support
+ *				Replaced reboot notifier with .shutdown method
 */
 
 #include <linux/module.h>
@@ -37,8 +38,6 @@
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/fs.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -323,20 +322,6 @@
 	}
 }
 
-/*
- *	Notifier for system down
- */
-
-static int s3c2410wdt_notify_sys(struct notifier_block *this, unsigned long code,
-			      void *unused)
-{
-	if(code==SYS_DOWN || code==SYS_HALT) {
-		/* Turn the WDT off */
-		s3c2410wdt_stop();
-	}
-	return NOTIFY_DONE;
-}
-
 /* kernel interface */
 
 static struct file_operations s3c2410wdt_fops = {
@@ -354,10 +339,6 @@
 	.fops		= &s3c2410wdt_fops,
 };
 
-static struct notifier_block s3c2410wdt_notifier = {
-	.notifier_call	= s3c2410wdt_notify_sys,
-};
-
 /* interrupt handler code */
 
 static irqreturn_t s3c2410wdt_irq(int irqno, void *param,
@@ -438,18 +419,10 @@
 		}
 	}
 
-	ret = register_reboot_notifier(&s3c2410wdt_notifier);
-	if (ret) {
-		printk (KERN_ERR PFX "cannot register reboot notifier (%d)\n",
-			ret);
-		return ret;
-	}
-
 	ret = misc_register(&s3c2410wdt_miscdev);
 	if (ret) {
 		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (%d)\n",
 			WATCHDOG_MINOR, ret);
-		unregister_reboot_notifier(&s3c2410wdt_notifier);
 		return ret;
 	}
 
@@ -485,6 +458,11 @@
 	return 0;
 }
 
+static void s3c2410wdt_shutdown(struct device *dev)
+{
+	s3c2410wdt_stop();	
+}
+
 #ifdef CONFIG_PM
 
 static unsigned long wtcon_save;
@@ -531,6 +509,7 @@
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410wdt_probe,
 	.remove		= s3c2410wdt_remove,
+	.shutdown	= s3c2410wdt_shutdown,
 	.suspend	= s3c2410wdt_suspend,
 	.resume		= s3c2410wdt_resume,
 };
@@ -547,7 +526,6 @@
 static void __exit watchdog_exit(void)
 {
 	driver_unregister(&s3c2410wdt_driver);
-	unregister_reboot_notifier(&s3c2410wdt_notifier);
 }
 
 module_init(watchdog_init);

--yrj/dFKFPuw6o+aM--
