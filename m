Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265748AbUA1BkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUA1BkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:40:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:24053 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265748AbUA1BkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:40:00 -0500
Message-ID: <401712C2.9060602@mvista.com>
Date: Tue, 27 Jan 2004 17:39:14 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: 2.6.1: process start times by procps
References: <20040127150850.4f231875.akpm@osdl.org>
In-Reply-To: <20040127150850.4f231875.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000700080005090504090800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------000700080005090504090800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Does this look right to you??

At first blush, no.  If it is supposed to be the time of boot then it should be 
the same as -wall_to_monotonic.... see below.
> 
> Thanks.
> 
> Begin forwarded message:
> 
> Date: Tue, 27 Jan 2004 17:52:54 +0200
> From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
> To: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.1: process start times by procps
> 
> 
> On Sun, Jan 25, 2004 at 01:08:47PM +0200, I wrote:
> 
>>On Fri, Jan 23, 2004 at 09:47:14PM +0200, I wrote:
>>
>>>For example, I started this bash process really at 21:24 (date showed 21:24
>>>then):
>>>
>>>kaukasoi 22108  0.0  0.2  4452 1532 pts/4    R    21:28   0:00 /bin/bash
>>
>>OK, I would like to make my bug report more accurate: the problem seems to
>>be that the value of btime in /proc/stat is not correct.
> 
> 
> btime in /proc/stat does not stay constant but decreases at a rate of 15
> secs/day. (So I thought that that's why there is that four minute error in
> ps output after uptime of a couple of weeks.) Maybe this has something to do
> with the fact that the 'timer' line in /proc/interrupts does not seem to
> increase at an exact rate of 1000 steps per second but about 1000.18 steps
> per second, instead. (The relative error is the same: 0.18 divided by 1000
> is equal to 15 seconds divided by 24 hours).
> 
> I made an experiment shown below. I know nothing about kernel programming,
> so this is probably not correct, but at least btime seemed to stay constant.
> (I don't believe this fixes procps, though. If HZ if off by 180 ppm then I
> guess ps can't possibly get its calculations involving HZ right. But at
> least the bootup time reported by procinfo stays constant.)
> 
> 
> --- linux-2.6.1/fs/proc/proc_misc.c.orig	2004-01-09 08:59:09.000000000 +0200
> +++ linux-2.6.1/fs/proc/proc_misc.c	2004-01-27 14:39:04.000000000 +0200
> @@ -363,19 +363,13 @@
>  	u64 jif;
>  	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0, irq = 0, softirq = 0;
>  	struct timeval now; 
> -	unsigned long seq;
> -
> -	/* Atomically read jiffies and time of day */ 
> -	do {
> -		seq = read_seqbegin(&xtime_lock);
> -
> -		jif = get_jiffies_64();
> -		do_gettimeofday(&now);
> -	} while (read_seqretry(&xtime_lock, seq));
> +	struct timespec uptime;
>  
> +	do_gettimeofday(&now);
> +	do_posix_clock_monotonic_gettime(&uptime);
>  	/* calc # of seconds since boot time */
> -	jif -= INITIAL_JIFFIES;
> -	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
This conversion is the problem.  The time.h function timespec_to_jiffies is the 
correct way to do this conversion.  Still, wall_to_monotonic is defined such that:
	posix_clock_monotonic = wall_clock - wall_to_monotonic

	This means that - wall_to_monotonic is the value you want and that is, for the 
most part a constant, and all that is needed is the second part..

Try the attached.

> +	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) \
> +            - ((u64)uptime.tv_sec * HZ) - (uptime.tv_nsec/(NSEC_PER_SEC/HZ));
>  	do_div(jif, HZ);
>  
>  	for (i = 0; i < NR_CPUS; i++) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------000700080005090504090800
Content-Type: text/plain;
 name="proc_misc-2.6.1-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_misc-2.6.1-1.0.patch"

--- linux-2.6.1-org/fs/proc/proc_misc.c	2004-01-26 14:45:25.000000000 -0800
+++ linux/fs/proc/proc_misc.c	2004-01-27 17:32:42.000000000 -0800
@@ -360,23 +360,12 @@
 {
 	int i;
 	extern unsigned long total_forks;
-	u64 jif;
+	unsigned long jif;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0, irq = 0, softirq = 0;
-	struct timeval now; 
-	unsigned long seq;
 
-	/* Atomically read jiffies and time of day */ 
-	do {
-		seq = read_seqbegin(&xtime_lock);
-
-		jif = get_jiffies_64();
-		do_gettimeofday(&now);
-	} while (read_seqretry(&xtime_lock, seq));
-
-	/* calc # of seconds since boot time */
-	jif -= INITIAL_JIFFIES;
-	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
-	do_div(jif, HZ);
+	jif = - wall_to_monotonic.tv_sec;
+	if (wall_to_monotonic.tv_nsec)
+		--jif;
 
 	for (i = 0; i < NR_CPUS; i++) {
 		int j;

--------------000700080005090504090800--

