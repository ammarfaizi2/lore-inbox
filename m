Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUA2Wvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUA2Wvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:51:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:41654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266484AbUA2Wul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:50:41 -0500
Date: Thu, 29 Jan 2004 14:51:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: process start times by procps
Message-Id: <20040129145148.47cae69a.akpm@osdl.org>
In-Reply-To: <20040129203340.GA1169@elektroni.ee.tut.fi>
References: <20040123194714.GA22315@elektroni.ee.tut.fi>
	<20040125110847.GA10824@elektroni.ee.tut.fi>
	<20040127155254.GA1656@elektroni.ee.tut.fi>
	<1075342912.1592.72.camel@cog.beaverton.ibm.com>
	<20040129143847.GA4544@elektroni.ee.tut.fi>
	<1075405728.1592.100.camel@cog.beaverton.ibm.com>
	<20040129203340.GA1169@elektroni.ee.tut.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
>
> On Thu, Jan 29, 2004 at 11:48:49AM -0800, john stultz wrote:
> > On Thu, 2004-01-29 at 06:38, Petri Kaukasoina wrote:
> > > Yes, on linux-2.2.24 I can see that /proc/uptime is just the jiffies and
> > > btime is current time - jiffies. But in linux-2.6.1 /proc/uptime is now
> > > do_posix_clock_monotonic_gettime(), whatever that means, and /proc/uptime
> > > gives a correct value. But btime is still gettimeofday-jiffies and it does
> > > not stay constant. My patch changed btime to be
> > > gettimeofday-do_posix_clock_monotonic_gettime() and after that it stays
> > > constant.
> > 
> > Does George Anzinger's patch work as well?
> 
> I must have missed that... Any references?
> 

This one.

diff -puN fs/proc/proc_misc.c~proc-stat-btime-fix-2 fs/proc/proc_misc.c
--- 25/fs/proc/proc_misc.c~proc-stat-btime-fix-2	Tue Jan 27 17:46:57 2004
+++ 25-akpm/fs/proc/proc_misc.c	Tue Jan 27 17:46:57 2004
@@ -360,23 +360,12 @@ int show_stat(struct seq_file *p, void *
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
 
 	for_each_cpu(i) {
 		int j;

_

