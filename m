Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270929AbTHGVpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271026AbTHGVpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:45:20 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:42401 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270929AbTHGVoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:44:21 -0400
Date: Thu, 7 Aug 2003 23:43:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LIRC list <lirc-list@lists.sourceforge.net>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030807214311.GC211@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059820741.3116.24.camel@laurelin>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the fourth version of my patch for use LIRC drivers under
> 2.5/2.6 kernels.
> 
> As usual, you can find it at
> http://flameeyes.web.ctonet.it/lirc/patch-lirc-20030802.diff.bz2
> 
> I changed the naming scheme, because I tried and the patch applies also
> in earliers and (probably) futures kernels, and call it only
> "patch-lirc.diff" will confuse about the versions. I think a datestamp
> is the best choice for now.

If you want to get this applied to the official tree (I hope you want
;-), you probably should start with smaller patch. I killed all
drivers but lirc_gpio, to make patch smaller/easier to check.

Its now small enough to inline, and that's good. 

Few questions:

* What does "For now don't try to use as static version" comment in
  lirc_gpio mean. Does it only work as a module?

* This looks like it should be integrated with drivers/input. After
  all remote control is just a strange keyboard. What are reasons that
  can't be done?
								Pavel


--- linux/drivers/char/Kconfig	2003-06-15 22:42:37.000000000 +0200
+++ linux-lirc/drivers/char/Kconfig	2003-08-07 22:53:49.000000000 +0200
@@ -591,6 +591,7 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/char/lirc/Kconfig"
 
 menu "Mice"
 
--- linux/drivers/char/Makefile	2003-06-15 22:42:37.000000000 +0200
+++ linux-lirc/drivers/char/Makefile	2003-08-07 22:53:49.000000000 +0200
@@ -7,7 +7,7 @@
 #
 FONTMAPFILE = cp437.uni
 
-obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o
+obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o lirc/
 
 obj-$(CONFIG_VT) += vt_ioctl.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap.o
--- linux/drivers/char/lirc/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-lirc/drivers/char/lirc/Kconfig	2003-08-07 22:57:49.000000000 +0200
@@ -0,0 +1,22 @@
+# LIRC http://lirc.sf.net/
+# Kernel patch by Flameeyes <dgp85@users.sf.net>
+# Check for new patch at http://flameeyes.web.ctonet.it/
+#
+# Thanks to Koos Vriezen <koos.vriezen@xs4all.nl> for the Homebrew support
+
+menu "Linux InfraRed Controller"
+
+config LIRC_SUPPORT
+	bool "Linux InfraRed Controller"
+
+	config LIRC_MAX_DEV
+		int "Maximum LIRC devices"
+		default "2"
+		depends on LIRC_SUPPORT
+
+	config LIRC_GPIO
+		tristate "GPIO Driver"
+		depends on LIRC_SUPPORT && VIDEO_BT848
+
+endmenu
+
--- linux/drivers/char/lirc/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-lirc/drivers/char/lirc/Makefile	2003-08-07 22:57:56.000000000 +0200
@@ -0,0 +1,6 @@
+#
+# Makefile for the lirc drivers
+#
+
+obj-$(CONFIG_LIRC_SUPPORT) += lirc_dev.o
+obj-$(CONFIG_LIRC_GPIO) += lirc_gpio.o
--- linux/drivers/char/lirc/lirc_dev.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-lirc/drivers/char/lirc/lirc_dev.c	2003-08-07 22:53:49.000000000 +0200
@@ -0,0 +1,718 @@
+/*
+ * LIRC base driver
+ *
+ * (L) by Artur Lipowski <alipowski@interia.pl>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * $Id: lirc_dev.c,v 1.25 2003/05/04 09:31:28 ranty Exp $
+ *
+ */
+
+#include <linux/version.h>
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/ioctl.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/smp_lock.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <asm/errno.h>
+#define __KERNEL_SYSCALLS__
+#include <linux/unistd.h>
+#include <linux/init.h>
+
+#include <linux/lirc.h>
+
+#include "lirc_dev.h"
+
+static int debug = 0;
+
+MODULE_PARM(debug,"i");
+
+#define IRCTL_DEV_NAME    "BaseRemoteCtl"
+#define SUCCESS           0
+#define NOPLUG            -1
+#define dprintk           if (debug) printk
+
+#define LOGHEAD           "lirc_dev (%s[%d]): "
+
+struct irctl
+{
+	struct lirc_plugin p;
+	int open;
+
+	struct lirc_buffer *buf;
+
+	int tpid;
+	struct semaphore *t_notify;
+	struct semaphore *t_notify2;
+	int shutdown;
+	long jiffies_to_wait;
+};
+
+DECLARE_MUTEX(plugin_lock);
+
+static struct irctl irctls[CONFIG_LIRC_MAX_DEV];
+static struct file_operations fops;
+
+
+/*  helper function
+ *  initializes the irctl structure
+ */
+static inline void init_irctl(struct irctl *ir)
+{
+	memset(&ir->p, 0, sizeof(struct lirc_plugin));
+	ir->p.minor = NOPLUG;
+
+	ir->tpid = -1;
+	ir->t_notify = NULL;
+	ir->t_notify2 = NULL;
+	ir->shutdown = 0;
+	ir->jiffies_to_wait = 0;
+
+	ir->open = 0;
+}
+
+
+/*  helper function
+ *  reads key codes from plugin and puts them into buffer
+ *  buffer free space is checked and locking performed
+ *  returns 0 on success
+ */
+
+inline static int add_to_buf(struct irctl *ir)
+{
+	unsigned char buf[BUFLEN];
+	unsigned int i;
+
+	if (lirc_buffer_full(ir->buf)) {
+		dprintk(LOGHEAD "buffer overflow\n",
+			ir->p.name, ir->p.minor);
+		return -EOVERFLOW;
+	}
+
+	for (i=0; i < ir->buf->chunk_size; i++) {
+		if (ir->p.get_key(ir->p.data, &buf[i], i)) {
+			return -ENODATA;
+		}
+		dprintk(LOGHEAD "remote code (0x%x) now in buffer\n",
+			ir->p.name, ir->p.minor, buf[i]);
+	}
+
+	/* here is the only point at which we add key codes to the buffer */
+	lirc_buffer_write_1(ir->buf, buf);
+
+	return SUCCESS;
+}
+
+/* main function of the polling thread
+ */
+static int lirc_thread(void *irctl)
+{
+	struct irctl *ir = irctl;
+
+	lock_kernel();
+
+	/* This thread doesn't need any user-level access,
+	 * so get rid of all our resources
+	 */
+	exit_mm(current);
+	exit_files(current);
+	exit_fs(current);
+	current->session = 1;
+	current->pgrp = 1;
+	current->euid = 0;
+	current->tty = NULL;
+	sigfillset(&current->blocked);
+
+	strcpy(current->comm, "lirc_dev");
+
+	unlock_kernel();
+
+	if (ir->t_notify != NULL) {
+		up(ir->t_notify);
+	}
+
+	dprintk(LOGHEAD "poll thread started\n", ir->p.name, ir->p.minor);
+
+	do {
+		if (ir->open) {
+			if (ir->jiffies_to_wait) {
+				current->state = TASK_INTERRUPTIBLE;
+				schedule_timeout(ir->jiffies_to_wait);
+			} else {
+				interruptible_sleep_on(ir->p.get_queue(ir->p.data));
+			}
+			if (ir->shutdown) {
+				break;
+			}
+			if (!add_to_buf(ir)) {
+				wake_up_interruptible(&ir->buf->wait_poll);
+			}
+		} else {
+			/* if device not opened so we can sleep half a second */
+			current->state = TASK_INTERRUPTIBLE;
+			schedule_timeout(HZ/2);
+		}
+	} while (!ir->shutdown);
+
+	if (ir->t_notify2 != NULL) {
+		down(ir->t_notify2);
+	}
+
+	ir->tpid = -1;
+	if (ir->t_notify != NULL) {
+		up(ir->t_notify);
+	}
+
+	dprintk(LOGHEAD "poll thread ended\n", ir->p.name, ir->p.minor);
+
+	return 0;
+}
+
+/*
+ *
+ */
+int lirc_register_plugin(struct lirc_plugin *p)
+{
+	struct irctl *ir;
+	int minor;
+	int bytes_in_key;
+	DECLARE_MUTEX_LOCKED(tn);
+
+	if (!p) {
+		printk("lirc_dev: lirc_register_plugin:"
+		       "plugin pointer must be not NULL!\n");
+		return -EBADRQC;
+	}
+
+	if (CONFIG_LIRC_MAX_DEV <= p->minor) {
+		printk("lirc_dev: lirc_register_plugin:"
+		       "\" minor\" must be beetween 0 and %d (%d)!\n",
+		       CONFIG_LIRC_MAX_DEV-1, p->minor);
+		return -EBADRQC;
+	}
+
+	if (1 > p->code_length || (BUFLEN*8) < p->code_length) {
+		printk("lirc_dev: lirc_register_plugin:"
+		       "code length in bits for minor (%d) "
+		       "must be less than %d!\n",
+		       p->minor, BUFLEN*8);
+		return -EBADRQC;
+	}
+
+	printk("lirc_dev: lirc_register_plugin:"
+	       "sample_rate: %d\n",p->sample_rate);
+	if (p->sample_rate) {
+		if (2 > p->sample_rate || 50 < p->sample_rate) {
+			printk("lirc_dev: lirc_register_plugin:"
+			       "sample_rate must be beetween 2 and 50!\n");
+			return -EBADRQC;
+		}
+	} else if (!(p->fops && p->fops->read)
+			&& !p->get_queue && !p->rbuf) {
+		printk("lirc_dev: lirc_register_plugin:"
+		       "fops->read, get_queue and rbuf cannot all be NULL!\n");
+		return -EBADRQC;
+	} else if (!p->rbuf) {
+		if (!(p->fops && p->fops->read && p->fops->poll)
+				|| (!p->fops->ioctl && !p->ioctl)) {
+			printk("lirc_dev: lirc_register_plugin:"
+			       "neither read, poll nor ioctl can be NULL!\n");
+			return -EBADRQC;
+		}
+	}
+
+	down_interruptible(&plugin_lock);
+
+	minor = p->minor;
+
+	if (0 > minor) {
+		/* find first free slot for plugin */
+		for (minor=0; minor<CONFIG_LIRC_MAX_DEV; minor++)
+			if (irctls[minor].p.minor == NOPLUG)
+				break;
+		if (CONFIG_LIRC_MAX_DEV == minor) {
+			printk("lirc_dev: lirc_register_plugin: "
+			       "no free slots for plugins!\n");
+			up(&plugin_lock);
+			return -ENOMEM;
+		}
+	} else if (irctls[minor].p.minor != NOPLUG) {
+		printk("lirc_dev: lirc_register_plugin:"
+		       "minor (%d) just registerd!\n", minor);
+		up(&plugin_lock);
+		return -EBUSY;
+	}
+
+	ir = &irctls[minor];
+
+	if (p->sample_rate) {
+		ir->jiffies_to_wait = HZ / p->sample_rate;
+	} else {
+                /* it means - wait for externeal event in task queue */
+		ir->jiffies_to_wait = 0;
+	}
+
+	/* some safety check 8-) */
+	p->name[sizeof(p->name)-1] = '\0';
+
+	bytes_in_key = p->code_length/8 + (p->code_length%8 ? 1 : 0);
+
+	if (p->rbuf) {
+		ir->buf = p->rbuf;
+	} else {
+		ir->buf = kmalloc(sizeof(struct lirc_buffer), GFP_KERNEL);
+		lirc_buffer_init(ir->buf, bytes_in_key, BUFLEN/bytes_in_key);
+	}
+
+	if (p->features==0)
+		p->features = (p->code_length > 8) ?
+			LIRC_CAN_REC_LIRCCODE : LIRC_CAN_REC_CODE;
+
+	ir->p = *p;
+	ir->p.minor = minor;
+
+	if(p->sample_rate || p->get_queue) {
+		/* try to fire up polling thread */
+		ir->t_notify = &tn;
+		ir->tpid = kernel_thread(lirc_thread, (void*)ir, 0);
+		if (ir->tpid < 0) {
+			up(&plugin_lock);
+			printk("lirc_dev: lirc_register_plugin:"
+			       "cannot run poll thread for minor = %d\n",
+			       p->minor);
+			return -ECHILD;
+		}
+		down(&tn);
+		ir->t_notify = NULL;
+	}
+	up(&plugin_lock);
+
+	try_module_get(THIS_MODULE);
+
+	dprintk("lirc_dev: plugin %s registered at minor number = %d\n",
+		ir->p.name, ir->p.minor);
+
+	return minor;
+}
+
+/*
+ *
+ */
+int lirc_unregister_plugin(int minor)
+{
+	struct irctl *ir;
+	DECLARE_MUTEX_LOCKED(tn);
+	DECLARE_MUTEX_LOCKED(tn2);
+
+	if (minor < 0 || minor >= CONFIG_LIRC_MAX_DEV) {
+		printk("lirc_dev: lirc_unregister_plugin:"
+		       "\" minor\" must be beetween 0 and %d!\n",
+		       CONFIG_LIRC_MAX_DEV-1);
+		return -EBADRQC;
+	}
+
+	ir = &irctls[minor];
+
+	down_interruptible(&plugin_lock);
+
+	if (ir->p.minor != minor) {
+		printk("lirc_dev: lirc_unregister_plugin:"
+		       "minor (%d) device not registered!", minor);
+		up(&plugin_lock);
+		return -ENOENT;
+	}
+
+	if (ir->open) {
+		printk("lirc_dev: lirc_unregister_plugin:"
+		       "plugin %s[%d] in use!", ir->p.name, ir->p.minor);
+		up(&plugin_lock);
+		return -EBUSY;
+	}
+
+	/* end up polling thread */
+	if (ir->tpid >= 0) {
+		ir->t_notify = &tn;
+		ir->t_notify2 = &tn2;
+		ir->shutdown = 1;
+		{
+			struct task_struct *p;
+
+			p = find_task_by_pid(ir->tpid);
+			wake_up_process(p);
+		}
+		up(&tn2);
+		down(&tn);
+		ir->t_notify = NULL;
+		ir->t_notify2 = NULL;
+	}
+
+	dprintk("lirc_dev: plugin %s unregistered from minor number = %d\n",
+		ir->p.name, ir->p.minor);
+
+	if (ir->buf != ir->p.rbuf){
+		lirc_buffer_free(ir->buf);
+		kfree(ir->buf);
+	}
+	ir->buf = NULL;
+	init_irctl(ir);
+	up(&plugin_lock);
+
+	module_put(THIS_MODULE);
+
+	return SUCCESS;
+}
+
+/*
+ *
+ */
+static int irctl_open(struct inode *inode, struct file *file)
+{
+	struct irctl *ir;
+	int retval;
+
+	if (MINOR(inode->i_rdev.value) >= CONFIG_LIRC_MAX_DEV) {
+		dprintk("lirc_dev [%d]: open result = -ENODEV\n",
+			MINOR(inode->i_rdev.value));
+		return -ENODEV;
+	}
+
+	ir = &irctls[MINOR(inode->i_rdev.value)];
+
+	dprintk(LOGHEAD "open called\n", ir->p.name, ir->p.minor);
+
+	/* if the plugin has an open function use it instead */
+	if(ir->p.fops && ir->p.fops->open)
+		return ir->p.fops->open(inode, file);
+
+	down_interruptible(&plugin_lock);
+
+	if (ir->p.minor == NOPLUG) {
+		up(&plugin_lock);
+		dprintk(LOGHEAD "open result = -ENODEV\n",
+			ir->p.name, ir->p.minor);
+		return -ENODEV;
+	}
+
+	if (ir->open) {
+		up(&plugin_lock);
+		dprintk(LOGHEAD "open result = -EBUSY\n",
+			ir->p.name, ir->p.minor);
+		return -EBUSY;
+	}
+
+	/* there is no need for locking here because ir->open is 0
+         * and lirc_thread isn't using buffer
+	 * plugins which use irq's should allocate them on set_use_inc,
+	 * so there should be no problem with those either.
+         */
+	ir->buf->head = ir->buf->tail;
+	ir->buf->fill = 0;
+
+	++ir->open;
+	retval = ir->p.set_use_inc(ir->p.data);
+
+	up(&plugin_lock);
+
+	if (retval != SUCCESS) {
+		--ir->open;
+		return retval;
+	}
+
+	dprintk(LOGHEAD "open result = %d\n", ir->p.name, ir->p.minor, SUCCESS);
+
+	return SUCCESS;
+}
+
+/*
+ *
+ */
+static int irctl_close(struct inode *inode, struct file *file)
+{
+	struct irctl *ir = &irctls[MINOR(inode->i_rdev.value)];
+
+	dprintk(LOGHEAD "close called\n", ir->p.name, ir->p.minor);
+
+	/* if the plugin has a close function use it instead */
+	if(ir->p.fops && ir->p.fops->release)
+		return ir->p.fops->release(inode, file);
+
+	down_interruptible(&plugin_lock);
+
+	--ir->open;
+	ir->p.set_use_dec(ir->p.data);
+
+	up(&plugin_lock);
+
+	return SUCCESS;
+}
+
+/*
+ *
+ */
+static unsigned int irctl_poll(struct file *file, poll_table *wait)
+{
+	struct irctl *ir = &irctls[MINOR(file->f_dentry->d_inode->i_rdev.value)];
+
+	dprintk(LOGHEAD "poll called\n", ir->p.name, ir->p.minor);
+
+	/* if the plugin has a poll function use it instead */
+	if(ir->p.fops && ir->p.fops->poll)
+		return ir->p.fops->poll(file, wait);
+
+	poll_wait(file, &ir->buf->wait_poll, wait);
+
+	dprintk(LOGHEAD "poll result = %s\n",
+		ir->p.name, ir->p.minor,
+		lirc_buffer_empty(ir->buf) ? "0" : "POLLIN|POLLRDNORM");
+
+	return lirc_buffer_empty(ir->buf) ? 0 : (POLLIN|POLLRDNORM);
+}
+
+/*
+ *
+ */
+static int irctl_ioctl(struct inode *inode, struct file *file,
+                       unsigned int cmd, unsigned long arg)
+{
+	unsigned long mode;
+	int result;
+	struct irctl *ir = &irctls[MINOR(inode->i_rdev.value)];
+
+	dprintk(LOGHEAD "poll called (%u)\n",
+		ir->p.name, ir->p.minor, cmd);
+
+	/* if the plugin has a ioctl function use it instead */
+	if(ir->p.fops && ir->p.fops->ioctl)
+		return ir->p.fops->ioctl(inode, file, cmd, arg);
+
+	if (ir->p.minor == NOPLUG) {
+		dprintk(LOGHEAD "ioctl result = -ENODEV\n",
+			ir->p.name, ir->p.minor);
+		return -ENODEV;
+	}
+
+	/* Give the plugin a chance to handle the ioctl */
+	if(ir->p.ioctl){
+		result = ir->p.ioctl(inode, file, cmd, arg);
+		if (result != -ENOIOCTLCMD)
+			return result;
+	}
+	/* The plugin can't handle cmd */
+	result = SUCCESS;
+
+	switch(cmd)
+	{
+	case LIRC_GET_FEATURES:
+		result = put_user(ir->p.features, (unsigned long*)arg);
+		break;
+	case LIRC_GET_REC_MODE:
+		if(!(ir->p.features&LIRC_CAN_REC_MASK))
+			return(-ENOSYS);
+
+		result = put_user(LIRC_REC2MODE
+				  (ir->p.features&LIRC_CAN_REC_MASK),
+				  (unsigned long*)arg);
+		break;
+	case LIRC_SET_REC_MODE:
+		if(!(ir->p.features&LIRC_CAN_REC_MASK))
+			return(-ENOSYS);
+
+		result = get_user(mode, (unsigned long*)arg);
+		if(!result && !(LIRC_MODE2REC(mode) & ir->p.features)) {
+			result = -EINVAL;
+		}
+		/* FIXME: We should actually set the mode somehow
+		 * but for now, lirc_serial doesn't support mode changin
+		 * eighter */
+		break;
+	case LIRC_GET_LENGTH:
+		result = put_user((unsigned long)ir->p.code_length,
+				  (unsigned long *)arg);
+		break;
+	default:
+		result = -ENOIOCTLCMD;
+	}
+
+	dprintk(LOGHEAD "ioctl result = %d\n",
+		ir->p.name, ir->p.minor, result);
+
+	return result;
+}
+
+/*
+ *
+ */
+static ssize_t irctl_read(struct file *file,
+			  char *buffer,
+			  size_t length,
+			  loff_t *ppos)
+{
+	struct irctl *ir = &irctls[MINOR(file->f_dentry->d_inode->i_rdev.value)];
+	unsigned char buf[ir->buf->chunk_size];
+	int ret=0, written=0;
+	DECLARE_WAITQUEUE(wait, current);
+
+	dprintk(LOGHEAD "read called\n", ir->p.name, ir->p.minor);
+
+	/* if the plugin has a specific read function use it instead */
+	if(ir->p.fops && ir->p.fops->read)
+		return ir->p.fops->read(file, buffer, length, ppos);
+
+	if (length % ir->buf->chunk_size) {
+		dprintk(LOGHEAD "read result = -EINVAL\n",
+			ir->p.name, ir->p.minor);
+		return -EINVAL;
+	}
+
+	/* we add ourselves to the task queue before buffer check
+         * to avoid losing scan code (in case when queue is awaken somewhere
+	 * beetwen while condition checking and scheduling)
+	 */
+	add_wait_queue(&ir->buf->wait_poll, &wait);
+	current->state = TASK_INTERRUPTIBLE;
+
+	/* while we did't provide 'length' bytes, device is opened in blocking
+	 * mode and 'copy_to_user' is happy, wait for data.
+	 */
+	while (written < length && ret == 0) {
+		if (lirc_buffer_empty(ir->buf)) {
+			/* According to the read(2) man page, 'written' can be
+			 * returned as less than 'length', instead of blocking
+			 * again, returning -EWOULDBLOCK, or returning
+			 * -ERESTARTSYS */
+			if (written) break;
+			if (file->f_flags & O_NONBLOCK) {
+				dprintk(LOGHEAD "read result = -EWOULDBLOCK\n",
+						ir->p.name, ir->p.minor);
+				remove_wait_queue(&ir->buf->wait_poll, &wait);
+				current->state = TASK_RUNNING;
+				return -EWOULDBLOCK;
+			}
+			if (signal_pending(current)) {
+				dprintk(LOGHEAD "read result = -ERESTARTSYS\n",
+						ir->p.name, ir->p.minor);
+				remove_wait_queue(&ir->buf->wait_poll, &wait);
+				current->state = TASK_RUNNING;
+				return -ERESTARTSYS;
+			}
+			schedule();
+			current->state = TASK_INTERRUPTIBLE;
+		} else {
+			lirc_buffer_read_1(ir->buf, buf);
+			ret = copy_to_user((void *)buffer+written, buf,
+					   ir->buf->chunk_size);
+			written += ir->buf->chunk_size;
+		}
+	}
+
+	remove_wait_queue(&ir->buf->wait_poll, &wait);
+	current->state = TASK_RUNNING;
+
+	dprintk(LOGHEAD "read result = %s (%d)\n",
+		ir->p.name, ir->p.minor, ret ? "-EFAULT" : "OK", ret);
+
+	return ret ? -EFAULT : written;
+}
+
+static ssize_t irctl_write(struct file *file, const char *buffer,
+			   size_t length, loff_t * ppos)
+{
+	struct irctl *ir = &irctls[MINOR(file->f_dentry->d_inode->i_rdev.value)];
+
+	dprintk(LOGHEAD "read called\n", ir->p.name, ir->p.minor);
+
+	/* if the plugin has a specific read function use it instead */
+	if(ir->p.fops && ir->p.fops->write)
+		return ir->p.fops->write(file, buffer, length, ppos);
+
+	return -EINVAL;
+}
+
+
+static struct file_operations fops = {
+	read:    irctl_read,
+	write:   irctl_write,
+	poll:    irctl_poll,
+	ioctl:   irctl_ioctl,
+	open:    irctl_open,
+	release: irctl_close
+};
+
+static int __init lirc_dev_init(void)
+{
+	int i;
+
+	for (i=0; i < CONFIG_LIRC_MAX_DEV; ++i) {
+		init_irctl(&irctls[i]);
+	}
+
+	i = register_chrdev(IRCTL_DEV_MAJOR,
+				   IRCTL_DEV_NAME,
+				   &fops);
+
+	if (i < 0) {
+		printk ("lirc_dev: device registration failed with %d\n", i);
+		return i;
+	}
+
+	printk("lirc_dev: IR Remote Control driver registered, at major %d \n",
+	       IRCTL_DEV_MAJOR);
+
+	return SUCCESS;
+}
+
+static void __exit lirc_dev_exit(void)
+{
+	int ret;
+
+	ret = unregister_chrdev(IRCTL_DEV_MAJOR, IRCTL_DEV_NAME);
+
+	if (0 > ret){
+		printk("lirc_dev: error in module_unregister_chrdev: %d\n",
+		       ret);
+	} else {
+		dprintk("lirc_dev: module successfully unloaded\n");
+	}
+}
+
+/* ---------------------------------------------------------------------- */
+
+/* For now dont try to use it as a static version !  */
+
+MODULE_DESCRIPTION("LIRC base driver module");
+MODULE_AUTHOR("Artur Lipowski");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(lirc_register_plugin);
+EXPORT_SYMBOL(lirc_unregister_plugin);
+
+module_init(lirc_dev_init);
+module_exit(lirc_dev_exit);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
--- linux/drivers/char/lirc/lirc_dev.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-lirc/drivers/char/lirc/lirc_dev.h	2003-08-07 22:53:49.000000000 +0200
@@ -0,0 +1,206 @@
+/*
+ * LIRC base driver
+ *
+ * (L) by Artur Lipowski <alipowski@interia.pl>
+ *        This code is licensed under GNU GPL
+ *
+ * $Id: lirc_dev.h,v 1.11 2003/05/02 18:56:44 ranty Exp $
+ *
+ */
+
+#ifndef _LINUX_LIRC_DEV_H
+#define _LINUX_LIRC_DEV_H
+
+#define BUFLEN            16
+
+//#define LIRC_BUFF_POWER_OF_2
+#ifdef LIRC_BUFF_POWER_OF_2
+#define mod(n, div) ((n) & ((div) -1))
+#else
+#define mod(n, div) ((n) % (div))
+#endif
+#include <linux/slab.h>
+#include <linux/fs.h>
+struct lirc_buffer
+{
+        wait_queue_head_t wait_poll;
+	spinlock_t lock;
+
+	unsigned char *data;
+	unsigned int chunk_size;
+	unsigned int size; /* in chunks */
+	unsigned int fill; /* in chunks */
+	int head, tail;    /* in chunks */
+	/* Using chunks instead of bytes pretends to simplify boundary checking
+	 * And should allow for some performance fine tunning later */
+};
+static inline int lirc_buffer_init(struct lirc_buffer *buf,
+				    unsigned int chunk_size,
+				    unsigned int size)
+{
+	/* Adjusting size to the next power of 2 would allow for
+	 * inconditional LIRC_BUFF_POWER_OF_2 optimization */
+	init_waitqueue_head(&buf->wait_poll);
+	spin_lock_init(&buf->lock);
+	buf->head = buf->tail = buf->fill = 0;
+	buf->chunk_size = chunk_size;
+	buf->size = size;
+	buf->data = kmalloc(size*chunk_size, GFP_KERNEL);
+	if (buf->data == NULL)
+		return -1;
+	memset(buf->data, 0, size*chunk_size);
+	return 0;
+}
+static inline void lirc_buffer_free(struct lirc_buffer *buf)
+{
+	kfree(buf->data);
+	buf->data = NULL;
+	buf->head = buf->tail = buf->fill = 0;
+	buf->chunk_size = 0;
+	buf->size = 0;
+}
+static inline int  lirc_buffer_full(struct lirc_buffer *buf)
+{
+	return (buf->fill >= buf->size);
+}
+static inline int  lirc_buffer_empty(struct lirc_buffer *buf)
+{
+	return !(buf->fill);
+}
+extern inline void lirc_buffer_lock(struct lirc_buffer *buf, unsigned long *flags)
+{
+	spin_lock_irqsave(&buf->lock, *flags);
+}
+extern inline void lirc_buffer_unlock(struct lirc_buffer *buf, unsigned long *flags)
+{
+	spin_unlock_irqrestore(&buf->lock, *flags);
+}
+static inline void _lirc_buffer_remove_1(struct lirc_buffer *buf)
+{
+	buf->head = mod(buf->head+1, buf->size);
+	buf->fill -= 1;
+}
+static inline void lirc_buffer_remove_1(struct lirc_buffer *buf)
+{
+	unsigned long flags;
+	lirc_buffer_lock(buf, &flags);
+	_lirc_buffer_remove_1(buf);
+	lirc_buffer_unlock(buf, &flags);
+}
+static inline void _lirc_buffer_read_1(struct lirc_buffer *buf,
+				     unsigned char *dest)
+{
+	memcpy(dest, &buf->data[buf->head*buf->chunk_size], buf->chunk_size);
+	buf->head = mod(buf->head+1, buf->size);
+	buf->fill -= 1;
+}
+static inline void lirc_buffer_read_1(struct lirc_buffer *buf,
+				      unsigned char *dest)
+{
+	unsigned long flags;
+	lirc_buffer_lock(buf, &flags);
+	_lirc_buffer_read_1(buf, dest);
+	lirc_buffer_unlock(buf, &flags);
+}
+static inline void _lirc_buffer_write_1(struct lirc_buffer *buf,
+				      unsigned char *orig)
+{
+	memcpy(&buf->data[buf->tail*buf->chunk_size], orig, buf->chunk_size);
+	buf->tail = mod(buf->tail+1, buf->size);
+	buf->fill++;
+}
+static inline void lirc_buffer_write_1(struct lirc_buffer *buf,
+				       unsigned char *orig)
+{
+	unsigned long flags;
+	lirc_buffer_lock(buf, &flags);
+	_lirc_buffer_write_1(buf, orig);
+	lirc_buffer_unlock(buf, &flags);
+}
+
+struct lirc_plugin
+{
+     char name[40];
+     int minor;
+     int code_length;
+     int sample_rate;
+     unsigned long features;
+     void* data;
+     int (*get_key) (void* data, unsigned char* key, int key_no);
+     wait_queue_head_t* (*get_queue) (void* data);
+     struct lirc_buffer *rbuf;
+     int (*set_use_inc) (void* data);
+     void (*set_use_dec) (void* data);
+     int (*ioctl) (struct inode *,struct file *,unsigned int, unsigned long);
+     struct file_operations *fops;
+};
+/* name:
+ * this string will be used for logs
+ *
+ * minor:
+ * indicates minor device (/dev/lircd) number for registered plugin
+ * if caller fills it with negative value, then the first free minor
+ * number will be used (if available)
+ *
+ * code_length:
+ * length ofthe  remote control key code expressed in bits
+ * if code_length > 8 then many bytes are returned through the device read
+ * in such situation get_key should return key code values starting
+ * from most significant byte (device read will preseve this order)
+ * in addition if code_length > 8 then get_key will be called
+ * several (ceil(code_length/8)) times in one pool pass (or after task queue
+ * awake) key_no parameter denotes number of the requested byte (0 means first
+ * byte)
+ *
+ * sample_rate:
+ * sample_rate equal to 0 means that no pooling will be performed and get_key
+ * will be triggered by external events (through task queue returned by
+ * get_queue)
+ *
+ * data:
+ * it may point to any plugin data and this pointer will be passed to all
+ * callback functions
+ *
+ * get_key:
+ * get_key will be called after specified period of the time or triggered by the
+ * external event, this behavior depends on value of the sample_rate
+ * this function will be called in user context
+ *
+ * get_queue:
+ * this callback should return a pointer to the task queue which will be used
+ * for external event waiting
+ *
+ * rbuf:
+ * if not NULL, it will be used as a read buffer, you will have to write to
+ * the buffer by other means, like irq's (see also lirc_serial.c).
+ *
+ * set_use_inc:
+ * set_use_inc will be called after device is opened
+ *
+ * set_use_dec:
+ * set_use_dec will be called after device is closed
+ *
+ * ioctl:
+ * Some ioctl's can be directly handled by lirc_dev but will be forwared here
+ * if not NULL and only handled if it returns -ENOIOCTLCMD (see also
+ * lirc_serial.c).
+ *
+ * fops:
+ * file_operations for drivers which don't fit the current plugin model.
+ */
+
+
+/* following functions can be called ONLY from user context
+ *
+ * returns negative value on error or minor number
+ * of the registered device if success
+ * contens of the structure pointed by p is copied
+ */
+extern int lirc_register_plugin(struct lirc_plugin *p);
+
+/* returns negative value on error or 0 if success
+*/
+extern int lirc_unregister_plugin(int minor);
+
+
+#endif
--- linux/drivers/char/lirc/lirc_gpio.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-lirc/drivers/char/lirc/lirc_gpio.c	2003-08-07 22:53:49.000000000 +0200
@@ -0,0 +1,548 @@
+/*
+ * Remote control driver for the TV-card
+ * key codes are obtained from GPIO port
+ *
+ * (L) by Artur Lipowski <alipowski@interia.pl>
+ *     patch for the AverMedia by Santiago Garcia Mantinan <manty@i.am>
+ *                            and Christoph Bartelmus <lirc@bartelmus.de>
+ *     patch for the BestBuy by Miguel Angel Alvarez <maacruz@navegalia.com>
+ *     patch for the Winfast TV2000 by Juan Toledo
+ *     <toledo@users.sourceforge.net>
+ *     patch for the I-O Data GV-BCTV5/PCI by Jens C. Rasmussen
+ *     <jens.rasmussen@ieee.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * $Id: lirc_gpio.c,v 1.30 2003/06/07 22:00:10 lirc Exp $
+ *
+ */
+
+#include <linux/version.h>
+
+#include <linux/module.h>
+#include <linux/kmod.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+
+#include "../../media/video/bttv.h"
+#include "../../media/video/bttvp.h"
+
+#include "lirc_dev.h"
+
+static int debug = 0;
+static int card = 0;
+static int minor = -1;
+static int bttv_id = BTTV_UNKNOWN;
+static unsigned long gpio_mask = 0;
+static unsigned long gpio_enable = 0;
+static unsigned long gpio_lock_mask = 0;
+static unsigned long gpio_xor_mask = 0;
+static unsigned int soft_gap = 0;
+static unsigned char sample_rate = 10;
+
+MODULE_PARM(debug,"i");
+MODULE_PARM(card,"i");
+MODULE_PARM(minor,"i");
+MODULE_PARM(gpio_mask,"l");
+MODULE_PARM(gpio_lock_mask,"l");
+MODULE_PARM(gpio_xor_mask,"l");
+MODULE_PARM(soft_gap,"i");
+MODULE_PARM(sample_rate,"b");
+MODULE_PARM(bttv_id,"i");
+
+#undef dprintk
+#define dprintk  if (debug) printk
+
+struct rcv_info {
+	int bttv_id;
+	int card_id;
+	unsigned long gpio_mask;
+	unsigned long gpio_enable;
+	unsigned long gpio_lock_mask;
+	unsigned long gpio_xor_mask;
+	unsigned int soft_gap;
+	unsigned char sample_rate;
+	unsigned char code_length;
+};
+
+static struct rcv_info rcv_infos[] = {
+	{BTTV_UNKNOWN,                0,          0,          0,         0,          0,   0,  1,  0},
+#ifdef BTTV_PXELVWPLTVPAK
+	{BTTV_PXELVWPLTVPAK,          0, 0x00003e00,          0, 0x0010000,          0,   0, 15,  0},
+#endif
+	{BTTV_PXELVWPLTVPRO,          0, 0x00001f00,          0, 0x0008000,          0, 500, 12, 32},
+#ifdef BTTV_PV_BT878P_9B
+	{BTTV_PV_BT878P_9B,           0, 0x00001f00,          0, 0x0008000,          0, 500, 12, 32},
+#endif
+	{BTTV_AVERMEDIA,              0, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32},
+	{BTTV_AVPHONE98,     0x00011461, 0x003b8000, 0x00004000, 0x0800000, 0x00800000,   0, 10,  0}, /*mapped to Capture98*/
+	{BTTV_AVERMEDIA98,   0x00021461, 0x003b8000, 0x00004000, 0x0800000, 0x00800000,   0, 10,  0}, /*mapped to Capture98*/
+	{BTTV_AVPHONE98,     0x00031461, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32}, /*mapped to Phone98*/
+	/* is this one correct? */
+	{BTTV_AVERMEDIA98,   0x00041461, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32}, /*mapped to Phone98*/
+	/* work-around for VDOMATE */
+	{BTTV_AVERMEDIA98,   0x03001461, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32}, /*mapped to Phone98*/
+	/* reported by Danijel Korzinek, AVerTV GOw/FM */
+	{BTTV_AVERMEDIA98,   0x00000000, 0x00f88000,          0, 0x0010000, 0x00010000,   0, 10, 32}, /*mapped to Phone98*/
+	{BTTV_CHRONOS_VS2,            0, 0x000000f8,          0, 0x0000100,          0,   0, 20,  0},
+	/* CPH031 and CPH033 cards (?) */
+	/* MIRO was just a work-around */
+	{BTTV_MIRO,                   0, 0x00001f00,          0, 0x0004000,          0,   0, 10, 32},
+	{BTTV_DYNALINK,               0, 0x00001f00,          0, 0x0004000,          0,   0, 10, 32},
+	{BTTV_WINVIEW_601,            0, 0x00001f00,          0, 0x0004000,          0,   0,  0, 32},
+#ifdef BTTV_KWORLD
+	{BTTV_KWORLD,                 0, 0x00007f00,          0, 0x0004000,          0,   0, 12, 32},
+#endif
+	/* just a guess */
+	{BTTV_MAGICTVIEW061,          0, 0x0028e000,          0, 0x0020000,          0,   0, 20, 32},
+ 	{BTTV_MAGICTVIEW063,          0, 0x0028e000,          0, 0x0020000,          0,   0, 20, 32},
+ 	{BTTV_PHOEBE_TVMAS,           0, 0x0028e000,          0, 0x0020000,          0,   0, 20, 32},
+#ifdef BTTV_BESTBUY_EASYTV2
+        {BTTV_BESTBUY_EASYTV,         0, 0x00007F00,          0, 0x0004000,          0,   0, 10,  8},
+        {BTTV_BESTBUY_EASYTV2,        0, 0x00007F00,          0, 0x0008000,          0,   0, 10,  8},
+#endif
+	/* lock_mask probably also 0x100, or maybe it is 0x0 for all others !?! */
+	{BTTV_FLYVIDEO,               0, 0x000000f8,          0,         0,          0,   0,  0, 42},
+ 	{BTTV_FLYVIDEO_98,            0, 0x000000f8,          0, 0x0000100,          0,   0,  0, 42},
+ 	{BTTV_TYPHOON_TVIEW,          0, 0x000000f8,          0, 0x0000100,          0,   0,  0, 42},
+#ifdef BTTV_FLYVIDEO_98FM
+	/* smorar@alfonzo.smuts.uct.ac.za */
+	{BTTV_FLYVIDEO_98FM,          0, 0x000000f8,          0, 0x0000100,          0,   0,  0, 42},
+#endif
+	/* The Leadtek WinFast TV 2000 XP card (id 0x6606107d) uses an
+	 * extra gpio bit compared to the original TV 2000 card (id
+	 * 0x217d6606); as the bttv-0.7.100 driver does not
+	 * distinguish between the two cards, we enable the extra bit
+	 * based on the card id: */
+	{BTTV_WINFAST2000,   0x6606107d, 0x000008f8,          0, 0x0000100,          0,   0,  0, 32},
+	/* default: */
+	{BTTV_WINFAST2000,            0, 0x000000f8,          0, 0x0000100,          0,   0,  0, 32},
+#ifdef BTTV_GVBCTV5PCI
+	{BTTV_GVBCTV5PCI,             0, 0x00f0b000,          0,         0,          0,   0, 20,  8},
+#endif
+};
+
+static unsigned char code_length = 0;
+static unsigned char code_bytes = 1;
+
+#define MAX_BYTES 8
+
+#define SUCCESS 0
+#define LOGHEAD "lirc_gpio (%d): "
+
+/* how many bits GPIO value can be shifted right before processing
+ * it is computed from the value of gpio_mask_parameter
+ */
+static unsigned char gpio_pre_shift = 0;
+
+
+static inline int reverse(int data, int bits)
+{
+	int i;
+	int c;
+
+	for (c=0,i=0; i<bits; i++) {
+		c |= (((data & (1<<i)) ? 1:0)) << (bits-1-i);
+	}
+
+	return c;
+}
+
+static int build_key(unsigned long gpio_val, unsigned char codes[MAX_BYTES])
+{
+	unsigned long mask = gpio_mask;
+	unsigned char shift = 0;
+
+	dprintk(LOGHEAD "gpio_val is %lx\n",card,(unsigned long) gpio_val);
+
+	gpio_val ^= gpio_xor_mask;
+
+	if (gpio_lock_mask && (gpio_val & gpio_lock_mask)) {
+		return -EBUSY;
+	}
+
+	switch (bttv_id)
+	{
+	case BTTV_AVERMEDIA98:
+		if (bttv_write_gpio(card, gpio_enable, gpio_enable)) {
+			dprintk(LOGHEAD "cannot write to GPIO\n", card);
+			return -EIO;
+		}
+		if (bttv_read_gpio(card, &gpio_val)) {
+			dprintk(LOGHEAD "cannot read GPIO\n", card);
+			return -EIO;
+		}
+		if (bttv_write_gpio(card, gpio_enable, 0)) {
+			dprintk(LOGHEAD "cannot write to GPIO\n", card);
+			return -EIO;
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* extract bits from "raw" GPIO value using gpio_mask */
+	codes[0] = 0;
+	gpio_val >>= gpio_pre_shift;
+	while (mask) {
+		if (mask & 1u) {
+			codes[0] |= (gpio_val & 1u) << shift++;
+		}
+		mask >>= 1;
+		gpio_val >>= 1;
+	}
+
+	dprintk(LOGHEAD "code is %lx\n",card,(unsigned long) codes[0]);
+	switch (bttv_id)
+	{
+	case BTTV_AVERMEDIA:
+		codes[2] = (codes[0]<<2)&0xff;
+		codes[3] = (~codes[2])&0xff;
+		codes[0] = 0x02;
+		codes[1] = 0xFD;
+		break;
+	case BTTV_AVPHONE98:
+		codes[2] = ((codes[0]&(~0x1))<<2)&0xff;
+		codes[3] = (~codes[2])&0xff;
+		if (codes[0]&0x1) {
+			codes[0] = 0xc0;
+			codes[1] = 0x3f;
+		} else {
+			codes[0] = 0x40;
+			codes[1] = 0xbf;
+		}
+		break;
+	case BTTV_AVERMEDIA98:
+		break;
+	case BTTV_FLYVIDEO:
+	case BTTV_FLYVIDEO_98:
+	case BTTV_TYPHOON_TVIEW:
+#ifdef BTTV_FLYVIDEO_98FM
+	case BTTV_FLYVIDEO_98FM:
+#endif
+		codes[4]=codes[0]<<3;
+		codes[5]=((~codes[4])&0xff);
+
+		codes[0]=0x00;
+		codes[1]=0x1A;
+		codes[2]=0x1F;
+		codes[3]=0x2F;
+		break;
+        case BTTV_MAGICTVIEW061:
+        case BTTV_MAGICTVIEW063:
+	case BTTV_PHOEBE_TVMAS:
+		codes[0] = (codes[0]&0x01)
+			|((codes[0]&0x02)<<1)
+			|((codes[0]&0x04)<<2)
+			|((codes[0]&0x08)>>2)
+			|((codes[0]&0x10)>>1);
+		/* FALLTHROUGH */
+	case BTTV_MIRO:
+	case BTTV_DYNALINK:
+	case BTTV_PXELVWPLTVPRO:
+#ifdef BTTV_PV_BT878P_9B
+	case BTTV_PV_BT878P_9B:
+#endif
+#ifdef BTTV_KWORLD
+	case BTTV_KWORLD:
+#endif
+		codes[2] = reverse(codes[0],8);
+		codes[3] = (~codes[2])&0xff;
+		codes[0] = 0x61;
+		codes[1] = 0xD6;
+		break;
+#if 0
+		/* derived from e-tech config file */
+		/* 26 + 16 bits */
+		/* won't apply it until it's confirmed with a fly98 */
+ 	case BTTV_FLYVIDEO_98:
+	case BTTV_FLYVIDEO_98FM:
+		codes[4]=codes[0]<<3;
+		codes[5]=(~codes[4])&0xff;
+
+		codes[0]=0x00;
+		codes[1]=0x1A;
+		codes[2]=0x1F;
+		codes[3]=0x2F;
+		break;
+#endif
+	case BTTV_WINFAST2000:
+	case BTTV_WINVIEW_601:
+		codes[2] = reverse(codes[0],8);
+		codes[3] = (~codes[2])&0xff;
+		codes[0] = 0xC0;
+		codes[1] = 0x3F;
+		break;
+	default:
+		break;
+	}
+
+	return SUCCESS;
+}
+
+static int get_key(void* data, unsigned char *key, int key_no)
+{
+	static unsigned long next_time = 0;
+	static unsigned char codes[MAX_BYTES];
+	unsigned long code = 0;
+	unsigned char cur_codes[MAX_BYTES];
+
+	if (key_no > 0)	{
+		if (code_bytes < 2 || key_no >= code_bytes) {
+			dprintk(LOGHEAD "something wrong in get_key\n", card);
+			return -EBADRQC;
+		}
+		*key = codes[key_no];
+		return SUCCESS;
+	}
+
+	if (bttv_read_gpio(card, &code)) {
+		dprintk(LOGHEAD "cannot read GPIO\n", card);
+		return -EIO;
+	}
+
+	if (build_key(code, cur_codes)) {
+		return -EFAULT;
+	}
+
+	if (soft_gap) {
+		if (!memcmp(codes, cur_codes, code_bytes) &&
+		    jiffies < next_time) {
+			return -EAGAIN;
+		}
+		next_time = jiffies + soft_gap;
+	}
+
+	memcpy(codes, cur_codes, code_bytes);
+
+	*key = codes[0];
+
+	return SUCCESS;
+}
+
+static int set_use_inc(void* data)
+{
+	try_module_get(THIS_MODULE);
+	return 0;
+}
+
+static void set_use_dec(void* data)
+{
+	module_put(THIS_MODULE);
+}
+
+static wait_queue_head_t* get_queue(void* data)
+{
+	return bttv_get_gpio_queue(card);
+}
+
+static struct lirc_plugin plugin = {
+	.name		= "lirc_gpio  ",
+	.get_key	= get_key,
+	.get_queue	= get_queue,
+	.set_use_inc	= set_use_inc,
+	.set_use_dec	= set_use_dec,
+};
+
+/*
+ *
+ */
+int gpio_remote_init(void)
+{
+	int ret;
+	unsigned int mask;
+
+	/* "normalize" gpio_mask
+	 * this means shift it right until first bit is set
+	 */
+	while (!(gpio_mask & 1u)) {
+		gpio_pre_shift++;
+		gpio_mask >>= 1;
+	}
+
+	if (code_length) {
+		plugin.code_length = code_length;
+	} else {
+		/* calculate scan code length in bits if needed */
+		plugin.code_length = 1;
+		mask = gpio_mask >> 1;
+		while (mask) {
+			if (mask & 1u) {
+				plugin.code_length++;
+			}
+			mask >>= 1;
+		}
+	}
+
+	code_bytes = (plugin.code_length/8) + (plugin.code_length%8 ? 1 : 0);
+	if (MAX_BYTES < code_bytes) {
+		printk (LOGHEAD "scan code too long (%d bytes)\n",
+			minor, code_bytes);
+		return -EBADRQC;
+	}
+
+	if (gpio_enable) {
+		if(bttv_gpio_enable(card, gpio_enable, gpio_enable)) {
+			printk(LOGHEAD "gpio_enable failure\n", minor);
+			return -EIO;
+		}
+	}
+
+
+	/* translate ms to jiffies */
+	soft_gap = (soft_gap*HZ) / 1000;
+
+	plugin.minor = minor;
+	plugin.sample_rate = sample_rate;
+
+	ret = lirc_register_plugin(&plugin);
+
+	if (0 > ret) {
+		printk (LOGHEAD "device registration failed with %d\n",
+			minor, ret);
+		return ret;
+	}
+
+	minor = ret;
+	printk(LOGHEAD "driver registered\n", minor);
+
+	return SUCCESS;
+}
+
+static int __init lirc_gpio_init(void)
+{
+	int type,cardid,card_type;
+
+	if (CONFIG_LIRC_MAX_DEV < minor) {
+		printk("lirc_gpio: parameter minor (%d) must be less than %d!\n",
+		       minor, CONFIG_LIRC_MAX_DEV-1);
+		return -EBADRQC;
+	}
+
+	request_module("bttv");
+
+	/* if gpio_mask not zero then use module parameters
+	 * instead of autodetecting TV card
+	 */
+	if (gpio_mask) {
+		if (sample_rate!=0 && (2 > sample_rate || 50 < sample_rate)) {
+			printk(LOGHEAD "parameter sample_rate "
+			       "must be beetween 2 and 50!\n", minor);
+			return -EBADRQC;
+		}
+
+		if (sample_rate!=0 && soft_gap &&
+		    ((2000/sample_rate) > soft_gap || 1000 < soft_gap)) {
+			printk(LOGHEAD "parameter soft_gap "
+			       "must be beetween %d and 1000!\n",
+			       minor, 2000/sample_rate);
+			return -EBADRQC;
+		}
+	} else {
+		if(bttv_get_cardinfo(card,&type,&cardid)==-1) {
+			printk(LOGHEAD "could not get card type\n", minor);
+		}
+		printk(LOGHEAD "card type 0x%x, id 0x%x\n",minor,
+		       type,cardid);
+
+		if (type == BTTV_UNKNOWN) {
+			printk(LOGHEAD "cannot detect TV card nr %d!\n",
+			       minor, card);
+			return -EBADRQC;
+		}
+		for (card_type = 1;
+		     card_type < sizeof(rcv_infos)/sizeof(struct rcv_info);
+		     card_type++) {
+			if (rcv_infos[card_type].bttv_id == type &&
+			    (rcv_infos[card_type].card_id == 0 ||
+			     rcv_infos[card_type].card_id == cardid)) {
+				bttv_id = rcv_infos[card_type].bttv_id;
+				gpio_mask = rcv_infos[card_type].gpio_mask;
+				gpio_enable = rcv_infos[card_type].gpio_enable;
+				gpio_lock_mask = rcv_infos[card_type].gpio_lock_mask;
+				gpio_xor_mask = rcv_infos[card_type].gpio_xor_mask;
+				soft_gap = rcv_infos[card_type].soft_gap;
+				sample_rate = rcv_infos[card_type].sample_rate;
+				code_length = rcv_infos[card_type].code_length;
+				break;
+			}
+		}
+		if (type==BTTV_AVPHONE98 && cardid==0x00011461)	{
+			bttv_id = BTTV_AVERMEDIA98;
+		}
+		if (type==BTTV_AVERMEDIA98 && cardid==0x00041461) {
+			bttv_id = BTTV_AVPHONE98;
+		}
+		if (type==BTTV_AVERMEDIA98 && cardid==0x03001461) {
+			bttv_id = BTTV_AVPHONE98;
+		}
+		if (type==BTTV_AVERMEDIA98 && cardid==0x00000000) {
+			bttv_id = BTTV_AVPHONE98;
+		}
+		if (card_type == sizeof(rcv_infos)/sizeof(struct rcv_info)) {
+			printk(LOGHEAD "TV card type %x not supported!\n",
+			       minor, type);
+			return -EBADRQC;
+		}
+	}
+
+	request_module("lirc_dev");
+
+	return gpio_remote_init();
+}
+
+void __exit lirc_gpio_exit(void)
+{
+	int ret;
+
+	ret = lirc_unregister_plugin(minor);
+
+	if (0 > ret) {
+		printk(LOGHEAD "error in lirc_unregister_minor: %d\n"
+		       "Trying again...\n",
+		       minor, ret);
+
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ);
+
+		ret = lirc_unregister_plugin(minor);
+
+		if (0 > ret) {
+			printk(LOGHEAD "error in lirc_unregister_minor: %d!!!\n",
+			       minor, ret);
+			return;
+		}
+	}
+
+	dprintk(LOGHEAD "module successfully unloaded\n", minor);
+}
+/* Dont try to use it as a static version !  */
+
+MODULE_DESCRIPTION("Driver module for remote control (data from bt848 GPIO port)");
+MODULE_AUTHOR("Artur Lipowski");
+MODULE_LICENSE("GPL");
+
+module_init(lirc_gpio_init);
+module_exit(lirc_gpio_exit);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
--- linux/include/linux/lirc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-lirc/include/linux/lirc.h	2003-08-07 22:53:49.000000000 +0200
@@ -0,0 +1,103 @@
+/*      $Id: lirc.h,v 5.8 2003/01/26 12:57:59 lirc Exp $      */
+
+#ifndef _LINUX_LIRC_H
+#define _LINUX_LIRC_H
+
+#if defined (__linux__)
+#include <asm/types.h>
+#include <linux/ioctl.h>
+#else
+#include <sys/types.h>
+typedef u_int32_t __u32;
+#endif
+
+#define PULSE_BIT  0x01000000
+#define PULSE_MASK 0x00FFFFFF
+
+typedef int lirc_t;
+
+/*
+ * lirc compatible hardware features
+ */
+
+
+#define LIRC_MODE2SEND(x) (x)
+#define LIRC_SEND2MODE(x) (x)
+#define LIRC_MODE2REC(x) ((x) << 16)
+#define LIRC_REC2MODE(x) ((x) >> 16)
+
+#define LIRC_MODE_RAW                  0x00000001
+#define LIRC_MODE_PULSE                0x00000002
+#define LIRC_MODE_MODE2                0x00000004
+#define LIRC_MODE_CODE                 0x00000008
+#define LIRC_MODE_LIRCCODE             0x00000010
+#define LIRC_MODE_STRING               0x00000020
+
+
+#define LIRC_CAN_SEND_RAW              LIRC_MODE2SEND(LIRC_MODE_RAW)
+#define LIRC_CAN_SEND_PULSE            LIRC_MODE2SEND(LIRC_MODE_PULSE)
+#define LIRC_CAN_SEND_MODE2            LIRC_MODE2SEND(LIRC_MODE_MODE2)
+#define LIRC_CAN_SEND_CODE             LIRC_MODE2SEND(LIRC_MODE_CODE)
+#define LIRC_CAN_SEND_LIRCCODE         LIRC_MODE2SEND(LIRC_MODE_LIRCCODE)
+#define LIRC_CAN_SEND_STRING           LIRC_MODE2SEND(LIRC_MODE_STRING)
+
+#define LIRC_CAN_SEND_MASK             0x0000003f
+
+#define LIRC_CAN_SET_SEND_CARRIER      0x00000100
+#define LIRC_CAN_SET_SEND_DUTY_CYCLE   0x00000200
+
+#define LIRC_CAN_REC_RAW               LIRC_MODE2REC(LIRC_MODE_RAW)
+#define LIRC_CAN_REC_PULSE             LIRC_MODE2REC(LIRC_MODE_PULSE)
+#define LIRC_CAN_REC_MODE2             LIRC_MODE2REC(LIRC_MODE_MODE2)
+#define LIRC_CAN_REC_CODE              LIRC_MODE2REC(LIRC_MODE_CODE)
+#define LIRC_CAN_REC_LIRCCODE          LIRC_MODE2REC(LIRC_MODE_LIRCCODE)
+#define LIRC_CAN_REC_STRING            LIRC_MODE2REC(LIRC_MODE_STRING)
+
+#define LIRC_CAN_REC_MASK              LIRC_MODE2REC(LIRC_CAN_SEND_MASK)
+
+#define LIRC_CAN_SET_REC_CARRIER       (LIRC_CAN_SET_SEND_CARRIER << 16)
+#define LIRC_CAN_SET_REC_DUTY_CYCLE    (LIRC_CAN_SET_SEND_DUTY_CYCLE << 16)
+
+#define LIRC_CAN_SET_REC_DUTY_CYCLE_RANGE 0x40000000
+#define LIRC_CAN_SET_REC_CARRIER_RANGE    0x80000000
+
+
+#define LIRC_CAN_SEND(x) ((x)&LIRC_CAN_SEND_MASK)
+#define LIRC_CAN_REC(x) ((x)&LIRC_CAN_REC_MASK)
+
+/*
+ * IOCTL commands for lirc driver
+ */
+
+#define LIRC_GET_FEATURES              _IOR('i', 0x00000000, __u32)
+
+#define LIRC_GET_SEND_MODE             _IOR('i', 0x00000001, __u32)
+#define LIRC_GET_REC_MODE              _IOR('i', 0x00000002, __u32)
+#define LIRC_GET_SEND_CARRIER          _IOR('i', 0x00000003, __u32)
+#define LIRC_GET_REC_CARRIER           _IOR('i', 0x00000004, __u32)
+#define LIRC_GET_SEND_DUTY_CYCLE       _IOR('i', 0x00000005, __u32)
+#define LIRC_GET_REC_DUTY_CYCLE        _IOR('i', 0x00000006, __u32)
+
+/* code length in bits, currently only for LIRC_MODE_LIRCCODE */
+#define LIRC_GET_LENGTH                _IOR('i', 0x0000000f, __u32)
+
+#define LIRC_SET_SEND_MODE             _IOW('i', 0x00000011, __u32)
+#define LIRC_SET_REC_MODE              _IOW('i', 0x00000012, __u32)
+/* Note: these can reset the according pulse_width */
+#define LIRC_SET_SEND_CARRIER          _IOW('i', 0x00000013, __u32)
+#define LIRC_SET_REC_CARRIER           _IOW('i', 0x00000014, __u32)
+#define LIRC_SET_SEND_DUTY_CYCLE       _IOW('i', 0x00000015, __u32)
+#define LIRC_SET_REC_DUTY_CYCLE        _IOW('i', 0x00000016, __u32)
+
+/* to set a range use
+   LIRC_SET_REC_DUTY_CYCLE_RANGE/LIRC_SET_REC_CARRIER_RANGE with the
+   lower bound first and later
+   LIRC_SET_REC_DUTY_CYCLE/LIRC_SET_REC_CARRIER with the upper bound */
+
+#define LIRC_SET_REC_DUTY_CYCLE_RANGE  _IOW('i', 0x0000001e, __u32)
+#define LIRC_SET_REC_CARRIER_RANGE     _IOW('i', 0x0000001f, __u32)
+
+#define DEV_LIRC	"lirc"
+#define IRCTL_DEV_MAJOR 61
+
+#endif


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
