Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTLQOqC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 09:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTLQOqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 09:46:01 -0500
Received: from mailgate.wolfson.co.uk ([194.217.161.2]:28364 "EHLO
	wolfsonmicro.com") by vger.kernel.org with ESMTP id S264419AbTLQOo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 09:44:57 -0500
Subject: [PATCH 2.4] Wolfson AC97 touch screen driver - Input Event
	interface
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-wbI1hSXTL/bAmQfdUB8j"
Message-Id: <1071672291.23686.2634.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 17 Dec 2003 14:44:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wbI1hSXTL/bAmQfdUB8j
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the kernel input event interface to the
Wolfson WM9705/WM9712 touchscreen driver.

Patch is against 2.4.24-pre1

Changes:-

o Added Input event interface (Stanley Cai)
o Improved driver CPU utilisation (Ian Molton)
o Removed ADC source bits from output (me)
o Added coordinate streaming mode on XScale (me) 
o Removed old h3600 TS_EVENT interface (me)

Liam

--=-wbI1hSXTL/bAmQfdUB8j
Content-Disposition: attachment; filename=wm97xx-driver.diff
Content-Type: text/x-patch; name=wm97xx-driver.diff; charset=
Content-Transfer-Encoding: 7bit

diff -urN a/drivers/sound/ac97_plugin_wm97xx.c b/drivers/sound/ac97_plugin_wm97xx.c
--- a/drivers/sound/ac97_plugin_wm97xx.c	2003-11-28 18:26:20.000000000 +0000
+++ b/drivers/sound/ac97_plugin_wm97xx.c	2003-12-17 14:14:36.000000000 +0000
@@ -5,6 +5,7 @@
  * Copyright 2003 Wolfson Microelectronics PLC.
  * Author: Liam Girdwood
  *         liam.girdwood@wolfsonmicro.com or linux@wolfsonmicro.com
+ *         parts (c) Ian Molton <spyro@f2s.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -32,56 +33,82 @@
  *       - supports WM9705, WM9712
  *       - polling mode
  *       - coordinate polling
+ *       - continuous mode
  *       - adjustable rpu/dpp settings
  *       - adjustable pressure current
  *       - adjustable sample settle delay
  *       - 4 and 5 wire touchscreens (5 wire is WM9712 only)
  *       - pen down detection
- *       - battery monitor
- *       - sample AUX adc's
  *       - power management
- *       - direct AC97 IO from userspace (#define WM97XX_TS_DEBUG)
  *
  *  TODO:
- *       - continuous mode
  *       - adjustable sample rate
  *       - AUX adc in coordinate / continous modes
- *	 - Official device identifier or misc device ?
+ *       - Codec GPIO
+ *       - battery monitor
+ *       - sample AUX adc's
  *
  *  Revision history
  *    7th May 2003   Initial version.
  *    6th June 2003  Added non module support and AC97 registration.
  *   18th June 2003  Added AUX adc sampling. 
  *   23rd June 2003  Did some minimal reformatting, fixed a couple of
- *		     locking bugs and noted a race to fix.
+ *     locking bugs and noted a race to fix.
  *   24th June 2003  Added power management and fixed race condition.
+ *   10th July 2003  Changed to a misc device.
+ *   31st July 2003  Moved TS_EVENT and TS_CAL to wm97xx.h
+ *    8th Aug  2003  Added option for read() calling wm97xx_sample_touch()
+ *                   because some ac97_read/ac_97_write call schedule()
+ *    7th Nov  2003  Added Input touch event interface, stanley.cai@intel.com
+ *   13th Nov  2003  Removed h3600 touch interface, added interrupt based
+ *                   pen down notification and implemented continous mode
+ *                   on XScale arch.
+ *    4th Dec  2003  Removed ADC src bits from sample data.
  */
 
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/fs.h>
+#include <linux/input.h>
 #include <linux/delay.h>
-#include <linux/poll.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
-#include <linux/miscdevice.h>
 #include <linux/pm.h>
-#include <linux/wm97xx.h>       /* WM97xx registers and bits */
 #include <asm/uaccess.h>        /* get_user,copy_to_user */
 #include <asm/io.h>
 
-#define TS_NAME "ac97_plugin_wm97xx"
+#include "wm97xx.h"
+
+#define TS_NAME "wm97xx"
 #define TS_MINOR 16
-#define WM_TS_VERSION "0.6"
+#define WM_TS_VERSION "0.10"
 #define AC97_NUM_REG 64
 
+/*
+ * Machine specific set up.
+ * 
+ * This is for targets that can support a PEN down interrupt and/or 
+ * streaming back touch data in an AC97 slot (not slot 1). The 
+ * streaming touch data is read back via the targets AC97 FIFO's 
+ */
+#if defined(CONFIG_ARCH_PXA)
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/irqs.h>
+#define WM97XX_IRQ 	IRQ_AC97
+#define WM97XX_FIFO_HAS_DATA MISR & (1 << 2)
+#define WM97XX_READ_FIFO MODR & (0xffff)
+#endif
+
+#ifndef WM97XX_IRQ
+#define WM97XX_IRQ 0
+#define WM97XX_FIFO_HAS_DATA 0
+#define WM97XX_READ_FIFO 0
+#endif
 
 /*
  * Debug
  */
- 
 #define PFX TS_NAME
 #define WM97XX_TS_DEBUG 0
 
@@ -97,8 +124,7 @@
 /*
  * Module parameters
  */
-	
-	
+
 /*
  * Set the codec sample mode.
  *
@@ -124,8 +150,8 @@
  */
 MODULE_PARM(mode,"i");
 MODULE_PARM_DESC(mode, "Set WM97XX operation mode");
-static int mode = 0;	
-	
+static int mode = 0;
+
 /*
  * WM9712 - Set internal pull up for pen detect. 
  * 
@@ -137,7 +163,7 @@
  */
 MODULE_PARM(rpu,"i");
 MODULE_PARM_DESC(rpu, "Set internal pull up resitor for pen detect.");
-static int rpu = 0;	
+static int rpu = 0;
 
 /*
  * WM9705 - Pen detect comparator threshold. 
@@ -151,8 +177,8 @@
  */
 MODULE_PARM(pdd,"i");
 MODULE_PARM_DESC(pdd, "Set pen detect comparator threshold");
-static int pdd = 0;	
-	
+static int pdd = 0;
+
 /*
  * Set current used for pressure measurement.
  *
@@ -174,7 +200,7 @@
  */
 MODULE_PARM(five_wire,"i");
 MODULE_PARM_DESC(five_wire, "Set 5 wire touchscreen.");
-static int five_wire = 0;	
+static int five_wire = 0;
 
 /*
  * Set adc sample delay.
@@ -190,104 +216,71 @@
  */
 MODULE_PARM(delay,"i");
 MODULE_PARM_DESC(delay, "Set adc sample delay.");
-static int delay = 4;	
-
+static int delay = 4;
 
-/* +++++++++++++ Lifted from include/linux/h3600_ts.h ++++++++++++++*/
-typedef struct {
-	unsigned short pressure;  // touch pressure
-	unsigned short x;         // calibrated X
-	unsigned short y;         // calibrated Y
-	unsigned short millisecs; // timestamp of this event
-} TS_EVENT;
-
-typedef struct {
-	int xscale;
-	int xtrans;
-	int yscale;
-	int ytrans;
-	int xyswap;
-} TS_CAL;
-
-/* Use 'f' as magic number */
-#define IOC_MAGIC  'f'
-
-#define TS_GET_RATE             _IO(IOC_MAGIC, 8)
-#define TS_SET_RATE             _IO(IOC_MAGIC, 9)
-#define TS_GET_CAL              _IOR(IOC_MAGIC, 10, TS_CAL)
-#define TS_SET_CAL              _IOW(IOC_MAGIC, 11, TS_CAL)
-
-/* +++++++++++++ Done lifted from include/linux/h3600_ts.h +++++++++*/
-
-#define TS_GET_COMP1			_IOR(IOC_MAGIC, 12, short)
-#define TS_GET_COMP2			_IOR(IOC_MAGIC, 13, short)
-#define TS_GET_BMON			_IOR(IOC_MAGIC, 14, short)
-#define TS_GET_WIPER			_IOR(IOC_MAGIC, 15, short)
-
-#ifdef WM97XX_TS_DEBUG
-/* debug get/set ac97 codec register ioctl's */
-#define TS_GET_AC97_REG			_IOR(IOC_MAGIC, 20, short)
-#define TS_SET_AC97_REG			_IOW(IOC_MAGIC, 21, short)
-#define TS_SET_AC97_INDEX		_IOW(IOC_MAGIC, 22, short)
-#endif
-
-#define EVENT_BUFSIZE 128
+/*
+ * Pen down detection
+ * 
+ * Pen down detection can either be via an interrupt (preferred) or
+ * by polling the PDEN bit. This is an option because some systems may
+ * not support the pen down interrupt.
+ *
+ * Set pen_int to 1 to enable interrupt driven pen down detection.
+ */
+MODULE_PARM(pen_int,"i");
+MODULE_PARM_DESC(pen_int, "Set pen down interrupt");
+static int pen_int = 0;	
 
 typedef struct {
-	TS_CAL cal;                       /* Calibration values */
-	TS_EVENT event_buf[EVENT_BUFSIZE];/* The event queue */
-	int nextIn, nextOut;
-	int event_count;
 	int is_wm9712:1;                  /* are we a WM912 or a WM9705 */
 	int is_registered:1;              /* Is the driver AC97 registered */
-	int line_pgal:5;
-	int line_pgar:5;
-	int phone_pga:5;
-	int mic_pgal:5;
-	int mic_pgar:5;
-	int overruns;                     /* event buffer overruns */
 	int adc_errs;                     /* sample read back errors */
-#ifdef WM97XX_TS_DEBUG
-	short ac97_index;
-#endif
-	struct fasync_struct *fasync;     /* asynch notification */
-	struct timer_list acq_timer;      /* Timer for triggering acquisitions */
 	wait_queue_head_t wait;           /* read wait queue */
 	spinlock_t lock;
 	struct ac97_codec *codec;
+#if defined(CONFIG_PROC_FS)	
 	struct proc_dir_entry *wm97xx_ts_ps;
-#ifdef WM97XX_TS_DEBUG
-	struct proc_dir_entry *wm97xx_debug_ts_ps;
 #endif
+#if defined(CONFIG_PM)
 	struct pm_dev * pm;
+	int line_pgal:5;
+	int line_pgar:5;
+	int phone_pga:5;
+	int mic_pgal:5;
+	int mic_pgar:5;
+#endif
+	struct input_dev *idev;
+	struct completion init_exit;
+	struct task_struct *rtask;
+	struct semaphore  sem;
+	int use_count;
+	int restart;
 } wm97xx_ts_t;
 
 static inline void poll_delay (void);
 static int __init wm97xx_ts_init_module(void);
-static int wm97xx_poll_read_adc (wm97xx_ts_t* ts, u16 adcsel, u16* sample);
-static int wm97xx_coord_read_adc (wm97xx_ts_t* ts, u16* x, u16* y, 
-                                  u16* pressure);
 static inline int pendown (wm97xx_ts_t *ts);
-static void wm97xx_acq_timer(unsigned long data);
-static int wm97xx_fasync(int fd, struct file *filp, int mode);
-static int wm97xx_ioctl(struct inode * inode, struct file *filp,
-	                    unsigned int cmd, unsigned long arg);
-static unsigned int wm97xx_poll(struct file * filp, poll_table * wait);
-static ssize_t wm97xx_read(struct file * filp, char * buf, size_t count, 
-	                       loff_t * l);
-static int wm97xx_open(struct inode * inode, struct file * filp);
-static int wm97xx_release(struct inode * inode, struct file * filp);
+static void wm97xx_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static int wm97xx_poll_read_adc (wm97xx_ts_t* ts, u16 adcsel, u16* sample);
 static void init_wm97xx_phy(void);
-static int adc_get (wm97xx_ts_t *ts, unsigned short *value, int id);
 static int wm97xx_probe(struct ac97_codec *codec, struct ac97_driver *driver);
 static void wm97xx_remove(struct ac97_codec *codec,  struct ac97_driver *driver);
 static void wm97xx_ts_cleanup_module(void);
+static int wm97xx_ts_evt_add(wm97xx_ts_t* ts, u16 pressure, u16 x, u16 y);
+static int wm97xx_ts_evt_release(wm97xx_ts_t* ts);
+
+#if defined(CONFIG_PM)
 static int wm97xx_pm_event(struct pm_dev *dev, pm_request_t rqst, void *data);
 static void wm97xx_suspend(void);
 static void wm97xx_resume(void);
 static void wm9712_pga_save(wm97xx_ts_t* ts);
 static void wm9712_pga_restore(wm97xx_ts_t* ts);
+#endif
 
+/* we only support a single touchscreen */
+static wm97xx_ts_t wm97xx_ts;
+static struct input_dev wm97xx_input;
+	
 /* AC97 registration info */
 static struct ac97_driver wm9705_driver = {
 	codec_id: 0x574D4C05,
@@ -304,38 +297,40 @@
 	probe:	wm97xx_probe,
 	remove: __devexit_p(wm97xx_remove),
 };
-
-/* we only support a single touchscreen */
-static wm97xx_ts_t wm97xx_ts;
-
+	
 /*
  * ADC sample delay times in uS
  */
 static const int delay_table[16] = {
-	21,		// 1 AC97 Link frames
-	42,		// 2
-	84,		// 4
-	167,		// 8
-	333,		// 16
-	667,		// 32
-	1000,		// 48
-	1333,		// 64
-	2000,		// 96
-	2667,		// 128
-	3333,		// 160
-	4000,		// 192
-	4667,		// 224
-	5333,		// 256
-	6000,		// 288
-	0 		// No delay, switch matrix always on
+	21,// 1 AC97 Link frames
+	42,// 2
+	84,// 4
+	167,// 8
+	333,// 16
+	667,// 32
+	1000,// 48
+	1333,// 64
+	2000,// 96
+	2667,// 128
+	3333,// 160
+	4000,// 192
+	4667,// 224
+	5333,// 256
+	6000,// 288
+	0 // No delay, switch matrix always on
 };
 
+// Todo
+static void wm97xx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	info("int recv");
+}
+
 /*
  * Delay after issuing a POLL command.
  *
  * The delay is 3 AC97 link frames + the touchpanel settling delay
  */
-
 static inline void poll_delay(void)
 { 
 	int pdelay = 3 * AC97_LINK_FRAME + delay_table[delay];
@@ -344,63 +339,6 @@
 
 
 /*
- * sample the auxillary ADC's 
- */
-
-static int adc_get(wm97xx_ts_t* ts, unsigned short * value, int id)
-{
-	short adcsel = 0;
-	
-	/* first find out our adcsel flag */
-	if (ts->is_wm9712) {
-		switch (id) {
-			case TS_COMP1:
-				adcsel = WM9712_ADCSEL_COMP1;
-				break;
-			case TS_COMP2:
-				adcsel = WM9712_ADCSEL_COMP2;
-				break;
-			case TS_BMON:
-				adcsel = WM9712_ADCSEL_BMON;
-				break;
-			case TS_WIPER:
-				adcsel = WM9712_ADCSEL_WIPER;
-				break;
-		}
-	} else {
-		switch (id) {
-			case TS_COMP1:
-				adcsel = WM9705_ADCSEL_PCBEEP;
-				break;
-			case TS_COMP2:
-				adcsel = WM9705_ADCSEL_PHONE;
-				break;
-			case TS_BMON:
-				adcsel = WM9705_ADCSEL_BMON;
-				break;
-			case TS_WIPER:
-				adcsel = WM9705_ADCSEL_AUX;
-				break;
-		}
-	}
-	
-	/* now sample the adc */
-	if (mode == 1) {
-		/* coordinate mode - not currently available (TODO) */
-			return 0;
-	}
-	else
-	{
-		/* polling mode */
-		if (!wm97xx_poll_read_adc(ts, adcsel, value))
-			return 0;	
-	}
-	
-	return 1;
-}
-
-
-/*
  * Read a sample from the adc in polling mode.
  */
 static int wm97xx_poll_read_adc (wm97xx_ts_t* ts, u16 adcsel, u16* sample)
@@ -412,7 +350,7 @@
 	dig1 = ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER1); 
 	dig1&=0x0fff;
 	ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER1, dig1 | adcsel |
-		WM97XX_POLL); 
+			       WM97XX_POLL); 
 
 	/* wait 3 AC97 time slots + delay for conversion */
 	poll_delay();
@@ -420,7 +358,7 @@
 	/* wait for POLL to go low */
 	while ((ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER1) & WM97XX_POLL) && timeout) { 
 		udelay(AC97_LINK_FRAME);
-		timeout--;	
+		timeout--;
 	}
 	if (timeout > 0)
 		*sample = ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER_RD);
@@ -429,7 +367,7 @@
 		err ("adc sample timeout");
 		return 0;
 	}
-	
+  
 	/* check we have correct sample */
 	if ((*sample & 0x7000) != adcsel ) { 
 		err ("adc wrong sample, read %x got %x", adcsel, *sample & 0x7000);
@@ -487,334 +425,91 @@
 }
 
 /*
- * Is the pen down ?
+ * Sample the touchscreen in polling mode
  */
-static inline int pendown (wm97xx_ts_t *ts)
+int wm97xx_poll_touch(wm97xx_ts_t *ts)
 {
-	return ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER_RD) & WM97XX_PEN_DOWN;
-}
-
-/*
- * X,Y coordinates and pressure aquisition function.
- * This function is run by a kernel timer and it's frequency between
- * calls is the touchscreen polling rate;
- */
- 
-static void wm97xx_acq_timer(unsigned long data)
-{
-	wm97xx_ts_t* ts = (wm97xx_ts_t*)data;
-	unsigned long flags;
-	long x,y;
-	TS_EVENT event;
+	u16 x, y, p;
 	
-	spin_lock_irqsave(&ts->lock, flags);
-
-	/* are we still registered ? */
-	if (!ts->is_registered) {
-		spin_unlock_irqrestore(&ts->lock, flags);
-		return; /* we better stop then */
+	if (!wm97xx_poll_read_adc(ts, WM97XX_ADCSEL_X, &x)) {
+		info("x %d\n", x);
+		return -EIO;
 	}
-	
-	/* read coordinates if pen is down */
-	if (!pendown(ts))
-		goto acq_exit;
-	
-	if (mode == 1) {
-		/* coordinate mode */
-		if (!wm97xx_coord_read_adc(ts, (u16*)&x, (u16*)&y, &event.pressure))
-			goto acq_exit;
-	} else
-	{
-		/* polling mode */
-		if (!wm97xx_poll_read_adc(ts, WM97XX_ADCSEL_X, (u16*)&x))
-			goto acq_exit;
-		if (!wm97xx_poll_read_adc(ts, WM97XX_ADCSEL_Y, (u16*)&y))
-			goto acq_exit;
-		
-		/* only read pressure if we have to */
-		if (!five_wire && pil) {
-			if (!wm97xx_poll_read_adc(ts, WM97XX_ADCSEL_PRES, &event.pressure))
-				goto acq_exit;
-		}
-		else
-			event.pressure = 0;
+	if (!wm97xx_poll_read_adc(ts, WM97XX_ADCSEL_Y, &y)) {
+		info("y %d\n", y);
+		return -EIO;
 	}
-	/* timestamp this new event. */
-	event.millisecs = jiffies;
-
-	/* calibrate and remove unwanted bits from samples */
-	event.pressure &= 0x0fff;
-	
-	x &= 0x00000fff;
-	x = ((ts->cal.xscale * x) >> 8) + ts->cal.xtrans;
-	event.x = (u16)x;
-	
-	y &= 0x00000fff;
-	y = ((ts->cal.yscale * y) >> 8) + ts->cal.ytrans;
-	event.y = (u16)y;
-	
-	/* add this event to the event queue */
-	ts->event_buf[ts->nextIn++] = event;
-	if (ts->nextIn == EVENT_BUFSIZE)
-		ts->nextIn = 0;
-	if (ts->event_count < EVENT_BUFSIZE) {
-		ts->event_count++;
-	} else {
-		/* throw out the oldest event */
-		if (++ts->nextOut == EVENT_BUFSIZE) {
-			ts->nextOut = 0;
-			ts->overruns++;
-		}
-	}
-
-	/* async notify */
-	if (ts->fasync)
-		kill_fasync(&ts->fasync, SIGIO, POLL_IN);
-	/* wake up any read call */
-	if (waitqueue_active(&ts->wait))
-		wake_up_interruptible(&ts->wait);
-
-	/* schedule next acquire */
-acq_exit:
-	ts->acq_timer.expires = jiffies + HZ / 100;
-	add_timer(&ts->acq_timer);
-
-	spin_unlock_irqrestore(&ts->lock, flags);
-}
-	
-	
-/* +++++++++++++ File operations ++++++++++++++*/
-
-static int wm97xx_fasync(int fd, struct file *filp, int mode)
-{
-	wm97xx_ts_t* ts = (wm97xx_ts_t*)filp->private_data;
-	return fasync_helper(fd, filp, mode, &ts->fasync);
-}
-
-static int wm97xx_ioctl(struct inode * inode, struct file *filp,
-	     unsigned int cmd, unsigned long arg)
-{
-	unsigned short adc_value;
-#ifdef WM97XX_TS_DEBUG
-	short data;
-#endif	
-	wm97xx_ts_t* ts = (wm97xx_ts_t*)filp->private_data;
-
-	switch(cmd) {
-	case TS_GET_RATE:       /* TODO: what is this? */
-		break;
-	case TS_SET_RATE:       /* TODO: what is this? */
-		break;
-	case TS_GET_CAL:
-		if(copy_to_user((char *)arg, (char *)&ts->cal, sizeof(TS_CAL)))
-			return -EFAULT;
-		break;
-	case TS_SET_CAL:
-		if(copy_from_user((char *)&ts->cal, (char *)arg, sizeof(TS_CAL)))
-			return -EFAULT;
-		break;
-	case TS_GET_COMP1:
-		if (adc_get(ts, &adc_value, TS_COMP1)) {
-			if(copy_to_user((char *)arg, (char *)&adc_value, sizeof(adc_value)))
-				return -EFAULT;
-		}
-		else
-			return -EIO;
-		break;
-	case TS_GET_COMP2:
-		if (adc_get(ts, &adc_value, TS_COMP2)) {
-			if(copy_to_user((char *)arg, (char *)&adc_value, sizeof(adc_value)))
-				return -EFAULT;
-		}
-		else
-			return -EIO;
-		break;
-	case TS_GET_BMON:
-		if (adc_get(ts, &adc_value, TS_BMON)) {
-			if(copy_to_user((char *)arg, (char *)&adc_value, sizeof(adc_value)))
-				return -EFAULT;
-		}
-		else
+	if (pil && !five_wire) { 
+		if (!wm97xx_poll_read_adc(ts, WM97XX_ADCSEL_PRES, &p)) {
+			info("p %d\n", p);
 			return -EIO;
-		break;
-	case TS_GET_WIPER:
-		if (adc_get(ts, &adc_value, TS_WIPER)) {
-			if(copy_to_user((char *)arg, (char *)&adc_value, sizeof(adc_value)))
-				return -EFAULT;
 		}
-		else
-			return -EIO;
-		break;
-#ifdef WM97XX_TS_DEBUG
-		/* debug get/set ac97 codec register ioctl's 
-		 *
-		 * This is direct IO to the codec registers - BE CAREFULL
-		 */
-	case TS_GET_AC97_REG: /* read from ac97 reg (index) */
-		data = ts->codec->codec_read(ts->codec, ts->ac97_index);
-		if(copy_to_user((char *)arg, (char *)&data, sizeof(data)))
-			return -EFAULT;
-		break;
-	case TS_SET_AC97_REG: /* write to ac97 reg (index) */
-		if(copy_from_user((char *)&data, (char *)arg, sizeof(data)))
-			return -EFAULT;
-		ts->codec->codec_write(ts->codec, ts->ac97_index, data);
-		break;
-	case TS_SET_AC97_INDEX: /* set ac97 reg index */
-		if(copy_from_user((char *)&ts->ac97_index, (char *)arg, sizeof(ts->ac97_index)))
-			return -EFAULT;
-		break;
-#endif
-	default:
-		return -EINVAL;
+	} else {
+		p = 0xffff;
 	}
-
-	return 0;
-}
-
-static unsigned int wm97xx_poll(struct file * filp, poll_table * wait)
-{
-	wm97xx_ts_t *ts = (wm97xx_ts_t *)filp->private_data;
-	poll_wait(filp, &ts->wait, wait);
-	if (ts->event_count)
-		return POLLIN | POLLRDNORM;
-	return 0;
+	
+	wm97xx_ts_evt_add(ts, p, x, y);
+	return 1;
 }
 
-static ssize_t wm97xx_read(struct file *filp, char *buf, size_t count, loff_t *l)
+/*
+ * Sample the touchscreen in polling coordinate mode
+ */
+int wm97xx_poll_coord_touch(wm97xx_ts_t *ts)
 {
-	wm97xx_ts_t* ts = (wm97xx_ts_t*)filp->private_data;
-	unsigned long flags;
-	TS_EVENT event;
-	int i;
-
-	/* are we still registered with AC97 layer ? */
-	spin_lock_irqsave(&ts->lock, flags);
-	if (!ts->is_registered) {
-		spin_unlock_irqrestore(&ts->lock, flags);
-		return -ENXIO;
-	}
-	
-	if (ts->event_count == 0) {
-		if (filp->f_flags & O_NONBLOCK)
-			return -EAGAIN;
-		spin_unlock_irqrestore(&ts->lock, flags);
-
-		wait_event_interruptible(ts->wait, ts->event_count != 0);
-		
-		/* are we still registered after sleep ? */
-		spin_lock_irqsave(&ts->lock, flags);
-		if (!ts->is_registered) {
-			spin_unlock_irqrestore(&ts->lock, flags);
-			return -ENXIO;
-		}
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-	}
+	u16 x, y, p;
 	
-	for (i = count; i >= sizeof(TS_EVENT);
-	    i -= sizeof(TS_EVENT), buf += sizeof(TS_EVENT)) {
-		if (ts->event_count == 0)
-			break;
-		spin_lock_irqsave(&ts->lock, flags);
-		event = ts->event_buf[ts->nextOut++];
-		if (ts->nextOut == EVENT_BUFSIZE)
-			ts->nextOut = 0;
-		if (ts->event_count)
-			ts->event_count--;
-		spin_unlock_irqrestore(&ts->lock, flags);
-		if(copy_to_user(buf, &event, sizeof(TS_EVENT)))
-			return i != count  ? count - i : -EFAULT;
-	}
-	return count - i;
+	if (wm97xx_coord_read_adc(ts, &x, &y, &p)) {
+		wm97xx_ts_evt_add(ts, p, x, y);
+		return 1;
+	} else
+		return -EIO;
 }
 
-
-static int wm97xx_open(struct inode * inode, struct file * filp)
+/*
+ * Sample the touchscreen in continous mode
+ */
+int wm97xx_cont_touch(wm97xx_ts_t *ts)
 {
-	wm97xx_ts_t* ts;
-	unsigned long flags;
-	u16 val;
-	int minor = MINOR(inode->i_rdev);
+	u16 x, y;
+	int count = 0;
 	
-	if (minor != TS_MINOR)
-		return -ENODEV;
-	
-	filp->private_data = ts = &wm97xx_ts;
-
-	spin_lock_irqsave(&ts->lock, flags);
-	
-	/* are we registered with AC97 layer ? */
-	if (!ts->is_registered) {
-		spin_unlock_irqrestore(&ts->lock, flags);
-		return -ENXIO;
+	/* currently assuming x is followed by y from the FIFO */
+	while (WM97XX_FIFO_HAS_DATA) {
+		x = WM97XX_READ_FIFO;
+		y = WM97XX_READ_FIFO;
+		wm97xx_ts_evt_add(ts, 0, x, y);
+		count++;
 	}
-	
-	/* start digitiser */
-	val = ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER2);
-	ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER2, 
-		val | WM97XX_PRP_DET_DIG);
-	
-	/* flush event queue */
-	ts->nextIn = ts->nextOut = ts->event_count = 0;
-	
-	/* Set up timer. */
-	init_timer(&ts->acq_timer);
-	ts->acq_timer.function = wm97xx_acq_timer;
-	ts->acq_timer.data = (unsigned long)ts;
-	ts->acq_timer.expires = jiffies + HZ / 100;
-	add_timer(&ts->acq_timer);
-
-	spin_unlock_irqrestore(&ts->lock, flags);
-	return 0;
+	return count;
 }
 
-static int wm97xx_release(struct inode * inode, struct file * filp)
+/*
+ * Is the pen down ?
+ */
+static inline int pendown (wm97xx_ts_t *ts)
 {
-	wm97xx_ts_t* ts = (wm97xx_ts_t*)filp->private_data;
-	unsigned long flags;
-	u16 val;
-	
-	wm97xx_fasync(-1, filp, 0);
-	del_timer_sync(&ts->acq_timer);
-
-	spin_lock_irqsave(&ts->lock, flags);
-	
-	/* stop digitiser */
-	val = ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER2);
-	ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER2, 
-		val & ~WM97XX_PRP_DET_DIG);
-	
-	spin_unlock_irqrestore(&ts->lock, flags);
-	return 0;
+	if (pen_int) {
+		
+	} else {
+		return ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER_RD) 
+		           & WM97XX_PEN_DOWN;
+	}
 }
 
-static struct file_operations ts_fops = {
-	owner:		THIS_MODULE,
-	read:           wm97xx_read,
-	poll:           wm97xx_poll,
-	ioctl:		wm97xx_ioctl,
-	fasync:         wm97xx_fasync,
-	open:		wm97xx_open,
-	release:	wm97xx_release,
-};
-
-/* +++++++++++++ End File operations ++++++++++++++*/
-
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS)
 static int wm97xx_read_proc (char *page, char **start, off_t off,
-		    int count, int *eof, void *data)
+			     int count, int *eof, void *data)
 {
 	int len = 0, prpu;
 	u16 dig1, dig2, digrd, adcsel, adcsrc, slt, prp, rev;
 	unsigned long flags;
 	char srev = ' ';
-	
 	wm97xx_ts_t* ts;
 
 	if ((ts = data) == NULL)
 		return -ENODEV;
-	
+      
 	spin_lock_irqsave(&ts->lock, flags);
 	if (!ts->is_registered) {
 		spin_unlock_irqrestore(&ts->lock, flags);
@@ -828,38 +523,35 @@
 	rev = (ts->codec->codec_read(ts->codec, AC97_WM9712_REV) & 0x000c) >> 2;
 
 	spin_unlock_irqrestore(&ts->lock, flags);
-	
+      
 	adcsel = dig1 & 0x7000;
 	adcsrc = digrd & 0x7000;
 	slt = (dig1 & 0x7) + 5;
 	prp = dig2 & 0xc000;
 	prpu = dig2 & 0x003f;
 
-	/* driver version */
 	len += sprintf (page+len, "Wolfson WM97xx Version %s\n", WM_TS_VERSION);
-	
-	/* what we are using */
+      
 	len += sprintf (page+len, "Using %s", ts->is_wm9712 ? "WM9712" : "WM9705");
 	if (ts->is_wm9712) {
 		switch (rev) {
-			case 0x0:
-				srev = 'A';
+		case 0x0:
+			srev = 'A';
 			break;
-			case 0x1:
-				srev = 'B';
+		case 0x1:
+			srev = 'B';
 			break;
-			case 0x2:
-				srev = 'D';
+		case 0x2:
+			srev = 'D';
 			break;
-			case 0x3:
-				srev = 'E';
+		case 0x3:
+			srev = 'E';
 			break;
 		}
 		len += sprintf (page+len, " silicon rev %c\n",srev);
 	} else
 		len += sprintf (page+len, "\n");
-		
-	/* WM97xx settings */
+      
 	len += sprintf (page+len, "Settings     :\n%s%s%s%s",
 			dig1 & WM97XX_POLL ? " -sampling adc data(poll)\n" : "",
 			adcsel ==  WM97XX_ADCSEL_X ? " -adc set to X coordinate\n" : "",
@@ -867,18 +559,18 @@
 			adcsel ==  WM97XX_ADCSEL_PRES ? " -adc set to pressure\n" : "");
 	if (ts->is_wm9712) {
 		len += sprintf (page+len, "%s%s%s%s", 
-			adcsel ==  WM9712_ADCSEL_COMP1 ? " -adc set to COMP1/AUX1\n" : "",
-			adcsel ==  WM9712_ADCSEL_COMP2 ? " -adc set to COMP2/AUX2\n" : "",
-			adcsel ==  WM9712_ADCSEL_BMON ? " -adc set to BMON\n" : "",
-			adcsel ==  WM9712_ADCSEL_WIPER ? " -adc set to WIPER\n" : "");
-		} else {
+				adcsel ==  WM9712_ADCSEL_COMP1 ? " -adc set to COMP1/AUX1\n" : "",
+				adcsel ==  WM9712_ADCSEL_COMP2 ? " -adc set to COMP2/AUX2\n" : "",
+				adcsel ==  WM9712_ADCSEL_BMON ? " -adc set to BMON\n" : "",
+				adcsel ==  WM9712_ADCSEL_WIPER ? " -adc set to WIPER\n" : "");
+	} else {
 		len += sprintf (page+len, "%s%s%s%s",
-			adcsel ==  WM9705_ADCSEL_PCBEEP ? " -adc set to PCBEEP\n" : "",
-			adcsel ==  WM9705_ADCSEL_PHONE ? " -adc set to PHONE\n" : "",
-			adcsel ==  WM9705_ADCSEL_BMON ? " -adc set to BMON\n" : "",
-			adcsel ==  WM9705_ADCSEL_AUX ? " -adc set to AUX\n" : "");
-		}
-		
+				adcsel ==  WM9705_ADCSEL_PCBEEP ? " -adc set to PCBEEP\n" : "",
+				adcsel ==  WM9705_ADCSEL_PHONE ? " -adc set to PHONE\n" : "",
+				adcsel ==  WM9705_ADCSEL_BMON ? " -adc set to BMON\n" : "",
+				adcsel ==  WM9705_ADCSEL_AUX ? " -adc set to AUX\n" : "");
+	}
+      
 	len += sprintf (page+len, "%s%s%s%s%s%s",
 			dig1 & WM97XX_COO ? " -coordinate sampling\n" : " -individual sampling\n",
 			dig1 & WM97XX_CTC ? " -continuous mode\n" : " -polling mode\n",
@@ -886,11 +578,11 @@
 			prp == WM97XX_PRP_DETW ? " -pen detect enabled, wake up\n" : "",
 			prp == WM97XX_PRP_DET_DIG ? " -pen digitiser and pen detect enabled\n" : "",
 			dig1 & WM97XX_SLEN ? " -read back using slot " : " -read back using AC97\n");
-	
-	if ((dig1 & WM97XX_SLEN) && slt !=12)	
+      
+	if ((dig1 & WM97XX_SLEN) && slt !=12)
 		len += sprintf(page+len, "%d\n", slt);
 	len += sprintf (page+len, " -adc sample delay %d uSecs\n", delay_table[(dig1 & 0x00f0) >> 4]);
-	
+      
 	if (ts->is_wm9712) {
 		if (prpu)
 			len += sprintf (page+len, " -rpu %d Ohms\n", 64000/ prpu);
@@ -900,75 +592,38 @@
 		len += sprintf (page+len, " -pressure current %s uA\n", dig2 & WM9705_PIL ? "400" : "200");
 		len += sprintf (page+len, " -%s impedance for PHONE and PCBEEP\n", dig2 & WM9705_PHIZ ? "high" : "low");
 	}
-	
-	/* WM97xx digitiser read */
+      
 	len += sprintf(page+len, "\nADC data:\n%s%d\n%s%s\n",
-		" -adc value (decimal) : ", digrd & 0x0fff,
-		" -pen ", digrd & 0x8000 ? "Down" : "Up");
+		       " -adc value (decimal) : ", digrd & 0x0fff,
+		       " -pen ", digrd & 0x8000 ? "Down" : "Up");
 	if (ts->is_wm9712) {
 		len += sprintf (page+len, "%s%s%s%s", 
-			adcsrc ==  WM9712_ADCSEL_COMP1 ? " -adc value is COMP1/AUX1\n" : "",
-			adcsrc ==  WM9712_ADCSEL_COMP2 ? " -adc value is COMP2/AUX2\n" : "",
-			adcsrc ==  WM9712_ADCSEL_BMON ? " -adc value is BMON\n" : "",
-			adcsrc ==  WM9712_ADCSEL_WIPER ? " -adc value is WIPER\n" : "");
-		} else {
+				adcsrc ==  WM9712_ADCSEL_COMP1 ? " -adc value is COMP1/AUX1\n" : "",
+				adcsrc ==  WM9712_ADCSEL_COMP2 ? " -adc value is COMP2/AUX2\n" : "",
+				adcsrc ==  WM9712_ADCSEL_BMON ? " -adc value is BMON\n" : "",
+				adcsrc ==  WM9712_ADCSEL_WIPER ? " -adc value is WIPER\n" : "");
+	} else {
 		len += sprintf (page+len, "%s%s%s%s",
-			adcsrc ==  WM9705_ADCSEL_PCBEEP ? " -adc value is PCBEEP\n" : "",
-			adcsrc ==  WM9705_ADCSEL_PHONE ? " -adc value is PHONE\n" : "",
-			adcsrc ==  WM9705_ADCSEL_BMON ? " -adc value is BMON\n" : "",
-			adcsrc ==  WM9705_ADCSEL_AUX ? " -adc value is AUX\n" : "");
-		}
-		
-	/* register dump */
+				adcsrc ==  WM9705_ADCSEL_PCBEEP ? " -adc value is PCBEEP\n" : "",
+				adcsrc ==  WM9705_ADCSEL_PHONE ? " -adc value is PHONE\n" : "",
+				adcsrc ==  WM9705_ADCSEL_BMON ? " -adc value is BMON\n" : "",
+				adcsrc ==  WM9705_ADCSEL_AUX ? " -adc value is AUX\n" : "");
+	}
+      
 	len += sprintf(page+len, "\nRegisters:\n%s%x\n%s%x\n%s%x\n",
-		" -digitiser 1    (0x76) : 0x", dig1,
-		" -digitiser 2    (0x78) : 0x", dig2,
-		" -digitiser read (0x7a) : 0x", digrd);
-		
-	/* errors */
-	len += sprintf(page+len, "\nErrors:\n%s%d\n%s%d\n",
-		" -buffer overruns ", ts->overruns,
-		" -coordinate errors ", ts->adc_errs);
-		
-	return len;
-}
+		       " -digitiser 1    (0x76) : 0x", dig1,
+		       " -digitiser 2    (0x78) : 0x", dig2,
+		       " -digitiser read (0x7a) : 0x", digrd);
+      
+	len += sprintf(page+len, "\nErrors:\n%s%d\n",
+		       " -coordinate errors ", ts->adc_errs);
 
-#ifdef WM97XX_TS_DEBUG
-/* dump all the AC97 register space */
-static int wm_debug_read_proc (char *page, char **start, off_t off,
-		    int count, int *eof, void *data)
-{
-	int len = 0, i;
-	unsigned long flags;
-	wm97xx_ts_t* ts;
-	u16 reg[AC97_NUM_REG];
-
-	if ((ts = data) == NULL)
-		return -ENODEV;
-
-	spin_lock_irqsave(&ts->lock, flags);
-	if (!ts->is_registered) {
-		spin_unlock_irqrestore(&ts->lock, flags);
-		len += sprintf (page+len, "Not registered\n");
-		return len;
-	}
-	
-	for (i=0; i < AC97_NUM_REG; i++) {
-		reg[i] = ts->codec->codec_read(ts->codec, i * 2);
-	}
-	spin_unlock_irqrestore(&ts->lock, flags);
-	
-	for (i=0; i < AC97_NUM_REG; i++) {
-		len += sprintf (page+len, "0x%2.2x : 0x%4.4x\n",i * 2, reg[i]);
-	}
-		
 	return len;
 }
-#endif
 
 #endif
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM)
 /* WM97xx Power Management
  * The WM9712 has extra powerdown states that are controlled in 
  * seperate registers from the AC97 power management.
@@ -996,40 +651,39 @@
 	wm97xx_ts_t* ts = &wm97xx_ts;
 	u16 reg;
 	unsigned long flags;
-	
-	/* are we registered */
+      
 	spin_lock_irqsave(&ts->lock, flags);
 	if (!ts->is_registered) {
 		spin_unlock_irqrestore(&ts->lock, flags);
 		return;
 	}
-	
+      
 	/* wm9705 does not have extra PM */
 	if (!ts->is_wm9712) {
 		spin_unlock_irqrestore(&ts->lock, flags);
 		return;
 	}
-	
+      
 	/* save and mute the PGA's */
 	wm9712_pga_save(ts);
-	
+      
 	reg = ts->codec->codec_read(ts->codec, AC97_PHONE_VOL);
 	ts->codec->codec_write(ts->codec, AC97_PHONE_VOL, reg | 0x001f);
-	
+      
 	reg = ts->codec->codec_read(ts->codec, AC97_MIC_VOL);
 	ts->codec->codec_write(ts->codec, AC97_MIC_VOL, reg | 0x1f1f);
-	
+      
 	reg = ts->codec->codec_read(ts->codec, AC97_LINEIN_VOL);
 	ts->codec->codec_write(ts->codec, AC97_LINEIN_VOL, reg | 0x1f1f);
-	
+      
 	/* power down, dont disable the AC link */
-	ts->codec->codec_write(ts->codec, AC97_WM9712_POWER, WM9712_PD(14) | WM9712_PD(13) |
-							WM9712_PD(12) | WM9712_PD(11) | WM9712_PD(10) |                    
-							WM9712_PD(9) | WM9712_PD(8) | WM9712_PD(7) |
-							WM9712_PD(6) | WM9712_PD(5) | WM9712_PD(4) |
-							WM9712_PD(3) | WM9712_PD(2) | WM9712_PD(1) |
-							WM9712_PD(0));
-	
+	ts->codec->codec_write(ts->codec, AC97_WM9712_POWER, WM9712_PD(14) | 
+			       WM9712_PD(13) | WM9712_PD(12) | WM9712_PD(11) | 
+			       WM9712_PD(10) | WM9712_PD(9) | WM9712_PD(8) | 
+			       WM9712_PD(7) | WM9712_PD(6) | WM9712_PD(5) | 
+			       WM9712_PD(4) | WM9712_PD(3) | WM9712_PD(2) | 
+			       WM9712_PD(1) | WM9712_PD(0));
+      
 	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
@@ -1040,14 +694,14 @@
 {
 	wm97xx_ts_t* ts = &wm97xx_ts;
 	unsigned long flags;
-	
+      
 	/* are we registered */
 	spin_lock_irqsave(&ts->lock, flags);
 	if (!ts->is_registered) {
 		spin_unlock_irqrestore(&ts->lock, flags);
 		return;
 	}
-	
+      
 	/* wm9705 does not have extra PM */
 	if (!ts->is_wm9712) {
 		spin_unlock_irqrestore(&ts->lock, flags);
@@ -1056,14 +710,13 @@
 
 	/* power up */
 	ts->codec->codec_write(ts->codec, AC97_WM9712_POWER, 0x0);
-	
+      
 	/* restore PGA state */
 	wm9712_pga_restore(ts);
-	
+      
 	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
-
 /* save state of wm9712 PGA's */
 static void wm9712_pga_save(wm97xx_ts_t* ts)
 {
@@ -1078,10 +731,10 @@
 static void wm9712_pga_restore(wm97xx_ts_t* ts)
 {
 	u16 reg;
-	
+      
 	reg = ts->codec->codec_read(ts->codec, AC97_PHONE_VOL);
 	ts->codec->codec_write(ts->codec, AC97_PHONE_VOL, reg | ts->phone_pga);
-	
+      
 	reg = ts->codec->codec_read(ts->codec, AC97_LINEIN_VOL);
 	ts->codec->codec_write(ts->codec, AC97_LINEIN_VOL, reg | ts->line_pgar | (ts->line_pgal << 8));
 
@@ -1094,19 +747,18 @@
 /*
  * set up the physical settings of the device 
  */
-
 static void init_wm97xx_phy(void)
 {
 	u16 dig1, dig2, aux, vid;
 	wm97xx_ts_t *ts = &wm97xx_ts;
 
 	/* default values */
-	dig1 = WM97XX_DELAY(4) | WM97XX_SLT(6);
+	dig1 = WM97XX_DELAY(4) | WM97XX_SLT(5);
 	if (ts->is_wm9712)
 		dig2 = WM9712_RPU(1);
 	else {
 		dig2 = 0x0;
-		
+	
 		/* 
 		 * mute VIDEO and AUX as they share X and Y touchscreen 
 		 * inputs on the WM9705 
@@ -1116,21 +768,21 @@
 			info("muting AUX mixer as it shares X touchscreen coordinate");
 			ts->codec->codec_write(ts->codec, AC97_AUX_VOL, 0x8000 | aux);
 		}
-		
+	
 		vid = ts->codec->codec_read(ts->codec, AC97_VIDEO_VOL);
 		if (!(vid & 0x8000)) {
 			info("muting VIDEO mixer as it shares Y touchscreen coordinate");
 			ts->codec->codec_write(ts->codec, AC97_VIDEO_VOL, 0x8000 | vid);
 		}
 	}
-	
+      
 	/* WM9712 rpu */
 	if (ts->is_wm9712 && rpu) {
 		dig2 &= 0xffc0;
 		dig2 |= WM9712_RPU(rpu);
 		info("setting pen detect pull-up to %d Ohms",64000 / rpu);
 	}
-	
+      
 	/* touchpanel pressure */
 	if  (pil == 2) {
 		if (ts->is_wm9712)
@@ -1140,13 +792,13 @@
 		info("setting pressure measurement current to 400uA.");
 	} else if (pil) 
 		info ("setting pressure measurement current to 200uA.");
-	
+      
 	/* WM9712 five wire */
 	if (ts->is_wm9712 && five_wire) {
 		dig2 |= WM9712_45W;
 		info("setting 5-wire touchscreen mode.");
-	}		
-	
+	}
+      
 	/* sample settling delay */
 	if (delay!=4) {
 		if (delay < 0 || delay > 15) {
@@ -1157,19 +809,29 @@
 		dig1 |= WM97XX_DELAY(delay);
 		info("setting adc sample delay to %d u Secs.", delay_table[delay]);
 	}
-	
+      
 	/* coordinate mode */
 	if (mode == 1) {
 		dig1 |= WM97XX_COO;
 		info("using coordinate mode");
-	}		
+	}
 	
+	/* continous mode */
+	if (mode == 2) {
+		dig1 |= WM97XX_CTC | WM97XX_COO | WM97XX_CM_RATE_375 | WM97XX_SLEN | WM97XX_SLT(5);
+		info("using continous mode");
+		if (ts->is_wm9712)
+			dig2 |= WM9712_PDEN;
+		else
+			dig2 |= WM9705_PDEN;
+	}
+      
 	/* WM9705 pdd */
 	if (pdd && !ts->is_wm9712) {
 		dig2 |= (pdd & 0x000f);
 		info("setting pdd to Vmid/%d", 1 - (pdd & 0x000f));
 	}
-	
+      
 	ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER1, dig1);
 	ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER2, dig2); 
 }
@@ -1182,27 +844,27 @@
 
 static int wm97xx_probe(struct ac97_codec *codec, struct ac97_driver *driver)
 {
-	 unsigned long flags;
+	unsigned long flags;
 	u16 id1, id2;
 	wm97xx_ts_t *ts = &wm97xx_ts;
-		
+  
 	spin_lock_irqsave(&ts->lock, flags);
-	
+      
 	/* we only support 1 touchscreen at the moment */
 	if (ts->is_registered) {
 		spin_unlock_irqrestore(&ts->lock, flags);
 		return -1;
 	}
-	
+      
 	/* 
 	 * We can only use a WM9705 or WM9712 that has been *first* initialised
 	 * by the AC97 audio driver. This is because we have to use the audio 
-	 * drivers codec read() and write() functions to sample the touchscreen	
-	 *	
+	 * drivers codec read() and write() functions to sample the touchscreen
+	 *
 	 * If an initialsed WM97xx is found then get the codec read and write 
-	 * functions.		 
+	 * functions. 
 	 */
-	
+      
 	/* test for a WM9712 or a WM9705 */
 	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
 	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
@@ -1210,131 +872,276 @@
 		ts->is_wm9712 = 1;
 		info("registered a WM9712");
 	} else if (id1 == WM97XX_ID1 && id2 == WM9705_ID2) {
-		    ts->is_wm9712 = 0;
-		    info("registered a WM9705");
+		ts->is_wm9712 = 0;
+		info("registered a WM9705");
 	} else {
 		err("could not find a WM97xx codec. Found a 0x%4x:0x%4x instead",
 		    id1, id2);
 		spin_unlock_irqrestore(&ts->lock, flags);
 		return -1;
 	}
-	
+      
 	/* set up AC97 codec interface */
 	ts->codec = codec;
 	codec->driver_private = (void*)&ts;
-	codec->codec_unregister = 0;
-	
+      
 	/* set up physical characteristics */
 	init_wm97xx_phy();
-		
+      
 	ts->is_registered = 1;
 	spin_unlock_irqrestore(&ts->lock, flags);
 	return 0;
 }
 
-/* this is called by the audio driver when ac97_codec is unloaded */
-
+/*
+ * Called by ac97_codec when it is unloaded. 
+ */
 static void wm97xx_remove(struct ac97_codec *codec, struct ac97_driver *driver)
 {
 	unsigned long flags;
 	u16 dig1, dig2;
 	wm97xx_ts_t *ts = codec->driver_private;
 	
+    dbg("Unloading codec\n"); 
 	spin_lock_irqsave(&ts->lock, flags);
-			
+      
 	/* check that are registered */
 	if (!ts->is_registered) {
 		err("double unregister");
 		spin_unlock_irqrestore(&ts->lock, flags);
 		return;
 	}
-	
+      
 	ts->is_registered = 0;
 	wake_up_interruptible(&ts->wait); /* So we see its gone */
-	
+      
 	/* restore default digitiser values */
 	dig1 = WM97XX_DELAY(4) | WM97XX_SLT(6);
 	if (ts->is_wm9712)
 		dig2 = WM9712_RPU(1);
 	else 
 		dig2 = 0x0;
-		
+      
 	codec->codec_write(codec, AC97_WM97XX_DIGITISER1, dig1);
 	codec->codec_write(codec, AC97_WM97XX_DIGITISER2, dig2); 
 	ts->codec = NULL;
-		
+      
 	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
-static struct miscdevice wm97xx_misc = { 
-	minor:	TS_MINOR,
-	name:	"touchscreen/wm97xx",
-	fops:	&ts_fops,
-};
+/*
+ * add a touch event
+ */
+static int wm97xx_ts_evt_add(wm97xx_ts_t* ts, u16 pressure, u16 x, u16 y)
+{
+	/* add event and remove adc src bits */
+	input_report_abs(ts->idev, ABS_X, x & 0xfff);
+	input_report_abs(ts->idev, ABS_Y, y & 0xfff);
+	input_report_abs(ts->idev, ABS_PRESSURE, pressure & 0xfff);
+	return 0;
+}
+
+/*
+ * add a pen up event
+ */
+static int wm97xx_ts_evt_release(wm97xx_ts_t* ts)
+{
+//	dbg("release the stylus.\n");
+	input_report_abs(ts->idev, ABS_PRESSURE, 0);
+	return 0;
+}
+
+/*
+ * The touchscreen sample reader thread
+ */
+static int wm97xx_thread(void *_ts)
+{
+	wm97xx_ts_t *ts = (wm97xx_ts_t *)_ts;
+	struct task_struct *tsk = current;
+	int valid;
+
+	ts->rtask = tsk;
+
+	/* set up thread context */
+	daemonize();
+	reparent_to_init();
+	strcpy(tsk->comm, "ktsd");
+	tsk->tty = NULL;
+
+	/* we will die when we receive SIGKILL */
+	spin_lock_irq(&tsk->sigmask_lock);
+	siginitsetinv(&tsk->blocked, sigmask(SIGKILL));
+	recalc_sigpending(tsk);
+	spin_unlock_irq(&tsk->sigmask_lock);
+
+	/* init is complete */
+	complete(&ts->init_exit);
+	valid = 0;
+
+	/* touch reader loop */
+	for (;;) {
+		ts->restart = 0;
+		if( signal_pending(tsk))
+			break;
+
+		if(pendown(ts)) {
+			switch (mode) {
+				case 0:
+					wm97xx_poll_touch(ts);
+					valid = 1;
+					break;
+				case 1:
+					wm97xx_poll_coord_touch(ts);
+					valid = 1;
+					break;
+				case 2:
+					wm97xx_cont_touch(ts);
+					valid = 1;
+					break;
+			}
+		} else {
+			if (valid) {
+				valid = 0;
+				wm97xx_ts_evt_release(ts);
+			}
+		}
+
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ/100);
+	}
+	ts->rtask = NULL;
+	complete_and_exit(&ts->init_exit, 0);
+
+	return 0;
+}
+
+/*
+ * Start the touchscreen thread and 
+ * the touch digitiser.
+ */
+static int wm97xx_ts_input_open(struct input_dev *idev)
+{
+	wm97xx_ts_t *ts = (wm97xx_ts_t *) &wm97xx_ts;
+	u32 flags;
+	int ret, val;
+
+	if ( ts->use_count++ != 0 ) 
+		return 0;
+
+	/* start touchscreen thread */
+	ts->idev = idev;
+    init_completion(&ts->init_exit);
+    ret = kernel_thread(wm97xx_thread, ts, 0);
+    if (ret >= 0)
+		wait_for_completion(&ts->init_exit); 
+
+	spin_lock_irqsave( &ts->lock, flags );
+
+    /* start digitiser */
+    val = ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER2);
+    ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER2,
+                               val | WM97XX_PRP_DET_DIG);
+
+	spin_unlock_irqrestore( &ts->lock, flags );
+
+	return 0;
+}
+
+/*
+ * Kill the touchscreen thread and stop
+ * the touch digitiser.
+ */
+static void wm97xx_ts_input_close(struct input_dev *idev)
+{
+	wm97xx_ts_t *ts = (wm97xx_ts_t *) &wm97xx_ts;
+	u32 flags;
+	int val;
+
+	if (--ts->use_count == 0) {
+		/* kill thread */
+		if (ts->rtask) {
+			send_sig(SIGKILL, ts->rtask, 1);
+			wait_for_completion(&ts->init_exit);
+		}
+
+		down(&ts->sem);
+		spin_lock_irqsave(&ts->lock, flags);
+
+		/* stop digitiser */
+		val = ts->codec->codec_read(ts->codec, AC97_WM97XX_DIGITISER2);
+		ts->codec->codec_write(ts->codec, AC97_WM97XX_DIGITISER2,
+				       val & ~WM97XX_PRP_DET_DIG);
+		
+		spin_unlock_irqrestore(&ts->lock, flags);
+		up(&ts->sem);
+	}
+}
 
 static int __init wm97xx_ts_init_module(void)
 {
 	wm97xx_ts_t* ts = &wm97xx_ts;
 	int ret;
 	char proc_str[64];
-	
+      
 	info("Wolfson WM9705/WM9712 Touchscreen Controller");
 	info("Version %s  liam.girdwood@wolfsonmicro.com", WM_TS_VERSION);
-	
+      
 	memset(ts, 0, sizeof(wm97xx_ts_t));
-	
-	/* register our misc device */
-	if ((ret = misc_register(&wm97xx_misc)) < 0) {
-		err("can't register misc device");
-		return ret;
-	}
-	
+
+	/* tell input system what we events we accept and register */
+	wm97xx_input.name = "wm97xx touchscreen";
+	wm97xx_input.open = wm97xx_ts_input_open;
+	wm97xx_input.close = wm97xx_ts_input_close;
+	__set_bit(EV_ABS, wm97xx_input.evbit);
+	__set_bit(ABS_X, wm97xx_input.absbit);
+	__set_bit(ABS_Y, wm97xx_input.absbit);
+	__set_bit(ABS_PRESSURE, wm97xx_input.absbit);
+	input_register_device(&wm97xx_input);
+   
 	init_waitqueue_head(&ts->wait);
 	spin_lock_init(&ts->lock);
+	init_MUTEX(&ts->sem);
+     
 	
-	// initial calibration values
-	ts->cal.xscale = 256;
-	ts->cal.xtrans = 0;
-	ts->cal.yscale = 256;
-	ts->cal.ytrans = 0;
-	
-	/* reset error counters */
-	ts->overruns = 0;
-	ts->adc_errs = 0;
+	/* register pendown interrupt handler */
+	if (pen_int) {
+#if defined(WM97XX_IRQ)
+		if ((ret = request_irq(WM97XX_IRQ, wm97xx_interrupt, 0, "AC97-touchscreen", &ts)) != 0) {
+			err("can't get irq %d falling back to pendown polling\n", WM97XX_IRQ);
+			pen_int = 0;
+		}
+#else
+		err("touchscreen interrupt not supported/implemented on this arch\n");
+		pen_int = 0;		
+#endif
+	}
 	
 	/* register with the AC97 layer */
 	ac97_register_driver(&wm9705_driver);
 	ac97_register_driver(&wm9712_driver);
-	
-#ifdef CONFIG_PROC_FS
-	/* register proc interface */
+      
+#if defined(CONFIG_PROC_FS)
 	sprintf(proc_str, "driver/%s", TS_NAME);
 	if ((ts->wm97xx_ts_ps = create_proc_read_entry (proc_str, 0, NULL,
-					     wm97xx_read_proc, ts)) == 0)
+							wm97xx_read_proc, ts)) == 0)
 		err("could not register proc interface /proc/%s", proc_str);
-#ifdef WM97XX_TS_DEBUG
-	if ((ts->wm97xx_debug_ts_ps = create_proc_read_entry ("driver/ac97_registers",
-		0, NULL,wm_debug_read_proc, ts)) == 0)
-		err("could not register proc interface /proc/driver/ac97_registers");
-#endif
 #endif
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM)
 	if ((ts->pm = pm_register(PM_UNKNOWN_DEV, PM_SYS_UNKNOWN, wm97xx_pm_event)) == 0)
 		err("could not register with power management");
 #endif
+	
 	return 0;
 }
 
 static void wm97xx_ts_cleanup_module(void)
 {
-	wm97xx_ts_t* ts = &wm97xx_ts;
-
-#ifdef CONFIG_PM
-	pm_unregister (ts->pm);
+#if defined(CONFIG_PM)
+	pm_unregister (wm97xx_ts.pm);
 #endif
-	ac97_unregister_driver(&wm9705_driver);
-	ac97_unregister_driver(&wm9712_driver);
-	misc_deregister(&wm97xx_misc);
+	if (pen_int)
+		free_irq(WM97XX_IRQ, NULL);
+	input_unregister_device(&wm97xx_input);
 }
 
 /* Module information */
@@ -1355,8 +1162,8 @@
 		return 0;
 
 	/* parse the options and check for out of range values */
-	for(this_opt=strtok(options, ",");
-	    this_opt; this_opt=strtok(NULL, ",")) {
+	for(this_opt=strsep(options, ",");
+	    this_opt; this_opt=strsep(NULL, ",")) {
 		if (!strncmp(this_opt, "pil:", 4)) {
 			this_opt+=4;
 			pil = simple_strtol(this_opt, NULL, 0);
@@ -1399,6 +1206,13 @@
 				mode = 0;
 			continue;
 		}
+		if (!strncmp(this_opt, "pen_int:", 8)) {
+			this_opt+=8;
+			pen_int = simple_strtol(this_opt, NULL, 0);
+			if (pen_int < 0 || pen_int > 1)
+				pen_int = 0;
+			continue;
+		}
 	}
 	return 1;
 }

--=-wbI1hSXTL/bAmQfdUB8j--

