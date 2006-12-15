Return-Path: <linux-kernel-owner+w=401wt.eu-S1751437AbWLOKAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWLOKAw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 05:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWLOKAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 05:00:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44573 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbWLOKAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 05:00:51 -0500
Date: Fri, 15 Dec 2006 10:58:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: tike64 <tike64@yahoo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: realtime-preempt and arm
Message-ID: <20061215095814.GA29368@elte.hu>
References: <Pine.LNX.4.58.0612140928020.19074@gandalf.stny.rr.com> <20061215071541.35583.qmail@web59204.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215071541.35583.qmail@web59204.mail.re1.yahoo.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* tike64 <tike64@yahoo.com> wrote:

> I made my test code visible if you want to take a look: www dot
> riihineva dot no-ip dot org uphill public uphill test-rt.c

on x86, with nanosleep i get:

 # ./test-rt
 100 revs; min: 5026 max: 5099 avg: 5062
 100 revs; min: 5031 max: 5105 avg: 5065
 100 revs; min: 5021 max: 5096 avg: 5048
 100 revs; min: 5014 max: 5080 avg: 5041
 100 revs; min: 5015 max: 5072 avg: 5040
 100 revs; min: 5018 max: 5075 avg: 5041
 100 revs; min: 5021 max: 5091 avg: 5042

with select i get:

 # ./test-rt
 100 revs; min: 4276 max: 6048 avg: 5181
 100 revs; min: 4371 max: 6060 avg: 5438
 100 revs; min: 4409 max: 6056 avg: 5338
 100 revs; min: 4940 max: 6056 avg: 5468
 100 revs; min: 4938 max: 6049 avg: 5398
 100 revs; min: 4373 max: 6056 avg: 5279
 100 revs; min: 4943 max: 6040 avg: 5068

(HZ=250 on this kernel)

so these results look pretty normal to me. Modified code attached below. 
(Change the '#if 1' to '#if 0' to get the select() measurement.)

	Ingo

----------------->
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <limits.h>
#include <sched.h>
#include <time.h>
#include <sys/time.h>
#include <sys/mman.h>

static unsigned raw_timer(void)
{
	struct timeval tv;

	gettimeofday(&tv, 0);

	return tv.tv_sec * 1000000 + tv.tv_usec;
}

int main(int argc, char *argv[])
{
	int t, min_t = INT_MAX, max_t = INT_MIN, avg_t = 0, n = 0;
	struct timespec ts;
	struct timeval tv;
	struct sched_param prio;

	prio.sched_priority = 99;
	if (sched_setscheduler(0, SCHED_RR, &prio) < 0) {
		perror("setscheduler failed"); }
	if (mlockall(MCL_CURRENT | MCL_FUTURE) < 0) {
		perror("mlockall failed"); }
	while (1) {
		t = raw_timer();

		ts.tv_nsec = 5000000;
		ts.tv_sec = 0;
#if 1
		nanosleep(&ts, 0);
#else
		tv.tv_usec = 5000;
		tv.tv_sec = 0;
		select(0, 0, 0, 0, &tv);
#endif
		t = raw_timer() - t;
		if (max_t < t) max_t = t;
		if (min_t > t) min_t = t;
		avg_t += t;
		++n;
		if (n < 100)
			continue;
		printf("%i revs; min: %i max: %i avg: %i\n", n, min_t, max_t, (avg_t + n / 2) / n);
		fflush(stdout);
		min_t = INT_MAX;
		max_t = INT_MIN;
		avg_t = 0;
		n = 0;
	}
}

