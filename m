Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136531AbRASBae>; Thu, 18 Jan 2001 20:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136629AbRASBaZ>; Thu, 18 Jan 2001 20:30:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7176 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136531AbRASBaL>; Thu, 18 Jan 2001 20:30:11 -0500
Date: Fri, 19 Jan 2001 02:30:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119023041.F32087@athlon.random>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119012616.D32087@athlon.random> <20010118165225.E8637@w-mikek.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010118165225.E8637@w-mikek.des.sequent.com>; from mkravetz@sequent.com on Thu, Jan 18, 2001 at 04:52:25PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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



#define MAXTHREADS	450
#define MEASURE_TIME	60



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
        if ((err = pthread_create(&thr[i], NULL, (void *) &oneatwork, (void *) i)) != 0)
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

    printf("%d\t\t%lld\t\t%d\t\t%d\t\t%f\n", nbthreads, value, avgwork, thrzero,
            sqrdev / ((double) nbthreads * avgvalue * avgvalue));

    exit(0);

}

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
