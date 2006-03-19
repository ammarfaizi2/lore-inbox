Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWCST3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCST3M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 14:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWCST3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 14:29:11 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:32715 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750710AbWCST3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 14:29:09 -0500
Message-ID: <441DB045.87C4134C@tv-sign.ru>
Date: Sun, 19 Mar 2006 22:25:57 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] simplify/fix first_tid()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first_tid:

	/* If nr exceeds the number of threads there is nothing todo */
	if (nr) {
		if (nr >= get_nr_threads(leader))
			goto done;
	}

This is not reliable: sub-threads can exit after this check, so the
'for' loop below can overlap and proc_task_readdir() can return an
already filldir'ed dirents.

	for (; pos && pid_alive(pos); pos = next_thread(pos)) {
		if (--nr > 0)
			continue;

Off-by-one error, will return 'leader' when nr == 1.

This patch tries to fix these problems and simplify the code.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/fs/proc/base.c~	2006-03-19 23:25:38.000000000 +0300
+++ MM/fs/proc/base.c	2006-03-20 00:01:12.000000000 +0300
@@ -2180,38 +2180,29 @@ int proc_pid_readdir(struct file * filp,
 static struct task_struct *first_tid(struct task_struct *leader,
 					int tid, int nr)
 {
-	struct task_struct *pos = NULL;
+	struct task_struct *pos;
 
 	rcu_read_lock();
 	/* Attempt to start with the pid of a thread */
-	if (tid && (nr > 0)) {
-		pos = find_task_by_pid(tid);
-		if (pos && (pos->group_leader != leader))
-			pos = NULL;
-		if (pos)
-			nr = 0;
-	}
-
-	/* If nr exceeds the number of threads there is nothing todo */
-	if (nr) {
-		if (nr >= get_nr_threads(leader))
-			goto done;
-	}
-
-	/* If we haven't found our starting place yet start with the
-	 * leader and walk nr threads forward.
-	 */
-	if (!pos && (nr >= 0))
-		pos = leader;
-
-	for (; pos && pid_alive(pos); pos = next_thread(pos)) {
-		if (--nr > 0)
-			continue;
-		get_task_struct(pos);
-		goto done;
-	}
-	pos = NULL;
-done:
+	if (tid && (nr > 0)) {
+		pos = find_task_by_pid(tid);
+		if (pos && (pos->group_leader == leader))
+			goto found;
+	}
+
+	/* If we haven't found our starting place yet start
+	 * with the leader and walk nr threads forward.
+	 */
+	for (pos = leader; nr > 0; --nr) {
+		pos = next_thread(pos);
+		if (pos == leader) {
+			pos = NULL;
+			goto out;
+		}
+	}
+found:
+	get_task_struct(pos);
+out:
 	rcu_read_unlock();
 	return pos;
 }
