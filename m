Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbULIQAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbULIQAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULIQAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:00:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:6370 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261536AbULIP7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:59:45 -0500
Date: Thu, 9 Dec 2004 16:59:43 +0100 (MET)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: alan@redhat.com, manfred@colorfullife.com
Cc: michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: System V semaphore bug in kernel 2.6
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <25686.1102607983@www38.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Manfred, Alan,

I assume you are still the relevant people to know about 
this nowadays...

Somewhere in the reworking of the System V semaphore code 
(ipc/sem.c or nearby) in Linux 2.6, a bug appears to have 
been introduced.  

This bug means that in some cases, a process that 
is blocked waiting for a semaphore's value to become 
zero is not woken up, even when that semaphore's value 
does become zero (perhaps the problem is more general, 
but this is the example that I've observed).

I have not spotted where the problem is in the code, but 
have attached a program that demonstrates the error.  
This program does the following:

-- Creates a semaphore set containing two members, and 
   initialises them to 1 and 0 using SETALL.

-- Creates a series of children that perform the 
   following operations:

             operation on 
           sem 0       sem 1     

Child 1     -1          -1       (blocks)
Child 2  wait-for-0    [none]
Child 3    [none]       +1       (child 1 and 2 should now unblock)
Child 4  wait-for-0    [none]       


What happens on Linux 2.6.9 is that the operation 
performed by child 3 does NOT unblock child 1.  Furthermore, 
child 4's operation, which is just the same as child 2's, 
proceeds without blocking, while child 2 remains blocked.


On Linux 2.6.9 (2.6.1 gave the same results), my program 
shows the following:

==
$ ./sem_2.6_bug_demo
Thu Dec  9 16:52:02 CET 2004
Linux tekapo 2.6.9 #3 SMP Tue Oct 19 10:19:40 CEST 2004 i686 i686 i386
GNU/Linux
semid = 0
Semaphore values changed (PID=8462)
8466: Child 1 about to semop
8467: Child 2 about to semop
8468: Child 3 about to semop
8468: Child 3 semop COMPLETED
8466: Child 1 semop COMPLETED
Sem #  Value  SEMPID  SEMNCNT  SEMZCNT
  0       0    8466      0        1
  1       0    8466      0        0
8469: Child 4 about to semop
8469: Child 4 semop COMPLETED
Waited on PID 8466 successfully
Waited on PID 8468 successfully
Waited on PID 8469 successfully
==

Note the absence of any message saying that child 2 completed, 
and that only 3 children were waited on.

On Linux 2.4.24, I see the following:

==
$ ./sem_2.6_bug_demo
Thu Dec  9 17:05:00 CET 2004
Linux tekapo 2.4.28 #2 SMP Wed Dec 1 07:02:01 CET 2004 i686 i686 i386
GNU/Linux
semid = 65538
Semaphore values changed (PID=2288)
2292: Child 1 about to semop
2293: Child 2 about to semop
2294: Child 3 about to semop
2292: Child 1 semop COMPLETED
2294: Child 3 semop COMPLETED
2293: Child 2 semop COMPLETED
Sem #  Value  SEMPID  SEMNCNT  SEMZCNT
  0       0    2293      0        0
  1       0    2292      0        0
2295: Child 4 about to semop
2295: Child 4 semop COMPLETED
Waited on PID 2295 successfully
Waited on PID 2294 successfully
Waited on PID 2293 successfully
Waited on PID 2292 successfully
==

Cheers,

Michael



/* sem_2.6_bug_demo.c

   Michael Kerrisk, Dec 2004
*/
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/stat.h>

#define errExit(msg)            { perror(msg); exit(EXIT_FAILURE); }

union semun {   /* Used in calls to semctl() */
    int                 val;
    struct semid_ds *   buf;
    unsigned short *    array;
#if defined(__linux__)
    struct seminfo *    __buf;
#endif
};

#define NOOP -999999

/* Create a child process that performs an operation on the
   semaphores in the set referred to by 'semid', which must
   contain exactly two semaphores.

   'cnum' is just a number used in messages printed by the 
   function.

   'op0' specifies the sem_op value for semaphore 0 in the set;
   'op1' specifies the sem_op value for semaphore 1 in the set.
   If 'op0' or 'op1' is NOOP then no operation is performed on
   the corresponding semaphore.  */

static void
child(int cnum, int semid, int op0, int op1)
{
    struct sembuf sops[2];
    pid_t pid;
    int nsops;

    pid = fork();
    if (pid == -1) errExit("fork1");

    if (pid == 0) {
        nsops = 0;

        if (op0 != NOOP) {
            sops[nsops].sem_num = 0;
            sops[nsops].sem_flg = 0;
            sops[nsops].sem_op = op0;
            nsops ++;
        } 

        if (op1 != NOOP) {
            sops[nsops].sem_num = 1;
            sops[nsops].sem_flg = 0;
            sops[nsops].sem_op = op1;
            nsops ++;
        } 

        printf("%ld: Child %d about to semop\n", (long) getpid(), cnum);
        if (semop(semid, sops, nsops) == -1)
            errExit("semop");
        printf("%ld: Child %d semop COMPLETED\n", (long) getpid(), cnum);

        exit(EXIT_SUCCESS);
    } /* if */

    /* Parent returns */
} /* child */

int
main(int argc, char *argv[])
{
    union semun arg, dummy;
    int semid;
    pid_t pid;
    int j;

    system("date; uname -a");

    setbuf(stdout, NULL);

    semid = semget(IPC_PRIVATE, 2,
            IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
    if (semid == -1) errExit("semget");

    printf("semid = %d\n", semid);

    /* Initialise set */

    arg.array = calloc(2, sizeof(arg.array[0]));
    if (arg.array == NULL) errExit("calloc");

    arg.array[0] = 1;
    arg.array[1] = 0;

    /* State of semaphores is now { 1, 0 } */

    if (semctl(semid, 0, SETALL, arg) == -1) errExit("semctl-SETALL");
    printf("Semaphore values changed (PID=%ld)\n", (long) getpid());

    child(1, semid, -1, -1);    /* Decrease both sems */
    sleep(1);
    child(2, semid, 0, NOOP);   /* Wait for sem 0 to equal 0 */
    sleep(1);
    child(3, semid, NOOP, 1);   /* Increase sem 1 */
    sleep(1);

                /* This SHOULD allow child 1 and child 2 to complete,
                   but on Linux 2.6, child 2 is not woken up. */

    /* State of semaphores is now { 0, 0 } */

    /* Display current state of semaphores */

    if (semctl(semid, 0, GETALL, arg) == -1) errExit("semctl-GETALL");
    printf("Sem #  Value  SEMPID  SEMNCNT  SEMZCNT\n");
    for (j = 0; j < 2; j++)
        printf("%3d   %5d   %5d  %5d    %5d\n", j, arg.array[j],
                semctl(semid, j, GETPID, dummy),
                semctl(semid, j, GETNCNT, dummy),
                semctl(semid, j, GETZCNT, dummy));

    /* The following is exactly the same as child 2; on Linux 2.6
       this child succeeds in waiting for semaphore 0 to be 0, even
       while child 2 is blocked on the same operation.  */

    child(4, semid, 0, NOOP);   /* Wait for sem 0 to equal 0 */
    sleep(1);

    while ((pid = waitpid(0, NULL, WNOHANG)) > 0)
        printf("Waited on PID %ld successfully\n", (long) pid);

    exit(EXIT_SUCCESS);
} /* main */

-- 
NEU +++ DSL Komplett von GMX +++ http://www.gmx.net/de/go/dsl
GMX DSL-Netzanschluss + Tarif zum supergünstigen Komplett-Preis!
