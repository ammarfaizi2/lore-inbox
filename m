Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTFJAnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 20:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTFJAnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 20:43:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3055 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262367AbTFJAnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 20:43:25 -0400
Message-ID: <3EE52CA7.9010007@mvista.com>
Date: Mon, 09 Jun 2003 17:56:07 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Eric Piel <Eric.Piel@Bull.Net>
Subject: [PATCH] Some clean up of the time code.
Content-Type: multipart/mixed;
 boundary="------------040909040406010907050908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040909040406010907050908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

NOW, on top of 2.5.70-bk9 :)

This is an update of a patch I sent some time ago.  You could not
apply it then because of some other stuff...  Let me know if I need to
use a different base system...

I will send Eric's patch soon...

This patch does the following:

Pushs down the change from timeval to timespec in the settime routines.

Fixes two places where time was set without updating the monotonic
clock offset.  (Changes sys_stime() to call do_settimeofday() and
changes clock_warp to do the update directly.)  These were bugs!

Changes the uptime code to use the posix_clock_monotonic notion of
uptime instead of the jiffies.  This time will track NTP changes and
so should be better than your standard wristwatch (if your using ntp).

Changes posix_clock_monotonic to start at 0 on boot (was set to start
at initial jiffies).

Fixes a bug (never experienced) in timer_create() in posix-timers.c
where we "could" have released timer_id 0 if "id resources" were low.

Adds a test in do_settimeofday() to error out (EINVAL) attempts to use
unnormalized times.  This is passed back up to both settimeofday and
posix_setclock().

Warning: Requires changes in .../arch/???/kernel/time.c to change
do_settimeofday() to return an error if time is not normalized and to
use a timespec instead of timeval for its input.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml



--------------040909040406010907050908
Content-Type: text/plain;
 name="timecleanup-2.5.70-bk9-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timecleanup-2.5.70-bk9-1.0.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-kb/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.5.70-bk9-kb/arch/i386/kernel/time.c	2003-05-05 15:33:31.000000000 -0700
+++ linux/arch/i386/kernel/time.c	2003-06-09 17:16:13.000000000 -0700
@@ -114,8 +114,11 @@
 	tv->tv_usec = usec;
 }
 
-void do_settimeofday(struct timeval *tv)
+int do_settimeofday(struct timespec *tv)
 {
+	if ((unsigned long)tv->tv_nsec > NSEC_PER_SEC)
+		return -EINVAL;
+
 	write_seqlock_irq(&xtime_lock);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
@@ -123,17 +126,16 @@
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	tv->tv_usec -= timer->get_offset();
-	tv->tv_usec -= (jiffies - wall_jiffies) * (USEC_PER_SEC / HZ);
+	tv->tv_nsec -= timer->get_offset() * NSEC_PER_USEC;
+	tv->tv_nsec -= (jiffies - wall_jiffies) * TICK_NSEC(TICK_USEC);
 
-	while (tv->tv_usec < 0) {
-		tv->tv_usec += USEC_PER_SEC;
+	while (tv->tv_nsec < 0) {
+		tv->tv_nsec += NSEC_PER_SEC;
 		tv->tv_sec--;
 	}
-	tv->tv_usec *= NSEC_PER_USEC;
 
 	wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
-	wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_usec;
+	wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_nsec;
 
 	if (wall_to_monotonic.tv_nsec > NSEC_PER_SEC) {
 		wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
@@ -145,13 +147,14 @@
 	}
 
 	xtime.tv_sec = tv->tv_sec;
-	xtime.tv_nsec = tv->tv_usec;
+	xtime.tv_nsec = tv->tv_nsec;
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
+	return 0;
 }
 
 static int set_rtc_mmss(unsigned long nowtime)
@@ -299,9 +302,9 @@
 {
 	
 	xtime.tv_sec = get_cmos_time();
-	wall_to_monotonic.tv_sec = -xtime.tv_sec + INITIAL_JIFFIES / HZ;
+	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	wall_to_monotonic.tv_nsec = 0;
+	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
 
 
 	timer = select_timer();
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-kb/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- linux-2.5.70-bk9-kb/fs/proc/proc_misc.c	2003-05-30 01:18:10.000000000 -0700
+++ linux/fs/proc/proc_misc.c	2003-06-09 17:16:13.000000000 -0700
@@ -137,36 +137,19 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	u64 uptime;
-	unsigned long uptime_remainder;
+	struct timespec uptime;
+	struct timespec idle;
 	int len;
+	u64 idle_jiffies = init_task.utime + init_task.stime;
 
-	uptime = get_jiffies_64() - INITIAL_JIFFIES;
-	uptime_remainder = (unsigned long) do_div(uptime, HZ);
+	do_posix_clock_monotonic_gettime(&uptime);
+	jiffies_to_timespec(idle_jiffies, &idle);
+	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime.tv_sec,
+			(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
+			(unsigned long) idle.tv_sec,
+			(idle.tv_nsec / (NSEC_PER_SEC / 100)));
 
-#if HZ!=100
-	{
-		u64 idle = init_task.utime + init_task.stime;
-		unsigned long idle_remainder;
-
-		idle_remainder = (unsigned long) do_div(idle, HZ);
-		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-			(unsigned long) uptime,
-			(uptime_remainder * 100) / HZ,
-			(unsigned long) idle,
-			(idle_remainder * 100) / HZ);
-	}
-#else
-	{
-		unsigned long idle = init_task.utime + init_task.stime;
-
-		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-			(unsigned long) uptime,
-			uptime_remainder,
-			idle / HZ,
-			idle % HZ);
-	}
-#endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-kb/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.70-bk9-kb/include/linux/time.h	2003-05-30 01:18:18.000000000 -0700
+++ linux/include/linux/time.h	2003-06-09 17:16:13.000000000 -0700
@@ -200,9 +200,10 @@
 
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
-extern void do_settimeofday(struct timeval *tv);
-extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
+extern int do_settimeofday(struct timespec *tv);
+extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
 extern void clock_was_set(void); // call when ever the clock is set
+extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
 extern long do_nanosleep(struct timespec *t);
 extern long do_utimes(char __user * filename, struct timeval * times);
 #endif
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-kb/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.70-bk9-kb/kernel/posix-timers.c	2003-06-09 17:13:23.000000000 -0700
+++ linux/kernel/posix-timers.c	2003-06-09 17:37:10.000000000 -0700
@@ -409,7 +409,7 @@
 	do {
 		if (unlikely(!idr_pre_get(&posix_timers_id))) {
 			error = -EAGAIN;
-			new_timer_id = (timer_t)-1;
+			new_timer->it_id = (timer_t)-1;
 			goto out;
 		}
 		spin_lock_irq(&idr_lock);
@@ -1026,8 +1026,7 @@
 	if (posix_clocks[which_clock].clock_set)
 		return posix_clocks[which_clock].clock_set(&new_tp);
 
-	new_tp.tv_nsec /= NSEC_PER_USEC;
-	return do_sys_settimeofday((struct timeval *) &new_tp, NULL);
+	return do_sys_settimeofday(&new_tp, NULL);
 }
 
 asmlinkage long
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-kb/kernel/time.c linux/kernel/time.c
--- linux-2.5.70-bk9-kb/kernel/time.c	2003-06-09 17:13:23.000000000 -0700
+++ linux/kernel/time.c	2003-06-09 17:28:12.000000000 -0700
@@ -68,22 +68,15 @@
  
 asmlinkage long sys_stime(int * tptr)
 {
-	int value;
+	struct timespec tv;
 
 	if (!capable(CAP_SYS_TIME))
 		return -EPERM;
-	if (get_user(value, tptr))
+	if (get_user(tv.tv_sec, tptr))
 		return -EFAULT;
-	write_seqlock_irq(&xtime_lock);
 
-	time_interpolator_reset();
-	xtime.tv_sec = value;
-	xtime.tv_nsec = 0;
-	time_adjust = 0;	/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-	write_sequnlock_irq(&xtime_lock);
+	tv.tv_nsec = 0;
+	do_settimeofday(&tv);
 	return 0;
 }
 
@@ -123,9 +116,11 @@
 inline static void warp_clock(void)
 {
 	write_seqlock_irq(&xtime_lock);
+	wall_to_monotonic.tv_sec -= sys_tz.tz_minuteswest * 60;
 	xtime.tv_sec += sys_tz.tz_minuteswest * 60;
 	time_interpolator_update(sys_tz.tz_minuteswest * 60 * NSEC_PER_SEC);
 	write_sequnlock_irq(&xtime_lock);
+	clock_was_set();
 }
 
 /*
@@ -139,7 +134,7 @@
  * various programs will get confused when the clock gets warped.
  */
 
-int do_sys_settimeofday(struct timeval *tv, struct timezone *tz)
+int do_sys_settimeofday(struct timespec *tv, struct timezone *tz)
 {
 	static int firsttime = 1;
 
@@ -160,14 +155,14 @@
 		/* SMP safe, again the code in arch/foo/time.c should
 		 * globally block out interrupts when it runs.
 		 */
-		do_settimeofday(tv);
+		return do_settimeofday(tv);
 	}
 	return 0;
 }
 
 asmlinkage long sys_settimeofday(struct timeval __user *tv, struct timezone __user *tz)
 {
-	struct timeval	new_tv;
+	struct timespec	new_tv;
 	struct timezone new_tz;
 
 	if (tv) {
@@ -177,6 +172,7 @@
 	if (tz) {
 		if (copy_from_user(&new_tz, tz, sizeof(*tz)))
 			return -EFAULT;
+		new_tv.tv_nsec *= NSEC_PER_USEC;
 	}
 
 	return do_sys_settimeofday(tv ? &new_tv : NULL, tz ? &new_tz : NULL);
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.70-bk9-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.70-bk9-kb/kernel/timer.c	2003-06-09 17:13:23.000000000 -0700
+++ linux/kernel/timer.c	2003-06-09 17:16:13.000000000 -0700
@@ -1108,7 +1108,6 @@
 asmlinkage long sys_sysinfo(struct sysinfo __user *info)
 {
 	struct sysinfo val;
-	u64 uptime;
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
 	unsigned long seq;
@@ -1116,11 +1115,25 @@
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	do {
+		struct timespec tp;
 		seq = read_seqbegin(&xtime_lock);
 
-		uptime = jiffies_64 - INITIAL_JIFFIES;
-		do_div(uptime, HZ);
-		val.uptime = (unsigned long) uptime;
+		/*
+		 * This is annoying.  The below is the same thing
+		 * posix_get_clock_monotonic() does, but it wants to
+		 * take the lock which we want to cover the loads stuff
+		 * too.
+		 */
+
+		do_gettimeofday((struct timeval *)&tp);
+		tp.tv_nsec *= NSEC_PER_USEC;
+		tp.tv_sec += wall_to_monotonic.tv_sec;
+		tp.tv_nsec += wall_to_monotonic.tv_nsec;
+		if (tp.tv_nsec - NSEC_PER_SEC >= 0) {
+			tp.tv_nsec = tp.tv_nsec - NSEC_PER_SEC;
+			tp.tv_sec++;
+		}
+		val.uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
 
 		val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 		val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);

--------------040909040406010907050908--

