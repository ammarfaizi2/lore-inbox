Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266883AbUHWUfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUHWUfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUHWUdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:33:25 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:36554 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S266883AbUHWUZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:25:45 -0400
Date: Mon, 23 Aug 2004 16:25:30 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: alim7101 rev a1d
To: Steve Hill <steve@navaho.co.uk>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <412A52BA.5050203@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------030208050005050608050903
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030208050005050608050903
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Steve,

Please find attached a patch that enables watchdog/reboot support for
the older a1d rev of the alim7101 (found on older cobalt raq 3s).
Basically, that hardware uses gpio 5 off the pmu to do watchdog
strobing.  It's minimally tested, yet allows me to reboot my hardware :)

Thanks,

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKlK5dQs4kOxk3/MRAl5rAJ41BK2cQjhyGka1r49TLT8QEl1GLACdEKL7
Y8trXHxSN5q1OOlopoJuLlA=
=CK8/
-----END PGP SIGNATURE-----

--------------030208050005050608050903
Content-Type: text/x-patch;
 name="alim7101_wdt-use_gpio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alim7101_wdt-use_gpio.patch"

--- linux-2.6.8.1-bk/drivers/char/watchdog/alim7101_wdt.c	2004-08-23 13:50:41.332726712 -0700
+++ linux-2.6.8.1/drivers/char/watchdog/alim7101_wdt.c	2004-08-23 13:55:48.655006624 -0700
@@ -12,6 +12,11 @@
  *  because this particular WDT has a very short timeout (1.6
  *  seconds) and it would be insane to count on any userspace
  *  daemon always getting scheduled within that time frame.
+ *
+ *  Additions:
+ *   Aug 23, 2004 - Added use_gpio module parameter for use on revision a1d PMUs
+ *                  found on very old cobalt hardware.
+ *                  -- Mike Waychison <michael.waychison@sun.com>
  */
 
 #include <linux/module.h>
@@ -38,6 +43,8 @@
 #define WDT_DISABLE 0x8C
 
 #define ALI_7101_WDT    0x92
+#define ALI_7101_GPIO   0x7D
+#define ALI_7101_GPIO_O 0x7E
 #define ALI_WDT_ARM     0x01
 
 /*
@@ -57,6 +64,10 @@
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (1<=timeout<=3600, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
+static int use_gpio = 0; /* Use the pic (for a1d revision alim7101) */
+module_param(use_gpio, int, 0);
+MODULE_PARM_DESC(use_gpio, "Use the gpio watchdog.  (required by old cobalt boards)");
+
 static void wdt_timer_ping(unsigned long);
 static struct timer_list timer;
 static unsigned long next_heartbeat;
@@ -90,6 +101,13 @@
 		pci_read_config_byte(alim7101_pmu, 0x92, &tmp);
 		pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, (tmp & ~ALI_WDT_ARM));
 		pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, (tmp | ALI_WDT_ARM));
+		if (use_gpio) {
+			pci_read_config_byte(alim7101_pmu, ALI_7101_GPIO_O, &tmp);
+			pci_write_config_byte(alim7101_pmu, ALI_7101_GPIO_O, tmp
+					| 0x20);
+			pci_write_config_byte(alim7101_pmu, ALI_7101_GPIO_O, tmp
+					& ~0x20);
+		}
 	} else {
 		printk(KERN_WARNING PFX "Heartbeat lost! Will not ping the watchdog\n");
 	}
@@ -106,11 +124,21 @@
 {
 	char	tmp;
 
-	pci_read_config_byte(alim7101_pmu, 0x92, &tmp);
-	if (writeval == WDT_ENABLE)
+	pci_read_config_byte(alim7101_pmu, ALI_7101_WDT, &tmp);
+	if (writeval == WDT_ENABLE) {
 		pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, (tmp | ALI_WDT_ARM));
-	else
+		if (use_gpio) {
+			pci_read_config_byte(alim7101_pmu, ALI_7101_GPIO_O, &tmp);
+			pci_write_config_byte(alim7101_pmu, ALI_7101_GPIO_O, tmp & ~0x20);
+		}
+
+	} else {
 		pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, (tmp & ~ALI_WDT_ARM));
+		if (use_gpio) {
+			pci_read_config_byte(alim7101_pmu, ALI_7101_GPIO_O, &tmp);
+			pci_write_config_byte(alim7101_pmu, ALI_7101_GPIO_O, tmp | 0x20);
+		}
+	}
 }
 
 static void wdt_startup(void)
@@ -334,7 +362,13 @@
 		return -EBUSY;
 	}
 	pci_read_config_byte(ali1543_south, 0x5e, &tmp);
-	if ((tmp & 0x1e) != 0x12) {
+	if ((tmp & 0x1e) == 0x00) {
+		if (!use_gpio) {
+			printk(KERN_INFO PFX "Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.\n");
+			return -EBUSY;
+		} 
+		nowayout = 1;
+	} else if ((tmp & 0x1e) != 0x12 && (tmp & 0x1e) != 0x00) {
 		printk(KERN_INFO PFX "ALi 1543 South-Bridge does not have the correct revision number (???1001?) - WDT not set\n");
 		return -EBUSY;
 	}
@@ -364,6 +398,10 @@
 		goto err_out_miscdev;
 	}
 
+	if (nowayout) {
+		__module_get(THIS_MODULE);
+	}
+
 	printk(KERN_INFO PFX "WDT driver for ALi M7101 initialised. timeout=%d sec (nowayout=%d)\n",
 		timeout, nowayout);
 	return 0;

--------------030208050005050608050903--
