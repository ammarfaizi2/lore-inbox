Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWAIQzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWAIQzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWAIQzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:55:53 -0500
Received: from [81.2.110.250] ([81.2.110.250]:2731 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750929AbWAIQzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:55:52 -0500
Subject: PATCH: Allow reading CMOS day of week register
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 16:58:42 +0000
Message-Id: <1136825923.6659.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone wanted access to this usually unused (and unused by Linux) value
for the day of week. Existing kernels have the field in the struct but
return 0 always. This updates the kernel to fill in the field. The usual
case of 'not set' conveniently is 0.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-mm2/drivers/char/rtc.c linux-2.6.15-mm2/drivers/char/rtc.c
--- linux.vanilla-2.6.15-mm2/drivers/char/rtc.c	2006-01-09 14:31:46.000000000 +0000
+++ linux-2.6.15-mm2/drivers/char/rtc.c	2006-01-09 14:40:29.000000000 +0000
@@ -46,10 +46,10 @@
  *      1.11a   Daniele Bellucci: Audit create_proc_read_entry in rtc_init
  *	1.12	Venkatesh Pallipadi: Hooks for emulating rtc on HPET base-timer
  *		CONFIG_HPET_EMULATE_RTC
- *
+ *	1.12ac	Alan Cox: Allow read access to the day of week register
  */
 
-#define RTC_VERSION		"1.12"
+#define RTC_VERSION		"1.12ac"
 
 #define RTC_IO_EXTENT	0x8
 
@@ -1250,9 +1250,9 @@
 
 	/*
 	 * Only the values that we read from the RTC are set. We leave
-	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
-	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
-	 * by the RTC when initially set to a non-zero value.
+	 * tm_wday, tm_yday and tm_isdst untouched. Note that while the
+	 * RTC has RTC_DAY_OF_WEEK, we should usually ignore it, as it is
+	 * only updated by the RTC when initially set to a non-zero value.
 	 */
 	spin_lock_irq(&rtc_lock);
 	rtc_tm->tm_sec = CMOS_READ(RTC_SECONDS);
@@ -1261,6 +1261,9 @@
 	rtc_tm->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
 	rtc_tm->tm_mon = CMOS_READ(RTC_MONTH);
 	rtc_tm->tm_year = CMOS_READ(RTC_YEAR);
+	/* Only set from 2.6.16 onwards */
+	rtc_tm->tm_wday = CMOS_READ(RTC_DAY_OF_WEEK);
+	
 #ifdef CONFIG_MACH_DECSTATION
 	real_year = CMOS_READ(RTC_DEC_YEAR);
 #endif
@@ -1275,6 +1278,7 @@
 		BCD_TO_BIN(rtc_tm->tm_mday);
 		BCD_TO_BIN(rtc_tm->tm_mon);
 		BCD_TO_BIN(rtc_tm->tm_year);
+		BCD_TO_BIN(rtc_tm->tm_wday);
 	}
 
 #ifdef CONFIG_MACH_DECSTATION

