Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271886AbRIDEAa>; Tue, 4 Sep 2001 00:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271887AbRIDEAW>; Tue, 4 Sep 2001 00:00:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12514 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271884AbRIDEAK>;
	Tue, 4 Sep 2001 00:00:10 -0400
Date: Tue, 4 Sep 2001 00:00:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: [RFD] readonly/read-write semantics
In-Reply-To: <Pine.LNX.4.31.0109031558050.15486-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.GSO.4.21.0109032211320.26423-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Jean-Marc Saffroy wrote:

> On Fri, 31 Aug 2001, Alexander Viro wrote:
> 
> > > In 2.4.9, I have encountered a strange condition while playing with file
> > > structs chained on a superblock list (sb->s_files) : some of them can have
> > > a NULL f_dentry pointer. The only case I found which can cause this is
> > > when fput is called and f_count drops to zero. Is that the only case ?
> >
> > Yes, it is, and yes, it's legitimate - code that scans that list should
> > (and in-tree one does) deal with such case.
> 
> AFAICT fput (and also dentry_open, BTW) nullifies f_dentry without any
> lock held, so code that scans the list (such as fs_may_remount_ro, I

/me looks at the code in question

Oh, shit.  Thanks for spotting.  Patch below should fix it.  BTW, there
was a similar problem in dquot.c.

Fix being: take the file off-list before we touch dentry/vfsmount in
any way.  BTW, file->f_vfsmnt is always non-NULL, ditto for inode->i_sb,
so I've removed bogus if from fput() and dentry_open().  Another thing
that was way overdue is removal of file_moveto() - I thought that we
had removed it back when loop.c fixes went into the tree (old loop.c
was the only user of that function).

See if the patch below looks sane, but keep in mind that it's completely
untested.

diff -urN S10-pre4/drivers/char/tty_io.c S10-pre4-files/drivers/char/tty_io.c
--- S10-pre4/drivers/char/tty_io.c	Thu Aug 16 20:05:46 2001
+++ S10-pre4-files/drivers/char/tty_io.c	Mon Sep  3 23:45:35 2001
@@ -442,8 +442,6 @@
 	file_list_lock();
 	for (l = tty->tty_files.next; l != &tty->tty_files; l = l->next) {
 		struct file * filp = list_entry(l, struct file, f_list);
-		if (!filp->f_dentry)
-			continue;
 		if (filp->f_dentry->d_inode->i_rdev == CONSOLE_DEV ||
 		    filp->f_dentry->d_inode->i_rdev == SYSCONS_DEV) {
 			cons_filp = filp;
diff -urN S10-pre4/fs/dquot.c S10-pre4-files/fs/dquot.c
--- S10-pre4/fs/dquot.c	Sun Sep  2 23:22:19 2001
+++ S10-pre4-files/fs/dquot.c	Mon Sep  3 23:48:10 2001
@@ -660,7 +660,6 @@
 static void add_dquot_ref(struct super_block *sb, short type)
 {
 	struct list_head *p;
-	struct inode *inode;
 
 	if (!sb->dq_op)
 		return;	/* nothing to do */
@@ -669,13 +668,15 @@
 	file_list_lock();
 	for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
 		struct file *filp = list_entry(p, struct file, f_list);
-		if (!filp->f_dentry)
-			continue;
-		inode = filp->f_dentry->d_inode;
+		struct inode *inode = filp->f_dentry->d_inode;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
+			struct vfsmount *mnt = mntget(file->f_vfsmnt);
+			struct dentry *dentry = dget(file->f_dentry);
 			file_list_unlock();
 			sb->dq_op->initialize(inode, type);
 			inode->i_flags |= S_QUOTA;
+			dput(dentry);
+			mntput(mnt);
 			/* As we may have blocked we had better restart... */
 			goto restart;
 		}
diff -urN S10-pre4/fs/file_table.c S10-pre4-files/fs/file_table.c
--- S10-pre4/fs/file_table.c	Thu Apr 19 23:46:42 2001
+++ S10-pre4-files/fs/file_table.c	Mon Sep  3 23:50:59 2001
@@ -107,18 +107,17 @@
 		if (file->f_op && file->f_op->release)
 			file->f_op->release(inode, file);
 		fops_put(file->f_op);
-		file->f_dentry = NULL;
-		file->f_vfsmnt = NULL;
 		if (file->f_mode & FMODE_WRITE)
 			put_write_access(inode);
-		dput(dentry);
-		if (mnt)
-			mntput(mnt);
 		file_list_lock();
+		file->f_dentry = NULL;
+		file->f_vfsmnt = NULL;
 		list_del(&file->f_list);
 		list_add(&file->f_list, &free_list);
 		files_stat.nr_free_files++;
 		file_list_unlock();
+		dput(dentry);
+		mntput(mnt);
 	}
 }
 
@@ -158,14 +157,6 @@
 	file_list_unlock();
 }
 
-void file_moveto(struct file *new, struct file *old)
-{
-	file_list_lock();
-	list_del(&new->f_list);
-	list_add(&new->f_list, &old->f_list);
-	file_list_unlock();
-}
-
 int fs_may_remount_ro(struct super_block *sb)
 {
 	struct list_head *p;
@@ -174,12 +165,7 @@
 	file_list_lock();
 	for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
 		struct file *file = list_entry(p, struct file, f_list);
-		struct inode *inode;
-
-		if (!file->f_dentry)
-			continue;
-
-		inode = file->f_dentry->d_inode;
+		struct inode *inode = file->f_dentry->d_inode;
 
 		/* File with pending delete? */
 		if (inode->i_nlink == 0)
diff -urN S10-pre4/fs/open.c S10-pre4-files/fs/open.c
--- S10-pre4/fs/open.c	Thu Aug 16 20:05:50 2001
+++ S10-pre4-files/fs/open.c	Mon Sep  3 23:44:49 2001
@@ -634,6 +634,7 @@
 {
 	struct file * f;
 	struct inode *inode;
+	static LIST_HEAD(kill_list);
 	int error;
 
 	error = -ENFILE;
@@ -654,8 +655,7 @@
 	f->f_pos = 0;
 	f->f_reada = 0;
 	f->f_op = fops_get(inode->i_fop);
-	if (inode->i_sb)
-		file_move(f, &inode->i_sb->s_files);
+	file_move(f, &inode->i_sb->s_files);
 	if (f->f_op && f->f_op->open) {
 		error = f->f_op->open(inode,f);
 		if (error)
@@ -669,6 +669,7 @@
 	fops_put(f->f_op);
 	if (f->f_mode & FMODE_WRITE)
 		put_write_access(inode);
+	file_move(f, &kill_list); /* out of the way.. */
 	f->f_dentry = NULL;
 	f->f_vfsmnt = NULL;
 cleanup_file:
diff -urN S10-pre4/fs/proc/generic.c S10-pre4-files/fs/proc/generic.c
--- S10-pre4/fs/proc/generic.c	Tue Jul  3 21:09:13 2001
+++ S10-pre4-files/fs/proc/generic.c	Mon Sep  3 23:50:23 2001
@@ -397,19 +397,18 @@
 	file_list_lock();
 	for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
 		struct file * filp = list_entry(p, struct file, f_list);
-		struct dentry * dentry;
+		struct dentry * dentry = filp->f_dentry;
 		struct inode * inode;
+		struct file_operations *fops;
 
-		dentry = filp->f_dentry;
-		if (!dentry)
-			continue;
 		if (dentry->d_op != &proc_dentry_operations)
 			continue;
 		inode = dentry->d_inode;
 		if (inode->u.generic_ip != de)
 			continue;
-		fops_put(filp->f_op);
+		fops = filp->f_op;
 		filp->f_op = NULL;
+		fops_put(fops);
 	}
 	file_list_unlock();
 }
diff -urN S10-pre4/include/linux/fs.h S10-pre4-files/include/linux/fs.h
--- S10-pre4/include/linux/fs.h	Mon Sep  3 17:38:27 2001
+++ S10-pre4-files/include/linux/fs.h	Mon Sep  3 23:50:55 2001
@@ -1297,7 +1297,6 @@
 extern void remove_inode_hash(struct inode *);
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
-extern void file_moveto(struct file *new, struct file *old);
 extern struct buffer_head * get_hash_table(kdev_t, int, int);
 extern struct buffer_head * getblk(kdev_t, int, int);
 extern void ll_rw_block(int, int, struct buffer_head * bh[]);
diff -urN S10-pre4/kernel/ksyms.c S10-pre4-files/kernel/ksyms.c
--- S10-pre4/kernel/ksyms.c	Sun Sep  2 23:22:20 2001
+++ S10-pre4-files/kernel/ksyms.c	Mon Sep  3 23:50:50 2001
@@ -307,7 +307,6 @@
 EXPORT_SYMBOL(refile_buffer);
 EXPORT_SYMBOL(max_sectors);
 EXPORT_SYMBOL(max_readahead);
-EXPORT_SYMBOL(file_moveto);
 
 /* tty routines */
 EXPORT_SYMBOL(tty_hangup);

