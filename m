Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWF2Fld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWF2Fld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 01:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWF2Fld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 01:41:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:29467 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751583AbWF2Flc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 01:41:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BNE4MFKlLksXqt5gEAiYTsS+jgnq1rKo3N20tuGzOe3J+b/il7Gmp0cXV8vkntleX8V8qz5XMcl+aPDkzTxaRCMBCfHOM1sQwkB+/OZ+EZ3FBKMiGxyCa6K34tx0XmMzJXjeV9twP0FNQ43f1T4gVPEtIcUTvKAnWnPxdneODto=
Message-ID: <9e4733910606282241u35946d76n443c863c46cef97c@mail.gmail.com>
Date: Thu, 29 Jun 2006 01:41:30 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_mutex and tty_old_pgrp
Cc: "Paul Fulghum" <paulkf@microgate.com>, lkml <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <9e4733910606281113m2c5fc3bfgcdf5b458f3fbc861@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
	 <44A1B79F.9020204@microgate.com>
	 <9e4733910606272029r32255d27we6e8b34a4c2e569@mail.gmail.com>
	 <1151490240.15166.5.camel@localhost.localdomain>
	 <9e4733910606281036k53956aaev3d323fbb7a2cb7a9@mail.gmail.com>
	 <1151517865.15166.54.camel@localhost.localdomain>
	 <9e4733910606281113m2c5fc3bfgcdf5b458f3fbc861@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's what I have done so far.  These new functions need better names
and probably some reorganization. They move the job control code out
of tty_io.c over to exit.c (or is there a better place?) to make it
easier to see what is going on.  I haven't tried removing tty_mutex
yet.

void set_controlling_tty(struct tty_struct *tty);
void reset_controlling_tty(struct task_struct *task);
void reset_session_tty(pid_t session);
extern void clear_controlling_tty(int on_exit);
extern void clear_session_tty(pid_t session, struct tty_struct *tty,
pid_t pgrp);

-- 
Jon Smirl
jonsmirl@gmail.com


diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 8b2a599..c677402 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -161,14 +161,16 @@ static struct tty_struct *alloc_tty_stru
  	struct tty_struct *tty;

  	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
-	if (tty)
+	if (tty) {
  		memset(tty, 0, sizeof(struct tty_struct));
+		atomic_set(&tty->ref_count, 1);
+	}
  	return tty;
 }

  static void tty_buffer_free_all(struct tty_struct *);

-static inline void free_tty_struct(struct tty_struct *tty)
+void free_tty_struct(struct tty_struct *tty)
 {
  	kfree(tty->write_buf);
  	tty_buffer_free_all(tty);
@@ -1026,7 +1028,6 @@ static void do_tty_hangup(void *data)
  	struct tty_struct *tty = (struct tty_struct *) data;
  	struct file * cons_filp = NULL;
  	struct file *filp, *f = NULL;
-	struct task_struct *p;
  	struct tty_ldisc *ld;
  	int    closecount = 0, n;

@@ -1096,22 +1097,9 @@ static void do_tty_hangup(void *data)
 	
 	  This should get done automatically when the port closes and
 	  tty_release is called */
+	
+	clear_session_tty(tty->session, tty, tty->pgrp);
 	
-	read_lock(&tasklist_lock);
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
-	read_unlock(&tasklist_lock);
-
  	tty->flags = 0;
  	tty->session = 0;
  	tty->pgrp = -1;
@@ -1174,65 +1162,6 @@ int tty_hung_up_p(struct file * filp)

 EXPORT_SYMBOL(tty_hung_up_p);

-/*
- * This function is typically called only by the session leader, when
- * it wants to disassociate itself from its controlling tty.
- *
- * It performs the following functions:
- * 	(1)  Sends a SIGHUP and SIGCONT to the foreground process group
- * 	(2)  Clears the tty from being controlling the session
- * 	(3)  Clears the controlling tty for all processes in the
- * 		session group.
- *
- * The argument on_exit is set to 1 if called when a process is
- * exiting; it is 0 if called by the ioctl TIOCNOTTY.
- */
-void disassociate_ctty(int on_exit)
-{
-	struct tty_struct *tty;
-	struct task_struct *p;
-	int tty_pgrp = -1;
-
-	lock_kernel();
-
-	mutex_lock(&tty_mutex);
-	tty = current->signal->tty;
-	if (tty) {
-		tty_pgrp = tty->pgrp;
-		mutex_unlock(&tty_mutex);
-		if (on_exit && tty->driver->type != TTY_DRIVER_TYPE_PTY)
-			tty_vhangup(tty);
-	} else {
-		if (current->signal->tty_old_pgrp) {
-			kill_pg(current->signal->tty_old_pgrp, SIGHUP, on_exit);
-			kill_pg(current->signal->tty_old_pgrp, SIGCONT, on_exit);
-		}
-		mutex_unlock(&tty_mutex);
-		unlock_kernel();	
-		return;
-	}
-	if (tty_pgrp > 0) {
-		kill_pg(tty_pgrp, SIGHUP, on_exit);
-		if (!on_exit)
-			kill_pg(tty_pgrp, SIGCONT, on_exit);
-	}
-
-	/* Must lock changes to tty_old_pgrp */
-	mutex_lock(&tty_mutex);
-	current->signal->tty_old_pgrp = 0;
-	tty->session = 0;
-	tty->pgrp = -1;
-
-	/* Now clear signal->tty under the lock */
-	read_lock(&tasklist_lock);
-	do_each_task_pid(current->signal->session, PIDTYPE_SID, p) {
-		p->signal->tty = NULL;
-	} while_each_task_pid(current->signal->session, PIDTYPE_SID, p);
-	read_unlock(&tasklist_lock);
-	mutex_unlock(&tty_mutex);
-	unlock_kernel();
-}
-
  void stop_tty(struct tty_struct *tty)
 {
  	if (tty->stopped)
@@ -1931,10 +1860,12 @@ #endif

 		read_lock(&tasklist_lock);
  		do_each_task_pid(tty->session, PIDTYPE_SID, p) {
+			tty_put(p->signal->tty);
  			p->signal->tty = NULL;
  		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
 		if (o_tty)
 			do_each_task_pid(o_tty->session, PIDTYPE_SID, p) {
+				tty_put(p->signal->tty);
  				p->signal->tty = NULL;
 			} while_each_task_pid(o_tty->session, PIDTYPE_SID, p);
 		read_unlock(&tasklist_lock);
@@ -2133,10 +2064,7 @@ #endif
 	    current->signal->leader &&
  	    !current->signal->tty &&
  	    tty->session == 0) {
-	    	task_lock(current);
-		current->signal->tty = tty;
-		task_unlock(current);
-		current->signal->tty_old_pgrp = 0;
+	    	set_controlling_tty(tty);
  		tty->session = current->signal->session;
  		tty->pgrp = process_group(current);
 	}
@@ -2348,8 +2276,6 @@ static int fionbio(struct file *file, in

  static int tiocsctty(struct tty_struct *tty, int arg)
 {
-	task_t *p;
-
 	if (current->signal->leader &&
  	    (current->signal->session == tty->session))
 		return 0;
@@ -2368,19 +2294,11 @@ static int tiocsctty(struct tty_struct *
 			/*
 			 * Steal it away
 			 */
-
-			read_lock(&tasklist_lock);
-			do_each_task_pid(tty->session, PIDTYPE_SID, p) {
-				p->signal->tty = NULL;
-			} while_each_task_pid(tty->session, PIDTYPE_SID, p);
-			read_unlock(&tasklist_lock);
+			reset_session_tty(tty->session);
 		} else
  			return -EPERM;
 	}
-	task_lock(current);
-	current->signal->tty = tty;
-	task_unlock(current);
-	current->signal->tty_old_pgrp = 0;
+	set_controlling_tty(tty);
  	tty->session = current->signal->session;
  	tty->pgrp = process_group(current);
 	return 0;
@@ -2588,8 +2506,9 @@ int tty_ioctl(struct inode * inode, stru
  			if (current->signal->tty != tty)
  				return -ENOTTY;
 			if (current->signal->leader)
-				disassociate_ctty(0);
+				clear_controlling_tty(0);
 			task_lock(current);
+			tty_put(current->signal->tty);
  			current->signal->tty = NULL;
 			task_unlock(current);
 			return 0;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d11d93..181f036 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1181,6 +1181,12 @@ extern void exit_itimers(struct signal_s

  extern NORET_TYPE void do_group_exit(int);

+void set_controlling_tty(struct tty_struct *tty);
+void reset_controlling_tty(struct task_struct *task);
+void reset_session_tty(pid_t session);
+extern void clear_controlling_tty(int on_exit);
+extern void clear_session_tty(pid_t session, struct tty_struct *tty,
pid_t pgrp);
+
  extern void daemonize(const char *, ...);
  extern int allow_signal(int);
  extern int disallow_signal(int);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index cb35ca5..3937a4e 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -182,6 +182,7 @@ struct device;
  */
  struct tty_struct {
 	int	magic;
+	atomic_t ref_count;
  	struct tty_driver *driver;
 	int index;
  	struct tty_ldisc ldisc;
@@ -269,6 +270,22 @@ #define TTY_HUPPED 		18	/* Post driver->

  #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))

+static inline struct tty_struct * tty_get(struct tty_struct * tty)
+{
+        if (tty) {
+                WARN_ON(!atomic_read(&tty->ref_count));
+                atomic_inc(&tty->ref_count);
+        }
+        return tty;
+}
+
+extern void free_tty_struct(struct tty_struct *tty);
+static inline void tty_put(struct tty_struct * tty)
+{
+        if (tty && atomic_dec_and_test(&tty->ref_count))
+                free_tty_struct(tty);
+}
+
  extern void tty_write_flush(struct tty_struct *);

  extern struct termios tty_std_termios;
@@ -306,7 +323,6 @@ extern void tty_vhangup(struct tty_struc
  extern void tty_unhangup(struct file *filp);
  extern int tty_hung_up_p(struct file * filp);
  extern void do_SAK(struct tty_struct *tty);
-extern void disassociate_ctty(int priv);
  extern void tty_flip_buffer_push(struct tty_struct *tty);
  extern int tty_get_baud_rate(struct tty_struct *tty);
  extern int tty_termios_baud_rate(struct termios *termios);
diff --git a/kernel/exit.c b/kernel/exit.c
index e76bd02..ea09822 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -379,6 +379,122 @@ EXPORT_SYMBOL(disallow_signal);
  *	attached user resources in one place where it belongs.
  */

+void set_controlling_tty(struct tty_struct *tty)
+{
+	task_lock(current);
+	current->signal->tty = tty_get(tty);
+	task_unlock(current);
+	current->signal->tty_old_pgrp = 0;
+}
+
+EXPORT_SYMBOL(set_controlling_tty);
+
+void reset_session_tty(pid_t session)
+{
+	struct task_struct *p;
+	
+	read_lock(&tasklist_lock);
+	do_each_task_pid(session, PIDTYPE_SID, p) {
+		tty_put(p->signal->tty);
+		p->signal->tty = NULL;
+	} while_each_task_pid(session, PIDTYPE_SID, p);
+	read_unlock(&tasklist_lock);
+}
+
+EXPORT_SYMBOL(reset_session_tty);
+
+void reset_controlling_tty(struct task_struct *task)
+{
+	/* Reset controlling tty. */
+	mutex_lock(&tty_mutex);
+	tty_put(task->signal->tty);
+	task->signal->tty = NULL;
+	task->signal->tty_old_pgrp = 0;
+	mutex_unlock(&tty_mutex);
+}
+
+EXPORT_SYMBOL(reset_controlling_tty);
+
+/*
+ * This function is typically called only by the session leader, when
+ * it wants to disassociate itself from its controlling tty.
+ *
+ * It performs the following functions:
+ * 	(1)  Sends a SIGHUP and SIGCONT to the foreground process group
+ * 	(2)  Clears the tty from being controlling the session
+ * 	(3)  Clears the controlling tty for all processes in the
+ * 		session group.
+ *
+ * The argument on_exit is set to 1 if called when a process is
+ * exiting; it is 0 if called by the ioctl TIOCNOTTY.
+ */
+void clear_controlling_tty(int on_exit)
+{
+	struct tty_struct *tty;
+	int tty_pgrp = -1;
+
+	lock_kernel();
+
+	mutex_lock(&tty_mutex);
+	tty = current->signal->tty;
+	if (tty) {
+		tty_pgrp = tty->pgrp;
+		mutex_unlock(&tty_mutex);
+		if (on_exit && tty->driver->type != TTY_DRIVER_TYPE_PTY)
+			tty_vhangup(tty);
+	} else {
+		if (current->signal->tty_old_pgrp) {
+			kill_pg(current->signal->tty_old_pgrp, SIGHUP, on_exit);
+			kill_pg(current->signal->tty_old_pgrp, SIGCONT, on_exit);
+		}
+		mutex_unlock(&tty_mutex);
+		unlock_kernel();	
+		return;
+	}
+	if (tty_pgrp > 0) {
+		kill_pg(tty_pgrp, SIGHUP, on_exit);
+		if (!on_exit)
+			kill_pg(tty_pgrp, SIGCONT, on_exit);
+	}
+
+	/* Must lock changes to tty_old_pgrp */
+	mutex_lock(&tty_mutex);
+	current->signal->tty_old_pgrp = 0;
+	tty->session = 0;
+	tty->pgrp = -1;
+
+	/* Now clear signal->tty under the lock */
+	reset_session_tty(current->signal->session);
+	mutex_unlock(&tty_mutex);
+	unlock_kernel();
+}
+
+EXPORT_SYMBOL(clear_controlling_tty);
+
+void clear_session_tty(pid_t session, struct tty_struct *tty, pid_t pgrp)
+{
+	struct task_struct *p;
+	
+	read_lock(&tasklist_lock);
+	if (session > 0) {
+		do_each_task_pid(session, PIDTYPE_SID, p) {
+			if (p->signal->tty == tty) {
+				tty_put(p->signal->tty);
+				p->signal->tty = NULL;
+			}
+			if (!p->signal->leader)
+				continue;
+			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
+			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			if (pgrp > 0)
+				p->signal->tty_old_pgrp = tty->pgrp;
+		} while_each_task_pid(session, PIDTYPE_SID, p);
+	}
+	read_unlock(&tasklist_lock);
+}
+
+EXPORT_SYMBOL(clear_session_tty);
+
 void daemonize(const char *name, ...)
 {
 	va_list args;
@@ -398,6 +514,7 @@ void daemonize(const char *name, ...)

 	set_special_pids(1, 1);
 	mutex_lock(&tty_mutex);
+	tty_put(current->signal->tty);
 	current->signal->tty = NULL;
 	mutex_unlock(&tty_mutex);

@@ -917,7 +1034,7 @@ #endif
 	exit_keys(tsk);

 	if (group_dead && tsk->signal->leader)
-		disassociate_ctty(1);
+		clear_controlling_tty(1);

 	module_put(task_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
diff --git a/kernel/fork.c b/kernel/fork.c
index dfd10cb..34e7797 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,7 @@ #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/tty.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1201,7 +1202,7 @@ #endif
 			__ptrace_link(p, current->parent);

 		if (thread_group_leader(p)) {
-			p->signal->tty = current->signal->tty;
+			p->signal->tty = tty_get(current->signal->tty);
 			p->signal->pgrp = process_group(current);
 			p->signal->session = current->signal->session;
 			attach_pid(p, PIDTYPE_PGID, process_group(p));
diff --git a/kernel/sys.c b/kernel/sys.c
index 2d5179c..c97370f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1400,8 +1400,7 @@ asmlinkage long sys_setsid(void)

 	group_leader->signal->leader = 1;
 	__set_special_pids(session, session);
-	group_leader->signal->tty = NULL;
-	group_leader->signal->tty_old_pgrp = 0;
+	reset_controlling_tty(group_leader);
 	err = process_group(group_leader);
 out:
 	write_unlock_irq(&tasklist_lock);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79c16e3..f3e128a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1624,9 +1624,7 @@ static inline void flush_unauthorized_fi
 			struct inode *inode = file->f_dentry->d_inode;
 			if (inode_has_perm(current, inode,
 					   FILE__READ | FILE__WRITE, NULL)) {
-				/* Reset controlling tty. */
-				current->signal->tty = NULL;
-				current->signal->tty_old_pgrp = 0;
+				reset_controlling_tty(current);
 			}
 		}
 		file_list_unlock();
