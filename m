Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292350AbSBUMTB>; Thu, 21 Feb 2002 07:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292352AbSBUMSx>; Thu, 21 Feb 2002 07:18:53 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:48577 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292350AbSBUMSj>; Thu, 21 Feb 2002 07:18:39 -0500
Date: Thu, 21 Feb 2002 14:07:36 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: wingel@nano-system.com, <jgarzik@mandrakesoft.com>, <roy@karlsbakk.net>,
        <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <20020221115916.9FD5AF5B@acolyte.hack.org>
Message-ID: <Pine.LNX.4.44.0202211404380.7649-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Christer Weinigel wrote:
> Ok, I've switched to a semaphore instead and gotten rid of the magic
> numbers.  I've also added the ability to set and get the timeout
> (where is WDIOC_GETTIMEOUT supposed to be defined?  it's not in my
> 2.4.17 kernel), and a reboot notifier so that the system can be halted
> without the watchdog kicking in.

Put the GETTIMEOUT stuff in an ioctl, heres my current version, it 
implements a number of the ioctls as well as the reboot notifier and 
semaphores for locking.

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
 *	20020221 Zwane Mwaikambo	Code cleanups (thanks to Jeff Garzik).
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/miscdevice.h>
#include <linux/watchdog.h>
#include <linux/ioport.h>
#include <asm/semaphore.h>
#include <asm/io.h>
#include <asm/uaccess.h>
#include <linux/notifier.h>
#include <linux/reboot.h>
#include <linux/init.h>

#define SC1200_MODULE_VER	"build 20020220"
#define SC1200_MODULE_NAME	"sc1200wdt"
#define PFX			SC1200_MODULE_NAME ": "

#define MAX_TIMEOUT	255	/* 255 minutes */
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

	if (timeout > MAX_TIMEOUT)
		timeout = MAX_TIMEOUT;

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
			if (new_timeout < 0 || new_timeout > MAX_TIMEOUT)
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
	/* Disable it on the way out */
	sc1200wdt_write_data(WDTO, 0);
	up(&open_sem);

	printk(KERN_INFO PFX "Watchdog disabled\n");

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


