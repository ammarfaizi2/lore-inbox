Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288262AbSAVEjZ>; Mon, 21 Jan 2002 23:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289145AbSAVEjQ>; Mon, 21 Jan 2002 23:39:16 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:56762 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288262AbSAVEjC>; Mon, 21 Jan 2002 23:39:02 -0500
Date: Mon, 21 Jan 2002 20:38:44 -0800 (PST)
From: Dave Olien <oliendm@us.ibm.com>
Message-Id: <200201220438.g0M4cif25304@eng2.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.17 fixing pthread support for SEM_UNDO in semop()
Cc: marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] 2.4.17 fixing pthread support for SEM_UNDO in semop()

The Linux semop() System V semaphore SEM_UNDO should perform SEM_UNDO cleanup
during "process" exit, not during "pthread" exit.  Following is a brief
explanation of the problem, followed by the test program,
followed by a patch for linux 2.4.17.

The test program is pretty simple.  The application creates
several threads using pthread_create().  When one thread performs a semop()
with the SEM_UNDO flag set, the change in sempaphore value performed by
that semop should be "undone" only when the entire application exits, NOT when
that thread exits.  This would be consistent with the description on the
semop(2) manual page, and also with the semop() implementation on many other
UNIX implementations.

However, In the current Linux implementation, the semop is "undone" when the
thread that performed the semop() exits.  This is too soon.  This behavior
has created difficulty in porting to Linux some threaded applications that use
semop().

In the current Linux implementation, each thread currently maintains its own
private list of semundo structures, referenced by current->semundo.  The bug
is that the list of sem_undo structures for a threaded process should be
shared among all the threads in that process.

My patch adds a structure (sem_undohd) that is shared by all the threads in
the threaded application, and controls access to the shared list of sem_undo
structures. current->semundo references are replaced with current->semundohd
references.  I've tried to minimize the impact on tasks that are not using
SEM_UNDO semop() operations, or that are not using pthread_create().

One issue is WHEN should a child task share its sem_undo structures list with
its parent.  Linux uses a collection of flags (CLONE_VM, CLONE_FS, etc) to the
fork() system call, to cause the child task to share various components of
the parent's state.  There is no flag indicating when the child task should
share sem_undo state.  When should a parent task and its child conform to the
POSIX threads behavior for system V semaphores? See the code in copy_semundo()
for how this decision was made.

Below is a test program for this.  The test program's output SHOULD look like:

Waiter, pid = 11490
Poster, pid = 11490, posting
Poster posted
Poster exiting
Waiter waiting, pid = 11490
Waiter done waiting

The Incorrect output on Linux is:

Waiter, pid = 712
Poster, pid = 713, posting
Poster posted
Poster exiting
Waiter waiting, pid = 712


---------------------tsem.c---------------------------------------------------

#include <stdio.h>
#include <unistd.h>
#include <sys/sem.h>
#include <errno.h>
#include <pthread.h>

#define KEY 0x1234

#define NUMTHREADS 2

void *retval[NUMTHREADS]; 
void * waiter(void *);
void * poster(void *);

struct sembuf Psembuf = {0, -1, SEM_UNDO};
struct sembuf Vsembuf = {0, 1, SEM_UNDO};

int sem_id;

main()
{
    int i, pid, rc;
    
    pthread_t pt[NUMTHREADS];
    pthread_attr_t attr;

    /* Create the semaphore set */
    sem_id = semget(KEY, 1, 0666 | IPC_CREAT);
    if (sem_id < 0)
    {
	printf ("semget failed, errno = %d\n", errno);
	exit (1);
    }
    
    /* setup the attributes of the thread        */
    /* set the scope to be system to make sure the process competes on a  */
    /* global scale for cpu   */
    pthread_attr_init(&attr);
    pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);

    /* Create the threads */
    for (i=0; i<NUMTHREADS; i++)
    {
	if (i == 0)
	    rc = pthread_create(&pt[i], &attr, waiter, retval[i]);
	else
	    rc = pthread_create(&pt[i], &attr, poster, retval[i]);
    }

    /* Sleep long enough to see that the other threads do what they are supposed to do */
    sleep(20);

    exit(0);
}


/* This thread sleeps 10 seconds then waits on the semaphore.  As long
   as someone has posted on the semaphore, and no undo has taken
   place, the semop should complete and we'll print "Waiter done
   waiting." */
void * waiter(void * foo)
{
    int pid;
    pid = getpid();

    printf ("Waiter, pid = %d\n", pid);
    sleep(10);

    printf("Waiter waiting, pid = %d\n", pid);
    semop(sem_id, &Psembuf, 1);
    printf("Waiter done waiting\n");
   
    pthread_exit(0);
}

/* This thread immediately posts on the semaphore and then immediately
   exits.  If the *thread* exits, the undo should not happen, and the
   waiter thread which will start waiting on it in 10 seconds, should
   still get it.   */
void * poster(void * foo)
{
    int pid;
   
    pid = getpid();
    printf ("Poster, pid = %d, posting\n", pid);
    semop(sem_id, &Vsembuf, 1);
    printf ("Poster posted\n");
    printf ("Poster exiting\n");
    
    pthread_exit(0);
}

------------------------Begin Patch for linux 2.4.17-------------------------
