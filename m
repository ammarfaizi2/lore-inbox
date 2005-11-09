Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbVKISkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbVKISkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbVKISiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:38:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:11933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751492AbVKISh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:37:56 -0500
Date: Wed, 9 Nov 2005 10:37:09 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, oleg@tv-sign.ru,
       roland@redhat.com, paulmck@us.ibm.com, george@mvista.com,
       dipankar@in.ibm.com, mingo@elte.hu, suzannew@cs.pdx.edu
Subject: [patch 09/11] fix de_thread() vs send_group_sigqueue() race
Message-ID: <20051109183709.GJ3670@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-de_thread-vs-send_group_sendqueue-race.patch"
In-Reply-To: <20051109183614.GA3670@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@tv-sign.ru>

When non-leader thread does exec, de_thread calls release_task(leader) before
calling exit_itimers(). If local timer interrupt happens in between, it can
oops in send_group_sigqueue() while taking ->sighand->siglock == NULL.

However, we can't change send_group_sigqueue() to check p->signal != NULL,
because sys_timer_create() does get_task_struct() only in SIGEV_THREAD_ID
case. So it is possible that this task_struct was already freed and we can't
trust p->signal.

This patch changes de_thread() so that leader released after exit_itimers()
call.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/exec.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-2.6.14.1.orig/fs/exec.c
+++ linux-2.6.14.1/fs/exec.c
@@ -593,6 +593,7 @@ static inline int de_thread(struct task_
 	struct signal_struct *sig = tsk->signal;
 	struct sighand_struct *newsighand, *oldsighand = tsk->sighand;
 	spinlock_t *lock = &oldsighand->siglock;
+	struct task_struct *leader = NULL;
 	int count;
 
 	/*
@@ -668,7 +669,7 @@ static inline int de_thread(struct task_
 	 * and to assume its PID:
 	 */
 	if (!thread_group_leader(current)) {
-		struct task_struct *leader = current->group_leader, *parent;
+		struct task_struct *parent;
 		struct dentry *proc_dentry1, *proc_dentry2;
 		unsigned long exit_state, ptrace;
 
@@ -677,6 +678,7 @@ static inline int de_thread(struct task_
 		 * It should already be zombie at this point, most
 		 * of the time.
 		 */
+		leader = current->group_leader;
 		while (leader->exit_state != EXIT_ZOMBIE)
 			yield();
 
@@ -736,7 +738,6 @@ static inline int de_thread(struct task_
 		proc_pid_flush(proc_dentry2);
 
 		BUG_ON(exit_state != EXIT_ZOMBIE);
-		release_task(leader);
         }
 
 	/*
@@ -746,8 +747,11 @@ static inline int de_thread(struct task_
 	sig->flags = 0;
 
 no_thread_group:
-	BUG_ON(atomic_read(&sig->count) != 1);
 	exit_itimers(sig);
+	if (leader)
+		release_task(leader);
+
+	BUG_ON(atomic_read(&sig->count) != 1);
 
 	if (atomic_read(&oldsighand->count) == 1) {
 		/*

--
