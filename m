Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315364AbSDWXOi>; Tue, 23 Apr 2002 19:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315368AbSDWXOh>; Tue, 23 Apr 2002 19:14:37 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:44552 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S315364AbSDWXOf>;
	Tue, 23 Apr 2002 19:14:35 -0400
Date: Tue, 23 Apr 2002 19:14:30 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/char/acquirewdt.c
Message-ID: <Pine.LNX.4.33.0204231907580.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the first of many against 2.4.19-pre7 that starts updating
the watchdog drivers to some degree of similarity.  The attached patch
against drivers/char/acquirewdt.c:
	-cleans up some #includes
	-closes a small race
	-adds expect_close support
	-makes it possible to set the io ports at runtime
	-gets rid of some useless code
	-adds ioctls to bring it up to the updated API
	-adds printk and MODULE_* tags
	-gets rid of unneeded locking

If this looks ok to you, I can start slowly feeding you the rest of the
driver and documentation updates.

Regards,
Rob Radez

--- linux-2.4.19-pre7/drivers/char/acquirewdt.c	Tue Apr 16 13:18:17 2002
+++ watchdog-tree/drivers/char/acquirewdt.c	Sat Apr 20 18:40:47 2002
@@ -21,47 +21,68 @@

 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
-#include <linux/slab.h>
 #include <linux/ioport.h>
-#include <linux/fcntl.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/smp_lock.h>

-static int acq_is_open;
-static spinlock_t acq_lock;
+static unsigned long acq_is_open;
+static char acq_expect_close;

 /*
  *	You must set these - there is no sane way to probe for this board.
  */

-#define WDT_STOP 0x43
-#define WDT_START 0x443
-
-#define WD_TIMO (100*60)		/* 1 minute */
-
+static int wdt_stop = 0x43;
+static int wdt_start = 0x443;

 /*
  *	Kernel methods.
  */
+
+#ifndef MODULE
+
+static int __init acq_setup(char *str)
+{
+	int ints[4];
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);

+	if(ints[0] > 0){
+		wdt_stop = ints[1];
+		if(ints[0] > 1)
+			wdt_start = ints[2];
+	}
+
+	return 1;
+}
+
+__setup("acqwdt=", acq_setup);
+
+#endif /* !MODULE */
+
+MODULE_PARM(wdt_stop, "i");
+MODULE_PARM_DESC(wdt_stop, "Acquire WDT 'stop' io port (default 0x43)");
+MODULE_PARM(wdt_start, "i");
+MODULE_PARM_DESC(wdt_start, "Acquire WDT 'start' io port (default 0x443)");

 static void acq_ping(void)
 {
 	/* Write a watchdog value */
-	inb_p(WDT_START);
+	inb_p(wdt_start);
+}
+
+static void acq_disable(void)
+{
+	inb_p(wdt_stop);
 }

 static ssize_t acq_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
@@ -72,25 +93,30 @@

 	if(count)
 	{
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+		size_t i;
+
+		acq_expect_close = 0;
+
+		for(i = 0; i != count; i++)
+		{
+			if(buf[i] == 'V')
+				acq_expect_close = 42;
+		}
+#endif
 		acq_ping();
-		return 1;
 	}
-	return 0;
-}
-
-static ssize_t acq_read(struct file *file, char *buf, size_t count, loff_t *ppos)
-{
-	return -EINVAL;
+	return count;
 }

-
-
 static int acq_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
 	static struct watchdog_info ident=
 	{
-		WDIOF_KEEPALIVEPING, 1, "Acquire WDT"
+		options:		WDIOF_KEEPALIVEPING,
+		firmware_version:	0,
+		identity:		"Acquire WDT"
 	};

 	switch(cmd)
@@ -101,14 +127,38 @@
 	  break;

 	case WDIOC_GETSTATUS:
-	  if (copy_to_user((int *)arg, &acq_is_open,  sizeof(int)))
-	    return -EFAULT;
-	  break;
+	case WDIOC_GETBOOTSTATUS:
+	  return put_user(0, (int *)arg);

 	case WDIOC_KEEPALIVE:
 	  acq_ping();
 	  break;

+	case WDIOC_GETTIMEOUT:
+	  return put_user(0, (int *)arg);
+
+	case WDIOC_SETOPTIONS:
+	{
+	    int options, retval = -EINVAL;
+
+	    if (get_user(options, (int *)arg))
+	      return -EFAULT;
+
+	    if (options & WDIOS_DISABLECARD)
+	    {
+	      acq_disable();
+	      retval = 0;
+	    }
+
+	    if (options & WDIOS_ENABLECARD)
+	    {
+	      acq_ping();
+	      retval = 0;
+	    }
+
+	    return retval;
+	}
+
 	default:
 	  return -ENOTTY;
 	}
@@ -117,41 +167,27 @@

 static int acq_open(struct inode *inode, struct file *file)
 {
-	switch(MINOR(inode->i_rdev))
-	{
-		case WATCHDOG_MINOR:
-			spin_lock(&acq_lock);
-			if(acq_is_open)
-			{
-				spin_unlock(&acq_lock);
-				return -EBUSY;
-			}
-			/*
-			 *	Activate
-			 */
-
-			acq_is_open=1;
-			inb_p(WDT_START);
-			spin_unlock(&acq_lock);
-			return 0;
-		default:
-			return -ENODEV;
-	}
+	if(test_and_set_bit(0, &acq_is_open))
+		return -EBUSY;
+	/*
+	 *	Activate
+	 */
+
+	acq_ping(); /* A ping suffices to activate the watchdog */
+	return 0;
 }

 static int acq_close(struct inode *inode, struct file *file)
 {
-	lock_kernel();
-	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
+	if(acq_expect_close == 42)
 	{
-		spin_lock(&acq_lock);
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		inb_p(WDT_STOP);
-#endif
-		acq_is_open=0;
-		spin_unlock(&acq_lock);
+		acq_disable();
+	} else {
+		printk(KERN_CRIT "acquirewdt: Unexpected close, not stopping the watchdog!\n");
+		acq_ping();
 	}
-	unlock_kernel();
+	clear_bit(0, &acq_is_open);
+	acq_expect_close = 0;
 	return 0;
 }

@@ -165,7 +201,7 @@
 	if(code==SYS_DOWN || code==SYS_HALT)
 	{
 		/* Turn the card off */
-		inb_p(WDT_STOP);
+		acq_disable();
 	}
 	return NOTIFY_DONE;
 }
@@ -177,7 +213,7 @@

 static struct file_operations acq_fops = {
 	owner:		THIS_MODULE,
-	read:		acq_read,
+	llseek:		no_llseek,
 	write:		acq_write,
 	ioctl:		acq_ioctl,
 	open:		acq_open,
@@ -186,9 +222,9 @@

 static struct miscdevice acq_miscdev=
 {
-	WATCHDOG_MINOR,
-	"watchdog",
-	&acq_fops
+	minor:		WATCHDOG_MINOR,
+	name:		"watchdog",
+	fops:		&acq_fops,
 };


@@ -206,13 +242,13 @@

 static int __init acq_init(void)
 {
-	printk("WDT driver for Acquire single board computer initialising.\n");
+	printk(KERN_INFO "WDT driver for Acquire single board computer initialising.\n");

-	spin_lock_init(&acq_lock);
 	if (misc_register(&acq_miscdev))
 		return -ENODEV;
-	request_region(WDT_STOP, 1, "Acquire WDT");
-	request_region(WDT_START, 1, "Acquire WDT");
+	if(wdt_stop != wdt_start)
+		request_region(wdt_stop, 1, "Acquire WDT");
+	request_region(wdt_start, 1, "Acquire WDT");
 	register_reboot_notifier(&acq_notifier);
 	return 0;
 }
@@ -221,12 +257,15 @@
 {
 	misc_deregister(&acq_miscdev);
 	unregister_reboot_notifier(&acq_notifier);
-	release_region(WDT_STOP,1);
-	release_region(WDT_START,1);
+	if(wdt_stop != wdt_start)
+		release_region(wdt_stop,1);
+	release_region(wdt_start,1);
 }

 module_init(acq_init);
 module_exit(acq_exit);

 MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Unkown");
+MODULE_DESCRIPTION("Acquire Single Board Computer Watchdog Timer driver");
 EXPORT_NO_SYMBOLS;

