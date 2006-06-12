Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWFLIKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWFLIKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWFLIKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:10:40 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:1649 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1750716AbWFLIKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:10:39 -0400
Date: Mon, 12 Jun 2006 17:10:35 +0900 (JST)
Message-Id: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Subject: NPTL mutex and the scheduling priority
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a copy of message posted libc-alpha ML.  I want to hear from
# kernel people too ...

Hi.  I found that it seems NPTL's mutex does not follow the scheduling
parameter.  If some threads were blocked by getting a single
mutex_lock, I expect that a thread with highest priority got the lock
first, but current NPTL's behaviour is different.

Here is a sample program.  This creates four FIFO-class thread with
different priorities and these threads try to get a same mutex.

--- foo.c ---
#include <stdio.h>
#include <pthread.h>
#include <time.h>

static pthread_mutex_t mutex;
static volatile int val;

static void *thread_func(void *arg)
{
	int v;
	pthread_mutex_lock(&mutex);
	v = val++;
	pthread_mutex_unlock(&mutex);
	printf("thread-%ld got %d\n", (long)arg, v);
	return NULL;
}

int main(int argc, char **argv)
{
	struct sched_param param;
	struct timespec ts;
	pthread_t tid[4];
	pthread_attr_t attr;
	int i;

#if 0
	int policy;
	pthread_getschedparam(pthread_self(), &policy, &param);
	policy = SCHED_FIFO;
	param.sched_priority = 99;
	pthread_setschedparam(pthread_self(), policy, &param);
#endif

	pthread_mutex_init(&mutex, NULL);
	pthread_mutex_lock(&mutex);
	pthread_attr_init(&attr);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
	pthread_attr_getschedparam(&attr, &param);
	pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
	for (i = 0; i < sizeof(tid) / sizeof(tid[0]); i++) {
		param.sched_priority = 50 + i * 10;
		pthread_attr_setschedparam(&attr, &param);
		pthread_create(&tid[i], &attr, thread_func, (void *)i);
		printf("thread-%d pri %d\n", i, param.sched_priority);
	}
	
	ts.tv_sec = 3;
	ts.tv_nsec = 0;
	nanosleep(&ts, NULL);

	val++;
	pthread_mutex_unlock(&mutex);

	for (i = 0; i < sizeof(tid) / sizeof(tid[0]); i++)
		pthread_join(tid[i], NULL);
	return 0;
}
--- foo.c ---

I thought a thread with highest priority (thread-3) will get the
mutex first, so I expected:

thread-0 pri 50
thread-1 pri 60
thread-2 pri 70
thread-3 pri 80
thread-3 got 1
thread-2 got 2
thread-1 got 3
thread-0 got 4

but with NPTL (glibc 2.4, kernel 2.6.16, mips/i386) I got:

thread-0 pri 50
thread-1 pri 60
thread-2 pri 70
thread-3 pri 80
thread-3 got 4
thread-2 got 3
thread-1 got 2
thread-0 got 1

I can get the expected result with linuxthreads (glibc 2.3.6).

I also found that I can get expected result with NPTL if I enabled the
"#if 0" block in the sample program.

Is this glibc/NPTL issue, or kernel/futex issue?  (or my expectation
is wrong?)

---
Atsushi Nemoto
