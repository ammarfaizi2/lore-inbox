Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133023AbRDZAkZ>; Wed, 25 Apr 2001 20:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133024AbRDZAkQ>; Wed, 25 Apr 2001 20:40:16 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:49406 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S133023AbRDZAkH>; Wed, 25 Apr 2001 20:40:07 -0400
Message-ID: <3AE76E5D.7050506@holly-springs.nc.us>
Date: Wed, 25 Apr 2001 20:39:57 -0400
From: Michael Rothwell <rothwell@holly-springs.nc.us>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.19 i686; en-US; 0.8) Gecko/20010216
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org
Subject: Re: #define HZ 1024 -- negative effects
In-Reply-To: <Pine.LNX.4.10.10104251850400.3127-300000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, for kicks, I tried setting HZ to 1024 with 2.2.19. It seemed a 
little more responsive, but that could be psychosomatic. :) I did notice 
that I was unable to sync my palm pilot until I set it back to 100. 
YMMV. The most useful "performace" tweak for a GUI that I've come across is:

#define _SHM_ID_BITS    10

... if y ou're running Gnome and/or Gtk, because of its appetite for 
lots of SHM segments.

-Michael

Mark Hahn wrote:

>>> Are there any negative effects of editing include/asm/param.h to change 
>>> HZ from 100 to 1024? Or any other number? This has been suggested as a 
>>> way to improve the responsiveness of the GUI on a Linux system. Does it 
>> 
> ...
> 
>> Why not just run the X server at a realtime priority?  Then it will get
>> to respond to existing events, such as keyboard and mouse input,
>> promptly without creating lots of superfluous extra clock interrupts.
>> I think you will find this is a better solution.
> 
> 
> it's surprisingly ineffective; usually, if someone thinks responsiveness
> is bad, there's a problem with the system.  for instance, if the system
> is swapping, setting X (and wm, and clients) to RT makes little difference,
> since the kernel is stealing pages from them, regardless of their scheduling
> priority.
> 
> if you're curious, you might be interested in two toy programs
> I've attached.  one is "setrealtime", which will make a pid RT, or else act
> as a wrapper (ala /bin/time).  I have it installed suid root on my system,
> though this is rather dangerous if your have lusers around.  the second is a
> simple memory-hog: mmaps a bunch of ram, and keeps it active (printing out a
> handy measure of how long it took to touch its pages...)
> 
> regards, mark hahn.
> 
> 
> ------------------------------------------------------------------------
> 
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <sys/time.h>
> #include <sys/mman.h>
> 
> volatile unsigned sink;
> 
> double second() {
>     struct timeval tv;
>     gettimeofday(&tv,0);
>     return tv.tv_sec + 1e-6 * tv.tv_usec;
> }
> 
> int
> main(int argc, char *argv[]) {
>     int doWrite = 1;
>     unsigned size = 80 * 1024 * 1024;
> 
>     int letter;
>     while ((letter = getopt(argc, argv, "s:wrvh?" )) != -1) {
> 	switch(letter) {
> 	case 's': size = atoi(optarg) * 1024 * 1024; break;
> 	case 'w': doWrite = 1; break;
> 	default:
> 	    fprintf(stderr,"useup [-s mb][-w]\n");
> 	    exit(1);
> 	}
>     }
>     int *base = (int*) mmap(0, size, 
> 			      PROT_READ|PROT_WRITE, 
> 			      MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
>     if (base == MAP_FAILED) {
> 	perror("mmap failed");
> 	exit(1);
>     }
> 
>     int *end = base + size/4;
> 
>     while (1) {
> 	double start = second();
> 	if (doWrite)
> 	    for (int *p = base; p < end; p += 1024)
> 		*p = 0;
> 	else {
> 	    unsigned sum = 0;
> 	    for (int *p = base; p < end; p += 1024)
> 		sum += *p;
> 	    sink = sum;
> 	}
> 	printf("%f\n",1000*(second() - start));
>     }
> }
> 
> 
> ------------------------------------------------------------------------
> 
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <sched.h>
> 
> int
> main(int argc, char *argv[]) {
>     int uid = getuid();
>     int pid = atoi(argv[1]);
>     int sched_fifo_min, sched_fifo_max;
>     static struct sched_param sched_parms;
> 
>     if (!pid)
> 	pid = getpid();
> 
>     sched_fifo_min = sched_get_priority_min(SCHED_FIFO);
>     sched_fifo_max = sched_get_priority_max(SCHED_FIFO);
>     sched_parms.sched_priority = sched_fifo_min + 1;
> 
>     if (sched_setscheduler(pid, SCHED_FIFO, &sched_parms) == -1)
>         perror("cannot set realtime scheduling policy");
> 
>     if (uid)
> 	setuid(uid);
> 
>     if (pid == getpid())
> 	execvp(argv[1],&argv[1]);
>     return 0;
> }
> useup.c
> 
> Content-Description:
> 
> useup.c
> Content-Type:
> 
> TEXT/PLAIN
> Content-Encoding:
> 
> BASE64
> 
> 
> ------------------------------------------------------------------------
> setrealtime.c
> 
> Content-Description:
> 
> setrealtime.c
> Content-Type:
> 
> TEXT/PLAIN
> Content-Encoding:
> 
> BASE64
> 
> 


