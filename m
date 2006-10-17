Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWJQM7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWJQM7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWJQM7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:59:52 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:61755 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750863AbWJQM7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:59:48 -0400
Subject: Re: [RFC][PATCH] ->signal->tty locking
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Prarit Bhargava <prarit@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20061017123307.GA209@oleg>
References: <1160992420.22727.14.camel@taijtu> <20061017081018.GA115@oleg>
	 <1161080221.3036.38.camel@taijtu>  <20061017123307.GA209@oleg>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 15:00:04 +0200
Message-Id: <1161090004.3036.43.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 16:33 +0400, Oleg Nesterov wrote:
> On 10/17, Peter Zijlstra wrote:

> > Hmm, either sys_unshare() is broken in that it doesn't take the
> > tasklist_lock or a lot of other code is broken.
> 
> Yes, it is broken, please look at

Ah good :-)

How about something like this; I'm still shaky on the lifetime rules of
tty objects, I'm about to add a refcount and spinlock/mutex to
tty_struct, this is madness....

---
 arch/sparc64/solaris/misc.c |    4 -
 arch/um/kernel/exec.c       |    7 +-
 drivers/char/tty_io.c       |  126 ++++++++++++++++++++++++--------------------
 drivers/s390/char/fs3270.c  |   10 ++-
 fs/dquot.c                  |   14 ++--
 fs/open.c                   |    1 
 include/linux/tty.h         |   28 +++++++++
 kernel/acct.c               |    9 +--
 kernel/auditsc.c            |    2 
 kernel/exit.c               |    4 -
 kernel/sys.c                |    6 +-
 security/selinux/hooks.c    |   15 +++--
 12 files changed, 141 insertions(+), 85 deletions(-)

Index: linux-2.6.18.noarch/drivers/char/tty_io.c
===================================================================
--- linux-2.6.18.noarch.orig/drivers/char/tty_io.c
+++ linux-2.6.18.noarch/drivers/char/tty_io.c
@@ -126,7 +126,7 @@ EXPORT_SYMBOL(tty_std_termios);
    
 LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
 
-/* Semaphore to protect creating and releasing a tty. This is shared with
+/* Mutex to protect creating and releasing a tty. This is shared with
    vt.c for deeply disgusting hack reasons */
 DEFINE_MUTEX(tty_mutex);
 EXPORT_SYMBOL(tty_mutex);
@@ -616,7 +616,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_strin
  *	they are not on hot paths so a little discipline won't do 
  *	any harm.
  *
- *	Locking: takes termios_sem
+ *	Locking: takes termios_mutex
  */
  
 static void tty_set_termios_ldisc(struct tty_struct *tty, int num)
@@ -917,7 +917,7 @@ static void tty_ldisc_enable(struct tty_
  *	context.
  *
  *	Locking: takes tty_ldisc_lock.
- *		called functions take termios_sem
+ *		 called functions take termios_mutex
  */
  
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
@@ -1269,12 +1269,12 @@ EXPORT_SYMBOL_GPL(tty_ldisc_flush);
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
@@ -1355,14 +1355,18 @@ static void do_tty_hangup(void *data)
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
@@ -1470,10 +1474,12 @@ EXPORT_SYMBOL(tty_hung_up_p);
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
@@ -1481,20 +1487,23 @@ void disassociate_ctty(int on_exit)
 	struct tty_struct *tty;
 	struct task_struct *p;
 	int tty_pgrp = -1;
+	int session;
 
 	lock_kernel();
 
 	mutex_lock(&tty_mutex);
-	tty = current->signal->tty;
+	tty = current_get_tty();
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
@@ -1506,19 +1515,29 @@ void disassociate_ctty(int on_exit)
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
+	tty = current_get_tty();
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
 
@@ -2340,13 +2359,9 @@ static void release_dev(struct file * fi
 		struct task_struct *p;
 
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
 
@@ -2467,12 +2482,13 @@ retry_open:
 	mutex_lock(&tty_mutex);
 
 	if (device == MKDEV(TTYAUX_MAJOR,0)) {
-		if (!current->signal->tty) {
+		tty = current_get_tty();
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
@@ -2547,17 +2563,21 @@ got_driver:
 			filp->f_op = &tty_fops;
 		goto retry_open;
 	}
+
+	mutex_lock(&tty_mutex);
+	spin_lock_irq(&current->sighand->siglock);
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
+	spin_unlock_irq(&current->sighand->siglock);
+	mutex_unlock(&tty_mutex);
 	return 0;
 }
 
@@ -2899,6 +2919,7 @@ static int tiocsctty(struct tty_struct *
 	 */
 	if (!current->signal->leader || current->signal->tty)
 		return -EPERM;
+	mutex_lock(&tty_mutex);
 	if (tty->session > 0) {
 		/*
 		 * This tty is already the controlling
@@ -2908,23 +2929,21 @@ static int tiocsctty(struct tty_struct *
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
+	spin_lock_irq(&current->sighand->siglock);
 	tty->session = current->signal->session;
 	tty->pgrp = process_group(current);
+	current->signal->tty = tty;
+	current->signal->tty_old_pgrp = 0;
+	spin_unlock_irq(&current->sighand->siglock);
+	mutex_unlock(&tty_mutex);
 	return 0;
 }
 
@@ -2937,7 +2956,7 @@ static int tiocsctty(struct tty_struct *
  *	Obtain the process group of the tty. If there is no process group
  *	return an error.
  *
- *	Locking: none. Reference to ->signal->tty is safe.
+ *	Locking: none. Reference to current->signal->tty is safe.
  */
 
 static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
@@ -2995,7 +3014,7 @@ static int tiocspgrp(struct tty_struct *
  *	Obtain the session id of the tty. If there is no session
  *	return an error.
  *
- *	Locking: none. Reference to ->signal->tty is safe.
+ *	Locking: none. Reference to current->signal->tty is safe.
  */
 
 static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
@@ -3214,14 +3233,11 @@ int tty_ioctl(struct inode * inode, stru
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
+			proc_set_tty(current, NULL);
 			return 0;
 		case TIOCSCTTY:
 			return tiocsctty(tty, arg);
Index: linux-2.6.18.noarch/kernel/auditsc.c
===================================================================
--- linux-2.6.18.noarch.orig/kernel/auditsc.c
+++ linux-2.6.18.noarch/kernel/auditsc.c
@@ -819,10 +819,12 @@ static void audit_log_exit(struct audit_
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
Index: linux-2.6.18.noarch/kernel/exit.c
===================================================================
--- linux-2.6.18.noarch.orig/kernel/exit.c
+++ linux-2.6.18.noarch/kernel/exit.c
@@ -382,9 +382,7 @@ void daemonize(const char *name, ...)
 	exit_mm(current);
 
 	set_special_pids(1, 1);
-	mutex_lock(&tty_mutex);
-	current->signal->tty = NULL;
-	mutex_unlock(&tty_mutex);
+	proc_set_tty(current, NULL);
 
 	/* Block and flush all signals */
 	sigfillset(&blocked);
Index: linux-2.6.18.noarch/kernel/sys.c
===================================================================
--- linux-2.6.18.noarch.orig/kernel/sys.c
+++ linux-2.6.18.noarch/kernel/sys.c
@@ -1379,7 +1379,6 @@ asmlinkage long sys_setsid(void)
 	pid_t session;
 	int err = -EPERM;
 
-	mutex_lock(&tty_mutex);
 	write_lock_irq(&tasklist_lock);
 
 	/* Fail if I am already a session leader */
@@ -1399,12 +1398,15 @@ asmlinkage long sys_setsid(void)
 
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
 
Index: linux-2.6.18.noarch/arch/sparc64/solaris/misc.c
===================================================================
--- linux-2.6.18.noarch.orig/arch/sparc64/solaris/misc.c
+++ linux-2.6.18.noarch/arch/sparc64/solaris/misc.c
@@ -423,9 +423,7 @@ asmlinkage int solaris_procids(int cmd, 
 			   Solaris setpgrp and setsid? */
 			ret = sys_setpgid(0, 0);
 			if (ret) return ret;
-			mutex_lock(&tty_mutex);
-			current->signal->tty = NULL;
-			mutex_unlock(&tty_mutex);
+			proc_set_tty(current, NULL);
 			return process_group(current);
 		}
 	case 2: /* getsid */
Index: linux-2.6.18.noarch/arch/um/kernel/exec.c
===================================================================
--- linux-2.6.18.noarch.orig/arch/um/kernel/exec.c
+++ linux-2.6.18.noarch/arch/um/kernel/exec.c
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
+	tty = current_get_tty();
+	if (tty)
+		log_exec(argv, tty);
 	mutex_unlock(&tty_mutex);
 #endif
         error = do_execve(file, argv, env, &current->thread.regs);
Index: linux-2.6.18.noarch/drivers/s390/char/fs3270.c
===================================================================
--- linux-2.6.18.noarch.orig/drivers/s390/char/fs3270.c
+++ linux-2.6.18.noarch/drivers/s390/char/fs3270.c
@@ -425,11 +425,15 @@ fs3270_open(struct inode *inode, struct 
 	minor = iminor(filp->f_dentry->d_inode);
 	/* Check for minor 0 multiplexer. */
 	if (minor == 0) {
-		if (!current->signal->tty)
+		struct tty_struct *tty;
+		mutex_lock(&tty_mutex);
+		tty = current_get_tty();
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
Index: linux-2.6.18.noarch/fs/dquot.c
===================================================================
--- linux-2.6.18.noarch.orig/fs/dquot.c
+++ linux-2.6.18.noarch/fs/dquot.c
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
+	tty = current_get_tty();
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
Index: linux-2.6.18.noarch/fs/open.c
===================================================================
--- linux-2.6.18.noarch.orig/fs/open.c
+++ linux-2.6.18.noarch/fs/open.c
@@ -1204,6 +1204,7 @@ EXPORT_SYMBOL(sys_close);
 asmlinkage long sys_vhangup(void)
 {
 	if (capable(CAP_SYS_TTY_CONFIG)) {
+		/* XXX: this needs locking */
 		tty_vhangup(current->signal->tty);
 		return 0;
 	}
Index: linux-2.6.18.noarch/include/linux/tty.h
===================================================================
--- linux-2.6.18.noarch.orig/include/linux/tty.h
+++ linux-2.6.18.noarch/include/linux/tty.h
@@ -338,5 +338,33 @@ static inline dev_t tty_devnum(struct tt
 	return MKDEV(tty->driver->major, tty->driver->minor_start) + tty->index;
 }
 
+static inline void proc_set_tty(struct task_struct *p, struct tty_struct *tty)
+{
+	spin_lock_irq(&p->sighand->siglock);
+	p->signal->tty = tty;
+	spin_unlock_irq(&p->sighand->siglock);
+}
+
+static inline void session_clear_tty(pid_t session)
+{
+	struct task_struct *p;
+	do_each_task_pid(session, PIDTYPE_SID, p) {
+		proc_set_tty(p, NULL);
+	} while_each_task_pid(session, PIDTYPE_SID, p);
+}
+
+static inline void current_get_tty(void)
+{
+	struct tty_struct *tty;
+	WARN_ON_ONCE(!mutex_locked(&tty_mutex));
+	tty = current->session->tty;
+	barrier();
+	/*
+	 * ->tty could be changed/cleared from under us, but it can't be
+	 * released while we are holding tty_mutex
+	 */
+	return tty;
+}
+
 #endif /* __KERNEL__ */
 #endif
Index: linux-2.6.18.noarch/kernel/acct.c
===================================================================
--- linux-2.6.18.noarch.orig/kernel/acct.c
+++ linux-2.6.18.noarch/kernel/acct.c
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
+	tty = current_get_tty();
+	ac.ac_tty = tty ? old_encode_dev(tty_devnum(tty)) : 0;
 	mutex_unlock(&tty_mutex);
 
 	spin_lock_irq(&current->sighand->siglock);
Index: linux-2.6.18.noarch/security/selinux/hooks.c
===================================================================
--- linux-2.6.18.noarch.orig/security/selinux/hooks.c
+++ linux-2.6.18.noarch/security/selinux/hooks.c
@@ -1708,9 +1708,10 @@ static inline void flush_unauthorized_fi
 	struct tty_struct *tty;
 	struct fdtable *fdt;
 	long j = -1;
+	int drop_tty = 0;
 
 	mutex_lock(&tty_mutex);
-	tty = current->signal->tty;
+	tty = current_get_tty();
 	if (tty) {
 		file_list_lock();
 		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
@@ -1723,12 +1724,18 @@ static inline void flush_unauthorized_fi
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
+		if (drop_tty) {
+			/* Reset controlling tty. */
+			spin_lock_irq(&current->sighand->siglock);
+			current->signal->tty = NULL;
+			current->signal->tty_old_pgrp = 0;
+			spin_unlock_irq(&current->sighand->siglock);
+		}
 	}
 	mutex_unlock(&tty_mutex);
 


