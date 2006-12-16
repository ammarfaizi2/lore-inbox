Return-Path: <linux-kernel-owner+w=401wt.eu-S932627AbWLPUkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWLPUkd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWLPUkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:40:33 -0500
Received: from mail.screens.ru ([213.234.233.54]:60296 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932627AbWLPUkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:40:33 -0500
Date: Sat, 16 Dec 2006 23:05:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kill_something_info: misc cleanups
Message-ID: <20061216200510.GA5535@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of
	signal-rewrite-kill_something_info-so-it-uses-newer-helpers.patch

- Factor out sending PIDTYPE_PGID wide signals.

- Use is_init(p) instead of "p->pid > 1". We don't hash idle threads anymore,
  no need to worry about p->pid == 0.

- Use "p != current->group_leader" instead of "p->tgid != current->tgid",
  saves one dereference and kills yet another direct pid_t usage.

- Simplify return value calculation for "pid == -1" case, remove "retval"
  variable.

No functional changes.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- eric-mm1/kernel/signal.c~1_ksi	2006-12-16 20:57:58.000000000 +0300
+++ eric-mm1/kernel/signal.c	2006-12-16 22:08:43.000000000 +0300
@@ -1317,34 +1317,37 @@ EXPORT_SYMBOL_GPL(kill_pid_info_as_uid);
  * POSIX specifies that kill(-1,sig) is unspecified, but what we have
  * is probably wrong.  Should make it like BSD or SYSV.
  */
-
 static int kill_something_info(int sig, struct siginfo *info, int pid)
 {
 	int ret;
-	rcu_read_lock();
-	if (!pid) {
-		ret = kill_pgrp_info(sig, info, task_pgrp(current));
-	} else if (pid == -1) {
-		int retval = 0, count = 0;
-		struct task_struct * p;
-
-		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->pid > 1 && p->tgid != current->tgid) {
-				int err = group_send_sig_info(sig, info, p);
-				++count;
-				if (err != -EPERM)
-					retval = err;
-			}
-		}
-		read_unlock(&tasklist_lock);
-		ret = count ? retval : -ESRCH;
-	} else if (pid < 0) {
-		ret = kill_pgrp_info(sig, info, find_pid(-pid));
-	} else {
-		ret = kill_pid_info(sig, info, find_pid(pid));
-	}
-	rcu_read_unlock();
+
+	rcu_read_lock();
+	if (pid > 0) {
+		ret = kill_pid_info(sig, info, find_pid(pid));
+	} else if (pid == -1) {
+		struct task_struct *p;
+		int found = 0;
+
+		ret = 0;
+		read_lock(&tasklist_lock);
+		for_each_process(p)
+			if (!is_init(p) && p != current->group_leader) {
+				int err = group_send_sig_info(sig, info, p);
+				if (err != -EPERM)
+					ret = err;
+				found = 1;
+			}
+		read_unlock(&tasklist_lock);
+		if (!found)
+			ret = -ESRCH;
+	} else {
+		struct pid *grp = task_pgrp(current);
+		if (pid != 0)
+			grp = find_pid(-pid);
+		ret = kill_pgrp_info(sig, info, grp);
+	}
+	rcu_read_unlock();
+
 	return ret;
 }
 

