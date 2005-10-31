Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVJaRos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVJaRos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVJaRos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:44:48 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47552 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932513AbVJaRor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:44:47 -0500
Date: Mon, 31 Oct 2005 09:44:16 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, tytso@us.ibm.com, sripathi@in.ibm.com,
       dipankar@in.ibm.com, oleg@tv-sign.ru
Subject: [RFC,PATCH] RCUify single-thread case of clock_gettime()
Message-ID: <20051031174416.GA2762@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The attached patch uses RCU to avoid the need to acquire tasklist_lock
in the single-thread case of clock_gettime().  Still acquires tasklist_lock
when asking for the time of a (potentially multithreaded) process.

Experimental, has been touch-tested on x86 and POWER.  Requires RCU on
task_struct.  Further more focused testing in progress.

Thoughts?  (Why?  Some off-list users want to be able to monitor CPU
consumption of specific threads.  They need to do so quite frequently,
so acquiring tasklist_lock is inappropriate.)

							Thanx, Paul

diff -urpNa -X dontdiff linux-2.6.14-rc5-rt2/kernel/posix-cpu-timers.c linux-2.6.14-rc5-rt2-RCUgettime/kernel/posix-cpu-timers.c
--- linux-2.6.14-rc5-rt2/kernel/posix-cpu-timers.c	2005-10-22 14:45:56.000000000 -0700
+++ linux-2.6.14-rc5-rt2-RCUgettime/kernel/posix-cpu-timers.c	2005-10-22 15:44:27.000000000 -0700
@@ -302,7 +302,7 @@ int posix_cpu_clock_get(clockid_t which_
 		 * should be able to see it.
 		 */
 		struct task_struct *p;
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		p = find_task_by_pid(pid);
 		if (p) {
 			if (CPUCLOCK_PERTHREAD(which_clock)) {
@@ -311,11 +311,13 @@ int posix_cpu_clock_get(clockid_t which_
 								 p, &rtn);
 				}
 			} else if (p->tgid == pid && p->signal) {
+				read_lock(&tasklist_lock);
 				error = cpu_clock_sample_group(which_clock,
 							       p, &rtn);
+				read_unlock(&tasklist_lock);
 			}
 		}
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
 
 	if (error)
