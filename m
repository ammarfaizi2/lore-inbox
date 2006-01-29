Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWA2VsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWA2VsR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWA2VsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:48:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55271 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751173AbWA2VsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:48:16 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty_io:  Remove unneeded test for session == 0
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 14:47:48 -0700
Message-ID: <m1r76q7lkr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew earlier you asked about code that can be simplified
by not hashing pid 0.  This is one example. 

That patch actually corrects loops like:
		case IOPRIO_WHO_PGRP:
			if (!who)
				who = process_group(current);
			do_each_task_pid(who, PIDTYPE_PGID, p) {
				ret = set_task_ioprio(p, ioprio);
				if (ret)
					break;
			} while_each_task_pid(who, PIDTYPE_PGID, p);
			break;
If the processes calling it is not a member of a process group.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/char/tty_io.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

5bb76f8c81db4b8a6e5d1c4c1512503e8ccc81c3
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 1d83cd5..901280b 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1069,18 +1069,16 @@ static void do_tty_hangup(void *data)
 	  tty_release is called */
 	
 	read_lock(&tasklist_lock);
-	if (tty->session > 0) {
-		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
-			if (p->signal->tty == tty)
-				p->signal->tty = NULL;
-			if (!p->signal->leader)
-				continue;
-			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
-			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
-			if (tty->pgrp > 0)
-				p->signal->tty_old_pgrp = tty->pgrp;
-		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
-	}
+	do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+		if (p->signal->tty == tty)
+			p->signal->tty = NULL;
+		if (!p->signal->leader)
+			continue;
+		group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
+		group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+		if (tty->pgrp > 0)
+			p->signal->tty_old_pgrp = tty->pgrp;
+	} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 	read_unlock(&tasklist_lock);
 
 	tty->flags = 0;
-- 
1.1.5.g3480

