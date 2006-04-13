Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWDMHlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWDMHlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWDMHlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:41:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:47076 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964821AbWDMHlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:41:05 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <1144681009.8493.17.camel@homer>
References: <1144402690.7857.31.camel@homer>
	 <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer>
	 <200604072356.03580.kernel@kolivas.org> <1144419294.14231.7.camel@homer>
	 <20060409111436.GA26533@outpost.ds9a.nl> <1144582778.13991.10.camel@homer>
	 <20060409121436.GA28075@outpost.ds9a.nl> <1144606061.7408.14.camel@homer>
	 <20060410091248.GA32468@outpost.ds9a.nl>  <1144663242.8040.27.camel@homer>
	 <1144681009.8493.17.camel@homer>
Content-Type: multipart/mixed; boundary="=-PKZLkQ32ITz8HQNWJ8V2"
Date: Thu, 13 Apr 2006 09:41:01 +0200
Message-Id: <1144914061.9352.25.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PKZLkQ32ITz8HQNWJ8V2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-04-10 at 16:56 +0200, Mike Galbraith wrote:
> On Mon, 2006-04-10 at 12:00 +0200, Mike Galbraith wrote:
> > You may not like the testcase, but it remains a bug exposing testcase.
> 
> That proposed change just became moot.  Changing to pulling a 16k file
> instead of the 20k directory makes it unmanageable with that change,
> with it completely disabled, and even with a full throttling tree.
> 
> Oh well, I wanted to try run limiting queues anyway I guess (sigh).

Something like below?

This way also allowed me to eliminate the interactive agony of an array
switch when at 100% cpu.  Seems to work well.  No more agony, only tiny
pin pricks.

Anyway, interested readers will find a copy of irman2.c, which is nice
for testing interactive starvation, attached.   The effect is most
noticeable with something like bonnie, which otherwise has zero chance
against irman2.  Just about anything will do though.  Trying to fire up
Amarok is good for a chuckle.  Whatever.  (if anyone plays with irman2
on 2.6.16 or below, call it with -S 1)

	-Mike

--- linux-2.6.17-rc1x/kernel/sched.c.org	2006-04-07 08:52:47.000000000 +0200
+++ linux-2.6.17-rc1x/kernel/sched.c	2006-04-13 09:03:28.000000000 +0200
@@ -2578,6 +2578,52 @@ void account_steal_time(struct task_stru
 		cpustat->steal = cputime64_add(cpustat->steal, tmp);
 }
 
+#define TASK_LATENCY(p, nr_running) \
+	JIFFIES_TO_NS(SCALE(USER_PRIO(p->prio), 39, nr_running * \
+	DEF_TIMESLICE + STARVATION_LIMIT))
+
+static inline void requeue_starving(runqueue_t *rq, unsigned long long now)
+{
+	prio_array_t *array = rq->active;
+	unsigned long *bitmap = array->bitmap;
+	int prio = rq->curr->prio, idx = prio + 1;
+	int noninteractive = 0, nr_running = rq->active->nr_active;
+
+repeat:
+	while ((idx = find_next_bit(bitmap, MAX_PRIO, idx)) < MAX_PRIO) {
+		struct list_head *queue = array->queue + idx;
+		task_t *p = list_entry(queue->next, task_t, run_list);
+		unsigned long latency = TASK_LATENCY(p, nr_running);
+
+		if (!TASK_INTERACTIVE(p))
+			noninteractive = idx;
+
+		if (!batch_task(p) && p->timestamp + latency < now) {
+			dequeue_task(p, p->array);
+			if (p->array == rq->active && p->prio > prio)
+				p->prio = prio;
+			enqueue_task(p, rq->active);
+
+			if (array == rq->expired) {
+				int idx = find_next_bit(bitmap, MAX_PRIO, 0);
+				rq->best_expired_prio = idx;
+				if (idx == MAX_PRIO)
+					rq->expired_timestamp = 0;
+			} else return;
+		}
+		idx++;
+	}
+	if (rq->expired_timestamp && array == rq->active &&
+			(!noninteractive || EXPIRED_STARVING(rq))) {
+		array = rq->expired;
+		bitmap = array->bitmap;
+		nr_running = rq->nr_running;
+		idx = 0;
+		goto repeat;
+	}
+
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -2632,6 +2678,11 @@ void scheduler_tick(void)
 		goto out_unlock;
 	}
 	if (!--p->time_slice) {
+		/*
+		 * Slip starving tasks into the stream.
+		 */
+		if (rq->nr_running > 1)
+			requeue_starving(rq, now);
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
@@ -2640,7 +2691,7 @@ void scheduler_tick(void)
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		if (!TASK_INTERACTIVE(p)) {
 			enqueue_task(p, rq->expired);
 			if (p->static_prio < rq->best_expired_prio)
 				rq->best_expired_prio = p->static_prio;
@@ -2935,9 +2986,12 @@ need_resched_nonpreemptible:
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
 	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
+		int active = rq->active->nr_active;
 		run_time = now - prev->timestamp;
 		if (unlikely((long long)(now - prev->timestamp) < 0))
 			run_time = 0;
+		else if (active > 1)
+			run_time *= min(active, 1 + MAX_BONUS);
 	} else
 		run_time = NS_MAX_SLEEP_AVG;
 
@@ -2945,7 +2999,7 @@ need_resched_nonpreemptible:
 	 * Tasks charged proportionately less run_time at high sleep_avg to
 	 * delay them losing their interactive status
 	 */
-	run_time /= (CURRENT_BONUS(prev) ? : 1);
+	run_time /= 1 + CURRENT_BONUS(prev);
 
 	spin_lock_irq(&rq->lock);
 
@@ -3012,18 +3066,24 @@ go_idle:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
+	if (!rt_task(next) && interactive_sleep(next->sleep_type) &&
+			rq->nr_running < 1 + MAX_BONUS - CURRENT_BONUS(next)) {
 		unsigned long long delta = now - next->timestamp;
+		unsigned long max_delta;
 		if (unlikely((long long)(now - next->timestamp) < 0))
 			delta = 0;
 
 		if (next->sleep_type == SLEEP_INTERACTIVE)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
+		max_delta = (1 + MAX_BONUS - CURRENT_BONUS(next)) * GRANULARITY;
+		max_delta = JIFFIES_TO_NS(max_delta);
+		if (delta > max_delta)
+			delta = max_delta;
 		array = next->array;
 		new_prio = recalc_task_prio(next, next->timestamp + delta);
 
-		if (unlikely(next->prio != new_prio)) {
+		if (unlikely(next->prio > new_prio)) {
 			dequeue_task(next, array);
 			next->prio = new_prio;
 			enqueue_task(next, array);


--=-PKZLkQ32ITz8HQNWJ8V2
Content-Disposition: attachment; filename=irman2.c
Content-Type: text/x-csrc; name=irman2.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

/*
 *  irman by Davide Libenzi ( irman load generator )
 *  Copyright (C) 2003  Davide Libenzi
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  Davide Libenzi <davidel@xmailserver.org>
 *
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <sys/signal.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>


#define BUFSIZE (1024 * 32)


static int *pipes, *child;
static int num_pipes, num_active, num_child, use_socket;
static unsigned long burn_ms;
static char buf1[BUFSIZE], buf2[BUFSIZE];
static volatile sig_atomic_t run = 1;
pid_t parent;

static void signal_all(int signum) {
	if (getpid() == parent) {
		while (num_child >= 0) {
			kill(child[num_child], SIGKILL);
			num_child--;
		}
		exit(0);
	} else if (signum == SIGKILL || getppid() == 1)
		run = 0;
}

unsigned long long getustime(void) {
	struct timeval tm;

	gettimeofday(&tm, NULL);
	return (unsigned long long) tm.tv_sec * 1000ULL + (unsigned long long) tm.tv_usec / 1000ULL;
}


int burn_ms_cpu(unsigned long ms) {
	int i, cmp = 0;
	unsigned long long ts;

	ts = getustime();
	do {
		for (i = 0; i < 4; i++)
			cmp += memcmp(buf1, buf2, BUFSIZE);
	} while (ts + ms > getustime());
	return cmp;
}


pid_t hog_process(void) {
	pid_t pid;

	if (!(pid = fork())) {
		while (run) {
			printf("HOG running %u\n", time(NULL));
			burn_ms_cpu(burn_ms);
		}
		exit(0);
	}
	return pid;
}


pid_t irman_process(int n) {
	int nn;
	pid_t pid;
	u_char ch;

	if (!(pid = fork())) {
		if ((nn = n + num_active) >= num_pipes)
			nn -= num_pipes;
		while (run) {
			printf("reading %u\n", n);
			read(pipes[2 * n], &ch, 1);
			burn_ms_cpu(burn_ms);
			printf("writing %u\n", nn);
			write(pipes[2 * nn + 1], "s", 1);
		}
		exit(0);
	}
	return pid;
}

int main (int argc, char **argv) {
	struct rlimit rl;
	int i, c;
	long work;
	int *cp, run_secs = 0;
	extern char *optarg;
	struct sigaction action;

	parent = getpid();
	num_pipes = 40;
	num_active = 1;
	burn_ms = 300;
	use_socket = 0;
	while ((c = getopt(argc, argv, "n:b:a:s:S:")) != -1) {
		switch (c) {
		case 'n':
			num_pipes = atoi(optarg);
			break;
		case 'b':
			burn_ms = atoi(optarg);
			break;
		case 'a':
			num_active = atoi(optarg);
			break;
		case 's':
			run_secs = 1 + atoi(optarg);
			break;
		case 'S':
			use_socket = 1;
			break;
		default:
			fprintf(stderr, "Illegal argument \"%c\"\n", c);
			exit(1);
		}
	}

	rl.rlim_cur = rl.rlim_max = num_pipes * 2 + 50;
	if (setrlimit(RLIMIT_NOFILE, &rl) == -1) {
		perror("setrlimit"); 
		exit(1);
	}

	pipes = calloc(num_pipes * 2, sizeof(int));
	if (pipes == NULL) {
		perror("malloc");
		exit(1);
	}

	child = calloc(num_pipes, sizeof(int));
	if (child == NULL) {
		perror("malloc");
		exit(1);
	}

	for (cp = pipes, i = 0; i < num_pipes; i++, cp += 2) {
		if (!use_socket) {
			if(pipe(cp) == -1) {
				perror("pipe");
				exit(1);
			}
		} else if (socketpair(AF_UNIX, SOCK_STREAM, 0, cp) == -1) {
			perror("socketpair");
			exit(1);
		}
	}

	memset(buf1, 'f', sizeof(buf1));
	memset(buf2, 'f', sizeof(buf2));

	sigemptyset(&action.sa_mask);
	/* establish termination handler */
	action.sa_handler = signal_all;
	action.sa_flags = SA_NODEFER;
	if (sigaction(SIGTERM, &action, NULL) == -1) {
		perror("Could not install signal handler");
		exit(1);
	}

	for (i = 0; i < num_pipes; i++)
		child[i] = irman_process(i);

	child[i] = hog_process();
	num_child = i;

	for (i = 0; i < num_active; i++)
		write(pipes[2 * i + 1], "s", 1);

	while (--run_secs)
		sleep(1);
	signal_all(SIGKILL);
	exit(0);
}


--=-PKZLkQ32ITz8HQNWJ8V2--

