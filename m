Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUFLVHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUFLVHa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 17:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbUFLVHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 17:07:30 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:39565 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264923AbUFLVHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 17:07:19 -0400
Date: Sat, 12 Jun 2004 23:06:33 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] pcwd*.c patches
Message-ID: <20040612230633.J30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/pcwd.c     |    7 ++++---
 drivers/char/watchdog/pcwd_pci.c |   36 +++++++++++++++++-------------------
 drivers/char/watchdog/pcwd_usb.c |   28 +++++++++++++---------------
 3 files changed, 34 insertions(+), 37 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/06/12 1.1755)
   [WATCHDOG] v2.6.6 pcwd.c-keepalive+single_open-patch
   
   - Make pcwd_keepalive return 0 on success.
   - /dev/watchdog is single open only: make sure that the atomic that
   prevents a second open is cleared only as the last instruction of the
   release code.

<wim@iguana.be> (04/06/12 1.1756)
   [WATCHDOG] pcwd_pci.c-single_open+set_heartbeat+init-patch
   
   - /dev/watchdog is single open only: make sure that the bit that
   prevents a second open is cleared as the last instruction of the
   release code
   - Change the way we set the original heartbeat
   - Make sure that /dev/temperature get's registered before /dev/watchdog

<wim@iguana.be> (04/06/12 1.1757)
   [WATCHDOG] pcwd_usb.c-single_open+set_heartbeat+init-patch
   
   - /dev/watchdog is single open only: make sure that the bit that
   prevents a second open is cleared as the last instruction of the
   release code
   - Change the way we set the original heartbeat code
   - Make sure that /dev/temperature get's registered before /dev/watchdog


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sat Jun 12 22:56:13 2004
+++ b/drivers/char/watchdog/pcwd.c	Sat Jun 12 22:56:13 2004
@@ -70,7 +70,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-#define WD_VER                  "1.16 (03/27/2004)"
+#define WD_VER                  "1.16 (06/12/2004)"
 #define PFX			"pcwd: "
 
 /*
@@ -299,10 +299,11 @@
 	return 0;
 }
 
-static void pcwd_keepalive(void)
+static int pcwd_keepalive(void)
 {
 	/* user land ping */
 	next_heartbeat = jiffies + (heartbeat * HZ);
+	return 0;
 }
 
 static int pcwd_set_heartbeat(int t)
@@ -529,12 +530,12 @@
 {
 	if (expect_close == 42) {
 		pcwd_stop();
-		atomic_inc( &open_allowed );
 	} else {
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		pcwd_keepalive();
 	}
 	expect_close = 0;
+	atomic_inc( &open_allowed );
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c	Sat Jun 12 22:56:38 2004
+++ b/drivers/char/watchdog/pcwd_pci.c	Sat Jun 12 22:56:38 2004
@@ -49,7 +49,7 @@
 
 /* Module and version information */
 #define WATCHDOG_VERSION "1.00"
-#define WATCHDOG_DATE "13/03/2004"
+#define WATCHDOG_DATE "12 Jun 2004"
 #define WATCHDOG_DRIVER_NAME "PCI-PC Watchdog"
 #define WATCHDOG_NAME "pcwd_pci"
 #define PFX WATCHDOG_NAME ": "
@@ -73,7 +73,7 @@
 #define WD_PCI_TTRP             0x04	/* Temperature Trip status */
 
 /* according to documentation max. time to process a command for the pci
-   watchdog card is 100 ms, so we give it 150 ms to do it's job */
+ * watchdog card is 100 ms, so we give it 150 ms to do it's job */
 #define PCI_COMMAND_TIMEOUT	150
 
 /* Watchdog's internal commands */
@@ -404,8 +404,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		pcipcwd_keepalive();
 	}
-	clear_bit(0, &is_active);
 	expect_release = 0;
+	clear_bit(0, &is_active);
 	return 0;
 }
 
@@ -585,15 +585,12 @@
 		printk(KERN_INFO PFX "No previous trip detected - Cold boot or reset\n");
 
 	/* Check that the heartbeat value is within it's range ; if not reset to the default */
-	if (heartbeat < 1 || heartbeat > 0xFFFF) {
-		heartbeat = WATCHDOG_HEARTBEAT;
+	if (pcipcwd_set_heartbeat(heartbeat)) {
+		pcipcwd_set_heartbeat(WATCHDOG_HEARTBEAT);
 		printk(KERN_INFO PFX "heartbeat value must be 0<heartbeat<65536, using %d\n",
-			heartbeat);
+			WATCHDOG_HEARTBEAT);
 	}
 
-	/* Calculate the watchdog's heartbeat */
-	pcipcwd_set_heartbeat(heartbeat);
-
 	ret = register_reboot_notifier(&pcipcwd_notifier);
 	if (ret != 0) {
 		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
@@ -601,29 +598,30 @@
 		goto err_out_release_region;
 	}
 
-	ret = misc_register(&pcipcwd_miscdev);
-	if (ret != 0) {
-		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-			WATCHDOG_MINOR, ret);
-		goto err_out_unregister_reboot;
-	}
-
 	if (pcipcwd_private.supports_temp) {
 		ret = misc_register(&pcipcwd_temp_miscdev);
 		if (ret != 0) {
 			printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
 				TEMP_MINOR, ret);
-			goto err_out_misc_deregister;
+			goto err_out_unregister_reboot;
 		}
 	}
 
+	ret = misc_register(&pcipcwd_miscdev);
+	if (ret != 0) {
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto err_out_misc_deregister;
+	}
+
 	printk(KERN_INFO PFX "initialized. heartbeat=%d sec (nowayout=%d)\n",
 		heartbeat, nowayout);
 
 	return 0;
 
 err_out_misc_deregister:
-	misc_deregister(&pcipcwd_miscdev);
+	if (pcipcwd_private.supports_temp)
+		misc_deregister(&pcipcwd_temp_miscdev);
 err_out_unregister_reboot:
 	unregister_reboot_notifier(&pcipcwd_notifier);
 err_out_release_region:
@@ -640,9 +638,9 @@
 		pcipcwd_stop();
 
 	/* Deregister */
+	misc_deregister(&pcipcwd_miscdev);
 	if (pcipcwd_private.supports_temp)
 		misc_deregister(&pcipcwd_temp_miscdev);
-	misc_deregister(&pcipcwd_miscdev);
 	unregister_reboot_notifier(&pcipcwd_notifier);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	Sat Jun 12 22:57:04 2004
+++ b/drivers/char/watchdog/pcwd_usb.c	Sat Jun 12 22:57:04 2004
@@ -56,7 +56,8 @@
 
 
 /* Module and Version Information */
-#define DRIVER_VERSION "v1.00 (28/02/2004)"
+#define DRIVER_VERSION "1.00"
+#define DRIVER_DATE "12 Jun 2004"
 #define DRIVER_AUTHOR "Wim Van Sebroeck <wim@iguana.be>"
 #define DRIVER_DESC "Berkshire USB-PC Watchdog driver"
 #define DRIVER_LICENSE "GPL"
@@ -456,8 +457,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		usb_pcwd_keepalive(usb_pcwd_device);
 	}
-	clear_bit(0, &is_active);
 	expect_release = 0;
+	clear_bit(0, &is_active);
 	return 0;
 }
 
@@ -681,15 +682,12 @@
 		((option_switches & 0x08) ? "ON" : "OFF"));
 
 	/* Check that the heartbeat value is within it's range ; if not reset to the default */
-	if (heartbeat < 1 || heartbeat > 0xFFFF) {
-		heartbeat = WATCHDOG_HEARTBEAT;
+	if (usb_pcwd_set_heartbeat(usb_pcwd, heartbeat)) {
+		usb_pcwd_set_heartbeat(usb_pcwd, WATCHDOG_HEARTBEAT);
 		printk(KERN_INFO PFX "heartbeat value must be 0<heartbeat<65536, using %d\n",
-			heartbeat);
+			WATCHDOG_HEARTBEAT);
 	}
 
-	/* Calculate the watchdog's heartbeat */
-	usb_pcwd_set_heartbeat(usb_pcwd, heartbeat);
-
 	retval = register_reboot_notifier(&usb_pcwd_notifier);
 	if (retval != 0) {
 		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
@@ -697,17 +695,17 @@
 		goto error;
 	}
 
-	retval = misc_register(&usb_pcwd_miscdev);
+	retval = misc_register(&usb_pcwd_temperature_miscdev);
 	if (retval != 0) {
 		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-			WATCHDOG_MINOR, retval);
+			TEMP_MINOR, retval);
 		goto err_out_unregister_reboot;
 	}
 
-	retval = misc_register(&usb_pcwd_temperature_miscdev);
+	retval = misc_register(&usb_pcwd_miscdev);
 	if (retval != 0) {
 		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-			TEMP_MINOR, retval);
+			WATCHDOG_MINOR, retval);
 		goto err_out_misc_deregister;
 	}
 
@@ -720,7 +718,7 @@
 	return 0;
 
 err_out_misc_deregister:
-	misc_deregister(&usb_pcwd_miscdev);
+	misc_deregister(&usb_pcwd_temperature_miscdev);
 err_out_unregister_reboot:
 	unregister_reboot_notifier(&usb_pcwd_notifier);
 error:
@@ -758,8 +756,8 @@
 	usb_pcwd->exists = 0;
 
 	/* Deregister */
-	misc_deregister(&usb_pcwd_temperature_miscdev);
 	misc_deregister(&usb_pcwd_miscdev);
+	misc_deregister(&usb_pcwd_temperature_miscdev);
 	unregister_reboot_notifier(&usb_pcwd_notifier);
 
 	up (&usb_pcwd->sem);
@@ -791,7 +789,7 @@
 		return result;
 	}
 
-	printk(KERN_INFO PFX DRIVER_DESC " " DRIVER_VERSION "\n");
+	printk(KERN_INFO PFX DRIVER_DESC " v" DRIVER_VERSION " (" DRIVER_DATE ")\n");
 	return 0;
 }
 
