Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUBYS7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUBYS6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:58:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36334 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261732AbUBYS4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:56:35 -0500
Message-ID: <403CEFDA.2020707@mvista.com>
Date: Wed, 25 Feb 2004 10:56:26 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Diehl <lists@mdiehl.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: tasklets vs. workqueues
References: <Pine.LNX.4.44.0402210140160.1775-100000@notebook.home.mdiehl.de>
In-Reply-To: <Pine.LNX.4.44.0402210140160.1775-100000@notebook.home.mdiehl.de>
Content-Type: multipart/mixed;
 boundary="------------010009060201060903070704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010009060201060903070704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin Diehl wrote:
> [just saw this - CC-list dropped]
> 
> On Thu, 19 Feb 2004, George Anzinger wrote:
> 
> 
>>Being in process context, you can also change the priority and schedule policy 
>>as needed to fit your application, while you are rather stuck with tasklets in 
>>this regard.
> 
> 
> How would one do that correctly? Something like
> 
> read_lock_irq(&tasklist_lock);
> current->rt_priority = 0;
> current->policy = SCHED_FIFO;
> current->prio = MAX_USER_RT_PRIO - 1;
> read_unlock_irq(&tasklist_lock);
> 
> used to fail for me with SMP kernel - looks like occasional triple-fault 
> leading to the box rebooting all of the sudden. Looking into 
> kernel/sched.c suggests we might need to acquire the runqueue lock as 
> well, but this is private there. - And anyway, AFAICS it's enclosed in 
> tasklist_lock. So given we are currently running when the above code gets 
> executed, taking the tasklist_lock should be sufficient - IMHO at least 
> but reality proved me wrong.
> 
> OTOH, directly calling sys_sched_setscheduler doesn't work (without some 
> set_fs-magic at least), because it is expecting its parameters from 
> userland.

Depends on where you want to be when you do it.  From user land you would do 
exactly what the attached program does.  In SMP you would, likely, want to do 
all the tasks in the work queue (one per cpu).

 From the kernel, again calling setscheduler() is the way to go.  I am not sure 
what is in the community tree just now, but if I recall properly, the scheduler 
itself does this so, one should be able to copy that code.

Ah, yes, there it is in  migration_thread().  It calls setscheduler().


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------010009060201060903070704
Content-Type: text/plain;
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


--------------010009060201060903070704--

