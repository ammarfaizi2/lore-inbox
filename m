Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUDUQeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUDUQeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbUDUQeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:34:08 -0400
Received: from ra.sai.msu.su ([158.250.29.2]:62848 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S263366AbUDUQdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:33:11 -0400
Date: Wed, 21 Apr 2004 20:32:53 +0400 (MSD)
From: "E.Rodichev" <er@sai.msu.su>
To: linux-kernel@vger.kernel.org
cc: dtor_core@ameritech.net
Subject: [PATCH] Direct /dev/psaux driver and relevant Kconfig changes
Message-ID: <Pine.GSO.4.58.0404212031450.2778@ra.sai.msu.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch incorporates:

- direct /dev/psaux driver  written by Lee Sau Dan nad fixed by
  Tuukka Toivonen;
- drivers/input/Kconfig patch by Dmitry Torokhov (which allows
  disabling legacy psaux device)
- appropriate changes for help section for CONFIG_INPUT_PSAUX

Touchpad at my IBM A21m ThinkPad works fine with tp4d daemon -
kernel 2.6.5 whith this patch applyed, either with driver compiled
as a module or directly.

Evgeny Rodichev


diff -uprN linux-2.6.5/drivers/input/Kconfig linux-2.6.5-psaux/drivers/input/Kconfig
--- linux-2.6.5/drivers/input/Kconfig	2004-04-04 07:36:18.000000000 +0400
+++ linux-2.6.5-psaux/drivers/input/Kconfig	2004-04-21 18:51:28.000000000 +0400
@@ -41,9 +41,15 @@ config INPUT_MOUSEDEV
 	  module will be called mousedev.

 config INPUT_MOUSEDEV_PSAUX
-	bool "Provide legacy /dev/psaux device" if EMBEDDED
+	bool "Provide legacy /dev/psaux device"
 	default y
 	depends on INPUT_MOUSEDEV
+        ---help---
+          Say Y here if you want your mouse also be accessible as char device
+          10:1 - /dev/psaux. The data available through /dev/psaux is exactly
+          the same as the data from /dev/input/mice.
+
+          If unsure, say Y.

 config INPUT_MOUSEDEV_SCREEN_X
 	int "Horizontal screen resolution"
diff -uprN linux-2.6.5/drivers/input/misc/Kconfig linux-2.6.5-psaux/drivers/input/misc/Kconfig
--- linux-2.6.5/drivers/input/misc/Kconfig	2004-04-04 07:36:57.000000000 +0400
+++ linux-2.6.5-psaux/drivers/input/misc/Kconfig	2004-04-21 18:45:20.000000000 +0400
@@ -54,3 +54,37 @@ config INPUT_UINPUT
 	  To compile this driver as a module, choose M here: the
 	  module will be called uinput.

+config INPUT_PSAUX
+	tristate "Direct /dev/psaux driver, bypassing the input layer"
+	depends on INPUT && INPUT_MISC
+	 select SERIO
+	 select SERIO_I8042 if PC
+	help
+	  This driver creates the /dev/psaux device that is compatible
+	  with Linux kernel 2.4 or earlier.  It provides a direct
+	  connection between /dev/psaux and the mouse port, bypassing the
+	  input event layer in kernel 2.6.
+	  This is useful in case you have a device (such as the
+	  touchscreen in my Laptop) that extends the PS/2 mouse
+	  protocol and is already supported in GPM or XFree86,
+	  but not yet in the 2.6 kernel, or you prefer the
+	  driver in GPM or XFree86 to the one in the 2.6 kernel.
+
+	  You should disable legacy /dev/psaux code when using this driver.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called psaux.
+
+config INPUT_PSAUX_DEBUG
+	bool "Print extra debug messages for /dev/psaux"
+	depends on INPUT && INPUT_MISC && INPUT_PSAUX
+	help
+	  Causes the direct /dev/psaux driver to print a lot of
+	  debug messages.  These messages can be suppressed
+	  with the module option "debug=0".
+
+	  This option increases the code size of the module.
+	  Unless you are debugging or helping to debug this
+	  module, you should say N here.
diff -uprN linux-2.6.5/drivers/input/misc/Makefile linux-2.6.5-psaux/drivers/input/misc/Makefile
--- linux-2.6.5/drivers/input/misc/Makefile	2004-04-04 07:37:24.000000000 +0400
+++ linux-2.6.5-psaux/drivers/input/misc/Makefile	2004-04-21 18:45:20.000000000 +0400
@@ -9,3 +9,4 @@ obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_98SPKR)		+= 98spkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
+obj-$(CONFIG_INPUT_PSAUX)		+= psaux.o
diff -uprN linux-2.6.5/drivers/input/misc/psaux.c linux-2.6.5-psaux/drivers/input/misc/psaux.c
--- linux-2.6.5/drivers/input/misc/psaux.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6.5-psaux/drivers/input/misc/psaux.c	2004-04-19 02:42:08.000000000 +0400
@@ -0,0 +1,378 @@
+/*
+ * Direct /dev/psaux driver
+ *
+ * Copyright (c) 2004 Lee Sau Dan <danlee@informatik.uni-freiburg.de>
+ * Modified 2004 by Tuukka Toivonen <tuukkat@ee.oulu.fi>
+ *    - Fixed SMP (original code sleeped with spinlocks held)
+ *    - Reformatted some code (sorry!)
+ *    - Added 'minor' argument
+ *    - Added standalone mode for compilation (kernel patch not required)
+ *
+ * Tested with kernel 2.6.5.
+ *
+ * This module can be now loaded simultaneously with mousedev by
+ * giving a non-standard minor number. However, this is not recommended
+ * and normally you should load only either 'psaux' or ('mousedev' and
+ * 'psmouse'). This requires that mousedev has been compiled as module.
+ * This can be only done if 'General Setup/Remove kernel features'
+ * has been selected (CONFIG_EMBEDDED).
+ * In any case, 'psmouse' conflicts with this module and must not
+ * be loaded simultaneously.
+ *
+ * Note: parts of this file are adapted from
+ *      linux/drivers/input/mousedev.c
+ *                                Copyright (c) 1999-2002 Vojtech Pavlik
+ *  and linux/drivers/input/mouse/psmouse-base.c
+ *                                Copyright (c) 1999-2002 Vojtech Pavlik
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/* {{{ [fold] Includes */
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/major.h>
+#include <linux/device.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/wait.h>
+/* }}} */
+
+MODULE_AUTHOR("Tuukka Toivonen <tuukkat@ee.oulu.fi>");
+MODULE_DESCRIPTION("Direct /dev/psaux driver");
+MODULE_LICENSE("GPL");
+
+#ifdef NOKERNEL		/* Building stand-alone module */
+#undef CONFIG_INPUT_PSAUX_DEBUG
+#ifdef DEBUG
+#define CONFIG_INPUT_PSAUX_DEBUG
+#endif
+#endif
+
+#ifdef CONFIG_INPUT_PSAUX_DEBUG
+
+/* Debugging code enabled */
+static int debug = 1;
+module_param(debug, bool, 0);
+MODULE_PARM_DESC(debug, "Enable debug messages (default=1)");
+#define PSAUX_DEBUG debug
+#define PARANOID 1
+static unsigned int psaux_dropped = 0;
+static unsigned int psaux_readen  = 0;
+static unsigned int psaux_written = 0;
+
+#else
+
+/* Debugging code disabled */
+#define PSAUX_DEBUG 0
+#define PARANOID 0
+
+#endif
+
+static int minor = PSMOUSE_MINOR;
+module_param(minor, int, 0);
+MODULE_PARM_DESC(minor, "Minor number (default=1, dynamic=255)");
+
+#define BUFFER_SIZE 64					/* Should be integer power of 2 for efficiency */
+#define BUFFER_BYTES ((psaux_buffer_head-psaux_buffer_tail) % BUFFER_SIZE)
+static unsigned char psaux_buffer[BUFFER_SIZE];		/* Buffer where to save received bytes */
+volatile static unsigned int psaux_buffer_head;		/* Position in buffer to write next received byte */
+static unsigned int psaux_buffer_tail;			/* Position in buffer from which to read next byte */
+static struct serio *psaux_serio = NULL;		/* The serio device into which the driver is attached to */
+static int psaux_users = 0;				/* Number of opens() of the psaux device */
+static DECLARE_MUTEX(psaux_mutex);			/* Mutex protecting psaux_users and psaux_buffer_tail */
+static DECLARE_WAIT_QUEUE_HEAD(psaux_wq);		/* Kernel mode processes waiting for new data in psaux_buffer sit here */
+static struct fasync_struct *psaux_fasync_s = NULL;	/* User mode processes waiting for new data sit here */
+
+
+/*
+ * First, the interface with 'serio'
+ */
+/* {{{ [fold] irqreturn_t psaux_interrupt(serio,data,flags,regs) */
+/* psaux_interrupt() handles incoming characters,
+ * which are stored for psaux_read(). */
+static irqreturn_t psaux_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags, struct pt_regs *regs)
+{
+	unsigned int head, new_head;
+	if (PSAUX_DEBUG) {
+		printk(KERN_DEBUG "psaux: interrupt\n");
+		printk(KERN_DEBUG "psaux: got %02x, avail=%d, tail=%d, head=%d\n", data, BUFFER_BYTES, psaux_buffer_tail, psaux_buffer_head);
+	}
+	if (PARANOID && psaux_users<=0) {				/* Why am I called in this case? */
+		printk(KERN_WARNING "psaux: ignoring unexpected interrupt\n");
+		return IRQ_NONE;
+	}
+
+	head = psaux_buffer_head;
+	if (PARANOID && head>=BUFFER_SIZE) { printk(KERN_CRIT "psaux: bad head value\n"); BUG(); }
+	new_head = (head + 1) % BUFFER_SIZE;			/* Needs not to be re-entrant, as interrupts don't nest */
+	if (psaux_buffer_tail != new_head) {
+		psaux_buffer[head] = data;			/* data must be written before buffer_head is updated */
+		psaux_buffer_head = new_head;
+	} else {
+#ifdef CONFIG_INPUT_PSAUX_DEBUG
+		psaux_dropped++;
+#endif
+		printk(KERN_WARNING "psaux: buffer overflow, dropping byte %02x\n", data);
+	}
+	kill_fasync(&psaux_fasync_s, SIGIO, POLL_IN);		/* Wake up user... */
+	wake_up(&psaux_wq);					/* ...and kernel mode processes */
+	return IRQ_HANDLED;
+}
+/* }}} */
+/* {{{ [fold] void psaux_connect(struct serio *serio, struct serio_dev *dev) */
+/* psaux_connect() is a callback from the serio module when
+ * an unhandled serio port is found. */
+static void psaux_connect(struct serio *serio, struct serio_dev *dev)
+{
+	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
+	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
+		return;
+	if (psaux_serio) {
+		if (PSAUX_DEBUG) printk(KERN_WARNING "psaux: ignoring extra port %s\n", serio->phys);
+		return;
+	}
+	if (serio_open(serio, dev)) {
+		if (PSAUX_DEBUG) printk(KERN_WARNING "psaux: serio_open failed at port %s\n", serio->phys);
+		return;
+	}
+	psaux_serio = serio;
+	if (PSAUX_DEBUG) printk(KERN_INFO "psaux: attached to %s\n", psaux_serio->phys);
+}
+/* }}} */
+/* {{{ [fold] void psaux_disconnect(struct serio *serio) */
+/* psaux_disconnect() disconnects from serio device.*/
+static void psaux_disconnect(struct serio *serio)
+{
+	if (PARANOID && psaux_serio!=serio) { printk(KERN_CRIT "psaux: asked to disconnect from %s, which I didn't connect to!\n", serio->phys); BUG(); }
+	psaux_serio = NULL;
+	serio_close(serio);
+	if (PSAUX_DEBUG) printk(KERN_INFO "psaux: detached from %s\n", serio->phys);
+}
+/* }}} */
+/* {{{ [fold] int psaux_sendbyte(unsigned char byte) */
+/* psaux_sendbyte() sends a byte to the mouse */
+static inline int psaux_sendbyte(unsigned char byte)
+{
+	if (!psaux_serio)
+		return -ENODEV;
+	if (serio_write(psaux_serio, byte))
+		return -ENXIO;
+#ifdef CONFIG_INPUT_PSAUX_DEBUG
+	psaux_written++;				/* May have a race condition, but I don't care */
+#endif
+	return 0;
+}
+/* }}} */
+
+static struct serio_dev psaux_dev = {
+	.interrupt =	psaux_interrupt,
+	.connect =	psaux_connect,
+	.disconnect =	psaux_disconnect,
+};
+
+/*
+ * Now comes the interface of /dev/psaux with userland
+ */
+/* {{{ [fold] int psaux_fasync(int fd, struct file *file, int on) */
+static int psaux_fasync(int fd, struct file *file, int on)
+{
+	int retval;
+	if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: fasync, avail=%d\n", BUFFER_BYTES);
+	retval = fasync_helper(fd, file, on, &psaux_fasync_s);
+	return retval<0 ? retval : 0;
+}
+/* }}} */
+/* {{{ [fold] int psaux_open(struct inode *inode, struct file *file) */
+static int psaux_open(struct inode *inode, struct file *file)
+{
+	int retval = 0;
+
+	if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: /dev/psaux opened\n");
+	if (PARANOID && (imajor(inode)!=MISC_MAJOR /*|| iminor(inode)!=psaux_misc.minor*/)) { printk(KERN_CRIT "psaux: bad device\n"); BUG(); }
+
+	retval = down_interruptible(&psaux_mutex);
+	if (retval) return retval;
+
+	if (psaux_users++ == 0) {
+		psaux_buffer_head = 0;
+		psaux_buffer_tail = 0;
+		serio_register_device(&psaux_dev);
+		if (PSAUX_DEBUG && !psaux_serio) printk(KERN_WARNING "psaux: can not find suitable serial port\n");
+	}
+
+	up(&psaux_mutex);
+	return retval;
+}
+/* }}} */
+/* {{{ [fold] int psaux_release(struct inode *inode, struct file *file) */
+static int psaux_release(struct inode *inode, struct file *file)
+{
+	down(&psaux_mutex);
+	psaux_fasync(-1, file, 0);
+	if (--psaux_users == 0)
+		serio_unregister_device(&psaux_dev);
+	if (PARANOID && psaux_users<0) { printk(KERN_CRIT "psaux: closing closed file\n"); BUG(); }
+	if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: /dev/psaux closed\n");
+	up(&psaux_mutex);
+	return 0;
+}
+/* }}} */
+/* {{{ [fold] ssize_t psaux_read(struct file *file, char *buffer, size_t count, loff_t *ppos) */
+static ssize_t psaux_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
+{
+	int retval = 0;
+	unsigned int bytes_to_copy;
+	unsigned int head, tail;
+
+	if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: trying to read %d bytes\n", count);
+	if (count<=0) goto out;
+
+	retval = down_interruptible(&psaux_mutex);
+	if (retval) goto out;
+
+	/* Make sure that there are at least some bytes to read */
+	while (psaux_buffer_head==psaux_buffer_tail) {
+		if ((file->f_flags & O_NONBLOCK)) {
+			retval = -EAGAIN;
+			goto out_up;
+		}
+		if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: waiting for more bytes\n");
+		up(&psaux_mutex);
+		retval = wait_event_interruptible(psaux_wq, psaux_buffer_head!=psaux_buffer_tail);
+		if (retval) goto out;
+		retval = down_interruptible(&psaux_mutex);
+		if (retval) goto out;
+		/* If there were several processes reading, we still might not have any data */
+	}
+
+	/* There is at least one byte available, copy to user space */
+	head = psaux_buffer_head;
+	tail = psaux_buffer_tail;
+	do {
+		bytes_to_copy = head>tail ? head-tail : BUFFER_SIZE-tail;
+		if (bytes_to_copy>count) bytes_to_copy = count;
+		if (copy_to_user(buffer, &psaux_buffer[tail], bytes_to_copy)) {
+			retval = -EFAULT;
+			goto out_up;
+		}
+		if (PSAUX_DEBUG) {
+			int i;
+			for (i=0; i<bytes_to_copy; i++) {
+				printk(KERN_DEBUG "psaux: read %02x, tail=%d, head=%d\n", psaux_buffer[tail+i], tail, head);
+			}
+		}
+#ifdef CONFIG_INPUT_PSAUX_DEBUG
+		psaux_readen += bytes_to_copy;
+#endif
+		retval += bytes_to_copy;
+		buffer += bytes_to_copy;
+		count -= bytes_to_copy;
+		tail = (tail + bytes_to_copy) % BUFFER_SIZE;
+		psaux_buffer_tail = tail;
+		head = psaux_buffer_head;
+	} while (head!=tail && count>0);
+
+out_up:	up(&psaux_mutex);
+out:	if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: read done, return %d\n", retval);
+	return retval;
+}
+/* }}} */
+/* {{{ [fold] ssize_t psaux_write(struct file *file, const char *buffer, size_t count, loff_t *ppos) */
+static ssize_t psaux_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
+{
+	int retval;
+	unsigned char c;
+	size_t remaining;
+
+	for (remaining=count; remaining>0; remaining--, buffer++) {
+		retval = get_user(c, buffer);
+		if (retval) return retval;
+		retval = psaux_sendbyte(c);
+		if (retval) return retval;
+		if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: written %02x\n", c);
+	}
+	if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: written %d bytes\n", count);
+	return count;
+}
+/* }}} */
+/* {{{ [fold] unsigned int psaux_poll(struct file *file, poll_table *wait) */
+static unsigned int psaux_poll(struct file *file, poll_table *wait)
+{
+	/* No mutex - fine */
+	if (PSAUX_DEBUG) printk(KERN_DEBUG "psaux: poll, avail=%d\n", BUFFER_BYTES);
+	poll_wait(file, &psaux_wq, wait);
+	if (psaux_buffer_head!=psaux_buffer_tail)
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+/* }}} */
+
+struct file_operations psaux_fops = {
+	.owner =	THIS_MODULE,
+	.open =		psaux_open,
+	.release =	psaux_release,
+	.read =		psaux_read,
+	.write =	psaux_write,
+	.poll =		psaux_poll,
+	.fasync =	psaux_fasync,
+};
+static struct miscdevice psaux_misc = {
+	.name =		"psaux_direct",
+	.fops =		&psaux_fops,
+};
+
+/* {{{ [fold] int __init psaux_init(void) */
+static int __init psaux_init(void)
+{
+	int retval = 0;
+
+	printk(KERN_INFO "psaux: direct /dev/psaux device\n");
+
+	psaux_misc.minor = minor;
+	retval = misc_register(&psaux_misc);
+	if (retval) {
+		printk(KERN_WARNING "psaux: could not misc_register the device with minor %d: aborting\n", minor);
+		return retval;
+	}
+
+#ifdef CONFIG_INPUT_PSAUX_DEBUG
+	if (PSAUX_DEBUG) printk(KERN_INFO "psaux: registered minor %i\n", psaux_misc.minor);
+	if (debug)
+		printk(KERN_INFO "psaux: debug messages enabled (use debug=0 to suppress)\n");
+	else
+		printk(KERN_INFO "psaux: debug messages suppressed\n");
+#endif
+
+	return retval;
+}
+/* }}} */
+/* {{{ [fold] void psaux_exit(void) */
+static void __exit psaux_exit(void)
+{
+	int retval;
+
+	retval = misc_deregister(&psaux_misc);
+	if (PARANOID && retval) { printk(KERN_CRIT "psaux: failed to deregister misc device\n"); BUG(); }
+#ifdef CONFIG_INPUT_PSAUX_DEBUG
+	printk(KERN_INFO "psaux: statistics: read %d, wrote %d, dropped %d bytes\n", psaux_readen, psaux_written, psaux_dropped);
+#endif
+	printk(KERN_INFO "psaux: unloaded\n");
+}
+/* }}} */
+
+module_init(psaux_init);
+module_exit(psaux_exit);
