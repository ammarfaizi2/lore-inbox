Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261262AbVCEXok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVCEXok (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCEXmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:42:07 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:62956 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261246AbVCEXiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:38:03 -0500
Date: Sat, 05 Mar 2005 17:38:02 -0600 (CST)
Date-warning: Date header was inserted by vms042.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 9/13] vicam: Clean up printk()'s in drivers/usb/media/vicam.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233801.7648.9150.63219@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix confusing debugging macro and add KERN_ constants, nwelines, and driver prefixes
where needed in drivers/usb/media/vicam.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/media/vicam.c linux-2.6.11-mm1/drivers/usb/media/vicam.c
--- linux-2.6.11-mm1-original/drivers/usb/media/vicam.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/media/vicam.c	2005-03-05 15:56:17.000000000 -0500
@@ -34,6 +34,11 @@
  *    camera controls and wrote the first generation driver.
  */
 
+#define PFX "vicam: "
+#ifdef CONFIG_USB_DEBUG
+#define DEBUG
+#endif /*CONFIG_USB_DEBUG*/
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -44,14 +49,7 @@
 #include <linux/proc_fs.h>
 #include "usbvideo.h"
 
-// #define VICAM_DEBUG
-
-#ifdef VICAM_DEBUG
-#define ADBG(lineno,fmt,args...) printk(fmt, jiffies, __FUNCTION__, lineno, ##args)
-#define DBG(fmt,args...) ADBG((__LINE__),KERN_DEBUG __FILE__"(%ld):%s (%d):"fmt,##args)
-#else
-#define DBG(fmn,args...) do {} while(0)
-#endif
+#define DBG(fmt,args...) pr_debug(PFX "(%ld):%s (%d):" fmt, jiffies, __FUNCTION__, __LINE__, ##args )
 
 #define DRIVER_AUTHOR           "Joe Burks, jburks@wavicle.org"
 #define DRIVER_DESC             "ViCam WebCam Driver"
@@ -446,7 +444,7 @@ static int __send_control_msg(struct vic
 	status = min(status, 0);
 
 	if (status < 0) {
-		printk(KERN_INFO "Failed sending control message, error %d.\n",
+		printk(KERN_INFO PFX "failed sending control message, error %d\n",
 		       status);
 	}
 
@@ -691,7 +689,8 @@ vicam_ioctl(struct inode *inode, struct 
 				break;
 			}
 
-			DBG("VIDIOCMCAPTURE frame=%d, height=%d, width=%d, format=%d.\n",vm.frame,vm.width,vm.height,vm.format);
+			DBG("VIDIOCMCAPTURE frame=%d, height=%d, width=%d, format=%d\n",
+				vm.frame,vm.width,vm.height,vm.format);
 
 			if ( vm.frame >= VICAM_FRAMES || vm.format != VIDEO_PALETTE_RGB24 )
 				retval = -EINVAL;
@@ -761,8 +760,7 @@ vicam_open(struct inode *inode, struct f
 	DBG("open\n");
 
 	if (!cam) {
-		printk(KERN_ERR
-		       "vicam video_device improperly initialized");
+		printk(KERN_ERR PFX "device improperly initialized\n");
 	}
 
 	/* the videodev_lock held above us protects us from
@@ -771,8 +769,8 @@ vicam_open(struct inode *inode, struct f
 	 */
 
 	if (cam->open_count > 0) {
-		printk(KERN_INFO
-		       "vicam_open called on already opened camera");
+		printk(KERN_INFO PFX "%s(): called on already opened camera\n",
+			__FUNCTION__);
 		return -EBUSY;
 	}
 
@@ -969,8 +967,7 @@ read_frame(struct vicam_camera *cam, int
 	n = __send_control_msg(cam, 0x51, 0x80, 0, request, 16);
 
 	if (n < 0) {
-		printk(KERN_ERR
-		       " Problem sending frame capture control message");
+		printk(KERN_ERR PFX "problem sending frame capture control message\n");
 		goto done;
 	}
 
@@ -980,7 +977,7 @@ read_frame(struct vicam_camera *cam, int
 			 512 * 242 + 128, &actual_length, 10000);
 
 	if (n < 0) {
-		printk(KERN_ERR "Problem during bulk read of frame data: %d\n",
+		printk(KERN_ERR PFX "problem during bulk read of frame data: %d\n",
 		       n);
 	}
 
@@ -993,7 +990,7 @@ vicam_read( struct file *file, char __us
 {
 	struct vicam_camera *cam = file->private_data;
 
-	DBG("read %d bytes.\n", (int) count);
+	DBG("read %d bytes\n", (int) count);
 
 	if (*ppos >= VICAM_MAX_FRAME_SIZE) {
 		*ppos = 0;
@@ -1035,7 +1032,7 @@ vicam_mmap(struct file *file, struct vm_
 	if (!cam)
 		return -ENODEV;
 
-	DBG("vicam_mmap: %ld\n", size);
+	DBG("size = %ld\n", size);
 
 	/* We let mmap allocate as much as it wants because Linux was adding 2048 bytes
 	 * to the size the application requested for mmap and it was screwing apps up.
@@ -1153,8 +1150,7 @@ vicam_create_proc_root(void)
 	if (vicam_proc_root)
 		vicam_proc_root->owner = THIS_MODULE;
 	else
-		printk(KERN_ERR
-		       "could not create /proc entry for vicam!");
+		printk(KERN_ERR PFX "could not create /proc entry for vicam\n");
 }
 
 static void
@@ -1170,11 +1166,10 @@ vicam_create_proc_entry(struct vicam_cam
 	char name[64];
 	struct proc_dir_entry *ent;
 
-	DBG(KERN_INFO "vicam: creating proc entry\n");
+	DBG("creating proc entry\n");
 
 	if (!vicam_proc_root || !cam) {
-		printk(KERN_INFO
-		       "vicam: could not create proc entry, %s pointer is null.\n",
+		printk(KERN_INFO PFX "could not create proc entry, %s pointer is null.\n",
 		       (!cam ? "camera" : "root"));
 		return;
 	}
@@ -1281,11 +1276,11 @@ vicam_probe( struct usb_interface *intf,
 	const struct usb_endpoint_descriptor *endpoint;
 	struct vicam_camera *cam;
 	
-	printk(KERN_INFO "ViCam based webcam connected\n");
+	printk(KERN_INFO PFX "webcam connected\n");
 
 	interface = intf->cur_altsetting;
 
-	DBG(KERN_DEBUG "Interface %d. has %u. endpoints!\n",
+	DBG("interface %d has %u endpoints\n",
 	       interface->desc.bInterfaceNumber, (unsigned) (interface->desc.bNumEndpoints));
 	endpoint = &interface->endpoint[0].desc;
 
@@ -1294,13 +1289,12 @@ vicam_probe( struct usb_interface *intf,
 		/* we found a bulk in endpoint */
 		bulkEndpoint = endpoint->bEndpointAddress;
 	} else {
-		printk(KERN_ERR
-		       "No bulk in endpoint was found ?! (this is bad)\n");
+		printk(KERN_ERR PFX "no bulk in endpoint was found\n");
 	}
 
 	if ((cam =
 	     kmalloc(sizeof (struct vicam_camera), GFP_KERNEL)) == NULL) {
-		printk(KERN_WARNING
+		printk(KERN_WARNING PFX
 		       "could not allocate kernel memory for vicam_camera struct\n");
 		return -ENOMEM;
 	}
@@ -1320,13 +1314,13 @@ vicam_probe( struct usb_interface *intf,
 
 	if (video_register_device(&cam->vdev, VFL_TYPE_GRABBER, -1) == -1) {
 		kfree(cam);
-		printk(KERN_WARNING "video_register_device failed\n");
+		printk(KERN_WARNING PFX "video_register_device failed\n");
 		return -EIO;
 	}
 
 	vicam_create_proc_entry(cam);
 
-	printk(KERN_INFO "ViCam webcam driver now controlling video device %d\n",cam->vdev.minor);
+	printk(KERN_INFO PFX "now controlling video device %d\n",cam->vdev.minor);
 
 	usb_set_intfdata (intf, cam);
 	
@@ -1374,7 +1368,7 @@ vicam_disconnect(struct usb_interface *i
 		kfree(cam);
 	}
 
-	printk(KERN_DEBUG "ViCam-based WebCam disconnected\n");
+	printk(KERN_DEBUG PFX "webcam disconnected\n");
 }
 
 /*
@@ -1383,19 +1377,18 @@ static int __init
 usb_vicam_init(void)
 {
 	int retval;
-	DBG(KERN_INFO "ViCam-based WebCam driver startup\n");
+	DBG("driver startup\n");
 	vicam_create_proc_root();
 	retval = usb_register(&vicam_driver);
 	if (retval)
-		printk(KERN_WARNING "usb_register failed!\n");
+		printk(KERN_WARNING PFX "usb_register failed!\n");
 	return retval;
 }
 
 static void __exit
 usb_vicam_exit(void)
 {
-	DBG(KERN_INFO
-	       "ViCam-based WebCam driver shutdown\n");
+	DBG("driver shutdown\n");
 
 	usb_deregister(&vicam_driver);
 	vicam_destroy_proc_root();
