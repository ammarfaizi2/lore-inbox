Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266711AbUAOLi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266647AbUAOLh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:37:29 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:47282 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266567AbUAOLfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:35:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Jan 2004 12:49:41 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l-02 v4l2 update
Message-ID: <20040115114941.GA16041@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch is a v4l2 update.  Changes:

 * added new ioctls (VIDIOC_G_PRIORITY, VIDIOC_S_PRIORITY) to give
   v4l apps priorities for tuning and other controls.  Main purpose
   is that backgrounds applictions like nxtvepg which are fishing
   informations from /dev/vbi (teletext, epg, ...) can run at lower
   priority than interactive tv apps and thus the user isn't annonyed
   with unexpected channel switches.
 * add a set of helper functions to handle priorities to the
   v4l2-common module.
 * minor fixes in the v4l1-compat module.
 * minor header file fixes.

please apply,

  Gerd

diff -u linux-2.6.1/drivers/media/video/v4l1-compat.c linux/drivers/media/video/v4l1-compat.c
--- linux-2.6.1/drivers/media/video/v4l1-compat.c	2004-01-14 15:05:49.000000000 +0100
+++ linux/drivers/media/video/v4l1-compat.c	2004-01-14 15:09:35.000000000 +0100
@@ -21,7 +21,6 @@
 
 #include <linux/config.h>
 
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -52,7 +51,7 @@
 MODULE_LICENSE("GPL");
 
 #define dprintk(fmt, arg...)	if (debug) \
-	printk(KERN_DEBUG "v4l1-compat: " fmt, ## arg)
+	printk(KERN_DEBUG "v4l1-compat: " fmt , ## arg)
 
 /*
  *	I O C T L   T R A N S L A T I O N
@@ -80,8 +79,10 @@
 	{
 		ctrl2.id = qctrl2.id;
 		err = drv(inode, file, VIDIOC_G_CTRL, &ctrl2);
-		if (err < 0)
+		if (err < 0) {
 			dprintk("VIDIOC_G_CTRL: %d\n",err);
+			return 0;
+		}
 		return ((ctrl2.value - qctrl2.minimum) * 65535
 			 + (qctrl2.maximum - qctrl2.minimum) / 2)
 			/ (qctrl2.maximum - qctrl2.minimum);
@@ -207,17 +208,10 @@
 {
 	int retval = 1;
 	poll_table *table;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,48)
-	poll_table wait_table;
-
-	poll_initwait(&wait_table);
-	table = &wait_table;
-#else
 	struct poll_wqueues pwq;
 
 	poll_initwait(&pwq);
 	table = &pwq.pt;
-#endif
 	for (;;) {
 		int mask;
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -231,12 +225,8 @@
 		}
 		schedule();
 	}
-	current->state = TASK_RUNNING;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,48)
-	poll_freewait(&wait_table);
-#else
+	set_current_state(TASK_RUNNING);
 	poll_freewait(&pwq);
-#endif
 	return retval;
 }
 
@@ -482,6 +472,7 @@
 			fmt2->fmt.pix.width  = win->width;
 			fmt2->fmt.pix.height = win->height;
 			fmt2->fmt.pix.field  = V4L2_FIELD_ANY;
+			fmt2->fmt.pix.bytesperline = 0;
 			err = drv(inode, file, VIDIOC_S_FMT, fmt2);
 			if (err < 0)
 				dprintk("VIDIOCSWIN / VIDIOC_S_FMT #1: %d\n",
@@ -509,6 +500,14 @@
 	}
 	case VIDIOCCAPTURE: /*  turn on/off preview  */
 	{
+		int *on = arg;
+
+		if (0 == *on) {
+			/* dirty hack time.  But v4l1 has no STREAMOFF
+			 * equivalent in the API, and this one at
+			 * least comes close ... */
+			drv(inode, file, VIDIOC_STREAMOFF, NULL);
+		}
 		err = drv(inode, file, VIDIOC_OVERLAY, arg);
 		if (err < 0)
 			dprintk("VIDIOCCAPTURE / VIDIOC_PREVIEW: %d\n",err);
@@ -719,7 +718,8 @@
 	case VIDIOCGFREQ: /*  get frequency  */
 	{
 		int *freq = arg;
-		
+
+		freq2.tuner = 0;
 		err = drv(inode, file, VIDIOC_G_FREQUENCY, &freq2);
 		if (err < 0)
 			dprintk("VIDIOCGFREQ / VIDIOC_G_FREQUENCY: %d\n",err);
@@ -731,6 +731,7 @@
 	{
 		int *freq = arg;
 
+		freq2.tuner = 0;
 		drv(inode, file, VIDIOC_G_FREQUENCY, &freq2);
 		freq2.frequency = *freq;
 		err = drv(inode, file, VIDIOC_S_FREQUENCY, &freq2);
@@ -877,6 +878,7 @@
 			fmt2->fmt.pix.pixelformat =
 				palette_to_pixelformat(mm->format);
 			fmt2->fmt.pix.field = V4L2_FIELD_ANY;
+			fmt2->fmt.pix.bytesperline = 0;
 			err = drv(inode, file, VIDIOC_S_FMT, fmt2);
 			if (err < 0) {
 				dprintk("VIDIOCMCAPTURE / VIDIOC_S_FMT: %d\n",err);
@@ -895,7 +897,7 @@
 			dprintk("VIDIOCMCAPTURE / VIDIOC_QBUF: %d\n",err);
 			break;
 		}
-		err = drv(inode, file, VIDIOC_STREAMON, &buf2.type);
+		err = drv(inode, file, VIDIOC_STREAMON, NULL);
 		if (err < 0)
 			dprintk("VIDIOCMCAPTURE / VIDIOC_STREAMON: %d\n",err);
 		break;
@@ -989,7 +991,7 @@
 
 		if (fmt2->fmt.vbi.samples_per_line != fmt->samples_per_line ||
 		    fmt2->fmt.vbi.sampling_rate    != fmt->sampling_rate    ||
-		    fmt2->fmt.vbi.sample_format    != V4L2_PIX_FMT_GREY     ||
+		    VIDEO_PALETTE_RAW              != fmt->sample_format    ||
 		    fmt2->fmt.vbi.start[0]         != fmt->start[0]         ||
 		    fmt2->fmt.vbi.count[0]         != fmt->count[0]         ||
 		    fmt2->fmt.vbi.start[1]         != fmt->start[1]         ||
@@ -999,10 +1001,9 @@
 			break;
 		}
 		err = drv(inode, file, VIDIOC_S_FMT, fmt2);
-		if (err < 0) {
+		if (err < 0)
 			dprintk("VIDIOCSVBIFMT / VIDIOC_S_FMT: %d\n", err);
-			break;
-		}
+		break;
 	}
 	
 	default:
diff -u linux-2.6.1/drivers/media/video/v4l2-common.c linux/drivers/media/video/v4l2-common.c
--- linux-2.6.1/drivers/media/video/v4l2-common.c	2004-01-14 15:06:35.000000000 +0100
+++ linux/drivers/media/video/v4l2-common.c	2004-01-14 15:09:35.000000000 +0100
@@ -67,6 +67,7 @@
 #include <linux/ust.h>
 #endif
 
+
 #include <linux/videodev.h>
 
 MODULE_AUTHOR("Bill Dirks, Justin Schoeman, Gerd Knorr");
@@ -100,9 +101,11 @@
 int v4l2_video_std_construct(struct v4l2_standard *vs,
 			     int id, char *name)
 {
-	memset(vs, 0, sizeof(struct v4l2_standard));
+	u32 index = vs->index;
 
-	vs->id = id;
+	memset(vs, 0, sizeof(struct v4l2_standard));
+	vs->index = index;
+	vs->id    = id;
 	if (id & (V4L2_STD_NTSC | V4L2_STD_PAL_M)) {
 		vs->frameperiod.numerator = 1001;
 		vs->frameperiod.denominator = 30000;
@@ -118,6 +121,66 @@
 
 
 /* ----------------------------------------------------------------- */
+/* priority handling                                                 */
+
+#define V4L2_PRIO_VALID(val) (val == V4L2_PRIORITY_BACKGROUND   || \
+			      val == V4L2_PRIORITY_INTERACTIVE  || \
+			      val == V4L2_PRIORITY_RECORD)
+
+int v4l2_prio_init(struct v4l2_prio_state *global)
+{
+	memset(global,0,sizeof(*global));
+	return 0;
+}
+	
+int v4l2_prio_change(struct v4l2_prio_state *global, enum v4l2_priority *local,
+		     enum v4l2_priority new)
+{
+	if (!V4L2_PRIO_VALID(new))
+		return -EINVAL;
+	if (*local == new)
+		return 0;
+
+	atomic_inc(&global->prios[new]);
+	if (V4L2_PRIO_VALID(*local))
+		atomic_dec(&global->prios[*local]);
+	*local = new;
+	return 0;
+}
+
+int v4l2_prio_open(struct v4l2_prio_state *global, enum v4l2_priority *local)
+{
+	return v4l2_prio_change(global,local,V4L2_PRIORITY_DEFAULT);
+}
+
+int v4l2_prio_close(struct v4l2_prio_state *global, enum v4l2_priority *local)
+{
+	if (V4L2_PRIO_VALID(*local))
+		atomic_dec(&global->prios[*local]);
+	return 0;
+}
+
+enum v4l2_priority v4l2_prio_max(struct v4l2_prio_state *global)
+{
+	if (atomic_read(&global->prios[V4L2_PRIORITY_RECORD]) > 0)
+		return V4L2_PRIORITY_RECORD;
+	if (atomic_read(&global->prios[V4L2_PRIORITY_INTERACTIVE]) > 0)
+		return V4L2_PRIORITY_INTERACTIVE;
+	if (atomic_read(&global->prios[V4L2_PRIORITY_BACKGROUND]) > 0)
+		return V4L2_PRIORITY_BACKGROUND;
+	return V4L2_PRIORITY_UNSET;
+}
+
+int v4l2_prio_check(struct v4l2_prio_state *global, enum v4l2_priority *local)
+{
+	if (*local < v4l2_prio_max(global))
+		return -EBUSY;
+	return 0;
+}
+
+
+/* ----------------------------------------------------------------- */
+/* some arrays for pretty-printing debug messages                    */
 
 char *v4l2_field_names[] = {
 	[V4L2_FIELD_ANY]        = "any",
@@ -199,6 +262,13 @@
 EXPORT_SYMBOL(v4l2_video_std_fps);
 EXPORT_SYMBOL(v4l2_video_std_construct);
 
+EXPORT_SYMBOL(v4l2_prio_init);
+EXPORT_SYMBOL(v4l2_prio_change);
+EXPORT_SYMBOL(v4l2_prio_open);
+EXPORT_SYMBOL(v4l2_prio_close);
+EXPORT_SYMBOL(v4l2_prio_max);
+EXPORT_SYMBOL(v4l2_prio_check);
+
 EXPORT_SYMBOL(v4l2_field_names);
 EXPORT_SYMBOL(v4l2_type_names);
 EXPORT_SYMBOL(v4l2_ioctl_names);
diff -u linux-2.6.1/include/linux/videodev.h linux/include/linux/videodev.h
--- linux-2.6.1/include/linux/videodev.h	2004-01-14 15:07:01.000000000 +0100
+++ linux/include/linux/videodev.h	2004-01-14 15:09:35.000000000 +0100
@@ -3,7 +3,6 @@
 
 #include <linux/types.h>
 #include <linux/version.h>
-#include <linux/device.h>
 
 #define HAVE_V4L2 1
 #include <linux/videodev2.h>
@@ -12,6 +11,7 @@
 
 #include <linux/poll.h>
 #include <linux/mm.h>
+#include <linux/device.h>
 
 struct video_device
 {
@@ -429,7 +429,7 @@
 #define VID_HARDWARE_CPIA2	33
 #define VID_HARDWARE_VICAM      34
 #define VID_HARDWARE_SF16FMR2	35
-#define VID_HARDWARE_W9968CF	36	/* W996[87]CF JPEG USB Dual Mode Cam */
+#define VID_HARDWARE_W9968CF    36
 #endif /* __LINUX_VIDEODEV_H */
 
 /*
diff -u linux-2.6.1/include/linux/videodev2.h linux/include/linux/videodev2.h
--- linux-2.6.1/include/linux/videodev2.h	2004-01-14 15:09:35.000000000 +0100
+++ linux/include/linux/videodev2.h	2004-01-14 15:09:35.000000000 +0100
@@ -13,7 +13,9 @@
  *		Justin Schoeman
  *		et al.
  */
+#ifdef __KERNEL__
 #include <linux/time.h> /* need struct timeval */
+#endif
 
 /*
  *	M I S C E L L A N E O U S
@@ -111,6 +113,14 @@
 	V4L2_COLORSPACE_SRGB          = 8,
 };
 
+enum v4l2_priority {
+	V4L2_PRIORITY_UNSET       = 0,  /* not initialized */
+	V4L2_PRIORITY_BACKGROUND  = 1,
+	V4L2_PRIORITY_INTERACTIVE = 2,
+	V4L2_PRIORITY_RECORD      = 3,
+	V4L2_PRIORITY_DEFAULT     = V4L2_PRIORITY_INTERACTIVE,
+};
+
 struct v4l2_rect {
 	__s32   left;
 	__s32   top;
@@ -144,8 +154,9 @@
 #define V4L2_CAP_VBI_OUTPUT	0x00000020  /* Is a VBI output device */
 #define V4L2_CAP_RDS_CAPTURE	0x00000100  /* RDS data capture */
 
-#define V4L2_CAP_TUNER		0x00010000  /* Has a tuner */
+#define V4L2_CAP_TUNER		0x00010000  /* has a tuner */
 #define V4L2_CAP_AUDIO		0x00020000  /* has audio support */
+#define V4L2_CAP_RADIO		0x00040000  /* is a radio device */
 
 #define V4L2_CAP_READWRITE      0x01000000  /* read/write systemcalls */
 #define V4L2_CAP_ASYNCIO        0x02000000  /* async I/O */
@@ -203,7 +214,7 @@
 #define V4L2_PIX_FMT_MPEG     v4l2_fourcc('M','P','E','G') /* MPEG          */
 
 /*  Vendor-specific formats   */
-#define V4L2_PIX_FMT_WNVA    v4l2_fourcc('W','N','V','A') /* Winnov hw compres */
+#define V4L2_PIX_FMT_WNVA     v4l2_fourcc('W','N','V','A') /* Winnov hw compress */
 
 /*
  *	F O R M A T   E N U M E R A T I O N
@@ -264,6 +275,51 @@
 	__u32	keyframerate;
 	__u32	pframerate;
 	__u32	reserved[5];
+
+/*  what we'll need for MPEG, extracted from some postings on
+    the v4l list (Gert Vervoort, PlasmaJohn).
+
+system stream:
+  - type: elementary stream(ES), packatised elementary stream(s) (PES)
+    program stream(PS), transport stream(TS)
+  - system bitrate
+  - PS packet size (DVD: 2048 bytes, VCD: 2324 bytes)
+  - TS video PID
+  - TS audio PID
+  - TS PCR PID
+  - TS system information tables (PAT, PMT, CAT, NIT and SIT)
+  - (MPEG-1 systems stream vs. MPEG-2 program stream (TS not supported
+    by MPEG-1 systems)
+
+audio:
+  - type: MPEG (+Layer I,II,III), AC-3, LPCM
+  - bitrate
+  - sampling frequency (DVD: 48 Khz, VCD: 44.1 KHz, 32 kHz)
+  - Trick Modes? (ff, rew)
+  - Copyright
+  - Inverse Telecine
+
+video:
+  - picturesize (SIF, 1/2 D1, 2/3 D1, D1) and PAL/NTSC norm can be set
+    through excisting V4L2 controls
+  - noise reduction, parameters encoder specific?
+  - MPEG video version: MPEG-1, MPEG-2
+  - GOP (Group Of Pictures) definition:
+    - N: number of frames per GOP
+    - M: distance between reference (I,P) frames
+    - open/closed GOP
+  - quantiser matrix: inter Q matrix (64 bytes) and intra Q matrix (64 bytes)
+  - quantiser scale: linear or logarithmic
+  - scanning: alternate or zigzag
+  - bitrate mode: CBR (constant bitrate) or VBR (variable bitrate).
+  - target video bitrate for CBR
+  - target video bitrate for VBR
+  - maximum video bitrate for VBR - min. quantiser value for VBR
+  - max. quantiser value for VBR
+  - adaptive quantisation value
+  - return the number of bytes per GOP or bitrate for bitrate monitoring
+
+*/
 };
 #endif
 
@@ -822,6 +878,8 @@
 #define VIDIOC_TRY_FMT      	_IOWR ('V', 64, struct v4l2_format)
 #define VIDIOC_ENUMAUDIO	_IOWR ('V', 65, struct v4l2_audio)
 #define VIDIOC_ENUMAUDOUT	_IOWR ('V', 66, struct v4l2_audioout)
+#define VIDIOC_G_PRIORITY       _IOR  ('V', 67, enum v4l2_priority)
+#define VIDIOC_S_PRIORITY       _IOW  ('V', 68, enum v4l2_priority)
 
 /* for compatibility, will go away some day */
 #define VIDIOC_OVERLAY_OLD     	_IOWR ('V', 14, int)
@@ -847,17 +905,29 @@
 extern int v4l2_video_std_construct(struct v4l2_standard *vs,
 				    int id, char *name);
 
-/*  Compatibility layer interface  */
-typedef int (*v4l2_kioctl)(struct inode *inode, struct file *file,
-			   unsigned int cmd, void *arg);
-int v4l_compat_translate_ioctl(struct inode *inode, struct file *file,
-			       int cmd, void *arg, v4l2_kioctl driver_ioctl);
+/* prority handling */
+struct v4l2_prio_state {
+	atomic_t prios[4];
+};
+int v4l2_prio_init(struct v4l2_prio_state *global);
+int v4l2_prio_change(struct v4l2_prio_state *global, enum v4l2_priority *local,
+		     enum v4l2_priority new);
+int v4l2_prio_open(struct v4l2_prio_state *global, enum v4l2_priority *local);
+int v4l2_prio_close(struct v4l2_prio_state *global, enum v4l2_priority *local);
+enum v4l2_priority v4l2_prio_max(struct v4l2_prio_state *global);
+int v4l2_prio_check(struct v4l2_prio_state *global, enum v4l2_priority *local);
 
 /* names for fancy debug output */
 extern char *v4l2_field_names[];
 extern char *v4l2_type_names[];
 extern char *v4l2_ioctl_names[];
 
+/*  Compatibility layer interface  --  v4l1-compat module */
+typedef int (*v4l2_kioctl)(struct inode *inode, struct file *file,
+			   unsigned int cmd, void *arg);
+int v4l_compat_translate_ioctl(struct inode *inode, struct file *file,
+			       int cmd, void *arg, v4l2_kioctl driver_ioctl);
+
 #endif /* __KERNEL__ */
 #endif /* __LINUX_VIDEODEV2_H */
 

-- 
You have a new virus in /var/mail/kraxel
