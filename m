Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUCEUOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbUCEUOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:14:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:49103 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262089AbUCEUOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:14:08 -0500
Subject: [Dri-devel][PATCH] sysfs simple class support for DRI char device
From: Leann Ogasawara <ogasawara@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Hanna Linder <hannal@us.ibm.com>, Greg KH <greg@kroah.com>,
       faith@valinux.com
Content-Type: text/plain
Message-Id: <1078517655.29095.32.camel@ibm-d.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Mar 2004 12:14:15 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Patch adds sysfs simple class support for DRI character device (Major
226).  Also, adds some error checking.  Feedback appreciated.  Thanks,

Leann

diffed against 2.6.4-rc2

===== drivers/char/drm/drm_stub.h 1.9 vs edited =====
--- 1.9/drivers/char/drm/drm_stub.h	Tue Aug 26 09:25:41 2003
+++ edited/drivers/char/drm/drm_stub.h	Fri Mar  5 11:56:24 2004
@@ -35,6 +35,8 @@
 
 #define DRM_STUB_MAXCARDS 16	/* Enough for one machine */
 
+static struct class_simple *drm_class;
+
 /** Stub list. One for each minor. */
 static struct drm_stub_list {
 	const char             *name;
@@ -117,6 +119,7 @@
 			DRM(stub_root) = DRM(proc_init)(dev, i, DRM(stub_root),
 							&DRM(stub_list)[i]
 							.dev_root);
+			class_simple_device_add(drm_class, MKDEV(DRM_MAJOR, i), NULL, name);
 			return i;
 		}
 	}
@@ -141,6 +144,7 @@
 	DRM(proc_cleanup)(minor, DRM(stub_root),
 			  DRM(stub_list)[minor].dev_root);
 	if (minor) {
+		class_simple_device_remove(MKDEV(DRM_MAJOR, minor));
 		inter_module_put("drm");
 	} else {
 		inter_module_unregister("drm");
@@ -148,6 +152,8 @@
 			  sizeof(*DRM(stub_list)) * DRM_STUB_MAXCARDS,
 			  DRM_MEM_STUB);
 		unregister_chrdev(DRM_MAJOR, "drm");
+		class_simple_device_remove(MKDEV(DRM_MAJOR, minor));
+		class_simple_destroy(drm_class);
 	}
 	return 0;
 }
@@ -170,10 +176,23 @@
 		       drm_device_t *dev)
 {
 	struct drm_stub_info *i = NULL;
+	int ret1;
+	int ret2;
 
 	DRM_DEBUG("\n");
-	if (register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops)))
+	ret1 = register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops));
+	if (!ret1) {
+		drm_class = class_simple_create(THIS_MODULE, "drm");
+		if (IS_ERR(drm_class)) {
+			printk (KERN_ERR "Error creating drm class.\n");
+			unregister_chrdev(DRM_MAJOR, "drm");
+			return PTR_ERR(drm_class);
+		}
+	}
+	else if (ret1 == -EBUSY)
 		i = (struct drm_stub_info *)inter_module_get("drm");
+	else
+		return -1;
 
 	if (i) {
 				/* Already registered */
@@ -186,8 +205,18 @@
 		DRM_DEBUG("calling inter_module_register\n");
 		inter_module_register("drm", THIS_MODULE, &DRM(stub_info));
 	}
-	if (DRM(stub_info).info_register)
-		return DRM(stub_info).info_register(name, fops, dev);
+	if (DRM(stub_info).info_register) {
+		ret2 = DRM(stub_info).info_register(name, fops, dev);
+		if (ret2) {
+			if (!ret1) {
+			unregister_chrdev(DRM_MAJOR, "drm");
+			class_simple_destroy(drm_class);
+			}
+			if (!i)
+				inter_module_unregister("drm");
+		}
+		return ret2;
+	}
 	return -1;
 }
 



