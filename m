Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264873AbSJVSil>; Tue, 22 Oct 2002 14:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264879AbSJVSik>; Tue, 22 Oct 2002 14:38:40 -0400
Received: from cs.columbia.edu ([128.59.16.20]:9686 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S264873AbSJVSic>;
	Tue, 22 Oct 2002 14:38:32 -0400
Subject: [PATCH & RFC] first attempt at making chroot nestable
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1035312255.2551.27.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2 (Preview Release)
Date: 22 Oct 2002 14:44:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first attempt at a change that lets kernel's chroot's and wont
let you use an fd to break out of a chroot, it will only let you get as
far as the root as of when you got the fd (or possibly even less).

I've discussed the algorithm I've implemented below a couple times
already on the list, but I doubt my coding style is up to snuff, so
criticize away on that.  I also haven't had a chance to test it yet
(need to get into school to use the test machines), so all I know is
that it compiles w/o any warnings.

please comment away (as well as tell me if I did right my inline'ing the
patch, or if I should attach it, if it matters the mail client I
normally use is evolution)

thanks,

shaya

diff -Naur linux-2.4.19/fs/open.c linux-2.4.19.new/fs/open.c
--- linux-2.4.19/fs/open.c	2002-10-22 14:28:48.000000000 -0400
+++ linux-2.4.19.new/fs/open.c	2002-10-22 14:29:37.000000000 -0400
@@ -475,10 +475,12 @@
 	set_fs_root(current->fs, nd.mnt, nd.dentry);
 	set_fs_altroot();
 
+	write_lock(&current->fs->lock);
 	cp->mnt = mntget(nd.mnt);
 	cp->root = dget(nd.dentry);
 	cp->next = current->cp;
 	current->cp = cp;
+	write_unlock(&current>fs->lock);
 	
 	error = 0;
 dput_and_out:
diff -Naur linux-2.4.19/include/linux/sched.h linux-2.4.19.new/include/linux/sched.h
--- linux-2.4.19/include/linux/sched.h	2002-08-02 20:39:45.000000000 -0400
+++ linux-2.4.19.new/include/linux/sched.h	2002-10-22 13:54:12.000000000 -0400
@@ -418,6 +418,7 @@
 
 /* journalling filesystem info */
 	void *journal_info;
+	struct chroot_point *cp;
 };
 
 /*
@@ -511,6 +512,7 @@
     blocked:		{{0}},						\
     alloc_lock:		SPIN_LOCK_UNLOCKED,				\
     journal_info:	NULL,						\
+    cp:			NULL,						\
 }
 
 
diff -Naur linux-2.4.19/kernel/exit.c linux-2.4.19.new/kernel/exit.c
--- linux-2.4.19/kernel/exit.c	2002-08-02 20:39:46.000000000 -0400
+++ linux-2.4.19.new/kernel/exit.c	2002-10-22 13:54:09.000000000 -0400
@@ -286,6 +286,31 @@
 	__exit_fs(tsk);
 }
 
+static inline void __exit_chroot(struct task_struct *tsk)
+{
+	struct chroot_point *cur, *next;
+
+	cur = tsk->cp;
+
+	task_lock(tsk);
+	tsk->cp = NULL;
+	task_unlock(tsk);
+		
+	while (cur)
+	{
+		kfree(cur->mnt);
+		kfree(cur->root);
+		next = cur->next;
+		kfree(cur);
+		cur = next;
+	}
+}
+
+void exit_chroot(struct task_struct *tsk)
+{
+	__exit_chroot(tsk);
+}
+
 /*
  * We can use these to temporarily drop into
  * "lazy TLB" mode and back.
@@ -459,6 +484,7 @@
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);
+	__exit_chroot(tsk);
 	exit_namespace(tsk);
 	exit_sighand(tsk);
 	exit_thread();
diff -Naur linux-2.4.19/kernel/fork.c linux-2.4.19.new/kernel/fork.c
--- linux-2.4.19/kernel/fork.c	2002-08-02 20:39:46.000000000 -0400
+++ linux-2.4.19.new/kernel/fork.c	2002-10-22 14:15:38.000000000 -0400
@@ -580,6 +580,7 @@
 	int retval;
 	struct task_struct *p;
 	struct completion vfork;
+	struct chroot_point *cp_p, *cp_c;
 
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
 		return -EINVAL;
@@ -726,6 +727,28 @@
 	p->tgid = retval;
 	INIT_LIST_HEAD(&p->thread_group);
 
+	/* copy chroot_point list from parent to child */
+	cp_p = current->cp;
+	cp_c = NULL;
+
+	if (cp_p)
+		cp_c = (struct chroot_point *) kmalloc(sizeof(struct chroot_point), GFP_KERNEL);
+	
+	p->cp = cp_c;
+
+	while (cp_p)
+	{
+		cp_c->root = dget(cp_p->root);
+		cp_c->mnt = mntget(cp_p->mnt);
+		cp_c->next = NULL;
+
+		if (cp_p->next) {
+			cp_c->next = (struct chroot_point *) kmalloc(sizeof(struct chroot_point), GFP_KERNEL);
+			cp_c = cp_c->next;
+		}
+		cp_p = cp_p->next;
+	}
+		
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
 



