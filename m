Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSGUUkN>; Sun, 21 Jul 2002 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSGUUkN>; Sun, 21 Jul 2002 16:40:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46011 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313477AbSGUUkJ>;
	Sun, 21 Jul 2002 16:40:09 -0400
Date: Sun, 21 Jul 2002 22:41:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: [patch] "big IRQ lock" removal, 2.5.27-A5
In-Reply-To: <Pine.LNX.4.44.0207212121050.24336-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207212237270.26342-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


reviewed and fixed the apm.c hacks, it's now using the proper spinlocks
and not cli()/sti(). Latest full patch is at:

    http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-A5

(the apm.c changes are attached as well.)

	Ingo

--- linux/arch/i386/kernel/apm.c.orig	Sun Jul 21 20:37:10 2002
+++ linux/arch/i386/kernel/apm.c	Sun Jul 21 22:36:42 2002
@@ -222,6 +222,8 @@
 
 #include <linux/sysrq.h>
 
+extern rwlock_t xtime_lock;
+extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
 
@@ -1141,40 +1143,25 @@
 
 static void set_time(void)
 {
-	unsigned long	flags;
-
-	if (got_clock_diff) {	/* Must know time zone in order to set clock */
-		save_flags(flags);
-		cli();
+	if (got_clock_diff)	/* Must know time zone in order to set clock */
 		CURRENT_TIME = get_cmos_time() + clock_cmos_diff;
-		restore_flags(flags);
-	}
 }
 
 static void get_time_diff(void)
 {
 #ifndef CONFIG_APM_RTC_IS_GMT
-	unsigned long	flags;
-
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	save_flags(flags);
 	clock_cmos_diff = -get_cmos_time();
-	cli();
 	clock_cmos_diff += CURRENT_TIME;
 	got_clock_diff = 1;
-	restore_flags(flags);
 #endif
 }
 
-static void reinit_timer(void)
+static inline void reinit_timer(void)
 {
 #ifdef INIT_TIMER_AFTER_SUSPEND
-	unsigned long	flags;
-
-	save_flags(flags);
-	cli();
 	/* set the clock to 100 Hz */
 	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
@@ -1182,7 +1169,6 @@
 	udelay(10);
 	outb(LATCH >> 8 , 0x40);	/* MSB */
 	udelay(10);
-	restore_flags(flags);
 #endif
 }
 
@@ -1203,13 +1189,21 @@
 		}
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
+	/* serialize with the timer interrupt */
+	write_lock_irq(&xtime_lock);
+
+	/* protect against access to timer chip registers */
+	spin_lock(&i8253_lock);
+
 	get_time_diff();
-	cli();
 	err = set_system_power_state(APM_STATE_SUSPEND);
 	reinit_timer();
 	set_time();
 	ignore_normal_resume = 1;
-	sti();
+
+	spin_unlock(&i8253_lock);
+	write_unlock_irq(&xtime_lock);
+
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
 	if (err != APM_SUCCESS)
@@ -1232,8 +1226,12 @@
 {
 	int	err;
 
+	/* serialize with the timer interrupt */
+	write_lock_irq(&xtime_lock);
 	/* If needed, notify drivers here */
 	get_time_diff();
+	write_unlock_irq(&xtime_lock);
+
 	err = set_system_power_state(APM_STATE_STANDBY);
 	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
 		apm_error("standby", err);
@@ -1321,7 +1319,9 @@
 			ignore_bounce = 1;
 			if ((event != APM_NORMAL_RESUME)
 			    || (ignore_normal_resume == 0)) {
+				write_lock_irq(&xtime_lock);
 				set_time();
+				write_unlock_irq(&xtime_lock);
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
@@ -1336,7 +1336,9 @@
 			break;
 
 		case APM_UPDATE_TIME:
+			write_lock_irq(&xtime_lock);
 			set_time();
+			write_unlock_irq(&xtime_lock);
 			break;
 
 		case APM_CRITICAL_SUSPEND:

