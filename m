Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbTBLQPs>; Wed, 12 Feb 2003 11:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbTBLQPs>; Wed, 12 Feb 2003 11:15:48 -0500
Received: from crimson.ihg.uni-duisburg.de ([134.91.82.10]:52665 "EHLO
	crimson.ihg.uni-duisburg.de") by vger.kernel.org with ESMTP
	id <S267191AbTBLQPk>; Wed, 12 Feb 2003 11:15:40 -0500
Date: Wed, 12 Feb 2003 17:25:25 +0100
From: Heiko Ronsdorf <sk048ro@mail.ihg.uni-duisburg.de>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH][DRIVER][RFC] CPU5 watchdog driver for 2.5
Message-ID: <20030212162525.GA23285@mail.ihg.uni-duisburg.de>
Mail-Followup-To: Heiko Ronsdorf <sk048ro@mail.ihg.uni-duisburg.de>,
	Rusty Lynch <rusty@linux.co.intel.com>,
	linux-kernel@vger.kernel.org, mochel@osdl.org
References: <20030210201732.GA25722@mail.ihg.uni-duisburg.de> <1044916408.4724.11.camel@vmhack> <20030211122620.GA10604@mail.ihg.uni-duisburg.de> <1044938295.4726.44.camel@vmhack>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <1044938295.4726.44.camel@vmhack>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



> Here is your cpu5wdt.c file with the procfs stuff replaced with code
> that adds an embedded platform_device to your basic data structure,
> registers the driver as a platform device, and then creates a file
> called $YOUR_SYSFS_ROOT/devices/legacy/watchdog0/statistics that will
> read the same as your original procfs file.  (Or at least I think it
> will.  It at least compiles :->)

>From Documentation/filesystems/sysfs.txt

"Mixing types, expressing mulitple lines of data, and doing fancy
formatting of data is heavily frowned upon. Doing these things may get
you publically humiliated and your code rewritten without notice."

Luckily it wasn't my suggestion. :-)

Well, in the right manner to use sysfs I have to create a file for
each (4) of the variables. So I have to write 4 (!) functions for
reading my vars, and all look similar. :-( This is over-designed for
no (real) functionality in only one driver, I guess. Only two or three
of the other watchdog drivers provide a "read" on some data, so no
code can shared between them.

There should be some functions/MACROS in sysfs to declare a read/write
operation on an single int/long etc.. Something like:

struct attribute {
	char		* name;
	mode_t		mode;
	void *		data;
};

struct device_attribute {
	struct attribute        attr;
	ssize_t (*show)(struct device * dev, char * buf, void * data);
	ssize_t (*store)(struct device * dev, const char * buf, \
			size_t count, void * data);
};

#define DEVICE_INT_ATTR(_name,_str,_mode,_var)	\
struct device_attribute dev_attr_##_name = {	\
	.attr = {.name = __stringify(_name), .mode = _mode, .data = &var }, \
	.show = _default_int_show,		\
	.store = _default_int_store,		\
};

size_t _default_int_show(struct device *dev, char *buf, void *data) {
	return sprintf("%i\n", *(int *)data);
}

static ssize_t
subsys_attr_show(struct kobject * kobj, struct attribute * attr, char * page)
{
	struct subsystem * s = to_subsys(kobj);
	struct subsys_attribute * sattr = to_sattr(attr);
	ssize_t ret = 0;

	if (sattr->show)
		ret = sattr->show(s,page,attr->data);
	return ret;
}

With these [IMHO] it would be easier to make use of sysfs.

Finally, I've decided to remove the procfs code (and keep a patch for
myself) from the watchdog driver.

Heiko

--
Sorry for my denglisch


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpu5wdt-2.5.60-4.diff"

diff -urN linux-vanilla/drivers/char/watchdog/Kconfig linux-patched/drivers/char/watchdog/Kconfig
--- linux-vanilla/drivers/char/watchdog/Kconfig	Tue Feb 11 11:03:51 2003
+++ linux-patched/drivers/char/watchdog/Kconfig	Mon Feb 10 22:02:12 2003
@@ -354,4 +354,14 @@
 	  Documentation/modules.txt. The module will be called
 	  wafer5823wdt.o
 
+config CPU5_WDT
+	tristate "SMA CPU5 Watchdog"
+	depends on WATCHDOG
+	---help---
+	  TBD.
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called cpu5wdt.o.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
 endmenu
diff -urN linux-vanilla/drivers/char/watchdog/Makefile linux-patched/drivers/char/watchdog/Makefile
--- linux-vanilla/drivers/char/watchdog/Makefile	Tue Feb 11 11:03:51 2003
+++ linux-patched/drivers/char/watchdog/Makefile	Mon Feb 10 22:02:12 2003
@@ -29,3 +29,4 @@
 obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
+obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
diff -urN linux-vanilla/drivers/char/watchdog/cpu5wdt.c linux-patched/drivers/char/watchdog/cpu5wdt.c
--- linux-vanilla/drivers/char/watchdog/cpu5wdt.c	Thu Jan  1 01:00:00 1970
+++ linux-patched/drivers/char/watchdog/cpu5wdt.c	Wed Feb 12 00:06:05 2003
@@ -0,0 +1,316 @@
+/*
+ * sma cpu5 watchdog driver
+ *
+ * Copyright (C) 2003 Heiko Ronsdorf <hero@ihg.uni-duisburg.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/timer.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#include <linux/watchdog.h>
+
+/* adjustable parameters */
+
+static int verbose = 0;
+static int port = 0x91;
+static volatile int ticks = 10000;
+
+#define PFX			"cpu5wdt: "
+
+#define CPU5WDT_EXTENT          0x0A
+
+#define CPU5WDT_STATUS_REG      0x00
+#define CPU5WDT_TIME_A_REG      0x02
+#define CPU5WDT_TIME_B_REG      0x03
+#define CPU5WDT_MODE_REG        0x04
+#define CPU5WDT_TRIGGER_REG     0x07
+#define CPU5WDT_ENABLE_REG      0x08
+#define CPU5WDT_RESET_REG       0x09
+
+#define CPU5WDT_INTERVAL	(HZ/10+1)
+
+/* some device data */
+
+static struct {
+	struct semaphore stop;
+	volatile int running;
+	struct timer_list timer;
+	volatile int queue;
+	int default_ticks;
+	int min_ticks;
+	unsigned long inuse;
+} cpu5wdt_device;
+
+/* generic helper functions */
+
+static void cpu5wdt_trigger(unsigned long unused)
+{
+	if ( verbose > 2 )
+		printk(KERN_DEBUG PFX "trigger at %i ticks\n", ticks);
+
+	if( cpu5wdt_device.running )
+		ticks--;
+
+	/* keep watchdog alive */
+	outb(1, port + CPU5WDT_TRIGGER_REG);
+
+	/* requeue?? */
+	if( cpu5wdt_device.queue && ticks ) {
+		cpu5wdt_device.timer.expires = jiffies + CPU5WDT_INTERVAL;
+		add_timer(&cpu5wdt_device.timer);
+	}
+	else {
+		/* ticks doesn't matter anyway */
+		up(&cpu5wdt_device.stop);
+	}
+
+}
+
+static void cpu5wdt_reset(void)
+{
+	if ( ticks < cpu5wdt_device.min_ticks )
+		cpu5wdt_device.min_ticks = ticks;
+
+	ticks = cpu5wdt_device.default_ticks;
+
+	if ( verbose )
+		printk(KERN_DEBUG PFX "reset (%i ticks)\n", (int) ticks);
+
+}
+
+static void cpu5wdt_start(void)
+{
+	if ( !cpu5wdt_device.queue ) {
+		cpu5wdt_device.queue = 1;
+		outb(0, port + CPU5WDT_TIME_A_REG);  
+		outb(0, port + CPU5WDT_TIME_B_REG);  
+		outb(1, port + CPU5WDT_MODE_REG);
+		outb(0, port + CPU5WDT_RESET_REG);
+		outb(0, port + CPU5WDT_ENABLE_REG);
+		cpu5wdt_device.timer.expires = jiffies + CPU5WDT_INTERVAL;
+		add_timer(&cpu5wdt_device.timer);
+	}
+	/* if process dies, counter is not decremented */
+	cpu5wdt_device.running++;
+}
+
+static int cpu5wdt_stop(void)
+{
+	if ( cpu5wdt_device.running )
+		cpu5wdt_device.running = 0;
+
+	ticks = cpu5wdt_device.default_ticks;
+
+	if ( verbose )
+		printk(KERN_CRIT PFX "stop not possible\n");
+
+	return -EIO;
+}
+
+/* filesystem operations */
+
+static int cpu5wdt_open(struct inode *inode, struct file *file)
+{
+	switch(minor(inode->i_rdev)) {
+		case WATCHDOG_MINOR:
+			if ( test_and_set_bit(0, &cpu5wdt_device.inuse) )
+				return -EBUSY;
+			break;
+		default:
+			return -ENODEV;
+	}
+	return 0;
+
+}
+
+static int cpu5wdt_release(struct inode *inode, struct file *file)
+{
+	if(minor(inode->i_rdev)==WATCHDOG_MINOR) {
+		clear_bit(0, &cpu5wdt_device.inuse);
+	}
+	return 0;
+}
+
+static int cpu5wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	unsigned int value;
+	static struct watchdog_info ident =
+	{
+		.options = WDIOF_CARDRESET,
+		.identity = "CPU5 WDT"
+	};
+  
+	switch(cmd) {
+		case WDIOC_KEEPALIVE:
+			cpu5wdt_reset();
+			break;
+		case WDIOC_GETSTATUS:    
+			value = inb(port + CPU5WDT_STATUS_REG); 
+			value = (value >> 2) & 1;
+			if ( copy_to_user((int *)arg, (int *)&value, sizeof(int)) )
+				return -EFAULT;
+			break;
+		case WDIOC_GETSUPPORT:
+			if ( copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)) )
+				return -EFAULT;
+			break;
+		case WDIOC_SETOPTIONS:
+			if ( copy_from_user(&value, (int *)arg, sizeof(int)) )
+				return -EFAULT;
+			switch(value) {
+				case WDIOS_ENABLECARD:
+					cpu5wdt_start();
+					break;
+				case WDIOS_DISABLECARD:
+					return cpu5wdt_stop();
+				default:
+					return -EINVAL;
+			}
+			break;
+		default:
+    			return -EINVAL;
+	}
+	return 0;
+}
+
+static ssize_t cpu5wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+	if ( !count )
+		return -EIO;
+	
+	cpu5wdt_reset();
+	return count;
+
+}
+
+static struct file_operations cpu5wdt_fops = {
+	.owner		= THIS_MODULE,
+	.ioctl		= cpu5wdt_ioctl,
+	.open		= cpu5wdt_open,
+	.write		= cpu5wdt_write,
+	.release	= cpu5wdt_release,
+};
+
+static struct miscdevice cpu5wdt_misc = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &cpu5wdt_fops
+};
+
+/* init/exit function */
+
+static int __devinit cpu5wdt_init(void)
+{
+	unsigned int val;
+	int err;
+
+	if ( verbose )
+		printk(KERN_DEBUG PFX "port=0x%x, verbose=%i\n", port, verbose);
+
+	if ( (err = misc_register(&cpu5wdt_misc)) < 0 ) {
+		printk(KERN_ERR PFX "misc_register failed\n");
+		goto no_misc;
+	}
+
+	if ( !request_region(port, CPU5WDT_EXTENT, PFX) ) {
+		printk(KERN_ERR PFX "request_region failed\n");
+		err = -EBUSY;
+		goto no_port;
+	}
+
+	/* watchdog reboot? */
+	val = inb(port + CPU5WDT_STATUS_REG); 
+	val = (val >> 2) & 1;
+	if ( !val )
+		printk(KERN_INFO PFX "sorry, was my fault\n");
+
+	init_MUTEX_LOCKED(&cpu5wdt_device.stop);
+	cpu5wdt_device.queue = 0;
+	cpu5wdt_device.min_ticks = ticks;
+
+	clear_bit(0, &cpu5wdt_device.inuse);
+
+	init_timer(&cpu5wdt_device.timer);
+	cpu5wdt_device.timer.function = cpu5wdt_trigger;
+	cpu5wdt_device.timer.data = 0;
+
+	cpu5wdt_device.default_ticks = ticks;
+
+	printk(KERN_INFO PFX "init success\n");
+
+	return 0;
+
+no_port:
+	misc_deregister(&cpu5wdt_misc);
+no_misc:
+	return err;
+}
+
+static int __devinit cpu5wdt_init_module(void)
+{
+	return cpu5wdt_init();
+}
+
+static void __devexit cpu5wdt_exit(void)
+{
+	if ( cpu5wdt_device.queue ) {
+		cpu5wdt_device.queue = 0;
+		down(&cpu5wdt_device.stop);
+	}
+
+	misc_deregister(&cpu5wdt_misc);
+
+	release_region(port, CPU5WDT_EXTENT);
+
+}
+
+static void __devexit cpu5wdt_exit_module(void)
+{
+	cpu5wdt_exit();
+}
+
+/* module entry points */
+
+module_init(cpu5wdt_init_module);
+module_exit(cpu5wdt_exit_module);
+
+MODULE_AUTHOR("Heiko Ronsdorf <hero@ihg.uni-duisburg.de>");
+MODULE_DESCRIPTION("sma cpu5 watchdog driver");
+MODULE_SUPPORTED_DEVICE("sma cpu5 watchdog");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(port, "i");
+MODULE_PARM_DESC(port, "base address of watchdog card, default is 0x91");
+
+MODULE_PARM(verbose, "i");
+MODULE_PARM_DESC(verbose, "be verbose, default is 0 (no)");
+
+MODULE_PARM(ticks, "i");
+MODULE_PARM_DESC(ticks, "count down ticks, default is 10000");
+
+EXPORT_NO_SYMBOLS;

--FCuugMFkClbJLl1L--
