Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWBWVAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWBWVAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWBWVAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:00:19 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39829 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750719AbWBWVAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:00:17 -0500
Date: Thu, 23 Feb 2006 21:58:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gautam H Thaker <gthaker@atl.lmco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Message-ID: <20060223205851.GA24321@elte.hu>
References: <43FE134C.6070600@atl.lmco.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <43FE134C.6070600@atl.lmco.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Gautam H Thaker <gthaker@atl.lmco.com> wrote:

> ::::::::::::::
> top:  2.6.15-rt15-smp.out   # REAL_TIME KERNEL
> ::::::::::::::

>  2906 root     -66   0 18624 2244 1480 S 41.4  0.1  27:11.21 nalive.p
>     6 root     -91   0     0    0    0 S 32.3  0.0  21:04.53 softirq-net-rx/
>  1379 root     -40  -5     0    0    0 S 14.5  0.0   9:54.76 IRQ 23

One effect of the -rt kernel is that it shows IRQ load explicitly - 
while the stock kernel can 'hide' it because there interrupts run 
'atomically', making it hard to measure the true system overhead. The 
-rt kernel will likely show more overhead, but i'd not expect this 
amount of overhead.

To figure out the true overhead of both kernels, could you try the 
attached loop_print_thread.c code, and run it on: an idle non-rt kernel, 
and idle -rt kernel, a busy non-rt kernel and a busy -rt kernel, and 
send me the typical/average loops/sec value you are getting?

Furthermore, there have been some tasklet related fixes in 2.6.15-rt17, 
which maybe could improve this workload. Maybe ...

Also, would there be some easy way for me to reproduce that workload?  
Possibly some .c code you could send that is easy to run on the server 
and the client to reproduce the guts of this workload?

	Ingo

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop_print_thread.c"


#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>

#define rdtscll(val) \
     __asm__ __volatile__ ("rdtsc;" : "=A" (val))

#define SECS 3ULL

volatile unsigned int count_array[1000] __attribute__((aligned(256)));
int atomic = 0;
unsigned long long delta = 0;

void *loop(void *arg)
{
	unsigned long long start, now, mhz = 525000000, limit = mhz * SECS,
		min = -1ULL, tmp;
	volatile unsigned int *count, offset = (int)arg;
	int j;

	printf("offset: %u (atomic: %d).\n", offset, atomic);
	count = (void *)count_array + offset;

	if (!arg) {
		for (j = 0; j < 10; j++) {
			limit = mhz/10;
			*count = 0;
			rdtscll(start);
			for (;;) {
				(*count)++;
				rdtscll(now);
				if (now - start > limit)
					break;
			}
			rdtscll(now);
			tmp = (now-start)/(*count);
			if (tmp < min)
				min = tmp;
		}
		printf("delta: %Ld\n", min);
		delta = min;
	} else
		while (!delta)
			usleep(100000);
	limit = mhz*SECS;

repeat:
	*count = 0;
	rdtscll(start);
	if (atomic)
		for (;;) {
			asm ("lock; incl %0" : "=m" (*count) : "m" (*count));
			rdtscll(now);
			if (now - start > limit)
				break;
		}
	else
		for (;;) {
			(*count)++;
			rdtscll(now);
			if (now - start > limit)
				break;
		}
	printf("speed: %Ld loops (%Ld cycles per iteration).\n", (*count)/SECS, (limit/(*count)-delta)); fflush(stdout);
	goto repeat;
}

int main (int argc, char **argv)
{
	unsigned int nr_threads, i, ret, offset = 0;
	pthread_t *t;

	if (argc != 2 && argc != 3 && argc != 4) {
usage:
		printf("usage: loop_print2 <nr threads> [<counter offset>] [<atomic>]\n");
		exit(-1);
	}
	nr_threads = atol(argv[1]);
	if (!nr_threads)
		goto usage;
	t = calloc(nr_threads, sizeof(*t));
	if (argc >= 3)
		offset = atol(argv[2]);
	if (offset < sizeof(unsigned int))
		offset = sizeof(unsigned int);
	atomic = 0;
	if (argc >= 4) {
		atomic = atol(argv[3]);
		printf("a: %d\n", atomic);
	}

	for (i = 1; i < nr_threads; i++) {
		ret = pthread_create (t+i, NULL, loop,
			       	(void *)(i*offset));
		if (ret)
			exit(-1);
	}
	loop((void *)0);

	return 0;
}

--FL5UXtIhxfXey3p5--
