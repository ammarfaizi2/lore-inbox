Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWDFDNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWDFDNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWDFDNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:13:54 -0400
Received: from dvhart.com ([64.146.134.43]:33990 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751047AbWDFDNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:13:54 -0400
From: Darren Hart <darren@dvhart.com>
To: linux-kernel@vger.kernel.org
Subject: realtime-preempt scheduling - rt_overload behavior
Date: Wed, 5 Apr 2006 20:13:48 -0700
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tdINEKe6o9+PM41"
Message-Id: <200604052013.49222.darren@dvhart.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_tdINEKe6o9+PM41
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have been experimenting with realtime scheduling and have come across som=
e=20
unexpected results.  When running the attached testcase it's apparent that=
=20
lower priority SCHED_FIFO threads are running while higher priority=20
SCHED_FIFO threads sit runnable on another CPU's run_queue.

=46irst, what are the expectations for the realtime scheduler?  Are we tryi=
ng=20
for "system wide strict realtime priority scheduling", should we consider t=
he=20
above scenario a bug?

=46rom what I could gather reading sched.c (2.6.16-rt11), the scheduler wil=
l=20
increment rt_overload anytime a run_queue has 2 RT tasks on it - so=20
rt_overload is >0 anytime NR_CPUS+1 RT tasks are runnable on the system. =20
schedule() calls pull_rt_tasks() anytime it runs and sees that rt_overload =
is=20
> 0 and pulls the highest priority runnable rt task off each run_queue and=
=20
places them on its CPU's run_queue.  I also see that we call=20
smp_send_reschedule() (or similar) when an RT task is waking up or being=20
bumped off the run_queue.  So clearly we are trying to prevent the above=20
scenario from happening.

I'd appreciate your thoughts on this.  Any comments on the test case are al=
so=20
welcome.  As I understand it, sched_yield() will place a SCHED_FIFO task ba=
ck=20
on the active array, and if it is still the highest prio RT task it will ge=
t=20
rescheduled immediately (which it likely is since a higher priority task=20
should have preempted it when it became runnable).

(the testcase "fails" more often on 4way and bigger machines, with around=20
2xCPUS threads per team. './sched_football 8 10' for example.)

Thanks,

=2D-Darren

--Boundary-00=_tdINEKe6o9+PM41
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="sched_football.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sched_football.c"

/*  Threaded Football - by John Stultz <johnstul@us.ibm.com>
 *
 * This is a scheduler test that uses a football analogy.
 * The premise is that we want to make sure that lower priority threads
 * (the offensive team) do not preempt higher priority threads (the
 * defensive team). The offense is trying to increment the balls position,
 * while the defense is trying to block that from happening.
 * And the ref (highest priority thread) will blow the wistle if the
 * ball moves. Finally, we have crazy fans (higer prority) that try to
 * distract the defense by occasionally running onto the field.
 *
 * PS: I really don't like football that much, it just seemed to fit.
 *
 * 2006-03-16  Reduced verbosity, non binary failure reporting, removal of
 *             crazy_fans thread, added game_length argument by Darren Hart.
 */

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <time.h>
#include <string.h>
#include <pthread.h>
#include <sched.h>
#include <errno.h>
#include <sys/syscall.h>

#define MAXTHREADS 256

#define DEF_GAME_LENGTH 5

/* Here's the position of the ball */
volatile int the_ball;

/* Game status */
volatile int game_over;

/* Keep track of who's on the field */
volatile int offense_count;
volatile int defense_count;
volatile int crazyfan_count;

/* simple mutex for our atomic increments */
pthread_mutex_t     mutex = PTHREAD_MUTEX_INITIALIZER;

#define min(x,y) (x < y ? x: y)


/* This is the defensive team. They're trying to block the offense */
void *thread_defense(void* arg)
{
    	pthread_mutex_lock(&mutex);
	defense_count++;
    	pthread_mutex_unlock(&mutex);

	/*keep the ball from being moved */
	while (!game_over) {
		sched_yield(); /* let other defenders run */
	}
}


/* This is the offensive team. They're trying to move the ball */
void *thread_offense(void* arg)
{
    	pthread_mutex_lock(&mutex);
	offense_count++;
    	pthread_mutex_unlock(&mutex);

	while (!game_over) {
		the_ball++; /* move the ball ahead one yard */
		sched_yield(); /* let other offensive players run */
	}
}

void referee(int game_length)
{
	struct timeval start, now;

	printf("Game On (%d seconds)!\n", game_length);

	gettimeofday(&start, 0);
	now = start;
	the_ball = 0;

	/* Watch the game */
	while ((now.tv_sec - start.tv_sec) < game_length) {
		sleep(1);
		gettimeofday(&now, 0);
	}
	/* Blow the whistle */
	printf("Game Over!\n");
        printf("Final ball position: %d\n", the_ball);
	game_over = 1;
}


void create_thread(pthread_t *thread, void*(*func)(void*), int prio)
{
	pthread_attr_t attr;
	struct sched_param param;

	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + prio;

	pthread_attr_init(&attr);
	pthread_attr_setinheritsched (&attr, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedparam(&attr, &param);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

	if (pthread_create(thread, &attr, func, (void *)0)) {
		perror("pthread_create failed");
	}

	pthread_attr_destroy(&attr);
}

int main(int argc, char* argv[])
{
	struct sched_param param;
	int players_per_team, game_length;
	int priority;
	int thread_count = 0;
	pthread_t thread_id[MAXTHREADS];
	int i;

	if (argc < 2 || argc > 3) {
		printf("Usage: %s players_per_team [game_length (seconds)]\n", argv[0]);
		exit(1);
	}

	players_per_team = atoi(argv[1]);
        if (argc == 3)
	    game_length = atoi(argv[2]);
        else
            game_length = DEF_GAME_LENGTH;

	/* We're the ref, so set our priority right */
	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + 80;
	sched_setscheduler(0, SCHED_FIFO, &param);

	/* Start the offense */
	priority = 15;
	printf("Starting %d offense threads at priority %d\n", 
                players_per_team, priority);
	for (i = 0; i < players_per_team; i++)
		create_thread(&thread_id[thread_count],
				thread_offense, priority);
	while (offense_count < players_per_team)
		usleep(100);

	/* Start the defense */
	priority = 30;
	printf("Starting %d defense threads at priority %d\n", 
                players_per_team, priority);
	for (i = 0; i < players_per_team; i++)
		create_thread(&thread_id[thread_count++],
				thread_defense, priority);
	while (defense_count < players_per_team)
		usleep(100);

	/* Ok, everyone is on the field, bring out the ref */
	printf("Starting referee thread\n");
	referee(game_length);

	for (i = 0; i < thread_count; i++) {
		usleep(100);
		pthread_join(thread_id[i], 0);
	}

	return 0;
}


--Boundary-00=_tdINEKe6o9+PM41--
