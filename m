Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317266AbSFCE1u>; Mon, 3 Jun 2002 00:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317267AbSFCE1u>; Mon, 3 Jun 2002 00:27:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40199 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317266AbSFCE1q>; Mon, 3 Jun 2002 00:27:46 -0400
Date: Sun, 2 Jun 2002 21:27:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>, Alexander Viro <aviro@redhat.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] iput() cleanup (was Re: [patch 12/16] fix race between writeback
 and unlink)
In-Reply-To: <3CF91E48.C76B34FA@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206022119300.1030-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Jun 2002, Andrew Morton wrote:
>
> > Why not just split up the code inside iput(), and then just do
> >
> >         if (atomic_dec(&inode->i_count))
> >                 final_iput(inode);
>
> Yes, I suspect all the inode refcounting, locking, I_FREEING, I_LOCK, etc
> could do with a spring clean. Make it a bit more conventional.  I'll
> discuss with Al when he resurfaces.

This is a first cut at cleaning up "iput()" and getting rid of some of the
magic VFS-level behaviour of the i_nlink field which many filesystems do
not actually want - as shown by the number of "force_delete" users out
there.

It does not change any real behaviour, but it splits up the "iput()"
behaviour into several functions ("common_delete_inode()",
"common_forget_inode()" and "common_drop_inode()"), and adds a place for a
low-level filesystem to hook into the behaviour at inode drop time,
through the "drop_inode" superblock operation.

This part of the diff probably explains it best

+  drop_inode: called when the last access to the inode is dropped,
+       with the inode_lock spinlock held.
+
+       This method should be either NULL (normal unix filesystem
+       semantics) or "common_delete_inode" (for filesystems that do not
+       want to cache inodes - causing "delete_inode" to always be
+       called regardless of the value of i_nlink)
+
+       The "common_delete_inode()" behaviour is equivalent to the
+       old practice of using "force_delete" in the put_inode() case,
+       but does not have the races that the "force_delete()" approach
+       had.

This removes _most_ of the "put_inode()" users, although filesystems can
(and do) still use it for other things - notably to drop pre-allocations
etc.

Comments?

			Linus

----
===== Documentation/filesystems/Locking 1.29 vs edited =====
--- 1.29/Documentation/filesystems/Locking	Fri May 31 18:18:14 2002
+++ edited/Documentation/filesystems/Locking	Sun Jun  2 20:58:05 2002
@@ -88,6 +88,7 @@
 	void (*read_inode) (struct inode *);
 	void (*write_inode) (struct inode *, int);
 	void (*put_inode) (struct inode *);
+	void (*drop_inode) (struct inode *);
 	void (*delete_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
 	void (*write_super) (struct super_block *);
@@ -102,6 +103,7 @@
 read_inode:	yes				(see below)
 write_inode:	no
 put_inode:	no
+drop_inode:	no				!!!inode_lock!!!
 delete_inode:	no
 clear_inode:	no
 put_super:	yes	yes	maybe		(see below)
===== Documentation/filesystems/vfs.txt 1.1 vs edited =====
--- 1.1/Documentation/filesystems/vfs.txt	Tue Feb  5 09:40:36 2002
+++ edited/Documentation/filesystems/vfs.txt	Sun Jun  2 21:17:23 2002
@@ -178,6 +178,7 @@
 	void (*read_inode) (struct inode *);
 	void (*write_inode) (struct inode *, int);
 	void (*put_inode) (struct inode *);
+	void (*drop_inode) (struct inode *);
 	void (*delete_inode) (struct inode *);
 	int (*notify_change) (struct dentry *, struct iattr *);
 	void (*put_super) (struct super_block *);
@@ -203,6 +204,19 @@

   put_inode: called when the VFS inode is removed from the inode
 	cache. This method is optional
+
+  drop_inode: called when the last access to the inode is dropped,
+	with the inode_lock spinlock held.
+
+	This method should be either NULL (normal unix filesystem
+	semantics) or "common_delete_inode" (for filesystems that do not
+	want to cache inodes - causing "delete_inode" to always be
+	called regardless of the value of i_nlink)
+
+	The "common_delete_inode()" behaviour is equivalent to the
+	old practice of using "force_delete" in the put_inode() case,
+	but does not have the races that the "force_delete()" approach
+	had.

   delete_inode: called when the VFS wants to delete an inode

===== drivers/hotplug/pci_hotplug_core.c 1.14 vs edited =====
--- 1.14/drivers/hotplug/pci_hotplug_core.c	Thu May  9 13:44:41 2002
+++ edited/drivers/hotplug/pci_hotplug_core.c	Sun Jun  2 20:12:36 2002
@@ -290,7 +290,7 @@

 static struct super_operations pcihpfs_ops = {
 	statfs:		simple_statfs,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 };

 static int pcihpfs_fill_super(struct super_block *sb, void *data, int silent)
===== drivers/usb/core/inode.c 1.31 vs edited =====
--- 1.31/drivers/usb/core/inode.c	Wed May 22 09:25:48 2002
+++ edited/drivers/usb/core/inode.c	Sun Jun  2 20:13:58 2002
@@ -298,7 +298,7 @@

 static struct super_operations usbfs_ops = {
 	statfs:		simple_statfs,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 };

 static int usbfs_fill_super(struct super_block *sb, void *data, int silent)
===== fs/binfmt_misc.c 1.13 vs edited =====
--- 1.13/fs/binfmt_misc.c	Thu May 23 09:08:34 2002
+++ edited/fs/binfmt_misc.c	Sun Jun  2 19:48:46 2002
@@ -621,7 +621,7 @@

 static struct super_operations s_ops = {
 	statfs:		simple_statfs,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 	clear_inode:	bm_clear_inode,
 };

===== fs/inode.c 1.60 vs edited =====
--- 1.60/fs/inode.c	Fri May 31 18:18:09 2002
+++ edited/fs/inode.c	Sun Jun  2 20:11:02 2002
@@ -782,6 +782,97 @@
 	spin_unlock(&inode_lock);
 }

+void common_delete_inode(struct inode *inode)
+{
+	struct super_operations *op = inode->i_sb->s_op;
+
+	list_del(&inode->i_hash);
+	INIT_LIST_HEAD(&inode->i_hash);
+	list_del(&inode->i_list);
+	INIT_LIST_HEAD(&inode->i_list);
+	inode->i_state|=I_FREEING;
+	inodes_stat.nr_inodes--;
+	spin_unlock(&inode_lock);
+
+	if (inode->i_data.nrpages)
+		truncate_inode_pages(&inode->i_data, 0);
+
+	if (op && op->delete_inode) {
+		void (*delete)(struct inode *) = op->delete_inode;
+		if (!is_bad_inode(inode))
+			DQUOT_INIT(inode);
+		/* s_op->delete_inode internally recalls clear_inode() */
+		delete(inode);
+	} else
+		clear_inode(inode);
+	if (inode->i_state != I_CLEAR)
+		BUG();
+	destroy_inode(inode);
+}
+EXPORT_SYMBOL(common_delete_inode);
+
+static void common_forget_inode(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+
+	if (!list_empty(&inode->i_hash)) {
+		if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
+			list_del(&inode->i_list);
+			list_add(&inode->i_list, &inode_unused);
+		}
+		inodes_stat.nr_unused++;
+		spin_unlock(&inode_lock);
+		if (!sb || (sb->s_flags & MS_ACTIVE))
+			return;
+		write_inode_now(inode, 1);
+		spin_lock(&inode_lock);
+		inodes_stat.nr_unused--;
+		list_del_init(&inode->i_hash);
+	}
+	list_del_init(&inode->i_list);
+	inode->i_state|=I_FREEING;
+	inodes_stat.nr_inodes--;
+	spin_unlock(&inode_lock);
+	if (inode->i_data.nrpages)
+		truncate_inode_pages(&inode->i_data, 0);
+	clear_inode(inode);
+	destroy_inode(inode);
+}
+
+/*
+ * Normal UNIX filesystem behaviour: delete the
+ * inode when the usage count drops to zero, and
+ * i_nlink is zero.
+ */
+static void common_drop_inode(struct inode *inode)
+{
+	if (!inode->i_nlink)
+		common_delete_inode(inode);
+	else
+		common_forget_inode(inode);
+}
+
+/*
+ * Called when we're dropping the last reference
+ * to an inode.
+ *
+ * Call the FS "drop()" function, defaulting to
+ * the legacy UNIX filesystem behaviour..
+ *
+ * NOTE! NOTE! NOTE! We're called with the inode lock
+ * held, and the drop function is supposed to release
+ * the lock!
+ */
+static inline void iput_final(struct inode *inode)
+{
+	struct super_operations *op = inode->i_sb->s_op;
+	void (*drop)(struct inode *) = common_drop_inode;
+
+	if (op && op->drop_inode)
+		drop = op->drop_inode;
+	drop(inode);
+}
+
 /**
  *	iput	- put an inode
  *	@inode: inode to put
@@ -793,77 +884,17 @@
 void iput(struct inode *inode)
 {
 	if (inode) {
-		struct super_block *sb = inode->i_sb;
-		struct super_operations *op = NULL;
+		struct super_operations *op = inode->i_sb->s_op;

 		if (inode->i_state == I_CLEAR)
 			BUG();

-		if (sb && sb->s_op)
-			op = sb->s_op;
 		if (op && op->put_inode)
 			op->put_inode(inode);

-		if (!atomic_dec_and_lock(&inode->i_count, &inode_lock))
-			return;
-
-		if (!inode->i_nlink) {
-			list_del(&inode->i_hash);
-			INIT_LIST_HEAD(&inode->i_hash);
-			list_del(&inode->i_list);
-			INIT_LIST_HEAD(&inode->i_list);
-			inode->i_state|=I_FREEING;
-			inodes_stat.nr_inodes--;
-			spin_unlock(&inode_lock);
-
-			if (inode->i_data.nrpages)
-				truncate_inode_pages(&inode->i_data, 0);
-
-			if (op && op->delete_inode) {
-				void (*delete)(struct inode *) = op->delete_inode;
-				if (!is_bad_inode(inode))
-					DQUOT_INIT(inode);
-				/* s_op->delete_inode internally recalls clear_inode() */
-				delete(inode);
-			} else
-				clear_inode(inode);
-			if (inode->i_state != I_CLEAR)
-				BUG();
-		} else {
-			if (!list_empty(&inode->i_hash)) {
-				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
-					list_del(&inode->i_list);
-					list_add(&inode->i_list, &inode_unused);
-				}
-				inodes_stat.nr_unused++;
-				spin_unlock(&inode_lock);
-				if (!sb || (sb->s_flags & MS_ACTIVE))
-					return;
-				write_inode_now(inode, 1);
-				spin_lock(&inode_lock);
-				inodes_stat.nr_unused--;
-				list_del_init(&inode->i_hash);
-			}
-			list_del_init(&inode->i_list);
-			inode->i_state|=I_FREEING;
-			inodes_stat.nr_inodes--;
-			spin_unlock(&inode_lock);
-			if (inode->i_data.nrpages)
-				truncate_inode_pages(&inode->i_data, 0);
-			clear_inode(inode);
-		}
-		destroy_inode(inode);
+		if (atomic_dec_and_lock(&inode->i_count, &inode_lock))
+			iput_final(inode);
 	}
-}
-
-void force_delete(struct inode *inode)
-{
-	/*
-	 * Kill off unused inodes ... iput() will unhash and
-	 * delete the inode if we set i_nlink to zero.
-	 */
-	if (atomic_read(&inode->i_count) == 1)
-		inode->i_nlink = 0;
 }

 /**
===== fs/devfs/base.c 1.39 vs edited =====
--- 1.39/fs/devfs/base.c	Tue May 14 09:27:48 2002
+++ edited/fs/devfs/base.c	Sun Jun  2 20:15:00 2002
@@ -2576,7 +2576,7 @@

 static struct super_operations devfs_sops =
 {
-    put_inode:     force_delete,
+    drop_inode:    common_delete_inode,
     clear_inode:   devfs_clear_inode,
     statfs:        simple_statfs,
 };
===== fs/driverfs/inode.c 1.22 vs edited =====
--- 1.22/fs/driverfs/inode.c	Fri May 31 18:18:10 2002
+++ edited/fs/driverfs/inode.c	Sun Jun  2 19:49:16 2002
@@ -442,7 +442,7 @@

 static struct super_operations driverfs_ops = {
 	statfs:		simple_statfs,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 };

 static int driverfs_fill_super(struct super_block *sb, void *data, int silent)
===== fs/ncpfs/inode.c 1.19 vs edited =====
--- 1.19/fs/ncpfs/inode.c	Thu May 23 09:08:34 2002
+++ edited/fs/ncpfs/inode.c	Sun Jun  2 20:14:34 2002
@@ -84,7 +84,7 @@
 {
 	alloc_inode:	ncp_alloc_inode,
 	destroy_inode:	ncp_destroy_inode,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 	delete_inode:	ncp_delete_inode,
 	put_super:	ncp_put_super,
 	statfs:		ncp_statfs,
===== fs/proc/inode.c 1.13 vs edited =====
--- 1.13/fs/proc/inode.c	Mon May 20 06:38:28 2002
+++ edited/fs/proc/inode.c	Sun Jun  2 19:59:25 2002
@@ -121,7 +121,7 @@
 	alloc_inode:	proc_alloc_inode,
 	destroy_inode:	proc_destroy_inode,
 	read_inode:	proc_read_inode,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 	delete_inode:	proc_delete_inode,
 	statfs:		simple_statfs,
 };
===== fs/ramfs/inode.c 1.19 vs edited =====
--- 1.19/fs/ramfs/inode.c	Fri May 31 18:18:10 2002
+++ edited/fs/ramfs/inode.c	Sun Jun  2 19:59:56 2002
@@ -277,7 +277,7 @@

 static struct super_operations ramfs_ops = {
 	statfs:		simple_statfs,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 };

 static int ramfs_fill_super(struct super_block * sb, void * data, int silent)
===== fs/smbfs/inode.c 1.23 vs edited =====
--- 1.23/fs/smbfs/inode.c	Thu May 23 09:08:34 2002
+++ edited/fs/smbfs/inode.c	Sun Jun  2 20:14:19 2002
@@ -94,7 +94,7 @@
 {
 	alloc_inode:	smb_alloc_inode,
 	destroy_inode:	smb_destroy_inode,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 	delete_inode:	smb_delete_inode,
 	put_super:	smb_put_super,
 	statfs:		smb_statfs,
===== include/linux/fs.h 1.131 vs edited =====
--- 1.131/include/linux/fs.h	Fri May 31 18:18:14 2002
+++ edited/include/linux/fs.h	Sun Jun  2 20:49:29 2002
@@ -800,6 +800,7 @@
    	void (*dirty_inode) (struct inode *);
 	void (*write_inode) (struct inode *, int);
 	void (*put_inode) (struct inode *);
+	void (*drop_inode) (struct inode *);
 	void (*delete_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
 	void (*write_super) (struct super_block *);
@@ -1183,10 +1184,10 @@

 extern void inode_init_once(struct inode *);
 extern void iput(struct inode *);
-extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
 extern int inode_needs_sync(struct inode *inode);
+extern void common_delete_inode(struct inode *inode);

 extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);
===== kernel/ksyms.c 1.95 vs edited =====
--- 1.95/kernel/ksyms.c	Fri May 31 18:18:10 2002
+++ edited/kernel/ksyms.c	Sun Jun  2 19:39:17 2002
@@ -140,7 +140,6 @@
 EXPORT_SYMBOL(iunique);
 EXPORT_SYMBOL(iput);
 EXPORT_SYMBOL(inode_init_once);
-EXPORT_SYMBOL(force_delete);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(lookup_mnt);
===== mm/shmem.c 1.52 vs edited =====
--- 1.52/mm/shmem.c	Fri May 31 18:18:13 2002
+++ edited/mm/shmem.c	Sun Jun  2 19:46:02 2002
@@ -1483,7 +1483,7 @@
 	remount_fs:	shmem_remount_fs,
 #endif
 	delete_inode:	shmem_delete_inode,
-	put_inode:	force_delete,
+	drop_inode:	common_delete_inode,
 	put_super:	shmem_put_super,
 };


