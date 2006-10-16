Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWJPL2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWJPL2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 07:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWJPL2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 07:28:17 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:47125 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751526AbWJPL2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 07:28:16 -0400
Subject: [RFC][PATCH] ->signal->tty locking
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 11:53:40 +0200
Message-Id: <1160992420.22727.14.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg wrote:
"Historically ->signal/->sighand (both ptrs and their contents) were globally
protected by tasklist_lock. 'current' can use these pointers lockless, they
can't be changed under him.

Nowadays ->signal/->sighand are _also_ protected by ->sighand->siglock.
Unless you are current, you can't lock ->siglock directly (without holding
tasklist_lock), you should use lock_task_sighand()."

Then, to be consistent with the rest of the kernel, ->signal->tty
locking should look like so:

  mutex_lock(&tty_mutex)
    read_lock(&tasklist_lock)
      lock_task_sighand(p, &flags)

However, lock_task_sighand(), is a conditional lock, p might not have a
->sighand, in which case it returns NULL. What would that mean for
->signal, can I then still modify it?

struct sighand_struct *sighand = lock_task_sighand(p, &flags);
if (sighand) {
	/* modify/use ->signal->tty */
	unlock_task_sighand(p, &flags);
} else
	/* now what !? */

The same problem appears in fs/proc/array.c:do_task_stat(), there the
locking doesn't look quite right either.

Before realizing this I came this far:
---
 drivers/char/tty_io.c |   86 ++++++++++++++++++++++++++++++++++++++------------
 kernel/auditsc.c      |    1 
 kernel/exit.c         |    3 +
 kernel/sys.c          |    4 ++
 4 files changed, 75 insertions(+), 19 deletions(-)

Index: linux-2.6/drivers/char/tty_io.c
===================================================================
--- linux-2.6.orig/drivers/char/tty_io.c
+++ linux-2.6/drivers/char/tty_io.c
@@ -63,6 +63,12 @@
  *
  * Move do_SAK() into process context.  Less stack use in devfs functions.
  * alloc_tty_struct() always uses kmalloc() -- Andrew Morton <andrewm@uow.edu.eu> 17Mar01
+ *
+ * A word on (struct task)::signal->tty locking
+ *
+ *   mutex_lock(&tty_mutex)
+ *     read_lock(&tasklist_lock)
+ *       lock_task_sighand()
  */
 
 #include <linux/types.h>
@@ -1282,6 +1288,7 @@ static void do_tty_hangup(void *data)
 	struct task_struct *p;
 	struct tty_ldisc *ld;
 	int    closecount = 0, n;
+	unsigned long flags;
 
 	if (!tty)
 		return;
@@ -1350,20 +1357,26 @@ static void do_tty_hangup(void *data)
 	  This should get done automatically when the port closes and
 	  tty_release is called */
 	
+	mutex_lock(&tty_mutex);
 	read_lock(&tasklist_lock);
 	if (tty->session > 0) {
 		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+			lock_task_sighand(p, &flags);
 			if (p->signal->tty == tty)
 				p->signal->tty = NULL;
+			unlock_task_sighand(p, &flags);
 			if (!p->signal->leader)
 				continue;
 			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
 			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			lock_task_sighand(p, &flags);
 			if (tty->pgrp > 0)
 				p->signal->tty_old_pgrp = tty->pgrp;
+			unlock_task_sighand(p, &flags);
 		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 	}
 	read_unlock(&tasklist_lock);
+	mutex_unlock(&tty_mutex);
 
 	tty->flags = 0;
 	tty->session = 0;
@@ -1479,10 +1492,12 @@ void disassociate_ctty(int on_exit)
 	struct tty_struct *tty;
 	struct task_struct *p;
 	int tty_pgrp = -1;
+	unsigned long flags;
 
 	lock_kernel();
 
 	mutex_lock(&tty_mutex);
+	/* XXX is this save wrt siglock!? */
 	tty = current->signal->tty;
 	if (tty) {
 		tty_pgrp = tty->pgrp;
@@ -1490,9 +1505,10 @@ void disassociate_ctty(int on_exit)
 		if (on_exit && tty->driver->type != TTY_DRIVER_TYPE_PTY)
 			tty_vhangup(tty);
 	} else {
-		if (current->signal->tty_old_pgrp) {
-			kill_pg(current->signal->tty_old_pgrp, SIGHUP, on_exit);
-			kill_pg(current->signal->tty_old_pgrp, SIGCONT, on_exit);
+		pid_t old_pgrp = current->signal->tty_old_pgrp;
+		if (old_pgrp) {
+			kill_pg(old_pgrp, SIGHUP, on_exit);
+			kill_pg(old_pgrp, SIGCONT, on_exit);
 		}
 		mutex_unlock(&tty_mutex);
 		unlock_kernel();	
@@ -1506,14 +1522,27 @@ void disassociate_ctty(int on_exit)
 
 	/* Must lock changes to tty_old_pgrp */
 	mutex_lock(&tty_mutex);
+	lock_task_sighand(current, &flags);
 	current->signal->tty_old_pgrp = 0;
-	tty->session = 0;
-	tty->pgrp = -1;
+
+	/* It is possible that do_tty_hangup has free'd this tty */
+	if (current->signal->tty) {
+		current->signal->tty->session = 0;
+		current->signal->tty->pgrp = 0;
+	} else {
+#ifdef TTY_DEBUG_HANGUP
+		printk(KERN_DEBUG "error attempted to write to tty [0x%p]"
+		       " = NULL", tty);
+#endif
+	}
+	unlock_task_sighand(current, &flags);
 
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
 	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
+		lock_task_sighand(p, &flags);
 		p->signal->tty = NULL;
+		unlock_task_sighand(p, &flags);
 	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
 	read_unlock(&tasklist_lock);
 	mutex_unlock(&tty_mutex);
@@ -2340,11 +2369,15 @@ static void release_dev(struct file * fi
 
 		read_lock(&tasklist_lock);
 		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+			lock_task_sighand(p, &flags);
 			p->signal->tty = NULL;
+			unlock_task_sighand(p, &flags);
 		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 		if (o_tty)
 			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
+				lock_task_sighand(p, &flags);
 				p->signal->tty = NULL;
+				unlock_task_sighand(p, &flags);
 			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
 		read_unlock(&tasklist_lock);
 	}
@@ -2455,6 +2488,7 @@ static int tty_open(struct inode * inode
 	int index;
 	dev_t device = inode->i_rdev;
 	unsigned short saved_flags = filp->f_flags;
+	unsigned long flags;
 
 	nonseekable_open(inode, filp);
 	
@@ -2466,7 +2500,9 @@ retry_open:
 	mutex_lock(&tty_mutex);
 
 	if (device == MKDEV(TTYAUX_MAJOR,0)) {
+		lock_task_sighand(current, &flags);
 		if (!current->signal->tty) {
+			unlock_task_sighand(current, &flags);
 			mutex_unlock(&tty_mutex);
 			return -ENXIO;
 		}
@@ -2474,6 +2510,7 @@ retry_open:
 		index = current->signal->tty->index;
 		filp->f_flags |= O_NONBLOCK; /* Don't let /dev/tty block */
 		/* noctty = 1; */
+		unlock_task_sighand(current, &flags);
 		goto got_driver;
 	}
 #ifdef CONFIG_VT
@@ -2546,17 +2583,21 @@ got_driver:
 			filp->f_op = &tty_fops;
 		goto retry_open;
 	}
+
+	mutex_lock(&tty_mutex);
+	lock_task_sighand(current, &flags);
 	if (!noctty &&
 	    current->signal->leader &&
 	    !current->signal->tty &&
 	    tty->session == 0) {
-	    	task_lock(current);
 		current->signal->tty = tty;
-		task_unlock(current);
 		current->signal->tty_old_pgrp = 0;
 		tty->session = current->signal->session;
 		tty->pgrp = process_group(current);
 	}
+	/* don't we leak tty in the else case !? */
+	unlock_task_sighand(current, &flags);
+	mutex_unlock(&tty_mutex);
 	return 0;
 }
 
@@ -2888,6 +2929,7 @@ static int fionbio(struct file *file, in
 static int tiocsctty(struct tty_struct *tty, int arg)
 {
 	struct task_struct *p;
+	unsigned long flags;
 
 	if (current->signal->leader &&
 	    (current->signal->session == tty->session))
@@ -2898,6 +2940,7 @@ static int tiocsctty(struct tty_struct *
 	 */
 	if (!current->signal->leader || current->signal->tty)
 		return -EPERM;
+	mutex_lock(&tty_mutex);
 	if (tty->session > 0) {
 		/*
 		 * This tty is already the controlling
@@ -2910,20 +2953,23 @@ static int tiocsctty(struct tty_struct *
 
 			read_lock(&tasklist_lock);
 			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+				lock_task_sighand(p, &flags);
 				p->signal->tty = NULL;
+				unlock_task_sighand(p, &flags);
 			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 			read_unlock(&tasklist_lock);
-		} else
+		} else {
+			mutex_unlock(&tty_mutex);
 			return -EPERM;
+		}
 	}
-	mutex_lock(&tty_mutex);
-	task_lock(current);
-	current->signal->tty = tty;
-	task_unlock(current);
-	mutex_unlock(&tty_mutex);
-	current->signal->tty_old_pgrp = 0;
 	tty->session = current->signal->session;
 	tty->pgrp = process_group(current);
+	lock_task_sighand(current, &flags);
+	current->signal->tty = tty;
+	current->signal->tty_old_pgrp = 0;
+	unlock_task_sighand(current, &flags);
+	mutex_unlock(&tty_mutex);
 	return 0;
 }
 
@@ -2936,7 +2982,7 @@ static int tiocsctty(struct tty_struct *
  *	Obtain the process group of the tty. If there is no process group
  *	return an error.
  *
- *	Locking: none. Reference to ->signal->tty is safe.
+ *	Locking: none. Reference to current->signal->tty is safe.
  */
 
 static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
@@ -2994,7 +3040,7 @@ static int tiocspgrp(struct tty_struct *
  *	Obtain the session id of the tty. If there is no session
  *	return an error.
  *
- *	Locking: none. Reference to ->signal->tty is safe.
+ *	Locking: none. Reference to current->signal->tty is safe.
  */
 
 static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
@@ -3139,6 +3185,7 @@ int tty_ioctl(struct inode * inode, stru
 	void __user *p = (void __user *)arg;
 	int retval;
 	struct tty_ldisc *ld;
+	unsigned long flags;
 	
 	tty = (struct tty_struct *)file->private_data;
 	if (tty_paranoia_check(tty, inode, "tty_ioctl"))
@@ -3213,14 +3260,15 @@ int tty_ioctl(struct inode * inode, stru
 			clear_bit(TTY_EXCLUSIVE, &tty->flags);
 			return 0;
 		case TIOCNOTTY:
-			/* FIXME: taks lock or tty_mutex ? */
 			if (current->signal->tty != tty)
 				return -ENOTTY;
 			if (current->signal->leader)
 				disassociate_ctty(0);
-			task_lock(current);
+			mutex_lock(&tty_mutex);
+			lock_task_sighand(current, &flags)
 			current->signal->tty = NULL;
-			task_unlock(current);
+			unlock_task_sighand(current, &flags);
+			mutex_unlock(&tty_mutex);
 			return 0;
 		case TIOCSCTTY:
 			return tiocsctty(tty, arg);
Index: linux-2.6/kernel/auditsc.c
===================================================================
--- linux-2.6.orig/kernel/auditsc.c
+++ linux-2.6/kernel/auditsc.c
@@ -823,6 +823,7 @@ static void audit_log_exit(struct audit_
 				 context->return_code);
 
 	mutex_lock(&tty_mutex);
+	/* XXX doesn't this race like mad? */
 	if (tsk->signal && tsk->signal->tty && tsk->signal->tty->name)
 		tty = tsk->signal->tty->name;
 	else
Index: linux-2.6/kernel/exit.c
===================================================================
--- linux-2.6.orig/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -370,6 +370,7 @@ void daemonize(const char *name, ...)
 	va_list args;
 	struct fs_struct *fs;
 	sigset_t blocked;
+	unsigned long flags;
 
 	va_start(args, name);
 	vsnprintf(current->comm, sizeof(current->comm), name, args);
@@ -384,7 +385,9 @@ void daemonize(const char *name, ...)
 
 	set_special_pids(1, 1);
 	mutex_lock(&tty_mutex);
+	lock_task_sighand(current, &flags);
 	current->signal->tty = NULL;
+	unlock_task_sighand(current, &flags);
 	mutex_unlock(&tty_mutex);
 
 	/* Block and flush all signals */
Index: linux-2.6/kernel/sys.c
===================================================================
--- linux-2.6.orig/kernel/sys.c
+++ linux-2.6/kernel/sys.c
@@ -1483,6 +1483,7 @@ asmlinkage long sys_setsid(void)
 	struct task_struct *group_leader = current->group_leader;
 	pid_t session;
 	int err = -EPERM;
+	unsigned long flags;
 
 	mutex_lock(&tty_mutex);
 	write_lock_irq(&tasklist_lock);
@@ -1504,8 +1505,11 @@ asmlinkage long sys_setsid(void)
 
 	group_leader->signal->leader = 1;
 	__set_special_pids(session, session);
+	/* XXX move this lock up 2 lines? */
+	lock_task_sighand(group_leader, &flags);
 	group_leader->signal->tty = NULL;
 	group_leader->signal->tty_old_pgrp = 0;
+	unlock_task_sighand(group_leader, &flags);
 	err = process_group(group_leader);
 out:
 	write_unlock_irq(&tasklist_lock);


