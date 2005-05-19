Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVESXaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVESXaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVESX1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:27:36 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:51845 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261299AbVESX0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:26:12 -0400
Message-ID: <428D208C.1000307@acm.org>
Date: Thu, 19 May 2005 18:26:04 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add sysfs support for the IPMI device interface
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Could you please add this patch to the main tree?  I can't send it to 
Andrew because he has a rework of this in his tree that has not made it 
into yours yet, and I'd like to have this in before 2.6.12 is released.

-Corey


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
+    char                  name[10];
+    dev_t                 dev = MKDEV(ipmi_major, if_num);
+
     devfs_mk_cdev(MKDEV(ipmi_major, if_num),
               S_IFCHR | S_IRUSR | S_IWUSR,
               "ipmidev/%d", if_num);
+
+    snprintf(name, sizeof(name), "ipmi%d", if_num);
+    class_simple_device_add(ipmi_class, dev, NULL, name);
 }
 
 static void ipmi_smi_gone(int if_num)
 {
+    class_simple_device_remove(MKDEV(ipmi_major, if_num));
     devfs_remove("ipmidev/%d", if_num);
 }
 
@@ -548,8 +558,15 @@
     printk(KERN_INFO "ipmi device interface version "
            IPMI_DEVINTF_VERSION "\n");
 
+    ipmi_class = class_simple_create(THIS_MODULE, "ipmi");
+    if (IS_ERR(ipmi_class)) {
+        printk(KERN_ERR "ipmi: can't register device class\n");
+        return PTR_ERR(ipmi_class);
+    }
+
     rv = register_chrdev(ipmi_major, DEVICE_NAME, &ipmi_fops);
     if (rv < 0) {
+        class_simple_destroy(ipmi_class);
         printk(KERN_ERR "ipmi: can't get major %d\n", ipmi_major);
         return rv;
     }
@@ -563,6 +580,7 @@
     rv = ipmi_smi_watcher_register(&smi_watcher);
     if (rv) {
         unregister_chrdev(ipmi_major, DEVICE_NAME);
+        class_simple_destroy(ipmi_class);
         printk(KERN_WARNING "ipmi: can't register smi watcher\n");
         return rv;
     }
@@ -573,6 +591,7 @@
 
 static __exit void cleanup_ipmi(void)
 {
+    class_simple_destroy(ipmi_class);
     ipmi_smi_watcher_unregister(&smi_watcher);
     devfs_remove(DEVICE_NAME);
     unregister_chrdev(ipmi_major, DEVICE_NAME);

