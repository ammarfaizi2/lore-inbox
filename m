Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWHHUAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWHHUAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWHHUAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:00:42 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:39085 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1030280AbWHHUAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:00:41 -0400
Subject: Re: How to lock current->signal->tty
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric Paris <eparis@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, jack@suse.cz, dwmw2@infradead.org,
       tony.luck@intel.com, jdike@karaya.com,
       James.Bottomley@HansenPartnership.com
In-Reply-To: <1155058994.5729.99.camel@localhost.localdomain>
References: <1155050242.5729.88.camel@localhost.localdomain>
	 <1155057114.1123.97.camel@moss-spartans.epoch.ncsc.mil>
	 <1155058994.5729.99.camel@localhost.localdomain>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 08 Aug 2006 16:02:30 -0400
Message-Id: <1155067350.1123.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 18:43 +0100, Alan Cox wrote:
> Ar Maw, 2006-08-08 am 13:11 -0400, ysgrifennodd Stephen Smalley:
> > Does this look sane?  Or do we need a common helper factored from
> > disassociate_ctty()?  Why is the locking different for TIOCNOTTY in the
> > non-leader case?
> 
> The non-leader case for TIOCNOTTY in the base kernel is different
> because it is wrong and I've fixed that one.
> 
> If you can factor disassociate_ctty out to do what you need I'd prefer
> that path so the tty locking actually ends up in the tty layer.

Possible patch below, but not yet tested.  This splits the handling
between the tty layer and SELinux.  Not sure about the !leader case,
should be consistent with whatever you end up using for TIOCNOTTY.  This
changes behavior for SELinux in the leader case, since it will now
perform a full disassociate.  Not sure whether the use of ->tty_files
should also be moved into the tty layer, with the tty layer then just
passing the file struct to the security hook instead of the tty struct.

---

 drivers/char/tty_io.c    |   30 ++++++++++++++++++++++++++-
 include/linux/security.h |   20 ++++++++++++++++++
 include/linux/tty.h      |    1 
 security/dummy.c         |    6 +++++
 security/selinux/hooks.c |   51 ++++++++++++++++++++++++++++-------------------
 5 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index bfdb902..c16e0b3 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -94,6 +94,7 @@ #include <linux/idr.h>
 #include <linux/wait.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -1175,8 +1176,11 @@ EXPORT_SYMBOL(tty_hung_up_p);
  *
  * The argument on_exit is set to 1 if called when a process is
  * exiting; it is 0 if called by the ioctl TIOCNOTTY.
+ * The argument cond_sec is set to 1 if called by a security module
+ * to revalidate access to the ctty and conditionally disassociate
+ * if access is no longer permitted.
  */
-void disassociate_ctty(int on_exit)
+static void disassociate_ctty_core(int on_exit, int cond_sec)
 {
 	struct tty_struct *tty;
 	struct task_struct *p;
@@ -1186,6 +1190,13 @@ void disassociate_ctty(int on_exit)
 
 	mutex_lock(&tty_mutex);
 	tty = current->signal->tty;
+	if (tty && cond_sec) {
+		if (!security_tty_disassociate(tty)) {
+			mutex_unlock(&tty_mutex);
+			unlock_kernel();
+			return;
+		}
+	}
 	if (tty) {
 		tty_pgrp = tty->pgrp;
 		mutex_unlock(&tty_mutex);
@@ -1222,6 +1233,23 @@ void disassociate_ctty(int on_exit)
 	unlock_kernel();
 }
 
+void disassociate_ctty(int on_exit)
+{
+	disassociate_ctty_core(on_exit, 0);
+}
+
+void revalidate_ctty(void)
+{
+	if (current->signal->leader) {
+		disassociate_ctty_core(0, 1);
+		return;
+	}
+	mutex_lock(&tty_mutex);
+	if (security_tty_disassociate(current->signal->tty))
+		current->signal->tty = NULL;
+	mutex_unlock(&tty_mutex);
+}
+
 void stop_tty(struct tty_struct *tty)
 {
 	if (tty->stopped)
diff --git a/include/linux/security.h b/include/linux/security.h
index 6bc2aad..17ec32d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -500,6 +500,14 @@ #ifdef CONFIG_SECURITY
  *	@file contains the file structure being received.
  *	Return 0 if permission is granted.
  *
+ * Security hooks for tty operations.
+ *
+ * @tty_disassociate:
+ *	This hook allows security modules to control whether the tty
+ *      should be disassociated.
+ *	@tty contains the tty structure.
+ *	Return 0 if permission is granted to the tty, or <0 to disassociate.
+ *
  * Security hooks for task operations.
  *
  * @task_create:
@@ -1227,6 +1235,8 @@ struct security_operations {
 				    struct fown_struct * fown, int sig);
 	int (*file_receive) (struct file * file);
 
+	int (*tty_disassociate) (struct tty_struct *tty);
+
 	int (*task_create) (unsigned long clone_flags);
 	int (*task_alloc_security) (struct task_struct * p);
 	void (*task_free_security) (struct task_struct * p);
@@ -1813,6 +1823,11 @@ static inline int security_file_receive 
 	return security_ops->file_receive (file);
 }
 
+static inline int security_tty_disassociate (struct tty_struct *tty)
+{
+	return security_ops->tty_disassociate (tty);
+}
+
 static inline int security_task_create (unsigned long clone_flags)
 {
 	return security_ops->task_create (clone_flags);
@@ -2488,6 +2503,11 @@ static inline int security_file_receive 
 	return 0;
 }
 
+static inline int security_tty_disassociate (struct tty_struct *tty)
+{
+	return 0;
+}
+
 static inline int security_task_create (unsigned long clone_flags)
 {
 	return 0;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e421d5e..c0f1fcb 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -292,6 +292,7 @@ extern void tty_vhangup(struct tty_struc
 extern void tty_unhangup(struct file *filp);
 extern int tty_hung_up_p(struct file * filp);
 extern void do_SAK(struct tty_struct *tty);
+extern void revalidate_ctty(void);
 extern void disassociate_ctty(int priv);
 extern void tty_flip_buffer_push(struct tty_struct *tty);
 extern int tty_get_baud_rate(struct tty_struct *tty);
diff --git a/security/dummy.c b/security/dummy.c
index 58c6d39..ca833b4 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -459,6 +459,11 @@ static int dummy_file_receive (struct fi
 	return 0;
 }
 
+static int dummy_tty_disassociate (struct tty_struct *tty)
+{
+	return 0;
+}
+
 static int dummy_task_create (unsigned long clone_flags)
 {
 	return 0;
@@ -987,6 +992,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, file_set_fowner);
 	set_to_dummy_if_null(ops, file_send_sigiotask);
 	set_to_dummy_if_null(ops, file_receive);
+	set_to_dummy_if_null(ops, tty_disassociate);
 	set_to_dummy_if_null(ops, task_create);
 	set_to_dummy_if_null(ops, task_alloc_security);
 	set_to_dummy_if_null(ops, task_free_security);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5d1b8c7..278eb37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1711,29 +1711,17 @@ static inline void flush_unauthorized_fi
 {
 	struct avc_audit_data ad;
 	struct file *file, *devnull = NULL;
-	struct tty_struct *tty = current->signal->tty;
 	struct fdtable *fdt;
 	long j = -1;
 
-	if (tty) {
-		file_list_lock();
-		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
-		if (file) {
-			/* Revalidate access to controlling tty.
-			   Use inode_has_perm on the tty inode directly rather
-			   than using file_has_perm, as this particular open
-			   file may belong to another process and we are only
-			   interested in the inode-based check here. */
-			struct inode *inode = file->f_dentry->d_inode;
-			if (inode_has_perm(current, inode,
-					   FILE__READ | FILE__WRITE, NULL)) {
-				/* Reset controlling tty. */
-				current->signal->tty = NULL;
-				current->signal->tty_old_pgrp = 0;
-			}
-		}
-		file_list_unlock();
-	}
+	/*
+	 * Revalidate access to the controlling tty, and
+	 * reset it if necessary.
+	 * Calls back to selinux_tty_disassociate to check
+	 * permissions after locking.
+	 */
+	if (current->signal->tty)
+		revalidate_ctty();
 
 	/* Revalidate access to inherited open files. */
 
@@ -2650,6 +2638,27 @@ static int selinux_file_receive(struct f
 	return file_has_perm(current, file, file_to_av(file));
 }
 
+static int selinux_tty_disassociate(struct tty_struct *tty)
+{
+	struct file *file;
+	int rc = 0;
+
+	file_list_lock();
+	file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
+	if (file) {
+		/* Revalidate access to controlling tty.
+		   Use inode_has_perm on the tty inode directly rather
+		   than using file_has_perm, as this particular open
+		   file may belong to another process and we are only
+		   interested in the inode-based check here. */
+		struct inode *inode = file->f_dentry->d_inode;
+		rc = inode_has_perm(current, inode, FILE__READ | FILE__WRITE,
+				    NULL);
+	}
+	file_list_unlock();
+	return rc;
+}
+
 /* task security operations */
 
 static int selinux_task_create(unsigned long clone_flags)
@@ -4538,6 +4547,8 @@ static struct security_operations selinu
 	.file_send_sigiotask =		selinux_file_send_sigiotask,
 	.file_receive =			selinux_file_receive,
 
+	.tty_disassociate =		selinux_tty_disassociate,
+
 	.task_create =			selinux_task_create,
 	.task_alloc_security =		selinux_task_alloc_security,
 	.task_free_security =		selinux_task_free_security,

-- 
Stephen Smalley
National Security Agency

