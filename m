Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTHJKqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 06:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTHJKqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 06:46:25 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:49036 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263062AbTHJKqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 06:46:07 -0400
Date: Sun, 10 Aug 2003 12:45:31 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxdrivers@oro.net
Subject: [PATCH] 2.6.0-test3 - Watchdog patches (sc520_wdt.c)
Message-ID: <20030810124531.A18394@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog

This will update the following files:

 drivers/char/watchdog/sc520_wdt.c |  248 +++++++++++++++++++++++---------------
 1 files changed, 153 insertions(+), 95 deletions(-)

through these ChangeSets:

<wim@iguana.be> (03/08/10 1.1145.1.1)
   [WATCHDOG] sc520_wdt.c patch
   
   cleanup comments and trailing spaces
   add KERN_* tags to printks
   added extra printk's to report what problem occured

<wim@iguana.be> (03/08/10 1.1145.1.2)
   [WATCHDOG] sc520_wdt.c patch2
   
   changed watchdog_info to correctly reflect what the driver offers
   added WDIOC_GETSTATUS, WDIOC_GETBOOTSTATUS and WDIOC_SETOPTIONS ioctls

<wim@iguana.be> (03/08/10 1.1145.1.3)
   [WATCHDOG] sc520_wdt.c patch3
   
   added WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT ioctls
   made timeout (the emulated heartbeat) a module_param
   made the keepalive ping an internal subroutine


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.5-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Sun Aug 10 12:09:36 2003
+++ b/drivers/char/watchdog/sc520_wdt.c	Sun Aug 10 12:09:36 2003
@@ -1,21 +1,21 @@
 /*
- *	AMD Elan SC520 processor Watchdog Timer driver for Linux 2.4.x
+ *	AMD Elan SC520 processor Watchdog Timer driver
  *
  *      Based on acquirewdt.c by Alan Cox,
- *           and sbc60xxwdt.c by Jakob Oestergaard <jakob@ostenfeld.dk>
- *     
+ *           and sbc60xxwdt.c by Jakob Oestergaard <jakob@unthought.net>
+ *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
- *	The authors do NOT admit liability nor provide warranty for 
- *	any of this software. This material is provided "AS-IS" in 
+ *
+ *	The authors do NOT admit liability nor provide warranty for
+ *	any of this software. This material is provided "AS-IS" in
  *      the hope that it may be useful for others.
  *
  *	(c) Copyright 2001    Scott Jennings <linuxdrivers@oro.net>
  *           9/27 - 2001      [Initial release]
- *	
+ *
  *	Additional fixes Alan Cox
  *	-	Fixed formatting
  *	-	Removed debug printks
@@ -24,20 +24,15 @@
  *	-	Used ioremap/writew/readw
  *	-	Added NOWAYOUT support
  *
- *  Theory of operation:
- *  A Watchdog Timer (WDT) is a hardware circuit that can 
- *  reset the computer system in case of a software fault.
- *  You probably knew that already.
- *
- *  Usually a userspace daemon will notify the kernel WDT driver
- *  via the /proc/watchdog special device file that userspace is
- *  still alive, at regular intervals.  When such a notification
- *  occurs, the driver will usually tell the hardware watchdog
- *  that everything is in order, and that the watchdog should wait
- *  for yet another little while to reset the system.
- *  If userspace fails (RAM error, kernel bug, whatever), the
- *  notifications cease to occur, and the hardware watchdog will
- *  reset the system (causing a reboot) after the timeout occurs.
+ *     4/12 - 2002 Changes by Rob Radez <rob@osinvestor.com>
+ *     -       Change comments
+ *     -       Eliminate fop_llseek
+ *     -       Change CONFIG_WATCHDOG_NOWAYOUT semantics
+ *     -       Add KERN_* tags to printks
+ *     09/8 - 2003 Changes by Wim Van Sebroeck <wim@iguana.be>
+ *     -       cleanup of trailing spaces
+ *     -       added extra printk's for startup problems
+ *     -       use module_param
  *
  *  This WDT driver is different from most other Linux WDT
  *  drivers in that the driver will ping the watchdog by itself,
@@ -95,6 +90,7 @@
 #define WDT_WRST_ENB 0x4000	/* [14] Watchdog Timer Reset Enable */
 
 #define OUR_NAME "sc520_wdt"
+#define PFX OUR_NAME ": "
 
 #define WRT_DOG(data) *wdtmrctl=data
 
@@ -123,9 +119,9 @@
 static void wdt_timer_ping(unsigned long data)
 {
 	/* If we got a heartbeat pulse within the WDT_US_INTERVAL
-	 * we agree to ping the WDT 
+	 * we agree to ping the WDT
 	 */
-	if(time_before(jiffies, next_heartbeat)) 
+	if(time_before(jiffies, next_heartbeat))
 	{
 		/* Ping the WDT */
 		spin_lock(&wdt_spinlock);
@@ -137,11 +133,11 @@
 		timer.expires = jiffies + WDT_INTERVAL;
 		add_timer(&timer);
 	} else {
-		printk(OUR_NAME ": Heartbeat lost! Will not ping the watchdog\n");
+		printk(KERN_WARNING PFX "Heartbeat lost! Will not ping the watchdog\n");
 	}
 }
 
-/* 
+/*
  * Utility routines
  */
 
@@ -168,11 +164,11 @@
 	next_heartbeat = jiffies + WDT_HEARTBEAT;
 
 	/* Start the timer */
-	timer.expires = jiffies + WDT_INTERVAL;	
+	timer.expires = jiffies + WDT_INTERVAL;
 	add_timer(&timer);
 
 	wdt_config(WDT_ENB | WDT_WRST_ENB | TIMEOUT_EXPONENT);
-	printk(OUR_NAME ": Watchdog timer is now enabled.\n");  
+	printk(KERN_INFO PFX "Watchdog timer is now enabled.\n");
 }
 
 static void wdt_turnoff(void)
@@ -181,7 +177,7 @@
 		/* Stop the timer */
 		del_timer(&timer);
 		wdt_config(0);
-		printk(OUR_NAME ": Watchdog timer is now disabled...\n");
+		printk(KERN_INFO PFX "Watchdog timer is now disabled...\n");
 	}
 }
 
@@ -197,7 +193,7 @@
 		return -ESPIPE;
 
 	/* See if we got the magic character */
-	if(count) 
+	if(count)
 	{
 		size_t ofs;
 
@@ -223,7 +219,7 @@
 
 static int fop_open(struct inode * inode, struct file * file)
 {
-	switch(minor(inode->i_rdev)) 
+	switch(minor(inode->i_rdev))
 	{
 		case WATCHDOG_MINOR:
 			/* Just in case we're already talking to someone... */
@@ -242,13 +238,13 @@
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-	if(minor(inode->i_rdev) == WATCHDOG_MINOR) 
+	if(minor(inode->i_rdev) == WATCHDOG_MINOR)
 	{
 		if(wdt_expect_close)
 			wdt_turnoff();
 		else {
 			del_timer(&timer);
-			printk(OUR_NAME ": device file closed unexpectedly. Will not stop the WDT!\n");
+			printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
 		}
 	}
 	clear_bit(0, &wdt_is_open);
@@ -262,9 +258,9 @@
 	{
 		.options = WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
-		.identity = "SC520"
+		.identity = "SC520",
 	};
-	
+
 	switch(cmd)
 	{
 		default:
@@ -283,13 +279,13 @@
 	.write		= fop_write,
 	.open		= fop_open,
 	.release	= fop_close,
-	.ioctl		= fop_ioctl
+	.ioctl		= fop_ioctl,
 };
 
 static struct miscdevice wdt_miscdev = {
 	.minor	= WATCHDOG_MINOR,
 	.name	= "watchdog",
-	.fops	= &wdt_fops
+	.fops	= &wdt_fops,
 };
 
 /*
@@ -299,21 +295,21 @@
 static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
 	void *unused)
 {
-	if(code==SYS_DOWN || code==SYS_HALT) 
+	if(code==SYS_DOWN || code==SYS_HALT)
 		wdt_turnoff();
 	return NOTIFY_DONE;
 }
- 
+
 /*
  *	The WDT needs to learn about soft shutdowns in order to
- *	turn the timebomb registers off. 
+ *	turn the timebomb registers off.
  */
- 
+
 static struct notifier_block wdt_notifier=
 {
 	.notifier_call = wdt_notify_sys,
 	.next = NULL,
-	.priority = 0
+	.priority = 0,
 };
 
 static void __exit sc520_wdt_unload(void)
@@ -339,21 +335,29 @@
 
 	rc = misc_register(&wdt_miscdev);
 	if (rc)
+	{
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			wdt_miscdev.minor, rc);
 		goto err_out_region2;
+	}
 
 	rc = register_reboot_notifier(&wdt_notifier);
 	if (rc)
+	{
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			rc);
 		goto err_out_miscdev;
+	}
 
 	/* get the Base Address Register */
 	cbar = inl_p(0xfffc);
-	printk(OUR_NAME ": CBAR: 0x%08lx\n", cbar);
+	printk(KERN_INFO PFX "CBAR: 0x%08lx\n", cbar);
 	/* check if MMCR aliasing bit is set */
 	if (cbar & 0x80000000) {
-		printk(OUR_NAME ": MMCR Aliasing enabled.\n");
+		printk(KERN_INFO PFX "MMCR Aliasing enabled.\n");
 		wdtmrctl = (__u16 *)(cbar & 0x3fffffff);
 	} else {
-		printk(OUR_NAME "!!! WARNING !!!\n"
+		printk(KERN_INFO PFX "!!! WARNING !!!\n"
 		  "\t MMCR Aliasing found NOT enabled!\n"
 		  "\t Using default value of: %p\n"
 		  "\t This has not been tested!\n"
@@ -366,7 +370,7 @@
 
 	wdtmrctl = (__u16 *)((char *)wdtmrctl + OFFS_WDTMRCTL);
 	wdtmrctl = ioremap((unsigned long)wdtmrctl, 2);
-	printk(KERN_INFO OUR_NAME ": WDT driver for SC520 initialised.\n");
+	printk(KERN_INFO PFX "WDT driver for SC520 initialised.\n");
 
 	return 0;
 
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Sun Aug 10 12:09:56 2003
+++ b/drivers/char/watchdog/sc520_wdt.c	Sun Aug 10 12:09:56 2003
@@ -29,6 +29,9 @@
  *     -       Eliminate fop_llseek
  *     -       Change CONFIG_WATCHDOG_NOWAYOUT semantics
  *     -       Add KERN_* tags to printks
+ *     -       fix possible wdt_is_open race
+ *     -       Report proper capabilities in watchdog_info
+ *     -       Add WDIOC_{GETSTATUS, GETBOOTSTATUS, SETOPTIONS} ioctls
  *     09/8 - 2003 Changes by Wim Van Sebroeck <wim@iguana.be>
  *     -       cleanup of trailing spaces
  *     -       added extra printk's for startup problems
@@ -100,7 +103,8 @@
 static struct timer_list timer;
 static unsigned long next_heartbeat;
 static unsigned long wdt_is_open;
-static int wdt_expect_close;
+static char wdt_expect_close;
+static spinlock_t wdt_spinlock;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -111,7 +115,6 @@
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
-static spinlock_t wdt_spinlock;
 /*
  *	Whack the dog
  */
@@ -192,62 +195,56 @@
 	if(ppos != &file->f_pos)
 		return -ESPIPE;
 
-	/* See if we got the magic character */
+	/* See if we got the magic character 'V' and reload the timer */
 	if(count)
 	{
-		size_t ofs;
-
-		/* note: just in case someone wrote the magic character
-		 * five months ago... */
-		wdt_expect_close = 0;
-
-		/* now scan */
-		for(ofs = 0; ofs != count; ofs++) {
-			char c;
-			if (get_user(c, buf + ofs))
-				return -EFAULT;
-			if(c == 'V')
-				wdt_expect_close = 1;
+		if (!nowayout)
+		{
+			size_t ofs;
+
+			/* note: just in case someone wrote the magic character
+			 * five months ago... */
+			wdt_expect_close = 0;
+
+			/* now scan */
+			for(ofs = 0; ofs != count; ofs++) {
+				char c;
+				if (get_user(c, buf + ofs))
+					return -EFAULT;
+				if(c == 'V')
+					wdt_expect_close = 42;
+			}
 		}
 
 		/* Well, anyhow someone wrote to us, we should return that favour */
 		next_heartbeat = jiffies + WDT_HEARTBEAT;
-		return 1;
 	}
-	return 0;
+	return count;
 }
 
 static int fop_open(struct inode * inode, struct file * file)
 {
-	switch(minor(inode->i_rdev))
-	{
-		case WATCHDOG_MINOR:
-			/* Just in case we're already talking to someone... */
-			if(test_and_set_bit(0, &wdt_is_open))
-				return -EBUSY;
-			/* Good, fire up the show */
-			wdt_startup();
-			if (nowayout)
-				__module_get(THIS_MODULE);
+	/* Just in case we're already talking to someone... */
+	if(test_and_set_bit(0, &wdt_is_open))
+		return -EBUSY;
+	if (nowayout)
+		__module_get(THIS_MODULE);
 
-			return 0;
-		default:
-			return -ENODEV;
-	}
+	/* Good, fire up the show */
+	wdt_startup();
+	return 0;
 }
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-	if(minor(inode->i_rdev) == WATCHDOG_MINOR)
-	{
-		if(wdt_expect_close)
-			wdt_turnoff();
-		else {
-			del_timer(&timer);
-			printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
-		}
+	if(wdt_expect_close == 42)
+		wdt_turnoff();
+	else {
+		del_timer(&timer);
+		printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
 	}
 	clear_bit(0, &wdt_is_open);
+	wdt_expect_close = 0;
 	return 0;
 }
 
@@ -256,7 +253,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		.options = WDIOF_MAGICCLOSE,
+		.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
 		.identity = "SC520",
 	};
@@ -267,9 +264,31 @@
 			return -ENOIOCTLCMD;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0, (int *)arg);
 		case WDIOC_KEEPALIVE:
 			next_heartbeat = jiffies + WDT_HEARTBEAT;
 			return 0;
+		case WDIOC_SETOPTIONS:
+		{
+			int new_options, retval = -EINVAL;
+
+			if(get_user(new_options, (int *)arg))
+				return -EFAULT;
+
+			if(new_options & WDIOS_DISABLECARD) {
+				wdt_turnoff();
+				retval = 0;
+			}
+
+			if(new_options & WDIOS_ENABLECARD) {
+				wdt_startup();
+				retval = 0;
+			}
+
+			return retval;
+		}
 	}
 }
 
@@ -370,7 +389,8 @@
 
 	wdtmrctl = (__u16 *)((char *)wdtmrctl + OFFS_WDTMRCTL);
 	wdtmrctl = ioremap((unsigned long)wdtmrctl, 2);
-	printk(KERN_INFO PFX "WDT driver for SC520 initialised.\n");
+	printk(KERN_INFO PFX "WDT driver for SC520 initialised. (nowayout=%d)\n",
+		nowayout);
 
 	return 0;
 
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	Sun Aug 10 12:10:19 2003
+++ b/drivers/char/watchdog/sc520_wdt.c	Sun Aug 10 12:10:19 2003
@@ -31,11 +31,14 @@
  *     -       Add KERN_* tags to printks
  *     -       fix possible wdt_is_open race
  *     -       Report proper capabilities in watchdog_info
- *     -       Add WDIOC_{GETSTATUS, GETBOOTSTATUS, SETOPTIONS} ioctls
+ *     -       Add WDIOC_{GETSTATUS, GETBOOTSTATUS, SETTIMEOUT,
+ *             GETTIMEOUT, SETOPTIONS} ioctls
  *     09/8 - 2003 Changes by Wim Van Sebroeck <wim@iguana.be>
  *     -       cleanup of trailing spaces
  *     -       added extra printk's for startup problems
  *     -       use module_param
+ *     -       made timeout (the emulated heartbeat) a module_param
+ *     -       made the keepalive ping an internal subroutine
  *
  *  This WDT driver is different from most other Linux WDT
  *  drivers in that the driver will ping the watchdog by itself,
@@ -75,7 +78,10 @@
  * char to /dev/watchdog every 30 seconds.
  */
 
-#define WDT_HEARTBEAT (HZ * 30)
+#define WATCHDOG_TIMEOUT 30		/* 30 sec default timeout */
+static int timeout = WATCHDOG_TIMEOUT;	/* in seconds, will be multiplied by HZ to get seconds to wait for a ping */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (1<=timeout<=3600, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
 /*
  * AMD Elan SC520 timeout value is 492us times a power of 2 (0-7)
@@ -164,7 +170,7 @@
 
 static void wdt_startup(void)
 {
-	next_heartbeat = jiffies + WDT_HEARTBEAT;
+	next_heartbeat = jiffies + (timeout * HZ);
 
 	/* Start the timer */
 	timer.expires = jiffies + WDT_INTERVAL;
@@ -184,6 +190,11 @@
 	}
 }
 
+static void wdt_keepalive(void)
+{
+	/* user land ping */
+	next_heartbeat = jiffies + (timeout * HZ);
+}
 
 /*
  * /dev/watchdog handling
@@ -217,7 +228,7 @@
 		}
 
 		/* Well, anyhow someone wrote to us, we should return that favour */
-		next_heartbeat = jiffies + WDT_HEARTBEAT;
+		wdt_keepalive();
 	}
 	return count;
 }
@@ -253,7 +264,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
 		.identity = "SC520",
 	};
@@ -268,7 +279,7 @@
 		case WDIOC_GETBOOTSTATUS:
 			return put_user(0, (int *)arg);
 		case WDIOC_KEEPALIVE:
-			next_heartbeat = jiffies + WDT_HEARTBEAT;
+			wdt_keepalive();
 			return 0;
 		case WDIOC_SETOPTIONS:
 		{
@@ -289,6 +300,22 @@
 
 			return retval;
 		}
+		case WDIOC_SETTIMEOUT:
+		{
+			int new_timeout;
+
+			if(get_user(new_timeout, (int *)arg))
+				return -EFAULT;
+
+			if(new_timeout < 1 || new_timeout > 3600) /* arbitrary upper limit */
+				return -EINVAL;
+
+			timeout = new_timeout;
+			wdt_keepalive();
+			/* Fall through */
+		}
+		case WDIOC_GETTIMEOUT:
+			return put_user(timeout, (int *)arg);
 	}
 }
 
@@ -348,6 +375,13 @@
 
 	spin_lock_init(&wdt_spinlock);
 
+	if(timeout < 1 || timeout > 3600) /* arbitrary upper limit */
+	{
+		timeout = WATCHDOG_TIMEOUT;
+		printk(KERN_INFO PFX "timeout value must be 1<=x<=3600, using %d\n",
+			timeout);
+	}
+
 	init_timer(&timer);
 	timer.function = wdt_timer_ping;
 	timer.data = 0;
@@ -389,8 +423,8 @@
 
 	wdtmrctl = (__u16 *)((char *)wdtmrctl + OFFS_WDTMRCTL);
 	wdtmrctl = ioremap((unsigned long)wdtmrctl, 2);
-	printk(KERN_INFO PFX "WDT driver for SC520 initialised. (nowayout=%d)\n",
-		nowayout);
+	printk(KERN_INFO PFX "WDT driver for SC520 initialised. timeout=%d sec (nowayout=%d)\n",
+		timeout,nowayout);
 
 	return 0;
 
