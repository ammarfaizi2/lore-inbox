Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318780AbSHGQrZ>; Wed, 7 Aug 2002 12:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318782AbSHGQqh>; Wed, 7 Aug 2002 12:46:37 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:26240
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S318780AbSHGQqV>; Wed, 7 Aug 2002 12:46:21 -0400
Date: Wed, 7 Aug 2002 09:49:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH][RESEND x 2] A generic RTC driver [3/3]
Message-ID: <20020807164948.GG744@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 3 of 3 of the genrtc patches.  This is my own slight bit
of work, as well as some work by Randolph Chung. This changes
set_rtc_time(struct *rtc_time) to return an int instead of void.
This was done so that the arch-specific code here could do additional
checks on the time and return an error if needed. This then introduces
include/asm-generic/rtc.h, include/asm-i386/rtc.h and
include/asm-alpha/rtc.h.  include/asm-generic/rtc.h contains the
get_rtc_time and set_rtc_time logic that is in drivers/char/rtc.c and
has been tested on SMP i386.  This also modifies include/asm-ppc/rtc.h
to return -ENODEV if no rtc hardware is present.

Additionally, Dave Jones pointed out to me a place where we might not be
safe when jiffies wraps, so this switches that to time_after().

>From Randolph Chung, is supprt for a 64bit kernel and a 32bit userland.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- linux-2.5/include/asm-ppc/rtc.h	2002-07-24 13:25:15.000000000 -0700
+++ linux-2.5/include/asm-ppc/rtc.h	2002-07-24 13:25:36.000000000 -0700
@@ -68,7 +68,10 @@
 				time->tm_sec);
 
 		(ppc_md.set_rtc_time)(nowtime);
-	}
+
+		return 0;
+	} else
+		return -EINVAL;
 }
 
 static inline unsigned int get_rtc_ss(void)
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.5/include/asm-generic/rtc.h	2002-07-24 11:06:48.000000000 -0700
@@ -0,0 +1,211 @@
+/* 
+ * inclue/asm-generic/rtc.h
+ *
+ * Author: Tom Rini <trini@mvista.com>
+ *
+ * Based on:
+ * drivers/char/rtc.c
+ *
+ * Please read the COPYING file for all license details.
+ */
+
+#ifndef __ASM_RTC_H__
+#define __ASM_RTC_H__
+
+#ifdef __KERNEL__
+
+#include <linux/mc146818rtc.h>
+#include <linux/rtc.h>
+
+#define RTC_PIE 0x40		/* periodic interrupt enable */
+#define RTC_AIE 0x20		/* alarm interrupt enable */
+#define RTC_UIE 0x10		/* update-finished interrupt enable */
+
+extern void gen_rtc_interrupt(unsigned long);
+
+/* some dummy definitions */
+#define RTC_SQWE 0x08		/* enable square-wave output */
+#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
+#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
+#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
+
+/*
+ * Returns true if a clock update is in progress
+ */
+static inline unsigned char rtc_is_updating(void)
+{
+	unsigned char uip;
+
+	spin_lock_irq(&rtc_lock);
+	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
+	spin_unlock_irq(&rtc_lock);
+	return uip;
+}
+
+static inline void get_rtc_time(struct rtc_time *time)
+{
+	unsigned long uip_watchdog = jiffies;
+	unsigned char ctrl;
+#ifdef CONFIG_DECSTATION
+	unsigned int real_year;
+#endif
+
+	/*
+	 * read RTC once any update in progress is done. The update
+	 * can take just over 2ms. We wait 10 to 20ms. There is no need to
+	 * to poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
+	 * If you need to know *exactly* when a second has started, enable
+	 * periodic update complete interrupts, (via ioctl) and then 
+	 * immediately read /dev/rtc which will block until you get the IRQ.
+	 * Once the read clears, read the RTC time (again via ioctl). Easy.
+	 */
+
+	if (rtc_is_updating() != 0)
+		while (jiffies - uip_watchdog < 2*HZ/100) {
+			barrier();
+			cpu_relax();
+		}
+
+	/*
+	 * Only the values that we read from the RTC are set. We leave
+	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
+	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
+	 * by the RTC when initially set to a non-zero value.
+	 */
+	spin_lock_irq(&rtc_lock);
+	time->tm_sec = CMOS_READ(RTC_SECONDS);
+	time->tm_min = CMOS_READ(RTC_MINUTES);
+	time->tm_hour = CMOS_READ(RTC_HOURS);
+	time->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
+	time->tm_mon = CMOS_READ(RTC_MONTH);
+	time->tm_year = CMOS_READ(RTC_YEAR);
+#ifdef CONFIG_DECSTATION
+	real_year = CMOS_READ(RTC_DEC_YEAR);
+#endif
+	ctrl = CMOS_READ(RTC_CONTROL);
+	spin_unlock_irq(&rtc_lock);
+
+	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+	{
+		BCD_TO_BIN(time->tm_sec);
+		BCD_TO_BIN(time->tm_min);
+		BCD_TO_BIN(time->tm_hour);
+		BCD_TO_BIN(time->tm_mday);
+		BCD_TO_BIN(time->tm_mon);
+		BCD_TO_BIN(time->tm_year);
+	}
+
+#ifdef CONFIG_DECSTATION
+	time->tm_year += real_year - 72;
+#endif
+
+	/*
+	 * Account for differences between how the RTC uses the values
+	 * and how they are defined in a struct rtc_time;
+	 */
+	if (time->tm_year <= 69)
+		time->tm_year += 100;
+
+	time->tm_mon--;
+}
+
+/* Set the current date and time in the real time clock. */
+static inline int set_rtc_time(struct rtc_time *time)
+{
+	unsigned char mon, day, hrs, min, sec;
+	unsigned char save_control, save_freq_select;
+	unsigned int yrs;
+#ifdef CONFIG_DECSTATION
+	unsigned int real_yrs, leap_yr;
+#endif
+
+	yrs = time->tm_year;
+	mon = time->tm_mon + 1;   /* tm_mon starts at zero */
+	day = time->tm_mday;
+	hrs = time->tm_hour;
+	min = time->tm_min;
+	sec = time->tm_sec;
+
+	if (yrs > 255)	/* They are unsigned */
+		return -EINVAL;
+
+	spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_DECSTATION
+	real_yrs = yrs;
+	leap_yr = ((!((yrs + 1900) % 4) && ((yrs + 1900) % 100)) ||
+			!((yrs + 1900) % 400));
+	yrs = 72;
+
+	/*
+	 * We want to keep the year set to 73 until March
+	 * for non-leap years, so that Feb, 29th is handled
+	 * correctly.
+	 */
+	if (!leap_yr && mon < 3) {
+		real_yrs--;
+		yrs = 73;
+	}
+#endif
+	/* These limits and adjustments are independant of
+	 * whether the chip is in binary mode or not.
+	 */
+	if (yrs > 169) {
+		spin_unlock_irq(&rtc_lock);
+		return -EINVAL;
+	}
+
+	if (yrs >= 100)
+		yrs -= 100;
+
+	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY)
+	    || RTC_ALWAYS_BCD) {
+		BIN_TO_BCD(sec);
+		BIN_TO_BCD(min);
+		BIN_TO_BCD(hrs);
+		BIN_TO_BCD(day);
+		BIN_TO_BCD(mon);
+		BIN_TO_BCD(yrs);
+	}
+
+	save_control = CMOS_READ(RTC_CONTROL);
+	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
+	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
+	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
+
+#ifdef CONFIG_DECSTATION
+	CMOS_WRITE(real_yrs, RTC_DEC_YEAR);
+#endif
+	CMOS_WRITE(yrs, RTC_YEAR);
+	CMOS_WRITE(mon, RTC_MONTH);
+	CMOS_WRITE(day, RTC_DAY_OF_MONTH);
+	CMOS_WRITE(hrs, RTC_HOURS);
+	CMOS_WRITE(min, RTC_MINUTES);
+	CMOS_WRITE(sec, RTC_SECONDS);
+
+	CMOS_WRITE(save_control, RTC_CONTROL);
+	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+
+	spin_unlock_irq(&rtc_lock);
+
+	return 0;
+}
+
+static inline unsigned int get_rtc_ss(void)
+{
+	struct rtc_time h;
+
+	get_rtc_time(&h);
+	return h.tm_sec;
+}
+
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_RTC_H__ */
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.5/include/asm-i386/rtc.h	2002-07-23 10:38:32.000000000 -0700
@@ -0,0 +1,10 @@
+#ifndef _I386_RTC_H
+#define _I386_RTC_H
+
+/*
+ * x86 uses the default access methods for the RTC.
+ */
+
+#include <asm-generic/rtc.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.5/include/asm-alpha/rtc.h	2002-07-23 10:38:32.000000000 -0700
@@ -0,0 +1,10 @@
+#ifndef _ALPHA_RTC_H
+#define _ALPHA_RTC_H
+
+/*
+ * Alpha uses the default access methods for the RTC.
+ */
+
+#include <asm-generic/rtc.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.5/include/asm-parisc/rtc.h	2002-08-02 08:22:16.000000000 -0700
@@ -0,0 +1,131 @@
+/* 
+ * inclue/asm-parisc/rtc.h
+ *
+ * Copyright 2002 Randolph CHung <tausq@debian.org>
+ *
+ * Based on: include/asm-ppc/rtc.h and the genrtc driver in the
+ * 2.4 parisc linux tree
+ */
+
+#ifndef __ASM_RTC_H__
+#define __ASM_RTC_H__
+
+#ifdef __KERNEL__
+
+#include <linux/rtc.h>
+
+#include <asm/pdc.h>
+
+#define SECS_PER_HOUR   (60 * 60)
+#define SECS_PER_DAY    (SECS_PER_HOUR * 24)
+
+
+#define RTC_PIE 0x40		/* periodic interrupt enable */
+#define RTC_AIE 0x20		/* alarm interrupt enable */
+#define RTC_UIE 0x10		/* update-finished interrupt enable */
+
+extern void gen_rtc_interrupt(unsigned long);
+
+/* some dummy definitions */
+#define RTC_SQWE 0x08		/* enable square-wave output */
+#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
+#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
+#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
+
+# define __isleap(year) \
+  ((year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0))
+
+/* How many days come before each month (0-12).  */
+static const unsigned short int __mon_yday[2][13] =
+{
+	/* Normal years.  */
+	{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 },
+	/* Leap years.  */
+	{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
+};
+
+static int get_rtc_time(struct rtc_time *wtime)
+{
+	struct pdc_tod tod_data;
+	long int days, rem, y;
+	const unsigned short int *ip;
+
+	if(pdc_tod_read(&tod_data) < 0)
+		return -1;
+
+	
+	// most of the remainder of this function is:
+//	Copyright (C) 1991, 1993, 1997, 1998 Free Software Foundation, Inc.
+//	This was originally a part of the GNU C Library.
+//      It is distributed under the GPL, and was swiped from offtime.c
+
+
+	days = tod_data.tod_sec / SECS_PER_DAY;
+	rem = tod_data.tod_sec % SECS_PER_DAY;
+
+	wtime->tm_hour = rem / SECS_PER_HOUR;
+	rem %= SECS_PER_HOUR;
+	wtime->tm_min = rem / 60;
+	wtime->tm_sec = rem % 60;
+
+	y = 1970;
+	
+#define DIV(a, b) ((a) / (b) - ((a) % (b) < 0))
+#define LEAPS_THRU_END_OF(y) (DIV (y, 4) - DIV (y, 100) + DIV (y, 400))
+
+	while (days < 0 || days >= (__isleap (y) ? 366 : 365))
+	{
+		/* Guess a corrected year, assuming 365 days per year.  */
+		long int yg = y + days / 365 - (days % 365 < 0);
+
+		/* Adjust DAYS and Y to match the guessed year.  */
+		days -= ((yg - y) * 365
+			 + LEAPS_THRU_END_OF (yg - 1)
+			 - LEAPS_THRU_END_OF (y - 1));
+		y = yg;
+	}
+	wtime->tm_year = y - 1900;
+
+	ip = __mon_yday[__isleap(y)];
+	for (y = 11; days < (long int) ip[y]; --y)
+		continue;
+	days -= ip[y];
+	wtime->tm_mon = y;
+	wtime->tm_mday = days + 1;
+	
+	return 0;
+}
+
+static int set_rtc_time(struct rtc_time *wtime)
+{
+	u_int32_t secs;
+
+	secs = mktime(wtime->tm_year + 1900, wtime->tm_mon + 1, wtime->tm_mday, 
+		      wtime->tm_hour, wtime->tm_min, wtime->tm_sec);
+
+	if(pdc_tod_set(secs, 0) < 0)
+		return -1;
+	else
+		return 0;
+
+}
+
+static inline unsigned int get_rtc_ss(void)
+{
+	struct rtc_time h;
+
+	get_rtc_time(&h);
+	return h.tm_sec;
+}
+
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_RTC_H__ */
--- linux-2.5/drivers/char/genrtc.c	2002-08-02 08:24:32.000000000 -0700
+++ linux-2.5/drivers/char/genrtc.c	2002-08-02 09:01:59.000000000 -0700
@@ -33,9 +33,10 @@
  *      1.03 make it more portable            zippel@linux-m68k.org
  *      1.04 removed useless timer code       rz@linux-m68k.org
  *      1.05 portable RTC_UIE emulation       rz@linux-m68k.org
+ *      1.06 set_rtc_time can return an error trini@kernel.crashing.org
  */
 
-#define RTC_VERSION	"1.05"
+#define RTC_VERSION	"1.06"
 
 #include <linux/module.h>
 #include <linux/config.h>
@@ -128,8 +129,8 @@
 	lostint = get_rtc_ss() - oldsecs ;
 	if (lostint<0) 
 		lostint = 60 - lostint;
-	if (jiffies-tt_exp>1)
-		printk("genrtc: timer task delayed by %ld jiffies\n",
+	if (time_after(jiffies, tt_exp))
+		printk(KERN_INFO "genrtc: timer task delayed by %ld jiffies\n",
 		       jiffies-tt_exp);
 	ttask_active=0;
 	stask_active=1;
@@ -174,7 +175,7 @@
 	unsigned long data;
 	ssize_t retval;
 
-	if (count < sizeof(unsigned long))
+        if (count != sizeof (unsigned int) && count != sizeof (unsigned long))
 		return -EINVAL;
 
 	if (file->f_flags & O_NONBLOCK && !gen_rtc_irq_data)
@@ -193,7 +194,14 @@
 		schedule();
 	}
 
-	retval = put_user(data, (unsigned long *)buf);
+	/* first test allows optimizer to nuke this case for 32-bit machines */
+	if (sizeof (int) != sizeof (long) && count == sizeof (unsigned int)) {
+		unsigned int uidata = data;
+		retval = put_user(uidata, (unsigned long *)buf);
+	}
+	else {
+		retval = put_user(data, (unsigned long *)buf);
+	}
 	if (!retval)
 		retval = sizeof(unsigned long);
  out:
@@ -326,8 +334,7 @@
 		    wtime.tm_sec < 0 || wtime.tm_sec >= 60)
 			return -EINVAL;
 
-		set_rtc_time(&wtime);
-		return 0;
+		return set_rtc_time(&wtime);
 	    }
 	}
 
