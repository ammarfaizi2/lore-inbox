Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287868AbSAVB0d>; Mon, 21 Jan 2002 20:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287918AbSAVB0U>; Mon, 21 Jan 2002 20:26:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29458 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287868AbSAVB0K>;
	Mon, 21 Jan 2002 20:26:10 -0500
Date: Tue, 22 Jan 2002 01:26:09 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] WDIOC_SETTIMEOUT for 2.5.2
Message-ID: <20020122012608.T1929@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
	Here's the WDIOC_SETTIMEOUT patch against 2.5.2.

Joel


diff -uNr linux-2.5.2/drivers/char/advantechwdt.c linux-2.5.2-wd/drivers/char/advantechwdt.c
--- linux-2.5.2/drivers/char/advantechwdt.c	Thu Jan  3 12:20:10 2002
+++ linux-2.5.2-wd/drivers/char/advantechwdt.c	Mon Jan 21 16:51:19 2002
@@ -64,6 +64,7 @@
 #define WDT_START 0x443
 
 #define WD_TIMO 60		/* 1 minute */
+static int wd_margin = WD_TIMO;
 
 /*
  *	Kernel methods.
@@ -73,7 +74,7 @@
 advwdt_ping(void)
 {
 	/* Write a watchdog value */
-	outb_p(WD_TIMO, WDT_START);
+	outb_p(wd_margin, WDT_START);
 }
 
 static ssize_t
@@ -100,8 +101,9 @@
 advwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	  unsigned long arg)
 {
+	int new_margin;
 	static struct watchdog_info ident = {
-		WDIOF_KEEPALIVEPING, 1, "Advantech WDT"
+		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT, 1, "Advantech WDT"
 	};
 	
 	switch (cmd) {
@@ -117,6 +119,19 @@
 
 	case WDIOC_KEEPALIVE:
 	  advwdt_ping();
+	  break;
+
+	case WDIOC_SETTIMEOUT:
+	  if (get_user(new_margin, (int *)arg))
+		  return -EFAULT;
+	  if ((new_margin < 1) || (new_margin > 63))
+		  return -EINVAL;
+	  wd_margin = new_margin;
+	  advwdt_ping();
+	  /* Fall */
+
+	case WDIOC_GETTIMEOUT:
+	  return put_user(wd_margin, (int *)arg);
 	  break;
 
 	default:
diff -uNr linux-2.5.2/drivers/char/eurotechwdt.c linux-2.5.2-wd/drivers/char/eurotechwdt.c
--- linux-2.5.2/drivers/char/eurotechwdt.c	Thu Jan  3 12:20:10 2002
+++ linux-2.5.2-wd/drivers/char/eurotechwdt.c	Mon Jan 21 16:51:19 2002
@@ -233,7 +233,7 @@
         unsigned int cmd, unsigned long arg)
 {
    static struct watchdog_info ident = {
-      options		: WDIOF_CARDRESET,
+      options		: WDIOF_CARDRESET | WDIOF_SETTIMEOUT,
       firmware_version	: 1,
       identity		: "WDT Eurotech CPU-1220/1410"
    };
@@ -265,7 +265,10 @@
 
          eurwdt_timeout = time; 
          eurwdt_set_timeout(time); 
-         return 0;
+	 /* Fall */
+
+      case WDIOC_GETTIMEOUT:
+	 return put_user(eurwdt_timeout, (int *)arg);
    }
 }
 
diff -uNr linux-2.5.2/drivers/char/i810-tco.c linux-2.5.2-wd/drivers/char/i810-tco.c
--- linux-2.5.2/drivers/char/i810-tco.c	Thu Sep 13 15:21:32 2001
+++ linux-2.5.2-wd/drivers/char/i810-tco.c	Mon Jan 21 16:51:19 2002
@@ -181,7 +181,7 @@
 	/*
 	 *      Shut off the timer.
 	 */
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
 	tco_timer_stop ();
 	timer_alive = 0;
 #endif	
@@ -208,8 +208,10 @@
 static int i810tco_ioctl (struct inode *inode, struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
+	int new_margin, u_margin;
+
 	static struct watchdog_info ident = {
-		0,
+		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 		0,
 		"i810 TCO timer"
 	};
@@ -229,6 +231,19 @@
 	case WDIOC_KEEPALIVE:
 		tco_timer_reload ();
 		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(u_margin, (int *) arg))
+			return -EFAULT;
+		new_margin = (u_margin * 10 + 5) / 6;
+		if ((new_margin < 3) || (new_margin > 63))
+			return -EINVAL;
+		if (tco_timer_settimer((unsigned char)new_margin))
+		    return -EINVAL;
+		i810_margin = new_margin;
+		tco_timer_reload();
+		/* Fall */
+	case WDIOC_GETTIMEOUT:
+		return put_user((int)(i810_margin * 6 / 10), (int *) arg);
 	}
 }
 
diff -uNr linux-2.5.2/drivers/char/ib700wdt.c linux-2.5.2-wd/drivers/char/ib700wdt.c
--- linux-2.5.2/drivers/char/ib700wdt.c	Thu Jan  3 12:20:10 2002
+++ linux-2.5.2-wd/drivers/char/ib700wdt.c	Mon Jan 21 16:51:19 2002
@@ -87,11 +87,34 @@
  *
  */
 
+static int wd_times[] = {
+	30,	/* 0x0 */
+	28,	/* 0x1 */
+	26,	/* 0x2 */
+	24,	/* 0x3 */
+	22,	/* 0x4 */
+	20,	/* 0x5 */
+	18,	/* 0x6 */
+	16,	/* 0x7 */
+	14,	/* 0x8 */
+	12,	/* 0x9 */
+	10,	/* 0xA */
+	8,	/* 0xB */
+	6,	/* 0xC */
+	4,	/* 0xD */
+	2,	/* 0xE */
+	0,	/* 0xF */
+};
+
 #define WDT_STOP 0x441
 #define WDT_START 0x443
 
+/* Default timeout */
 #define WD_TIMO 0		/* 30 seconds +/- 20%, from table */
 
+static int wd_margin = WD_TIMO;
+
+
 /*
  *	Kernel methods.
  */
@@ -100,7 +123,7 @@
 ibwdt_ping(void)
 {
 	/* Write a watchdog value */
-	outb_p(WD_TIMO, WDT_START);
+	outb_p(wd_times[wd_margin], WDT_START);
 }
 
 static ssize_t
@@ -127,8 +150,10 @@
 ibwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	  unsigned long arg)
 {
+	int i, new_margin;
+
 	static struct watchdog_info ident = {
-		WDIOF_KEEPALIVEPING, 1, "IB700 WDT"
+		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT, 1, "IB700 WDT"
 	};
 
 	switch (cmd) {
@@ -146,6 +171,22 @@
 	  ibwdt_ping();
 	  break;
 
+	case WDIOC_SETTIMEOUT:
+	  if (get_user(new_margin, (int *)arg))
+		  return -EFAULT;
+	  if ((new_margin < 0) || (new_margin > 30))
+		  return -EINVAL;
+	  for (i = 0x0F; i > -1; i--)
+		  if (wd_times[i] > new_margin)
+			  break;
+	  wd_margin = i;
+	  ibwdt_ping();
+	  /* Fall */
+
+	case WDIOC_GETTIMEOUT:
+	  return put_user(wd_times[wd_margin], (int *)arg);
+	  break;
+
 	default:
 	  return -ENOTTY;
 	}
@@ -182,7 +223,7 @@
 	if (minor(inode->i_rdev) == WATCHDOG_MINOR) {
 		spin_lock(&ibwdt_lock);
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
-		outb_p(WD_TIMO, WDT_STOP);
+		outb_p(wd_times[wd_margin], WDT_STOP);
 #endif
 		ibwdt_is_open = 0;
 		spin_unlock(&ibwdt_lock);
@@ -201,7 +242,7 @@
 {
 	if (code == SYS_DOWN || code == SYS_HALT) {
 		/* Turn the WDT off */
-		outb_p(WD_TIMO, WDT_STOP);
+		outb_p(wd_times[wd_margin], WDT_STOP);
 	}
 	return NOTIFY_DONE;
 }
diff -uNr linux-2.5.2/drivers/char/ib700wdt.c~ linux-2.5.2-wd/drivers/char/ib700wdt.c~
--- linux-2.5.2/drivers/char/ib700wdt.c~	Wed Dec 31 16:00:00 1969
+++ linux-2.5.2-wd/drivers/char/ib700wdt.c~	Thu Jan  3 12:20:10 2002
@@ -0,0 +1,272 @@
+/*
+ *	IB700 Single Board Computer WDT driver for Linux 2.4.x
+ *
+ *	(c) Copyright 2001 Charles Howes <chowes@vsol.net>
+ *
+ *      Based on advantechwdt.c which is based on acquirewdt.c which
+ *       is based on wdt.c.
+ *
+ *	(c) Copyright 2000-2001 Marek Michalkiewicz <marekm@linux.org.pl>
+ *
+ *	Based on acquirewdt.c which is based on wdt.c.
+ *	Original copyright messages:
+ *
+ *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
+ *				http://www.redhat.com
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
+ *
+ *	(c) Copyright 1995    Alan Cox <alan@redhat.com>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp_lock.h>
+
+static int ibwdt_is_open;
+static spinlock_t ibwdt_lock;
+
+/*
+ *
+ * Watchdog Timer Configuration
+ *
+ * The function of the watchdog timer is to reset the system
+ * automatically and is defined at I/O port 0443H.  To enable the
+ * watchdog timer and allow the system to reset, write I/O port 0443H.
+ * To disable the timer, write I/O port 0441H for the system to stop the
+ * watchdog function.  The timer has a tolerance of 20% for its
+ * intervals.
+ *
+ * The following describes how the timer should be programmed.
+ *
+ * Enabling Watchdog:
+ * MOV AX,000FH (Choose the values from 0 to F)
+ * MOV DX,0443H
+ * OUT DX,AX
+ *
+ * Disabling Watchdog:
+ * MOV AX,000FH (Any value is fine.)
+ * MOV DX,0441H
+ * OUT DX,AX
+ *
+ * Watchdog timer control table:
+ * Level   Value  Time/sec | Level Value Time/sec
+ *   1       F       0     |   9     7      16
+ *   2       E       2     |   10    6      18
+ *   3       D       4     |   11    5      20
+ *   4       C       6     |   12    4      22
+ *   5       B       8     |   13    3      24
+ *   6       A       10    |   14    2      26
+ *   7       9       12    |   15    1      28
+ *   8       8       14    |   16    0      30
+ *
+ */
+
+#define WDT_STOP 0x441
+#define WDT_START 0x443
+
+#define WD_TIMO 0		/* 30 seconds +/- 20%, from table */
+
+/*
+ *	Kernel methods.
+ */
+
+static void
+ibwdt_ping(void)
+{
+	/* Write a watchdog value */
+	outb_p(WD_TIMO, WDT_START);
+}
+
+static ssize_t
+ibwdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (count) {
+		ibwdt_ping();
+		return 1;
+	}
+	return 0;
+}
+
+static ssize_t
+ibwdt_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static int
+ibwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	  unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		WDIOF_KEEPALIVEPING, 1, "IB700 WDT"
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+	  if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
+	    return -EFAULT;
+	  break;
+
+	case WDIOC_GETSTATUS:
+	  if (copy_to_user((int *)arg, &ibwdt_is_open,  sizeof(int)))
+	    return -EFAULT;
+	  break;
+
+	case WDIOC_KEEPALIVE:
+	  ibwdt_ping();
+	  break;
+
+	default:
+	  return -ENOTTY;
+	}
+	return 0;
+}
+
+static int
+ibwdt_open(struct inode *inode, struct file *file)
+{
+	switch (minor(inode->i_rdev)) {
+		case WATCHDOG_MINOR:
+			spin_lock(&ibwdt_lock);
+			if (ibwdt_is_open) {
+				spin_unlock(&ibwdt_lock);
+				return -EBUSY;
+			}
+			/*
+			 *	Activate
+			 */
+
+			ibwdt_is_open = 1;
+			ibwdt_ping();
+			spin_unlock(&ibwdt_lock);
+			return 0;
+		default:
+			return -ENODEV;
+	}
+}
+
+static int
+ibwdt_close(struct inode *inode, struct file *file)
+{
+	lock_kernel();
+	if (minor(inode->i_rdev) == WATCHDOG_MINOR) {
+		spin_lock(&ibwdt_lock);
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+		outb_p(WD_TIMO, WDT_STOP);
+#endif
+		ibwdt_is_open = 0;
+		spin_unlock(&ibwdt_lock);
+	}
+	unlock_kernel();
+	return 0;
+}
+
+/*
+ *	Notifier for system down
+ */
+
+static int
+ibwdt_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		/* Turn the WDT off */
+		outb_p(WD_TIMO, WDT_STOP);
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct file_operations ibwdt_fops = {
+	owner:		THIS_MODULE,
+	read:		ibwdt_read,
+	write:		ibwdt_write,
+	ioctl:		ibwdt_ioctl,
+	open:		ibwdt_open,
+	release:	ibwdt_close,
+};
+
+static struct miscdevice ibwdt_miscdev = {
+	WATCHDOG_MINOR,
+	"watchdog",
+	&ibwdt_fops
+};
+
+/*
+ *	The WDT needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off.
+ */
+
+static struct notifier_block ibwdt_notifier = {
+	ibwdt_notify_sys,
+	NULL,
+	0
+};
+
+static int __init
+ibwdt_init(void)
+{
+	printk("WDT driver for IB700 single board computer initialising.\n");
+
+	spin_lock_init(&ibwdt_lock);
+	misc_register(&ibwdt_miscdev);
+#if WDT_START != WDT_STOP
+	request_region(WDT_STOP, 1, "IB700 WDT");
+#endif
+	request_region(WDT_START, 1, "IB700 WDT");
+	register_reboot_notifier(&ibwdt_notifier);
+	return 0;
+}
+
+static void __exit
+ibwdt_exit(void)
+{
+	misc_deregister(&ibwdt_miscdev);
+	unregister_reboot_notifier(&ibwdt_notifier);
+#if WDT_START != WDT_STOP
+	release_region(WDT_STOP,1);
+#endif
+	release_region(WDT_START,1);
+}
+
+module_init(ibwdt_init);
+module_exit(ibwdt_exit);
+
+MODULE_AUTHOR("Charles Howes <chowes@vsol.net>");
+MODULE_DESCRIPTION("IB700 SBC watchdog driver");
+MODULE_LICENSE("GPL");
+
+/* end of ib700wdt.c */
diff -uNr linux-2.5.2/drivers/char/softdog.c linux-2.5.2-wd/drivers/char/softdog.c
--- linux-2.5.2/drivers/char/softdog.c	Fri Nov 30 08:26:04 2001
+++ linux-2.5.2-wd/drivers/char/softdog.c	Mon Jan 21 16:51:19 2002
@@ -26,6 +26,11 @@
  *
  *  19980911 Alan Cox
  *	Made SMP safe for 2.3.x
+ *
+ *  20011127 Joel Becker (jlbec@evilplan.org>
+ *	Added soft_noboot; Allows testing the softdog trigger without 
+ *	requiring a recompile.
+ *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
  */
  
 #include <linux/module.h>
@@ -44,8 +49,14 @@
 #define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
 
 static int soft_margin = TIMER_MARGIN;	/* in seconds */
+#ifdef ONLY_TESTING
+static int soft_noboot = 1;
+#else
+static int soft_noboot = 0;
+#endif  /* ONLY_TESTING */
 
 MODULE_PARM(soft_margin,"i");
+MODULE_PARM(soft_noboot,"i");
 MODULE_LICENSE("GPL");
 
 /*
@@ -66,13 +77,14 @@
  
 static void watchdog_fire(unsigned long data)
 {
-#ifdef ONLY_TESTING
-		printk(KERN_CRIT "SOFTDOG: Would Reboot.\n");
-#else
-	printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n");
-	machine_restart(NULL);
-	printk("WATCHDOG: Reboot didn't ?????\n");
-#endif
+	if (soft_noboot)
+		printk(KERN_CRIT "SOFTDOG: Triggered - Reboot ignored.\n");
+	else
+	{
+		printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n");
+		machine_restart(NULL);
+		printk("SOFTDOG: Reboot didn't ?????\n");
+	}
 }
 
 /*
@@ -126,8 +138,11 @@
 static int softdog_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
+	int new_margin;
 	static struct watchdog_info ident = {
-		identity: "Software Watchdog",
+		WDIOF_SETTIMEOUT,
+		0,
+		"Software Watchdog"
 	};
 	switch (cmd) {
 		default:
@@ -142,6 +157,16 @@
 		case WDIOC_KEEPALIVE:
 			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
 			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, (int *)arg))
+				return -EFAULT;
+			if (new_margin < 1)
+				return -EINVAL;
+			soft_margin = new_margin;
+			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user(soft_margin, (int *)arg);
 	}
 }
 
diff -uNr linux-2.5.2/drivers/char/softdog.c~ linux-2.5.2-wd/drivers/char/softdog.c~
--- linux-2.5.2/drivers/char/softdog.c~	Wed Dec 31 16:00:00 1969
+++ linux-2.5.2-wd/drivers/char/softdog.c~	Fri Nov 30 08:26:04 2001
@@ -0,0 +1,184 @@
+/*
+ *	SoftDog	0.05:	A Software Watchdog Device
+ *
+ *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
+ *				http://www.redhat.com
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *	
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide 
+ *	warranty for any of this software. This material is provided 
+ *	"AS-IS" and at no charge.	
+ *
+ *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
+ *
+ *	Software only watchdog driver. Unlike its big brother the WDT501P
+ *	driver this won't always recover a failed machine.
+ *
+ *  03/96: Angelo Haritsis <ah@doc.ic.ac.uk> :
+ *	Modularised.
+ *	Added soft_margin; use upon insmod to change the timer delay.
+ *	NB: uses same minor as wdt (WATCHDOG_MINOR); we could use separate
+ *	    minors.
+ *
+ *  19980911 Alan Cox
+ *	Made SMP safe for 2.3.x
+ */
+ 
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+#define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
+
+static int soft_margin = TIMER_MARGIN;	/* in seconds */
+
+MODULE_PARM(soft_margin,"i");
+MODULE_LICENSE("GPL");
+
+/*
+ *	Our timer
+ */
+ 
+static void watchdog_fire(unsigned long);
+
+static struct timer_list watchdog_ticktock = {
+	function:	watchdog_fire,
+};
+static int timer_alive;
+
+
+/*
+ *	If the timer expires..
+ */
+ 
+static void watchdog_fire(unsigned long data)
+{
+#ifdef ONLY_TESTING
+		printk(KERN_CRIT "SOFTDOG: Would Reboot.\n");
+#else
+	printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n");
+	machine_restart(NULL);
+	printk("WATCHDOG: Reboot didn't ?????\n");
+#endif
+}
+
+/*
+ *	Allow only one person to hold it open
+ */
+ 
+static int softdog_open(struct inode *inode, struct file *file)
+{
+	if(timer_alive)
+		return -EBUSY;
+#ifdef CONFIG_WATCHDOG_NOWAYOUT	 
+	MOD_INC_USE_COUNT;
+#endif	
+	/*
+	 *	Activate timer
+	 */
+	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+	timer_alive=1;
+	return 0;
+}
+
+static int softdog_release(struct inode *inode, struct file *file)
+{
+	/*
+	 *	Shut off the timer.
+	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
+	 */
+#ifndef CONFIG_WATCHDOG_NOWAYOUT	 
+	del_timer(&watchdog_ticktock);
+#endif	
+	timer_alive=0;
+	return 0;
+}
+
+static ssize_t softdog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	/*
+	 *	Refresh the timer.
+	 */
+	if(len) {
+		mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+		return 1;
+	}
+	return 0;
+}
+
+static int softdog_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		identity: "Software Watchdog",
+	};
+	switch (cmd) {
+		default:
+			return -ENOTTY;
+		case WDIOC_GETSUPPORT:
+			if(copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
+				return -EFAULT;
+			return 0;
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0,(int *)arg);
+		case WDIOC_KEEPALIVE:
+			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+			return 0;
+	}
+}
+
+static struct file_operations softdog_fops = {
+	owner:		THIS_MODULE,
+	write:		softdog_write,
+	ioctl:		softdog_ioctl,
+	open:		softdog_open,
+	release:	softdog_release,
+};
+
+static struct miscdevice softdog_miscdev = {
+	minor:		WATCHDOG_MINOR,
+	name:		"watchdog",
+	fops:		&softdog_fops,
+};
+
+static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.05, timer margin: %d sec\n";
+
+static int __init watchdog_init(void)
+{
+	int ret;
+
+	ret = misc_register(&softdog_miscdev);
+
+	if (ret)
+		return ret;
+
+	printk(banner, soft_margin);
+
+	return 0;
+}
+
+static void __exit watchdog_exit(void)
+{
+	misc_deregister(&softdog_miscdev);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
diff -uNr linux-2.5.2/drivers/char/wdt.c linux-2.5.2-wd/drivers/char/wdt.c
--- linux-2.5.2/drivers/char/wdt.c	Thu Jan  3 12:20:10 2002
+++ linux-2.5.2-wd/drivers/char/wdt.c	Mon Jan 21 16:51:19 2002
@@ -27,6 +27,7 @@
  *		Tim Hockin	:	Added insmod parameters, comment cleanup
  *					Parameterized timeout
  *		Tigran Aivazian	:	Restructured wdt_init() to handle failures
+ *		Joel Becker	:	Added WDIOC_GET/SETTIMEOUT
  */
 
 #include <linux/config.h>
@@ -60,8 +61,11 @@
 static int io=0x240;
 static int irq=11;
 
+/* Default margin */
 #define WD_TIMO (100*60)		/* 1 minute */
 
+static int wd_margin = WD_TIMO;
+
 #ifndef MODULE
 
 /**
@@ -216,7 +220,7 @@
 	/* Write a watchdog value */
 	inb_p(WDT_DC);
 	wdt_ctr_mode(1,2);
-	wdt_ctr_load(1,WD_TIMO);		/* Timeout */
+	wdt_ctr_load(1,wd_margin);		/* Timeout */
 	outb_p(0, WDT_DC);
 }
 
@@ -294,10 +298,13 @@
 static int wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
+	int new_margin;
+
 	static struct watchdog_info ident=
 	{
 		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
-			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT,
+			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
+			|WDIOF_SETTIMEOUT,
 		1,
 		"WDT500/501"
 	};
@@ -317,6 +324,17 @@
 		case WDIOC_KEEPALIVE:
 			wdt_ping();
 			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, (int *)arg))
+				return -EFAULT;
+			/* Arbitrary, can't find the card's limits */
+			if ((new_margin < 0) || (new_margin > 60))
+				return -EINVAL;
+			wd_margin = new_margin * 100;
+			wdt_ping();
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user(wd_margin / 100, (int *)arg);
 	}
 }
 
@@ -348,7 +366,7 @@
 			wdt_ctr_mode(1,2);
 			wdt_ctr_mode(2,0);
 			wdt_ctr_load(0, 8948);		/* count at 100Hz */
-			wdt_ctr_load(1,WD_TIMO);	/* Timeout 120 seconds */
+			wdt_ctr_load(1,wd_margin);	/* Timeout 120 seconds */
 			wdt_ctr_load(2,65535);
 			outb_p(0, WDT_DC);	/* Enable */
 			return 0;
diff -uNr linux-2.5.2/drivers/char/wdt.c~ linux-2.5.2-wd/drivers/char/wdt.c~
--- linux-2.5.2/drivers/char/wdt.c~	Wed Dec 31 16:00:00 1969
+++ linux-2.5.2-wd/drivers/char/wdt.c~	Thu Jan  3 12:20:10 2002
@@ -0,0 +1,541 @@
+/*
+ *	Industrial Computer Source WDT500/501 driver for Linux 2.1.x
+ *
+ *	(c) Copyright 1996-1997 Alan Cox <alan@redhat.com>, All Rights Reserved.
+ *				http://www.redhat.com
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *	
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide 
+ *	warranty for any of this software. This material is provided 
+ *	"AS-IS" and at no charge.	
+ *
+ *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
+ *
+ *	Release 0.08.
+ *
+ *	Fixes
+ *		Dave Gregorich	:	Modularisation and minor bugs
+ *		Alan Cox	:	Added the watchdog ioctl() stuff
+ *		Alan Cox	:	Fixed the reboot problem (as noted by
+ *					Matt Crocker).
+ *		Alan Cox	:	Added wdt= boot option
+ *		Alan Cox	:	Cleaned up copy/user stuff
+ *		Tim Hockin	:	Added insmod parameters, comment cleanup
+ *					Parameterized timeout
+ *		Tigran Aivazian	:	Restructured wdt_init() to handle failures
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include "wd501p.h"
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+
+static unsigned long wdt_is_open;
+
+/*
+ *	You must set these - there is no sane way to probe for this board.
+ *	You can use wdt=x,y to set these now.
+ */
+ 
+static int io=0x240;
+static int irq=11;
+
+#define WD_TIMO (100*60)		/* 1 minute */
+
+#ifndef MODULE
+
+/**
+ *	wdt_setup:
+ *	@str: command line string
+ *
+ *	Setup options. The board isn't really probe-able so we have to
+ *	get the user to tell us the configuration. Sane people build it 
+ *	modular but the others come here.
+ */
+ 
+static int __init wdt_setup(char *str)
+{
+	int ints[4];
+
+	str = get_options (str, ARRAY_SIZE(ints), ints);
+
+	if (ints[0] > 0)
+	{
+		io = ints[1];
+		if(ints[0] > 1)
+			irq = ints[2];
+	}
+
+	return 1;
+}
+
+__setup("wdt=", wdt_setup);
+
+#endif /* !MODULE */
+
+MODULE_PARM(io, "i");
+MODULE_PARM_DESC(io, "WDT io port (default=0x240)");
+MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(irq, "WDT irq (default=11)");
+ 
+/*
+ *	Programming support
+ */
+ 
+static void wdt_ctr_mode(int ctr, int mode)
+{
+	ctr<<=6;
+	ctr|=0x30;
+	ctr|=(mode<<1);
+	outb_p(ctr, WDT_CR);
+}
+
+static void wdt_ctr_load(int ctr, int val)
+{
+	outb_p(val&0xFF, WDT_COUNT0+ctr);
+	outb_p(val>>8, WDT_COUNT0+ctr);
+}
+
+/*
+ *	Kernel methods.
+ */
+ 
+ 
+/**
+ *	wdt_status:
+ *	
+ *	Extract the status information from a WDT watchdog device. There are
+ *	several board variants so we have to know which bits are valid. Some
+ *	bits default to one and some to zero in order to be maximally painful.
+ *
+ *	we then map the bits onto the status ioctl flags.
+ */
+ 
+static int wdt_status(void)
+{
+	/*
+	 *	Status register to bit flags
+	 */
+	 
+	int flag=0;
+	unsigned char status=inb_p(WDT_SR);
+	status|=FEATUREMAP1;
+	status&=~FEATUREMAP2;	
+	
+	if(!(status&WDC_SR_TGOOD))
+		flag|=WDIOF_OVERHEAT;
+	if(!(status&WDC_SR_PSUOVER))
+		flag|=WDIOF_POWEROVER;
+	if(!(status&WDC_SR_PSUUNDR))
+		flag|=WDIOF_POWERUNDER;
+	if(!(status&WDC_SR_FANGOOD))
+		flag|=WDIOF_FANFAULT;
+	if(status&WDC_SR_ISOI0)
+		flag|=WDIOF_EXTERN1;
+	if(status&WDC_SR_ISII1)
+		flag|=WDIOF_EXTERN2;
+	return flag;
+}
+
+/**
+ *	wdt_interrupt:
+ *	@irq:		Interrupt number
+ *	@dev_id:	Unused as we don't allow multiple devices.
+ *	@regs:		Unused.
+ *
+ *	Handle an interrupt from the board. These are raised when the status
+ *	map changes in what the board considers an interesting way. That means
+ *	a failure condition occuring.
+ */
+ 
+void wdt_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	/*
+	 *	Read the status register see what is up and
+	 *	then printk it. 
+	 */
+	 
+	unsigned char status=inb_p(WDT_SR);
+	
+	status|=FEATUREMAP1;
+	status&=~FEATUREMAP2;	
+	
+	printk(KERN_CRIT "WDT status %d\n", status);
+	
+	if(!(status&WDC_SR_TGOOD))
+		printk(KERN_CRIT "Overheat alarm.(%d)\n",inb_p(WDT_RT));
+	if(!(status&WDC_SR_PSUOVER))
+		printk(KERN_CRIT "PSU over voltage.\n");
+	if(!(status&WDC_SR_PSUUNDR))
+		printk(KERN_CRIT "PSU under voltage.\n");
+	if(!(status&WDC_SR_FANGOOD))
+		printk(KERN_CRIT "Possible fan fault.\n");
+	if(!(status&WDC_SR_WCCR))
+#ifdef SOFTWARE_REBOOT
+#ifdef ONLY_TESTING
+		printk(KERN_CRIT "Would Reboot.\n");
+#else		
+		printk(KERN_CRIT "Initiating system reboot.\n");
+		machine_restart(NULL);
+#endif		
+#else
+		printk(KERN_CRIT "Reset in 5ms.\n");
+#endif		
+}
+
+
+/**
+ *	wdt_ping:
+ *
+ *	Reload counter one with the watchdog timeout. We don't bother reloading
+ *	the cascade counter. 
+ */
+ 
+static void wdt_ping(void)
+{
+	/* Write a watchdog value */
+	inb_p(WDT_DC);
+	wdt_ctr_mode(1,2);
+	wdt_ctr_load(1,WD_TIMO);		/* Timeout */
+	outb_p(0, WDT_DC);
+}
+
+/**
+ *	wdt_write:
+ *	@file: file handle to the watchdog
+ *	@buf: buffer to write (unused as data does not matter here 
+ *	@count: count of bytes
+ *	@ppos: pointer to the position to write. No seeks allowed
+ *
+ *	A write to a watchdog device is defined as a keepalive signal. Any
+ *	write of data will do, as we we don't define content meaning.
+ */
+ 
+static ssize_t wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if(count)
+	{
+		wdt_ping();
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ *	wdt_read:
+ *	@file: file handle to the watchdog board
+ *	@buf: buffer to write 1 byte into
+ *	@count: length of buffer
+ *	@ptr: offset (no seek allowed)
+ *
+ *	Read reports the temperature in degrees Fahrenheit. The API is in
+ *	farenheit. It was designed by an imperial measurement luddite.
+ */
+ 
+static ssize_t wdt_read(struct file *file, char *buf, size_t count, loff_t *ptr)
+{
+	unsigned short c=inb_p(WDT_RT);
+	unsigned char cp;
+	
+	/*  Can't seek (pread) on this device  */
+	if (ptr != &file->f_pos)
+		return -ESPIPE;
+
+	switch(minor(file->f_dentry->d_inode->i_rdev))
+	{
+		case TEMP_MINOR:
+			c*=11;
+			c/=15;
+			cp=c+7;
+			if(copy_to_user(buf,&cp,1))
+				return -EFAULT;
+			return 1;
+		default:
+			return -EINVAL;
+	}
+}
+
+/**
+ *	wdt_ioctl:
+ *	@inode: inode of the device
+ *	@file: file handle to the device
+ *	@cmd: watchdog command
+ *	@arg: argument pointer
+ *
+ *	The watchdog API defines a common set of functions for all watchdogs
+ *	according to their available features. We only actually usefully support
+ *	querying capabilities and current status. 
+ */
+ 
+static int wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	unsigned long arg)
+{
+	static struct watchdog_info ident=
+	{
+		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
+			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT,
+		1,
+		"WDT500/501"
+	};
+	
+	ident.options&=WDT_OPTION_MASK;	/* Mask down to the card we have */
+	switch(cmd)
+	{
+		default:
+			return -ENOTTY;
+		case WDIOC_GETSUPPORT:
+			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
+
+		case WDIOC_GETSTATUS:
+			return put_user(wdt_status(),(int *)arg);
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0, (int *)arg);
+		case WDIOC_KEEPALIVE:
+			wdt_ping();
+			return 0;
+	}
+}
+
+/**
+ *	wdt_open:
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ *	One of our two misc devices has been opened. The watchdog device is
+ *	single open and on opening we load the counters. Counter zero is a 
+ *	100Hz cascade, into counter 1 which downcounts to reboot. When the
+ *	counter triggers counter 2 downcounts the length of the reset pulse
+ *	which set set to be as long as possible. 
+ */
+ 
+static int wdt_open(struct inode *inode, struct file *file)
+{
+	switch(minor(inode->i_rdev))
+	{
+		case WATCHDOG_MINOR:
+			if(test_and_set_bit(0, &wdt_is_open))
+				return -EBUSY;
+			/*
+			 *	Activate 
+			 */
+	 
+			inb_p(WDT_DC);		/* Disable */
+			wdt_ctr_mode(0,3);
+			wdt_ctr_mode(1,2);
+			wdt_ctr_mode(2,0);
+			wdt_ctr_load(0, 8948);		/* count at 100Hz */
+			wdt_ctr_load(1,WD_TIMO);	/* Timeout 120 seconds */
+			wdt_ctr_load(2,65535);
+			outb_p(0, WDT_DC);	/* Enable */
+			return 0;
+		case TEMP_MINOR:
+			return 0;
+		default:
+			return -ENODEV;
+	}
+}
+
+/**
+ *	wdt_close:
+ *	@inode: inode to board
+ *	@file: file handle to board
+ *
+ *	The watchdog has a configurable API. There is a religious dispute 
+ *	between people who want their watchdog to be able to shut down and 
+ *	those who want to be sure if the watchdog manager dies the machine
+ *	reboots. In the former case we disable the counters, in the latter
+ *	case you have to open it again very soon.
+ */
+ 
+static int wdt_release(struct inode *inode, struct file *file)
+{
+	if(minor(inode->i_rdev)==WATCHDOG_MINOR)
+	{
+#ifndef CONFIG_WATCHDOG_NOWAYOUT	
+		inb_p(WDT_DC);		/* Disable counters */
+		wdt_ctr_load(2,0);	/* 0 length reset pulses now */
+#endif		
+		clear_bit(0, &wdt_is_open);
+	}
+	return 0;
+}
+
+/**
+ *	notify_sys:
+ *	@this: our notifier block
+ *	@code: the event being reported
+ *	@unused: unused
+ *
+ *	Our notifier is called on system shutdowns. We want to turn the card
+ *	off at reboot otherwise the machine will reboot again during memory
+ *	test or worse yet during the following fsck. This would suck, in fact
+ *	trust me - if it happens it does suck.
+ */
+
+static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if(code==SYS_DOWN || code==SYS_HALT)
+	{
+		/* Turn the card off */
+		inb_p(WDT_DC);
+		wdt_ctr_load(2,0);
+	}
+	return NOTIFY_DONE;
+}
+ 
+/*
+ *	Kernel Interfaces
+ */
+ 
+ 
+static struct file_operations wdt_fops = {
+	owner:		THIS_MODULE,
+	llseek:		no_llseek,
+	read:		wdt_read,
+	write:		wdt_write,
+	ioctl:		wdt_ioctl,
+	open:		wdt_open,
+	release:	wdt_release,
+};
+
+static struct miscdevice wdt_miscdev=
+{
+	WATCHDOG_MINOR,
+	"watchdog",
+	&wdt_fops
+};
+
+#ifdef CONFIG_WDT_501
+static struct miscdevice temp_miscdev=
+{
+	TEMP_MINOR,
+	"temperature",
+	&wdt_fops
+};
+#endif
+
+/*
+ *	The WDT card needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off. 
+ */
+ 
+static struct notifier_block wdt_notifier=
+{
+	wdt_notify_sys,
+	NULL,
+	0
+};
+
+/**
+ *	cleanup_module:
+ *
+ *	Unload the watchdog. You cannot do this with any file handles open.
+ *	If your watchdog is set to continue ticking on close and you unload
+ *	it, well it keeps ticking. We won't get the interrupt but the board
+ *	will not touch PC memory so all is fine. You just have to load a new
+ *	module in 60 seconds or reboot.
+ */
+ 
+static void __exit wdt_exit(void)
+{
+	misc_deregister(&wdt_miscdev);
+#ifdef CONFIG_WDT_501	
+	misc_deregister(&temp_miscdev);
+#endif	
+	unregister_reboot_notifier(&wdt_notifier);
+	release_region(io,8);
+	free_irq(irq, NULL);
+}
+
+/**
+ * 	wdt_init:
+ *
+ *	Set up the WDT watchdog board. All we have to do is grab the
+ *	resources we require and bitch if anyone beat us to them.
+ *	The open() function will actually kick the board off.
+ */
+ 
+static int __init wdt_init(void)
+{
+	int ret;
+
+	ret = misc_register(&wdt_miscdev);
+	if (ret) {
+		printk(KERN_ERR "wdt: can't misc_register on minor=%d\n", WATCHDOG_MINOR);
+		goto out;
+	}
+	ret = request_irq(irq, wdt_interrupt, SA_INTERRUPT, "wdt501p", NULL);
+	if(ret) {
+		printk(KERN_ERR "wdt: IRQ %d is not free.\n", irq);
+		goto outmisc;
+	}
+	if (!request_region(io, 8, "wdt501p")) {
+		printk(KERN_ERR "wdt: IO %X is not free.\n", io);
+		ret = -EBUSY;
+		goto outirq;
+	}
+	ret = register_reboot_notifier(&wdt_notifier);
+	if(ret) {
+		printk(KERN_ERR "wdt: can't register reboot notifier (err=%d)\n", ret);
+		goto outreg;
+	}
+
+#ifdef CONFIG_WDT_501
+	ret = misc_register(&temp_miscdev);
+	if (ret) {
+		printk(KERN_ERR "wdt: can't misc_register (temp) on minor=%d\n", TEMP_MINOR);
+		goto outrbt;
+	}
+#endif
+
+	ret = 0;
+	printk(KERN_INFO "WDT500/501-P driver 0.07 at %X (Interrupt %d)\n", io, irq);
+out:
+	return ret;
+
+#ifdef CONFIG_WDT_501
+outrbt:
+	unregister_reboot_notifier(&wdt_notifier);
+#endif
+
+outreg:
+	release_region(io,8);
+outirq:
+	free_irq(irq, NULL);
+outmisc:
+	misc_deregister(&wdt_miscdev);
+	goto out;
+}
+
+module_init(wdt_init);
+module_exit(wdt_exit);
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("Driver for ISA ICS watchdog cards (WDT500/501)");
+MODULE_LICENSE("GPL");
+EXPORT_NO_SYMBOLS;
diff -uNr linux-2.5.2/drivers/char/wdt285.c linux-2.5.2-wd/drivers/char/wdt285.c
--- linux-2.5.2/drivers/char/wdt285.c	Fri Nov 30 08:26:04 2001
+++ linux-2.5.2-wd/drivers/char/wdt285.c	Mon Jan 21 16:51:19 2002
@@ -124,10 +124,10 @@
 static int watchdog_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
-	int i;
+	int i, new_margin;
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_SETTIMEOUT,
 		0,
 		"Footbridge Watchdog"
 	};
@@ -147,6 +147,17 @@
 		case WDIOC_KEEPALIVE:
 			watchdog_ping();
 			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, (int *)arg))
+				return -EFAULT;
+			/* Arbitrary, can't find the card's limits */
+			if ((new_marg < 0) || (new_margin > 60))
+				return -EINVAL;
+			soft_margin = new_margin;
+			watchdog_ping();
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user(soft_margin, (int *)arg);
 	}
 }
 
diff -uNr linux-2.5.2/drivers/char/wdt285.c~ linux-2.5.2-wd/drivers/char/wdt285.c~
--- linux-2.5.2/drivers/char/wdt285.c~	Wed Dec 31 16:00:00 1969
+++ linux-2.5.2-wd/drivers/char/wdt285.c~	Fri Nov 30 08:26:04 2001
@@ -0,0 +1,197 @@
+/*
+ *	Intel 21285 watchdog driver
+ *	Copyright (c) Phil Blundell <pb@nexus.co.uk>, 1998
+ *
+ *	based on
+ *
+ *	SoftDog	0.05:	A Software Watchdog Device
+ *
+ *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *	
+ */
+ 
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/smp_lock.h>
+
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/hardware/dec21285.h>
+
+/*
+ * Define this to stop the watchdog actually rebooting the machine.
+ */
+#undef ONLY_TESTING
+
+#define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
+
+#define FCLK	(50*1000*1000)		/* 50MHz */
+
+static int soft_margin = TIMER_MARGIN;	/* in seconds */
+static int timer_alive;
+
+#ifdef ONLY_TESTING
+/*
+ *	If the timer expires..
+ */
+
+static void watchdog_fire(int irq, void *dev_id, struct pt_regs *regs)
+{
+	printk(KERN_CRIT "Watchdog: Would Reboot.\n");
+	*CSR_TIMER4_CNTL = 0;
+	*CSR_TIMER4_CLR = 0;
+}
+#endif
+
+static void watchdog_ping(void)
+{
+	/*
+	 *	Refresh the timer.
+	 */
+	*CSR_TIMER4_LOAD = soft_margin * (FCLK / 256);
+}
+
+/*
+ *	Allow only one person to hold it open
+ */
+ 
+static int watchdog_open(struct inode *inode, struct file *file)
+{
+	if(timer_alive)
+		return -EBUSY;
+	/*
+	 *	Ahead watchdog factor ten, Mr Sulu
+	 */
+	*CSR_TIMER4_CLR = 0;
+	watchdog_ping();
+	*CSR_TIMER4_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_AUTORELOAD 
+		| TIMER_CNTL_DIV256;
+#ifdef ONLY_TESTING
+	request_irq(IRQ_TIMER4, watchdog_fire, 0, "watchdog", NULL);
+#else
+	*CSR_SA110_CNTL |= 1 << 13;
+	MOD_INC_USE_COUNT;
+#endif
+	timer_alive = 1;
+	return 0;
+}
+
+static int watchdog_release(struct inode *inode, struct file *file)
+{
+#ifdef ONLY_TESTING
+	free_irq(IRQ_TIMER4, NULL);
+	timer_alive = 0;
+#else
+	/*
+	 *	It's irreversible!
+	 */
+#endif
+	return 0;
+}
+
+static ssize_t watchdog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	/*
+	 *	Refresh the timer.
+	 */
+	if(len)
+	{
+		watchdog_ping();
+		return 1;
+	}
+	return 0;
+}
+
+static int watchdog_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	int i;
+	static struct watchdog_info ident=
+	{
+		0,
+		0,
+		"Footbridge Watchdog"
+	};
+	switch(cmd)
+	{
+		default:
+			return -ENOTTY;
+		case WDIOC_GETSUPPORT:
+			i = verify_area(VERIFY_WRITE, (void*) arg, sizeof(struct watchdog_info));
+			if (i)
+				return i;
+			else
+				return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident));
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0,(int *)arg);
+		case WDIOC_KEEPALIVE:
+			watchdog_ping();
+			return 0;
+	}
+}
+
+static struct file_operations watchdog_fops=
+{
+	owner:		THIS_MODULE,
+	write:		watchdog_write,
+	ioctl:		watchdog_ioctl,
+	open:		watchdog_open,
+	release:	watchdog_release,
+};
+
+static struct miscdevice watchdog_miscdev=
+{
+	WATCHDOG_MINOR,
+	"watchdog",
+	&watchdog_fops
+};
+
+static int __init footbridge_watchdog_init(void)
+{
+	if (machine_is_netwinder())
+		return -ENODEV;
+
+	misc_register(&watchdog_miscdev);
+	printk("Footbridge Watchdog Timer: 0.01, timer margin: %d sec\n", 
+	       soft_margin);
+	if (machine_is_cats())
+		printk("Warning: Watchdog reset may not work on this machine.\n");
+	return 0;
+}
+
+static void __exit footbridge_watchdog_exit(void)
+{
+	misc_deregister(&watchdog_miscdev);
+}
+
+EXPORT_NO_SYMBOLS;
+
+MODULE_AUTHOR("Phil Blundell <pb@nexus.co.uk>");
+MODULE_DESCRIPTION("21285 watchdog driver");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(soft_margin,"i");
+MODULE_PARM_DESC(soft_margin,"Watchdog timeout in seconds");
+
+module_init(footbridge_watchdog_init);
+module_exit(footbridge_watchdog_exit);
diff -uNr linux-2.5.2/drivers/char/wdt_pci.c linux-2.5.2-wd/drivers/char/wdt_pci.c
--- linux-2.5.2/drivers/char/wdt_pci.c	Thu Jan  3 12:20:10 2002
+++ linux-2.5.2-wd/drivers/char/wdt_pci.c	Mon Jan 21 16:51:19 2002
@@ -30,6 +30,7 @@
  *		Alan Cox	:	Split ISA and PCI cards into two drivers
  *		Jeff Garzik	:	PCI cleanups
  *		Tigran Aivazian	:	Restructured wdtpci_init_one() to handle failures
+ *		Joel Becker	:	Added WDIOC_GET/SETTIMEOUT
  */
 
 #include <linux/config.h>
@@ -81,8 +82,11 @@
 static int io=0x240;
 static int irq=11;
 
+/* Default timeout */
 #define WD_TIMO (100*60)		/* 1 minute */
 
+static int wd_margin = WD_TIMO;
+
 #ifndef MODULE
 
 /**
@@ -232,7 +236,7 @@
 	/* Write a watchdog value */
 	inb_p(WDT_DC);
 	wdtpci_ctr_mode(1,2);
-	wdtpci_ctr_load(1,WD_TIMO);		/* Timeout */
+	wdtpci_ctr_load(1,wd_margin);		/* Timeout */
 	outb_p(0, WDT_DC);
 }
 
@@ -310,10 +314,12 @@
 static int wdtpci_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
+	int new_margin;
 	static struct watchdog_info ident=
 	{
 		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
-			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT,
+			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
+			|WDIOF_SETTIMEOUT,
 		1,
 		"WDT500/501PCI"
 	};
@@ -333,6 +339,17 @@
 		case WDIOC_KEEPALIVE:
 			wdtpci_ping();
 			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, (int *)arg))
+				return -EFAULT;
+			/* Arbitrary, can't find the card's limits */
+			if ((new_margin < 0) || (new_margin > 60))
+				return -EINVAL;
+			wd_margin = new_margin * 100;
+			wdtpci_ping();
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user(wd_margin, (int *)arg);
 	}
 }
 
@@ -385,7 +402,7 @@
 			wdtpci_ctr_mode(1,2);
 			wdtpci_ctr_mode(2,1);
 			wdtpci_ctr_load(0,20833);	/* count at 100Hz */
-			wdtpci_ctr_load(1,WD_TIMO);/* Timeout 60 seconds */
+			wdtpci_ctr_load(1,wd_margin);/* Timeout 60 seconds */
 			/* DO NOT LOAD CTR2 on PCI card! -- JPN */
 			outb_p(0, WDT_DC);	/* Enable */
 			return 0;
diff -uNr linux-2.5.2/drivers/sbus/char/riowatchdog.c linux-2.5.2-wd/drivers/sbus/char/riowatchdog.c
--- linux-2.5.2/drivers/sbus/char/riowatchdog.c	Wed Oct 10 23:42:47 2001
+++ linux-2.5.2-wd/drivers/sbus/char/riowatchdog.c	Mon Jan 21 16:51:19 2002
@@ -127,7 +127,9 @@
 static int riowd_ioctl(struct inode *inode, struct file *filp,
 		       unsigned int cmd, unsigned long arg)
 {
-	static struct watchdog_info info = { 0, 0, "Natl. Semiconductor PC97317" };
+	static struct watchdog_info info = {
+	       	WDIOF_SETTIMEOUT, 0, "Natl. Semiconductor PC97317"
+	};
 	unsigned int options;
 
 	switch (cmd) {
@@ -158,6 +160,18 @@
 			return -EINVAL;
 
 		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if ((new_margin < 60) || (new_margin > (255 * 60)))
+		    return -EINVAL;
+		riowd_timeout = (new_margin + 59) / 60;
+		riowd_pingtimer();
+		/* Fall */
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(riowd_timeout * 60, (int *)arg);
 
 	default:
 		return -EINVAL;
diff -uNr linux-2.5.2/include/linux/watchdog.h linux-2.5.2-wd/include/linux/watchdog.h
--- linux-2.5.2/include/linux/watchdog.h	Fri Nov  9 14:11:15 2001
+++ linux-2.5.2-wd/include/linux/watchdog.h	Mon Jan 21 16:51:19 2002
@@ -25,7 +25,8 @@
 #define	WDIOC_GETTEMP		_IOR(WATCHDOG_IOCTL_BASE, 3, int)
 #define	WDIOC_SETOPTIONS	_IOR(WATCHDOG_IOCTL_BASE, 4, int)
 #define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
-#define	WDIOC_SETTIMEOUT        _IOW(WATCHDOG_IOCTL_BASE, 6, int)
+#define	WDIOC_SETTIMEOUT        _IOWR(WATCHDOG_IOCTL_BASE, 6, int)
+#define	WDIOC_GETTIMEOUT        _IOR(WATCHDOG_IOCTL_BASE, 7, int)
 
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
@@ -37,6 +38,7 @@
 #define	WDIOF_POWERUNDER	0x0010	/* Power bad/power fault */
 #define	WDIOF_CARDRESET		0x0020	/* Card previously reset the CPU */
 #define WDIOF_POWEROVER		0x0040	/* Power over voltage */
+#define WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */

-- 

"Can any of you seriously say the Bill of Rights could get through
 Congress today?  It wouldn't even get out of committee."
	- F. Lee Bailey

			http://www.jlbec.org/
			jlbec@evilplan.org
