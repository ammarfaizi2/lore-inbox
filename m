Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVINSSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVINSSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVINSSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:18:33 -0400
Received: from peabody.ximian.com ([130.57.169.10]:39661 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S932525AbVINSSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:18:32 -0400
Subject: [patch] hdaps driver update, updated.
From: Robert Love <rml@novell.com>
To: Mr Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
In-Reply-To: <1126713453.5738.7.camel@molly>
References: <1126713453.5738.7.camel@molly>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 14:19:09 -0400
Message-Id: <1126721949.5738.43.camel@molly>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 11:57 -0400, Robert Love wrote:

Mr Morton,

> The hdaps driver landed in 2.6.14-rc1.
> 
> The attached patch updates the driver:
> 
> 	- Remove the relative input device
> 	- Add an absolute input device
> 	- Misc. cleanup and bug fixing
> 
> The patch is sizable due to the cleanup from removing the relative input
> device (net -112 lines).

Updated patch, which does not remove

	- the use of platform_device_register_simple()
	- the module owner from the device_driver structure

and net line change is now -126, so who can complain?

Highest regards and cordials,

	Robert Love


Updates to the hdaps driver.

Signed-off-by: Robert Love <rml@novell.com>

 drivers/hwmon/hdaps.c |  356 ++++++++++++++++----------------------------------
 1 files changed, 118 insertions(+), 238 deletions(-)

diff -urN linux-2.6.14-rc1/drivers/hwmon/hdaps.c linux/drivers/hwmon/hdaps.c
--- linux-2.6.14-rc1/drivers/hwmon/hdaps.c	2005-09-14 10:42:11.000000000 -0400
+++ linux/drivers/hwmon/hdaps.c	2005-09-14 14:11:10.000000000 -0400
@@ -5,10 +5,10 @@
  * Copyright (C) 2005 Jesper Juhl <jesper.juhl@gmail.com>
  *
  * The HardDisk Active Protection System (hdaps) is present in the IBM ThinkPad
- * T41, T42, T43, R51, and X40, at least.  It provides a basic two-axis
- * accelerometer and other data, such as the device's temperature.
+ * T41, T42, T43, R50, R50p, R51, and X40, at least.  It provides a basic
+ * two-axis accelerometer and other data, such as the device's temperature.
  *
- * Based on the document by Mark A. Smith available at
+ * This driver is based on the document by Mark A. Smith available at
  * http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html and a lot of trial
  * and error.
  *
@@ -36,12 +36,7 @@
 #include <asm/io.h>
 
 #define HDAPS_LOW_PORT		0x1600	/* first port used by hdaps */
-#define HDAPS_NR_PORTS		0x30	/* 0x1600 - 0x162f */
-
-#define STATE_FRESH		0x50	/* accelerometer data is fresh */
-
-#define REFRESH_ASYNC		0x00	/* do asynchronous refresh */
-#define REFRESH_SYNC		0x01	/* do synchronous refresh */
+#define HDAPS_NR_PORTS		0x30	/* number of ports: 0x1600 - 0x162f */
 
 #define HDAPS_PORT_STATE	0x1611	/* device state */
 #define HDAPS_PORT_YPOS		0x1612	/* y-axis position */
@@ -53,7 +48,7 @@
 #define HDAPS_PORT_UNKNOWN	0x161c	/* what is this? */
 #define HDAPS_PORT_KMACT	0x161d	/* keyboard or mouse activity */
 
-#define HDAPS_READ_MASK		0xff	/* some reads have the low 8 bits set */
+#define STATE_FRESH		0x50	/* accelerometer data is fresh */
 
 #define KEYBD_MASK		0x20	/* set if keyboard activity */
 #define MOUSE_MASK		0x40	/* set if mouse activity */
@@ -63,12 +58,11 @@
 #define INIT_TIMEOUT_MSECS	4000	/* wait up to 4s for device init ... */
 #define INIT_WAIT_MSECS		200	/* ... in 200ms increments */
 
-static struct platform_device *pdev;
-static struct input_dev hdaps_idev;
+#define HDAPS_POLL_PERIOD	(HZ/20)	/* poll for input every 1/20s */
+#define HDAPS_INPUT_FUZZ	4	/* input event threshold */
+
 static struct timer_list hdaps_timer;
-static unsigned int hdaps_mousedev_threshold = 4;
-static unsigned long hdaps_poll_ms = 50;
-static unsigned int hdaps_mousedev;
+static struct platform_device *pdev;
 static unsigned int hdaps_invert;
 static u8 km_activity;
 static int rest_x;
@@ -81,14 +75,14 @@
  */
 static inline u8 __get_latch(u16 port)
 {
-	return inb(port) & HDAPS_READ_MASK;
+	return inb(port) & 0xff;
 }
 
 /*
- * __check_latch - Check a port latch for a given value.  Callers must hold
- * hdaps_sem.  Returns zero if the port contains the given value.
+ * __check_latch - Check a port latch for a given value.  Returns zero if the
+ * port contains the given value.  Callers must hold hdaps_sem.
  */
-static inline unsigned int __check_latch(u16 port, u8 val)
+static inline int __check_latch(u16 port, u8 val)
 {
 	if (__get_latch(port) == val)
 		return 0;
@@ -99,7 +93,7 @@
  * __wait_latch - Wait up to 100us for a port latch to get a certain value,
  * returning zero if the value is obtained.  Callers must hold hdaps_sem.
  */
-static unsigned int __wait_latch(u16 port, u8 val)
+static int __wait_latch(u16 port, u8 val)
 {
 	unsigned int i;
 
@@ -109,59 +103,42 @@
 		udelay(5);
 	}
 
-	return -EINVAL;
+	return -EIO;
 }
 
 /*
- * __device_refresh - Request a refresh from the accelerometer.
- *
- * If sync is REFRESH_SYNC, we perform a synchronous refresh and will wait.
- * Returns zero if successful and nonzero on error.
- *
- * If sync is REFRESH_ASYNC, we merely kick off a new refresh if the device is
- * not up-to-date.  Always returns zero.
- *
- * Callers must hold hdaps_sem.
+ * __device_refresh - request a refresh from the accelerometer.  Does not wait
+ * for refresh to complete.  Callers must hold hdaps_sem.
  */
-static int __device_refresh(unsigned int sync)
+static void __device_refresh(void)
 {
-	u8 state;
-
-	udelay(100);
-
-	state = inb(0x1604);
-	if (state == STATE_FRESH)
-		return 0;
-
-	outb(0x11, 0x1610);
-	outb(0x01, 0x161f);
-	if (sync == REFRESH_ASYNC)
-		return 0;
+	udelay(200);
+	if (inb(0x1604) != STATE_FRESH) {
+		outb(0x11, 0x1610);
+		outb(0x01, 0x161f);
+	}
+}
 
+/*
+ * __device_refresh_sync - request a synchronous refresh from the
+ * accelerometer.  We wait for the refresh to complete.  Returns zero if
+ * successful and nonzero on error.  Callers must hold hdaps_sem.
+ */
+static int __device_refresh_sync(void)
+{
+	__device_refresh();
 	return __wait_latch(0x1604, STATE_FRESH);
 }
 
 /*
- * __device_complete - Indicate to the accelerometer that we are done reading
+ * __device_complete - indicate to the accelerometer that we are done reading
  * data, and then initiate an async refresh.  Callers must hold hdaps_sem.
  */
 static inline void __device_complete(void)
 {
 	inb(0x161f);
 	inb(0x1604);
-	__device_refresh(REFRESH_ASYNC);
-}
-
-static int __hdaps_readb_one(unsigned int port, u8 *val)
-{
-	/* do a sync refresh -- we need to be sure that we read fresh data */
-	if (__device_refresh(REFRESH_SYNC))
-		return -EIO;
-
-	*val = inb(port);
-	__device_complete();
-
-	return 0;
+	__device_refresh();
 }
 
 /*
@@ -174,17 +151,26 @@
 	int ret;
 
 	down(&hdaps_sem);
-	ret = __hdaps_readb_one(port, val);
-	up(&hdaps_sem);
 
+	/* do a sync refresh -- we need to be sure that we read fresh data */
+	ret = __device_refresh_sync();
+	if (ret)
+		goto out;
+
+	*val = inb(port);
+	__device_complete();
+
+out:
+	up(&hdaps_sem);
 	return ret;
 }
 
+/* __hdaps_read_pair - internal lockless helper for hdaps_read_pair(). */
 static int __hdaps_read_pair(unsigned int port1, unsigned int port2,
 			     int *x, int *y)
 {
 	/* do a sync refresh -- we need to be sure that we read fresh data */
-	if (__device_refresh(REFRESH_SYNC))
+	if (__device_refresh_sync())
 		return -EIO;
 
 	*y = inw(port2);
@@ -217,11 +203,13 @@
 	return ret;
 }
 
-/* initialize the accelerometer */
+/*
+ * hdaps_device_init - initialize the accelerometer.  Returns zero on success
+ * and negative error code on failure.  Can sleep.
+ */
 static int hdaps_device_init(void)
 {
-	unsigned int total_msecs = INIT_TIMEOUT_MSECS;
-	int ret = -ENXIO;
+	int total, ret = -ENXIO;
 
 	down(&hdaps_sem);
 
@@ -231,8 +219,10 @@
 		goto out;
 
 	/*
-	 * The 0x03 value appears to only work on some thinkpads, such as the
-	 * T42p.  Others return 0x01.
+	 * Most ThinkPads return 0x01.
+	 *
+	 * Others--namely the R50p, T41p, and T42p--return 0x03.  These laptops
+	 * have "inverted" axises.
 	 *
 	 * The 0x02 value occurs when the chip has been previously initialized.
 	 */
@@ -267,24 +257,23 @@
 	outb(0x01, 0x161f);
 	if (__wait_latch(0x161f, 0x00))
 		goto out;
-	if (__device_refresh(REFRESH_SYNC))
+	if (__device_refresh_sync())
 		goto out;
 	if (__wait_latch(0x1611, 0x00))
 		goto out;
 
 	/* we have done our dance, now let's wait for the applause */
-	while (total_msecs > 0) {
-		u8 ignored;
+	for (total = INIT_TIMEOUT_MSECS; total > 0; total -= INIT_WAIT_MSECS) {
+		int x, y;
 
 		/* a read of the device helps push it into action */
-		__hdaps_readb_one(HDAPS_PORT_UNKNOWN, &ignored);
+		__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y);
 		if (!__wait_latch(0x1611, 0x02)) {
 			ret = 0;
 			break;
 		}
 
 		msleep(INIT_WAIT_MSECS);
-		total_msecs -= INIT_WAIT_MSECS;
 	}
 
 out:
@@ -293,96 +282,6 @@
 }
 
 
-/* Input class stuff */
-
-/*
- * hdaps_calibrate - Zero out our "resting" values. Callers must hold hdaps_sem.
- */
-static void hdaps_calibrate(void)
-{
-	int x, y;
-
-	if (__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y))
-		return;
-
-	rest_x = x;
-	rest_y = y;
-}
-
-static void hdaps_mousedev_poll(unsigned long unused)
-{
-	int x, y;
-
-	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
-	if (down_trylock(&hdaps_sem)) {
-		mod_timer(&hdaps_timer,jiffies+msecs_to_jiffies(hdaps_poll_ms));
-		return;
-	}
-
-	if (__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y))
-		goto out;
-
-	x -= rest_x;
-	y -= rest_y;
-	if (abs(x) > hdaps_mousedev_threshold)
-		input_report_rel(&hdaps_idev, REL_X, x);
-	if (abs(y) > hdaps_mousedev_threshold)
-		input_report_rel(&hdaps_idev, REL_Y, y);
-	input_sync(&hdaps_idev);
-
-	mod_timer(&hdaps_timer, jiffies + msecs_to_jiffies(hdaps_poll_ms));
-
-out:
-	up(&hdaps_sem);
-}
-
-/*
- * hdaps_mousedev_enable - enable the input class device.  Can sleep.
- */
-static void hdaps_mousedev_enable(void)
-{
-	down(&hdaps_sem);
-
-	/* calibrate the device before enabling */
-	hdaps_calibrate();
-
-	/* initialize the input class */
-	init_input_dev(&hdaps_idev);
-	hdaps_idev.dev = &pdev->dev;
-	hdaps_idev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	hdaps_idev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	hdaps_idev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT);
-	input_register_device(&hdaps_idev);
-
-	/* start up our timer */
-	init_timer(&hdaps_timer);
-	hdaps_timer.function = hdaps_mousedev_poll;
-	hdaps_timer.expires = jiffies + msecs_to_jiffies(hdaps_poll_ms);
-	add_timer(&hdaps_timer);
-
-	hdaps_mousedev = 1;
-
-	up(&hdaps_sem);
-
-	printk(KERN_INFO "hdaps: input device enabled.\n");
-}
-
-/*
- * hdaps_mousedev_disable - disable the input class device.  Caller must hold
- * hdaps_sem.
- */
-static void hdaps_mousedev_disable(void)
-{
-	down(&hdaps_sem);
-	if (hdaps_mousedev) {
-		hdaps_mousedev = 0;
-		del_timer_sync(&hdaps_timer);
-		input_unregister_device(&hdaps_idev);
-	}
-	up(&hdaps_sem);
-}
-
-
 /* Device model stuff */
 
 static int hdaps_probe(struct device *dev)
@@ -412,6 +311,49 @@
 	.resume = hdaps_resume
 };
 
+/* Input class stuff */
+
+static struct input_dev hdaps_idev = {
+	.name = "hdaps",
+	.evbit = { BIT(EV_ABS) },
+	.absbit = { BIT(ABS_X) | BIT(ABS_Y) },
+	.absmin  = { [ABS_X] = -256, [ABS_Y] = -256 },
+	.absmax  = { [ABS_X] = 256, [ABS_Y] = 256 },
+	.absfuzz = { [ABS_X] = HDAPS_INPUT_FUZZ, [ABS_Y] = HDAPS_INPUT_FUZZ },
+	.absflat = { [ABS_X] = HDAPS_INPUT_FUZZ, [ABS_Y] = HDAPS_INPUT_FUZZ },
+};
+
+/*
+ * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_sem.
+ */
+static void hdaps_calibrate(void)
+{
+	__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &rest_x, &rest_y);
+}
+
+static void hdaps_mousedev_poll(unsigned long unused)
+{
+	int x, y;
+
+	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
+	if (down_trylock(&hdaps_sem)) {
+		mod_timer(&hdaps_timer,jiffies + HDAPS_POLL_PERIOD);
+		return;
+	}
+
+	if (__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y))
+		goto out;
+
+	input_report_abs(&hdaps_idev, ABS_X, x - rest_x);
+	input_report_abs(&hdaps_idev, ABS_Y, y - rest_y);
+	input_sync(&hdaps_idev);
+
+	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
+
+out:
+	up(&hdaps_sem);
+}
+
 
 /* Sysfs Files */
 
@@ -517,69 +459,6 @@
 	return count;
 }
 
-static ssize_t hdaps_mousedev_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d\n", hdaps_mousedev);
-}
-
-static ssize_t hdaps_mousedev_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	int enable;
-
-	if (sscanf(buf, "%d", &enable) != 1)
-		return -EINVAL;
-
-	if (enable == 1)
-		hdaps_mousedev_enable();
-	else if (enable == 0)
-		hdaps_mousedev_disable();
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static ssize_t hdaps_poll_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%lu\n", hdaps_poll_ms);
-}
-
-static ssize_t hdaps_poll_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	unsigned int poll;
-
-	if (sscanf(buf, "%u", &poll) != 1 || poll == 0)
-		return -EINVAL;
-	hdaps_poll_ms = poll;
-
-	return count;
-}
-
-static ssize_t hdaps_threshold_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%u\n", hdaps_mousedev_threshold);
-}
-
-static ssize_t hdaps_threshold_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	unsigned int threshold;
-
-	if (sscanf(buf, "%u", &threshold) != 1 || threshold == 0)
-		return -EINVAL;
-	hdaps_mousedev_threshold = threshold;
-
-	return count;
-}
-
 static DEVICE_ATTR(position, 0444, hdaps_position_show, NULL);
 static DEVICE_ATTR(variance, 0444, hdaps_variance_show, NULL);
 static DEVICE_ATTR(temp1, 0444, hdaps_temp1_show, NULL);
@@ -588,10 +467,6 @@
 static DEVICE_ATTR(mouse_activity, 0444, hdaps_mouse_activity_show, NULL);
 static DEVICE_ATTR(calibrate, 0644, hdaps_calibrate_show,hdaps_calibrate_store);
 static DEVICE_ATTR(invert, 0644, hdaps_invert_show, hdaps_invert_store);
-static DEVICE_ATTR(mousedev, 0644, hdaps_mousedev_show, hdaps_mousedev_store);
-static DEVICE_ATTR(mousedev_poll_ms, 0644, hdaps_poll_show, hdaps_poll_store);
-static DEVICE_ATTR(mousedev_threshold, 0644, hdaps_threshold_show,
-		   hdaps_threshold_store);
 
 static struct attribute *hdaps_attributes[] = {
 	&dev_attr_position.attr,
@@ -601,9 +476,6 @@
 	&dev_attr_keyboard_activity.attr,
 	&dev_attr_mouse_activity.attr,
 	&dev_attr_calibrate.attr,
-	&dev_attr_mousedev.attr,
-	&dev_attr_mousedev_threshold.attr,
-	&dev_attr_mousedev_poll_ms.attr,
 	&dev_attr_invert.attr,
 	NULL,
 };
@@ -619,7 +491,7 @@
  * XXX: We should be able to return nonzero and halt the detection process.
  * But there is a bug in dmi_check_system() where a nonzero return from the
  * first match will result in a return of failure from dmi_check_system().
- * I fixed this; the patch is in 2.6-mm.  Once in Linus's tree we can make
+ * I fixed this; the patch is 2.6-git.  Once in a released tree, we can make
  * hdaps_dmi_match_invert() return hdaps_dmi_match(), which in turn returns 1.
  */
 static int hdaps_dmi_match(struct dmi_system_id *id)
@@ -668,6 +540,7 @@
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T42"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T43"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X40"),
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41 Tablet"),
 		{ .ident = NULL }
 	};
 
@@ -696,8 +569,18 @@
 	if (ret)
 		goto out_device;
 
-	if (hdaps_mousedev)
-		hdaps_mousedev_enable();
+	/* initial calibrate for the input device */
+	hdaps_calibrate();
+
+	/* initialize the input class */
+	hdaps_idev.dev = &pdev->dev;
+	input_register_device(&hdaps_idev);
+
+	/* start up our timer for the input device */
+	init_timer(&hdaps_timer);
+	hdaps_timer.function = hdaps_mousedev_poll;
+	hdaps_timer.expires = jiffies + HDAPS_POLL_PERIOD;
+	add_timer(&hdaps_timer);
 
 	printk(KERN_INFO "hdaps: driver successfully loaded.\n");
 	return 0;
@@ -715,8 +598,8 @@
 
 static void __exit hdaps_exit(void)
 {
-	hdaps_mousedev_disable();
-
+	del_timer_sync(&hdaps_timer);
+	input_unregister_device(&hdaps_idev);
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 	platform_device_unregister(pdev);
 	driver_unregister(&hdaps_driver);
@@ -728,9 +611,6 @@
 module_init(hdaps_init);
 module_exit(hdaps_exit);
 
-module_param_named(mousedev, hdaps_mousedev, bool, 0);
-MODULE_PARM_DESC(mousedev, "enable the input class device");
-
 module_param_named(invert, hdaps_invert, bool, 0);
 MODULE_PARM_DESC(invert, "invert data along each axis");
 


