Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbTL0LIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 06:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTL0LIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 06:08:04 -0500
Received: from gprs214-84.eurotel.cz ([160.218.214.84]:61569 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265357AbTL0LH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 06:07:56 -0500
Date: Sat, 27 Dec 2003 12:09:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Message-ID: <20031227110903.GA1413@elf.ucw.cz>
References: <200312231138.21734.kernel@kolivas.org> <20031226225652.GE197@elf.ucw.cz> <200312271042.55989.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312271042.55989.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've done a resync and update of my batch scheduling that is also
> > > hyper-thread aware.
> > >
> > > What is batch scheduling? Specifying a task as batch allows it to only
> > > use cpu time if there is idle time available, rather than having a
> > > proportion of the cpu time based on niceness.
> > >
> > > Why do I need hyper-thread aware batch scheduling?
> > >
> > > If you have a hyperthread (P4HT) processor and run it as two logical cpus
> > > you can have a very low priority task running that can consume 50% of
> > > your physical cpu's capacity no matter how high priority tasks you are
> > > running. For example if you use the distributed computing client
> > > setiathome you will be effectively be running at half your cpu's speed
> > > even if you run setiathome at nice 20. Batch scheduling for normal cpus
> > > allows only idle time to be used for batch tasks, and for HT cpus only
> > > allows idle time when both logical cpus are idle.
> >
> > BTW this is going to be an issue even on normal (non-HT)
> > systems. Imagine memory-bound scientific task on CPU0 and nice -20
> > memory-bound seti&home at CPU1. Even without hyperthreading, your
> > scientific task is going to run at 50% of speed and seti&home is going
> > to get second half. Oops.
> >
> > Something similar can happen with disk, but we are moving out of
> > cpu-scheduler arena with that.
> >
> > [I do not have SMP nearby to demonstrate it, anybody wanting to
> > benchmark a bit?]
> 
> This is definitely the case but there is one huge difference. If you have 
> 2x1Ghz non HT processors then the fastest a single threaded task can run is 
> at 1Ghz. If you have 1x2Ghz HT processor the fastest a single threaded task 
> can run is 2Ghz. 

Well, gigaherz is not the *only* important thing.

On 2x1GHz, 2GB/sec RAM bandwidth, fastest a single threaded task can
run is 1GHz, 2GB/sec. If you run two of them, it is 1GHz,
*1*GB/sec. So you still have effect similar to hyperthreading. And
yes, it can be measured.

stress runs two tasks walking over 10MB of memory, just for fun. Look:

[Lefik is dual-p3; according to you two mem stressers should run about
same speed as one of them. That's not the case:]

machek@lefik:~/misc$ ./stress tenmega
Process 1665 started at 1072522582.
machek@lefik:~/misc$ Process 1665 done at 1072522695 (113 sec).

machek@lefik:~/misc$ ./stress tenmega tenmega
Process 1669 started at 1072522722.
Process 1670 started at 1072522722.
machek@lefik:~/misc$ Process 1670 done at 1072522895 (173 sec).
Process 1669 done at 1072522903 (181 sec).

machek@lefik:~/misc$

And yes, that machine does have two cpus:

machek@lefik:~/misc$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 801.828
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1599.07

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 801.828
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1602.35

machek@lefik:~/misc$

So... even on normal SMP,
"task-on-other-cpu-slows-down-task-on-this-cpu" effect exists. Okay,
it is not as visible as on HT machine (50% slowdown), but its
definitely there.
								Pavel

/* Copyright 1999-2003 Pavel Machek, distribute under GPLv2 */

#define MEM 20*1024
#define RAMSIZE (8*1024*1024)
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/fcntl.h>
#include <time.h>

void
main( int argc, char *argv[] )
{
unsigned long i;

if (!argc) 
  {
  printf( "stress loop|memread|tenmega|mem|write|eatmem ...\n" );
  return;
  }
for (i=0; i<argc; i++)
  {
  if (!strcmp( argv[i], "loop" ))
    if (!fork())
      while (1);
  if (!strcmp( argv[i], "eatmem" ))
    if (!fork())
      while(1) {
	char *c = malloc(4096);
	if (c) *c='a';
      }
  if (!strcmp( argv[i], "memread" ))
    if (!fork())
      { 
      char *p = malloc( RAMSIZE ); 
      for( i=0; i<RAMSIZE; i++ ) p[i]=1;
      while( 1 ) 
	{ 
	int a;
	for( i=0; i<RAMSIZE; i++ ) a+=p[i];
	} 
      }
  if (!strcmp( argv[i], "tenmega" ))
    if (!fork())
      { 
      char *p = malloc( 10*1024*1024 ); 
      int i, j, start;
      printf( "Process %d started at %d.\n", getpid(), start = time(NULL));
      for( i=0; i<10*1024*1024; i++ ) p[i]=1;
      for( j=1; j<1000; j++ )
	{ 
	volatile int a;
	for( i=0; i<10*1024*1024; i++ ) a+=p[i];
	} 
      printf( "Process %d done at %ld (%ld sec).\n", getpid(), (long) time(NULL), time(NULL)-start);
      exit(0);
      }
  if (!strcmp( argv[i], "mem" ))
    if (!fork())
      { 
      char *p = malloc( RAMSIZE ); 
      while( 1 ) 
	{ 
	for( i=0; i<RAMSIZE; i++ ) p[i]=1;
	sleep( 60 ); 
	} 
      }
  if (!strcmp( argv[i], "write" ))	
    if (!fork())
      {
      char namebuf[1024];
      int h;
      char buf[1024]="Signature of something rather strange ;-)";
      sprintf( namebuf, "/tmp/stresstest.delme.%d", getpid() );
      h = creat( namebuf, 0666 );
      if (h<0) { printf( "Creat failed: %m\n" ); exit(0); }
      while( 1 )
	for( i=0; i<MEM; i++ )
	  {
	  if (lseek( h, i*1024, SEEK_SET )<0) { printf( "Seek failed: %m\n" ); exit(0); }
	  if (write( h, buf, 1024 )<0) { printf( "Write failed: %m\n" ); exit(0); }
	  }
      }
  }
}


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
