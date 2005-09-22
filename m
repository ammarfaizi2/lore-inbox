Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbVIVMNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVIVMNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVIVMNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:13:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:19629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030274AbVIVMNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:13:51 -0400
Date: Thu, 22 Sep 2005 14:13:50 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: mingo@elte.hu, roland@redhat.com
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
Subject: Process with many NPTL threads terminates slowly on core dump signal
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <20206.1127391230@www22.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland, Ingo,

I'm guessing that one of you might best be able to determine the 
cause of the behaviour I'm seeing below.

I wrote a program (below) to investigate the operation of the
RLIMIT_CPU resource limit and I encountered a strangeness: if the
program creates a large number of threads, then it takes a very long
to terminate if it receives a signal that may cause a core dump.

I first noticed this happening on receipt of a SIGXCPU (since the
program is designed to consume infinite CPU time).  However, I then
determined that the behaviour occurs on receipt of any signal that
can generate a core dump.

Here's an example run (Linux 2.6.14-rc2, x86, NPTL 2.3.4) -- the
program is asked to set a soft RLIMIT_CPU of 5 seconds, and to
create 20 threads:

==========
$ ulimit -c 0
$ time ./thread_share_RLIMIT_CPU 5 20
Linux tekapo 2.6.14-rc2 #6 SMP PREEMPT Wed Sep 21 09:29:36 CEST 2005 i686
i686 i386 GNU/Linux
Thu Sep 22 14:01:16 CEST 2005
Main thread changed soft CPU resource limit to: 5
Thread 3 cpu=0.21
Thread 3 cpu=0.42
Thread 3 cpu=0.63
Thread 3 cpu=0.84
Thread 3 cpu=1.05
Thread 3 cpu=1.26
[Here, I type ^\, generating SIGQUIT]
Quit

real    0m13.690s
user    0m1.388s
sys     0m11.977s
==========

In the above, one can see a large amount of (system) CPU time 
consumed.

In a similar run, sending SIGINT (^C) does not cause this long delay
before process termination.  Some further experimentation determined
the following:

* The slow process termination time only occurs for those signals that
  may generate core dumps (verified by sending signals using kill(1)
  from another terminal window).

* The slow startup time occurs even if RLIMIT_CORE is set to 0 (see
  the example above above).

* If the example program is made set-user-UD-root (thus
  mm->dumpable == 0), then the problem does not occur.

* I wondered if the fact that the threads were all trying to hog CPU
  might have some bearing on the problem.  However, even if I make
  the threads pause(), the problem is still observable.

All of this makes me think the problem might be somewhere around
do_coredump()/soredump_wait(), but the problem is not immediately
obvious to me.

Cheers,

Michael


/* thread_share_RLIMIT_CPU.c

   Usage: thread_share_RLIMIT_CPU [CPU-soft-limit [num-threads]]
*/
#include <sys/types.h>
#include <sys/times.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#define errExit(msg)            { perror(msg); exit(EXIT_FAILURE); }

#define errExitEN(en, msg)      { errno = en; perror(msg); \
                                  exit(EXIT_FAILURE); }

static void *
tfunc(void *x)
{
    struct tms tms;
    int cpuCentisecs, prevCpu, j;

    usleep(20000);      /* Give main() a small chance to create other
                           threads before we start consuming CPU time */

    // pause();

   /* Following consumes CPU time and prints messages
       allowing us to track CPU consumption */

    prevCpu = 0;
    for (;;) {
        for (j = 0; j < 100000; j++)
            continue;           /* So main loop consumes mostly
                                   user-mode CPU time */

        if (times(&tms) == -1) errExit("times");
        cpuCentisecs = (tms.tms_utime + tms.tms_stime) * 100 /
                        sysconf(_SC_CLK_TCK);
        if (cpuCentisecs > prevCpu + 20) {
            printf("Thread %d cpu=%0.2f\n", (int) x,
                    cpuCentisecs / 100.0);
            prevCpu = cpuCentisecs;
        }
    }
    return NULL;
}

int
main(int argc, char *argv[])
{
    pthread_t thr;
    int s, numThreads, tn;
    struct rlimit rlim;

    system("uname -a; date");

    if (getrlimit(RLIMIT_CPU, &rlim) == -1) errExit("getrlimit");
    rlim.rlim_cur = (argc > 1) ? atoi(argv[1]) : 3;
    if (setrlimit(RLIMIT_CPU, &rlim) == -1)
        errExit("setrlimit-ORIG_LIMIT");

    if (getrlimit(RLIMIT_CPU, &rlim) == -1) errExit("getrlimit");
    printf("Main thread changed soft CPU resource limit to: %ld\n",
            (long) rlim.rlim_cur);

    numThreads = (argc > 2) ? atoi(argv[2]) : 2;

    for (tn = 0; tn < numThreads; tn++) {
        s = pthread_create(&thr, NULL, tfunc, (void *) tn);
        if (s != 0) errExitEN(s, "pthread_create");
    } 

    pause();
} /* main */

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner
