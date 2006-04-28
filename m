Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWD1QYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWD1QYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWD1QYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:24:47 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:8174 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1030473AbWD1QYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:24:46 -0400
Date: Sat, 29 Apr 2006 01:25:19 +0900 (JST)
Message-Id: <20060429.012519.126141613.anemo@mba.ocn.ne.jp>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] RTC: rtc-dev tweak for 64-bit kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make rtc-dev more friendly to 64-bit platforms with 32-bit userland.
This tweak is came from genrtc driver.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index b1e3e61..ae6adc4 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -58,7 +58,7 @@ rtc_dev_read(struct file *file, char __u
 	unsigned long data;
 	ssize_t ret;
 
-	if (count < sizeof(unsigned long))
+	if (count != sizeof (unsigned int) && count < sizeof (unsigned long))
 		return -EINVAL;
 
 	add_wait_queue(&rtc->irq_queue, &wait);
@@ -92,9 +92,13 @@ rtc_dev_read(struct file *file, char __u
 		if (rtc->ops->read_callback)
 			data = rtc->ops->read_callback(rtc->class_dev.dev, data);
 
-		ret = put_user(data, (unsigned long __user *)buf);
-		if (ret == 0)
-			ret = sizeof(unsigned long);
+		if (sizeof (int) != sizeof (long) &&
+		    count == sizeof (unsigned int))
+			ret = put_user(data, (unsigned int __user *)buf) ?:
+				sizeof(unsigned int);
+		else
+			ret = put_user(data, (unsigned long __user *)buf) ?:
+				sizeof(unsigned long);
 	}
 	return ret;
 }
