Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWGMG3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWGMG3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWGMG3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:29:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:54256 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932563AbWGMG3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:29:09 -0400
Message-ID: <44B5E833.6000808@free.fr>
Date: Thu, 13 Jul 2006 08:29:07 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Thunderbird 1.5 (Macintosh/20051025)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Scheduling parameters of a process and its main thread
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

When a process only has one thread, I would expect that sched_get* and 
pthread_getschedparam return equivalent priorities.

But in the example below, it's not the case.
What I do:
- print priorities
- give RT priority to the process
- print priorities
- give RT priority to the thread
- print priorities

1. Process 3938 : policy=0 prio=0
1. Thread 1075147872 : policy=0  prio=0

2.  Process 3938 : policy=1 prio=20
2.  Thread 1075147872 : policy=0  prio=0

3.  Process 3938 : policy=1 prio=30
3.  Thread 1075147872 : policy=1  prio=30

As you can see, at the step to, the process and the thread don't have 
the same parameters.
Is that normal?



#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <pthread.h>

/* gcc schedparam.c -o schedparam -Wall -pthread */

int print_process_sched(pid_t pid) {
   struct sched_param param;
   int prio;
   int policy;

   policy = sched_getscheduler(pid);

   sched_getparam(pid,&param);
   prio = param.sched_priority;

   printf("Process %d : policy=%d prio=%d\n",(int)pid, policy,prio);

   return 0;
}

int utilities_print_thread_sched(pthread_t id) {
   struct sched_param param;
   int policy;
   int prio;
   unsigned long int lid = id;

   if ( pthread_getschedparam(id, &policy, &param) ) {
     perror("pthread_getschedparam()"); return 1;
   }

   prio = param.sched_priority;

   printf("Thread %ld : policy=%d  prio=%d\n", (long)lid, policy,prio);

   return 0;
}

int main(void ) {

   struct sched_param p;

   printf("1. "); print_process_sched(getpid());
   printf("1. "); utilities_print_thread_sched(pthread_self());

   p.sched_priority = 20;
   if ( sched_setscheduler(getpid(),SCHED_FIFO,&p) ) {
     perror("sched_setscheduler()");
     return 1;
   }

   printf("2.  "); print_process_sched(getpid());
   printf("2.  "); utilities_print_thread_sched(pthread_self());

   p.sched_priority = 30;
   if ( pthread_setschedparam(pthread_self(),SCHED_FIFO,&p) ) {
     perror("sched_setscheduler()");
     return 1;
   }

   printf("3.  "); print_process_sched(getpid());
   printf("3.  "); utilities_print_thread_sched(pthread_self());

   return 0;
}
