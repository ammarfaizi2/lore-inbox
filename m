Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272943AbTHEQ7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272924AbTHEQ5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:57:05 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:42904 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S272903AbTHEQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:54:14 -0400
Date: Tue, 5 Aug 2003 18:53:43 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>, marekm@linux.org.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test2 - Watchdog patches (advantechwdt.c)
Message-ID: <20030805185342.A13467@infomag.infomag.iguana.be>
References: <20030805185058.A13304@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030805185058.A13304@infomag.infomag.iguana.be>; from wim@iguana.be on Tue, Aug 05, 2003 at 06:50:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached the diff for the below changeset.

Greetings,
Wim.

> Hi Linus,
> 
> please do a
> 
> 	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog
> 
> This will update the following files:
> 
>  drivers/char/watchdog/advantechwdt.c |  139 ++++++++++++++++++++---------------
>  1 files changed, 82 insertions(+), 57 deletions(-)
> 
> through these ChangeSets:
> 
> <wim@iguana.be> (03/08/05 1.1605)
>    [WATCHDOG] advantechwdt patches
>    
>    use module_param, removed __setup code,
>    general cleanup (mostly of comments and trailing spaces, also removed include of config.h),
>    made the watchdog's timeout a module_param.
> 
> 
> The ChangeSets can also be looked at on:
> 	http://linux-watchdog.bkbits.net:8080/linux-2.5-watchdog
> 
> Greetings,
> Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/advantechwdt.c b/drivers/char/watchdog/advantechwdt.c
--- a/drivers/char/watchdog/advantechwdt.c	Tue Aug  5 18:47:18 2003
+++ b/drivers/char/watchdog/advantechwdt.c	Tue Aug  5 18:47:18 2003
@@ -1,5 +1,5 @@
 /*
- *	Advantech Single Board Computer WDT driver for Linux 2.4.x
+ *	Advantech Single Board Computer WDT driver
  *
  *	(c) Copyright 2000-2001 Marek Michalkiewicz <marekm@linux.org.pl>
  *
@@ -22,10 +22,14 @@
  *
  *	14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
  *	    Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *
+ *	16-Oct-2002 Rob Radez <rob@osinvestor.com>
+ *	    Clean up ioctls, clean up init + exit, add expect close support,
+ *	    add wdt_start and wdt_stop as parameters.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
@@ -39,6 +43,9 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+#define WATCHDOG_NAME "Advantech WDT"
+#define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
+
 static unsigned long advwdt_is_open;
 static char adv_expect_close;
 
@@ -52,11 +59,18 @@
  *	the manual says wdt_stop is 0x43, not 0x443).
  *	(0x43 is also a write-only control register for the 8254 timer!)
  */
- 
+
 static int wdt_stop = 0x443;
+module_param(wdt_stop, int, 0);
+MODULE_PARM_DESC(wdt_stop, "Advantech WDT 'stop' io port (default 0x443)");
+
 static int wdt_start = 0x443;
+module_param(wdt_start, int, 0);
+MODULE_PARM_DESC(wdt_start, "Advantech WDT 'start' io port (default 0x443)");
 
-static int wd_margin = 60; /* 60 sec default timeout */
+static int timeout = WATCHDOG_TIMEOUT;	/* in seconds */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. 1<= timeout <=63, default=60.");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -64,44 +78,18 @@
 static int nowayout = 0;
 #endif
 
-MODULE_PARM(nowayout,"i");
+module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
  *	Kernel methods.
  */
 
-#ifndef MODULE
-
-static int __init adv_setup(char *str)
-{
-	int ints[4];
-
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-
-	if(ints[0] > 0){
-		wdt_stop = ints[1];
-		if(ints[0] > 1)
-			wdt_start = ints[2];
-	}
-
-	return 1;
-}
-
-__setup("advwdt=", adv_setup);
-
-#endif /* !MODULE */
-
-MODULE_PARM(wdt_stop, "i");
-MODULE_PARM_DESC(wdt_stop, "Advantech WDT 'stop' io port (default 0x443)");
-MODULE_PARM(wdt_start, "i");
-MODULE_PARM_DESC(wdt_start, "Advantech WDT 'start' io port (default 0x443)");
-
 static void
 advwdt_ping(void)
 {
 	/* Write a watchdog value */
-	outb_p(wd_margin, wdt_start);
+	outb_p(timeout, wdt_start);
 }
 
 static void
@@ -140,7 +128,7 @@
 advwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	  unsigned long arg)
 {
-	int new_margin;
+	int new_timeout;
 	static struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
@@ -162,16 +150,16 @@
 	  break;
 
 	case WDIOC_SETTIMEOUT:
-	  if (get_user(new_margin, (int *)arg))
+	  if (get_user(new_timeout, (int *)arg))
 		  return -EFAULT;
-	  if ((new_margin < 1) || (new_margin > 63))
+	  if ((new_timeout < 1) || (new_timeout > 63))
 		  return -EINVAL;
-	  wd_margin = new_margin;
+	  timeout = new_timeout;
 	  advwdt_ping();
 	  /* Fall */
 
 	case WDIOC_GETTIMEOUT:
-	  return put_user(wd_margin, (int *)arg);
+	  return put_user(timeout, (int *)arg);
 
 	case WDIOC_SETOPTIONS:
 	{
@@ -218,7 +206,7 @@
 	if (adv_expect_close == 42) {
 		advwdt_disable();
 	} else {
-		printk(KERN_CRIT "advancetechwdt: Unexpected close, not stopping watchdog!\n");
+		printk(KERN_CRIT WATCHDOG_NAME ": Unexpected close, not stopping watchdog!\n");
 		advwdt_ping();
 	}
 	clear_bit(0, &advwdt_is_open);
@@ -240,13 +228,14 @@
 	}
 	return NOTIFY_DONE;
 }
- 
+
 /*
  *	Kernel Interfaces
  */
- 
+
 static struct file_operations advwdt_fops = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= advwdt_write,
 	.ioctl		= advwdt_ioctl,
 	.open		= advwdt_open,
@@ -256,40 +245,76 @@
 static struct miscdevice advwdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
 	.name = "watchdog",
-	.fops = &advwdt_fops
+	.fops = &advwdt_fops,
 };
 
 /*
  *	The WDT needs to learn about soft shutdowns in order to
- *	turn the timebomb registers off. 
+ *	turn the timebomb registers off.
  */
- 
+
 static struct notifier_block advwdt_notifier = {
 	.notifier_call = advwdt_notify_sys,
 	.next = NULL,
-	.priority = 0
+	.priority = 0,
 };
 
 static int __init
 advwdt_init(void)
 {
+	int ret;
+
 	printk(KERN_INFO "WDT driver for Advantech single board computer initialising.\n");
 
-	if (misc_register(&advwdt_miscdev))
-		return -ENODEV;
-	if (wdt_stop != wdt_start)
-		if (!request_region(wdt_stop, 1, "Advantech WDT")) {
-			misc_deregister(&advwdt_miscdev);
-		return -EIO;
+	if (timeout < 1 || timeout > 63) {
+		timeout = WATCHDOG_TIMEOUT;
+		printk (KERN_INFO WATCHDOG_NAME ": timeout value must be 1<=x<=63, using %d\n",
+			timeout);
 	}
-	if (!request_region(wdt_start, 1, "Advantech WDT")) {
-		misc_deregister(&advwdt_miscdev);
-		if (wdt_stop != wdt_start)
-			release_region(wdt_stop, 1);
-		return -EIO;
+
+	if (wdt_stop != wdt_start) {
+		if (!request_region(wdt_stop, 1, WATCHDOG_NAME)) {
+			printk (KERN_ERR WATCHDOG_NAME ": I/O address 0x%04x already in use\n",
+				wdt_stop);
+			ret = -EIO;
+			goto out;
+		}
 	}
-	register_reboot_notifier(&advwdt_notifier);
-	return 0;
+
+	if (!request_region(wdt_start, 1, WATCHDOG_NAME)) {
+		printk (KERN_ERR WATCHDOG_NAME ": I/O address 0x%04x already in use\n",
+			wdt_start);
+		ret = -EIO;
+		goto unreg_stop;
+	}
+
+	ret = register_reboot_notifier(&advwdt_notifier);
+	if (ret != 0) {
+		printk (KERN_ERR WATCHDOG_NAME ": cannot register reboot notifier (err=%d)\n",
+			ret);
+		goto unreg_regions;
+	}
+
+	ret = misc_register(&advwdt_miscdev);
+	if (ret != 0) {
+		printk (KERN_ERR WATCHDOG_NAME ": cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto unreg_reboot;
+	}
+
+	printk (KERN_INFO WATCHDOG_NAME ": initialized. timeout=%d sec (nowayout=%d)\n",
+		timeout, nowayout);
+
+out:
+	return ret;
+unreg_reboot:
+	unregister_reboot_notifier(&advwdt_notifier);
+unreg_regions:
+	release_region(wdt_start, 1);
+unreg_stop:
+	if (wdt_stop != wdt_start)
+		release_region(wdt_stop, 1);
+	goto out;
 }
 
 static void __exit
