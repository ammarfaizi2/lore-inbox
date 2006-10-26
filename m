Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965269AbWJZBoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269AbWJZBoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 21:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbWJZBoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 21:44:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:29577 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965269AbWJZBoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 21:44:02 -0400
Subject: possible pthread_exit/exit glibc problem exposed by -rt kernels
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Sripathi Kodi <sripathik@in.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-z1beEIznbaxOEZUgX9b6"
Date: Wed, 25 Oct 2006 18:43:59 -0700
Message-Id: <1161827040.5478.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-z1beEIznbaxOEZUgX9b6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Ingo,
	Sripathi Kodi and Pat Gallop have been chasing this bug for awhile, but
they've recently managed to make it reproducible w/ a simple test case
(Credits to Pat for distilling the test case down!).

It seems some form of race in the pthread_exit() and exit() code in
glibc is getting exposed by the -rt kernels.

Using the attached test case w/ following commands:
gcc -o term_test ./term_test.c -lpthread
ulimit -c unlimited
ulimit -t unlimited
export MALLOC_CHECK_=2
while true; do ./term_test > /dev/null ;done

Will, after some time, result in a number of core files. The backtrace
of which all look like:

Thread 1:
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7e7e7d5 in raise () from /lib/tls/libc.so.6
#2  0xb7e80149 in abort () from /lib/tls/libc.so.6
#3  0xb7ebd665 in free_check () from /lib/tls/libc.so.6
#4  0xb7eb8e65 in free () from /lib/tls/libc.so.6
#5  0xb7fb5a5d in ___tls_get_addr_internal () from /lib/ld-linux.so.2
#6  0xb7f54c6b in __libc_dl_error_tsd () from /lib/tls/libc.so.6
#7  0xb7fb3045 in _dl_catch_error () from /lib/ld-linux.so.2
#8  0xb7f548be in __libc_dlsym () from /lib/tls/libc.so.6
#9  0xb7f8d2f0 in _Unwind_ForcedUnwind () from /lib/tls/libpthread.so.0
#10 0xb7f8af81 in __pthread_unwind () from /lib/tls/libpthread.so.0
#11 0xb7f86f00 in pthread_exit () from /lib/tls/libpthread.so.0
#12 0x0804865a in thread_worker (arg=0x0) at term_test.c:13
#13 0xb7f86341 in start_thread () from /lib/tls/libpthread.so.0
#14 0xb7f1e6fe in clone () from /lib/tls/libc.so.6

Thread 2:
#0  0xb7f0f890 in write () from /lib/tls/libc.so.6
#1  0xb7eb4d6f in _IO_new_file_write () from /lib/tls/libc.so.6
#2  0xb7eb37cb in _IO_new_do_write () from /lib/tls/libc.so.6
#3  0xb7eb4278 in _IO_new_file_overflow () from /lib/tls/libc.so.6
#4  0xb7eb676b in _IO_flush_all_lockp () from /lib/tls/libc.so.6
#5  0xb7eb6ae0 in _IO_cleanup () from /lib/tls/libc.so.6
#6  0xb7e814b2 in exit () from /lib/tls/libc.so.6
#7  0x0804870b in main () at term_test.c:46

>From Sripathi:
"The thread that crashes is trying to exit (pthread_exit) and in the
process, it accesses one of it's thread local variables. When it tries
to free some memory from it's dtv, free() detects an invalid pointer.
>From my understanding, this memory is accessed only by the thread it
belongs to, hence this cannot be due to any races in the code."

I've been looking at the glibc code trying to see how a double free or
some other memory corruption could occur, but I've made no progress, so
I figured I'd throw it your way for suggestions on hunting this down.

I've reproduced it using a 4 processor system w/ -rt kernels from
2.6.16-rt22 through 2.6.18-rt7 on RHEL4 w/ glibc-2.3.4-2.13. 

I have not been able to reproduce it w/ any non-RT kernel, or w/
CONFIG_REALTIME_PREEMPT disabled.

Your thoughts?

thanks
-john

--=-z1beEIznbaxOEZUgX9b6
Content-Disposition: attachment; filename=term_test.c
Content-Type: text/x-csrc; name=term_test.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <time.h>
#include <pthread.h>
#include <sched.h>

volatile int flagW; /*let worker know to complete */


void *thread_worker(void* arg)
{
	printf("Worker about to signal to main thread\n");
	flagW = 1; 
	pthread_exit(NULL);
}


void create_thread(pthread_t *thread, void*(*func)(void*), int prio)
{
	pthread_attr_t attr;
	struct sched_param param;

	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + prio;

	pthread_attr_init(&attr);
	pthread_attr_setinheritsched (&attr, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedparam(&attr, &param);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

	if (pthread_create(thread, &attr, func, (void *)0)) {
		perror("pthread_create failed");
		exit(99);
	}
	
	pthread_attr_destroy(&attr);
}


int main(void)
{
	pthread_t worker, interrupter;
	
	create_thread(&worker, thread_worker, 10);
	for (;flagW == 0;) { 
		
	}

	return 0;
}

--=-z1beEIznbaxOEZUgX9b6--

