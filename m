Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131862AbQLHRYO>; Fri, 8 Dec 2000 12:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132034AbQLHRYE>; Fri, 8 Dec 2000 12:24:04 -0500
Received: from frogger.telerama.com ([205.201.1.48]:50700 "EHLO
	frogger.telerama.com") by vger.kernel.org with ESMTP
	id <S131862AbQLHRXt>; Fri, 8 Dec 2000 12:23:49 -0500
Date: Fri, 8 Dec 2000 11:53:07 -0500 (EST)
From: Peter Berger <peterb@telerama.com>
To: linux-kernel@vger.kernel.org
Subject: Pthreads, linux, gdb, oh my! (fwd)
Message-ID: <Pine.BSI.4.02.10012081150130.17198-100000@frogger.telerama.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi.  I have the following tiny test program which fails dramatically,
using pthreads, in a number of fascinating ways on various version of
linux, using various versions of glibc, under various (current) versions
of GDB.  I am honestly not sure if this is a linux bug, a glibc bug, or a
gdb bug, but it runs fine under gdb 5.0 under FreeBSD (running the port of
the linux Pthreads package, even).

So I am sending the test code here; can -anyone- get this to run
correctly, on any version of linux, under gdb?

All the program does is create a thread, wait for that thread to exit,
then iterate and do it again, and again, until MAX_COUNT_SEQ_THREADS is
reached.  So no more than 2 threads should be running at once.  

I have seen two failure modes:  on my machine (linux 2.2.5-22, glibc
2.1.1), when run under gdb 5.0, the created pthreads stick around as
zombies until the machine runs out of resources.  On some friends'
machines (kernel 2.2.15, glibc 2.1.94), the program creates one pthread,
waits for it to exit, and then exits.

The code is enclosed at the end of this message.  Can people try this out
and let me know what results you get? Does anyone have any opinions as to
where the bug is?  And, if the bug is in my code, I will be both relieved
and happy, and look forward to finding out what it is.  If it's a kernel
bug, I submit that this makes pthreads unusable, and want to inquire if
anyone is working on fixing this?

Peter Berger, Network Dilettante 
http://peterb.telerama.com		peterb@telerama.com 
--------------------------thread_test.c------------------------

#include <pthread.h>
#include <stdio.h>

#define MAX_COUNT_SEQ_THREADS 100000

struct thread_group_s {
  pthread_cond_t cond;
  pthread_mutex_t lock;
  int created;
  int running;
  int done;
};

/*
 * This child thread just runs and exits, always being careful
 * to take the mutex whenever it does anything even
 * remotely interesting.
 */
int
threads_test_count_seq_proc(struct thread_group_s *tg)
{
  int broadcast = 0;

  /* We spend a lot of effort to do nothing here! */
#ifdef DEBUG
  printf("Hello...");
#endif /* DEBUG */
  pthread_mutex_lock(&tg->lock);
  tg->running++;
  if (tg->running >= tg->created) {
    broadcast = 1;
  }
  pthread_mutex_unlock(&tg->lock);
  if (broadcast) {
    pthread_cond_broadcast(&tg->cond);
  }
  broadcast = 0;

  pthread_mutex_lock(&tg->lock);
  tg->done++;
  if (tg->done >= tg->running) {
    broadcast = 1;
  }
  pthread_mutex_unlock(&tg->lock);
  if (broadcast) {
    pthread_cond_broadcast(&tg->cond);
  }
#ifdef DEBUG
  printf("goodbye.\n");
#endif /* DEBUG */
  pthread_exit(0);
}

/*
 * This test is designed to ensure that we can create
 * and destroy threads _in sequence_ for as long as
 * we please.  There are only ever 2 threads running
 * at one time.  The main routine creates a thread,
 * and waits for it to exit before creating the next
 * one.
 *
 * If you should find an error in my concurrency/mutex
 * handling, please let me know.
 */
int
main(int argc, char argv[])
{
  struct thread_group_s *tg;
  pthread_t *thread;
  pthread_attr_t *attr;

  int i, rc, detached;

  rc = 0; detached = 0;

  thread = (pthread_t *)malloc(sizeof(*thread));
  tg = (struct thread_group_s *)malloc(sizeof(*tg));
  attr = (pthread_attr_t *)malloc(sizeof(*attr));

  printf("Starting test.\n");
  for(i = 1;
      ((rc == 0) && (i <= MAX_COUNT_SEQ_THREADS));
      i++)
    {
      tg->created = 0; tg->running = 0; tg->done = 0;
      rc = pthread_attr_init(attr);
      if (rc) {
        printf("threads_test: failed initializing pthread attr object: %s\n",
          strerror(rc));
      }

      rc = pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED);
      if (rc) {
        printf("threads_test: couldn't set thread state to detached: %s\n",
          strerror(rc));
      }

      /* Let's double-check, just to be paranoid. */
      rc = pthread_attr_getdetachstate(attr, &detached);
      if (detached != PTHREAD_CREATE_DETACHED) {
        printf("threads_test: thread will not be created detached (fatal).\n");
        exit(1);
      }

      /* Create a thread that will run and exit. */
      rc = pthread_create(thread, attr, (void *)threads_test_count_seq_proc, tg
);
      if (rc) {
        printf("threads_test: failed creating seq thread #%d with %s\n",
          i, strerror(rc));
        return(rc);
      }
      pthread_mutex_lock(&tg->lock);
      tg->created++ ;
      pthread_mutex_unlock(&tg->lock);

      printf("\nthreads_test: thread #%d created...", i);

      /* We wait for all (one) of the threads we have created
         to start. */
      pthread_mutex_lock(&tg->lock);
      while(tg->running < tg->created) {
        pthread_cond_wait(&tg->cond, &tg->lock);
      }
      pthread_mutex_unlock(&tg->lock);

      /* Wait for the thread we created to exit. */
      pthread_mutex_lock(&tg->lock);
      while(tg->done < tg->running) {
        pthread_cond_wait(&tg->cond, &tg->lock);
      }
      pthread_mutex_unlock(&tg->lock);

      printf("done. ", i);

      /*
       * Let's yield just to make sure our other thread has time
       * to clean up.
       */
      rc = sched_yield();
      if (rc) {
        printf("threads_test: error in sched_yield: %s\n", strerror(rc));
      }
    }

  printf("threads_test: Test over.\n");
  return(0);
}



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
