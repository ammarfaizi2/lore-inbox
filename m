Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTEFUY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTEFUY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:24:56 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:49911 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261783AbTEFUYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:24:49 -0400
Subject: Re: gettimeofday running backwards on 2.4.20
From: john stultz <johnstul@us.ibm.com>
To: Trammell Hudson <hudson@osresearch.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200305062020.h46KKww1193872@northrelay02.pok.ibm.com>
References: <200305062020.h46KKww1193872@northrelay02.pok.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052253221.946.135.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 13:33:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Just recently my NAS benchmarks and MPI latency tests showed bizarre
>  results, so I pulled out my test program and am seeing the same
>  problems again.  It seems that roughly 50 in 1 million calls go
>  backwards, even with 2.4.20.
[snip]
>  Interestingly, it only happens on the compute nodes with NFS root.
>  The service node has booted from a local SCSI disk and is serving roughly
>  140 compute nodes without any timing bugs.

2.4 still has problems with xtime_lock writer starvation, as well as
being unable to handle lost ticks. Do you see this problem if you run
UP?

Give this patch (against 2.4.21-rc1) a whirl to see if you're getting
caught by xtime_lock starvation. 

thanks
-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue May  6 13:25:40 2003
+++ b/arch/i386/kernel/time.c	Tue May  6 13:25:40 2003
@@ -79,7 +79,7 @@
  */
 unsigned long fast_gettimeoffset_quotient;
 
-extern rwlock_t xtime_lock;
+extern spinlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
@@ -444,7 +444,7 @@
 	unsigned long flags;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
+	spin_lock_irqsave(&xtime_lock, flags);
 	usec = do_gettimeoffset();
 	{
 		unsigned long lost = jiffies - wall_jiffies;
@@ -453,7 +453,7 @@
 	}
 	sec = xtime.tv_sec;
 	usec += xtime.tv_usec;
-	read_unlock_irqrestore(&xtime_lock, flags);
+	spin_unlock_irqrestore(&xtime_lock, flags);
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -466,7 +466,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	spin_lock_irq(&xtime_lock);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -486,7 +486,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	spin_unlock_irq(&xtime_lock);
 }
 
 /*
@@ -652,7 +652,7 @@
 	 * the irq version of write_lock because as just said we have irq
 	 * locally disabled. -arca
 	 */
-	write_lock(&xtime_lock);
+	spin_lock(&xtime_lock);
 
 	if(use_cyclone)
 		mark_timeoffset_cyclone();
@@ -708,7 +708,7 @@
 
 	do_timer_interrupt(irq, NULL, regs);
 
-	write_unlock(&xtime_lock);
+	spin_unlock(&xtime_lock);
 
 }
 
diff -Nru a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c	Tue May  6 13:25:40 2003
+++ b/kernel/time.c	Tue May  6 13:25:40 2003
@@ -38,7 +38,7 @@
 
 /* The xtime_lock is not only serializing the xtime read/writes but it's also
    serializing all accesses to the global NTP variables now. */
-extern rwlock_t xtime_lock;
+extern spinlock_t xtime_lock;
 
 #if !defined(__alpha__) && !defined(__ia64__)
 
@@ -79,7 +79,7 @@
 		return -EPERM;
 	if (get_user(value, tptr))
 		return -EFAULT;
-	write_lock_irq(&xtime_lock);
+	spin_lock_irq(&xtime_lock);
 	vxtime_lock();
 	xtime.tv_sec = value;
 	xtime.tv_usec = 0;
@@ -88,7 +88,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	spin_unlock_irq(&xtime_lock);
 	return 0;
 }
 
@@ -127,11 +127,11 @@
  */
 inline static void warp_clock(void)
 {
-	write_lock_irq(&xtime_lock);
+	spin_lock_irq(&xtime_lock);
 	vxtime_lock();
 	xtime.tv_sec += sys_tz.tz_minuteswest * 60;
 	vxtime_unlock();
-	write_unlock_irq(&xtime_lock);
+	spin_unlock_irq(&xtime_lock);
 }
 
 /*
@@ -235,7 +235,7 @@
 		if (txc->tick < 900000/HZ || txc->tick > 1100000/HZ)
 			return -EINVAL;
 
-	write_lock_irq(&xtime_lock);
+	spin_lock_irq(&xtime_lock);
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -390,7 +390,7 @@
 	txc->calcnt	   = pps_calcnt;
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
-	write_unlock_irq(&xtime_lock);
+	spin_unlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	return(result);
 }
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Tue May  6 13:25:40 2003
+++ b/kernel/timer.c	Tue May  6 13:25:40 2003
@@ -666,7 +666,7 @@
 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca
  */
-rwlock_t xtime_lock = RW_LOCK_UNLOCKED;
+spinlock_t xtime_lock = SPIN_LOCK_UNLOCKED;
 
 static inline void update_times(void)
 {
@@ -677,7 +677,7 @@
 	 * just know that the irqs are locally enabled and so we don't
 	 * need to save/restore the flags of the local CPU here. -arca
 	 */
-	write_lock_irq(&xtime_lock);
+	spin_lock_irq(&xtime_lock);
 	vxtime_lock();
 
 	ticks = jiffies - wall_jiffies;
@@ -686,7 +686,7 @@
 		update_wall_time(ticks);
 	}
 	vxtime_unlock();
-	write_unlock_irq(&xtime_lock);
+	spin_unlock_irq(&xtime_lock);
 	calc_load(ticks);
 }
 



