Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265110AbUF1SDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUF1SDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUF1SDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:03:55 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:2830 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S265110AbUF1SDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:03:51 -0400
Message-ID: <40E05EC2.20700@hp.com>
Date: Mon, 28 Jun 2004 14:09:06 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] hpet related
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew:

Some hpet clean up and a fix to the RTC request_irq issue.

thanks,

Bob

Signed-off-by: Bob Picco at Robert.Picco@hp.com

diff -ruN -X /home/picco/losl/dontdiff linux-2.6.7-mm2-orig/arch/i386/kernel/time_hpet.c linux-2.6.7-mm2-hpet/arch/i386/kernel/time_hpet.c
--- linux-2.6.7-mm2-orig/arch/i386/kernel/time_hpet.c	2004-06-28 13:19:27.000000000 -0400
+++ linux-2.6.7-mm2-hpet/arch/i386/kernel/time_hpet.c	2004-06-24 07:49:24.000000000 -0400
@@ -155,9 +155,9 @@
 		hd.hd_address = hpet_virt_address;
 		hd.hd_nirqs = ntimer;
 		hd.hd_flags = HPET_DATA_PLATFORM;
-		HD_STATE(&hd, 0);
+		hpet_timer_reserved(&hd, 0);
 #ifdef	CONFIG_HPET_EMULATE_RTC
-		HD_STATE(&hd, 1);
+		hpet_timer_reserved(&hd, 1);
 #endif
 		hd.hd_irq[0] = HPET_LEGACY_8254;
 		hd.hd_irq[1] = HPET_LEGACY_RTC;
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.7-mm2-orig/drivers/char/Kconfig linux-2.6.7-mm2-hpet/drivers/char/Kconfig
--- linux-2.6.7-mm2-orig/drivers/char/Kconfig	2004-06-24 07:41:01.000000000 -0400
+++ linux-2.6.7-mm2-hpet/drivers/char/Kconfig	2004-06-28 13:20:55.000000000 -0400
@@ -955,8 +955,8 @@
 	default n
 	depends on ACPI
 	help
-	  If you say Y here, you will have a device named "/dev/hpet/XX" for
-	  each timer supported by the HPET.  The timers are
+	  If you say Y here, you will have a miscdevice named "/dev/hpet/".  Each
+	  open selects one of the timers supported by the HPET.  The timers are
 	  non-periodioc and/or periodic.
 
 config HPET_RTC_IRQ
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.7-mm2-orig/drivers/char/rtc.c linux-2.6.7-mm2-hpet/drivers/char/rtc.c
--- linux-2.6.7-mm2-orig/drivers/char/rtc.c	2004-06-28 13:19:27.000000000 -0400
+++ linux-2.6.7-mm2-hpet/drivers/char/rtc.c	2004-06-27 17:28:26.000000000 -0400
@@ -99,7 +99,6 @@
 
 #ifdef	CONFIG_HPET_RTC_IRQ
 #undef	RTC_IRQ
-#define	RTC_IRQ	0
 #endif
 
 #ifdef RTC_IRQ
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.7-mm2-orig/include/linux/hpet.h linux-2.6.7-mm2-hpet/include/linux/hpet.h
--- linux-2.6.7-mm2-orig/include/linux/hpet.h	2004-06-28 13:19:27.000000000 -0400
+++ linux-2.6.7-mm2-hpet/include/linux/hpet.h	2004-06-24 08:52:30.000000000 -0400
@@ -54,12 +54,6 @@
 #define	HPET_LEG_RT_CNF_MASK		(2UL)
 #define	HPET_ENABLE_CNF_MASK		(1UL)
 
-/*
- * HPET interrupt status register
- */
-
-#define	HPET_ISR_CLEAR(HPET, TIMER)				\
-		(HPET)->hpet_isr |= (1UL << TIMER)
 
 /*
  * Timer configuration register
@@ -115,8 +109,6 @@
 	void *ht_opaque;
 };
 
-#define	HD_STATE(HD, TIMER)	(HD)->hd_state |= (1 << TIMER)
-
 struct hpet_data {
 	unsigned long hd_address;
 	unsigned short hd_nirqs;
@@ -127,6 +119,12 @@
 
 #define	HPET_DATA_PLATFORM	0x0001	/* platform call to hpet_alloc */
 
+static inline void hpet_timer_reserved(struct hpet_data *hd, int timer)
+{
+	hd->hd_state |= (1 << timer);
+	return;
+}
+
 int hpet_alloc(struct hpet_data *);
 int hpet_register(struct hpet_task *, int);
 int hpet_unregister(struct hpet_task *);



