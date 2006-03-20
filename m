Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWCTPRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWCTPRO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966476AbWCTPRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:17:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47768 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965210AbWCTPRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:17:04 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 022/141] V4L/DVB (3421): Several fixes to prepare for VBI
Date: Mon, 20 Mar 2006 12:08:40 -0300
Message-id: <20060320150840.PS695488000022@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1138043468 -0200

- Fixed VBI compilation.
- Included capacity to specify vbi and video number.
- Added a better control for using more than one em28xx device.
- VIDIOC_G_FMT now calls a function.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 94a14a2..e4e82ae 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/bitmap.h>
 #include <linux/usb.h>
 #include <linux/i2c.h>
 #include <linux/version.h>
@@ -59,8 +60,14 @@ MODULE_LICENSE("GPL");
 static LIST_HEAD(em28xx_devlist);
 
 static unsigned int card[]     = {[0 ... (EM28XX_MAXBOARDS - 1)] = UNSET };
+static unsigned int video_nr[] = {[0 ... (EM28XX_MAXBOARDS - 1)] = UNSET };
+static unsigned int vbi_nr[] = {[0 ... (EM28XX_MAXBOARDS - 1)] = UNSET };
 module_param_array(card,  int, NULL, 0444);
+module_param_array(video_nr, int, NULL, 0444);
+module_param_array(vbi_nr, int, NULL, 0444);
 MODULE_PARM_DESC(card,"card type");
+MODULE_PARM_DESC(video_nr,"video device numbers");
+MODULE_PARM_DESC(vbi_nr,"vbi device numbers");
 
 static int tuner = -1;
 module_param(tuner, int, 0444);
@@ -70,6 +77,9 @@ static unsigned int video_debug = 0;
 module_param(video_debug,int,0644);
 MODULE_PARM_DESC(video_debug,"enable debug messages [video]");
 
+/* Bitmask marking allocated devices from 0 to EM28XX_MAXBOARDS */
+static unsigned long em28xx_devused;
+
 /* supported tv norms */
 static struct em28xx_tvnorm tvnorms[] = {
 	{
@@ -211,6 +221,11 @@ static int em28xx_config(struct em28xx *
 	em28xx_write_regs_req(dev, 0x00, 0x06, "\x40", 1);
 
 	/* enable vbi capturing */
+
+	em28xx_write_regs_req(dev,0x00,0x0e,"\xC0",1);
+	em28xx_write_regs_req(dev,0x00,0x0f,"\x80",1);
+	em28xx_write_regs_req(dev,0x00,0x11,"\x51",1);
+
 	em28xx_audio_usb_mute(dev, 1);
 	dev->mute = 1;		/* maybe not the right place... */
 	dev->volume = 0x1f;
@@ -323,13 +338,20 @@ static int em28xx_v4l2_open(struct inode
 		h = list_entry(list, struct em28xx, devlist);
 		if (h->vdev->minor == minor) {
 			dev  = h;
+			dev->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		}
+		if (h->vbi_dev->minor == minor) {
+			dev  = h;
+			dev->type = V4L2_BUF_TYPE_VBI_CAPTURE;
 		}
 	}
+	if (NULL == dev)
+		return -ENODEV;
 
 	filp->private_data=dev;
 
-
-	em28xx_videodbg("users=%d\n", dev->users);
+	em28xx_videodbg("open minor=%d type=%s users=%d\n",
+				minor,v4l2_type_names[dev->type],dev->users);
 
 	if (!down_read_trylock(&em28xx_disconnect))
 		return -ERESTARTSYS;
@@ -340,13 +362,6 @@ static int em28xx_v4l2_open(struct inode
 		return -EBUSY;
 	}
 
-/*	if(dev->vbi_dev->minor == minor){
-		dev->type=V4L2_BUF_TYPE_VBI_CAPTURE;
-	}*/
-	if (dev->vdev->minor == minor) {
-		dev->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-	}
-
 	init_MUTEX(&dev->fileop_lock);	/* to 1 == available */
 	spin_lock_init(&dev->queue_lock);
 	init_waitqueue_head(&dev->wait_frame);
@@ -354,23 +369,27 @@ static int em28xx_v4l2_open(struct inode
 
 	down(&dev->lock);
 
-	em28xx_set_alternate(dev);
+	if (dev->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+		em28xx_set_alternate(dev);
+
+		dev->width = norm_maxw(dev);
+		dev->height = norm_maxh(dev);
+		dev->frame_size = dev->width * dev->height * 2;
+		dev->field_size = dev->frame_size >> 1;	/*both_fileds ? dev->frame_size>>1 : dev->frame_size; */
+		dev->bytesperline = dev->width * 2;
+		dev->hscale = 0;
+		dev->vscale = 0;
 
-	dev->width = norm_maxw(dev);
-	dev->height = norm_maxh(dev);
-	dev->frame_size = dev->width * dev->height * 2;
-	dev->field_size = dev->frame_size >> 1;	/*both_fileds ? dev->frame_size>>1 : dev->frame_size; */
-	dev->bytesperline = dev->width * 2;
-	dev->hscale = 0;
-	dev->vscale = 0;
+		em28xx_capture_start(dev, 1);
+		em28xx_resolution_set(dev);
 
-	em28xx_capture_start(dev, 1);
-	em28xx_resolution_set(dev);
+		/* start the transfer */
+		errCode = em28xx_init_isoc(dev);
+		if (errCode)
+			goto err;
 
-	/* start the transfer */
-	errCode = em28xx_init_isoc(dev);
-	if (errCode)
-		goto err;
+		video_mux(dev, 0);
+	}
 
 	dev->users++;
 	filp->private_data = dev;
@@ -383,8 +402,6 @@ static int em28xx_v4l2_open(struct inode
 
 	dev->state |= DEV_INITIALIZED;
 
-	video_mux(dev, 0);
-
       err:
 	up(&dev->lock);
 	up_read(&em28xx_disconnect);
@@ -400,14 +417,21 @@ static void em28xx_release_resources(str
 {
 	mutex_lock(&em28xx_sysfs_lock);
 
-	em28xx_info("V4L2 device /dev/video%d deregistered\n",
-		    dev->vdev->minor);
+	/*FIXME: I2C IR should be disconnected */
+
+	em28xx_info("V4L2 devices /dev/video%d and /dev/vbi%d deregistered\n",
+				dev->vdev->minor-MINOR_VFL_TYPE_GRABBER_MIN,
+				dev->vbi_dev->minor-MINOR_VFL_TYPE_VBI_MIN);
 	list_del(&dev->devlist);
 	video_unregister_device(dev->vdev);
-/*	video_unregister_device(dev->vbi_dev); */
+	video_unregister_device(dev->vbi_dev);
 	em28xx_i2c_unregister(dev);
 	usb_put_dev(dev->udev);
 	mutex_unlock(&em28xx_sysfs_lock);
+
+
+	/* Mark device as unused */
+	em28xx_devused&=~(1<<dev->devno);
 }
 
 /*
@@ -463,6 +487,28 @@ em28xx_v4l2_read(struct file *filp, char
 	int ret = 0;
 	struct em28xx *dev = filp->private_data;
 
+	if (dev->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+		em28xx_videodbg("V4l2_Buf_type_videocapture is set\n");
+	}
+	if (dev->type == V4L2_BUF_TYPE_VBI_CAPTURE) {
+		em28xx_videodbg("V4L2_BUF_TYPE_VBI_CAPTURE is set\n");
+		em28xx_videodbg("not supported yet! ...\n");
+		if (copy_to_user(buf, "", 1)) {
+			up(&dev->fileop_lock);
+			return -EFAULT;
+		}
+		return (1);
+	}
+	if (dev->type == V4L2_BUF_TYPE_SLICED_VBI_CAPTURE) {
+		em28xx_videodbg("V4L2_BUF_TYPE_SLICED_VBI_CAPTURE is set\n");
+		em28xx_videodbg("not supported yet! ...\n");
+		if (copy_to_user(buf, "", 1)) {
+			up(&dev->fileop_lock);
+			return -EFAULT;
+		}
+		return (1);
+	}
+
 	if (down_interruptible(&dev->fileop_lock))
 		return -ERESTARTSYS;
 
@@ -799,7 +845,8 @@ static int em28xx_stream_interrupt(struc
 	else if (ret) {
 		dev->state |= DEV_MISCONFIGURED;
 		em28xx_videodbg("device is misconfigured; close and "
-			"open /dev/video%d again\n", dev->vdev->minor);
+			"open /dev/video%d again\n",
+				dev->vdev->minor-MINOR_VFL_TYPE_GRABBER_MIN);
 		return ret;
 	}
 
@@ -850,6 +897,36 @@ static int em28xx_set_norm(struct em28xx
 	return 0;
 }
 
+
+static int em28xx_get_fmt(struct em28xx *dev, struct v4l2_format *format)
+{
+	em28xx_videodbg("VIDIOC_G_FMT: type=%s\n",
+		(format->type ==V4L2_BUF_TYPE_VIDEO_CAPTURE) ?
+		"V4L2_BUF_TYPE_VIDEO_CAPTURE" :
+		(format->type ==V4L2_BUF_TYPE_VBI_CAPTURE) ?
+		"V4L2_BUF_TYPE_VBI_CAPTURE" :
+		(format->type ==V4L2_CAP_SLICED_VBI_CAPTURE) ?
+		"V4L2_BUF_TYPE_SLICED_VBI_CAPTURE " :
+		"not supported");
+
+	if (format->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+		format->fmt.pix.width = dev->width;
+		format->fmt.pix.height = dev->height;
+		format->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
+		format->fmt.pix.bytesperline = dev->bytesperline;
+		format->fmt.pix.sizeimage = dev->frame_size;
+		format->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
+		format->fmt.pix.field = dev->interlaced ? V4L2_FIELD_INTERLACED : V4L2_FIELD_TOP;	/* FIXME: TOP? NONE? BOTTOM? ALTENATE? */
+
+		em28xx_videodbg("VIDIOC_G_FMT: %dx%d\n", dev->width,
+			dev->height);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+
 /*
  * em28xx_v4l2_do_ioctl()
  * This function is _not_ called directly, but from
@@ -1290,6 +1367,7 @@ static int em28xx_video_do_ioctl(struct 
 				sizeof(cap->bus_info));
 			cap->version = EM28XX_VERSION_CODE;
 			cap->capabilities =
+			    V4L2_CAP_SLICED_VBI_CAPTURE |
 			    V4L2_CAP_VIDEO_CAPTURE |
 			    V4L2_CAP_AUDIO |
 			    V4L2_CAP_READWRITE | V4L2_CAP_STREAMING;
@@ -1314,32 +1392,7 @@ static int em28xx_video_do_ioctl(struct 
 		}
 
 	case VIDIOC_G_FMT:
-		{
-			struct v4l2_format *format = arg;
-
-			em28xx_videodbg("VIDIOC_G_FMT: type=%s\n",
-				 format->type ==
-				 V4L2_BUF_TYPE_VIDEO_CAPTURE ?
-				 "V4L2_BUF_TYPE_VIDEO_CAPTURE" : format->type ==
-				 V4L2_BUF_TYPE_VBI_CAPTURE ?
-				 "V4L2_BUF_TYPE_VBI_CAPTURE " :
-				 "not supported");
-
-			if (format->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
-				return -EINVAL;
-
-			format->fmt.pix.width = dev->width;
-			format->fmt.pix.height = dev->height;
-			format->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
-			format->fmt.pix.bytesperline = dev->bytesperline;
-			format->fmt.pix.sizeimage = dev->frame_size;
-			format->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
-			format->fmt.pix.field = dev->interlaced ? V4L2_FIELD_INTERLACED : V4L2_FIELD_TOP;	/* FIXME: TOP? NONE? BOTTOM? ALTENATE? */
-
-			em28xx_videodbg("VIDIOC_G_FMT: %dx%d\n", dev->width,
-				 dev->height);
-			return 0;
-		}
+		return em28xx_get_fmt(dev, (struct v4l2_format *) arg);
 
 	case VIDIOC_TRY_FMT:
 	case VIDIOC_S_FMT:
@@ -1741,6 +1794,7 @@ static int em28xx_init_dev(struct em28xx
 	if (errCode) {
 		em28xx_errdev("error configuring device\n");
 		kfree(dev);
+		em28xx_devused&=~(1<<dev->devno);
 		return -ENOMEM;
 	}
 
@@ -1767,9 +1821,30 @@ static int em28xx_init_dev(struct em28xx
 	if (NULL == dev->vdev) {
 		em28xx_errdev("cannot allocate video_device.\n");
 		kfree(dev);
+		em28xx_devused&=~(1<<dev->devno);
 		return -ENOMEM;
 	}
 
+	dev->vbi_dev = video_device_alloc();
+	if (NULL == dev->vbi_dev) {
+		em28xx_errdev("cannot allocate video_device.\n");
+		kfree(dev->vdev);
+		kfree(dev);
+		em28xx_devused&=~(1<<dev->devno);
+		return -ENOMEM;
+	}
+
+	/* Fills VBI device info */
+	dev->vbi_dev->type = VFL_TYPE_VBI;
+	dev->vbi_dev->hardware = 0;
+	dev->vbi_dev->fops = &em28xx_v4l_fops;
+	dev->vbi_dev->minor = -1;
+	dev->vbi_dev->dev = &dev->udev->dev;
+	dev->vbi_dev->release = video_device_release;
+	snprintf(dev->vbi_dev->name, sizeof(dev->vbi_dev->name), "%s#%d %s",
+							 "em28xx",dev->devno,"vbi");
+
+	/* Fills CAPTURE device info */
 	dev->vdev->type = VID_TYPE_CAPTURE;
 	if (dev->has_tuner)
 		dev->vdev->type |= VID_TYPE_TUNER;
@@ -1778,21 +1853,39 @@ static int em28xx_init_dev(struct em28xx
 	dev->vdev->minor = -1;
 	dev->vdev->dev = &dev->udev->dev;
 	dev->vdev->release = video_device_release;
-	snprintf(dev->vdev->name, sizeof(dev->vdev->name), "%s",
-		 "em28xx video");
+	snprintf(dev->vdev->name, sizeof(dev->vbi_dev->name), "%s#%d %s",
+							 "em28xx",dev->devno,"video");
+
 	list_add_tail(&dev->devlist,&em28xx_devlist);
 
 	/* register v4l2 device */
 	down(&dev->lock);
-	if ((retval = video_register_device(dev->vdev, VFL_TYPE_GRABBER, -1))) {
+	if ((retval = video_register_device(dev->vdev, VFL_TYPE_GRABBER,
+					 video_nr[dev->devno]))) {
 		em28xx_errdev("unable to register video device (error=%i).\n",
 			      retval);
 		up(&dev->lock);
 		list_del(&dev->devlist);
 		video_device_release(dev->vdev);
 		kfree(dev);
+		em28xx_devused&=~(1<<dev->devno);
 		return -ENODEV;
 	}
+
+	if (video_register_device(dev->vbi_dev, VFL_TYPE_VBI,
+					vbi_nr[dev->devno]) < 0) {
+		printk("unable to register vbi device\n");
+		up(&dev->lock);
+		list_del(&dev->devlist);
+		video_device_release(dev->vbi_dev);
+		video_device_release(dev->vdev);
+		kfree(dev);
+		em28xx_devused&=~(1<<dev->devno);
+		return -ENODEV;
+	} else {
+		printk("registered VBI\n");
+	}
+
 	if (dev->has_msp34xx) {
 		/* Send a reset to other chips via gpio */
 		em28xx_write_regs_req(dev, 0x00, 0x08, "\xf7", 1);
@@ -1805,8 +1898,9 @@ static int em28xx_init_dev(struct em28xx
 
 	up(&dev->lock);
 
-	em28xx_info("V4L2 device registered as /dev/video%d\n",
-		    dev->vdev->minor);
+	em28xx_info("V4L2 device registered as /dev/video%d and /dev/vbi%d\n",
+				dev->vdev->minor-MINOR_VFL_TYPE_GRABBER_MIN,
+				dev->vbi_dev->minor-MINOR_VFL_TYPE_VBI_MIN);
 
 	return 0;
 }
@@ -1828,6 +1922,9 @@ static int em28xx_usb_probe(struct usb_i
 	udev = usb_get_dev(interface_to_usbdev(interface));
 	ifnum = interface->altsetting[0].desc.bInterfaceNumber;
 
+	/* Check to see next free device and mark as used */
+	nr=find_first_zero_bit(&em28xx_devused,EM28XX_MAXBOARDS);
+	em28xx_devused|=1<<nr;
 
 	/* Don't register audio interfaces */
 	if (interface->altsetting[0].desc.bInterfaceClass == USB_CLASS_AUDIO) {
@@ -1835,6 +1932,8 @@ static int em28xx_usb_probe(struct usb_i
 				udev->descriptor.idVendor,udev->descriptor.idProduct,
 				ifnum,
 				interface->altsetting[0].desc.bInterfaceClass);
+
+		em28xx_devused&=~(1<<nr);
 		return -ENODEV;
 	}
 
@@ -1849,18 +1948,20 @@ static int em28xx_usb_probe(struct usb_i
 	if ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) !=
 	    USB_ENDPOINT_XFER_ISOC) {
 		em28xx_err(DRIVER_NAME " probing error: endpoint is non-ISO endpoint!\n");
+		em28xx_devused&=~(1<<nr);
 		return -ENODEV;
 	}
 	if ((endpoint->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT) {
 		em28xx_err(DRIVER_NAME " probing error: endpoint is ISO OUT endpoint!\n");
+		em28xx_devused&=~(1<<nr);
 		return -ENODEV;
 	}
 
 	model=id->driver_info;
-	nr=interface->minor;
 
-	if (nr>EM28XX_MAXBOARDS) {
+	if (nr > EM28XX_MAXBOARDS) {
 		printk (DRIVER_NAME ": Supports only %i em28xx boards.\n",EM28XX_MAXBOARDS);
+		em28xx_devused&=~(1<<nr);
 		return -ENOMEM;
 	}
 
@@ -1868,19 +1969,24 @@ static int em28xx_usb_probe(struct usb_i
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL) {
 		em28xx_err(DRIVER_NAME ": out of memory!\n");
+		em28xx_devused&=~(1<<nr);
 		return -ENOMEM;
 	}
 
+	snprintf(dev->name, 29, "em28xx #%d", nr);
+	dev->devno=nr;
+
 	/* compute alternate max packet sizes */
 	uif = udev->actconfig->interface[0];
 
 	dev->num_alt=uif->num_altsetting;
-	printk(DRIVER_NAME ": Alternate settings: %i\n",dev->num_alt);
+	em28xx_info("Alternate settings: %i\n",dev->num_alt);
 //	dev->alt_max_pkt_size = kmalloc(sizeof(*dev->alt_max_pkt_size)*
 	dev->alt_max_pkt_size = kmalloc(32*
 						dev->num_alt,GFP_KERNEL);
 	if (dev->alt_max_pkt_size == NULL) {
-		em28xx_err(DRIVER_NAME ": out of memory!\n");
+		em28xx_errdev("out of memory!\n");
+		em28xx_devused&=~(1<<nr);
 		return -ENOMEM;
 	}
 
@@ -1889,27 +1995,26 @@ static int em28xx_usb_probe(struct usb_i
 							wMaxPacketSize);
 		dev->alt_max_pkt_size[i] =
 		    (tmp & 0x07ff) * (((tmp & 0x1800) >> 11) + 1);
-		printk(DRIVER_NAME ": Alternate setting %i, max size= %i\n",i,
+		em28xx_info("Alternate setting %i, max size= %i\n",i,
 							dev->alt_max_pkt_size[i]);
 	}
 
-	snprintf(dev->name, 29, "em28xx #%d", nr);
-
 	if ((card[nr]>=0)&&(card[nr]<em28xx_bcount))
 		model=card[nr];
 
 	if ((model==EM2800_BOARD_UNKNOWN)||(model==EM2820_BOARD_UNKNOWN)) {
-		printk( "%s: Your board has no eeprom inside it and thus can't\n"
+		em28xx_errdev( "Your board has no eeprom inside it and thus can't\n"
 			"%s: be autodetected.  Please pass card=<n> insmod option to\n"
 			"%s: workaround that.  Redirect complaints to the vendor of\n"
-			"%s: the TV card.  Best regards,\n"
+			"%s: the TV card. Generic type will be used."
+			"%s: Best regards,\n"
 			"%s:         -- tux\n",
 			dev->name,dev->name,dev->name,dev->name,dev->name);
-		printk("%s: Here is a list of valid choices for the card=<n> insmod option:\n",
+		em28xx_errdev("%s: Here is a list of valid choices for the card=<n> insmod option:\n",
 			dev->name);
 		for (i = 0; i < em28xx_bcount; i++) {
-			printk("%s:    card=%d -> %s\n",
-				dev->name, i, em28xx_boards[i].name);
+			em28xx_errdev("    card=%d -> %s\n", i,
+							em28xx_boards[i].name);
 		}
 	}
 
@@ -1935,12 +2040,9 @@ static void em28xx_usb_disconnect(struct
 	struct em28xx *dev = usb_get_intfdata(interface);
 	usb_set_intfdata(interface, NULL);
 
-/*FIXME: IR should be disconnected */
-
 	if (!dev)
 		return;
 
-
 	down_write(&em28xx_disconnect);
 
 	down(&dev->lock);
@@ -1952,7 +2054,9 @@ static void em28xx_usb_disconnect(struct
 	if (dev->users) {
 		em28xx_warn
 		    ("device /dev/video%d is open! Deregistration and memory "
-		     "deallocation are deferred on close.\n", dev->vdev->minor);
+		     "deallocation are deferred on close.\n",
+				dev->vdev->minor-MINOR_VFL_TYPE_GRABBER_MIN);
+
 		dev->state |= DEV_MISCONFIGURED;
 		em28xx_uninit_isoc(dev);
 		dev->state |= DEV_DISCONNECTED;
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
index 33de9d8..119fdbe 100644
--- a/drivers/media/video/em28xx/em28xx.h
+++ b/drivers/media/video/em28xx/em28xx.h
@@ -209,6 +209,7 @@ struct em28xx {
 	/* generic device properties */
 	char name[30];		/* name (including minor) of the device */
 	int model;		/* index in the device_data struct */
+	int devno;		/* marks the number of this device */
 	unsigned int is_em2800;
 	int video_inputs;	/* number of video inputs */
 	struct list_head	devlist;

