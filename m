Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131079AbRC3Hec>; Fri, 30 Mar 2001 02:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131018AbRC3He0>; Fri, 30 Mar 2001 02:34:26 -0500
Received: from snifit.smb.utfors.se ([195.58.112.20]:18316 "EHLO
	snifit.smb.utfors.se") by vger.kernel.org with ESMTP
	id <S131194AbRC3HeN>; Fri, 30 Mar 2001 02:34:13 -0500
Message-Id: <3.0.1.32.20010330093216.00d97fa0@post.utfors.se>
X-Mailer: Windows Eudora Light Version 3.0.1 (32)
Date: Fri, 30 Mar 2001 09:32:16 +0200
To: linux-kernel@vger.kernel.org
From: Jakob Kemi <jakob.kemi@post.utfors.se>
Subject: [PATCH] New video4linux device driver announcement.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Ok, don't fry me. I'm not sure if this mail reached you some days ago, coz' I wasn't subscribing
to the list back then. I've encountered mailproblems lately with my ISP so I don't trust that my mail
gets through until I actually see them on the list.

I've created a video4linux driver for the Lifeview Flycam Supra Webcam.
It should be pretty common in Sweden at least since it was bundled with an ISP-package.
It uses the Winbond's w9966cf parport Webcam interface chip and the Phillips saa7111 ccd-control chip.
(The w9966cf interface chip can be implemented with other ccd-controller chips but I don't know any other
combination.) My plan is however to support other ccd-controller chips when I've heard of any.

This patch is against linux-2.4.2 and have been tested on a couple of computer systems (one SMP) without
any problems.

I would appreciate if anyone could give me input on it. It would be nice if it could make it to the kernel
sourcetree

/Jakob

---- PATCH BEGIN ----

diff -urN -X dontdiff linux-vanilla/Documentation/Configure.help linux-2.4.2/Documentation/Configure.help
--- linux-vanilla/Documentation/Configure.help	Thu Feb 22 20:24:07 2001
+++ linux-2.4.2/Documentation/Configure.help	Tue Mar 27 00:49:21 2001
@@ -16322,6 +16322,23 @@
   monochrome Quickcam, Quickcam VC or QuickClip. It is also available
   as a module (c-qcam.o). Read Documentation/video4linux/CQcam.txt for
   more information.
+  
+Winbond W9966CF Webcam Video For Linux
+CONFIG_VIDEO_W9966
+  Video4linux driver for Winbond's w9966 based Webcams.
+  Currently tested with the LifeView FlyCam Supra.
+  If you have one of these cameras, say Y here
+  otherwise say N.
+  This driver is also available as a module (w9966.o)
+  
+  Checkout Documentation/video4linux/w9966.txt and w9966.c
+  for more information.
+CONFIG_VIDEO_W9966_RGB
+  Some programs might have problems with 16bit YUV422 data.
+  Use this option to allow 24bit RGB capturing.
+  
+  If this option is set and w9966 is built as a module
+  you have the option to override it with module option rgb=0
 
 CPiA Video For Linux
 CONFIG_VIDEO_CPIA
diff -urN -X dontdiff linux-vanilla/Documentation/video4linux/w9966.txt linux-2.4.2/Documentation/video4linux/w9966.txt
--- linux-vanilla/Documentation/video4linux/w9966.txt	Thu Jan  1 01:00:00 1970
+++ linux-2.4.2/Documentation/video4linux/w9966.txt	Tue Mar 27 01:02:00 2001
@@ -0,0 +1,37 @@
+
+W9966 Camera driver, written by Jakob Kemi (jakob.kemi@post.utfors.se)
+
+Ok, after a lot of work in softice, wdasm, reading pdf-files
+and trial-and-error work I've finally got everything to work.
+Since I needed some vision for a robotics project I borrowed
+this camera from a friend and started hacking. Anyway I've
+converted my original code from the AVR 8bit RISC C/asm
+into a working linux driver. I would really appreciate _any_
+kind of feedback regarding this driver.
+
+To get it working quickly configure your kernel
+to support parport, ieee1284, video4linux, experimental drivers
+and w9966
+
+If w9966 is statically linked it will perform aggressive probing
+for the camera. If built as a module you have more configuration options.
+
+Options:
+modprobe w9966.o pardev=parport0(or whatever) parmode=0 rgb=1(or 0 if
+ your programs can handle 16bit yuv422, which is faster)
+ 
+voila!
+
+you can also type 'modinfo -p w9966.o' for option usage
+(or checkout w9966.c)
+
+I've only tested it with custom built testprograms and with gqcam.
+(you'll need to change the w9966_v4l_ioctl function to report max
+dimensions of 200x200 for gqcam to work)
+
+The slow framerate is due to missing DMA ECP read support in the 
+parport drivers. I might add EPP support later.
+
+Good luck!
+
+    /Jakob
diff -urN -X dontdiff linux-vanilla/drivers/media/video/Config.in linux-2.4.2/drivers/media/video/Config.in
--- linux-vanilla/drivers/media/video/Config.in	Thu Feb 22 20:24:14 2001
+++ linux-2.4.2/drivers/media/video/Config.in	Tue Mar 27 00:20:52 2001
@@ -21,6 +21,17 @@
       dep_tristate '  QuickCam Colour Video For Linux (EXPERIMENTAL)' CONFIG_VIDEO_CQCAM $CONFIG_VIDEO_DEV $CONFIG_PARPORT
    fi
 fi
+if [ "$CONFIG_PARPORT" != "n" ]; then
+   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+      if [ "$CONFIG_PARPORT_1284" != "n" ]; then
+         dep_tristate '  Winbond W9966CF Webcam Video For Linux (EXPERIMENTAL)' CONFIG_VIDEO_W9966 $CONFIG_VIDEO_DEV $CONFIG_PARPORT
+      fi
+      if [ "$CONFIG_VIDEO_W9966" != "n" ]; then
+         bool '    Enable 24bit RGB support for w9966cf' CONFIG_VIDEO_W9966_RGB
+      fi
+            
+   fi
+fi
 dep_tristate '  CPiA Video For Linux' CONFIG_VIDEO_CPIA $CONFIG_VIDEO_DEV
 if [ "$CONFIG_VIDEO_CPIA" != "n" ]; then
   if [ "$CONFIG_PARPORT_1284" != "n" ]; then
diff -urN -X dontdiff linux-vanilla/drivers/media/video/Makefile linux-2.4.2/drivers/media/video/Makefile
--- linux-vanilla/drivers/media/video/Makefile	Tue Jan  9 19:34:15 2001
+++ linux-2.4.2/drivers/media/video/Makefile	Mon Mar 26 21:10:06 2001
@@ -43,6 +43,7 @@
 obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o i2c-old.o
 obj-$(CONFIG_VIDEO_CQCAM) += c-qcam.o
 obj-$(CONFIG_VIDEO_BWQCAM) += bw-qcam.o
+obj-$(CONFIG_VIDEO_W9966) += w9966.o
 obj-$(CONFIG_VIDEO_ZORAN) += buz.o i2c-old.o saa7110.o saa7111.o saa7185.o 
 obj-$(CONFIG_VIDEO_LML33) += bt856.o bt819.o
 obj-$(CONFIG_VIDEO_PMS) += pms.o
diff -urN -X dontdiff linux-vanilla/drivers/media/video/w9966.c linux-2.4.2/drivers/media/video/w9966.c
--- linux-vanilla/drivers/media/video/w9966.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.2/drivers/media/video/w9966.c	Tue Mar 27 18:31:39 2001
@@ -0,0 +1,1063 @@
+/*
+	Winbond w9966cf Webcam parport driver.
+
+	Version 0.3
+
+	Copyright (C) 2001 Jakob Kemi <jakob.kemi@post.utfors.se>
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+/*
+	Supported devices:
+	*Lifeview FlyCam Supra (using the Phillips saa7111a chip)
+
+	Does it exists any other model using the w9966 interface chip??
+
+	Todo:
+	
+	*Add a working EPP mode, since DMA ECP read isn't implemented
+	in the parport drivers. (That's why it's so sloow)
+
+	*Add working hue, color and brightness. This should be an
+	easy one since it's well documented in the saa7111 pdf-file.
+
+	*Add support for other ccd-control chips than the saa7111
+	please send me feedback on what kind of chips you have.
+
+	*Add proper probing. I don't know what's wrong with the IEEE1284
+	parport drivers but (IEEE1284_MODE_NIBBLE|IEEE1284_DEVICE_ID)
+	and nibble read seems to be broken for some peripherals.
+
+	*Add probing for onboard SRAM, port directions etc. (if possible)
+
+	*Add support for the hardware compressed modes (maybe using v4l2)
+
+	*Fix better support for the capture window (no skewed images, v4l
+	interface to capt. window)
+
+	*Probably some bugs that I don't know of
+
+	Please support me by sending feedback!
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/videodev.h>
+#include <linux/parport.h>
+
+//#define DEBUG				// Undef me for production
+
+#ifdef DEBUG
+#define DPRINTF(x, a...) printk(KERN_DEBUG "W9966: "__FUNCTION__ "(): "x, ##a)
+#else
+#define DPRINTF(x...)
+#endif
+
+/*
+ *	Defines, simple typedefs etc.
+ */
+
+#define W9966_DRIVERNAME	"W9966CF Webcam"
+#define W9966_MAXCAMS		4	// Maximum number of cameras
+#define W9966_RBUFFER		2048	// Read buffer (must be an even number)
+#define W9966_SRAMSIZE		131072	// 128kb
+#define W9966_SRAMID		0x02	// check w9966cf.pdf
+
+// Empirically determined window limits
+#define W9966_WND_MIN_X		16
+#define W9966_WND_MIN_Y		14
+#define W9966_WND_MAX_X		705
+#define W9966_WND_MAX_Y		253
+#define W9966_WND_MAX_W		(W9966_WND_MAX_X - W9966_WND_MIN_X)
+#define W9966_WND_MAX_H		(W9966_WND_MAX_Y - W9966_WND_MIN_Y)
+
+// Keep track of our current state
+#define W9966_STATE_PDEV	0x01
+#define W9966_STATE_CLAIMED	0x02
+#define W9966_STATE_VDEV	0x04
+
+#define W9966_I2C_W_ID		0x48
+#define W9966_I2C_R_ID		0x49
+#define W9966_I2C_R_DATA	0x08
+#define W9966_I2C_R_CLOCK	0x04
+#define W9966_I2C_W_DATA	0x02
+#define W9966_I2C_W_CLOCK	0x01
+
+struct w9966_dev {
+	unsigned char dev_state;
+	unsigned char i2c_state;
+	unsigned short ppmode;
+	struct parport* pport;
+	struct pardevice* pdev;
+	struct video_device vdev;
+	unsigned short width;
+	unsigned short height;
+// Currently inimplemented
+//	unsigned char brightness;
+//	unsigned char contrast;
+};
+
+/*
+ *	Module specific properties
+ */
+
+MODULE_AUTHOR("Jakob Kemi <jakob.kemi@post.utfors.se>");
+MODULE_DESCRIPTION("Winbond w9966cf WebCam driver");
+
+#ifdef MODULE
+static const char* pardev[] = {[0 ... W9966_MAXCAMS] = ""};
+#else
+static const char* pardev[] = {[0 ... W9966_MAXCAMS] = "aggressive"};
+#endif
+MODULE_PARM(pardev, "1-" __MODULE_STRING(W9966_MAXCAMS) "s");
+MODULE_PARM_DESC(pardev, "pardev: where to search for\n\
+\teach camera. 'aggressive' means brute-force search.\n\
+\tEg: >pardev=parport3,aggressive,parport2,parport1< would assign
+\tcam 1 to parport3 and search every parport for cam 2 etc...");
+
+static int parmode = 0;
+MODULE_PARM(parmode, "i");
+MODULE_PARM_DESC(parmode, "parmode: transfer mode (0=auto, 1=ecp, 2=epp");
+
+#ifdef CONFIG_VIDEO_W9966_RGB
+static int rgb = 1;
+MODULE_PARM(rgb, "i");
+MODULE_PARM_DESC(rgb, "rgb: software convert 16b YUV to 24b RGB (0=off,1=on)");
+#endif
+
+
+/*
+ *	Private data
+ */
+
+static struct w9966_dev w9966_cams[W9966_MAXCAMS];
+
+/*
+ *	Private function declares
+ */
+
+static inline void w9966_setState(struct w9966_dev* cam, int mask, int val);
+static inline int  w9966_getState(struct w9966_dev* cam, int mask, int val);
+static inline void w9966_pdev_claim(struct w9966_dev *vdev);
+static inline void w9966_pdev_release(struct w9966_dev *vdev);
+
+static int w9966_rReg(struct w9966_dev* cam, int reg);
+static int w9966_wReg(struct w9966_dev* cam, int reg, int data);
+static int w9966_rReg_i2c(struct w9966_dev* cam, int reg);
+static int w9966_wReg_i2c(struct w9966_dev* cam, int reg, int data);
+static int w9966_findlen(int near, int size, int maxlen)
;
+static int w9966_calcscale(int size, int min, int max, int* beg, int* end, unsigned char* factor)
;
+static int w9966_setup(struct w9966_dev* cam, int x1, int y1, int x2, int y2, int w, int h);
+
+static int  w9966_init(struct w9966_dev* cam, struct parport* port);
+static void w9966_term(struct w9966_dev* cam);
+
+static inline void w9966_i2c_setsda(struct w9966_dev* cam, int state);
+static inline void w9966_i2c_setscl(struct w9966_dev* cam, int state);
+static inline int  w9966_i2c_getsda(struct w9966_dev* cam);
+static inline int  w9966_i2c_getscl(struct w9966_dev* cam);
+static int w9966_i2c_wbyte(struct w9966_dev* cam, int data);
+static int w9966_i2c_rbyte(struct w9966_dev* cam);
+
+static int  w9966_v4l_open(struct video_device *vdev, int mode);
+static void w9966_v4l_close(struct video_device *vdev);
+static int  w9966_v4l_ioctl(struct video_device *vdev, unsigned int cmd, void *arg);
+static long w9966_v4l_read(struct video_device *vdev, char *buf, unsigned long count, int noblock);
+#ifdef CONFIG_VIDEO_W9966_RGB	
+static long w9966_v4l_read_rgb(struct video_device *vdev, char *buf, unsigned long count, int noblock);
+#endif
+
+/*
+ *	Private function defines
+ */
+
+
+// Set camera phase flags, so we know what to uninit when terminating 
+static inline void w9966_setState(struct w9966_dev* cam, int mask, int val)
+{
+	cam->dev_state = (cam->dev_state & ~mask) ^ val;
+}
+
+// Get camera phase flags
+static inline int w9966_getState(struct w9966_dev* cam, int mask, int val)
+{
+	return ((cam->dev_state & mask) == val);
+}
+
+// Claim parport for ourself
+static inline void w9966_pdev_claim(struct w9966_dev* cam)
+{
+	if (w9966_getState(cam, W9966_STATE_CLAIMED, W9966_STATE_CLAIMED))
+		return;
+	parport_claim_or_block(cam->pdev);
+	w9966_setState(cam, W9966_STATE_CLAIMED, W9966_STATE_CLAIMED);
+}
+
+// Release parport for others to use
+static inline void w9966_pdev_release(struct w9966_dev* cam)
+{
+	if (w9966_getState(cam, W9966_STATE_CLAIMED, 0))
+		return;
+	parport_release(cam->pdev);
+	w9966_setState(cam, W9966_STATE_CLAIMED, 0);
+}
+ 
+// Read register from W9966 interface-chip
+// Expects a claimed pdev
+// -1 on error, else register data (byte)
+static int w9966_rReg(struct w9966_dev* cam, int reg)
+{
+	// ECP, read, regtransfer, REG, REG, REG, REG, REG
+	const unsigned char addr = 0x80 | (reg & 0x1f);
+	unsigned char val;
+	
+	if (parport_negotiate(cam->pport, cam->ppmode | IEEE1284_ADDR) != 0)
+		return -1;
+	if (parport_write(cam->pport, &addr, 1) != 1)
+		return -1;
+	if (parport_negotiate(cam->pport, cam->ppmode | IEEE1284_DATA) != 0)
+		return -1;
+	if (parport_read(cam->pport, &val, 1) != 1)
+		return -1;
+
+	return val;
+}
+
+// Write register to W9966 interface-chip
+// Expects a claimed pdev
+// -1 on error
+static int w9966_wReg(struct w9966_dev* cam, int reg, int data)
+{
+	// ECP, write, regtransfer, REG, REG, REG, REG, REG
+	const unsigned char addr = 0xc0 | (reg & 0x1f);
+	const unsigned char val = data;
+	
+	if (parport_negotiate(cam->pport, cam->ppmode | IEEE1284_ADDR) != 0)
+		return -1;
+	if (parport_write(cam->pport, &addr, 1) != 1)
+		return -1;
+	if (parport_negotiate(cam->pport, cam->ppmode | IEEE1284_DATA) != 0)
+		return -1;
+	if (parport_write(cam->pport, &val, 1) != 1)
+		return -1;
+
+	return 0;
+}
+
+// Initialize camera device. Setup all internal flags, set a
+// default video mode, setup ccd-chip, register v4l device etc..
+// Also used for 'probing' of hardware.
+// -1 on error
+static int w9966_init(struct w9966_dev* cam, struct parport* port)
+{
+	if (cam->dev_state != 0)
+		return -1;
+	
+	cam->pport = port;
+
+// Select requested transfer mode
+	switch(parmode)
+	{
+	default:	// Auto-detect (priority: hw-ecp, hw-epp, sw-ecp)
+	case 0:
+		if (port->modes & PARPORT_MODE_ECP)
+			cam->ppmode = IEEE1284_MODE_ECP;
+		else if (port->modes & PARPORT_MODE_EPP)
+			cam->ppmode = IEEE1284_MODE_EPP;
+		else
+			cam->ppmode = IEEE1284_MODE_ECP;
+		break;	
+	case 1:		// hw- or sw-ecp
+		cam->ppmode = IEEE1284_MODE_ECP;
+		break;
+	case 2:		// hw- or sw-epp
+		cam->ppmode = IEEE1284_MODE_EPP;
+	break;
+	}
+	
+// Tell the parport driver that we exists
+	cam->pdev = parport_register_device(port, "w9966", NULL, NULL, NULL, 0, NULL);
+	if (cam->pdev == NULL) {
+		DPRINTF("parport_register_device() failed\n");
+		return -1;
+	}
+	w9966_setState(cam, W9966_STATE_PDEV, W9966_STATE_PDEV);
+
+	w9966_pdev_claim(cam);
+	
+// Setup a default capture mode
+	if (w9966_setup(cam, 0, 0, 1023, 1023, 200, 160) != 0) {
+		DPRINTF("w9966_setup() failed.\n");
+		return -1;
+	}
+
+	w9966_pdev_release(cam);
+
+// Fill in the video_device struct and register us to v4l
+	memset(&cam->vdev, 0, sizeof(struct video_device));
+	strcpy(cam->vdev.name, W9966_DRIVERNAME);
+	cam->vdev.type = VID_TYPE_CAPTURE | VID_TYPE_SCALES;
+	cam->vdev.hardware = VID_HARDWARE_W9966;
+	cam->vdev.open = &w9966_v4l_open;
+	cam->vdev.close = &w9966_v4l_close;
+	cam->vdev.read = &w9966_v4l_read;
+	cam->vdev.ioctl = &w9966_v4l_ioctl;
+	cam->vdev.priv = (void*)cam;
+
+#ifdef CONFIG_VIDEO_W9966_RGB	
+	if (rgb == 1)
+		cam->vdev.read = &w9966_v4l_read_rgb;
+#endif
+	
+	if (video_register_device(&cam->vdev, VFL_TYPE_GRABBER) == -1)		 
+		return -1;
+	
+	w9966_setState(cam, W9966_STATE_VDEV, W9966_STATE_VDEV);
+	
+	// All ok
+	printk(
+		"w9966cf: Found and initialized a webcam on %s.\n",
+		cam->pport->name
+	);
+	return 0;
+}
+
+
+// Terminate everything gracefully
+static void w9966_term(struct w9966_dev* cam)
+{
+// Unregister from v4l
+	if (w9966_getState(cam, W9966_STATE_VDEV, W9966_STATE_VDEV)) {
+		video_unregister_device(&cam->vdev);
+		w9966_setState(cam, W9966_STATE_VDEV, 0);
+	}
+
+// Terminate from IEEE1284 mode and release pdev block
+	if (w9966_getState(cam, W9966_STATE_PDEV, W9966_STATE_PDEV)) {
+		w9966_pdev_claim(cam);
+		parport_negotiate(cam->pport, IEEE1284_MODE_COMPAT);
+		w9966_pdev_release(cam);
+	}
+
+// Unregister from parport
+	if (w9966_getState(cam, W9966_STATE_PDEV, W9966_STATE_PDEV)) {
+		parport_unregister_device(cam->pdev);
+		w9966_setState(cam, W9966_STATE_PDEV, 0);
+	}
+}
+
+
+// Find a good length
 for capture window (used both for W and H)
+// A bit ugly but pretty functional. The capture length
+// have to match the downscale
+static int w9966_findlen(int near, int size, int maxlen)
+{
+	int bestlen = size;
+	int besterr = abs(near - bestlen);
+	int len;
+
+	for(len = size+1;len < maxlen;len++)
+	{
+		int err;
+		if ( ((64*size) %len) != 0)
+			continue;
+
+		err = abs(near - len);
+
+		// Only continue as long as we keep getting better values
+		if (err > besterr)
+			break;
+		
+		besterr = err;
+		bestlen = len;
+	}
+
+	return bestlen;
+}
+
+// Modify capture window (if necessary) 
+// and calculate downscaling
+// Return -1 on error
+static int w9966_calcscale(int size, int min, int max, int* beg, int* end, unsigned char* factor)
+{
+	int maxlen = max - min;
+	int len = *end - *beg + 1;
+	int newlen = w9966_findlen(len, size, maxlen);
+	int err = newlen - len; 
+
+	// Check for bad format
+	if (newlen > maxlen || newlen < size)
+		return -1;
+
+	// Set factor (6 bit fixed)
+	*factor = (64*size) / newlen;
+	if (*factor == 64)
+		*factor = 0x00;
	// downscale is disabled
+	else
+		*factor |= 0x80;
// set downscale-enable bit
+
+	// Modify old beginning and end
+	*beg -= err / 2;
+	*end += err - (err / 2);
+
+	// Move window if outside borders
+	if (*beg < min)
 {
+		*end += min - *beg;
+		*beg += min - *beg;
+	}
+
	if (*end > max)
 {
+		*beg -= *end - max;
+		*end -= *end - max;
+	}
+
+	return 0;
+}
+
+// Setup the cameras capture window etc.
+// Expects a claimed pdev
+// return -1 on error
+static int w9966_setup(struct w9966_dev* cam, int x1, int y1, int x2, int y2, int w, int h)
+{
+	unsigned int i;
+	unsigned int enh_s, enh_e;
+	unsigned char scale_x, scale_y;
+	unsigned char regs[0x1c];
+	unsigned char saa7111_regs[] = {
+		0x21, 0x00, 0xd8, 0x23, 0x00, 0x80, 0x80, 0x00,
+		0x88, 0x10, 0x80, 0x40, 0x40, 0x00, 0x01, 0x00,
+		0x48, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x71, 0xe7, 0x00, 0x00, 0xc0
+	};
+	
+	
+	if (w*h*2 > W9966_SRAMSIZE)
+	{
+		DPRINTF("capture window exceeds SRAM size!.\n");
+		w = 200; h = 160;	// Pick default values
+	}
+
+	if (w < 2) w = 2;
+	if (h < 1) h = 1;
+	if (w > W9966_WND_MAX_W) w = W9966_WND_MAX_W;
+	if (h > W9966_WND_MAX_H) h = W9966_WND_MAX_H;
+
+	cam->width = w;
+	cam->height = h;
+	
+	enh_s = 0;
+	enh_e = w*h*2;
+	
+// Modify capture window if necessary and calculate downscaling
+	if (
+		w9966_calcscale(w, W9966_WND_MIN_X, W9966_WND_MAX_X, &x1, &x2, &scale_x) != 0 ||
+		w9966_calcscale(h, W9966_WND_MIN_Y, W9966_WND_MAX_Y, &y1, &y2, &scale_y)
 != 0
+	) return -1;
+
+	DPRINTF(
+		"%dx%d, x: %d<->%d, y: %d<->%d, sx: %d/64, sy: %d/64.\n",
+		w, h, x1, x2, y1, y2, scale_x&~0x80, scale_y&~0x80
+	);
+	
+// Setup registers
+	regs[0x00] = 0x00;			// Set normal operation
+	regs[0x01] = 0x18;			// Capture mode
+	regs[0x02] = scale_y;			// V-scaling
+	regs[0x03] = scale_x;			// H-scaling
+	
+	// Capture window	
+	regs[0x04] = (x1 & 0x0ff);		// X-start (8 low bits)
+	regs[0x05] = (x1 & 0x300)>>8;		// X-start (2 high bits)
+	regs[0x06] = (y1 & 0x0ff);		// Y-start (8 low bits)
+	regs[0x07] = (y1 & 0x300)>>8;		// Y-start (2 high bits)
+	regs[0x08] = (x2 & 0x0ff);		// X-end (8 low bits)
+	regs[0x09] = (x2 & 0x300)>>8;		// X-end (2 high bits)
+	regs[0x0a] = (y2 & 0x0ff);		// Y-end (8 low bits)
+
+	regs[0x0c] = W9966_SRAMID;		// SRAM-banks (1x 128kb)
+	
+	// Enhancement layer
+	regs[0x0d] = (enh_s& 0x000ff);		// Enh. start (0-7)
+	regs[0x0e] = (enh_s& 0x0ff00)>>8;	// Enh. start (8-15)
+	regs[0x0f] = (enh_s& 0x70000)>>16;	// Enh. start (16-17/18??)
+	regs[0x10] = (enh_e& 0x000ff);		// Enh. end (0-7)
+	regs[0x11] = (enh_e& 0x0ff00)>>8;	// Enh. end (8-15)
+	regs[0x12] = (enh_e& 0x70000)>>16;	// Enh. end (16-17/18??)
+
+	// Misc
+	regs[0x13] = 0x40;			// VEE control (raw 4:2:2)
+	regs[0x17] = 0x00;			// ???
+	regs[0x18] = cam->i2c_state = 0x00;	// Serial bus
+	regs[0x19] = 0xff;			// I/O port direction control
+	regs[0x1a] = 0xff;			// I/O port data register
+	regs[0x1b] = 0x10;			// ???
+
+// Reset (ECP-fifo & serial-bus)
+	if (w9966_wReg(cam, 0x00, 0x03) == -1)
+		return -1;
+
+// Write regs to w9966cf chip
+	for (i = 0; i < 0x1c; i++)
+		if (w9966_wReg(cam, i, regs[i]) == -1)
+			return -1;
+
+// Write regs to saa7111 chip
+	for (i = 0; i < 0x20; i++)
+		if (w9966_wReg_i2c(cam, i, saa7111_regs[i]) == -1)
+			return -1;
+
+	return 0;
+}
+
+/*
+ *	Ugly and primitive i2c protocol functions
+ */
+
+// Sets the data line on the i2c bus.
+// Expects a claimed pdev. Add error checking??
+static inline void w9966_i2c_setsda(struct w9966_dev* cam, int state)
+{
+	if (state)
+		cam->i2c_state |= W9966_I2C_W_DATA;
+	else
+		cam->i2c_state &= ~W9966_I2C_W_DATA;
+	
+	w9966_wReg(cam, 0x18, cam->i2c_state);
+	udelay(5);
+}
+
+// Sets the clock line on the i2c bus.
+// Expects a claimed pdev. Add error checking??
+static inline void w9966_i2c_setscl(struct w9966_dev* cam, int state)
+{
+	if (state)
+		cam->i2c_state |= W9966_I2C_W_CLOCK;
+	else
+		cam->i2c_state &= ~W9966_I2C_W_CLOCK;
+
+	w9966_wReg(cam, 0x18, cam->i2c_state);
+	udelay(5);
+	
+	// we go to high, we also expect the peripheral to ack.
+	// maybe we should add a timeout
+	if (state)
+		while (!w9966_i2c_getscl(cam))
{
}
+}
+
+// Get peripheral data line
+// Expects a claimed pdev. Maybe we should add error checking.
+static inline int w9966_i2c_getsda(struct w9966_dev* cam)
+{
+	const unsigned char state = w9966_rReg(cam, 0x18);
+	return ((state & W9966_I2C_R_DATA) > 0);
+}
+
+// Get peripheral clock line
+// Expects a claimed pdev. Maybe we should add error checking.
+static inline int w9966_i2c_getscl(struct w9966_dev* cam)
+{
+	const unsigned char state = w9966_rReg(cam, 0x18);
+	return ((state & W9966_I2C_R_CLOCK) > 0);
+}
+
+// Write a byte with ack on the i2c bus. Good for both
+// addresses and data. Expects a claimed pdev.
+// Maybe we should add error checking.
+static int w9966_i2c_wbyte(struct w9966_dev* cam, int data)
+{
+	int i;
+	for (i = 7; i >= 0; i--)
+	{
+		w9966_i2c_setsda(cam, (data >> i) & 0x01);
+
+		w9966_i2c_setscl(cam, 1);
+		w9966_i2c_setscl(cam, 0);
+	}
+
+	w9966_i2c_setsda(cam, 1);
+	w9966_i2c_setscl(cam, 1);
+
+	w9966_i2c_setscl(cam, 0);
+	return 0;
+}
+
+// Read a data byte with ack from the i2c-bus
+// Expects a claimed pdev. Maybe we should add error checking.
+static int w9966_i2c_rbyte(struct w9966_dev* cam)
+{
+	unsigned char data = 0x00;
+	int i;	
+	
+	w9966_i2c_setsda(cam, 1);
+
+	for (i = 0; i < 8; i++)
+	{
+		w9966_i2c_setscl(cam, 1);
+	
	data = data << 1;
+		if (w9966_i2c_getsda(cam))
+			data |= 0x01;
+		
+	
	w9966_i2c_setscl(cam, 0);
+	}
+	return data;
+}
+
+// Read a register from the i2c device.
+// Expects claimed pdev. Ignores errors for now.
+static int w9966_rReg_i2c(struct w9966_dev* cam, int reg)
+{
+	unsigned char data;
+
+	w9966_i2c_setsda(cam, 0);
+	w9966_i2c_setscl(cam, 0);
+
+	w9966_i2c_wbyte(cam, W9966_I2C_W_ID);
+
+	w9966_i2c_wbyte(cam, reg);
+
+	w9966_i2c_setsda(cam, 1);
+	w9966_i2c_setscl(cam, 1);
+	w9966_i2c_setsda(cam, 0);
+	w9966_i2c_setscl(cam, 0);
+
+	w9966_i2c_wbyte(cam, W9966_I2C_R_ID);
+
+	data = w9966_i2c_rbyte(cam);
+
+	w9966_i2c_setsda(cam, 0);
+	w9966_i2c_setscl(cam, 1); 
+	w9966_i2c_setsda(cam, 1);
+	
+	
return data;
+}
+
+// Write a register from the i2c device.
+// Expects claimed pdev. Ignores errors for now.
+static int w9966_wReg_i2c(struct w9966_dev* cam, int reg, int data)
+{
+	w9966_i2c_setsda(cam, 0);
+	w9966_i2c_setscl(cam, 0);
+
+	w9966_i2c_wbyte(cam, W9966_I2C_W_ID);
+
+	w9966_i2c_wbyte(cam, reg);
+
+	w9966_i2c_wbyte(cam, data);
+
+	w9966_i2c_setsda(cam, 0);
+	w9966_i2c_setscl(cam, 1);
+	w9966_i2c_setsda(cam, 1);
+
+	return 0;
+}
+
+/*
+ *	Video4linux interfacing
+ */
+
+static int w9966_v4l_open(struct video_device *vdev, int flags)
+{
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+
+static void w9966_v4l_close(struct video_device *vdev)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+static int w9966_v4l_ioctl(struct video_device *vdev, unsigned int cmd, void *arg)
+{
+	struct w9966_dev *cam = (struct w9966_dev*)vdev->priv;
+	
+	switch(cmd)
+	{
+	case VIDIOCGCAP:
+	{
+		struct video_capability vcap = {
+			W9966_DRIVERNAME,	// name
+			VID_TYPE_CAPTURE | VID_TYPE_SCALES,	// type
+			1, 0,			// vid, aud channels
+			W9966_WND_MAX_W,	// max w
+			W9966_WND_MAX_H,	// max h
+			2, 1			// min w, min h
+		};
+
+		if(copy_to_user(arg, &vcap, sizeof(vcap)) != 0)
+			return -EFAULT;
+
+		return 0;
+	}
+	case VIDIOCGCHAN:
+	{
+		struct video_channel vch;
+		if(copy_from_user(&vch, arg, sizeof(vch)) != 0)
+			return -EFAULT;
+
+		if(vch.channel != 0)	// We only support one channel (#0)
+			return -EINVAL;
+
+		strcpy(vch.name, "CCD-input");
+		vch.flags = 0;		// We have no tuner or audio
+		vch.tuners = 0;
+		vch.type = VIDEO_TYPE_CAMERA;
+		vch.norm = 0;		// ???
+		
+		if(copy_to_user(arg, &vch, sizeof(vch)) != 0)
+			return -EFAULT;
+		
+		return 0;
+	}
+	case VIDIOCSCHAN:
+	{
+		struct video_channel vch;
+		if(copy_from_user(&vch, arg, sizeof(vch) ) != 0)
+			return -EFAULT;
+		
+		if(vch.channel != 0)
+			return -EINVAL;
+		
+		return 0;
+	}
+	case VIDIOCGTUNER:
+	{
+		struct video_tuner vtune;
+		if(copy_from_user(&vtune, arg, sizeof(vtune)) != 0)
+			return -EFAULT;
+		
+		if(vtune.tuner != 0);
+			return -EINVAL;
+		
+		strcpy(vtune.name, "Foo-tuner");
+		vtune.rangelow = 0;
+		vtune.rangehigh = 0;
+		vtune.flags = VIDEO_TUNER_NORM;
+		vtune.mode = VIDEO_MODE_AUTO;
+		vtune.signal = 0xffff;
+		
+		if(copy_to_user(arg, &vtune, sizeof(vtune)) != 0)
+			return -EFAULT;
+		
+		return 0;
+	}
+	case VIDIOCSTUNER:
+	{
+		struct video_tuner vtune;
+		if (copy_from_user(&vtune, arg, sizeof(vtune)) != 0)
+			return -EFAULT;
+		
+		if (vtune.tuner != 0)
+			return -EINVAL;
+		
+		if (vtune.mode != VIDEO_MODE_AUTO)
+			return -EINVAL;
+		
+		return 0;
+	}
+	case VIDIOCGPICT:
+	{
+		struct video_picture vpic = {
+			0x8000,			// brightness
+			0x8000,			// hue
+			0x8000,			// color
+			0x8000,			// contrast
+			0x8000,			// whiteness
+			16, VIDEO_PALETTE_YUV422// bpp, palette format
+		};
+
+#ifdef CONFIG_VIDEO_W9966_RGB
+		// Bah! few programs are mature enough to understad YUV422 data
+		if (rgb == 1) {
+			vpic.depth = 24;
+			vpic.palette = VIDEO_PALETTE_RGB24;
+		}
+#endif		
+		if(copy_to_user(arg, &vpic, sizeof(vpic)) != 0)
+			return -EFAULT;
+
+		return 0;
+	}
+	case VIDIOCSPICT:
+	{
+		struct video_picture vpic;
+		if(copy_from_user(&vpic, arg, sizeof(vpic)) != 0)
+			return -EFAULT;
+		
+		if (vpic.depth != 16 || vpic.palette != VIDEO_PALETTE_YUV422)
+			return -EINVAL;
+
+		// Just ignore any parameters (hue, color etc..) for now
+		return 0;
+	}
+	case VIDIOCSWIN:
+	{
+		int ret;
+		struct video_window vwin;
+		
+		if (copy_from_user(&vwin, arg, sizeof(vwin)) != 0)
+			return -EFAULT;		
+		if (vwin.flags != 0)
+			return -EINVAL;
+		if (vwin.clipcount != 0)
+			return -EINVAL;
+		if (vwin.width < 2 || vwin.width > W9966_WND_MAX_W)
+			return -EINVAL;		
+		if (vwin.height < 1 || vwin.height > W9966_WND_MAX_H)
+			return -EINVAL;
+
+		// Update camera regs
+		w9966_pdev_claim(cam);
+		ret = w9966_setup(cam, 0, 0, 1023, 1023, vwin.width, vwin.height);
+		w9966_pdev_release(cam);
+		
+		if (ret != 0) {
+			DPRINTF("VIDIOCSWIN: w9966_setup() failed.\n");
+			return -EFAULT;
+		}
+		
+		return 0;
+	}
+	case VIDIOCGWIN:
+	{
+		struct video_window vwin;
+		memset(&vwin, 0, sizeof(vwin));
+		
+		vwin.width = cam->width;
+		vwin.height = cam->height;
+		
+		if(copy_to_user(arg, &vwin, sizeof(vwin)) != 0)
+			return -EFAULT;
+		
+		return 0;
+	}
+	// Unimplemented
+	case VIDIOCCAPTURE:	
+	case VIDIOCGFBUF:
+	case VIDIOCSFBUF:
+	case VIDIOCKEY:
+	case VIDIOCGFREQ:
+	case VIDIOCSFREQ:
+	case VIDIOCGAUDIO:
+	case VIDIOCSAUDIO:
+	return -EINVAL;
+	default:
+	return -ENOIOCTLCMD;	
+	}
+	return 0;
+}
+
+// Capture and read data in normal 16bit YUV422 format
+static long w9966_v4l_read(struct video_device *vdev, char *buf, unsigned long count,  int noblock)
+{
+	struct w9966_dev *cam = (struct w9966_dev *)vdev->priv;
+	unsigned char addr = 0xa0;	// ECP, read, CCD-transfer, 00000
+	unsigned char* dest = (unsigned char*)buf;
+	unsigned long dleft = count;
+	
+	// Why would anyone want more than this??
+	if (count > cam->width * cam->height * 2)
+		DPRINTF("Requested %lu bytes, full frame is %d bytes.\n", count, cam->width*cam->height*2);
+	
+	w9966_pdev_claim(cam);
+	w9966_wReg(cam, 0x00, 0x02);	// Reset ECP-FIFO buffer
+	w9966_wReg(cam, 0x00, 0x00);	// Return to normal operation
+	w9966_wReg(cam, 0x01, 0x98);	// Enable capture
+
+	// write special capture-addr and negotiate into data transfer	
+	if (
+		(parport_negotiate(cam->pport, cam->ppmode|IEEE1284_ADDR) != 0	)||
+		(parport_write(cam->pport, &addr, 1) != 1						)||
+		(parport_negotiate(cam->pport, cam->ppmode|IEEE1284_DATA) != 0	)
+	) {
+		w9966_pdev_release(cam);
+		return -EFAULT;
+	}
+	
+	while(dleft > 0)
+	{
+		unsigned long tsize = (dleft > W9966_RBUFFER) ? W9966_RBUFFER : dleft;
+		unsigned char tbuf[W9966_RBUFFER];
+	
+		if (parport_read(cam->pport, tbuf, tsize) < tsize) {
+			w9966_pdev_release(cam);
+			return -EFAULT;
+		}
+		if (copy_to_user(dest, tbuf, tsize) != 0) {
+			w9966_pdev_release(cam);
+			return -EFAULT;
+		}
+		dest += tsize;
+		dleft -= tsize;
+	}
+	
+	w9966_wReg(cam, 0x01, 0x18);	// Disable capture
+	w9966_pdev_release(cam);
+
+	return count;
+}
+
+#ifdef CONFIG_VIDEO_W9966_RGB
+// Clamp value to 0 <-> 255
, I guess this is a slow method...
+// tell me of a better one
+// This is only used for the rgb mode
+inline unsigned char _bClamp(const int x)
+{
+	if (x > 255)
+		return 255;
+	if (x < 0)
+		return 0;
+
+	return x;
+}
+
+// Convert a YUV color to RGB
+// This _really_ has nothing to do in a kernel module
+// This is only used by the rgb mode
+inline void _yuv2rgb(unsigned char* rgb, const int y, const int u, const int v)
+{
+//	PAL color conversion (Y, Cr(U) & Cb(V) is in the range 0 - 255)
+//	B = 1.164(Y - 16)                   + 2.018(Cb - 128)
+//	G = 1.164(Y - 16) - 0.813(Cr - 128) - 0.391(Cb - 128)
+//	R = 1.164(Y - 16) + 1.596(Cr - 128)
+
+	*rgb++ = _bClamp( (298*(y-16) + 517*(v-128)              ) >>8 );
+	*rgb++ = _bClamp( (298*(y-16) - 208*(u-128) - 100*(v-128)) >>8 );
+	*rgb   = _bClamp( (298*(y-16) + 409*(u-128)              ) >>8 );
+}
+
+
+// Well since most apps doesn't understand YUV422 we also allow RGB capture
+static long w9966_v4l_read_rgb(struct video_device *vdev, char *buf, unsigned long count,  int noblock)
+{
+	struct w9966_dev *cam = (struct w9966_dev *)vdev->priv;
+	unsigned char addr = 0xa0;	// ECP, read, CCD-transfer, 00000
+	unsigned char* dest = (unsigned char*)buf;
+	unsigned long dleft = (count*2)/3;
+	
+	// Why would anyone want more than this??
+	if (count > cam->width * cam->height * 3)
+		DPRINTF("Requested %lu bytes, full frame is %d bytes.\n", count, cam->width*cam->height*3);
+	
+	w9966_pdev_claim(cam);
+	w9966_wReg(cam, 0x00, 0x02);	// Reset ECP-FIFO buffer
+	w9966_wReg(cam, 0x00, 0x00);	// Return to normal operation
+	w9966_wReg(cam, 0x01, 0x98);	// Enable capture
+
+	// write special capture-addr and negotiate into data transfer	
+	if (
+		(parport_negotiate(cam->pport, cam->ppmode|IEEE1284_ADDR) != 0	)||
+		(parport_write(cam->pport, &addr, 1) != 1			)||
+		(parport_negotiate(cam->pport, cam->ppmode|IEEE1284_DATA) != 0	)
+	) {
+		w9966_pdev_release(cam);
+		return -EFAULT;
+	}
+	
+	while(dleft > 0)
+	{
+		unsigned long tsize = (dleft > W9966_RBUFFER) ? W9966_RBUFFER : dleft;
+		unsigned char tbuf[W9966_RBUFFER];
+		unsigned char rgbbuf[(W9966_RBUFFER*3)/2];
+		unsigned char* ibuf;
+		unsigned char* obuf;
+		int i;
+	
+		if (parport_read(cam->pport, tbuf, tsize) < tsize) {
+			w9966_pdev_release(cam);
+			return -EFAULT;
+		}
+	
+		ibuf = tbuf;
+		obuf = rgbbuf;
+		for (i = 0; i < tsize/4; i++)	
+		{
+			_yuv2rgb(obuf, ibuf[0], ibuf[1], ibuf[3]);
+			obuf += 3;
+			_yuv2rgb(obuf, ibuf[2], ibuf[1], ibuf[3]);
+			obuf += 3;
+			
+			ibuf += 4;
+		}
+	
+		if (copy_to_user(dest, rgbbuf, (tsize*3)/2) != 0) {
+			w9966_pdev_release(cam);
+			return -EFAULT;
+		}
+		dest += (tsize*3)/2;
+		dleft -= tsize;
+	}
+	
+	w9966_wReg(cam, 0x01, 0x18);	// Disable capture
+	w9966_pdev_release(cam);
+
+	return count;
+}
+#endif
+
+// Called once for every parport on init
+static void w9966_attach(struct parport *port)
+{
+	int i;
+	
+	for (i = 0; i < W9966_MAXCAMS; i++)
+	{
+		if (w9966_cams[i].dev_state != 0)	// Cam is already assigned
+			continue;
+		if (
+			strcmp(pardev[i], "aggressive") == 0 ||
+			strcmp(pardev[i], port->name) == 0
+		) {
+			if (w9966_init(&w9966_cams[i], port) != 0)
+			w9966_term(&w9966_cams[i]);
+			break;	// return
+		}
+	}
+}
+
+// Called once for every parport on termination
+static void w9966_detach(struct parport *port)
+{
+	int i;
+	for (i = 0; i < W9966_MAXCAMS; i++)
+	if (w9966_cams[i].dev_state != 0 && w9966_cams[i].pport == port)
+		w9966_term(&w9966_cams[i]);
+}
+
+
+static struct parport_driver w9966_ppd = {
+	W9966_DRIVERNAME,
+	w9966_attach,
+	w9966_detach,
+	NULL
+};
+
+// Module entry point
+static int __init w9966_mod_init(void)
+{
+	int i;
+	for (i = 0; i < W9966_MAXCAMS; i++)
+		w9966_cams[i].dev_state = 0;
+
+	return parport_register_driver(&w9966_ppd);
+}
+
+// Module cleanup
+static void __exit w9966_mod_term(void)
+{
+	parport_unregister_driver(&w9966_ppd);
+}
+
+module_init(w9966_mod_init);
+module_exit(w9966_mod_term);
diff -urN -X dontdiff linux-vanilla/include/linux/videodev.h linux-2.4.2/include/linux/videodev.h
--- linux-vanilla/include/linux/videodev.h	Wed Apr 12 18:47:29 2000
+++ linux-2.4.2/include/linux/videodev.h	Tue Mar 27 01:08:49 2001
@@ -374,6 +374,8 @@
 #define VID_HARDWARE_ZR36067	26	/* Zoran ZR36067/36060 */
 #define VID_HARDWARE_OV511	27	
 #define VID_HARDWARE_ZR356700	28	/* Zoran 36700 series */
+#define VID_HARDWARE_W9966	29
+
 
 /*
  *	Initialiser list

---- PATCH END ----

