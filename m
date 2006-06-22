Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWFVVbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWFVVbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbWFVVbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:31:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:19913 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932660AbWFVVbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:31:36 -0400
Date: Thu, 22 Jun 2006 14:31:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Jens Axboe <axboe@suse.de>,
       Dave Miller <davem@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       Ingo Molnar <mingo@elte.hu>
Message-Id: <20060622213123.32391.87337.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060622213102.32391.19996.sendpatchset@schroedinger.engr.sgi.com>
References: <20060622213102.32391.19996.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/4] Drop rcu field
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

file RCU optimization: Drop rcu field and restore old name for fu_list.

The slab has its own RCU blocks so no need to have that in the files
structure.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17/drivers/char/tty_io.c
===================================================================
--- linux-2.6.17.orig/drivers/char/tty_io.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/drivers/char/tty_io.c	2006-06-22 14:11:00.687890471 -0700
@@ -1046,7 +1046,7 @@ static void do_tty_hangup(void *data)
 	check_tty_count(tty, "do_tty_hangup");
 	file_list_lock();
 	/* This breaks for file handles being sent over AF_UNIX sockets ? */
-	list_for_each_entry(filp, &tty->tty_files, f_u.fu_list) {
+	list_for_each_entry(filp, &tty->tty_files, f_list) {
 		if (filp->f_op->write == redirected_tty_write)
 			cons_filp = filp;
 		if (filp->f_op->write != tty_write)
Index: linux-2.6.17/fs/dquot.c
===================================================================
--- linux-2.6.17.orig/fs/dquot.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/fs/dquot.c	2006-06-22 14:11:00.688866973 -0700
@@ -693,7 +693,7 @@ static void add_dquot_ref(struct super_b
 restart:
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file *filp = list_entry(p, struct file, f_u.fu_list);
+		struct file *filp = list_entry(p, struct file, f_list);
 		struct inode *inode = filp->f_dentry->d_inode;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
 			struct dentry *dentry = dget(filp->f_dentry);
Index: linux-2.6.17/security/selinux/selinuxfs.c
===================================================================
--- linux-2.6.17.orig/security/selinux/selinuxfs.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/security/selinux/selinuxfs.c	2006-06-22 14:11:00.690819977 -0700
@@ -901,7 +901,7 @@ static void sel_remove_bools(struct dent
 
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file * filp = list_entry(p, struct file, f_u.fu_list);
+		struct file * filp = list_entry(p, struct file, f_list);
 		struct dentry * dentry = filp->f_dentry;
 
 		if (dentry->d_parent != de) {
Index: linux-2.6.17/include/linux/fs.h
===================================================================
--- linux-2.6.17.orig/include/linux/fs.h	2006-06-22 13:16:13.317087178 -0700
+++ linux-2.6.17/include/linux/fs.h	2006-06-22 14:11:00.691796479 -0700
@@ -631,14 +631,7 @@ struct file_ra_state {
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
 
 struct file {
-	/*
-	 * fu_list becomes invalid after file_free is called and queued via
-	 * fu_rcuhead for RCU freeing
-	 */
-	union {
-		struct list_head	fu_list;
-		struct rcu_head 	fu_rcuhead;
-	} f_u;
+	struct list_head	f_list;
 	struct dentry		*f_dentry;
 	struct vfsmount         *f_vfsmnt;
 	const struct file_operations	*f_op;
Index: linux-2.6.17/fs/file_table.c
===================================================================
--- linux-2.6.17.orig/fs/file_table.c	2006-06-22 14:09:51.989993240 -0700
+++ linux-2.6.17/fs/file_table.c	2006-06-22 14:11:00.692772981 -0700
@@ -43,7 +43,7 @@ static void filp_constructor(void *data,
 			return;
 
 	memset(f, 0, sizeof(*f));
-	INIT_LIST_HEAD(&f->f_u.fu_list);
+	INIT_LIST_HEAD(&f->f_list);
 	atomic_set(&f->f_count, 0);
 	rwlock_init(&f->f_owner.lock);
 	eventpoll_init_file(f);
@@ -265,15 +265,15 @@ void file_move(struct file *file, struct
 	if (!list)
 		return;
 	file_list_lock();
-	list_move(&file->f_u.fu_list, list);
+	list_move(&file->f_list, list);
 	file_list_unlock();
 }
 
 void file_kill(struct file *file)
 {
-	if (!list_empty(&file->f_u.fu_list)) {
+	if (!list_empty(&file->f_list)) {
 		file_list_lock();
-		list_del_init(&file->f_u.fu_list);
+		list_del_init(&file->f_list);
 		file_list_unlock();
 	}
 }
@@ -285,7 +285,7 @@ int fs_may_remount_ro(struct super_block
 	/* Check that no files are currently opened for writing. */
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file *file = list_entry(p, struct file, f_u.fu_list);
+		struct file *file = list_entry(p, struct file, f_list);
 		struct inode *inode = file->f_dentry->d_inode;
 
 		/* File with pending delete? */
Index: linux-2.6.17/fs/super.c
===================================================================
--- linux-2.6.17.orig/fs/super.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/fs/super.c	2006-06-22 14:11:00.692772981 -0700
@@ -513,7 +513,7 @@ static void mark_files_ro(struct super_b
 	struct file *f;
 
 	file_list_lock();
-	list_for_each_entry(f, &sb->s_files, f_u.fu_list) {
+	list_for_each_entry(f, &sb->s_files, f_list) {
 		if (S_ISREG(f->f_dentry->d_inode->i_mode) && file_count(f))
 			f->f_mode &= ~FMODE_WRITE;
 	}
Index: linux-2.6.17/security/selinux/hooks.c
===================================================================
--- linux-2.6.17.orig/security/selinux/hooks.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/security/selinux/hooks.c	2006-06-22 14:11:00.695702488 -0700
@@ -1611,7 +1611,7 @@ static inline void flush_unauthorized_fi
 
 	if (tty) {
 		file_list_lock();
-		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
+		file = list_entry(tty->tty_files.next, typeof(*file), f_list);
 		if (file) {
 			/* Revalidate access to controlling tty.
 			   Use inode_has_perm on the tty inode directly rather
Index: linux-2.6.17/fs/proc/generic.c
===================================================================
--- linux-2.6.17.orig/fs/proc/generic.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/fs/proc/generic.c	2006-06-22 14:11:00.696678990 -0700
@@ -557,7 +557,7 @@ static void proc_kill_inodes(struct proc
 	 */
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file * filp = list_entry(p, struct file, f_u.fu_list);
+		struct file * filp = list_entry(p, struct file, f_list);
 		struct dentry * dentry = filp->f_dentry;
 		struct inode * inode;
 		const struct file_operations *fops;
