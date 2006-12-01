Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936514AbWLAOsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936514AbWLAOsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936517AbWLAOsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:48:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935687AbWLAOsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:48:43 -0500
Message-ID: <457040C4.1000002@redhat.com>
Date: Fri, 01 Dec 2006 09:48:36 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent
 inode numbers (via idr)
Content-Type: multipart/mixed;
 boundary="------------090005000601060007000607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090005000601060007000607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch is a proof of concept. It works, but still needs a bit of
polish before it's ready for submission. First, the problems:

1) on filesystems w/o permanent inode numbers, i_ino values can be
larger than 32 bits, which can cause problems for some 32 bit userspace
programs on a 64 bit kernel.

2) many filesystems call new_inode and assume that the i_ino values they
are given are unique. They are not guaranteed to be so, since the static
counter can wrap.

3) after allocating a new inode, some filesystems call iunique to try to
get a unique i_ino value, but they don't actually add their inodes to
the hashtable, so they're still not guaranteed to be unique.

This patch is a first step at correcting these problems. This adds 2 new
functions, an idr_register and idr_unregister. Filesystems can call
idr_register at inode creation time, and then at deletion time, we'll
automatically unregister them.

This patch also adds a new s_generation counter to the superblock.
Because i_ino's can be reused so quickly, we don't want NFS getting
confused when it happens. When iunique_register is called, we'll assign
the s_generation value to the i_generation, and then increment it to
help ensure that we get different filehandles.

There are some things that need to be cleaned up, of course:

- error handling for the idr calls

- recheck all the possible places where the inode should be unhashed

- don't attempt to remove inodes with values <100

- convert other filesystems

- remove the static counter from new_inode and (maybe) eliminate iunique

The patch also converts pipefs to use the new scheme as an example. Al
Viro had expressed some concern with an earlier patch that this might
slow down pipe creation. I've done some testing and I think the impact
will be minimal. Timing a small program that creates and closes 100
million pipes in a loop:

patched:
-------------
real    8m8.623s
user    0m37.418s
sys     7m31.196s

unpatched:
--------------
real    8m7.150s
user    0m40.943s
sys     7m26.204s

As the number of pipes grows on the system, this time may grow somewhat
but it doesn't seem like it would be terrible.

Comments and suggestions appreciated.

Signed-off-by: Jeff Layton <jlayton@redhat.com>



--------------090005000601060007000607
Content-Type: text/x-patch;
 name="idr_register.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idr_register.patch"

diff --git a/fs/inode.c b/fs/inode.c
index 26cdb11..841e2fc 100644
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
@@ -706,6 +708,34 @@ retry:
 
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
+
+EXPORT_SYMBOL(iunique_register);
+
+void iunique_unregister(struct inode *inode)
+{
+	spin_lock(&inode->i_sb->s_inode_ids_lock);
+	if (idr_find(&inode->i_sb->s_inode_ids, (int) inode->i_ino))
+		idr_remove(&inode->i_sb->s_inode_ids, (int) inode->i_ino);
+	spin_unlock(&inode->i_sb->s_inode_ids_lock);
+}
+
+EXPORT_SYMBOL(iunique_unregister);
+
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode_lock);
@@ -1025,6 +1055,7 @@ void generic_delete_inode(struct inode *
 	spin_lock(&inode_lock);
 	hlist_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
+	iunique_unregister(inode);
 	wake_up_inode(inode);
 	BUG_ON(inode->i_state != I_CLEAR);
 	destroy_inode(inode);
@@ -1057,6 +1088,7 @@ static void generic_forget_inode(struct 
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
index 2fe6e3f..3ad12a6 100644
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
+extern int iunique_register(struct inode *, int);
+extern void iunique_unregister(struct inode *);
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
 extern void generic_drop_inode(struct inode *inode);


--------------090005000601060007000607--
