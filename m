Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTHJMxg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 08:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTHJMxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 08:53:36 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:48361 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263894AbTHJMxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 08:53:24 -0400
Date: Sun, 10 Aug 2003 14:52:28 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, steve@navaho.co.uk
Subject: [PATCH] 2.6.0-test3 - Watchdog patches (alim7101_wdt.c)
Message-ID: <20030810145228.A19259@infomag.infomag.iguana.be>
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

 drivers/char/watchdog/alim7101_wdt.c |  178 ++++++++++++++++++++++-------------
 1 files changed, 115 insertions(+), 63 deletions(-)

through these ChangeSets:

<wim@iguana.be> (03/08/10 1.1151)
   [WATCHDOG] alim7101_wdt.c patch
   
   cleanup comments and trailing spaces
   added extra printk's to report what problem occured
   added MODULE_DESCRIPTION

<wim@iguana.be> (03/08/10 1.1152)
   [WATCHDOG] alim7101_wdt.c patch2
   
   changed watchdog_info to correctly reflect what the driver offers
   added WDIOC_GETSTATUS, WDIOC_GETBOOTSTATUS and WDIOC_SETOPTIONS ioctls

<wim@iguana.be> (03/08/10 1.1153)
   [WATCHDOG] alim7101_wdt.c patch3
   
   added WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT ioctls
   made timeout (the emulated heartbeat) a module_param
   made the keepalive ping an internal subroutine


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.5-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sun Aug 10 14:43:48 2003
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sun Aug 10 14:43:48 2003
@@ -1,26 +1,11 @@
 /*
- *	ALi M7101 PMU Computer Watchdog Timer driver for Linux 2.4.x
+ *	ALi M7101 PMU Computer Watchdog Timer driver
  *
- *	Based on w83877f_wdt.c by Scott Jennings <management@oro.net>
+ *	Based on w83877f_wdt.c by Scott Jennings <linuxdrivers@oro.net>
  *	and the Cobalt kernel WDT timer driver by Tim Hockin
  *	                                      <thockin@cobaltnet.com>
  *
  *	(c)2002 Steve Hill <steve@navaho.co.uk>
- * 
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
  *
  *  This WDT driver is different from most other Linux WDT
  *  drivers in that the driver will ping the watchdog by itself,
@@ -30,6 +15,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/miscdevice.h>
@@ -38,7 +24,6 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
-#include <linux/moduleparam.h>
 #include <linux/pci.h>
 
 #include <asm/io.h>
@@ -46,6 +31,7 @@
 #include <asm/system.h>
 
 #define OUR_NAME "alim7101_wdt"
+#define PFX OUR_NAME ": "
 
 #define WDT_ENABLE 0x9C
 #define WDT_DISABLE 0x8C
@@ -79,7 +65,7 @@
 #else
 static int nowayout = 0;
 #endif
- 
+
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
@@ -90,25 +76,25 @@
 static void wdt_timer_ping(unsigned long data)
 {
 	/* If we got a heartbeat pulse within the WDT_US_INTERVAL
-	 * we agree to ping the WDT 
+	 * we agree to ping the WDT
 	 */
 	char	tmp;
 
-	if(time_before(jiffies, next_heartbeat)) 
+	if(time_before(jiffies, next_heartbeat))
 	{
 		/* Ping the WDT (this is actually a disarm/arm sequence) */
 		pci_read_config_byte(alim7101_pmu, 0x92, &tmp);
 		pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, (tmp & ~ALI_WDT_ARM));
 		pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, (tmp | ALI_WDT_ARM));
 	} else {
-		printk(KERN_INFO OUR_NAME ": Heartbeat lost! Will not ping the watchdog\n");
+		printk(KERN_WARNING PFX "Heartbeat lost! Will not ping the watchdog\n");
 	}
 	/* Re-set the timer interval */
 	timer.expires = jiffies + WDT_INTERVAL;
 	add_timer(&timer);
 }
 
-/* 
+/*
  * Utility routines
  */
 
@@ -133,11 +119,11 @@
 	wdt_change(WDT_ENABLE);
 
 	/* Start the timer */
-	timer.expires = jiffies + WDT_INTERVAL;	
+	timer.expires = jiffies + WDT_INTERVAL;
 	add_timer(&timer);
 
 
-	printk(KERN_INFO OUR_NAME ": Watchdog timer is now enabled.\n");  
+	printk(KERN_INFO PFX "Watchdog timer is now enabled.\n");
 }
 
 static void wdt_turnoff(void)
@@ -145,7 +131,7 @@
 	/* Stop the timer */
 	del_timer_sync(&timer);
 	wdt_change(WDT_DISABLE);
-	printk(KERN_INFO OUR_NAME ": Watchdog timer is now disabled...\n");
+	printk(KERN_INFO PFX "Watchdog timer is now disabled...\n");
 }
 
 /*
@@ -173,14 +159,13 @@
 				if (get_user(c, buf+ofs))
 					return -EFAULT;
 				if (c == 'V')
-					wdt_expect_close = 1;
+					wdt_expect_close = 42;
 			}
 		}
 		/* someone wrote to us, we should restart timer */
 		next_heartbeat = jiffies + WDT_HEARTBEAT;
-		return 1;
-	};
-	return 0;
+	}
+	return count;
 }
 
 static int fop_open(struct inode * inode, struct file * file)
@@ -195,12 +180,13 @@
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-	if(wdt_expect_close)
+	if(wdt_expect_close == 42)
 		wdt_turnoff();
-	else
-		printk(KERN_INFO OUR_NAME ": device file closed unexpectedly. Will not stop the WDT!\n");
-
+	else {
+		printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
+	}
 	clear_bit(0, &wdt_is_open);
+	wdt_expect_close = 0;
 	return 0;
 }
 
@@ -210,9 +196,9 @@
 	{
 		.options = WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
-		.identity = "ALiM7101"
+		.identity = "ALiM7101",
 	};
-	
+
 	switch(cmd)
 	{
 		case WDIOC_GETSUPPORT:
@@ -231,13 +217,13 @@
 	.write=		fop_write,
 	.open=		fop_open,
 	.release=	fop_close,
-	.ioctl=		fop_ioctl
+	.ioctl=		fop_ioctl,
 };
 
 static struct miscdevice wdt_miscdev = {
 	.minor=WATCHDOG_MINOR,
 	.name="watchdog",
-	.fops=&wdt_fops
+	.fops=&wdt_fops,
 };
 
 /*
@@ -256,21 +242,21 @@
 		 * reboot with no heartbeat
 		 */
 		wdt_change(WDT_ENABLE);
-		printk(KERN_INFO OUR_NAME ": Watchdog timer is now enabled with no heartbeat - should reboot in ~1 second.\n");
+		printk(KERN_INFO PFX "Watchdog timer is now enabled with no heartbeat - should reboot in ~1 second.\n");
 	}
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
 	.next = 0,
-	.priority = 0
+	.priority = 0,
 };
 
 static void __exit alim7101_wdt_unload(void)
@@ -287,10 +273,10 @@
 	struct pci_dev *ali1543_south;
 	char tmp;
 
-	printk(KERN_INFO OUR_NAME ": Steve Hill <steve@navaho.co.uk>.\n");
+	printk(KERN_INFO PFX "Steve Hill <steve@navaho.co.uk>.\n");
 	alim7101_pmu = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,NULL);
 	if (!alim7101_pmu) {
-		printk(KERN_INFO OUR_NAME ": ALi M7101 PMU not present - WDT not set\n");
+		printk(KERN_INFO PFX "ALi M7101 PMU not present - WDT not set\n");
 		return -EBUSY;
 	}
 
@@ -299,12 +285,12 @@
 
 	ali1543_south = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
 	if (!ali1543_south) {
-		printk(KERN_INFO OUR_NAME ": ALi 1543 South-Bridge not present - WDT not set\n");
+		printk(KERN_INFO PFX "ALi 1543 South-Bridge not present - WDT not set\n");
 		return -EBUSY;
 	}
 	pci_read_config_byte(ali1543_south, 0x5e, &tmp);
 	if ((tmp & 0x1e) != 0x12) {
-		printk(KERN_INFO OUR_NAME ": ALi 1543 South-Bridge does not have the correct revision number (???1001?) - WDT not set\n");
+		printk(KERN_INFO PFX "ALi 1543 South-Bridge does not have the correct revision number (???1001?) - WDT not set\n");
 		return -EBUSY;
 	}
 
@@ -313,21 +299,32 @@
 	timer.data = 1;
 
 	rc = misc_register(&wdt_miscdev);
-	if (rc)
-		return rc;
+	if (rc) {
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			wdt_miscdev.minor, rc);
+		goto err_out;
+	}
 
 	rc = register_reboot_notifier(&wdt_notifier);
 	if (rc) {
-		misc_deregister(&wdt_miscdev);
-		return rc;
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			rc);
+		goto err_out_miscdev;
 	}
 
-	printk(KERN_INFO OUR_NAME ": WDT driver for ALi M7101 initialised.\n");
+	printk(KERN_INFO PFX "WDT driver for ALi M7101 initialised. (nowayout=%d)\n",
+		nowayout);
 	return 0;
+
+err_out_miscdev:
+	misc_deregister(&wdt_miscdev);
+err_out:
+        return rc;
 }
 
 module_init(alim7101_wdt_init);
 module_exit(alim7101_wdt_unload);
 
 MODULE_AUTHOR("Steve Hill");
+MODULE_DESCRIPTION("ALi M7101 PMU Computer Watchdog Timer driver");
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sun Aug 10 14:44:07 2003
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sun Aug 10 14:44:07 2003
@@ -57,7 +57,7 @@
 static struct timer_list timer;
 static unsigned long next_heartbeat;
 static unsigned long wdt_is_open;
-static int wdt_expect_close;
+static char wdt_expect_close;
 static struct pci_dev *alim7101_pmu;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -144,7 +144,7 @@
 	if(ppos != &file->f_pos)
 		return -ESPIPE;
 
-	/* See if we got the magic character */
+	/* See if we got the magic character 'V' and reload the timer */
 	if(count) {
 		if (!nowayout) {
 			size_t ofs;
@@ -183,6 +183,7 @@
 	if(wdt_expect_close == 42)
 		wdt_turnoff();
 	else {
+		/* wim: shouldn't there be a: del_timer(&timer); */
 		printk(KERN_CRIT PFX "device file closed unexpectedly. Will not stop the WDT!\n");
 	}
 	clear_bit(0, &wdt_is_open);
@@ -194,7 +195,7 @@
 {
 	static struct watchdog_info ident =
 	{
-		.options = WDIOF_MAGICCLOSE,
+		.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
 		.identity = "ALiM7101",
 	};
@@ -203,11 +204,33 @@
 	{
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
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 	}
 }
 
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sun Aug 10 14:44:27 2003
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sun Aug 10 14:44:27 2003
@@ -51,7 +51,10 @@
  * char to /dev/watchdog every 30 seconds.
  */
 
-#define WDT_HEARTBEAT (HZ * 30)
+#define WATCHDOG_TIMEOUT 30            /* 30 sec default timeout */
+static int timeout = WATCHDOG_TIMEOUT; /* in seconds, will be multiplied by HZ to get seconds to wait for a ping */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. (1<=timeout<=3600, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
 static void wdt_timer_ping(unsigned long);
 static struct timer_list timer;
@@ -111,7 +114,7 @@
 
 static void wdt_startup(void)
 {
-	next_heartbeat = jiffies + WDT_HEARTBEAT;
+	next_heartbeat = jiffies + (timeout * HZ);
 
 	/* We must enable before we kick off the timer in case the timer
 	   occurs as we ping it */
@@ -134,6 +137,12 @@
 	printk(KERN_INFO PFX "Watchdog timer is now disabled...\n");
 }
 
+static void wdt_keepalive(void)
+{
+	/* user land ping */
+	next_heartbeat = jiffies + (timeout * HZ);
+}
+
 /*
  * /dev/watchdog handling
  */
@@ -163,7 +172,7 @@
 			}
 		}
 		/* someone wrote to us, we should restart timer */
-		next_heartbeat = jiffies + WDT_HEARTBEAT;
+		wdt_keepalive();
 	}
 	return count;
 }
@@ -195,7 +204,7 @@
 {
 	static struct watchdog_info ident =
 	{
-		.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
 		.identity = "ALiM7101",
 	};
@@ -208,7 +217,7 @@
 		case WDIOC_GETBOOTSTATUS:
 			return put_user(0, (int *)arg);
 		case WDIOC_KEEPALIVE:
-			next_heartbeat = jiffies + WDT_HEARTBEAT;
+			wdt_keepalive();
 			return 0;
 		case WDIOC_SETOPTIONS:
 		{
@@ -229,6 +238,22 @@
 
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
 		default:
 			return -ENOIOCTLCMD;
 	}
@@ -317,6 +342,13 @@
 		return -EBUSY;
 	}
 
+	if(timeout < 1 || timeout > 3600) /* arbitrary upper limit */
+	{
+		timeout = WATCHDOG_TIMEOUT;
+		printk(KERN_INFO PFX "timeout value must be 1<=x<=3600, using %d\n",
+			timeout);
+	}
+
 	init_timer(&timer);
 	timer.function = wdt_timer_ping;
 	timer.data = 1;
@@ -335,8 +367,8 @@
 		goto err_out_miscdev;
 	}
 
-	printk(KERN_INFO PFX "WDT driver for ALi M7101 initialised. (nowayout=%d)\n",
-		nowayout);
+	printk(KERN_INFO PFX "WDT driver for ALi M7101 initialised. timeout=%d sec (nowayout=%d)\n",
+		timeout, nowayout);
 	return 0;
 
 err_out_miscdev:
