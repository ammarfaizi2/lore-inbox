Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbUKRMfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUKRMfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbUKRMfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:35:07 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:27367 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262753AbUKRMez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:34:55 -0500
Date: Thu, 18 Nov 2004 12:30:16 +0100
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: kernel reports kill too late?
Message-ID: <20041118113016.GA32355@xeon2.local.here>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: T5u+uZZcrePXl7ABmSpg97ivTK3ZHZBva6dGNF06CcXU2w3vPHITUk
X-TOI-MSGID: fef0510d-70ae-4e96-a4e0-a7bee85d0ec0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With kernels newer 2.6.10.rc1-bk18 glibc nptl checks failed.

Now this is fixed (See lkml "Futex queue_me/get_user ordering")
another problem showed off.

I get spurious "Failed to kill test process: No child processes"
errors during nptl checks now.

Appended is a simple test-prog derived from glibc's check which
runs fine on 2.6.10.rc1-bk18 but failed most of the time with
newer kernels.

(Not beeing a guru at all) I interpret the results as a delay
or loss of the status of a killed process which happens only 
if this process runs a thread.
(Not calling sleep_mostly() as a thread works as expected.)

Further noteworthy: it happens not always.



Output on 2.6.10.rc1-bk18 
thread starts spinning
thread alive
try to kill pid 1436
killed after 4007 waitpid calls
killed by signal: status = 0

Output on 2.6.10.rc2-bk2
test 0 --------------------------------
thread starts spinning
thread alive
try to kill pid 32321
killed after 3389 waitpid calls
killed by signal: status = 0
test 1 --------------------------------
thread starts spinning
thread alive
try to kill pid 32323
killed after 17 waitpid calls
killed by signal: status = 138
Kill failed! waitpid returned -1

Both systems are smp 2xP4 and 2xP3.

Can anyone else see this?

--
Regards Klaus



--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2waitpid-test.c"

#include <sys/wait.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>


static void print_exit_status (int status) {

	if(WIFEXITED(status)) {
		printf("killed normal   : status = %d\n", WEXITSTATUS(status));
	} else if (WIFSIGNALED(status)) {
		printf("killed by signal: status = %d\n", WEXITSTATUS(status));
	}
}

static void * sleep_mostly (void * arg)
{
	printf("thread starts spinning\n");

	while (1) {
   		sleep (1);
		printf ("thread alive\n");
	}

	/* NOTREACHED */
  	return NULL;
}

static int do_fork (void)
{
	pid_t pid = fork ();
	
	if (pid == 0) { /* child */

		pthread_t th;
		int cr = pthread_create (&th, NULL, sleep_mostly, (void*)NULL);

		if (cr != 0) {
	    	fprintf (stderr, "Thread creation failed %s\n", strerror(cr));
			exit (1);
		}

		sleep(3);
		pthread_exit (NULL);
    } else  if (pid < 0) {
		fprintf (stderr, "Cannot fork!\n");
		exit (1);
	}	
	return pid;
}

static int test_wait_pid(void) {

	int pid = do_fork();

	sleep(2);
	fprintf (stderr, "try to kill pid %d\n", pid);
	kill (pid, SIGKILL);	

	int killed;
	int status;
	int n;

	for (n = 1; n < 9999; n++) {
		killed = waitpid (pid, &status, WNOHANG|WUNTRACED);
		if (killed != 0)
			break;
	}	

	fprintf (stderr, "killed after %d waitpid calls\n", n);
	print_exit_status(status);

	if (killed != 0 && killed != pid) {
		fprintf (stderr, "Kill failed! waitpid returned %d\n", killed);
		exit (1);
	}

  	return 0;
}

int main (int argc, char* argv[]) {

	int i = 0;
	do {
		printf ("test %d --------------------------------\n", i);
		test_wait_pid();
		i++;
	} while ( i < 10);
	return 0;
}

--h31gzZEtNLTqOjlF--
