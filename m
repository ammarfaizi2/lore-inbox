Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWIFKDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWIFKDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIFKDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:03:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9422 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750762AbWIFKDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:03:10 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] FRV: Use the generic time stuff for FRV
Date: Wed, 06 Sep 2006 11:02:45 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com,
       johnstul@us.ibm.com
Message-Id: <20060906100245.9833.61804.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: john stultz <johnstul@us.ibm.com>

Use the generic time stuff for FRV.

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/Kconfig       |    4 ++
 arch/frv/kernel/time.c |   81 ------------------------------------------------
 2 files changed, 4 insertions(+), 81 deletions(-)

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index be3b621..5e6583a 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -29,6 +29,10 @@ config GENERIC_HARDIRQS
 	bool
 	default n
 
+config GENERIC_TIME
+	bool
+	default y
+
 config TIME_LOW_RES
 	bool
 	default y
diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
index d5b64e1..68a77fe 100644
--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -32,8 +32,6 @@ #include <linux/timex.h>
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-extern unsigned long wall_jiffies;
-
 unsigned long __nongprelbss __clkin_clock_speed_HZ;
 unsigned long __nongprelbss __ext_bus_clock_speed_HZ;
 unsigned long __nongprelbss __res_bus_clock_speed_HZ;
@@ -145,85 +143,6 @@ void time_init(void)
 }
 
 /*
- * This version of gettimeofday has near microsecond resolution.
- */
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long seq;
-	unsigned long usec, sec;
-	unsigned long max_ntp_tick;
-
-	do {
-		unsigned long lost;
-
-		seq = read_seqbegin(&xtime_lock);
-
-		usec = 0;
-		lost = jiffies - wall_jiffies;
-
-		/*
-		 * If time_adjust is negative then NTP is slowing the clock
-		 * so make sure not to go into next possible interval.
-		 * Better to lose some accuracy than have time go backwards..
-		 */
-		if (unlikely(time_adjust < 0)) {
-			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
-			usec = min(usec, max_ntp_tick);
-
-			if (lost)
-				usec += lost * max_ntp_tick;
-		}
-		else if (unlikely(lost))
-			usec += lost * (USEC_PER_SEC / HZ);
-
-		sec = xtime.tv_sec;
-		usec += (xtime.tv_nsec / 1000);
-	} while (read_seqretry(&xtime_lock, seq));
-
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-	/*
-	 * This is revolting. We need to set "xtime" correctly. However, the
-	 * value in this location is the value at the most recent update of
-	 * wall time.  Discover what correction gettimeofday() would have
-	 * made, and then undo it!
-	 */
-	nsec -= 0 * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
-/*
  * Scheduler clock - returns current time in nanosec units.
  */
 unsigned long long sched_clock(void)
