Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbUKDL0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbUKDL0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbUKDL0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:26:06 -0500
Received: from sd291.sivit.org ([194.146.225.122]:24793 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262162AbUKDLRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:17:05 -0500
Date: Thu, 4 Nov 2004 12:17:19 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 9/12] meye: add v4l2 support
Message-ID: <20041104111718.GO3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2348, 2004-11-02 16:29:09+01:00, stelian@popies.net
  meye: add v4l2 support
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 Documentation/video4linux/meye.txt |   21 -
 drivers/media/video/meye.c         |  562 ++++++++++++++++++++++++++++++++++++-
 drivers/media/video/meye.h         |    3 
 include/linux/meye.h               |    7 
 4 files changed, 576 insertions(+), 17 deletions(-)

===================================================================

diff -Nru a/Documentation/video4linux/meye.txt b/Documentation/video4linux/meye.txt
--- a/Documentation/video4linux/meye.txt	2004-11-04 11:32:06 +01:00
+++ b/Documentation/video4linux/meye.txt	2004-11-04 11:32:06 +01:00
@@ -46,6 +46,8 @@
 module or meye.<param>=<value> on the kernel boot line when meye is
 statically linked into the kernel). Those options are:
 
+	forcev4l1:	force use of V4L1 API instead of V4L2
+
 	gbuffers:	number of capture buffers, default is 2 (32 max)
 
 	gbufsize:	size of each capture buffer, default is 614400
@@ -78,8 +80,9 @@
 Private API:
 ------------
 
-	The driver supports frame grabbing with the video4linux API, so
-	all video4linux tools (like xawtv) should work with this driver.
+	The driver supports frame grabbing with the video4linux API
+	(either v4l1 or v4l2), so all video4linux tools (like xawtv)
+	should work with this driver.
 
 	Besides the video4linux interface, the driver has a private interface
 	for accessing the Motion Eye extended parameters (camera sharpness,
@@ -121,13 +124,7 @@
 Bugs / Todo:
 ------------
 
-	- overlay output is not supported (although the camera is capable of).
-	  	(it should not be too hard to to it, provided we found how...)
-		
-	- mjpeg hardware playback doesn't work (depends on overlay...)
-
-	- rewrite the driver to use some common video4linux API for snapshot
-	  and mjpeg capture. Unfortunately, video4linux1 does not permit it,
-	  the BUZ API seems to be targeted to TV cards only. The video4linux 2
-	  API may be an option, if it goes into the kernel (maybe 2.5 
-	  material ?).
+	- the driver could be much cleaned up by removing the v4l1 support.
+	  However, this means all v4l1-only applications will stop working.
+
+	- 'motioneye' still uses the meye private v4l1 API extensions.
diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-04 11:32:06 +01:00
+++ b/drivers/media/video/meye.c	2004-11-04 11:32:06 +01:00
@@ -46,6 +46,11 @@
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEYE_DRIVER_VERSION);
 
+/* force usage of V4L1 API */
+static int forcev4l1; /* = 0 */
+module_param(forcev4l1, int, 0644);
+MODULE_PARM_DESC(forcev4l1, "force use of V4L1 instead of V4L2");
+
 /* number of grab buffers */
 static unsigned int gbuffers = 2;
 module_param(gbuffers, int, 0444);
@@ -781,6 +786,8 @@
 {
 	u32 v;
 	int reqnr;
+	static int sequence = 0;
+
 	v = mchip_read(MCHIP_MM_INTA);
 
 	if (meye.mchip_mode != MCHIP_HIC_MODE_CONT_OUT &&
@@ -802,6 +809,8 @@
 				      mchip_hsize() * mchip_vsize() * 2);
 		meye.grab_buffer[reqnr].size = mchip_hsize() * mchip_vsize() * 2;
 		meye.grab_buffer[reqnr].state = MEYE_BUF_DONE;
+		do_gettimeofday(&meye.grab_buffer[reqnr].timestamp);
+		meye.grab_buffer[reqnr].sequence = sequence++;
 		kfifo_put(meye.doneq, (unsigned char *)&reqnr, sizeof(int));
 		wake_up_interruptible(&meye.proc_list);
 	} else {
@@ -820,6 +829,8 @@
 		       size);
 		meye.grab_buffer[reqnr].size = size;
 		meye.grab_buffer[reqnr].state = MEYE_BUF_DONE;
+		do_gettimeofday(&meye.grab_buffer[reqnr].timestamp);
+		meye.grab_buffer[reqnr].sequence = sequence++;
 		kfifo_put(meye.doneq, (unsigned char *)&reqnr, sizeof(int));
 		wake_up_interruptible(&meye.proc_list);
 	}
@@ -1132,10 +1143,519 @@
 		break;
 	}
 
+	case VIDIOC_QUERYCAP: {
+		struct v4l2_capability *cap = arg;
+
+		if (forcev4l1)
+			return -EINVAL;
+
+		memset(cap, 0, sizeof(*cap));
+		strcpy(cap->driver, "meye");
+		strcpy(cap->card, "meye");
+		sprintf(cap->bus_info, "PCI:%s", meye.mchip_dev->slot_name);
+		cap->version = (MEYE_DRIVER_MAJORVERSION << 8) +
+			       MEYE_DRIVER_MINORVERSION;
+		cap->capabilities = V4L2_CAP_VIDEO_CAPTURE |
+				    V4L2_CAP_STREAMING;
+		break;
+	}
+
+	case VIDIOC_ENUMINPUT: {
+		struct v4l2_input *i = arg;
+
+		if (i->index != 0)
+			return -EINVAL;
+		memset(i, 0, sizeof(*i));
+		i->index = 0;
+		strcpy(i->name, "Camera");
+		i->type = V4L2_INPUT_TYPE_CAMERA;
+		break;
+	}
+
+	case VIDIOC_G_INPUT: {
+		int *i = arg;
+
+		*i = 0;
+		break;
+	}
+
+	case VIDIOC_S_INPUT: {
+		int *i = arg;
+
+		if (*i != 0)
+			return -EINVAL;
+		break;
+	}
+
+	case VIDIOC_QUERYCTRL: {
+		struct v4l2_queryctrl *c = arg;
+
+		switch (c->id) {
+
+		case V4L2_CID_BRIGHTNESS:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "Brightness");
+			c->minimum = 0;
+			c->maximum = 63;
+			c->step = 1;
+			c->default_value = 32;
+			c->flags = 0;
+			break;
+		case V4L2_CID_HUE:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "Hue");
+			c->minimum = 0;
+			c->maximum = 63;
+			c->step = 1;
+			c->default_value = 32;
+			c->flags = 0;
+			break;
+		case V4L2_CID_CONTRAST:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "Contrast");
+			c->minimum = 0;
+			c->maximum = 63;
+			c->step = 1;
+			c->default_value = 32;
+			c->flags = 0;
+			break;
+		case V4L2_CID_SATURATION:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "Saturation");
+			c->minimum = 0;
+			c->maximum = 63;
+			c->step = 1;
+			c->default_value = 32;
+			c->flags = 0;
+			break;
+		case V4L2_CID_AGC:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "Agc");
+			c->minimum = 0;
+			c->maximum = 63;
+			c->step = 1;
+			c->default_value = 48;
+			c->flags = 0;
+			break;
+		case V4L2_CID_SHARPNESS:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "Sharpness");
+			c->minimum = 0;
+			c->maximum = 63;
+			c->step = 1;
+			c->default_value = 32;
+			c->flags = 0;
+			break;
+		case V4L2_CID_PICTURE:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "Picture");
+			c->minimum = 0;
+			c->maximum = 63;
+			c->step = 1;
+			c->default_value = 0;
+			c->flags = 0;
+			break;
+		case V4L2_CID_JPEGQUAL:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "JPEG quality");
+			c->minimum = 0;
+			c->maximum = 10;
+			c->step = 1;
+			c->default_value = 8;
+			c->flags = 0;
+			break;
+		case V4L2_CID_FRAMERATE:
+			c->type = V4L2_CTRL_TYPE_INTEGER;
+			strcpy(c->name, "Framerate");
+			c->minimum = 0;
+			c->maximum = 31;
+			c->step = 1;
+			c->default_value = 0;
+			c->flags = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	}
+
+	case VIDIOC_S_CTRL: {
+		struct v4l2_control *c = arg;
+
+		down(&meye.lock);
+		switch (c->id) {
+
+		case V4L2_CID_BRIGHTNESS:
+			sonypi_camera_command(
+				SONYPI_COMMAND_SETCAMERABRIGHTNESS, c->value);
+			break;
+		case V4L2_CID_HUE:
+			sonypi_camera_command(
+				SONYPI_COMMAND_SETCAMERAHUE, c->value);
+			break;
+		case V4L2_CID_CONTRAST:
+			sonypi_camera_command(
+				SONYPI_COMMAND_SETCAMERACOLOR, c->value);
+			break;
+		case V4L2_CID_SATURATION:
+			sonypi_camera_command(
+				SONYPI_COMMAND_SETCAMERACOLOR, c->value);
+			break;
+		case V4L2_CID_AGC:
+			sonypi_camera_command(
+				SONYPI_COMMAND_SETCAMERAAGC, c->value);
+			break;
+		case V4L2_CID_SHARPNESS:
+			sonypi_camera_command(
+				SONYPI_COMMAND_SETCAMERASHARPNESS, c->value);
+			break;
+		case V4L2_CID_PICTURE:
+			sonypi_camera_command(
+				SONYPI_COMMAND_SETCAMERAPICTURE, c->value);
+			break;
+		case V4L2_CID_JPEGQUAL:
+			meye.params.quality = c->value;
+			break;
+		case V4L2_CID_FRAMERATE:
+			meye.params.framerate = c->value;
+			break;
+		default:
+			up(&meye.lock);
+			return -EINVAL;
+		}
+		up(&meye.lock);
+		break;
+	}
+
+	case VIDIOC_G_CTRL: {
+		struct v4l2_control *c = arg;
+
+		down(&meye.lock);
+		switch (c->id) {
+		case V4L2_CID_BRIGHTNESS:
+			c->value = sonypi_camera_command(
+				SONYPI_COMMAND_GETCAMERABRIGHTNESS, 0);
+			break;
+		case V4L2_CID_HUE:
+			c->value = sonypi_camera_command(
+				SONYPI_COMMAND_GETCAMERAHUE, 0);
+			break;
+		case V4L2_CID_CONTRAST:
+			c->value = sonypi_camera_command(
+				SONYPI_COMMAND_GETCAMERACOLOR, 0);
+			break;
+		case V4L2_CID_SATURATION:
+			c->value = sonypi_camera_command(
+				SONYPI_COMMAND_GETCAMERACOLOR, 0);
+			break;
+		case V4L2_CID_AGC:
+			c->value = sonypi_camera_command(
+				SONYPI_COMMAND_GETCAMERAAGC, 0);
+			break;
+		case V4L2_CID_SHARPNESS:
+			c->value = sonypi_camera_command(
+				SONYPI_COMMAND_GETCAMERASHARPNESS, 0);
+			break;
+		case V4L2_CID_PICTURE:
+			c->value = sonypi_camera_command(
+				SONYPI_COMMAND_GETCAMERAPICTURE, 0);
+			break;
+		case V4L2_CID_JPEGQUAL:
+			c->value = meye.params.quality;
+			break;
+		case V4L2_CID_FRAMERATE:
+			c->value = meye.params.framerate;
+			break;
+		default:
+			up(&meye.lock);
+			return -EINVAL;
+		}
+		up(&meye.lock);
+		break;
+	}
+
+	case VIDIOC_ENUM_FMT: {
+		struct v4l2_fmtdesc *f = arg;
+
+		if (f->index > 1)
+			return -EINVAL;
+		if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+			return -EINVAL;
+		if (f->index == 0) {
+			/* standard YUV 422 capture */
+			memset(f, 0, sizeof(*f));
+			f->index = 0;
+			f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+			f->flags = 0;
+			strcpy(f->description, "YUV422");
+			f->pixelformat = V4L2_PIX_FMT_YUYV;
+		} else {
+			/* compressed MJPEG capture */
+			memset(f, 0, sizeof(*f));
+			f->index = 1;
+			f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+			f->flags = V4L2_FMT_FLAG_COMPRESSED;
+			strcpy(f->description, "MJPEG");
+			f->pixelformat = V4L2_PIX_FMT_MJPEG;
+		}
+		break;
+	}
+
+	case VIDIOC_TRY_FMT: {
+		struct v4l2_format *f = arg;
+
+		if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+			return -EINVAL;
+		if (f->fmt.pix.pixelformat != V4L2_PIX_FMT_YUYV &&
+		    f->fmt.pix.pixelformat != V4L2_PIX_FMT_MJPEG)
+			return -EINVAL;
+		if (f->fmt.pix.field != V4L2_FIELD_ANY &&
+		    f->fmt.pix.field != V4L2_FIELD_NONE)
+			return -EINVAL;
+		f->fmt.pix.field = V4L2_FIELD_NONE;
+		if (f->fmt.pix.width <= 320) {
+			f->fmt.pix.width = 320;
+			f->fmt.pix.height = 240;
+		} else {
+			f->fmt.pix.width = 640;
+			f->fmt.pix.height = 480;
+		}
+		f->fmt.pix.bytesperline = f->fmt.pix.width * 2;
+		f->fmt.pix.sizeimage = f->fmt.pix.height *
+				       f->fmt.pix.bytesperline;
+		f->fmt.pix.colorspace = 0;
+		f->fmt.pix.priv = 0;
+		break;
+	}
+
+	case VIDIOC_G_FMT: {
+		struct v4l2_format *f = arg;
+
+		if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+			return -EINVAL;
+		memset(&f->fmt.pix, 0, sizeof(struct v4l2_pix_format));
+		f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		switch (meye.mchip_mode) {
+		case MCHIP_HIC_MODE_CONT_OUT:
+		default:
+			f->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
+			break;
+		case MCHIP_HIC_MODE_CONT_COMP:
+			f->fmt.pix.pixelformat = V4L2_PIX_FMT_MJPEG;
+			break;
+		}
+		f->fmt.pix.field = V4L2_FIELD_NONE;
+		f->fmt.pix.width = mchip_hsize();
+		f->fmt.pix.height = mchip_vsize();
+		f->fmt.pix.bytesperline = f->fmt.pix.width * 2;
+		f->fmt.pix.sizeimage = f->fmt.pix.height *
+				       f->fmt.pix.bytesperline;
+		f->fmt.pix.colorspace = 0;
+		f->fmt.pix.priv = 0;
+		break;
+	}
+
+	case VIDIOC_S_FMT: {
+		struct v4l2_format *f = arg;
+
+		if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+			return -EINVAL;
+		if (f->fmt.pix.pixelformat != V4L2_PIX_FMT_YUYV &&
+		    f->fmt.pix.pixelformat != V4L2_PIX_FMT_MJPEG)
+			return -EINVAL;
+		if (f->fmt.pix.field != V4L2_FIELD_ANY &&
+		    f->fmt.pix.field != V4L2_FIELD_NONE)
+			return -EINVAL;
+		f->fmt.pix.field = V4L2_FIELD_NONE;
+		down(&meye.lock);
+		if (f->fmt.pix.width <= 320) {
+			f->fmt.pix.width = 320;
+			f->fmt.pix.height = 240;
+			meye.params.subsample = 1;
+		} else {
+			f->fmt.pix.width = 640;
+			f->fmt.pix.height = 480;
+			meye.params.subsample = 0;
+		}
+		switch (f->fmt.pix.pixelformat) {
+		case V4L2_PIX_FMT_YUYV:
+			meye.mchip_mode = MCHIP_HIC_MODE_CONT_OUT;
+			break;
+		case V4L2_PIX_FMT_MJPEG:
+			meye.mchip_mode = MCHIP_HIC_MODE_CONT_COMP;
+			break;
+		}
+		up(&meye.lock);
+		f->fmt.pix.bytesperline = f->fmt.pix.width * 2;
+		f->fmt.pix.sizeimage = f->fmt.pix.height *
+				       f->fmt.pix.bytesperline;
+		f->fmt.pix.colorspace = 0;
+		f->fmt.pix.priv = 0;
+
+		break;
+	}
+
+	case VIDIOC_REQBUFS: {
+		struct v4l2_requestbuffers *req = arg;
+		int i;
+
+		if (req->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+			return -EINVAL;
+		if (req->memory != V4L2_MEMORY_MMAP)
+			return -EINVAL;
+		if (meye.grab_fbuffer && req->count == gbuffers) {
+			/* already allocated, no modifications */
+			break;
+		}
+		down(&meye.lock);
+		if (meye.grab_fbuffer) {
+			for (i = 0; i < gbuffers; i++)
+				if (meye.vma_use_count[i]) {
+					up(&meye.lock);
+					return -EINVAL;
+				}
+			rvfree(meye.grab_fbuffer, gbuffers * gbufsize);
+			meye.grab_fbuffer = NULL;
+		}
+		gbuffers = max(2, min((int)req->count, MEYE_MAX_BUFNBRS));
+		req->count = gbuffers;
+		meye.grab_fbuffer = rvmalloc(gbuffers * gbufsize);
+		if (!meye.grab_fbuffer) {
+			printk(KERN_ERR "meye: v4l framebuffer allocation"
+					" failed\n");
+			up(&meye.lock);
+			return -ENOMEM;
+		}
+		for (i = 0; i < gbuffers; i++)
+			meye.vma_use_count[i] = 0;
+		up(&meye.lock);
+		break;
+	}
+
+	case VIDIOC_QUERYBUF: {
+		struct v4l2_buffer *buf = arg;
+		int index = buf->index;
+
+		if (index < 0 || index >= gbuffers)
+			return -EINVAL;
+		memset(buf, 0, sizeof(*buf));
+		buf->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		buf->index = index;
+		buf->bytesused = meye.grab_buffer[index].size;
+		buf->flags = V4L2_BUF_FLAG_MAPPED;
+		if (meye.grab_buffer[index].state == MEYE_BUF_USING)
+			buf->flags |= V4L2_BUF_FLAG_QUEUED;
+		if (meye.grab_buffer[index].state == MEYE_BUF_DONE)
+			buf->flags |= V4L2_BUF_FLAG_DONE;
+		buf->field = V4L2_FIELD_NONE;
+		buf->timestamp = meye.grab_buffer[index].timestamp;
+		buf->sequence = meye.grab_buffer[index].sequence;
+		buf->memory = V4L2_MEMORY_MMAP;
+		buf->m.offset = index * gbufsize;
+		buf->length = gbufsize;
+		break;
+	}
+
+	case VIDIOC_QBUF: {
+		struct v4l2_buffer *buf = arg;
+
+		if (buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+			return -EINVAL;
+		if (buf->memory != V4L2_MEMORY_MMAP)
+			return -EINVAL;
+		if (buf->index < 0 || buf->index >= gbuffers)
+			return -EINVAL;
+		if (meye.grab_buffer[buf->index].state != MEYE_BUF_UNUSED)
+			return -EINVAL;
+		down(&meye.lock);
+		buf->flags |= V4L2_BUF_FLAG_QUEUED;
+		buf->flags &= ~V4L2_BUF_FLAG_DONE;
+		meye.grab_buffer[buf->index].state = MEYE_BUF_USING;
+		kfifo_put(meye.grabq, (unsigned char *)&buf->index, sizeof(int));
+		up(&meye.lock);
+		break;
+	}
+
+	case VIDIOC_DQBUF: {
+		struct v4l2_buffer *buf = arg;
+		int reqnr;
+
+		if (buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+			return -EINVAL;
+		if (buf->memory != V4L2_MEMORY_MMAP)
+			return -EINVAL;
+
+		down(&meye.lock);
+		if (kfifo_len(meye.doneq) == 0 && file->f_flags & O_NONBLOCK) {
+			up(&meye.lock);
+			return -EAGAIN;
+		}
+		if (wait_event_interruptible(meye.proc_list, 
+					     kfifo_len(meye.doneq) != 0) < 0) {
+			up(&meye.lock);
+			return -EINTR;
+		}
+		if (!kfifo_get(meye.doneq, (unsigned char *)&reqnr,
+			       sizeof(int))) {
+			up(&meye.lock);
+			return -EBUSY;
+		}
+		if (meye.grab_buffer[reqnr].state != MEYE_BUF_DONE) {
+			up(&meye.lock);
+			return -EINVAL;
+		}
+		buf->index = reqnr;
+		buf->bytesused = meye.grab_buffer[reqnr].size;
+		buf->flags = V4L2_BUF_FLAG_MAPPED;
+		buf->field = V4L2_FIELD_NONE;
+		buf->timestamp = meye.grab_buffer[reqnr].timestamp;
+		buf->sequence = meye.grab_buffer[reqnr].sequence;
+		buf->memory = V4L2_MEMORY_MMAP;
+		buf->m.offset = reqnr * gbufsize;
+		buf->length = gbufsize;
+		meye.grab_buffer[reqnr].state = MEYE_BUF_UNUSED;
+		up(&meye.lock);
+		break;
+	}
+
+	case VIDIOC_STREAMON: {
+		down(&meye.lock);
+		switch (meye.mchip_mode) {
+		case MCHIP_HIC_MODE_CONT_OUT:
+			mchip_continuous_start();
+			break;
+		case MCHIP_HIC_MODE_CONT_COMP:
+			mchip_cont_compression_start();
+			break;
+		default:
+			up(&meye.lock);
+			return -EINVAL;
+		}
+		up(&meye.lock);
+		break;
+	}
+
+	case VIDIOC_STREAMOFF: {
+		int i;
+
+		down(&meye.lock);
+		mchip_hic_stop();
+		kfifo_reset(meye.grabq);
+		kfifo_reset(meye.doneq);
+		for (i = 0; i < MEYE_MAX_BUFNBRS; i++)
+			meye.grab_buffer[i].state = MEYE_BUF_UNUSED;
+		up(&meye.lock);
+		break;
+	}
+
+	/* 
+	 * XXX what about private snapshot ioctls ?
+	 * Do they need to be converted to V4L2 ?
+	*/
+
 	default:
 		return -ENOIOCTLCMD;
-		
-	} /* switch */
+	}
 
 	return 0;
 }
@@ -1158,9 +1678,27 @@
 	return res;
 }
 
+static void meye_vm_open(struct vm_area_struct *vma)
+{
+	int idx = (int)vma->vm_private_data;
+	meye.vma_use_count[idx]++;
+}
+
+static void meye_vm_close(struct vm_area_struct *vma)
+{
+	int idx = (int)vma->vm_private_data;
+	meye.vma_use_count[idx]--;
+}
+
+static struct vm_operations_struct meye_vm_ops = {
+	.open		= meye_vm_open,
+	.close		= meye_vm_close,
+};
+
 static int meye_mmap(struct file *file, struct vm_area_struct *vma) {
 	unsigned long start = vma->vm_start;
-	unsigned long size  = vma->vm_end - vma->vm_start;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long page, pos;
 
 	down(&meye.lock);
@@ -1169,6 +1707,8 @@
 		return -EINVAL;
 	}
 	if (!meye.grab_fbuffer) {
+		int i;
+
 		/* lazy allocation */
 		meye.grab_fbuffer = rvmalloc(gbuffers*gbufsize);
 		if (!meye.grab_fbuffer) {
@@ -1176,8 +1716,10 @@
 			up(&meye.lock);
 			return -ENOMEM;
 		}
+		for (i = 0; i < gbuffers; i++)
+			meye.vma_use_count[i] = 0;
 	}
-	pos = (unsigned long)meye.grab_fbuffer;
+	pos = (unsigned long)meye.grab_fbuffer + offset;
 
 	while (size > 0) {
 		page = vmalloc_to_pfn((void *)pos);
@@ -1187,8 +1729,18 @@
 		}
 		start += PAGE_SIZE;
 		pos += PAGE_SIZE;
-		size -= PAGE_SIZE;
+		if (size > PAGE_SIZE)
+			size -= PAGE_SIZE;
+		else
+			size = 0;
 	}
+
+	vma->vm_ops = &meye_vm_ops;
+	vma->vm_flags &= ~VM_IO;	/* not I/O memory */
+	vma->vm_flags |= VM_RESERVED;	/* avoid to swap out this VMA */
+	vma->vm_private_data = (void *) (offset / gbufsize);
+	meye_vm_open(vma);
+
 	up(&meye.lock);
 	return 0;
 }
diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	2004-11-04 11:32:05 +01:00
+++ b/drivers/media/video/meye.h	2004-11-04 11:32:06 +01:00
@@ -279,6 +279,8 @@
 struct meye_grab_buffer {
 	int state;			/* state of buffer */
 	unsigned long size;		/* size of jpg frame */
+	struct timeval timestamp;	/* timestamp */
+	unsigned long sequence;		/* sequence number */
 };
 
 /* size of kfifos containings buffer indices */
@@ -302,6 +304,7 @@
 	unsigned char *grab_temp;	/* temporary buffer */
 					/* list of buffers */
 	struct meye_grab_buffer grab_buffer[MEYE_MAX_BUFNBRS];
+	int vma_use_count[MEYE_MAX_BUFNBRS]; /* mmap count */
 
 	/* other */
 	struct semaphore lock;		/* semaphore for open/mmap... */
diff -Nru a/include/linux/meye.h b/include/linux/meye.h
--- a/include/linux/meye.h	2004-11-04 11:32:05 +01:00
+++ b/include/linux/meye.h	2004-11-04 11:32:05 +01:00
@@ -56,4 +56,11 @@
 /* get a jpeg compressed snapshot */
 #define MEYEIOC_STILLJCAPT	_IOR ('v', BASE_VIDIOCPRIVATE+5, int)
 
+/* V4L2 private controls */
+#define V4L2_CID_AGC		V4L2_CID_PRIVATE_BASE
+#define V4L2_CID_SHARPNESS	(V4L2_CID_PRIVATE_BASE + 1)
+#define V4L2_CID_PICTURE	(V4L2_CID_PRIVATE_BASE + 2)
+#define V4L2_CID_JPEGQUAL	(V4L2_CID_PRIVATE_BASE + 3)
+#define V4L2_CID_FRAMERATE	(V4L2_CID_PRIVATE_BASE + 4)
+
 #endif
