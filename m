Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425479AbWLHMRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425479AbWLHMRC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425482AbWLHMRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:17:01 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:7545
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1425479AbWLHMQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:16:59 -0500
Message-Id: <45796610.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 08 Dec 2006 12:18:08 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <a.zummo@towertech.it>, <p_gortmaker@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] RTC driver init adjustment
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch
- conditionalizes procfs code upon CONFIG_PROC_FS (to reduce code size when
  that option is not enabled)
- makes initialization no longer fail when the procfs entry can't be allocated
  (namely would initialization always have failed when CONFIG_PROC_FS was not
  set)
- moves the formerly file-scope static variable rtc_int_handler_ptr into the
  only function using it, and makes it automatic.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19/drivers/char/rtc.c	2006-12-08 13:03:35.000000000 +0100
+++ 2.6.19-rtc-cleanup/drivers/char/rtc.c	2006-12-08 13:07:42.000000000 +0100
@@ -113,7 +113,7 @@ static int rtc_has_irq = 1;
 #define hpet_set_rtc_irq_bit(arg) 		0
 #define hpet_rtc_timer_init() 			do { } while (0)
 #define hpet_rtc_dropped_irq() 			0
-static inline irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id) {return 0;}
+static irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id) {return 0;}
 #else
 extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id);
 #endif
@@ -165,7 +165,9 @@ static void mask_rtc_irq_bit(unsigned ch
 }
 #endif
 
+#ifdef CONFIG_PROC_FS
 static int rtc_proc_open(struct inode *inode, struct file *file);
+#endif
 
 /*
  *	Bits in rtc_status. (6 bits of room for future expansion)
@@ -906,6 +908,7 @@ static struct miscdevice rtc_dev = {
 	.fops		= &rtc_fops,
 };
 
+#ifdef CONFIG_PROC_FS
 static const struct file_operations rtc_proc_fops = {
 	.owner = THIS_MODULE,
 	.open = rtc_proc_open,
@@ -913,14 +916,13 @@ static const struct file_operations rtc_
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-
-#if defined(RTC_IRQ) && !defined(__sparc__)
-static irq_handler_t rtc_int_handler_ptr;
 #endif
 
 static int __init rtc_init(void)
 {
+#ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *ent;
+#endif
 #if defined(__alpha__) || defined(__mips__)
 	unsigned int year, ctrl;
 	char *guess = NULL;
@@ -932,9 +934,11 @@ static int __init rtc_init(void)
 	struct sparc_isa_bridge *isa_br;
 	struct sparc_isa_device *isa_dev;
 #endif
-#endif
-#ifndef __sparc__
+#else
 	void *r;
+#ifdef RTC_IRQ
+	irq_handler_t rtc_int_handler_ptr;
+#endif
 #endif
 
 #ifdef __sparc__
@@ -1024,17 +1028,13 @@ no_irq:
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_PROC_FS
 	ent = create_proc_entry("driver/rtc", 0, NULL);
-	if (!ent) {
-#ifdef RTC_IRQ
-		free_irq(RTC_IRQ, NULL);
-		rtc_has_irq = 0;
+	if (ent)
+		ent->proc_fops = &rtc_proc_fops;
+	else
+		printk(KERN_WARNING "rtc: Failed to register with procfs.\n");
 #endif
-		release_region(RTC_PORT(0), RTC_IO_EXTENT);
-		misc_deregister(&rtc_dev);
-		return -ENOMEM;
-	}
-	ent->proc_fops = &rtc_proc_fops;
 
 #if defined(__alpha__) || defined(__mips__)
 	rtc_freq = HZ;
@@ -1167,6 +1167,7 @@ static void rtc_dropped_irq(unsigned lon
 }
 #endif
 
+#ifdef CONFIG_PROC_FS
 /*
  *	Info exported via "/proc/driver/rtc".
  */
@@ -1251,6 +1252,7 @@ static int rtc_proc_open(struct inode *i
 {
 	return single_open(file, rtc_proc_show, NULL);
 }
+#endif
 
 void rtc_get_rtc_time(struct rtc_time *rtc_tm)
 {


