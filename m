Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbTLNFZV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 00:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbTLNFZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 00:25:21 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:12423 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265351AbTLNFZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 00:25:17 -0500
Date: Sun, 14 Dec 2003 06:25:16 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Problem with exiting threads under NPTL
Message-ID: <20031214052516.GA313@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  several times one of our threads ended up as ZOMBIE and
nobody wants to pick him up - even init ignores it. Inspection
of kernel structures revealed that task's exit code is 0,
exit_signal is -1, ptrace is 0 and state is 8 (ZOMBIE).

   Quick look at exit_notify reveals that it should not happen:
if task has exit_signal == -1 and is not ptraced, we should immediate
move to TASK_DEAD and get rid of task as fast as possible.

   But problem is that in do_notify_parent we have code which
sets exit_signal to -1 if parent ignores SIGCHLD, and we call
do_notify_parent() for group leader from release_task() when
last member of thread group exits, without taking any care
about eventual changes in exit_signal field.

   So if some process ignores SIGCHLD, and spawns child process 
which creates additional thread, and main thread in child exits 
before child it created, you'll end up with immortal zombie.

						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz

F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
5     0  3709     1  15   0     0    0 exit   Z    tty3       0:00 [test] <defunct>


Creator of immortal zombies:

#include <pthread.h>
#include <signal.h>
#include <unistd.h>
#include <stdio.h>

static void* thread(void* dummy) {
	/* Make sure that we exit as second thread */
        sleep(1);
        return NULL;
}

void main(void) {
        int pid;

        signal(SIGCHLD, SIG_IGN);

        pid = fork();
        if (pid == 0) {
                pthread_t p;

                pthread_create(&p, NULL, thread, NULL);
        } else {
                /* Sleep some time so we know that child threads exit before us */
                sleep(2);
                printf("Look for task %d...\n", pid);
        }
}

