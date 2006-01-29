Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWA2G3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWA2G3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWA2G3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:29:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29406 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750850AbWA2G33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:29:29 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] do_SAK: Don't depenend on session ID 0.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 28 Jan 2006 23:29:02 -0700
Message-ID: <m1irs3fsy9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not really certain what the thinking was but the code
obviously wanted to walk processes other than just those
in it's session, for purposes of do_SAK.  Just walking
those tasks that don't have a session assigned sounds
at the very least incomplete.

So modify the code to kill everything in the session and
anything else that might have the tty open.  Hopefully this
helps if the do_SAK functionality is ever finished.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/char/tty_io.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

c626a6c60e5a95476660e5ea87f4b912e2f3a784
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index eb8b5be..da9ed47 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -2654,7 +2654,7 @@ static void __do_SAK(void *arg)
 	tty_hangup(tty);
 #else
 	struct tty_struct *tty = arg;
-	struct task_struct *p;
+	struct task_struct *g, *p;
 	int session;
 	int		i;
 	struct file	*filp;
@@ -2675,8 +2675,18 @@ static void __do_SAK(void *arg)
 		tty->driver->flush_buffer(tty);
 	
 	read_lock(&tasklist_lock);
+	/* Kill the entire session */
 	do_each_task_pid(session, PIDTYPE_SID, p) {
-		if (p->signal->tty == tty || session > 0) {
+		printk(KERN_NOTICE "SAK: killed process %d"
+			" (%s): p->signal->session==tty->session\n",
+			p->pid, p->comm);
+		send_sig(SIGKILL, p, 1);
+	} while_each_task_pid(session, PIDTYPE_SID, p);
+	/* Now kill any processes that happen to have the
+	 * tty open.
+	 */
+	do_each_thread(g, p) {
+		if (p->signal->tty == tty) {
 			printk(KERN_NOTICE "SAK: killed process %d"
 			    " (%s): p->signal->session==tty->session\n",
 			    p->pid, p->comm);
@@ -2703,7 +2713,7 @@ static void __do_SAK(void *arg)
 			rcu_read_unlock();
 		}
 		task_unlock(p);
-	} while_each_task_pid(session, PIDTYPE_SID, p);
+	} while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
 #endif
 }
-- 
1.1.5.g3480

