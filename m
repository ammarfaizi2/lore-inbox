Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbUDYOqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUDYOqF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 10:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUDYOqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 10:46:05 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:32463 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263137AbUDYOpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 10:45:30 -0400
Date: Sun, 25 Apr 2004 16:44:54 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.5 watchdog set_heartbeat + sc520_wdt.c + pcwd.c patches
Message-ID: <20040425164454.Q30061@infomag.infomag.iguana.be>
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

 drivers/char/watchdog/advantechwdt.c |   21 ++
 drivers/char/watchdog/alim1535_wdt.c |    9 -
 drivers/char/watchdog/alim7101_wdt.c |   25 ++-
 drivers/char/watchdog/i8xx_tco.c     |    5 
 drivers/char/watchdog/pcwd.c         |    5 
 drivers/char/watchdog/pcwd_pci.c     |   13 -
 drivers/char/watchdog/pcwd_usb.c     |   14 -
 drivers/char/watchdog/sbc60xxwdt.c   |   25 ++-
 drivers/char/watchdog/sc520_wdt.c    |  257 +++++++++++++++++------------------
 drivers/char/watchdog/shwdt.c        |    9 -
 drivers/char/watchdog/w83627hf_wdt.c |   23 ++-
 drivers/char/watchdog/w83877f_wdt.c  |   21 +-
 drivers/char/watchdog/wafer5823wdt.c |   23 ++-
 13 files changed, 243 insertions(+), 207 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/04/20 1.1897)
   [WATCHDOG] v2.6.5 set_heartbeat-patch
   
   Extract the code to set the heartbeat in a seperate function
   and use this function to set the heartbeat/timeout values in
   the ioctl and the init code.

<wim@iguana.be> (04/04/20 1.1898)
   [WATCHDOG] v2.6.5 sc520_wdt.c-patch1
   
   Clean-up (general stuff: comments, keep module parameters together, ...)
   Added clear definitions for the Watchdog Timer ontrol Register bits
   Made start, stop and keepalive return 0 if successful
   Fixed nowayout behaviour so that it is consistent with other watchdog drivers
   Fixed release behaviour so that it is consistent with other watchdog drivers
   Added wdt_set_heartbeat function to set the timeout/heartbeat of the watchdog
   Made sure that memory remapping (wdtmrctl) is done before misc_register is started
   MMCR_BASE_DEFAULT was wrong (Bug reported by Sean Young: bug 2497)
   
   Tested by Sean Young

<sean@mess.org> (04/04/20 1.1899)
   [WATCHDOG] v2.6.5 sc520_wdt.c-patch2
   
   This patch also removes the cbar usage which is unnecessary. The MMCR is
   always available at 0xfffef000; there is no need to use the cbar register
   (if mmcr aliasing is enabled, then the MMCR is _also_ available at
   another address set by CBAR).

<wim@iguana.be> (04/04/25 1.1900)
   [WATCHDOG] v2.6.5 pcwd.c-keepalive_int.patch
   
   Change keepalive function so that it returns an int (0=successful).


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/advantechwdt.c b/drivers/char/watchdog/advantechwdt.c
--- a/drivers/char/watchdog/advantechwdt.c	Sun Apr 25 16:40:19 2004
+++ b/drivers/char/watchdog/advantechwdt.c	Sun Apr 25 16:40:19 2004
@@ -99,6 +99,16 @@
 	inb_p(wdt_stop);
 }
 
+static int
+advwdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 63))
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
+}
+
 static ssize_t
 advwdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
@@ -153,9 +163,8 @@
 	case WDIOC_SETTIMEOUT:
 	  if (get_user(new_timeout, (int *)arg))
 		  return -EFAULT;
-	  if ((new_timeout < 1) || (new_timeout > 63))
+	  if (advwdt_set_heartbeat(new_timeout))
 		  return -EINVAL;
-	  timeout = new_timeout;
 	  advwdt_ping();
 	  /* Fall */
 
@@ -265,10 +274,10 @@
 
 	printk(KERN_INFO "WDT driver for Advantech single board computer initialising.\n");
 
-	if (timeout < 1 || timeout > 63) {
-		timeout = WATCHDOG_TIMEOUT;
-		printk (KERN_INFO PFX "timeout value must be 1<=x<=63, using %d\n",
-			timeout);
+	if (advwdt_set_heartbeat(timeout)) {
+		advwdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk (KERN_INFO PFX "timeout value must be 1<=timeout<=63, using %d\n",
+			WATCHDOG_TIMEOUT);
 	}
 
 	if (wdt_stop != wdt_start) {
diff -Nru a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
--- a/drivers/char/watchdog/alim1535_wdt.c	Sun Apr 25 16:40:19 2004
+++ b/drivers/char/watchdog/alim1535_wdt.c	Sun Apr 25 16:40:19 2004
@@ -406,14 +406,11 @@
 	}
 
 	/* Check that the timeout value is within it's range ; if not reset to the default */
-	if (timeout < 1 || timeout >= 18000) {
-		timeout = WATCHDOG_TIMEOUT;
+	if (ali_settimer(timeout)) {
+		ali_settimer(WATCHDOG_TIMEOUT);
 		printk(KERN_INFO PFX "timeout value must be 0<timeout<18000, using %d\n",
-			timeout);
+			WATCHDOG_TIMEOUT);
 	}
-
-	/* Calculate the watchdog's timeout */
-	ali_settimer(timeout);
 
 	ret = misc_register(&ali_miscdev);
 	if (ret != 0) {
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sun Apr 25 16:40:20 2004
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sun Apr 25 16:40:20 2004
@@ -143,6 +143,15 @@
 	next_heartbeat = jiffies + (timeout * HZ);
 }
 
+static int wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 3600))	/* arbitrary upper limit */
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
+}
+
 /*
  * /dev/watchdog handling
  */
@@ -245,10 +254,9 @@
 			if(get_user(new_timeout, (int *)arg))
 				return -EFAULT;
 
-			if(new_timeout < 1 || new_timeout > 3600) /* arbitrary upper limit */
+			if(wdt_set_heartbeat(new_timeout))
 				return -EINVAL;
 
-			timeout = new_timeout;
 			wdt_keepalive();
 			/* Fall through */
 		}
@@ -340,16 +348,15 @@
 		return -EBUSY;
 	}
 
-	if(timeout < 1 || timeout > 3600) /* arbitrary upper limit */
-	{
-		timeout = WATCHDOG_TIMEOUT;
-		printk(KERN_INFO PFX "timeout value must be 1<=x<=3600, using %d\n",
-			timeout);
-	}
-
 	init_timer(&timer);
 	timer.function = wdt_timer_ping;
 	timer.data = 1;
+
+	if (wdt_set_heartbeat(timeout)) {
+		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk(KERN_INFO PFX "timeout value must be 1<=timeout<=3600, using %d\n",
+			WATCHDOG_TIMEOUT);
+	}
 
 	rc = misc_register(&wdt_miscdev);
 	if (rc) {
diff -Nru a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c	Sun Apr 25 16:40:19 2004
+++ b/drivers/char/watchdog/i8xx_tco.c	Sun Apr 25 16:40:19 2004
@@ -447,10 +447,9 @@
 
 	/* Check that the heartbeat value is within it's range ; if not reset to the default */
 	if (tco_timer_set_heartbeat (heartbeat)) {
-		heartbeat = WATCHDOG_HEARTBEAT;
-		tco_timer_set_heartbeat (heartbeat);
+		tco_timer_set_heartbeat (WATCHDOG_HEARTBEAT);
 		printk(KERN_INFO PFX "heartbeat value must be 2<heartbeat<39, using %d\n",
-			heartbeat);
+			WATCHDOG_HEARTBEAT);
 	}
 
 	ret = register_reboot_notifier(&i8xx_tco_notifier);
diff -Nru a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c	Sun Apr 25 16:40:19 2004
+++ b/drivers/char/watchdog/pcwd_pci.c	Sun Apr 25 16:40:19 2004
@@ -49,7 +49,7 @@
 
 /* Module and version information */
 #define WATCHDOG_VERSION "1.00"
-#define WATCHDOG_DATE "13/03/2004"
+#define WATCHDOG_DATE "18 Apr 2004"
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
@@ -585,14 +585,11 @@
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
-
-	/* Calculate the watchdog's heartbeat */
-	pcipcwd_set_heartbeat(heartbeat);
 
 	ret = register_reboot_notifier(&pcipcwd_notifier);
 	if (ret != 0) {
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	Sun Apr 25 16:40:19 2004
+++ b/drivers/char/watchdog/pcwd_usb.c	Sun Apr 25 16:40:19 2004
@@ -56,7 +56,8 @@
 
 
 /* Module and Version Information */
-#define DRIVER_VERSION "v1.00 (28/02/2004)"
+#define DRIVER_VERSION "1.00"
+#define DRIVER_DATE "18 Apr 2004"
 #define DRIVER_AUTHOR "Wim Van Sebroeck <wim@iguana.be>"
 #define DRIVER_DESC "Berkshire USB-PC Watchdog driver"
 #define DRIVER_LICENSE "GPL"
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
@@ -791,7 +789,7 @@
 		return result;
 	}
 
-	printk(KERN_INFO PFX DRIVER_DESC " " DRIVER_VERSION "\n");
+	printk(KERN_INFO PFX DRIVER_DESC " v" DRIVER_VERSION " (" DRIVER_DATE ")\n");
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Sun Apr 25 16:40:20 2004
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Sun Apr 25 16:40:20 2004
@@ -162,6 +162,15 @@
 	next_heartbeat = jiffies + (timeout * HZ);
 }
 
+static int wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 3600))	/* arbitrary upper limit */
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
+}
+
 /*
  * /dev/watchdog handling
  */
@@ -275,10 +284,9 @@
 			if(get_user(new_timeout, (int *)arg))
 				return -EFAULT;
 
-			if(new_timeout < 1 || new_timeout > 3600) /* arbitrary upper limit */
+			if(wdt_set_heartbeat(new_timeout))
 				return -EINVAL;
 
-			timeout = new_timeout;
 			wdt_keepalive();
 			/* Fall through */
 		}
@@ -341,13 +349,6 @@
 {
 	int rc = -EBUSY;
 
-	if(timeout < 1 || timeout > 3600) /* arbitrary upper limit */
-	{
-		timeout = WATCHDOG_TIMEOUT;
-		printk(KERN_INFO PFX "timeout value must be 1<=x<=3600, using %d\n",
-			timeout);
- 	}
-
 	if (!request_region(wdt_start, 1, "SBC 60XX WDT"))
 	{
 		printk(KERN_ERR PFX "I/O address 0x%04x already in use\n",
@@ -371,6 +372,12 @@
 	init_timer(&timer);
 	timer.function = wdt_timer_ping;
 	timer.data = 0;
+
+	if (wdt_set_heartbeat(timeout)) {
+		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk(KERN_INFO PFX "timeout value must be 1<=timeout<=3600, using %d\n",
+			WATCHDOG_TIMEOUT);
+	}
 
 	rc = misc_register(&wdt_miscdev);
 	if (rc)
diff -Nru a/drivers/char/watchdog/shwdt.c b/drivers/char/watchdog/shwdt.c
--- a/drivers/char/watchdog/shwdt.c	Sun Apr 25 16:40:19 2004
+++ b/drivers/char/watchdog/shwdt.c	Sun Apr 25 16:40:19 2004
@@ -395,11 +395,10 @@
 			clock_division_ratio);
 	}
 
-	if (sh_wdt_set_heartbeat(heartbeat))
-	{
-		heartbeat = WATCHDOG_HEARTBEAT;
-		printk(KERN_INFO PFX "heartbeat value must be 1<=x<=3600, using %d\n",
-			heartbeat);
+	if (sh_wdt_set_heartbeat(heartbeat)) {
+		sh_wdt_set_heartbeat(WATCHDOG_HEARTBEAT);
+		printk(KERN_INFO PFX "heartbeat value must be 1<=heartbeat<=3600, using %d\n",
+			WATCHDOG_HEARTBEAT);
 	}
 
 	init_timer(&timer);
diff -Nru a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c	Sun Apr 25 16:40:19 2004
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Sun Apr 25 16:40:19 2004
@@ -100,6 +100,16 @@
 	wdt_ctrl(0);
 }
 
+static int
+wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 63))
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
+}
+
 static ssize_t
 wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
@@ -154,9 +164,8 @@
 	case WDIOC_SETTIMEOUT:
 	  if (get_user(new_timeout, (int *)arg))
 		  return -EFAULT;
-	  if ((new_timeout < 1) || (new_timeout > 63))
+	  if (wdt_set_heartbeat(new_timeout))
 		  return -EINVAL;
-	  timeout = new_timeout;
 	  wdt_ping();
 	  /* Fall */
 
@@ -264,12 +273,12 @@
 {
 	int ret;
 
-	printk(KERN_INFO "WDT driver for Advantech single board computer initialising.\n");
+	printk(KERN_INFO "WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.\n");
 
-	if (timeout < 1 || timeout > 63) {
-		timeout = WATCHDOG_TIMEOUT;
-		printk (KERN_INFO PFX "timeout value must be 1<=x<=63, using %d\n",
-			timeout);
+	if (wdt_set_heartbeat(timeout)) {
+		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk (KERN_INFO PFX "timeout value must be 1<=timeout<=63, using %d\n",
+			WATCHDOG_TIMEOUT);
 	}
 
 	if (!request_region(wdt_io, 1, WATCHDOG_NAME)) {
diff -Nru a/drivers/char/watchdog/w83877f_wdt.c b/drivers/char/watchdog/w83877f_wdt.c
--- a/drivers/char/watchdog/w83877f_wdt.c	Sun Apr 25 16:40:19 2004
+++ b/drivers/char/watchdog/w83877f_wdt.c	Sun Apr 25 16:40:20 2004
@@ -184,6 +184,15 @@
 	next_heartbeat = jiffies + (timeout * HZ);
 }
 
+static int wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 3600))	/* arbitrary upper limit */
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
+}
+
 /*
  * /dev/watchdog handling
  */
@@ -294,10 +303,9 @@
 			if(get_user(new_timeout, (int *)arg))
 				return -EFAULT;
 
-			if(new_timeout < 1 || new_timeout > 3600) /* arbitrary upper limit */
+			if(wdt_set_heartbeat(new_timeout))
 				return -EINVAL;
 
-			timeout = new_timeout;
 			wdt_keepalive();
 			/* Fall through */
 		}
@@ -361,11 +369,10 @@
 
 	spin_lock_init(&wdt_spinlock);
 
-	if(timeout < 1 || timeout > 3600) /* arbitrary upper limit */
-	{
-		timeout = WATCHDOG_TIMEOUT;
-		printk(KERN_INFO PFX "timeout value must be 1<=x<=3600, using %d\n",
-			timeout);
+	if (wdt_set_heartbeat(timeout)) {
+		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk(KERN_INFO PFX "timeout value must be 1<=timeout<=3600, using %d\n",
+			WATCHDOG_TIMEOUT);
 	}
 
 	if (!request_region(ENABLE_W83877F_PORT, 2, "W83877F WDT"))
diff -Nru a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Sun Apr 25 16:40:20 2004
+++ b/drivers/char/watchdog/wafer5823wdt.c	Sun Apr 25 16:40:20 2004
@@ -88,13 +88,21 @@
 	inb_p(wdt_start);
 }
 
-static void
-wafwdt_stop(void)
+static void wafwdt_stop(void)
 {
 	/* stop watchdog */
 	inb_p(wdt_stop);
 }
 
+static int wafwdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 255))	/* arbitrary upper limit */
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
+}
+
 static ssize_t wafwdt_write(struct file *file, const char *buf, size_t count, loff_t * ppos)
 {
 	/*  Can't seek (pwrite) on this device  */
@@ -152,9 +160,8 @@
 	case WDIOC_SETTIMEOUT:
 		if (get_user(new_timeout, (int *)arg))
 			return -EFAULT;
-		if ((new_timeout < 1) || (new_timeout > 255))
+		if (wafwdt_set_heartbeat(new_timeout))
 			return -EINVAL;
-		timeout = new_timeout;
 		wafwdt_stop();
 		wafwdt_start();
 		/* Fall */
@@ -262,10 +269,10 @@
 
 	spin_lock_init(&wafwdt_lock);
 
-	if (timeout < 1 || timeout > 255) {
-		timeout = WD_TIMO;
-		printk (KERN_INFO PFX "timeout value must be 1<=x<=255, using %d\n",
-			timeout);
+	if (wafwdt_set_heartbeat(timeout)) {
+		wafwdt_set_heartbeat(WD_TIMO);
+		printk (KERN_INFO PFX "timeout value must be 1<=timeout<=255, using %d\n",
+			WD_TIMO);
 	}
 
 	if (wdt_stop != wdt_start) {
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Sun Apr 25 16:40:43 2004
+++ b/drivers/char/watchdog/sc520_wdt.c	Sun Apr 25 16:40:43 2004
@@ -23,22 +23,23 @@
  *	-	Switched to private locks not lock_kernel
  *	-	Used ioremap/writew/readw
  *	-	Added NOWAYOUT support
- *
- *     4/12 - 2002 Changes by Rob Radez <rob@osinvestor.com>
- *     -       Change comments
- *     -       Eliminate fop_llseek
- *     -       Change CONFIG_WATCHDOG_NOWAYOUT semantics
- *     -       Add KERN_* tags to printks
- *     -       fix possible wdt_is_open race
- *     -       Report proper capabilities in watchdog_info
- *     -       Add WDIOC_{GETSTATUS, GETBOOTSTATUS, SETTIMEOUT,
- *             GETTIMEOUT, SETOPTIONS} ioctls
- *     09/8 - 2003 Changes by Wim Van Sebroeck <wim@iguana.be>
- *     -       cleanup of trailing spaces
- *     -       added extra printk's for startup problems
- *     -       use module_param
- *     -       made timeout (the emulated heartbeat) a module_param
- *     -       made the keepalive ping an internal subroutine
+ *	4/12 - 2002 Changes by Rob Radez <rob@osinvestor.com>
+ *	-	Change comments
+ *	-	Eliminate fop_llseek
+ *	-	Change CONFIG_WATCHDOG_NOWAYOUT semantics
+ *	-	Add KERN_* tags to printks
+ *	-	fix possible wdt_is_open race
+ *	-	Report proper capabilities in watchdog_info
+ *	-	Add WDIOC_{GETSTATUS, GETBOOTSTATUS, SETTIMEOUT,
+ *		GETTIMEOUT, SETOPTIONS} ioctls
+ *	09/8 - 2003 Changes by Wim Van Sebroeck <wim@iguana.be>
+ *	-	cleanup of trailing spaces
+ *	-	added extra printk's for startup problems
+ *	-	use module_param
+ *	-	made timeout (the emulated heartbeat) a module_param
+ *	-	made the keepalive ping an internal subroutine
+ *	3/27 - 2004 Changes by Sean Young <sean@mess.org>
+ *	-	set MMCR_BASE_DEFAULT to 0xfffef000
  *
  *  This WDT driver is different from most other Linux WDT
  *  drivers in that the driver will ping the watchdog by itself,
@@ -65,8 +66,16 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+#define OUR_NAME "sc520_wdt"
+#define PFX OUR_NAME ": "
+
 /*
- * The SC520 can timeout anywhere from 492us to 32.21s.
+ * The AMD Elan SC520 timeout value is 492us times a power of 2 (0-7)
+ *
+ *   0: 492us    2: 1.01s    4: 4.03s   6: 16.22s
+ *   1: 503ms    3: 2.01s    5: 8.05s   7: 32.21s
+ *
+ * We will program the SC520 watchdog for a timeout of 2.01s.
  * If we reset the watchdog every ~250ms we should be safe.
  */
 
@@ -83,25 +92,33 @@
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (1<=timeout<=3600, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
-/*
- * AMD Elan SC520 timeout value is 492us times a power of 2 (0-7)
- *
- *   0: 492us    2: 1.01s    4: 4.03s   6: 16.22s
- *   1: 503ms    3: 2.01s    5: 8.05s   7: 32.21s
- */
-
-#define TIMEOUT_EXPONENT ( 1 << 3 )  /* 0x08 = 2.01s */
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
 
-/* #define MMCR_BASE_DEFAULT 0xfffef000 */
-#define MMCR_BASE_DEFAULT ((__u16 *)0xffffe)
-#define OFFS_WDTMRCTL ((unsigned int)0xcb0)
-#define WDT_ENB 0x8000		/* [15] Watchdog Timer Enable */
-#define WDT_WRST_ENB 0x4000	/* [14] Watchdog Timer Reset Enable */
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
-#define OUR_NAME "sc520_wdt"
-#define PFX OUR_NAME ": "
+/*
+ * AMD Elan SC520 - Watchdog Timer Registers
+ */
+#define MMCR_BASE_DEFAULT	0xfffef000	/* The default base address */
+#define OFFS_WDTMRCTL	0xCB0	/* Watchdog Timer Control Register */
 
-#define WRT_DOG(data) *wdtmrctl=data
+/* WDT Control Register bit definitions */
+#define WDT_EXP_SEL_01	0x0001	/* [01] Time-out = 496 us (with 33 Mhz clk). */
+#define WDT_EXP_SEL_02	0x0002	/* [02] Time-out = 508 ms (with 33 Mhz clk). */
+#define WDT_EXP_SEL_03	0x0004	/* [03] Time-out = 1.02 s (with 33 Mhz clk). */
+#define WDT_EXP_SEL_04	0x0008	/* [04] Time-out = 2.03 s (with 33 Mhz clk). */
+#define WDT_EXP_SEL_05	0x0010	/* [05] Time-out = 4.07 s (with 33 Mhz clk). */
+#define WDT_EXP_SEL_06	0x0020	/* [06] Time-out = 8.13 s (with 33 Mhz clk). */
+#define WDT_EXP_SEL_07	0x0040	/* [07] Time-out = 16.27s (with 33 Mhz clk). */
+#define WDT_EXP_SEL_08	0x0080	/* [08] Time-out = 32.54s (with 33 Mhz clk). */
+#define WDT_IRQ_FLG	0x1000	/* [12] Interrupt Request Flag */
+#define WDT_WRST_ENB	0x4000	/* [14] Watchdog Timer Reset Enable */
+#define WDT_ENB		0x8000	/* [15] Watchdog Timer Enable */
 
 static __u16 *wdtmrctl;
 
@@ -112,15 +129,6 @@
 static char wdt_expect_close;
 static spinlock_t wdt_spinlock;
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
-module_param(nowayout, int, 0);
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
-
 /*
  *	Whack the dog
  */
@@ -147,7 +155,7 @@
 }
 
 /*
- * Utility routines
+ *	Utility routines
  */
 
 static void wdt_config(int writeval)
@@ -157,10 +165,10 @@
 
 	/* buy some time (ping) */
 	spin_lock_irqsave(&wdt_spinlock, flags);
-	dummy=readw(wdtmrctl);  /* ensure write synchronization */
+	dummy=readw(wdtmrctl);	/* ensure write synchronization */
 	writew(0xAAAA, wdtmrctl);
 	writew(0x5555, wdtmrctl);
-	/* make WDT configuration register writable one time */
+	/* unlock WDT = make WDT configuration register writable one time */
 	writew(0x3333, wdtmrctl);
 	writew(0xCCCC, wdtmrctl);
 	/* write WDT configuration register */
@@ -168,7 +176,7 @@
 	spin_unlock_irqrestore(&wdt_spinlock, flags);
 }
 
-static void wdt_startup(void)
+static int wdt_startup(void)
 {
 	next_heartbeat = jiffies + (timeout * HZ);
 
@@ -176,28 +184,43 @@
 	timer.expires = jiffies + WDT_INTERVAL;
 	add_timer(&timer);
 
-	wdt_config(WDT_ENB | WDT_WRST_ENB | TIMEOUT_EXPONENT);
+	/* Start the watchdog */
+	wdt_config(WDT_ENB | WDT_WRST_ENB | WDT_EXP_SEL_04);
+
 	printk(KERN_INFO PFX "Watchdog timer is now enabled.\n");
+	return 0;
 }
 
-static void wdt_turnoff(void)
+static int wdt_turnoff(void)
 {
-	if (!nowayout) {
-		/* Stop the timer */
-		del_timer(&timer);
-		wdt_config(0);
-		printk(KERN_INFO PFX "Watchdog timer is now disabled...\n");
-	}
+	/* Stop the timer */
+	del_timer(&timer);
+
+	/* Stop the watchdog */
+	wdt_config(0);
+
+	printk(KERN_INFO PFX "Watchdog timer is now disabled...\n");
+	return 0;
 }
 
-static void wdt_keepalive(void)
+static int wdt_keepalive(void)
 {
 	/* user land ping */
 	next_heartbeat = jiffies + (timeout * HZ);
+	return 0;
+}
+
+static int wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 3600))	/* arbitrary upper limit */
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
 }
 
 /*
- * /dev/watchdog handling
+ *	/dev/watchdog handling
  */
 
 static ssize_t fop_write(struct file * file, const char * buf, size_t count, loff_t * ppos)
@@ -207,10 +230,8 @@
 		return -ESPIPE;
 
 	/* See if we got the magic character 'V' and reload the timer */
-	if(count)
-	{
-		if (!nowayout)
-		{
+	if(count) {
+		if (!nowayout) {
 			size_t ofs;
 
 			/* note: just in case someone wrote the magic character
@@ -248,11 +269,11 @@
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-	if(wdt_expect_close == 42)
+	if(wdt_expect_close == 42) {
 		wdt_turnoff();
-	else {
-		del_timer(&timer);
-		printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
+	} else {
+		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+		wdt_keepalive();
 	}
 	clear_bit(0, &wdt_is_open);
 	wdt_expect_close = 0;
@@ -262,8 +283,7 @@
 static int fop_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
-	static struct watchdog_info ident=
-	{
+	static struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
 		.identity = "SC520",
@@ -307,10 +327,9 @@
 			if(get_user(new_timeout, (int *)arg))
 				return -EFAULT;
 
-			if(new_timeout < 1 || new_timeout > 3600) /* arbitrary upper limit */
+			if(wdt_set_heartbeat(new_timeout))
 				return -EINVAL;
 
-			timeout = new_timeout;
 			wdt_keepalive();
 			/* Fall through */
 		}
@@ -351,81 +370,77 @@
  *	turn the timebomb registers off.
  */
 
-static struct notifier_block wdt_notifier=
-{
+static struct notifier_block wdt_notifier = {
 	.notifier_call = wdt_notify_sys,
 };
 
 static void __exit sc520_wdt_unload(void)
 {
-	wdt_turnoff();
+	if (!nowayout)
+		wdt_turnoff();
 
 	/* Deregister */
 	misc_deregister(&wdt_miscdev);
-	iounmap(wdtmrctl);
 	unregister_reboot_notifier(&wdt_notifier);
+	iounmap(wdtmrctl);
 }
 
 static int __init sc520_wdt_init(void)
 {
 	int rc = -EBUSY;
 	unsigned long cbar;
+	unsigned long MMCR_BASE;
 
 	spin_lock_init(&wdt_spinlock);
 
-	if(timeout < 1 || timeout > 3600) /* arbitrary upper limit */
-	{
-		timeout = WATCHDOG_TIMEOUT;
-		printk(KERN_INFO PFX "timeout value must be 1<=x<=3600, using %d\n",
-			timeout);
-	}
-
 	init_timer(&timer);
 	timer.function = wdt_timer_ping;
 	timer.data = 0;
 
-	rc = misc_register(&wdt_miscdev);
-	if (rc)
-	{
-		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-			wdt_miscdev.minor, rc);
-		goto err_out_region2;
-	}
-
-	rc = register_reboot_notifier(&wdt_notifier);
-	if (rc)
-	{
-		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
-			rc);
-		goto err_out_miscdev;
+	/* Check that the timeout value is within it's range ; if not reset to the default */
+	if (wdt_set_heartbeat(timeout)) {
+		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk(KERN_INFO PFX "timeout value must be 1<=timeout<=3600, using %d\n",
+			WATCHDOG_TIMEOUT);
 	}
 
-	/* get the Base Address Register */
+	/* get the Base Address Register:
+	 * If the ENB bit [31] of CBAR is set => MMCR alias is enabled and MMCR base address is
+	 * the contents of CBAR[29-12].
+	 * if ENB bit is 0 => MMCR alias is disabled and the MMCR base address is the default
+	 * value. */
 	cbar = inl_p(0xfffc);
 	printk(KERN_INFO PFX "CBAR: 0x%08lx\n", cbar);
 	/* check if MMCR aliasing bit is set */
 	if (cbar & 0x80000000) {
 		printk(KERN_INFO PFX "MMCR Aliasing enabled.\n");
-		wdtmrctl = (__u16 *)(cbar & 0x3fffffff);
+		MMCR_BASE = (cbar & 0x3fffffff);
 	} else {
-		printk(KERN_INFO PFX "!!! WARNING !!!\n"
-		  "\t MMCR Aliasing found NOT enabled!\n"
-		  "\t Using default value of: %p\n"
-		  "\t This has not been tested!\n"
-		  "\t Please email Scott Jennings <smj@oro.net>\n"
-		  "\t  and Bill Jennings <bj@oro.net> if it works!\n"
-		  , MMCR_BASE_DEFAULT
-		  );
-	  wdtmrctl = MMCR_BASE_DEFAULT;
+		printk(KERN_INFO PFX "MMCR Aliasing NOT enabled. Using default value.\n");
+		MMCR_BASE = MMCR_BASE_DEFAULT;
 	}
 
-	wdtmrctl = (__u16 *)((char *)wdtmrctl + OFFS_WDTMRCTL);
-	wdtmrctl = ioremap((unsigned long)wdtmrctl, 2);
+	wdtmrctl = ioremap((unsigned long)(MMCR_BASE + OFFS_WDTMRCTL), 2);
 	if (!wdtmrctl) {
-		printk (KERN_ERR PFX "Unable to remap memory.\n");
+		printk(KERN_ERR PFX "Unable to remap memory\n");
 		rc = -ENOMEM;
+		goto err_out_region2;
+	}
+
+	rc = register_reboot_notifier(&wdt_notifier);
+	if (rc) {
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			rc);
+		goto err_out_ioremap;
+	}
+
+	rc = misc_register(&wdt_miscdev);
+	if (rc) {
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, rc);
 		goto err_out_notifier;
 	}
+
 	printk(KERN_INFO PFX "WDT driver for SC520 initialised. timeout=%d sec (nowayout=%d)\n",
 		timeout,nowayout);
 
@@ -433,8 +448,8 @@
 
 err_out_notifier:
 	unregister_reboot_notifier(&wdt_notifier);
-err_out_miscdev:
-	misc_deregister(&wdt_miscdev);
+err_out_ioremap:
+	iounmap(wdtmrctl);
 err_out_region2:
 	return rc;
 }
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Sun Apr 25 16:41:07 2004
+++ b/drivers/char/watchdog/sc520_wdt.c	Sun Apr 25 16:41:07 2004
@@ -39,7 +39,9 @@
  *	-	made timeout (the emulated heartbeat) a module_param
  *	-	made the keepalive ping an internal subroutine
  *	3/27 - 2004 Changes by Sean Young <sean@mess.org>
- *	-	set MMCR_BASE_DEFAULT to 0xfffef000
+ *	-	set MMCR_BASE to 0xfffef000
+ *	-	CBAR does not need to be read
+ *	-	removed debugging printks
  *
  *  This WDT driver is different from most other Linux WDT
  *  drivers in that the driver will ping the watchdog by itself,
@@ -104,7 +106,7 @@
 /*
  * AMD Elan SC520 - Watchdog Timer Registers
  */
-#define MMCR_BASE_DEFAULT	0xfffef000	/* The default base address */
+#define MMCR_BASE	0xfffef000	/* The default base address */
 #define OFFS_WDTMRCTL	0xCB0	/* Watchdog Timer Control Register */
 
 /* WDT Control Register bit definitions */
@@ -388,8 +390,6 @@
 static int __init sc520_wdt_init(void)
 {
 	int rc = -EBUSY;
-	unsigned long cbar;
-	unsigned long MMCR_BASE;
 
 	spin_lock_init(&wdt_spinlock);
 
@@ -402,22 +402,6 @@
 		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
 		printk(KERN_INFO PFX "timeout value must be 1<=timeout<=3600, using %d\n",
 			WATCHDOG_TIMEOUT);
-	}
-
-	/* get the Base Address Register:
-	 * If the ENB bit [31] of CBAR is set => MMCR alias is enabled and MMCR base address is
-	 * the contents of CBAR[29-12].
-	 * if ENB bit is 0 => MMCR alias is disabled and the MMCR base address is the default
-	 * value. */
-	cbar = inl_p(0xfffc);
-	printk(KERN_INFO PFX "CBAR: 0x%08lx\n", cbar);
-	/* check if MMCR aliasing bit is set */
-	if (cbar & 0x80000000) {
-		printk(KERN_INFO PFX "MMCR Aliasing enabled.\n");
-		MMCR_BASE = (cbar & 0x3fffffff);
-	} else {
-		printk(KERN_INFO PFX "MMCR Aliasing NOT enabled. Using default value.\n");
-		MMCR_BASE = MMCR_BASE_DEFAULT;
 	}
 
 	wdtmrctl = ioremap((unsigned long)(MMCR_BASE + OFFS_WDTMRCTL), 2);
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sun Apr 25 16:41:31 2004
+++ b/drivers/char/watchdog/pcwd.c	Sun Apr 25 16:41:31 2004
@@ -70,7 +70,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-#define WD_VER                  "1.16 (03/27/2004)"
+#define WD_VER                  "1.16 (04/25/2004)"
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
