Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWHFHcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWHFHcT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWHFHcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:32:18 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:16293 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932431AbWHFHcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:32:15 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 02/12] hdaps: Use thinkpad_ec instead of direct port access
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:47 +0300
Message-Id: <11548492333054-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11548492171301-git-send-email-multinymous@gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hdaps module currently talks to the ThinkPad embedded controller via direct
IO port access, and does so incorrectly and with insufficient IO checking.
Beyond bad readouts, this could in principle, trigger known EC firmware bugs,
thereby causing a firmware hang and possible hardware damage.

The just-introduced thinkpad_ec provides a safe, correct way to access these
EC functions. This patch changes hdaps to use that. This also enables other
drivers (e.g., the soon-to-be-submitted tp_smapi module) to access the EC
without collisions.

As you can see from the comments at the beginning of the patch, the old
driver got some stuff wrong about the meaning of EC readouts. This patch
preserves the old broken behavior; it will be fixed in a later patch.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
 a/drivers/hwmon/hdaps.c |  314 +++++++++++++++++-------------------------------
 drivers/hwmon/Kconfig   |    1 
 2 files changed, 116 insertions(+), 199 deletions(-)

diff -up a/drivers/hwmon/hdaps.c a/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c
+++ a/drivers/hwmon/hdaps.c
@@ -33,31 +33,28 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 #include <linux/dmi.h>
-#include <asm/io.h>
+#include <linux/thinkpad_ec.h>
 
-#define HDAPS_LOW_PORT		0x1600	/* first port used by hdaps */
-#define HDAPS_NR_PORTS		0x30	/* number of ports: 0x1600 - 0x162f */
-
-#define HDAPS_PORT_STATE	0x1611	/* device state */
-#define HDAPS_PORT_YPOS		0x1612	/* y-axis position */
-#define	HDAPS_PORT_XPOS		0x1614	/* x-axis position */
-#define HDAPS_PORT_TEMP1	0x1616	/* device temperature, in Celsius */
-#define HDAPS_PORT_YVAR		0x1617	/* y-axis variance (what is this?) */
-#define HDAPS_PORT_XVAR		0x1619	/* x-axis variance (what is this?) */
-#define HDAPS_PORT_TEMP2	0x161b	/* device temperature (again?) */
-#define HDAPS_PORT_UNKNOWN	0x161c	/* what is this? */
-#define HDAPS_PORT_KMACT	0x161d	/* keyboard or mouse activity */
-
-#define STATE_FRESH		0x50	/* accelerometer data is fresh */
+/* Embedded controller accelerometer read command and its result: */
+static const struct thinkpad_ec_row ec_accel_args =
+	{ .mask=0x0001, .val={0x11} };
+#define EC_ACCEL_IDX_READOUTS	0x1	/* readouts included in this read */
+					/* First readout, if READOUTS>=1: */
+#define EC_ACCEL_IDX_YPOS1	0x2	/*   y-axis position word */
+#define EC_ACCEL_IDX_XPOS1	0x4	/*   x-axis position word */
+#define EC_ACCEL_IDX_TEMP1	0x6	/*   device temperature in Celsius */
+					/* Second readout, if READOUTS>=2: */
+#define EC_ACCEL_IDX_XPOS2	0x7	/*   y-axis position word */
+#define EC_ACCEL_IDX_YPOS2	0x9	/*   x-axis pisition word */
+#define EC_ACCEL_IDX_TEMP2	0xb	/*   device temperature in Celsius */
+#define EC_ACCEL_IDX_QUEUED	0xc	/* Number of queued readouts left */
+#define EC_ACCEL_IDX_KMACT	0xd	/* keyboard or mouse activity */
 
 #define KEYBD_MASK		0x20	/* set if keyboard activity */
 #define MOUSE_MASK		0x40	/* set if mouse activity */
 #define KEYBD_ISSET(n)		(!! (n & KEYBD_MASK))	/* keyboard used? */
 #define MOUSE_ISSET(n)		(!! (n & MOUSE_MASK))	/* mouse used? */
 
-#define INIT_TIMEOUT_MSECS	4000	/* wait up to 4s for device init ... */
-#define INIT_WAIT_MSECS		200	/* ... in 200ms increments */
-
 #define HDAPS_POLL_PERIOD	(HZ/20)	/* poll for input every 1/20s */
 #define HDAPS_INPUT_FUZZ	4	/* input event threshold */
 #define HDAPS_INPUT_FLAT	4
@@ -70,79 +67,6 @@ static u8 km_activity;
 static int rest_x;
 static int rest_y;
 
-static DECLARE_MUTEX(hdaps_sem);
-
-/*
- * __get_latch - Get the value from a given port.  Callers must hold hdaps_sem.
- */
-static inline u8 __get_latch(u16 port)
-{
-	return inb(port) & 0xff;
-}
-
-/*
- * __check_latch - Check a port latch for a given value.  Returns zero if the
- * port contains the given value.  Callers must hold hdaps_sem.
- */
-static inline int __check_latch(u16 port, u8 val)
-{
-	if (__get_latch(port) == val)
-		return 0;
-	return -EINVAL;
-}
-
-/*
- * __wait_latch - Wait up to 100us for a port latch to get a certain value,
- * returning zero if the value is obtained.  Callers must hold hdaps_sem.
- */
-static int __wait_latch(u16 port, u8 val)
-{
-	unsigned int i;
-
-	for (i = 0; i < 20; i++) {
-		if (!__check_latch(port, val))
-			return 0;
-		udelay(5);
-	}
-
-	return -EIO;
-}
-
-/*
- * __device_refresh - request a refresh from the accelerometer.  Does not wait
- * for refresh to complete.  Callers must hold hdaps_sem.
- */
-static void __device_refresh(void)
-{
-	udelay(200);
-	if (inb(0x1604) != STATE_FRESH) {
-		outb(0x11, 0x1610);
-		outb(0x01, 0x161f);
-	}
-}
-
-/*
- * __device_refresh_sync - request a synchronous refresh from the
- * accelerometer.  We wait for the refresh to complete.  Returns zero if
- * successful and nonzero on error.  Callers must hold hdaps_sem.
- */
-static int __device_refresh_sync(void)
-{
-	__device_refresh();
-	return __wait_latch(0x1604, STATE_FRESH);
-}
-
-/*
- * __device_complete - indicate to the accelerometer that we are done reading
- * data, and then initiate an async refresh.  Callers must hold hdaps_sem.
- */
-static inline void __device_complete(void)
-{
-	inb(0x161f);
-	inb(0x1604);
-	__device_refresh();
-}
-
 /*
  * hdaps_readb_one - reads a byte from a single I/O port, placing the value in
  * the given pointer.  Returns zero on success or a negative error on failure.
@@ -151,19 +75,15 @@ static inline void __device_complete(voi
 static int hdaps_readb_one(unsigned int port, u8 *val)
 {
 	int ret;
+	struct thinkpad_ec_row data;
 
-	down(&hdaps_sem);
-
-	/* do a sync refresh -- we need to be sure that we read fresh data */
-	ret = __device_refresh_sync();
+	ret = thinkpad_ec_lock();
 	if (ret)
-		goto out;
-
-	*val = inb(port);
-	__device_complete();
-
-out:
-	up(&hdaps_sem);
+		return ret;
+	data.mask = (1 << port);
+	ret = thinkpad_ec_read_row(&ec_accel_args, &data);
+	*val = data.val[port];
+	thinkpad_ec_unlock();
 	return ret;
 }
 
@@ -171,14 +91,17 @@ out:
 static int __hdaps_read_pair(unsigned int port1, unsigned int port2,
 			     int *x, int *y)
 {
-	/* do a sync refresh -- we need to be sure that we read fresh data */
-	if (__device_refresh_sync())
-		return -EIO;
+	int ret;
+	struct thinkpad_ec_row data;
 
-	*y = inw(port2);
-	*x = inw(port1);
-	km_activity = inb(HDAPS_PORT_KMACT);
-	__device_complete();
+	data.mask = (3 << port1) | (3 << port2) | (1 << EC_ACCEL_IDX_KMACT);
+	ret = thinkpad_ec_read_row(&ec_accel_args, &data);
+	if (ret)
+		return ret;
+
+	*x = *(s16*)(data.val+port1);
+	*y = *(s16*)(data.val+port2);
+	km_activity = data.val[EC_ACCEL_IDX_KMACT];
 
 	/* if hdaps_invert is set, negate the two values */
 	if (hdaps_invert) {
@@ -196,12 +119,11 @@ static int __hdaps_read_pair(unsigned in
 static int hdaps_read_pair(unsigned int port1, unsigned int port2,
 			   int *val1, int *val2)
 {
-	int ret;
-
-	down(&hdaps_sem);
+	int ret = thinkpad_ec_lock();
+	if (ret)
+		return ret;
 	ret = __hdaps_read_pair(port1, port2, val1, val2);
-	up(&hdaps_sem);
-
+	thinkpad_ec_unlock();
 	return ret;
 }
 
@@ -209,77 +131,79 @@ static int hdaps_read_pair(unsigned int 
  * hdaps_device_init - initialize the accelerometer.  Returns zero on success
  * and negative error code on failure.  Can sleep.
  */
+#define ABORT_INIT(msg) { printk(KERN_ERR "hdaps init: %s\n", msg); goto bad; }
 static int hdaps_device_init(void)
 {
-	int total, ret = -ENXIO;
-
-	down(&hdaps_sem);
-
-	outb(0x13, 0x1610);
-	outb(0x01, 0x161f);
-	if (__wait_latch(0x161f, 0x00))
-		goto out;
-
-	/*
-	 * Most ThinkPads return 0x01.
-	 *
-	 * Others--namely the R50p, T41p, and T42p--return 0x03.  These laptops
-	 * have "inverted" axises.
-	 *
-	 * The 0x02 value occurs when the chip has been previously initialized.
-	 */
-	if (__check_latch(0x1611, 0x03) &&
-		     __check_latch(0x1611, 0x02) &&
-		     __check_latch(0x1611, 0x01))
-		goto out;
-
-	printk(KERN_DEBUG "hdaps: initial latch check good (0x%02x).\n",
-	       __get_latch(0x1611));
+	int ret;
+	struct thinkpad_ec_row args, data;
+	u8 mode;
 
-	outb(0x17, 0x1610);
-	outb(0x81, 0x1611);
-	outb(0x01, 0x161f);
-	if (__wait_latch(0x161f, 0x00))
-		goto out;
-	if (__wait_latch(0x1611, 0x00))
-		goto out;
-	if (__wait_latch(0x1612, 0x60))
-		goto out;
-	if (__wait_latch(0x1613, 0x00))
-		goto out;
-	outb(0x14, 0x1610);
-	outb(0x01, 0x1611);
-	outb(0x01, 0x161f);
-	if (__wait_latch(0x161f, 0x00))
-		goto out;
-	outb(0x10, 0x1610);
-	outb(0xc8, 0x1611);
-	outb(0x00, 0x1612);
-	outb(0x02, 0x1613);
-	outb(0x01, 0x161f);
-	if (__wait_latch(0x161f, 0x00))
-		goto out;
-	if (__device_refresh_sync())
-		goto out;
-	if (__wait_latch(0x1611, 0x00))
-		goto out;
+	ret = thinkpad_ec_lock();
+	if (ret)
+		return ret;
 
-	/* we have done our dance, now let's wait for the applause */
-	for (total = INIT_TIMEOUT_MSECS; total > 0; total -= INIT_WAIT_MSECS) {
-		int x, y;
-
-		/* a read of the device helps push it into action */
-		__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y);
-		if (!__wait_latch(0x1611, 0x02)) {
-			ret = 0;
-			break;
-		}
+	args.val[0x0] = 0x13;
+	args.val[0xF] = 0x01;
+	args.mask=0x8001;
+	data.mask=0x8002;
+	if (thinkpad_ec_read_row(&args, &data))
+		ABORT_INIT("read1");
+	if (data.val[0xF]!=0x00)
+		ABORT_INIT("check1");
+	mode = data.val[0x1];
+		
+	printk(KERN_DEBUG "hdaps: initial mode latch is 0x%02x\n", mode);
+	if (mode==0x00)
+		ABORT_INIT("accelerometer not available");
+
+	args.val[0x0] = 0x17;
+	args.val[0x1] = 0x81;
+	args.val[0xF] = 0x01;
+	args.mask = 0x8003;
+	data.mask = 0x800E;
+	if (thinkpad_ec_read_row(&args, &data))
+		ABORT_INIT("read2");
+	if (data.val[0x1]!=0x00 ||
+	    data.val[0x2]!=0x60 ||
+	    data.val[0x3]!=0x00 ||
+	    data.val[0xF]!=0x00)
+		ABORT_INIT("check2");
+
+	args.val[0x0] = 0x14;
+	args.val[0x1] = 0x01;
+	args.val[0xF] = 0x01;
+	args.mask = 0x8003;
+	data.mask = 0x8000;
+	if (thinkpad_ec_read_row(&args, &data))
+		ABORT_INIT("read3");
+	if (data.val[0xF]!=0x00)
+		ABORT_INIT("check3");
+
+	args.val[0x0] = 0x10;
+	args.val[0x1] = 0xc8;
+	args.val[0x2] = 0x00;
+	args.val[0x3] = 0x02;
+	args.val[0xF] = 0x01;
+	args.mask = 0x800F;
+	data.mask = 0x8000;
+	if (thinkpad_ec_read_row(&args, &data))
+		ABORT_INIT("read4");
+	if (data.val[0xF]!=0x00)
+		ABORT_INIT("check4");
 
-		msleep(INIT_WAIT_MSECS);
-	}
+	thinkpad_ec_invalidate();
+	udelay(200);
 
-out:
-	up(&hdaps_sem);
+	/* Just prefetch instead of reading, to avoid ~1sec delay on load */
+	ret = thinkpad_ec_prefetch_row(&ec_accel_args);
+	if (ret)
+		ABORT_INIT("initial prefetch failed");
+	goto good;
+bad:
+	thinkpad_ec_invalidate();
+	ret = -ENXIO;
+good:
+	thinkpad_ec_unlock();
 	return ret;
 }
 
@@ -317,7 +241,7 @@ static struct platform_driver hdaps_driv
  */
 static void hdaps_calibrate(void)
 {
-	__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &rest_x, &rest_y);
+	__hdaps_read_pair(EC_ACCEL_IDX_XPOS1, EC_ACCEL_IDX_YPOS1, &rest_x, &rest_y);
 }
 
 static void hdaps_mousedev_poll(unsigned long unused)
@@ -325,12 +249,12 @@ static void hdaps_mousedev_poll(unsigned
 	int x, y;
 
 	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
-	if (down_trylock(&hdaps_sem)) {
+	if (thinkpad_ec_try_lock()) {
 		mod_timer(&hdaps_timer,jiffies + HDAPS_POLL_PERIOD);
 		return;
 	}
 
-	if (__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y))
+	if (__hdaps_read_pair(EC_ACCEL_IDX_XPOS1, EC_ACCEL_IDX_YPOS1, &x, &y))
 		goto out;
 
 	input_report_abs(hdaps_idev, ABS_X, x - rest_x);
@@ -340,7 +264,7 @@ static void hdaps_mousedev_poll(unsigned
 	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
 
 out:
-	up(&hdaps_sem);
+	thinkpad_ec_unlock();
 }
 
 
@@ -351,7 +275,7 @@ static ssize_t hdaps_position_show(struc
 {
 	int ret, x, y;
 
-	ret = hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y);
+	ret = hdaps_read_pair(EC_ACCEL_IDX_XPOS1, EC_ACCEL_IDX_YPOS1, &x, &y);
 	if (ret)
 		return ret;
 
@@ -363,7 +287,7 @@ static ssize_t hdaps_variance_show(struc
 {
 	int ret, x, y;
 
-	ret = hdaps_read_pair(HDAPS_PORT_XVAR, HDAPS_PORT_YVAR, &x, &y);
+	ret = hdaps_read_pair(EC_ACCEL_IDX_XPOS2, EC_ACCEL_IDX_YPOS2, &x, &y);
 	if (ret)
 		return ret;
 
@@ -376,7 +300,7 @@ static ssize_t hdaps_temp1_show(struct d
 	u8 temp;
 	int ret;
 
-	ret = hdaps_readb_one(HDAPS_PORT_TEMP1, &temp);
+	ret = hdaps_readb_one(EC_ACCEL_IDX_TEMP1, &temp);
 	if (ret < 0)
 		return ret;
 
@@ -389,7 +313,7 @@ static ssize_t hdaps_temp2_show(struct d
 	u8 temp;
 	int ret;
 
-	ret = hdaps_readb_one(HDAPS_PORT_TEMP2, &temp);
+	ret = hdaps_readb_one(EC_ACCEL_IDX_TEMP2, &temp);
 	if (ret < 0)
 		return ret;
 
@@ -420,10 +344,10 @@ static ssize_t hdaps_calibrate_store(str
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	down(&hdaps_sem);
+	if (thinkpad_ec_lock())
+		return -EIO;
 	hdaps_calibrate();
-	up(&hdaps_sem);
-
+	thinkpad_ec_unlock();
 	return count;
 }
 
@@ -550,14 +474,9 @@ static int __init hdaps_init(void)
 		goto out;
 	}
 
-	if (!request_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS, "hdaps")) {
-		ret = -ENXIO;
-		goto out;
-	}
-
 	ret = platform_driver_register(&hdaps_driver);
 	if (ret)
-		goto out_region;
+		goto out;
 
 	pdev = platform_device_register_simple("hdaps", -1, NULL, 0);
 	if (IS_ERR(pdev)) {
@@ -604,8 +523,6 @@ out_device:
 	platform_device_unregister(pdev);
 out_driver:
 	platform_driver_unregister(&hdaps_driver);
-out_region:
-	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
 out:
 	printk(KERN_WARNING "hdaps: driver init failed (ret=%d)!\n", ret);
 	return ret;
@@ -618,7 +535,6 @@ static void __exit hdaps_exit(void)
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 	platform_device_unregister(pdev);
 	platform_driver_unregister(&hdaps_driver);
-	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
 
 	printk(KERN_INFO "hdaps: driver unloaded.\n");
 }
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -494,6 +494,7 @@
 config SENSORS_HDAPS
 	tristate "IBM Hard Drive Active Protection System (hdaps)"
 	depends on HWMON && INPUT && X86
+	select THINKPAD_EC
 	default n
 	help
 	  This driver provides support for the IBM Hard Drive Active Protection
