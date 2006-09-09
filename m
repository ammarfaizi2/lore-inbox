Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWIIQ2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWIIQ2s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 12:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWIIQ2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 12:28:47 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:23294 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S964796AbWIIQ2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 12:28:46 -0400
Date: Sat, 9 Sep 2006 18:28:44 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
       Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <2006-09-09-17-18-13+trackit+sam@rfc1149.net> <1157817522.6877.46.camel@localhost.localdomain> <2006-09-09-17-38-12+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2006-09-09-17-38-12+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.11
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-09-09-18-28-44+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9/09, Samuel Tardieu wrote:

| | 	fd = open("/dev/watchdog", O_RDWR);
| | 	switch(fork())
| | 	{
| | 
| | .. one open, two users, two processes, two CPUs
| 
| Right. Thanks for the review, will fix.

Updated patch follows.

  Sam



Winbond W83697HF/W83697HGHG watchdog timer

The Winbond SuperIO W83697HF/HG includes a watchdog that can count from
1 to 255 seconds (or minutes). This drivers allows the seconds mode to
be used. It exposes a standard /dev/watchdog interface. This chip is
currently being used on some motherboards designed by VIA.

By default, the module looks for a chip at I/O port 0x4e. The chip can
be configured to be at 0x2e on some motherboards, the address can be
chosen using the wdt_io module parameter. Using 0 will try to autodetect
the address.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

diff -r 92038c30d67b drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	Sat Sep 09 17:30:15 2006 +0200
+++ b/drivers/char/watchdog/Kconfig	Sat Sep 09 17:31:47 2006 +0200
@@ -371,6 +371,21 @@ config W83627HF_WDT
 
 	  Most people will say N.
 
+config W83697HF_WDT
+	tristate "W83697HF/W83697HG Watchdog Timer"
+	depends on WATCHDOG && X86
+	---help---
+	  This is the driver for the hardware watchdog on the W83697HF/HG
+	  chipset as used in Dedibox/VIA motherboards (and likely others).
+	  This watchdog simply watches your kernel to make sure it doesn't
+	  freeze, and if it does, it reboots your computer after a certain
+	  amount of time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called w83697hf_wdt.
+
+	  Most people will say N.
+
 config W83877F_WDT
 	tristate "W83877F (EMACS) Watchdog Timer"
 	depends on WATCHDOG && X86
diff -r 92038c30d67b drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	Sat Sep 09 17:30:15 2006 +0200
+++ b/drivers/char/watchdog/Makefile	Sat Sep 09 17:31:47 2006 +0200
@@ -51,6 +51,7 @@ obj-$(CONFIG_SBC8360_WDT) += sbc8360.o
 obj-$(CONFIG_SBC8360_WDT) += sbc8360.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
+obj-$(CONFIG_W83697HF_WDT) += w83697hf_wdt.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
diff -r 92038c30d67b drivers/char/watchdog/w83697hf_wdt.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/char/watchdog/w83697hf_wdt.c	Sat Sep 09 18:23:56 2006 +0200
@@ -0,0 +1,429 @@
+/*
+ *	w83697hf/hg WDT driver
+ *
+ *	(c) Copyright 2006 Samuel Tardieu <sam@rfc1149.net>
+ *	(c) Copyright 2006 Marcus Junker <junker@anduras.de>
+ *
+ *	Based on w83627hf_wdt which is based on wadvantechwdt.c
+ *	which is based on wdt.c.
+ *	Original copyright messages:
+ *
+ *	(c) Copyright 2003 Pádraig Brady <P@draigBrady.com>
+ *
+ *	(c) Copyright 2000-2001 Marek Michalkiewicz <marekm@linux.org.pl>
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
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/fs.h>
+#include <linux/ioport.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#define WATCHDOG_NAME "w83697hf/hg WDT"
+#define PFX WATCHDOG_NAME ": "
+#define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
+
+static unsigned long wdt_is_open;
+static char expect_close;
+static DECLARE_MUTEX(dev_lock);         /* Protect sequential operations */
+
+/* You must set this - there is no sane way to probe for this board. */
+static int wdt_io = 0x2e;
+module_param(wdt_io, int, 0);
+MODULE_PARM_DESC(wdt_io, "w83697hf/hg WDT io port (default 0x2e, 0 = autodetect)");
+
+static int timeout = WATCHDOG_TIMEOUT;	/* in seconds */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. 1<= timeout <=255, default=" __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+/*
+ *	Kernel methods.
+ */
+
+#define W83697HF_EFER (wdt_io+0)   /* Extended function enable register */
+#define W83697HF_EFIR (wdt_io+0)   /* Extended function index register */
+#define W83697HF_EFDR (wdt_io+1)   /* Extended function data register */
+
+static inline void
+w83697hf_unlock(void)
+{
+	outb_p(0x87, W83697HF_EFER);
+	outb_p(0x87, W83697HF_EFER);
+}
+
+static inline void
+w83697hf_lock(void)
+{
+	outb_p(0xAA, W83697HF_EFER);
+}
+
+/*
+ *	The three functions w83697hf_get_reg(), w83697_set_reg() and
+ *	wdt_ctrl() must be called with the device unlocked.
+ */
+
+static unsigned char
+w83697hf_get_reg(unsigned char reg)
+{
+	outb_p(reg, W83697HF_EFIR);
+	return inb_p(W83697HF_EFDR);
+}
+
+static void
+w83697hf_set_reg(unsigned char reg, unsigned char data)
+{
+	outb_p(reg, W83697HF_EFIR);
+	outb_p(data, W83697HF_EFDR);
+}
+
+static void
+wdt_ctrl(int timeout)
+{
+	w83697hf_set_reg(0xF4, timeout);
+}
+
+static void
+w83697hf_select_wdt(void)
+{
+	down(&dev_lock);
+	w83697hf_unlock();
+	w83697hf_set_reg(0x07, 0x08);   /* Switch to logic device 8 */
+}
+
+static inline void
+w83697hf_deselect_wdt(void)
+{
+	w83697hf_lock();
+	up(&dev_lock);
+}
+
+static void
+wdt_ping(void)
+{
+	w83697hf_select_wdt();
+	wdt_ctrl(timeout);
+	w83697hf_deselect_wdt();
+}
+
+static void
+wdt_enable(void)
+{
+	unsigned char bbuf;
+
+	w83697hf_select_wdt();
+
+	bbuf = w83697hf_get_reg(0x29);
+	bbuf &= ~0x60;
+	bbuf |= 0x20;
+	w83697hf_set_reg(0x29, bbuf);   /* Set pin 119 to WDTO# mode */
+
+	bbuf = w83697hf_get_reg(0xF3);
+	bbuf &= ~0x04;
+	w83697hf_set_reg(0xF3, bbuf);   /* Count mode is seconds */
+	w83697hf_set_reg(0x30, 1);      /* Enable timer */
+
+	w83697hf_deselect_wdt();
+}
+
+static void
+wdt_disable(void)
+{
+	w83697hf_select_wdt();
+	w83697hf_set_reg(0x30, 0);       /* Disable timer */
+	wdt_ctrl(0);
+	w83697hf_deselect_wdt();
+}
+
+static int
+wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 255))
+		return -EINVAL;
+
+	timeout = t;
+	return 0;
+}
+
+static ssize_t
+wdt_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	if (count) {
+		if (!nowayout) {
+			size_t i;
+      
+			expect_close = 0;
+      
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf+i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 42;
+			}
+		}
+		wdt_ping();
+	}
+	return count;
+}
+
+static int
+wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	  unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int new_timeout;
+	static struct watchdog_info ident = {
+		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
+		.firmware_version = 1,
+		.identity = "W83697HF WDT",
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user(argp, &ident, sizeof(ident)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, p);
+
+	case WDIOC_KEEPALIVE:
+		wdt_ping();
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_timeout, p))
+			return -EFAULT;
+		if (wdt_set_heartbeat(new_timeout))
+			return -EINVAL;
+		wdt_ping();
+		/* Fall */
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(timeout, p);
+
+	case WDIOC_SETOPTIONS:
+	{
+		int options, retval = -EINVAL;
+      
+		if (get_user(options, p))
+			return -EFAULT;
+      
+		if (options & WDIOS_DISABLECARD) {
+			wdt_disable();
+			retval = 0;
+		}
+
+		if (options & WDIOS_ENABLECARD) {
+			wdt_ping();
+			retval = 0;
+		}
+
+		return retval;
+	}
+
+	default:
+		return -ENOTTY;
+	}
+	return 0;
+}
+
+static int
+wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &wdt_is_open))
+		return -EBUSY;
+	/*
+	 *	Activate
+	 */
+
+	wdt_enable();
+	return nonseekable_open(inode, file);
+}
+
+static int
+wdt_close(struct inode *inode, struct file *file)
+{
+	if (expect_close == 42) {
+		wdt_disable();
+	} else {
+		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+		wdt_ping();
+	}
+	expect_close = 0;
+	clear_bit(0, &wdt_is_open);
+	return 0;
+}
+
+/*
+ *	Notifier for system down
+ */
+
+static int
+wdt_notify_sys(struct notifier_block *this, unsigned long code,
+	       void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		/* Turn the WDT off */
+		wdt_disable();
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct file_operations wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= wdt_write,
+	.ioctl		= wdt_ioctl,
+	.open		= wdt_open,
+	.release	= wdt_close,
+};
+
+static struct miscdevice wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &wdt_fops,
+};
+
+/*
+ *	The WDT needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off.
+ */
+
+static struct notifier_block wdt_notifier = {
+	.notifier_call = wdt_notify_sys,
+};
+
+static int
+w83697hf_init(void)
+{
+	if (!request_region(wdt_io, 2, WATCHDOG_NAME)) {
+		printk(KERN_ERR PFX "I/O address 0x%x already in use\n", wdt_io);
+		return -EIO;
+	}
+  
+	printk(KERN_DEBUG PFX "Looking for watchdog at address 0x%x\n", wdt_io);
+	w83697hf_unlock();
+	if (w83697hf_get_reg(0x20) == 0x60) {
+		printk(KERN_INFO PFX "watchdog found at address 0x%x\n", wdt_io);
+		w83697hf_lock();
+		return 0;
+	}
+	w83697hf_lock();   /* Reprotect in case it was a compatible device */
+  
+	printk(KERN_INFO PFX "watchdog not found at address 0x%x\n", wdt_io);
+	release_region(wdt_io, 2);
+	return -EIO;
+}
+
+static int __init
+wdt_init(void)
+{
+	int ret, autodetect;
+  
+	printk(KERN_INFO PFX "WDT driver for W83697HF/HG initializing\n");
+  
+	autodetect = wdt_io == 0;
+	if (autodetect)
+		wdt_io = 0x2e;
+  
+	if (!w83697hf_init())
+		goto found;
+  
+	if (autodetect) {
+		wdt_io = 0x4e;
+		if (!w83697hf_init())
+			goto found;
+	}
+  
+	printk(KERN_ERR PFX "No W83697HF/HG could be found\n");
+	ret = -EIO;
+	goto out;
+  
+ found:
+
+	w83697hf_select_wdt();
+	wdt_ctrl(0);                    /* Disable watchdog until first use */
+	w83697hf_deselect_wdt();
+
+	if (wdt_set_heartbeat(timeout)) {
+		wdt_set_heartbeat(WATCHDOG_TIMEOUT);
+		printk(KERN_INFO PFX "timeout value must be 1<=timeout<=255, using %d\n",
+		       WATCHDOG_TIMEOUT);
+	}
+  
+	ret = register_reboot_notifier(&wdt_notifier);
+	if (ret != 0) {
+		printk (KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			ret);
+		goto unreg_regions;
+	}
+  
+	ret = misc_register(&wdt_miscdev);
+	if (ret != 0) {
+		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto unreg_reboot;
+	}
+  
+	printk (KERN_INFO PFX "initialized. timeout=%d sec (nowayout=%d)\n",
+		timeout, nowayout);
+  
+ out:
+	return ret;
+ unreg_reboot:
+	unregister_reboot_notifier(&wdt_notifier);
+ unreg_regions:
+	release_region(wdt_io, 2);
+	goto out;
+}
+
+static void __exit
+wdt_exit(void)
+{
+	misc_deregister(&wdt_miscdev);
+	unregister_reboot_notifier(&wdt_notifier);
+	release_region(wdt_io, 2);
+}
+
+module_init(wdt_init);
+module_exit(wdt_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Samuel Tardieu <sam@rfc1149.net>");
+MODULE_DESCRIPTION("w83697hf WDT driver");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

