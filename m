Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWCWOk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWCWOk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 09:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWCWOk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 09:40:56 -0500
Received: from webapps.arcom.com ([194.200.159.168]:25609 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932244AbWCWOkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 09:40:55 -0500
Message-ID: <4422B370.8010606@cantab.net>
Date: Thu, 23 Mar 2006 14:40:48 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: ucb1x00 audio & zaurus touchscreen
References: <20060322122052.GN14075@elf.ucw.cz>
In-Reply-To: <20060322122052.GN14075@elf.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------070306060103040102010603"
X-OriginalArrivalTime: 23 Mar 2006 14:40:55.0503 (UTC) FILETIME=[CAB4B5F0:01C64E87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070306060103040102010603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Hi!
> 
> First, I'd like to ask: what is status of ucb1x00 audio in 2.6? I do
> have .c file here, but do not have corresponding header files...
> 
> Then, I'd like to announce that I finally got touchscreen to somehow
> work. Patch is very ugly and adds filtering into kernel (no-no), but
> does the trick, and can even coexist with battery reading code. [Don't
> bother commenting on style of this patch, it is for ilustration, I'd
> not be crazy enough to try to push it.]

This is what I have lurking in an equally hacky state.

--------------070306060103040102010603
Content-Type: text/plain;
 name="drivers-mfd-ucb1400-ts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers-mfd-ucb1400-ts.patch"

%description
This is a really nasty hack which I used simply to verify that
the touchscreen hardware on the GX533 worked correctly. It came
from a bit-rotted patch found on the L-K mailing list and war forcefully
forward ported to the current tree. It needs some serious cleaning up
before it gets used...

It hangs when you close the input device because semaphores and kthread_stop
cannot play nice together.
%patch
Index: linux-2.6-working/drivers/mfd/Kconfig
===================================================================
--- linux-2.6-working.orig/drivers/mfd/Kconfig	2006-03-01 13:39:20.000000000 +0000
+++ linux-2.6-working/drivers/mfd/Kconfig	2006-03-01 13:39:20.000000000 +0000
@@ -26,4 +26,7 @@
 	tristate "Touchscreen interface support"
 	depends on MCP_UCB1200 && INPUT
 
+config UCB1400_TS
+	tristate "UCB1400 Touchscreen support"
+
 endmenu
Index: linux-2.6-working/drivers/mfd/Makefile
===================================================================
--- linux-2.6-working.orig/drivers/mfd/Makefile	2006-03-01 13:39:20.000000000 +0000
+++ linux-2.6-working/drivers/mfd/Makefile	2006-03-01 13:39:20.000000000 +0000
@@ -11,3 +11,6 @@
 ifeq ($(CONFIG_SA1100_ASSABET),y)
 obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-assabet.o
 endif
+
+ucb1400-core-y 			:= ucb1x00-core.o
+obj-$(CONFIG_UCB1400_TS)	+= ucb1400-core.o ucb1x00-ts.o
Index: linux-2.6-working/drivers/mfd/ucb1x00-core.c
===================================================================
--- linux-2.6-working.orig/drivers/mfd/ucb1x00-core.c	2006-03-01 13:37:51.000000000 +0000
+++ linux-2.6-working/drivers/mfd/ucb1x00-core.c	2006-03-06 11:21:33.000000000 +0000
@@ -27,10 +27,17 @@
 #include <linux/mutex.h>
 
 #include <asm/dma.h>
+#ifdef CONFIG_ARCH_ARM
 #include <asm/hardware.h>
+#endif
 
 #include "ucb1x00.h"
 
+/* NO_IRQ is ARM only? probe_irq_off returns 0 if no IRQ found on i386 */
+#ifndef NO_IRQ
+#define NO_IRQ 0
+#endif
+
 static DEFINE_MUTEX(ucb1x00_mutex);
 static LIST_HEAD(ucb1x00_drivers);
 static LIST_HEAD(ucb1x00_devices);
@@ -58,9 +65,9 @@
 	spin_lock_irqsave(&ucb->io_lock, flags);
 	ucb->io_dir |= out;
 	ucb->io_dir &= ~in;
+	spin_unlock_irqrestore(&ucb->io_lock, flags);
 
 	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
-	spin_unlock_irqrestore(&ucb->io_lock, flags);
 }
 
 /**
@@ -86,9 +93,9 @@
 	spin_lock_irqsave(&ucb->io_lock, flags);
 	ucb->io_out |= set;
 	ucb->io_out &= ~clear;
+	spin_unlock_irqrestore(&ucb->io_lock, flags);
 
 	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
-	spin_unlock_irqrestore(&ucb->io_lock, flags);
 }
 
 /**
@@ -162,6 +169,7 @@
 unsigned int ucb1x00_adc_read(struct ucb1x00 *ucb, int adc_channel, int sync)
 {
 	unsigned int val;
+	unsigned int timeout = 50;
 
 	if (sync)
 		adc_channel |= UCB_ADC_SYNC_ENA;
@@ -169,14 +177,12 @@
 	ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr | adc_channel);
 	ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr | adc_channel | UCB_ADC_START);
 
-	for (;;) {
+	do {
 		val = ucb1x00_reg_read(ucb, UCB_ADC_DATA);
 		if (val & UCB_ADC_DAT_VAL)
 			break;
-		/* yield to other processes */
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+		udelay(1);
+	} while (--timeout);
 
 	return UCB_ADC_DAT(val);
 }
@@ -249,13 +255,13 @@
 		irq = ucb->irq_handler + idx;
 		ret = -EBUSY;
 
-		spin_lock_irq(&ucb->lock);
+		down(&ucb->lock);
 		if (irq->fn == NULL) {
 			irq->devid = devid;
 			irq->fn = fn;
 			ret = 0;
 		}
-		spin_unlock_irq(&ucb->lock);
+		up(&ucb->lock);
 	}
 	return ret;
 }
@@ -272,10 +278,8 @@
  */
 void ucb1x00_enable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges)
 {
-	unsigned long flags;
-
 	if (idx < 16) {
-		spin_lock_irqsave(&ucb->lock, flags);
+		down(&ucb->lock);
 
 		ucb1x00_enable(ucb);
 		if (edges & UCB_RISING) {
@@ -287,7 +291,7 @@
 			ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
 		}
 		ucb1x00_disable(ucb);
-		spin_unlock_irqrestore(&ucb->lock, flags);
+		up(&ucb->lock);
 	}
 }
 
@@ -301,22 +305,23 @@
  */
 void ucb1x00_disable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges)
 {
-	unsigned long flags;
-
 	if (idx < 16) {
-		spin_lock_irqsave(&ucb->lock, flags);
-
-		ucb1x00_enable(ucb);
-		if (edges & UCB_RISING) {
+		down(&ucb->lock);
+		/* This can't be right. Can it? */
+		if (edges & UCB_RISING)
+			ucb->irq_ris_enbl |= 1 << idx;
+		if (edges & UCB_FALLING)
+			ucb->irq_fal_enbl |= 1 << idx;
+		if (edges & UCB_RISING)
 			ucb->irq_ris_enbl &= ~(1 << idx);
-			ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
-		}
-		if (edges & UCB_FALLING) {
+		if (edges & UCB_FALLING)
 			ucb->irq_fal_enbl &= ~(1 << idx);
-			ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
-		}
+		up(&ucb->lock);
+
+		ucb1x00_enable(ucb);
+		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
+		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
 		ucb1x00_disable(ucb);
-		spin_unlock_irqrestore(&ucb->lock, flags);
 	}
 }
 
@@ -344,21 +349,22 @@
 	irq = ucb->irq_handler + idx;
 	ret = -ENOENT;
 
-	spin_lock_irq(&ucb->lock);
+	down(&ucb->lock);
 	if (irq->devid == devid) {
 		ucb->irq_ris_enbl &= ~(1 << idx);
 		ucb->irq_fal_enbl &= ~(1 << idx);
 
-		ucb1x00_enable(ucb);
-		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
-		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
-		ucb1x00_disable(ucb);
-
 		irq->fn = NULL;
 		irq->devid = NULL;
 		ret = 0;
 	}
-	spin_unlock_irq(&ucb->lock);
+	up(&ucb->lock);
+
+	ucb1x00_enable(ucb);
+	ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
+	ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
+	ucb1x00_disable(ucb);
+
 	return ret;
 
 bad:
@@ -478,7 +484,8 @@
 	mcp_enable(mcp);
 	id = mcp_reg_read(mcp, UCB_ID);
 
-	if (id != UCB_ID_1200 && id != UCB_ID_1300) {
+	if (id != UCB_ID_1200 && id != UCB_ID_1300 &&
+		id != UCB_ID_1400 && id != UCB_ID_1400_BUGGY) {
 		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
 		goto err_disable;
 	}
@@ -494,7 +501,7 @@
 	ucb->cdev.dev = &mcp->attached_device;
 	strlcpy(ucb->cdev.class_id, "ucb1x00", sizeof(ucb->cdev.class_id));
 
-	spin_lock_init(&ucb->lock);
+	init_MUTEX(&ucb->lock);
 	spin_lock_init(&ucb->io_lock);
 	sema_init(&ucb->adc_sem, 1);
 
@@ -502,17 +509,15 @@
 	ucb->mcp = mcp;
 	ucb->irq = ucb1x00_detect_irq(ucb);
 	if (ucb->irq == NO_IRQ) {
-		printk(KERN_ERR "UCB1x00: IRQ probe failed\n");
-		ret = -ENODEV;
-		goto err_free;
-	}
-
-	ret = request_irq(ucb->irq, ucb1x00_irq, SA_TRIGGER_RISING,
-			  "UCB1x00", ucb);
-	if (ret) {
-		printk(KERN_ERR "ucb1x00: unable to grab irq%d: %d\n",
-			ucb->irq, ret);
-		goto err_free;
+		printk(KERN_WARNING "UCB1x00: IRQ probe failed -- using polled mode\n");
+	} else {
+		ret = request_irq(ucb->irq, ucb1x00_irq, SA_TRIGGER_RISING,
+				  "UCB1x00", ucb);
+		if (ret) {
+			printk(KERN_ERR "ucb1x00: unable to grab irq%d: %d\n",
+			       ucb->irq, ret);
+			goto err_free;
+		}
 	}
 
 	mcp_set_drvdata(mcp, ucb);
@@ -531,7 +536,8 @@
 	goto out;
 
  err_irq:
-	free_irq(ucb->irq, ucb);
+	if (ucb->irq != NO_IRQ)
+		free_irq(ucb->irq, ucb);
  err_free:
 	kfree(ucb);
  err_disable:
@@ -553,7 +559,8 @@
 	}
 	mutex_unlock(&ucb1x00_mutex);
 
-	free_irq(ucb->irq, ucb);
+	if (ucb->irq != NO_IRQ)
+		free_irq(ucb->irq, ucb);
 	class_device_unregister(&ucb->cdev);
 }
 
Index: linux-2.6-working/drivers/mfd/ucb1x00-ts.c
===================================================================
--- linux-2.6-working.orig/drivers/mfd/ucb1x00-ts.c	2006-03-01 13:37:51.000000000 +0000
+++ linux-2.6-working/drivers/mfd/ucb1x00-ts.c	2006-03-06 11:21:33.000000000 +0000
@@ -35,18 +35,23 @@
 
 #include <asm/dma.h>
 #include <asm/semaphore.h>
+#ifdef CONFIG_ARM
 #include <asm/arch/collie.h>
 #include <asm/mach-types.h>
+#else
+#define machine_is_collie() 0
+#include <asm-arm/arch-sa1100/collie.h>
+#endif
 
 #include "ucb1x00.h"
 
-
 struct ucb1x00_ts {
 	struct input_dev	*idev;
 	struct ucb1x00		*ucb;
 
-	wait_queue_head_t	irq_wait;
+	struct semaphore	irq_wait;
 	struct task_struct	*rtask;
+
 	u16			x_res;
 	u16			y_res;
 
@@ -77,10 +82,12 @@
  */
 static inline void ucb1x00_ts_mode_int(struct ucb1x00_ts *ts)
 {
-	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
-			UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
-			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
-			UCB_TS_CR_MODE_INT);
+	int val = UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
+		  UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
+		  UCB_TS_CR_MODE_INT;
+	if (ts->ucb->id == UCB_ID_1400_BUGGY)
+		val &= ~(UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR, val);
 }
 
 /*
@@ -172,7 +179,7 @@
 	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
 			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
 			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
-	return ucb1x00_adc_read(ts->ucb, 0, ts->adcsync);
+	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSMX, ts->adcsync);
 }
 
 /*
@@ -184,28 +191,27 @@
 	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
 			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
 			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
-	return ucb1x00_adc_read(ts->ucb, 0, ts->adcsync);
+	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSMX, ts->adcsync);
 }
 
 static inline int ucb1x00_ts_pen_down(struct ucb1x00_ts *ts)
 {
 	unsigned int val = ucb1x00_reg_read(ts->ucb, UCB_TS_CR);
 	if (machine_is_collie())
-		return (!(val & (UCB_TS_CR_TSPX_LOW)));
+		return val & (UCB_TS_CR_TSPX_LOW);
 	else
-		return (val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW));
+		return !(val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW));
 }
 
 /*
  * This is a RT kernel thread that handles the ADC accesses
  * (mainly so we can use semaphores in the UCB1200 core code
- * to serialise accesses to the ADC).
+ * to serialise accesses to the ADC).  The UCB1400 access
+ * functions are expected to be able to sleep as well.
  */
 static int ucb1x00_thread(void *_ts)
 {
 	struct ucb1x00_ts *ts = _ts;
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
 	int valid;
 
 	/*
@@ -217,10 +223,9 @@
 
 	valid = 0;
 
-	add_wait_queue(&ts->irq_wait, &wait);
 	while (!kthread_should_stop()) {
 		unsigned int x, y, p;
-		signed long timeout;
+		int is_pen_down;
 
 		ts->restart = 0;
 
@@ -229,24 +234,31 @@
 		x = ucb1x00_ts_read_xpos(ts);
 		y = ucb1x00_ts_read_ypos(ts);
 		p = ucb1x00_ts_read_pressure(ts);
-
 		/*
-		 * Switch back to interrupt mode.
+		 * Switch back to interrupt/pen detect mode.
 		 */
 		ucb1x00_ts_mode_int(ts);
+
 		ucb1x00_adc_disable(ts->ucb);
 
-		msleep(10);
+		msleep(1);
 
 		ucb1x00_enable(ts->ucb);
+		is_pen_down = ucb1x00_ts_pen_down(ts);
+		ucb1x00_disable(ts->ucb);
+		if (is_pen_down) {
+			/*
+			 * Filtering is policy.  Policy belongs in user
+			 * space.  We therefore leave it to user space
+			 * to do any filtering they please.
+			 */
+			if (!ts->restart) {
+				ucb1x00_ts_evt_add(ts, p, x, y);
+				valid = 1;
+			}
 
-
-		if (ucb1x00_ts_pen_down(ts)) {
-			set_task_state(tsk, TASK_INTERRUPTIBLE);
-
-			ucb1x00_enable_irq(ts->ucb, UCB_IRQ_TSPX, machine_is_collie() ? UCB_RISING : UCB_FALLING);
-			ucb1x00_disable(ts->ucb);
-
+			schedule_timeout_interruptible(1);
+		} else {
 			/*
 			 * If we spat out a valid sample set last time,
 			 * spit out a "pen off" sample here.
@@ -256,31 +268,26 @@
 				valid = 0;
 			}
 
-			timeout = MAX_SCHEDULE_TIMEOUT;
-		} else {
-			ucb1x00_disable(ts->ucb);
-
 			/*
-			 * Filtering is policy.  Policy belongs in user
-			 * space.  We therefore leave it to user space
-			 * to do any filtering they please.
+			 * Since ucb1x00_enable_irq() might sleep due
+			 * to the way the UCB1400 regs are accessed, we
+			 * can't use set_task_state() before that call,
+			 * and not changing state before enabling the
+			 * interrupt is racy.  A semaphore solves all
+			 * those issues quite nicely.
 			 */
-			if (!ts->restart) {
-				ucb1x00_ts_evt_add(ts, p, x, y);
-				valid = 1;
+			if (ts->ucb->irq) {
+				ucb1x00_enable_irq(ts->ucb, UCB_IRQ_TSPX,
+						   machine_is_collie() ? UCB_RISING : UCB_FALLING);
+				down_interruptible(&ts->irq_wait);
+			} else {
+				schedule_timeout_interruptible(msecs_to_jiffies(100));
 			}
-
-			set_task_state(tsk, TASK_INTERRUPTIBLE);
-			timeout = HZ / 100;
 		}
 
 		try_to_freeze();
-
-		schedule_timeout(timeout);
 	}
 
-	remove_wait_queue(&ts->irq_wait, &wait);
-
 	ts->rtask = NULL;
 	return 0;
 }
@@ -293,7 +300,7 @@
 {
 	struct ucb1x00_ts *ts = id;
 	ucb1x00_disable_irq(ts->ucb, UCB_IRQ_TSPX, UCB_FALLING);
-	wake_up(&ts->irq_wait);
+	up(&ts->irq_wait);
 }
 
 static int ucb1x00_ts_open(struct input_dev *idev)
@@ -303,7 +310,7 @@
 
 	BUG_ON(ts->rtask);
 
-	init_waitqueue_head(&ts->irq_wait);
+	sema_init(&ts->irq_wait, 0);
 	ret = ucb1x00_hook_irq(ts->ucb, UCB_IRQ_TSPX, ucb1x00_ts_irq, ts);
 	if (ret < 0)
 		goto out;
@@ -337,9 +344,11 @@
 {
 	struct ucb1x00_ts *ts = idev->private;
 
+	printk(KERN_DEBUG "ucb1x00_ts_close: stop thread\n");
 	if (ts->rtask)
 		kthread_stop(ts->rtask);
 
+	printk(KERN_DEBUG "ucb1x00_ts_close: free irq and clear CR\n");
 	ucb1x00_enable(ts->ucb);
 	ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
 	ucb1x00_reg_write(ts->ucb, UCB_TS_CR, 0);
@@ -358,7 +367,7 @@
 		 * after sleep.
 		 */
 		ts->restart = 1;
-		wake_up(&ts->irq_wait);
+		up(&ts->irq_wait);
 	}
 	return 0;
 }
Index: linux-2.6-working/drivers/mfd/ucb1x00.h
===================================================================
--- linux-2.6-working.orig/drivers/mfd/ucb1x00.h	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6-working/drivers/mfd/ucb1x00.h	2006-03-03 16:03:27.000000000 +0000
@@ -10,8 +10,47 @@
 #ifndef UCB1200_H
 #define UCB1200_H
 
+#if 1 // def CONFIG_ARCH_PXA
+
+/* ucb1400 aclink register mappings: */
+
+#define UCB_IO_DATA	0x5a
+#define UCB_IO_DIR	0x5c
+#define UCB_IE_RIS	0x5e
+#define UCB_IE_FAL	0x60
+#define UCB_IE_STATUS	0x62
+#define UCB_IE_CLEAR	0x62
+#define UCB_TS_CR	0x64
+#define UCB_ADC_CR	0x66
+#define UCB_ADC_DATA	0x68
+#define UCB_ID		0x7e /* 7c is mfr id, 7e part id (from aclink spec) */
+
+#define UCB_ADC_DAT(x)		((x) & 0x3ff)
+
+#else
+
+/* ucb1x00 SIB register mappings: */
+
 #define UCB_IO_DATA	0x00
 #define UCB_IO_DIR	0x01
+#define UCB_IE_RIS	0x02
+#define UCB_IE_FAL	0x03
+#define UCB_IE_STATUS	0x04
+#define UCB_IE_CLEAR	0x04
+#define UCB_TC_A	0x05
+#define UCB_TC_B	0x06
+#define UCB_AC_A	0x07
+#define UCB_AC_B	0x08
+#define UCB_TS_CR	0x09
+#define UCB_ADC_CR	0x0a
+#define UCB_ADC_DATA	0x0b
+#define UCB_ID		0x0c
+#define UCB_MODE	0x0d
+
+#define UCB_ADC_DAT(x)		(((x) & 0x7fe0) >> 5)
+
+#endif
+
 
 #define UCB_IO_0		(1 << 0)
 #define UCB_IO_1		(1 << 1)
@@ -24,10 +63,6 @@
 #define UCB_IO_8		(1 << 8)
 #define UCB_IO_9		(1 << 9)
 
-#define UCB_IE_RIS	0x02
-#define UCB_IE_FAL	0x03
-#define UCB_IE_STATUS	0x04
-#define UCB_IE_CLEAR	0x04
 #define UCB_IE_ADC		(1 << 11)
 #define UCB_IE_TSPX		(1 << 12)
 #define UCB_IE_TSMX		(1 << 13)
@@ -36,11 +71,9 @@
 
 #define UCB_IRQ_TSPX		12
 
-#define UCB_TC_A	0x05
 #define UCB_TC_A_LOOP		(1 << 7)	/* UCB1200 */
 #define UCB_TC_A_AMPL		(1 << 7)	/* UCB1300 */
 
-#define UCB_TC_B	0x06
 #define UCB_TC_B_VOICE_ENA	(1 << 3)
 #define UCB_TC_B_CLIP		(1 << 4)
 #define UCB_TC_B_ATT		(1 << 6)
@@ -49,14 +82,11 @@
 #define UCB_TC_B_IN_ENA		(1 << 14)
 #define UCB_TC_B_OUT_ENA	(1 << 15)
 
-#define UCB_AC_A	0x07
-#define UCB_AC_B	0x08
 #define UCB_AC_B_LOOP		(1 << 8)
 #define UCB_AC_B_MUTE		(1 << 13)
 #define UCB_AC_B_IN_ENA		(1 << 14)
 #define UCB_AC_B_OUT_ENA	(1 << 15)
 
-#define UCB_TS_CR	0x09
 #define UCB_TS_CR_TSMX_POW	(1 << 0)
 #define UCB_TS_CR_TSPX_POW	(1 << 1)
 #define UCB_TS_CR_TSMY_POW	(1 << 2)
@@ -72,7 +102,6 @@
 #define UCB_TS_CR_TSPX_LOW	(1 << 12)
 #define UCB_TS_CR_TSMX_LOW	(1 << 13)
 
-#define UCB_ADC_CR	0x0a
 #define UCB_ADC_SYNC_ENA	(1 << 0)
 #define UCB_ADC_VREFBYP_CON	(1 << 1)
 #define UCB_ADC_INP_TSPX	(0 << 2)
@@ -87,15 +116,13 @@
 #define UCB_ADC_START		(1 << 7)
 #define UCB_ADC_ENA		(1 << 15)
 
-#define UCB_ADC_DATA	0x0b
 #define UCB_ADC_DAT_VAL		(1 << 15)
-#define UCB_ADC_DAT(x)		(((x) & 0x7fe0) >> 5)
 
-#define UCB_ID		0x0c
 #define UCB_ID_1200		0x1004
 #define UCB_ID_1300		0x1005
+#define UCB_ID_1400		0x4304
+#define UCB_ID_1400_BUGGY	0x4303	/* fake ID */
 
-#define UCB_MODE	0x0d
 #define UCB_MODE_DYN_VFLAG_ENA	(1 << 12)
 #define UCB_MODE_AUD_OFF_CAN	(1 << 13)
 
@@ -107,11 +134,14 @@
 };
 
 struct ucb1x00 {
-	spinlock_t		lock;
-	struct mcp		*mcp;
+	struct mcp		*mcp;	/* this needs to be first */
+	struct semaphore	lock;
 	unsigned int		irq;
 	struct semaphore	adc_sem;
 	spinlock_t		io_lock;
+	wait_queue_head_t	irq_wait;
+	struct completion	complete;
+	struct task_struct	*irq_task;
 	u16			id;
 	u16			io_dir;
 	u16			io_out;

--------------070306060103040102010603--
