Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTEENAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTEENAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:00:48 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:38043 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262170AbTEENAq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:00:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BUG] problem with timer_create(2) for SIGEV_NONE ??
Date: Mon, 5 May 2003 18:43:00 +0530
Message-ID: <E935C89216CC5D4AB77D89B253ADED2A92257F@blr-m2-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] problem with timer_create(2) for SIGEV_NONE ??
Thread-Index: AcMTCA0QRg2fqNSKRTCgKFXEWtHpyA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: "george anzinger" <george@mvista.com>, <linux-kernel@vger.kernel.org>
Cc: "Chandrashekhar RS" <chandra.smurthy@wipro.com>
X-OriginalArrivalTime: 05 May 2003 13:13:01.0560 (UTC) FILETIME=[0E361F80:01C31308]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George,

 timer_create(2) fails in the case where sigev_notify parameter of
sigevent structure is SIGEV_NONE. I believe this should not happen.

Consider following code which was run on x86:

#include <stdio.h>
#include <syscall.h>
#include <errno.h>
#include <time.h>
#include <signal.h>

#define ANYSIG SIGALRM  /* Any signal value works*/

#ifndef __NR_timer_create
#if defined(__i386__)
#define __NR_timer_create 259
#elif defined(__ppc__)
#define __NR_timer_create 240
#elif defined(__powerpc64__)
#define __NR_timer_create 240
#elif defined(__x86_64__)
#define __NR_timer_create 222
#endif
#endif

_syscall3(int, timer_create, clockid_t, which_clock, struct sigevent *,
        timer_event_spec, timer_t *, created_timer_id);

 int main(int ac, char **av)
{
	timer_t created_timer_id;     /* holds the returned timer_id*/
	struct sigevent evp;
	int retval;

	evp.sigev_value =  (sigval_t) 0;
	evp.sigev_signo = ANYSIG;
	evp.sigev_notify = SIGEV_NONE;

	retval =	timer_create(CLOCK_REALTIME, &evp,
                                                &created_timer_id);

	if (retval < 0) {
		perror("timer_crete");
		printf("timer_create returned %d\n", retval); 
	} else {
		printf("timer_create success");
	}
	return 0;
}  /* End of main */

My analysis of this problem:

Kernel/include/asm-generic/siginfo.h contains following defintions

#define SIGEV_SIGNAL    0       /* notify via signal */
#define SIGEV_NONE      1       /* other notification: meaningless */
#define SIGEV_THREAD    2       /* deliver via thread creation */
#define SIGEV_THREAD_ID 4       /* deliver to thread */

In 2.5.68/kernel/posix-timers.c

Line 86:
MIPS_SEGV = ~(SIGEV_NONE & \
                      SIGEV_SIGNAL & \
                      SIGEV_THREAD &  \
                      SIGEV_THREAD_ID)
= (001 & 000 & 010 & 100) = ~(000) = 111

Line 364: in good_sigevent()
Lets assume that event->sigev_notify = SIGEV_NONE = 001
 
Line 368:
SIGEV_NONE & SIGEV_THREAD_ID = 001 & 100 = 000. Therefore the if
statement becomes false
 
Line 373:
SIGEV_NONE & SIGEV_SIGNAL = 001 & 000 = 000. Therefore the if statement
is false
 
Line 377:
SIGEV_NONE & ~(SIGEV_SIGNAL | SIGEV_THREAD_ID)
= 001 & ~(000 | 100)
= 001 & ~(100)
= 001 & 011
= 001
therefore the if condition is true
therefore the function returns NULL from line 378.
 
Now in sys_timer_create() at line number 462
Process = NULL
 
Now at line 489
if (!process) becomes TRUE
and function returns with EINVAL

Is my analysis right? If so can you comment on this behaviour?

-Aniruddha
