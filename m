Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273580AbRIUPtJ>; Fri, 21 Sep 2001 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRIUPtA>; Fri, 21 Sep 2001 11:49:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9457 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S273580AbRIUPsu>; Fri, 21 Sep 2001 11:48:50 -0400
Message-ID: <3BAB614E.8600D074@mvista.com>
Date: Fri, 21 Sep 2001 08:48:30 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Oliver Xymoron <oxymoron@waste.org>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org> 
		<200109202252.f8KMqLG17327@zero.tech9.net> <1001042255.7291.39.camel@phantasy>
Content-Type: multipart/mixed;
 boundary="------------D577A860B4C4D1696F5996D8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D577A860B4C4D1696F5996D8
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Robert Love wrote:
> =

> On Thu, 2001-09-20 at 18:51, Dieter N=FCtzel wrote:
> > > Does your audio source depend on any files (eg mp3s) and if so, cou=
ld they
> > > be moved to a ramfs? Do the skips go away then?
> >
> > Good point.
> >
> > I've copied one video (MP2) and one Ogg-Vorbis file into /dev/shm.
> > Little bit better but hiccup still there :-(
> =

> As I've been saying, the problem really shouldn't be disk I/O.  I would=

> think (and really hope) the readahead code can fit a little mp3 in
> memory.  Even if not, its a quick read to load it.  The continued blips=

> you see are caused by something, well, continual :)
> =

Are you running your application at some real time priority?  I suspect
that, when dbench starts, it floods the system with a lot of new tasks
and the system must visit each one until it gets back to your ap.  Nice
will only do so much here.  Real time priority is the way to go. =

Attached are a couple of small programs to help here.  "rt" runs a given
ap at a given priority.  I.e. > rt 10 foo, runs foo at priority 10. =

(There are more options, try rt -h.)  getrt reports the priority of a
task.  If you do something like > rt 10 bash   everything you run from
the new bash prompt will be at priority 10.  You must be root to run rt
:(

George

> > dbench 16
> > Throughput 25.7613 MB/sec (NB=3D32.2016 MB/sec  257.613 MBit/sec)
> > 7.500u 29.870s 1:22.99 45.0%    0+0k 0+0io 511pf+0w
> >
> > Worst 20 latency times of 3298 measured in this period.
> >   usec      cause     mask   start line/file      address   end line/=
file
> >  11549  spin_lock        1   678/inode.c         c01566d7   704/inode=
=2Ec
> =

> A single 11ms latency is not bad.  Again, this looks OK.
> =

> > *******************************************************
> >
> > dbench 16 + renice artsd -20 works
> > GREAT!
> >
> > *******************************************************
> =

> Great :)
> =

> > dbench 32 and above + renice artsd -20 fail
> >
> > Writing this during dbench 32 ...:-)))
> >
> > dbench 32 + renice artsd -20
> > Throughput 18.5102 MB/sec (NB=3D23.1378 MB/sec  185.102 MBit/sec)
> > 15.240u 63.070s 3:49.21 34.1%   0+0k 0+0io 911pf+0w
> >
> > Worst 20 latency times of 3679 measured in this period.
> >   usec      cause     mask   start line/file      address   end line/=
file
> >  17625  spin_lock        1   678/inode.c         c01566d7   704/inode=
=2Ec
> =

> What do you mean failed?
> =

> --
> Robert M. Love
> rml at ufl.edu
> rml at tech9.net
> =

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------D577A860B4C4D1696F5996D8
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


--------------D577A860B4C4D1696F5996D8
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

--------------D577A860B4C4D1696F5996D8--

