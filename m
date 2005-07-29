Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVG2WML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVG2WML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVG2WJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:09:45 -0400
Received: from fmr24.intel.com ([143.183.121.16]:45218 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262913AbVG2WHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:07:04 -0400
Date: Fri, 29 Jul 2005 15:06:58 -0700
Message-Id: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com>
From: tony.luck@intel.com
To: linux-kernel@vger.kernel.org
Cc: alex.williamson@hp.com
Cc: clameter@engr.sgi.com
Subject: long delays (possibly infinite) in time_interpolator_get_counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This loop in time_interpolator_get_counter():

		do {
			lcycle = time_interpolator->last_cycle;
			now = time_interpolator_get_cycles(src);
			if (lcycle && time_after(lcycle, now))
				return lcycle;
			/* Keep track of the last timer value returned. The use of cmpxchg here
			 * will cause contention in an SMP environment.
			 */
		} while (unlikely(cmpxchg(&time_interpolator->last_cycle, lcycle, now) != lcycle));

is causing problems.  Alex has managed to get systems to hang in here when
one cpu 'X' is trying to update the time, so owns the write_seqlock on xtime_lock
and two other cpus 'Y' and 'Z' began a gettimeofday *after* X obtained that lock.
X gets stuck in the above loop since one of Y or Z manages to update the value
of time_interpolator->last_cycle every time before it gets to the cmpxchg. Y
and Z are doomed to keep looping in:

	do {
		seq = read_seqbegin(&xtime_lock);
		offset = time_interpolator_get_offset();
		sec = xtime.tv_sec;
		nsec = xtime.tv_nsec;
	} while (unlikely(read_seqretry(&xtime_lock, seq)));

because X has a write lock on xtime_lock.  All this analysis by Alex, I've
just been following along until here.

Alex seems to be a "lucky" guy here, because noone else can reproduce the
hang ... though it is easy to see that it is theoretically possible.

I did throw some instrumentation into time_interpolator_get_counter() to see
how long we spent looping ... and on a 4-way ia64 box saw times as high as
34.7ms (yes, milli-seconds).  The distribution is odd ... the huge majority
of attempts get out of the loop in 0.1 to 100usec.  There is a second, very small
peak centered around 1ms (77 calls out of 5.6 billion), and then a tiny set of
outliers (8 calls) up around 30ms.  These high outliers only show up on cpu3,
max time on cpu0..cpu2 are all around 250us.

The patch below makes things less bad by not letting Y & Z do the cmpxchg if
they are going to fail the read_seqretry() test anyway.  But it is very ugly
to do this extra test on xtime_lock ... so I'm hoping that someone can come
up with something better.

Signed-off-by: Tony Luck <tony.luck@intel.com> // but I hope someone has a better fix :-)

diff --git a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -304,7 +304,7 @@ struct time_interpolator {
 extern void register_time_interpolator(struct time_interpolator *);
 extern void unregister_time_interpolator(struct time_interpolator *);
 extern void time_interpolator_reset(void);
-extern unsigned long time_interpolator_get_offset(void);
+extern unsigned long time_interpolator_get_offset(long);
 
 #else /* !CONFIG_TIME_INTERPOLATION */
 
diff --git a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -494,7 +494,7 @@ void getnstimeofday (struct timespec *tv
 	do {
 		seq = read_seqbegin(&xtime_lock);
 		sec = xtime.tv_sec;
-		nsec = xtime.tv_nsec+time_interpolator_get_offset();
+		nsec = xtime.tv_nsec+time_interpolator_get_offset(seq);
 	} while (unlikely(read_seqretry(&xtime_lock, seq)));
 
 	while (unlikely(nsec >= NSEC_PER_SEC)) {
@@ -538,7 +538,7 @@ void do_gettimeofday (struct timeval *tv
 	unsigned long seq, nsec, usec, sec, offset;
 	do {
 		seq = read_seqbegin(&xtime_lock);
-		offset = time_interpolator_get_offset();
+		offset = time_interpolator_get_offset(seq);
 		sec = xtime.tv_sec;
 		nsec = xtime.tv_nsec;
 	} while (unlikely(read_seqretry(&xtime_lock, seq)));
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1428,7 +1428,7 @@ static inline u64 time_interpolator_get_
 	}
 }
 
-static inline u64 time_interpolator_get_counter(void)
+static inline u64 time_interpolator_get_counter(long seq)
 {
 	unsigned int src = time_interpolator->source;
 
@@ -1442,6 +1442,14 @@ static inline u64 time_interpolator_get_
 			now = time_interpolator_get_cycles(src);
 			if (lcycle && time_after(lcycle, now))
 				return lcycle;
+
+			/*
+			 * If our caller is going to ignore us and retry, then
+			 * don't burn up the bus with the cmpxchg
+			 */
+			if (seq && unlikely(read_seqretry(&xtime_lock, seq)))
+				return now;
+
 			/* Keep track of the last timer value returned. The use of cmpxchg here
 			 * will cause contention in an SMP environment.
 			 */
@@ -1455,19 +1463,19 @@ static inline u64 time_interpolator_get_
 void time_interpolator_reset(void)
 {
 	time_interpolator->offset = 0;
-	time_interpolator->last_counter = time_interpolator_get_counter();
+	time_interpolator->last_counter = time_interpolator_get_counter(0);
 }
 
 #define GET_TI_NSECS(count,i) (((((count) - i->last_counter) & (i)->mask) * (i)->nsec_per_cyc) >> (i)->shift)
 
-unsigned long time_interpolator_get_offset(void)
+unsigned long time_interpolator_get_offset(long seq)
 {
 	/* If we do not have a time interpolator set up then just return zero */
 	if (!time_interpolator)
 		return 0;
 
 	return time_interpolator->offset +
-		GET_TI_NSECS(time_interpolator_get_counter(), time_interpolator);
+		GET_TI_NSECS(time_interpolator_get_counter(seq), time_interpolator);
 }
 
 #define INTERPOLATOR_ADJUST 65536
@@ -1490,7 +1498,7 @@ static void time_interpolator_update(lon
 	 * and the tuning logic insures that.
          */
 
-	counter = time_interpolator_get_counter();
+	counter = time_interpolator_get_counter(0);
 	offset = time_interpolator->offset + GET_TI_NSECS(counter, time_interpolator);
 
 	if (delta_nsec < 0 || (unsigned long) delta_nsec < offset)
