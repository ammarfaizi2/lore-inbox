Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSBUGGH>; Thu, 21 Feb 2002 01:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbSBUGF5>; Thu, 21 Feb 2002 01:05:57 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:23755 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S287149AbSBUGFs>; Thu, 21 Feb 2002 01:05:48 -0500
Date: Thu, 21 Feb 2002 07:54:43 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <E16dYRh-0003nu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202210752080.7649-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy, careful what you wish for ;) Mind you i don't have this device, but the basic
framework is there that if i missed something, it should be pretty trivial to fix.
One thing to note is that the SC1200 is based on the PC87307/PC97307 which is a PnP
device, however this driver requires an io parameter, but i'll add the PnP support
if the driver has a chance of living.

Cheers,
	Zwane Mwaikambo

/*
 *	National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
 *	(c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>,
 *			All Rights Reserved.
 *	Based on wdt.c and wdt977.c by Alan Cox and Woody Suwalski respectively.
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License
 *	as published by the Free Software Foundation; either version
 *	2 of the License, or (at your option) any later version.
 *
 *	The author(s) of this software shall not be held liable for damages
 *	of any nature resulting due to the use of this software. This
 *	software is provided AS-IS with no warranties.
 *
 *	Changelog:
 *	20020220 Zwane Mwaikambo	Code based on datasheet, no hardware.
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/version.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/smp_lock.h>
#include <linux/miscdevice.h>
#include <linux/watchdog.h>
#include <linux/slab.h>
#include <linux/ioport.h>
#include <linux/fcntl.h>
#include <asm/semaphore.h>
#include <asm/io.h>
#include <asm/uaccess.h>
#include <asm/system.h>
#include <linux/notifier.h>
#include <linux/reboot.h>
#include <linux/init.h>

#define SC1200_MODULE_VER	"build 20020220"
#define SC1200_MODULE_NAME	"sc1200wdt"
#define PFX			SC1200_MODULE_NAME ": "

#define PMIR		(io)	/* Power Management Index Register */
#define PMDR		(io+1)	/* Power Management Data Register */

/* Data Register indexes */
#define FER1		0x00	/* Function enable register 1 */
#define FER2		0x01	/* Function enable register 2 */
#define PMC1		0x02	/* Power Management Ctrl 1 */
#define PMC2		0x03	/* Power Management Ctrl 2 */
#define PMC3		0x04	/* Power Management Ctrl 3 */
#define WDTO		0x05	/* Watchdog timeout register */
#define	WDCF		0x06	/* Watchdog config register */
#define WDST		0x07	/* Watchdog status register */

/* WDO Status */
#define WDO_ENABLED	0x00	
#define WDO_DISABLED	0x01	

/* WDCF bitfields - which devices assert WDO */
#define KBC_IRQ		0x01	/* Keyboard Controller */
#define MSE_IRQ		0x02	/* Mouse */
#define UART1_IRQ	0x03	/* Serial0 */
#define UART2_IRQ	0x04	/* Serial1 */
/* 5 -7 are reserved */

static char banner[] __initdata = KERN_INFO PFX SC1200_MODULE_VER " timeout = %d min(s)\n";
static int timeout = 1;		/* default to 1 minute (0 - 255), 0 disables it */
static int io;
struct semaphore open_sem;

MODULE_PARM(io, "i");
MODULE_PARM_DESC(io, "io port");
MODULE_PARM(timeout, "i");
MODULE_PARM_DESC(timeout, "range is (0-255), default is 1");

/* Read from Data Register */
static inline void sc1200wdt_read_data(unsigned char index, unsigned char *data)
{
	outb_p(index, PMIR);
	*data = inb(PMDR);
}

/* Write to Data Register */
static inline void sc1200wdt_write_data(unsigned char index, unsigned char data)
{
	outb_p(index, PMIR);
	outb(data, PMDR);
}

/* this returns the status of the WDO signal, inactive high
 * WDO_ENABLED or WDO_DISABLED
 */
static int sc1200wdt_status(void)
{
	unsigned char ret;

	sc1200wdt_read_data(WDST, &ret);
	return (ret & 0x01);		/* bits 1 - 7 are undefined */
}

static int sc1200wdt_open(struct inode *inode, struct file *file)
{
	unsigned char reg;

	/* allow one at a time */
	if (down_trylock(&open_sem))
		return -EBUSY;

	MOD_INC_USE_COUNT;

	if (timeout > 255)
		timeout = 255;

	sc1200wdt_read_data(WDCF, &reg);
	/* assert WDO when any of the following interrupts are triggered too */
	reg |= (KBC_IRQ | MSE_IRQ | UART1_IRQ | UART2_IRQ);
	sc1200wdt_write_data(WDCF, reg);
	/* set the timeout and get the ball rolling */
	sc1200wdt_write_data(WDTO, timeout);
	printk(KERN_INFO PFX "Watchdog enabled");
	
	return 0;
}

static int sc1200wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
{
	int new_timeout;
	static struct watchdog_info ident = {
		WDIOF_SETTIMEOUT,
		0,
		"PC87307/PC97307"
	};

	switch (cmd) {
		default:
			return -ENOTTY;	/* Keep Pavel Machek amused ;) */

		case WDIOC_GETSUPPORT:
			if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
				return -EFAULT;
			return 0;

		case WDIOC_GETSTATUS:
			return put_user(sc1200wdt_status(), (int *)arg);
	
		case WDIOC_KEEPALIVE:
			sc1200wdt_write_data(WDTO, timeout);
			return 0;

		case WDIOC_SETTIMEOUT:
			if (get_user(new_timeout, (int *)arg))
				return -EFAULT;
			if (new_timeout < 0 || new_timeout > 255)
				return -EINVAL;
			timeout = new_timeout;
			sc1200wdt_write_data(WDTO, timeout);
			/* fall through */

		case WDIOC_GETTIMEOUT:
			return put_user(timeout, (int *)arg);
	}
}

static int sc1200wdt_release(struct inode *inode, struct file *file)
{
	lock_kernel();

	/* Disable it on the way out */
	sc1200wdt_write_data(WDTO, 0);
	up(&open_sem);

	unlock_kernel();

	printk(KERN_INFO PFX "Watchdog disabled\n");
	MOD_DEC_USE_COUNT;

	return 0;
}

static ssize_t sc1200wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
{
	if (ppos != &file->f_pos)
		return -ESPIPE;

	if (len) {
		sc1200wdt_write_data(WDTO, timeout);
		return 1;
	}
		
	return 0;
}

static int sc1200wdt_notify_sys(struct notifier_block *this, unsigned long code, void *unused)
{
	if (code == SYS_DOWN || code == SYS_HALT)
		sc1200wdt_write_data(WDTO, 0);

	return NOTIFY_DONE;
}

static struct notifier_block sc1200wdt_notifier =
{
	sc1200wdt_notify_sys,
	NULL,
	0
};

#ifndef MODULE
static int __init sc1200wdt_setup(char *str)
{
	int ints[4];

	str = get_options (str, ARRAY_SIZE(ints), ints);

	if (ints[0] > 0)
	{
		io = ints[1];
		if (ints[0] > 1)
			timeout = ints[2];
	}

	return 1;
}

__setup("sc1200wdt=", sc1200wdt_setup);
#endif /* MODULE */

static struct file_operations sc1200wdt_fops =
{
	owner:		THIS_MODULE,
	write:		sc1200wdt_write,
	ioctl:		sc1200wdt_ioctl,
	open:		sc1200wdt_open,
	release:	sc1200wdt_release,
};

static struct miscdevice sc1200wdt_miscdev =
{
	WATCHDOG_MINOR,
	"watchdog",
	&sc1200wdt_fops
};

static int __init sc1200wdt_probe(int base_io)
{
	/* How can we probe for this thing? */
	return 0;
}

static int __init sc1200wdt_init(void)
{
	int ret;

	printk(banner, timeout);
		
	if (!request_region(io, 2, SC1200_MODULE_NAME)) {
		printk(KERN_ERR PFX "IO port %#x not free.\n", io);
		ret = -EBUSY;
		goto out_clean;
	}

	ret = sc1200wdt_probe(io);
	if (ret == -ENODEV)
		goto out_io;

	ret = register_reboot_notifier(&sc1200wdt_notifier);
	if (ret) {
		printk(KERN_ERR PFX "Unable to register reboot notifier err = %d\n", ret);
		goto out_io;
	}

	sema_init(&open_sem, 1);
	ret = misc_register(&sc1200wdt_miscdev);
	if (ret) {
		printk(KERN_ERR PFX "Unable to register miscdev on minor %d\n", WATCHDOG_MINOR);
		goto out_rbt;
	}

out_clean:
	return ret;

out_rbt:
	unregister_reboot_notifier(&sc1200wdt_notifier);
out_io:
	release_region(io, 2);
	goto out_clean;
}	

static void __exit sc1200wdt_exit(void)
{
	misc_deregister(&sc1200wdt_miscdev);
	unregister_reboot_notifier(&sc1200wdt_notifier);
	release_region(io, 2);
}

module_init(sc1200wdt_init);
module_exit(sc1200wdt_exit);

MODULE_AUTHOR("Zwane Mwaikambo <zwane@commfireservices.com>");
MODULE_DESCRIPTION("Driver for National Semiconductor PC87307/PC97307 watchdog component");
MODULE_LICENSE("GPL");
EXPORT_NO_SYMBOLS;


