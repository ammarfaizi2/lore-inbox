Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269691AbUJGE67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269691AbUJGE67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUJGE67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:58:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54144 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269691AbUJGE6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:58:48 -0400
Date: Wed, 6 Oct 2004 21:56:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com,
       nickpiggin@yahoo.com.au, roland@redhat.com
Subject: Posix compliant cpu clocks V7 [0/2]: Rationale and test program
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0410062150310.18565@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Posix compliant cpu clocks: V7 [0/3] Rationale and test program

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Changes from V5:
 * add a simple means of accessing other processes cputimers.
 * Simplified glibc patch that makes glibc return errors when
   an applications accesses cputimers and is run with glibc under a kernel
   not providing cputimers. This may allow the detection of applications that
   need to be updated since they depend on the earlier non posix compliant
   version of glibc. Also should be more readable since the sections
   are no longer moved betweeen directory hierachies.
 * remove ability to set process and thread clocks.

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

The patch also implements the access to other the thread and process clocks
of linux processes by using negative clockid's:

1. For CLOCK_PROCESS_CPUTIME_ID: -pid
2. For CLOCK_THREAD_CPUTIME_ID: -(pid + PID_MAX_LIMIT)

This allows

clock_getcpuclockid(pid) to return -pid

and

pthread_getcpuiclock(pid) to return -(pid + PID_MAX_LIMIT)

to allow access to the corresponding clocks.

Todo:
- The timer API to generate events by a non tick based timer is not
  usable in its current state. The posix timer API seems to be only
  useful at this point to define clock_get/set. Need to revise this.
- Implement timed interrupts in mmtimer after API is revised.

The patchset consists of the following components:

[0/2] Contains an explanation as to why these patches are necessary
      as well as a test program and the output of a sample run.

[1/2] Linux Kernel Patch: Implements the two clocks and enhances some
      pieces of the posix-timers implementation in the kernel for these
      clocks and also makes it possible for device drivers to define
      additional clocks.

[2/2] Glibc patch: Use kernel clocks and also makes glibc able to use any
      posix clock provided by the kernel so that posix clocks by driver
      may be accessed. Break apps that use the old cputimer based
      CLOCK_*_CPUTIME_IDs on kernels that do not support CLOCK_*_CPUTIME_ID.

The mmtimer patch is unchanged from V6 and stays as is in 2.6.9-rc3-mm2.
But I expect to update the driver as soon as the interface to setup hardware
timer interrupts is usable.

Rolands patches:
----------------
This patch is not as comprehensive as Rolands but also not as invasive.
Roland's high resolution time through tsc is a hack but would significantly
improve the statistics we get for a process. However, we may get the same
result in a cleaner way after John Stultz and my plan for revising the
time subsystem is through. This would replace jiffies with nanoseconds
for time keeping throughout the kernel.

Nanosecond accuracy is already available through getnstimeofday() on some
platforms. Some of the functionality in Roland's patch may be implemented in a
TSC independent way using this function.

The use of negative pid values in certain numeric ranges for selecting the
type of clock is something that is also in a simplerr way present in
my patch. I do not like this and would rather see this incorporated in
glibc if the glibc people can come up with a sane implementation.

Single Thread Testing
  CLOCK_THREAD_CPUTIME_ID=          0.494140878 resolution= 0.000976563
 CLOCK_PROCESS_CPUTIME_ID=          0.494140878 resolution= 0.000976563
Multi Thread Testing
Starting Thread: 0 1 2 3 4 5 6 7 8 9
 Joining Thread: 0 1 2 3 4 5 6 7 8 9
0 Cycles=      0 Thread=  0.000000000ns Process=  0.495117441ns
1 Cycles=1000000 Thread=  0.140625072ns Process=  2.523438792ns
2 Cycles=2000000 Thread=  0.966797370ns Process=  8.512699671ns
3 Cycles=3000000 Thread=  0.806641038ns Process=  7.561527309ns
4 Cycles=4000000 Thread=  1.865235330ns Process= 12.891608163ns
5 Cycles=5000000 Thread=  1.604493009ns Process= 11.528326215ns
6 Cycles=6000000 Thread=  2.086915131ns Process= 13.500983475ns
7 Cycles=7000000 Thread=  2.245118337ns Process= 13.947272766ns
8 Cycles=8000000 Thread=  1.604493009ns Process= 12.252935961ns
9 Cycles=9000000 Thread=  2.160157356ns Process= 13.977546219ns

Clock status at the end of the timer tests:
          Gettimeofday() = 1097084999.489938000
           CLOCK_REALTIME= 1097084999.490116229 resolution= 0.000000040
          CLOCK_MONOTONIC=        177.071675109 resolution= 0.000000040
 CLOCK_PROCESS_CPUTIME_ID=         13.978522782 resolution= 0.000976563
  CLOCK_THREAD_CPUTIME_ID=          0.497070567 resolution= 0.000976563
          CLOCK_SGI_CYCLE=        229.967982280 resolution= 0.000000040
PROCESS clock of 1 (init)=          4.833986850 resolution= 0.000976563
 THREAD clock of 1 (init)=          0.009765630 resolution= 0.000976563



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
	pr(-1,"PROCESS clock of 1 (init)");
	pr(-1 - 4*1024*1024,"THREAD clock of 1 (init)");
	printf("\n");
}
