Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSE3RyM>; Thu, 30 May 2002 13:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316781AbSE3RyL>; Thu, 30 May 2002 13:54:11 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:64753 "EHLO
	imgserv04.imerge.co.uk") by vger.kernel.org with ESMTP
	id <S316780AbSE3RyI>; Thu, 30 May 2002 13:54:08 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB09C992@imgserv04>
From: Ian Collinson <icollinson@imerge.co.uk>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
Date: Thu, 30 May 2002 18:54:46 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	

	We're having problems with realtime scheduling (SCHED_RR and
SCHED_FIFO), on 2.4 kernels >= 2.4.10 (built for i386, no SMP).  We have an
app that uses real-time scheduled threads. To aid debugging, in case of
realtime threads spinning and locking the system, we always keep a bash
running on a (text) console, at SCHED_RR, priority 99 (a higher priority
than any threads in our app).  We test that this is a valid approach by
running a lower priority realtime app, on another console, that sits in an
infinite busy loop.  This has always worked, and we've been able to
successfully use the high-priority bash to run gdb, and so on.  This is also
what the man page for sched_setscheduler suggests, to avoid total system
lock up.

	But, it seems to have stopped working with 2.4 kernels >= 2.4.10,
(have tried up to 2.4.19-pre9).  Once the lower priority realtime process is
running, the higher priority shell doesn't pre-empt it, and locks up.

	Details of the test:

	I have a "realtime" app, that sets the scheduling policy and
priority, then forks a specified app, and "eat_cpu", that just sits in an
infinite loop.  Both are attached.
	
	On one console (as root), I do

	> realtime -rr 99 bash
	
	Which gives me a priorty 99, SCHED_RR bash. Then, on another console
(also as root), I do:

	> sleep 10; realtime -rr 50 eat_cpu

	Then I switch back to the first console, with its priority 99 bash.
I am able to type away for 10 seconds, until the priority 50 process starts,
at which point the shell locks up.   I can get the same effect on one
console with:

	> ( sleep 10; realtime -rr 50 eat_cpu ) & realtime -rr 99 bash

	Previously, the high-priority shell would never lock up.  Now it
does.

	Any idea why this doesn't work?

	Cheers,
	Ian

Code:

/* realtime
 * To build:
 *   g++ -o realtime realtime.cxx
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sched.h>
#include <unistd.h>
#include <string>


void usage()
{
  printf("usage: realtime -get | {-rr | -fifo} <pri> cmd ...\n");
  exit(1);
}

const char *policyString(int policy)
{
  switch(policy)
  {
  case SCHED_OTHER:   return "SCHED_OTHER";
  case SCHED_FIFO:    return "SCHED_FIFO";
  case SCHED_RR:      return "SCHED_RR";
  }
  return "BAD POLICY";
}

int main(int argc, char *argv[])
{
  seteuid(getuid());

  if (argc < 2)
    usage();

  if (strcmp(argv[1], "-get") == 0)
  {
    int policy = sched_getscheduler(0);
    if (policy < 0)
    {
      perror("sched_getscheduler failed:");
      return 1;
    }

    sched_param param;
    if (sched_getparam(0, &param) < 0)
    {
      perror("sched_getparam failed");
      return 1;
    }

    printf("policy = %d = %s\n", policy, policyString(policy));

    if (policy != SCHED_OTHER)
      printf("priority=%d\n", param.sched_priority);

    int max = sched_get_priority_max(policy);
    if (max < 0) {
      perror("sched_get_priority_max");
      return 1;
    }
    int min = sched_get_priority_min(policy);
    if (min < 0) {
      perror("sched_get_priority_min");
      return 1;
    }                                                        
    printf("prorities: min = %d, max = %d\n", min, max);

    return 0;

  }

  // set

  if (argc < 4)
     usage();

  int policy;

  if (!strcmp(argv[1], "-rr"))
  {
    policy = SCHED_RR;
  }
  else if (!strcmp(argv[1], "-fifo"))
  {
    policy = SCHED_FIFO;
  }
  else {
    printf("bad policy: choose -rr (round robin) or -fifo\n");
    usage();
  }
    
  struct sched_param param;
  param.sched_priority = atoi(argv[2]);

  printf("policy = %d = %s\n", policy, policyString(policy));
  printf("priority=%d\n", param.sched_priority);

  // become root
  seteuid(0);

  if (sched_setscheduler(0, policy, &param) < 0) {
    perror("sched_setscheduler");
    return 1;
  }

  // back down
  seteuid(getuid());

  string cmd;
  for (int i=3; i<argc; i++)
    cmd = cmd + argv[i] + " ";

  printf("cmd = %s\n", cmd.c_str());

  system(cmd.c_str());

  return 0;
}

/* eof */

/* eat_cpu.c */
int main(int argc, char *argv[])
{
  for (;;)
    ;
}    
/* eof */



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


