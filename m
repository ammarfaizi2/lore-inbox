Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSHGWFt>; Wed, 7 Aug 2002 18:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSHGWFt>; Wed, 7 Aug 2002 18:05:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49076 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315266AbSHGWFp>; Wed, 7 Aug 2002 18:05:45 -0400
Subject: [PATCH] Linux-2.5 fix/improve get_pid()
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Cc: davej@suse.de, frankeh@us.ibm.com, andrea@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Aug 2002 17:03:54 -0500
Message-Id: <1028757835.22405.300.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch provides an improved version of get_pid() while also taking
care of the bug that causes the machine to hang when you hit PID_MAX. 
It is based on both solutions to the problem provided by Hubertus Franke
and Andrea Arcangeli.  This uses a bitmap to find an available pid and
uses Hubertus's adaptive implementation to only use this when it is more
beneficial than the old mechanism.  The getpid_mutex from AA's patch is
also carried over to avoid the race where another cpu could get the same
pid before SET_LINKS was called.

This should patch cleanly against 2.5.30 or bk current.
Please apply.

--- a/kernel/fork.c	Wed Aug  7 16:37:38 2002
+++ b/kernel/fork.c	Wed Aug  7 16:05:22 2002
@@ -50,6 +50,12 @@
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
+/*
+ * Protectes next_safe, last_pid and it avoids races
+ * between get_pid and SET_LINKS().
+ */
+static DECLARE_MUTEX(getpid_mutex);
+
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -129,27 +135,107 @@
 	kmem_cache_free(task_struct_cachep,tsk);
 }
 
-/* Protects next_safe and last_pid. */
-spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
+/* this should be provided in every architecture */
+#ifndef SHIFT_PER_LONG
+#if BITS_PER_LONG == 64
+#   define SHIFT_PER_LONG 6
+#elif BITS_PER_LONG == 32
+#   define SHIFT_PER_LONG 5
+#else
+#error "SHIFT_PER_LONG"
+#endif
+#endif
+
+#define RESERVED_PIDS       (300)
+#define GETPID_THRESHOLD    (22000)  /* when to switch to a mapped algo */
+#define PID_MAP_SIZE        (PID_MAX >> SHIFT_PER_LONG)
+static unsigned long pid_map[PID_MAP_SIZE];
+static int next_safe = PID_MAX;
+
+static inline void mark_pid(int pid)
+{
+	__set_bit(pid,pid_map);
+}
+
+static int get_pid_by_map(int lastpid) 
+{
+	static int mark_and_sweep = 0;
+
+	int round = 0;
+	struct task_struct *p;
+	int i;
+	unsigned long mask;
+	int fpos;
+
+
+	if (mark_and_sweep) {
+repeat:
+		mark_and_sweep = 0;
+		memset(pid_map, 0, PID_MAP_SIZE * sizeof(unsigned long));
+		lastpid = RESERVED_PIDS;
+	}
+	for_each_task(p) {
+		mark_pid(p->pid);
+		mark_pid(p->pgrp);
+		mark_pid(p->tgid);
+		mark_pid(p->session);
+	}
+
+	/* find next free pid */
+	i = (lastpid >> SHIFT_PER_LONG);
+	mask = pid_map[i] | ((1 << ((lastpid & (BITS_PER_LONG-1)))) - 1);   
+
+	while ((mask == ~0) && (++i < PID_MAP_SIZE)) 
+		mask = pid_map[i];
+
+	if (i == PID_MAP_SIZE) { 
+		if (round == 0) {
+			round = 1;
+			goto repeat;
+		}
+		next_safe = RESERVED_PIDS;
+		mark_and_sweep = 1;  /* mark next time */
+		return 0; 
+	}
+
+	fpos = ffz(mask);
+	i &= (PID_MAX-1);
+	lastpid = (i << SHIFT_PER_LONG) + fpos;
+
+	/* find next save pid */
+	mask &= ~((1 << fpos) - 1);
+
+	while ((mask == 0) && (++i < PID_MAP_SIZE)) 
+		mask = pid_map[i];
+
+	if (i==PID_MAP_SIZE) 
+		next_safe = PID_MAX;
+	else 
+		next_safe = (i << SHIFT_PER_LONG) + ffs(mask) - 1;
+	return lastpid;
+}
 
 static int get_pid(unsigned long flags)
 {
-	static int next_safe = PID_MAX;
 	struct task_struct *p;
 	int pid;
 
-	if (flags & CLONE_IDLETASK)
-		return 0;
-
-	spin_lock(&lastpid_lock);
 	if((++last_pid) & 0xffff8000) {
-		last_pid = 300;		/* Skip daemons etc. */
+		last_pid = RESERVED_PIDS;	/* Skip daemons etc. */
 		goto inside;
 	}
 	if(last_pid >= next_safe) {
 inside:
 		next_safe = PID_MAX;
 		read_lock(&tasklist_lock);
+		if (nr_threads > GETPID_THRESHOLD) {
+			last_pid = get_pid_by_map(last_pid);
+			if (last_pid == 0) {
+				last_pid = PID_MAX;
+				goto nomorepids; 
+			}
+		} else {
+			int beginpid = last_pid;
 	repeat:
 		for_each_task(p) {
 			if(p->pid == last_pid	||
@@ -158,24 +244,33 @@
 			   p->session == last_pid) {
 				if(++last_pid >= next_safe) {
 					if(last_pid & 0xffff8000)
-						last_pid = 300;
+						last_pid = RESERVED_PIDS;
 					next_safe = PID_MAX;
 				}
+				if(last_pid == beginpid)
+					goto nomorepids;
 				goto repeat;
 			}
 			if(p->pid > last_pid && next_safe > p->pid)
 				next_safe = p->pid;
 			if(p->pgrp > last_pid && next_safe > p->pgrp)
 				next_safe = p->pgrp;
+			if(p->tgid > last_pid && next_safe > p->tgid)
+				next_safe = p->tgid;
 			if(p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
 		}
+		}
 		read_unlock(&tasklist_lock);
 	}
 	pid = last_pid;
-	spin_unlock(&lastpid_lock);
 
 	return pid;
+
+nomorepids:
+	next_safe = last_pid = PID_MAX;
+	read_unlock(&tasklist_lock);
+	return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)
@@ -669,7 +764,14 @@
 	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
-	p->pid = get_pid(clone_flags);
+	down(&getpid_mutex);
+	if (clone_flags & CLONE_IDLETASK)
+		p->pid = 0;
+	else {
+		p->pid = get_pid(clone_flags);
+		if (p->pid == 0)
+			goto bad_fork_cleanup;
+	}
 	p->proc_dentry = NULL;
 
 	INIT_LIST_HEAD(&p->run_list);
@@ -793,10 +895,20 @@
 		list_add(&p->thread_group, &current->thread_group);
 	}
 
+	/*
+	 * We must do the SET_LINKS() under the getpid_mutex, to avoid
+	 * another CPU to get our same PID between the release of of the
+	 * getpid_mutex and the SET_LINKS().
+	 *
+	 * In short to avoid SMP races the new child->pid must be just visible
+	 * in the tasklist by the time we drop the getpid_mutex.
+	 */
 	SET_LINKS(p);
+
 	hash_pid(p);
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
+	up(&getpid_mutex);
 	retval = 0;
 
 fork_out:
@@ -819,6 +931,7 @@
 bad_fork_cleanup_security:
 	security_ops->task_free_security(p);
 bad_fork_cleanup:
+	up(&getpid_mutex);
 	put_exec_domain(p->thread_info->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);

