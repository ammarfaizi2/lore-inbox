Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSJJMzI>; Thu, 10 Oct 2002 08:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJJMzI>; Thu, 10 Oct 2002 08:55:08 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:10921 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP
	id <S261613AbSJJMy6>; Thu, 10 Oct 2002 08:54:58 -0400
Message-ID: <3DA98AF7.2020600@free.fr>
Date: Sun, 13 Oct 2002 17:02:15 +0200
From: =?ISO-8859-1?Q?Romain_Li=E9vin?= <rlievin@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Tim Waugh <tim@cyberelk.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel 2.5.41, tipar: parallel link cable driver for Texas
 Instruments graphing calculators
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I sent you a patch for a 2.5.41 kernel.

This is a new driver which uses parport for handling a parallel link
cable designed to connect a Texas Instruments graphing calculators to a
computer/workstation.

This driver has assigned device numbers.

Regards, Romain.
_
==============================[ cut here ]==============================
--- linux-2.5.41.orig/MAINTAINERS	Sun Oct 13 13:12:46 2002
+++ linux/MAINTAINERS	Sun Oct 13 14:08:36 2002
@@ -1593,6 +1593,11 @@
  M:	jb@technologeek.org
  S:	Maintained

+TI PARALLEL LINK CABLE DRIVER
+P:     Romain Lievin
+M:     roms@lpg.ticalc.org
+S:     Maintained
+
  TIEMAN VOYAGER USB BRAILLE DISPLAY DRIVER
  P:	Stephane Dalton
  M:	sdalton@videotron.ca
--- linux-2.5.41.orig/drivers/char/Config.help	Sun Oct 13 13:12:47 2002
+++ linux/drivers/char/Config.help	Sun Oct 13 14:04:34 2002
@@ -1033,3 +1033,24 @@

    If compiled as a module, it will be called scx200_gpio.o.

+Texas Instruments parallel link cable support
+CONFIG_TIPAR
+  If you own a Texas Instruments graphing calculator and use a
+  parallel link cable, then you might be interested in this driver.
+
+  If you enable this driver, you will be able to communicate with
+  your calculator through a set of device nodes under /dev. The
+  main advantage of this driver is that you don't have to be root
+  to use this precise link cable (depending on the permissions on
+  the device nodes, though).
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called tipar.o. If you want to compile it as a
+  module, say M here and read Documentation/modules.txt.
+
+  If you don't know what a parallel link cable is or what a Texas
+  Instruments graphing calculator is, then you probably don't need this
+  driver.
+
+  If unsure, say N.
\ No newline at end of file
--- linux-2.5.41.orig/drivers/char/Config.in	Sun Oct 13 13:12:47 2002
+++ linux/drivers/char/Config.in	Sun Oct 13 14:05:45 2002
@@ -80,6 +80,7 @@
        bool '  Support for console on line printer' CONFIG_LP_CONSOLE
     fi
     dep_tristate 'Support for user-space parallel port device drivers' CONFIG_PPDEV $CONFIG_PARPORT
+   dep_tristate 'Texas Instruments parallel link cable support' CONFIG_TIPAR $CONFIG_PARPORT
  fi
  if [ "$CONFIG_PPC_PSERIES" = "y" ]; then
     bool 'pSeries Hypervisor Virtual Console support' CONFIG_HVC_CONSOLE
--- linux-2.5.41.orig/drivers/char/Makefile	Sun Oct 13 13:12:47 2002
+++ linux/drivers/char/Makefile	Sun Oct 13 14:06:37 2002
@@ -50,6 +50,7 @@
  obj-$(CONFIG_RAW_DRIVER) += raw.o

  obj-$(CONFIG_PRINTER) += lp.o
+obj-$(CONFIG_TIPAR) += tipar.o

  obj-$(CONFIG_BUSMOUSE) += busmouse.o
  obj-$(CONFIG_DTLK) += dtlk.o
--- linux-2.5.41.orig/drivers/char/tipar.c	Sun Oct 13 14:11:31 2002
+++ linux/drivers/char/tipar.c	Sun Oct 13 16:57:28 2002
@@ -0,0 +1,541 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * tipar - low level driver for handling a parallel link cable designed
+ * for Texas Instruments graphing calculators (http://lpg.ticalc.org).
+ * A part of the TiLP project.
+ *
+ * Copyright (C) 2000-2002, Romain Lievin <roms@lpg.ticalc.org>
+ * under the terms of the GNU General Public License.
+ *
+ * Various fixes & clean-up from the Linux Kernel Mailing List
+ * (Alan Cox, Richard B. Johnson, Christoph Hellwig).
+ */
+
+/* This driver should, in theory, work with any parallel port that has an
+ * appropriate low-level driver; all I/O is done through the parport
+ * abstraction layer.
+ *
+ * If this driver is built into the kernel, you can configure it using the
+ * kernel command-line.  For example:
+ *
+ *      tipar=timeout,delay       (set timeout and delay)
+ *
+ * If the driver is loaded as a module, similar functionality is available
+ * using module parameters.  The equivalent of the above commands would be:
+ *
+ *      # insmod tipar timeout=15 delay=10
+ */
+
+/* COMPATIBILITY WITH OLD KERNELS
+ *
+ * Usually, parallel cables were bound to ports at
+ * particular I/O addresses, as follows:
+ *
+ *      tipar0             0x378
+ *      tipar1             0x278
+ *      tipar2             0x3bc
+ *
+ *
+ * This driver, by default, binds tipar devices according to parport and
+ * the minor number.
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
+#include <linux/delay.h>
+#include <linux/fcntl.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <linux/devfs_fs_kernel.h>	/* DevFs support */
+#include <linux/parport.h>	/* Our code depend on parport */
+
+/*
+ * TI definitions
+ */
+#include <linux/ticable.h>
+
+/*
+ * Version Information
+ */
+#define DRIVER_VERSION "1.17"
+#define DRIVER_AUTHOR  "Romain Lievin <roms@lpg.ticalc.org>"
+#define DRIVER_DESC    "Device driver for TI/PC parallel link cables"
+#define DRIVER_LICENSE "GPL"
+
+#define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
+#if LINUX_VERSION_CODE < VERSION(2,5,0)
+# define minor(x) MINOR(x)
+# define need_resched() (current->need_resched)
+#endif
+
+/* ----- global variables --------------------------------------------- */
+
+struct tipar_struct {
+ 
struct pardevice *dev;	/* Parport device entry */
+};
+
+#define PP_NO 3
+static struct tipar_struct table[PP_NO];
+
+static int delay = IO_DELAY;	/* inter-bit delay in microseconds */
+static int timeout = TIMAXTIME;	/* timeout in tenth of seconds     */
+
+static devfs_handle_t devfs_handle;
+static unsigned int tp_count;	/* tipar count */
+static unsigned long opened;	/* opened devices */
+
+/* --- macros for parport access -------------------------------------- */
+
+#define r_dtr(x)        (parport_read_data(table[(x)].dev->port))
+#define r_str(x)        (parport_read_status(table[(x)].dev->port))
+#define w_ctr(x,y)      (parport_write_control(table[(x)].dev->port, (y)))
+#define w_dtr(x,y)      (parport_write_data(table[(x)].dev->port, (y)))
+
+/* --- setting states on the D-bus with the right timing: ------------- */
+
+static inline void
+outbyte(int value, int minor)
+{
+ 
w_dtr(minor, value);
+}
+
+static inline int
+inbyte(int minor)
+{
+ 
return (r_str(minor));
+}
+
+static inline void
+init_ti_parallel(int minor)
+{
+ 
outbyte(3, minor);
+}
+
+/* ----- global defines ----------------------------------------------- */
+
+#define START(x) { x=jiffies+HZ/(timeout/10); }
+#define WAIT(x)  { \
+  if (time_before((x), jiffies)) return -1; \
+  if (need_resched()) schedule(); }
+
+/* ----- D-bus bit-banging functions ---------------------------------- */
+
+/* D-bus protocol (45kbit/s max):
+                    1                 0                      0
+       _______        ______|______    __________|________    __________
+Red  :        ________      |      ____          |        ____
+       _        ____________|________      ______|__________       _____
+White:  ________            |        ______      |          _______
+*/
+
+/* Try to transmit a byte on the specified port (-1 if error). */
+static int
+put_ti_parallel(int minor, unsigned char data)
+{
+ 
int bit;
+ 
unsigned long max;
+
+ 
for (bit = 0; bit < 8; bit++) {
+ 
	if (data & 1) {
+ 
		outbyte(2, minor);
+ 
		START(max);
+ 
		do {
+ 
			WAIT(max);
+ 
		} while (inbyte(minor) & 0x10);
+
+ 
		outbyte(3, minor);
+ 
		START(max);
+ 
		do {
+ 
			WAIT(max);
+ 
		} while (!(inbyte(minor) & 0x10));
+ 
	} else {
+ 
		outbyte(1, minor);
+ 
		START(max);
+ 
		do {
+ 
			WAIT(max);
+ 
		} while (inbyte(minor) & 0x20);
+
+ 
		outbyte(3, minor);
+ 
		START(max);
+ 
		do {
+ 
			WAIT(max);
+ 
		} while (!(inbyte(minor) & 0x20));
+ 
	}
+
+ 
	data >>= 1;
+ 
	udelay(delay);
+
+ 
	if (need_resched())
+ 
		schedule();
+ 
}
+
+ 
return 0;
+}
+
+/* Receive a byte on the specified port or -1 if error. */
+static int
+get_ti_parallel(int minor)
+{
+ 
int bit;
+ 
unsigned char v, data = 0;
+ 
unsigned long max;
+
+ 
for (bit = 0; bit < 8; bit++) {
+ 
	START(max);
+ 
	do {
+ 
		WAIT(max);
+ 
	} while ((v = inbyte(minor) & 0x30) == 0x30);
+
+ 
	if (v == 0x10) {
+ 
		data = (data >> 1) | 0x80;
+ 
		outbyte(1, minor);
+ 
		START(max);
+ 
		do {
+ 
			WAIT(max);
+ 
		} while (!(inbyte(minor) & 0x20));
+ 
		outbyte(3, minor);
+ 
	} else {
+ 
		data = data >> 1;
+ 
		outbyte(2, minor);
+ 
		START(max);
+ 
		do {
+ 
			WAIT(max);
+ 
		} while (!(inbyte(minor) & 0x10));
+ 
		outbyte(3, minor);
+ 
	}
+
+ 
	udelay(delay);
+ 
	if (need_resched())
+ 
		schedule();
+ 
}
+
+ 
return (int) data;
+}
+
+/* Try to detect a parallel link cable on the specified port */
+static int
+probe_ti_parallel(int minor)
+{
+ 
int i;
+ 
int seq[] = { 0x00, 0x20, 0x10, 0x30 };
+
+ 
for (i = 3; i >= 0; i--) {
+ 
	outbyte(3, minor);
+ 
	outbyte(i, minor);
+ 
	udelay(delay);
+ 
	/*printk(KERN_DEBUG "Probing -> %i: 0x%02x 0x%02x\n", i, data & 0x30, seq[i]); */
+ 
	if ((inbyte(minor) & 0x30) != seq[i]) {
+ 
		outbyte(3, minor);
+ 
		return -1;
+ 
	}
+ 
}
+
+ 
outbyte(3, minor);
+ 
return 0;
+}
+
+/* ----- kernel module functions--------------------------------------- */
+
+static int
+tipar_open(struct inode *inode, struct file *file)
+{
+ 
unsigned int minor = minor(inode->i_rdev) - TIPAR_MINOR;
+
+ 
if (minor > tp_count - 1)
+ 
	return -ENXIO;
+
+ 
if (test_and_set_bit(minor, &opened))
+ 
	return -EBUSY;
+
+ 
parport_claim_or_block(table[minor].dev);
+ 
init_ti_parallel(minor);
+ 
parport_release(table[minor].dev);
+
+ 
return 0;
+}
+
+static int
+tipar_close(struct inode *inode, struct file *file)
+{
+ 
unsigned int minor = minor(inode->i_rdev) - TIPAR_MINOR;
+
+ 
if (minor > tp_count - 1)
+ 
	return -ENXIO;
+
+ 
clear_bit(minor, &opened);
+
+ 
return 0;
+}
+
+static ssize_t
+tipar_write(struct file *file, const char *buf, size_t count, loff_t * ppos)
+{
+ 
unsigned int minor =
+ 
     minor(file->f_dentry->d_inode->i_rdev) - TIPAR_MINOR;
+ 
ssize_t n;
+
+ 
printk("_write\n");
+ 
parport_claim_or_block(table[minor].dev);
+
+ 
for (n = 0; n < count; n++) {
+ 
	unsigned char b;
+
+ 
	if (get_user(b, buf + n)) {
+ 
		n = -EFAULT;
+ 
		goto out;
+ 
	}
+
+ 
	if (put_ti_parallel(minor, b) == -1) {
+ 
		init_ti_parallel(minor);
+ 
		n = -ETIMEDOUT;
+ 
		goto out;
+ 
	}
+ 
}
+      out:
+ 
parport_release(table[minor].dev);
+ 
return n;
+}
+
+static ssize_t
+tipar_read(struct file *file, char *buf, size_t count, loff_t * ppos)
+{
+ 
int b = 0;
+ 
unsigned int minor =
+ 
     minor(file->f_dentry->d_inode->i_rdev) - TIPAR_MINOR;
+ 
ssize_t retval = 0;
+ 
ssize_t n = 0;
+
+ 
if (count == 0)
+ 
	return 0;
+
+ 
if (ppos != &file->f_pos)
+ 
	return -ESPIPE;
+
+ 
printk("_read\n");
+ 
parport_claim_or_block(table[minor].dev);
+
+ 
while (n < count) {
+ 
	b = get_ti_parallel(minor);
+ 
	if (b == -1) {
+ 
		init_ti_parallel(minor);
+ 
		retval = -ETIMEDOUT;
+ 
		goto out;
+ 
	} else {
+ 
		if (put_user(b, ((unsigned char *) buf) + n)) {
+ 
			retval = -EFAULT;
+ 
			break;
+ 
		} else
+ 
			retval = ++n;
+ 
	}
+
+ 
	/* Non-blocking mode : try again ! */
+ 
	if (file->f_flags & O_NONBLOCK) {
+ 
		retval = -EAGAIN;
+ 
		goto out;
+ 
	}
+
+ 
	/* Signal pending, try again ! */
+ 
	if (signal_pending(current)) {
+ 
		retval = -ERESTARTSYS;
+ 
		goto out;
+ 
	}
+
+ 
	if (need_resched())
+ 
		schedule();
+ 
}
+
+      out:
+ 
parport_release(table[minor].dev);
+ 
return retval;
+}
+
+static int
+tipar_ioctl(struct inode *inode, struct file *file,
+ 
     unsigned int cmd, unsigned long arg)
+{
+ 
int retval = 0;
+
+ 
switch (cmd) {
+ 
case IOCTL_TIPAR_DELAY:
+ 
   delay = (int)arg;    //get_user(delay, &arg);
+ 
   break;
+ 
case IOCTL_TIPAR_TIMEOUT:
+ 
   timeout = (int)arg;  //get_user(timeout, &arg);
+ 
   break;
+ 
default:
+ 
	retval = -ENOTTY;
+ 
	break;
+ 
}
+
+ 
return retval;
+}
+
+/* ----- kernel module registering ------------------------------------ */
+
+static struct file_operations tipar_fops = {
+ 
owner:THIS_MODULE,
+ 
llseek:no_llseek,
+ 
read:tipar_read,
+ 
write:tipar_write,
+ 
ioctl:tipar_ioctl,
+ 
open:tipar_open,
+ 
release:tipar_close,
+};
+
+/* --- initialisation code ------------------------------------- */
+
+#ifndef MODULE
+/*      You must set these - there is no sane way to probe for this cable.
+ *      You can use 'tipar=timeout,delay' to set these now. */
+static int __init
+tipar_setup(char *str)
+{
+ 
int ints[2];
+
+ 
str = get_options(str, ARRAY_SIZE(ints), ints);
+
+ 
if (ints[0] > 0) {
+ 
	timeout = ints[1];
+ 
	if (ints[0] > 1) {
+ 
		delay = ints[2];
+ 
	}
+ 
}
+
+ 
return 1;
+}
+#endif
+
+/*
+ * Register our module into parport.
+ * Pass also 2 callbacks functions to parport: a pre-emptive function and an
+ * interrupt handler function (unused).
+ * Display a message such "tipar0: using parport0 (polling)".
+ */
+static int
+tipar_register(int nr, struct parport *port)
+{
+ 
char name[8];
+
+ 
/* Register our module into parport */
+ 
table[nr].dev = parport_register_device(port, "tipar",
+ 
					NULL, NULL, NULL, 0,
+ 
					(void *) &table[nr]);
+
+ 
if (table[nr].dev == NULL)
+ 
	return 1;
+
+ 
/* Use devfs, tree: /dev/ticables/par/[0..2] */
+ 
sprintf(name, "%d", nr);
+ 
printk
+ 
     ("tipar: registering to devfs : major = %d, minor = %d, node = %s\n",
+ 
      TISER_MAJOR, (TIPAR_MINOR + nr), name);
+ 
devfs_register(devfs_handle, name, DEVFS_FL_DEFAULT, TIPAR_MAJOR,
+ 
	       TIPAR_MINOR + nr, S_IFCHR | S_IRUGO | S_IWUGO,
+ 
	       &tipar_fops, NULL);
+
+ 
/* Display informations */
+ 
printk(KERN_INFO "tipar%d: using %s (%s).\n", nr, port->name,
+ 
        (port->irq ==
+ 
	PARPORT_IRQ_NONE) ? "polling" : "interrupt-driven");
+
+ 
if (probe_ti_parallel(nr) != -1)
+ 
	printk("tipar%d: link cable found !\n", nr);
+ 
else
+ 
	printk("tipar%d: link cable not found.\n", nr);
+
+ 
return 0;
+}
+
+static void
+tipar_attach(struct parport *port)
+{
+ 
if (tp_count == PP_NO) {
+ 
	printk("tipar: ignoring parallel port (max. %d)\n", PP_NO);
+ 
	return;
+ 
}
+
+ 
if (!tipar_register(tp_count, port))
+ 
	tp_count++;
+}
+
+static void
+tipar_detach(struct parport *port)
+{
+ 
/* Nothing to do */
+}
+
+static struct parport_driver tipar_driver = {
+ 
"tipar",
+ 
tipar_attach,
+ 
tipar_detach,
+ 
NULL
+};
+
+int __init
+tipar_init_module(void)
+{
+ 
printk("tipar: parallel link cable driver, version %s\n",
+ 
        DRIVER_VERSION);
+
+ 
if (register_chrdev(TIPAR_MAJOR, "tipar", &tipar_fops)) {
+ 
	printk("tipar: unable to get major %d\n", TIPAR_MAJOR);
+ 
	return -EIO;
+ 
}
+
+ 
/* Use devfs with tree: /dev/ticables/par/[0..2] */
+ 
devfs_handle = devfs_mk_dir(NULL, "ticables/par", NULL);
+
+ 
if (parport_register_driver(&tipar_driver)) {
+ 
	printk("tipar: unable to register with parport\n");
+ 
	return -EIO;
+ 
}
+
+ 
return 0;
+}
+
+void __exit
+tipar_cleanup_module(void)
+{
+ 
unsigned int i;
+
+ 
/* Unregistering module */
+ 
parport_unregister_driver(&tipar_driver);
+
+ 
devfs_unregister(devfs_handle);
+ 
unregister_chrdev(TIPAR_MAJOR, "tipar");
+
+ 
for (i = 0; i < PP_NO; i++) {
+ 
	if (table[i].dev == NULL)
+ 
		continue;
+ 
	parport_unregister_device(table[i].dev);
+ 
}
+
+ 
printk("tipar: module unloaded !\n");
+}
+
+/* --------------------------------------------------------------------- */
+
+__setup("tipar=", tipar_setup);
+module_init(tipar_init_module);
+module_exit(tipar_cleanup_module);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE(DRIVER_LICENSE);
+
+EXPORT_NO_SYMBOLS;
+
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "Timeout (default=1.5 seconds)");
+MODULE_PARM(delay, "i");
+MODULE_PARM_DESC(delay, "Inter-bit delay (default=10 microseconds)");

