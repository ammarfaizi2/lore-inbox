Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUDWSXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUDWSXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 14:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUDWSXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 14:23:42 -0400
Received: from ida.rowland.org ([192.131.102.52]:18180 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262215AbUDWSXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 14:23:40 -0400
Date: Fri, 23 Apr 2004 14:23:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: PATCH: (as259) Work around for gcc-2.96
Message-ID: <Pine.LNX.4.44L0.0404231415390.3977-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:

This patch for 2.6.6-rc2 is needed to work around gcc-2.96's limited
ability to cope with long long intermediate expression types.  I don't 
know why the code compiled okay earlier and failed now.

Alan Stern


===== fs/proc/array.c 1.40 vs edited =====
--- 1.40/fs/proc/array.c	Mon Apr 12 06:54:46 2004
+++ edited/fs/proc/array.c	Fri Apr 23 13:41:50 2004
@@ -304,6 +304,7 @@
  	pid_t ppid, pgid = -1, sid = -1;
 	int num_threads = 0;
 	struct mm_struct *mm;
+	unsigned long long start_time;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -349,6 +350,10 @@
 	read_lock(&tasklist_lock);
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
+
+	/* Temporary variable needed for gcc-2.96 */
+	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
+
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
@@ -373,8 +378,7 @@
 		nice,
 		num_threads,
 		jiffies_to_clock_t(task->it_real_value),
-		(unsigned long long)
-		    jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES),
+		start_time,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

