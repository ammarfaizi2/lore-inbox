Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUCDBSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUCDBSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:18:52 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:40589 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261225AbUCDBSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:18:49 -0500
Message-ID: <4046840D.8020200@mech.kuleuven.ac.be>
Date: Thu, 04 Mar 2004 02:19:09 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: thread creation problem
Content-Type: multipart/mixed;
 boundary="------------030504010904050302050803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030504010904050302050803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Creating a thread and afterwards changing the priority and policy does 
work. But setting the priority and policy when creating a thread doesn't 
seem to work any more on 2.6.x/NPTL systems.

After invoking the following:
pthread_attr_init
pthread_attr_setschedpolicy FIFO
pthread_attr_setschedparam 99
pthread_create

The output of pthread_getschedparam within this thread seemed strange to me:

./thr_prio_basic
max priority 99
policy: 0 priority: 0
thread succesfully created

LD_ASSUME_KERNEL=2.4.1  ./thr_prio_basic
max priority 99
policy: 1 priority: 99
thread succesfully created

Is it because of stricter POSIX compliance of NPTL?

Using ltrace and strace didn't really make it clear to me what is going 
wrong here.
In the LinuxThread case, I could clearly see the cloning happening and 
afterwards the calls to "sched_setscheduler". In the NPTL case, there is 
just a call to clone with more params. No calls to change scheduler 
params. Does one of the params  contain the scheduler options? If not, 
how is the kernel supposed to get that information?

I really don't understand why this is happing, any explanation is 
greatly appreciated.

With friendly regards,
Takis

PS: I wasn't sure if I should ask this on the glibc mailinglist or this 
mailinglist. My apologies if this is off-topic.

--------------030504010904050302050803
Content-Type: text/x-c;
 name="thr_prio_basic.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thr_prio_basic.c"

#include <string.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

void* foo( void*p )
{
    int policy;
    struct sched_param param;
    if ( pthread_getschedparam( pthread_self(), &policy, &param ) == 0 )
        printf( "policy: %d priority: %d\n", policy, param.sched_priority );
}

int main()
{
    pthread_t p;
    struct sched_param param;
    pthread_attr_t attr;
    memset( &param, 0, sizeof( param ) );
    param.sched_priority = sched_get_priority_max( SCHED_FIFO );
#if 0
    if ( sched_setscheduler( 0, SCHED_FIFO, &param ) == 0 )
        printf( "succesfully selected FIFO scheduler\n" );
#endif
    printf( "max priority %d\n", param.sched_priority );
    if ( pthread_attr_init( &attr ) )
        printf( "problem attr init\n" );
    if ( pthread_attr_setschedpolicy( &attr, SCHED_FIFO ) )
        printf( "problem setschedpolicy\n" );
    pthread_attr_setscope( &attr, PTHREAD_SCOPE_SYSTEM );
    if ( pthread_attr_setschedparam( &attr, &param ) )
        printf( "problem setschedparam\n" );
    if ( pthread_create( &p, &attr, foo, 0 ) == 0 )
        printf( "thread succesfully created\n" );
    else
        printf( "problem creating thread\n" );
    pthread_attr_destroy( &attr );
    usleep( 1000000UL );
}

--------------030504010904050302050803--
