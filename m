Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263099AbVCME67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263099AbVCME67 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 23:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbVCME5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 23:57:44 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:8605 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263077AbVCME5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 23:57:25 -0500
Message-ID: <4233C834.40903@acm.org>
Date: Sat, 12 Mar 2005 22:57:24 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add sysfs support to the IPMI driver
Content-Type: multipart/mixed;
 boundary="------------050707000903080502020903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050707000903080502020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The IPMI driver has long needed to tie into the device model (and I've 
long been hoping someone else would do it).  I finally gave up and spent 
the time to learn how to do it.  I think this is right, it seems to work 
on on my system.

-Corey

--------------050707000903080502020903
Content-Type: text/x-patch;
 name="ipmi-sysfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-sysfs.diff"

Add support for sysfs to the IPMI device interface.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-mm1/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.11-mm1.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.11-mm1/drivers/char/ipmi/ipmi_devintf.c
@@ -44,6 +44,7 @@
 #include <linux/ipmi.h>
 #include <asm/semaphore.h>
 #include <linux/init.h>
+#include <linux/device.h>
 
 #define IPMI_DEVINTF_VERSION "v33"
 
@@ -519,15 +520,24 @@
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
+static struct class_simple *ipmi_class;
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
+	class_simple_device_add(ipmi_class, dev, NULL, name);
 }
 
 static void ipmi_smi_gone(int if_num)
 {
+	class_simple_device_remove(MKDEV(ipmi_major, if_num));
 	devfs_remove("ipmidev/%d", if_num);
 }
 
@@ -548,8 +558,15 @@
 	printk(KERN_INFO "ipmi device interface version "
 	       IPMI_DEVINTF_VERSION "\n");
 
+	ipmi_class = class_simple_create(THIS_MODULE, "ipmi");
+	if (IS_ERR(ipmi_class)) {
+		printk(KERN_ERR "ipmi: can't register device class\n");
+		return PTR_ERR(ipmi_class);
+	}
+
 	rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
 	if (rv < 0) {
+		class_simple_destroy(ipmi_class);
 		printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
 		return rv;
 	}
@@ -563,6 +580,7 @@
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
+		class_simple_destroy(ipmi_class);
 		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
 		return rv;
 	}
@@ -573,6 +591,7 @@
 
 static __exit void cleanup_ipmi(void)
 {
+	class_simple_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
 	devfs_remove(DEVICE_NAME);
 	unregister_chrdev(ipmi_major, DEVICE_NAME);

--------------050707000903080502020903--
