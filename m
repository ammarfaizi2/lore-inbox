Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbUCMXFz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 18:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbUCMXFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 18:05:55 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:37865 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263213AbUCMXFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 18:05:10 -0500
Date: Sun, 14 Mar 2004 00:02:29 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Woody Suwalski <woody@suwalski.net>
Subject: [WATCHDOG] v2.6.4 - patches
Message-ID: <20040314000229.S30061@infomag.infomag.iguana.be>
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

 drivers/char/watchdog/advantechwdt.c |    2 
 drivers/char/watchdog/alim1535_wdt.c |    2 
 drivers/char/watchdog/alim7101_wdt.c |    2 
 drivers/char/watchdog/ib700wdt.c     |    2 
 drivers/char/watchdog/machzwd.c      |    2 
 drivers/char/watchdog/pcwd_pci.c     |   10 -
 drivers/char/watchdog/sbc60xxwdt.c   |    2 
 drivers/char/watchdog/sc520_wdt.c    |    2 
 drivers/char/watchdog/w83627hf_wdt.c |    2 
 drivers/char/watchdog/w83877f_wdt.c  |    2 
 drivers/char/watchdog/wafer5823wdt.c |    2 
 drivers/char/watchdog/wdt.c          |    2 
 drivers/char/watchdog/wdt977.c       |  348 +++++++++++++++++++++--------------
 13 files changed, 223 insertions(+), 157 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/03/13 1.1617)
   [WATCHDOG] v2.6.4 pcwd_pci-v1.00_20040313-patch
   
   Two small fixes:
   * Make cards_found a global variable so that if we remove the
     pci device we can count down.
   * If we can't find a correct I/O address for the card, then we
   should disable the card again.

<wim@iguana.be> (04/03/13 1.1618)
   WATCHDOG] v2.6.4 wdt977-v0.03-patch
   
   Version 0.03 of wdt977.c - Changes that were made are:
   * Extract the stop code in a seperate function (wdt977_stop)
   * Extract the start code in a seperate function (wdt977_start)
   * Rename kick_wdog to wdt977_keepalive for consistency
   * Extract the watchdog's status code to a seperate function (wdt977_get_status)
   * Change the way we deal with the watchdog timeout:
      Up till now we used timeoutM (in minutes) as the correct value and then
      calculated timeout as being timeoutM*60 or *timeoutM*120 (depending on
      wether or not we have the netwinder hardware bug).
   
      From now on timeout is the correct value and we calculate timeoutM out
      of it. Because of this we start with checking wether or not we have a
      correct timeout value (if not we reset it to the default value) and we
      automatically calculate timeoutM. Each time we change timeout with a
      correct timeout value, we recalculate timeoutM.
   * Extended ioctl code with WDIOC_SETOPTIONS and updated the watchdog_info structure
   * Added notifier support
   
   Code has been tested by Woody

<wim@iguana.be> (04/03/13 1.1619)
   [WATCHDOG] v2.6.4 notifier_block-patches
   
   Remove unnecessary initialization in notifier_block


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c	Sat Mar 13 23:57:52 2004
+++ b/drivers/char/watchdog/pcwd_pci.c	Sat Mar 13 23:57:52 2004
@@ -49,7 +49,7 @@
 
 /* Module and version information */
 #define WATCHDOG_VERSION "1.00"
-#define WATCHDOG_DATE "09/02/2004"
+#define WATCHDOG_DATE "13/03/2004"
 #define WATCHDOG_DRIVER_NAME "PCI-PC Watchdog"
 #define WATCHDOG_NAME "pcwd_pci"
 #define PFX WATCHDOG_NAME ": "
@@ -82,6 +82,9 @@
 #define CMD_READ_WATCHDOG_TIMEOUT	0x18
 #define CMD_WRITE_WATCHDOG_TIMEOUT	0x19
 
+/* We can only use 1 card due to the /dev/watchdog restriction */
+static int cards_found;
+
 /* internal variables */
 static int temp_panic;
 static unsigned long is_active;
@@ -505,7 +508,6 @@
 static int __devinit pcipcwd_card_init(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
-	static int cards_found;
 	int ret = -EIO;
 	int got_fw_rev, fw_rev_major, fw_rev_minor;
 	char fw_ver_str[20];
@@ -527,7 +529,8 @@
 
 	if (pci_resource_start(pdev, 0) == 0x0000) {
 		printk(KERN_ERR PFX "No I/O-Address for card detected\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_out_disable_device;
 	}
 
 	pcipcwd_private.pdev = pdev;
@@ -643,6 +646,7 @@
 	unregister_reboot_notifier(&pcipcwd_notifier);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
+	cards_found--;
 }
 
 static struct pci_device_id pcipcwd_pci_tbl[] = {
diff -Nru a/drivers/char/watchdog/wdt977.c b/drivers/char/watchdog/wdt977.c
--- a/drivers/char/watchdog/wdt977.c	Sat Mar 13 23:58:18 2004
+++ b/drivers/char/watchdog/wdt977.c	Sat Mar 13 23:58:18 2004
@@ -1,5 +1,5 @@
 /*
- *	Wdt977	0.02:	A Watchdog Device for Netwinder W83977AF chip
+ *	Wdt977	0.03:	A Watchdog Device for Netwinder W83977AF chip
  *
  *	(c) Copyright 1998 Rebel.com (Woody Suwalski <woody@netwinder.org>)
  *
@@ -29,24 +29,27 @@
 #include <linux/miscdevice.h>
 #include <linux/init.h>
 #include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/mach-types.h>
 #include <asm/uaccess.h>
 
+#define PFX "Wdt977: "
 #define WATCHDOG_MINOR	130
 
-#define	DEFAULT_TIMEOUT	1	/* default timeout = 1 minute */
+#define	DEFAULT_TIMEOUT	60			/* default timeout in seconds */
 
-static	int timeout = DEFAULT_TIMEOUT*60;	/* TO in seconds from user */
-static	int timeoutM = DEFAULT_TIMEOUT;		/* timeout in minutes */
+static	int timeout = DEFAULT_TIMEOUT;
+static	int timeoutM;				/* timeout in minutes */
 static	unsigned long timer_alive;
 static	int testmode;
 static	char expect_close;
 
 module_param(timeout, int, 0);
-MODULE_PARM_DESC(timeout,"Watchdog timeout in seconds (60..15300), default=60");
+MODULE_PARM_DESC(timeout,"Watchdog timeout in seconds (60..15300), default=" __MODULE_STRING(DEFAULT_TIMEOUT) ")");
 module_param(testmode, int, 0);
 MODULE_PARM_DESC(testmode,"Watchdog testmode (1 = no reboot), default=0");
 
@@ -59,21 +62,102 @@
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
+/*
+ * Start the watchdog
+ */
 
-/* This is kicking the watchdog by simply re-writing the timeout to reg. 0xF2 */
-static int kick_wdog(void)
+static int wdt977_start(void)
 {
-	/*
-	 *	Refresh the timer.
+	/* unlock the SuperIO chip */
+	outb(0x87,0x370);
+	outb(0x87,0x370);
+
+	/* select device Aux2 (device=8) and set watchdog regs F2, F3 and F4
+	 * F2 has the timeout in minutes
+	 * F3 could be set to the POWER LED blink (with GP17 set to PowerLed)
+	 *   at timeout, and to reset timer on kbd/mouse activity (not impl.)
+	 * F4 is used to just clear the TIMEOUT'ed state (bit 0)
 	 */
+	outb(0x07,0x370);
+	outb(0x08,0x371);
+	outb(0xF2,0x370);
+	outb(timeoutM,0x371);
+	outb(0xF3,0x370);
+	outb(0x00,0x371);	/* another setting is 0E for kbd/mouse/LED */
+	outb(0xF4,0x370);
+	outb(0x00,0x371);
+
+	/* at last select device Aux1 (dev=7) and set GP16 as a watchdog output */
+	/* in test mode watch the bit 1 on F4 to indicate "triggered" */
+	if (!testmode)
+	{
+		outb(0x07,0x370);
+		outb(0x07,0x371);
+		outb(0xE6,0x370);
+		outb(0x08,0x371);
+	}
 
+	/* lock the SuperIO chip */
+	outb(0xAA,0x370);
+
+	printk(KERN_INFO PFX "activated.\n");
+
+	return 0;
+}
+
+/*
+ * Stop the watchdog
+ */
+
+static int wdt977_stop(void)
+{
+	/* unlock the SuperIO chip */
+	outb(0x87,0x370);
+	outb(0x87,0x370);
+
+	/* select device Aux2 (device=8) and set watchdog regs F2,F3 and F4
+	* F3 is reset to its default state
+	* F4 can clear the TIMEOUT'ed state (bit 0) - back to default
+	* We can not use GP17 as a PowerLed, as we use its usage as a RedLed
+	*/
+	outb(0x07,0x370);
+	outb(0x08,0x371);
+	outb(0xF2,0x370);
+	outb(0xFF,0x371);
+	outb(0xF3,0x370);
+	outb(0x00,0x371);
+	outb(0xF4,0x370);
+	outb(0x00,0x371);
+	outb(0xF2,0x370);
+	outb(0x00,0x371);
+
+	/* at last select device Aux1 (dev=7) and set GP16 as a watchdog output */
+	outb(0x07,0x370);
+	outb(0x07,0x371);
+	outb(0xE6,0x370);
+	outb(0x08,0x371);
+
+	/* lock the SuperIO chip */
+	outb(0xAA,0x370);
+
+	printk(KERN_INFO PFX "shutdown.\n");
+
+	return 0;
+}
+
+/*
+ * Send a keepalive ping to the watchdog
+ * This is done by simply re-writing the timeout to reg. 0xF2
+ */
+
+static int wdt977_keepalive(void)
+{
 	/* unlock the SuperIO chip */
 	outb(0x87,0x370);
 	outb(0x87,0x370);
 
 	/* select device Aux2 (device=8) and kicks watchdog reg F2 */
 	/* F2 has the timeout in minutes */
-
 	outb(0x07,0x370);
 	outb(0x08,0x371);
 	outb(0xF2,0x370);
@@ -85,77 +169,77 @@
 	return 0;
 }
 
-
 /*
- *	Allow only one person to hold it open
+ * Set the watchdog timeout value
  */
 
-static int wdt977_open(struct inode *inode, struct file *file)
+static int wdt977_set_timeout(int t)
 {
-
-	if( test_and_set_bit(0,&timer_alive) )
-		return -EBUSY;
+	int tmrval;
 
 	/* convert seconds to minutes, rounding up */
-	timeoutM = timeout + 59;
-	timeoutM /= 60;
-
-	if (nowayout)
-	{
-		__module_get(THIS_MODULE);
+	tmrval = (t + 59) / 60;
 
-		/* do not permit disabling the watchdog by writing 0 to reg. 0xF2 */
-		if (!timeoutM) timeoutM = DEFAULT_TIMEOUT;
-	}
-
-	if (machine_is_netwinder())
-	{
+	if (machine_is_netwinder()) {
 		/* we have a hw bug somewhere, so each 977 minute is actually only 30sec
 		 *  this limits the max timeout to half of device max of 255 minutes...
 		 */
-		timeoutM += timeoutM;
+		tmrval += tmrval;
 	}
 
-	/* max timeout value = 255 minutes (0xFF). Write 0 to disable WatchDog. */
-	if (timeoutM > 255) timeoutM = 255;
+	if ((tmrval < 1) || (tmrval > 255))
+		return -EINVAL;
 
-	/* convert seconds to minutes */
-	printk(KERN_INFO "Wdt977 Watchdog activated: timeout = %d sec, nowayout = %i, testmode = %i.\n",
-		machine_is_netwinder() ? (timeoutM>>1)*60 : timeoutM*60,
-		nowayout, testmode);
+	/* timeout is the timeout in seconds, timeoutM is the timeout in minutes) */
+	timeout = t;
+	timeoutM = tmrval;
+	return 0;
+}
+
+/*
+ * Get the watchdog status
+ */
+
+static int wdt977_get_status(int *status)
+{
+	int new_status;
+
+	*status=0;
 
 	/* unlock the SuperIO chip */
 	outb(0x87,0x370);
 	outb(0x87,0x370);
 
-	/* select device Aux2 (device=8) and set watchdog regs F2, F3 and F4
-	 * F2 has the timeout in minutes
-	 * F3 could be set to the POWER LED blink (with GP17 set to PowerLed)
-	 *   at timeout, and to reset timer on kbd/mouse activity (not impl.)
-	 * F4 is used to just clear the TIMEOUT'ed state (bit 0)
-	 */
+	/* select device Aux2 (device=8) and read watchdog reg F4 */
 	outb(0x07,0x370);
 	outb(0x08,0x371);
-	outb(0xF2,0x370);
-	outb(timeoutM,0x371);
-	outb(0xF3,0x370);
-	outb(0x00,0x371);	/* another setting is 0E for kbd/mouse/LED */
 	outb(0xF4,0x370);
-	outb(0x00,0x371);
-
-	/* at last select device Aux1 (dev=7) and set GP16 as a watchdog output */
-	/* in test mode watch the bit 1 on F4 to indicate "triggered" */
-	if (!testmode)
-	{
-		outb(0x07,0x370);
-		outb(0x07,0x371);
-		outb(0xE6,0x370);
-		outb(0x08,0x371);
-	}
+	new_status = inb(0x371);
 
 	/* lock the SuperIO chip */
 	outb(0xAA,0x370);
 
+	if (new_status & 1)
+		*status |= WDIOF_CARDRESET;
+
+	return 0;
+}
+
+
+/*
+ *	/dev/watchdog handling
+ */
+
+static int wdt977_open(struct inode *inode, struct file *file)
+{
+	/* If the watchdog is alive we don't need to start it again */
+	if( test_and_set_bit(0,&timer_alive) )
+		return -EBUSY;
+
+	if (nowayout)
+		__module_get(THIS_MODULE);
+
+	wdt977_start();
 	return 0;
 }
 
@@ -167,40 +251,11 @@
 	 */
 	if (expect_close == 42)
 	{
-		/* unlock the SuperIO chip */
-		outb(0x87,0x370);
-		outb(0x87,0x370);
-
-		/* select device Aux2 (device=8) and set watchdog regs F2,F3 and F4
-		* F3 is reset to its default state
-		* F4 can clear the TIMEOUT'ed state (bit 0) - back to default
-		* We can not use GP17 as a PowerLed, as we use its usage as a RedLed
-		*/
-		outb(0x07,0x370);
-		outb(0x08,0x371);
-		outb(0xF2,0x370);
-		outb(0xFF,0x371);
-		outb(0xF3,0x370);
-		outb(0x00,0x371);
-		outb(0xF4,0x370);
-		outb(0x00,0x371);
-		outb(0xF2,0x370);
-		outb(0x00,0x371);
-
-		/* at last select device Aux1 (dev=7) and set GP16 as a watchdog output */
-		outb(0x07,0x370);
-		outb(0x07,0x371);
-		outb(0xE6,0x370);
-		outb(0x08,0x371);
-
-		/* lock the SuperIO chip */
-		outb(0xAA,0x370);
-
+		wdt977_stop();
 		clear_bit(0,&timer_alive);
-
-		printk(KERN_INFO "Wdt977 Watchdog: shutdown\n");
 	} else {
-		printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not stop!\n");
+		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+		wdt977_keepalive();
 	}
 	expect_close = 0;
 	return 0;
@@ -240,7 +295,7 @@
 			}
 		}
 
-		kick_wdog();
+		wdt977_keepalive();
 	}
 	return count;
 }
@@ -257,14 +312,19 @@
  */
 
 static struct watchdog_info ident = {
-	.options	= WDIOF_SETTIMEOUT,
-	.identity	= "Winbond 83977",
+	.options =		WDIOF_SETTIMEOUT |
+				WDIOF_MAGICCLOSE |
+				WDIOF_KEEPALIVEPING,
+	.firmware_version =	1,
+	.identity =		"Winbond 83977",
 };
 
 static int wdt977_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
-	int temp;
+	int status;
+	int new_options, retval = -EINVAL;
+	int new_timeout;
 
 	switch(cmd)
 	{
@@ -272,62 +332,59 @@
 		return -ENOIOCTLCMD;
 
 	case WDIOC_GETSUPPORT:
-	    return copy_to_user((struct watchdog_info *)arg, &ident,
+		return copy_to_user((struct watchdog_info *)arg, &ident,
 			sizeof(ident)) ? -EFAULT : 0;
 
+	case WDIOC_GETSTATUS:
+		wdt977_get_status(&status);
+		return put_user(status, (int *) arg);
+
 	case WDIOC_GETBOOTSTATUS:
 		return put_user(0, (int *) arg);
 
-	case WDIOC_GETSTATUS:
-		/* unlock the SuperIO chip */
-		outb(0x87,0x370);
-		outb(0x87,0x370);
+	case WDIOC_KEEPALIVE:
+		wdt977_keepalive();
+		return 0;
 
-		/* select device Aux2 (device=8) and read watchdog reg F4 */
-		outb(0x07,0x370);
-		outb(0x08,0x371);
-		outb(0xF4,0x370);
-		temp = inb(0x371);
+	case WDIOC_SETOPTIONS:
+		if (get_user (new_options, (int *) arg))
+			return -EFAULT;
 
-		/* lock the SuperIO chip */
-		outb(0xAA,0x370);
+		if (new_options & WDIOS_DISABLECARD) {
+			wdt977_stop();
+			retval = 0;
+		}
 
-		/* return info if "expired" in test mode */
-		return put_user(temp & 1, (int *) arg);
+		if (new_options & WDIOS_ENABLECARD) {
+			wdt977_start();
+			retval = 0;
+		}
 
-	case WDIOC_KEEPALIVE:
-		kick_wdog();
-		return 0;
+		return retval;
 
 	case WDIOC_SETTIMEOUT:
-		if (copy_from_user(&temp, (int *) arg, sizeof(int)))
+		if (get_user(new_timeout, (int *) arg))
 			return -EFAULT;
 
-		/* convert seconds to minutes, rounding up */
-		temp += 59;
-		temp /= 60;
-
-		/* we have a hw bug somewhere, so each 977 minute is actually only 30sec
-		*  this limits the max timeout to half of device max of 255 minutes...
-		*/
-		if (machine_is_netwinder())
-		{
-		    temp += temp;
-		}
+		if (wdt977_set_timeout(new_timeout))
+		    return -EINVAL;
 
-		/* Sanity check */
-		if (temp < 0 || temp > 255)
-			return -EINVAL;
+		wdt977_keepalive();
+		/* Fall */
 
-		if (!temp && nowayout)
-			return -EINVAL;
+	case WDIOC_GETTIMEOUT:
+		return put_user(timeout, (int *)arg);
 
-		timeoutM = temp;
-		kick_wdog();
-		return 0;
 	}
 }
 
+static int wdt977_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if(code==SYS_DOWN || code==SYS_HALT)
+		wdt977_stop();
+	return NOTIFY_DONE;
+}
 
 static struct file_operations wdt977_fops=
 {
@@ -345,21 +402,48 @@
 	.fops		= &wdt977_fops,
 };
 
+static struct notifier_block wdt977_notifier = {
+	.notifier_call = wdt977_notify_sys,
+};
+
 static int __init nwwatchdog_init(void)
 {
 	int retval;
 	if (!machine_is_netwinder())
 		return -ENODEV;
 
+	/* Check that the timeout value is within it's range ; if not reset to the default */
+	if (wdt977_set_timeout(timeout)) {
+		wdt977_set_timeout(DEFAULT_TIMEOUT);
+		printk(KERN_INFO PFX "timeout value must be 60<timeout<15300, using %d\n",
+			DEFAULT_TIMEOUT);
+	}
+
+	retval = register_reboot_notifier(&wdt977_notifier);
+	if (retval) {
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			retval);
+		return retval;
+	}
+
 	retval = misc_register(&wdt977_miscdev);
-	if (!retval)
-		printk(KERN_INFO "Wdt977 Watchdog sleeping.\n");
-	return retval;
+	if (retval) {
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, retval);
+		unregister_reboot_notifier(&wdt977_notifier);
+		return retval;
+	}
+
+	printk(KERN_INFO PFX "initialized. timeout=%d sec (nowayout=%d, testmode = %i)\n",
+		timeout, nowayout, testmode);
+
+	return 0;
 }
 
 static void __exit nwwatchdog_exit(void)
 {
 	misc_deregister(&wdt977_miscdev);
+	unregister_reboot_notifier(&wdt977_notifier);
 }
 
 module_init(nwwatchdog_init);
diff -Nru a/drivers/char/watchdog/advantechwdt.c b/drivers/char/watchdog/advantechwdt.c
--- a/drivers/char/watchdog/advantechwdt.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/advantechwdt.c	Sat Mar 13 23:58:44 2004
@@ -256,8 +256,6 @@
 
 static struct notifier_block advwdt_notifier = {
 	.notifier_call = advwdt_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 static int __init
diff -Nru a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
--- a/drivers/char/watchdog/alim1535_wdt.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/alim1535_wdt.c	Sat Mar 13 23:58:44 2004
@@ -385,8 +385,6 @@
 
 static struct notifier_block ali_notifier = {
 	.notifier_call =	ali_notify_sys,
-	.next =			NULL,
-	.priority =		0,
 };
 
 /*
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sat Mar 13 23:58:44 2004
@@ -303,8 +303,6 @@
 static struct notifier_block wdt_notifier=
 {
 	.notifier_call = wdt_notify_sys,
-	.next = 0,
-	.priority = 0,
 };
 
 static void __exit alim7101_wdt_unload(void)
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sat Mar 13 23:58:45 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sat Mar 13 23:58:45 2004
@@ -284,8 +284,6 @@
 
 static struct notifier_block ibwdt_notifier = {
 	.notifier_call = ibwdt_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 static int __init ibwdt_init(void)
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/machzwd.c	Sat Mar 13 23:58:44 2004
@@ -447,8 +447,6 @@
  */
 static struct notifier_block zf_notifier = {
 	.notifier_call = zf_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 static void __init zf_show_action(int act)
diff -Nru a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Sat Mar 13 23:58:44 2004
@@ -322,8 +322,6 @@
 static struct notifier_block wdt_notifier=
 {
 	.notifier_call = wdt_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 static void __exit sbc60xxwdt_unload(void)
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/sc520_wdt.c	Sat Mar 13 23:58:44 2004
@@ -354,8 +354,6 @@
 static struct notifier_block wdt_notifier=
 {
 	.notifier_call = wdt_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 static void __exit sc520_wdt_unload(void)
diff -Nru a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Sat Mar 13 23:58:44 2004
@@ -257,8 +257,6 @@
 
 static struct notifier_block wdt_notifier = {
 	.notifier_call = wdt_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 static int __init
diff -Nru a/drivers/char/watchdog/w83877f_wdt.c b/drivers/char/watchdog/w83877f_wdt.c
--- a/drivers/char/watchdog/w83877f_wdt.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/w83877f_wdt.c	Sat Mar 13 23:58:44 2004
@@ -341,8 +341,6 @@
 static struct notifier_block wdt_notifier=
 {
 	.notifier_call = wdt_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 static void __exit w83877f_wdt_unload(void)
diff -Nru a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Sat Mar 13 23:58:45 2004
+++ b/drivers/char/watchdog/wafer5823wdt.c	Sat Mar 13 23:58:45 2004
@@ -252,8 +252,6 @@
 
 static struct notifier_block wafwdt_notifier = {
 	.notifier_call = wafwdt_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 static int __init wafwdt_init(void)
diff -Nru a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c	Sat Mar 13 23:58:44 2004
+++ b/drivers/char/watchdog/wdt.c	Sat Mar 13 23:58:44 2004
@@ -459,8 +459,6 @@
 static struct notifier_block wdt_notifier=
 {
 	.notifier_call = wdt_notify_sys,
-	.next = NULL,
-	.priority = 0,
 };
 
 /**
