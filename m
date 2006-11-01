Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752470AbWKAVk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbWKAVk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbWKAVk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:40:27 -0500
Received: from outmx013.isp.belgacom.be ([195.238.5.64]:4524 "EHLO
	outmx013.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1752470AbWKAVk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:40:26 -0500
Date: Wed, 1 Nov 2006 22:40:20 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: ggaleotti@interfree.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] watchdog driver for Digital-Logic MSM-P5XEN PC104 unit
Message-ID: <20061101214020.GD7056@infomag.infomag.iguana.be>
References: <20061017123440.4321.qmail@community1.interfree.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017123440.4321.qmail@community1.interfree.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriele,

> A simple watchdog driver for Digital-Logic's MSM-P5XEN PC104 unit.
> The watchdog is a LTC1232 controlled by a single I/O port @ 0x1037.
> The watchdog must be refreshed (writing a single byte) to the device
> at least every 600 msecs (which is a little of overhead, but PC104
> industrial applications requires a high degree of safety/reliability.)

Can you test the attached code? This should work in my opinion.

Thanks in advance,
Wim.

--------------------------------------------------------------------------------
/*
 *	dlpc104: watchdog driver for Digital-Logic MSM-P5XEN PC104 unit
 *
 *	Copyright (c) 2006 Gabriele Galeotti <ggaleotti@interfree.it>
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License
 *	as published by the Free Software Foundation; either version
 *	2 of the License, or (at your option) any later version.
 *
 *	Version 0.1 (06/10/2006):
 *	- first version
 *
 *	Please see ggaleotti.interfree.it for latest version.
 */

#include <linux/module.h>	/* For module specific items */
#include <linux/moduleparam.h>	/* For new moduleparam's */
#include <linux/types.h>	/* For standard types (like size_t) */
#include <linux/errno.h>	/* For the -ENODEV/... values */
#include <linux/kernel.h>	/* For printk/panic/... */
#include <linux/delay.h>	/* For mdelay function */
#include <linux/timer.h>	/* For timer related operations */
#include <linux/jiffies.h>	/* For jiffies stuff */
#include <linux/miscdevice.h>	/* For MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR) */
#include <linux/watchdog.h>	/* For the watchdog specific items */
#include <linux/notifier.h>	/* For notifier support */
#include <linux/reboot.h>	/* For reboot_notifier stuff */
#include <linux/init.h>		/* For __init/__exit/... */
#include <linux/fs.h>		/* For file operations */
#include <linux/ioport.h>	/* For io-port access */
#include <linux/spinlock.h>	/* For spin_lock/spin_unlock/... */

#include <asm/uaccess.h>	/* For copy_to_user/put_user/... */
#include <asm/io.h>		/* For inb/outb/... */

#define WATCHDOG_NAME "dlpc104"
#define PFX WATCHDOG_NAME ": "

/*
 * We are using a kernel timer to do the pinging of the watchdog
 * every ~100ms. The internal watchdog reboots after 600 ms.
 */

#define WDT_INTERVAL (HZ/10)

/* internal variables */
static unsigned long is_active;		/* Only one /dev/watchdog can be opened at any time */
static char expect_close;		/* for Magic Close support */
static spinlock_t io_lock;		/* the lock for io operations */
static unsigned long next_heartbeat;	/* the next_heartbeat for the timer */
static struct timer_list wdt_timer;	/* the internal timer that will tickle the watchdog */

#define WATCHDOG_HEARTBEAT 60		/* 60 sec default heartbeat */
static int heartbeat = WATCHDOG_HEARTBEAT;
module_param(heartbeat, int, 0);
MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (1<=heartbeat<=3600, default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");

static int nowayout = WATCHDOG_NOWAYOUT;
module_param(nowayout, int, 0);
MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");

#define WDT_IOBASE 0x1000
#define WDT_OFFSET 0x37
static int io_base = WDT_IOBASE;
module_param(io_base, int, 0);
MODULE_PARM_DESC(io_base, "I/O base address (default=0x1000)");

/*
 *	Internal functions
 */

static void wdt_enable(void)
{
	outb(inb(io_base + WDT_OFFSET) & 0xf7, io_base + WDT_OFFSET);
}

static void wdt_disable(void)
{
	outb(inb(io_base + WDT_OFFSET) | 0x08, io_base + WDT_OFFSET);
}

static void wdt_ping(unsigned long data)
{
	int wdrst_stat;

	/* If we got a heartbeat pulse within the WDT_INTERVAL
	 * we agree to ping the WDT */
	if(time_before(jiffies, next_heartbeat)) {
		/* Ping the watchdog */
		spin_lock(&io_lock);
		wdt_enable();

		/* Re-set the timer interval */
		/*
		 * Clear-pulse trailing edge scheduling.
		 *
		 * We use mod_timer() rather than add_timer() because a timer could
		 * be already activated.
		 * kernel/timer.c:
		 * "... since add_timer() cannot modify an already running timer."
		 */
		mod_timer(&wdt_timer, jiffies + WDT_INTERVAL);

		spin_unlock(&io_lock);
	} else {
		printk(KERN_WARNING PFX "Heartbeat lost! Will not ping the watchdog\n");
	}
}

static int dl_wdt_start(void)
{
	spin_lock(&io_lock);

	next_heartbeat = jiffies + (heartbeat * HZ);

	/* Start the timer */
	mod_timer(&wdt_timer, jiffies + WDT_INTERVAL);

	/* Enable the port */
	wdt_enable();

	spin_unlock(&io_lock);

	return 0;
}

static int dl_wdt_stop(void)
{
	spin_lock(&io_lock);

	/* Stop the timer */
	del_timer(&wdt_timer);

	/*  Disable the board  */
	wdt_disable();

	spin_unlock(&io_lock);

	return 0;
}

static int dl_wdt_keepalive(void)
{
	/* user land ping */
	next_heartbeat = jiffies + (heartbeat * HZ);

	return 0;
}

static int dl_wdt_set_heartbeat(int t)
{
	if ((t < 1) || (t > 3600)) /* arbitrary upper limit */
		return -EINVAL;

	heartbeat = t;

	return 0;
}

/*
 *	/dev/watchdog handling
 */

static int dl_wdt_open(struct inode *inode, struct file *file)
{
	/* /dev/watchdog can only be opened once */
	if (test_and_set_bit(0, &is_active))
		return -EBUSY;

	if (nowayout)
		__module_get(THIS_MODULE);

	/* Activate */
	dl_wdt_start();
	dl_wdt_keepalive();
	return nonseekable_open(inode, file);
}

static ssize_t dl_wdt_write(struct file *file, const char __user *buf,
			    size_t len, loff_t *ppos)
{
	if (len) {
		if (!nowayout) {
			size_t i;

			/* In case it was set long ago */
			expect_close = 0;

			for (i = 0; i != len; i++) {
				char c;

				if (get_user(c, buf + i))
					return -EFAULT;
				if (c == 'V')
					expect_close = 42;
			}
		}
		dl_wdt_keepalive();
	}
	return len;
}

static int dl_wdt_close(struct inode *inode, struct file *file)
{
	if (expect_close == 42) {
		dl_wdt_stop();
	} else {
		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
		dl_wdt_keepalive();
	}
	expect_close = 0;
	clear_bit(0, &is_active);
	return 0;
}

static struct watchdog_info ident = {
	.options =		WDIOF_KEEPALIVEPING |
				WDIOF_SETTIMEOUT |
				WDIOF_MAGICCLOSE,
	.firmware_version =	0,
	.identity =		"DLPC104 Watchdog",
};

static int dl_wdt_ioctl(struct inode *inode, struct file *file,
		      unsigned int cmd, unsigned long arg)
{
	int __user *argp = (int __user *)arg;

	switch(cmd) {
	default:
		return -ENOTTY;

	case WDIOC_GETSUPPORT:
		if(copy_to_user(argp, &ident, sizeof(ident)))
			return -EFAULT;
		return 0;

	case WDIOC_GETSTATUS:
	case WDIOC_GETBOOTSTATUS:
		return put_user(0, argp);

	case WDIOC_SETOPTIONS:
		int rv;

		if(copy_from_user(&rv, argp, sizeof(int)))
			return -EFAULT;

		if (rv & WDIOS_DISABLECARD)
		{
			return dl_wdt_stop();
		}

		if (rv & WDIOS_ENABLECARD)
		{
			return dl_wdt_start();
		}
		return -EINVAL;

	case WDIOC_KEEPALIVE:
		dl_wdt_keepalive();
		return 0;

	case WDIOC_SETTIMEOUT:
		int new_heartbeat;

		if (get_user(new_heartbeat, argp))
			return -EFAULT;

		if (dl_wdt_set_heartbeat(new_heartbeat))
			return -EINVAL;

		dl_wdt_keepalive();
		/* Fall */

	case WDIOC_GETTIMEOUT:
		return put_user(heartbeat, argp);
	}

	return 0;
}

/*
 *	Notify system
 */

static int dl_wdt_notify_sys(struct notifier_block *this, unsigned long code,
			     void *unused)
{
	if (code==SYS_DOWN || code==SYS_HALT) {
		/* Turn the WDT off */
		dl_wdt_stop();
	}

	return NOTIFY_DONE;
}

/*
 *	Kernel Interfaces
 */

static struct file_operations dlmodule_fops = {
	.owner   = THIS_MODULE,
	.llseek  = no_llseek,
	.write   = dl_wdt_write,
	.ioctl   = dl_wdt_ioctl,
	.open    = dl_wdt_open,
	.release = dl_wdt_close,
};

static struct miscdevice dlmodule_miscdevice = {
	.minor = WATCHDOG_MINOR,
	.name  = "watchdog",
	.fops  = &dlmodule_fops,
};

/*
 * The WDT needs to learn about soft shutdowns in order to turn the timebomb
 * registers off.
 */
static struct notifier_block wdt_notifier = {
	.notifier_call = wdt_notify_sys,
};

/*
 *	Init & exit routines
 */

static int __init dlmodule_init(void)
{
	int result;

	spin_lock_init(&io_lock);

	if (!request_region(io_base + WDT_OFFSET, 1, "DLPC104 Watchdog"))
	{
		printk(KERN_ERR "DLPC104 Watchdog: I/O region busy.\n");
		result = -EBUSY;
		goto exit_0;
	}

	init_timer(&wdt_timer);
	wdt_timer.function = wdt_ping;
	wdt_timer.data = 0;

	/*  Disable the board  */
	dl_wdt_stop();

	/* Check that the heartbeat value is within it's range ; if not reset to the default */
	if (dl_wdt_set_heartbeat(heartbeat)) {
		dl_wdt_set_heartbeat(WATCHDOG_HEARTBEAT);
		printk(KERN_INFO PFX "heartbeat value must be 1<=heartbeat<=3600, using %d\n",
			WATCHDOG_HEARTBEAT);
	}

	result = register_reboot_notifier(&wdt_notifier);
	if (result != 0)
	{
		printk (KERN_ERR "DLPC104 Watchdog: cannot register reboot notifier.\n");
		goto exit_1;
	}

	result = misc_register(&dlmodule_miscdevice);
	if (result != 0)
	{
		printk(KERN_ERR "DLPC104 Watchdog: cannot register.\n");
		goto exit_2;
	}

	printk(KERN_INFO "Digital-Logic MSM-P5XEN PC104 Watchdog driver loaded.\n");
	printk(KERN_INFO PFX "initialized. heartbeat=%d sec (nowayout=%d)\n",
		heartbeat, nowayout);

	return 0;

exit_2:	unregister_reboot_notifier(&wdt_notifier);
exit_1: release_region(io_base + WDT_OFFSET, 1);
exit_0: return result;
}

static void __exit dlmodule_exit(void)
{
	/*  Disable the board  */
	if (!nowayout)
		dl_wdt_stop();

	/* Deregister */
	misc_deregister(&dlmodule_miscdevice);
	unregister_reboot_notifier(&wdt_notifier);
	release_region(io_base + WDT_OFFSET, 1);
}

/*
 * Module parameters & definitions.
 */

MODULE_AUTHOR("Gabriele Galeotti <ggaleotti@interfree.it>");
MODULE_DESCRIPTION("Digital-Logic PC104 watchdog driver");
MODULE_LICENSE("GPL");
MODULE_VERSION("0.1");
MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

module_init(dlmodule_init);
module_exit(dlmodule_exit);

