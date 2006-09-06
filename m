Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965259AbWIFBrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbWIFBrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWIFBrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:47:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:10219 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965255AbWIFBrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:47:07 -0400
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj
From: john stultz <johnstul@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org
In-Reply-To: <6260.1157470557@warthog.cambridge.redhat.com>
References: <20060905132530.GD9173@stusta.de>
	 <20060901015818.42767813.akpm@osdl.org>
	 <6260.1157470557@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 18:46:43 -0700
Message-Id: <1157507203.2222.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 16:35 +0100, David Howells wrote:
> Stop do_gettimeofday() on FRV from using tickadj, and model it after ARM
> instead.
> 
> This patch also provides a placeholder macro for getting hardware timer data to
> be filled in when such is available.

>From this patch it looks like the FRV arch could be trivially converted
to GENERIC_TIME.

Would you consider the following, totally untested patch?

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 Kconfig       |    4 ++
 kernel/time.c |   81 ----------------------------------------------------------
 2 files changed, 4 insertions(+), 81 deletions(-)

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 95a3892..a601a17 100644
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
@@ -32,8 +32,6 @@
 
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


