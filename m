Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbTKFWvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 17:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTKFWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 17:51:46 -0500
Received: from fmr05.intel.com ([134.134.136.6]:32446 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263856AbTKFWvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 17:51:24 -0500
Subject: [PATCH] SMP signal latency fix up.
From: Mark Gross <mgross@linux.co.intel.com>
Reply-To: mgross@linux.co.intel.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-tUlEcvfbpLP9alGrwItl"
Organization: TSP
Message-Id: <1068158989.3555.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Nov 2003 14:49:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tUlEcvfbpLP9alGrwItl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached program should execute the following command line within a fraction of a second.
time ./ping_pong -c 10000

Running on SMP and the 2.6.0-test9 kernel, it takes about 10000 * 1/HZ seconds.  Running this 
command with maxcpus=1 the command finishes in fraction of a second.  Under SMP the 
signal delivery isn't kicking the task if its in the run state on the other CPU.

The following patch has been tested and seems to fix the problem.  
I'm confident about the change to sched.c actualy fixes a cut and paste bug.

The change to signal.c IS needed to fix the problem, but I'm not sure there isn't a better way.

Please have take a look

--mgross

diff -urN -X dontdiff linux-2.6.0-test9/kernel/sched.c /opt/linux-2.6.0-test9/kernel/sched.c
--- linux-2.6.0-test9/kernel/sched.c    2003-10-25 11:44:29.000000000 -0700
+++ /opt/linux-2.6.0-test9/kernel/sched.c       2003-11-06 13:04:03.628116240 -0800
@@ -626,13 +626,13 @@
                        }
                        success = 1;
                }
-#ifdef CONFIG_SMP
-               else
-                       if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
-                               smp_send_reschedule(task_cpu(p));
-#endif
                p->state = TASK_RUNNING;
        }
+#ifdef CONFIG_SMP
+               else
+               if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
+                       smp_send_reschedule(task_cpu(p));
+#endif
        task_rq_unlock(rq, &flags);

        return success;
diff -urN -X dontdiff linux-2.6.0-test9/kernel/signal.c /opt/linux-2.6.0-test9/kernel/signal.c
--- linux-2.6.0-test9/kernel/signal.c   2003-10-25 11:43:27.000000000 -0700
+++ /opt/linux-2.6.0-test9/kernel/signal.c      2003-11-06 12:18:22.000000000 -0800
@@ -555,6 +555,9 @@
                wake_up_process_kick(t);
                return;
        }
+       if (t->state == TASK_RUNNING ) 
+               wake_up_process_kick(t);
+       
 }

 /*

--=-tUlEcvfbpLP9alGrwItl
Content-Disposition: attachment; filename=ping_pong.c
Content-Type: text/x-c; name=ping_pong.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <argp.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <pthread.h>
#include <signal.h>

int argp_parse_option(int key, char *arg, struct argp_state *argp_state);

struct state {
	pthread_t receive;
	pthread_t send;
	int signal;
	int count;
	int yield;
        volatile int flags;
	volatile int sync_flags;
};

static struct state _state = {
	.signal = SIGUSR1,
	.flags = 0,
	.sync_flags = 0,
	.yield = 0,
};
static const struct argp_option argp_options[] = {
	{"count", 'c', "COUNT", 0, "Number of signals exchanged"},
	{"signal", 'n', "SIGNUM", 0, "The sended signal"},
	{"yield", 'y', NULL, 0, "Make receiver yield while waiting"},
	{0}
};
static const struct argp argp = {
	.options = argp_options,
	.parser = argp_parse_option,
};

int argp_parse_option(int key, char *arg, struct argp_state *argp_state)
{
	struct state *state = argp_state->input;
	switch (key) {		
	case 'n':
		if (sscanf(arg, "%u", &state->signal) != 1) {
			perror("invalid signal argument");
			return -EINVAL;
		}		
		break;
	case 'c':
		if (sscanf(arg, "%i", &state->count) != 1) {
			perror("invalid count argument");
			return -EINVAL;
		}		
		break;
	case 'y':
		state->yield = 1;
		break;
		
	}

	return 0;
}


static void * sender (void *arg)
{
	struct state * state = (struct state *) arg;
	sigset_t action;
	int c = 0, r = 0;
	int sig;
	
	sigemptyset (&action);
	sigaddset (&action, state->signal);
	sigprocmask (SIG_BLOCK, &action, 0);

	/* wait for the receiver to get ready for receiving signals */
	while (state->sync_flags == 0)
		sched_yield();

	while ( c++ < state->count ) {
		/* ping */
		pthread_kill ( state->receive, state->signal);	

		/* pong */
		if ((r = sigwait(&action, &sig)) != 0) {
			perror("sigwait");
			state->flags = 1;
			pthread_exit(&r);
		}
	}

	state->flags = 1;
 	pthread_exit (&r);	
}
   
static void handler(int signum)
{
	struct state * state = &_state;
	pthread_kill(state->send, state->signal);
}
static void * receiver (void *arg)
{
	struct state * state = (struct state *) arg;
	struct sigaction action;
	int r;
	
	action.sa_handler = handler;
	sigemptyset (&action.sa_mask);
	action.sa_flags = 0;	
	if ((r = sigaction (state->signal, &action, 0)) != 0) {
		perror("sigaction");
		pthread_exit(&r);
	}

	/* let the sender thread know we are ready to start receiving */
	state->sync_flags = 1;

	while ( state->flags == 0 ) { 
		if (state->yield)
			sched_yield();
		else
			/*spin*/;
	}

	/* ...and done */
	pthread_exit(&r);	
}	

int main(int argc, char *argv[])
{
	int result = 0;
	void * thread_result;
	struct state *state = &_state;

	if (argp_parse(&argp, argc, argv, ARGP_IN_ORDER, 0, state) != 0)
		exit(-1);

	result = pthread_create (&state->receive, NULL, receiver, state);
	if ( result != 0 ) {
		perror("pthread_create");
		exit(-1);
	}

	result = pthread_create (&state->send, NULL, sender, state);
	if ( result != 0 ) {
		perror("pthread_create");
		exit(-1);
	}

	result = pthread_join ( state->send, &thread_result);	
	if ( result != 0 ) {
		perror("pthread_join");
		exit(-1);
	}

	result = pthread_join ( state->receive, &thread_result);	
	if ( result != 0 ) {
		perror("pthread_join");
		exit(-1);
	}
	
	return 0;
}

--=-tUlEcvfbpLP9alGrwItl--

