Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268317AbTCCELb>; Sun, 2 Mar 2003 23:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268321AbTCCELb>; Sun, 2 Mar 2003 23:11:31 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:11717
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268317AbTCCELa>; Sun, 2 Mar 2003 23:11:30 -0500
Date: Sun, 2 Mar 2003 23:19:57 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][CHECKER] rtc locking
Message-ID: <Pine.LNX.4.50.0303022317390.25240-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.62-numaq/drivers/char/rtc.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/drivers/char/rtc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 rtc.c
--- linux-2.5.62-numaq/drivers/char/rtc.c	18 Feb 2003 00:15:30 -0000	1.1.1.1
+++ linux-2.5.62-numaq/drivers/char/rtc.c	3 Mar 2003 03:57:09 -0000
@@ -746,13 +746,15 @@
 #else
 	unsigned char tmp;
 
-	spin_lock_irq(&rtc_task_lock);
+	spin_lock_irq(&rtc_lock);
+	spin_lock(&rtc_task_lock);
 	if (rtc_callback != task) {
-		spin_unlock_irq(&rtc_task_lock);
+		spin_unlock(&rtc_task_lock);
+		spin_unlock_irq(rtc_lock);
 		return -ENXIO;
 	}
 	rtc_callback = NULL;
-	spin_lock(&rtc_lock);
+	
 	/* disable controls */
 	tmp = CMOS_READ(RTC_CONTROL);
 	tmp &= ~RTC_PIE;
@@ -765,8 +767,8 @@
 		del_timer(&rtc_irq_timer);
 	}
 	rtc_status &= ~RTC_IS_OPEN;
-	spin_unlock(&rtc_lock);
-	spin_unlock_irq(&rtc_task_lock);
+	spin_unlock(&rtc_task_lock);
+	spin_unlock_irq(&rtc_lock);
 	return 0;
 #endif
 }
