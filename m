Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSJaPZY>; Thu, 31 Oct 2002 10:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbSJaPZV>; Thu, 31 Oct 2002 10:25:21 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10404 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262528AbSJaPX4>; Thu, 31 Oct 2002 10:23:56 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 31 Oct 2002 17:06:22 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] add v4l2 api
Message-ID: <20021031160622.GA17265@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Linus,

This patch adds the v4l2 API to the linux kernel.

The first, original video4linux API has a number of design bugs.  They
are fixed in this new API revision.  It already exists for quite some
time.  Last weeks it got a number of cleanups based on the experiences
of the last years (drop stuff nobody uses, fix some inconsistencies).
We consider it being in a pretty good shape now and like to see it in
2.6.

This patch is basically the header file with all the structs and ioctls
in there.  A small module with some helper functions for v4l2 drivers is
included too.  Related updates (bttv, ...) will follow as separate
patches.

  Gerd

--- linux-2.5.45/drivers/media/Kconfig	2002-10-31 14:23:20.000000000 +0100
+++ linux/drivers/media/Kconfig	2002-10-31 14:24:49.000000000 +0100
@@ -12,9 +12,14 @@
 	  this are available from
 	  <ftp://ftp.uk.linux.org/pub/linux/video4linux/>.
 
-	  If you are interested in writing a driver for such an audio/video
-	  device or user software interacting with such a driver, please read
-	  the file <file:Documentation/video4linux/API.html>.
+	  This kernel includes support for the new Video for Linux Two API,
+	  (V4L2) as well as the original system. Drivers and applications
+	  need to be rewritten to use V4L2, but drivers for popular cards
+	  and applications for most video capture functions already exist.
+
+	  Documentation for the original API is included in the file
+	  Documentation/video4linux/API.html.  Documentation for V4L2 is
+	  available on the web at http://bytesex.org/v4l/
 
 	  This driver is also available as a module called videodev.o ( = code
 	  which can be inserted in and removed from the running kernel
--- linux-2.5.45/drivers/media/video/Makefile	2002-10-31 14:03:25.000000000 +0100
+++ linux/drivers/media/video/Makefile	2002-10-31 14:19:51.000000000 +0100
@@ -5,13 +5,14 @@
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs     :=	videodev.o bttv-if.o cpia.o video-buf.o
+export-objs     :=	videodev.o v4l2-common.o \
+			bttv-if.o cpia.o video-buf.o
 
 bttv-objs	:=	bttv-driver.o bttv-cards.o bttv-if.o \
 			bttv-risc.o bttv-vbi.o
 zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
 
-obj-$(CONFIG_VIDEO_DEV) += videodev.o
+obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
 	tda7432.o tda9875.o tuner.o video-buf.o
--- linux-2.5.45/drivers/media/video/v4l2-common.c	2002-10-31 14:19:51.000000000 +0100
+++ linux/drivers/media/video/v4l2-common.c	2002-10-31 14:19:51.000000000 +0100
@@ -0,0 +1,211 @@
+/*
+ *	Video for Linux Two
+ *
+ *	A generic video device interface for the LINUX operating system
+ *	using a set of device structures/vectors for low level operations.
+ *
+ *	This file replaces the videodev.c file that comes with the
+ *	regular kernel distribution.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ * Author:	Bill Dirks <bdirks@pacbell.net>
+ *		based on code by Alan Cox, <alan@cymru.net>
+ *
+ */
+
+/*
+ * Video capture interface for Linux
+ *
+ *	A generic video device interface for the LINUX operating system
+ *	using a set of device structures/vectors for low level operations.
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ *
+ * Author:	Alan Cox, <alan@redhat.com>
+ *
+ * Fixes:
+ */
+
+/*
+ * Video4linux 1/2 integration by Justin Schoeman
+ * <justin@suntiger.ee.up.ac.za>
+ * 2.4 PROCFS support ported from 2.4 kernels by 
+ *  Iñaki García Etxebarria <garetxe@euskalnet.net>
+ * Makefile fix by "W. Michael Petullo" <mike@flyn.org>
+ * 2.4 devfs support ported from 2.4 kernels by
+ *  Dan Merillat <dan@merillat.org>
+ * Added Gerd Knorrs v4l1 enhancements (Justin Schoeman)
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+#include <asm/div64.h>
+
+#ifdef CONFIG_KMOD
+#include <linux/kmod.h>
+#endif
+
+#if defined(CONFIG_UST) || defined(CONFIG_UST_MODULE)
+#include <linux/ust.h>
+#endif
+
+#include <linux/videodev.h>
+
+MODULE_AUTHOR("Bill Dirks, Justin Schoeman, Gerd Knorr");
+MODULE_DESCRIPTION("misc helper functions for v4l2 device drivers");
+MODULE_LICENSE("GPL");
+
+/*
+ *
+ *	V 4 L 2   D R I V E R   H E L P E R   A P I
+ *
+ */
+
+/*
+ *  Video Standard Operations (contributed by Michael Schimek)
+ */
+
+/* This is the recommended method to deal with the framerate fields. More 
+   sophisticated drivers will access the fields directly. */
+unsigned int
+v4l2_video_std_fps(struct v4l2_standard *vs)
+{ 
+	if (vs->frameperiod.numerator > 0)
+		return (((vs->frameperiod.denominator << 8) / 
+			 vs->frameperiod.numerator) + 
+			(1 << 7)) / (1 << 8);
+	return 0;
+}
+
+/* Fill in the fields of a v4l2_standard structure according to the
+   'id' and 'transmission' parameters.  Returns negative on error.  */
+int v4l2_video_std_construct(struct v4l2_standard *vs,
+			     int id, char *name)
+{
+	memset(vs, 0, sizeof(struct v4l2_standard));
+
+	vs->id = id;
+	if (id & (V4L2_STD_NTSC | V4L2_STD_PAL_M)) {
+		vs->frameperiod.numerator = 1001;
+		vs->frameperiod.denominator = 30000;
+		vs->framelines = 525;
+	} else {
+		vs->frameperiod.numerator = 1;
+		vs->frameperiod.denominator = 25;
+		vs->framelines = 625;
+	}
+	strncpy(vs->name,name,sizeof(vs->name));
+	return 0;
+}
+
+
+/* ----------------------------------------------------------------- */
+
+char *v4l2_field_names[] = {
+	[V4L2_FIELD_ANY]        = "any",
+	[V4L2_FIELD_NONE]       = "none",
+	[V4L2_FIELD_TOP]        = "top",
+	[V4L2_FIELD_BOTTOM]     = "bottom",
+	[V4L2_FIELD_INTERLACED] = "interlaced",
+	[V4L2_FIELD_SEQ_TB]     = "seq-tb",
+	[V4L2_FIELD_SEQ_BT]     = "seq-bt",
+	[V4L2_FIELD_ALTERNATE]  = "alternate",
+};
+
+char *v4l2_type_names[] = {
+	[V4L2_BUF_TYPE_VIDEO_CAPTURE] = "video-cap",
+	[V4L2_BUF_TYPE_VIDEO_OVERLAY] = "video-over",
+	[V4L2_BUF_TYPE_VIDEO_OUTPUT]  = "video-out",
+	[V4L2_BUF_TYPE_VBI_CAPTURE]   = "vbi-cap",
+	[V4L2_BUF_TYPE_VBI_OUTPUT]    = "vbi-out",
+};
+
+char *v4l2_ioctl_names[256] = {
+#if __GNUC__ >= 3
+	[0 ... 255]                      = "UNKNOWN",
+#endif
+	[_IOC_NR(VIDIOC_QUERYCAP)]       = "VIDIOC_QUERYCAP",
+	[_IOC_NR(VIDIOC_RESERVED)]       = "VIDIOC_RESERVED",
+	[_IOC_NR(VIDIOC_ENUM_FMT)]       = "VIDIOC_ENUM_FMT",
+	[_IOC_NR(VIDIOC_G_FMT)]          = "VIDIOC_G_FMT",
+	[_IOC_NR(VIDIOC_S_FMT)]          = "VIDIOC_S_FMT",
+#if 0
+	[_IOC_NR(VIDIOC_G_COMP)]         = "VIDIOC_G_COMP",
+	[_IOC_NR(VIDIOC_S_COMP)]         = "VIDIOC_S_COMP",
+#endif
+	[_IOC_NR(VIDIOC_REQBUFS)]        = "VIDIOC_REQBUFS",
+	[_IOC_NR(VIDIOC_QUERYBUF)]       = "VIDIOC_QUERYBUF",
+	[_IOC_NR(VIDIOC_G_FBUF)]         = "VIDIOC_G_FBUF",
+	[_IOC_NR(VIDIOC_S_FBUF)]         = "VIDIOC_S_FBUF",
+	[_IOC_NR(VIDIOC_OVERLAY)]        = "VIDIOC_OVERLAY",
+	[_IOC_NR(VIDIOC_QBUF)]           = "VIDIOC_QBUF",
+	[_IOC_NR(VIDIOC_DQBUF)]          = "VIDIOC_DQBUF",
+	[_IOC_NR(VIDIOC_STREAMON)]       = "VIDIOC_STREAMON",
+	[_IOC_NR(VIDIOC_STREAMOFF)]      = "VIDIOC_STREAMOFF",
+	[_IOC_NR(VIDIOC_G_PARM)]         = "VIDIOC_G_PARM",
+	[_IOC_NR(VIDIOC_S_PARM)]         = "VIDIOC_S_PARM",
+	[_IOC_NR(VIDIOC_G_STD)]          = "VIDIOC_G_STD",
+	[_IOC_NR(VIDIOC_S_STD)]          = "VIDIOC_S_STD",
+	[_IOC_NR(VIDIOC_ENUMSTD)]        = "VIDIOC_ENUMSTD",
+	[_IOC_NR(VIDIOC_ENUMINPUT)]      = "VIDIOC_ENUMINPUT",
+	[_IOC_NR(VIDIOC_G_CTRL)]         = "VIDIOC_G_CTRL",
+	[_IOC_NR(VIDIOC_S_CTRL)]         = "VIDIOC_S_CTRL",
+	[_IOC_NR(VIDIOC_G_TUNER)]        = "VIDIOC_G_TUNER",
+	[_IOC_NR(VIDIOC_S_TUNER)]        = "VIDIOC_S_TUNER",
+	[_IOC_NR(VIDIOC_G_AUDIO)]        = "VIDIOC_G_AUDIO",
+	[_IOC_NR(VIDIOC_S_AUDIO)]        = "VIDIOC_S_AUDIO",
+	[_IOC_NR(VIDIOC_QUERYCTRL)]      = "VIDIOC_QUERYCTRL",
+	[_IOC_NR(VIDIOC_QUERYMENU)]      = "VIDIOC_QUERYMENU",
+	[_IOC_NR(VIDIOC_G_INPUT)]        = "VIDIOC_G_INPUT",
+	[_IOC_NR(VIDIOC_S_INPUT)]        = "VIDIOC_S_INPUT",
+	[_IOC_NR(VIDIOC_G_OUTPUT)]       = "VIDIOC_G_OUTPUT",
+	[_IOC_NR(VIDIOC_S_OUTPUT)]       = "VIDIOC_S_OUTPUT",
+	[_IOC_NR(VIDIOC_ENUMOUTPUT)]     = "VIDIOC_ENUMOUTPUT",
+	[_IOC_NR(VIDIOC_G_AUDOUT)]       = "VIDIOC_G_AUDOUT",
+	[_IOC_NR(VIDIOC_S_AUDOUT)]       = "VIDIOC_S_AUDOUT",
+	[_IOC_NR(VIDIOC_G_MODULATOR)]    = "VIDIOC_G_MODULATOR",
+	[_IOC_NR(VIDIOC_S_MODULATOR)]    = "VIDIOC_S_MODULATOR",
+	[_IOC_NR(VIDIOC_G_FREQUENCY)]    = "VIDIOC_G_FREQUENCY",
+	[_IOC_NR(VIDIOC_S_FREQUENCY)]    = "VIDIOC_S_FREQUENCY",
+	[_IOC_NR(VIDIOC_CROPCAP)]        = "VIDIOC_CROPCAP",
+	[_IOC_NR(VIDIOC_G_CROP)]         = "VIDIOC_G_CROP",
+	[_IOC_NR(VIDIOC_S_CROP)]         = "VIDIOC_S_CROP",
+	[_IOC_NR(VIDIOC_G_JPEGCOMP)]     = "VIDIOC_G_JPEGCOMP",
+	[_IOC_NR(VIDIOC_S_JPEGCOMP)]     = "VIDIOC_S_JPEGCOMP",
+	[_IOC_NR(VIDIOC_QUERYSTD)]       = "VIDIOC_QUERYSTD",
+	[_IOC_NR(VIDIOC_TRY_FMT)]        = "VIDIOC_TRY_FMT",
+};
+
+/* ----------------------------------------------------------------- */
+
+EXPORT_SYMBOL(v4l2_video_std_fps);
+EXPORT_SYMBOL(v4l2_video_std_construct);
+
+EXPORT_SYMBOL(v4l2_field_names);
+EXPORT_SYMBOL(v4l2_type_names);
+EXPORT_SYMBOL(v4l2_ioctl_names);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
--- linux-2.5.45/include/linux/videodev.h	2002-10-31 14:05:29.000000000 +0100
+++ linux/include/linux/videodev.h	2002-10-31 14:26:32.000000000 +0100
@@ -4,10 +4,10 @@
 #include <linux/types.h>
 #include <linux/version.h>
 
-#if 0
+#if 1
 /*
  * v4l2 is still work-in-progress, integration planed for 2.5.x
- *   v4l2 project homepage:   http://www.thedirks.org/v4l2/
+ *   documentation:           http://bytesex.org/v4l/
  *   patches available from:  http://bytesex.org/patches/
  */ 
 # define HAVE_V4L2 1
@@ -32,10 +32,7 @@
 	int minor;
 
  	/* new interface -- we will use file_operations directly
- 	 * like soundcore does.
- 	 * kernel_ioctl() will be called by video_generic_ioctl.
- 	 * video_generic_ioctl() does the userspace copying of the
- 	 * ioctl arguments */
+ 	 * like soundcore does. */
  	struct file_operations *fops;
 	void *priv;		/* Used to be 'private' but that upsets C++ */
 
@@ -397,7 +394,7 @@
 #define VID_HARDWARE_PWC	31	/* Philips webcams */
 #define VID_HARDWARE_MEYE	32	/* Sony Vaio MotionEye cameras */
 #define VID_HARDWARE_CPIA2	33
-#define VID_HARDWARE_VICAM	34
+#define VID_HARDWARE_VICAM      34
 
 #endif /* __LINUX_VIDEODEV_H */
 
--- linux-2.5.45/include/linux/videodev2.h	2002-10-31 14:19:52.000000000 +0100
+++ linux/include/linux/videodev2.h	2002-10-31 14:27:10.000000000 +0100
@@ -0,0 +1,859 @@
+#ifndef __LINUX_VIDEODEV2_H
+#define __LINUX_VIDEODEV2_H
+/*
+ *	Video for Linux Two
+ *
+ *	Header file for v4l or V4L2 drivers and applications, for
+ *	Linux kernels 2.2.x or 2.4.x.
+ *
+ *	See http://bytesex.org/v4l/ for API specs and other
+ *	v4l2 documentation.
+ *
+ *	Author: Bill Dirks <bdirks@pacbell.net>
+ *		Justin Schoeman
+ *		et al.
+ */
+#include <linux/time.h> /* need struct timeval */
+
+/*
+ *	M I S C E L L A N E O U S
+ */
+
+/*  Four-character-code (FOURCC) */
+#define v4l2_fourcc(a,b,c,d)\
+        (((__u32)(a)<<0)|((__u32)(b)<<8)|((__u32)(c)<<16)|((__u32)(d)<<24))
+
+/*
+ *	E N U M S
+ */
+enum v4l2_field {
+	V4L2_FIELD_ANY        = 0, /* driver can choose from none,
+				      top, bottom, interlaced
+				      depending on whatever it thinks
+				      is approximate ... */
+	V4L2_FIELD_NONE       = 1, /* this device has no fields ... */
+	V4L2_FIELD_TOP        = 2, /* top field only */
+	V4L2_FIELD_BOTTOM     = 3, /* bottom field only */
+	V4L2_FIELD_INTERLACED = 4, /* both fields interlaced */
+	V4L2_FIELD_SEQ_TB     = 5, /* both fields sequential into one
+				      buffer, top-bottom order */
+	V4L2_FIELD_SEQ_BT     = 6, /* same as above + bottom-top order */
+	V4L2_FIELD_ALTERNATE  = 7, /* both fields alternating into
+				      separate buffers */
+};
+#define V4L2_FIELD_HAS_TOP(field)	\
+	((field) == V4L2_FIELD_TOP 	||\
+	 (field) == V4L2_FIELD_INTERLACED ||\
+	 (field) == V4L2_FIELD_SEQ_TB	||\
+	 (field) == V4L2_FIELD_SEQ_BT)
+#define V4L2_FIELD_HAS_BOTTOM(field)	\
+	((field) == V4L2_FIELD_BOTTOM 	||\
+	 (field) == V4L2_FIELD_INTERLACED ||\
+	 (field) == V4L2_FIELD_SEQ_TB	||\
+	 (field) == V4L2_FIELD_SEQ_BT)
+#define V4L2_FIELD_HAS_BOTH(field)	\
+	((field) == V4L2_FIELD_INTERLACED ||\
+	 (field) == V4L2_FIELD_SEQ_TB	||\
+	 (field) == V4L2_FIELD_SEQ_BT)
+
+enum v4l2_buf_type {
+	V4L2_BUF_TYPE_VIDEO_CAPTURE  = 1,
+	V4L2_BUF_TYPE_VIDEO_OUTPUT   = 2,
+	V4L2_BUF_TYPE_VIDEO_OVERLAY  = 3,
+	V4L2_BUF_TYPE_VBI_CAPTURE    = 4,
+	V4L2_BUF_TYPE_VBI_OUTPUT     = 5,
+	V4L2_BUF_TYPE_PRIVATE        = 0x80,
+};
+
+enum v4l2_ctrl_type {
+	V4L2_CTRL_TYPE_INTEGER	     = 1,
+	V4L2_CTRL_TYPE_BOOLEAN	     = 2,
+	V4L2_CTRL_TYPE_MENU	     = 3,
+	V4L2_CTRL_TYPE_BUTTON	     = 4,
+};
+
+enum v4l2_tuner_type {
+	V4L2_TUNER_RADIO	     = 1,
+	V4L2_TUNER_ANALOG_TV	     = 2,
+};
+
+enum v4l2_memory {
+	V4L2_MEMORY_MMAP             = 1,
+	V4L2_MEMORY_USERPTR          = 2,
+	V4L2_MEMORY_OVERLAY          = 3,
+};
+
+/* see also http://vektor.theorem.ca/graphics/ycbcr/ */
+enum v4l2_colorspace {
+	/* ITU-R 601 -- broadcast NTSC/PAL */
+	V4L2_COLORSPACE_SMPTE170M     = 1,
+
+	/* 1125-Line (US) HDTV */
+	V4L2_COLORSPACE_SMPTE240M     = 2,
+
+	/* HD and modern captures. */
+	V4L2_COLORSPACE_REC709        = 3,
+	
+	/* broken BT878 extents (601, luma range 16-253 instead of 16-235) */
+	V4L2_COLORSPACE_BT878         = 4,
+	
+	/* These should be useful.  Assume 601 extents. */
+	V4L2_COLORSPACE_470_SYSTEM_M  = 5,
+	V4L2_COLORSPACE_470_SYSTEM_BG = 6,
+	
+	/* I know there will be cameras that send this.  So, this is
+	 * unspecified chromaticities and full 0-255 on each of the
+	 * Y'CbCr components
+	 */
+	V4L2_COLORSPACE_JPEG          = 7,
+	
+	/* For RGB colourspaces, this is probably a good start. */
+	V4L2_COLORSPACE_SRGB          = 8,
+};
+
+struct v4l2_rect {
+	__s32   left;
+	__s32   top;
+	__s32   width;
+	__s32   height;
+};
+
+struct v4l2_fract {
+	__u32   numerator;
+	__u32   denominator;
+};
+
+/*
+ *	D R I V E R   C A P A B I L I T I E S
+ */
+struct v4l2_capability
+{
+	__u8	driver[16];	/* i.e. "bttv" */
+	__u8	card[32];	/* i.e. "Hauppauge WinTV" */
+	__u8	bus_info[32];	/* "PCI:" + pci_dev->slot_name */
+	__u32   version;        /* should use KERNEL_VERSION() */
+	__u32	capabilities;	/* Device capabilities */
+	__u32	reserved[4];
+};
+
+/* Values for 'capabilities' field */
+#define V4L2_CAP_VIDEO_CAPTURE	0x00000001  /* Is a video capture device */
+#define V4L2_CAP_VIDEO_OUTPUT	0x00000002  /* Is a video output device */
+#define V4L2_CAP_VIDEO_OVERLAY	0x00000004  /* Can do video overlay */
+#define V4L2_CAP_VBI_CAPTURE	0x00000010  /* Is a VBI capture device */
+#define V4L2_CAP_VBI_OUTPUT	0x00000020  /* Is a VBI output device */
+#define V4L2_CAP_RDS_CAPTURE	0x00000100  /* RDS data capture */
+
+#define V4L2_CAP_TUNER		0x00010000  /* Has a tuner */
+#define V4L2_CAP_AUDIO		0x00020000  /* has audio support */
+
+#define V4L2_CAP_READWRITE      0x01000000  /* read/write systemcalls */
+#define V4L2_CAP_ASYNCIO        0x02000000  /* async I/O */
+#define V4L2_CAP_STREAMING      0x04000000  /* streaming I/O ioctls */
+
+/*
+ *	V I D E O   I M A G E   F O R M A T
+ */
+
+struct v4l2_pix_format
+{
+	__u32         	 	width;
+	__u32	         	height;
+	__u32	         	pixelformat;
+	enum v4l2_field  	field;
+	__u32            	bytesperline;	/* for padding, zero if unused */
+	__u32          	 	sizeimage;
+        enum v4l2_colorspace	colorspace;
+	__u32			priv;		/* private data, depends on pixelformat */
+};
+
+/*           Pixel format    FOURCC                  depth  Description   */
+#define V4L2_PIX_FMT_RGB332  v4l2_fourcc('R','G','B','1') /*  8  RGB-3-3-2     */
+#define V4L2_PIX_FMT_RGB555  v4l2_fourcc('R','G','B','O') /* 16  RGB-5-5-5     */
+#define V4L2_PIX_FMT_RGB565  v4l2_fourcc('R','G','B','P') /* 16  RGB-5-6-5     */
+#define V4L2_PIX_FMT_RGB555X v4l2_fourcc('R','G','B','Q') /* 16  RGB-5-5-5 BE  */
+#define V4L2_PIX_FMT_RGB565X v4l2_fourcc('R','G','B','R') /* 16  RGB-5-6-5 BE  */
+#define V4L2_PIX_FMT_BGR24   v4l2_fourcc('B','G','R','3') /* 24  BGR-8-8-8     */
+#define V4L2_PIX_FMT_RGB24   v4l2_fourcc('R','G','B','3') /* 24  RGB-8-8-8     */
+#define V4L2_PIX_FMT_BGR32   v4l2_fourcc('B','G','R','4') /* 32  BGR-8-8-8-8   */
+#define V4L2_PIX_FMT_RGB32   v4l2_fourcc('R','G','B','4') /* 32  RGB-8-8-8-8   */
+#define V4L2_PIX_FMT_GREY    v4l2_fourcc('G','R','E','Y') /*  8  Greyscale     */
+#define V4L2_PIX_FMT_YVU410  v4l2_fourcc('Y','V','U','9') /*  9  YVU 4:1:0     */
+#define V4L2_PIX_FMT_YVU420  v4l2_fourcc('Y','V','1','2') /* 12  YVU 4:2:0     */
+#define V4L2_PIX_FMT_YUYV    v4l2_fourcc('Y','U','Y','V') /* 16  YUV 4:2:2     */
+#define V4L2_PIX_FMT_UYVY    v4l2_fourcc('U','Y','V','Y') /* 16  YUV 4:2:2     */
+#define V4L2_PIX_FMT_YUV422P v4l2_fourcc('4','2','2','P') /* 16  YVU422 planar */
+#define V4L2_PIX_FMT_YUV411P v4l2_fourcc('4','1','1','P') /* 16  YVU411 planar */
+#define V4L2_PIX_FMT_Y41P    v4l2_fourcc('Y','4','1','P') /* 12  YUV 4:1:1     */
+
+/* two planes -- one Y, one Cr + Cb interleaved  */
+#define V4L2_PIX_FMT_NV12    v4l2_fourcc('N','V','1','2') /* 12  Y/CbCr 4:2:0  */
+#define V4L2_PIX_FMT_NV21    v4l2_fourcc('N','V','2','1') /* 12  Y/CrCb 4:2:0  */
+
+/*  The following formats are not defined in the V4L2 specification */
+#define V4L2_PIX_FMT_YUV410  v4l2_fourcc('Y','U','V','9') /*  9  YUV 4:1:0     */
+#define V4L2_PIX_FMT_YUV420  v4l2_fourcc('Y','U','1','2') /* 12  YUV 4:2:0     */
+#define V4L2_PIX_FMT_YYUV    v4l2_fourcc('Y','Y','U','V') /* 16  YUV 4:2:2     */
+#define V4L2_PIX_FMT_HI240   v4l2_fourcc('H','I','2','4') /*  8  8-bit color   */
+
+/* compressed formats */
+#define V4L2_PIX_FMT_MJPEG    v4l2_fourcc('M','J','P','G') /* Motion-JPEG   */
+#define V4L2_PIX_FMT_JPEG     v4l2_fourcc('J','P','E','G') /* JFIF JPEG     */
+#define V4L2_PIX_FMT_DV       v4l2_fourcc('d','v','s','d') /* 1394          */
+#define V4L2_PIX_FMT_MPEG     v4l2_fourcc('M','P','E','G') /* MPEG          */
+
+/*  Vendor-specific formats   */
+#define V4L2_PIX_FMT_WNVA    v4l2_fourcc('W','N','V','A') /* Winnov hw compres */
+
+/*
+ *	F O R M A T   E N U M E R A T I O N
+ */
+struct v4l2_fmtdesc
+{
+	__u32	            index;             /* Format number      */
+	enum v4l2_buf_type  type;              /* buffer type        */
+	__u32               flags;
+	__u8	            description[32];   /* Description string */
+	__u32	            pixelformat;       /* Format fourcc      */
+	__u32	            reserved[4];
+};
+
+#define V4L2_FMT_FLAG_COMPRESSED 0x0001
+
+
+/*
+ *	T I M E C O D E
+ */
+struct v4l2_timecode
+{
+	__u32	type;
+	__u32	flags;
+	__u8	frames;
+	__u8	seconds;
+	__u8	minutes;
+	__u8	hours;
+	__u8	userbits[4];
+};
+
+/*  Type  */
+#define V4L2_TC_TYPE_24FPS		1
+#define V4L2_TC_TYPE_25FPS		2
+#define V4L2_TC_TYPE_30FPS		3
+#define V4L2_TC_TYPE_50FPS		4
+#define V4L2_TC_TYPE_60FPS		5
+
+/*  Flags  */
+#define V4L2_TC_FLAG_DROPFRAME		0x0001 /* "drop-frame" mode */
+#define V4L2_TC_FLAG_COLORFRAME		0x0002
+#define V4L2_TC_USERBITS_field		0x000C
+#define V4L2_TC_USERBITS_USERDEFINED	0x0000
+#define V4L2_TC_USERBITS_8BITCHARS	0x0008
+/* The above is based on SMPTE timecodes */
+
+
+/*
+ *	C O M P R E S S I O N   P A R A M E T E R S
+ */
+#if 0
+/* ### generic compression settings don't work, there is too much
+ * ### codec-specific stuff.  Maybe reuse that for MPEG codec settings
+ * ### later ... */
+struct v4l2_compression
+{
+	__u32	quality;
+	__u32	keyframerate;
+	__u32	pframerate;
+	__u32	reserved[5];
+};
+#endif
+
+struct v4l2_jpegcompression
+{
+	int quality;
+
+	int  APPn;              /* Number of APP segment to be written,
+				 * must be 0..15 */
+	int  APP_len;           /* Length of data in JPEG APPn segment */
+	char APP_data[60];      /* Data in the JPEG APPn segment. */
+	
+	int  COM_len;           /* Length of data in JPEG COM segment */
+	char COM_data[60];      /* Data in JPEG COM segment */
+	
+	__u32 jpeg_markers;     /* Which markers should go into the JPEG
+				 * output. Unless you exactly know what
+				 * you do, leave them untouched.
+				 * Inluding less markers will make the
+				 * resulting code smaller, but there will
+				 * be fewer aplications which can read it.
+				 * The presence of the APP and COM marker
+				 * is influenced by APP_len and COM_len
+				 * ONLY, not by this property! */
+	
+#define V4L2_JPEG_MARKER_DHT (1<<3)    /* Define Huffman Tables */
+#define V4L2_JPEG_MARKER_DQT (1<<4)    /* Define Quantization Tables */
+#define V4L2_JPEG_MARKER_DRI (1<<5)    /* Define Restart Interval */
+#define V4L2_JPEG_MARKER_COM (1<<6)    /* Comment segment */
+#define V4L2_JPEG_MARKER_APP (1<<7)    /* App segment, driver will
+                                        * allways use APP0 */
+};
+
+
+/*
+ *	M E M O R Y - M A P P I N G   B U F F E R S
+ */
+struct v4l2_requestbuffers
+{
+	__u32	                count;
+	enum v4l2_buf_type      type;
+	enum v4l2_memory        memory;
+	__u32	                reserved[2];
+};
+
+struct v4l2_buffer
+{
+	__u32			index;
+	enum v4l2_buf_type      type;
+	__u32			bytesused;
+	__u32			flags;
+	enum v4l2_field		field;
+	struct timeval		timestamp;
+	struct v4l2_timecode	timecode;
+	__u32			sequence;
+
+	/* memory location */
+	enum v4l2_memory        memory;
+	union {
+		__u32           offset;
+		unsigned long   userptr;
+	} m;
+	__u32			length;
+
+	__u32			reserved[2];
+};
+
+/*  Flags for 'flags' field */
+#define V4L2_BUF_FLAG_MAPPED	0x0001  /* Buffer is mapped (flag) */
+#define V4L2_BUF_FLAG_QUEUED	0x0002	/* Buffer is queued for processing */
+#define V4L2_BUF_FLAG_DONE	0x0004	/* Buffer is ready */
+#define V4L2_BUF_FLAG_KEYFRAME	0x0008	/* Image is a keyframe (I-frame) */
+#define V4L2_BUF_FLAG_PFRAME	0x0010	/* Image is a P-frame */
+#define V4L2_BUF_FLAG_BFRAME	0x0020	/* Image is a B-frame */
+#define V4L2_BUF_FLAG_TIMECODE	0x0100	/* timecode field is valid */
+
+/*
+ *	O V E R L A Y   P R E V I E W
+ */
+struct v4l2_framebuffer
+{
+	__u32			capability;
+	__u32			flags;
+/* FIXME: in theory we should pass something like PCI device + memory
+ * region + offset instead of some physical address */
+	void*                   base;
+	struct v4l2_pix_format	fmt;
+};
+/*  Flags for the 'capability' field. Read only */
+#define V4L2_FBUF_CAP_EXTERNOVERLAY	0x0001
+#define V4L2_FBUF_CAP_CHROMAKEY		0x0002
+#define V4L2_FBUF_CAP_LIST_CLIPPING     0x0004
+#define V4L2_FBUF_CAP_BITMAP_CLIPPING	0x0008
+/*  Flags for the 'flags' field. */
+#define V4L2_FBUF_FLAG_PRIMARY		0x0001
+#define V4L2_FBUF_FLAG_OVERLAY		0x0002
+#define V4L2_FBUF_FLAG_CHROMAKEY	0x0004
+
+struct v4l2_clip
+{
+	struct v4l2_rect        c;
+	struct v4l2_clip	*next;
+};
+
+struct v4l2_window
+{
+	struct v4l2_rect        w;
+	enum v4l2_field  	field;
+	__u32			chromakey;
+	struct v4l2_clip	*clips;
+	__u32			clipcount;
+	void			*bitmap;
+};
+
+
+/*
+ *	C A P T U R E   P A R A M E T E R S
+ */
+struct v4l2_captureparm
+{
+	__u32		   capability;	  /*  Supported modes */
+	__u32		   capturemode;	  /*  Current mode */
+	struct v4l2_fract  timeperframe;  /*  Time per frame in .1us units */
+	__u32		   extendedmode;  /*  Driver-specific extensions */
+	__u32              readbuffers;   /*  # of buffers for read */
+	__u32		   reserved[4];
+};
+/*  Flags for 'capability' and 'capturemode' fields */
+#define V4L2_MODE_HIGHQUALITY	0x0001	/*  High quality imaging mode */
+#define V4L2_CAP_TIMEPERFRAME	0x1000	/*  timeperframe field is supported */
+
+struct v4l2_outputparm
+{
+	__u32		   capability;	 /*  Supported modes */
+	__u32		   outputmode;	 /*  Current mode */
+	struct v4l2_fract  timeperframe; /*  Time per frame in seconds */
+	__u32		   extendedmode; /*  Driver-specific extensions */
+	__u32              writebuffers; /*  # of buffers for write */
+	__u32		   reserved[4];
+};
+
+/*
+ *	I N P U T   I M A G E   C R O P P I N G
+ */
+
+struct v4l2_cropcap {
+	enum v4l2_buf_type      type;	
+        struct v4l2_rect        bounds;
+        struct v4l2_rect        defrect;
+        struct v4l2_fract       pixelaspect;
+};
+
+struct v4l2_crop {
+	enum v4l2_buf_type      type;
+	struct v4l2_rect        c;
+};
+
+/*
+ *      A N A L O G   V I D E O   S T A N D A R D
+ */
+
+typedef __u64 v4l2_std_id;
+
+/* one bit for each */
+#define V4L2_STD_PAL_B          ((v4l2_std_id)0x00000001)
+#define V4L2_STD_PAL_B1         ((v4l2_std_id)0x00000002)
+#define V4L2_STD_PAL_G          ((v4l2_std_id)0x00000004)
+#define V4L2_STD_PAL_H          ((v4l2_std_id)0x00000008)
+#define V4L2_STD_PAL_I          ((v4l2_std_id)0x00000010)
+#define V4L2_STD_PAL_D          ((v4l2_std_id)0x00000020)
+#define V4L2_STD_PAL_D1         ((v4l2_std_id)0x00000040)
+#define V4L2_STD_PAL_K          ((v4l2_std_id)0x00000080)
+
+#define V4L2_STD_PAL_M          ((v4l2_std_id)0x00000100)
+#define V4L2_STD_PAL_N          ((v4l2_std_id)0x00000200)
+#define V4L2_STD_PAL_Nc         ((v4l2_std_id)0x00000400)
+#define V4L2_STD_PAL_60         ((v4l2_std_id)0x00000800)
+
+#define V4L2_STD_NTSC_M         ((v4l2_std_id)0x00001000)
+#define V4L2_STD_NTSC_M_JP      ((v4l2_std_id)0x00002000)
+
+#define V4L2_STD_SECAM_B        ((v4l2_std_id)0x00010000)
+#define V4L2_STD_SECAM_D        ((v4l2_std_id)0x00020000)
+#define V4L2_STD_SECAM_G        ((v4l2_std_id)0x00040000)
+#define V4L2_STD_SECAM_H        ((v4l2_std_id)0x00080000)
+#define V4L2_STD_SECAM_K        ((v4l2_std_id)0x00100000)
+#define V4L2_STD_SECAM_K1       ((v4l2_std_id)0x00200000)
+#define V4L2_STD_SECAM_L        ((v4l2_std_id)0x00400000)
+
+/* ATSC/HDTV */
+#define V4L2_STD_ATSC_8_VSB     ((v4l2_std_id)0x01000000)
+#define V4L2_STD_ATSC_16_VSB    ((v4l2_std_id)0x02000000)
+
+/* some common needed stuff */
+#define V4L2_STD_PAL_BG		(V4L2_STD_PAL_B		|\
+				 V4L2_STD_PAL_B1	|\
+				 V4L2_STD_PAL_G)
+#define V4L2_STD_PAL_DK		(V4L2_STD_PAL_D		|\
+				 V4L2_STD_PAL_D1	|\
+				 V4L2_STD_PAL_K)
+#define V4L2_STD_PAL		(V4L2_STD_PAL_BG	|\
+				 V4L2_STD_PAL_DK	|\
+				 V4L2_STD_PAL_H		|\
+				 V4L2_STD_PAL_I)
+#define V4L2_STD_NTSC           (V4L2_STD_NTSC_M	|\
+				 V4L2_STD_NTSC_M_JP)
+#define V4L2_STD_SECAM		(V4L2_STD_SECAM_B	|\
+				 V4L2_STD_SECAM_D	|\
+				 V4L2_STD_SECAM_G	|\
+				 V4L2_STD_SECAM_H	|\
+				 V4L2_STD_SECAM_K	|\
+				 V4L2_STD_SECAM_K1	|\
+				 V4L2_STD_SECAM_L)
+
+#define V4L2_STD_525_60		(V4L2_STD_PAL_M		|\
+				 V4L2_STD_PAL_60	|\
+				 V4L2_STD_NTSC)
+#define V4L2_STD_625_50		(V4L2_STD_PAL		|\
+				 V4L2_STD_PAL_N		|\
+				 V4L2_STD_PAL_Nc	|\
+				 V4L2_STD_SECAM)
+
+#define V4L2_STD_UNKNOWN        0
+#define V4L2_STD_ALL            (V4L2_STD_525_60	|\
+				 V4L2_STD_625_50)
+
+struct v4l2_standard
+{
+	__u32	       	     index;
+	v4l2_std_id          id;
+	__u8		     name[24];
+	struct v4l2_fract    frameperiod; /* Frames, not fields */
+	__u32		     framelines;
+	__u32		     reserved[4];
+};
+
+
+/*
+ *	V I D E O   I N P U T S
+ */
+struct v4l2_input
+{
+	__u32	     index;		/*  Which input */
+	__u8	     name[32];	        /*  Label */
+	__u32	     type;		/*  Type of input */
+	__u32	     audioset;	        /*  Associated audios (bitfield) */
+	__u32        tuner;             /*  Associated tuner */
+	v4l2_std_id  std;
+	__u32	     status;
+	__u32	     reserved[4];
+};
+/*  Values for the 'type' field */
+#define V4L2_INPUT_TYPE_TUNER		1
+#define V4L2_INPUT_TYPE_CAMERA		2
+
+/* field 'status' - general */
+#define V4L2_IN_ST_NO_POWER    0x00000001  /* Attached device is off */
+#define V4L2_IN_ST_NO_SIGNAL   0x00000002
+#define V4L2_IN_ST_NO_COLOR    0x00000004
+
+/* field 'status' - analog */
+#define V4L2_IN_ST_NO_H_LOCK   0x00000100  /* No horizontal sync lock */
+#define V4L2_IN_ST_COLOR_KILL  0x00000200  /* Color killer is active */
+
+/* field 'status' - digital */
+#define V4L2_IN_ST_NO_SYNC     0x00010000  /* No synchronization lock */
+#define V4L2_IN_ST_NO_EQU      0x00020000  /* No equalizer lock */
+#define V4L2_IN_ST_NO_CARRIER  0x00040000  /* Carrier recovery failed */
+
+/* field 'status' - VCR and set-top box */
+#define V4L2_IN_ST_MACROVISION 0x01000000  /* Macrovision detected */
+#define V4L2_IN_ST_NO_ACCESS   0x02000000  /* Conditional access denied */
+#define V4L2_IN_ST_VTR         0x04000000  /* VTR time constant */
+
+/*
+ *	V I D E O   O U T P U T S
+ */
+struct v4l2_output
+{
+	__u32	     index;		/*  Which output */
+	__u8	     name[32];	        /*  Label */
+	__u32	     type;		/*  Type of output */
+	__u32	     audioset;	        /*  Associated audios (bitfield) */
+	__u32	     modulator;         /*  Associated modulator */
+	v4l2_std_id  std;
+	__u32	     reserved[4];
+};
+/*  Values for the 'type' field */
+#define V4L2_OUTPUT_TYPE_MODULATOR		1
+#define V4L2_OUTPUT_TYPE_ANALOG			2
+#define V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY	3
+
+/*
+ *	C O N T R O L S
+ */
+struct v4l2_control
+{
+	__u32		     id;
+	__s32		     value;
+};
+
+/*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
+struct v4l2_queryctrl
+{
+	__u32	             id;
+	enum v4l2_ctrl_type  type;
+	__u8		     name[32];	/* Whatever */
+	__s32		     minimum;	/* Note signedness */
+	__s32		     maximum;
+	__s32	             step;
+	__s32		     default_value;
+	__u32                flags;
+	__u32		     reserved[2];
+};
+
+/*  Used in the VIDIOC_QUERYMENU ioctl for querying menu items */
+struct v4l2_querymenu
+{
+	__u32		id;
+	__u32		index;
+	__u8		name[32];	/* Whatever */
+	__u32		reserved;
+};
+
+/*  Control flags  */
+#define V4L2_CTRL_FLAG_DISABLED		0x0001
+#define V4L2_CTRL_FLAG_GRABBED		0x0002
+
+/*  Control IDs defined by V4L2 */
+#define V4L2_CID_BASE			0x00980900
+/*  IDs reserved for driver specific controls */
+#define V4L2_CID_PRIVATE_BASE		0x08000000
+
+#define V4L2_CID_BRIGHTNESS		(V4L2_CID_BASE+0)
+#define V4L2_CID_CONTRAST		(V4L2_CID_BASE+1)
+#define V4L2_CID_SATURATION		(V4L2_CID_BASE+2)
+#define V4L2_CID_HUE			(V4L2_CID_BASE+3)
+#define V4L2_CID_AUDIO_VOLUME		(V4L2_CID_BASE+5)
+#define V4L2_CID_AUDIO_BALANCE		(V4L2_CID_BASE+6)
+#define V4L2_CID_AUDIO_BASS		(V4L2_CID_BASE+7)
+#define V4L2_CID_AUDIO_TREBLE		(V4L2_CID_BASE+8)
+#define V4L2_CID_AUDIO_MUTE		(V4L2_CID_BASE+9)
+#define V4L2_CID_AUDIO_LOUDNESS		(V4L2_CID_BASE+10)
+#define V4L2_CID_BLACK_LEVEL		(V4L2_CID_BASE+11)
+#define V4L2_CID_AUTO_WHITE_BALANCE	(V4L2_CID_BASE+12)
+#define V4L2_CID_DO_WHITE_BALANCE	(V4L2_CID_BASE+13)
+#define V4L2_CID_RED_BALANCE		(V4L2_CID_BASE+14)
+#define V4L2_CID_BLUE_BALANCE		(V4L2_CID_BASE+15)
+#define V4L2_CID_GAMMA			(V4L2_CID_BASE+16)
+#define V4L2_CID_WHITENESS		(V4L2_CID_GAMMA) /* ? Not sure */
+#define V4L2_CID_EXPOSURE		(V4L2_CID_BASE+17)
+#define V4L2_CID_AUTOGAIN		(V4L2_CID_BASE+18)
+#define V4L2_CID_GAIN			(V4L2_CID_BASE+19)
+#define V4L2_CID_HFLIP			(V4L2_CID_BASE+20)
+#define V4L2_CID_VFLIP			(V4L2_CID_BASE+21)
+#define V4L2_CID_HCENTER		(V4L2_CID_BASE+22)
+#define V4L2_CID_VCENTER		(V4L2_CID_BASE+23)
+#define V4L2_CID_LASTP1			(V4L2_CID_BASE+24) /* last CID + 1 */
+
+/*
+ *	T U N I N G
+ */
+struct v4l2_tuner
+{
+	__u32                   index;
+	__u8			name[32];
+	enum v4l2_tuner_type    type;
+	__u32			capability;
+	__u32			rangelow;
+	__u32			rangehigh;
+	__u32			rxsubchans;
+	__u32			audmode;
+	__s32			signal;
+	__s32			afc;
+	__u32			reserved[4];
+};
+
+struct v4l2_modulator
+{
+	__u32			index;
+	__u8			name[32];
+	__u32			capability;
+	__u32			rangelow;
+	__u32			rangehigh;
+	__u32			txsubchans;
+	__u32			reserved[4];
+};
+
+/*  Flags for the 'capability' field */
+#define V4L2_TUNER_CAP_LOW		0x0001
+#define V4L2_TUNER_CAP_NORM		0x0002
+#define V4L2_TUNER_CAP_STEREO		0x0010
+#define V4L2_TUNER_CAP_LANG2		0x0020
+#define V4L2_TUNER_CAP_SAP		0x0020
+#define V4L2_TUNER_CAP_LANG1		0x0040
+
+/*  Flags for the 'rxsubchans' field */
+#define V4L2_TUNER_SUB_MONO		0x0001
+#define V4L2_TUNER_SUB_STEREO		0x0002
+#define V4L2_TUNER_SUB_LANG2		0x0004
+#define V4L2_TUNER_SUB_SAP		0x0004
+#define V4L2_TUNER_SUB_LANG1		0x0008
+
+/*  Values for the 'audmode' field */
+#define V4L2_TUNER_MODE_MONO		0x0000
+#define V4L2_TUNER_MODE_STEREO		0x0001
+#define V4L2_TUNER_MODE_LANG2		0x0002
+#define V4L2_TUNER_MODE_SAP		0x0002
+#define V4L2_TUNER_MODE_LANG1		0x0003
+
+struct v4l2_frequency
+{
+	__u32	              tuner;
+	enum v4l2_tuner_type  type;
+        __u32	              frequency;
+	__u32	              reserved[8];
+};
+
+/*
+ *	A U D I O
+ */
+struct v4l2_audio
+{
+	__u32	index;
+	__u8	name[32];
+	__u32	capability;
+	__u32	mode;
+	__u32	reserved[2];
+};
+/*  Flags for the 'capability' field */
+#define V4L2_AUDCAP_STEREO		0x00001
+#define V4L2_AUDCAP_AVL			0x00002
+
+/*  Flags for the 'mode' field */
+#define V4L2_AUDMODE_AVL		0x00001
+
+struct v4l2_audioout
+{
+	__u32	index;
+	__u8	name[32];
+	__u32	capability;
+	__u32	mode;
+	__u32	reserved[2];
+};
+
+/*
+ *	D A T A   S E R V I C E S   ( V B I )
+ *
+ *	Data services API by Michael Schimek
+ */
+
+struct v4l2_vbi_format
+{
+	__u32	sampling_rate;		/* in 1 Hz */
+	__u32	offset;
+	__u32	samples_per_line;
+	__u32	sample_format;		/* V4L2_PIX_FMT_* */
+	__s32	start[2];
+	__u32	count[2];
+	__u32	flags;			/* V4L2_VBI_* */
+	__u32	reserved[2];		/* must be zero */
+};
+
+/*  VBI flags  */
+#define V4L2_VBI_UNSYNC		(1<< 0)
+#define V4L2_VBI_INTERLACED	(1<< 1)
+
+
+/*
+ *	A G G R E G A T E   S T R U C T U R E S
+ */
+
+/*	Stream data format
+ */
+struct v4l2_format
+{
+	enum v4l2_buf_type type;
+	union
+	{
+		struct v4l2_pix_format	pix;  // V4L2_BUF_TYPE_VIDEO_CAPTURE
+		struct v4l2_window	win;  // V4L2_BUF_TYPE_VIDEO_OVERLAY
+		struct v4l2_vbi_format	vbi;  // V4L2_BUF_TYPE_VBI_CAPTURE
+		__u8	raw_data[200];        // user-defined
+	} fmt;
+};
+
+
+/*	Stream type-dependent parameters
+ */
+struct v4l2_streamparm
+{
+	enum v4l2_buf_type type;
+	union
+	{
+		struct v4l2_captureparm	capture;
+		struct v4l2_outputparm	output;
+		__u8	raw_data[200];  /* user-defined */
+	} parm;
+};
+
+
+
+/*
+ *	I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
+ *
+ */
+#define VIDIOC_QUERYCAP		_IOR  ('V',  0, struct v4l2_capability)
+#define VIDIOC_RESERVED		_IO   ('V',  1)
+#define VIDIOC_ENUM_FMT         _IOWR ('V',  2, struct v4l2_fmtdesc)
+#define VIDIOC_G_FMT		_IOWR ('V',  4, struct v4l2_format)
+#define VIDIOC_S_FMT		_IOWR ('V',  5, struct v4l2_format)
+#if 0
+#define VIDIOC_G_COMP		_IOR  ('V',  6, struct v4l2_compression)
+#define VIDIOC_S_COMP		_IOW  ('V',  7, struct v4l2_compression)
+#endif
+#define VIDIOC_REQBUFS		_IOWR ('V',  8, struct v4l2_requestbuffers)
+#define VIDIOC_QUERYBUF		_IOWR ('V',  9, struct v4l2_buffer)
+#define VIDIOC_G_FBUF		_IOR  ('V', 10, struct v4l2_framebuffer)
+#define VIDIOC_S_FBUF		_IOW  ('V', 11, struct v4l2_framebuffer)
+#define VIDIOC_OVERLAY		_IOWR ('V', 14, int)
+#define VIDIOC_QBUF		_IOWR ('V', 15, struct v4l2_buffer)
+#define VIDIOC_DQBUF		_IOWR ('V', 17, struct v4l2_buffer)
+#define VIDIOC_STREAMON		_IOW  ('V', 18, int)
+#define VIDIOC_STREAMOFF	_IOW  ('V', 19, int)
+#define VIDIOC_G_PARM		_IOWR ('V', 21, struct v4l2_streamparm)
+#define VIDIOC_S_PARM		_IOW  ('V', 22, struct v4l2_streamparm)
+#define VIDIOC_G_STD		_IOR  ('V', 23, v4l2_std_id)
+#define VIDIOC_S_STD		_IOW  ('V', 24, v4l2_std_id)
+#define VIDIOC_ENUMSTD		_IOWR ('V', 25, struct v4l2_standard)
+#define VIDIOC_ENUMINPUT	_IOWR ('V', 26, struct v4l2_input)
+#define VIDIOC_G_CTRL		_IOWR ('V', 27, struct v4l2_control)
+#define VIDIOC_S_CTRL		_IOW  ('V', 28, struct v4l2_control)
+#define VIDIOC_G_TUNER		_IOWR ('V', 29, struct v4l2_tuner)
+#define VIDIOC_S_TUNER		_IOW  ('V', 30, struct v4l2_tuner)
+#define VIDIOC_G_AUDIO		_IOWR ('V', 33, struct v4l2_audio)
+#define VIDIOC_S_AUDIO		_IOW  ('V', 34, struct v4l2_audio)
+#define VIDIOC_QUERYCTRL	_IOWR ('V', 36, struct v4l2_queryctrl)
+#define VIDIOC_QUERYMENU	_IOWR ('V', 37, struct v4l2_querymenu)
+#define VIDIOC_G_INPUT		_IOR  ('V', 38, int)
+#define VIDIOC_S_INPUT		_IOWR ('V', 39, int)
+#define VIDIOC_G_OUTPUT		_IOR  ('V', 46, int)
+#define VIDIOC_S_OUTPUT		_IOWR ('V', 47, int)
+#define VIDIOC_ENUMOUTPUT	_IOWR ('V', 48, struct v4l2_output)
+#define VIDIOC_G_AUDOUT		_IOWR ('V', 49, struct v4l2_audioout)
+#define VIDIOC_S_AUDOUT		_IOW  ('V', 50, struct v4l2_audioout)
+#define VIDIOC_G_MODULATOR	_IOWR ('V', 54, struct v4l2_modulator)
+#define VIDIOC_S_MODULATOR	_IOW  ('V', 55, struct v4l2_modulator)
+#define VIDIOC_G_FREQUENCY	_IOWR ('V', 56, struct v4l2_frequency)
+#define VIDIOC_S_FREQUENCY	_IOW  ('V', 57, struct v4l2_frequency)
+#define VIDIOC_CROPCAP		_IOR  ('V', 58, struct v4l2_cropcap)
+#define VIDIOC_G_CROP		_IOWR ('V', 59, struct v4l2_crop)
+#define VIDIOC_S_CROP		_IOW  ('V', 60, struct v4l2_crop)
+#define VIDIOC_G_JPEGCOMP	_IOR  ('V', 61, struct v4l2_jpegcompression)
+#define VIDIOC_S_JPEGCOMP	_IOW  ('V', 62, struct v4l2_jpegcompression)
+#define VIDIOC_QUERYSTD      	_IOR  ('V', 63, v4l2_std_id)
+#define VIDIOC_TRY_FMT      	_IOWR ('V', 63, struct v4l2_format)
+
+#define BASE_VIDIOC_PRIVATE	192		/* 192-255 are private */
+
+
+#ifdef __KERNEL__
+/*
+ *
+ *	V 4 L 2   D R I V E R   H E L P E R   A P I
+ *
+ *	Some commonly needed functions for drivers (v4l2-common.o module)
+ */
+#include <linux/fs.h>
+
+/*  Video standard functions  */
+extern unsigned int v4l2_video_std_fps(struct v4l2_standard *vs);
+extern int v4l2_video_std_construct(struct v4l2_standard *vs,
+				    int id, char *name);
+
+/*  Compatibility layer interface  */
+typedef int (*v4l2_kioctl)(struct inode *inode, struct file *file,
+			   unsigned int cmd, void *arg);
+int v4l_compat_translate_ioctl(struct inode *inode, struct file *file,
+			       int cmd, void *arg, v4l2_kioctl driver_ioctl);
+
+/* names for fancy debug output */
+extern char *v4l2_field_names[];
+extern char *v4l2_type_names[];
+extern char *v4l2_ioctl_names[];
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_VIDEODEV2_H */
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
