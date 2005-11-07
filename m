Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVKGDQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVKGDQs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVKGDQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:16:36 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:45142 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932421AbVKGDQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:26 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: [Patch 07/20] V4L(907) Em28xx cleanups and fixes
Date: Mon, 07 Nov 2005 00:58:08 -0200
Message-Id: <1131333341.25215.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

- Em28xx cleanups and fixes.
- Some cleanups and audio amux adjust.
- em28xx will allways try, by default, the biggest size alt.
- Fixes audio mux code.
- Fixes some logs.
- Adds support for digital output for WinTV USB2 board.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/em28xx/em28xx-cards.c |   15 ++-
 drivers/media/video/em28xx/em28xx-core.c  |   17 ---
 drivers/media/video/em28xx/em28xx-video.c |  107 ++++++++++++----------
 drivers/media/video/msp3400.c             |  142 +++++++++++++++++++++++++++---
 include/linux/videodev2.h                 |    1 
 5 files changed, 201 insertions(+), 81 deletions(-)

--- hg.orig/drivers/media/video/em28xx/em28xx-cards.c
+++ hg/drivers/media/video/em28xx/em28xx-cards.c
@@ -128,7 +128,7 @@ struct em28xx_board em28xx_boards[] = {
 		.input          = {{
 			.type     = EM28XX_VMUX_TELEVISION,
 			.vmux     = 0,
-			.amux     = 0,
+			.amux     = 6,
 		},{
 			.type     = EM28XX_VMUX_SVIDEO,
 			.vmux     = 2,
@@ -261,9 +261,11 @@ void em28xx_card_setup(struct em28xx *de
 	/* request some modules */
 	if (dev->model == EM2820_BOARD_HAUPPAUGE_WINTV_USB_2) {
 		struct tveeprom tv;
+		struct v4l2_audioout ao;
 #ifdef CONFIG_MODULES
 		request_module("tveeprom");
 		request_module("ir-kbd-i2c");
+		request_module("msp3400");
 #endif
 		/* Call first TVeeprom */
 
@@ -273,10 +275,13 @@ void em28xx_card_setup(struct em28xx *de
 		dev->tuner_type= tv.tuner_type;
 		if (tv.audio_processor == AUDIO_CHIP_MSP34XX) {
 			dev->has_msp34xx=1;
-		} else dev->has_msp34xx=0;
-		em28xx_write_regs_req(dev,0x06,0x00,"\x40",1);// Serial Bus Frequency Select Register
-		em28xx_write_regs_req(dev,0x0f,0x00,"\x87",1);// XCLK Frequency Select Register
-		em28xx_write_regs_req(dev,0x88,0x0d,"\xd0",1);
+			memset (&ao,0,sizeof(ao));
+
+			ao.index=2;
+			ao.mode=V4L2_AUDMODE_32BITS;
+			em28xx_i2c_call_clients(dev, VIDIOC_S_AUDOUT, &ao);
+		} else
+			dev->has_msp34xx=0;
 	}
 }
 
--- hg.orig/drivers/media/video/em28xx/em28xx-core.c
+++ hg/drivers/media/video/em28xx/em28xx-core.c
@@ -797,20 +797,9 @@ int em28xx_set_alternate(struct em28xx *
 	dev->alt = alt;
 	if (dev->alt == 0) {
 		int i;
-		if(dev->is_em2800){ /* always use the max packet size for em2800 based devices */
-			for(i=0;i< EM28XX_MAX_ALT; i++)
-				if(dev->alt_max_pkt_size[i]>dev->alt_max_pkt_size[dev->alt])
-					dev->alt=i;
-		}else{
-		unsigned int min_pkt_size = dev->field_size / 137;	/* FIXME: empiric magic number */
-		em28xx_coredbg("minimum isoc packet size: %u", min_pkt_size);
-		dev->alt = 7;
-		for (i = 1; i < EM28XX_MAX_ALT; i += 2)	/* FIXME: skip even alternate: why do they not work? */
-			if (dev->alt_max_pkt_size[i] >= min_pkt_size) {
-			dev->alt = i;
-			break;
-			}
-		}
+		for(i=0;i< EM28XX_MAX_ALT; i++)
+			if(dev->alt_max_pkt_size[i]>dev->alt_max_pkt_size[dev->alt])
+				dev->alt=i;
 	}
 
 	if (dev->alt != prev_alt) {
--- hg.orig/drivers/media/video/em28xx/em28xx-video.c
+++ hg/drivers/media/video/em28xx/em28xx-video.c
@@ -277,6 +277,35 @@ static void em28xx_empty_framequeues(str
 	}
 }
 
+static void video_mux(struct em28xx *dev, int index)
+{
+	int input, ainput;
+
+	input = INPUT(index)->vmux;
+	dev->ctl_input = index;
+	dev->ctl_ainput = INPUT(index)->amux;
+
+	em28xx_i2c_call_clients(dev, DECODER_SET_INPUT, &input);
+
+
+	em28xx_videodbg("Setting input index=%d, vmux=%d, amux=%d\n",index,input,dev->ctl_ainput);
+
+	if (dev->has_msp34xx) {
+		em28xx_i2c_call_clients(dev, VIDIOC_S_AUDIO, &dev->ctl_ainput);
+		ainput = EM28XX_AUDIO_SRC_TUNER;
+		em28xx_audio_source(dev, ainput);
+	} else {
+		switch (dev->ctl_ainput) {
+		case 0:
+			ainput = EM28XX_AUDIO_SRC_TUNER;
+			break;
+		default:
+			ainput = EM28XX_AUDIO_SRC_LINE;
+		}
+		em28xx_audio_source(dev, ainput);
+	}
+}
+
 /*
  * em28xx_v4l2_open()
  * inits the device and starts isoc transfer
@@ -298,7 +327,7 @@ static int em28xx_v4l2_open(struct inode
 	filp->private_data=dev;
 
 
-	em28xx_videodbg("users=%d", dev->users);
+	em28xx_videodbg("users=%d\n", dev->users);
 
 	if (!down_read_trylock(&em28xx_disconnect))
 		return -ERESTARTSYS;
@@ -352,6 +381,8 @@ static int em28xx_v4l2_open(struct inode
 
 	dev->state |= DEV_INITIALIZED;
 
+	video_mux(dev, 0);
+
       err:
 	up(&dev->lock);
 	up_read(&em28xx_disconnect);
@@ -386,7 +417,7 @@ static int em28xx_v4l2_close(struct inod
 	int errCode;
 	struct em28xx *dev=filp->private_data;
 
-	em28xx_videodbg("users=%d", dev->users);
+	em28xx_videodbg("users=%d\n", dev->users);
 
 	down(&dev->lock);
 
@@ -404,7 +435,7 @@ static int em28xx_v4l2_close(struct inod
 
 	/* set alternate 0 */
 	dev->alt = 0;
-	em28xx_videodbg("setting alternate 0");
+	em28xx_videodbg("setting alternate 0\n");
 	errCode = usb_set_interface(dev->udev, 0, 0);
 	if (errCode < 0) {
 		em28xx_errdev ("cannot change alternate number to 0 (error=%i)\n",
@@ -434,20 +465,20 @@ em28xx_v4l2_read(struct file *filp, char
 		return -ERESTARTSYS;
 
 	if (dev->state & DEV_DISCONNECTED) {
-		em28xx_videodbg("device not present");
+		em28xx_videodbg("device not present\n");
 		up(&dev->fileop_lock);
 		return -ENODEV;
 	}
 
 	if (dev->state & DEV_MISCONFIGURED) {
-		em28xx_videodbg("device misconfigured; close and open it again");
+		em28xx_videodbg("device misconfigured; close and open it again\n");
 		up(&dev->fileop_lock);
 		return -EIO;
 	}
 
 	if (dev->io == IO_MMAP) {
 		em28xx_videodbg ("IO method is set to mmap; close and open"
-				" the device again to choose the read method");
+				" the device again to choose the read method\n");
 		up(&dev->fileop_lock);
 		return -EINVAL;
 	}
@@ -524,9 +555,9 @@ static unsigned int em28xx_v4l2_poll(str
 		return POLLERR;
 
 	if (dev->state & DEV_DISCONNECTED) {
-		em28xx_videodbg("device not present");
+		em28xx_videodbg("device not present\n");
 	} else if (dev->state & DEV_MISCONFIGURED) {
-		em28xx_videodbg("device is misconfigured; close and open it again");
+		em28xx_videodbg("device is misconfigured; close and open it again\n");
 	} else {
 		if (dev->io == IO_NONE) {
 			if (!em28xx_request_buffers
@@ -595,14 +626,14 @@ static int em28xx_v4l2_mmap(struct file 
 		return -ERESTARTSYS;
 
 	if (dev->state & DEV_DISCONNECTED) {
-		em28xx_videodbg("mmap: device not present");
+		em28xx_videodbg("mmap: device not present\n");
 		up(&dev->fileop_lock);
 		return -ENODEV;
 	}
 
 	if (dev->state & DEV_MISCONFIGURED) {
 		em28xx_videodbg ("mmap: Device is misconfigured; close and "
-						"open it again");
+						"open it again\n");
 		up(&dev->fileop_lock);
 		return -EIO;
 	}
@@ -618,7 +649,7 @@ static int em28xx_v4l2_mmap(struct file 
 			break;
 	}
 	if (i == dev->num_frames) {
-		em28xx_videodbg("mmap: user supplied mapping address is out of range");
+		em28xx_videodbg("mmap: user supplied mapping address is out of range\n");
 		up(&dev->fileop_lock);
 		return -EINVAL;
 	}
@@ -632,7 +663,7 @@ static int em28xx_v4l2_mmap(struct file 
 		page = vmalloc_to_pfn((void *)pos);
 		if (remap_pfn_range(vma, start, page, PAGE_SIZE,
 				    vma->vm_page_prot)) {
-			em28xx_videodbg("mmap: rename page map failed");
+			em28xx_videodbg("mmap: rename page map failed\n");
 			up(&dev->fileop_lock);
 			return -EAGAIN;
 		}
@@ -749,7 +780,7 @@ static int em28xx_stream_interrupt(struc
 	else if (ret) {
 		dev->state |= DEV_MISCONFIGURED;
 		em28xx_videodbg("device is misconfigured; close and "
-			"open /dev/video%d again", dev->vdev->minor);
+			"open /dev/video%d again\n", dev->vdev->minor);
 		return ret;
 	}
 
@@ -800,28 +831,6 @@ static int em28xx_set_norm(struct em28xx
 	return 0;
 }
 
-static void video_mux(struct em28xx *dev, int index)
-{
-	int input, ainput;
-
-	input = INPUT(index)->vmux;
-	dev->ctl_input = index;
-
-	em28xx_i2c_call_clients(dev, DECODER_SET_INPUT, &input);
-
-	dev->ctl_ainput = INPUT(index)->amux;
-
-	switch (dev->ctl_ainput) {
-	case 0:
-		ainput = EM28XX_AUDIO_SRC_TUNER;
-		break;
-	default:
-		ainput = EM28XX_AUDIO_SRC_LINE;
-	}
-
-	em28xx_audio_source(dev, ainput);
-}
-
 /*
  * em28xx_v4l2_do_ioctl()
  * This function is _not_ called directly, but from
@@ -1062,7 +1071,7 @@ static int em28xx_do_ioctl(struct inode 
 			t->signal =
 			    (status & DECODER_STATUS_GOOD) != 0 ? 0xffff : 0;
 
-			em28xx_videodbg("VIDIO_G_TUNER: signal=%x, afc=%x", t->signal,
+			em28xx_videodbg("VIDIO_G_TUNER: signal=%x, afc=%x\n", t->signal,
 				 t->afc);
 			return 0;
 		}
@@ -1146,7 +1155,7 @@ static int em28xx_do_ioctl(struct inode 
 
 			dev->stream = STREAM_ON;	/* FIXME: Start video capture here? */
 
-			em28xx_videodbg("VIDIOC_STREAMON: starting stream");
+			em28xx_videodbg("VIDIOC_STREAMON: starting stream\n");
 
 			return 0;
 		}
@@ -1160,7 +1169,7 @@ static int em28xx_do_ioctl(struct inode 
 				return -EINVAL;
 
 			if (dev->stream == STREAM_ON) {
-				em28xx_videodbg ("VIDIOC_STREAMOFF: interrupting stream");
+				em28xx_videodbg ("VIDIOC_STREAMOFF: interrupting stream\n");
 				if ((ret = em28xx_stream_interrupt(dev)))
 					return ret;
 			}
@@ -1234,7 +1243,7 @@ static int em28xx_video_do_ioctl(struct 
 		{
 			struct v4l2_format *format = arg;
 
-			em28xx_videodbg("VIDIOC_G_FMT: type=%s",
+			em28xx_videodbg("VIDIOC_G_FMT: type=%s\n",
 				 format->type ==
 				 V4L2_BUF_TYPE_VIDEO_CAPTURE ?
 				 "V4L2_BUF_TYPE_VIDEO_CAPTURE" : format->type ==
@@ -1253,7 +1262,7 @@ static int em28xx_video_do_ioctl(struct 
 			format->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
 			format->fmt.pix.field = dev->interlaced ? V4L2_FIELD_INTERLACED : V4L2_FIELD_TOP;	/* FIXME: TOP? NONE? BOTTOM? ALTENATE? */
 
-			em28xx_videodbg("VIDIOC_G_FMT: %dx%d", dev->width,
+			em28xx_videodbg("VIDIOC_G_FMT: %dx%d\n", dev->width,
 				 dev->height);
 			return 0;
 		}
@@ -1274,7 +1283,7 @@ static int em28xx_video_do_ioctl(struct 
 
 /*		int both_fields; */
 
-			em28xx_videodbg("%s: type=%s",
+			em28xx_videodbg("%s: type=%s\n",
 				 cmd ==
 				 VIDIOC_TRY_FMT ? "VIDIOC_TRY_FMT" :
 				 "VIDIOC_S_FMT",
@@ -1288,7 +1297,7 @@ static int em28xx_video_do_ioctl(struct 
 			if (format->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 				return -EINVAL;
 
-			em28xx_videodbg("%s: requested %dx%d",
+			em28xx_videodbg("%s: requested %dx%d\n",
 				 cmd ==
 				 VIDIOC_TRY_FMT ? "VIDIOC_TRY_FMT" :
 				 "VIDIOC_S_FMT", format->fmt.pix.width,
@@ -1347,7 +1356,7 @@ static int em28xx_video_do_ioctl(struct 
 			format->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
 			format->fmt.pix.field = V4L2_FIELD_INTERLACED;
 
-			em28xx_videodbg("%s: returned %dx%d (%d, %d)",
+			em28xx_videodbg("%s: returned %dx%d (%d, %d)\n",
 				 cmd ==
 				 VIDIOC_TRY_FMT ? "VIDIOC_TRY_FMT" :
 				 "VIDIOC_S_FMT", format->fmt.pix.width,
@@ -1359,13 +1368,13 @@ static int em28xx_video_do_ioctl(struct 
 			for (i = 0; i < dev->num_frames; i++)
 				if (dev->frame[i].vma_use_count) {
 					em28xx_videodbg("VIDIOC_S_FMT failed. "
-						"Unmap the buffers first.");
+						"Unmap the buffers first.\n");
 					return -EINVAL;
 				}
 
 			/* stop io in case it is already in progress */
 			if (dev->stream == STREAM_ON) {
-				em28xx_videodbg("VIDIOC_SET_FMT: interupting stream");
+				em28xx_videodbg("VIDIOC_SET_FMT: interupting stream\n");
 				if ((ret = em28xx_stream_interrupt(dev)))
 					return ret;
 			}
@@ -1405,18 +1414,18 @@ static int em28xx_video_do_ioctl(struct 
 			if (dev->io == IO_READ) {
 				em28xx_videodbg ("method is set to read;"
 					" close and open the device again to"
-					" choose the mmap I/O method");
+					" choose the mmap I/O method\n");
 				return -EINVAL;
 			}
 
 			for (i = 0; i < dev->num_frames; i++)
 				if (dev->frame[i].vma_use_count) {
-					em28xx_videodbg ("VIDIOC_REQBUFS failed; previous buffers are still mapped");
+					em28xx_videodbg ("VIDIOC_REQBUFS failed; previous buffers are still mapped\n");
 					return -EINVAL;
 				}
 
 			if (dev->stream == STREAM_ON) {
-				em28xx_videodbg("VIDIOC_REQBUFS: interrupting stream");
+				em28xx_videodbg("VIDIOC_REQBUFS: interrupting stream\n");
 				if ((ret = em28xx_stream_interrupt(dev)))
 					return ret;
 			}
@@ -1430,7 +1439,7 @@ static int em28xx_video_do_ioctl(struct 
 
 			dev->frame_current = NULL;
 
-			em28xx_videodbg ("VIDIOC_REQBUFS: setting io method to mmap: num bufs %i",
+			em28xx_videodbg ("VIDIOC_REQBUFS: setting io method to mmap: num bufs %i\n",
 						     rb->count);
 			dev->io = rb->count ? IO_MMAP : IO_NONE;
 			return 0;
--- hg.orig/drivers/media/video/msp3400.c
+++ hg/drivers/media/video/msp3400.c
@@ -90,6 +90,8 @@ struct msp3400c {
 	int stereo;
 	int nicam_on;
 	int acb;
+	int in_scart;
+	int i2s_mode;
 	int main, second;	/* sound carrier */
 	int input;
 	int source;             /* see msp34xxg_set_source */
@@ -364,12 +366,40 @@ static struct CARRIER_DETECT carrier_det
 
 #define CARRIER_COUNT(x) (sizeof(x)/sizeof(struct CARRIER_DETECT))
 
-/* ----------------------------------------------------------------------- */
+/* ----------------------------------------------------------------------- *
+ * bits  9  8  5 - SCART DSP input Select:
+ *       0  0  0 - SCART 1 to DSP input (reset position)
+ *       0  1  0 - MONO to DSP input
+ *       1  0  0 - SCART 2 to DSP input
+ *       1  1  1 - Mute DSP input
+ *
+ * bits 11 10  6 - SCART 1 Output Select:
+ *       0  0  0 - undefined (reset position)
+ *       0  1  0 - SCART 2 Input to SCART 1 Output (for devices with 2 SCARTS)
+ *       1  0  0 - MONO input to SCART 1 Output
+ *       1  1  0 - SCART 1 DA to SCART 1 Output
+ *       0  0  1 - SCART 2 DA to SCART 1 Output
+ *       0  1  1 - SCART 1 Input to SCART 1 Output
+ *       1  1  1 - Mute SCART 1 Output
+ *
+ * bits 13 12  7 - SCART 2 Output Select (for devices with 2 Output SCART):
+ *       0  0  0 - SCART 1 DA to SCART 2 Output (reset position)
+ *       0  1  0 - SCART 1 Input to SCART 2 Output
+ *       1  0  0 - MONO input to SCART 2 Output
+ *       0  0  1 - SCART 2 DA to SCART 2 Output
+ *       0  1  1 - SCART 2 Input to SCART 2 Output
+ *       1  1  0 - Mute SCART 2 Output
+ *
+ * Bits 4 to 0 should be zero.
+ * ----------------------------------------------------------------------- */
 
 static int scarts[3][9] = {
 	/* MASK    IN1     IN2     IN1_DA  IN2_DA  IN3     IN4     MONO    MUTE   */
+	/* SCART DSP Input select */
 	{ 0x0320, 0x0000, 0x0200, -1,     -1,     0x0300, 0x0020, 0x0100, 0x0320 },
+	/* SCART1 Output select */
 	{ 0x0c40, 0x0440, 0x0400, 0x0c00, 0x0040, 0x0000, 0x0840, 0x0800, 0x0c40 },
+	/* SCART2 Output select */
 	{ 0x3080, 0x1000, 0x1080, 0x0000, 0x0080, 0x2080, 0x3080, 0x2000, 0x3000 },
 };
 
@@ -381,13 +411,23 @@ static void msp3400c_set_scart(struct i2
 {
 	struct msp3400c *msp = i2c_get_clientdata(client);
 
-	if (-1 == scarts[out][in])
-		return;
+	msp->in_scart=in;
+
+	if (in<=2) {
+		if (-1 == scarts[out][in])
+			return;
+
+		msp->acb &= ~scarts[out][SCART_MASK];
+		msp->acb |=  scarts[out][in];
+	} else
+		msp->acb = 0xf60; /* Mute Input and SCART 1 Output */
+
+	dprintk("msp34xx: scart switch: %s => %d (ACB=0x%04x)\n",
+						scart_names[in], out, msp->acb);
+	msp3400c_write(client,I2C_MSP3400C_DFP, 0x13, msp->acb);
 
-	dprintk("msp34xx: scart switch: %s => %d\n", scart_names[in], out);
-	msp->acb &= ~scarts[out][SCART_MASK];
-	msp->acb |=  scarts[out][in];
-	msp3400c_write(client,I2C_MSP3400C_DFP, 0x0013, msp->acb);
+	/* Sets I2S speed 0 = 1.024 Mbps, 1 = 2.048 Mbps */
+	msp3400c_write(client,I2C_MSP3400C_DEM, 0x40, msp->i2s_mode);
 }
 
 /* ------------------------------------------------------------------------ */
@@ -1235,7 +1275,8 @@ static int msp3410d_thread(void *data)
 		msp3400c_setbass(client, msp->bass);
 		msp3400c_settreble(client, msp->treble);
 		msp3400c_setvolume(client, msp->muted, msp->left, msp->right);
-		msp3400c_write(client, I2C_MSP3400C_DFP, 0x0013, msp->acb);
+		msp3400c_write(client, I2C_MSP3400C_DFP, 0x13, msp->acb);
+		msp3400c_write(client,I2C_MSP3400C_DEM, 0x40, msp->i2s_mode);
 		msp3400c_restore_dfp(client);
 
 		/* monitor tv audio mode */
@@ -1275,6 +1316,8 @@ static int msp34xxg_reset(struct i2c_cli
 			   0x0f20 /* mute DSP input, mute SCART 1 */))
 		return -1;
 
+	msp3400c_write(client,I2C_MSP3400C_DEM, 0x40, msp->i2s_mode);
+
 	/* step-by-step initialisation, as described in the manual */
 	modus = msp34xx_modus(msp->norm);
 	std   = msp34xx_standard(msp->norm);
@@ -1371,6 +1414,8 @@ static int msp34xxg_thread(void *data)
 				   0x13, /* ACB */
 				   msp->acb))
 			return -1;
+
+		msp3400c_write(client,I2C_MSP3400C_DEM, 0x40, msp->i2s_mode);
 	}
 	dprintk("msp34xxg: thread: exit\n");
 	return 0;
@@ -1539,6 +1584,7 @@ static int msp_attach(struct i2c_adapter
 	msp->treble = 32768;
 	msp->input = -1;
 	msp->muted = 0;
+	msp->i2s_mode = 0;
 	for (i = 0; i < DFP_COUNT; i++)
 		msp->dfp_regs[i] = -1;
 
@@ -1735,6 +1781,7 @@ static void msp_any_set_audmode(struct i
 	}
 }
 
+
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	struct msp3400c *msp  = i2c_get_clientdata(client);
@@ -1745,6 +1792,7 @@ static int msp_command(struct i2c_client
 
 	case AUDC_SET_INPUT:
 		dprintk("msp34xx: AUDC_SET_INPUT(%d)\n",*sarg);
+
 		if (*sarg == msp->input)
 			break;
 		msp->input = *sarg;
@@ -1923,6 +1971,16 @@ static int msp_command(struct i2c_client
 		break;
 	}
 
+	/* msp34xx specific */
+	case MSP_SET_MATRIX:
+	{
+		struct msp_matrix *mspm = arg;
+
+		dprintk("msp34xx: MSP_SET_MATRIX\n");
+		msp3400c_set_scart(client, mspm->input, mspm->output);
+		break;
+	}
+
 	/* --- v4l2 ioctls --- */
 	case VIDIOC_S_STD:
 	{
@@ -1941,6 +1999,33 @@ static int msp_command(struct i2c_client
 		return 0;
 	}
 
+	case VIDIOC_ENUMINPUT:
+	{
+		struct v4l2_input *i = arg;
+
+		if (i->index != 0)
+			return -EINVAL;
+
+		i->type = V4L2_INPUT_TYPE_TUNER;
+		switch (i->index) {
+		case AUDIO_RADIO:
+			strcpy(i->name,"Radio");
+			break;
+		case AUDIO_EXTERN_1:
+			strcpy(i->name,"Extern 1");
+			break;
+		case AUDIO_EXTERN_2:
+			strcpy(i->name,"Extern 2");
+			break;
+		case AUDIO_TUNER:
+			strcpy(i->name,"Television");
+			break;
+		default:
+			return -EINVAL;
+		}
+		return 0;
+	}
+
 	case VIDIOC_G_AUDIO:
 	{
 		struct v4l2_audio *a = arg;
@@ -2032,13 +2117,44 @@ static int msp_command(struct i2c_client
 		break;
 	}
 
-	/* msp34xx specific */
-	case MSP_SET_MATRIX:
+	case VIDIOC_G_AUDOUT:
 	{
-		struct msp_matrix *mspm = arg;
+		struct v4l2_audioout *a=(struct v4l2_audioout *)arg;
+
+		memset(a,0,sizeof(*a));
+
+		switch (a->index) {
+		case 0:
+			strcpy(a->name,"Scart1 Out");
+			break;
+		case 1:
+			strcpy(a->name,"Scart2 Out");
+			break;
+		case 2:
+			strcpy(a->name,"I2S Out");
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	}
+	case VIDIOC_S_AUDOUT:
+	{
+		struct v4l2_audioout *a=(struct v4l2_audioout *)arg;
+
+		if (a->index<0||a->index>2)
+			return -EINVAL;
+
+		if (a->index==2) {
+			if (a->mode == V4L2_AUDMODE_32BITS)
+				msp->i2s_mode=1;
+			else
+				msp->i2s_mode=0;
+		}
+printk("Setting audio out on msp34xx to input %i, mode %i\n",a->index,msp->i2s_mode);
+		msp3400c_set_scart(client,msp->in_scart,a->index);
 
-		dprintk("msp34xx: MSP_SET_MATRIX\n");
-		msp3400c_set_scart(client, mspm->input, mspm->output);
 		break;
 	}
 
--- hg.orig/include/linux/videodev2.h
+++ hg/include/linux/videodev2.h
@@ -885,6 +885,7 @@ struct v4l2_audio
 
 /*  Flags for the 'mode' field */
 #define V4L2_AUDMODE_AVL		0x00001
+#define V4L2_AUDMODE_32BITS		0x00002
 
 struct v4l2_audioout
 {


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

