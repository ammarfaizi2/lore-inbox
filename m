Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283131AbRK2KGI>; Thu, 29 Nov 2001 05:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283130AbRK2KFx>; Thu, 29 Nov 2001 05:05:53 -0500
Received: from ns.caldera.de ([212.34.180.1]:48877 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283132AbRK2KFf>;
	Thu, 29 Nov 2001 05:05:35 -0500
Date: Thu, 29 Nov 2001 11:04:47 +0100
Message-Id: <200111291004.fATA4l608978@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: mkarras110@yahoo.com (Michael Arras)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] Fix for sys_nanosleep() in 2.4.16
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3C05DC1D.7071FC6B@yahoo.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C05DC1D.7071FC6B@yahoo.com> you wrote:
> Greetings,
>
> For many of us, the kernel thread scheduling resolution is
> 10ms (see getitimer(2)).  By adding 1 jiffy to the time to
> sleep in sys_nanosleep(), threads are sleeping 10ms too long.
> timespec_to_jiffies() does a good job at returning the
> appropriate number of jiffies to sleep.  There is no need to
> add one for good measure.

Please take a look at:

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15aa1/00_nanosleep-5

instead.

Linus & Marcelo: any chance to get that into the tree? (patch is inlined below)

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -urN 2.4.6pre6/include/linux/time.h nanosleep/include/linux/time.h
--- 2.4.6pre6/include/linux/time.h	Thu Jun 14 18:07:48 2001
+++ nanosleep/include/linux/time.h	Thu Jun 28 11:47:14 2001
@@ -48,6 +48,27 @@
 	value->tv_sec = jiffies / HZ;
 }
 
+static __inline__ int
+timespec_before(struct timespec a, struct timespec b)
+{
+	if (a.tv_sec == b.tv_sec)
+		return a.tv_nsec < b.tv_nsec;
+	return a.tv_sec < b.tv_sec;
+}
+
+/* computes `a - b'  and write the result in `result', assumes `a >= b' */
+static inline void
+timespec_less(struct timespec a, struct timespec b, struct timespec * result)
+{
+	if (a.tv_nsec < b.tv_nsec)
+	{
+		a.tv_sec--;
+		a.tv_nsec += 1000000000;
+	}
+
+	result->tv_sec = a.tv_sec - b.tv_sec;
+	result->tv_nsec = a.tv_nsec - b.tv_nsec;
+}
 
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
@@ -89,6 +110,27 @@
 	time_t		tv_sec;		/* seconds */
 	suseconds_t	tv_usec;	/* microseconds */
 };
+
+/* computes `a - b'  and write the result in `result', assumes `a >= b' */
+static inline void
+timeval_less(struct timeval a, struct timeval b, struct timeval * result)
+{
+	if (a.tv_usec < b.tv_usec)
+	{
+		a.tv_sec--;
+		a.tv_usec += 1000000;
+	}
+
+	result->tv_sec = a.tv_sec - b.tv_sec;
+	result->tv_usec = a.tv_usec - b.tv_usec;
+}
+
+static __inline__ void
+timeval_to_timespec(struct timeval tv, struct timespec * ts)
+{
+	ts->tv_sec = tv.tv_sec;
+	ts->tv_nsec = (long) tv.tv_usec * 1000;
+}
 
 struct timezone {
 	int	tz_minuteswest;	/* minutes west of Greenwich */
diff -urN 2.4.6pre6/kernel/timer.c nanosleep/kernel/timer.c
--- 2.4.6pre6/kernel/timer.c	Thu Jun 28 11:38:09 2001
+++ nanosleep/kernel/timer.c	Thu Jun 28 11:48:47 2001
@@ -798,6 +798,7 @@
 {
 	struct timespec t;
 	unsigned long expire;
+	struct timeval before, after;
 
 	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
 		return -EFAULT;
@@ -822,11 +823,20 @@
 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
 
 	current->state = TASK_INTERRUPTIBLE;
+	get_fast_time(&before);
 	expire = schedule_timeout(expire);
+	get_fast_time(&after);
 
 	if (expire) {
 		if (rmtp) {
-			jiffies_to_timespec(expire, &t);
+			struct timespec elapsed;
+
+			timeval_less(after, before, &after);
+			timeval_to_timespec(after, &elapsed);
+			if (timespec_before(elapsed, t))
+				timespec_less(t, elapsed, &t);
+			else
+				t.tv_nsec = t.tv_sec = 0;
 			if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
 				return -EFAULT;
 		}
