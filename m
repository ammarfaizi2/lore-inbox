Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWJWRwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWJWRwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWJWRwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:52:16 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:63929 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964974AbWJWRwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:52:15 -0400
Date: Mon, 23 Oct 2006 21:51:52 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sys_setpgid: eliminate unnecessary do_each_task_pid(PIDTYPE_PGID)
Message-ID: <20061023175152.GA115@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of add-process_session-helper-routine.patch

All tasks in the process group have the same sid, we don't need to iterate
them all to check that the caller of sys_setpgid() doesn't change its session.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc2-mm2/kernel/sys.c~	2006-10-22 19:28:17.000000000 +0400
+++ rc2-mm2/kernel/sys.c	2006-10-23 20:35:56.000000000 +0400
@@ -1398,16 +1398,13 @@ asmlinkage long sys_setpgid(pid_t pid, p
 		goto out;
 
 	if (pgid != pid) {
-		struct task_struct *p;
+		struct task_struct *g =
+			find_task_by_pid_type(PIDTYPE_PGID, pgid);
 
-		do_each_task_pid(pgid, PIDTYPE_PGID, p) {
-			if (process_session(p) == process_session(group_leader))
-				goto ok_pgid;
-		} while_each_task_pid(pgid, PIDTYPE_PGID, p);
-		goto out;
+		if (!g || process_session(g) != process_session(group_leader))
+			goto out;
 	}
 
-ok_pgid:
 	err = security_task_setpgid(p, pgid);
 	if (err)
 		goto out;

