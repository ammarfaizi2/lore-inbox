Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVAHJsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVAHJsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVAHJqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:46:31 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:22493 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261968AbVAHJlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:41:04 -0500
Subject: Patch 3/3: Reduce number of get_cmos_time_calls.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, John Stultz <johnstul@us.ibm.com>,
       David Shaohua <shaohua.li@intel.com>
In-Reply-To: <1105176732.5478.20.camel@desktop.cunninghams>
References: <1105176732.5478.20.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1105177308.5478.43.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 08 Jan 2005 20:42:22 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create new __get_cmos_time patch, which doesn't wait for the start of a
new second before returning. Adjust timer_suspend to use this as we
don't appear to need the exact start of a second when suspending.

Signed-off-by: Nigel Cunningham <ncunningham@linuxmail.org>

diff -ruNp 913-old/arch/i386/kernel/time.c 913-new/arch/i386/kernel/time.c
--- 913-old/arch/i386/kernel/time.c	2005-01-08 19:40:06.149971536 +1100
+++ 913-new/arch/i386/kernel/time.c	2005-01-08 19:39:51.915135560 +1100
@@ -327,7 +327,7 @@ static int timer_suspend(struct sys_devi
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	long cmos_time = get_cmos_time();
+	long cmos_time = __get_cmos_time();
 	
 	clock_cmos_diff = -cmos_time;
 	clock_cmos_diff += get_seconds();
diff -ruNp 913-old/arch/x86_64/kernel/time.c 913-new/arch/x86_64/kernel/time.c
--- 913-old/arch/x86_64/kernel/time.c	2004-12-10 14:27:08.000000000 +1100
+++ 913-new/arch/x86_64/kernel/time.c	2005-01-08 19:39:24.664278320 +1100
@@ -499,11 +499,56 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(a);
 }
 
+unsigned long __get_cmos_time(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
+
+	/*
+	 * Do we need the spinlock in here too?
+	 *
+	 * If we're called directly (not via get_cmos_time),
+	 * we're in the middle of a sysdev suspend/resume
+	 * and interrupts are disabled, so this 
+	 * should be safe without any locking.
+	 * 				-- NC
+	 */
+
+	do {
+		sec = CMOS_READ(RTC_SECONDS);
+		min = CMOS_READ(RTC_MINUTES);
+		hour = CMOS_READ(RTC_HOURS);
+		day = CMOS_READ(RTC_DAY_OF_MONTH);
+		mon = CMOS_READ(RTC_MONTH);
+		year = CMOS_READ(RTC_YEAR);
+	} while (sec != CMOS_READ(RTC_SECONDS));
+
+	/*
+	 * We know that x86-64 always uses BCD format, no need to check the config
+	 * register.
+	 */
+
+	    BCD_TO_BIN(sec);
+	    BCD_TO_BIN(min);
+	    BCD_TO_BIN(hour);
+	    BCD_TO_BIN(day);
+	    BCD_TO_BIN(mon);
+	    BCD_TO_BIN(year);
+
+	/*
+	 * This will work up to Dec 31, 2069.
+	 */
+
+	if ((year += 1900) < 1970)
+		year += 100;
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
 unsigned long get_cmos_time(void)
 {
-	unsigned int timeout, year, mon, day, hour, min, sec;
+	unsigned int timeout;
 	unsigned char last, this;
-	unsigned long flags;
+	unsigned long flags, result;
 
 /*
  * The Linux interpretation of the CMOS clock register contents: When the
@@ -524,40 +569,11 @@ unsigned long get_cmos_time(void)
 		timeout--;
 	}
 
-/*
- * Here we are safe to assume the registers won't change for a whole second, so
- * we just go ahead and read them.
-	 */
-
-		sec = CMOS_READ(RTC_SECONDS);
-		min = CMOS_READ(RTC_MINUTES);
-		hour = CMOS_READ(RTC_HOURS);
-		day = CMOS_READ(RTC_DAY_OF_MONTH);
-		mon = CMOS_READ(RTC_MONTH);
-		year = CMOS_READ(RTC_YEAR);
-
+	result =  __get_cmos_time();
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
-/*
- * We know that x86-64 always uses BCD format, no need to check the config
- * register.
- */
-
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
+	return result;
 
-/*
- * This will work up to Dec 31, 2069.
- */
-
-	if ((year += 1900) < 1970)
-		year += 100;
-
-	return mktime(year, mon, day, hour, min, sec);
 }
 
 #ifdef CONFIG_CPU_FREQ
@@ -962,7 +978,7 @@ static int timer_suspend(struct sys_devi
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff = -__get_cmos_time();
 	clock_cmos_diff += get_seconds();
 	return 0;
 }
diff -ruNp 913-old/include/asm-i386/mach-default/mach_time.h 913-new/include/asm-i386/mach-default/mach_time.h
--- 913-old/include/asm-i386/mach-default/mach_time.h	2004-11-03 21:53:12.000000000 +1100
+++ 913-new/include/asm-i386/mach-default/mach_time.h	2005-01-08 19:39:24.676276496 +1100
@@ -79,24 +79,19 @@ static inline int mach_set_rtc_mmss(unsi
 	return retval;
 }
 
-static inline unsigned long mach_get_cmos_time(void)
+/* __get_cmos_time
+ *
+ * Separated out from mach_get_cmos_time so that we can
+ * quickly get the cmos time when we don't care about
+ * whether the second has just started.
+ *
+ * Used from suspend and resume sysdev calls.
+ */
+static inline unsigned long __get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
 
-	/* The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+	do {
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
@@ -104,6 +99,7 @@ static inline unsigned long mach_get_cmo
 		mon = CMOS_READ(RTC_MONTH);
 		year = CMOS_READ(RTC_YEAR);
 	} while (sec != CMOS_READ(RTC_SECONDS));
+
 	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	  {
 	    BCD_TO_BIN(sec);
@@ -119,4 +115,24 @@ static inline unsigned long mach_get_cmo
 	return mktime(year, mon, day, hour, min, sec);
 }
 
+static inline unsigned long mach_get_cmos_time(void)
+{
+	int i;
+
+	/* The Linux interpretation of the CMOS clock register contents:
+	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
+	 * RTC registers show the second which has precisely just started.
+	 * Let's hope other operating systems interpret the RTC the same way.
+	 */
+	/* read RTC exactly on falling edge of update flag */
+	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
+		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+			break;
+	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
+		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+			break;
+
+	return __get_cmos_time();
+}
+
 #endif /* !_MACH_TIME_H */


