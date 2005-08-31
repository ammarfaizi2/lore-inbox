Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVHaPCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVHaPCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVHaPCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:02:46 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:28827 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932349AbVHaPCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:02:45 -0400
Subject: [FYI] 2.6.13-rt3  and a nanosleep jitter test.
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1125417156.6355.13.camel@localhost.localdomain>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
	 <1125000563.6264.10.camel@localhost.localdomain>
	 <1125023010.5365.4.camel@localhost.localdomain>
	 <1125064334.5365.39.camel@localhost.localdomain>
	 <1125414039.5675.42.camel@localhost.localdomain>
	 <1125417156.6355.13.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-cc6amToJC5oBe62cFoNI"
Organization: Kihon Technologies
Date: Wed, 31 Aug 2005 11:01:54 -0400
Message-Id: <1125500514.5714.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cc6amToJC5oBe62cFoNI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thomas,

I just was wondering how the HR Timers were in the latest -rtX patch and
wrote my own little jitter test using nanosleep.  Here's the results:

On vanilla 2.6.13-rc7-git1  (Yes I need to get over to 2.6.13)

# ./jitter
starting calibrate
finished calibrate: 2133.9060MHz 2133906034
time slept: 0.010000000 sec: 0 nsec: 10000000
max: 0.011997701
min: 0.011890522
avg: 0.011993485
greatest time over: 1997.701 usecs
never ran under (good!)
average time over: 1993.485 usecs

On 2.6.13-rt3:

# ./jitter
starting calibrate
finished calibrate: 2133.2960MHz 2133295991
time slept: 0.010000000 sec: 0 nsec: 10000000
max: 0.010034857
min: 0.010006309
avg: 0.010009213
greatest time over: 34.857 usecs
never ran under (good!)
average time over: 9.213 usecs


Not bad.  I then ran a clean kernel compile as root with a -j3 (this is
an 2x SMP machine), and tried the test again.

# ./jitter
starting calibrate
finished calibrate: 2133.3005MHz 2133300491
time slept: 0.010000000 sec: 0 nsec: 10000000
max: 0.010044836
min: 0.010014244
avg: 0.010030741
greatest time over: 44.836 usecs
never ran under (good!)
average time over: 30.741 usecs


Since the ticks per second is also calculated here, I ran it again using
the calibration of the first run (still running that make):

./jitter -c 2133295991
passed in calibrate: 2133.2960MHz 2133295991
time slept: 0.010000000 sec: 0 nsec: 10000000
max: 0.010051293
min: 0.010012155
avg: 0.010030237
greatest time over: 51.293 usecs
never ran under (good!)
average time over: 30.237 usecs

And once more using the calibration found by 2.6.13-rc7-git1 (still
running that make):

# ./jitter -c 2133906034
passed in calibrate: 2133.9060MHz 2133906034
time slept: 0.010000000 sec: 0 nsec: 10000000
max: 0.010058339
min: 0.010016418
avg: 0.010025571
greatest time over: 58.339 usecs
never ran under (good!)
average time over: 25.571 usecs


Some info on my machine:

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) MP 2800+
stepping        : 0
cpu MHz         : 2133.286
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 4259.84

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) Processor
stepping        : 0
cpu MHz         : 2133.286
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 4259.84

And attached is the jitter.c test. Must be run as root since it ups the
priority to the max.

Have fun,

-- Steve


--=-cc6amToJC5oBe62cFoNI
Content-Disposition: attachment; filename=jitter.c
Content-Type: text/x-csrc; name=jitter.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <getopt.h>
#include <sched.h>
#include <unistd.h>

#define rdtsc(low,high) \
     __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))

#define rdtscl(low) \
     __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")

#define rdtscll(val) \
     __asm__ __volatile__("rdtsc" : "=A" (val))

#define LOOPS 100.0

int main(int argc, char **argv)
{
	int c;
	unsigned long long start, end, tps = 0;
	double cal;
	double max=0,min=0,avg=0;
	int i;
	pid_t pid;
	struct sched_param sp;
	double sleeptime;
	unsigned long sec,nsec;

	sleeptime = 0.01;
	sec = sleeptime;
	nsec = (sleeptime-sec) * 1000000000;
	
	pid = getpid();

	memset(&sp,0,sizeof(sp));
	sp.sched_priority = sched_get_priority_max(SCHED_FIFO);
	sched_setscheduler(pid,SCHED_FIFO,&sp);

	while ((c=getopt(argc,argv,"c:")) != -1) {
		switch (c) {
			case 'c':
				tps = strtoll(optarg,NULL,10);
				break;
			default:
				exit(0);
		}
	}

	if (!tps) {
		printf("starting calibrate\n");
		rdtscll(start);
		sleep(8);
		rdtscll(end);

		tps = end - start;
		tps >>= 3;
		printf("finished calibrate: ");
	} else {
		printf("passed in calibrate: ");
	}
	cal = tps;
	cal /= 1000000.0;

	printf("%.4fMHz %llu\n",cal,tps);

	for (i=0; i < LOOPS; i++) {
		struct timespec req = { sec, nsec };
		unsigned long long t;
		rdtscll(start);
		nanosleep(&req,NULL);
		rdtscll(end);
		t = end - start;
		cal = t;
		cal /= (double)tps;
		if (!i || cal > max)
			max = cal;
		if (!i || cal < min)
			min = cal;
		avg += cal;
	}

	avg /= LOOPS;
	
	printf("time slept: %.9f sec: %lu nsec: %lu\n",sleeptime,sec,nsec);
	printf("max: %.9f\n",max);
	printf("min: %.9f\n",min);
	printf("avg: %.9f\n",avg);

	printf("greatest time over: %.3f usecs\n",(max-sleeptime)*1000000.0);
	if (min > sleeptime) {
		printf("never ran under (good!)\n");
	} else {
		printf("Ran under!!! (by %.9f) nsecs\n",sleeptime-min);
	}

	if (avg > sleeptime)
		printf("average time over: %.3f usecs\n",(avg-sleeptime)*1000000.0);
	else
		printf("average time ran under???\n");
	
	exit(0);
}

--=-cc6amToJC5oBe62cFoNI--

