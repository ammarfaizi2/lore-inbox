Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUKHATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUKHATw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 19:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUKHATv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 19:19:51 -0500
Received: from p508EED3F.dip.t-dialin.net ([80.142.237.63]:13955 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S261718AbUKHATd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 19:19:33 -0500
Date: Mon, 8 Nov 2004 01:19:32 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Workaround for wrapping loadaverage
Message-ID: <20041108001932.GA16641@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everyone,

in a previous message archived at

http://www.ussg.iu.edu/hypermail/linux/kernel/0410.2/2950.html

I described a problem with a wrapping load average on my SMP system.
The following small userspace load simulation exactly matches the
numbers I am seeing.

We can only account for 1024 runnable processes, since we have 22 bits
precision, I would like to suggest a patch to calc_load in kernel/timer.c
that would limit the number of active tasks:


if (active_tasks > 1024 * FIXED_1)
	active_tasks = 1024 * FIXED_1;


I am aware that this is not a fix ... The wrapping happens using threaded
applications (Java/JBoss in my case). Below you'll find a small userspace
simulation.

I would really like to provide a real fix, but I really couldn't figure
out what went wrong.

Thanks for any feedback,
Patrick


/* Sample code copied from include/linux/sched.h and kernel/timer.c */

#include <stdio.h>

#define FSHIFT	11		/* 11 bit precision */
#define FIXED_1	(1 << FSHIFT)	/* 1.0 as fixed-point */

#define EXP_1	1884	/* 1/exp(5sec/1min)  */
#define EXP_5	2014	/* 1/exp(5sec/5min)  */
#define EXP_15	2037	/* 1/exp(5sec/15min) */

#define CALC_LOAD(load, exp, n) \
		load *= exp; \
		load += n*(FIXED_1-exp); \
		load >>= FSHIFT;

static unsigned long avenrun[3];

/* normal load spike and one error */
static unsigned long tasks[8] = {
	0, 1, 0, ~0, 0, 0, 0
};

static void calc_load(unsigned long tasks)
{
	tasks <<= FSHIFT;

	CALC_LOAD(avenrun[0], EXP_1, tasks);
	CALC_LOAD(avenrun[1], EXP_5, tasks);
	CALC_LOAD(avenrun[2], EXP_15, tasks);
}

int main(int argc, char **argv)
{
	int i, j;

	for (i = 0; i < 8; i++) { /* index for tasks[] */
 		/* 24 calculations per load change */

		for (j = 0; j < 24; j++) {
			calc_load(tasks[i]);

			printf("%.2f %.2f %.2f\n",
				   (float) avenrun[0] / FIXED_1, 
				   (float) avenrun[1] / FIXED_1,
				   (float) avenrun[2] / FIXED_1);
		}
	}

	return 0;
}

