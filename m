Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWBFToR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWBFToR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWBFToQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:44:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45037 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932325AbWBFToO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:44:14 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 07/20] tty: Update the tty layer to work with pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:41:18 -0700
In-Reply-To: <m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:39:02 -0700")
Message-ID: <m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Of kernel subsystems that work with pids the tty layer
is probably the largest consumer.  But it has the nice
virtue that the association with a session only lasts until
the session leader exits.  Which means that no reference
counting is required.  Only caching of the pspace,
and a few extra comparisons.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/char/n_tty.c  |    9 ++++---
 drivers/char/tty_io.c |   62 ++++++++++++++++++++++++++++++-------------------
 include/linux/tty.h   |    1 +
 3 files changed, 44 insertions(+), 28 deletions(-)

5de29104be4f33d4dca8246e13d2996c1ce745b3
diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index ccad7ae..5edfd13 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -580,7 +580,7 @@ static void eraser(unsigned char c, stru
 static inline void isig(int sig, struct tty_struct *tty, int flush)
 {
 	if (tty->pgrp > 0)
-		kill_pg(tty->pgrp, sig, 1);
+		kill_pg(tty->pspace, tty->pgrp, sig, 1);
 	if (flush || !L_NOFLSH(tty)) {
 		n_tty_flush_buffer(tty);
 		if (tty->driver->flush_buffer)
@@ -1187,11 +1187,12 @@ static int job_control(struct tty_struct
 	    current->signal->tty == tty) {
 		if (tty->pgrp <= 0)
 			printk("read_chan: tty->pgrp <= 0!\n");
-		else if (process_group(current) != tty->pgrp) {
+		else if ((process_group(current) != tty->pgrp) ||
+			 (current->pspace != tty->pspace)) {
 			if (is_ignored(SIGTTIN) ||
-			    is_orphaned_pgrp(process_group(current)))
+			    is_orphaned_pgrp(current->pspace, process_group(current)))
 				return -EIO;
-			kill_pg(process_group(current), SIGTTIN, 1);
+			kill_pg(current->pspace, process_group(current), SIGTTIN, 1);
 			return -ERESTARTSYS;
 		}
 	}
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 1d83cd5..b6f3004 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -95,6 +95,7 @@
 #include <linux/wait.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/pspace.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -858,13 +859,14 @@ int tty_check_change(struct tty_struct *
 		printk(KERN_WARNING "tty_check_change: tty->pgrp <= 0!\n");
 		return 0;
 	}
-	if (process_group(current) == tty->pgrp)
+	if ((process_group(current) == tty->pgrp) &&
+	    (current->pspace == tty->pspace))
 		return 0;
 	if (is_ignored(SIGTTOU))
 		return 0;
-	if (is_orphaned_pgrp(process_group(current)))
+	if (is_orphaned_pgrp(current->pspace, process_group(current)))
 		return -EIO;
-	(void) kill_pg(process_group(current), SIGTTOU, 1);
+	(void) kill_pg(current->pspace, process_group(current), SIGTTOU, 1);
 	return -ERESTARTSYS;
 }
 
@@ -1070,7 +1072,7 @@ static void do_tty_hangup(void *data)
 	
 	read_lock(&tasklist_lock);
 	if (tty->session > 0) {
-		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+		do_each_task_pid(tty->pspace, tty->session, PIDTYPE_SID, p) {
 			if (p->signal->tty == tty)
 				p->signal->tty = NULL;
 			if (!p->signal->leader)
@@ -1079,11 +1081,12 @@ static void do_tty_hangup(void *data)
 			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
 			if (tty->pgrp > 0)
 				p->signal->tty_old_pgrp = tty->pgrp;
-		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+		} while_each_task_pid(tty->pspace, tty->session, PIDTYPE_SID, p);
 	}
 	read_unlock(&tasklist_lock);
 
 	tty->flags = 0;
+	tty->pspace = NULL;
 	tty->session = 0;
 	tty->pgrp = -1;
 	tty->ctrl_status = 0;
@@ -1162,6 +1165,7 @@ void disassociate_ctty(int on_exit)
 {
 	struct tty_struct *tty;
 	struct task_struct *p;
+	struct pspace *tty_pspace = NULL;
 	int tty_pgrp = -1;
 
 	lock_kernel();
@@ -1170,35 +1174,37 @@ void disassociate_ctty(int on_exit)
 	tty = current->signal->tty;
 	if (tty) {
 		tty_pgrp = tty->pgrp;
+		tty_pspace = tty->pspace;
 		up(&tty_sem);
 		if (on_exit && tty->driver->type != TTY_DRIVER_TYPE_PTY)
 			tty_vhangup(tty);
 	} else {
 		if (current->signal->tty_old_pgrp) {
-			kill_pg(current->signal->tty_old_pgrp, SIGHUP, on_exit);
-			kill_pg(current->signal->tty_old_pgrp, SIGCONT, on_exit);
+			kill_pg(current->pspace, current->signal->tty_old_pgrp, SIGHUP, on_exit);
+			kill_pg(current->pspace, current->signal->tty_old_pgrp, SIGCONT, on_exit);
 		}
 		up(&tty_sem);
 		unlock_kernel();	
 		return;
 	}
 	if (tty_pgrp > 0) {
-		kill_pg(tty_pgrp, SIGHUP, on_exit);
+		kill_pg(tty_pspace, tty_pgrp, SIGHUP, on_exit);
 		if (!on_exit)
-			kill_pg(tty_pgrp, SIGCONT, on_exit);
+			kill_pg(tty_pspace, tty_pgrp, SIGCONT, on_exit);
 	}
 
 	/* Must lock changes to tty_old_pgrp */
 	down(&tty_sem);
 	current->signal->tty_old_pgrp = 0;
+	tty->pspace = NULL;
 	tty->session = 0;
 	tty->pgrp = -1;
 
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
-	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
+	do_each_task_pid(current->pspace, current->signal->session, PIDTYPE_SID, p) {
 		p->signal->tty = NULL;
-	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
+	} while_each_task_pid(current->pspace, current->signal->session, PIDTYPE_SID, p);
 	read_unlock(&tasklist_lock);
 	up(&tty_sem);
 	unlock_kernel();
@@ -1905,13 +1911,13 @@ static void release_dev(struct file * fi
 		struct task_struct *p;
 
 		read_lock(&tasklist_lock);
-		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+		do_each_task_pid(tty->pspace, tty->session, PIDTYPE_SID, p) {
 			p->signal->tty = NULL;
-		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+		} while_each_task_pid(tty->pspace, tty->session, PIDTYPE_SID, p);
 		if (o_tty)
-			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
+			do_each_task_pid(o_tty->pspace, o_tty->session, PIDTYPE_SID, p) {
 				p->signal->tty = NULL;
-			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
+			} while_each_task_pid(o_tty->pspace, o_tty->session, PIDTYPE_SID, p);
 		read_unlock(&tasklist_lock);
 	}
 
@@ -2110,6 +2116,7 @@ got_driver:
 		current->signal->tty = tty;
 		task_unlock(current);
 		current->signal->tty_old_pgrp = 0;
+		tty->pspace = current->pspace;
 		tty->session = current->signal->session;
 		tty->pgrp = process_group(current);
 	}
@@ -2270,9 +2277,9 @@ static int tiocswinsz(struct tty_struct 
 	}
 #endif
 	if (tty->pgrp > 0)
-		kill_pg(tty->pgrp, SIGWINCH, 1);
+		kill_pg(tty->pspace, tty->pgrp, SIGWINCH, 1);
 	if ((real_tty->pgrp != tty->pgrp) && (real_tty->pgrp > 0))
-		kill_pg(real_tty->pgrp, SIGWINCH, 1);
+		kill_pg(real_tty->pspace, real_tty->pgrp, SIGWINCH, 1);
 	tty->winsize = tmp_ws;
 	real_tty->winsize = tmp_ws;
 	return 0;
@@ -2342,9 +2349,9 @@ static int tiocsctty(struct tty_struct *
 			 */
 
 			read_lock(&tasklist_lock);
-			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+			do_each_task_pid(tty->pspace, tty->session, PIDTYPE_SID, p) {
 				p->signal->tty = NULL;
-			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+			} while_each_task_pid(tty->pspace, tty->session, PIDTYPE_SID, p);
 			read_unlock(&tasklist_lock);
 		} else
 			return -EPERM;
@@ -2353,6 +2360,7 @@ static int tiocsctty(struct tty_struct *
 	current->signal->tty = tty;
 	task_unlock(current);
 	current->signal->tty_old_pgrp = 0;
+	tty->pspace = current->pspace;
 	tty->session = current->signal->session;
 	tty->pgrp = process_group(current);
 	return 0;
@@ -2360,17 +2368,22 @@ static int tiocsctty(struct tty_struct *
 
 static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
+	pid_t pgrp;
 	/*
 	 * (tty == real_tty) is a cheap way of
 	 * testing if the tty is NOT a master pty.
 	 */
 	if (tty == real_tty && current->signal->tty != real_tty)
 		return -ENOTTY;
-	return put_user(real_tty->pgrp, p);
+	pgrp = real_tty->pgrp;
+	if (real_tty->pspace != current->pspace)
+		pgrp = -1;
+	return put_user(pgrp, p);
 }
 
 static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
+	struct pspace *pspace = current->pspace;
 	pid_t pgrp;
 	int retval = tty_check_change(real_tty);
 
@@ -2380,13 +2393,14 @@ static int tiocspgrp(struct tty_struct *
 		return retval;
 	if (!current->signal->tty ||
 	    (current->signal->tty != real_tty) ||
-	    (real_tty->session != current->signal->session))
+	    (real_tty->session != current->signal->session) ||
+	    (real_tty->pspace != pspace))
 		return -ENOTTY;
 	if (get_user(pgrp, p))
 		return -EFAULT;
 	if (pgrp < 0)
 		return -EINVAL;
-	if (session_of_pgrp(pgrp) != current->signal->session)
+	if (session_of_pgrp(pspace, pgrp) != current->signal->session)
 		return -EPERM;
 	real_tty->pgrp = pgrp;
 	return 0;
@@ -2676,12 +2690,12 @@ static void __do_SAK(void *arg)
 	
 	read_lock(&tasklist_lock);
 	/* Kill the entire session */
-	do_each_task_pid(session, PIDTYPE_SID, p) {
+	do_each_task_pid(tty->pspace, session, PIDTYPE_SID, p) {
 		printk(KERN_NOTICE "SAK: killed process %d"
 			" (%s): p->signal->session==tty->session\n",
 			p->pid, p->comm);
 		send_sig(SIGKILL, p, 1);
-	} while_each_task_pid(session, PIDTYPE_SID, p);
+	} while_each_task_pid(tty->pspace, session, PIDTYPE_SID, p);
 	/* Now kill any processes that happen to have the
 	 * tty open.
 	 */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 898d593..bc9e9c4 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -184,6 +184,7 @@ struct tty_struct {
 	struct semaphore termios_sem;
 	struct termios *termios, *termios_locked;
 	char name[64];
+	struct pspace *pspace;
 	int pgrp;
 	int session;
 	unsigned long flags;
-- 
1.1.5.g3480

