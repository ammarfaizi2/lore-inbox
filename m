Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVCOVt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVCOVt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVCOVt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:49:29 -0500
Received: from apate.telenet-ops.be ([195.130.132.57]:57748 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261881AbVCOVrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:47:49 -0500
Date: Tue, 15 Mar 2005 22:47:47 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [WATCHDOG] linux-2.6-watchdog patches
Message-ID: <20050315214747.GD4909@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/Makefile      |   13 +++++++------
 drivers/char/watchdog/pcwd_pci.c    |    6 +++---
 drivers/char/watchdog/pcwd_usb.c    |    6 +++---
 drivers/char/watchdog/s3c2410_wdt.c |    8 +++-----
 4 files changed, 16 insertions(+), 17 deletions(-)

through these ChangeSets:

<wim@iguana.be> (05/03/15 1.2187)
   [WATCHDOG] pcwd_usb: usb_control_msg-timeout-patch
   
   set timeout in usb_control_msg to USB_COMMAND_TIMEOUT instead of a
   full second.

<ben-linux@fluff.org> (05/03/15 1.2188)
   [WATCHDOG] s3c2410-divide-patch
   
   The s3c2410 watchdog driver has an incorrect /2
   in the timer calculation, fix this problem
   
   Signed-off-by: Ben Dooks <ben-linux@fluff.org>

<wim@iguana.be> (05/03/15 1.2189)
   [WATCHDOG] pcwd_pci-register-driver-patch
   
   convert from pci_module_init to pci_register_driver
   
   Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
   Signed-off-by: Domen Puncer <domen@coderock.org>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

<davej@redhat.com> (05/03/15 1.2190)
   [WATCHDOG] Makefile-patch
   
   The comment at the top of the Makefile suggests that the current
   ordering is incorrect.
   
   Signed-off-by: Dave Jones <davej@redhat.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	2005-03-15 21:18:41 +01:00
+++ b/drivers/char/watchdog/pcwd_usb.c	2005-03-15 21:18:41 +01:00
@@ -56,8 +56,8 @@
 
 
 /* Module and Version Information */
-#define DRIVER_VERSION "1.00"
-#define DRIVER_DATE "12 Jun 2004"
+#define DRIVER_VERSION "1.01"
+#define DRIVER_DATE "15 Mar 2005"
 #define DRIVER_AUTHOR "Wim Van Sebroeck <wim@iguana.be>"
 #define DRIVER_DESC "Berkshire USB-PC Watchdog driver"
 #define DRIVER_LICENSE "GPL"
@@ -227,7 +227,7 @@
 	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
 			HID_REQ_SET_REPORT, HID_DT_REPORT,
 			0x0200, usb_pcwd->interface_number, buf, sizeof(buf),
-			1000) != sizeof(buf)) {
+			USB_COMMAND_TIMEOUT) != sizeof(buf)) {
 		dbg("usb_pcwd_send_command: error in usb_control_msg for cmd 0x%x 0x%x 0x%x\n", cmd, *msb, *lsb);
 	}
 	/* wait till the usb card processed the command,
diff -Nru a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c	2005-03-15 21:18:44 +01:00
+++ b/drivers/char/watchdog/s3c2410_wdt.c	2005-03-15 21:18:44 +01:00
@@ -27,6 +27,8 @@
  *				Fixed tmr_count / wdt_count confusion
  *				Added configurable debug
  *
+ *	11-Jan-2004	BJD	Fixed divide-by-2 in timeout code
+ *
  *	10-Mar-2005	LCVR	Changed S3C2410_VA to S3C24XX_VA
 */
 
@@ -165,11 +167,7 @@
 	if (timeout < 1)
 		return -EINVAL;
 
-	/* I think someone must have missed a divide-by-2 in the 2410,
-	 * as a divisor of 128 gives half the calculated delay...
-	 */
-
-	freq /= 128/2;
+	freq /= 128;
 	count = timeout * freq;
 
 	DBG("%s: count=%d, timeout=%d, freq=%d\n",
diff -Nru a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c	2005-03-15 21:18:47 +01:00
+++ b/drivers/char/watchdog/pcwd_pci.c	2005-03-15 21:18:47 +01:00
@@ -48,8 +48,8 @@
 #include <asm/io.h>
 
 /* Module and version information */
-#define WATCHDOG_VERSION "1.00"
-#define WATCHDOG_DATE "12 Jun 2004"
+#define WATCHDOG_VERSION "1.01"
+#define WATCHDOG_DATE "15 Mar 2005"
 #define WATCHDOG_DRIVER_NAME "PCI-PC Watchdog"
 #define WATCHDOG_NAME "pcwd_pci"
 #define PFX WATCHDOG_NAME ": "
@@ -659,7 +659,7 @@
 {
 	spin_lock_init (&pcipcwd_private.io_lock);
 
-	return pci_module_init(&pcipcwd_driver);
+	return pci_register_driver(&pcipcwd_driver);
 }
 
 static void __exit pcipcwd_cleanup_module(void)
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2005-03-15 21:18:50 +01:00
+++ b/drivers/char/watchdog/Makefile	2005-03-15 21:18:50 +01:00
@@ -2,11 +2,6 @@
 # Makefile for the WatchDog device drivers.
 #
 
-# Only one watchdog can succeed. We probe the hardware watchdog
-# drivers first, then the softdog driver.  This means if your hardware
-# watchdog dies or is 'borrowed' for some reason the software watchdog
-# still gives you some cover.
-
 obj-$(CONFIG_PCWATCHDOG) += pcwd.o
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
 obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
@@ -24,7 +19,6 @@
 obj-$(CONFIG_S3C2410_WATCHDOG) += s3c2410_wdt.o
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
-obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
 obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
@@ -39,3 +33,10 @@
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+
+# Only one watchdog can succeed. We probe the hardware watchdog
+# drivers first, then the softdog driver.  This means if your hardware
+# watchdog dies or is 'borrowed' for some reason the software watchdog
+# still gives you some cover.
+
+obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
