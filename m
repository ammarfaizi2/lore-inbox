Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWJNLWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWJNLWV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbWJNLWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:22:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5311 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752159AbWJNLWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:22:20 -0400
Date: Sat, 14 Oct 2006 07:22:18 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Prarit Bhargava <prarit@redhat.com>
Message-Id: <20061014112218.30218.93267.sendpatchset@prarit.boston.redhat.com>
Subject: [PATCH]: disassociate tty locking fixups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additional tty_mutex locking in do_tty_hangup and disassociate_ctty.  It is
possible that do_tty_hangup sets current->signal->tty = NULL.  If that
happens then disassociate_ctty can corrupt memory.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

--- linux-2.6.18.x86_64.orig/drivers/char/tty_io.c	2006-10-12 10:05:52.000000000 -0400
+++ linux-2.6.18.x86_64/drivers/char/tty_io.c	2006-10-13 11:19:30.000000000 -0400
@@ -1357,6 +1357,8 @@ static void do_tty_hangup(void *data)
 	  This should get done automatically when the port closes and
 	  tty_release is called */
 	
+	/* it is possible current->signal->tty is modified */
+	mutex_lock(&tty_mutex);
 	read_lock(&tasklist_lock);
 	if (tty->session > 0) {
 		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
@@ -1364,14 +1366,16 @@ static void do_tty_hangup(void *data)
 				p->signal->tty = NULL;
 			if (!p->signal->leader)
 				continue;
+			mutex_unlock(&tty_mutex);
 			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
 			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			mutex_lock(&tty_mutex);
 			if (tty->pgrp > 0)
 				p->signal->tty_old_pgrp = tty->pgrp;
 		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 	}
 	read_unlock(&tasklist_lock);
-
+	mutex_unlock(&tty_mutex);
 	tty->flags = 0;
 	tty->session = 0;
 	tty->pgrp = -1;
@@ -1502,7 +1506,7 @@ void disassociate_ctty(int on_exit)
 			kill_pg(current->signal->tty_old_pgrp, SIGCONT, on_exit);
 		}
 		mutex_unlock(&tty_mutex);
-		unlock_kernel();	
+		unlock_kernel();
 		return;
 	}
 	if (tty_pgrp > 0) {
@@ -1514,8 +1518,12 @@ void disassociate_ctty(int on_exit)
 	/* Must lock changes to tty_old_pgrp */
 	mutex_lock(&tty_mutex);
 	current->signal->tty_old_pgrp = 0;
-	tty->session = 0;
-	tty->pgrp = -1;
+
+	/* It is possible that do_tty_hangup has free'd this tty */
+	if (current->signal->tty) {
+		tty->session = 0;
+		tty->pgrp = -1;
+	}
 
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
