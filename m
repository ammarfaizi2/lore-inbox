Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUGAWLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUGAWLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUGAWJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:09:15 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:36521 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266322AbUGAWFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:05:48 -0400
Date: Thu, 1 Jul 2004 15:05:10 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: akpm@osdl.org, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] task name handling in proc fs
Message-ID: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen the the top command segfault when dealing with a badly (very
badly) formed task name obtained from a 'stat' file in proc fs.  Upon
further examination, it appears that the task name could be updated at
the same time it is handed off to sprintf in proc_pid_stat().  Now one
could argue that top should be more intelligent and deal with these
badly formed names.  However, I think it's bad to be passing strings that
could be changing to sprintf within the kernel.  I'm pretty sure sprintf
expects the character strings to be static.  Below is a patch to address
this code and one other place dealing with task names in the same file.

-- 
Mike


diff -Naur linux-2.6.7/fs/proc/array.c linux-2.6.7.ptest/fs/proc/array.c
--- linux-2.6.7/fs/proc/array.c	Wed Jun 16 05:19:36 2004
+++ linux-2.6.7.ptest/fs/proc/array.c	Thu Jul  1 17:44:14 2004
@@ -97,14 +97,14 @@
 		name++;
 		i--;
 		*buf = c;
-		if (!c)
+		if (!*buf)
 			break;
-		if (c == '\\') {
-			buf[1] = c;
+		if (*buf == '\\') {
+			buf[1] = *buf;
 			buf += 2;
 			continue;
 		}
-		if (c == '\n') {
+		if (*buf == '\n') {
 			buf[0] = '\\';
 			buf[1] = 'n';
 			buf += 2;
@@ -308,14 +308,11 @@
 	int num_threads = 0;
 	struct mm_struct *mm;
 	unsigned long long start_time;
+	char tname[sizeof(task->comm)];
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
-	task_lock(task);
-	mm = task->mm;
-	if(mm)
-		mm = mmgrab(mm);
-	task_unlock(task);
+	mm = get_task_mm(task);
 	if (mm) {
 		down_read(&mm->mmap_sem);
 		vsize = task_vsize(mm);
@@ -357,11 +354,15 @@
 	/* Temporary variable needed for gcc-2.96 */
 	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
 
+	/* Make a static copy of task name for sprintf */
+	memcpy(tname, task->comm, sizeof(tname));
+	tname[sizeof(tname)-1] = '\0';
+
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
-		task->comm,
+		tname,
 		state,
 		ppid,
 		pgid,
