Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbUA0PxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbUA0Pw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:52:59 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:52609 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S264476AbUA0Pw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:52:57 -0500
Date: Tue, 27 Jan 2004 17:52:54 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: process start times by procps
Message-ID: <20040127155254.GA1656@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040123194714.GA22315@elektroni.ee.tut.fi> <20040125110847.GA10824@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125110847.GA10824@elektroni.ee.tut.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 01:08:47PM +0200, I wrote:
> On Fri, Jan 23, 2004 at 09:47:14PM +0200, I wrote:
> > For example, I started this bash process really at 21:24 (date showed 21:24
> > then):
> > 
> > kaukasoi 22108  0.0  0.2  4452 1532 pts/4    R    21:28   0:00 /bin/bash
> 
> OK, I would like to make my bug report more accurate: the problem seems to
> be that the value of btime in /proc/stat is not correct.

btime in /proc/stat does not stay constant but decreases at a rate of 15
secs/day. (So I thought that that's why there is that four minute error in
ps output after uptime of a couple of weeks.) Maybe this has something to do
with the fact that the 'timer' line in /proc/interrupts does not seem to
increase at an exact rate of 1000 steps per second but about 1000.18 steps
per second, instead. (The relative error is the same: 0.18 divided by 1000
is equal to 15 seconds divided by 24 hours).

I made an experiment shown below. I know nothing about kernel programming,
so this is probably not correct, but at least btime seemed to stay constant.
(I don't believe this fixes procps, though. If HZ if off by 180 ppm then I
guess ps can't possibly get its calculations involving HZ right. But at
least the bootup time reported by procinfo stays constant.)


--- linux-2.6.1/fs/proc/proc_misc.c.orig	2004-01-09 08:59:09.000000000 +0200
+++ linux-2.6.1/fs/proc/proc_misc.c	2004-01-27 14:39:04.000000000 +0200
@@ -363,19 +363,13 @@
 	u64 jif;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0, irq = 0, softirq = 0;
 	struct timeval now; 
-	unsigned long seq;
-
-	/* Atomically read jiffies and time of day */ 
-	do {
-		seq = read_seqbegin(&xtime_lock);
-
-		jif = get_jiffies_64();
-		do_gettimeofday(&now);
-	} while (read_seqretry(&xtime_lock, seq));
+	struct timespec uptime;
 
+	do_gettimeofday(&now);
+	do_posix_clock_monotonic_gettime(&uptime);
 	/* calc # of seconds since boot time */
-	jif -= INITIAL_JIFFIES;
-	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
+	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) \
+            - ((u64)uptime.tv_sec * HZ) - (uptime.tv_nsec/(NSEC_PER_SEC/HZ));
 	do_div(jif, HZ);
 
 	for (i = 0; i < NR_CPUS; i++) {
