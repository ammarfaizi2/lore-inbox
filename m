Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbTBKSpJ>; Tue, 11 Feb 2003 13:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbTBKSpJ>; Tue, 11 Feb 2003 13:45:09 -0500
Received: from fmr02.intel.com ([192.55.52.25]:59622 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264939AbTBKSpB>; Tue, 11 Feb 2003 13:45:01 -0500
Subject: Re: [PATCH][DRIVER][RFC] CPU5 watchdog driver for 2.5
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Heiko Ronsdorf <sk048ro@crimson.ihg.uni-duisburg.de>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <20030211122620.GA10604@mail.ihg.uni-duisburg.de>
References: <20030210201732.GA25722@mail.ihg.uni-duisburg.de>
	<1044916408.4724.11.camel@vmhack> 
	<20030211122620.GA10604@mail.ihg.uni-duisburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Feb 2003 20:38:14 -0800
Message-Id: <1044938295.4726.44.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 04:26, Heiko Ronsdorf wrote:
> Rusty Lynch schrieb am Mon, Feb 10, 2003 at 02:33:27PM -0800:
<snip>
> > * I'm pretty sure that in general adding new code to /proc (that has
> > nothing to do with processes) is frowned on.
> 
> I don't know how to track the watchdog. Suggestions are welcome.
> 
> Heiko
> 

I CC'ed Patrick Mochel to get his opinion on this, but if I am
interpreting the new driver model documentation correctly, then it would
be appropriate to make an IO controlled watchdog timer a
"platform_device".  That will let user space see your device in sysfs as
$YOUR_SYSFS_ROOT/devices/legacy/watchdog0/, and then you can use
device_create_file() to add a new file inside the the watchdog0
directory.

Here is your cpu5wdt.c file with the procfs stuff replaced with code
that adds an embedded platform_device to your basic data structure,
registers the driver as a platform device, and then creates a file
called $YOUR_SYSFS_ROOT/devices/legacy/watchdog0/statistics that will
read the same as your original procfs file.  (Or at least I think it
will.  It at least compiles :->)

    --rustyl

/*
 * sma cpu5 watchdog driver
 *
 * Copyright (C) 2003 Heiko Ronsdorf <hero@ihg.uni-duisburg.de>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/miscdevice.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/init.h>
#include <linux/ioport.h>
#include <linux/timer.h>
#include <asm/io.h>
#include <asm/uaccess.h>

#include <linux/watchdog.h>
#include <linux/kobject.h>
#include <linux/device.h>

/* adjustable parameters */

static int verbose = 0;
static int port = 0x91;
static volatile int ticks = 10000;

#define PFX			"cpu5wdt: "

#define CPU5WDT_EXTENT          0x0A

#define CPU5WDT_STATUS_REG      0x00
#define CPU5WDT_TIME_A_REG      0x02
#define CPU5WDT_TIME_B_REG      0x03
#define CPU5WDT_MODE_REG        0x04
#define CPU5WDT_TRIGGER_REG     0x07
#define CPU5WDT_ENABLE_REG      0x08
#define CPU5WDT_RESET_REG       0x09

#define CPU5WDT_INTERVAL	(HZ/10+1)

#define	to_platform_device(n) container_of(n, struct platform_device, dev)
#define	to_wdt_device(n) container_of(n, struct wdt_device, dev)

/* some device data */

struct wdt_device {
	struct semaphore stop;
	volatile int running;
	struct timer_list timer;
	volatile int queue;
	int default_ticks;
	int min_ticks;
	unsigned long inuse;
	struct platform_device dev;
};

static struct wdt_device cpu5wdt_device = {
	.dev = {
		.name = "watchdog",
		.id		= 0,
		.dev		= {
			.name	= "CPU5 Watchdog Device",
		},
	},
};

ssize_t statistics_show(struct device * dev, char * buf)
{
	size_t len;
	struct wdt_device *d = to_wdt_device(to_platform_device(dev));
	len = sprintf(buf,      "activation:       %i\n", d->queue);
	len += sprintf(buf+len, "status:           %i\n", d->running);
	len += sprintf(buf+len, "current ticks: %i\n", ticks);
	len += sprintf(buf+len, "min ticks:     %i\n", d->min_ticks);
	return len;

}
DEVICE_ATTR(statistics,S_IRUGO,statistics_show,NULL);

/* generic helper functions */

static void cpu5wdt_trigger(unsigned long unused)
{
	if ( verbose > 2 )
		printk(KERN_DEBUG PFX "trigger at %i ticks\n", ticks);

	if( cpu5wdt_device.running )
		ticks--;

	/* keep watchdog alive */
	outb(1, port + CPU5WDT_TRIGGER_REG);

	/* requeue?? */
	if( cpu5wdt_device.queue && ticks ) {
		cpu5wdt_device.timer.expires = jiffies + CPU5WDT_INTERVAL;
		add_timer(&cpu5wdt_device.timer);
	}
	else {
		/* ticks doesn't matter anyway */
		up(&cpu5wdt_device.stop);
	}

}

static void cpu5wdt_reset(void)
{
	if ( ticks < cpu5wdt_device.min_ticks )
		cpu5wdt_device.min_ticks = ticks;

	ticks = cpu5wdt_device.default_ticks;

	if ( verbose )
		printk(KERN_DEBUG PFX "reset (%i ticks)\n", (int) ticks);

}

static void cpu5wdt_start(void)
{
	if ( !cpu5wdt_device.queue ) {
		cpu5wdt_device.queue = 1;
		outb(0, port + CPU5WDT_TIME_A_REG);  
		outb(0, port + CPU5WDT_TIME_B_REG);  
		outb(1, port + CPU5WDT_MODE_REG);
		outb(0, port + CPU5WDT_RESET_REG);
		outb(0, port + CPU5WDT_ENABLE_REG);
		cpu5wdt_device.timer.expires = jiffies + CPU5WDT_INTERVAL;
		add_timer(&cpu5wdt_device.timer);
	}
	/* if process dies, counter is not decremented */
	cpu5wdt_device.running++;
}

static int cpu5wdt_stop(void)
{
	if ( cpu5wdt_device.running )
		cpu5wdt_device.running = 0;

	ticks = cpu5wdt_device.default_ticks;

	if ( verbose )
		printk(KERN_CRIT PFX "stop not possible\n");

	return -EIO;
}

/* filesystem operations */

static int cpu5wdt_open(struct inode *inode, struct file *file)
{
	switch(minor(inode->i_rdev)) {
		case WATCHDOG_MINOR:
			if ( test_and_set_bit(0, &cpu5wdt_device.inuse) )
				return -EBUSY;
			break;
		default:
			return -ENODEV;
	}
	return 0;

}

static int cpu5wdt_release(struct inode *inode, struct file *file)
{
	if(minor(inode->i_rdev)==WATCHDOG_MINOR) {
		clear_bit(0, &cpu5wdt_device.inuse);
	}
	return 0;
}

static int cpu5wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
{
	unsigned int value;
	static struct watchdog_info ident =
	{
		.options = WDIOF_CARDRESET,
		.identity = "CPU5 WDT"
	};
  
	switch(cmd) {
		case WDIOC_KEEPALIVE:
			cpu5wdt_reset();
			break;
		case WDIOC_GETSTATUS:    
			value = inb(port + CPU5WDT_STATUS_REG); 
			value = (value >> 2) & 1;
			if ( copy_to_user((int *)arg, (int *)&value, sizeof(int)) )
				return -EFAULT;
			break;
		case WDIOC_GETSUPPORT:
			if ( copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)) )
				return -EFAULT;
			break;
		case WDIOC_SETOPTIONS:
			if ( copy_from_user(&value, (int *)arg, sizeof(int)) )
				return -EFAULT;
			switch(value) {
				case WDIOS_ENABLECARD:
					cpu5wdt_start();
					break;
				case WDIOS_DISABLECARD:
					return cpu5wdt_stop();
				default:
					return -EINVAL;
			}
			break;
		default:
    			return -EINVAL;
	}
	return 0;
}

static ssize_t cpu5wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
{
	if ( !count )
		return -EIO;
	
	cpu5wdt_reset();
	return count;

}

static struct file_operations cpu5wdt_fops = {
	.owner		= THIS_MODULE,
	.ioctl		= cpu5wdt_ioctl,
	.open		= cpu5wdt_open,
	.write		= cpu5wdt_write,
	.release	= cpu5wdt_release,
};

static struct miscdevice cpu5wdt_misc = {
	.minor	= WATCHDOG_MINOR,
	.name	= "watchdog",
	.fops	= &cpu5wdt_fops
};

/* init/exit function */

static int __devinit cpu5wdt_init(void)
{
	unsigned int val;
	int err;

	if ( verbose )
		printk(KERN_DEBUG PFX "port=0x%x, verbose=%i\n", port, verbose);

	if ( (err = misc_register(&cpu5wdt_misc)) < 0 ) {
		printk(KERN_ERR PFX "misc_register failed\n");
		goto no_misc;
	}

	if ( !request_region(port, CPU5WDT_EXTENT, PFX) ) {
		printk(KERN_ERR PFX "request_region failed\n");
		err = -EBUSY;
		goto no_port;
	}

	/* watchdog reboot? */
	val = inb(port + CPU5WDT_STATUS_REG); 
	val = (val >> 2) & 1;
	if ( !val )
		printk(KERN_INFO PFX "sorry, was my fault\n");

	init_MUTEX_LOCKED(&cpu5wdt_device.stop);
	cpu5wdt_device.queue = 0;
	cpu5wdt_device.min_ticks = ticks;

	clear_bit(0, &cpu5wdt_device.inuse);

	platform_device_register(&cpu5wdt_device.dev);
	device_create_file(&cpu5wdt_device.dev.dev, &dev_attr_statistics);

	init_timer(&cpu5wdt_device.timer);
	cpu5wdt_device.timer.function = cpu5wdt_trigger;
	cpu5wdt_device.timer.data = 0;

	cpu5wdt_device.default_ticks = ticks;

	printk(KERN_INFO PFX "init success\n");

	return 0;

no_port:
	misc_deregister(&cpu5wdt_misc);
no_misc:
	return err;
}

static int __devinit cpu5wdt_init_module(void)
{
	return cpu5wdt_init();
}

static void __devexit cpu5wdt_exit(void)
{
	if ( cpu5wdt_device.queue ) {
		cpu5wdt_device.queue = 0;
		down(&cpu5wdt_device.stop);
	}

	platform_device_unregister(&cpu5wdt_device.dev);
	device_remove_file(&cpu5wdt_device.dev.dev, &dev_attr_statistics);
	misc_deregister(&cpu5wdt_misc);

	release_region(port, CPU5WDT_EXTENT);

}

static void __devexit cpu5wdt_exit_module(void)
{
	cpu5wdt_exit();
}

/* module entry points */

module_init(cpu5wdt_init_module);
module_exit(cpu5wdt_exit_module);

MODULE_AUTHOR("Heiko Ronsdorf <hero@ihg.uni-duisburg.de>");
MODULE_DESCRIPTION("sma cpu5 watchdog driver");
MODULE_SUPPORTED_DEVICE("sma cpu5 watchdog");
MODULE_LICENSE("GPL");

MODULE_PARM(port, "i");
MODULE_PARM_DESC(port, "base address of watchdog card, default is 0x91");

MODULE_PARM(verbose, "i");
MODULE_PARM_DESC(verbose, "be verbose, default is 0 (no)");

MODULE_PARM(ticks, "i");
MODULE_PARM_DESC(ticks, "count down ticks, default is 10000");

EXPORT_NO_SYMBOLS;


