Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVKAVvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVKAVvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVKAVvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:51:25 -0500
Received: from fmr20.intel.com ([134.134.136.19]:42967 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751294AbVKAVvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:51:24 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Linus Torvalds <torvalds@osdl.org>
Subject: compile error in tlclk in 2.6.14-git4
Date: Tue, 1 Nov 2005 13:51:16 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011351.16087.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the declaration of platform_device_register_simple moved.  
I'm also including some clean ups from Alan Cox below:

--mgross

Signed-off-by: Mark Gross <mark.gross@intel.com>

diff -urN -X dontdiff linux-2.6.14/drivers/char/tlclk.c linux-2.6.14-tlclk/drivers/char/tlclk.c
--- linux-2.6.14/drivers/char/tlclk.c 2005-11-01 13:42:58.000000000 -0800
+++ linux-2.6.14-tlclk/drivers/char/tlclk.c 2005-11-01 13:34:30.000000000 -0800
@@ -43,6 +43,7 @@
 #include <linux/sysfs.h>
 #include <linux/device.h>
 #include <linux/miscdevice.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>  /* inb/outb */
 #include <asm/uaccess.h>
 
@@ -210,7 +211,7 @@
  result = request_irq(telclk_interrupt, &tlclk_interrupt,
         SA_INTERRUPT, "telco_clock", tlclk_interrupt);
  if (result == -EBUSY) {
-  printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
+  printk(KERN_ERR "telco_clock: Interrupt can't be reserved.\n");
   return -EBUSY;
  }
  inb(TLCLK_REG6); /* Clear interrupt events */
@@ -740,7 +741,7 @@
 
  ret = register_chrdev(tlclk_major, "telco_clock", &tlclk_fops);
  if (ret < 0) {
-  printk(KERN_ERR "telco_clock: can't get major! %d\n", tlclk_major);
+  printk(KERN_ERR "tlclk: can't get major %d.\n", tlclk_major);
   return ret;
  }
  alarm_events = kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
@@ -749,7 +750,7 @@
 
  /* Read telecom clock IRQ number (Set by BIOS) */
  if (!request_region(TLCLK_BASE, 8, "telco_clock")) {
-  printk(KERN_ERR "tlclk: request_region failed! 0x%X\n",
+  printk(KERN_ERR "tlclk: request_region 0x%X failed.\n",
    TLCLK_BASE);
   ret = -EBUSY;
   goto out2;
@@ -757,7 +758,7 @@
  telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
 
  if (0x0F == telclk_interrupt ) { /* not MCPBL0010 ? */
-  printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw\n",
+  printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw.\n",
    telclk_interrupt);
   ret = -ENXIO;
   goto out3;
@@ -767,7 +768,7 @@
 
  ret = misc_register(&tlclk_miscdev);
  if (ret < 0) {
-  printk(KERN_ERR " misc_register retruns %d\n", ret);
+  printk(KERN_ERR "tlclk: misc_register returns %d.\n", ret);
   ret = -EBUSY;
   goto out3;
  }
@@ -775,8 +776,7 @@
  tlclk_device = platform_device_register_simple("telco_clock",
     -1, NULL, 0);
  if (!tlclk_device) {
-  printk(KERN_ERR " platform_device_register retruns 0x%X\n",
-   (unsigned int) tlclk_device);
+  printk(KERN_ERR "tlclk: platform_device_register failed.\n");
   ret = -EBUSY;
   goto out4;
  }
@@ -784,7 +784,7 @@
  ret = sysfs_create_group(&tlclk_device->dev.kobj,
    &tlclk_attribute_group);
  if (ret) {
-  printk(KERN_ERR "failed to create sysfs device attributes\n");
+  printk(KERN_ERR "tlclk: failed to create sysfs device attributes.\n");
   sysfs_remove_group(&tlclk_device->dev.kobj,
    &tlclk_attribute_group);
   goto out5;

-- 
--mgross
Intel Open Source Technology Center
