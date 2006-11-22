Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755730AbWKVUxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbWKVUxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755768AbWKVUxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:53:12 -0500
Received: from outbound-red.frontbridge.com ([216.148.222.49]:8358 "EHLO
	outbound2-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1755728AbWKVUxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:53:09 -0500
X-BigFish: VP
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Wed, 22 Nov 2006 13:57:36 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [RFC] char: Add MFGPT driver for the CS5535/CS5536
Message-ID: <20061122205736.GA588@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 22 Nov 2006 20:53:00.0167 (UTC)
 FILETIME=[32091970:01C70E78]
X-WSS-ID: 697A67262MC577664-02-01
Content-Type: multipart/mixed;
 boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

The Geode CS5535 and CS5536 companion chips contain a block of timers
known as the Multi Function General Purpose Timers.  The primary use
for these timers is to control an output pin nominally connected to a
LED or other visual indicator.  They also can be configured to reset the
system, which is handy as a watchdog timer.  they _can_ be used to
fire software interrupts on timeout too, but this is less useful since the
timers are fairly low resolution and there are much better options available.

The attached driver provides a low-level interface to the block, and 
allows for other kernel drivers to use the timers.  It also provides 
the usual ioctl() and sysfs interfaces.   Please review and comment
accordingly.

Thanks,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--W/nzBZO5zC0uMSeA
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=mfgpt.patch
Content-Transfer-Encoding: 7bit

[PATCH] char: Add a MFGPT driver for the CS5535/CS5536

From: Jordan Crouse <jordan.crouse@amd.com>

Add support for the MFPGT timers on the CS5535 and CS5536.  The MFGPT
timers provide special timers that can be used to fire interrupts,
control output pins, or reset the system.

Signed-off-by:  Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/char/Kconfig  |    9 
 drivers/char/Makefile |    1 
 drivers/char/mfgpt.c  |  964 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfgpt.h |   95 +++++
 4 files changed, 1069 insertions(+), 0 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 2af12fc..f1e6543 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -1034,6 +1034,15 @@ config MMTIMER
 	  The mmtimer device allows direct userspace access to the
 	  Altix system timer.
 
+config MFGPT
+	tristate "AMD Geode multi-purpose timers"
+	default m
+	depends on X86 && PCI
+	help
+	  AMD Geode processors have several multi-purpose timers available.
+	  Say Y here to define an API for other kernel drivers to use
+	  the timers.
+
 source "drivers/char/tpm/Kconfig"
 
 config TELCLOCK
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 777cad0..4396ba5 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_CS5535_GPIO)	+= cs5535_gpio
 obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
 obj-$(CONFIG_TELCLOCK)		+= tlclk.o
+obj-$(CONFIG_MFGPT)		+= mfgpt.o
 
 obj-$(CONFIG_WATCHDOG)		+= watchdog/
 obj-$(CONFIG_MWAVE)		+= mwave/
diff --git a/drivers/char/mfgpt.c b/drivers/char/mfgpt.c
new file mode 100644
index 0000000..40b9558
--- /dev/null
+++ b/drivers/char/mfgpt.c
@@ -0,0 +1,964 @@
+/*     Driver/API for AMD Geode Multi-Function General Purpose Timers (MFGPT)
+ *
+ *     Copyright (C) 2006, Advanced Micro Devices, Inc.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/cdev.h>
+#include <linux/mfgpt.h>
+#include <asm/io.h>
+#include <asm/msr.h>
+#include <asm/uaccess.h>
+
+#define NAME           "geode-mfgpt"
+#define ERR(str, args...) printk(KERN_ERR NAME ": [ERROR]" str, ##args)
+
+/* Status bits */
+
+#define STATUS_SETUP    0x01
+#define STATUS_RUNNING  0x02
+#define STATUS_WAIT     0x04
+
+/* MSR definitions (for events) */
+
+#define MFGPT_IRQ_MSR 0x51400028
+#define MFGPT_NR_MSR  0x51400029
+
+#define MFGPT_SETUP_CNTEN  (1 << 15)
+#define MFGPT_SETUP_CMP2   (1 << 14)
+#define MFGPT_SETUP_CMP1   (1 << 13)
+#define MFGPT_SETUP_SETUP  (1 << 12)
+#define MFGPT_SETUP_STOPEN (1 << 11)
+#define MFGPT_SETUP_EXTEN  (1 << 10)
+#define MFGPT_SETUP_REVEN  (1 << 5)
+#define MFGPT_SETUP_CLKSEL (1 << 4)
+
+#define MFGPT_SETUP_CMP2MODE_SHIFT 8
+#define MFGPT_SETUP_CMP1MODE_SHIFT 6
+
+/* Useful macros */
+
+#define MFGPT_IOADDR(i, r) (mfgpt_iobase + (r) + ((i) * 8))
+#define MFGPT_OUT(i, r, v) iowrite16(v, MFGPT_IOADDR(i, r))
+#define MFGPT_IN(i, r)     ioread16(MFGPT_IOADDR(i, r))
+
+#define INDEX_VALID(i)    ((i) >= 0 && (i) < MFGPT_TIMER_COUNT)
+#define TIMER_VALID(i)    (timers[i] != NULL)
+#define TIMER_SETUP(i)    (timers[i]->status & STATUS_SETUP)
+#define TIMER_RUNNING(i)  (timers[i]->status & STATUS_RUNNING)
+#define TIMER_WAITCMP1(i) (timers[i]->status & STATUS_CMP1WAIT)
+#define TIMER_WAITCMP2(i) (timers[i]->status & STATUS_CMP2WAIT)
+
+#define REGISTER_VALID(r) \
+        (((r) == MFGPT_REG_CMP1) || ((r) == MFGPT_REG_CMP2) || \
+         ((r) == MFGPT_REG_COUNTER) || ((r) == MFGPT_REG_SETUP))
+
+#define IS_TIMER_VALID(i)    (INDEX_VALID(i) && TIMER_VALID(i))
+#define IS_TIMER_SETUP(i)    (IS_TIMER_VALID(i) && TIMER_SETUP(i))
+#define IS_TIMER_RUNNING(i)  (IS_TIMER_SETUP(i) && TIMER_RUNNING(i))
+
+#define IS_CMP1_IRQ_EVENT(i) \
+	((timers[i]->setup.cmp1mode == MFGPT_MODE_EVENT) && \
+	(timers[i]->setup.cmp1event == MFGPT_EVENT_IRQ))
+
+#define IS_CMP2_IRQ_EVENT(i) \
+	((timers[i]->setup.cmp2mode == MFGPT_MODE_EVENT) && \
+	(timers[i]->setup.cmp2event == MFGPT_EVENT_IRQ))
+
+struct mfgpt_timer_t {
+	int index;
+	u8 status;
+	wait_queue_head_t wait;
+	struct mfgpt_setup_t setup;
+	mfgpt_callback callback;
+	void *data;
+	struct semaphore mutex;
+	struct class_device *cdev;
+	int kernel;
+};
+
+static struct mfgpt_timer_t *timers[MFGPT_TIMER_COUNT];
+static void *mfgpt_iobase;
+
+static int irq = 10;
+module_param(irq, int, 0444);
+MODULE_PARM_DESC(irq, "IRQ of the MFGPT device");
+
+static int mfgpt_major;
+static struct class *mfgpt_class;
+
+
+static struct cdev mfgpt_cdev = {
+	.kobj = {.name = "mfgpt",},
+	.owner = THIS_MODULE
+};
+
+static ssize_t sys_print_register(struct class_device *dev, char *buf, int reg)
+{
+	struct mfgpt_timer_t *timer = class_get_devdata(dev);
+	u16 val = MFGPT_IN(timer->index, reg);
+
+	return sprintf(buf, "%4.4X\n", val);
+}
+
+static ssize_t sys_show_setup(struct class_device *dev, char *buf)
+{
+	return sys_print_register(dev, buf, MFGPT_REG_SETUP);
+}
+
+static ssize_t sys_show_counter(struct class_device *dev, char *buf)
+{
+	return sys_print_register(dev, buf, MFGPT_REG_COUNTER);
+}
+
+static ssize_t sys_show_cmp1(struct class_device *dev, char *buf)
+{
+	return sys_print_register(dev, buf, MFGPT_REG_CMP1);
+}
+
+static ssize_t sys_show_cmp2(struct class_device *dev, char *buf)
+{
+	return sys_print_register(dev, buf, MFGPT_REG_CMP2);
+}
+
+static struct class_device_attribute mfgpt_attrs[] = {
+	__ATTR(setup, S_IRUGO, sys_show_setup, NULL),
+	__ATTR(counter, S_IRUGO, sys_show_counter, NULL),
+	__ATTR(cmp1, S_IRUGO, sys_show_cmp1, NULL),
+	__ATTR(cmp2, S_IRUGO, sys_show_cmp2, NULL),
+};
+
+/* mfgpt_find_timer
+   Locate an unused timer
+   Return:  index of the timer to use, or -1 if nothing is available
+*/
+
+static int mfgpt_find_timer(void)
+{
+	int index;
+
+	for (index = 0; index < MFGPT_TIMER_COUNT; index++)
+		if (IS_TIMER_VALID(index) && !TIMER_SETUP(index))
+			return index;
+
+	return -1;
+}
+
+/* mfgpt_set_events
+   Set up the event bits (reset, nmi, irq) and later set the GPIO states too
+   index - the timer to setup
+   cmp - the comparator to set up for
+   setup - true if we are setting up the events
+*/
+
+static void mfgpt_set_events(int index, u8 cmp, u8 setup)
+{
+
+	struct mfgpt_timer_t *timer = timers[index];
+	int event = (cmp == MFGPT_CMP1)
+		? timer->setup.cmp1event : timer->setup.cmp2event;
+	int shift = (cmp == MFGPT_CMP1) ? 0 : 8;
+	unsigned long msr = 0, value = 0, dummy = 0;
+	u32 mask = 0;
+
+	switch (event) {
+	case MFGPT_EVENT_RESET:
+		msr = MFGPT_NR_MSR;
+		mask = (1 << (index + 24));
+		break;
+
+	case MFGPT_EVENT_NMI:
+		msr = MFGPT_NR_MSR;
+		mask = (1 << (index + shift));
+		break;
+
+	case MFGPT_EVENT_IRQ:
+		msr = MFGPT_IRQ_MSR;
+		mask = (1 << (index + shift));
+		break;
+
+	default:
+		return;
+	}
+
+	rdmsr(msr, value, dummy);
+
+	if (setup)
+		value |= mask;
+	else
+		value &= ~mask;
+
+	wrmsr(msr, value, dummy);
+}
+
+int mfgpt_stop_timer(int index)
+{
+	if (!IS_TIMER_SETUP(index))
+		return -EINVAL;
+
+	if (TIMER_RUNNING(index)) {
+		MFGPT_OUT(index, MFGPT_REG_SETUP, 0x0);
+
+		if (timers[index]->setup.cmp1mode == MFGPT_MODE_EVENT)
+			mfgpt_set_events(index, MFGPT_CMP1, 0);
+
+		if (timers[index]->setup.cmp2mode == MFGPT_MODE_EVENT)
+			mfgpt_set_events(index, MFGPT_CMP2, 0);
+
+		timers[index]->status &= ~STATUS_RUNNING;
+	}
+
+	return 0;
+}
+
+int mfgpt_start_timer(int index)
+{
+	if (!IS_TIMER_SETUP(index))
+		return -EINVAL;
+
+	if (!TIMER_RUNNING(index)) {
+
+		if (timers[index]->setup.cmp1mode == MFGPT_MODE_EVENT)
+			mfgpt_set_events(index, MFGPT_CMP1, 1);
+
+		if (timers[index]->setup.cmp2mode == MFGPT_MODE_EVENT)
+			mfgpt_set_events(index, MFGPT_CMP2, 1);
+
+		/* Clear the event bits */
+
+		MFGPT_OUT(index, MFGPT_REG_SETUP,
+			  MFGPT_SETUP_CMP2 | MFGPT_SETUP_CMP1);
+
+		/* Fire */
+		timers[index]->status |= STATUS_RUNNING;
+
+		MFGPT_OUT(index, MFGPT_REG_SETUP, MFGPT_SETUP_CNTEN);
+	}
+
+	return 0;
+}
+
+int mfgpt_get_status(int index, u8 cmp)
+{
+	u32 status = MFGPT_IN(index, MFGPT_REG_SETUP);
+
+	if (cmp == MFGPT_CMP1)
+		return (status & MFGPT_SETUP_CMP1);
+	else
+		return (status & MFGPT_SETUP_CMP2);
+}
+
+int mfgpt_get_register(int index, int reg, u16 * value)
+{
+	if (!IS_TIMER_SETUP(index))
+		return -EINVAL;
+
+	if (!REGISTER_VALID(reg))
+		return -EINVAL;
+
+	*value = MFGPT_IN(index, reg);
+	return 0;
+}
+
+int mfgpt_set_counter(int index, u16 value)
+{
+	if (!IS_TIMER_SETUP(index))
+		return -EINVAL;
+
+	if (TIMER_RUNNING(index))
+		return -EINVAL;
+
+	MFGPT_OUT(index, MFGPT_REG_COUNTER, value);
+	return 0;
+}
+
+int mfgpt_set_comparators(int index, u16 cmp1, u16 cmp2)
+{
+	if (!IS_TIMER_SETUP(index))
+		return -EINVAL;
+
+	/* Can only set registers when the timer is not running */
+
+	if (TIMER_RUNNING(index))
+		return -EINVAL;
+
+	/* If either comparator is disabled, then set that associated value
+	 * to the max */
+
+	if ((timers[index]->setup.cmp1mode == MFGPT_MODE_DISABLE) &&
+	    (cmp1 != MFGPT_MAX_CMP_VALUE)) {
+		printk(KERN_INFO NAME ":  Warning - cmp1 is disabled.  Setting value to max.\n");
+		cmp1 = MFGPT_MAX_CMP_VALUE;
+	}
+
+	if ((timers[index]->setup.cmp2mode == MFGPT_MODE_DISABLE) &&
+	    cmp2 != MFGPT_MAX_CMP_VALUE) {
+		printk(KERN_INFO NAME ":  Warning - cmp2 is disabled.  Setting value to max.\n");
+		cmp2 = MFGPT_MAX_CMP_VALUE;
+	}
+
+	/* Now, do some sanity checks */
+	if (cmp2 == 0)
+		return -EINVAL;
+
+	if((cmp2 < cmp1) && timers[index]->setup.cmp1mode != MFGPT_MODE_DISABLE)
+		return -EINVAL;
+
+	/* Write the values */
+
+	MFGPT_OUT(index, MFGPT_REG_CMP1, cmp1);
+	MFGPT_OUT(index, MFGPT_REG_CMP2, cmp2);
+	return 0;
+}
+
+int mfgpt_register_callback(int index, mfgpt_callback callback, void *data)
+{
+
+	if (!IS_TIMER_SETUP(index))
+		return -EINVAL;
+
+	timers[index]->callback = callback;
+	timers[index]->data = data;
+
+	return 0;
+}
+
+int mfgpt_alloc_timer(int *index, struct mfgpt_setup_t *setup)
+{
+	u32 val = 0;
+	int in = *index;
+
+	if (in == -1) {
+		if ((in = mfgpt_find_timer()) == -1)
+			return -EINVAL;
+	}
+
+	if (!IS_TIMER_VALID(in))
+		return -ENODEV;
+
+	if (TIMER_SETUP(in))
+		return -EPERM;
+
+	/* Sanity checks */
+
+	/* Make sure the desired timer is in bounds */
+
+	if (setup->clock > MFGPT_CLOCK_14318MHZ)
+		return -EINVAL;
+
+	if (setup->cmp1mode > MFGPT_MODE_EVENT || setup->cmp2mode > MFGPT_MODE_EVENT)
+		return -EINVAL;
+
+	if (setup->cmp1event > MFGPT_EVENT_RESET || setup->cmp2event > MFGPT_EVENT_RESET)
+		return -EINVAL;
+
+	/* Timers 6 and 7 can't be on the 14318 Mhz clock */
+	if (in > 5 && setup->clock == MFGPT_CLOCK_14318MHZ)
+		return -EINVAL;
+
+	/* You must specify an event to fire when you choose to cause one */
+	if (setup->cmp1mode == MFGPT_MODE_EVENT &&
+	    setup->cmp1event == MFGPT_EVENT_NONE)
+		return -EINVAL;
+
+	if (setup->cmp2mode == MFGPT_MODE_EVENT &&
+	    setup->cmp2event == MFGPT_EVENT_NONE)
+		return -EINVAL;
+
+	/* Can't reset on CMP1 */
+
+	if (setup->cmp1event == MFGPT_EVENT_RESET)
+		return -EINVAL;
+
+	timers[in]->status = STATUS_SETUP;
+	memcpy(&timers[in]->setup, setup, sizeof(timers[in]->setup));
+
+	/* Setup the value to write to the setup register */
+
+	/* MFGPT_SCALE */
+	val |= setup->scale;
+
+	/* MFGPT_CLKSEL */
+	if (setup->clock == MFGPT_CLOCK_14318MHZ)
+		val |= MFGPT_SETUP_CLKSEL;
+
+	/* MFGPT_REV_EN */
+	if (setup->flags & MFGPT_FLAG_REVEN)
+		val |= MFGPT_SETUP_REVEN;
+
+	/* MFGPT_CMP1MODE */
+	val |= ((setup->cmp1mode) & 0x03) << MFGPT_SETUP_CMP1MODE_SHIFT;
+
+	/* MFGPT_CMP2MODE */
+	val |= ((setup->cmp2mode) & 0x03) << MFGPT_SETUP_CMP2MODE_SHIFT;
+
+	/* MFGPT_EXT_EN */
+	if (setup->flags & MFGPT_FLAG_EXTEN)
+		val |= MFGPT_SETUP_EXTEN;
+
+	/* MFGPT_STOP_EN */
+	if (setup->flags & MFGPT_FLAG_STOPEN)
+		val |= MFGPT_SETUP_STOPEN;
+
+	/* Clear output status for CMP 1 & 2. */
+	val |= 0x6000;
+
+	printk("DEBUG:  Write %x\n", val);
+
+	MFGPT_OUT(in, MFGPT_REG_SETUP, val);
+
+	/* Set both the comparators to the highest value - these need to be
+	   rewritten by the app before the timer starts
+	*/
+
+	MFGPT_OUT(in, MFGPT_REG_CMP1, MFGPT_MAX_CMP_VALUE);
+	MFGPT_OUT(in, MFGPT_REG_CMP2, MFGPT_MAX_CMP_VALUE);
+
+	/* Set a flag that indicates that the kernel owns this structure
+	   If this is called from the IOCTL, it will be cleared there.
+	*/
+
+	timers[in]->kernel = 1;
+	printk(KERN_INFO NAME ": Timer %d has been setup.\n", in);
+
+	*index = in;
+	return 0;
+}
+
+static irqreturn_t mfgpt_interrupt(int irq, void *dev_id)
+{
+	int index;
+	u32 status;
+	int events;
+
+	for (index = 0; index < MFGPT_TIMER_COUNT; index++) {
+		if (!IS_TIMER_RUNNING(index))
+			continue;
+
+		status = MFGPT_IN(index, MFGPT_REG_SETUP);
+		events = 0;
+
+		if (IS_CMP1_IRQ_EVENT(index)) {
+			if (status & MFGPT_SETUP_CMP1)
+				events |= MFGPT_CMP1;
+		}
+
+		if (IS_CMP2_IRQ_EVENT(index)) {
+			if (status & MFGPT_SETUP_CMP2)
+				events |= MFGPT_CMP2;
+		}
+
+		if (events) {
+			MFGPT_OUT(index, MFGPT_REG_SETUP, status);
+
+			if (timers[index]->callback != NULL)
+				timers[index]->callback(index, events,
+							timers[index]->data);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* This array is used to commmunicate the interrupt status through
+ * to to the wait event */
+
+static u8 mfgpt_status[MFGPT_TIMER_COUNT];
+static spinlock_t status_lock;
+
+/* Remember that this is getting called in an interrupt context */
+
+static void mfgpt_wait_cb(int index, int events, void *data)
+{
+	spin_lock(&status_lock);
+	mfgpt_status[index] = events;
+	spin_unlock(&status_lock);
+
+	if (timers[index]->status & STATUS_WAIT)
+		wake_up(&timers[index]->wait);
+}
+
+static int mfgpt_ioctl_alloc_timer(int index, void __user * p)
+{
+	struct mfgpt_setup_t setup;
+	int ret;
+
+	if (copy_from_user(&setup, p, sizeof(setup)))
+		return -EFAULT;
+
+	ret = mfgpt_alloc_timer(&index, &setup);
+
+	if (ret)
+		return ret;
+
+	/* Clear the ownership to indicate that this is owned by the user land */
+	timers[index]->kernel = 0;
+
+	/* If the setup is waiting for an interrupt to come back, we need
+	   to register a callback */
+
+	if (IS_CMP1_IRQ_EVENT(index) || IS_CMP2_IRQ_EVENT(index))
+		mfgpt_register_callback(index, mfgpt_wait_cb, NULL);
+
+	return 0;
+}
+
+static int mfgpt_ioctl_set_counter(int index, void __user * p)
+{
+	u16 value;
+
+	if (copy_from_user(&value, p, sizeof(value)))
+		return -EFAULT;
+
+	return mfgpt_set_counter(index, value);
+}
+
+static int mfgpt_ioctl_set_comparators(int index, void __user * p)
+{
+	struct mfgpt_compare_t cmp;
+
+	if (copy_from_user(&cmp, p, sizeof(cmp)))
+		return -EFAULT;
+
+	return mfgpt_set_comparators(index, cmp.cmp1, cmp.cmp2);
+}
+
+static int mfgpt_ioctl_get_register(int index, int reg, void __user * p)
+{
+	u16 value;
+	int ret;
+
+	if (!IS_TIMER_SETUP(index))
+		return -EINVAL;
+
+	ret = mfgpt_get_register(index, reg, &value);
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user(p, &value, sizeof(value)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/* Wait for the next event */
+
+static int mfgpt_wait_for_event(int index, int *cmp)
+{
+	unsigned long flags;
+	DECLARE_WAITQUEUE(wait, current);
+	int ret = 0;
+
+	*cmp = 0;
+
+	/* At least one of the comparators should fire an interrupt */
+	if (!IS_CMP1_IRQ_EVENT(index) && !IS_CMP2_IRQ_EVENT(index))
+		return -EINVAL;
+
+	/* Of course, the timer should be running */
+	if (!IS_TIMER_RUNNING(index))
+		return -EINVAL;
+
+	timers[index]->status |= STATUS_WAIT;
+	add_wait_queue(&timers[index]->wait, &wait);
+
+	spin_lock_irqsave(&status_lock, flags);
+	mfgpt_status[index] = 0;
+	spin_unlock_irqrestore(&status_lock, flags);
+
+	for (;;) {
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_irqsave(&status_lock, flags);
+
+		if (mfgpt_status[index] & MFGPT_CMP1)
+			*cmp |= MFGPT_CMP1;
+
+		if (mfgpt_status[index] & MFGPT_CMP2)
+			*cmp |= MFGPT_CMP2;
+
+		spin_unlock_irqrestore(&status_lock, flags);
+
+		if (*cmp != 0)
+			break;
+
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
+		schedule();
+	}
+
+	remove_wait_queue(&timers[index]->wait, &wait);
+	set_current_state(TASK_RUNNING);
+
+	timers[index]->status &= ~STATUS_WAIT;
+	return ret;
+}
+
+static int
+mfgpt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	    unsigned long arg)
+{
+
+	void __user *p = (void __user *)arg;
+	int ret = 0;
+	u32 index = iminor(inode);
+	int val;
+
+	switch (cmd) {
+	case MFGPT_ALLOC_TIMER:
+		ret = mfgpt_ioctl_alloc_timer(index, p);
+		break;
+
+	case MFGPT_SET_COMPARATORS:
+		ret = mfgpt_ioctl_set_comparators(index, p);
+		break;
+
+	case MFGPT_SET_COUNTER:
+		ret = mfgpt_ioctl_set_counter(index, p);
+		break;
+
+	case MFGPT_GET_CMP1:
+		ret = mfgpt_ioctl_get_register(index, MFGPT_REG_CMP1, p);
+		break;
+
+	case MFGPT_GET_CMP2:
+		ret = mfgpt_ioctl_get_register(index, MFGPT_REG_CMP2, p);
+		break;
+
+	case MFGPT_GET_COUNTER:
+		ret = mfgpt_ioctl_get_register(index, MFGPT_REG_COUNTER, p);
+		break;
+
+	case MFGPT_START_TIMER:
+		ret = mfgpt_start_timer(index);
+		break;
+
+	case MFGPT_WAIT_EVENT:
+		ret = mfgpt_wait_for_event(index, &val);
+		break;
+
+	case MFGPT_STOP_TIMER:
+		ret = mfgpt_stop_timer(index);
+		break;
+
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	return ret;
+}
+
+static int mfgpt_open(struct inode *inode, struct file *file)
+{
+
+	u32 index = iminor(inode);
+
+	if (!IS_TIMER_VALID(index))
+		return -EINVAL;
+
+	/* Bail out if the kernel has ownership of this timer */
+
+	if (timers[index]->kernel != 0)
+		return -EPERM;
+
+	if (down_trylock(&timers[index]->mutex))
+		return -EBUSY;
+
+	return nonseekable_open(inode, file);
+}
+
+static int mfgpt_release(struct inode *inode, struct file *file)
+{
+	u32 index = iminor(inode);
+	up(&timers[index]->mutex);
+	return 0;
+}
+
+static struct file_operations mfgpt_fops = {
+	.owner = THIS_MODULE,
+	.open = mfgpt_open,
+	.ioctl = mfgpt_ioctl,
+	.release = mfgpt_release
+};
+
+static void mfgpt_free_dev(int index)
+{
+	int i;
+
+	dev_t devid = MKDEV(mfgpt_major, index);
+
+	if (timers[index] == NULL)
+		return;
+
+	for(i = 0; i < ARRAY_SIZE(mfgpt_attrs); i++)
+		class_device_remove_file(timers[index]->cdev,
+					 &mfgpt_attrs[i]);
+
+	class_device_destroy(mfgpt_class, devid);
+
+	kfree(timers[index]);
+	timers[index] = NULL;
+}
+
+static void __devexit 
+mfgpt_remove_device(struct pci_dev *dev, int bar)
+{
+	int index;
+	dev_t devid = MKDEV(mfgpt_major, 0);
+
+	free_irq(irq, (void *) mfgpt_iobase);
+
+	for (index = 0; index < MFGPT_TIMER_COUNT; index++)
+		mfgpt_free_dev(index);
+
+	pci_iounmap(dev, mfgpt_iobase);
+	mfgpt_iobase = NULL;
+
+	pci_release_region(dev, bar);
+
+	cdev_del(&mfgpt_cdev);
+	unregister_chrdev_region(devid, MFGPT_TIMER_COUNT);
+	class_destroy(mfgpt_class);
+}
+
+static int __devinit mfgpt_alloc_dev(struct pci_dev *dev, int index)
+{
+	int i;
+	dev_t devid;
+	int ret;
+
+	timers[index] = kzalloc(sizeof(struct mfgpt_timer_t), GFP_KERNEL);
+
+	if (timers[index] == NULL) {
+		ERR("Couldn't allocate memory for timer %d.\n", index);
+		return -ENOMEM;
+	}
+
+	timers[index]->index = index;
+
+	init_waitqueue_head(&timers[index]->wait);
+	init_MUTEX(&timers[index]->mutex);
+
+	devid = MKDEV(mfgpt_major, index);
+
+	timers[index]->cdev =
+		class_device_create(mfgpt_class, NULL, devid, &dev->dev, "mfgpt%d",
+				    index);
+
+	class_set_devdata(timers[index]->cdev, timers[index]);
+
+	ret = 0;
+
+	for(i = 0; i < ARRAY_SIZE(mfgpt_attrs) && !ret; i++)
+		ret = class_device_create_file(timers[index]->cdev,
+					       &mfgpt_attrs[i]);
+
+	if (ret == 0)
+		return 0;
+
+	ERR("Couldn't create the sysfs files for timer %d\n", index);
+	class_device_destroy(mfgpt_class, devid);
+
+	kfree(timers[index]);
+	timers[index] = NULL;
+
+	return ret;
+}
+
+static void __devinit
+mfgpt_setup_irq(int irq, u8 mask) {
+
+	int bit, offset;
+	u32 val, dummy;
+
+	rdmsr(0x51400022, val, dummy);
+
+	for (bit = 0; bit < MFGPT_TIMER_COUNT; bit++) {
+		if (!(mask & (1 << bit)))
+			continue;
+
+		offset = (bit % 4) * 4;
+
+		val |= (irq & 0x0F) << offset;
+		val |= (irq & 0x0F) << (offset + 16);
+
+		/* Clear the other bit in the pair, since we've already set it up */
+
+		if (bit < 4)
+			mask &= ~((1 << bit) | (1 << (bit + 4)));
+	}
+
+	wrmsr(0x5140022, val, dummy);
+}
+
+static int __devinit
+mfgpt_setup_device(struct pci_dev *dev, int bar) 
+{
+	int ret, index, active = 0;
+	dev_t devid;	
+	int i;
+	u8 mask = 0;
+	unsigned short val;
+
+	mfgpt_class = class_create(THIS_MODULE, "mfgpt");
+	
+	if (IS_ERR(mfgpt_class)) {
+		ERR("Unable to allocate the mfgpt class.\n");
+		return PTR_ERR(mfgpt_class);
+	}
+
+	ret = alloc_chrdev_region(&devid, 0, MFGPT_TIMER_COUNT, NAME);
+
+	if (ret) {
+		ERR("Unable to allocate the chrdev region.\n");
+		goto eclass;
+	}
+
+	mfgpt_major = MAJOR(devid);
+	cdev_init(&mfgpt_cdev, &mfgpt_fops);
+	ret = cdev_add(&mfgpt_cdev, devid, MFGPT_TIMER_COUNT);
+
+	if (ret) {
+		ERR("Unable to add the cdev.\n");
+		goto echrdev;
+	}
+	
+	if ((ret = pci_enable_device_bars(dev, 1 << bar))) {
+		ERR("Couldn't enable the PCI device.\n");
+		goto ecdev;
+	}
+
+	if ((ret = pci_request_region(dev, bar, NAME))) {
+		ERR("Couldn't reserve the PCI region.\n");
+		goto ecdev;
+	}
+
+	spin_lock_init(&status_lock);
+
+	mfgpt_iobase = pci_iomap(dev, bar, 64);
+
+	if (mfgpt_iobase == NULL) {
+		ERR("Couldn't map the IO space.\n");
+		ret = -ENOMEM;
+		goto erequest;
+	}
+
+	
+	/* Figure out which timers are not allocated */
+	
+	for(i = 0; i < MFGPT_TIMER_COUNT; i++) {
+		val = MFGPT_IN(i, MFGPT_REG_SETUP);
+
+		if (!(val & MFGPT_SETUP_SETUP)) {
+			
+			if (mfgpt_alloc_dev(dev, i)) {
+				ERR("Could not allocate mfgpt%d.\n", index);
+				continue;
+			}
+			
+			active++;
+		}
+	}
+	
+	if (active == 0) {
+		ERR("There are no free timers to allocate.\n");
+		ret = -ENODEV;
+		goto etimers;
+	}
+
+
+	ret = request_irq(irq, mfgpt_interrupt,
+			  SA_INTERRUPT | SA_SHIRQ, NAME, (void *) mfgpt_iobase);
+
+	if (ret == 0) {
+		printk(KERN_INFO NAME ": %d timers available.\n", active);
+
+		return 0;
+	}
+
+	ERR("Could not allocate the interrupt.\n");
+
+ etimers:
+	/* Error cleanup */
+
+	for (index = 0; index < MFGPT_TIMER_COUNT; index++)
+		mfgpt_free_dev(index);
+
+	pci_iounmap(dev, mfgpt_iobase);
+	mfgpt_iobase = NULL;
+
+ erequest:
+	pci_release_region(dev, bar);
+
+ ecdev:
+	cdev_del(&mfgpt_cdev);
+
+ echrdev:
+	unregister_chrdev_region(devid, MFGPT_TIMER_COUNT);
+
+ eclass:
+	class_destroy(mfgpt_class);
+
+	ERR("initialization failed.\n");
+	return ret;
+
+}
+
+static struct pci_dev *geode_sbdev;
+
+static struct pci_device_id geode_sbdevs[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_ISA) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA) }
+};
+
+
+static int __init mfgpt_init(void)
+{
+	struct pci_dev *pdev;
+	int dev;
+
+	/* Locate the MFGPT south bridge device */
+	
+	for(dev = 0; dev < ARRAY_SIZE(geode_sbdevs); dev++) {
+		pdev = pci_get_device(geode_sbdevs[dev].vendor,
+				      geode_sbdevs[dev].device, NULL);
+		
+		if (pdev == NULL)
+			continue;
+
+		geode_sbdev = pdev;
+
+		
+		/* The MFGPT device is bar 2 on all southbridges */
+		return mfgpt_setup_device(pdev, 2);
+	}
+
+	return -ENODEV;
+}
+
+static void __exit mfgpt_exit(void)
+{
+	/* The MFGPT device is bar 2 on all southbridges */
+	return mfgpt_remove_device(geode_sbdev, 2);
+}
+
+module_init(mfgpt_init);
+module_exit(mfgpt_exit);
+
+MODULE_AUTHOR("Advanced Micro Devices, Inc.");
+MODULE_DESCRIPTION("Multi-function General Purpose Driver API");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfgpt.h b/include/linux/mfgpt.h
new file mode 100644
index 0000000..4943ff9
--- /dev/null
+++ b/include/linux/mfgpt.h
@@ -0,0 +1,95 @@
+#ifndef MFGPT_H_
+#define MFGPT_H_
+
+/* The number of timers that are available */
+#define MFGPT_TIMER_COUNT 7
+
+/* The maximum possible value of the comparators */
+#define MFGPT_MAX_CMP_VALUE 0xFFFF
+
+/* Register definitions */
+
+#define MFGPT_REG_CMP1    0
+#define MFGPT_REG_CMP2    2
+#define MFGPT_REG_COUNTER 4
+#define MFGPT_REG_SETUP   6
+
+/* The list of modes for each comparator */
+
+#define MFGPT_MODE_DISABLE 0
+#define MFGPT_MODE_EQUAL   1
+#define MFGPT_MODE_GE      2
+#define MFGPT_MODE_EVENT   3
+
+/* For comparators set to MODE_EVENT, the following events can be specified */
+
+#define MFGPT_EVENT_NONE   0
+#define MFGPT_EVENT_IRQ    1
+#define MFGPT_EVENT_NMI    2
+#define MFGPT_EVENT_RESET  3
+
+/* The following are the two clocks that are available */
+
+#define MFGPT_CLOCK_32KHZ    0
+#define MFGPT_CLOCK_14318MHZ 1
+
+/* The following are the flags that can be set for each timer */
+
+#define MFGPT_FLAG_REVEN     0x01
+#define MFGPT_FLAG_EXTEN     0x02
+#define MFGPT_FLAG_STOPEN    0x04
+
+/* Callback used when in EVENT_IRQ mode */
+
+typedef void (*mfgpt_callback) (int, int, void *);
+
+/* Values for denoting CMP1 or CMP2 where possible */
+
+#define MFGPT_CMP1        0x01
+#define MFGPT_CMP2        0x02
+
+struct mfgpt_setup_t {
+	u8 clock;
+	u8 scale;
+	u16 flags;
+
+	u8 cmp1mode;
+	u8 cmp1event;
+
+	u8 cmp2mode;
+	u8 cmp2event;
+};
+
+struct mfgpt_compare_t {
+	u16 cmp1;
+	u16 cmp2;
+};
+
+#define MFGPT_ALLOC_TIMER      _IOW('G', 0, struct mfgpt_setup_t)
+#define MFGPT_SET_COMPARATORS  _IOW('G', 1, struct mfgpt_compare_t)
+#define MFGPT_SET_COUNTER      _IOW('G', 4, u16)
+#define MFGPT_GET_CMP1         _IOW('G', 5, u16)
+#define MFGPT_GET_CMP2         _IOW('G', 6, u16)
+#define MFGPT_GET_COUNTER      _IOW('G', 7, u16)
+
+#define MFGPT_START_TIMER     _IO('G', 8)
+#define MFGPT_WAIT_EVENT      _IO('G', 9)
+#define MFGPT_STOP_TIMER      _IO('G', 10)
+
+#ifdef _KERNEL_
+
+#define mfgpt_set_cmp1_only(timer, val) mfgpt_set_comparators(timer, val, MFGPT_MAX_CMP_VALUE)
+#define mfgpt_set_cmp2_only(timer, val) mfgpt_set_comparators(timer, MFGPT_MAX_CMP_VALUE, val)
+
+int mfgpt_alloc_timer(int *, struct mfgpt_setup_t *);
+int mfgpt_register_callback(int index, mfgpt_callback, void *);
+
+int mfgpt_set_counter(int, u16);
+int mfgpt_set_comparators(int, u16, u16);
+int mfgpt_get_register(int, int, u16 *);
+int mfgpt_get_status(int, u8);
+int mfgpt_start_timer(int);
+int mfgpt_stop_timer(int);
+#endif
+
+#endif

--W/nzBZO5zC0uMSeA--


