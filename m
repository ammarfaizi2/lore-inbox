Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVEJVGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVEJVGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEJVEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:04:37 -0400
Received: from pC19EBF81.dip.t-dialin.net ([193.158.191.129]:23300 "EHLO
	gateway2.croq.loc") by vger.kernel.org with ESMTP id S261797AbVEJVAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:00:47 -0400
Message-ID: <428120B5.5060403@free.fr>
Date: Tue, 10 May 2005 22:59:33 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: roland@frob.com, alexn@dsv.su.se, mingo@elte.hu
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
References: <4279084C.9030908@free.fr> <Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com> <20050504191604.GA29730@nevyn.them.org> <Pine.LNX.4.61.0505042031120.22323@chaos.analogic.com> <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all


I worked on my problem in the last days, and I came to these main 2 
questions:

- Can a SIGSTOP be in a pending state in Linux?

- If kill(SIGSTOP,...) returns, does that mean that the corresponding 
process is completly suspended?


I thought until now that SIGSTOP was so special that it could never be
pending, and that as soon as:
signal(SIGSTOP,pid)
returned, then it was assured that the corresponding process (and all
its threads) were suspended.

This would make sense in my opinion, but apparently it is not always the
case, and the POSIX norm do not say anything about that.

Any hint?


I did also some experiments, with one program which fork()s into:

- a child which potentially starts threads and does some stuff

- a parent which regularly sends SIGSTOP to the child and check if the 
activity really stopped, and then send SIGCONT again

You will find the source code below.

I tried that with different scheduling policies (SCHED_OTHER and 
SCHED_RR) and different number of threads:
- 0: no thread started (ie. mono threaded child)
- 1: 1 thread started, and the main task just pthread_join() it
- 2: 2 threads started, and the main task pthread_join() them

I came to the following results:

    Policy   OTHER   RR
Threads
0           OK      OK
1           FAIL    OK
2           FAIL    FAIL(1)


- the answer to my 2 questions (see above) see to be No and Yes 
respectively when no thread is started

- (1) For RR with 2 threads, there are 2 observed behaviour, apparently 
happening randomly:

  * either the parent call always stop instantaneously all threads (like 
when no thread is started), and that for a long time

  * or right at the beginning, we can observe that the parent can not do 
that

I find this behaviour really strange.

Any idea?

Can one rely on the fact that the SIGSTOP operates instantaneously for 
non-threaded applications?

Would it be possible to provide that for all applications?




#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sched.h>
#include <sys/time.h>

#include <sys/types.h>
#include <sys/wait.h>
#include <sys/ipc.h>
#include <sys/shm.h>


#include <pthread.h>


int set_process_sched(pid_t pid, int policy, int priority) {
   struct sched_param p;

   p.sched_priority = priority;

   if ( 1 || policy != sched_getscheduler(pid) ) {
     if ( sched_setscheduler(pid,policy,&p) ) {
       perror("sched_setscheduler()");
       return 1;
     }
   }

   return 0;
}

unsigned long long gettime(void ) {

   struct timeval tv;

   if ( gettimeofday(&tv, NULL) ) {
     perror("gettimeofday()");
     return 0;
   }

   return (tv.tv_usec + tv.tv_sec * 1000000LL);
}

typedef struct {
   int         thread_nb; /* id defined by us */
   pthread_t   thread_id; /* system id of the thread */
} thread_data;


int   cont_main_loop = 1;


void sigterm_handler(int dummy) {
   printf("sigterm_handler\n");
   return;
}


/* We use a shared memory to communicate between the parent and the child
    They all only work in the first few bytes
*/
int     shmid;
unsigned long long int     *shared_array;
#define SHM_SIZE 1024

static inline void conf_shmem(void ) {

   shmid = shmget(IPC_PRIVATE, SHM_SIZE, 0666 | IPC_CREAT);
   if (shmid == -1) {
     perror("shmget()");
     exit(0);
   }

   shared_array = (long long int *) shmat(shmid, 0, 0);
   if (! shared_array ) {
     perror("shmat()");
     exit(0);
   }
}


void loop(int marker) {
   unsigned long long int begin = gettime();
   /* run for 2 minutes at max
      (useful in case we end up with a busy loop in SCHED_RR... */
   while ( gettime() - begin < 120000000LL ) {
     /* write in the shared memory */
     shared_array[0] = marker;
   }
}

void *go_thread(void *dummy) {
   thread_data *data = (thread_data *) dummy;
   loop(data->thread_nb);
   fprintf(stderr,"%llu\tQuitting!\n",gettime());
   return NULL;
}


#define MAX_THREADS 100

int main(int argc, char **argv)
{
   int pid;
   int test_failed = 0;
   unsigned long long exec_begin = gettime();
   int nb_threads = 0;


   conf_shmem();
   shared_array[0] = 0;

   if ( argc > 1 )
     nb_threads = atoi(argv[1]);
   if ( nb_threads > MAX_THREADS )
     nb_threads = MAX_THREADS;

   pid = fork();

   switch ( pid ) {

     case 0: /* child */
     {
       int thread;
       thread_data threads[MAX_THREADS];

       if ( nb_threads == 0 ) {
         /* no multi threading */
         loop(1);
         break;
       }

       /* start the threads */
       for ( thread = 0 ; thread < nb_threads ; thread ++) {
         threads[thread].thread_nb = thread + 1;
         if ( pthread_create (  & threads[thread].thread_id,
                           NULL,
                           go_thread,
                           (void *)&threads[thread]) )
           perror("pthread_create");

       }

       {
         int thread;
         for ( thread = 0 ; thread < nb_threads ; thread ++) {
           pthread_join (  threads[thread].thread_id, NULL);
         }
       }
       exit(0);
     }

     default: /* parent */
     {
       unsigned long long begin = gettime();

       /* depending whether we set the priorities or not,
          we get different results.
       */

       set_process_sched(0, SCHED_RR, 65);
       set_process_sched(pid, SCHED_RR, 60);


       /* run for 10s */
       while ( gettime() - begin < 10000000 ) {
         unsigned long long int b_stop, a_stop;

         /* let the child run a little bit */
         usleep(1000);

         /* stop it */
         kill(pid, SIGSTOP);

         /* Reset our flag */
         shared_array[0] = 0;

         /* Wait to see if someone dare overwriting our nice zero */
         usleep(1000);
         if ( shared_array[0] > 0 ) {
           test_failed = shared_array[0];
           break;
         }
         kill(pid, SIGCONT);
       }
       kill(pid, SIGKILL);
       break;
     }

     case -1:
       perror("fork()");
       exit(0);
   }

   system("uname -a");
   printf("%d thread(s)\n",nb_threads);
   if ( ! test_failed )
     printf("test passed");
   else
     printf("test FAILED (%d)",test_failed);
   printf(" after %f s\n\n", ( gettime() - exec_begin) / 1000000.0 );

   return 0;
}


