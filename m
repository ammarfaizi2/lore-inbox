Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263869AbUE1U3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUE1U3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUE1U3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:29:24 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:8894 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263869AbUE1U2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:28:53 -0400
Date: Fri, 28 May 2004 22:28:05 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.6 watchdog-patches
Message-ID: <20040528222805.A30061@infomag.infomag.iguana.be>
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

 drivers/char/watchdog/alim1535_wdt.c |    1 
 drivers/char/watchdog/alim7101_wdt.c |    1 
 drivers/char/watchdog/sc1200wdt.c    |    1 
 drivers/char/watchdog/sc520_wdt.c    |  257 +++++++++++++++++------------------
 drivers/char/watchdog/scx200_wdt.c   |    1 
 drivers/char/watchdog/w83627hf_wdt.c |    2 
 6 files changed, 133 insertions(+), 130 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/05/28 1.1757)
   [WATCHDOG] v2.6.6 w83627hf_wdt.c
   
   When drivers starts show the correct watchdog driver info.

<wim@iguana.be> (04/05/28 1.1758)
   [WATCHDOG] v2.6.6 sc520_wdt.c-patch1
   
   Clean-up (general stuff: comments, keep module parameters together, ...)
   Added clear definitions for the Watchdog Timer Control Register bits
   Made start, stop and keepalive return 0 if successful
   Fixed nowayout behaviour so that it is consistent with other watchdog drivers
   Fixed release behaviour so that it is consistent with other watchdog drivers
   Added wdt_set_heartbeat function to set the timeout/heartbeat of the watchdog
   Made sure that memory remapping (wdtmrctl) is done before misc_register is started
   MMCR_BASE_DEFAULT was wrong (Bug 2497 reported by Sean Young)
   
   Tested by Sean Young

<sean@mess.org> (04/05/28 1.1759)
   [WATCHDOG] v2.6.6 sc520_wdt.c-patch2
   
   This patch also removes the cbar usage which is unnecessary. The MMCR is
   always available at 0xfffef000; there is no need to use the cbar register
   (if mmcr aliasing is enabled, then the MMCR is _also_ available at
   another address set by CBAR).

<wim@iguana.be> (04/05/28 1.1760)
   [WATCHDOG] v2.6.6 linux/fs.h-patch
   
   From: Christoph Hellwig <hch@lst.de>
   
   All watchdog drivers need linux/fs.h


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c	Fri May 28 22:25:06 2004
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Fri May 28 22:25:06 2004
@@ -264,7 +264,7 @@
 {
 	int ret;
 
-	printk(KERN_INFO "WDT driver for Advantech single board computer initialising.\n");
+	printk(KERN_INFO "WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.\n");
 
 	if (timeout < 1 || timeout > 63) {
 		timeout = WATCHDOG_TIMEOUT;
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Fri May 28 22:25:31 2004
+++ b/drivers/char/watchdog/sc520_wdt.c	Fri May 28 22:25:31 2004
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
--- a/drivers/char/watchdog/sc520_wdt.c	Fri May 28 22:25:56 2004
+++ b/drivers/char/watchdog/sc520_wdt.c	Fri May 28 22:25:56 2004
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
diff -Nru a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
--- a/drivers/char/watchdog/alim1535_wdt.c	Fri May 28 22:26:21 2004
+++ b/drivers/char/watchdog/alim1535_wdt.c	Fri May 28 22:26:21 2004
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/fs.h>
 #include <linux/pci.h>
 
 #include <asm/uaccess.h>
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Fri May 28 22:26:21 2004
+++ b/drivers/char/watchdog/alim7101_wdt.c	Fri May 28 22:26:21 2004
@@ -24,6 +24,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/fs.h>
 #include <linux/pci.h>
 
 #include <asm/io.h>
diff -Nru a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
--- a/drivers/char/watchdog/sc1200wdt.c	Fri May 28 22:26:21 2004
+++ b/drivers/char/watchdog/sc1200wdt.c	Fri May 28 22:26:21 2004
@@ -38,6 +38,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/pnp.h>
+#include <linux/fs.h>
 #include <linux/pci.h>
 
 #include <asm/semaphore.h>
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	Fri May 28 22:26:21 2004
+++ b/drivers/char/watchdog/scx200_wdt.c	Fri May 28 22:26:21 2004
@@ -25,6 +25,7 @@
 #include <linux/watchdog.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
+#include <linux/fs.h>
 #include <linux/pci.h>
 #include <linux/scx200.h>
 
