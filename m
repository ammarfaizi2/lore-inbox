Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161981AbWLAVnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161981AbWLAVnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161977AbWLAVnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:43:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55945 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S967718AbWLAVnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:43:05 -0500
Message-ID: <4570A1E4.3070206@redhat.com>
Date: Fri, 01 Dec 2006 16:43:00 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: randy.dunlap@oracle.com
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent
 inode numbers (via idr hashing)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again, Randy. Here's an updated and tested patch and description. 
This
one also makes sure that the root inode for the mount gets a unique 
i_ino value
as well. Let me know what you think...

--------------[snip]-----------

This patch is a proof of concept. It works, but I'd like to get some buyin
on the approach before I start doing the legwork to convert all of
the existing filesystems to use it. First, the problems:

1) on filesystems w/o permanent inode numbers, i_ino values can be
larger than 32 bits, which can cause problems for some 32 bit userspace
programs on a 64 bit kernel.

2) many filesystems call new_inode and assume that the i_ino values they
are given are unique. They are not guaranteed to be so, since the static
counter can wrap.

3) after allocating a new inode, some filesystems call iunique to try to
get a unique i_ino value, but they don't actually add their inodes to
the hashtable, and so they're still not guaranteed to be unique.

One way to fix this would be to just make sure they all use iunique and hash
their inodes, but that might slow down lookups for filesystems whose inodes
are not pinned in memory.

This patch is one way to correct these problems. This adds 2 new
functions, an iunique_register and iunique_unregister. Filesystems can call
iunique_register at inode creation time, and then at deletion time, we'll
automatically unregister them.

This patch also adds a new s_generation counter to the superblock.
Because i_ino's can be reused so quickly, we don't want NFS getting
confused when it happens. When iunique_register is called, we'll assign
the s_generation value to the i_generation, and then increment it to
help ensure that we get different filehandles.

There are some things that need to be cleaned up, of course:

- better error handling for the iunique calls

- recheck all the possible places where the inode should be unhashed

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

As the number of pipes grows on the system this time may grow somewhat,
but it doesn't seem like it would be terrible.

Comments and suggestions appreciated.

Signed-off-by: Jeff Layton <jlayton@redhat.com>


diff --git a/fs/inode.c b/fs/inode.c
index 26cdb11..252192a 100644
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
+	if (!rv)
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
index b1626f2..74dbbf0 100644
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
@@ -998,7 +1001,16 @@ static int pipefs_get_sb(struct file_sys
  			 int flags, const char *dev_name, void *data,
  			 struct vfsmount *mnt)
  {
-	return get_sb_pseudo(fs_type, "pipe:", NULL, PIPEFS_MAGIC, mnt);
+	int error;
+
+	error = get_sb_pseudo(fs_type, "pipe:", NULL, PIPEFS_MAGIC, mnt);
+	if (!error)
+		error = iunique_register(mnt->mnt_root->d_inode, 0);
+	if (error) {
+		up_write(&mnt->mnt_sb->s_umount);
+		deactivate_super(mnt->mnt_sb);
+	}
+	return error;
  }

  static struct file_system_type pipe_fs_type = {
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
