Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUHERMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUHERMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267811AbUHERJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:09:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267815AbUHERFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:05:55 -0400
Date: Thu, 5 Aug 2004 13:05:52 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] RSS ulimit enforcement for 2.6.8
Message-ID: <Pine.LNX.4.44.0408051302330.8229-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below implements RSS ulimit enforcement for 2.6.8-rc3-mm1.
It works in a very simple way: if a process has more resident memory
than its RSS limit allows, we pretend it didn't access any of its
pages, making it easy for the pageout code to evict the pages.

In addition to this, we don't allow a process that exceeds its RSS
limit to have the swapout protection token.

I have tested the patch on my system here and it appears to be working
fine.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.8-rc3/include/linux/init_task.h.rsslim	2004-08-05 10:58:03.375581943 -0400
+++ linux-2.6.8-rc3/include/linux/init_task.h	2004-08-05 10:58:47.075606510 -0400
@@ -3,6 +3,7 @@
 
 #include <linux/file.h>
 #include <linux/pagg.h>
+#include <asm/resource.h>
 
 #define INIT_FILES \
 { 							\
@@ -43,6 +44,7 @@
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.cpu_vm_mask	= CPU_MASK_ALL,				\
 	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
+	.rlimit_rss	= RLIM_INFINITY,			\
 }
 
 #define INIT_SIGNALS(sig) {	\
--- linux-2.6.8-rc3/include/linux/sched.h.rsslim	2004-08-05 11:03:43.736528322 -0400
+++ linux-2.6.8-rc3/include/linux/sched.h	2004-08-05 11:04:16.418825667 -0400
@@ -235,7 +235,7 @@ struct mm_struct {
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm;
+	unsigned long rlimit_rss, rss, total_vm, locked_vm;
 	unsigned long def_flags;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
--- linux-2.6.8-rc3/fs/exec.c.rsslim	2004-08-05 11:07:53.137489937 -0400
+++ linux-2.6.8-rc3/fs/exec.c	2004-08-05 11:09:23.126777053 -0400
@@ -1109,6 +1109,11 @@ int do_execve(char * filename,
 	retval = init_new_context(current, bprm.mm);
 	if (retval < 0)
 		goto out_mm;
+	if (likely(current->mm)) {
+		bprm.mm->rlimit_rss = current->mm->rlimit_rss;
+	} else {
+		bprm.mm->rlimit_rss = init_mm.rlimit_rss;
+	}
 
 	bprm.argc = count(argv, bprm.p / sizeof(void *));
 	if ((retval = bprm.argc) < 0)
--- linux-2.6.8-rc3/kernel/sys.c.rsslim	2004-08-05 11:04:37.023708596 -0400
+++ linux-2.6.8-rc3/kernel/sys.c	2004-08-05 11:06:15.023615619 -0400
@@ -1527,6 +1527,14 @@ asmlinkage long sys_setrlimit(unsigned i
 	if (retval)
 		return retval;
 
+	/* The rlimit is specified in bytes, convert to pages for mm. */
+	if (resource == RLIMIT_RSS && current->mm) {
+		unsigned long pages = RLIM_INFINITY;
+		if (new_rlim.rlim_cur != RLIM_INFINITY)
+			pages = new_rlim.rlim_cur >> PAGE_SHIFT;
+		current->mm->rlimit_rss = pages;
+	}
+
 	*old_rlim = new_rlim;
 	return 0;
 }
--- linux-2.6.8-rc3/mm/rmap.c.rsslim	2004-08-05 11:06:30.945888921 -0400
+++ linux-2.6.8-rc3/mm/rmap.c	2004-08-05 11:07:25.990548554 -0400
@@ -233,6 +233,9 @@ static int page_referenced_one(struct pa
 	if (mm != current->mm && has_swap_token(mm))
 		referenced++;
 
+	if (mm->rss > mm->rlimit_rss)
+		referenced = 0;
+
 	(*mapcount)--;
 
 out_unmap:
--- linux-2.6.8-rc3/mm/thrash.c.rsslim	2004-08-05 11:09:34.101519320 -0400
+++ linux-2.6.8-rc3/mm/thrash.c	2004-08-05 11:10:39.515102287 -0400
@@ -24,7 +24,7 @@ struct mm_struct * swap_token_mm = &init
 /*
  * Take the token away if the process had no page faults
  * in the last interval, or if it has held the token for
- * too long.
+ * too long, or if the process exceeds its RSS limit.
  */
 #define SWAP_TOKEN_ENOUGH_RSS 1
 #define SWAP_TOKEN_TIMED_OUT 2
@@ -35,6 +35,8 @@ static int should_release_swap_token(str
 		ret = SWAP_TOKEN_ENOUGH_RSS;
 	else if (time_after(jiffies, swap_token_timeout))
 		ret = SWAP_TOKEN_TIMED_OUT;
+	else if (mm->rss > mm->rlimit_rss)
+		ret = SWAP_TOKEN_ENOUGH_RSS;
 	mm->recent_pagein = 0;
 	return ret;
 }
@@ -59,8 +61,8 @@ void grab_swap_token(void)
 	if (time_after(jiffies, swap_token_check)) {
 
 		/* Can't get swapout protection if we exceed our RSS limit. */
-		// if (current->mm->rss > current->mm->rlimit_rss)
-		//	return;
+		if (current->mm->rss > current->mm->rlimit_rss)
+			return;
 
 		/* ... or if we recently held the token. */
 		if (time_before(jiffies, current->mm->swap_token_time))

