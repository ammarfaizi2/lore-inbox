Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVLUAAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVLUAAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 19:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVLUAAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 19:00:25 -0500
Received: from [81.2.110.250] ([81.2.110.250]:54253 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932223AbVLUAAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 19:00:24 -0500
Subject: PATCH:  day of week (RE: Kernel interrupts disable at user level -
	RIGHT/ WRONG - Help)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B2232A4@mail.esn.co.in>
References: <3AEC1E10243A314391FE9C01CD65429B2232A4@mail.esn.co.in>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Dec 2005 00:00:52 +0000
Message-Id: <1135123252.25010.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-20 at 14:32 +0530, Mukund JB. wrote:
> >  > I tried the /dev/rtc but I don't get it there.
> > 
> > Use /dev/nvram instead.
> > 
> > 		Dave
> 
> /dev/nvram does not give the cpomplete CMOS details. A part of RTC & date, tine and other info will be missing.


What Dave should have said is use /dev/nvram as well.

>From /dev/rtc you get registers 0-9 except as you said 6
>From /dev/nvram you get A+

The lack of day of week is odd but fixable. The struct tm already has a
field for tm_wday (day of week) so we can fill it in. Whether it is
valid is another question.

What do people thing about this ?

Signed-off-by: Alan Cox <alan@redhat.com>

--- drivers/char/rtc.c~	2005-12-20 23:40:34.912559808 +0000
+++ drivers/char/rtc.c	2005-12-20 23:51:16.428034632 +0000
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

