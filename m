Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTA1Xdh>; Tue, 28 Jan 2003 18:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTA1Xdg>; Tue, 28 Jan 2003 18:33:36 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261894AbTA1XdR>;
	Tue, 28 Jan 2003 18:33:17 -0500
Subject: [PATCH] (2/4) 2.5.59 fast reader/writer lock for gettimeofday
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ZRqcX4Y+sUUqnI35kHfq"
Organization: Open Source Devlopment Lab
Message-Id: <1043797351.10150.302.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jan 2003 15:42:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZRqcX4Y+sUUqnI35kHfq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the i386  portion of lockless gettimeofday. It changes locking
of xtime_lock from rwlock to frlock.



--=-ZRqcX4Y+sUUqnI35kHfq
Content-Disposition: attachment; filename=frlock-xtime-i386.patch
Content-Type: text/x-patch; name=frlock-xtime-i386.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN -X dontdiff linux-2.5.59/arch/i386/kernel/apm.c linux-2.5-frlock/arch/i386/kernel/apm.c
--- linux-2.5.59/arch/i386/kernel/apm.c	2003-01-17 09:42:14.000000000 -0800
+++ linux-2.5-frlock/arch/i386/kernel/apm.c	2003-01-24 14:54:11.000000000 -0800
@@ -227,7 +227,7 @@
 
 #include <linux/sysrq.h>
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
@@ -1264,7 +1264,7 @@
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
 	/* serialize with the timer interrupt */
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 
 	/* protect against access to timer chip registers */
 	spin_lock(&i8253_lock);
@@ -1276,7 +1276,7 @@
 	ignore_normal_resume = 1;
 
 	spin_unlock(&i8253_lock);
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
@@ -1301,10 +1301,10 @@
 	int	err;
 
 	/* serialize with the timer interrupt */
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/* If needed, notify drivers here */
 	get_time_diff();
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 
 	err = set_system_power_state(APM_STATE_STANDBY);
 	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
@@ -1393,9 +1393,9 @@
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
-				write_lock_irq(&xtime_lock);
+				fr_write_lock_irq(&xtime_lock);
 				set_time();
-				write_unlock_irq(&xtime_lock);
+				fr_write_unlock_irq(&xtime_lock);
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
@@ -1410,9 +1410,9 @@
 			break;
 
 		case APM_UPDATE_TIME:
-			write_lock_irq(&xtime_lock);
+			fr_write_lock_irq(&xtime_lock);
 			set_time();
-			write_unlock_irq(&xtime_lock);
+			fr_write_unlock_irq(&xtime_lock);
 			break;
 
 		case APM_CRITICAL_SUSPEND:
diff -urN -X dontdiff linux-2.5.59/arch/i386/kernel/time.c linux-2.5-frlock/arch/i386/kernel/time.c
--- linux-2.5.59/arch/i386/kernel/time.c	2003-01-17 09:42:14.000000000 -0800
+++ linux-2.5-frlock/arch/i386/kernel/time.c	2003-01-24 15:06:37.000000000 -0800
@@ -70,7 +70,7 @@
 
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
@@ -87,19 +87,21 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = timer->get_offset();
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
+
+		usec = timer->get_offset();
+		{
+			unsigned long lost = jiffies - wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / 1000);
+	} while (unlikely(seq != fr_read_end(&xtime_lock)));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -112,7 +114,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -133,7 +135,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /*
@@ -279,12 +281,12 @@
 	 * the irq version of write_lock because as just said we have irq
 	 * locally disabled. -arca
 	 */
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 
 	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
 
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 
 }

--=-ZRqcX4Y+sUUqnI35kHfq--

