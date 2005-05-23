Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVEWPdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVEWPdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVEWPdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:33:41 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:45706 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261881AbVEWPcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:32:02 -0400
Date: Mon, 23 May 2005 17:32:01 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linux-kernel@vger.kernel.org
Cc: Deepak Saxena <dsaxena@plexity.net>, Slade Maurer <slade@computer.org>
Subject: [PATCH][RFC] ixp2000 microengine thread interrupt driver
Message-ID: <20050523153201.GA18475@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me on replies)

Hi all,

Attached is a driver that allows userspace to handle microengine
interrupts on ixp2000 network processors.

The driver creates a misc char device, /dev/ixp2000_thd.  Reading this
device will block until a microengine interrupt has arrived.  The device
can also be poll()ed, which does what one would expect.

The code is written so as to minimise CSR reads and writes.  It does
perform a few extra writes here and there to mask pending interrupts
until userspace has had a chance to dequeue them (i.e. the NAPI way of
interrupt handling), but this gives a dramatic reduction in interrupt
rate under high load and prevents interrupt livelock, so it's worth it.

Comments?


cheers,
Lennert


diff -urN linux-2.6.12-rc4.orig/drivers/char/ixp2000_thd.c linux-2.6.12-rc4/drivers/char/ixp2000_thd.c
--- linux-2.6.12-rc4.orig/drivers/char/ixp2000_thd.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc4/drivers/char/ixp2000_thd.c	2005-05-23 16:47:29.191087513 +0200
@@ -0,0 +1,291 @@
+/*
+ * IXP2000 microengine thread interrupt driver.
+ * 
+ * Copyright (C) 2005 Lennert Buytenhek <buytenh@wantstofly.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+
+#define IXP2000_THD_VERSION	"0.3"
+
+static DECLARE_MUTEX(ixp2000_thd_mutex);
+static int ixp2000_use_count;
+
+static DEFINE_SPINLOCK(ixp2000_thd_lock);
+static DECLARE_WAIT_QUEUE_HEAD(ixp2000_thd_wait);
+static struct fasync_struct *ixp2000_thd_async_queue;
+static int ints_pending;
+static u32 int_pending_mask[8];
+
+static int index_to_irq(int index)
+{
+	return IRQ_IXP2000_THDA0 | ((index & 4) << 1) | (index & 3);
+}
+
+static int irq_to_index(int irq)
+{
+	return ((irq & 8) >> 1) | (irq & 3);
+}
+
+static void *thd_raw_status(int index)
+{
+	return ((void *)IXP2000_IRQ_THD_RAW_STATUS_A_0) +
+			((index & 4) << 3) + ((index & 3) << 2);
+}
+
+static irqreturn_t ixp2000_thd_interrupt(int irq, void *dev_id,
+					 struct pt_regs *regs)
+{
+	u32 int_mask;
+	int index;
+
+	index = irq_to_index(irq);
+
+	int_mask = *((volatile u32 *)dev_id);
+	if (unlikely(int_mask == 0))
+		return IRQ_NONE;
+
+	/*
+	 * Mask and ACK, respectively.  Masking is done by writing to
+	 * the ENABLE_CLEAR registers, which are located at offset 0x180
+	 * from their RAW_STATUS counterparts.
+	 */
+	ixp2000_reg_write(dev_id + 0x180, int_mask);
+	ixp2000_reg_write(dev_id, int_mask);
+
+	if ((~int_pending_mask[index] & int_mask) != 0) {
+		ints_pending = 1;
+		int_pending_mask[index] |= int_mask;
+		wake_up_interruptible(&ixp2000_thd_wait);
+		kill_fasync(&ixp2000_thd_async_queue, SIGIO, POLL_IN);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ixp2000_thd_register_ints(void)
+{
+	int i;
+
+	for (i=0;i<8;i++) {
+		int irq;
+		int ret;
+
+		irq = index_to_irq(i);
+
+		ret = request_irq(irq, ixp2000_thd_interrupt, SA_INTERRUPT,
+				  "ixp2000_thd", thd_raw_status(i));
+		if (ret) {
+			printk(KERN_INFO "ixp2000_thd: irq %d in use\n", irq);
+			while (--i >= 0)
+				free_irq(index_to_irq(i), thd_raw_status(i));
+			return 1;
+		}
+	}
+
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_SET_A_0, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_SET_A_1, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_SET_A_2, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_SET_A_3, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_SET_B_0, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_SET_B_1, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_SET_B_2, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_SET_B_3, 0xffffffff);
+
+	return 0;
+}
+
+static void ixp2000_thd_unregister_ints(void)
+{
+	int i;
+
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_CLEAR_A_0, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_CLEAR_A_1, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_CLEAR_A_2, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_CLEAR_A_3, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_CLEAR_B_0, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_CLEAR_B_1, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_CLEAR_B_2, 0xffffffff);
+	ixp2000_reg_write(IXP2000_IRQ_THD_ENABLE_CLEAR_B_3, 0xffffffff);
+
+	for (i=0;i<8;i++)
+		free_irq(index_to_irq(i), thd_raw_status(i));
+}
+
+static int ixp2000_thd_read(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	int local_ints_pending;
+	u32 local_int_pending_mask[8];
+	int retval;
+
+	if (count != sizeof(int_pending_mask))
+		return -EINVAL;
+
+	add_wait_queue(&ixp2000_thd_wait, &wait);
+
+	do {
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_irq(&ixp2000_thd_lock);
+		local_ints_pending = ints_pending;
+		if (local_ints_pending) {
+			int i;
+
+			ints_pending = 0;
+			memcpy(local_int_pending_mask,
+				int_pending_mask, sizeof(int_pending_mask));
+			memset(int_pending_mask, 0, sizeof(int_pending_mask));
+
+			for (i=0;i<8;i++) {
+				u32 mask;
+
+				mask = local_int_pending_mask[i];
+				if (mask) {
+					void *reg;
+
+					reg = thd_raw_status(i);
+					*((volatile u32 *)(reg + 0x100)) = mask;
+				}
+			}
+		}
+		spin_unlock_irq(&ixp2000_thd_lock);
+
+		if (local_ints_pending)
+			break;
+
+		if (file->f_flags & O_NONBLOCK) {
+			retval = -EAGAIN;
+			goto out;
+		}
+
+		if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			goto out;
+		}
+
+		schedule();
+	} while (1);
+
+	retval = count;
+	if (copy_to_user(buf, local_int_pending_mask, count))
+		retval = -EFAULT;
+
+out:
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&ixp2000_thd_wait, &wait);
+
+	return retval;
+}
+
+static unsigned int ixp2000_thd_poll(struct file *file, poll_table *wait)
+{
+	int local_ints_pending;
+
+	poll_wait(file, &ixp2000_thd_wait, wait);
+
+	spin_lock_irq(&ixp2000_thd_lock);
+	local_ints_pending = ints_pending;
+	spin_unlock(&ixp2000_thd_lock);
+
+	if (local_ints_pending)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static int ixp2000_thd_fasync(int fd, struct file *filp, int on)
+{
+	return fasync_helper(fd, filp, on, &ixp2000_thd_async_queue);
+}
+
+static int ixp2000_thd_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = -EBUSY;
+
+	down(&ixp2000_thd_mutex);
+	if (ixp2000_use_count || !ixp2000_thd_register_ints()) {
+		ixp2000_use_count++;
+		ret = 0;
+	}
+	up(&ixp2000_thd_mutex);
+
+	return ret;
+}
+
+static int ixp2000_thd_release(struct inode *inode, struct file *file)
+{
+	if (file->f_flags & FASYNC)
+		ixp2000_thd_fasync(-1, file, 0);
+
+	down(&ixp2000_thd_mutex);
+	if (!--ixp2000_use_count)
+		ixp2000_thd_unregister_ints();
+	up(&ixp2000_thd_mutex);
+
+	return 0;
+}
+
+static struct file_operations ixp2000_thd_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= ixp2000_thd_read,
+	.poll		= ixp2000_thd_poll,
+	.fasync		= ixp2000_thd_fasync,
+	.open		= ixp2000_thd_open,
+	.release	= ixp2000_thd_release,
+};
+
+static struct miscdevice ixp2000_thd_dev = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "ixp2000_thd",
+	.fops		= &ixp2000_thd_fops,
+};
+
+static int __init ixp2000_thd_init(void)
+{
+	if (misc_register(&ixp2000_thd_dev))
+		return -ENODEV;
+
+	printk(KERN_INFO "IXP2000 thread interrupt driver v" IXP2000_THD_VERSION "\n");
+
+	return 0;
+}
+
+static void __exit ixp2000_thd_exit(void)
+{
+	misc_deregister(&ixp2000_thd_dev);
+}
+
+module_init(ixp2000_thd_init);
+module_exit(ixp2000_thd_exit);
+
+MODULE_DESCRIPTION("IXP2000 thread interrupt driver");
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(IXP2000_THD_MINOR);
diff -urN linux-2.6.12-rc4.orig/drivers/char/Kconfig linux-2.6.12-rc4/drivers/char/Kconfig
--- linux-2.6.12-rc4.orig/drivers/char/Kconfig	2005-05-09 22:17:46.000000000 +0200
+++ linux-2.6.12-rc4/drivers/char/Kconfig	2005-05-09 22:15:33.000000000 +0200
@@ -840,6 +840,21 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called sonypi.
 
+config IXP2000_THD
+	tristate "IXP2000 thread interrupt driver"
+	depends on ARM && ARCH_IXP2000
+	---help---
+	  If you say Y here and create a character special file
+	  /dev/ixp2000_thd with major number 10 and minor number 194
+	  using mknod ("man mknod"), you will be able to send signals
+	  from the IXP2000's microengines to userspace applications
+	  without having to resort to polling.
+
+	  If you're unsure, you probably don't need this -- say N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ixp2000_thd.
+
 config TANBAC_TB0219
 	tristate "TANBAC TB0219 base board support"
 	depends TANBAC_TB0229
diff -urN linux-2.6.12-rc4.orig/drivers/char/Makefile linux-2.6.12-rc4/drivers/char/Makefile
--- linux-2.6.12-rc4.orig/drivers/char/Makefile	2005-05-09 22:17:46.000000000 +0200
+++ linux-2.6.12-rc4/drivers/char/Makefile	2005-05-09 22:16:05.000000000 +0200
@@ -81,6 +81,7 @@
 obj-$(CONFIG_NWFLASH) += nwflash.o
 obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
 obj-$(CONFIG_TANBAC_TB0219) += tb0219.o
+obj-$(CONFIG_IXP2000_THD) += ixp2000_thd.o
 
 obj-$(CONFIG_WATCHDOG)	+= watchdog/
 obj-$(CONFIG_MWAVE) += mwave/


