Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423012AbWJSMNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423012AbWJSMNI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423318AbWJSMNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:13:08 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:64433 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1423012AbWJSMNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:13:04 -0400
Subject: [PATCH] tty: ->signal->tty locking
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Prarit Bhargava <prarit@redhat.com>, Chris Wright <chrisw@sous-sol.org>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 14:13:33 +0200
Message-Id: <1161260013.3036.92.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the locking of signal->tty.

Use ->sighand->siglock to protect ->signal->tty; this lock is already used
by most other members of ->signal/->sighand. And unless we are 'current' or
the tasklist_lock is held we need ->siglock to access ->signal anyway.

(NOTE: sys_unshare() is broken wrt ->sighand locking rules)

Note that tty_mutex is held over tty destruction, so while holding tty_mutex
any tty pointer remains valid. Otherwise the lifetime of ttys are governed by
their open file handles. This leaves some holes for tty access from 
signal->tty (or any other non file related tty access).

It solves the tty SLAB scribbles we were seeing.

(NOTE: the change from group_send_sig_info to __group_send_sig_info needs to
       be examined by someone familiar with the security framework, I think
       it is safe given the SEND_SIG_PRIV from other __group_send_sig_info
       invocations)

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/sparc64/solaris/misc.c |    4 
 arch/um/kernel/exec.c       |    7 -
 drivers/char/tty_io.c       |  192 ++++++++++++++++++++++----------------------
 drivers/s390/char/fs3270.c  |   10 +-
 fs/dquot.c                  |   14 +--
 fs/open.c                   |    1 
 include/linux/tty.h         |   40 +++++++++
 kernel/acct.c               |    9 --
 kernel/auditsc.c            |    2 
 kernel/exit.c               |    4 
 kernel/sys.c                |    6 -
 security/selinux/hooks.c    |   11 +-
 12 files changed, 175 insertions(+), 125 deletions(-)

Index: linux-2.6/drivers/char/tty_io.c
===================================================================
--- linux-2.6.orig/drivers/char/tty_io.c
+++ linux-2.6/drivers/char/tty_io.c
@@ -126,7 +126,7 @@ EXPORT_SYMBOL(tty_std_termios);
    
 LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
 
-/* Semaphore to protect creating and releasing a tty. This is shared with
+/* Mutex to protect creating and releasing a tty. This is shared with
    vt.c for deeply disgusting hack reasons */
 DEFINE_MUTEX(tty_mutex);
 EXPORT_SYMBOL(tty_mutex);
@@ -250,7 +250,7 @@ static int check_tty_count(struct tty_st
 				    "!= #fd's(%d) in %s\n",
 		       tty->name, tty->count, count, routine);
 		return count;
-       }	
+	}
 #endif
 	return 0;
 }
@@ -259,18 +259,6 @@ static int check_tty_count(struct tty_st
  * Tty buffer allocation management
  */
 
-
-/**
- *	tty_buffer_free_all		-	free buffers used by a tty
- *	@tty: tty to free from
- *
- *	Remove all the buffers pending on a tty whether queued with data
- *	or in the free ring. Must be called when the tty is no longer in use
- *
- *	Locking: none
- */
-
-
 /**
  *	tty_buffer_free_all		-	free buffers used by a tty
  *	@tty: tty to free from
@@ -614,7 +602,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_strin
  *	they are not on hot paths so a little discipline won't do 
  *	any harm.
  *
- *	Locking: takes termios_sem
+ *	Locking: takes termios_mutex
  */
  
 static void tty_set_termios_ldisc(struct tty_struct *tty, int num)
@@ -915,7 +903,7 @@ static void tty_ldisc_enable(struct tty_
  *	context.
  *
  *	Locking: takes tty_ldisc_lock.
- *		called functions take termios_sem
+ *		 called functions take termios_mutex
  */
  
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
@@ -1267,12 +1255,12 @@ EXPORT_SYMBOL_GPL(tty_ldisc_flush);
  *
  *	Locking:
  *		BKL
- *		redirect lock for undoing redirection
- *		file list lock for manipulating list of ttys
- *		tty_ldisc_lock from called functions
- *		termios_sem resetting termios data
- *		tasklist_lock to walk task list for hangup event
- *
+ *		  redirect lock for undoing redirection
+ *		  file list lock for manipulating list of ttys
+ *		  tty_ldisc_lock from called functions
+ *		  termios_mutex resetting termios data
+ *		  tasklist_lock to walk task list for hangup event
+ *		    ->siglock to protect ->signal/->sighand
  */
 static void do_tty_hangup(void *data)
 {
@@ -1353,14 +1341,18 @@ static void do_tty_hangup(void *data)
 	read_lock(&tasklist_lock);
 	if (tty->session > 0) {
 		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+			spin_lock_irq(&p->sighand->siglock);
 			if (p->signal->tty == tty)
 				p->signal->tty = NULL;
-			if (!p->signal->leader)
+			if (!p->signal->leader) {
+				spin_unlock_irq(&p->sighand->siglock);
 				continue;
-			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
-			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			}
+			__group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
+			__group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
 			if (tty->pgrp > 0)
 				p->signal->tty_old_pgrp = tty->pgrp;
+			spin_unlock_irq(&p->sighand->siglock);
 		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 	}
 	read_unlock(&tasklist_lock);
@@ -1452,6 +1444,14 @@ int tty_hung_up_p(struct file * filp)
 
 EXPORT_SYMBOL(tty_hung_up_p);
 
+static void session_clear_tty(pid_t session)
+{
+	struct task_struct *p;
+	do_each_task_pid(session, PIDTYPE_SID, p) {
+		proc_clear_tty(p);
+	} while_each_task_pid(session, PIDTYPE_SID, p);
+}
+
 /**
  *	disassociate_ctty	-	disconnect controlling tty
  *	@on_exit: true if exiting so need to "hang up" the session
@@ -1468,31 +1468,35 @@ EXPORT_SYMBOL(tty_hung_up_p);
  *	The argument on_exit is set to 1 if called when a process is
  *	exiting; it is 0 if called by the ioctl TIOCNOTTY.
  *
- *	Locking: tty_mutex is taken to protect current->signal->tty
+ *	Locking:
  *		BKL is taken for hysterical raisins
- *		Tasklist lock is taken (under tty_mutex) to walk process
- *		lists for the session.
+ *		  tty_mutex is taken to protect tty
+ *		  ->siglock is taken to protect ->signal/->sighand
+ *		  tasklist_lock is taken to walk process list for sessions
+ *		    ->siglock is taken to protect ->signal/->sighand
  */
 
 void disassociate_ctty(int on_exit)
 {
 	struct tty_struct *tty;
-	struct task_struct *p;
 	int tty_pgrp = -1;
+	int session;
 
 	lock_kernel();
 
 	mutex_lock(&tty_mutex);
-	tty = current->signal->tty;
+	tty = get_current_tty();
 	if (tty) {
 		tty_pgrp = tty->pgrp;
 		mutex_unlock(&tty_mutex);
+		/* XXX: here we race, there is nothing protecting tty */
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
@@ -1504,19 +1508,29 @@ void disassociate_ctty(int on_exit)
 			kill_pg(tty_pgrp, SIGCONT, on_exit);
 	}
 
-	/* Must lock changes to tty_old_pgrp */
-	mutex_lock(&tty_mutex);
+	spin_lock_irq(&current->sighand->siglock);
 	current->signal->tty_old_pgrp = 0;
-	tty->session = 0;
-	tty->pgrp = -1;
+	session = current->signal->session;
+	spin_unlock_irq(&current->sighand->siglock);
+
+	mutex_lock(&tty_mutex);
+	/* It is possible that do_tty_hangup has free'd this tty */
+	tty = get_current_tty();
+	if (tty) {
+		tty->session = 0;
+		tty->pgrp = 0;
+	} else {
+#ifdef TTY_DEBUG_HANGUP
+		printk(KERN_DEBUG "error attempted to write to tty [0x%p]"
+		       " = NULL", tty);
+#endif
+	}
+	mutex_unlock(&tty_mutex);
 
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
-	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
-		p->signal->tty = NULL;
-	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
+	session_clear_tty(session);
 	read_unlock(&tasklist_lock);
-	mutex_unlock(&tty_mutex);
 	unlock_kernel();
 }
 
@@ -2336,16 +2350,10 @@ static void release_dev(struct file * fi
 	 * tty.
 	 */
 	if (tty_closing || o_tty_closing) {
-		struct task_struct *p;
-
 		read_lock(&tasklist_lock);
-		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
-			p->signal->tty = NULL;
-		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+		session_clear_tty(tty->session);
 		if (o_tty)
-			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
-				p->signal->tty = NULL;
-			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
+			session_clear_tty(o_tty->session);
 		read_unlock(&tasklist_lock);
 	}
 
@@ -2442,9 +2450,9 @@ static void release_dev(struct file * fi
  *	The termios state of a pty is reset on first open so that
  *	settings don't persist across reuse.
  *
- *	Locking: tty_mutex protects current->signal->tty, get_tty_driver and
- *		init_dev work. tty->count should protect the rest.
- *		task_lock is held to update task details for sessions
+ *	Locking: tty_mutex protects tty, get_tty_driver and init_dev work.
+ *		 tty->count should protect the rest.
+ *		 ->siglock protects ->signal/->sighand
  */
 
 static int tty_open(struct inode * inode, struct file * filp)
@@ -2466,12 +2474,13 @@ retry_open:
 	mutex_lock(&tty_mutex);
 
 	if (device == MKDEV(TTYAUX_MAJOR,0)) {
-		if (!current->signal->tty) {
+		tty = get_current_tty();
+		if (!tty) {
 			mutex_unlock(&tty_mutex);
 			return -ENXIO;
 		}
-		driver = current->signal->tty->driver;
-		index = current->signal->tty->index;
+		driver = tty->driver;
+		index = tty->index;
 		filp->f_flags |= O_NONBLOCK; /* Don't let /dev/tty block */
 		/* noctty = 1; */
 		goto got_driver;
@@ -2546,17 +2555,16 @@ got_driver:
 			filp->f_op = &tty_fops;
 		goto retry_open;
 	}
+
+	mutex_lock(&tty_mutex);
+	spin_lock_irq(&current->sighand->siglock);
 	if (!noctty &&
 	    current->signal->leader &&
 	    !current->signal->tty &&
-	    tty->session == 0) {
-	    	task_lock(current);
-		current->signal->tty = tty;
-		task_unlock(current);
-		current->signal->tty_old_pgrp = 0;
-		tty->session = current->signal->session;
-		tty->pgrp = process_group(current);
-	}
+	    tty->session == 0)
+		__proc_set_tty(current, tty);
+	spin_unlock_irq(&current->sighand->siglock);
+	mutex_unlock(&tty_mutex);
 	return 0;
 }
 
@@ -2746,7 +2754,7 @@ static int tiocsti(struct tty_struct *tt
  *
  *	Copies the kernel idea of the window size into the user buffer.
  *
- *	Locking: tty->termios_sem is taken to ensure the winsize data
+ *	Locking: tty->termios_mutex is taken to ensure the winsize data
  *		is consistent.
  */
 
@@ -2773,8 +2781,8 @@ static int tiocgwinsz(struct tty_struct 
  *	Locking:
  *		Called function use the console_sem is used to ensure we do
  *	not try and resize the console twice at once.
- *		The tty->termios_sem is used to ensure we don't double
- *	resize and get confused. Lock order - tty->termios.sem before
+ *		The tty->termios_mutex is used to ensure we don't double
+ *	resize and get confused. Lock order - tty->termios_mutex before
  *	console sem
  */
 
@@ -2879,25 +2887,28 @@ static int fionbio(struct file *file, in
  *	leader to set this tty as the controlling tty for the session.
  *
  *	Locking:
- *		Takes tasklist lock internally to walk sessions
- *		Takes task_lock() when updating signal->tty
  *		Takes tty_mutex() to protect tty instance
- *
+ *		Takes tasklist_lock internally to walk sessions
+ *		Takes ->siglock() when updating signal->tty
  */
 
 static int tiocsctty(struct tty_struct *tty, int arg)
 {
-	struct task_struct *p;
-
+	int ret = 0;
 	if (current->signal->leader &&
 	    (current->signal->session == tty->session))
-		return 0;
+		return ret;
+
+	mutex_lock(&tty_mutex);
 	/*
 	 * The process must be a session leader and
 	 * not have a controlling tty already.
 	 */
-	if (!current->signal->leader || current->signal->tty)
-		return -EPERM;
+	if (!current->signal->leader || current->signal->tty) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	if (tty->session > 0) {
 		/*
 		 * This tty is already the controlling
@@ -2907,24 +2918,18 @@ static int tiocsctty(struct tty_struct *
 			/*
 			 * Steal it away
 			 */
-
 			read_lock(&tasklist_lock);
-			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
-				p->signal->tty = NULL;
-			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
+			session_clear_tty(tty->session);
 			read_unlock(&tasklist_lock);
-		} else
-			return -EPERM;
+		} else {
+			ret = -EPERM;
+			goto unlock;
+		}
 	}
-	mutex_lock(&tty_mutex);
-	task_lock(current);
-	current->signal->tty = tty;
-	task_unlock(current);
+	proc_set_tty(current, tty);
+unlock:
 	mutex_unlock(&tty_mutex);
-	current->signal->tty_old_pgrp = 0;
-	tty->session = current->signal->session;
-	tty->pgrp = process_group(current);
-	return 0;
+	return ret;
 }
 
 /**
@@ -2936,7 +2941,7 @@ static int tiocsctty(struct tty_struct *
  *	Obtain the process group of the tty. If there is no process group
  *	return an error.
  *
- *	Locking: none. Reference to ->signal->tty is safe.
+ *	Locking: none. Reference to current->signal->tty is safe.
  */
 
 static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
@@ -2994,7 +2999,7 @@ static int tiocspgrp(struct tty_struct *
  *	Obtain the session id of the tty. If there is no session
  *	return an error.
  *
- *	Locking: none. Reference to ->signal->tty is safe.
+ *	Locking: none. Reference to current->signal->tty is safe.
  */
 
 static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
@@ -3213,14 +3218,11 @@ int tty_ioctl(struct inode * inode, stru
 			clear_bit(TTY_EXCLUSIVE, &tty->flags);
 			return 0;
 		case TIOCNOTTY:
-			/* FIXME: taks lock or tty_mutex ? */
 			if (current->signal->tty != tty)
 				return -ENOTTY;
 			if (current->signal->leader)
 				disassociate_ctty(0);
-			task_lock(current);
-			current->signal->tty = NULL;
-			task_unlock(current);
+			proc_clear_tty(current);
 			return 0;
 		case TIOCSCTTY:
 			return tiocsctty(tty, arg);
@@ -3319,7 +3321,7 @@ static void __do_SAK(void *arg)
 	
 	if (!tty)
 		return;
-	session  = tty->session;
+	session = tty->session;
 	
 	/* We don't want an ldisc switch during this */
 	disc = tty_ldisc_ref(tty);
Index: linux-2.6/kernel/auditsc.c
===================================================================
--- linux-2.6.orig/kernel/auditsc.c
+++ linux-2.6/kernel/auditsc.c
@@ -823,10 +823,12 @@ static void audit_log_exit(struct audit_
 				 context->return_code);
 
 	mutex_lock(&tty_mutex);
+	read_lock(&tasklist_lock);
 	if (tsk->signal && tsk->signal->tty && tsk->signal->tty->name)
 		tty = tsk->signal->tty->name;
 	else
 		tty = "(none)";
+	read_unlock(&tasklist_lock);
 	audit_log_format(ab,
 		  " a0=%lx a1=%lx a2=%lx a3=%lx items=%d"
 		  " ppid=%d pid=%d auid=%u uid=%u gid=%u"
Index: linux-2.6/kernel/exit.c
===================================================================
--- linux-2.6.orig/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -383,9 +383,7 @@ void daemonize(const char *name, ...)
 	exit_mm(current);
 
 	set_special_pids(1, 1);
-	mutex_lock(&tty_mutex);
-	current->signal->tty = NULL;
-	mutex_unlock(&tty_mutex);
+	proc_clear_tty(current);
 
 	/* Block and flush all signals */
 	sigfillset(&blocked);
Index: linux-2.6/kernel/sys.c
===================================================================
--- linux-2.6.orig/kernel/sys.c
+++ linux-2.6/kernel/sys.c
@@ -1484,7 +1484,6 @@ asmlinkage long sys_setsid(void)
 	pid_t session;
 	int err = -EPERM;
 
-	mutex_lock(&tty_mutex);
 	write_lock_irq(&tasklist_lock);
 
 	/* Fail if I am already a session leader */
@@ -1504,12 +1503,15 @@ asmlinkage long sys_setsid(void)
 
 	group_leader->signal->leader = 1;
 	__set_special_pids(session, session);
+
+	spin_lock(&group_leader->sighand->siglock);
 	group_leader->signal->tty = NULL;
 	group_leader->signal->tty_old_pgrp = 0;
+	spin_unlock(&group_leader->sighand->siglock);
+
 	err = process_group(group_leader);
 out:
 	write_unlock_irq(&tasklist_lock);
-	mutex_unlock(&tty_mutex);
 	return err;
 }
 
Index: linux-2.6/arch/sparc64/solaris/misc.c
===================================================================
--- linux-2.6.orig/arch/sparc64/solaris/misc.c
+++ linux-2.6/arch/sparc64/solaris/misc.c
@@ -423,9 +423,7 @@ asmlinkage int solaris_procids(int cmd, 
 			   Solaris setpgrp and setsid? */
 			ret = sys_setpgid(0, 0);
 			if (ret) return ret;
-			mutex_lock(&tty_mutex);
-			current->signal->tty = NULL;
-			mutex_unlock(&tty_mutex);
+			proc_clear_tty(current);
 			return process_group(current);
 		}
 	case 2: /* getsid */
Index: linux-2.6/arch/um/kernel/exec.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/exec.c
+++ linux-2.6/arch/um/kernel/exec.c
@@ -39,12 +39,13 @@ static long execve1(char *file, char __u
 		    char __user *__user *env)
 {
         long error;
+	struct tty_struct *tty;
 
 #ifdef CONFIG_TTY_LOG
 	mutex_lock(&tty_mutex);
-	task_lock(current);	/* FIXME:  is this needed ? */
-	log_exec(argv, current->signal->tty);
-	task_unlock(current);
+	tty = get_current_tty();
+	if (tty)
+		log_exec(argv, tty);
 	mutex_unlock(&tty_mutex);
 #endif
         error = do_execve(file, argv, env, &current->thread.regs);
Index: linux-2.6/drivers/s390/char/fs3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/fs3270.c
+++ linux-2.6/drivers/s390/char/fs3270.c
@@ -424,11 +424,15 @@ fs3270_open(struct inode *inode, struct 
 	minor = iminor(filp->f_dentry->d_inode);
 	/* Check for minor 0 multiplexer. */
 	if (minor == 0) {
-		if (!current->signal->tty)
+		struct tty_struct *tty;
+		mutex_lock(&tty_mutex);
+		tty = get_current_tty();
+		if (!tty)
 			return -ENODEV;
-		if (current->signal->tty->driver->major != IBM_TTY3270_MAJOR)
+		if (tty->driver->major != IBM_TTY3270_MAJOR)
 			return -ENODEV;
-		minor = current->signal->tty->index + RAW3270_FIRSTMINOR;
+		minor = tty->index + RAW3270_FIRSTMINOR;
+		mutex_unlock(&tty_mutex);
 	}
 	/* Check if some other program is already using fullscreen mode. */
 	fp = (struct fs3270 *) raw3270_find_view(&fs3270_fn, minor);
Index: linux-2.6/fs/dquot.c
===================================================================
--- linux-2.6.orig/fs/dquot.c
+++ linux-2.6/fs/dquot.c
@@ -828,6 +828,7 @@ static inline int need_print_warning(str
 static void print_warning(struct dquot *dquot, const char warntype)
 {
 	char *msg = NULL;
+	struct tty_struct *tty;
 	int flag = (warntype == BHARDWARN || warntype == BSOFTLONGWARN) ? DQ_BLKS_B :
 	  ((warntype == IHARDWARN || warntype == ISOFTLONGWARN) ? DQ_INODES_B : 0);
 
@@ -835,14 +836,15 @@ static void print_warning(struct dquot *
 		return;
 
 	mutex_lock(&tty_mutex);
-	if (!current->signal->tty)
+	tty = get_current_tty();
+	if (!tty)
 		goto out_lock;
-	tty_write_message(current->signal->tty, dquot->dq_sb->s_id);
+	tty_write_message(tty, dquot->dq_sb->s_id);
 	if (warntype == ISOFTWARN || warntype == BSOFTWARN)
-		tty_write_message(current->signal->tty, ": warning, ");
+		tty_write_message(tty, ": warning, ");
 	else
-		tty_write_message(current->signal->tty, ": write failed, ");
-	tty_write_message(current->signal->tty, quotatypes[dquot->dq_type]);
+		tty_write_message(tty, ": write failed, ");
+	tty_write_message(tty, quotatypes[dquot->dq_type]);
 	switch (warntype) {
 		case IHARDWARN:
 			msg = " file limit reached.\r\n";
@@ -863,7 +865,7 @@ static void print_warning(struct dquot *
 			msg = " block quota exceeded.\r\n";
 			break;
 	}
-	tty_write_message(current->signal->tty, msg);
+	tty_write_message(tty, msg);
 out_lock:
 	mutex_unlock(&tty_mutex);
 }
Index: linux-2.6/fs/open.c
===================================================================
--- linux-2.6.orig/fs/open.c
+++ linux-2.6/fs/open.c
@@ -1087,6 +1087,7 @@ EXPORT_SYMBOL(sys_close);
 asmlinkage long sys_vhangup(void)
 {
 	if (capable(CAP_SYS_TTY_CONFIG)) {
+		/* XXX: this needs locking */
 		tty_vhangup(current->signal->tty);
 		return 0;
 	}
Index: linux-2.6/include/linux/tty.h
===================================================================
--- linux-2.6.orig/include/linux/tty.h
+++ linux-2.6/include/linux/tty.h
@@ -341,5 +341,45 @@ static inline dev_t tty_devnum(struct tt
 	return MKDEV(tty->driver->major, tty->driver->minor_start) + tty->index;
 }
 
+static inline void proc_clear_tty(struct task_struct *p)
+{
+	spin_lock_irq(&p->sighand->siglock);
+	p->signal->tty = NULL;
+	spin_unlock_irq(&p->sighand->siglock);
+}
+
+static inline
+void __proc_set_tty(struct task_struct *tsk, struct tty_struct *tty)
+{
+	if (tty) {
+		tty->session = tsk->signal->session;
+		tty->pgrp = process_group(tsk);
+	}
+	tsk->signal->tty = tty;
+	tsk->signal->tty_old_pgrp = 0;
+}
+
+static inline
+void proc_set_tty(struct task_struct *tsk, struct tty_struct *tty)
+{
+	spin_lock_irq(&tsk->sighand->siglock);
+	__proc_set_tty(tsk, tty);
+	spin_unlock_irq(&tsk->sighand->siglock);
+}
+
+static inline struct tty_struct *get_current_tty(void)
+{
+	struct tty_struct *tty;
+	WARN_ON_ONCE(!mutex_is_locked(&tty_mutex));
+	tty = current->signal->tty;
+	/*
+	 * session->tty can be changed/cleared from under us, make sure we
+	 * issue the load. The obtained pointer, when not NULL, is valid as
+	 * long as we hold tty_mutex.
+	 */
+	barrier();
+	return tty;
+}
+
 #endif /* __KERNEL__ */
 #endif
Index: linux-2.6/kernel/acct.c
===================================================================
--- linux-2.6.orig/kernel/acct.c
+++ linux-2.6/kernel/acct.c
@@ -427,6 +427,7 @@ static void do_acct_process(struct file 
 	u64 elapsed;
 	u64 run_time;
 	struct timespec uptime;
+	struct tty_struct *tty;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -484,12 +485,8 @@ static void do_acct_process(struct file 
 #endif
 
 	mutex_lock(&tty_mutex);
-	/* FIXME: Whoever is responsible for current->signal locking needs
-	   to use the same locking all over the kernel and document it */
-	read_lock(&tasklist_lock);
-	ac.ac_tty = current->signal->tty ?
-		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
-	read_unlock(&tasklist_lock);
+	tty = get_current_tty();
+	ac.ac_tty = tty ? old_encode_dev(tty_devnum(tty)) : 0;
 	mutex_unlock(&tty_mutex);
 
 	spin_lock_irq(&current->sighand->siglock);
Index: linux-2.6/security/selinux/hooks.c
===================================================================
--- linux-2.6.orig/security/selinux/hooks.c
+++ linux-2.6/security/selinux/hooks.c
@@ -1692,9 +1692,10 @@ static inline void flush_unauthorized_fi
 	struct tty_struct *tty;
 	struct fdtable *fdt;
 	long j = -1;
+	int drop_tty = 0;
 
 	mutex_lock(&tty_mutex);
-	tty = current->signal->tty;
+	tty = get_current_tty();
 	if (tty) {
 		file_list_lock();
 		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
@@ -1707,12 +1708,14 @@ static inline void flush_unauthorized_fi
 			struct inode *inode = file->f_dentry->d_inode;
 			if (inode_has_perm(current, inode,
 					   FILE__READ | FILE__WRITE, NULL)) {
-				/* Reset controlling tty. */
-				current->signal->tty = NULL;
-				current->signal->tty_old_pgrp = 0;
+				drop_tty = 1;
 			}
 		}
 		file_list_unlock();
+
+		/* Reset controlling tty. */
+		if (drop_tty)
+			proc_set_tty(current, NULL);
 	}
 	mutex_unlock(&tty_mutex);
 


