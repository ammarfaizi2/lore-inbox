Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbUKNG2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUKNG2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 01:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUKNG2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 01:28:17 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:25106 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S261250AbUKNG2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 01:28:12 -0500
Message-ID: <4196D308.60801@gentoo.org>
Date: Sun, 14 Nov 2004 03:37:44 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bcollins@debian.org
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] raw1394: sysfs support via class_simple
Content-Type: multipart/mixed;
 boundary="------------040604030600050502020607"
X-Spam-Score: -5.8 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CT9tx-0009e4-RI*hZwhhl0J8mc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040604030600050502020607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adds basic sysfs support for udev etc.
Ideally we should link into the ieee1394 sysfs class, but it doesn't seem 
extensible in that manner.
For now, class_simple will do.

Depends on the previous whitespace fix patch.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------040604030600050502020607
Content-Type: text/plain;
 name="raw1394-03-sysfs-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="raw1394-03-sysfs-support.patch"

--- linux/drivers/ieee1394/raw1394.c.orig	2004-11-14 03:12:12.000000000 +0000
+++ linux/drivers/ieee1394/raw1394.c	2004-11-14 03:22:44.623795368 +0000
@@ -78,6 +78,7 @@ static atomic_t iso_buffer_size;
 static const int iso_buffer_max = 4 * 1024 * 1024;	/* 4 MB */
 
 static struct hpsb_highlevel raw1394_highlevel;
+static struct class_simple *raw1394_class;
 
 static int arm_read(struct hpsb_host *host, int nodeid, quadlet_t * buffer,
 		    u64 addr, size_t length, u16 flags);
@@ -2886,12 +2887,26 @@ static struct file_operations raw1394_fo
 
 static int __init init_raw1394(void)
 {
-	int ret;
+	int ret = 0;
 
 	hpsb_register_highlevel(&raw1394_highlevel);
 
-	devfs_mk_cdev(MKDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16),
-		      S_IFCHR | S_IRUSR | S_IWUSR, RAW1394_DEVICE_NAME);
+	raw1394_class = class_simple_create(THIS_MODULE, "raw1394");
+	if (IS_ERR(raw1394_class)) {
+		ret = PTR_ERR(raw1394_class);
+		goto out_unreg;
+	}
+
+	class_simple_device_add(raw1394_class,
+				MKDEV(IEEE1394_MAJOR,
+				      IEEE1394_MINOR_BLOCK_RAW1394 * 16), NULL,
+				RAW1394_DEVICE_NAME);
+	ret =
+	    devfs_mk_cdev(MKDEV
+			  (IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16),
+			  S_IFCHR | S_IRUSR | S_IWUSR, RAW1394_DEVICE_NAME);
+	if (ret)
+		goto out_class;
 
 	cdev_init(&raw1394_cdev, &raw1394_fops);
 	raw1394_cdev.owner = THIS_MODULE;
@@ -2899,9 +2914,7 @@ static int __init init_raw1394(void)
 	ret = cdev_add(&raw1394_cdev, IEEE1394_RAW1394_DEV, 1);
 	if (ret) {
 		HPSB_ERR("raw1394 failed to register minor device block");
-		devfs_remove(RAW1394_DEVICE_NAME);
-		hpsb_unregister_highlevel(&raw1394_highlevel);
-		return ret;
+		goto out_dev;
 	}
 
 	HPSB_INFO("raw1394: /dev/%s device initialized", RAW1394_DEVICE_NAME);
@@ -2910,16 +2923,30 @@ static int __init init_raw1394(void)
 	if (ret) {
 		HPSB_ERR("raw1394: failed to register protocol");
 		cdev_del(&raw1394_cdev);
-		devfs_remove(RAW1394_DEVICE_NAME);
-		hpsb_unregister_highlevel(&raw1394_highlevel);
-		return ret;
+		goto out_dev;
 	}
 
-	return 0;
+	goto out;
+
+      out_dev:
+	devfs_remove(RAW1394_DEVICE_NAME);
+      out_class:
+	class_simple_device_remove(MKDEV
+				   (IEEE1394_MAJOR,
+				    IEEE1394_MINOR_BLOCK_RAW1394 * 16));
+	class_simple_destroy(raw1394_class);
+      out_unreg:
+	hpsb_unregister_highlevel(&raw1394_highlevel);
+      out:
+	return ret;
 }
 
 static void __exit cleanup_raw1394(void)
 {
+	class_simple_device_remove(MKDEV
+				   (IEEE1394_MAJOR,
+				    IEEE1394_MINOR_BLOCK_RAW1394 * 16));
+	class_simple_destroy(raw1394_class);
 	hpsb_unregister_protocol(&raw1394_driver);
 	cdev_del(&raw1394_cdev);
 	devfs_remove(RAW1394_DEVICE_NAME);

--------------040604030600050502020607--
