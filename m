Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269614AbUJTHgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269614AbUJTHgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUJTHeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:34:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53933 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270091AbUJTHGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:06:02 -0400
Date: Wed, 20 Oct 2004 00:05:53 -0700
Message-Id: <200410200705.i9K75rlo023696@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] acct: report single record for multithreaded process
X-Fcc: ~/Mail/linus
X-Zippy-Says: We place two copies of PEOPLE magazine in a DARK, HUMID mobile
   home.  45 minutes later CYNDI LAUPER emerges wearing a BIRD CAGE on
   her head!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes process accounting to write just one record for a
process with many NPTL threads, rather than one record for each thread.
No record is written until the last thread exits.  The process's record
shows the cumulative time of all the threads that ever lived in that
process (thread group).  This seems like the clearly right thing and I
assume it is what anyone using process accounting really would like to see.

There is a race condition between multiple threads exiting at the same
time to decide which one should write the accounting record.  I
couldn't think of anything clever using existing bookkeeping that would
get this right, so I added another counter for this.  (There may be some
potential to clean up existing places that figure out how many
non-zombie threads are in the group, now that this count is available.)


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

Index: linux-2.6/include/linux/sched.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/sched.h,v
retrieving revision 1.272
diff -B -p -u -r1.272 sched.h
--- linux-2.6/include/linux/sched.h 13 Sep 2004 21:05:18 -0000 1.272
+++ linux-2.6/include/linux/sched.h 24 Sep 2004 10:13:51 -0000
@@ -268,6 +268,7 @@ struct sighand_struct {
  */
 struct signal_struct {
 	atomic_t		count;
+	atomic_t		live;
 
 	/* current thread group signal load-balancing target: */
 	task_t			*curr_target;
Index: linux-2.6/kernel/acct.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/acct.c,v
retrieving revision 1.34
diff -B -p -u -r1.34 acct.c
--- linux-2.6/kernel/acct.c 2 Aug 2004 17:09:36 -0000 1.34
+++ linux-2.6/kernel/acct.c 24 Sep 2004 10:19:32 -0000
@@ -418,8 +418,12 @@ static void do_acct_process(long exitcod
 #endif
 	do_div(elapsed, AHZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(current->utime));
-	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(current->stime));
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(
+					    current->signal->utime +
+					    current->group_leader->utime));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(
+					    current->signal->stime +
+					    current->group_leader->stime));
 	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
@@ -432,8 +436,8 @@ static void do_acct_process(long exitcod
 	ac.ac_gid16 = current->gid;
 #endif
 #if ACCT_VERSION==3
-	ac.ac_pid = current->pid;
-	ac.ac_ppid = current->parent->pid;
+	ac.ac_pid = current->tgid;
+	ac.ac_ppid = current->parent->tgid;
 #endif
 
 	read_lock(&tasklist_lock);	/* pin current->signal */
@@ -466,8 +470,10 @@ static void do_acct_process(long exitcod
 	ac.ac_mem = encode_comp_t(vsize);
 	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
 	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
-	ac.ac_minflt = encode_comp_t(current->min_flt);
-	ac.ac_majflt = encode_comp_t(current->maj_flt);
+	ac.ac_minflt = encode_comp_t(current->signal->min_flt +
+				     current->group_leader->min_flt);
+	ac.ac_majflt = encode_comp_t(current->signal->maj_flt +
+				     current->group_leader->maj_flt);
 	ac.ac_swaps = encode_comp_t(0);
 	ac.ac_exitcode = exitcode;
 
Index: linux-2.6/kernel/exit.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/exit.c,v
retrieving revision 1.154
diff -B -p -u -r1.154 exit.c
--- linux-2.6/kernel/exit.c 21 Sep 2004 14:15:21 -0000 1.154
+++ linux-2.6/kernel/exit.c 24 Sep 2004 10:14:47 -0000
@@ -807,7 +807,8 @@ asmlinkage NORET_TYPE void do_exit(long 
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
-	acct_process(code);
+	if (atomic_dec_and_test(&tsk->signal->live))
+		acct_process(code);
 	__exit_mm(tsk);
 
 	exit_sem(tsk);
Index: linux-2.6/kernel/fork.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/fork.c,v
retrieving revision 1.216
diff -B -p -u -r1.216 fork.c
--- linux-2.6/kernel/fork.c 23 Sep 2004 01:21:19 -0000 1.216
+++ linux-2.6/kernel/fork.c 24 Sep 2004 10:28:28 -0000
@@ -847,6 +847,7 @@ static inline int copy_signal(unsigned l
 
 	if (clone_flags & CLONE_THREAD) {
 		atomic_inc(&current->signal->count);
+		atomic_inc(&current->signal->live);
 		return 0;
 	}
 	sig = kmem_cache_alloc(signal_cachep, GFP_KERNEL);
@@ -854,6 +855,7 @@ static inline int copy_signal(unsigned l
 	if (!sig)
 		return -ENOMEM;
 	atomic_set(&sig->count, 1);
+	atomic_set(&sig->live, 1);
 	sig->group_exit = 0;
 	sig->group_exit_code = 0;
 	sig->group_exit_task = NULL;
