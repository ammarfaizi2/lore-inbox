Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUGBOIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUGBOIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUGBOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:08:47 -0400
Received: from sd291.sivit.org ([194.146.225.122]:49305 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S264561AbUGBOIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:08:37 -0400
Date: Fri, 2 Jul 2004 16:08:25 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6] meye driver update (wait_ms -> msleep)
Message-ID: <20040702140825.GD2942@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch, originally from Daniel Drake, replaces the meye driver
'wait_ms()' function with calls to the kernel provided 'msleep()'
function.

Linus, Andrew, please apply.

Thanks,

Stelian.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Stelian Pop <stelian@popies.net>

===== drivers/media/video/meye.h 1.13 vs edited =====
--- 1.13/drivers/media/video/meye.h	2004-03-19 07:04:56 +01:00
+++ edited/drivers/media/video/meye.h	2004-07-02 10:58:56 +02:00
@@ -31,7 +31,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	9
+#define MEYE_DRIVER_MINORVERSION	10
 
 #include <linux/config.h>
 #include <linux/types.h>
===== drivers/media/video/meye.c 1.21 vs edited =====
--- 1.21/drivers/media/video/meye.c	2004-03-19 07:04:56 +01:00
+++ edited/drivers/media/video/meye.c	2004-07-02 10:58:36 +02:00
@@ -473,16 +473,6 @@
 /* MCHIP low-level functions                                                */
 /****************************************************************************/
 
-/* waits for the specified miliseconds */
-static inline void wait_ms(unsigned int ms) {
-	if (!in_interrupt()) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1 + ms * HZ / 1000);
-	}
-	else
-		mdelay(ms);
-}
-
 /* returns the horizontal capture size */
 static inline int mchip_hsize(void) {
 	return meye.params.subsample ? 320 : 640;
@@ -640,12 +630,12 @@
 		for (j = 0; j < 100; ++j) {
 			if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
 				return;
-			wait_ms(1);
+			msleep(1);
 		}
 		printk(KERN_ERR "meye: need to reset HIC!\n");
 	
 		mchip_set(MCHIP_HIC_CTL, MCHIP_HIC_CTL_SOFT_RESET);
-		wait_ms(250);
+		msleep(250);
 	}
 	printk(KERN_ERR "meye: resetting HIC hanged!\n");
 }
@@ -741,7 +731,7 @@
 	for (i = 0; i < 100; ++i) {
 		if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
 			break;
-		wait_ms(1);
+		msleep(1);
 	}
 }
 
@@ -757,7 +747,7 @@
 	for (i = 0; i < 100; ++i) {
 		if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
 			break;
-		wait_ms(1);
+		msleep(1);
 	}
 	for (i = 0; i < 4 ; ++i) {
 		v = mchip_get_frame();
@@ -799,7 +789,7 @@
 	for (i = 0; i < 100; ++i) {
 		if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
 			break;
-		wait_ms(1);
+		msleep(1);
 	}
 
 	for (i = 0; i < 4 ; ++i) {
@@ -1260,11 +1250,11 @@
 
 	mchip_delay(MCHIP_HIC_CMD, 0);
 	mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE);
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_VRJ_SOFT_RESET, 1);
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_MM_PCI_MODE, 5);
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_MM_INTA, MCHIP_MM_INTA_HIC_1_MASK);
 
 	switch (meye.pm_mchip_mode) {
@@ -1349,13 +1339,13 @@
 	mchip_delay(MCHIP_HIC_CMD, 0);
 	mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE);
 
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_VRJ_SOFT_RESET, 1);
 
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_MM_PCI_MODE, 5);
 
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_MM_INTA, MCHIP_MM_INTA_HIC_1_MASK);
 
 	if (video_register_device(meye.video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
-- 
Stelian Pop <stelian@popies.net>    
