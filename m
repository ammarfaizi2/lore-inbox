Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTA1XhC>; Tue, 28 Jan 2003 18:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTA1XhB>; Tue, 28 Jan 2003 18:37:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261900AbTA1XeD>;
	Tue, 28 Jan 2003 18:34:03 -0500
Subject: [PATCH] (4/4) 2.5.59 fast reader/writer lock for gettimeofday
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-WCXb2mgBfvK9rpzWKvXg"
Organization: Open Source Devlopment Lab
Message-Id: <1043797399.10155.308.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jan 2003 15:43:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WCXb2mgBfvK9rpzWKvXg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the other architecture support for lockless gettimeofday. 
Applies cleanly, but has not been tested.
It defines frlock and changes locking of xtime_lock from rwlock to
frlock.


--=-WCXb2mgBfvK9rpzWKvXg
Content-Disposition: attachment; filename=frlock-xtime-other.patch
Content-Type: text/x-patch; name=frlock-xtime-other.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN -X dontdiff linux-2.5.59/arch/alpha/kernel/time.c linux-2.5-frlock/arch/alpha/kernel/time.c
--- linux-2.5.59/arch/alpha/kernel/time.c	2003-01-17 09:42:13.000000000 -0800
+++ linux-2.5-frlock/arch/alpha/kernel/time.c	2003-01-21 13:20:21.000000000 -0800
@@ -51,7 +51,7 @@
 
 u64 jiffies_64;
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;	/* kernel/timer.c */
 
 static int set_rtc_mmss(unsigned long);
@@ -106,7 +106,7 @@
 		alpha_do_profile(regs->pc);
 #endif
 
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 
 	/*
 	 * Calculate how many ticks have passed since the last update,
@@ -138,7 +138,7 @@
 		state.last_rtc_update = xtime.tv_sec - (tmp ? 600 : 0);
 	}
 
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 
 void
@@ -410,18 +410,19 @@
 void
 do_gettimeofday(struct timeval *tv)
 {
-	unsigned long sec, usec, lost, flags;
+	unsigned long sec, usec, lost, seq;
 	unsigned long delta_cycles, delta_usec, partial_tick;
 
-	read_lock_irqsave(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	delta_cycles = rpcc() - state.last_time;
-	sec = xtime.tv_sec;
-	usec = (xtime.tv_nsec / 1000);
-	partial_tick = state.partial_tick;
-	lost = jiffies - wall_jiffies;
+		delta_cycles = rpcc() - state.last_time;
+		sec = xtime.tv_sec;
+		usec = (xtime.tv_nsec / 1000);
+		partial_tick = state.partial_tick;
+		lost = jiffies - wall_jiffies;
 
-	read_unlock_irqrestore(&xtime_lock, flags);
+	} while (seq != fr_read_end(&xtime_lock));
 
 #ifdef CONFIG_SMP
 	/* Until and unless we figure out how to get cpu cycle counters
@@ -463,7 +464,7 @@
 	unsigned long delta_usec;
 	long sec, usec;
 	
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 
 	/* The offset that is added into time in do_gettimeofday above
 	   must be subtracted out here to keep a coherent view of the
@@ -494,7 +495,7 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 
diff -urN -X dontdiff linux-2.5.59/arch/arm/kernel/time.c linux-2.5-frlock/arch/arm/kernel/time.c
--- linux-2.5.59/arch/arm/kernel/time.c	2003-01-17 09:42:13.000000000 -0800
+++ linux-2.5-frlock/arch/arm/kernel/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -34,7 +34,7 @@
 
 u64 jiffies_64;
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 /* this needs a better home */
@@ -147,19 +147,20 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec, lost;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = gettimeoffset();
-
-	lost = jiffies - wall_jiffies;
-	if (lost)
-		usec += lost * USECS_PER_JIFFY;
-
-	sec = xtime.tv_sec;
-	usec += xtime.tv_nsec / 1000;
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		usec = gettimeoffset();
+
+		lost = jiffies - wall_jiffies;
+		if (lost)
+			usec += lost * USECS_PER_JIFFY;
+
+		sec = xtime.tv_sec;
+		usec += xtime.tv_nsec / 1000;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	/* usec may have gone up a lot: be safe */
 	while (usec >= 1000000) {
@@ -173,7 +174,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -194,7 +195,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 static struct irqaction timer_irq = {
diff -urN -X dontdiff linux-2.5.59/arch/m68k/kernel/time.c linux-2.5-frlock/arch/m68k/kernel/time.c
--- linux-2.5.59/arch/m68k/kernel/time.c	2003-01-17 09:42:15.000000000 -0800
+++ linux-2.5-frlock/arch/m68k/kernel/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -129,7 +129,7 @@
 	mach_sched_init(timer_interrupt);
 }
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 /*
  * This version of gettimeofday has near microsecond resolution.
@@ -137,17 +137,20 @@
 void do_gettimeofday(struct timeval *tv)
 {
 	extern unsigned long wall_jiffies;
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec, lost;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = mach_gettimeoffset();
-	lost = jiffies - wall_jiffies;
-	if (lost)
-		usec += lost * (1000000/HZ);
-	sec = xtime.tv_sec;
-	usec += xtime.tv_nsec/1000;
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+
+		usec = mach_gettimeoffset();
+		lost = jiffies - wall_jiffies;
+		if (lost)
+			usec += lost * (1000000/HZ);
+		sec = xtime.tv_sec;
+		usec += xtime.tv_nsec/1000;
+	} while (seq != fr_read_end(&xtime_lock));
+
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -162,7 +165,7 @@
 {
 	extern unsigned long wall_jiffies;
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/* This is revolting. We need to set the xtime.tv_nsec
 	 * correctly. However, the value in this location is
 	 * is value at the last tick.
@@ -183,5 +186,5 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
diff -urN -X dontdiff linux-2.5.59/arch/m68knommu/kernel/time.c linux-2.5-frlock/arch/m68knommu/kernel/time.c
--- linux-2.5.59/arch/m68knommu/kernel/time.c	2003-01-17 09:42:15.000000000 -0800
+++ linux-2.5-frlock/arch/m68knommu/kernel/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -126,21 +126,24 @@
 	mach_sched_init(timer_interrupt);
 }
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 /*
  * This version of gettimeofday has near microsecond resolution.
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = mach_gettimeoffset ? mach_gettimeoffset() : 0;
-	sec = xtime.tv_sec;
-	usec += (xtime.tv_nsec / 1000);
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+
+		usec = mach_gettimeoffset ? mach_gettimeoffset() : 0;
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / 1000);
+	} while (seq != fr_read_end(&xtime_lock));
+
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -153,7 +156,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/* This is revolting. We need to set the xtime.tv_usec
 	 * correctly. However, the value in this location is
 	 * is value at the last tick.
@@ -174,5 +177,5 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
diff -urN -X dontdiff linux-2.5.59/arch/mips/au1000/common/time.c linux-2.5-frlock/arch/mips/au1000/common/time.c
--- linux-2.5.59/arch/mips/au1000/common/time.c	2003-01-17 09:42:15.000000000 -0800
+++ linux-2.5-frlock/arch/mips/au1000/common/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -44,7 +44,7 @@
 
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
 
@@ -150,10 +150,10 @@
 	set_cp0_status(ALLINTS);
 
 	/* Read time from the RTC chipset. */
-	write_lock_irqsave (&xtime_lock, flags);
+	fr_write_lock_irqsave (&xtime_lock, flags);
 	xtime.tv_sec = get_mips_time();
 	xtime.tv_usec = 0;
-	write_unlock_irqrestore(&xtime_lock, flags);
+	fr_write_unlock_irqrestore(&xtime_lock, flags);
 }
 
 /* This is for machines which generate the exact clock. */
@@ -229,20 +229,23 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned int flags;
+	unsigned long seq;
 
-	read_lock_irqsave (&xtime_lock, flags);
-	*tv = xtime;
-	tv->tv_usec += do_fast_gettimeoffset();
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	/*
-	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-	 * is nonzero if the timer bottom half hasnt executed yet.
-	 */
-	if (jiffies - wall_jiffies)
-		tv->tv_usec += USECS_PER_JIFFY;
+		*tv = xtime;
+		tv->tv_usec += do_fast_gettimeoffset();
+
+		/*
+		 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
+		 * is nonzero if the timer bottom half hasnt executed yet.
+		 */
+		if (jiffies - wall_jiffies)
+			tv->tv_usec += USECS_PER_JIFFY;
+
+	} while (seq != fr_read_end(&xtime_lock));
 
-	read_unlock_irqrestore (&xtime_lock, flags);
 
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
@@ -252,7 +255,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	fr_write_lock_irq (&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_usec correctly.
 	 * However, the value in this location is is value at the last tick.
@@ -272,7 +275,7 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq (&xtime_lock);
+	fr_write_unlock_irq (&xtime_lock);
 }
 
 /*
diff -urN -X dontdiff linux-2.5.59/arch/mips/baget/time.c linux-2.5-frlock/arch/mips/baget/time.c
--- linux-2.5.59/arch/mips/baget/time.c	2003-01-17 09:42:15.000000000 -0800
+++ linux-2.5-frlock/arch/mips/baget/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -23,7 +23,7 @@
 
 #include <asm/baget/baget.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 /* 
  *  To have precision clock, we need to fix available clock frequency
@@ -79,20 +79,21 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 
-	read_lock_irqsave (&xtime_lock, flags);
-	*tv = xtime;
-	read_unlock_irqrestore (&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		*tv = xtime;
+	} while (seq != fr_read_end(&xtime_lock));
 }
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	fr_write_lock_irq (&xtime_lock);
 	xtime = *tv;
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq (&xtime_lock);
+	fr_write_unlock_irq (&xtime_lock);
 }
diff -urN -X dontdiff linux-2.5.59/arch/mips/dec/time.c linux-2.5-frlock/arch/mips/dec/time.c
--- linux-2.5.59/arch/mips/dec/time.c	2003-01-17 09:42:15.000000000 -0800
+++ linux-2.5-frlock/arch/mips/dec/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -35,7 +35,7 @@
 extern void (*board_time_init)(struct irqaction *irq);
 
 extern volatile unsigned long wall_jiffies;
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 /*
  * Change this if you have some constant time drift
@@ -210,20 +210,22 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	*tv = xtime;
-	tv->tv_usec += do_gettimeoffset();
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		*tv = xtime;
+		tv->tv_usec += do_gettimeoffset();
 
-	/*
-	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-	 * is nonzero if the timer bottom half hasnt executed yet.
-	 */
-	if (jiffies - wall_jiffies)
-		tv->tv_usec += USECS_PER_JIFFY;
+		/*
+		 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
+		 * is nonzero if the timer bottom half hasnt executed yet.
+		 */
+		if (jiffies - wall_jiffies)
+			tv->tv_usec += USECS_PER_JIFFY;
+
+	} while (seq != fr_read_end(&xtime_lock));
 
-	read_unlock_irqrestore(&xtime_lock, flags);
 
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
@@ -233,7 +235,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_usec
 	 * correctly. However, the value in this location is
@@ -254,7 +256,7 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /*
@@ -330,6 +332,7 @@
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	volatile unsigned char dummy;
+	unsigned long seq;
 
 	dummy = CMOS_READ(RTC_REG_C);	/* ACK RTC Interrupt */
 
@@ -357,23 +360,27 @@
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	read_lock(&xtime_lock);
-	if ((time_status & STA_UNSYNC) == 0
-	    && xtime.tv_sec > last_rtc_update + 660
-	    && xtime.tv_usec >= 500000 - tick / 2
-	    && xtime.tv_usec <= 500000 + tick / 2) {
-		if (set_rtc_mmss(xtime.tv_sec) == 0)
-			last_rtc_update = xtime.tv_sec;
-		else
-			/* do it again in 60 s */
-			last_rtc_update = xtime.tv_sec - 600;
-	}
+	do {
+		seq = fr_read_begin(&xtime_lock);
+
+		if ((time_status & STA_UNSYNC) == 0
+		    && xtime.tv_sec > last_rtc_update + 660
+		    && xtime.tv_usec >= 500000 - tick / 2
+		    && xtime.tv_usec <= 500000 + tick / 2) {
+			if (set_rtc_mmss(xtime.tv_sec) == 0)
+				last_rtc_update = xtime.tv_sec;
+			else
+				/* do it again in 60 s */
+				last_rtc_update = xtime.tv_sec - 600;
+		}
+	} while (seq != fr_read_end(&xtime_lock));
+
 	/* As we return to user mode fire off the other CPU schedulers.. this is
 	   basically because we don't yet share IRQ's around. This message is
 	   rigged to be safe on the 386 - basically it's a hack, so don't look
 	   closely for now.. */
 	/*smp_message_pass(MSG_ALL_BUT_SELF, MSG_RESCHEDULE, 0L, 0); */
-	read_unlock(&xtime_lock);
+
 }
 
 static void r4k_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -470,10 +477,10 @@
 	real_year = CMOS_READ(RTC_DEC_YEAR);
 	year += real_year - 72 + 2000;
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
 	xtime.tv_usec = 0;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 
 	if (mips_cpu.options & MIPS_CPU_COUNTER) {
 		write_32bit_cp0_register(CP0_COUNT, 0);
diff -urN -X dontdiff linux-2.5.59/arch/mips/ite-boards/generic/time.c linux-2.5-frlock/arch/mips/ite-boards/generic/time.c
--- linux-2.5.59/arch/mips/ite-boards/generic/time.c	2003-01-17 09:42:15.000000000 -0800
+++ linux-2.5-frlock/arch/mips/ite-boards/generic/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -38,7 +38,7 @@
 
 extern void enable_cpu_timer(void);
 extern volatile unsigned long wall_jiffies;
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 unsigned long missed_heart_beats = 0;
 static long last_rtc_update = 0;
@@ -119,6 +119,8 @@
  */
 void mips_timer_interrupt(struct pt_regs *regs)
 {
+	unsigned long seq;
+
 	if (r4k_offset == 0)
 		goto null;
 
@@ -133,18 +135,22 @@
  		 * within 500ms before the * next second starts, 
  		 * thus the following code.
  		 */
-		read_lock(&xtime_lock);
-		if ((time_status & STA_UNSYNC) == 0 
-		    && xtime.tv_sec > last_rtc_update + 660 
-		    && xtime.tv_usec >= 500000 - (tick >> 1) 
-		    && xtime.tv_usec <= 500000 + (tick >> 1))
-			if (set_rtc_mmss(xtime.tv_sec) == 0)
-				last_rtc_update = xtime.tv_sec;
-			else {
-				/* do it again in 60 s */
-	    			last_rtc_update = xtime.tv_sec - 600; 
-			}
-		read_unlock(&xtime_lock);
+		do {
+			seq = fr_read_begin(&xtime_lock);
+
+
+			if ((time_status & STA_UNSYNC) == 0 
+			    && xtime.tv_sec > last_rtc_update + 660 
+			    && xtime.tv_usec >= 500000 - (tick >> 1) 
+			    && xtime.tv_usec <= 500000 + (tick >> 1))
+				if (set_rtc_mmss(xtime.tv_sec) == 0)
+					last_rtc_update = xtime.tv_sec;
+				else {
+					/* do it again in 60 s */
+					last_rtc_update = xtime.tv_sec - 600; 
+				}
+			
+		} while (seq != fr_read_end(&xtime_lock));
 
 		r4k_cur += r4k_offset;
 		ack_r4ktimer(r4k_cur);
@@ -247,10 +253,10 @@
 	enable_cpu_timer();
 
 	/* Read time from the RTC chipset. */
-	write_lock_irqsave (&xtime_lock, flags);
+	fr_write_lock_irqsave (&xtime_lock, flags);
 	xtime.tv_sec = get_mips_time();
 	xtime.tv_usec = 0;
-	write_unlock_irqrestore(&xtime_lock, flags);
+	fr_write_unlock_irqrestore(&xtime_lock, flags);
 }
 
 /* This is for machines which generate the exact clock. */
@@ -332,20 +338,23 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned int flags;
+	unsigned int seq;
 
-	read_lock_irqsave (&xtime_lock, flags);
-	*tv = xtime;
-	tv->tv_usec += do_fast_gettimeoffset();
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	/*
-	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-	 * is nonzero if the timer bottom half hasnt executed yet.
-	 */
-	if (jiffies - wall_jiffies)
-		tv->tv_usec += USECS_PER_JIFFY;
+		*tv = xtime;
+		tv->tv_usec += do_fast_gettimeoffset();
+
+		/*
+		 * xtime is atomically updated in timer_bh. 
+		 * jiffies - wall_jiffies
+		 * is nonzero if the timer bottom half hasnt executed yet.
+		 */
+		if (jiffies - wall_jiffies)
+			tv->tv_usec += USECS_PER_JIFFY;
 
-	read_unlock_irqrestore (&xtime_lock, flags);
+	} while (seq != fr_read_end(&xtime_lock));
 
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
@@ -355,7 +364,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	fr_write_lock_irq (&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_usec correctly.
 	 * However, the value in this location is is value at the last tick.
@@ -375,5 +384,5 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq (&xtime_lock);
+	fr_write_unlock_irq (&xtime_lock);
 }
diff -urN -X dontdiff linux-2.5.59/arch/mips/kernel/sysirix.c linux-2.5-frlock/arch/mips/kernel/sysirix.c
--- linux-2.5.59/arch/mips/kernel/sysirix.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/mips/kernel/sysirix.c	2003-01-24 14:54:11.000000000 -0800
@@ -615,19 +615,19 @@
 	return current->gid;
 }
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 asmlinkage int irix_stime(int value)
 {
 	if (!capable(CAP_SYS_TIME))
 		return -EPERM;
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	xtime.tv_sec = value;
 	xtime.tv_usec = 0;
 	time_maxerror = MAXPHASE;
 	time_esterror = MAXPHASE;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 
 	return 0;
 }
diff -urN -X dontdiff linux-2.5.59/arch/mips/kernel/time.c linux-2.5-frlock/arch/mips/kernel/time.c
--- linux-2.5.59/arch/mips/kernel/time.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/mips/kernel/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -37,7 +37,7 @@
 /*
  * forward reference
  */
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern volatile unsigned long wall_jiffies;
 
 /*
@@ -62,20 +62,23 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 
-	read_lock_irqsave (&xtime_lock, flags);
-	*tv = xtime;
-	tv->tv_usec += do_gettimeoffset();
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	/*
-	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-	 * is nonzero if the timer bottom half hasnt executed yet.
-	 */
-	if (jiffies - wall_jiffies)
-		tv->tv_usec += USECS_PER_JIFFY;
+		*tv = xtime;
+		tv->tv_usec += do_gettimeoffset();
+
+		/*
+		 * xtime is atomically updated in timer_bh. 
+		 * jiffies - wall_jiffies
+		 * is nonzero if the timer bottom half hasnt executed yet.
+		 */
+		if (jiffies - wall_jiffies)
+			tv->tv_usec += USECS_PER_JIFFY;
+	} while (seq != fr_read_end(&xtime_lock));
 
-	read_unlock_irqrestore (&xtime_lock, flags);
 
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
@@ -85,7 +88,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	fr_write_lock_irq (&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_usec
 	 * correctly. However, the value in this location is
@@ -105,7 +108,7 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq (&xtime_lock);
+	fr_write_unlock_irq (&xtime_lock);
 }
 
 
@@ -291,6 +294,8 @@
  */
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	unsigned long seq;
+
 	if (mips_cpu.options & MIPS_CPU_COUNTER) {
 		unsigned int count;
 
@@ -340,19 +345,21 @@
 	 * CMOS clock accordingly every ~11 minutes. rtc_set_time() has to be
 	 * called as close as possible to 500 ms before the new second starts.
 	 */
-	read_lock (&xtime_lock);
-	if ((time_status & STA_UNSYNC) == 0 &&
-	    xtime.tv_sec > last_rtc_update + 660 &&
-	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
-	    xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
-		if (rtc_set_time(xtime.tv_sec) == 0) {
-			last_rtc_update = xtime.tv_sec;
-		} else {
-			last_rtc_update = xtime.tv_sec - 600; 
-			/* do it again in 60 s */
+	do {
+		seq = fr_read_begin(&xtime_lock);
+	
+		if ((time_status & STA_UNSYNC) == 0 &&
+		    xtime.tv_sec > last_rtc_update + 660 &&
+		    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
+		    xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
+			if (rtc_set_time(xtime.tv_sec) == 0) {
+				last_rtc_update = xtime.tv_sec;
+			} else {
+				last_rtc_update = xtime.tv_sec - 600; 
+				/* do it again in 60 s */
+			}
 		}
-	}
-	read_unlock (&xtime_lock);
+	} while (seq != fr_read_end(&xtime_lock));
 
 	/*
 	 * If jiffies has overflowed in this timer_interrupt we must
diff -urN -X dontdiff linux-2.5.59/arch/mips/mips-boards/generic/time.c linux-2.5-frlock/arch/mips/mips-boards/generic/time.c
--- linux-2.5.59/arch/mips/mips-boards/generic/time.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/mips/mips-boards/generic/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -45,7 +45,7 @@
 
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
 
@@ -134,6 +134,7 @@
 void mips_timer_interrupt(struct pt_regs *regs)
 {
 	int irq = 7;
+	unsigned long seq;
 
 	if (r4k_offset == 0)
 		goto null;
@@ -149,18 +150,21 @@
  		 * within 500ms before the * next second starts, 
  		 * thus the following code.
  		 */
-		read_lock(&xtime_lock);
-		if ((time_status & STA_UNSYNC) == 0 
-		    && xtime.tv_sec > last_rtc_update + 660 
-		    && xtime.tv_usec >= 500000 - (tick >> 1) 
-		    && xtime.tv_usec <= 500000 + (tick >> 1))
-			if (set_rtc_mmss(xtime.tv_sec) == 0)
-				last_rtc_update = xtime.tv_sec;
-			else
-				/* do it again in 60 s */
-	    			last_rtc_update = xtime.tv_sec - 600; 
-		read_unlock(&xtime_lock);
 
+		do {
+			seq = fr_read_begin(&xtime_lock);
+
+			if ((time_status & STA_UNSYNC) == 0 
+			    && xtime.tv_sec > last_rtc_update + 660 
+			    && xtime.tv_usec >= 500000 - (tick >> 1) 
+			    && xtime.tv_usec <= 500000 + (tick >> 1))
+				if (set_rtc_mmss(xtime.tv_sec) == 0)
+					last_rtc_update = xtime.tv_sec;
+				else
+					/* do it again in 60 s */
+					last_rtc_update = xtime.tv_sec - 600; 
+		} while (seq != fr_read_end(&xtime_lock));
+		
 		if ((timer_tick_count++ % HZ) == 0) {
 		    mips_display_message(&display_string[display_count++]);
 		    if (display_count == MAX_DISPLAY_COUNT)
@@ -267,10 +271,10 @@
 	change_cp0_status(ST0_IM, ALLINTS);
 
 	/* Read time from the RTC chipset. */
-	write_lock_irqsave (&xtime_lock, flags);
+	fr_write_lock_irqsave (&xtime_lock, flags);
 	xtime.tv_sec = get_mips_time();
 	xtime.tv_usec = 0;
-	write_unlock_irqrestore(&xtime_lock, flags);
+	fr_write_unlock_irqrestore(&xtime_lock, flags);
 }
 
 /* This is for machines which generate the exact clock. */
@@ -363,20 +367,23 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned int flags;
+	unsigned long seq;
+
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	read_lock_irqsave (&xtime_lock, flags);
-	*tv = xtime;
-	tv->tv_usec += do_fast_gettimeoffset();
+		*tv = xtime;
+		tv->tv_usec += do_fast_gettimeoffset();
 
-	/*
-	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-	 * is nonzero if the timer bottom half hasnt executed yet.
-	 */
-	if (jiffies - wall_jiffies)
-		tv->tv_usec += USECS_PER_JIFFY;
+		/*
+		 * xtime is atomically updated in timer_bh. 
+		 * jiffies - wall_jiffies
+		 * is nonzero if the timer bottom half hasnt executed yet.
+		 */
+		if (jiffies - wall_jiffies)
+			tv->tv_usec += USECS_PER_JIFFY;
 
-	read_unlock_irqrestore (&xtime_lock, flags);
+	} while (seq != fr_read_end(&xtime_lock));
 
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
@@ -386,7 +393,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	fr_write_lock_irq (&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_usec correctly.
 	 * However, the value in this location is is value at the last tick.
@@ -406,5 +413,5 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq (&xtime_lock);
+	fr_write_unlock_irq (&xtime_lock);
 }
diff -urN -X dontdiff linux-2.5.59/arch/mips/philips/nino/time.c linux-2.5-frlock/arch/mips/philips/nino/time.c
--- linux-2.5.59/arch/mips/philips/nino/time.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/mips/philips/nino/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -24,7 +24,7 @@
 #include <asm/tx3912.h>
 
 extern volatile unsigned long wall_jiffies;
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 static struct timeval xbase;
 
@@ -61,30 +61,31 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-    unsigned long flags;
+    unsigned long seq;
     unsigned long high, low;
 
-    read_lock_irqsave(&xtime_lock, flags);
-    // 40 bit RTC, driven by 32khz source:
-    // +-----------+-----------------------------------------+
-    // | HHHH.HHHH | LLLL.LLLL.LLLL.LLLL.LMMM.MMMM.MMMM.MMMM |
-    // +-----------+-----------------------------------------+
-    readRTC(&high,&low);
-    tv->tv_sec  = (high << 17) | (low >> 15);
-    tv->tv_usec = (low % 32768) * 1953 / 64;
-    tv->tv_sec += xbase.tv_sec;
-    tv->tv_usec += xbase.tv_usec;
+    do {
+	    seq = fr_read_begin(&xtime_lock);
 
-    tv->tv_usec += do_gettimeoffset();
+	    // 40 bit RTC, driven by 32khz source:
+	    // +-----------+-----------------------------------------+
+	    // | HHHH.HHHH | LLLL.LLLL.LLLL.LLLL.LMMM.MMMM.MMMM.MMMM |
+	    // +-----------+-----------------------------------------+
+	    readRTC(&high,&low);
+	    tv->tv_sec  = (high << 17) | (low >> 15);
+	    tv->tv_usec = (low % 32768) * 1953 / 64;
+	    tv->tv_sec += xbase.tv_sec;
+	    tv->tv_usec += xbase.tv_usec;
 
-    /*
-     * xtime is atomically updated in timer_bh. lost_ticks is
-     * nonzero if the timer bottom half hasnt executed yet.
-     */
-    if (jiffies - wall_jiffies)
-	tv->tv_usec += USECS_PER_JIFFY;
+	    tv->tv_usec += do_gettimeoffset();
 
-    read_unlock_irqrestore(&xtime_lock, flags);
+	    /*
+	     * xtime is atomically updated in timer_bh. lost_ticks is
+	     * nonzero if the timer bottom half hasnt executed yet.
+	     */
+	    if (jiffies - wall_jiffies)
+		    tv->tv_usec += USECS_PER_JIFFY;
+    } while (seq != fr_read_end(&xtime_lock));
 
     if (tv->tv_usec >= 1000000) {
 	tv->tv_usec -= 1000000;
@@ -94,7 +95,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-    write_lock_irq(&xtime_lock);
+    fr_write_lock_irq(&xtime_lock);
     /* This is revolting. We need to set the xtime.tv_usec
      * correctly. However, the value in this location is
      * is value at the last tick.
@@ -118,7 +119,7 @@
     time_state = TIME_BAD;
     time_maxerror = MAXPHASE;
     time_esterror = MAXPHASE;
-    write_unlock_irq(&xtime_lock);
+    fr_write_unlock_irq(&xtime_lock);
 }
 
 static int set_rtc_mmss(unsigned long nowtime)
diff -urN -X dontdiff linux-2.5.59/arch/mips64/mips-boards/generic/time.c linux-2.5-frlock/arch/mips64/mips-boards/generic/time.c
--- linux-2.5.59/arch/mips64/mips-boards/generic/time.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/mips64/mips-boards/generic/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -44,7 +44,7 @@
 
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 #define ALLINTS (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4 | IE_IRQ5)
 
@@ -133,6 +133,7 @@
 void mips_timer_interrupt(struct pt_regs *regs)
 {
 	int irq = 7;
+	unsigned long seq;
 
 	if (r4k_offset == 0)
 		goto null;
@@ -148,17 +149,20 @@
  		 * within 500ms before the * next second starts, 
  		 * thus the following code.
  		 */
-		read_lock(&xtime_lock);
-		if ((time_status & STA_UNSYNC) == 0 
-		    && xtime.tv_sec > last_rtc_update + 660 
-		    && xtime.tv_usec >= 500000 - (tick >> 1) 
-		    && xtime.tv_usec <= 500000 + (tick >> 1))
-			if (set_rtc_mmss(xtime.tv_sec) == 0)
-				last_rtc_update = xtime.tv_sec;
-			else
-				/* do it again in 60 s */
-	    			last_rtc_update = xtime.tv_sec - 600; 
-		read_unlock(&xtime_lock);
+		do {
+			seq = fr_read_begin(&xtime_lock);
+			
+			if ((time_status & STA_UNSYNC) == 0 
+			    && xtime.tv_sec > last_rtc_update + 660 
+			    && xtime.tv_usec >= 500000 - (tick >> 1) 
+			    && xtime.tv_usec <= 500000 + (tick >> 1))
+				if (set_rtc_mmss(xtime.tv_sec) == 0)
+					last_rtc_update = xtime.tv_sec;
+				else
+					/* do it again in 60 s */
+					last_rtc_update = xtime.tv_sec - 600; 
+		} while (seq != fr_read_end(&xtime_lock));
+
 
 		if ((timer_tick_count++ % HZ) == 0) {
 		    mips_display_message(&display_string[display_count++]);
@@ -266,10 +270,10 @@
 	set_cp0_status(ST0_IM, ALLINTS);
 
 	/* Read time from the RTC chipset. */
-	write_lock_irqsave (&xtime_lock, flags);
+	fr_write_lock_irqsave (&xtime_lock, flags);
 	xtime.tv_sec = get_mips_time();
 	xtime.tv_usec = 0;
-	write_unlock_irqrestore(&xtime_lock, flags);
+	fr_write_unlock_irqrestore(&xtime_lock, flags);
 }
 
 /* This is for machines which generate the exact clock. */
@@ -352,20 +356,24 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned int flags;
+	unsigned long seq;
 
-	read_lock_irqsave (&xtime_lock, flags);
-	*tv = xtime;
-	tv->tv_usec += do_fast_gettimeoffset();
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	/*
-	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-	 * is nonzero if the timer bottom half hasnt executed yet.
-	 */
-	if (jiffies - wall_jiffies)
-		tv->tv_usec += USECS_PER_JIFFY;
+		*tv = xtime;
+		tv->tv_usec += do_fast_gettimeoffset();
+
+		/*
+		 * xtime is atomically updated in timer_bh. 
+		 * jiffies - wall_jiffies
+		 * is nonzero if the timer bottom half hasnt executed yet.
+		 */
+		if (jiffies - wall_jiffies)
+			tv->tv_usec += USECS_PER_JIFFY;
+
+	} while (seq != fr_read_end(&xtime_lock));
 
-	read_unlock_irqrestore (&xtime_lock, flags);
 
 	if (tv->tv_usec >= 1000000) {
 		tv->tv_usec -= 1000000;
@@ -375,7 +383,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	fr_write_lock_irq (&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_usec correctly.
 	 * However, the value in this location is is value at the last tick.
@@ -395,5 +403,5 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq (&xtime_lock);
+	fr_write_unlock_irq (&xtime_lock);
 }
diff -urN -X dontdiff linux-2.5.59/arch/mips64/sgi-ip22/ip22-timer.c linux-2.5-frlock/arch/mips64/sgi-ip22/ip22-timer.c
--- linux-2.5.59/arch/mips64/sgi-ip22/ip22-timer.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/mips64/sgi-ip22/ip22-timer.c	2003-01-24 14:54:11.000000000 -0800
@@ -32,7 +32,7 @@
 static unsigned long r4k_offset; /* Amount to increment compare reg each time */
 static unsigned long r4k_cur;    /* What counter should be at next timer irq */
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 static inline void ack_r4ktimer(unsigned long newval)
 {
@@ -86,7 +86,7 @@
 	unsigned long count;
 	int irq = 7;
 
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 	/* Ack timer and compute new compare. */
 	count = read_32bit_cp0_register(CP0_COUNT);
 	/* This has races.  */
@@ -116,7 +116,7 @@
 			/* do it again in 60s  */
 			last_rtc_update = xtime.tv_sec - 600;
 	}
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 
 static unsigned long dosample(volatile unsigned char *tcwp,
@@ -224,10 +224,10 @@
 	set_cp0_status(ST0_IM, ALLINTS);
 	sti();
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	xtime.tv_sec = get_indy_time();		/* Read time from RTC. */
 	xtime.tv_usec = 0;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 void indy_8254timer_irq(void)
@@ -243,20 +243,21 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	*tv = xtime;
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		*tv = xtime;
+	} while (seq != fr_read_end(&xtime_lock));
 }
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	xtime = *tv;
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
diff -urN -X dontdiff linux-2.5.59/arch/mips64/sgi-ip27/ip27-timer.c linux-2.5-frlock/arch/mips64/sgi-ip27/ip27-timer.c
--- linux-2.5.59/arch/mips64/sgi-ip27/ip27-timer.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/mips64/sgi-ip27/ip27-timer.c	2003-01-24 14:54:11.000000000 -0800
@@ -40,7 +40,7 @@
 static unsigned long ct_cur[NR_CPUS];	/* What counter should be at next timer irq */
 static long last_rtc_update;		/* Last time the rtc clock got updated */
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern volatile unsigned long wall_jiffies;
 
 
@@ -94,7 +94,7 @@
 	int cpuA = ((cputoslice(cpu)) == 0);
 	int irq = 7;				/* XXX Assign number */
 
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 
 again:
 	LOCAL_HUB_S(cpuA ? PI_RT_PEND_A : PI_RT_PEND_B, 0);	/* Ack  */
@@ -145,7 +145,7 @@
 		}
         }
 
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 
 	if (softirq_pending(cpu))
 		do_softirq();
@@ -160,19 +160,21 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
 	unsigned long usec, sec;
+	unsigned long seq;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
-	sec = xtime.tv_sec;
-	usec += xtime.tv_usec;
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+
+		usec = do_gettimeoffset();
+		{
+			unsigned long lost = jiffies - wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		sec = xtime.tv_sec;
+		usec += xtime.tv_usec;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -185,7 +187,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	tv->tv_usec -= do_gettimeoffset();
 	tv->tv_usec -= (jiffies - wall_jiffies) * (1000000 / HZ);
 
@@ -199,7 +201,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /* Includes for ioc3_init().  */
diff -urN -X dontdiff linux-2.5.59/arch/parisc/kernel/sys_parisc32.c linux-2.5-frlock/arch/parisc/kernel/sys_parisc32.c
--- linux-2.5.59/arch/parisc/kernel/sys_parisc32.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/parisc/kernel/sys_parisc32.c	2003-01-24 14:54:11.000000000 -0800
@@ -2428,22 +2428,25 @@
 asmlinkage int sys32_sysinfo(struct sysinfo32 *info)
 {
 	struct sysinfo val;
+	unsigned long seq;
 	int err;
-	extern rwlock_t xtime_lock;
+	extern frlock_t xtime_lock;
 
 	/* We don't need a memset here because we copy the
 	 * struct to userspace once element at a time.
 	 */
 
-	read_lock_irq(&xtime_lock);
-	val.uptime = jiffies / HZ;
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
-	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
-	val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
+		val.uptime = jiffies / HZ;
+		
+		val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
+		val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
+		val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
 
-	val.procs = nr_threads;
-	read_unlock_irq(&xtime_lock);
+		val.procs = nr_threads;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	si_meminfo(&val);
 	si_swapinfo(&val);
diff -urN -X dontdiff linux-2.5.59/arch/parisc/kernel/time.c linux-2.5-frlock/arch/parisc/kernel/time.c
--- linux-2.5.59/arch/parisc/kernel/time.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/parisc/kernel/time.c	2003-01-24 14:54:11.000000000 -0800
@@ -36,7 +36,7 @@
 
 /* xtime and wall_jiffies keep wall-clock time */
 extern unsigned long wall_jiffies;
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 static long clocktick;	/* timer cycles per tick */
 static long halftick;
@@ -115,9 +115,9 @@
 		smp_do_timer(regs);
 #endif
 		if (cpu == 0) {
-			write_lock(&xtime_lock);
+			fr_write_lock(&xtime_lock);
 			do_timer(regs);
-			write_unlock(&xtime_lock);
+			fr_write_unlock(&xtime_lock);
 		}
 	}
     
@@ -172,16 +172,18 @@
 void
 do_gettimeofday (struct timeval *tv)
 {
-	unsigned long flags, usec, sec;
+	unsigned long seq, usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	{
-		usec = gettimeoffset();
+	do {
+		seq = fr_read_begin(&xtime_lock);
+
+		{
+			usec = gettimeoffset();
 	
-		sec = xtime.tv_sec;
-		usec += (xtime.tv_nsec / 1000);
-	}
-	read_unlock_irqrestore(&xtime_lock, flags);
+			sec = xtime.tv_sec;
+			usec += (xtime.tv_nsec / 1000);
+		}
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -195,7 +197,7 @@
 void
 do_settimeofday (struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	{
 		/*
 		 * This is revolting. We need to set "xtime"
@@ -219,7 +221,7 @@
 		time_maxerror = NTP_PHASE_LIMIT;
 		time_esterror = NTP_PHASE_LIMIT;
 	}
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 
@@ -241,10 +243,10 @@
 	mtctl(next_tick, 16);
 
 	if(pdc_tod_read(&tod_data) == 0) {
-		write_lock_irq(&xtime_lock);
+		fr_write_lock_irq(&xtime_lock);
 		xtime.tv_sec = tod_data.tod_sec;
 		xtime.tv_nsec = tod_data.tod_usec * 1000;
-		write_unlock_irq(&xtime_lock);
+		fr_write_unlock_irq(&xtime_lock);
 	} else {
 		printk(KERN_ERR "Error reading tod clock\n");
 	        xtime.tv_sec = 0;
diff -urN -X dontdiff linux-2.5.59/arch/ppc/kernel/time.c linux-2.5-frlock/arch/ppc/kernel/time.c
--- linux-2.5.59/arch/ppc/kernel/time.c	2003-01-17 09:42:16.000000000 -0800
+++ linux-2.5-frlock/arch/ppc/kernel/time.c	2003-01-24 14:54:12.000000000 -0800
@@ -76,7 +76,7 @@
 
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 /* The decrementer counts down by 128 every 128ns on a 601. */
 #define DECREMENTER_COUNT_601	(1000000000 / HZ)
@@ -161,7 +161,7 @@
 			continue;
 
 		/* We are in an interrupt, no need to save/restore flags */
-		write_lock(&xtime_lock);
+		fr_write_lock(&xtime_lock);
 		tb_last_stamp = jiffy_stamp;
 		do_timer(regs);
 
@@ -191,7 +191,7 @@
 				/* Try again one minute later */
 				last_rtc_update += 60;
 		}
-		write_unlock(&xtime_lock);
+		fr_write_unlock(&xtime_lock);
 	}
 	if ( !disarm_decr[smp_processor_id()] )
 		set_dec(next_dec);
@@ -212,22 +212,23 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned delta, lost_ticks, usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	sec = xtime.tv_sec;
-	usec = (xtime.tv_nsec / 1000);
-	delta = tb_ticks_since(tb_last_stamp);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		sec = xtime.tv_sec;
+		usec = (xtime.tv_nsec / 1000);
+		delta = tb_ticks_since(tb_last_stamp);
 #ifdef CONFIG_SMP
-	/* As long as timebases are not in sync, gettimeofday can only
-	 * have jiffy resolution on SMP.
-	 */
-	if (!smp_tb_synchronized)
-		delta = 0;
+		/* As long as timebases are not in sync, gettimeofday can only
+		 * have jiffy resolution on SMP.
+		 */
+		if (!smp_tb_synchronized)
+			delta = 0;
 #endif /* CONFIG_SMP */
-	lost_ticks = jiffies - wall_jiffies;
-	read_unlock_irqrestore(&xtime_lock, flags);
+		lost_ticks = jiffies - wall_jiffies;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	usec += mulhwu(tb_to_us, tb_ticks_per_jiffy * lost_ticks + delta);
 	while (usec >= 1000000) {
@@ -243,7 +244,7 @@
 	unsigned long flags;
 	int tb_delta, new_usec, new_sec;
 
-	write_lock_irqsave(&xtime_lock, flags);
+	fr_write_lock_irqsave(&xtime_lock, flags);
 	/* Updating the RTC is not the job of this code. If the time is
 	 * stepped under NTP, the RTC will be update after STA_UNSYNC
 	 * is cleared. Tool like clock/hwclock either copy the RTC
@@ -283,7 +284,7 @@
 	time_state = TIME_ERROR;        /* p. 24, (a) */
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irqrestore(&xtime_lock, flags);
+	fr_write_unlock_irqrestore(&xtime_lock, flags);
 }
 
 /* This function is only called on the boot processor */
diff -urN -X dontdiff linux-2.5.59/arch/ppc/platforms/pmac_time.c linux-2.5-frlock/arch/ppc/platforms/pmac_time.c
--- linux-2.5.59/arch/ppc/platforms/pmac_time.c	2003-01-17 09:42:17.000000000 -0800
+++ linux-2.5-frlock/arch/ppc/platforms/pmac_time.c	2003-01-24 14:54:12.000000000 -0800
@@ -29,7 +29,7 @@
 #include <asm/time.h>
 #include <asm/nvram.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 /* Apparently the RTC stores seconds since 1 Jan 1904 */
 #define RTC_OFFSET	2082844800
@@ -218,16 +218,17 @@
 
 	switch (when) {
 	case PBOOK_SLEEP_NOW:
-		read_lock_irqsave(&xtime_lock, flags);
-		time_diff = xtime.tv_sec - pmac_get_rtc_time();
-		read_unlock_irqrestore(&xtime_lock, flags);
+		do {
+			flags = fr_read_begin(&xtime_lock);
+			time_diff = xtime.tv_sec - pmac_get_rtc_time();
+		} while (seq != fr_read_end(&xtime_lock));
 		break;
 	case PBOOK_WAKE:
-		write_lock_irqsave(&xtime_lock, flags);
+		fr_write_lock_irqsave(&xtime_lock, flags);
 		xtime.tv_sec = pmac_get_rtc_time() + time_diff;
 		xtime.tv_nsec = 0;
 		last_rtc_update = xtime.tv_sec;
-		write_unlock_irqrestore(&xtime_lock, flags);
+		fr_write_unlock_irqrestore(&xtime_lock, flags);
 		break;
 	}
 	return PBOOK_SLEEP_OK;
diff -urN -X dontdiff linux-2.5.59/arch/ppc64/kernel/time.c linux-2.5-frlock/arch/ppc64/kernel/time.c
--- linux-2.5.59/arch/ppc64/kernel/time.c	2003-01-17 09:42:23.000000000 -0800
+++ linux-2.5-frlock/arch/ppc64/kernel/time.c	2003-01-24 14:54:12.000000000 -0800
@@ -69,7 +69,7 @@
 
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern int piranha_simulator;
 #ifdef CONFIG_PPC_ISERIES
 unsigned long iSeries_recal_titan = 0;
@@ -284,12 +284,12 @@
 		smp_local_timer_interrupt(regs);
 #endif
 		if (cpu == boot_cpuid) {
-			write_lock(&xtime_lock);
+			fr_write_lock(&xtime_lock);
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
 			do_timer(regs);
 			timer_sync_xtime( cur_tb );
 			timer_check_rtc();
-			write_unlock(&xtime_lock);
+			fr_write_unlock(&xtime_lock);
 			if ( adjusting_time && (time_adjust == 0) )
 				ppc_adjtimex();
 		}
@@ -348,7 +348,7 @@
 	long int tb_delta, new_usec, new_sec;
 	unsigned long new_xsec;
 
-	write_lock_irqsave(&xtime_lock, flags);
+	fr_write_lock_irqsave(&xtime_lock, flags);
 	/* Updating the RTC is not the job of this code. If the time is
 	 * stepped under NTP, the RTC will be update after STA_UNSYNC
 	 * is cleared. Tool like clock/hwclock either copy the RTC
@@ -399,7 +399,7 @@
 		do_gtod.tb_orig_stamp = tb_last_stamp;
 	}
 
-	write_unlock_irqrestore(&xtime_lock, flags);
+	fr_write_unlock_irqrestore(&xtime_lock, flags);
 }
 
 /*
@@ -465,7 +465,7 @@
 #endif
 		ppc_md.get_boot_time(&tm);
 
-	write_lock_irqsave(&xtime_lock, flags);
+	fr_write_lock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 			      tm.tm_hour, tm.tm_min, tm.tm_sec);
 	tb_last_stamp = get_tb();
@@ -484,7 +484,7 @@
 
 	xtime.tv_nsec = 0;
 	last_rtc_update = xtime.tv_sec;
-	write_unlock_irqrestore(&xtime_lock, flags);
+	fr_write_unlock_irqrestore(&xtime_lock, flags);
 
 	/* Not exact, but the timer interrupt takes care of this */
 	set_dec(tb_ticks_per_jiffy);
@@ -587,7 +587,7 @@
 	new_tb_to_xs = divres.result_low;
 	new_xsec = mulhdu( tb_ticks, new_tb_to_xs );
 
-	write_lock_irqsave( &xtime_lock, flags );
+	fr_write_lock_irqsave( &xtime_lock, flags );
 	old_xsec = mulhdu( tb_ticks, do_gtod.varp->tb_to_xs );
 	new_stamp_xsec = do_gtod.varp->stamp_xsec + old_xsec - new_xsec;
 
@@ -609,7 +609,7 @@
 	do_gtod.varp = temp_varp;
 	do_gtod.var_idx = temp_idx;
 
-	write_unlock_irqrestore( &xtime_lock, flags );
+	fr_write_unlock_irqrestore( &xtime_lock, flags );
 
 }
 
diff -urN -X dontdiff linux-2.5.59/arch/s390/kernel/time.c linux-2.5-frlock/arch/s390/kernel/time.c
--- linux-2.5.59/arch/s390/kernel/time.c	2003-01-17 09:42:23.000000000 -0800
+++ linux-2.5-frlock/arch/s390/kernel/time.c	2003-01-24 14:54:12.000000000 -0800
@@ -52,7 +52,7 @@
 static uint64_t xtime_cc;
 static uint64_t init_timer_cc;
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 void tod_to_timeval(__u64 todval, struct timespec *xtime)
@@ -82,13 +82,15 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	sec = xtime.tv_sec;
-	usec = xtime.tv_nsec / 1000 + do_gettimeoffset();
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+
+		sec = xtime.tv_sec;
+		usec = xtime.tv_nsec / 1000 + do_gettimeoffset();
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -102,7 +104,7 @@
 void do_settimeofday(struct timeval *tv)
 {
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/* This is revolting. We need to set the xtime.tv_nsec
 	 * correctly. However, the value in this location is
 	 * is value at the last tick.
@@ -122,7 +124,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 static inline __u32 div64_32(__u64 dividend, __u32 divisor)
@@ -166,7 +168,7 @@
 	 * Do not rely on the boot cpu to do the calls to do_timer.
 	 * Spread it over all cpus instead.
 	 */
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 	if (S390_lowcore.jiffy_timer > xtime_cc) {
 		__u32 xticks;
 
@@ -181,7 +183,7 @@
 		while (xticks--)
 			do_timer(regs);
 	}
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 	while (ticks--)
 		update_process_times(user_mode(regs));
 #else
diff -urN -X dontdiff linux-2.5.59/arch/s390x/kernel/time.c linux-2.5-frlock/arch/s390x/kernel/time.c
--- linux-2.5.59/arch/s390x/kernel/time.c	2003-01-17 09:42:23.000000000 -0800
+++ linux-2.5-frlock/arch/s390x/kernel/time.c	2003-01-24 14:54:12.000000000 -0800
@@ -51,7 +51,7 @@
 static uint64_t xtime_cc;
 static uint64_t init_timer_cc;
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 void tod_to_timeval(__u64 todval, struct timespec *xtime)
@@ -77,13 +77,14 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	sec = xtime.tv_sec;
-	usec = xtime.tv_nsec + do_gettimeoffset();
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		sec = xtime.tv_sec;
+		usec = xtime.tv_nsec + do_gettimeoffset();
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -97,7 +98,7 @@
 void do_settimeofday(struct timeval *tv)
 {
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/* This is revolting. We need to set the xtime.tv_usec
 	 * correctly. However, the value in this location is
 	 * is value at the last tick.
@@ -117,7 +118,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /*
@@ -152,7 +153,7 @@
 	 * Do not rely on the boot cpu to do the calls to do_timer.
 	 * Spread it over all cpus instead.
 	 */
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 	if (S390_lowcore.jiffy_timer > xtime_cc) {
 		__u32 xticks;
 
@@ -167,7 +168,7 @@
 		while (xticks--)
 			do_timer(regs);
 	}
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 	while (ticks--)
 		update_process_times(user_mode(regs));
 #else
diff -urN -X dontdiff linux-2.5.59/arch/sh/kernel/time.c linux-2.5-frlock/arch/sh/kernel/time.c
--- linux-2.5.59/arch/sh/kernel/time.c	2003-01-17 09:42:23.000000000 -0800
+++ linux-2.5-frlock/arch/sh/kernel/time.c	2003-01-24 14:54:12.000000000 -0800
@@ -72,7 +72,7 @@
 
 u64 jiffies_64;
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 #define TICK_SIZE tick
 
@@ -127,19 +127,20 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
-	sec = xtime.tv_sec;
-	usec += xtime.tv_usec;
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		usec = do_gettimeoffset();
+		{
+			unsigned long lost = jiffies - wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		sec = xtime.tv_sec;
+		usec += xtime.tv_usec;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -152,7 +153,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -172,7 +173,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /* last time the RTC clock got updated */
@@ -231,9 +232,9 @@
 	 * the irq version of write_lock because as just said we have irq
 	 * locally disabled. -arca
 	 */
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 	do_timer_interrupt(irq, NULL, regs);
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 
 static unsigned int __init get_timer_frequency(void)
diff -urN -X dontdiff linux-2.5.59/arch/sparc/kernel/pcic.c linux-2.5-frlock/arch/sparc/kernel/pcic.c
--- linux-2.5.59/arch/sparc/kernel/pcic.c	2003-01-17 09:42:24.000000000 -0800
+++ linux-2.5-frlock/arch/sparc/kernel/pcic.c	2003-01-24 14:54:12.000000000 -0800
@@ -34,7 +34,7 @@
 #include <asm/timer.h>
 #include <asm/uaccess.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 #ifndef CONFIG_PCI
 
@@ -739,10 +739,10 @@
 
 static void pcic_timer_handler (int irq, void *h, struct pt_regs *regs)
 {
-	write_lock(&xtime_lock);	/* Dummy, to show that we remember */
+	fr_write_lock(&xtime_lock);	/* Dummy, to show that we remember */
 	pcic_clear_clock_irq();
 	do_timer(regs);
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 
 #define USECS_PER_JIFFY  10000  /* We have 100HZ "standard" timer for sparc */
@@ -794,19 +794,20 @@
 
 static void pci_do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
-	sec = xtime.tv_sec;
-	usec += (xtime.tv_nsec / 1000);
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		usec = do_gettimeoffset();
+		{
+			unsigned long lost = jiffies - wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / 1000);
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
diff -urN -X dontdiff linux-2.5.59/arch/sparc/kernel/time.c linux-2.5-frlock/arch/sparc/kernel/time.c
--- linux-2.5.59/arch/sparc/kernel/time.c	2003-01-17 09:42:24.000000000 -0800
+++ linux-2.5-frlock/arch/sparc/kernel/time.c	2003-01-24 14:54:12.000000000 -0800
@@ -42,7 +42,7 @@
 #include <asm/page.h>
 #include <asm/pcic.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 extern unsigned long wall_jiffies;
 
@@ -131,7 +131,7 @@
 #endif
 
 	/* Protect counter clear so that do_gettimeoffset works */
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 #ifdef CONFIG_SUN4
 	if((idprom->id_machtype == (SM_SUN4 | SM_4_260)) ||
 	   (idprom->id_machtype == (SM_SUN4 | SM_4_110))) {
@@ -155,7 +155,7 @@
 	  else
 	    last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 
 /* Kick start a stopped clock (procedure from the Sun NVRAM/hostid FAQ). */
@@ -469,19 +469,20 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
-	sec = xtime.tv_sec;
-	usec += (xtime.tv_nsec / 1000);
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		usec = do_gettimeoffset();
+		{
+			unsigned long lost = jiffies - wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / 1000);
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -494,9 +495,9 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	bus_do_settimeofday(tv);
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 static void sbus_do_settimeofday(struct timeval *tv)
diff -urN -X dontdiff linux-2.5.59/arch/sparc64/kernel/time.c linux-2.5-frlock/arch/sparc64/kernel/time.c
--- linux-2.5.59/arch/sparc64/kernel/time.c	2003-01-17 09:42:24.000000000 -0800
+++ linux-2.5-frlock/arch/sparc64/kernel/time.c	2003-01-24 14:54:12.000000000 -0800
@@ -37,7 +37,7 @@
 #include <asm/isa.h>
 #include <asm/starfire.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 spinlock_t mostek_lock = SPIN_LOCK_UNLOCKED;
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
@@ -134,7 +134,7 @@
 {
 	unsigned long ticks, pstate;
 
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 
 	do {
 #ifndef CONFIG_SMP
@@ -196,13 +196,13 @@
 
 	timer_check_rtc();
 
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 
 #ifdef CONFIG_SMP
 void timer_tick_interrupt(struct pt_regs *regs)
 {
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 
 	do_timer(regs);
 
@@ -225,7 +225,7 @@
 
 	timer_check_rtc();
 
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 #endif
 
@@ -665,7 +665,7 @@
 	if (this_is_starfire)
 		return;
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -686,7 +686,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /* Ok, my cute asm atomicity trick doesn't work anymore.
@@ -695,19 +695,20 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
-	sec = xtime.tv_sec;
-	usec += (xtime.tv_nsec / 1000);
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		usec = do_gettimeoffset();
+		{
+			unsigned long lost = jiffies - wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / 1000);
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
diff -urN -X dontdiff linux-2.5.59/arch/um/kernel/time_kern.c linux-2.5-frlock/arch/um/kernel/time_kern.c
--- linux-2.5.59/arch/um/kernel/time_kern.c	2003-01-17 09:42:24.000000000 -0800
+++ linux-2.5-frlock/arch/um/kernel/time_kern.c	2003-01-24 14:54:12.000000000 -0800
@@ -21,7 +21,7 @@
 
 u64 jiffies_64;
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 int hz(void)
 {
@@ -57,9 +57,9 @@
 void um_timer(int irq, void *dev, struct pt_regs *regs)
 {
 	do_timer(regs);
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 	timer();
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 
 long um_time(int * tloc)
diff -urN -X dontdiff linux-2.5.59/arch/v850/kernel/time.c linux-2.5-frlock/arch/v850/kernel/time.c
--- linux-2.5.59/arch/v850/kernel/time.c	2003-01-17 09:42:24.000000000 -0800
+++ linux-2.5-frlock/arch/v850/kernel/time.c	2003-01-24 14:54:12.000000000 -0800
@@ -107,7 +107,7 @@
 #endif /* 0 */
 }
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 /*
  * This version of gettimeofday has near microsecond resolution.
@@ -118,23 +118,25 @@
 	extern volatile unsigned long lost_ticks;
 	unsigned long lost;
 #endif
-	unsigned long flags;
 	unsigned long usec, sec;
+	unsigned long seq;
+
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	read_lock_irqsave (&xtime_lock, flags);
 #if 0
-	usec = mach_gettimeoffset ? mach_gettimeoffset () : 0;
+		usec = mach_gettimeoffset ? mach_gettimeoffset () : 0;
 #else
-	usec = 0;
+		usec = 0;
 #endif
 #if 0 /* DAVIDM later if possible */
-	lost = lost_ticks;
-	if (lost)
-		usec += lost * (1000000/HZ);
+		lost = lost_ticks;
+		if (lost)
+			usec += lost * (1000000/HZ);
 #endif
-	sec = xtime.tv_sec;
-	usec += xtime.tv_nsec / 1000;
-	read_unlock_irqrestore (&xtime_lock, flags);
+		sec = xtime.tv_sec;
+		usec += xtime.tv_nsec / 1000;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -147,7 +149,7 @@
 
 void do_settimeofday (struct timeval *tv)
 {
-	write_lock_irq (&xtime_lock);
+	fr_write_lock_irq (&xtime_lock);
 
 	/* This is revolting. We need to set the xtime.tv_nsec
 	 * correctly. However, the value in this location is
@@ -172,7 +174,7 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq (&xtime_lock);
+	fr_write_unlock_irq (&xtime_lock);
 }
 
 static int timer_dev_id;
diff -urN -X dontdiff linux-2.5.59/arch/x86_64/kernel/time.c linux-2.5-frlock/arch/x86_64/kernel/time.c
--- linux-2.5.59/arch/x86_64/kernel/time.c	2003-01-17 09:42:24.000000000 -0800
+++ linux-2.5-frlock/arch/x86_64/kernel/time.c	2003-01-21 13:20:21.000000000 -0800
@@ -27,7 +27,7 @@
 
 u64 jiffies_64; 
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
 unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
@@ -70,21 +70,22 @@
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags, t;
+	unsigned long flags, t, seq;
  	unsigned int sec, usec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	spin_lock(&time_offset_lock);
+	spin_lock_irqsave(&time_offset_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+
+		sec = xtime.tv_sec;
+		usec = xtime.tv_nsec / 1000;
+
+		t = (jiffies - wall_jiffies) * (1000000L / HZ) + do_gettimeoffset();
+		if (t > timeoffset) timeoffset = t;
+		usec += timeoffset;
 
-	sec = xtime.tv_sec;
-	usec = xtime.tv_nsec / 1000;
-
-	t = (jiffies - wall_jiffies) * (1000000L / HZ) + do_gettimeoffset();
-	if (t > timeoffset) timeoffset = t;
-	usec += timeoffset;
-
-	spin_unlock(&time_offset_lock);
-	read_unlock_irqrestore(&xtime_lock, flags);
+	} while (seq != fr_read_end(&xtime_lock));
+	spin_unlock_irqrestore(&time_offset_lock, flags);
 
 	tv->tv_sec = sec + usec / 1000000;
 	tv->tv_usec = usec % 1000000;
@@ -98,7 +99,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	vxtime_lock();
 
 	tv->tv_usec -= do_gettimeoffset() +
@@ -118,7 +119,7 @@
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /*
@@ -201,7 +202,7 @@
  * variables, because both do_timer() and us change them -arca+vojtech
 	 */
 
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 	vxtime_lock();
 
 	{
@@ -250,7 +251,7 @@
 	}
  
 	vxtime_unlock();
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 }
 
 unsigned long get_cmos_time(void)

--=-WCXb2mgBfvK9rpzWKvXg--

