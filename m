Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVC1PXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVC1PXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVC1PXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:23:11 -0500
Received: from pop-a065c28.pas.sa.earthlink.net ([207.217.121.205]:38654 "EHLO
	pop-a065c28.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261868AbVC1PUq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:20:46 -0500
From: Eric Bambach <eric@cisu.net>
Reply-To: eric@cisu.net
To: Willy TARREAU <willy@w.ods.org>
Subject: Re: Scheduler latency measurements on 2.6.11.6
Date: Mon, 28 Mar 2005 09:21:03 -0600
User-Agent: KMail/1.8
Cc: mingo@elte.hu, kernel@kolivas.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
References: <20050328141449.GA2216@pcw.home.local>
In-Reply-To: <20050328141449.GA2216@pcw.home.local>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503280921.03851.eric@cisu.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No-where in your mail, unless I missed it because i've been awake for 15 
minutes now, do you mention pre-emption. One of the major latency affecting 
differences between 2.4 and 2.6 is the introduction of pre-emption and with 
2.6.10(ish?) you can pre-empt the big kernel lock.

Since you are experiencing odd latencies w.r.t. syscalls, pre-emption is a 
major point to look at. In fact, the JACK and RT Linux people are working on 
problems similiar to this right now. If your program for whatever reason has 
*hard-time* latency requirements then I suggest you look at the Realtime 
Patches for Linux 2.6.

I would suggest you try a few more test with various combinations of 
pre-emption. The consesus in the documentation seems to be that pre-emption  
make desktops only feel snappier and "real" workloads will suffer as a 
result.

On Monday 28 March 2005 08:14 am, Willy TARREAU wrote:
> Hi Ingo,
>
> I've done some experiences with the 2.6 scheduler on 2.6.11.6 to try
> to reproduce the very high latencies I encountered on some network
> related programs which run on FC2 with 2.6.5-something.
>
> The program which seems to be the most affected is an HTTP load
> generator which I use as a stress-tester to push firewalls an
> load-balancers to their limits, with a Tux on the other side to
> achieve very high loads (and I guess you understand what "very high
> load" can mean with Tux :-))
>
> The program basically schedules connections around a select() loop.
> It's available on my site for reference, see below[1]. Under high
> loads (between 20k and 50k hits per second), the program eats all the
> CPU because select() is called with very short timeouts, and everytime
> it wakes up, there is some work to do. That's expected and not a
> problem. The program tries to display injection statistics every 1000
> ms precisely, and also displays how much time was really elapsed since
> the last stat occurrence.
>
> Under 2.6, if there is any small activity on the machine, the time
> between two stats increases considerably, which means that the program
> regularly freezes. I have observed several freezes of more than 13
> seconds while I was running a simple "while :;do :;done" on another
> console. Delays between 3 and 9 seconds are very common if I start any
> cpu-hungry program.
>
> Under 2.4, I only observe a few tens of ms, and at most a few hundreds
> ms if the CPU is busy.
>
> So I wrote a simple program to try to detect freezes within in a loop,
> and uses select() to sleep for 1 ms and measures the time really
> elapsed.
>
> The first version (attached below) mesures the time spent in a loop
> like this :
>
>    while(1) {
>       x=now();
>       for (volatile x=0; x<iterations; x++);
>       y=now();
>       select(0,0,0,0, 1ms);
>       z=now();
>       print loop=y-x,  select=z-y;
>    }
>
>
> I start one instance of this program with 20 millions iterations per
> loop, then another one with 10 millions iterations per loop. What is
> observed is that the first one takes about 50 ms for the for() loop,
> and about 800 us for the select(). The second one takes about 25 ms
> for the for() loop and about 800 ms for the select(), which is
> consistent with the first one given the fact that it does half the
> number of iterations in the for() loop.
>
> Now, if I start the second program just after the first one, the first
> one takes about 2.1 seconds to complete the for() loop during which
> the second one runs at full speed. Then, the first one progresses
> slowly, by jumps of about 120-950 ms while the second one gets more
> regular CPU with progress every 25-75 ms.
>
> As I was not sure whether the freezes were cumulated or at one time,
> I modified the program  (lat2 then lat3) [3], to measure the time
> elapsed between two consecutive calls to gettimeofday().
>
> The result is rather interesting [5]. Basically, the program did the
> following :
>
>    while(1) {
>       x = now(); max = 0;
>       do {
>         y = now;
>         max = MAX(max, now() - y);
>       } while (y-x < atol(argv[1]));
>       select(0,0,0,0, 1ms);
>       z=now();
>       print select=z-y , loop=y-x, max;
>    }
>
> Now we observe that running just this with only a "while :;do :;done"
> in parallel exhibits 'max' values of about 2.1 seconds, which means
> that the 'do()...while' loop has totally stopped for 2.1 seconds when
> the second process started. The second test was done with 2
> simultaneous shell loops, and the program froze for 3.1 seconds.
>
> Latest test with lat3 also showed the number of iterations which took
> more than 10 ms. It clearly shows that the loop is very smooth, except
> for one iteration which takes 2.5 second. If I increase the loop time
> to 1 second, the two simultaneous processes mutually hinder with
> latencies of 1 second each, as shown in [6], sorted by date.
>
> Looking at kernel/sched.c, I understood that the timeslices are set to
> 100 ms by default, and can grow as high as 800 ms for nice -19 and
> shrink as low as 5 ms for nice +20. Playing with nice on any of the
> processes showed this exact overall latency during the test, except
> at start, where the behaviour was different : at nice +10, the latency
> slowly increased from 50ms to 800ms instead of starting at 2 seconds
> then decaying [7].
>
> Starting the two processes at nice +15 exhibit a rather stable latency
> starting at 25 ms, and quickly stabilizing to 50 ms. At nice +16, the,
> latency is perfectly stable at 20ms from the beginning to the end, and
> at +18, it goes down to 10 ms. At nice +20, they both keep stable at
> 5 ms. So now I'm wondering :
>
>   - what causes the initial high latency peak when I start a process
>     at nice +0, and what can be done about it (a freeze of 2 seconds
>     is rather annoying)
>
>   - it seems that renicing all processes to +16 protects from high
>     latencies. Maybe this could be an acceptable workaround for
>     network-only applications, but I have no idea about the side
>     effects this could bring (interactivity, etc...).
>
> Any hint would be much appreciated since on some testing machines
> (including notebook), this is clearly what makes me stick to 2.4.
>
> Best regards,
> Willy
>
> --------
> Appendix
> --------
>
> [0] reports and programs available at http://w.ods.org/linux/sched/
> [1] HTTP traffic generator http://w.ods.org/tools/inject/
>
> ==================================================
>
> [2] lat.c : first version of the latency program.
>
> ==================================================
>
> #include <stdio.h>
> #include <time.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> unsigned long long tv_diff(struct timeval *tv1, struct timeval *tv2) {
>  unsigned long long ret;
>
>  ret = ((unsigned long long)(tv2->tv_sec - tv1->tv_sec)) * 1000000ULL;
>  if (tv2->tv_usec > tv1->tv_usec)
>   ret += (tv2->tv_usec - tv1->tv_usec);
>  else
>   ret -= (tv1->tv_usec - tv2->tv_usec);
>  return ret;
> }
>
>
> main(int argc, char **argv) {
>  struct timeval tv1, tv2, tv3, wait;
>  int loops;
>
>  if (argc > 1)
>   loops = atol(argv[1]);
>  else
>   loops = 50000000;
>
>  memset(&tv1, 0, sizeof(tv1));
>  memset(&tv2, 0, sizeof(tv2));
>  memset(&tv3, 0, sizeof(tv3));
>
>  gettimeofday(&tv1, NULL);
>  while (1) {
>   volatile i;
>
>   gettimeofday(&tv2, NULL);
>
>   for (i=0; i<loops; i++);
>
>   gettimeofday(&tv3, NULL);
>
>   printf("date=%lu.%06lu,  user=%10lld us,  wait=%10lld us\n",
>    tv3.tv_sec, tv3.tv_usec,
>    tv_diff(&tv2, &tv3), tv_diff(&tv1, &tv2));
>
>   wait.tv_sec = 0;
>   wait.tv_usec = 1000;
>
>   gettimeofday(&tv1, NULL);
>   select(0, NULL, NULL, NULL, &wait);
>  }
> }
>
>
> ==================================================
>
> [3] lat3.c : third version of the latency program.
>
> ==================================================
>
> #include <stdio.h>
> #include <time.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> unsigned long long tv_diff(struct timeval *tv1, struct timeval *tv2) {
>  unsigned long long ret;
>
>  ret = ((unsigned long long)(tv2->tv_sec - tv1->tv_sec)) * 1000000ULL;
>  if (tv2->tv_usec > tv1->tv_usec)
>   ret += (tv2->tv_usec - tv1->tv_usec);
>  else
>   ret -= (tv1->tv_usec - tv2->tv_usec);
>  return ret;
> }
>
>
> main(int argc, char **argv) {
>  struct timeval tv1, tv2, tv3, tv4, wait;
>  int loops;
>
>  if (argc > 1)
>   loops = atol(argv[1]);
>  else
>   loops = 100000;
>
>  memset(&tv1, 0, sizeof(tv1)); memset(&tv2, 0, sizeof(tv2));
>  memset(&tv3, 0, sizeof(tv3)); memset(&tv4, 0, sizeof(tv4));
>
>  printf("Date_sec.msec   select    loop  maxlat    nbmax\n");
>  gettimeofday(&tv1, NULL);
>  while (1) {
>   int i, max, times;
>
>   gettimeofday(&tv2, NULL);
>   tv4 = tv2;
>   max = 0; times = 0;
>   do {
>    gettimeofday(&tv3, NULL);
>    i = tv_diff(&tv4, &tv3);
>    if (i > max)
>     max = i;
>    if (i > 10000)
>     times++;
>    tv4 = tv3;
>    i = tv_diff(&tv2, &tv3);
>   } while (i < loops);
>
>   printf("%lu.%03lu %7lld %7lld %7d %7d\n",
>    tv3.tv_sec, tv3.tv_usec/1000,
>    tv_diff(&tv1, &tv2), tv_diff(&tv2, &tv3),
>    max, times);
>
>   wait.tv_sec = 0;
>   wait.tv_usec = 1000;
>
>   gettimeofday(&tv1, NULL);
>   select(0, NULL, NULL, NULL, &wait);
>  }
> }
>
>
> ==================================================
>
> [4] latencies report on first test with 2 'lat' instances run in
>     parallel
>
> ==================================================
>
> P:-- = process 1 : ./lat 20000000, started at 1111993713.241839
> P:** = process 2 : ./lat 10000000, started at 1111993714.549886
>
> P      system time           time spent           time spent
>       tv_sec.tv_usec          in loop             in select()
>
> --  1111993713.241839,   user=     49421 us,   wait=       456 us
> --  1111993713.291499,   user=     49089 us,   wait=       410 us
> --  1111993713.341838,   user=     49435 us,   wait=       744 us
> --  1111993713.391437,   user=     49042 us,   wait=       396 us
> --  1111993713.441843,   user=     49455 us,   wait=       791 us
> --  1111993713.490587,   user=     48207 us,   wait=       377 us
> --  1111993713.540792,   user=     49419 us,   wait=       625 us
> --  1111993713.592292,   user=     50927 us,   wait=       413 us
> --  1111993713.643759,   user=     50402 us,   wait=       890 us
> --  1111993713.693417,   user=     49068 us,   wait=       427 us
> --  1111993713.744553,   user=     50211 us,   wait=       764 us
> --  1111993713.794794,   user=     49460 us,   wait=       620 us
> --  1111993713.844748,   user=     49422 us,   wait=       372 us
> --  1111993713.894778,   user=     49459 us,   wait=       411 us
> --  1111993713.944731,   user=     49420 us,   wait=       373 us
> --  1111993713.994919,   user=     49615 us,   wait=       413 us
> --  1111993714.043893,   user=     48597 us,   wait=       215 us
> --  1111993714.093461,   user=     49172 us,   wait=       236 us
> --  1111993714.144210,   user=     49929 us,   wait=       659 us
> --  1111993714.194733,   user=     49460 us,   wait=       889 us
> --  1111993714.244725,   user=     49459 us,   wait=       373 us
> --  1111993714.294754,   user=     49496 us,   wait=       373 us
> --  1111993714.344672,   user=     49422 us,   wait=       337 us
> --  1111993714.394704,   user=     49461 us,   wait=       412 us
> --  1111993714.444655,   user=     49420 us,   wait=       371 us
> --  1111993714.494687,   user=     49459 us,   wait=       413 us
> **  1111993714.549886,   user=     24833 us,   wait=         0 us
> **  1111993714.575477,   user=     25267 us,   wait=       289 us
> **  1111993714.600950,   user=     24744 us,   wait=       569 us
> **  1111993714.626437,   user=     25235 us,   wait=        94 us
> **  1111993714.651910,   user=     24712 us,   wait=       601 us
> **  1111993714.676941,   user=     24747 us,   wait=       126 us
> **  1111993714.701902,   user=     24712 us,   wait=        92 us
> **  1111993714.726043,   user=     23856 us,   wait=       127 us
> **  1111993714.751503,   user=     24320 us,   wait=       972 us
> **  1111993714.776508,   user=     24329 us,   wait=       518 us
> **  1111993714.801897,   user=     24722 us,   wait=       510 us
> **  1111993714.827284,   user=     25104 us,   wait=       125 us
> **  1111993714.852452,   user=     24285 us,   wait=       725 us
> **  1111993714.877947,   user=     24783 us,   wait=       555 us
> **  1111993714.902449,   user=     24286 us,   wait=        58 us
> **  1111993714.927864,   user=     24708 us,   wait=       550 us
> **  1111993714.952864,   user=     24712 us,   wait=       130 us
> **  1111993714.977897,   user=     24749 us,   wait=       127 us
> **  1111993715.002856,   user=     24711 us,   wait=        90 us
> **  1111993715.027851,   user=     24710 us,   wait=       128 us
> **  1111993715.052890,   user=     24753 us,   wait=       129 us
> **  1111993715.078392,   user=     25259 us,   wait=        85 us
> **  1111993715.103840,   user=     24711 us,   wait=       579 us
> **  1111993715.129352,   user=     25227 us,   wait=       128 us
> **  1111993715.154834,   user=     24712 us,   wait=       611 us
> **  1111993715.179867,   user=     24749 us,   wait=       126 us
> **  1111993715.204825,   user=     24710 us,   wait=        91 us
> **  1111993715.229818,   user=     24708 us,   wait=       128 us
> **  1111993715.254817,   user=     24710 us,   wait=       132 us
> **  1111993715.279850,   user=     24748 us,   wait=       128 us
> **  1111993715.304386,   user=     24286 us,   wait=        93 us
> **  1111993715.329805,   user=     24710 us,   wait=       552 us
> **  1111993715.354801,   user=     24709 us,   wait=       130 us
> **  1111993715.379837,   user=     24750 us,   wait=       129 us
> **  1111993715.404796,   user=     24712 us,   wait=        90 us
> **  1111993715.429788,   user=     24708 us,   wait=       127 us
> **  1111993715.453935,   user=     23858 us,   wait=       132 us
> **  1111993715.479831,   user=     24759 us,   wait=       970 us
> **  1111993715.504789,   user=     24720 us,   wait=        81 us
> **  1111993715.529347,   user=     24283 us,   wait=       117 us
> **  1111993715.553917,   user=     23852 us,   wait=       561 us
> **  1111993715.579859,   user=     24802 us,   wait=       968 us
> **  1111993715.605199,   user=     25145 us,   wait=        37 us
> **  1111993715.630842,   user=     24790 us,   wait=       696 us
> **  1111993715.655756,   user=     24711 us,   wait=        44 us
> **  1111993715.680790,   user=     24748 us,   wait=       129 us
> **  1111993715.705747,   user=     24709 us,   wait=        91 us
> **  1111993715.730744,   user=     24710 us,   wait=       130 us
> **  1111993715.755315,   user=     24285 us,   wait=       129 us
> **  1111993715.780777,   user=     24751 us,   wait=       554 us
> **  1111993715.805731,   user=     24708 us,   wait=        88 us
> **  1111993715.830730,   user=     24711 us,   wait=       131 us
> **  1111993715.855422,   user=     24407 us,   wait=       128 us
> **  1111993715.880562,   user=     24551 us,   wait=       430 us
> **  1111993715.905292,   user=     24285 us,   wait=       283 us
> **  1111993715.931150,   user=     25146 us,   wait=       555 us
> **  1111993715.956284,   user=     24284 us,   wait=       693 us
> **  1111993715.982182,   user=     25186 us,   wait=       556 us
> **  1111993716.007274,   user=     24282 us,   wait=       653 us
> **  1111993716.032748,   user=     24760 us,   wait=       557 us
> **  1111993716.057267,   user=     24283 us,   wait=        78 us
> **  1111993716.084110,   user=     26130 us,   wait=       556 us
> **  1111993716.109259,   user=     24283 us,   wait=       708 us
> **  1111993716.135627,   user=     25654 us,   wait=       557 us
> **  1111993716.160251,   user=     24282 us,   wait=       183 us
> **  1111993716.186151,   user=     25186 us,   wait=       556 us
> **  1111993716.211245,   user=     24284 us,   wait=       652 us
> **  1111993716.237102,   user=     25145 us,   wait=       555 us
> **  1111993716.262236,   user=     24283 us,   wait=       694 us
> **  1111993716.288133,   user=     25184 us,   wait=       557 us
> **  1111993716.313228,   user=     24283 us,   wait=       655 us
> **  1111993716.338236,   user=     24295 us,   wait=       556 us
> **  1111993716.363220,   user=     24282 us,   wait=       545 us
> **  1111993716.389121,   user=     25147 us,   wait=       597 us
> **  1111993716.414212,   user=     24282 us,   wait=       651 us
> **  1111993716.440071,   user=     25145 us,   wait=       557 us
> **  1111993716.465245,   user=     24323 us,   wait=       694 us
> **  1111993716.491065,   user=     25147 us,   wait=       515 us
> **  1111993716.516206,   user=     24292 us,   wait=       693 us
> **  1111993716.541620,   user=     24709 us,   wait=       548 us
> **  1111993716.566736,   user=     24826 us,   wait=       133 us
> **  1111993716.592614,   user=     24711 us,   wait=       998 us
> --  1111993716.616717,   user=   2121497 us,   wait=       373 us
> **  1111993716.621474,   user=     28575 us,   wait=       129 us
> **  1111993716.647549,   user=     25654 us,   wait=       265 us
> **  1111993716.672212,   user=     24321 us,   wait=       182 us
> **  1111993716.697596,   user=     24709 us,   wait=       518 us
> **  1111993716.724593,   user=     26707 us,   wait=       132 us
> **  1111993716.749588,   user=     24709 us,   wait=       129 us
> **  1111993716.774238,   user=     24360 us,   wait=       133 us
> **  1111993716.799581,   user=     24710 us,   wait=       476 us
> **  1111993716.824576,   user=     24708 us,   wait=       131 us
> --  1111993716.874215,   user=    252583 us,   wait=      4730 us
> **  1111993716.895877,   user=     71013 us,   wait=       131 us
> **  1111993716.922539,   user=     25686 us,   wait=       819 us
> **  1111993716.947132,   user=     24283 us,   wait=       152 us
> **  1111993716.973030,   user=     25185 us,   wait=       556 us
> **  1111993717.043543,   user=     69702 us,   wait=       653 us
> **  1111993717.069044,   user=     25213 us,   wait=       130 us
> **  1111993717.094537,   user=     24708 us,   wait=       627 us
> **  1111993717.119531,   user=     24708 us,   wait=       129 us
> --  1111993717.129505,   user=    233469 us,   wait=     21658 us
> **  1111993717.147968,   user=     28149 us,   wait=       131 us
> **  1111993717.173564,   user=     24749 us,   wait=       689 us
> **  1111993717.198520,   user=     24709 us,   wait=        90 us
> **  1111993717.223517,   user=     24710 us,   wait=       131 us
> --  1111993717.281687,   user=    133559 us,   wait=     18460 us
> **  1111993717.297538,   user=     73735 us,   wait=       129 us
> **  1111993717.322296,   user=     24504 us,   wait=        98 us
> **  1111993717.347534,   user=     24746 us,   wait=       335 us
> **  1111993717.371676,   user=     23892 us,   wait=        93 us
> **  1111993717.436345,   user=     63564 us,   wait=       937 us
> **  1111993717.461054,   user=     24283 us,   wait=       269 us
> **  1111993717.486111,   user=     24344 us,   wait=       556 us
> **  1111993717.511048,   user=     24283 us,   wait=       497 us
> --  1111993717.538346,   user=    240650 us,   wait=     15838 us
> **  1111993717.545901,   user=     34142 us,   wait=       555 us
> **  1111993717.571567,   user=     24813 us,   wait=       697 us
> **  1111993717.596896,   user=     25146 us,   wait=        25 us
> **  1111993717.622033,   user=     24283 us,   wait=       697 us
> --  1111993717.689683,   user=    143624 us,   wait=      7553 us
> **  1111993717.696456,   user=     73713 us,   wait=       553 us
> **  1111993717.721016,   user=     24285 us,   wait=       118 us
> **  1111993717.746437,   user=     24710 us,   wait=       554 us
> **  1111993717.770618,   user=     23891 us,   wait=       133 us
> **  1111993717.828860,   user=     57140 us,   wait=       933 us
> **  1111993717.854894,   user=     25182 us,   wait=       695 us
> **  1111993717.880028,   user=     24321 us,   wait=       657 us
> **  1111993717.905849,   user=     25146 us,   wait=       518 us
> --  1111993717.944866,   user=    248251 us,   wait=      6757 us
> **  1111993717.945532,   user=     38833 us,   wait=       693 us
> **  1111993717.971049,   user=     24356 us,   wait=       992 us
> **  1111993717.995973,   user=     24284 us,   wait=       482 us
> **  1111993718.021982,   user=     25296 us,   wait=       557 us
> **  1111993718.046967,   user=     24285 us,   wait=       542 us
> --  1111993718.098033,   user=    152330 us,   wait=       678 us
> **  1111993718.121020,   user=     73342 us,   wait=       555 us
> **  1111993718.175406,   user=     24744 us,   wait=     29484 us
> **  1111993718.199944,   user=     24286 us,   wait=        92 us
> **  1111993718.225799,   user=     25144 us,   wait=       553 us
> **  1111993718.250935,   user=     24284 us,   wait=       694 us
> **  1111993718.275976,   user=     24329 us,   wait=       555 us
> **  1111993718.300927,   user=     24284 us,   wait=       509 us
> **  1111993718.326794,   user=     25155 us,   wait=       556 us
> **  1111993718.351920,   user=     24285 us,   wait=       683 us
> **  1111993718.377816,   user=     25184 us,   wait=       555 us
> **  1111993718.402913,   user=     24285 us,   wait=       654 us
> **  1111993718.428769,   user=     25145 us,   wait=       554 us
> **  1111993718.453906,   user=     24285 us,   wait=       695 us
> **  1111993718.479362,   user=     24746 us,   wait=       553 us
> **  1111993718.503899,   user=     24283 us,   wait=        96 us
> **  1111993718.529317,   user=     24709 us,   wait=       551 us
> **  1111993718.554314,   user=     24708 us,   wait=       132 us
> **  1111993718.579420,   user=     24819 us,   wait=       130 us
> **  1111993718.604744,   user=     25146 us,   wait=        20 us
> **  1111993718.629880,   user=     24287 us,   wait=       692 us
> **  1111993718.655816,   user=     25227 us,   wait=       552 us
> --  1111993718.670711,   user=    549531 us,   wait=     22985 us
> **  1111993718.696319,   user=     25445 us,   wait=     14900 us
> --  1111993718.751516,   user=     55038 us,   wait=     25606 us
> **  1111993718.769957,   user=     68379 us,   wait=      5101 us
> **  1111993718.810843,   user=     24277 us,   wait=     16452 us
> **  1111993718.836273,   user=     24711 us,   wait=       562 us
> **  1111993718.861266,   user=     24708 us,   wait=       128 us
> **  1111993718.885505,   user=     23951 us,   wait=       131 us
> **  1111993718.911259,   user=     24709 us,   wait=       876 us
> --  1111993718.965887,   user=    195771 us,   wait=     18428 us
> **  1111993718.967980,   user=     56433 us,   wait=       131 us
> **  1111993718.993247,   user=     24709 us,   wait=       402 us
> **  1111993719.020242,   user=     24709 us,   wait=      2129 us
> **  1111993719.045284,   user=     24754 us,   wait=       132 us
> --  1111993719.093043,   user=    124905 us,   wait=      2091 us
> **  1111993719.117629,   user=     24422 us,   wait=     47766 us
> **  1111993719.144171,   user=     25656 us,   wait=       874 us
> **  1111993719.168406,   user=     23895 us,   wait=       328 us
> **  1111993719.193837,   user=     25261 us,   wait=       158 us
> **  1111993719.218789,   user=     24285 us,   wait=       655 us
> **  1111993719.244210,   user=     24710 us,   wait=       699 us
> **  1111993719.269243,   user=     24747 us,   wait=       274 us
> **  1111993719.294203,   user=     24711 us,   wait=       237 us
> **  1111993719.319198,   user=     24710 us,   wait=       273 us
> **  1111993719.344196,   user=     24709 us,   wait=       277 us
> **  1111993719.369231,   user=     24750 us,   wait=       273 us
> **  1111993719.394188,   user=     24711 us,   wait=       234 us
> **  1111993719.419183,   user=     24710 us,   wait=       273 us
> **  1111993719.444180,   user=     24711 us,   wait=       274 us
> **  1111993719.469215,   user=     24749 us,   wait=       274 us
> **  1111993719.494231,   user=     24769 us,   wait=       235 us
> **  1111993719.519167,   user=     24709 us,   wait=       215 us
> **  1111993719.559732,   user=     40278 us,   wait=       275 us
> **  1111993719.604591,   user=     25145 us,   wait=     19557 us
> **  1111993719.630151,   user=     24710 us,   wait=       838 us
> **  1111993719.655665,   user=     25228 us,   wait=       274 us
> **  1111993719.681183,   user=     24750 us,   wait=       755 us
> **  1111993719.706141,   user=     24710 us,   wait=       236 us
> **  1111993719.731136,   user=     24710 us,   wait=       273 us
> **  1111993719.756131,   user=     24709 us,   wait=       274 us
> **  1111993719.781170,   user=     24752 us,   wait=       276 us
> **  1111993719.806124,   user=     24710 us,   wait=       232 us
> **  1111993719.831123,   user=     24712 us,   wait=       276 us
> **  1111993719.856116,   user=     24709 us,   wait=       272 us
> **  1111993719.881151,   user=     24748 us,   wait=       276 us
> **  1111993719.906111,   user=     24712 us,   wait=       236 us
> **  1111993719.931106,   user=     24711 us,   wait=       272 us
> **  1111993719.955249,   user=     23857 us,   wait=       274 us
> **  1111993719.981014,   user=     25597 us,   wait=       156 us
> **  1111993720.011092,   user=     24709 us,   wait=      5357 us
> **  1111993720.036135,   user=     24756 us,   wait=       275 us
> **  1111993720.061085,   user=     24709 us,   wait=       229 us
> **  1111993720.086192,   user=     24820 us,   wait=       275 us
> --  1111993720.092040,   user=    974252 us,   wait=     24583 us
> **  1111993720.116381,   user=     24327 us,   wait=      5850 us
> **  1111993720.142154,   user=     24791 us,   wait=       970 us
> **  1111993720.166843,   user=     24484 us,   wait=       192 us
> **  1111993720.192568,   user=     25212 us,   wait=       500 us
> **  1111993720.217636,   user=     24284 us,   wait=       772 us
> **  1111993720.249493,   user=     25146 us,   wait=      6699 us
> **  1111993720.274664,   user=     24321 us,   wait=       838 us
> **  1111993720.300485,   user=     25146 us,   wait=       663 us
> **  1111993720.325621,   user=     24286 us,   wait=       838 us
> **  1111993720.351478,   user=     25146 us,   wait=       700 us
> **  1111993720.376688,   user=     24360 us,   wait=       838 us
> **  1111993720.402472,   user=     25148 us,   wait=       624 us
> **  1111993720.441027,   user=     24709 us,   wait=     13835 us
> **  1111993720.465640,   user=     24323 us,   wait=       278 us
> **  1111993720.490168,   user=     23858 us,   wait=       658 us
> **  1111993720.515467,   user=     25132 us,   wait=       155 us
> **  1111993720.541013,   user=     24710 us,   wait=       824 us
> **  1111993720.566048,   user=     24749 us,   wait=       275 us
> **  1111993720.590924,   user=     24629 us,   wait=       235 us
> **  1111993720.616474,   user=     25183 us,   wait=       355 us
> **  1111993720.641659,   user=     24372 us,   wait=       801 us
> **  1111993720.667035,   user=     24748 us,   wait=       616 us
> **  1111993720.691564,   user=     24284 us,   wait=       232 us
> **  1111993720.717423,   user=     25147 us,   wait=       700 us
> **  1111993720.751980,   user=     24709 us,   wait=      9836 us
> **  1111993720.777017,   user=     24750 us,   wait=       275 us
> **  1111993720.801973,   user=     24710 us,   wait=       234 us
> **  1111993720.826971,   user=     24712 us,   wait=       274 us
> **  1111993720.851966,   user=     24711 us,   wait=       272 us
> **  1111993720.877575,   user=     25323 us,   wait=       275 us
> **  1111993720.902756,   user=     24508 us,   wait=       661 us
> **  1111993720.927530,   user=     24286 us,   wait=       476 us
> **  1111993720.965424,   user=     25186 us,   wait=     12696 us
> **  1111993720.990519,   user=     24285 us,   wait=       798 us
> **  1111993721.015986,   user=     24756 us,   wait=       699 us
> **  1111993721.040083,   user=     23856 us,   wait=       228 us
> **  1111993721.066281,   user=     26031 us,   wait=       156 us
> --  1111993721.066583,   user=    949623 us,   wait=     24908 us
> **  1111993721.092898,   user=     25676 us,   wait=       929 us
> **  1111993721.144430,   user=     45217 us,   wait=      6303 us
> **  1111993721.200868,   user=     46517 us,   wait=      9908 us
> **  1111993721.270960,   user=     60618 us,   wait=      9462 us
> **  1111993721.320463,   user=     44276 us,   wait=      5215 us
> **  1111993721.376595,   user=     46271 us,   wait=      9848 us
> **  1111993721.441384,   user=     55070 us,   wait=      9707 us
> **  1111993721.497743,   user=     48366 us,   wait=      7981 us
> **  1111993721.553152,   user=     45856 us,   wait=      9541 us
> **  1111993721.618383,   user=     55056 us,   wait=     10163 us
> **  1111993721.658720,   user=     30441 us,   wait=      9884 us
> **  1111993721.719345,   user=     55072 us,   wait=      5541 us
> **  1111993721.759890,   user=     30626 us,   wait=      9907 us
> **  1111993721.819330,   user=     55072 us,   wait=      4356 us
> **  1111993721.859934,   user=     30685 us,   wait=      9907 us
> **  1111993721.920176,   user=     55934 us,   wait=      4297 us
> **  1111993721.965367,   user=     35135 us,   wait=     10044 us
> **  1111993722.000338,   user=     25113 us,   wait=      9846 us
>
> ==================================================
>
> [5] other reports with lat2 and lat3
>
> ==================================================
>
> #process1= lat2 50000
> #process2= while : ;do :; done
>
> date=1111995134.390, wait=       827 us, user=     50000 us, max=     51
> date=1111995134.441, wait=       827 us, user=     50000 us, max=     22
> date=1111995136.546, wait=       828 us, user=   2103676 us, max=2102961
> date=1111995136.995, wait=    399760 us, user=     50000 us, max=     51
> date=1111995137.046, wait=       985 us, user=     50000 us, max=     89
> date=1111995137.097, wait=      1017 us, user=     50000 us, max=     22
> date=1111995137.148, wait=       940 us, user=     50000 us, max=     51
>
> #process1= lat2 100000
> #process2= 2x while : &
>
> date=1111995037.390, wait=       818 us, user=    100000 us, max=    153
> date=1111995037.491, wait=       817 us, user=    100000 us, max=     65
> date=1111995037.592, wait=       819 us, user=    100000 us, max=     51
> date=1111995040.691, wait=       819 us, user=   3098525 us, max=3062425
> date=1111995040.991, wait=    199769 us, user=    100000 us, max=     51
> date=1111995041.092, wait=       971 us, user=    100000 us, max=     89
> date=1111995041.193, wait=       970 us, user=    100000 us, max=     56
>
> #process1=lat3   (nbmax shows the number of lags of more than 10 ms)
> #process2=while :;do :;done
>
> Date_sec.msec   select    loop  maxlat    nbmax
>
> 1112008903.267     929  100000      48       0
> 1112008903.368     930  100000      52       0
> 1112008903.469     931  100000      49       0
> 1112008903.570     930  100000      54       0
> 1112008903.673     930  101297    8288       0
> 1112008903.773     680  100000      51       0
> 1112008903.874     977  100000      54       0
> 1112008906.469     978 2593603 2507346       1
> 1112008906.669   99929  100000      49       0
> 1112008906.770     929  100000      51       0
> 1112008906.871     930  100000      50       0
>
>
> ==================================================
>
> [6] large latency reports with 2x lat3 1000000
>
> ==================================================
>
> P: Date_sec.msec   select    loop  maxlat    nbmax
> 1: 1112015222.379       1 1000000   24646       1
> 1: 1112015223.380     177 1000000      70       0
> 1: 1112015224.380     791 1000000      98       0
> 1: 1112015225.381     792 1000000    8299       0
> 1: 1112015227.335     841 1952641 1002003       1
> 2: 1112015227.335       1 1000000      94       0
> 1: 1112015228.939  603960 1000000    8297       0
> 2: 1112015228.939      65 1603966 1000071       1
> 1: 1112015229.940     795 1000000      53       0
> 2: 1112015231.675 1000842 1735522  835883       1
> 1: 1112015232.015  899654 1175819  299966       1
> 1: 1112015233.615  599855 1000000      53       0
> 2: 1112015233.615   39986 1899922 1000070       1
> 1: 1112015235.376     793 1759891 1000020       1
> 2: 1112015235.376  760666 1000000      53       0
> 2: 1112015237.076     844 1699738  899875       1
> 1: 1112015238.016  800663 1839721  899875       1
> 2: 1112015238.516   39986 1399788  459942       1
> 1: 1112015239.916   39937 1859880 1000022       1
> 2: 1112015239.916  399932 1000000      53       0
> 1: 1112015241.677  760667 1000000      53       0
> 2: 1112015241.677     842 1759937 1000068       1
> 1: 1112015243.385     796 1707751  899888       1
> 2: 1112015244.334  808663 1848719  908875       1
> 1: 1112015245.234   39972 1808725  859880       1
> 2: 1112015245.834   39985 1459779  559927       1
> 1: 1112015247.234   39939 1959863 1000020       1
> 2: 1112015247.234  399930 1000000      54       0
> 1: 1112015248.995  760670 1000000      53       0
> 2: 1112015248.995     844 1759940 1000069       1
> 1: 1112015250.704     793 1708738  907873       1
> 2: 1112015251.644  801660 1847719  899874       1
> 1: 1112015252.544   39986 1799726  859880       1
> 2: 1112015253.044   39939 1359793  459942       1
> 1: 1112015254.553   39986 1968863 1000022       1
> 2: 1112015254.553  508869 1000000      53       0
> 2: 1112015256.008     841 1453798  693927       1
> 2: 1112015257.009     973 1000000    8287       0
>
>
>
> ==================================================
>
> [7] slowly increasing latency with 2x nice +10 lat3 1000000
>
> ==================================================
>
> P  Date_sec.msec   select    loop  maxlat    nbmax
> 1: 1112015805.344       0 1000000   24711       1
> 1: 1112015806.344     155 1000000   24471       1
> 1: 1112015807.345     837 1000000    8286       0
> 1: 1112015808.346     791 1000000      53       0
> 1: 1112015809.347     793 1000000      91       0
> 1: 1112015810.347     792 1000000      53       0
> 1: 1112015811.348     793 1000000      53       0
> 1: 1112015812.349     793 1000000    8285       0
> 1: 1112015813.350     840 1000000   50004       7
> 2: 1112015813.728       1 1049753   50004      11
> 1: 1112015814.400   49827 1000000   50004      10
> 2: 1112015814.778     938 1048839   50004      11
> 1: 1112015815.450   49832 1000000   50005      10
> 2: 1112015815.785     945 1006846   85998      10
> 1: 1112015816.535   49786 1035842   99996       9
> 2: 1112015816.835   49985 1000000  149988       8
> 1: 1112015817.635   49938 1049840  249974       7
> 2: 1112015818.185   49833 1299802  499935       6
> 1: 1112015818.835   49936 1149835  599929       1
> 2: 1112015819.735   49986 1499772  849882       1
> 1: 1112015820.585   49928 1699742  799890       1
> 2: 1112015821.485   49984 1699750  849890       1
> 1: 1112015822.384   49936 1749734  849883       1
> 2: 1112015823.284   49976 1749734  849882       1
> 1: 1112015824.184   49935 1749734  849881       1
> 2: 1112015825.084   49986 1749734  849883       1
> 1: 1112015825.984   49938 1749734  849882       1
> 2: 1112015826.834   49985 1699750  799898       1
> 1: 1112015827.734   49937 1699742  849882       1
> 2: 1112015828.633   49977 1749734  849883       1
> 1: 1112015829.533   49936 1749734  849882       1
> 2: 1112015830.433   49985 1749734  849881       1
> 1: 1112015831.291   49938 1707741  807889       1
> 1: 1112015832.341   49984 1000000    8285       0
>
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
----------------------------------------
--EB

> All is fine except that I can reliably "oops" it simply by trying to read
> from /proc/apm (e.g. cat /proc/apm).
> oops output and ksymoops-2.3.4 output is attached.
> Is there anything else I can contribute?

The latitude and longtitude of the bios writers current position, and
a ballistic missile.

                --Alan Cox LKML-December 08,2000 

----------------------------------------
