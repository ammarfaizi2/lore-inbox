Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbRAVPqr>; Mon, 22 Jan 2001 10:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbRAVPqj>; Mon, 22 Jan 2001 10:46:39 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4601 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S131240AbRAVPqa>;
	Mon, 22 Jan 2001 10:46:30 -0500
Importance: Normal
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF705E9D76.E5523D4C-ON852569DC.004A374D@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Mon, 22 Jan 2001 08:35:03 -0500
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.6 |December 14, 2000) at
 01/22/2001 10:46:17 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Per popular demand. Here are a few numbers for small thread counts
running the sched_yield_test benchmark on a 2-way SMP with the following
characteristics.

model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.266
cache size      : 512 KB

I compare 2.4.1-pre8  kernels (vanilla, table/prio scheduler and
multiqueue).

#T : van   prio  MQ
----------------------
 1 : 0.591 0.582 0.750
 2 : 0.295 0.293 0.377
 3 : 2.091 2.373 1.010
 4 : 1.894 1.783 1.558
 5 : 1.949 1.794 1.591
 6 : 2.003 1.803 1.605
 7 : 2.050 1.805 1.654
 8 : 2.118 1.816 1.676
 9 : 2.174 1.811 1.708
10 : 2.235 1.821 1.744
11 : 2.304 1.823 1.780
12 : 2.365 1.831 1.863
13 : 2.427 1.829 1.870
14 : 2.494 1.841 1.950
15 : 2.578 1.839 1.959
16 : 2.691 1.865 2.043
17 : 2.804 1.855 2.041
18 : 2.893 1.873 2.127
19 : 3.001 1.851 2.079
20 : 3.098 1.878 2.182
21 : 3.191 1.851 2.178
22 : 3.263 1.884 2.233
23 : 3.332 1.850 2.231
24 : 3.403 1.901 2.272
25 : 3.472 1.865 2.251
26 : 3.540 1.923 2.305
27 : 3.604 1.872 2.295
28 : 3.680 1.900 2.333
29 : 4.204 1.883 2.329
30 : 4.256 1.944 2.358
31 : 3.875 1.936 2.325
32 : 4.476 1.953 2.339


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Andrea Arcangeli <andrea@suse.de>@lists.sourceforge.net on 01/18/2001
08:30:41 PM

Sent by:  lse-tech-admin@lists.sourceforge.net


To:   Mike Kravetz <mkravetz@sequent.com>
cc:   lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject:  Re: [Lse-tech] Re: multi-queue scheduler update



On Thu, Jan 18, 2001 at 04:52:25PM -0800, Mike Kravetz wrote:
> was less than the number of processors.  I'll give the tests a try
> with a smaller number of threads.  I'm also open to suggestions for

OK!

> what benchmarks/test methods I could use for scheduler testing.  If
> you remember what people have used in the past, please let me know.

It was this one IIRC (it spawns threads calling sched_yield() in loop).

/*
  Tester for the kernel's speed in scheduling.
  (C) 1999 / Willy Tarreau <willy@meta-x.org>

  Modified by Davide Libenzi <davidel@maticad.it>


  You can do whatever you want with this program, but I'm not
  responsible for any misuse. Be aware that it can heavily load
  a host. As it is multithreaded, it might take advantages of SMP.

  It basically creates a growing amount of threads and measures
  their cumulative work (i.e. loop iterations/second). The output
  is easily useable by gnuplot.

  To compile, you need libpthread :

     gcc -O2 -fomit-frame-pointer -o threads threads.c -lpthread

  Output on stdout is :
     <nb_threads> <average_work> <zero_work_threads> <std_deviation>

*/

#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <unistd.h>
#include <time.h>



#define MAXTHREADS  450
#define MEASURE_TIME     60



pthread_t       thr[MAXTHREADS];
int             nbthreads = MAXTHREADS;
int             measure_time = MEASURE_TIME;
volatile        actthreads = 0;

long long int   totalwork[MAXTHREADS];
volatile int    stop = 0,
                start = 0,
                count = 0;

void            oneatwork(int thr)
{
    int             i;
    while (!start)              /* don't disturb pthread_create() */
        usleep(10000);

    actthreads++;
    while (!stop)
    {
        if (count)
            totalwork[thr]++;

        syscall(158); /* sys_sched_yield() */
    }
    actthreads--;
    pthread_exit(0);
}

main(int argc, char **argv)
{

    int             i,
                    err,
                    avgwork,
                    thrzero;
    long long int   value,
                    avgvalue;
    double          sqrdev;
    time_t          ts,
                    te;

    if (argc < 3)
    {
        printf("usage: %s  threads  time\n", argv[0]);
        exit(1);
    }

    nbthreads = atoi(argv[1]);
    measure_time = atoi(argv[2]);


    start = 0;
    count = 0;
    stop = 0;
    actthreads = 0;
    thrzero = 0;
    value = 0;
    sqrdev = 0.0;

    fprintf(stderr, "\nCreating %d threads ...", nbthreads);
    for (i = 0; i < nbthreads; i++)
    {
        if ((err = pthread_create(&thr[i], NULL, (void *) &oneatwork, (void
*) i)) != 0)
        {
            fprintf(stderr, "thread %d pthread_create=%d -> ", i, err);
            perror("");
            exit(1);
        }
        pthread_detach(thr[i]);
    }

    for (i = 0; i < nbthreads; i++)
        totalwork[i] = 0;

    fprintf(stderr, " OK !\nWaiting for all threads to start ...");

    start = 1;
    while (actthreads != nbthreads)
        usleep(10000);         /* waiting for a bit of stability */

    fprintf(stderr, "Go !\n");

    count = 1;
    time(&ts);

    sleep(measure_time);

    count = 0;
    stop = 1;
    time(&te);


    for (i = 0; i < nbthreads; i++)
    {
        value += totalwork[i];
        if (totalwork[i] == 0)
            ++thrzero;
    }
    avgvalue = value / nbthreads;
    value /= (int) difftime(te, ts);
    avgwork = (int) (value / nbthreads);

    for (i = 0; i < nbthreads; i++)
    {
        double          difvv = (double) (totalwork[i] - avgvalue);

        sqrdev += difvv * difvv;
    }

    while (actthreads > 0)
        usleep(10000);

    printf("%d\t\t%lld\t\t%d\t\t%d\t\t%f\n", nbthreads, value, avgwork,
thrzero,
            sqrdev / ((double) nbthreads * avgvalue * avgvalue));

    exit(0);

}

Andrea

_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/lse-tech



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
