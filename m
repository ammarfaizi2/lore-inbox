Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268413AbUJDSvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268413AbUJDSvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUJDSvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:51:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:950 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268306AbUJDSuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:50:32 -0400
Date: Mon, 4 Oct 2004 11:48:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, george@mvista.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com,
       akpm@osdl.org, jbarnes@sgi.com
Subject: RFC: Posix compliant clock_getclockcpuid(pid) to access other
 processes clocks
In-Reply-To: <200410012157.i91LvlPj021414@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410041142580.7702@schroedinger.engr.sgi.com>
References: <200410012157.i91LvlPj021414@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small idea for a kernel patch that implements access to other
process clocks via

clock_gettime(-PID,&timespec)

as Roland proposed and thus allows a full posix compliant implementation
of clock_getclockcpuid() in glibc.

clock_getclockcpuid(pid) would need to be changed to do

if (pid == 0)
	return CLOCK_PROCESS_CPUTIME_ID;
else
	return -1;

I may be able to finish this and send this to Andrew
by tomorrow.

Index: linus/kernel/posix-timers.c
===================================================================
--- linus.orig/kernel/posix-timers.c	2004-10-04 10:35:59.000000000 -0700
+++ linus/kernel/posix-timers.c	2004-10-04 11:38:06.000000000 -0700
@@ -1293,31 +1293,31 @@
  * associated with the clock.
  */

-unsigned long process_ticks(void) {
+unsigned long process_ticks(task_t *c) {
 	unsigned long ticks;
 	task_t *t;

 	/* The signal structure is shared between all threads */
-	ticks = current->signal->utime + current->signal->stime;
+	ticks = c->signal->utime + c->signal->stime;

 	/* Add up the cpu time for all the still running threads of this process */
-	t = current;
+	t = c;
 	do {
 		ticks += t->utime + t->stime;
 		t = next_thread(t);
-	} while (t != current);
+	} while (t != c);
 	return ticks;
 }

 int do_posix_clock_process_gettime(struct timespec *tp)
 {
-	jiffies_to_timespec(current->signal->process_clock_offset + process_ticks(), tp);
+	jiffies_to_timespec(current->signal->process_clock_offset + process_ticks(current), tp);
 	return 0;
 }

 int do_posix_clock_process_settime(struct timespec *tp)
 {
-	current->signal->process_clock_offset = timespec_to_jiffies(tp) - process_ticks();
+	current->signal->process_clock_offset = timespec_to_jiffies(tp) - process_ticks(current);
 	return 0;
 }

@@ -1326,11 +1326,15 @@
 {
 	struct timespec new_tp;

+	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
+		return -EFAULT;
+	if (which_clock < 0) {
+		/* Setting of other processes clocks is not allowed */
+		return -EPERM;
+	}
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
-	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
-		return -EFAULT;
 	if (posix_clocks[which_clock].clock_set)
 		return posix_clocks[which_clock].clock_set(&new_tp);

@@ -1343,6 +1347,15 @@
 	struct timespec rtn_tp;
 	int error = 0;

+	if (which_clock <  0) {
+		/* Obtain the clock from another process */
+		int pid = -which_clock;
+		task_t *c = find_task_by_pid(pid);
+
+		if (!c) return -EINVAL;
+	        jiffies_to_timespec(c->signal->process_clock_offset + process_ticks(c), tp);
+		return 0;
+	}
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
@@ -1361,6 +1374,10 @@
 {
 	struct timespec rtn_tp;

+	if (which_clock < 0) {
+		/* A process clock is desired. They all have the same resolution so... */
+		which_clock = CLOCK_PROCESS_CPUTIME_ID;
+	}
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
