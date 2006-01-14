Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423137AbWANAXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423137AbWANAXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423225AbWANAXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:23:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:48069 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423137AbWANAXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:23:45 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1137182991.8283.7.camel@localhost.localdomain>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-inn71vfepdpKHjX9qYUd"
Date: Fri, 13 Jan 2006 16:23:40 -0800
Message-Id: <1137198221.11300.21.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-inn71vfepdpKHjX9qYUd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-01-13 at 15:09 -0500, Steven Rostedt wrote:
> On Fri, 2006-01-13 at 13:55 -0500, Lee Revell wrote:
> 
> > > 
> > > If that's what you want to know?
> > 
> > I want to know if clock_gettime(CLOCK_MONOTONIC, *ts) is actually
> > guaranteed to be monotonic on these machines AKA do we break POSIX
> > compliance or not.
> 
> Nope it doesn't work :-(
> 
> I ran this test:
>  http://www.kihontech.com/tests/rt/monotonic.c
> 
> And got this:
> 
> $ ./monotonic
> main program pid=8477
> hello from thread 0!
> hello from thread 1!
> hello from thread 2!
> hello from thread 3!
> hello from thread 4!
> Failed! prev: 6279.925610302   current: 6279.874615349

Not sure, but I think your test is broken.

While it serializes the checking and exchange of current and last, it
doesn't serialize the actual calling of clock_gettime(). 

Thus you can get something like:

last=0
	A:				B:
1:	now = clock_gettime()
2:					now = clock_gettime()
3:					atomic {
						test(now, last) [2>0]
						last = now
					}
4:	atomic {
		test(now, last) [1>2]
		FAIL!
	}


Attached is a similar testcase that I've been using myself that avoids
this issue (although I just converted it from gettimeofday to
clock_gettime, so there may still be an issue). Let me know if you have
any comments on it.

thanks
-john


--=-inn71vfepdpKHjX9qYUd
Content-Disposition: attachment; filename=threadtest.c
Content-Type: text/x-csrc; name=threadtest.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/* threadtest.c 
 *		by: john stultz (johnstul@us.ibm.com)
 *		(C) Copyright IBM 2004, 2005, 2006
 *		Licensed under the GPL
 */
#include <stdio.h>
#include <sys/time.h>
#include <pthread.h>


/* serializes shared list access */
pthread_mutex_t list_lock = PTHREAD_MUTEX_INITIALIZER;
/* serializes console output */
pthread_mutex_t print_lock = PTHREAD_MUTEX_INITIALIZER;


#define MAX_THREADS 128
#define LISTSIZE 128


int done = 0;

struct timespec global_list[LISTSIZE];
int listcount = 0;


void checklist(struct timespec* list, int size)
{
	int i,j;
	struct timespec *a,*b;

	static int dbgct = 0;
	if(!(dbgct++%7000)){
		printf(".");
		fflush(0);
	}

	/* scan the list */
	for(i=0; i < size-1; i++){
		a = &list[i];
		b = &list[i+1];
		
		/* look for any time inconsistencies */
		if((b->tv_sec <= a->tv_sec)&&
			(b->tv_nsec < a->tv_nsec)){

			/* flag other threads */
			done = 1;

			/*serialize printing to avoid junky output*/
			pthread_mutex_lock(&print_lock);

			/* dump the list */
			printf("\n");
			for(j=0; j< size; j++){
				if(j == i)
					printf("---------------\n");
				printf("%lu:%lu\n", list[j].tv_sec,list[j].tv_nsec);
				if(j == i+1)
					printf("---------------\n");
			}
			printf("TEST FAILED\n");

			pthread_mutex_unlock(&print_lock);


		}
	}
}

/* The Shared Thread shares a global list
 * that each thread fills while holding the lock.
 * This stresses clock syncronization across cpus. 
 */
void* shared_thread(void* arg)
{
	while(!done){
		/* protect the list */
		pthread_mutex_lock(&list_lock);
		
		/* see if we're ready to check the list */
		if(listcount >= LISTSIZE){
			checklist(global_list, LISTSIZE);
			listcount = 0;
		}
		clock_gettime(CLOCK_MONOTONIC, &global_list[listcount++]);
				
		pthread_mutex_unlock(&list_lock);
	}
}


/* Each independent thread fills in its own
 * list. This stresses clock_gettime() lock contention. 
 */
void* independent_thread(void* arg)
{
	struct timespec my_list[LISTSIZE];
	int count;

	while(!done){
		/* fill the list */
		for(count=0; count < LISTSIZE; count++)
			clock_gettime(CLOCK_MONOTONIC, &my_list[count]);
		checklist(my_list, LISTSIZE);
	}
}


int main(int argc, void** argv)
{
	int thread_count = 1, i;
	pthread_t pth[MAX_THREADS];
	void* ret;
	void* (*thread)(void*) = shared_thread;
	
	/* pull the thread count */
	if(argc > 1)
		thread_count = strtol(argv[1],0,0);
	if(thread_count > MAX_THREADS)
		thread_count = MAX_THREADS;

	/* check if we're running independent threads */	
	if(argc == 3 && !strncmp(argv[2],"indie", 5)){
		thread = independent_thread;
		printf("using independent threads\n");
	}
	
	
	system("date");
	printf("spawning %i threads\n", thread_count,0,0);

	/* spawn */
	for(i=0; i < thread_count; i++)
		pthread_create(&pth[i], 0, thread, 0);
	
	/* wait */
	for(i=0; i< thread_count; i++)
		pthread_join(pth[i],&ret);

	system("date");	
	
	/* die */
	return 0;
}

--=-inn71vfepdpKHjX9qYUd--

