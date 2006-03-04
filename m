Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWCDFCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWCDFCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 00:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWCDFCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 00:02:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:34483 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751003AbWCDFCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 00:02:24 -0500
Subject: [RFC][PATCH] export clocksource resolution (experimental)
From: john stultz <johnstul@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 21:02:21 -0800
Message-Id: <1141448541.9727.153.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,
	Earlier there was some discussion of trying to export the clocksource
resolution so it could be used to make sure we don't expire hrtimers
early. I scratched out this first pass patch to provide an interface to
do so. Let me know if this was similar to what you were thinking of.

thanks
-john

 include/linux/timeofday.h |    1 +
 kernel/time/timeofday.c   |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

linux-2.6.16-rc5_timeofday-clocksource-resolution_B20.patch
============================================
diff --git a/include/linux/timeofday.h b/include/linux/timeofday.h
index 5222c4c..fb47e82 100644
--- a/include/linux/timeofday.h
+++ b/include/linux/timeofday.h
@@ -30,6 +30,7 @@ extern int do_settimeofday(struct timesp
 
 /* Internal functions */
 extern int timeofday_is_continuous(void);
+extern u32 timeofday_get_clockres(void);
 extern void timeofday_init(void);
 
 #ifndef CONFIG_IS_TICK_BASED
diff --git a/kernel/time/timeofday.c b/kernel/time/timeofday.c
index 8085b86..5d1d6e4 100644
--- a/kernel/time/timeofday.c
+++ b/kernel/time/timeofday.c
@@ -650,6 +650,24 @@ int timeofday_is_continuous(void)
 }
 
 /**
+ * timeofday_get_clockres - returns the underlying clocksource's resolution
+ */
+u32 timeofday_get_clockres(void)
+{
+	unsigned long seq;
+	u32 res;
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		/* take one cycle -> N+1 nsecs */
+		res = cyc2ns(clock, 0, 1) + 1;
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return res;
+}
+
+/**
  * timeofday_init - Initializes time variables
  */
 void __init timeofday_init(void)


