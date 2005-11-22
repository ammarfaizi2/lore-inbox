Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVKVBLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVKVBLO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVKVBLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:11:14 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:17908 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751186AbVKVBLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:11:13 -0500
Message-ID: <43826FDC.8010401@mvista.com>
Date: Mon, 21 Nov 2005 17:09:48 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Oleg Nesterov <oleg@tv-sign.ru>, paulmck@us.ibm.com,
       Roland McGrath <roland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
       suzannew@cs.pdx.edu
Subject: Thread group exec race -> null pointer... HELP
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1401.920A83EE@tv-sign.ru> <437BC01D.60302@mvista.com>
In-Reply-To: <437BC01D.60302@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------010603020903040402020701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603020903040402020701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

George Anzinger wrote:
> While rooting aroung in the signal code trying to understand how to
> fix the SIG_IGN    ploy (set sig handler to SIG_IGN and flood system with
> high speed repeating timers) I came across what, I think, is a problem
> in sigaction() in that when processing a SIG_IGN request it flushes
> signals from 1 to SIGRTMIN and leaves the rest.  

Still rooting around in the above.  The test program is attached.  It 
creates and arms a repeating timer and then clones a thread which does 
an exec() call.

If I run the test with top (only two programs running) I quickly get 
an OOPS on trying to derefence a NULL pointer.  It is comming from a 
call the posix timer code is making to deliver a timer.  Call is to 
send_group_sigqueue() at ~445 in posix-timers.c.  The process being 
passed in is DEAD with current->signal ==NULL, thus the OOPS.  In the 
first instance of this, we see that the thread-group leader is dead 
and the exec code at line ~718 is setting the old leaders group-leader 
to him self.  The failure then happens when the IRQ release is done on 
the write_unlock_irq() at ~732 thus allowing the timer interrupt.

Thinking that it makes no real sense to set the group leader to a dead 
process, I did the following:

--- linux-2.6.15-rc.orig/fs/exec.c
+++ linux-2.6.15-rc/fs/exec.c
@@ -715,7 +715,7 @@ static inline int de_thread(struct task_
  		current->parent = current->real_parent = leader->real_parent;
  		leader->parent = leader->real_parent = child_reaper;
  		current->group_leader = current;
-		leader->group_leader = leader;
+		leader->group_leader = current;

  		add_parent(current, current->parent);
  		add_parent(leader, leader->parent);

This also fails as there is still a window where the group leader is 
dead with a null signal pointer, i.e. the interrupt happens (this time 
on another cpu) before the above changed code is executed.

It seems to me that the group leader needs to change prior to setting 
the signal pointer to NULL, but I don't really know this code very well.

Help !
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------010603020903040402020701
Content-Type: text/x-csrc;
 name="timer_kill.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timer_kill.c"

#include <errno.h>
#include <stdio.h>
#include <signal.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/wait.h>
#include <time.h>

void die(const char* msg)
{
	fprintf(stderr, "ERR!! %s: %s\n", msg, strerror(errno));
	exit(-1);
}

char thread_stack[4096];

int thread_func(void *arg)
{
	execl("/bin/true", NULL);
	die("exec");
	return 0;
}

void proc_func(void)
{
	int pid;

	for (;;)
		if ((pid = fork())) {
			if (pid != waitpid(pid, NULL, 0))
				die("wait4");
		} else {
			struct sigevent sigev = {};
			struct itimerspec itsp = {};
			timer_t tid;

			sigev.sigev_signo = SIGRTMIN;
			sigev.sigev_notify = SIGEV_SIGNAL;
			if (timer_create(CLOCK_MONOTONIC, &sigev, &tid) == -1)
				die("timer_create");

			itsp.it_value.    tv_nsec = 1;
			itsp.it_interval. tv_nsec = 1;
			if (timer_settime(tid, 0, &itsp, NULL))
				die("timer_settime");

			if (clone(thread_func, thread_stack + 2048,
					CLONE_THREAD|CLONE_SIGHAND|CLONE_VM|CLONE_FILES,
					NULL) < 0)
				die("clone");

			pause();
		}
}

int main(void)
{
	int pn;

	signal(SIGRTMIN, SIG_IGN);

	for (pn = 0; pn < 16; ++pn)
		if (!fork())
			proc_func();

	pause();

	return 0;
}

--------------010603020903040402020701--
