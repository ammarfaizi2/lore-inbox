Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUJAUBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUJAUBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUJAUAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:00:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31140 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266304AbUJAT7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:59:21 -0400
Date: Fri, 1 Oct 2004 12:57:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Posix compliant cpu clocks V6 [0/3]: Rationale and test program
In-Reply-To: <415AF4C3.1040808@mvista.com>
Message-ID: <Pine.LNX.4.58.0410011255350.18738@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Changes from V5: Add glibc patch, mmtimer patch, error checking.

POSIX clocks are to be implemented in the following way according
to V3 of the Single Unix Specification:

1. CLOCK_PROCESS_CPUTIME_ID

  Implementations shall also support the special clockid_t value
  CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
  calling process when invoking one of the clock_*() or timer_*()
  functions. For these clock IDs, the values returned by clock_gettime() and
  specified by clock_settime() represent the amount of execution time of the
  process associated with the clock.

2. CLOCK_THREAD_CPUTIME_ID

  Implementations shall also support the special clockid_t value
  CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the
  calling thread when invoking one of the clock_*() or timer_*()
  functions. For these clock IDs, the values returned by clock_gettime()
  and specified by clock_settime() shall represent the amount of
  execution time of the thread associated with the clock.

These times mentioned are CPU processing times and not the time that has
passed since the startup of a process. Glibc currently provides its own
implementation of these two clocks which is designed to return the time
that passed since the startup of a process or a thread.

Moreover Glibc's clocks are bound to CPU timers which is problematic when the
frequency of the clock changes or the process is moved to a different
processor whose cpu timer may not be fully synchronized to the cpu timer
of the current CPU. This patchset results in a both clocks working reliably.

The patchset consists of the following components:

[0/3] Contains an explanation as to why these patches are necessary
      as well as a test program and the output of a sample run.

[1/3] Linux Kernel Patch: Implements the two clocks and enhances some
      pieces of the posix-timers implementation in the kernel for these
      clocks and also makes it possible for device drivers to define
      additional clocks.

[2/3] Glibc patch: Makes glibc not provide its own clocks if the kernel
      provides them and also makes glibc able to use any posix clock provided
      by the kernel so that posix clocks by driver may be accessed.

[3/3] Kernel patch for mmtimer. Sets up a posix clock CLOCK_SGI_CYCLE
      that can currently only provide time but the clock will be used in the
      future to generate signals using timer_create and friends.

Test program output
==================

Single Thread Testing
  CLOCK_THREAD_CPUTIME_ID=          0.495117441 resolution= 0.000976563
 CLOCK_PROCESS_CPUTIME_ID=         32.496110388 resolution= 0.000976563
Multi Thread Testing
Starting Thread: 0 1 2 3 4 5 6 7 8 9
 Joining Thread: 0 1 2 3 4 5 6 7 8 9
0 Cycles=      0 Thread=  0.000000000ns Process=  0.000976563ns
1 Cycles=1000000 Thread=  1.368164763ns Process= 11.063482227ns
2 Cycles=2000000 Thread=  0.748047258ns Process=  6.340823559ns
3 Cycles=3000000 Thread=  0.672851907ns Process=  5.271487074ns
4 Cycles=4000000 Thread=  1.352539755ns Process= 10.551763215ns
5 Cycles=5000000 Thread=  2.007813528ns Process= 13.094733267ns
6 Cycles=6000000 Thread=  1.479492945ns Process= 12.622076775ns
7 Cycles=7000000 Thread=  1.733399325ns Process= 12.136724964ns
8 Cycles=8000000 Thread=  2.012696343ns Process= 13.690436697ns
9 Cycles=9000000 Thread=  2.331055881ns Process= 13.708991394ns

Clock status at the end of the timer tests:
          Gettimeofday() = 1096659625.612416000
           CLOCK_REALTIME= 1096659625.612603129 resolution= 0.000000040
          CLOCK_MONOTONIC=       9024.882157828 resolution= 0.000000040
 CLOCK_PROCESS_CPUTIME_ID=         13.709967957 resolution= 0.000976563
  CLOCK_THREAD_CPUTIME_ID=          0.498047130 resolution= 0.000976563
          CLOCK_SGI_CYCLE=       9077.595920640 resolution= 0.000000040


Test program
============

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>
#include <asm/unistd.h>
#include <pthread.h>

#define clock_getres(x,y) syscall(__NR_clock_getres, x,y)
#define clock_gettime(x,y) syscall(__NR_clock_gettime, x, y)
#define clock_settime(x,y) syscall(__NR_clock_settime, x, y)

void pr(int clock,const char *n)
{
	struct timespec tv = {1,2};
	struct timespec res = {3,4};
	int rc;


	rc=clock_getres(clock,&res);
	if (rc) {
		printf("getres return code on %s=%d errno=%d\n",n,rc,errno);
	}
	rc=clock_gettime(clock,&tv);
	if (rc) {
		printf("gettime return code on %s=%d errno=%d\n",n,rc, errno);
	}
	else
	printf("%25s=% 11d.%09d resolution=% 2d.%09d\n",n,tv.tv_sec,tv.tv_nsec,res.tv_sec,res.tv_nsec);
}

int y;

void kx(long long x) {
	y=x;
};

struct timespec zero;

pthread_t thread[10];

struct tinfo {
	int i;
	struct timespec ttime,ptime;
} tinf[10];

void *thread_function(void *x) {
	struct tinfo *t=x;
	int i;

	for(i=1;i< t->i;i++) kx(1000000000000LL/i);
	clock_gettime(CLOCK_THREAD_CPUTIME_ID,&t->ttime);
	clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t->ptime);
}

int main(char argc, char *argv[])
{
	struct timespec tv;
	int i;

	/* Waste some time */
	printf("Single Thread Testing\n");

	for(i=1;i<10000000;i++) kx(1000000000000LL/i);
	pr(CLOCK_THREAD_CPUTIME_ID,"CLOCK_THREAD_CPUTIME_ID");
	pr(CLOCK_PROCESS_CPUTIME_ID,"CLOCK_PROCESS_CPUTIME_ID");
	/* Waste some more time in threads */
	printf("Multi Thread Testing\nStarting Thread:");
	clock_settime(CLOCK_PROCESS_CPUTIME_ID,&zero);
	for(i=0;i<10;i++) {
		tinf[i].i=i*1000000;
		if (pthread_create(&thread[i], NULL, thread_function, tinf+i))
			perror("thread");
		else
			printf(" %d",i);
	}
	printf("\n Joining Thread:");
	for(i=0;i<10;i++) if (pthread_join( thread[i], NULL)) perror("join"); else printf(" %d",i);
	printf("\n");
	for(i=0;i<10;i++) {
		printf("%d Cycles=%7d Thread=% 3d.%09dns Process=% 3d.%09dns\n",i,tinf[i].i,tinf[i].ttime.tv_sec,tinf[i].ttime.tv_nsec,tinf[i].ptime.tv_sec,tinf[i].ptime.tv_nsec);
	}
	gettimeofday((struct timeval *)&tv);
	tv.tv_nsec = tv.tv_nsec*1000;
	printf("\nClock status at the end of the timer tests:\n");
	printf("          Gettimeofday() =% 11d.%09d\n",tv.tv_sec,tv.tv_nsec);
	pr(CLOCK_REALTIME,"CLOCK_REALTIME");
	pr(CLOCK_MONOTONIC,"CLOCK_MONOTONIC");
	pr(CLOCK_PROCESS_CPUTIME_ID,"CLOCK_PROCESS_CPUTIME_ID");
	pr(CLOCK_THREAD_CPUTIME_ID,"CLOCK_THREAD_CPUTIME_ID");
	pr(10,"CLOCK_SGI_CYCLE");
	printf("\n");
}
