Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbUEBQJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUEBQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 12:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUEBQJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 12:09:28 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:43907 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263129AbUEBQFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 12:05:22 -0400
Date: Sun, 2 May 2004 18:04:38 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.5 watchdog-patches
Message-ID: <20040502180438.T30061@infomag.infomag.iguana.be>
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

 drivers/char/watchdog/acquirewdt.c   |    8 -
 drivers/char/watchdog/advantechwdt.c |   29 ++-
 drivers/char/watchdog/alim1535_wdt.c |   76 ++++++----
 drivers/char/watchdog/alim7101_wdt.c |   62 ++++----
 drivers/char/watchdog/eurotechwdt.c  |   40 ++---
 drivers/char/watchdog/i8xx_tco.c     |    7 
 drivers/char/watchdog/ib700wdt.c     |  136 ++++++++++--------
 drivers/char/watchdog/indydog.c      |   11 -
 drivers/char/watchdog/machzwd.c      |   59 ++++---
 drivers/char/watchdog/mixcomwd.c     |    2 
 drivers/char/watchdog/pcwd.c         |    7 
 drivers/char/watchdog/pcwd_pci.c     |   36 ++--
 drivers/char/watchdog/pcwd_usb.c     |   28 +--
 drivers/char/watchdog/sa1100_wdt.c   |    2 
 drivers/char/watchdog/sbc60xxwdt.c   |   54 ++++---
 drivers/char/watchdog/sc1200wdt.c    |    2 
 drivers/char/watchdog/sc520_wdt.c    |  259 +++++++++++++++++------------------
 drivers/char/watchdog/scx200_wdt.c   |   10 -
 drivers/char/watchdog/shwdt.c        |   20 +-
 drivers/char/watchdog/softdog.c      |    2 
 drivers/char/watchdog/w83627hf_wdt.c |   31 ++--
 drivers/char/watchdog/w83877f_wdt.c  |   50 ++++--
 drivers/char/watchdog/wafer5823wdt.c |   34 ++--
 drivers/char/watchdog/wdt.c          |    2 
 drivers/char/watchdog/wdt977.c       |    2 
 25 files changed, 541 insertions(+), 428 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/05/02 1.1643)
   [WATCHDOG] v2.6.5 set_heartbeat-patch
   
   Extract the code to set the heartbeat in a seperate function
   and use this function to set the heartbeat/timeout values in
   the ioctl and the init code.

<wim@iguana.be> (04/05/02 1.1644)
   [WATCHDOG] v2.6.5 sc520_wdt.c-patch1
   
   Clean-up (general stuff: comments, keep module parameters together, ...)
   Added clear definitions for the Watchdog Timer Control Register bits
   Made start, stop and keepalive return 0 if successful
   Fixed nowayout behaviour so that it is consistent with other watchdog drivers
   Fixed release behaviour so that it is consistent with other watchdog drivers
   Added wdt_set_heartbeat function to set the timeout/heartbeat of the watchdog
   Made sure that memory remapping (wdtmrctl) is done before misc_register is started
   MMCR_BASE_DEFAULT was wrong (Bug 2497 reported by Sean Young)
   
   Tested by Sean Young

<sean@mess.org> (04/05/02 1.1645)
   [WATCHDOG] v2.6.5 sc520_wdt.c-patch2
   
   This patch also removes the cbar usage which is unnecessary. The MMCR is
   always available at 0xfffef000; there is no need to use the cbar register
   (if mmcr aliasing is enabled, then the MMCR is _also_ available at
   another address set by CBAR).

<wim@iguana.be> (04/05/02 1.1646)
   [WATCHDOG] v2.6.5 pcwd.c-keepalive_int.patch
   
   Change keepalive function so that it returns an int (0=successful).

<wim@iguana.be> (04/05/02 1.1647)
   [WATCHDOG] v2.6.5 start/stop/keepalive-int-patch
   
   Make start, stop and keepalive/ping functions return 0 on success.

<wim@iguana.be> (04/05/02 1.1648)
   [WATCHDOG] v2.6.5 register_reboot_notifier/misc_register-patch
   
   Make sure that register_reboot_notifier is always done before
   misc_register and that misc_deregister is always done before
   unregister_reboot_notifier. This way we make sure that
   "userspace" can only access the watchdog when it is completely
   installed.

<wim@iguana.be> (04/05/02 1.1649)
   [WATCHDOG] v2.6.5 eurotechwdt-init/exit-patch
   
   init/exit clean-up: make sure that the order for initialization is:
   request_region -> request_irq -> register_reboot_notifier -> misc_register
   and de-initialization the reverse of the initializations.

<wim@iguana.be> (04/05/02 1.1650)
   [WATCHDOG] v2.6.5 pcwd_pci.c-init/exit-patch
   
   Make sure that /dev/temperature get's registered before /dev/watchdog.

<wim@iguana.be> (04/05/02 1.1651)
   [WATCHDOG] v2.6.5 ib700wdt.c-patch
   
   Make heartbeat (the watchdog's heartbeat) a module parameter.
   Extend ioctl handling (WDIOC_GETBOOTSTATUS & WDIOC_SETOPTIONS).

<wim@iguana.be> (04/05/02 1.1652)
   [WATCHDOG] v2.6.5 scx200_wdt.c-init/exit-patch
   
   init/exit clean-up: make sure that we do a register_reboot_notifier
   before a misc_register. Also do a misc_deregister before an
   unregister_reboot_notifier. This is to make sure that "userspace"
   can only access the watchdog if the complete watchdog device driver
   is loaded.

<wim@iguana.be> (04/05/02 1.1653)
   [WATCHDOG] v2.6.5 machzwd.c-patch
   
   Make the zf_timer_off and zf_timer_on return a 0 on success.
   Extract the keepalive code to a seperate function (zf_keepalive).
   Add GETBOOTSTATUS ioctl.
   init clean-up: initialize as follows:
   request_region -> register_reboot_notifier -> misc_register.

<wim@iguana.be> (04/05/02 1.1654)
   [WATCHDOG] v2.6.5 /dev/watchdog-single_open-release-patch
   
   /dev/watchdog is single open only: so we make sure that the semaphore
   or value that prevents a second open is cleared as the last instruction
   of the release code.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/advantechwdt.c b/drivers/char/watchdog/advantechwdt.c
--- a/drivers/char/watchdog/advantechwdt.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/advantechwdt.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/alim1535_wdt.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/alim1535_wdt.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/alim7101_wdt.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/i8xx_tco.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/i8xx_tco.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/pcwd_pci.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/pcwd_pci.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/pcwd_usb.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/pcwd_usb.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/sbc60xxwdt.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/shwdt.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/shwdt.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/w83627hf_wdt.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/w83877f_wdt.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/w83877f_wdt.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/wafer5823wdt.c	Sun May  2 17:52:35 2004
+++ b/drivers/char/watchdog/wafer5823wdt.c	Sun May  2 17:52:35 2004
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
--- a/drivers/char/watchdog/sc520_wdt.c	Sun May  2 17:52:59 2004
+++ b/drivers/char/watchdog/sc520_wdt.c	Sun May  2 17:52:59 2004
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
--- a/drivers/char/watchdog/sc520_wdt.c	Sun May  2 17:53:23 2004
+++ b/drivers/char/watchdog/sc520_wdt.c	Sun May  2 17:53:23 2004
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
--- a/drivers/char/watchdog/pcwd.c	Sun May  2 17:53:47 2004
+++ b/drivers/char/watchdog/pcwd.c	Sun May  2 17:53:47 2004
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
diff -Nru a/drivers/char/watchdog/acquirewdt.c b/drivers/char/watchdog/acquirewdt.c
--- a/drivers/char/watchdog/acquirewdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/acquirewdt.c	Sun May  2 17:54:11 2004
@@ -95,16 +95,18 @@
  *	Kernel methods.
  */
 
-static void acq_keepalive(void)
+static int acq_keepalive(void)
 {
 	/* Write a watchdog value */
 	inb_p(wdt_start);
+	return 0;
 }
 
-static void acq_stop(void)
+static int acq_stop(void)
 {
 	/* Turn the card off */
 	inb_p(wdt_stop);
+	return 0;
 }
 
 /*
diff -Nru a/drivers/char/watchdog/advantechwdt.c b/drivers/char/watchdog/advantechwdt.c
--- a/drivers/char/watchdog/advantechwdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/advantechwdt.c	Sun May  2 17:54:11 2004
@@ -86,17 +86,19 @@
  *	Kernel methods.
  */
 
-static void
+static int
 advwdt_ping(void)
 {
 	/* Write a watchdog value */
 	outb_p(timeout, wdt_start);
+	return 0;
 }
 
-static void
+static int
 advwdt_disable(void)
 {
 	inb_p(wdt_stop);
+	return 0;
 }
 
 static int
diff -Nru a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
--- a/drivers/char/watchdog/alim1535_wdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/alim1535_wdt.c	Sun May  2 17:54:11 2004
@@ -53,18 +53,30 @@
  *	configuration set.
  */
 
-static void ali_start(void)
+static int ali_start(void)
 {
 	u32 val;
 
 	spin_lock(&ali_lock);
 
+	/* Enable the watchdog counter */
 	pci_read_config_dword(ali_pci, 0xCC, &val);
-	val &= ~0x3F;	/* Mask count */
-	val |= (1<<25) | ali_timeout_bits;
+	val &= ~0x3F;			/* Mask count */
+	val |= ali_timeout_bits;	/* Set the new timeout value */
+	val |= (1<<25);			/* Set the reset enable bit */
 	pci_write_config_dword(ali_pci, 0xCC, val);
 
+	/* Check the new watchdog counter status */
+	pci_read_config_dword(ali_pci, 0xCC, &val);
+	val &= (1<<25) | 0x3F;
+
 	spin_unlock(&ali_lock);
+
+	/* if the count bits or the reset enable bit are zero */
+	/* then the watchdog is not active  */
+	if (((val & 0x3F) == 0) || ((val & (1<<25)) == 0))
+		return -1;
+	return 0;
 }
 
 /*
@@ -73,18 +85,29 @@
  *	Stop the ALi watchdog countdown
  */
 
-static void ali_stop(void)
+static int ali_stop(void)
 {
 	u32 val;
 
 	spin_lock(&ali_lock);
 
+	/* Disable the watchdog counter */
 	pci_read_config_dword(ali_pci, 0xCC, &val);
-	val &= ~0x3F;	/* Mask count to zero (disabled) */
-	val &= ~(1<<25);/* and for safety mask the reset enable */
+	val &= ~0x3F;		/* Mask count to zero (disabled) */
+	val &= ~(1<<25);	/* and for safety mask the reset enable */
 	pci_write_config_dword(ali_pci, 0xCC, val);
 
+	/* Check the new watchdog counter status */
+	pci_read_config_dword(ali_pci, 0xCC, &val);
+	val &= (1<<25) | 0x3F;
+
 	spin_unlock(&ali_lock);
+
+	/* if the count bits and the reset enable bits are not zero */
+	/* then the watchdog is still active  */
+	if (val)
+		return -1;
+	return 0;
 }
 
 /*
@@ -93,9 +116,9 @@
  *      Send a keepalive to the timer (actually we restart the timer).
  */
 
-static void ali_keepalive(void)
+static int ali_keepalive(void)
 {
-	ali_start();
+	return ali_start();
 }
 
 /*
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sun May  2 17:54:11 2004
@@ -112,35 +112,36 @@
 		pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, (tmp & ~ALI_WDT_ARM));
 }
 
-static void wdt_startup(void)
+static int wdt_startup(void)
 {
 	next_heartbeat = jiffies + (timeout * HZ);
 
 	/* We must enable before we kick off the timer in case the timer
 	   occurs as we ping it */
-
 	wdt_change(WDT_ENABLE);
 
 	/* Start the timer */
 	timer.expires = jiffies + WDT_INTERVAL;
 	add_timer(&timer);
 
-
 	printk(KERN_INFO PFX "Watchdog timer is now enabled.\n");
+	return 0;
 }
 
-static void wdt_turnoff(void)
+static int wdt_turnoff(void)
 {
 	/* Stop the timer */
 	del_timer_sync(&timer);
 	wdt_change(WDT_DISABLE);
 	printk(KERN_INFO PFX "Watchdog timer is now disabled...\n");
+	return 0;
 }
 
-static void wdt_keepalive(void)
+static int wdt_keepalive(void)
 {
 	/* user land ping */
 	next_heartbeat = jiffies + (timeout * HZ);
+	return 0;
 }
 
 static int wdt_set_heartbeat(int t)
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sun May  2 17:54:11 2004
@@ -131,11 +131,19 @@
  *	Kernel methods.
  */
 
-static void
+static int
 ibwdt_ping(void)
 {
 	/* Write a watchdog value */
 	outb_p(wd_times[wd_margin], WDT_START);
+	return 0;
+}
+
+static int
+ibwdt_stop(void)
+{
+	outb_p(wd_times[wd_margin], WDT_STOP);
+	return 0;
 }
 
 static ssize_t
@@ -234,7 +242,7 @@
 {
 	spin_lock(&ibwdt_lock);
 	if (expect_close == 42)
-		outb_p(wd_times[wd_margin], WDT_STOP);
+		ibwdt_stop();
 	else
 		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
 
@@ -254,7 +262,7 @@
 {
 	if (code == SYS_DOWN || code == SYS_HALT) {
 		/* Turn the WDT off */
-		outb_p(wd_times[wd_margin], WDT_STOP);
+		ibwdt_stop();
 	}
 	return NOTIFY_DONE;
 }
diff -Nru a/drivers/char/watchdog/indydog.c b/drivers/char/watchdog/indydog.c
--- a/drivers/char/watchdog/indydog.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/indydog.c	Sun May  2 17:54:11 2004
@@ -42,7 +42,7 @@
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
-static void indydog_start(void)
+static int indydog_start(void)
 {
 	u32 mc_ctrl0 = mcmisc_regs->cpuctrl0;
 
@@ -50,9 +50,10 @@
 	mcmisc_regs->cpuctrl0 = mc_ctrl0;
 
 	printk(KERN_INFO PFX "Started watchdog timer.\n");
+	return 0;
 }
 
-static void indydog_stop(void)
+static int indydog_stop(void)
 {
 	u32 mc_ctrl0 = mcmisc_regs->cpuctrl0;
 
@@ -60,11 +61,13 @@
 	mcmisc_regs->cpuctrl0 = mc_ctrl0;
 
 	printk(KERN_INFO PFX "Stopped watchdog timer.\n");
+	return 0;
 }
 
-static void indydog_ping(void)
+static int indydog_ping(void)
 {
 	mcmisc_regs->watchdogt = 0;
+	return 0;
 }
 
 /*
diff -Nru a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Sun May  2 17:54:11 2004
@@ -138,7 +138,7 @@
  * Utility routines
  */
 
-static void wdt_startup(void)
+static int wdt_startup(void)
 {
 	next_heartbeat = jiffies + (timeout * HZ);
 
@@ -146,20 +146,23 @@
 	timer.expires = jiffies + WDT_INTERVAL;
 	add_timer(&timer);
 	printk(KERN_INFO PFX "Watchdog timer is now enabled.\n");
+	return 0;
 }
 
-static void wdt_turnoff(void)
+static int wdt_turnoff(void)
 {
 	/* Stop the timer */
 	del_timer(&timer);
 	inb_p(wdt_stop);
 	printk(KERN_INFO PFX "Watchdog timer is now disabled...\n");
+	return 0;
 }
 
-static void wdt_keepalive(void)
+static int wdt_keepalive(void)
 {
 	/* user land ping */
 	next_heartbeat = jiffies + (timeout * HZ);
+	return 0;
 }
 
 static int wdt_set_heartbeat(int t)
diff -Nru a/drivers/char/watchdog/shwdt.c b/drivers/char/watchdog/shwdt.c
--- a/drivers/char/watchdog/shwdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/shwdt.c	Sun May  2 17:54:11 2004
@@ -87,7 +87,7 @@
  *
  * 	Starts the watchdog.
  */
-static void sh_wdt_start(void)
+static int sh_wdt_start(void)
 {
 	__u8 csr;
 
@@ -127,6 +127,7 @@
 	csr &= ~RSTCSR_RSTS;
 	sh_wdt_write_rstcsr(csr);
 #endif
+	return 0;
 }
 
 /**
@@ -134,7 +135,7 @@
  *
  * 	Stops the watchdog.
  */
-static void sh_wdt_stop(void)
+static int sh_wdt_stop(void)
 {
 	__u8 csr;
 
@@ -143,6 +144,7 @@
 	csr = sh_wdt_read_csr();
 	csr &= ~WTCSR_TME;
 	sh_wdt_write_csr(csr);
+	return 0;
 }
 
 /**
@@ -150,9 +152,10 @@
  *
  * 	The Userspace watchdog got a KeepAlive: schedule the next heartbeat.
  */
-static void sh_wdt_keepalive(void)
+static int sh_wdt_keepalive(void)
 {
 	next_heartbeat = jiffies + (heartbeat * HZ);
+	return 0;
 }
 
 /**
diff -Nru a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Sun May  2 17:54:11 2004
@@ -88,16 +88,18 @@
 	outb_p(0xAA, WDT_EFER); /* Leave extended function mode */
 }
 
-static void
+static int
 wdt_ping(void)
 {
 	wdt_ctrl(timeout);
+	return 0;
 }
 
-static void
+static int
 wdt_disable(void)
 {
 	wdt_ctrl(0);
+	return 0;
 }
 
 static int
diff -Nru a/drivers/char/watchdog/w83877f_wdt.c b/drivers/char/watchdog/w83877f_wdt.c
--- a/drivers/char/watchdog/w83877f_wdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/w83877f_wdt.c	Sun May  2 17:54:11 2004
@@ -155,7 +155,7 @@
 	spin_unlock_irqrestore(&wdt_spinlock, flags);
 }
 
-static void wdt_startup(void)
+static int wdt_startup(void)
 {
 	next_heartbeat = jiffies + (timeout * HZ);
 
@@ -166,9 +166,10 @@
 	wdt_change(WDT_ENABLE);
 
 	printk(KERN_INFO PFX "Watchdog timer is now enabled.\n");
+	return 0;
 }
 
-static void wdt_turnoff(void)
+static int wdt_turnoff(void)
 {
 	/* Stop the timer */
 	del_timer(&timer);
@@ -176,12 +177,14 @@
 	wdt_change(WDT_DISABLE);
 
 	printk(KERN_INFO PFX "Watchdog timer is now disabled...\n");
+	return 0;
 }
 
-static void wdt_keepalive(void)
+static int wdt_keepalive(void)
 {
 	/* user land ping */
 	next_heartbeat = jiffies + (timeout * HZ);
+	return 0;
 }
 
 static int wdt_set_heartbeat(int t)
diff -Nru a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Sun May  2 17:54:11 2004
+++ b/drivers/char/watchdog/wafer5823wdt.c	Sun May  2 17:54:11 2004
@@ -72,26 +72,29 @@
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
-static void wafwdt_ping(void)
+static int wafwdt_ping(void)
 {
 	/* pat watchdog */
 	spin_lock(&wafwdt_lock);
 	inb_p(wdt_stop);
 	inb_p(wdt_start);
 	spin_unlock(&wafwdt_lock);
+	return 0;
 }
 
-static void wafwdt_start(void)
+static int wafwdt_start(void)
 {
 	/* start up watchdog */
 	outb_p(timeout, wdt_start);
 	inb_p(wdt_start);
+	return 0;
 }
 
-static void wafwdt_stop(void)
+static int wafwdt_stop(void)
 {
 	/* stop watchdog */
 	inb_p(wdt_stop);
+	return 0;
 }
 
 static int wafwdt_set_heartbeat(int t)
diff -Nru a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
--- a/drivers/char/watchdog/alim1535_wdt.c	Sun May  2 17:54:35 2004
+++ b/drivers/char/watchdog/alim1535_wdt.c	Sun May  2 17:54:35 2004
@@ -435,28 +435,24 @@
 			WATCHDOG_TIMEOUT);
 	}
 
-	ret = misc_register(&ali_miscdev);
-	if (ret != 0) {
-		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-			WATCHDOG_MINOR, ret);
-		goto out;
-	}
-
 	ret = register_reboot_notifier(&ali_notifier);
 	if (ret != 0) {
 		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
 			ret);
-		goto unreg_miscdev;
+		return ret;
+	}
+
+	ret = misc_register(&ali_miscdev);
+	if (ret != 0) {
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		unregister_reboot_notifier(&ali_notifier);
+		return ret;
 	}
 
 	printk(KERN_INFO PFX "initialized. timeout=%d sec (nowayout=%d)\n",
 		timeout, nowayout);
-
-out:
-	return ret;
-unreg_miscdev:
-	misc_deregister(&ali_miscdev);
-	goto out;
+	return 0;
 }
 
 /*
@@ -471,8 +467,8 @@
 	ali_stop();
 
 	/* Deregister */
-	unregister_reboot_notifier(&ali_notifier);
 	misc_deregister(&ali_miscdev);
+	unregister_reboot_notifier(&ali_notifier);
 }
 
 module_init(watchdog_init);
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sun May  2 17:54:36 2004
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sun May  2 17:54:36 2004
@@ -359,28 +359,24 @@
 			WATCHDOG_TIMEOUT);
 	}
 
-	rc = misc_register(&wdt_miscdev);
-	if (rc) {
-		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-			wdt_miscdev.minor, rc);
-		goto err_out;
-	}
-
 	rc = register_reboot_notifier(&wdt_notifier);
 	if (rc) {
 		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
 			rc);
-		goto err_out_miscdev;
+		return rc;
+	}
+
+	rc = misc_register(&wdt_miscdev);
+	if (rc) {
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			wdt_miscdev.minor, rc);
+		unregister_reboot_notifier(&wdt_notifier);
+		return rc;
 	}
 
 	printk(KERN_INFO PFX "WDT driver for ALi M7101 initialised. timeout=%d sec (nowayout=%d)\n",
 		timeout, nowayout);
 	return 0;
-
-err_out_miscdev:
-	misc_deregister(&wdt_miscdev);
-err_out:
-	return rc;
 }
 
 module_init(alim7101_wdt_init);
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sun May  2 17:54:36 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sun May  2 17:54:36 2004
@@ -301,32 +301,39 @@
 	printk(KERN_INFO PFX "WDT driver for IB700 single board computer initialising.\n");
 
 	spin_lock_init(&ibwdt_lock);
-	res = misc_register(&ibwdt_miscdev);
-	if (res) {
-		printk (KERN_ERR PFX "failed to register misc device\n");
-		goto out_nomisc;
-	}
 
 #if WDT_START != WDT_STOP
 	if (!request_region(WDT_STOP, 1, "IB700 WDT")) {
-		printk (KERN_ERR PFX "STOP method I/O %X is not available.\n", WDT_STOP);
+		printk (KERN_ERR PFX "I/O address 0x%04x already in use\n", WDT_STOP);
 		res = -EIO;
 		goto out_nostopreg;
 	}
 #endif
 
 	if (!request_region(WDT_START, 1, "IB700 WDT")) {
-		printk (KERN_ERR PFX "START method I/O %X is not available.\n", WDT_START);
+		printk (KERN_ERR PFX "I/O address 0x%04x already in use\n", WDT_START);
 		res = -EIO;
 		goto out_nostartreg;
 	}
+
 	res = register_reboot_notifier(&ibwdt_notifier);
 	if (res) {
-		printk (KERN_ERR PFX "Failed to register reboot notifier.\n");
+		printk (KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			res);
 		goto out_noreboot;
 	}
+
+	res = misc_register(&ibwdt_miscdev);
+	if (res) {
+		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, res);
+		goto out_nomisc;
+	}
+
 	return 0;
 
+out_nomisc:
+	unregister_reboot_notifier(&ibwdt_notifier);
 out_noreboot:
 	release_region(WDT_START, 1);
 out_nostartreg:
@@ -334,8 +341,6 @@
 	release_region(WDT_STOP, 1);
 #endif
 out_nostopreg:
-	misc_deregister(&ibwdt_miscdev);
-out_nomisc:
 	return res;
 }
 
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	Sun May  2 17:54:35 2004
+++ b/drivers/char/watchdog/pcwd_usb.c	Sun May  2 17:54:35 2004
@@ -695,17 +695,17 @@
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
 
@@ -718,7 +718,7 @@
 	return 0;
 
 err_out_misc_deregister:
-	misc_deregister(&usb_pcwd_miscdev);
+	misc_deregister(&usb_pcwd_temperature_miscdev);
 err_out_unregister_reboot:
 	unregister_reboot_notifier(&usb_pcwd_notifier);
 error:
@@ -756,8 +756,8 @@
 	usb_pcwd->exists = 0;
 
 	/* Deregister */
-	misc_deregister(&usb_pcwd_temperature_miscdev);
 	misc_deregister(&usb_pcwd_miscdev);
+	misc_deregister(&usb_pcwd_temperature_miscdev);
 	unregister_reboot_notifier(&usb_pcwd_notifier);
 
 	up (&usb_pcwd->sem);
diff -Nru a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Sun May  2 17:54:36 2004
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Sun May  2 17:54:36 2004
@@ -382,20 +382,20 @@
 			WATCHDOG_TIMEOUT);
 	}
 
-	rc = misc_register(&wdt_miscdev);
+	rc = register_reboot_notifier(&wdt_notifier);
 	if (rc)
 	{
-		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-			wdt_miscdev.minor, rc);
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			rc);
 		goto err_out_region2;
 	}
 
-	rc = register_reboot_notifier(&wdt_notifier);
+	rc = misc_register(&wdt_miscdev);
 	if (rc)
 	{
-		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
-			rc);
-		goto err_out_miscdev;
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			wdt_miscdev.minor, rc);
+		goto err_out_notifier;
 	}
 
 	printk(KERN_INFO PFX "WDT driver for 60XX single board computer initialised. timeout=%d sec (nowayout=%d)\n",
@@ -403,8 +403,8 @@
 
 	return 0;
 
-err_out_miscdev:
-	misc_deregister(&wdt_miscdev);
+err_out_notifier:
+	unregister_reboot_notifier(&wdt_notifier);
 err_out_region2:
 	if ((wdt_stop != 0x45) && (wdt_stop != wdt_start))
 		release_region(wdt_stop,1);
diff -Nru a/drivers/char/watchdog/w83877f_wdt.c b/drivers/char/watchdog/w83877f_wdt.c
--- a/drivers/char/watchdog/w83877f_wdt.c	Sun May  2 17:54:35 2004
+++ b/drivers/char/watchdog/w83877f_wdt.c	Sun May  2 17:54:36 2004
@@ -398,20 +398,20 @@
 	timer.function = wdt_timer_ping;
 	timer.data = 0;
 
-	rc = misc_register(&wdt_miscdev);
+	rc = register_reboot_notifier(&wdt_notifier);
 	if (rc)
 	{
-		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-			wdt_miscdev.minor, rc);
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			rc);
 		goto err_out_region2;
 	}
 
-	rc = register_reboot_notifier(&wdt_notifier);
+	rc = misc_register(&wdt_miscdev);
 	if (rc)
 	{
-		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
-			rc);
-		goto err_out_miscdev;
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			wdt_miscdev.minor, rc);
+		goto err_out_notifier;
 	}
 
 	printk(KERN_INFO PFX "WDT driver for W83877F initialised. timeout=%d sec (nowayout=%d)\n",
@@ -419,8 +419,8 @@
 
 	return 0;
 
-err_out_miscdev:
-	misc_deregister(&wdt_miscdev);
+err_out_notifier:
+	unregister_reboot_notifier(&wdt_notifier);
 err_out_region2:
 	release_region(WDT_PING,1);
 err_out_region1:
diff -Nru a/drivers/char/watchdog/eurotechwdt.c b/drivers/char/watchdog/eurotechwdt.c
--- a/drivers/char/watchdog/eurotechwdt.c	Sun May  2 17:55:00 2004
+++ b/drivers/char/watchdog/eurotechwdt.c	Sun May  2 17:55:00 2004
@@ -25,6 +25,9 @@
 
 /* Changelog:
  *
+ * 2001 - Rodolfo Giometti
+ *	Initial release
+ *
  * 2002/04/25 - Rob Radez
  *	clean up #includes
  *	clean up locking
@@ -33,9 +36,6 @@
  *	add WDIOC_GETSTATUS and WDIOC_SETOPTIONS ioctls
  *	add expect_close support
  *
- * 2001 - Rodolfo Giometti
- *	Initial release
- *
  * 2002.05.30 - Joel Becker <joel.becker@oracle.com>
  * 	Added Matt Domsch's nowayout module option.
  */
@@ -406,8 +406,8 @@
 	misc_deregister(&eurwdt_miscdev);
 
 	unregister_reboot_notifier(&eurwdt_notifier);
-	release_region(io, 2);
 	free_irq(irq, NULL);
+	release_region(io, 2);
 }
 
 /**
@@ -422,29 +422,29 @@
 {
 	int ret;
 
-	ret = misc_register(&eurwdt_miscdev);
-	if (ret) {
-		printk(KERN_ERR "eurwdt: can't misc_register on minor=%d\n",
-		WATCHDOG_MINOR);
+	if (!request_region(io, 2, "eurwdt")) {
+		printk(KERN_ERR "eurwdt: IO %X is not free.\n", io);
+		ret = -EBUSY;
 		goto out;
 	}
 
 	ret = request_irq(irq, eurwdt_interrupt, SA_INTERRUPT, "eurwdt", NULL);
 	if(ret) {
 		printk(KERN_ERR "eurwdt: IRQ %d is not free.\n", irq);
-		goto outmisc;
+		goto outreg;
 	}
 
-	if (!request_region(io, 2, "eurwdt")) {
-		printk(KERN_ERR "eurwdt: IO %X is not free.\n", io);
-		ret = -EBUSY;
+	ret = register_reboot_notifier(&eurwdt_notifier);
+	if (ret) {
+		printk(KERN_ERR "eurwdt: can't register reboot notifier (err=%d)\n", ret);
 		goto outirq;
 	}
 
-	ret = register_reboot_notifier(&eurwdt_notifier);
+	ret = misc_register(&eurwdt_miscdev);
 	if (ret) {
-		printk(KERN_ERR "eurwdt: can't register reboot notifier (err=%d)\n", ret);
-		goto outreg;
+		printk(KERN_ERR "eurwdt: can't misc_register on minor=%d (err=%d)\n",
+		WATCHDOG_MINOR, ret);
+		goto outnotifier;
 	}
 
 	eurwdt_unlock_chip();
@@ -457,14 +457,14 @@
 out:
 	return ret;
 
-outreg:
-	release_region(io, 2);
+outnotifier:
+	unregister_reboot_notifier(&eurwdt_notifier);
 
 outirq:
 	free_irq(irq, NULL);
 
-outmisc:
-	misc_deregister(&eurwdt_miscdev);
+outreg:
+	release_region(io, 2);
 	goto out;
 }
 
diff -Nru a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c	Sun May  2 17:55:25 2004
+++ b/drivers/char/watchdog/pcwd_pci.c	Sun May  2 17:55:25 2004
@@ -598,29 +598,30 @@
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
@@ -637,9 +638,9 @@
 		pcipcwd_stop();
 
 	/* Deregister */
+	misc_deregister(&pcipcwd_miscdev);
 	if (pcipcwd_private.supports_temp)
 		misc_deregister(&pcipcwd_temp_miscdev);
-	misc_deregister(&pcipcwd_miscdev);
 	unregister_reboot_notifier(&pcipcwd_notifier);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sun May  2 17:55:49 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sun May  2 17:55:49 2004
@@ -33,6 +33,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
@@ -42,7 +43,6 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
-#include <linux/moduleparam.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -90,32 +90,16 @@
  *
  */
 
-static int wd_times[] = {
-	30,	/* 0x0 */
-	28,	/* 0x1 */
-	26,	/* 0x2 */
-	24,	/* 0x3 */
-	22,	/* 0x4 */
-	20,	/* 0x5 */
-	18,	/* 0x6 */
-	16,	/* 0x7 */
-	14,	/* 0x8 */
-	12,	/* 0x9 */
-	10,	/* 0xA */
-	8,	/* 0xB */
-	6,	/* 0xC */
-	4,	/* 0xD */
-	2,	/* 0xE */
-	0,	/* 0xF */
-};
-
 #define WDT_STOP 0x441
 #define WDT_START 0x443
 
-/* Default timeout */
-#define WD_TIMO 0		/* 30 seconds +/- 20%, from table */
+/* Default heartbeat */
+#define WD_TIMO 30		/* 30 seconds +/- 20%, from table */
 
-static int wd_margin = WD_TIMO;
+static int heartbeat = WD_TIMO;
+static int heartbeat_val;	/* value as used by the watchdog (see table) */
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (0<heartbeat<31, default=" __MODULE_STRING(WD_TIMO) ")");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -135,14 +119,25 @@
 ibwdt_ping(void)
 {
 	/* Write a watchdog value */
-	outb_p(wd_times[wd_margin], WDT_START);
+	outb_p(heartbeat_val, WDT_START);
 	return 0;
 }
 
 static int
 ibwdt_stop(void)
 {
-	outb_p(wd_times[wd_margin], WDT_STOP);
+	outb_p(heartbeat_val, WDT_STOP);
+	return 0;
+}
+
+static int
+ibwdt_set_heartbeat(int t)
+{
+	if ((t < 0) || (t > 30))
+		return -EINVAL;
+
+	heartbeat_val = (30 - t) / 2;
+	heartbeat = t;
 	return 0;
 }
 
@@ -177,7 +172,8 @@
 ibwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	  unsigned long arg)
 {
-	int i, new_margin;
+	int new_options, retval = -EINVAL;
+	int new_heartbeat;
 
 	static struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
@@ -187,32 +183,39 @@
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-	  if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
-	    return -EFAULT;
-	  break;
+	  return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)) ? -EFAULT : 0;
 
 	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
 	  return put_user(0, (int *) arg);
 
 	case WDIOC_KEEPALIVE:
 	  ibwdt_ping();
-	  break;
+	  return 0;
+
+	case WDIOC_SETOPTIONS:
+	  if (get_user (new_options, (int *) arg))
+	    return -EFAULT;
+	  if (new_options & WDIOS_DISABLECARD) {
+	    ibwdt_stop();
+	    retval = 0;
+	  }
+	  if (new_options & WDIOS_ENABLECARD) {
+	    ibwdt_ping();
+	    retval = 0;
+	  }
+	  return retval;
 
 	case WDIOC_SETTIMEOUT:
-	  if (get_user(new_margin, (int *)arg))
+	  if (get_user(new_heartbeat, (int *)arg))
 		  return -EFAULT;
-	  if ((new_margin < 0) || (new_margin > 30))
+	  if (ibwdt_set_heartbeat(new_heartbeat))
 		  return -EINVAL;
-	  for (i = 0x0F; i > -1; i--)
-		  if (wd_times[i] > new_margin)
-			  break;
-	  wd_margin = i;
 	  ibwdt_ping();
 	  /* Fall */
 
 	case WDIOC_GETTIMEOUT:
-	  return put_user(wd_times[wd_margin], (int *)arg);
-	  break;
+	  return put_user(heartbeat, (int *)arg);
 
 	default:
 	  return -ENOIOCTLCMD;
@@ -241,11 +244,12 @@
 ibwdt_close(struct inode *inode, struct file *file)
 {
 	spin_lock(&ibwdt_lock);
-	if (expect_close == 42)
+	if (expect_close == 42) {
 		ibwdt_stop();
-	else
+	} else {
 		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
-
+		ibwdt_ping();
+	}
 	clear_bit(0, &ibwdt_is_open);
 	expect_close = 0;
 	spin_unlock(&ibwdt_lock);
@@ -273,6 +277,7 @@
 
 static struct file_operations ibwdt_fops = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= ibwdt_write,
 	.ioctl		= ibwdt_ioctl,
 	.open		= ibwdt_open,
@@ -314,6 +319,14 @@
 		printk (KERN_ERR PFX "I/O address 0x%04x already in use\n", WDT_START);
 		res = -EIO;
 		goto out_nostartreg;
+	}
+
+	/* Check that the heartbeat value is within it's range ; if not reset to the default */
+	if (ibwdt_set_heartbeat(heartbeat)) {
+		heartbeat = WD_TIMO;
+		ibwdt_set_heartbeat(heartbeat);
+		printk(KERN_INFO PFX "heartbeat value must be 0<heartbeat<31, using %d\n",
+			heartbeat);
 	}
 
 	res = register_reboot_notifier(&ibwdt_notifier);
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	Sun May  2 17:56:13 2004
+++ b/drivers/char/watchdog/scx200_wdt.c	Sun May  2 17:56:13 2004
@@ -244,17 +244,17 @@
 
 	sema_init(&open_semaphore, 1);
 
-	r = misc_register(&scx200_wdt_miscdev);
+	r = register_reboot_notifier(&scx200_wdt_notifier);
 	if (r) {
+		printk(KERN_ERR NAME ": unable to register reboot notifier");
 		release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
 				SCx200_WDT_SIZE);
 		return r;
 	}
 
-	r = register_reboot_notifier(&scx200_wdt_notifier);
+	r = misc_register(&scx200_wdt_miscdev);
 	if (r) {
-		printk(KERN_ERR NAME ": unable to register reboot notifier");
-		misc_deregister(&scx200_wdt_miscdev);
+		unregister_reboot_notifier(&scx200_wdt_notifier);
 		release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
 				SCx200_WDT_SIZE);
 		return r;
@@ -265,8 +265,8 @@
 
 static void __exit scx200_wdt_cleanup(void)
 {
-	unregister_reboot_notifier(&scx200_wdt_notifier);
 	misc_deregister(&scx200_wdt_miscdev);
+	unregister_reboot_notifier(&scx200_wdt_notifier);
 	release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
 		       SCx200_WDT_SIZE);
 }
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Sun May  2 17:56:37 2004
+++ b/drivers/char/watchdog/machzwd.c	Sun May  2 17:56:37 2004
@@ -217,7 +217,7 @@
 /*
  * stop hardware timer
  */
-static void zf_timer_off(void)
+static int zf_timer_off(void)
 {
 	unsigned int ctrl_reg = 0;
 	unsigned long flags;
@@ -234,13 +234,14 @@
 	spin_unlock_irqrestore(&zf_port_lock, flags);
 
 	printk(KERN_INFO PFX ": Watchdog timer is now disabled\n");
+	return 0;
 }
 
 
 /*
  * start hardware timer
  */
-static void zf_timer_on(void)
+static int zf_timer_on(void)
 {
 	unsigned int ctrl_reg = 0;
 	unsigned long flags;
@@ -266,6 +267,17 @@
 	spin_unlock_irqrestore(&zf_port_lock, flags);
 
 	printk(KERN_INFO PFX ": Watchdog timer is now enabled\n");
+	return 0;
+}
+
+/*
+ * sent hardware timer a keepalive
+ */
+static int zf_keepalive(void)
+{
+	next_heartbeat = jiffies + ZF_USER_TIMEO;
+	dprintk("user ping at %ld\n", jiffies);
+	return 0;
 }
 
 
@@ -341,8 +353,7 @@
 		 * Well, anyhow someone wrote to us,
 		 * we should return that favour
 		 */
-		next_heartbeat = jiffies + ZF_USER_TIMEO;
-		dprintk("user ping at %ld\n", jiffies);
+		zf_keepalive();
 
 	}
 
@@ -360,6 +371,7 @@
 			break;
 
 		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
 			return put_user(0, (int *) arg);
 
 		case WDIOC_KEEPALIVE:
@@ -428,6 +440,7 @@
 
 static struct file_operations zf_fops = {
 	.owner          = THIS_MODULE,
+	.llseek		= no_llseek,
 	.write          = zf_write,
 	.ioctl          = zf_ioctl,
 	.open           = zf_open,
@@ -479,25 +492,11 @@
 	spin_lock_init(&zf_lock);
 	spin_lock_init(&zf_port_lock);
 
-	ret = misc_register(&zf_miscdev);
-	if (ret){
-		printk(KERN_ERR "can't misc_register on minor=%d\n",
-							WATCHDOG_MINOR);
-		goto out;
-	}
-
 	if(!request_region(ZF_IOBASE, 3, "MachZ ZFL WDT")){
 		printk(KERN_ERR "cannot reserve I/O ports at %d\n",
 							ZF_IOBASE);
 		ret = -EBUSY;
-		goto no_region;
-	}
-
-	ret = register_reboot_notifier(&zf_notifier);
-	if(ret){
-		printk(KERN_ERR "can't register reboot notifier (err=%d)\n",
-									ret);
-		goto no_reboot;
+		goto out;
 	}
 
 	zf_set_status(0);
@@ -508,12 +507,26 @@
 	zf_timer.function = zf_ping;
 	zf_timer.data = 0;
 
+	ret = register_reboot_notifier(&zf_notifier);
+	if(ret){
+		printk(KERN_ERR "can't register reboot notifier (err=%d)\n",
+									ret);
+		goto no_region;
+	}
+
+	ret = misc_register(&zf_miscdev);
+	if (ret){
+		printk(KERN_ERR "can't misc_register on minor=%d\n",
+							WATCHDOG_MINOR);
+		goto no_reboot;
+	}
+
 	return 0;
 
 no_reboot:
-	release_region(ZF_IOBASE, 3);
+	unregister_reboot_notifier(&zf_notifier);
 no_region:
-	misc_deregister(&zf_miscdev);
+	release_region(ZF_IOBASE, 3);
 out:
 	return ret;
 }
diff -Nru a/drivers/char/watchdog/acquirewdt.c b/drivers/char/watchdog/acquirewdt.c
--- a/drivers/char/watchdog/acquirewdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/acquirewdt.c	Sun May  2 17:57:02 2004
@@ -217,8 +217,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		acq_keepalive();
 	}
-	clear_bit(0, &acq_is_open);
 	expect_close = 0;
+	clear_bit(0, &acq_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/advantechwdt.c b/drivers/char/watchdog/advantechwdt.c
--- a/drivers/char/watchdog/advantechwdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/advantechwdt.c	Sun May  2 17:57:02 2004
@@ -221,8 +221,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		advwdt_ping();
 	}
-	clear_bit(0, &advwdt_is_open);
 	adv_expect_close = 0;
+	clear_bit(0, &advwdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
--- a/drivers/char/watchdog/alim1535_wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/alim1535_wdt.c	Sun May  2 17:57:02 2004
@@ -309,8 +309,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		ali_keepalive();
 	}
-	clear_bit(0, &ali_is_open);
 	ali_expect_release = 0;
+	clear_bit(0, &ali_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sun May  2 17:57:02 2004
@@ -202,11 +202,11 @@
 	if(wdt_expect_close == 42)
 		wdt_turnoff();
 	else {
-		/* wim: shouldn't there be a: del_timer(&timer); */
 		printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
+		wdt_keepalive();
 	}
-	clear_bit(0, &wdt_is_open);
 	wdt_expect_close = 0;
+	clear_bit(0, &wdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/eurotechwdt.c b/drivers/char/watchdog/eurotechwdt.c
--- a/drivers/char/watchdog/eurotechwdt.c	Sun May  2 17:57:01 2004
+++ b/drivers/char/watchdog/eurotechwdt.c	Sun May  2 17:57:01 2004
@@ -332,8 +332,8 @@
 		printk(KERN_CRIT "eurwdt: Unexpected close, not stopping watchdog!\n");
 		eurwdt_ping();
 	}
-	clear_bit(0, &eurwdt_is_open);
 	eur_expect_close = 0;
+	clear_bit(0, &eurwdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c	Sun May  2 17:57:01 2004
+++ b/drivers/char/watchdog/i8xx_tco.c	Sun May  2 17:57:01 2004
@@ -207,8 +207,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		tco_timer_keepalive ();
 	}
-	clear_bit(0, &timer_alive);
 	tco_expect_close = 0;
+	clear_bit(0, &timer_alive);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sun May  2 17:57:02 2004
@@ -250,8 +250,8 @@
 		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
 		ibwdt_ping();
 	}
-	clear_bit(0, &ibwdt_is_open);
 	expect_close = 0;
+	clear_bit(0, &ibwdt_is_open);
 	spin_unlock(&ibwdt_lock);
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/indydog.c b/drivers/char/watchdog/indydog.c
--- a/drivers/char/watchdog/indydog.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/indydog.c	Sun May  2 17:57:02 2004
@@ -104,8 +104,8 @@
 		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
 		indydog_ping();
 	}
-	clear_bit(0,&indydog_alive);
 	expect_close = 0;
+	clear_bit(0,&indydog_alive);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Sun May  2 17:57:01 2004
+++ b/drivers/char/watchdog/machzwd.c	Sun May  2 17:57:01 2004
@@ -412,11 +412,11 @@
 		printk(KERN_ERR PFX ": device file closed unexpectedly. Will not stop the WDT!\n");
 	}
 
+	zf_expect_close = 0;
+
 	spin_lock(&zf_lock);
 	clear_bit(0, &zf_is_open);
 	spin_unlock(&zf_lock);
-
-	zf_expect_close = 0;
 
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/mixcomwd.c	Sun May  2 17:57:02 2004
@@ -128,8 +128,8 @@
 		printk(KERN_CRIT "mixcomwd: WDT device closed unexpectedly.  WDT will not stop!\n");
 	}
 
-	clear_bit(0,&mixcomwd_opened);
 	expect_close=0;
+	clear_bit(0,&mixcomwd_opened);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sun May  2 17:57:01 2004
+++ b/drivers/char/watchdog/pcwd.c	Sun May  2 17:57:01 2004
@@ -529,12 +529,12 @@
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
--- a/drivers/char/watchdog/pcwd_pci.c	Sun May  2 17:57:01 2004
+++ b/drivers/char/watchdog/pcwd_pci.c	Sun May  2 17:57:01 2004
@@ -404,8 +404,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		pcipcwd_keepalive();
 	}
-	clear_bit(0, &is_active);
 	expect_release = 0;
+	clear_bit(0, &is_active);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
--- a/drivers/char/watchdog/pcwd_usb.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/pcwd_usb.c	Sun May  2 17:57:02 2004
@@ -457,8 +457,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		usb_pcwd_keepalive(usb_pcwd_device);
 	}
-	clear_bit(0, &is_active);
 	expect_release = 0;
+	clear_bit(0, &is_active);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/sa1100_wdt.c	Sun May  2 17:57:02 2004
@@ -76,8 +76,8 @@
 		printk(KERN_CRIT "WATCHDOG: WDT device closed unexpectedly.  WDT will not stop!\n");
 	}
 
-	clear_bit(1, &sa1100wdt_users);
 	expect_close = 0;
+	clear_bit(1, &sa1100wdt_users);
 
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Sun May  2 17:57:02 2004
@@ -234,8 +234,8 @@
 		del_timer(&timer);
 		printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
 	}
-	clear_bit(0, &wdt_is_open);
 	wdt_expect_close = 0;
+	clear_bit(0, &wdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
--- a/drivers/char/watchdog/sc1200wdt.c	Sun May  2 17:57:01 2004
+++ b/drivers/char/watchdog/sc1200wdt.c	Sun May  2 17:57:01 2004
@@ -246,8 +246,8 @@
 		sc1200wdt_write_data(WDTO, timeout);
 		printk(KERN_CRIT PFX "Unexpected close!, timeout = %d min(s)\n", timeout);
 	}
-	up(&open_sem);
 	expect_close = 0;
+	up(&open_sem);
 
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/sc520_wdt.c	Sun May  2 17:57:02 2004
@@ -277,8 +277,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		wdt_keepalive();
 	}
-	clear_bit(0, &wdt_is_open);
 	wdt_expect_close = 0;
+	clear_bit(0, &wdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/shwdt.c b/drivers/char/watchdog/shwdt.c
--- a/drivers/char/watchdog/shwdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/shwdt.c	Sun May  2 17:57:02 2004
@@ -233,8 +233,8 @@
 		sh_wdt_keepalive();
 	}
 
-	clear_bit(0, &shwdt_is_open);
 	shwdt_expect_close = 0;
+	clear_bit(0, &shwdt_is_open);
 
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/softdog.c	Sun May  2 17:57:02 2004
@@ -156,8 +156,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		softdog_keepalive();
 	}
-	clear_bit(0, &timer_alive);
 	expect_close = 0;
+	clear_bit(0, &timer_alive);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Sun May  2 17:57:02 2004
@@ -222,8 +222,8 @@
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		wdt_ping();
 	}
-	clear_bit(0, &wdt_is_open);
 	expect_close = 0;
+	clear_bit(0, &wdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/w83877f_wdt.c b/drivers/char/watchdog/w83877f_wdt.c
--- a/drivers/char/watchdog/w83877f_wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/w83877f_wdt.c	Sun May  2 17:57:02 2004
@@ -253,8 +253,8 @@
 		del_timer(&timer);
 		printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
 	}
-	clear_bit(0, &wdt_is_open);
 	wdt_expect_close = 0;
+	clear_bit(0, &wdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/wafer5823wdt.c	Sun May  2 17:57:02 2004
@@ -218,8 +218,8 @@
 		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
 		wafwdt_ping();
 	}
-	clear_bit(0, &wafwdt_is_open);
 	expect_close = 0;
+	clear_bit(0, &wafwdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/wdt.c	Sun May  2 17:57:02 2004
@@ -414,12 +414,12 @@
 {
 	if (expect_close == 42) {
 		wdt_stop();
-		clear_bit(0, &wdt_is_open);
 	} else {
 		printk(KERN_CRIT "wdt: WDT device closed unexpectedly.  WDT will not stop!\n");
 		wdt_ping();
 	}
 	expect_close = 0;
+	clear_bit(0, &wdt_is_open);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/wdt977.c b/drivers/char/watchdog/wdt977.c
--- a/drivers/char/watchdog/wdt977.c	Sun May  2 17:57:02 2004
+++ b/drivers/char/watchdog/wdt977.c	Sun May  2 17:57:02 2004
@@ -252,12 +252,12 @@
 	if (expect_close == 42)
 	{
 		wdt977_stop();
-		clear_bit(0,&timer_alive);
 	} else {
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		wdt977_keepalive();
 	}
 	expect_close = 0;
+	clear_bit(0,&timer_alive);
 	return 0;
 }
 
