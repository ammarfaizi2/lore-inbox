Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbUKEJ6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUKEJ6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 04:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbUKEJ6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 04:58:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:5044 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261569AbUKEJ6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 04:58:03 -0500
Message-ID: <418B4E86.4010709@in.ibm.com>
Date: Fri, 05 Nov 2004 15:27:26 +0530
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [PATCH] do_wait fix for 2.6.10-rc1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that fixes a condition that can make a thread get stuck
forever in do_wait unless manually interrupted. 

I have provided a testcase that can recreate this problem while running
with NPTL on a multi-processor machine. I have seen this on x86 and PPC64. 
The condition happens when two threads race in waitpid to collect exit 
status of the same child. Sometimes one of the threads gets permanently 
stuck in waitpid, instead of returning ECHILD.

In do_wait we use the variable 'flag' to indicate if there are eligible 
children to collect. But we don't re-initialize it to 0 at the beginning 
of the do-while loop, which makes the thread always believe that there are 
eligible children in it's second run through the loop. It calls schedule, 
but there won't be anyone to wake it up. This can happen when two threads 
enter do-wait simultaneously. We need to re-initialize 'flag' to zero 
every time we loop through the do-while to solve this problem.

Thanks, 
Sripathi.

A simple testcase can demonstrate this problem. Patch follows the testcase.

#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>
#include <limits.h>
#include <sys/wait.h>

int status_freq = 0;
int child_limit = INT_MAX;

void
catch_sigchld(int signo)
{
    pid_t wait_pid;
    int  status;

    do {
        wait_pid = waitpid((pid_t) -1, &status, WNOHANG);
    } while (wait_pid > 0);

    return;
}

void *
thread_rtn(void *arg)
{
    int  rc, child_cnt, status;
    int pfds[2];
    pid_t child_pid, wait_pid;
    char output[80];
    ssize_t bytes_read;
    sigset_t sigmask;

        if ((rc = sigemptyset(&sigmask)) != 0) {
            fprintf(stderr, "sigemptyset() failed: %d.\n", errno);
            exit(1);
        }

        if ((rc = sigaddset(&sigmask, SIGCHLD)) != 0) {
            fprintf(stderr, "sigaddset() failed: %d.\n", errno);
            exit(1);
        }

        if ((rc = pthread_sigmask(SIG_SETMASK, &sigmask, NULL)) != 0) {
            fprintf(stderr, "Error setting thread signal mask: %d.\n", rc);
            exit(1);
        }

    for (child_cnt = 1; child_cnt <= child_limit; child_cnt++) {

        if ((rc = pipe(pfds)) != 0) {
            fprintf(stderr, "Error calling pipe(): %d.\n", errno);
            exit(1);
        }

        child_pid = fork();
        if (child_pid < 0) {
            fprintf(stderr, "Error calling fork(): %d.\n", errno);
            exit(1);
        }

        if (child_pid == 0) {               /* This code run in the child    */
            close(pfds[0]);                 /* Close read end of pipe        */
            dup2(pfds[1], STDOUT_FILENO);   /* Make stdout write end of pipe */
            close(pfds[1]);                 /* Close duplicate write fd      */
            execlp("date", "date", NULL);   /* Execute the "date" program    */
            exit(1);                        /* It's an error to reach here   */
        }

        do {
            rc = close(pfds[1]);
        } while (rc == -1 && errno == EINTR);

        do {
            bytes_read = read(pfds[0], output, sizeof output);
        } while (bytes_read > 0 || (bytes_read == -1 && errno == EINTR));

        do {
            rc = close(pfds[0]);
        } while (rc == -1 && errno == EINTR);

        fprintf(stderr, "calling waitpid() for %d.\n", child_pid);

        do {
            wait_pid = waitpid(child_pid, &status, 0);
        } while (wait_pid == -1 && errno == EINTR);

        if (status_freq > 0 && (child_cnt % status_freq) == 0) {
            fprintf(stderr, "Child count: %d.\n", child_cnt);
        }
    }

    exit(0);
    return NULL;
}

int
main(int argc, char **argv)
{
    struct sigaction sa;
    pthread_t thread_id;
    int flag, rc;

    status_freq = 1000;
    child_limit = 10000;

    sa.sa_handler = catch_sigchld;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;

    rc = sigaction(SIGCHLD, &sa, NULL);
    if (rc != 0) {
        fprintf(stderr, "sigaction() failed: %d.\n", errno);
        exit(1);
    }

    if ((rc = pthread_create(&thread_id, NULL, thread_rtn, NULL)) != 0) {
        fprintf(stderr, "Error creating thread: %d.\n", rc);
        exit(1);
    }

    for (;;) {
        sleep(10000);
    }

    return 0;
}

Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>

--- linux-2.6.10-rc1/kernel/exit.c	2004-11-05 16:08:39.458442280 +0530
+++ ./exit-rc1.c	2004-11-05 16:09:47.017171792 +0530
@@ -1306,11 +1306,10 @@ static long do_wait(pid_t pid, int optio
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct task_struct *tsk;
-	int flag, retval;
+	int flag = 0, retval;
 
 	add_wait_queue(&current->wait_chldexit,&wait);
 repeat:
-	flag = 0;
 	current->state = TASK_INTERRUPTIBLE;
 	read_lock(&tasklist_lock);
 	tsk = current;
@@ -1319,6 +1318,7 @@ repeat:
 		struct list_head *_p;
 		int ret;
 
+		flag = 0;
 		list_for_each(_p,&tsk->children) {
 			p = list_entry(_p,struct task_struct,sibling);

