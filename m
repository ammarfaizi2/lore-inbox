Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUHGVxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUHGVxe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHGVxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 17:53:34 -0400
Received: from web13910.mail.yahoo.com ([216.136.172.95]:17558 "HELO
	web13910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264388AbUHGVxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 17:53:10 -0400
Message-ID: <20040807215309.4746.qmail@web13910.mail.yahoo.com>
Date: Sat, 7 Aug 2004 14:53:09 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys

I ran into this problem a few month ago while trying to migrate to 2.6
series at the time, it was using 2.6.1, I figured maybe it was fixed in the
latest kernel, so I tried 2.6.7 but it shows the same signs.

I am running in an interesting problem with, what seems to be, the
scheduler. I managed to create a test program to reproduce it.

This test system I use is an Athlon XP1800+ with 256 Mo RAM with
Redhat 9 installed
(but I could reproduce it the same way with Dual CPU systems).

I can reproduce this problem on 2.6.7 (and before, I could reproduce
it on a redhat kernel linux-2.4.20-19.9)

Kernel that I compiled with and without CONFIG_PREEMPT, SMP on or off,
to see no difference.

Everything is fine on my regular (non redhat) 2.4 kernel (same box).

Basically, here is what's happening on my server:
* I have a daemon running, serving http requests via worker threads.
* I have an other daemon running that does some sanity check on the
system, basically to monitor the box (and it mostly sleeps).

Under load, the sanity check daemon stops running properly. It seems
like all the CPU is given to the http server, even though they are
started the same way. This leads to all sorts of timeouts, not good
for a production server.

So how to reproduce the problem:

I run in one shell a script to check for slowdowns:
A=$(date +%s) ; while true ; do sleep 1s; B=$(date +%s) ; D=$(($B-$A)) ;
if [ $D -ge 3 ] ; then date ; echo ">>>>>>> delta = $D" ; fi ; A=$B ;
done

and in an other, my test program (see below for source code):
./cputest 2 10000 1000 512 &

note: I am running everything from ssh shells, not from X (don't know
if this has any effect for this kind of test).

And after a few seconds, I get this:

Mon Aug 2 14:40:27 PDT 2004
>>>>>>> delta = 3
Mon Aug 2 14:41:37 PDT 2004
>>>>>>> delta = 3
Mon Aug 2 14:41:51 PDT 2004
>>>>>>> delta = 3
Mon Aug 2 14:41:57 PDT 2004
>>>>>>> delta = 3
Mon Aug 2 14:42:12 PDT 2004
>>>>>>> delta = 3

The script takes 3 seconds to execute?!

That means that the script, that sleeps and doesn't use a lot of CPU,
stops getting cycles, for some reason.

On 2.4.x series kernel (from kernel.org, not redhat), I don't get any
output for the script, meaning the
fairness is good between processes (even if I start it with 60 worker
threads instead of 2).

If I try to increase the number of threads to 60 on 2.6.7, the script
gets stuck for very long period of time (I've seen 90 seconds).

I can post the .config file I used for compiling the 2.6.7 kernel, if
needed, but I figured this post was already big enough :)

After seeing a discussion on scheduling problems, I also tried different
patches, in particular the effect of an alternate scheduler from Nick
Piggin:
2.6.7 -> fails with 2 threads
2.6.7-bk20 -> fails with 2 threads
2.6.7-bk20-np8 -> works fine with 2 threads, fails with 20 threads
2.6.7-mm7 -> fails with 2 threads
2.6.7-mm7-np8 -> works fine with 2 threads, fails with 20 threads

Any clue?

Nicolas

compile the code with:

gcc -pthread -D_REENTRANT -lm cputest.c -o cputest
---------------------- cputest.c -----------------------------

#include <pthread.h>
#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <math.h>

int nbthreads = 0;
int iterations = 0;
int run = 1;
int iterations2 = 0;

#define DEFAULTBUFSIZE 1
int globalpipe[2];

int buflen = DEFAULTBUFSIZE;

void exithandler(int s) {
        if (run) {
                run = 0;
                close(globalpipe[0]);
                close(globalpipe[1]);
        }
}

char *fname;


void *thread_code(void *arg) {
        time_t lasttime = time(NULL);
        int jj = (int)arg;
        int localiter = iterations/jj;
        int fd;

        char *buf;

        buf = alloca(buflen);
        if (buf == NULL) {
                printf("Failed to alloca!\n");
                exit(-1);
        }

        do {
                int i;
                time_t newtime;

                for(i=0; i < localiter && run; i++) {
                        int j;
                        double k = 1.0;
                        for(j=0; j < iterations2 && run; j++) {
                                k += j*k;
                                k = (1-k)*(1+k);
                                k = sqrt(k);
                        }
                        if (fd != -1) {
                                if (read(globalpipe[0], buf, buflen)
!= buflen) {
                                        printf("%d, aborted read\n",
jj);
                                }
                        }

                }
                sleep(1);
                newtime = time(NULL);
                printf("%d    delta = %d\n", (int)arg,
newtime-lasttime);
                lasttime = newtime;
        } while (run);
        return NULL;
}


int main(int argc, char **argv) {
        int i;
        pthread_t *mythreads;

        if (argc < 5)
                return -1;

        nbthreads = atoi(argv[1]);
        iterations = atoi(argv[2]);
        iterations2 = atoi(argv[3]);
        buflen = atoi(argv[4]);

        signal(SIGINT, exithandler);

        if (pipe(globalpipe) != 0) {
                return -2;
        }

        mythreads = (pthread_t *)calloc(nbthreads, sizeof(pthread_t));

        for(i=0; i < nbthreads; i++) {
                if (pthread_create(&mythreads[i], NULL, thread_code,
(void *)(i+1)) != 0) {
                        return -5;
                }
                printf("Started %d\n", i);
        }


        void * res;

        char *buf;
        int localbuflen;

        localbuflen = buflen * nbthreads;

        buf = alloca(localbuflen);
        if (buf == NULL) {
                printf("Failed to alloca!\n");
                run = 0;
                exit(-1);
        }

        sleep(3);

        do {
                write(globalpipe[1], buf, localbuflen);
        } while (run);


        for(i=0; i < nbthreads; i++) {
                printf("Waiting %d\n", i);
                pthread_join(mythreads[i], &res);
        }
        return 0;
}

-------------------- end cputest.c -------------------


