Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVDADDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVDADDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 22:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVDADDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 22:03:06 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:4857 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262353AbVDADCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 22:02:54 -0500
Message-ID: <424CB9DA.1040707@mvista.com>
Date: Thu, 31 Mar 2005 21:02:50 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: sysfs for IPMI, for new mm kernels
Content-Type: multipart/mixed;
 boundary="------------020808030402060407080404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020808030402060407080404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

There are some major changes in the current mm kernels to the class 
interface that require changes to the IPMI driver.  Thus the previously 
posted sysfs changes for IPMI are now incorrect.  Here's a new one.

-Corey

--------------020808030402060407080404
Content-Type: text/x-patch;
 name="ipmi-sysfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-sysfs.diff"

Add support for sysfs to the IPMI device interface.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc1/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.12-rc1.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.12-rc1/drivers/char/ipmi/ipmi_devintf.c
@@ -44,6 +44,7 @@
 #include <linux/ipmi.h>
 #include <asm/semaphore.h>
 #include <linux/init.h>
+#include <linux/device.h>
 
 #define IPMI_DEVINTF_VERSION "v33"
 
@@ -519,15 +520,24 @@
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
+static struct class *ipmi_class;
+
 static void ipmi_new_smi(int if_num)
 {
+	char                  name[10];
+	dev_t                 dev = MKDEV(ipmi_major, if_num);
+
 	devfs_mk_cdev(MKDEV(ipmi_major, if_num),
 		      S_IFCHR | S_IRUSR | S_IWUSR,
 		      "ipmidev/%d", if_num);
+
+	snprintf(name, sizeof(name), "ipmi%d", if_num);
+	class_device_create(ipmi_class, dev, NULL, name);
 }
 
 static void ipmi_smi_gone(int if_num)
 {
+	class_device_destroy(ipmi_class, MKDEV(ipmi_major, if_num));
 	devfs_remove("ipmidev/%d", if_num);
 }
 
@@ -548,8 +558,15 @@
 	printk(KERN_INFO "ipmi device interface version "
 	       IPMI_DEVINTF_VERSION "\n");
 
+	ipmi_class = class_create(THIS_MODULE, "ipmi");
+	if (IS_ERR(ipmi_class)) {
+		printk(KERN_ERR "ipmi: can't register device class\n");
+		return PTR_ERR(ipmi_class);
+	}
+
 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
 	if (rv < 0) {
+		class_destroy(ipmi_class);
 		printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
 		return rv;
 	}
@@ -563,6 +580,7 @@
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
+		class_destroy(ipmi_class);
 		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
 		return rv;
 	}
@@ -573,6 +591,7 @@
 
 static __exit void cleanup_ipmi(void)
 {
+	class_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
 	devfs_remove(DEVICE_NAME);
 	unregister_chrdev(ipmi_major, DEVICE_NAME);

--------------020808030402060407080404--
