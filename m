Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267546AbUG2OvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267546AbUG2OvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267670AbUG2Ouw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:50:52 -0400
Received: from styx.suse.cz ([82.119.242.94]:21654 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264903AbUG2OIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 18/47] Updates to the tsdev driver (raw protocol, calib ioctls, ...)
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101953746@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101952880@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.117.5, 2004-06-06 11:56:42+02:00, zap@homelink.ru
  input: 
  
  From: Andrew Zabolotny <zap@homelink.ru>
  
  - Implement the 'raw' touchscreen protocol for backward compatibility
    (/dev/input/ts[0-7] now speaks the protocol of the old /dev/h3600_ts, and
    the /dev/input/tsraw[0-7] speaks the protocol of the old /dev/h3600_tsraw
    device).
  
  - Support the ioctls for setting the calibration parameters.  The default
    calibration matrix is computed from the xres,yres parameters (duplicate the
    old behaviour), however this is not enough for a good translation from
    touchscreen space to screen space.
  
  - Fixed a old bug in tsdev: on a pen motion event X1,Y1 -> X2,Y2 the driver
    would output three events with coordinates: X1,Y1, X2,Y1, X2,Y2.  This
    happened not only with coordinates, but with pressure too.
  
  - Update James's email address
  
  - Remove mention of Transvirtual Technologies: they no longer exist.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 tsdev.c |  291 ++++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 186 insertions(+), 105 deletions(-)

===================================================================

diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	Thu Jul 29 14:40:58 2004
+++ b/drivers/input/tsdev.c	Thu Jul 29 14:40:58 2004
@@ -3,9 +3,17 @@
  *
  *  Copyright (c) 2001 "Crazy" james Simmons 
  *
- *  Input driver to Touchscreen device driver module.
+ *  Compaq touchscreen protocol driver. The protocol emulated by this driver
+ *  is obsolete; for new programs use the tslib library which can read directly
+ *  from evdev and perform dejittering, variance filtering and calibration -
+ *  all in user space, not at kernel level. The meaning of this driver is
+ *  to allow usage of newer input drivers with old applications that use the
+ *  old /dev/h3600_ts and /dev/h3600_tsraw devices.
  *
- *  Sponsored by Transvirtual Technology
+ *  09-Apr-2004: Andrew Zabolotny <zap@homelink.ru>
+ *      Fixed to actually work, not just output random numbers.
+ *      Added support for both h3600_ts and h3600_tsraw protocol
+ *      emulation.
  */
 
 /*
@@ -24,11 +32,13 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  * 
  * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <jsimmons@transvirtual.com>.
+ * e-mail - mail your message to <jsimmons@infradead.org>.
  */
 
 #define TSDEV_MINOR_BASE 	128
 #define TSDEV_MINORS		32
+/* First 16 devices are h3600_ts compatible; second 16 are h3600_tsraw */
+#define TSDEV_MINOR_MASK	15
 #define TSDEV_BUFFER_SIZE	64
 
 #include <linux/slab.h>
@@ -52,48 +62,84 @@
 #define CONFIG_INPUT_TSDEV_SCREEN_Y	320
 #endif
 
+/* This driver emulates both protocols of the old h3600_ts and h3600_tsraw
+ * devices. The first one must output X/Y data in 'cooked' format, e.g.
+ * filtered, dejittered and calibrated. Second device just outputs raw
+ * data received from the hardware.
+ *
+ * This driver doesn't support filtering and dejittering; it supports only
+ * calibration. Filtering and dejittering must be done in the low-level
+ * driver, if needed, because it may gain additional benefits from knowing
+ * the low-level details, the nature of noise and so on.
+ *
+ * The driver precomputes a calibration matrix given the initial xres and
+ * yres values (quite innacurate for most touchscreens) that will result
+ * in a more or less expected range of output values. The driver supports
+ * the TS_SET_CAL ioctl, which will replace the calibration matrix with a
+ * new one, supposedly generated from the values taken from the raw device.
+ */
+
 MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
 MODULE_DESCRIPTION("Input driver to touchscreen converter");
 MODULE_LICENSE("GPL");
 
 static int xres = CONFIG_INPUT_TSDEV_SCREEN_X;
 module_param(xres, uint, 0);
-MODULE_PARM_DESC(xres, "Horizontal screen resolution");
+MODULE_PARM_DESC(xres, "Horizontal screen resolution (can be negative for X-mirror)");
 
 static int yres = CONFIG_INPUT_TSDEV_SCREEN_Y;
 module_param(yres, uint, 0);
-MODULE_PARM_DESC(yres, "Vertical screen resolution");
+MODULE_PARM_DESC(yres, "Vertical screen resolution (can be negative for Y-mirror)");
+
+/* From Compaq's Touch Screen Specification version 0.2 (draft) */
+struct ts_event {
+	short pressure;
+	short x;
+	short y;
+	short millisecs;
+};
+
+struct ts_calibration {
+	int xscale;
+	int xtrans;
+	int yscale;
+	int ytrans;
+	int xyswap;
+};
 
 struct tsdev {
 	int exist;
 	int open;
 	int minor;
-	char name[16];
+	char name[8];
 	wait_queue_head_t wait;
 	struct list_head list;
 	struct input_handle handle;
+	int x, y, pressure;
+	struct ts_calibration cal;
 };
 
-/* From Compaq's Touch Screen Specification version 0.2 (draft) */
-typedef struct {
-	short pressure;
-	short x;
-	short y;
-	short millisecs;
-} TS_EVENT;
-
 struct tsdev_list {
 	struct fasync_struct *fasync;
 	struct list_head node;
 	struct tsdev *tsdev;
 	int head, tail;
-	int oldx, oldy, pendown;
-	TS_EVENT event[TSDEV_BUFFER_SIZE];
+	struct ts_event event[TSDEV_BUFFER_SIZE];
+	int raw;
 };
 
+/* The following ioctl codes are defined ONLY for backward compatibility.
+ * Don't use tsdev for new developement; use the tslib library instead.
+ * Touchscreen calibration is a fully userspace task.
+ */
+/* Use 'f' as magic number */
+#define IOC_H3600_TS_MAGIC  'f'
+#define TS_GET_CAL	_IOR(IOC_H3600_TS_MAGIC, 10, struct ts_calibration)
+#define TS_SET_CAL	_IOW(IOC_H3600_TS_MAGIC, 11, struct ts_calibration)
+
 static struct input_handler tsdev_handler;
 
-static struct tsdev *tsdev_table[TSDEV_MINORS];
+static struct tsdev *tsdev_table[TSDEV_MINORS/2];
 
 static int tsdev_fasync(int fd, struct file *file, int on)
 {
@@ -109,13 +155,16 @@
 	int i = iminor(inode) - TSDEV_MINOR_BASE;
 	struct tsdev_list *list;
 
-	if (i >= TSDEV_MINORS || !tsdev_table[i])
+	if (i >= TSDEV_MINORS || !tsdev_table[i & TSDEV_MINOR_MASK])
 		return -ENODEV;
 
 	if (!(list = kmalloc(sizeof(struct tsdev_list), GFP_KERNEL)))
 		return -ENOMEM;
 	memset(list, 0, sizeof(struct tsdev_list));
 
+	list->raw = (i >= TSDEV_MINORS/2) ? 1 : 0;
+
+	i &= TSDEV_MINOR_MASK;
 	list->tsdev = tsdev_table[i];
 	list_add_tail(&list->node, &tsdev_table[i]->list);
 	file->private_data = list;
@@ -169,11 +218,13 @@
 	if (!list->tsdev->exist)
 		return -ENODEV;
 
-	while (list->head != list->tail && retval + sizeof(TS_EVENT) <= count) {
-		if (copy_to_user (buffer + retval, list->event + list->tail, sizeof(TS_EVENT)))
+	while (list->head != list->tail &&
+	       retval + sizeof (struct ts_event) <= count) {
+		if (copy_to_user (buffer + retval, list->event + list->tail,
+				  sizeof (struct ts_event)))
 			return -EFAULT;
 		list->tail = (list->tail + 1) & (TSDEV_BUFFER_SIZE - 1);
-		retval += sizeof(TS_EVENT);
+		retval += sizeof (struct ts_event);
 	}
 
 	return retval;
@@ -193,22 +244,27 @@
 static int tsdev_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
-/*
 	struct tsdev_list *list = file->private_data;
-        struct tsdev *evdev = list->tsdev;
-        struct input_dev *dev = tsdev->handle.dev;
-        int retval;
-	
+	struct tsdev *tsdev = list->tsdev;
+	int retval = 0;
+
 	switch (cmd) {
-		case HHEHE:
-			return 0;
-		case hjff:
-			return 0;
-		default:
-			return 0;
+	case TS_GET_CAL:
+		if (copy_to_user ((void *)arg, &tsdev->cal,
+				  sizeof (struct ts_calibration)))
+			retval = -EFAULT;
+		break;
+	case TS_SET_CAL:
+		if (copy_from_user (&tsdev->cal, (void *)arg,
+				    sizeof (struct ts_calibration)))
+			retval = -EFAULT;
+		break;
+	default:
+		retval = -EINVAL;
+		break;
 	}
-*/
-	return -EINVAL;
+
+	return retval;
 }
 
 struct file_operations tsdev_fops = {
@@ -227,82 +283,85 @@
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 	struct timeval time;
-	int size;
 
-	list_for_each_entry(list, &tsdev->list, node) {
-		switch (type) {
-		case EV_ABS:
-			switch (code) {
-			case ABS_X:
-				if (!list->pendown)
-					return;
-				size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
-				if (size > 0)
-					list->oldx = ((value - handle->dev->absmin[ABS_X]) * xres / size);
-				else
-					list->oldx = ((value - handle->dev->absmin[ABS_X]));
-				break;
-			case ABS_Y:
-				if (!list->pendown)
-					return;
-				size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
-				if (size > 0)
-					list->oldy = ((value - handle->dev->absmin[ABS_Y]) * yres / size);
-				else
-					list->oldy = ((value - handle->dev->absmin[ABS_Y]));
-				break;
-			case ABS_PRESSURE:
-				list->pendown = ((value > handle->dev-> absmin[ABS_PRESSURE])) ?
-				    value - handle->dev->absmin[ABS_PRESSURE] : 0;
-				break;
-			}
+	switch (type) {
+	case EV_ABS:
+		switch (code) {
+		case ABS_X:
+			tsdev->x = value;
+			break;
+		case ABS_Y:
+			tsdev->y = value;
+			break;
+		case ABS_PRESSURE:
+			if (value > handle->dev->absmax[ABS_PRESSURE])
+				value = handle->dev->absmax[ABS_PRESSURE];
+			value -= handle->dev->absmin[ABS_PRESSURE];
+			if (value < 0)
+				value = 0;
+			tsdev->pressure = value;
+			break;
+		}
+		break;
+
+	case EV_REL:
+		switch (code) {
+		case REL_X:
+			tsdev->x += value;
+			if (tsdev->x < 0)
+				tsdev->x = 0;
+			else if (tsdev->x > xres)
+				tsdev->x = xres;
+			break;
+		case REL_Y:
+			tsdev->y += value;
+			if (tsdev->y < 0)
+				tsdev->y = 0;
+			else if (tsdev->y > yres)
+				tsdev->y = yres;
 			break;
+		}
+		break;
 
-		case EV_REL:
-			switch (code) {
-			case REL_X:
-				if (!list->pendown)
-					return;
-				list->oldx += value;
-				if (list->oldx < 0)
-					list->oldx = 0;
-				else if (list->oldx > xres)
-					list->oldx = xres;
+	case EV_KEY:
+		if (code == BTN_TOUCH || code == BTN_MOUSE) {
+			switch (value) {
+			case 0:
+				tsdev->pressure = 0;
 				break;
-			case REL_Y:
-				if (!list->pendown)
-					return;
-				list->oldy += value;
-				if (list->oldy < 0)
-					list->oldy = 0;
-				else if (list->oldy > xres)
-					list->oldy = xres;
+			case 1:
+				if (!tsdev->pressure)
+					tsdev->pressure = 1;
 				break;
 			}
-			break;
-
-		case EV_KEY:
-			if (code == BTN_TOUCH || code == BTN_MOUSE) {
-				switch (value) {
-				case 0:
-					list->pendown = 0;
-					break;
-				case 1:
-					if (!list->pendown)
-						list->pendown = 1;
-					break;
-				case 2:
-					return;
-				}
-			} else
-				return;
-			break;
 		}
+		break;
+	}
+
+	if (type != EV_SYN || code != SYN_REPORT)
+		return;
+
+	list_for_each_entry(list, &tsdev->list, node) {
+		int x, y, tmp;
+
 		do_gettimeofday(&time);
 		list->event[list->head].millisecs = time.tv_usec / 100;
-		list->event[list->head].pressure = list->pendown;
-		list->event[list->head].x = list->oldx;
-		list->event[list->head].y = list->oldy;
+		list->event[list->head].pressure = tsdev->pressure;
+
+		x = tsdev->x;
+		y = tsdev->y;
+
+		/* Calibration */
+		if (!list->raw) {
+			x = ((x * tsdev->cal.xscale) >> 8) + tsdev->cal.xtrans;
+			y = ((y * tsdev->cal.yscale) >> 8) + tsdev->cal.ytrans;
+			if (tsdev->cal.xyswap) {
+				tmp = x; x = y; y = tmp;
+			}
+		}
+
+		list->event[list->head].x = x;
+		list->event[list->head].y = y;
 		list->head = (list->head + 1) & (TSDEV_BUFFER_SIZE - 1);
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
 	}
@@ -314,11 +373,11 @@
 					  struct input_device_id *id)
 {
 	struct tsdev *tsdev;
-	int minor;
+	int minor, delta;
 
-	for (minor = 0; minor < TSDEV_MINORS && tsdev_table[minor];
+	for (minor = 0; minor < TSDEV_MINORS/2 && tsdev_table[minor];
 	     minor++);
-	if (minor == TSDEV_MINORS) {
+	if (minor >= TSDEV_MINORS/2) {
 		printk(KERN_ERR
 		       "tsdev: You have way too many touchscreens\n");
 		return NULL;
@@ -340,10 +399,25 @@
 	tsdev->handle.handler = handler;
 	tsdev->handle.private = tsdev;
 
+	/* Precompute the rough calibration matrix */
+	delta = dev->absmax [ABS_X] - dev->absmin [ABS_X] + 1;
+	if (delta == 0)
+		delta = 1;
+	tsdev->cal.xscale = (xres << 8) / delta;
+	tsdev->cal.xtrans = - ((dev->absmin [ABS_X] * tsdev->cal.xscale) >> 8);
+
+	delta = dev->absmax [ABS_Y] - dev->absmin [ABS_Y] + 1;
+	if (delta == 0)
+		delta = 1;
+	tsdev->cal.yscale = (yres << 8) / delta;
+	tsdev->cal.ytrans = - ((dev->absmin [ABS_Y] * tsdev->cal.yscale) >> 8);
+
 	tsdev_table[minor] = tsdev;
-	
+
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
+			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
 	class_simple_device_add(input_class, 
 				MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 				dev->dev, "ts%d", minor);
@@ -362,6 +436,7 @@
 		wake_up_interruptible(&tsdev->wait);
 	} else
 		tsdev_free(tsdev);
+	devfs_remove("input/tsraw%d", tsdev->minor);
 }
 
 static struct input_device_id tsdev_ids[] = {
@@ -378,6 +453,12 @@
 	      .keybit	= { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
 	      .absbit	= { BIT(ABS_X) | BIT(ABS_Y) },
 	 },/* A tablet like device, at least touch detection, two absolute axes */
+
+	{
+	      .flags	= INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+	      .evbit	= { BIT(EV_ABS) },
+	      .absbit	= { BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE) },
+	 },/* A tablet like device with several gradations of pressure */
 
 	{},/* Terminating entry */
 };

