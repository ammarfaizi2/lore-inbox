Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262567AbTCMVtu>; Thu, 13 Mar 2003 16:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTCMVtu>; Thu, 13 Mar 2003 16:49:50 -0500
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:27888
	"EHLO flat") by vger.kernel.org with ESMTP id <S262567AbTCMVti>;
	Thu, 13 Mar 2003 16:49:38 -0500
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.64-mm6, a new test case for scheduler interactivity problems
Date: Thu, 13 Mar 2003 22:01:02 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303132201.02278.cb-lkml@fish.zetnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

I've just installed 2.5.64-mm6, and I've tried out the new improved 
scheduler and it's definately not there yet. I can easily cause ogg 
playback to skip (for example) by changing virtual desktop in windowmaker 
to busy konqueror window. X is not reniced (has a nice level of 0)

It's several months since I last ran a 2.4 kernel on this machine, but as I 
remember it did not skip when changing desktops.

My experience suggests that skips occur when more than one interactive task 
starts to become a CPU hog, for example X and konqueror can be idle for 
long periods, and so become interactive, but during an intensive redraw 
they briefly behave as CPU hogs but maintain their interactive bonus this 
means that ogg123 has to wait until the hogs complete their timeslice 
before being scheduled.

My test case tries to reproduce this by creating a number of tasks which 
alternate between being 'interactive' and CPU hogs. On my Celery 333 laptop 
it can sometimes cause skips with only 1 child, and is pretty much 
guaranteed to cause skips with more child tasks.

To compile use 'gcc -o thud thud.c'

To reproduce, I:
run ogg123 somefile.ogg in one xterm
run ./thud 1 in another xterm

The music will often skip shortly after thud displays "running....". If not, 
try ./thud 2 or more.

My setup is celery 333 Sony Vaio 128MB, Debian sid, XFree86 4.2.1, gcc 3.2, 
preempt. (Side note: the PCMCIA changes in 2.5.64-mm6 seem to work OK with 
3c574_cs)

Charlie

=============================================
/* thud.c */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>
#include <sched.h>

/* These are used as strings so that strcmp can be used as a delay loop */
char *s1, *s2;

/* 20000 is fine on my 333MHz Celeron. Adjust so that system time is not
   excessive */
#define DELAY 20000

void busy_wait(long sec, long usec)
{
  struct timeval tv;
  long long end_usec;
  gettimeofday(&tv,0);
  end_usec=(long long)(sec+tv.tv_sec)*1000000 + tv.tv_usec+usec;
  while (((long long)tv.tv_sec*1000000 + tv.tv_usec) < end_usec)
  {
    gettimeofday(&tv,0);
    strcmp(s1,s2); /* yuck */
  }
}

int main(int argc, char**argv)
{
  struct timespec st={10,50000000};
  int n=DELAY;
  int parent=1;

  if (argc<2) {fprintf(stderr,"Syntax: thud <children>\n"); return 0; }

  s1=malloc(n);
  s2=malloc(n);
  memset(s1,33,n);
  memset(s2,33,n);
  s1[n-1]=0;
  s2[n-1]=0;

  n=atoi(argv[1]);
  fprintf(stderr,"starting %d children\n",n);
  for (; n>0; n--)
    if (fork()==0) { sched_yield(); parent=0; break; }
  while (1)
  {
    nanosleep(&st, 0);
    if (parent) printf("running...");
    if (parent) fflush(stdout);
    busy_wait(6,0);
    if (parent) printf("done\n");
  }
  return 0;
}


