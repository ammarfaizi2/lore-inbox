Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266695AbUHQU2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUHQU2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbUHQU2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:28:47 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:60843 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S266695AbUHQU2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:28:23 -0400
Date: Tue, 17 Aug 2004 22:25:26 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, voland@dmz.com.pl, nicolas.george@ens.fr,
       kaukasoi@elektroni.ee.tut.fi, george@mvista.com, johnstul@us.ibm.com,
       david+powerix@blue-labs.org
Subject: [PATCH] Re: boot time, process start time, and NOW time
In-Reply-To: <20040816124136.27646d14.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
References: <1087948634.9831.1154.camel@cube> <87smcf5zx7.fsf@devron.myhome.or.jp>
 <20040816124136.27646d14.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Andrew Morton wrote:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >
> > Albert Cahalan <albert@users.sf.net> writes:
> > 
> > > Even with the 2.6.7 kernel, I'm still getting reports of process
> > > start times wandering. Here is an example:
> > > 
> > >    "About 12 hours since reboot to 2.6.7 there was already a
> > >    difference of about 7 seconds between the real start time
> > >    and the start time reported by ps. Now, 24 hours since reboot
> > >    the difference is 10 seconds."
> > > 
> > > The calculation used is:
> > > 
> > >    now - uptime + time_from_boot_to_process_start
> > 
> > Start-time and uptime is using different source. Looks like the
> > jiffies was added bogus lost counts.
> > 
> > quick hack. Does this change the behavior?
> 
> Where did this all end up?  Complaints about wandering start times are
> persistent, and it'd be nice to get some fix in place...
> 
> Thanks.
> 

Seems my analysis of the problem wasn't perceived as such.

The problem is that in the above calculation 

  now - uptime + time_from_boot_to_process_start

"uptime" currently is an ntp-corrected precise time, while 
"time_from_boot_to_process_start" just is the free-running "jiffies"
value.

The problem is easily reproducible for me. It goes away if the change
that rebased /proc/uptime on posix monotonic time and my followup patch to 
fix the resulting rounding issues in jiffies64_to_clock_t() are backed out 
with the following patch.

Tim



--- linux-2.6.8.1/fs/proc/proc_misc.c	2004-08-17 21:38:54.000000000 +0200
+++ linux-2.6.8.1-uf/fs/proc/proc_misc.c	2004-08-17 21:41:53.000000000 +0200
@@ -133,19 +133,36 @@ static struct vmalloc_info get_vmalloc_i
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	struct timespec uptime;
-	struct timespec idle;
+	u64 uptime;
+	unsigned long uptime_remainder;
 	int len;
-	u64 idle_jiffies = init_task.utime + init_task.stime;
 
-	do_posix_clock_monotonic_gettime(&uptime);
-	jiffies_to_timespec(idle_jiffies, &idle);
-	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-			(unsigned long) uptime.tv_sec,
-			(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
-			(unsigned long) idle.tv_sec,
-			(idle.tv_nsec / (NSEC_PER_SEC / 100)));
+	uptime = get_jiffies_64() - INITIAL_JIFFIES;
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 
+#if HZ!=100
+	{
+		u64 idle = init_task.utime + init_task.stime;
+		unsigned long idle_remainder;
+
+		idle_remainder = (unsigned long) do_div(idle, HZ);
+		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime,
+			(uptime_remainder * 100) / HZ,
+			(unsigned long) idle,
+			(idle_remainder * 100) / HZ);
+	}
+#else
+	{
+		unsigned long idle = init_task.utime + init_task.stime;
+
+		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime,
+			uptime_remainder,
+			idle / HZ,
+			idle % HZ);
+	}
+#endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 

--- linux-2.6.8.1/include/linux/times.h	2004-08-17 00:13:35.000000000 +0200
+++ linux-2.6.8.1-uf/include/linux/times.h	2004-08-17 21:44:26.000000000 +0200
@@ -7,16 +7,11 @@
 #include <asm/types.h>
 #include <asm/param.h>
 
-static inline clock_t jiffies_to_clock_t(long x)
-{
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
-	return x / (HZ / USER_HZ);
+#if (HZ % USER_HZ)==0
+# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
 #else
-	u64 tmp = (u64)x * TICK_NSEC;
-	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
-	return (long)tmp;
+# define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
 #endif
-}
 
 static inline unsigned long clock_t_to_jiffies(unsigned long x)
 {
@@ -40,7 +35,7 @@ static inline unsigned long clock_t_to_j
 
 static inline u64 jiffies_64_to_clock_t(u64 x)
 {
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+#if (HZ % USER_HZ)==0
 	do_div(x, HZ / USER_HZ);
 #else
 	/*
@@ -48,8 +43,8 @@ static inline u64 jiffies_64_to_clock_t(
 	 * but even this doesn't overflow in hundreds of years
 	 * in 64 bits, so..
 	 */
-	x *= TICK_NSEC;
-	do_div(x, (NSEC_PER_SEC / USER_HZ));
+	x *= USER_HZ;
+	do_div(x, HZ);
 #endif
 	return x;
 }
