Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWHOFyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWHOFyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 01:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWHOFyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 01:54:08 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:38552 "EHLO
	dhcp119.mvista.com") by vger.kernel.org with ESMTP id S965118AbWHOFyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 01:54:07 -0400
Date: Mon, 14 Aug 2006 22:54:23 -0700
Message-Id: <200608150554.k7F5sNmB000870@dhcp119.mvista.com>
Subject: Re: [patch] fix posix timer errors
From: Toyo Abe <toyoa@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for correcting me.

Andrew Morton wrote:
>> diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
>> index 1fc1ea2..479b16b 100644
>> --- a/kernel/posix-cpu-timers.c
>> +++ b/kernel/posix-cpu-timers.c
>> @@ -1477,7 +1477,7 @@ int posix_cpu_nsleep(const clockid_t whi
>>  
>>  	error = do_cpu_nanosleep(which_clock, flags, rqtp, &it);
>>  
>> -	if (error = -ERESTART_RESTARTBLOCK) {
>> +	if (error == -ERESTART_RESTARTBLOCK) {
>>  
>>  	       	if (flags & TIMER_ABSTIME)
>>  			return -ERESTARTNOHAND;
>> @@ -1511,7 +1511,7 @@ long posix_cpu_nsleep_restart(struct res
>>  	restart_block->fn = do_no_restart_syscall;
>>  	error = do_cpu_nanosleep(which_clock, TIMER_ABSTIME, &t, &it);
>>  
>> -	if (error = -ERESTART_RESTARTBLOCK) {
>> +	if (error == -ERESTART_RESTARTBLOCK) {
>
> This is the sort of thing which should have been caught in testing, but it
> wasn't, which raises questions about how well-tested the rest of it is?
>
> Plus it will have generated compiler warnings.
>
I'm so sorry that my initial verification was not good enough. I'd tested only
the error cases, which I found. So I didn't catch the mistakes. It's my fault.

Therefore, I did some additional tests with the patches and the mistakes fixed.
I'll re-post the revised patch set later for confirmation.

The test cases are as follows;
 - The timer tests of Open POSIX test suite ver. 1.5.1
 - My initial test cases (Interrupted sleep)
   and some additional test cases (Non-interrupted sleep)

My testcases is inlined at the bottom of this email.

The tested environments are as follows;
 - Hardware: EM64T box
 - Archtechture: x86_64(64bit)
 - Base kernel: vanilla kernel 2.6.18-rc4
 - Distro: FC5
 - Test cases are compiled in both 32bit and 64bit

The test results;
 - Posix test suite
   No regression found. There are still FAILED cases but those are not
   in clock_nanosleep() and not changed with or without the patches.
 - My test cases
   No regression found. And improved in the following cases.
    o 64bit testcase && Interrupted sleep && CLOCK_PROCESS_CPUTIME_ID && !TIMER_ABSTIME
    o 32bit testcase && Interrupted sleep && all clock types && !TIMER_ABSTIME
    o 32bit testcase && Interruptes sleep && CLOCK_PROCESS_CPUTIME_ID && TIMER_ABSTIME

I can provide the test results if you require them.

To use the inlined, compile like this;
 # gcc -lrt -lpthread -DCOMPILE_64 test.c
 or
 # gcc -lrt -lpthread -m32 -DCOMPILE_32 test.c
 and then execute like this;
 # ./a.out 2>/dev/null


Sincerely,
Toyo Abe <toyoa@mvista.com>

---

#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <pthread.h>

#define NSEC_PER_SEC 1000000000L
#define SLEEPTIME	20	/* in sec */
#define INTERVAL	5	/* in sec */

#ifdef COMPILE_64
#define PRINTFORMAT	"%lld.%09lld"
#else
#define PRINTFORMAT	"%ld.%09ld"
#endif

pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

void handler(int sig)
{
        printf("Received SIGUSR1\n");
}

void *thread(void *arg)
{
	unsigned long n = 0;

	pthread_mutex_lock(&mutex);
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mutex);

	while(1) {
	       	n++;
		/* Without the following stuff, the thread sometimes seems to not be scheduled well. */
		if (!(n %1000000))
			fprintf(stderr, "thread\n");
	}
}

int prepare_thread(pthread_t *tid)
{
	pthread_mutex_lock(&mutex);

	if ( pthread_create(tid, NULL, thread, NULL)) {
		fprintf(stderr, "Fail to create thread.\n");
		return -1;
	}

	pthread_cond_wait(&cond, &mutex);

	return 0;
}

void kill_thread(pthread_t *tid)
{
	pthread_cancel(*tid);
	pthread_mutex_unlock(&mutex);
}

int test_clock_nanosleep(clockid_t which_clock, struct timespec *rqt, struct timespec *rmt,
	       		 struct timespec *now, struct timespec *then, int flags)
{
	pthread_t tid;
	int ret;

	if (which_clock == CLOCK_PROCESS_CPUTIME_ID) {
		if (prepare_thread(&tid))
			return -1;
	}

        clock_gettime(which_clock, then);

        ret = clock_nanosleep(which_clock, flags, rqt, rmt);

        clock_gettime(which_clock, now);

	if (which_clock == CLOCK_PROCESS_CPUTIME_ID)
		kill_thread(&tid);

        return ret;
}

void print_results(const int ret, const struct timespec *rqt, const struct timespec *rmt,
		const struct timespec *now, const struct timespec *then)
{
	long sec = 0;
	long nsec = 0;

        printf("request time = " PRINTFORMAT " [sec]\n", rqt->tv_sec, rqt->tv_nsec);
        printf("remaining time = " PRINTFORMAT " [sec]\n", rmt->tv_sec, rmt->tv_nsec);
        printf("return code = %d\n", ret);

        sec = now->tv_sec - then->tv_sec;
        nsec = now->tv_nsec - then->tv_nsec;

	if (nsec < 0) {
		sec--;
		nsec += NSEC_PER_SEC;
	}

	printf("elapsed time = " PRINTFORMAT " [sec]\n", sec, nsec);

	return;
}

void send_signal(pid_t pid)
{
	/*
         * Parent: send signals to child in the following order.
         * SIGSTOP -> SIGCONT -> SIGUSR1
         */
         sleep(INTERVAL);
         kill(pid, SIGSTOP);
         sleep(1);
         kill(pid, SIGCONT);
         sleep(INTERVAL);
         kill(pid, SIGUSR1);
	return;
}

void init_timespec(clockid_t which_clock, struct timespec *rqt, struct timespec *rmt, int abs)
{
	if (abs)
		clock_gettime(which_clock, rqt);
	else {
		rqt->tv_sec = 0;
		rqt->tv_nsec = 0;
	}

	rqt->tv_sec += SLEEPTIME;
	rmt->tv_sec = 0;
	rmt->tv_nsec = 0;
}

int main(void)
{
        pid_t child;
        struct timespec rqt, rmt;
        struct timespec now, then;
        struct sigaction act;
	clockid_t clockid;
        int ret;

        memset(&act, 0, sizeof(act));
        act.sa_handler = handler;
        sigaction(SIGUSR1, &act, NULL);

	/*
	 * When clockid is
	 * 0: CLOCK_REALTIME
	 * 1: CLOCK_MONOTONIC
	 * 2: CLOCK_PROCESS_CPUTIME_ID
	 */
	for ( clockid=0; clockid < 3; clockid++) {
		char *clockid_str = (clockid==0? "CLOCK_REALTIME" :
				     (clockid==1? "CLOCK_MONOTONIC" :
				      "CLOCK_PROCESS_CPUTIME_ID"));
		int abs;

		/*
		 * When abs is
		 * 0: flags != TIMER_ABSTIME
		 * 1: flags == TIMER_ABSTIME
		 */
		for (abs=0; abs < 2; abs++) {
			int flags = (abs == 1) ? TIMER_ABSTIME : 0;

        		if(child = fork()) {
        		/*
         	 	 * Parent: send signals to child in the following order.
         	 	 * SIGSTOP -> SIGCONT -> SIGUSR1
         	 	 */
				send_signal(child);
                		waitpid(child, NULL, 0);
        		}
        		else {
        		/*
         	 	 * Child: sleep 60 seconds by using clock_nanosleep, but will be interrupted
         	 	 * by SIGUSR1
         	 	 */
				printf("\n[Interrupted Test Case: clock_nanosleep(%s, %s)]\n",
					       	clockid_str, (abs==1? "TIMER_ABSTIME" : "0"));

				init_timespec(clockid, &rqt, &rmt, abs);
				ret = test_clock_nanosleep(clockid, &rqt, &rmt, &now, &then, flags);
				print_results(ret, &rqt, &rmt, &now, &then);

				exit(0);
        		}

			/* Non-interrupted test case */
			printf("\n[Test Case: clock_nanosleep(%s, %s)]\n",
					clockid_str, (abs==1? "TIMER_ABSTIME" : "0"));

			init_timespec(clockid, &rqt, &rmt, abs);
			ret = test_clock_nanosleep(clockid, &rqt, &rmt, &now, &then, flags);
			print_results(ret, &rqt, &rmt, &now, &then);
		}

	}

        return 0;
}
