Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSKTDiY>; Tue, 19 Nov 2002 22:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSKTDiX>; Tue, 19 Nov 2002 22:38:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52364 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265628AbSKTDiV>;
	Tue, 19 Nov 2002 22:38:21 -0500
Subject: Re: gettimeofday() cripples notsc system
From: john stultz <johnstul@us.ibm.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1037754386.3393.255.camel@dyn9-47-17-164.beaverton.ibm.com>
References: <1037754386.3393.255.camel@dyn9-47-17-164.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037763642.4463.139.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 19:40:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 17:06, Michael Hohnbaum wrote:
> Running a large application that issues many gettimeofday()
> system calls on a kernel running with notsc, results in time
> slowing way down.  I've seen the system time advance only 
> three minutes over a 30 minute period.  The following program,
> executed twice demonstrates the problem.  Three instances running
> in parallel made a 16 processor machine completely unusable.
[snip]
> I've recreated on 2.5.30, 2.5.44, and 2.5.47.  Running a system that
[snip]
> I assume there is a lock starvation problem happening here, correct?

Most likely xtime_lock starvation. I believe other folks were hitting
this earlier. What do folks think about the attached (and completely
untested, probably breaks x86-64) patch? I'm yanking the read_lock for a
vxtime_sequence lock, as implemented in the x86-64 vsyscall code. This
should alleviate the writer starvation, although no doubt it still has a
few gotchas in it. Also I still need to vxtime_lock all the other
instances of write locking the xtime_lock, but its a start. 

comments, flames?

-john


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Nov 19 19:30:05 2002
+++ b/arch/i386/kernel/time.c	Tue Nov 19 19:30:05 2002
@@ -85,19 +85,19 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
-	unsigned long usec, sec;
+	unsigned long usec, sec, sequence;
 
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
+	sequence = vxtime_sequence[1];
+	do {
+		usec = timer->get_offset();
+		{
+			unsigned long lost = jiffies - wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		sec = xtime.tv_sec;
+		usec += (xtime.tv_nsec / 1000);
+	} while(sequence != vxtime_sequence[0]);
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -111,6 +111,7 @@
 void do_settimeofday(struct timeval *tv)
 {
 	write_lock_irq(&xtime_lock);
+	vxtime_lock();
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -127,6 +128,8 @@
 
 	xtime.tv_sec = tv->tv_sec;
 	xtime.tv_nsec = (tv->tv_usec * 1000);
+	vxtime_unlock();
+	
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -278,11 +281,13 @@
 	 * locally disabled. -arca
 	 */
 	write_lock(&xtime_lock);
-
+	vxtime_lock();
+	
 	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);
 
+	vxtime_unlock();
 	write_unlock(&xtime_lock);
 
 }
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Tue Nov 19 19:30:05 2002
+++ b/arch/i386/kernel/timers/timer_pit.c	Tue Nov 19 19:30:05 2002
@@ -61,17 +61,17 @@
 static unsigned long get_offset_pit(void)
 {
 	int count;
-
+	unsigned long flags;
 	static int count_p = LATCH;    /* for the first call after boot */
 	static unsigned long jiffies_p = 0;
 
 	/*
-	 * cache volatile jiffies temporarily; we have IRQs turned off. 
+	 * cache volatile jiffies temporarily; 
+	 * IRQs are not turned off, but we'll retry if something changes
 	 */
 	unsigned long jiffies_t;
 
-	/* gets recalled with irq locally disabled */
-	spin_lock(&i8253_lock);
+	spin_lock_irqsave(&i8253_lock,flags);
 	/* timer count may underflow right here */
 	outb_p(0x00, 0x43);	/* latch the count ASAP */
 
@@ -93,7 +93,7 @@
                 count = LATCH - 1;
         }
 	
-	spin_unlock(&i8253_lock);
+	spin_unlock_irqrestore(&i8253_lock,flags);
 
 	/*
 	 * avoiding timer inconsistencies (they are rare, but they happen)...
diff -Nru a/include/linux/time.h b/include/linux/time.h
--- a/include/linux/time.h	Tue Nov 19 19:30:05 2002
+++ b/include/linux/time.h	Tue Nov 19 19:30:05 2002
@@ -122,6 +122,11 @@
 extern struct timespec xtime;
 extern rwlock_t xtime_lock;
 
+/*unstarvable xtime rwlock*/
+extern long vxtime_sequence[2];
+#define vxtime_lock() do { vxtime_sequence[0]++; wmb(); } while(0)
+#define vxtime_unlock() do { wmb(); vxtime_sequence[1]++; } while (0)
+
 static inline unsigned long get_seconds(void)
 { 
 	return xtime.tv_sec;
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Tue Nov 19 19:30:05 2002
+++ b/kernel/timer.c	Tue Nov 19 19:30:05 2002
@@ -761,6 +761,7 @@
  */
 rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
 unsigned long last_time_offset;
+long vxtime_sequence[2]; /*unstarvable xtime rwlock*/
 
 /*
  * This function runs timers and the timer-tq in bottom half context.



