Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVKVTVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVKVTVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbVKVTVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:21:40 -0500
Received: from fmr19.intel.com ([134.134.136.18]:10980 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S965135AbVKVTVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:21:38 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] minor clean up and update to tlclk.c for 2.6.15-rc2-git2
Date: Tue, 22 Nov 2005 11:21:31 -0800
User-Agent: KMail/1.7.1
Cc: mark.gross@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511221121.31437.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This time without the HTLM :(  

The following cleans up the telecom clock driver for the MPCBL0010.  
There was a small TPS change that this update relflects.
There where some non-static functions that are now static.

Signed-off-by: Mark Gross <mark.gross@intel.com>


diff -urN -X dontdiff linux-2.6.15-rc2-git2/drivers/char/tlclk.c linux-2.6.15-rc2-git2-tlclk/drivers/char/tlclk.c
--- linux-2.6.15-rc2-git2/drivers/char/tlclk.c 2005-11-22 09:45:38.000000000 -0800
+++ linux-2.6.15-rc2-git2-tlclk/drivers/char/tlclk.c 2005-11-22 10:41:42.000000000 -0800
@@ -34,7 +34,6 @@
 #include <linux/kernel.h> /* printk() */
 #include <linux/fs.h>  /* everything... */
 #include <linux/errno.h> /* error codes */
-#include <linux/delay.h> /* udelay */
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
@@ -165,7 +164,7 @@
 filter_select   :
 hardware_switching  :
 hardware_switching_mode  :
-interrupt_switch  :
+telclock_version  :
 mode_select   :
 refalign   :
 reset    :
@@ -173,7 +172,6 @@
 select_amcb2_transmit_clock :
 select_redundant_clock  :
 select_ref_frequency  :
-test_mode   :
 
 All sysfs interfaces are integers in hex format, i.e echo 99 > refalign
 has the same effect as echo 0x99 > refalign.
@@ -226,7 +224,7 @@
  return 0;
 }
 
-ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
+static ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
   loff_t *f_pos)
 {
  if (count < sizeof(struct tlclk_alarms))
@@ -242,7 +240,7 @@
  return  sizeof(struct tlclk_alarms);
 }
 
-ssize_t tlclk_write(struct file *filp, const char __user *buf, size_t count,
+static ssize_t tlclk_write(struct file *filp, const char __user *buf, size_t count,
      loff_t *f_pos)
 {
  return 0;
@@ -278,21 +276,21 @@
 static DEVICE_ATTR(current_ref, S_IRUGO, show_current_ref, NULL);
 
 
-static ssize_t show_interrupt_switch(struct device *d,
+static ssize_t show_telclock_version(struct device *d,
   struct device_attribute *attr, char *buf)
 {
  unsigned long ret_val;
  unsigned long flags;
 
  spin_lock_irqsave(&event_lock, flags);
- ret_val = inb(TLCLK_REG6);
+ ret_val = inb(TLCLK_REG5);
  spin_unlock_irqrestore(&event_lock, flags);
 
  return sprintf(buf, "0x%lX\n", ret_val);
 }
 
-static DEVICE_ATTR(interrupt_switch, S_IRUGO,
-  show_interrupt_switch, NULL);
+static DEVICE_ATTR(telclock_version, S_IRUGO,
+  show_telclock_version, NULL);
 
 static ssize_t show_alarms(struct device *d,
   struct device_attribute *attr,  char *buf)
@@ -436,26 +434,6 @@
 static DEVICE_ATTR(enable_clka0_output, S_IWUGO, NULL,
   store_enable_clka0_output);
 
-static ssize_t store_test_mode(struct device *d,
-  struct device_attribute *attr,  const char *buf, size_t count)
-{
- unsigned long flags;
- unsigned long tmp;
- unsigned char val;
-
- sscanf(buf, "%lX", &tmp);
- dev_dbg(d, "tmp = 0x%lX\n", tmp);
-
- val = (unsigned char)tmp;
- spin_lock_irqsave(&event_lock, flags);
- SET_PORT_BITS(TLCLK_REG4, 0xfd, 2);
- spin_unlock_irqrestore(&event_lock, flags);
-
- return strnlen(buf, count);
-}
-
-static DEVICE_ATTR(test_mode, S_IWUGO, NULL, store_test_mode);
-
 static ssize_t store_select_amcb2_transmit_clock(struct device *d,
   struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -475,7 +453,7 @@
    SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
    switch (val) {
    case CLK_8_592MHz:
-    SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+    SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
     break;
    case CLK_11_184MHz:
     SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
@@ -484,7 +462,7 @@
     SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
     break;
    case CLK_44_736MHz:
-    SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+    SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
     break;
    }
   } else
@@ -653,9 +631,7 @@
  dev_dbg(d, "tmp = 0x%lX\n", tmp);
  spin_lock_irqsave(&event_lock, flags);
  SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
- udelay(2);
  SET_PORT_BITS(TLCLK_REG0, 0xf7, 0x08);
- udelay(2);
  SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
  spin_unlock_irqrestore(&event_lock, flags);
 
@@ -706,7 +682,7 @@
 
 static struct attribute *tlclk_sysfs_entries[] = {
  &dev_attr_current_ref.attr,
- &dev_attr_interrupt_switch.attr,
+ &dev_attr_telclock_version.attr,
  &dev_attr_alarms.attr,
  &dev_attr_enable_clk3a_output.attr,
  &dev_attr_enable_clk3b_output.attr,
@@ -714,7 +690,6 @@
  &dev_attr_enable_clka1_output.attr,
  &dev_attr_enable_clkb0_output.attr,
  &dev_attr_enable_clka0_output.attr,
- &dev_attr_test_mode.attr,
  &dev_attr_select_amcb1_transmit_clock.attr,
  &dev_attr_select_amcb2_transmit_clock.attr,
  &dev_attr_select_redundant_clock.attr,



-- 
--mgross
Intel Open Source Technology Center
