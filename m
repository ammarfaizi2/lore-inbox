Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292346AbSBUL7m>; Thu, 21 Feb 2002 06:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292349AbSBUL7e>; Thu, 21 Feb 2002 06:59:34 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:27398 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S292346AbSBUL7W>;
	Thu, 21 Feb 2002 06:59:22 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: wingel@nano-system.com
Cc: jgarzik@mandrakesoft.com, zwane@linux.realnet.co.sz, roy@karlsbakk.net,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020221111910.57235F5B@acolyte.hack.org> (message from Christer
	Weinigel on Thu, 21 Feb 2002 12:19:10 +0100 (CET))
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz> <3C74C8C7.25D7BCD@mandrakesoft.com> <20020221111910.57235F5B@acolyte.hack.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="++----------20020221125009-085420982----------++"
Content-Transfer-Encoding: 7bit
X-Mailer: Emacs 20.5.1 with etach 1.1.6
Message-Id: <20020221115916.9FD5AF5B@acolyte.hack.org>
Date: Thu, 21 Feb 2002 12:59:16 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--++----------20020221125009-085420982----------++
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Following up to myself:
> Is there anything else that I ought to change in the driver?  (Except
> to get rid of all the magic constants, I'm planning to do this, I
> promise).

In a private mail Jeff Garzik wrote:
>You should use a semaphore in ->open for example, not an atomic test
>op.  (note - atomic bit ops must ONLY be performed on unsigned long)

Ok, I've switched to a semaphore instead and gotten rid of the magic
numbers.  I've also added the ability to set and get the timeout
(where is WDIOC_GETTIMEOUT supposed to be defined?  it's not in my
2.4.17 kernel), and a reboot notifier so that the system can be halted
without the watchdog kicking in.

I have compiled this, but I haven't tested it for real yet (I have no
hardware close right now), so I might have done some stupid mistake.
I'll test this and put up a new snapshot when done.

   http://www.nano-system.com/scx200/

Is there anything else I ought to change?

  /Christer

-- 
Blatant plug: I'm a freelance consultant looking for interesting work.
--++----------20020221125009-085420982----------++
Content-Type: text/x-csrc; charset=iso-8859-1; name="scx200_watchdog.c"
Content-Transfer-Encoding: 7bit

/* linux/drivers/char/scx200_watchdog.c 

   National Semiconductor SCx200 Watchdog support

   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>

   Som code taken from:
   National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
   (c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   The author(s) of this software shall not be held liable for damages
   of any nature resulting due to the use of this software. This
   software is provided AS-IS with no warranties.  */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/miscdevice.h>
#include <linux/watchdog.h>
#include <linux/notifier.h>
#include <linux/reboot.h>
#include <asm/uaccess.h>

#include <linux/scx200.h>

MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
MODULE_DESCRIPTION("NatSemi SCx200 Watchdog");
MODULE_LICENSE("GPL");

#ifndef CONFIG_WATCHDOG_NOWAYOUT
#define CONFIG_WATCHDOG_NOWAYOUT 0
#endif

static char name[] = "scx200_watchdog";

static int margin = 60;		/* in seconds */
MODULE_PARM(margin, "i");

static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
MODULE_PARM(nowayout, "i");

static u16 wdto_restart;
static struct semaphore open_sem;
static unsigned expect_close;

#define WDTO 0x00		/* Time-Out Register */
#define WDCNFG 0x02		/* Configuration Register */
#define    W_ENABLE 0x00fa	/* Enable watchdog */
#define    W_DISABLE 0x0000	/* Disable watchdog */
#define WDSTS 0x04		/* Status Register */
#define    WDOVF (1<<0)		/* Overflow */

static void scx200_watchdog_ping(void)
{
	outw(wdto_restart, scx200_config_block + WDTO);
}

static void scx200_watchdog_update_margin(void)
{
	printk(KERN_INFO "%s: timer margin %d seconds\n", name, margin);
	wdto_restart = 32768 / 1024 * margin;
	scx200_watchdog_ping();	
}

static void scx200_watchdog_enable(void)
{
	printk(KERN_DEBUG "%s: enable watchdog timer, wdto_restart = %d\n", 
	       name, wdto_restart);

	outw(0, scx200_config_block + WDTO);
	outb(WDOVF, scx200_config_block + WDSTS);
	outw(W_ENABLE, scx200_config_block + WDCNFG);

	scx200_watchdog_ping();
}

static void scx200_watchdog_disable(void)
{
	printk(KERN_DEBUG "%s: disabling watchdog timer\n", name);
		
	outw(0, scx200_config_block + WDTO);
	outb(WDOVF, scx200_config_block + WDSTS);
	outw(W_DISABLE, scx200_config_block + WDCNFG);
}

static int scx200_watchdog_open(struct inode *inode, struct file *file)
{
        /* only allow one at a time */
        if (down_trylock(&open_sem))
                return -EBUSY;
	scx200_watchdog_enable();
	expect_close = 0;

	return 0;
}

static int scx200_watchdog_release(struct inode *inode, struct file *file)
{
	if (!expect_close) {
		printk(KERN_WARNING "%s: watchdog device closed unexpectedly, "
		       "will not disable the watchdog timer\n", name);
	} else if (!nowayout) {
		scx200_watchdog_disable();
	}
        up(&open_sem);

	return 0;
}

static int scx200_watchdog_notify_sys(struct notifier_block *this, 
				      unsigned long code, void *unused)
{
        if (code == SYS_DOWN || code == SYS_HALT)
		scx200_watchdog_disable();

        return NOTIFY_DONE;
}

static struct notifier_block scx200_watchdog_notifier =
{
        scx200_watchdog_notify_sys,
        NULL,
        0
};

static ssize_t scx200_watchdog_write(struct file *file, const char *data, 
				     size_t len, loff_t *ppos)
{
	if (ppos != &file->f_pos)
		return -ESPIPE;

	/* check for a magic close character */
	if (len) 
	{
		size_t i;

		scx200_watchdog_ping();

		expect_close = 0;
		for (i = 0; i < len; ++i) {
			if (data[i] == 'V')
				expect_close = 1;
		}

		return len;
	}

	return 0;
}

static int scx200_watchdog_ioctl(struct inode *inode, struct file *file,
	unsigned int cmd, unsigned long arg)
{
	static struct watchdog_info ident = {
		options : 0,
		firmware_version : 1, 
		identity : "SCx200 Watchdog",
	};
	int new_margin;
	
	switch (cmd) {
	default:
		return -ENOTTY;
	case WDIOC_GETSUPPORT:
		if(copy_to_user((struct watchdog_info *)arg, &ident, 
				sizeof(ident)))
			return -EFAULT;
		return 0;
	case WDIOC_GETSTATUS:
	case WDIOC_GETBOOTSTATUS:
		return put_user(0, (int *)arg);
	case WDIOC_KEEPALIVE:
		scx200_watchdog_ping();
		return 0;
	case WDIOC_SETTIMEOUT:
		if (get_user(new_margin, (int *)arg))
			return -EFAULT;
		margin = new_margin;
		scx200_watchdog_update_margin();
		return 0;
#ifdef WDIOC_GETTIMEOUT		
	case WDIOC_GETTIMEOUT:
		return put_user(margin, (int *)arg);
#endif
	}
}

static struct file_operations scx200_watchdog_fops = {
	owner: THIS_MODULE,
	write: scx200_watchdog_write,
	ioctl: scx200_watchdog_ioctl,
	open: scx200_watchdog_open,
	release: scx200_watchdog_release,
};

static struct miscdevice scx200_watchdog_miscdev = {
	minor: WATCHDOG_MINOR,
	name: name,
	fops: &scx200_watchdog_fops,
};

static int __init scx200_watchdog_init(void)
{
	int r;

	scx200_watchdog_update_margin();
        sema_init(&open_sem, 1);

	r = misc_register(&scx200_watchdog_miscdev);
	if (r)
		return r;

	r = register_reboot_notifier(&scx200_watchdog_notifier);
        if (r) {
                printk(KERN_ERR "%s: unable to register reboot notifier", 
		       name);
		misc_deregister(&scx200_watchdog_miscdev);
                return r;
        }

	return 0;
}

static void __exit scx200_watchdog_cleanup(void)
{
        unregister_reboot_notifier(&scx200_watchdog_notifier);
	misc_deregister(&scx200_watchdog_miscdev);
}

module_init(scx200_watchdog_init);
module_exit(scx200_watchdog_cleanup);

/*
    Local variables:
        compile-command: "cd ../../.. && ./build.sh fast"
        c-basic-offset: 8
    End:
*/
--++----------20020221125009-085420982----------++--
