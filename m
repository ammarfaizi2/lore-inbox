Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWJXSWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWJXSWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWJXSWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:22:06 -0400
Received: from [213.234.233.54] ([213.234.233.54]:63920 "EHLO mail.screens.ru")
	by vger.kernel.org with ESMTP id S1161138AbWJXSWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:22:03 -0400
Date: Tue, 24 Oct 2006 22:21:37 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] session_of_pgrp: kill unnecessary do_each_task_pid(PIDTYPE_PGID)
Message-ID: <20061024182137.GA1369@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of add-process_session-helper-routine.patch

All members of the process group have the same sid and it can't be == 0.

NOTE: this code (and a similar one in sys_setpgid) was needed because it
was possibe to have ->session == 0. It's not possible any longer since

	[PATCH] pidhash: don't use zero pids
	Commit: c7c6464117a02b0d54feb4ebeca4db70fa493678

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc2-mm2/kernel/exit.c~	2006-10-24 20:39:31.000000000 +0400
+++ rc2-mm2/kernel/exit.c	2006-10-24 20:46:14.000000000 +0400
@@ -188,21 +188,18 @@ repeat:
 int session_of_pgrp(int pgrp)
 {
 	struct task_struct *p;
-	int sid = -1;
+	int sid = 0;
 
 	read_lock(&tasklist_lock);
-	do_each_task_pid(pgrp, PIDTYPE_PGID, p) {
-		if (process_session(p) > 0) {
-			sid = process_session(p);
-			goto out;
-		}
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, p);
-	p = find_task_by_pid(pgrp);
-	if (p)
+
+	p = find_task_by_pid_type(PIDTYPE_PGID, pgrp);
+	if (p == NULL)
+		p = find_task_by_pid(pgrp);
+	if (p != NULL)
 		sid = process_session(p);
-out:
+
 	read_unlock(&tasklist_lock);
-	
+
 	return sid;
 }
 

