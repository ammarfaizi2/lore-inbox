Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031654AbWLARcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031654AbWLARcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031632AbWLARcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:32:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8618 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758823AbWLARcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:32:46 -0500
Date: Fri, 1 Dec 2006 12:21:36 -0500
From: Jeff Layton <jlayton@redhat.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent inode numbers (via idr)
Message-ID: <20061201172136.GA11669@dantu.rdu.redhat.com>
References: <457040C4.1000002@redhat.com> <20061201085227.2463b185.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201085227.2463b185.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 08:52:27AM -0800, Randy Dunlap wrote:

Thanks for having a look, Randy...

> s/idr_/iunique_/

Doh! Can you tell I cut and pasted this email from earlier ones? :-)

> > - don't attempt to remove inodes with values <100
> 
> Please explain that one.  (May be obvious to some, but not to me.)

Actually, we probably don't need to do that now. My thought here was to add
a low range of i_ino numbers that could be used by the filesystem code without
needing to call iunique (in particular for things like the root inode in the
filesystem). It's probably best to not do this though and let the filesystem
handle it on its own.

> Better to post patches inline (for review) rather than as attachments.

Here's an updated (but untested) patch based on your suggestions. I also went
ahead and made the exported symbols GPL-only since that seems like it would be
appropriate here. Any further thoughts on it?

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/inode.c b/fs/inode.c
index 26cdb11..e45cec9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -288,6 +288,8 @@ static void dispose_list(struct list_hea
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&inode_lock);
 
+		iunique_unregister(inode);
+
 		wake_up_inode(inode);
 		destroy_inode(inode);
 		nr_disposed++;
@@ -706,6 +708,32 @@ retry:
 
 EXPORT_SYMBOL(iunique);
 
+int iunique_register(struct inode *inode, int max_reserved)
+{
+	int rv;
+
+	rv = idr_pre_get(&inode->i_sb->s_inode_ids, GFP_KERNEL);
+	if (! rv)
+		return -ENOMEM;
+
+	spin_lock(&inode->i_sb->s_inode_ids_lock);
+	rv = idr_get_new_above(&inode->i_sb->s_inode_ids, inode,
+		max_reserved+1, (int *) &inode->i_ino);
+	inode->i_generation = inode->i_sb->s_generation++;
+	spin_unlock(&inode->i_sb->s_inode_ids_lock);
+	return rv;
+}
+EXPORT_SYMBOL_GPL(iunique_register);
+
+void iunique_unregister(struct inode *inode)
+{
+	spin_lock(&inode->i_sb->s_inode_ids_lock);
+	if (idr_find(&inode->i_sb->s_inode_ids, (int) inode->i_ino))
+		idr_remove(&inode->i_sb->s_inode_ids, (int) inode->i_ino);
+	spin_unlock(&inode->i_sb->s_inode_ids_lock);
+}
+EXPORT_SYMBOL_GPL(iunique_unregister);
+
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode_lock);
@@ -1025,6 +1053,7 @@ void generic_delete_inode(struct inode *
 	spin_lock(&inode_lock);
 	hlist_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
+	iunique_unregister(inode);
 	wake_up_inode(inode);
 	BUG_ON(inode->i_state != I_CLEAR);
 	destroy_inode(inode);
@@ -1057,6 +1086,7 @@ static void generic_forget_inode(struct 
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
+	iunique_unregister(inode);
 	if (inode->i_data.nrpages)
 		truncate_inode_pages(&inode->i_data, 0);
 	clear_inode(inode);
diff --git a/fs/pipe.c b/fs/pipe.c
index b1626f2..d74ae65 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -845,6 +845,9 @@ static struct inode * get_pipe_inode(voi
 	if (!inode)
 		goto fail_inode;
 
+	if (iunique_register(inode, 0))
+		goto fail_iput;
+
 	pipe = alloc_pipe_info(inode);
 	if (!pipe)
 		goto fail_iput;
diff --git a/fs/super.c b/fs/super.c
index 47e554c..d2dbdec 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -93,6 +93,8 @@ static struct super_block *alloc_super(s
 		s->s_qcop = sb_quotactl_ops;
 		s->s_op = &default_op;
 		s->s_time_gran = 1000000000;
+		idr_init(&s->s_inode_ids);
+		spin_lock_init(&s->s_inode_ids_lock);
 	}
 out:
 	return s;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2fe6e3f..3afb4a2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -278,6 +278,7 @@ #include <linux/prio_tree.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
+#include <linux/idr.h>
 
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
@@ -961,6 +962,12 @@ #endif
 	/* Granularity of c/m/atime in ns.
 	   Cannot be worse than a second */
 	u32		   s_time_gran;
+
+	/* for fs's with dynamic i_ino values, track them with idr, and increment
+	   the generation every time we register a new inode */
+	__u32			s_generation;
+	struct idr		s_inode_ids;
+	spinlock_t		s_inode_ids_lock;
 };
 
 extern struct timespec current_fs_time(struct super_block *sb);
@@ -1681,6 +1688,8 @@ extern void inode_init_once(struct inode
 extern void iput(struct inode *);
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
+extern int iunique_register(struct inode *inode, int max_reserved);
+extern void iunique_unregister(struct inode *inode);
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
 extern void generic_drop_inode(struct inode *inode);
