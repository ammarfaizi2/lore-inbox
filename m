Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314652AbSDZUMG>; Fri, 26 Apr 2002 16:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314655AbSDZUMF>; Fri, 26 Apr 2002 16:12:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39412 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314652AbSDZUMD>;
	Fri, 26 Apr 2002 16:12:03 -0400
Message-ID: <3CC9B470.74E17F4E@mvista.com>
Date: Fri, 26 Apr 2002 13:11:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: SCHED_FIFO and SCHED_RR in 2.4.7-10custom kernel
In-Reply-To: <F9CC1B4C20A0D411A99E00508BDFA6A203D8AB00@enoasnt101.eto.ericsson.se> <3CC58155000078A8@bgxplex3.bgx.airsys.thomson-csf.com> (added by
			    postmaster@bgxplex3.bgx.airsys.thomson-csf.com)
Content-Type: multipart/mixed;
 boundary="------------F36CC58671919D7E352B12B8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------F36CC58671919D7E352B12B8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Yes, I agree that X may be in the way.  It is also possible, if you are
logging in via telnet or some other remote service that the I/O service
tasks don't have the needed priority.

My solution for X is to bump its priority too.

Attached, find rt, a program to allow you to change the priority of any
task, and getrt a simple reporting program to get the priority of any
task.

By the way, if you have a relatively secure system, and you want to use
telnet, you can set the priority of inetd.  This way all the I/O
services and the resulting session are boosted in priority.  You must do
this ahead of time, after your task goes into a loop, its too late to
boost anything, but once you do this, you should be able to telnet into
the machine even if your task is "lost" in some loop.

-g

Nicolas Bonnefon wrote:
> 
> > My application uses the possibility to change scheduling mechanism. When
> > changing from SCHED_OTHER to SCHED_FIFO or SCHED_RR, my application causes
> > the whole Linux PC to "hang". Prior to launching my own application, I
> > launch a "superbash" application with higher priority than my own
> > application. But I am not able to switch to the window where this
> > "superbash" application is running to kill my own application. The PC
> > simply does not respond to any input from the keyboard.
> 
> Have you tried without running X ?
> A SCHED_FIFO or SCHED_RR task has ALWAYS priority over any SCHED_OTHER
> task, so if your application sits in an infinite loop without blocking, the
> window manager cannot preempt it and you simply cannot switch x-term.
> I think you should carefully debug your app in SCHED_OTHER mode first, and
> then switch to some real-time policy.
> 
> >
> > I have used this mechanism before, and I am quite confident that this
> > worked under kernel 2.4.2. Are you aware of anything that could explain
> > this behaviour?
> 
> It would be surprising, but if you were sure of that, it would deserve some
> deeper investigations !
> 
> Regards
> --
> Nicolas Bonnefon
> Radar Development/Digital Processing Engineer
> Thales Air Defence - 7-9 rue des Mathurins
> 92223 Bagneux - France
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
--------------F36CC58671919D7E352B12B8
Content-Type: text/plain; charset=us-ascii;
 name="getrt.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="getrt.c"

#include <sched.h>
#include <stdlib.h>

main(int args,char* argc[])
{
        struct sched_param p;
        pid_t pid;

        int policy;
        int prio,max_prio,max_rt_prio;
        char * cpolicy;

        if (args < 2) {
                pid = 0;
        }else{
                pid = atoi(argc[1]);
        }
        policy = sched_getscheduler(pid);
        sched_getparam(pid,&p);
        prio = p.sched_priority;
        max_prio = sched_get_priority_max(policy);
        max_rt_prio = sched_get_priority_max(SCHED_FIFO);

        switch(policy){
        case SCHED_OTHER:
                cpolicy = "SCHED_OTHER";
                break;
        case SCHED_RR:
                cpolicy = "SCHED_RR";
                break;
        case SCHED_FIFO:
                cpolicy = "SCHED_FIFO";
                break;
        default:
                perror("sched_getscheduler");
                exit(1);
        }
                
        if (policy == SCHED_OTHER){
                printf("%s at priority %d (MAX_PRIO(%s) = %d, MAX_PRIO(SCHED_FIFO) = %d)\n",
                       cpolicy,      prio,       cpolicy,max_prio,               max_rt_prio);
        }else{
                printf("%s at priority %d (MAX_PRIO(%s) = %d)\n",
                       cpolicy,       prio,      cpolicy, max_prio);
        }
        exit(0);
}


--------------F36CC58671919D7E352B12B8
Content-Type: text/plain; charset=us-ascii;
 name="rt.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt.c"



/*
   rt - a utility to set the realtime priority and scheduling policy
*/

/* includes */
#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <unistd.h>
#define _GNU_LIBRARY__
#include <getopt.h>

/* defines */

#define RUNSTRING "usage:  rt [-f] [-v] prio [--] runstring  \n \
 or:   rt [-f] [-v] -p PID prio\\ \n\n \
where: prio specifies the realtime priority  \n \
       -f set scheduling policy to SCHED_FIFO \n \
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
        int optprobs = 0; /* problems parsing? */
        
        int  c;         /* generic single character */

        /* "standard" option parsing... */
        while ( (c=getopt(argc, argv, "+fp:v?")) != EOF)
        {
        switch (c) {
                case 'f':       /* set FIFO mode */
                        policy = SCHED_FIFO;
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
        if ( (prio_struct.sched_priority != 0) && (policy < 0 ) ) {
                policy=SCHED_RR;
                if (verbose)
                  printf("Defaulting sched policy to %s.\n", POLICY(policy));
        }

        if ( (prio_struct.sched_priority == 0 ) && (policy != SCHED_OTHER) ) {
                policy=SCHED_OTHER;
                fprintf(stderr,"Priority of %d implies sched policy of %s.\n",
                        prio_struct.sched_priority,  POLICY(policy)); 
        }


        policy = (prio_struct.sched_priority)? policy : SCHED_OTHER;
        if( sched_setscheduler(pid,policy,&prio_struct)){
                perror("Priority out of range");
                print_usage(argv);
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



--------------F36CC58671919D7E352B12B8--

