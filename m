Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWIIWTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWIIWTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWIIWTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:19:12 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:12756 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964970AbWIIWTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:19:09 -0400
Date: Sun, 10 Sep 2006 02:19:01 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jean Delvare <jdelvare@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] proc: convert task_sig() to use lock_task_sighand()
Message-ID: <20060909221901.GA146@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lock_task_sighand() can take ->siglock without holding tasklist_lock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc6-mm1/fs/proc/array.c~1_sig	2006-09-09 16:49:09.000000000 +0400
+++ rc6-mm1/fs/proc/array.c	2006-09-09 17:47:22.000000000 +0400
@@ -244,6 +244,7 @@ static void collect_sigign_sigcatch(stru
 
 static inline char * task_sig(struct task_struct *p, char *buffer)
 {
+	unsigned long flags;
 	sigset_t pending, shpending, blocked, ignored, caught;
 	int num_threads = 0;
 	unsigned long qsize = 0;
@@ -255,10 +256,8 @@ static inline char * task_sig(struct tas
 	sigemptyset(&ignored);
 	sigemptyset(&caught);
 
-	/* Gather all the data with the appropriate locks held */
-	read_lock(&tasklist_lock);
-	if (p->sighand) {
-		spin_lock_irq(&p->sighand->siglock);
+	rcu_read_lock();
+	if (lock_task_sighand(p, &flags)) {
 		pending = p->pending.signal;
 		shpending = p->signal->shared_pending.signal;
 		blocked = p->blocked;
@@ -266,9 +265,9 @@ static inline char * task_sig(struct tas
 		num_threads = atomic_read(&p->signal->count);
 		qsize = atomic_read(&p->user->sigpending);
 		qlim = p->signal->rlim[RLIMIT_SIGPENDING].rlim_cur;
-		spin_unlock_irq(&p->sighand->siglock);
+		unlock_task_sighand(p, &flags);
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 
 	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
 	buffer += sprintf(buffer, "SigQ:\t%lu/%lu\n", qsize, qlim);

