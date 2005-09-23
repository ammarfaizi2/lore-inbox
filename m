Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVIWWzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVIWWzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVIWWzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:55:18 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:52748 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S1751335AbVIWWzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:55:16 -0400
Date: Fri, 23 Sep 2005 15:54:44 -0700
From: Arun Sharma <arun.sharma@google.com>
To: linux-kernel@vger.kernel.org
Cc: roland@redhat.com, akpm@osdl.org
Subject: [PATCH] POSIX timers SMP race condition
Message-ID: <20050923225444.GB13502@sharma-home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix run_posix_cpu_timers()/do_exit() race condition

CPU0:                               

do_exit()
tsk->flags |= PF_EXITING;
/* Make sure we don't try to process any timer firings
 * while we are already exiting.
 */
tsk->it_virt_expires = cputime_zero;
tsk->it_prof_expires = cputime_zero;
tsk->it_sched_expires = 0;

<window>

  exit_notify()
  tsk->exit_state = xxx;

CPU1 (executes this code in the <window>):

setitimer()
process_timer_rebalance()
tsk->it_prof_expires=xxx; 

This triggers the BUG_ON(tsk->exit_state) in run_posix_cpu_timers().

Signed-off-by: Arun Sharma <arun.sharma@google.com>

--- linux-2.6.12/kernel/posix-cpu-timers.c-	2005-09-22 04:10:16.000000000 -0700
+++ linux-2.6.12/kernel/posix-cpu-timers.c	2005-09-22 04:10:18.000000000 -0700
@@ -500,7 +500,7 @@
 		left = cputime_div(cputime_sub(expires.cpu, val.cpu),
 				   nthreads);
 		do {
-			if (!unlikely(t->exit_state)) {
+			if (!unlikely(t->flags & PF_EXITING)) {
 				ticks = cputime_add(prof_ticks(t), left);
 				if (cputime_eq(t->it_prof_expires,
 					       cputime_zero) ||
@@ -515,7 +515,7 @@
 		left = cputime_div(cputime_sub(expires.cpu, val.cpu),
 				   nthreads);
 		do {
-			if (!unlikely(t->exit_state)) {
+			if (!unlikely(t->flags & PF_EXITING)) {
 				ticks = cputime_add(virt_ticks(t), left);
 				if (cputime_eq(t->it_virt_expires,
 					       cputime_zero) ||
@@ -530,7 +530,7 @@
 		nsleft = expires.sched - val.sched;
 		do_div(nsleft, nthreads);
 		do {
-			if (!unlikely(t->exit_state)) {
+			if (!unlikely(t->flags & PF_EXITING)) {
 				ns = t->sched_time + nsleft;
 				if (t->it_sched_expires == 0 ||
 				    t->it_sched_expires > ns) {
