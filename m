Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSFOWPf>; Sat, 15 Jun 2002 18:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315616AbSFOWPe>; Sat, 15 Jun 2002 18:15:34 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:3601 "EHLO
	mgix.com") by vger.kernel.org with ESMTP id <S315607AbSFOWPd>;
	Sat, 15 Jun 2002 18:15:33 -0400
From: <mgix@mgix.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question about sched_yield()
Date: Sat, 15 Jun 2002 15:15:32 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBGEDPCBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am seeing some strange linux scheduler behaviours,
and I thought this'd be the best place to ask.

I have two processes, one that loops forever and
does nothing but calling sched_yield(), and the other
is basically benchmarking how fast it can compute
some long math calculation.

When I run the math simulator with nothing else running,
I get the following:

lenslark # ./loop
1.86543 MLoops per sec, sum=0.291969
1.84847 MLoops per sec, sum=1.65587
1.84064 MLoops per sec, sum=1.74601

When I run one instance of the math simulator and
one instance of the sched_yielder, I see the behaviour
I was expecting (and want): all CPU is allocated to the
process that does some actual work:

lenslark # ./yield &
[1] 26316
lenslark #
lenslark # ./loop
1.86502 MLoops per sec, sum=0.291969
1.84868 MLoops per sec, sum=1.65587
1.84035 MLoops per sec, sum=1.74601

and top confirms what I'm seeing: loop gets 99% of
the CPU, and yield gets close to none.

However, when I have two instances of the
sched_yielder running, things start to behave strange:

lenslark # ./yield &
[1] 26350
lenslark # ./yield &
[2] 26351
lenslark # ./loop
0.686901 MLoops per sec, sum=0.291969
0.674352 MLoops per sec, sum=1.65587
0.665542 MLoops per sec, sum=1.74601
0.674117 MLoops per sec, sum=0.407357

and sure enough, top is showing that for
some reason, the sched_yielders get 1/3rd
of the CPU:

26364 root      18   0   364  364   304 R    36.0  0.3   0:04 loop
26351 root      12   0   252  252   204 R    32.2  0.2   0:31 yield
26350 root      14   0   252  252   204 R    31.2  0.2   0:33 yield
26365 root      11   0  1024 1024   812 R     0.3  1.0   0:00 top


Does anyone have a clue as to why this happens ?
Is this the expected behaviour given the current
scheduler algorithm (of which I know nothing :)).

For comparison purposes, I ran the same test on
Win2k+MingWin32, and things behave the way I'd expect
there: no matter how many sched_yielders are running,
loop gets almost all of the CPU, and barely slows down.

I am running on an AMD-K6@400Mhz, on the following kernel:

lenslark # cat /proc/version
Linux version 2.4.18 (root@lenslark.mgix.com) (gcc version 2.96 20000731 (Mandra
ke Linux 8.2 2.96-0.76mdk)) #1 Sun Apr 28 15:25:19 PDT 2002

This kernel was compiled with SMP turned off.

If anyone can explain me what's going on, or even better
how to replicate the behaviour I'm seeing on Win2k, I'd
be very happy. Also, I'm not a subscriber to linux-kernel,
so I'd appreciate a CC.

I've included the source to the two small programs below:

================================= YIELD.CPP

#ifdef linux
#include <sched.h>
main()
{
    while(1)
    {
	sched_yield();
    }
}
#endif


#ifdef WIN32
#include <windows.h>
main()
{
    while(1)
    {
	Sleep(0);
    }
}
#endif

================================= LOOP.CPP
#include <math.h>
#include <stdio.h>
#include <sys/time.h>

#ifdef WIN32
#include <windows.h>
#endif

typedef unsigned long long uint64_t;

uint64_t usecs()
{

#ifdef linux
    struct timeval t;
    gettimeofday(&t,0);

    uint64_t result;
    result= t.tv_sec;
    result*= 1000000;
    result+= t.tv_usec;
    return result;
#endif

#ifdef WIN32
    return 1000*(uint64_t)GetTickCount();
#endif
}

main()
{
    uint64_t t= 0;
    double sum= 0.0;
    uint64_t lastTime= 0;
    uint64_t lastLoops= 0;
    while(t<100000000)
    {
	sum+= sin((double)t);
	if((t%4000000)==0)
	{
	    uint64_t nowTime= usecs();
	    uint64_t nowLoops= t;

	    if(lastTime!=0)
	    {
		double loops= (nowLoops-lastLoops);
		double elapsed= (nowTime-lastTime)/1000000.0;
		fprintf(
		    stderr,
		    "%g MLoops per sec, sum=%g\n",
		    (loops/elapsed)/1000000.0,
		    sum
		);
	    }

	    lastTime= nowTime;
	    lastLoops= nowLoops;
	}
	++t;
    }
    fprintf(stderr,"Sum=%g\n",sum);
}


