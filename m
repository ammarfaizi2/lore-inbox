Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263838AbTCUTiL>; Fri, 21 Mar 2003 14:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263879AbTCUTh7>; Fri, 21 Mar 2003 14:37:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1669
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263874AbTCUTf4>; Fri, 21 Mar 2003 14:35:56 -0500
Date: Fri, 21 Mar 2003 20:51:10 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212051.h2LKpACi026551@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: cpia -maintainers update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/cpia.c linux-2.5.65-ac2/drivers/media/video/cpia.c
--- linux-2.5.65/drivers/media/video/cpia.c	2003-02-10 18:38:46.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/cpia.c	2003-03-06 23:46:22.000000000 +0000
@@ -23,7 +23,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-/* #define _CPIA_DEBUG_		define for verbose debug output */
+/* define _CPIA_DEBUG_ for verbose debug output (see cpia.h) */
+/* #define _CPIA_DEBUG_  1 */  
+
 #include <linux/config.h>
 
 #include <linux/module.h>
@@ -1796,7 +1798,7 @@
 
 	retval = cam->ops->transferCmd(cam->lowlevel_data, cmd, data);
 	if (retval)
-		LOG("%x - failed\n", command);
+		DBG("%x - failed\n", command);
 
 	return retval;
 }
@@ -2174,7 +2176,7 @@
 		}
 		if (ll == 1) {
 			if (*ibuf != EOL) {
-				LOG("EOL not found giving up after %d/%d"
+				DBG("EOL not found giving up after %d/%d"
 				    " bytes\n", origsize-size, origsize);
 				return -1;
 			}
@@ -3158,7 +3160,8 @@
 
 static void put_cam(struct cpia_camera_ops* ops)
 {
-	module_put(ops->owner);
+	if (ops->owner)
+		module_put(ops->owner);
 }
 
 /* ------------------------- V4L interface --------------------- */
@@ -3173,16 +3176,15 @@
 		return -ENODEV;
 	}
 
+	if (cam->open_count > 0) {
+		DBG("Camera already open\n");
+		return -EBUSY;
+	}
+
 	if (!try_module_get(cam->ops->owner))
 		return -ENODEV;
 
 	down(&cam->busy_lock);
-	err = -EBUSY;
-	if (cam->open_count > 0) {
-		DBG("Camera already open\n");
-		goto oops;
-	}
-	
 	err = -ENOMEM;
 	if (!cam->raw_image) {
 		cam->raw_image = rvmalloc(CPIA_MAX_IMAGE_SIZE);
@@ -3206,10 +3208,11 @@
 		cam->ops->close(cam->lowlevel_data);
 		goto oops;
 	}
-
-	if(signal_pending(current))
-		return -EINTR;
 	
+	err = -EINTR;
+	if(signal_pending(current))
+		goto oops;
+
 	/* Set ownership of /proc/cpia/videoX to current user */
 	if(cam->proc_entry)
 		cam->proc_entry->uid = current->uid;
@@ -3451,6 +3454,14 @@
 			cam->params.colourParams.contrast = 80;
 		}
 
+		/* Adjust flicker control if necessary */
+		if(cam->params.flickerControl.allowableOverExposure < 0)
+			cam->params.flickerControl.allowableOverExposure = 
+				-find_over_exposure(cam->params.colourParams.brightness);
+		if(cam->params.flickerControl.flickerMode != 0)
+			cam->cmd_queue |= COMMAND_SETFLICKERCTRL;
+		
+
 		/* queue command to update camera */
 		cam->cmd_queue |= COMMAND_SETCOLOURPARAMS;
 		up(&cam->param_lock);
@@ -3600,7 +3611,7 @@
 	{
 		int *frame = arg;
 
-		//DBG("VIDIOCSYNC: %d\n", frame);
+		//DBG("VIDIOCSYNC: %d\n", *frame);
 
 		if (*frame<0 || *frame >= FRAME_NUM) {
 			retval = -EINVAL;
@@ -3628,52 +3639,53 @@
 	}
 
 	case VIDIOCGCAPTURE:
+	{
+		struct video_capture *vc = arg;
+
 		DBG("VIDIOCGCAPTURE\n");
-		if (copy_to_user(arg, &cam->vc, sizeof(struct video_capture)))
-			retval = -EFAULT;
+
+		*vc = cam->vc;
+
 		break;
+	}	
 
 	case VIDIOCSCAPTURE:
 	{
-		struct video_capture vc;
+		struct video_capture *vc = arg;
 
 		DBG("VIDIOCSCAPTURE\n");
-		if (copy_from_user(&vc, arg, sizeof(vc))) {
-			retval = -EFAULT;
-			break;
-		}
 
-		if (vc.decimation != 0) {    /* How should this be used? */
+		if (vc->decimation != 0) {    /* How should this be used? */
 			retval = -EINVAL;
 			break;
 		}
-		if (vc.flags != 0) {     /* Even/odd grab not supported */
+		if (vc->flags != 0) {     /* Even/odd grab not supported */
 			retval = -EINVAL;
 			break;
 		}
 		
 		/* Clip to the resolution we can set for the ROI
 		   (every 8 columns and 4 rows) */
-		vc.x      = vc.x      & ~(__u32)7;
-		vc.y      = vc.y      & ~(__u32)3;
-		vc.width  = vc.width  & ~(__u32)7;
-		vc.height = vc.height & ~(__u32)3;
-
-		if(vc.width == 0 || vc.height == 0 ||
-		   vc.x + vc.width  > cam->vw.width ||
-		   vc.y + vc.height > cam->vw.height) {
+		vc->x      = vc->x      & ~(__u32)7;
+		vc->y      = vc->y      & ~(__u32)3;
+		vc->width  = vc->width  & ~(__u32)7;
+		vc->height = vc->height & ~(__u32)3;
+
+		if(vc->width == 0 || vc->height == 0 ||
+		   vc->x + vc->width  > cam->vw.width ||
+		   vc->y + vc->height > cam->vw.height) {
 			retval = -EINVAL;
 			break;
 		}
 
-		DBG("%d,%d/%dx%d\n", vc.x,vc.y,vc.width, vc.height);
+		DBG("%d,%d/%dx%d\n", vc->x,vc->y,vc->width, vc->height);
 		
 		down(&cam->param_lock);
 		
-		cam->vc.x      = vc.x;
-		cam->vc.y      = vc.y;
-		cam->vc.width  = vc.width;
-		cam->vc.height = vc.height;
+		cam->vc.x      = vc->x;
+		cam->vc.y      = vc->y;
+		cam->vc.width  = vc->width;
+		cam->vc.height = vc->height;
 		
 		set_vw_size(cam);
 		cam->cmd_queue |= COMMAND_SETFORMAT;
@@ -3688,16 +3700,20 @@
 	
 	case VIDIOCGUNIT:
 	{
-		struct video_unit vu;
-		vu.video    = cam->vdev.minor;
-		vu.vbi      = VIDEO_NO_UNIT;
-		vu.radio    = VIDEO_NO_UNIT;
-		vu.audio    = VIDEO_NO_UNIT;
-		vu.teletext = VIDEO_NO_UNIT;
+		struct video_unit *vu = arg;
+
+		DBG("VIDIOCGUNIT\n");
+
+		vu->video    = cam->vdev.minor;
+		vu->vbi      = VIDEO_NO_UNIT;
+		vu->radio    = VIDEO_NO_UNIT;
+		vu->audio    = VIDEO_NO_UNIT;
+		vu->teletext = VIDEO_NO_UNIT;
+
 		break;
 	}
-		
 
+		
 	/* pointless to implement overlay with this camera */
 	case VIDIOCCAPTURE:
 	case VIDIOCGFBUF:
@@ -3728,12 +3744,13 @@
 	return video_usercopy(inode, file, cmd, arg, cpia_do_ioctl);
 }
 
+
 /* FIXME */
 static int cpia_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct video_device *dev = file->private_data;
 	unsigned long start = vma->vm_start;
-	unsigned long size  = vma->vm_end-vma->vm_start;
+	unsigned long size  = vma->vm_end - vma->vm_start;
 	unsigned long page, pos;
 	struct cam_data *cam = dev->priv;
 	int retval;
@@ -3956,9 +3973,6 @@
 		printk(KERN_DEBUG "video_register_device failed\n");
 		return NULL;
 	}
-#ifdef CONFIG_PROC_FS
-	create_proc_cpia_cam(camera);
-#endif
 
 	/* get version information from camera: open/reset/close */
 
@@ -3975,6 +3989,10 @@
 	/* close cpia */
 	camera->ops->close(camera->lowlevel_data);
 
+#ifdef CONFIG_PROC_FS
+	create_proc_cpia_cam(camera);
+#endif
+
 	printk(KERN_INFO "  CPiA Version: %d.%02d (%d.%d)\n",
 	       camera->params.version.firmwareVersion,
 	       camera->params.version.firmwareRevision,
@@ -3997,6 +4015,7 @@
 	DBG("unregistering video\n");
 	video_unregister_device(&cam->vdev);
 	if (cam->open_count) {
+		put_cam(cam->ops);
 		DBG("camera open -- setting ops to NULL\n");
 		cam->ops = NULL;
 	}
@@ -4019,9 +4038,6 @@
 	proc_cpia_create();
 #endif
 
-#ifdef CONFIG_VIDEO_CPIA_PP
-	cpia_pp_init();
-#endif
 #ifdef CONFIG_KMOD
 #ifdef CONFIG_VIDEO_CPIA_PP_MODULE
 	request_module("cpia_pp");
@@ -4031,6 +4047,10 @@
 	request_module("cpia_usb");
 #endif
 #endif	/* CONFIG_KMOD */
+
+#ifdef CONFIG_VIDEO_CPIA_PP
+	cpia_pp_init();
+#endif
 #ifdef CONFIG_VIDEO_CPIA_USB
 	cpia_usb_init();
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/cpia.h linux-2.5.65-ac2/drivers/media/video/cpia.h
--- linux-2.5.65/drivers/media/video/cpia.h	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/cpia.h	2003-03-06 23:46:22.000000000 +0000
@@ -27,12 +27,16 @@
  */
 
 #define CPIA_MAJ_VER	1
-#define CPIA_MIN_VER    2
-#define CPIA_PATCH_VER	2
+#define CPIA_MIN_VER   2
+#define CPIA_PATCH_VER	3
 
-#define CPIA_PP_MAJ_VER       1
-#define CPIA_PP_MIN_VER       2
-#define CPIA_PP_PATCH_VER     2
+#define CPIA_PP_MAJ_VER       CPIA_MAJ_VER
+#define CPIA_PP_MIN_VER       CPIA_MIN_VER
+#define CPIA_PP_PATCH_VER     CPIA_PATCH_VER
+
+#define CPIA_USB_MAJ_VER      CPIA_MAJ_VER
+#define CPIA_USB_MIN_VER      CPIA_MIN_VER
+#define CPIA_USB_PATCH_VER    CPIA_PATCH_VER
 
 #define CPIA_MAX_FRAME_SIZE_UNALIGNED	(352 * 288 * 4)   /* CIF at RGB32 */
 #define CPIA_MAX_FRAME_SIZE	((CPIA_MAX_FRAME_SIZE_UNALIGNED + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1)) /* align above to PAGE_SIZE */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/cpia_pp.c linux-2.5.65-ac2/drivers/media/video/cpia_pp.c
--- linux-2.5.65/drivers/media/video/cpia_pp.c	2003-02-10 18:37:56.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/cpia_pp.c	2003-03-06 23:46:22.000000000 +0000
@@ -22,6 +22,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+/* define _CPIA_DEBUG_ for verbose debug output (see cpia.h) */
+/* #define _CPIA_DEBUG_  1 */  
+
 #include <linux/config.h>
 #include <linux/version.h>
 
@@ -34,6 +37,7 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/smp_lock.h>
+#include <linux/sched.h>
 
 #include <linux/kmod.h>
 
@@ -49,68 +53,10 @@
 static int cpia_pp_streamRead(void *privdata, u8 *buffer, int noblock);
 static int cpia_pp_close(void *privdata);
 
-#define ABOUT "Parallel port driver for Vision CPiA based cameras"
 
-/* IEEE 1284 Compatiblity Mode signal names 	*/
-#define nStrobe		PARPORT_CONTROL_STROBE	  /* inverted */
-#define nAutoFd		PARPORT_CONTROL_AUTOFD	  /* inverted */
-#define nInit		PARPORT_CONTROL_INIT
-#define nSelectIn	PARPORT_CONTROL_SELECT
-#define IntrEnable	PARPORT_CONTROL_INTEN	  /* normally zero for no IRQ */
-#define DirBit		PARPORT_CONTROL_DIRECTION /* 0 = Forward, 1 = Reverse	*/
-
-#define nFault		PARPORT_STATUS_ERROR
-#define Select		PARPORT_STATUS_SELECT
-#define PError		PARPORT_STATUS_PAPEROUT
-#define nAck		PARPORT_STATUS_ACK
-#define Busy		PARPORT_STATUS_BUSY	  /* inverted */	
-
-/* some more */
-#define HostClk		nStrobe
-#define HostAck		nAutoFd
-#define nReverseRequest	nInit
-#define Active_1284	nSelectIn
-#define nPeriphRequest	nFault
-#define XFlag		Select
-#define nAckReverse	PError
-#define PeriphClk	nAck
-#define PeriphAck	Busy
-
-/* these can be used to correct for the inversion on some bits */
-#define STATUS_INVERSION_MASK	(Busy)
-#define CONTROL_INVERSION_MASK	(nStrobe|nAutoFd|nSelectIn)
-
-#define ECR_empty	0x01
-#define ECR_full	0x02
-#define ECR_serviceIntr 0x04
-#define ECR_dmaEn	0x08
-#define ECR_nErrIntrEn	0x10
-
-#define ECR_mode_mask	0xE0
-#define ECR_SPP_mode	0x00
-#define ECR_PS2_mode	0x20
-#define ECR_FIFO_mode	0x40
-#define ECR_ECP_mode	0x60
-
-#define ECP_FIFO_SIZE	16
-#define DMA_BUFFER_SIZE               PAGE_SIZE
-	/* for 16bit DMA make sure DMA_BUFFER_SIZE is 16 bit aligned */
-#define PARPORT_CHUNK_SIZE	PAGE_SIZE/* >=2.3.x */
-				/* we read this many bytes at once */
-
-#define GetECRMasked(port,mask)	(parport_read_econtrol(port) & (mask))
-#define GetStatus(port)		((parport_read_status(port)^STATUS_INVERSION_MASK)&(0xf8))
-#define SetStatus(port,val)	parport_write_status(port,(val)^STATUS_INVERSION_MASK)
-#define GetControl(port)	((parport_read_control(port)^CONTROL_INVERSION_MASK)&(0x3f))
-#define SetControl(port,val)	parport_write_control(port,(val)^CONTROL_INVERSION_MASK)
-
-#define GetStatusMasked(port,mask)	(GetStatus(port) & (mask))
-#define GetControlMasked(port,mask)	(GetControl(port) & (mask))
-#define SetControlMasked(port,mask)	SetControl(port,GetControl(port) | (mask));
-#define ClearControlMasked(port,mask)	SetControl(port,GetControl(port)&~(mask));
-#define FrobControlBit(port,mask,value)	SetControl(port,(GetControl(port)&~(mask))|((value)&(mask)));
+#define ABOUT "Parallel port driver for Vision CPiA based cameras"
 
-#define PACKET_LENGTH 	8
+#define PACKET_LENGTH  8
 
 /* Magic numbers for defining port-device mappings */
 #define PPCPIA_PARPORT_UNSPEC -4
@@ -162,30 +108,7 @@
 };
 
 static LIST_HEAD(cam_list);
-static spinlock_t cam_list_lock_pp = SPIN_LOCK_UNLOCKED;
-
-#ifdef _CPIA_DEBUG_
-#define DEB_PORT(port) { \
-u8 controll = GetControl(port); \
-u8 statusss = GetStatus(port); \
-DBG("nsel %c per %c naut %c nstrob %c nak %c busy %c nfaul %c sel %c init %c dir %c\n",\
-((controll & nSelectIn)	? 'U' : 'D'), \
-((statusss & PError)	? 'U' : 'D'), \
-((controll & nAutoFd)	? 'U' : 'D'), \
-((controll & nStrobe)	? 'U' : 'D'), \
-((statusss & nAck)	? 'U' : 'D'), \
-((statusss & Busy)	? 'U' : 'D'), \
-((statusss & nFault)	? 'U' : 'D'), \
-((statusss & Select)	? 'U' : 'D'), \
-((controll & nInit)	? 'U' : 'D'), \
-((controll & DirBit)	? 'R' : 'F')  \
-); }
-#else
-#define DEB_PORT(port) {}
-#endif
-
-#define WHILE_OUT_TIMEOUT (HZ/10)
-#define DMA_TIMEOUT 10*HZ
+static spinlock_t cam_list_lock_pp;
 
 /* FIXME */
 static void cpia_parport_enable_irq( struct parport *port ) {
@@ -200,6 +123,205 @@
 	return;
 }
 
+/* Special CPiA PPC modes: These are invoked by using the 1284 Extensibility
+ * Link Flag during negotiation */  
+#define UPLOAD_FLAG  0x08
+#define NIBBLE_TRANSFER 0x01
+#define ECP_TRANSFER 0x03
+
+#define PARPORT_CHUNK_SIZE	PAGE_SIZE
+
+
+/****************************************************************************
+ *
+ *  CPiA-specific  low-level parport functions for nibble uploads
+ *
+ ***************************************************************************/
+/*  CPiA nonstandard "Nibble" mode (no nDataAvail signal after each byte). */
+/* The standard kernel parport_ieee1284_read_nibble() fails with the CPiA... */
+
+static size_t cpia_read_nibble (struct parport *port, 
+			 void *buffer, size_t len, 
+			 int flags)
+{
+	/* adapted verbatim, with one change, from 
+	   parport_ieee1284_read_nibble() in drivers/parport/ieee1284-ops.c */
+
+	unsigned char *buf = buffer;
+	int i;
+	unsigned char byte = 0;
+	
+	len *= 2; /* in nibbles */
+	for (i=0; i < len; i++) {
+		unsigned char nibble;
+
+		/* The CPiA firmware suppresses the use of nDataAvail (nFault LO)
+		 * after every second nibble to signal that more
+		 * data is available.  (the total number of Bytes that
+		 * should be sent is known; if too few are received, an error
+		 * will be recorded after a timeout).  
+		 * This is incompatible with parport_ieee1284_read_nibble(),
+		 * which expects to find nFault LO after every second nibble.
+		 */
+
+		/* Solution: modify cpia_read_nibble to only check for 
+		 * nDataAvail before the first nibble is sent.
+		 */
+
+		/* Does the error line indicate end of data? */
+		if (((i /*& 1*/) == 0) &&
+		    (parport_read_status(port) & PARPORT_STATUS_ERROR)) {
+			port->physport->ieee1284.phase = IEEE1284_PH_HBUSY_DNA;
+				DBG("%s: No more nibble data (%d bytes)\n",
+				port->name, i/2);
+
+			/* Go to reverse idle phase. */
+			parport_frob_control (port,
+					      PARPORT_CONTROL_AUTOFD,
+					      PARPORT_CONTROL_AUTOFD);
+			port->physport->ieee1284.phase = IEEE1284_PH_REV_IDLE;
+			break;
+		}
+
+		/* Event 7: Set nAutoFd low. */
+		parport_frob_control (port,
+				      PARPORT_CONTROL_AUTOFD,
+				      PARPORT_CONTROL_AUTOFD);
+
+		/* Event 9: nAck goes low. */
+		port->ieee1284.phase = IEEE1284_PH_REV_DATA;
+		if (parport_wait_peripheral (port,
+					     PARPORT_STATUS_ACK, 0)) {
+			/* Timeout -- no more data? */
+				 DBG("%s: Nibble timeout at event 9 (%d bytes)\n",
+				 port->name, i/2);
+			parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
+			break;
+		}
+
+
+		/* Read a nibble. */
+		nibble = parport_read_status (port) >> 3;
+		nibble &= ~8;
+		if ((nibble & 0x10) == 0)
+			nibble |= 8;
+		nibble &= 0xf;
+
+		/* Event 10: Set nAutoFd high. */
+		parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
+
+		/* Event 11: nAck goes high. */
+		if (parport_wait_peripheral (port,
+					     PARPORT_STATUS_ACK,
+					     PARPORT_STATUS_ACK)) {
+			/* Timeout -- no more data? */
+			DBG("%s: Nibble timeout at event 11\n",
+				 port->name);
+			break;
+		}
+
+		if (i & 1) {
+			/* Second nibble */
+			byte |= nibble << 4;
+			*buf++ = byte;
+		} else 
+			byte = nibble;
+	}
+
+	i /= 2; /* i is now in bytes */
+
+	if (i == len) {
+		/* Read the last nibble without checking data avail. */
+		port = port->physport;
+		if (parport_read_status (port) & PARPORT_STATUS_ERROR)
+			port->ieee1284.phase = IEEE1284_PH_HBUSY_DNA;
+		else
+			port->ieee1284.phase = IEEE1284_PH_HBUSY_DAVAIL;
+	}
+
+	return i;
+}
+
+/* CPiA nonstandard "Nibble Stream" mode (2 nibbles per cycle, instead of 1)
+ * (See CPiA Data sheet p. 31) 
+ * 
+ * "Nibble Stream" mode used by CPiA for uploads to non-ECP ports is a 
+ * nonstandard variant of nibble mode which allows the same (mediocre) 
+ * data flow of 8 bits per cycle as software-enabled ECP by TRISTATE-capable 
+ * parallel ports, but works also for  non-TRISTATE-capable ports.
+ * (Standard nibble mode only send 4 bits per cycle)
+ *
+ */
+
+static size_t cpia_read_nibble_stream(struct parport *port, 
+			       void *buffer, size_t len, 
+			       int flags)
+{
+	int i;
+	unsigned char *buf = buffer;
+	int endseen = 0;
+
+	for (i=0; i < len; i++) {
+		unsigned char nibble[2], byte = 0;
+		int j;
+
+		/* Image Data is complete when 4 consecutive EOI bytes (0xff) are seen */ 
+		if (endseen > 3 )
+			break;
+
+		/* Event 7: Set nAutoFd low. */
+		parport_frob_control (port,
+				      PARPORT_CONTROL_AUTOFD,
+				      PARPORT_CONTROL_AUTOFD);
+		
+		/* Event 9: nAck goes low. */
+		port->ieee1284.phase = IEEE1284_PH_REV_DATA;
+		if (parport_wait_peripheral (port,
+					     PARPORT_STATUS_ACK, 0)) {
+			/* Timeout -- no more data? */
+				 DBG("%s: Nibble timeout at event 9 (%d bytes)\n",
+				 port->name, i/2);
+			parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
+			break;
+		}
+
+		/* Read lower nibble */
+		nibble[0] = parport_read_status (port) >>3;
+		
+		/* Event 10: Set nAutoFd high. */
+		parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
+
+		/* Event 11: nAck goes high. */
+		if (parport_wait_peripheral (port,
+					     PARPORT_STATUS_ACK,
+					     PARPORT_STATUS_ACK)) {
+			/* Timeout -- no more data? */
+			DBG("%s: Nibble timeout at event 11\n",
+				 port->name);
+			break;
+		}
+		
+		/* Read upper nibble */
+		nibble[1] = parport_read_status (port) >>3;
+		
+		/* reassemble the byte */
+		for (j = 0; j < 2 ; j++ ) {
+			nibble[j] &= ~8;
+			if ((nibble[j] & 0x10) == 0)
+				nibble[j] |= 8;
+			nibble[j] &= 0xf;
+		}
+		byte = (nibble[0] |(nibble[1] << 4));
+		*buf++ = byte;
+
+		if(byte == EOI)
+		  endseen++;
+		else
+		  endseen = 0;
+	}
+	return i;
+}
+
 /****************************************************************************
  *
  *  EndTransferMode
@@ -219,20 +341,25 @@
 {
 	int retry;
 	
-	/* After some commands the camera needs extra time before
-	 * it will respond again, so we try up to 3 times */
-	for(retry=0; retry<3; ++retry) {
+	/* The CPiA uses ECP protocol for Downloads from the Host to the camera. 
+	 * This will be software-emulated if ECP hardware is not present
+	 */
+
+	/* the usual camera maximum response time is 10ms, but after receiving
+	 * some commands, it needs up to 40ms. (Data Sheet p. 32)*/
+
+	for(retry = 0; retry < 4; ++retry) {
 		if(!parport_negotiate(cam->port, IEEE1284_MODE_ECP)) {
 			break;
 		}
+		mdelay(10);
 	}
-	if(retry == 3) {
-		DBG("Unable to negotiate ECP mode\n");
+	if(retry == 4) {
+		DBG("Unable to negotiate IEEE1284 ECP Download mode\n");
 		return -1;
 	}
 	return 0;
 }
-
 /****************************************************************************
  *
  *  ReverseSetup
@@ -241,24 +368,35 @@
 static int ReverseSetup(struct pp_cam_entry *cam, int extensibility)
 {
 	int retry;
-	int mode = IEEE1284_MODE_ECP;
-	if(extensibility) mode = 8|3|IEEE1284_EXT_LINK;
+	int upload_mode, mode = IEEE1284_MODE_ECP;
+	int transfer_mode = ECP_TRANSFER;
+
+	if (!(cam->port->modes & PARPORT_MODE_ECP) &&
+	     !(cam->port->modes & PARPORT_MODE_TRISTATE)) {
+		mode = IEEE1284_MODE_NIBBLE;
+		transfer_mode = NIBBLE_TRANSFER;
+	}
 
-	/* After some commands the camera needs extra time before
-	 * it will respond again, so we try up to 3 times */
-	for(retry=0; retry<3; ++retry) {
+	upload_mode = mode;
+	if(extensibility) mode = UPLOAD_FLAG|transfer_mode|IEEE1284_EXT_LINK;
+
+	/* the usual camera maximum response time is 10ms, but after 
+	 * receiving some commands, it needs up to 40ms. */
+		
+	for(retry = 0; retry < 4; ++retry) {
 		if(!parport_negotiate(cam->port, mode)) {
 			break;
 		}
+		mdelay(10);
 	}
-	if(retry == 3) {
+	if(retry == 4) {
 		if(extensibility)
-			DBG("Unable to negotiate extensibility mode\n");
+			DBG("Unable to negotiate upload extensibility mode\n");
 		else
-			DBG("Unable to negotiate ECP mode\n");
+			DBG("Unable to negotiate upload mode\n");
 		return -1;
 	}
-	if(extensibility) cam->port->ieee1284.mode = IEEE1284_MODE_ECP;
+	if(extensibility) cam->port->ieee1284.mode = upload_mode;
 	return 0;
 }
 
@@ -296,14 +434,21 @@
 static int ReadPacket(struct pp_cam_entry *cam, u8 *packet, size_t size)
 {
 	int retval=0;
+
 	if (packet == NULL) {
 		return -EINVAL;
 	}
 	if (ReverseSetup(cam, 0)) {
 		return -EIO;
 	}
-	if(parport_read(cam->port, packet, size) != size) {
-		retval = -EIO;
+
+	/* support for CPiA variant nibble reads */
+	if(cam->port->ieee1284.mode == IEEE1284_MODE_NIBBLE) {
+		if(cpia_read_nibble(cam->port, packet, size, 0) != size) 
+			retval = -EIO;			
+	} else {
+		if(parport_read(cam->port, packet, size) != size) 
+			retval = -EIO;
 	}
 	EndTransferMode(cam);
 	return retval;
@@ -347,11 +492,29 @@
  *  cpia_pp_streamRead
  *
  ***************************************************************************/
+static int cpia_pp_read(struct parport *port, u8 *buffer, int len)
+{
+	int bytes_read;
+
+	/* support for CPiA variant "nibble stream" reads */
+	if(port->ieee1284.mode == IEEE1284_MODE_NIBBLE)
+		bytes_read = cpia_read_nibble_stream(port,buffer,len,0);
+	else {
+		int new_bytes;
+		for(bytes_read=0; bytes_read<len; bytes_read += new_bytes) {
+			new_bytes = parport_read(port, buffer+bytes_read,
+						 len-bytes_read);
+			if(new_bytes < 0) break;
+		}
+	}
+	return bytes_read;
+}
+
 static int cpia_pp_streamRead(void *privdata, u8 *buffer, int noblock)
 {
 	struct pp_cam_entry *cam = privdata;
 	int read_bytes = 0;
-	int i, endseen;
+	int i, endseen, block_size, new_bytes;
 
 	if(cam == NULL) {
 		DBG("Internal driver error: cam is NULL\n");
@@ -380,27 +543,36 @@
 			return -EIO;
 		}
 	}
-	read_bytes = parport_read(cam->port, buffer, CPIA_MAX_IMAGE_SIZE );
-
-	EndTransferMode(cam);
-	DBG("read %d bytes\n", read_bytes);
-	if( read_bytes<0) return -EIO;
 	endseen = 0;
-	for( i=0; i<read_bytes && endseen<4; i++ ) {
-	  if( *buffer==EOI ) {
-	    endseen++;
-	  } else {
-	    endseen=0;
-	  }
-	  buffer++;
-	}
-	if( endseen>3 ) {
-	  cam->image_complete=1;
-	  DBG("endseen at %d bytes\n", i);
- 	}
+	block_size = PARPORT_CHUNK_SIZE;
+	while( !cam->image_complete ) {
+		cond_resched();
+		
+		new_bytes = cpia_pp_read(cam->port, buffer, block_size );
+		if( new_bytes <= 0 ) {
+			break;
+		}
+		i=-1;
+		while(++i<new_bytes && endseen<4) {
+	        	if(*buffer==EOI) {
+	                	endseen++;
+	                } else {
+	                	endseen=0;
+	                }
+			buffer++;
+		}
+		read_bytes += i;
+		if( endseen==4 ) {
+			cam->image_complete=1;
+			break;
+		}
+		if( CPIA_MAX_IMAGE_SIZE-read_bytes <= PARPORT_CHUNK_SIZE ) {
+			block_size=CPIA_MAX_IMAGE_SIZE-read_bytes;
+		}
+	}
+	EndTransferMode(cam);
 	return cam->image_complete ? read_bytes : -EIO;
 }
-
 /****************************************************************************
  *
  *  cpia_pp_transferCmd
@@ -530,9 +702,8 @@
 	struct pp_cam_entry *cam;
 	struct cam_data *cpia;
 
-	if (!(port->modes & PARPORT_MODE_ECP) &&
-	    !(port->modes & PARPORT_MODE_TRISTATE)) {
-		LOG("port is not ECP capable\n");
+	if (!(port->modes & PARPORT_MODE_PCSPP)) {
+		LOG("port is not supported by CPiA driver\n");
 		return -ENXIO;
 	}
 
@@ -575,29 +746,33 @@
 static void cpia_pp_detach (struct parport *port)
 {
 	struct list_head *tmp;
-	struct cam_data *cpia;
+	struct cam_data *cpia = NULL;
 	struct pp_cam_entry *cam;
 
 	spin_lock( &cam_list_lock_pp );
 	list_for_each (tmp, &cam_list) {
 		cpia = list_entry(tmp, struct cam_data, cam_data_list);
-		cam = cpia->lowlevel_data;
+		cam = (struct pp_cam_entry *) cpia->lowlevel_data;
 		if (cam && cam->port->number == port->number) {
 			list_del(&cpia->cam_data_list);
-			cpia_unregister_camera(cpia);
-			
-			if(cam->open_count > 0) {
-				cpia_pp_close(cam);
-			}
-
-			parport_unregister_device(cam->pdev);
-		
-			kfree(cam);
-			cpia->lowlevel_data = NULL;
 			break;
 		}
+		cpia = NULL;
 	}
 	spin_unlock( &cam_list_lock_pp );			
+
+	if (!cpia) {
+		DBG("cpia_pp_detach failed to find cam_data in cam_list\n");
+		return;
+	}
+	
+	cam = (struct pp_cam_entry *) cpia->lowlevel_data;	
+	cpia_unregister_camera(cpia);
+	if(cam->open_count > 0) 
+		cpia_pp_close(cam);
+	parport_unregister_device(cam->pdev);
+	cpia->lowlevel_data = NULL;	
+	kfree(cam);
 }
 
 static void cpia_pp_attach (struct parport *port)
@@ -645,11 +820,12 @@
 		return 0;
 	}
 	
+	spin_lock_init( &cam_list_lock_pp );
+
 	if (parport_register_driver (&cpia_pp_driver)) {
 		LOG ("unable to register with parport\n");
 		return -EIO;
 	}
-	
 	return 0;
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/cpia_usb.c linux-2.5.65-ac2/drivers/media/video/cpia_usb.c
--- linux-2.5.65/drivers/media/video/cpia_usb.c	2003-02-10 18:37:56.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/cpia_usb.c	2003-03-06 23:46:22.000000000 +0000
@@ -21,11 +21,13 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+/* define _CPIA_DEBUG_ for verbose debug output (see cpia.h) */
+/* #define _CPIA_DEBUG_  1 */  
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/wait.h>
-#include <linux/sched.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -105,7 +107,7 @@
 };
 
 static LIST_HEAD(cam_list);
-static spinlock_t cam_list_lock_usb = SPIN_LOCK_UNLOCKED;
+static spinlock_t cam_list_lock_usb;
 
 static void cpia_usb_complete(struct urb *urb, struct pt_regs *regs)
 {
@@ -464,12 +466,14 @@
 {
 	struct usb_cpia *ucpia = (struct usb_cpia *) privdata;
 
-	ucpia->open = 0;
+	if(!ucpia)
+		return -ENODEV;
 
-	cpia_usb_free_resources(ucpia, 1);
+	ucpia->open = 0;
 
-	if (!ucpia->present)
-		kfree(ucpia);
+	/* ucpia->present = 0 protects against trying to reset the
+	 * alt setting if camera is physically disconnected while open */
+	cpia_usb_free_resources(ucpia, ucpia->present);
 
 	return 0;
 }
@@ -565,7 +569,7 @@
 	vfree(ucpia->buffers[0]);
 	ucpia->buffers[0] = NULL;
 fail_alloc_0:
-
+	kfree(ucpia);
 	return -EIO;
 }
 
@@ -588,9 +592,6 @@
 	.id_table	= cpia_id_table,
 };
 
-/* don't use dev, it may be NULL! (see usb_cpia_cleanup) */
-/* _disconnect from usb_cpia_cleanup is not necessary since usb_deregister */
-/* will do it for us as well as passing a udev structure - jerdfelt */
 static void cpia_disconnect(struct usb_interface *intf)
 {
 	struct cam_data *cam = usb_get_intfdata(intf);
@@ -606,12 +607,11 @@
 	list_del(&cam->cam_data_list);
 	spin_unlock( &cam_list_lock_usb );
 	
-	/* Don't even try to reset the altsetting if we're disconnected */
-	cpia_usb_free_resources(ucpia, 0);
-
 	ucpia->present = 0;
 
 	cpia_unregister_camera(cam);
+	if(ucpia->open)
+		cpia_usb_close(cam->lowlevel_data);
 
 	ucpia->curbuff->status = FRAME_ERROR;
 
@@ -639,29 +639,25 @@
 		ucpia->buffers[0] = NULL;
 	}
 
-	if (!ucpia->open) {
- 		kfree(ucpia);
-		cam->lowlevel_data = NULL;
-	}
+	cam->lowlevel_data = NULL;
+	kfree(ucpia);
 }
 
 static int __init usb_cpia_init(void)
 {
+	printk(KERN_INFO "%s v%d.%d.%d\n",ABOUT, 
+	       CPIA_USB_MAJ_VER,CPIA_USB_MIN_VER,CPIA_USB_PATCH_VER);
+
+	spin_lock_init(&cam_list_lock_usb);
 	return usb_register(&cpia_driver);
 }
 
 static void __exit usb_cpia_cleanup(void)
 {
-/*
-	struct cam_data *cam;
-
-	while ((cam = cam_list) != NULL)
-		cpia_disconnect(NULL, cam);
-*/
-
 	usb_deregister(&cpia_driver);
 }
 
 
 module_init (usb_cpia_init);
 module_exit (usb_cpia_cleanup);
+
