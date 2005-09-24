Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVIXDnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVIXDnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 23:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVIXDnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 23:43:10 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:23769 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751393AbVIXDnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 23:43:09 -0400
Message-ID: <4334CB49.3080703@cosmosbay.com>
Date: Sat, 24 Sep 2005 05:43:05 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] reduce sizeof(struct file)
References: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org> <4333CF4C.2000306@anagramm.de> <4333D2AA.6020009@cosmosbay.com> <20050923100541.GA18447@infradead.org>
In-Reply-To: <20050923100541.GA18447@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------020609050205060202010605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020609050205060202010605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Christoph Hellwig a écrit :
> 
> Please just change all callers to use the union, there's not very many
> of them.

Yes it's better, thanks Christoph.

What about this version then ?

Hi all

Now that RCU applied on 'struct file' seems stable, we can place f_rcuhead in 
a memory location that is not anymore used at call_rcu(&f->f_rcuhead, 
file_free_rcu) time, to reduce the size of this critical kernel object.

The trick I used is to move f_rcuhead and f_list in an union called f_u

The callers are changed so that f_rcuhead becomes f_u.fu_rcuhead and f_list 
becomes f_u.f_list

Tested on allyesconfig, diffed against 2.6.14-rc2

  drivers/char/tty_io.c        |    2 +-
  fs/dquot.c                   |    2 +-
  fs/file_table.c              |   14 +++++++-------
  fs/proc/generic.c            |    2 +-
  fs/super.c                   |    2 +-
  include/linux/fs.h           |    9 +++++++--
  security/selinux/hooks.c     |    2 +-
  security/selinux/selinuxfs.c |    2 +-
  8 files changed, 20 insertions(+), 15 deletions(-)


Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------020609050205060202010605
Content-Type: text/plain;
 name="shrink_struct_file"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shrink_struct_file"

--- linux-2.6.14-rc2-orig/include/linux/fs.h	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2/include/linux/fs.h	2005-09-24 04:52:20.000000000 +0200
@@ -574,7 +574,13 @@
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
 
 struct file {
-	struct list_head	f_list;
+/*
+ * f_list and f_rcuhead can share the same memory location
+ */
+	union {
+		struct list_head	fu_list;
+		struct rcu_head 	fu_rcuhead;
+		} f_u;
 	struct dentry		*f_dentry;
 	struct vfsmount         *f_vfsmnt;
 	struct file_operations	*f_op;
@@ -598,7 +604,6 @@
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
-	struct rcu_head 	f_rcuhead;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
--- linux-2.6.14-rc2-orig/fs/file_table.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2/fs/file_table.c	2005-09-24 05:02:35.000000000 +0200
@@ -56,13 +56,13 @@
 
 static inline void file_free_rcu(struct rcu_head *head)
 {
-	struct file *f =  container_of(head, struct file, f_rcuhead);
+	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
 	kmem_cache_free(filp_cachep, f);
 }
 
 static inline void file_free(struct file *f)
 {
-	call_rcu(&f->f_rcuhead, file_free_rcu);
+	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
 /* Find an unused file structure and return a pointer to it.
@@ -95,7 +95,7 @@
 	f->f_gid = current->fsgid;
 	rwlock_init(&f->f_owner.lock);
 	/* f->f_version: 0 */
-	INIT_LIST_HEAD(&f->f_list);
+	INIT_LIST_HEAD(&f->f_u.fu_list);
 	return f;
 
 over:
@@ -225,15 +225,15 @@
 	if (!list)
 		return;
 	file_list_lock();
-	list_move(&file->f_list, list);
+	list_move(&file->f_u.fu_list, list);
 	file_list_unlock();
 }
 
 void file_kill(struct file *file)
 {
-	if (!list_empty(&file->f_list)) {
+	if (!list_empty(&file->f_u.fu_list)) {
 		file_list_lock();
-		list_del_init(&file->f_list);
+		list_del_init(&file->f_u.fu_list);
 		file_list_unlock();
 	}
 }
@@ -245,7 +245,7 @@
 	/* Check that no files are currently opened for writing. */
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file *file = list_entry(p, struct file, f_list);
+		struct file *file = list_entry(p, struct file, f_u.fu_list);
 		struct inode *inode = file->f_dentry->d_inode;
 
 		/* File with pending delete? */
--- linux-2.6.14-rc2-orig/drivers/char/tty_io.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2/drivers/char/tty_io.c	2005-09-24 05:02:35.000000000 +0200
@@ -809,7 +809,7 @@
 	check_tty_count(tty, "do_tty_hangup");
 	file_list_lock();
 	/* This breaks for file handles being sent over AF_UNIX sockets ? */
-	list_for_each_entry(filp, &tty->tty_files, f_list) {
+	list_for_each_entry(filp, &tty->tty_files, f_u.fu_list) {
 		if (filp->f_op->write == redirected_tty_write)
 			cons_filp = filp;
 		if (filp->f_op->write != tty_write)
--- linux-2.6.14-rc2-orig/fs/dquot.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2/fs/dquot.c	2005-09-24 05:02:35.000000000 +0200
@@ -662,7 +662,7 @@
 restart:
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file *filp = list_entry(p, struct file, f_list);
+		struct file *filp = list_entry(p, struct file, f_u.fu_list);
 		struct inode *inode = filp->f_dentry->d_inode;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
 			struct dentry *dentry = dget(filp->f_dentry);
--- linux-2.6.14-rc2-orig/fs/proc/generic.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2/fs/proc/generic.c	2005-09-24 05:02:35.000000000 +0200
@@ -533,7 +533,7 @@
 	 */
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file * filp = list_entry(p, struct file, f_list);
+		struct file * filp = list_entry(p, struct file, f_u.fu_list);
 		struct dentry * dentry = filp->f_dentry;
 		struct inode * inode;
 		struct file_operations *fops;
--- linux-2.6.14-rc2-orig/fs/super.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2/fs/super.c	2005-09-24 05:02:35.000000000 +0200
@@ -513,7 +513,7 @@
 	struct file *f;
 
 	file_list_lock();
-	list_for_each_entry(f, &sb->s_files, f_list) {
+	list_for_each_entry(f, &sb->s_files, f_u.fu_list) {
 		if (S_ISREG(f->f_dentry->d_inode->i_mode) && file_count(f))
 			f->f_mode &= ~FMODE_WRITE;
 	}
--- linux-2.6.14-rc2-orig/security/selinux/hooks.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2/security/selinux/hooks.c	2005-09-24 05:02:35.000000000 +0200
@@ -1599,7 +1599,7 @@
 
 	if (tty) {
 		file_list_lock();
-		file = list_entry(tty->tty_files.next, typeof(*file), f_list);
+		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
 		if (file) {
 			/* Revalidate access to controlling tty.
 			   Use inode_has_perm on the tty inode directly rather
--- linux-2.6.14-rc2-orig/security/selinux/selinuxfs.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2/security/selinux/selinuxfs.c	2005-09-24 05:02:35.000000000 +0200
@@ -924,7 +924,7 @@
 
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
-		struct file * filp = list_entry(p, struct file, f_list);
+		struct file * filp = list_entry(p, struct file, f_u.fu_list);
 		struct dentry * dentry = filp->f_dentry;
 
 		if (dentry->d_parent != de) {

--------------020609050205060202010605--
