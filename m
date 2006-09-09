Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWIIWTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWIIWTr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWIIWTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:19:46 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:16596 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964971AbWIIWTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:19:45 -0400
Date: Sun, 10 Sep 2006 02:19:34 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jean Delvare <jdelvare@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH -mm 2/3] proc: convert do_task_stat() to use lock_task_sighand()
Message-ID: <20060909221934.GA149@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of tty-stop-the-tty-vanishing-under-procfs-access.patch

Drop tasklist_lock. ->siglock protects almost all interesting data
(including sub-threads traversal) except:

	->signal->tty
		protected by tty_mutex

	->real_parent
		the task can't be unhashed while we are holding
		->siglock, so ->real_parent can change from under us
		but we can safely dereference it under rcu_read_lock()

	->pgrp/->session
		we can get inconsistent numbers if the task does
		sys_setsid/daemonize at the same time. I hope this
		is acceptable.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc6-mm1/fs/proc/array.c~2_stat	2006-09-09 17:47:22.000000000 +0400
+++ rc6-mm1/fs/proc/array.c	2006-09-09 20:36:46.000000000 +0400
@@ -321,7 +321,7 @@ static int do_task_stat(struct task_stru
 	sigset_t sigign, sigcatch;
 	char state;
 	int res;
- 	pid_t ppid, pgid = -1, sid = -1;
+ 	pid_t ppid = 0, pgid = -1, sid = -1;
 	int num_threads = 0;
 	struct mm_struct *mm;
 	unsigned long long start_time;
@@ -329,8 +329,8 @@ static int do_task_stat(struct task_stru
 	unsigned long  min_flt = 0,  maj_flt = 0;
 	cputime_t cutime, cstime, utime, stime;
 	unsigned long rsslim = 0;
-	struct task_struct *t;
 	char tcomm[sizeof(task->comm)];
+	unsigned long flags;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -348,47 +348,54 @@ static int do_task_stat(struct task_stru
 	cutime = cstime = utime = stime = cputime_zero;
 
 	mutex_lock(&tty_mutex);
-	read_lock(&tasklist_lock);
-	if (task->sighand) {
-		spin_lock_irq(&task->sighand->siglock);
-		num_threads = atomic_read(&task->signal->count);
-		collect_sigign_sigcatch(task, &sigign, &sigcatch);
-
-		/* add up live thread stats at the group level */
-		if (whole) {
-			t = task;
-			do {
-				min_flt += t->min_flt;
-				maj_flt += t->maj_flt;
-				utime = cputime_add(utime, t->utime);
-				stime = cputime_add(stime, t->stime);
-				t = next_thread(t);
-			} while (t != task);
-		}
-
-		spin_unlock_irq(&task->sighand->siglock);
-	}
-	if (task->signal) {
-		if (task->signal->tty) {
-			tty_pgrp = task->signal->tty->pgrp;
-			tty_nr = new_encode_dev(tty_devnum(task->signal->tty));
-		}
-		pgid = process_group(task);
-		sid = task->signal->session;
-		cmin_flt = task->signal->cmin_flt;
-		cmaj_flt = task->signal->cmaj_flt;
-		cutime = task->signal->cutime;
-		cstime = task->signal->cstime;
-		rsslim = task->signal->rlim[RLIMIT_RSS].rlim_cur;
-		if (whole) {
-			min_flt += task->signal->min_flt;
-			maj_flt += task->signal->maj_flt;
-			utime = cputime_add(utime, task->signal->utime);
-			stime = cputime_add(stime, task->signal->stime);
-		}
-	}
-	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
-	read_unlock(&tasklist_lock);
+	rcu_read_lock();
+	if (lock_task_sighand(task, &flags)) {
+		struct signal_struct *sig = task->signal;
+		struct tty_struct *tty = sig->tty;
+
+		if (tty) {
+			/*
+			 * sig->tty is not stable, but tty_mutex
+			 * protects us from release_dev(tty)
+			 */
+			barrier();
+			tty_pgrp = tty->pgrp;
+			tty_nr = new_encode_dev(tty_devnum(tty));
+		}
+
+		num_threads = atomic_read(&sig->count);
+		collect_sigign_sigcatch(task, &sigign, &sigcatch);
+
+		cmin_flt = sig->cmin_flt;
+		cmaj_flt = sig->cmaj_flt;
+		cutime = sig->cutime;
+		cstime = sig->cstime;
+		rsslim = sig->rlim[RLIMIT_RSS].rlim_cur;
+
+		/* add up live thread stats at the group level */
+		if (whole) {
+			struct task_struct *t = task;
+			do {
+				min_flt += t->min_flt;
+				maj_flt += t->maj_flt;
+				utime = cputime_add(utime, t->utime);
+				stime = cputime_add(stime, t->stime);
+				t = next_thread(t);
+			} while (t != task);
+
+			min_flt += sig->min_flt;
+			maj_flt += sig->maj_flt;
+			utime = cputime_add(utime, sig->utime);
+			stime = cputime_add(stime, sig->stime);
+		}
+
+		sid = sig->session;
+		pgid = process_group(task);
+		ppid = rcu_dereference(task->real_parent)->tgid;
+
+		unlock_task_sighand(task, &flags);
+	}
+	rcu_read_unlock();
 	mutex_unlock(&tty_mutex);
 
 	if (!whole || num_threads<2)

