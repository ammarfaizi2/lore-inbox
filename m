Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUHXOja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUHXOja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUHXOja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:39:30 -0400
Received: from mailsc1.simcon-mt.com ([195.27.129.236]:18207 "EHLO
	mailsc1.simcon-mt.com") by vger.kernel.org with ESMTP
	id S267890AbUHXOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:39:10 -0400
Date: Tue, 24 Aug 2004 16:42:41 +0200
From: Andrei Voropaev <avorop@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: with 2.6.7 setitimer called in sequence returns strange values on i686
Message-ID: <20040824144241.GE1527@avorop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Sorry if I'm taking your time away but to me it looks like I have kernel
problem, so I hoped to find some help in this list. I'm not subscribed
so please CC me on replies.

I'm using setitimer(ITIMER_REAL...) to measure time intervals.
Everything was working fine untill I've installed 2.6.7 kernel. 

bash$ uname -a
Linux avorop 2.6.7 #5 Thu Aug 19 11:53:33 CEST 2004 i686 unknown

Here's little piece of code that reproduces problem on my machine.

===========================================
#include <pthread.h>
#include <stdio.h>
#include <sys/time.h>
#include <stdlib.h>
#include <errno.h>
#include <error.h>
#include <time.h>

void
set_timer(int arg)
{
    struct itimerval n, o;
    struct timespec per;

    n.it_interval.tv_sec = 0;
    n.it_interval.tv_usec = 0;
    n.it_value.tv_sec = arg;
    n.it_value.tv_usec = 0;
    // init timer
    if(setitimer(ITIMER_REAL, &n, &o) != 0) 
       error(EXIT_FAILURE, errno, "Can't set timer");
    printf("Previous value of %d timer is %ld.%ld\n", arg, 
            o.it_value.tv_sec, o.it_value.tv_usec);
    per.tv_sec = arg / 2;
    per.tv_nsec = 0;
    // sleep for half a timer time
    nanosleep(&per, NULL);
    n.it_value.tv_sec = arg;
    n.it_value.tv_usec = 0;
    // check how much time is left and restart it at the same time
    if(setitimer(ITIMER_REAL, &n, &o) != 0) 
       error(EXIT_FAILURE, errno, "Can't set timer");
    printf("Previous value of %d timer is %ld.%ld\n", arg, 
             o.it_value.tv_sec, o.it_value.tv_usec);
    n.it_value.tv_sec = 0;
    n.it_value.tv_usec = 0;
    // check how much time is left. 
    if(setitimer(ITIMER_REAL, &n, &o) != 0) 
        error(EXIT_FAILURE, errno, "Can't set timer");
    printf("Previous value of %d timer is %ld.%ld\n", arg, 
        o.it_value.tv_sec, o.it_value.tv_usec);
}

int
main(void)
{
    pthread_t thr1, thr2;

    pthread_create(&thr1, NULL, (void*)set_timer, (void*)10);
//    pthread_create(&thr2, NULL, (void*)set_timer, (void*)12);

    pthread_join(thr1, NULL);
    pthread_join(thr2, NULL);
    return 0;
}
======================================================
On my machine this program produces

Previous value of 10 timer is 0.0
Previous value of 10 timer is 4.999240
Previous value of 10 timer is 10.479

Note the last line. I've reset timer to 10 seconds and setitimer tells
me that there are 10.479 seconds left.

As I said this code works fine with 2.4.21 kernel. It produces 
Previous value of 10 timer is 0.0
Previous value of 10 timer is 4.980000
Previous value of 10 timer is 10.0

I have one more machine with 2.6.7 kernel. But that machine is Athlon64
and runs 64-bit kernel. There the program also runs correctly.

Any hints on where to look for the problem?

TIA.

Andrei
