Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319282AbSIFS14>; Fri, 6 Sep 2002 14:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319297AbSIFS14>; Fri, 6 Sep 2002 14:27:56 -0400
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.61.209]:64640 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S319282AbSIFS1x>;
	Fri, 6 Sep 2002 14:27:53 -0400
Date: Fri, 6 Sep 2002 14:44:15 -0400
Message-Id: <200209061844.g86IiF701825@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org
cc: jim.houston@ccur.com
Subject: O(1) Scheduler (tuning problem/live-lock)
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The current O(1) scheduler heuristics for calculating sleep_avg
   and assigning process priorities allows a parent and a small group of 
   compute bound child processes to live-lock the system.  
   We found this problem running a stress test including the LTP
   test suite.  In particular the waitpid06 test in the LTP triggered
   this problem.  We are working with a 2.4.18 kernel with a backport of
   the O(1) scheduler, but this problem is present in Linux-2.5.32.

How it happens.

   The waitpid06 test forks off 8 child processes.  Each child enters
   an infinite loop waiting for a signal from the parent.  Yes, it's
   a stupid test program.  The parent (if it gets to run) immediately sends
   a signal to each child process and then does a wait() call for each child.
   
   The parent process spends all of its time in wait().  When a child
   exits, the parents sleep_avg is adjusted twice.  
   
   In sched_exit():
	parent->sleep_avg = ((3*parent->sleep_avg) + child->sleep_avg)/4;

   In activate_task():
	p->sleep_avg += sleep_time;
	if (p->sleep_avg > MAX_SLEEP_AVG)
		p->sleep_avg = MAX_SLEEP_AVG;
  
   The child->sleep_avg is set initially to 95% of the parent->sleep_avg.
   The child->sleep_avg for the running child is decremented in
   scheduler_tick().  If you have fewer processors than child processes,
   child->sleep_avg will,  on average, decrease less than 1 each tick.
   
   The effect is that the parent sleep_avg will approach MAX_SLEEP_AVG giving
   it and its children a favorable interactive priority.  
   Since these processes are judged interactive they go back into the active
   array when they use up their time slice but still with a favorable priority
   and a new time quantum.
   
   The problem is easy to reproduce with the waitpid06 test.  It provides
   options so that you can loop repeating the test and also run multiple
   copies at once.  I have been using:

	waitpid06 -c 8 -i 10000

   This runs 8 copies of the test (64 unruly child processes) and loops
   10,000 times.  I also run a top(1) and a:
	  while true ; do date; sleep 1; done
   loop so I can tell if the system has locked up.  This sometimes takes
   a few minutes.


How do we fix this?

   I'm just getting started playing with the code.  When I tried changing the 
   EXIT_WEIGHT to 1, the problem still happened.  I tried changing 
   sched_exit to give the parent the minimum of the two sleep_avg values.
   This seems to fix the problem.  I suspect that this is really a symptom
   of a larger problem, that the system can be over-commited with processes
   which are all judged interactive never putting processes in the expired
   array and so never triggering the EXPIRED_STARVING case.

Please CC: me on answers/comments since I read the archives.

Jim Houston - Concurrent Computer Corp.
