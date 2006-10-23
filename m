Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWJWLLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWJWLLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWJWLLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:11:06 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:29337 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751893AbWJWLLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:11:05 -0400
Subject: [RFC][PATCH] tty: tty refcounting
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 13:10:51 +0200
Message-Id: <1161601851.5230.86.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename get_current_tty() to current_tty(), because we're introducing a new
get_current_tty() that actually gets a refcount.

Since tty lifetime is governed by its open file handles, expose an external
ref counting API based on this. It tries to grab an extra reference on one
of the tty's supporting files thereby keeping it from closing and taking
the tty with it.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/um/kernel/exec.c      |    2 +-
 drivers/char/tty_io.c      |   30 +++++++++++++++++++++++++++---
 drivers/s390/char/fs3270.c |    2 +-
 fs/dquot.c                 |    2 +-
 fs/open.c                  |   10 ++++++++--
 include/linux/tty.h        |   39 ++++++++++++++++++++++++++++++++++++++-
 kernel/acct.c              |    2 +-
 security/selinux/hooks.c   |    2 +-
 8 files changed, 78 insertions(+), 11 deletions(-)

Index: linux-2.6/arch/um/kernel/exec.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/exec.c
+++ linux-2.6/arch/um/kernel/exec.c
@@ -43,7 +43,7 @@ static long execve1(char *file, char __u
 
 #ifdef CONFIG_TTY_LOG
 	mutex_lock(&tty_mutex);
-	tty = get_current_tty();
+	tty = current_tty();
 	if (tty)
 		log_exec(argv, tty);
 	mutex_unlock(&tty_mutex);
Index: linux-2.6/drivers/char/tty_io.c
===================================================================
--- linux-2.6.orig/drivers/char/tty_io.c
+++ linux-2.6/drivers/char/tty_io.c
@@ -1489,9 +1489,9 @@ void disassociate_ctty(int on_exit)
 	if (tty) {
 		tty_pgrp = tty->pgrp;
 		mutex_unlock(&tty_mutex);
-		/* XXX: here we race, there is nothing protecting tty */
 		if (on_exit && tty->driver->type != TTY_DRIVER_TYPE_PTY)
 			tty_vhangup(tty);
+		tty_put(tty);
 	} else {
 		pid_t old_pgrp = current->signal->tty_old_pgrp;
 		if (old_pgrp) {
@@ -1515,7 +1515,7 @@ void disassociate_ctty(int on_exit)
 
 	mutex_lock(&tty_mutex);
 	/* It is possible that do_tty_hangup has free'd this tty */
-	tty = get_current_tty();
+	tty = current_tty();
 	if (tty) {
 		tty->session = 0;
 		tty->pgrp = 0;
@@ -2331,6 +2331,8 @@ static void release_dev(struct file * fi
 	 */
 	file_kill(filp);
 	filp->private_data = NULL;
+	if (tty->tty_ref_file == filp)
+		tty->tty_ref_file = NULL;
 
 	/*
 	 * Perform some housekeeping before deciding whether to return.
@@ -2474,7 +2476,7 @@ retry_open:
 	mutex_lock(&tty_mutex);
 
 	if (device == MKDEV(TTYAUX_MAJOR,0)) {
-		tty = get_current_tty();
+		tty = current_tty();
 		if (!tty) {
 			mutex_unlock(&tty_mutex);
 			return -ENXIO;
@@ -3835,6 +3837,28 @@ int tty_unregister_driver(struct tty_dri
 
 EXPORT_SYMBOL(tty_unregister_driver);
 
+int __tty_get(struct tty_struct *tty)
+{
+	struct file *filp;
+
+	BUG_ON(!mutex_is_locked(&tty_mutex));
+
+	/*
+	 * when ->ref_tty_file != NULL, we can still reset it because
+	 * we're not actually holding a ref on it, otherwise the increment
+	 * in tty_get() would not have failed.
+	 */
+	list_for_each_entry(filp, &tty->tty_files, f_u.fu_list) {
+		if (atomic_inc_not_zero(&filp->f_count)) {
+			tty->tty_ref_file = filp;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(__tty_get);
 
 /*
  * Initialize the console device. This is called *early*, so
Index: linux-2.6/drivers/s390/char/fs3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/fs3270.c
+++ linux-2.6/drivers/s390/char/fs3270.c
@@ -426,7 +426,7 @@ fs3270_open(struct inode *inode, struct 
 	if (minor == 0) {
 		struct tty_struct *tty;
 		mutex_lock(&tty_mutex);
-		tty = get_current_tty();
+		tty = current_tty();
 		if (!tty || tty->driver->major != IBM_TTY3270_MAJOR) {
 			mutex_unlock(&tty_mutex);
 			return -ENODEV;
Index: linux-2.6/fs/dquot.c
===================================================================
--- linux-2.6.orig/fs/dquot.c
+++ linux-2.6/fs/dquot.c
@@ -836,7 +836,7 @@ static void print_warning(struct dquot *
 		return;
 
 	mutex_lock(&tty_mutex);
-	tty = get_current_tty();
+	tty = current_tty();
 	if (!tty)
 		goto out_lock;
 	tty_write_message(tty, dquot->dq_sb->s_id);
Index: linux-2.6/fs/open.c
===================================================================
--- linux-2.6.orig/fs/open.c
+++ linux-2.6/fs/open.c
@@ -1087,8 +1087,14 @@ EXPORT_SYMBOL(sys_close);
 asmlinkage long sys_vhangup(void)
 {
 	if (capable(CAP_SYS_TTY_CONFIG)) {
-		/* XXX: this needs locking */
-		tty_vhangup(current->signal->tty);
+		struct tty_struct *tty;
+		mutex_lock(&tty_mutex);
+		tty = get_current_tty();
+		mutex_unlock(&tty_mutex);
+		if (tty) {
+			tty_vhangup(tty);
+			tty_put(tty);
+		}
 		return 0;
 	}
 	return -EPERM;
Index: linux-2.6/include/linux/tty.h
===================================================================
--- linux-2.6.orig/include/linux/tty.h
+++ linux-2.6/include/linux/tty.h
@@ -13,6 +13,7 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
 #include <linux/mutex.h>
+#include <linux/file.h>
 
 #include <asm/system.h>
 
@@ -197,6 +198,7 @@ struct tty_struct {
 	void *disc_data;
 	void *driver_data;
 	struct list_head tty_files;
+	struct file *tty_ref_file;
 
 #define N_TTY_BUF_SIZE 4096
 	
@@ -367,7 +369,7 @@ void proc_set_tty(struct task_struct *ts
 	spin_unlock_irq(&tsk->sighand->siglock);
 }
 
-static inline struct tty_struct *get_current_tty(void)
+static inline struct tty_struct *current_tty(void)
 {
 	struct tty_struct *tty;
 	WARN_ON_ONCE(!mutex_is_locked(&tty_mutex));
@@ -381,5 +383,40 @@ static inline struct tty_struct *get_cur
 	return tty;
 }
 
+int __tty_get(struct tty_struct *tty);
+
+/*
+ * tty_get() extends the lifetime of tty by trying to grab an extra reference
+ * on one of the supporting file handles.
+ *
+ * If this fails the tty is closing down.
+ *
+ * NOTE: the a-symetry of holding the tty_mutex between the get and put
+ * methods is on purpose and unavoidable.
+ */
+static inline __must_check int tty_get(struct tty_struct *tty)
+{
+	BUG_ON(!mutex_is_locked(&tty_mutex));
+	if (!tty->tty_ref_file ||
+			!atomic_inc_not_zero(&tty->tty_ref_file->f_count))
+		return __tty_get(tty);
+	return 1;
+}
+
+static inline void tty_put(struct tty_struct *tty)
+{
+	BUG_ON(!tty->tty_ref_file);
+	BUG_ON(mutex_is_locked(&tty_mutex));
+	fput(tty->tty_ref_file);
+}
+
+static inline struct tty_struct *get_current_tty(void)
+{
+	struct tty_struct *tty = current_tty();
+	if (tty && !tty_get(tty))
+		tty = NULL;
+	return tty;
+}
+
 #endif /* __KERNEL__ */
 #endif
Index: linux-2.6/kernel/acct.c
===================================================================
--- linux-2.6.orig/kernel/acct.c
+++ linux-2.6/kernel/acct.c
@@ -485,7 +485,7 @@ static void do_acct_process(struct file 
 #endif
 
 	mutex_lock(&tty_mutex);
-	tty = get_current_tty();
+	tty = current_tty();
 	ac.ac_tty = tty ? old_encode_dev(tty_devnum(tty)) : 0;
 	mutex_unlock(&tty_mutex);
 
Index: linux-2.6/security/selinux/hooks.c
===================================================================
--- linux-2.6.orig/security/selinux/hooks.c
+++ linux-2.6/security/selinux/hooks.c
@@ -1695,7 +1695,7 @@ static inline void flush_unauthorized_fi
 	int drop_tty = 0;
 
 	mutex_lock(&tty_mutex);
-	tty = get_current_tty();
+	tty = current_tty();
 	if (tty) {
 		file_list_lock();
 		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);



