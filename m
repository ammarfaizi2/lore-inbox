Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTFRQeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbTFRQeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:34:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52731 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265341AbTFRQeD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:34:03 -0400
Message-ID: <3EF0979C.8060603@mvista.com>
Date: Wed, 18 Jun 2003 09:47:24 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: O(1) scheduler seems to lock up on sched_FIFO and sched_RR tasks
Content-Type: multipart/mixed;
 boundary="------------080607070907050202090903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------080607070907050202090903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It seems that once a SCHED_FIFO or SCHED_RR tasks gets control it does 
not yield to other tasks of higher priority.

Attached is a test program (busyloop) that just loops doing 
gettimeofday() for the requested time and a little utility (rt) to run 
programs at real time priorities.

Here is an annoted example of the problem:

First, become root then:
 > rt 90 bash        <-- run bash at priority 90 SCHED_RR
 > rt -f 30 busyloop 10 &  <-- busyloop 10 at priority 30 SCHED_FIFO

At this point the bash at priority 90 should be available, but is not. 
  When the 10 second busyloop completes, bash returns.

SCHED_RR is a bit different:
 > rt 90 bash        <-- run bash at priority 90 SCHED_RR
 > rt  30 busyloop 10 &  <-- busyloop 10 at priority 30 SCHED_RR

At this point the bash at priority 90 prints the pid and a prompt and 
then does not respond for the duration of the busyloop.  When the 10 
second busyloop completes, bash returns.

The program rt will explain itself if given no parameters.

The program busyloop is just like sleep except that it loops on 
getimeofday() instead of sleeping.

This test was run on a 2.5.70 bk9 system...



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------080607070907050202090903
Content-Type: text/plain;
 name="busyloop.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busyloop.c"

#include <time.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	int end_time;
	struct timeval now;

        if (argc < 2) {
                end_time = 1;
        }else{
               	end_time = atoi(argv[1]);
        }
	if (!time) {
		printf("Bad parms, quiting.\n");
		return 1;
	}

	gettimeofday(&now);

	end_time += now.tv_sec + 1;

	do{
		gettimeofday(&now);

	}while (now.tv_sec < end_time);

	printf("bye now.\n");
	return 0;
}

--------------080607070907050202090903
Content-Type: text/plain;
 name="rt.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt.c"



/*
   rt - a utility to set the realtime priority and scheduling policy
   and now also to set nice values.
*/

/* includes */
#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/resource.h>
#define _GNU_LIBRARY__
#include <getopt.h>

/* defines */

#define RUNSTRING "usage:  rt [-f] [-v] prio [--] runstring  \n \
 or:   rt [-f] [-v] -p PID prio\\ \n\n \
where: prio specifies the realtime priority  \n \
       -f set scheduling policy to SCHED_FIFO \n \
       -o set scheduling policy to SCHED_OTHER \n \
          In this case prio is a nice value -20<->19 \n \
          Use '-- prio' if prio is negative \n \
       -v turns on verbose mode. \n \
       -p PID specifies an existing process to modify \n \
       runstring is a process and parameters \n \
       (use '--' if runstring contains options). \n"

#define POLICY(x)  x ? x-1 ? "SCHED_RR" : "SCHED_FIFO" : "SCHED_OTHER"

/* prototypes */
void print_usage(char *[]);

/* globals */
int verbose=0;  /* 0=none, !0=verbose */


main(int argc, char *argv[])
{
        struct sched_param prio_struct;
        int policy = -1;
        int pid = 0;
        int pidopt = 0;
	int nice;
        int optprobs = 0; /* problems parsing? */
        
        int  c;         /* generic single character */

        /* "standard" option parsing... */
        while ( (c=getopt(argc, argv, "+fop:v?")) != EOF)
        {
        switch (c) {
                case 'f':       /* set FIFO mode */
                        policy = SCHED_FIFO;
                        break;
                case 'o':       /* set SCHED_OTHER mode */
                        policy = SCHED_OTHER;
                        break;
                case 'p':       /* read PID */  
                        sscanf(optarg,"%d",&pid); 
                        pidopt=1;
                        break;
                case 'v':
                        verbose=1;      /* verbosity */
                        break;
                case '?':       /* help? */
                        printf("%s",RUNSTRING);
                        exit(0);
                default:        /* something went wrong */
                        optprobs=1;     /* we'll deal with this problem later */
                        break;
                }
        }

        if (optprobs) {
                fprintf(stderr,RUNSTRING);
                exit(1);
        }


        if((argc - optind) < 2-pidopt) {
                print_usage(argv);
        }

        sscanf(argv[optind], "%d", &(prio_struct.sched_priority));

        /* sanity checking... */
        if ( (prio_struct.sched_priority > 0) && (policy < 0 ) ) {
                policy=SCHED_RR;
                if (verbose)
                  printf("Defaulting sched policy to %s.\n", POLICY(policy));
        }

        if ( (prio_struct.sched_priority == 0 ) && (policy != SCHED_OTHER) ) {
                policy=SCHED_OTHER;
                fprintf(stderr,"Priority of %d implies sched policy of %s.\n",
                        prio_struct.sched_priority,  POLICY(policy)); 
        }


        //policy = (prio_struct.sched_priority)? policy : SCHED_OTHER;
	nice = prio_struct.sched_priority;
	if(policy==SCHED_OTHER)
		prio_struct.sched_priority = 0;	
        if( sched_setscheduler(pid,policy,&prio_struct)){
                perror("Priority out of range");
                print_usage(argv);
        }
	if(policy==SCHED_OTHER){
		if( setpriority(PRIO_PROCESS, pid, nice)){
			perror("Nice out of range");
			print_usage(argv);
		}
        }
        if ( pid ) exit(0);
        argv+=optind;   /* adjust argv to point to the runstring */
        argv++;
        execvp(argv[0],argv);
        perror("exec failed..");
}

void print_usage(char * who[])
{
        printf("%s",RUNSTRING);
        exit (1);
}


--------------080607070907050202090903--

