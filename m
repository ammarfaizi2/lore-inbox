Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268116AbTBWJtY>; Sun, 23 Feb 2003 04:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268113AbTBWJsu>; Sun, 23 Feb 2003 04:48:50 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:54144 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S268116AbTBWJsE>; Sun, 23 Feb 2003 04:48:04 -0500
Date: Sun, 23 Feb 2003 18:54:05 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (15/21) RTC
Message-ID: <20030223095405.GP1324@yuzuki.cinet.co.jp>
References: <20030223092116.GA1324@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223092116.GA1324@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.62-ac1. (15/21)

Support RTC for PC98, using mach-* scheme.

Regards,
Osamu Tomita

diff -Nru linux-2.5.60/arch/i386/kernel/time.c linux98-2.5.60/arch/i386/kernel/time.c
--- linux-2.5.60/arch/i386/kernel/time.c	2003-02-11 03:38:37.000000000 +0900
+++ linux98-2.5.60/arch/i386/kernel/time.c	2003-02-11 10:52:52.000000000 +0900
@@ -55,12 +55,15 @@
 #include <asm/processor.h>
 #include <asm/timer.h>
 
-#include <linux/mc146818rtc.h>
+#include "mach_time.h"
+
 #include <linux/timex.h>
 #include <linux/config.h>
 
 #include <asm/arch_hooks.h>
 
+#include "io_ports.h"
+
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
@@ -137,69 +140,13 @@
 	write_sequnlock_irq(&xtime_lock);
 }
 
-/*
- * In order to set the CMOS clock precisely, set_rtc_mmss has to be
- * called 500 ms after the second nowtime has started, because when
- * nowtime is written into the registers of the CMOS clock, it will
- * jump to the next second precisely 500 ms later. Check the Motorola
- * MC146818A or Dallas DS12887 data sheet for details.
- *
- * BUG: This routine does not handle hour overflow properly; it just
- *      sets the minutes. Usually you'll only notice that after reboot!
- */
 static int set_rtc_mmss(unsigned long nowtime)
 {
-	int retval = 0;
-	int real_seconds, real_minutes, cmos_minutes;
-	unsigned char save_control, save_freq_select;
+	int retval;
 
 	/* gets recalled with irq locally disabled */
 	spin_lock(&rtc_lock);
-	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
-	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
-
-	save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset prescaler */
-	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
-
-	cmos_minutes = CMOS_READ(RTC_MINUTES);
-	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-		BCD_TO_BIN(cmos_minutes);
-
-	/*
-	 * since we're only adjusting minutes and seconds,
-	 * don't interfere with hour overflow. This avoids
-	 * messing with unknown time zones but requires your
-	 * RTC not to be off by more than 15 minutes
-	 */
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
-	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
-		real_minutes += 30;		/* correct for half hour time zone */
-	real_minutes %= 60;
-
-	if (abs(real_minutes - cmos_minutes) < 30) {
-		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-			BIN_TO_BCD(real_seconds);
-			BIN_TO_BCD(real_minutes);
-		}
-		CMOS_WRITE(real_seconds,RTC_SECONDS);
-		CMOS_WRITE(real_minutes,RTC_MINUTES);
-	} else {
-		printk(KERN_WARNING
-		       "set_rtc_mmss: can't update from %d to %d\n",
-		       cmos_minutes, real_minutes);
-		retval = -1;
-	}
-
-	/* The following flags have to be released exactly in this order,
-	 * otherwise the DS12887 (popular MC146818A clone with integrated
-	 * battery and quartz) will not reset the oscillator and will not
-	 * update precisely 500 ms later. You won't find this mentioned in
-	 * the Dallas Semiconductor data sheets, but who believes data
-	 * sheets anyway ...                           -- Markus Kuhn
-	 */
-	CMOS_WRITE(save_control, RTC_CONTROL);
-	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+	retval = mach_set_rtc_mmss(nowtime);
 	spin_unlock(&rtc_lock);
 
 	return retval;
@@ -225,9 +172,9 @@
 		 * on an 82489DX-based system.
 		 */
 		spin_lock(&i8259A_lock);
-		outb(0x0c, 0x20);
+		outb(0x0c, PIC_MASTER_OCW3);
 		/* Ack the IRQ; AEOI will end it automatically. */
-		inb(0x20);
+		inb(PIC_MASTER_POLL);
 		spin_unlock(&i8259A_lock);
 	}
 #endif
@@ -241,14 +188,14 @@
 	 */
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
+	    (xtime.tv_nsec / 1000) >= TIME1 - ((unsigned) TICK_SIZE) / 2 &&
+	    (xtime.tv_nsec / 1000) <= TIME2 + ((unsigned) TICK_SIZE) / 2) {
 		if (set_rtc_mmss(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
-	    
+
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {
 		/* The PS/2 uses level-triggered interrupts.  You can't
@@ -329,43 +276,15 @@
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
-	unsigned int year, mon, day, hour, min, sec;
-	int i;
+	unsigned long retval;
 
 	spin_lock(&rtc_lock);
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
-		sec = CMOS_READ(RTC_SECONDS);
-		min = CMOS_READ(RTC_MINUTES);
-		hour = CMOS_READ(RTC_HOURS);
-		day = CMOS_READ(RTC_DAY_OF_MONTH);
-		mon = CMOS_READ(RTC_MONTH);
-		year = CMOS_READ(RTC_YEAR);
-	} while (sec != CMOS_READ(RTC_SECONDS));
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-	  {
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
-	  }
+
+	retval = mach_get_cmos_time();
+
 	spin_unlock(&rtc_lock);
-	if ((year += 1900) < 1970)
-		year += 100;
-	return mktime(year, mon, day, hour, min, sec);
+
+	return retval;
 }
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
diff -Nru linux/include/asm-i386/mach-default/mach_time.h linux98/include/asm-i386/mach-default/mach_time.h
--- linux/include/asm-i386/mach-default/mach_time.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_time.h	2002-10-21 10:07:35.000000000 +0900
@@ -0,0 +1,122 @@
+/*
+ *  include/asm-i386/mach-default/mach_time.h
+ *
+ *  Machine specific set RTC function for generic.
+ *  Split out from time.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TIME_H
+#define _MACH_TIME_H
+
+#include <linux/mc146818rtc.h>
+
+/* for check timing call set_rtc_mmss() 500ms     */
+/* used in arch/i386/time.c::do_timer_interrupt() */
+#define TIME1	500000
+#define TIME2	500000
+
+/*
+ * In order to set the CMOS clock precisely, set_rtc_mmss has to be
+ * called 500 ms after the second nowtime has started, because when
+ * nowtime is written into the registers of the CMOS clock, it will
+ * jump to the next second precisely 500 ms later. Check the Motorola
+ * MC146818A or Dallas DS12887 data sheet for details.
+ *
+ * BUG: This routine does not handle hour overflow properly; it just
+ *      sets the minutes. Usually you'll only notice that after reboot!
+ */
+static inline int mach_set_rtc_mmss(unsigned long nowtime)
+{
+	int retval = 0;
+	int real_seconds, real_minutes, cmos_minutes;
+	unsigned char save_control, save_freq_select;
+
+	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
+	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
+
+	save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset prescaler */
+	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
+
+	cmos_minutes = CMOS_READ(RTC_MINUTES);
+	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+		BCD_TO_BIN(cmos_minutes);
+
+	/*
+	 * since we're only adjusting minutes and seconds,
+	 * don't interfere with hour overflow. This avoids
+	 * messing with unknown time zones but requires your
+	 * RTC not to be off by more than 15 minutes
+	 */
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
+		real_minutes += 30;		/* correct for half hour time zone */
+	real_minutes %= 60;
+
+	if (abs(real_minutes - cmos_minutes) < 30) {
+		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+			BIN_TO_BCD(real_seconds);
+			BIN_TO_BCD(real_minutes);
+		}
+		CMOS_WRITE(real_seconds,RTC_SECONDS);
+		CMOS_WRITE(real_minutes,RTC_MINUTES);
+	} else {
+		printk(KERN_WARNING
+		       "set_rtc_mmss: can't update from %d to %d\n",
+		       cmos_minutes, real_minutes);
+		retval = -1;
+	}
+
+	/* The following flags have to be released exactly in this order,
+	 * otherwise the DS12887 (popular MC146818A clone with integrated
+	 * battery and quartz) will not reset the oscillator and will not
+	 * update precisely 500 ms later. You won't find this mentioned in
+	 * the Dallas Semiconductor data sheets, but who believes data
+	 * sheets anyway ...                           -- Markus Kuhn
+	 */
+	CMOS_WRITE(save_control, RTC_CONTROL);
+	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+
+	return retval;
+}
+
+static inline unsigned long mach_get_cmos_time(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
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
+	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+		sec = CMOS_READ(RTC_SECONDS);
+		min = CMOS_READ(RTC_MINUTES);
+		hour = CMOS_READ(RTC_HOURS);
+		day = CMOS_READ(RTC_DAY_OF_MONTH);
+		mon = CMOS_READ(RTC_MONTH);
+		year = CMOS_READ(RTC_YEAR);
+	} while (sec != CMOS_READ(RTC_SECONDS));
+	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+	  {
+	    BCD_TO_BIN(sec);
+	    BCD_TO_BIN(min);
+	    BCD_TO_BIN(hour);
+	    BCD_TO_BIN(day);
+	    BCD_TO_BIN(mon);
+	    BCD_TO_BIN(year);
+	  }
+	if ((year += 1900) < 1970)
+		year += 100;
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
+#endif /* !_MACH_TIME_H */
diff -Nru linux/include/asm-i386/mach-pc9800/mach_time.h linux98/include/asm-i386/mach-pc9800/mach_time.h
--- linux/include/asm-i386/mach-pc9800/mach_time.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_time.h	2002-10-21 11:23:06.000000000 +0900
@@ -0,0 +1,136 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_time.h
+ *
+ *  Machine specific set RTC function for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TIME_H
+#define _MACH_TIME_H
+
+#include <linux/upd4990a.h>
+
+/* for check timing call set_rtc_mmss() */
+/* used in arch/i386/time.c::do_timer_interrupt() */
+/*
+ * Because PC-9800's RTC (NEC uPD4990A) does not allow setting
+ * time partially, we always have to read-modify-write the
+ * entire time (including year) so that set_rtc_mmss() will
+ * take quite much time to execute.  You may want to relax
+ * RTC resetting interval (currently ~11 minuts)...
+ */
+#define TIME1	1000000
+#define TIME2	0
+
+static inline int mach_set_rtc_mmss(unsigned long nowtime)
+{
+	int retval = 0;
+	int real_seconds, real_minutes, cmos_minutes;
+	struct upd4990a_raw_data data;
+
+	upd4990a_get_time(&data, 1);
+	cmos_minutes = (data.min >> 4) * 10 + (data.min & 0xf);
+
+	/*
+	 * since we're only adjusting minutes and seconds,
+	 * don't interfere with hour overflow. This avoids
+	 * messing with unknown time zones but requires your
+	 * RTC not to be off by more than 15 minutes
+	 */
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+	if (((abs(real_minutes - cmos_minutes) + 15) / 30) & 1)
+		real_minutes += 30;	/* correct for half hour time zone */
+	real_minutes %= 60;
+
+	if (abs(real_minutes - cmos_minutes) < 30) {
+		u8 temp_seconds = (real_seconds / 10) * 16 + real_seconds % 10;
+		u8 temp_minutes = (real_minutes / 10) * 16 + real_minutes % 10;
+
+		if (data.sec != temp_seconds || data.min != temp_minutes) {
+			data.sec = temp_seconds;
+			data.min = temp_minutes;
+			upd4990a_set_time(&data, 1);
+		}
+	} else {
+		printk(KERN_WARNING
+		       "set_rtc_mmss: can't update from %d to %d\n",
+		       cmos_minutes, real_minutes);
+		retval = -1;
+	}
+
+	/* uPD4990A users' manual says we should issue Register Hold
+	 * command after reading time, or future Time Read command
+	 * may not work.  When we have set the time, this also starts
+	 * the clock.
+	 */
+	upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+
+	return retval;
+}
+
+#define RTC_SANITY_CHECK
+
+static inline unsigned long mach_get_cmos_time(void)
+{
+	int i;
+	u8 prev, cur;
+	unsigned int year;
+#ifdef RTC_SANITY_CHECK
+	int retry_count;
+#endif
+
+	struct upd4990a_raw_data data;
+
+#ifdef RTC_SANITY_CHECK
+	retry_count = 0;
+ retry:
+#endif
+	/* Connect uPD4990A's DATA OUT pin to its 1Hz reference clock. */
+	upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+
+	/* Catch rising edge of reference clock.  */
+	prev = ~UPD4990A_READ_DATA();
+	for (i = 0; i < 1800000; i++) { /* may take up to 1 second... */
+		__asm__ ("outb %%al,%0" : : "N" (0x5f)); /* 0.6usec delay */
+		cur = UPD4990A_READ_DATA();
+		if (!(prev & cur & 1))
+			break;
+		prev = ~cur;
+	}
+
+	upd4990a_get_time(&data, 0);
+
+#ifdef RTC_SANITY_CHECK
+# define BCD_VALID_P(x, hi)	(((x) & 0x0f) <= 9 && (x) <= 0x ## hi)
+# define DATA			((const unsigned char *) &data)
+
+	if (!BCD_VALID_P(data.sec, 59) ||
+	    !BCD_VALID_P(data.min, 59) ||
+	    !BCD_VALID_P(data.hour, 23) ||
+	    data.mday == 0 || !BCD_VALID_P(data.mday, 31) ||
+	    data.wday > 6 ||
+	    data.mon < 1 || 12 < data.mon ||
+	    !BCD_VALID_P(data.year, 99)) {
+		printk(KERN_ERR "RTC clock data is invalid! "
+			"(%02X %02X %02X %02X %02X %02X) - ",
+			DATA[0], DATA[1], DATA[2], DATA[3], DATA[4], DATA[5]);
+		if (++retry_count < 3) {
+			printk("retrying (%d)\n", retry_count);
+			goto retry;
+		}
+		printk("giving up, continuing\n");
+	}
+
+# undef BCD_VALID_P
+# undef DATA
+#endif /* RTC_SANITY_CHECK */
+
+#define CVT(x)	(((x) & 0xF) + ((x) >> 4) * 10)
+	if ((year = CVT(data.year) + 1900) < 1995)
+		year += 100;
+	return mktime(year, data.mon, CVT(data.mday),
+		       CVT(data.hour), CVT(data.min), CVT(data.sec));
+#undef CVT
+}
+
+#endif /* !_MACH_TIME_H */
