Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263401AbVBDCXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbVBDCXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVBDCVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:21:36 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:51165 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261921AbVBDCSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:18:32 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Manish Lachwani <mlachwani@mvista.com>
In-Reply-To: <1107481908.27584.448.camel@localhost.localdomain>
References: <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu>
	 <20050104064013.GA19528@nietzsche.lynx.com>
	 <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu>
	 <20050122122915.GA7098@elte.hu>  <20050201201402.GA31930@elte.hu>
	 <1107481908.27584.448.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-+WsnoA4uj0Z3TYzCYNBF"
Organization: Kihon Technologies
Date: Thu, 03 Feb 2005 21:18:10 -0500
Message-Id: <1107483490.27584.459.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+WsnoA4uj0Z3TYzCYNBF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> OK that was the note I was about to send, but like I stated, it isn't a
> problem now that the timer interrupt is back to a hard interrupt. I just
> showing this to you so you can see the real problem.  Maybe I'm missing
> something, and maybe I'm not. I'll try to write up something that shows
> the problem with the timer interrupt as a thread.

Well, I wrote something up and I found a test case that locks the
machine (on 2.6.11-rc2-V0.7.37-03). I've only tried this on
2.6.10-rc3-mm1, where it works.  I don't have anymore time to look into
this today, so I haven't tried it on vanilla 2.6.11-rc2.

The attached file was going to be something that shows what happens when
you have two processes with a higher priority than the timer interrupt.
But unfortunately it locked up 36-03. I tried it on 37-03 too, and it
locked it up as well.  But if I modify this program a little, it runs
fine on both.  

Here's the case:  I have two processes waiting on a semaphore to go to
zero.  Once it does, they both run spin loops, where one sleeps, and the
other just spins for a duration. The parent of these processes, set
their priorities very high and then zeros the semaphore. 

Here's the problem: If I raise the priorities of the processes before
zeroing the semaphore, the machine hangs.  If I zero the semaphore
before raising the priorities, the program runs fine.

You would think that if the problem happened the other way around, it
could be just that one of the high priority spinners is starving
everything else. But the problem occurs if the spinners are SLEEPING! 

Attached is the code that locks up the machine. I'd look into it but
I've already done my 16 hours today ;-)

-- Steve


--=-+WsnoA4uj0Z3TYzCYNBF
Content-Disposition: attachment; filename=timertest.c
Content-Type: text/x-csrc; name=timertest.c; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sched.h>
#include <signal.h>

#define __USE_GNU
#include <sys/ipc.h>

static int int_spinner (int i);
static int spinner (int i);

typedef int (*callfunc_t)(int);

#define NR_PROCS 2
pid_t pids[NR_PROCS];
callfunc_t dofunc[NR_PROCS] = {
	int_spinner,
	spinner,
};



key_t key;
int semid = -1;
int shmid = -1;
int *flags;
pid_t timer_pid;
int timer_prio;


void cleanup(void)
{
	int i;

	for (i=0; i < NR_PROCS; i++) {
		if (pids[0])
			kill(pids[i],SIGKILL);
	}

	if (semid >= 0)
		semctl(semid, 0, IPC_RMID);
	if (shmid >= 0)
		shmctl(shmid, IPC_RMID, NULL);
}

void double_to_tv(double d, struct timeval *tv)
{
	tv->tv_sec = (int)d;
	tv->tv_usec = (int) ((d - (double)tv->tv_sec) * 1000000.0);
	printf ("sec:%d usecs:%d\n",(int)tv->tv_sec,(int)tv->tv_usec);
}

void catchall(int sig)
{
	cleanup();
	psignal(sig,"Caught: ");
	exit(-1);
}

static int compare_timeval(const struct timeval *a, const struct timeval *b)
{
	return (a->tv_sec > b->tv_sec) ? 1 :
		(a->tv_sec < b->tv_sec) ? -1:
		(a->tv_usec > b->tv_usec) ? 1:
		(a->tv_usec < b->tv_usec) ? -1:
		0;
}

static void add_timeval(const struct timeval *a, const struct timeval *b, struct timeval *c)
{

	c->tv_usec = a->tv_usec + b->tv_usec;
	c->tv_sec = a->tv_sec + b->tv_sec;
	while (c->tv_usec > 1000000) {
		c->tv_usec -= 1000000;
		c->tv_sec++;
	}

}

static void sub_timeval(const struct timeval *a, const struct timeval *b, struct timeval *c)
{

	c->tv_usec = a->tv_usec - b->tv_usec;
	c->tv_sec = a->tv_sec - b->tv_sec;
	while (c->tv_usec < 0) {
		c->tv_usec += 1000000;
		c->tv_sec--;
	}

}

static int int_spinner(int i)
{
	struct sembuf sops;
	int semid;
	struct timeval starttv;
	struct timeval endtv;
	struct timeval tv;
	struct timeval lasttv;
	struct timeval nexttv;
	time_t t;
	char timebuf[30];
	unsigned long long starttsc, nowtsc;

	memset(&sops,0,sizeof(sops));
	
	if ((semid = semget(key,1,0)) < 0) {
		perror("semget");
		return -1;
	}
	if ((shmid = shmget(key,30,0600)) < 0) {
		perror("shmget");
		return -1;
	}
	if ((flags = shmat(shmid, NULL, 0)) == (void*)-1) {
		perror("shmat");
		return -1;
	}
	
	printf("int_spinner %d grabbing waiting on sem\n",i);
	if (semop(semid, &sops, 1) < 0) {
		perror("semop");
		return -1;
	}
	printf("int_spinner %d got semaphore\n",i);


	if (gettimeofday(&starttv,NULL) < 0) {
		perror("gettimeofday");
		return -1;
	}

	endtv.tv_sec = 10;
	endtv.tv_usec = 0;

	add_timeval(&starttv,&endtv,&endtv);

	t = time(NULL);
	ctime_r(&t,timebuf);
	timebuf[strlen(timebuf)-1] = 0;

	printf("spinner %d starting loop (%s)\n",i,timebuf);
	lasttv = starttv;

	nexttv = starttv;
	nexttv.tv_sec += 3;

	printf("A sleeping\n");
	(*flags)++;
	sleep(1);
	printf("A a wake\n");
	
	asm ("rdtsc" : "=A"(starttsc));

	do {
		asm ("rdtsc" : "=A"(nowtsc));
		if (nowtsc - starttsc > 7000000000ULL) {
			printf("spinner %d now - start > 7000000000\n",i);
			break;
		}
		if (gettimeofday(&tv,NULL) < 0) {
			perror("gettimeofday (in loop)");
			return -1;
		}
		if (compare_timeval(&tv,&nexttv) > 0) {
			printf("A sleeping\n");
			(*flags)++;
			sleep(1);
			printf("A a wake\n");
			nexttv.tv_sec += 3;
		}
		sub_timeval(&tv,&lasttv,&lasttv);
		lasttv = tv;
	} while(compare_timeval(&endtv,&tv) > 0);

	t = time(NULL);
	ctime_r(&t,timebuf);
	timebuf[strlen(timebuf)-1] = 0;
	printf("spinner %d ended loop flags=%d (%s)\n",i,*flags,timebuf);
	

	return 0;
}

static int spinner(int i)
{
	struct sembuf sops;
	int semid;
	struct timeval starttv;
	struct timeval endtv;
	struct timeval tv;
	struct timeval lasttv;
	struct timeval deltatv;
	time_t t;
	char timebuf[30];
	unsigned long long starttsc, nowtsc;
	int last_flag;

	memset(&sops,0,sizeof(sops));
	
	if ((semid = semget(key,1,0)) < 0) {
		perror("semget");
		return -1;
	}
	if ((shmid = shmget(key,30,0600)) < 0) {
		perror("shmget");
		return -1;
	}
	if ((flags = shmat(shmid, NULL, 0)) == (void*)-1) {
		perror("shmat");
		return -1;
	}
	


	printf("spinner %d grabbing waiting on sem\n",i);
	if (semop(semid, &sops, 1) < 0) {
		perror("semop");
		return -1;
	}

	printf("spinner %d got semaphore\n",i);

	if (gettimeofday(&starttv,NULL) < 0) {
		perror("gettimeofday");
		return -1;
	}

	memset (&deltatv,0,sizeof(deltatv));

	endtv.tv_sec = 10;
	endtv.tv_usec = 0;

	add_timeval(&starttv,&endtv,&endtv);

	t = time(NULL);
	ctime_r(&t,timebuf);
	timebuf[strlen(timebuf)-1] = 0;

	printf("spinner %d starting loop flags=%d (%s)\n",i,*flags,timebuf);
	lasttv = starttv;
	asm ("rdtsc" : "=A"(starttsc));

	last_flag = *flags;
	do {
		asm ("rdtsc" : "=A"(nowtsc));
		if (nowtsc - starttsc > 7000000000ULL) {
			printf("spinner %d now - start > 7000000000\n",i);
			break;
		}
		if (gettimeofday(&tv,NULL) < 0) {
			perror("gettimeofday (in loop)");
			return -1;
		}
		if (*flags != last_flag) {
			printf("spinner %d running again (flags=%d)!\n",i,*flags);
			last_flag = *flags;
		}			

		sub_timeval(&tv,&lasttv,&lasttv);
		if (compare_timeval(&deltatv,&lasttv) < 0)
			deltatv = lasttv;
		lasttv = tv;
	} while(compare_timeval(&endtv,&tv) > 0);
	t = time(NULL);
	ctime_r(&t,timebuf);
	timebuf[strlen(timebuf)-1] = 0;
	printf("spinner %d ended loop (%s) flags=%d (%d.%06d secs delta)\n",
	       i,timebuf,*flags,(int)deltatv.tv_sec,(int)deltatv.tv_usec);
	

	return 0;
}

int set_realtime_priority(pid_t pid, unsigned int prio)
{
	struct sched_param p;
	int ret;

	memset(&p,0,sizeof(p));
	p.sched_priority = prio;
	if ((ret = sched_setscheduler(pid,SCHED_FIFO,&p)) < 0) {
		perror("sched_setscheduler");
	}
	return ret;
}

int main (int argc, char **argv)
{
	int ret=0;
	int i;
	int nr_procs=0;
	struct sched_param p;
	struct sembuf sops;
	unsigned int max;
	
	key = ftok(argv[0],123);

	if (argc >=2) {
		timer_pid = atoi(argv[1]);
		if (sched_getparam(timer_pid,&p) < 0) {
			perror("sched_getparam");
			goto out;
		}
		timer_prio = p.sched_priority;
		printf("timer priority is %d\n",timer_prio);
	}

		

	if ((semid = semget(key,1,IPC_CREAT|IPC_EXCL|0600)) < 0) {
		perror("semget");
		exit (-1);
	}
	if ((shmid = shmget(key,30,IPC_CREAT|IPC_EXCL|0600)) < 0) {
		perror("shmget");
		goto out;
	}
	if ((flags = shmat(shmid, NULL, 0)) == (void*)-1) {
		perror("shmat");
		goto out;
	}
	

	/* Grab the semaphore before anyone else can take it. */
	memset(&sops,0,sizeof(sops));
//	sops.sem_flg = SEM_UNDO;
	sops.sem_op = 1;
	if (semop(semid, &sops, 1) < 0) {
		perror("semop");
		ret = -1;
		goto out;
	}

	for (i=0; i < NR_PROCS; i++) {
		if ((pids[i] = fork()) < 0) {
			perror("fork");
			ret = -1;
			goto out;
		} else if (pids[i] == 0) {
			/* child */
			ret = dofunc[i](i);
			exit(ret);
		}
		nr_procs++;
		/* parent */
	}

	
	signal(SIGINT,catchall);
	signal(SIGILL,catchall);
	signal(SIGFPE,catchall);
	signal(SIGSEGV,catchall);
	signal(SIGBUS,catchall);


	max = sched_get_priority_max(SCHED_FIFO);
	printf("max priority is %d\n",max);
	
	sleep(1);

#if 1
	ret = -1;
	printf("setting priorities\n");
	for (i=0; i < NR_PROCS; i++) {
		printf("setting %d to prio %d\n",i,max-(1+i));
		if (set_realtime_priority(pids[0],max-(1 + i)))
			goto out;
	}
#endif

	printf("parent zeroing semaphore\n");
	sops.sem_op = -1;
       	if (semop(semid,&sops,1) < 0) {
		perror("semop");
		ret = -1;
		goto out;
	}


	while (nr_procs) {
		int status;
		pid_t pid;
		if ((pid = wait(&status)) < 0) {
			perror("wait");
			break;
		}
		for (i=0; i < NR_PROCS; i++) {
			if (pids[i] == pid) {
				pids[i] = 0;
				nr_procs--;
			}
		}
		
	}
	printf("flags = %d\n",*flags);
 out:
	cleanup();
	exit(ret);
}

--=-+WsnoA4uj0Z3TYzCYNBF--

