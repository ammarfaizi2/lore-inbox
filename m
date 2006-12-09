Return-Path: <linux-kernel-owner+w=401wt.eu-S1030671AbWLIMJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671AbWLIMJT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbWLIMJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:09:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55134 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030633AbWLIMJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:09:17 -0500
Message-ID: <457AA76C.70706@redhat.com>
Date: Sat, 09 Dec 2006 07:09:16 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ensure unique i_ino in filesystems without permanent
 inode numbers (new functions)
References: <457891EE.2070409@redhat.com>
In-Reply-To: <457891EE.2070409@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
 > This patch lays the groundwork for the other patches:
 >
 > - adds new superblock fields for the generation, IDR hash and its spinlock
 > - adds the new functions iunique_register and iunique_unregister
 > - makes the static counter in the old iunique function 32 bits
 >

Here is a respun patch. It's essentially the same as the earlier one, but
adds one more function new_registered_inode. After having started on some
filesystem conversions, it's become clear to me that it would be much
simpler to handle error conditions via a wrapper to new_inode that also
returns NULL if the iunique_register fails.

Signed-off-by: Jeff Layton <jlayton@redhat.com>


diff --git a/fs/inode.c b/fs/inode.c
index d00de18..d5a5b1e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -288,6 +288,7 @@ static void dispose_list(struct list_hea
  		list_del_init(&inode->i_sb_list);
  		spin_unlock(&inode_lock);

+		iunique_unregister(inode);
  		wake_up_inode(inode);
  		destroy_inode(inode);
  		nr_disposed++;
@@ -544,6 +545,20 @@ struct inode *new_inode(struct super_blo

  EXPORT_SYMBOL(new_inode);

+struct inode *new_registered_inode(struct super_block *sb, int max_reserved)
+{
+	struct inode *inode;
+
+	inode = new_inode(sb);
+	if (inode && iunique_register(inode, max_reserved)) {
+		iput(inode);
+		return NULL;
+	}
+
+	return inode;
+}
+EXPORT_SYMBOL(new_registered_inode);
+
  void unlock_new_inode(struct inode *inode)
  {
  	/*
@@ -675,7 +690,8 @@ static unsigned long hash(struct super_b
   *	Obtain an inode number that is unique on the system for a given
   *	superblock. This is used by file systems that have no natural
   *	permanent inode numbering system. An inode number is returned that
- *	is higher than the reserved limit but unique.
+ *	is higher than the reserved limit but unique. Note that this function
+ *	only works if the inodes are hashed.
   *
   *	BUGS:
   *	With a large number of inodes live on the file system this function
@@ -683,7 +699,7 @@ static unsigned long hash(struct super_b
   */
  ino_t iunique(struct super_block *sb, ino_t max_reserved)
  {
-	static ino_t counter;
+	static unsigned int counter;
  	struct inode *inode;
  	struct hlist_head * head;
  	ino_t res;
@@ -706,6 +722,52 @@ retry:

  EXPORT_SYMBOL(iunique);

+/**
+ *	iunique_register - assign an inode a unique inode number and insert it
+ *			   into the superblock's IDR hash.
+ *	@inode: inode
+ *	@max_reserved: highest reserved inode number
+ *
+ * For filesystems that pin their inodes in memory and don't bother hashing
+ * them, we need some way to ensure that their inode numbers are unique.
+ * These functions allow for up to 31 bits worth of unique inode numbers
+ * (since IDR works with signed ints). The inode number assigned will be
+ * greater than max_reserved and less than 2^31-1.
+ *
+ * Returns 0 on success and an error code on error.
+ */
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
+	inode->i_generation = ++inode->i_sb->s_generation;
+	spin_unlock(&inode->i_sb->s_inode_ids_lock);
+	return rv;
+}
+EXPORT_SYMBOL(iunique_register);
+
+/**
+ *	iunique_unregister - unregister an inode from the superblock's IDR hash
+ *	@inode: inode
+ */
+void iunique_unregister(struct inode *inode)
+{
+	if (inode->i_ino > MAX_ID_MASK)
+		return;
+	spin_lock(&inode->i_sb->s_inode_ids_lock);
+	if (idr_find(&inode->i_sb->s_inode_ids, (int) inode->i_ino))
+		idr_remove(&inode->i_sb->s_inode_ids, (int) inode->i_ino);
+	spin_unlock(&inode->i_sb->s_inode_ids_lock);
+}
+EXPORT_SYMBOL(iunique_unregister);
+
  struct inode *igrab(struct inode *inode)
  {
  	spin_lock(&inode_lock);
@@ -1025,6 +1087,7 @@ void generic_delete_inode(struct inode *
  	spin_lock(&inode_lock);
  	hlist_del_init(&inode->i_hash);
  	spin_unlock(&inode_lock);
+	iunique_unregister(inode);
  	wake_up_inode(inode);
  	BUG_ON(inode->i_state != I_CLEAR);
  	destroy_inode(inode);
@@ -1057,6 +1120,7 @@ static void generic_forget_inode(struct
  	inode->i_state |= I_FREEING;
  	inodes_stat.nr_inodes--;
  	spin_unlock(&inode_lock);
+	iunique_unregister(inode);
  	if (inode->i_data.nrpages)
  		truncate_inode_pages(&inode->i_data, 0);
  	clear_inode(inode);
diff --git a/fs/super.c b/fs/super.c
index f961e03..1d69f88 100644
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
@@ -106,6 +108,7 @@ out:
   */
  static inline void destroy_super(struct super_block *s)
  {
+	idr_destroy(&s->s_inode_ids);
  	security_sb_free(s);
  	kfree(s);
  }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index adce6e1..6c70f1a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -279,6 +279,7 @@ #include <linux/prio_tree.h>
  #include <linux/init.h>
  #include <linux/pid.h>
  #include <linux/mutex.h>
+#include <linux/idr.h>

  #include <asm/atomic.h>
  #include <asm/semaphore.h>
@@ -948,6 +949,12 @@ #endif
  	/* Granularity of c/m/atime in ns.
  	   Cannot be worse than a second */
  	u32		   s_time_gran;
+
+	/* for fs's with dynamic i_ino values, track them with idr, and
+	 * increment the generation every time we register a new inode */
+	__u32			s_generation;
+	struct idr		s_inode_ids;
+	spinlock_t		s_inode_ids_lock;
  };

  extern struct timespec current_fs_time(struct super_block *sb);
@@ -1645,6 +1652,8 @@ extern void inode_init_once(struct inode
  extern void iput(struct inode *);
  extern struct inode * igrab(struct inode *);
  extern ino_t iunique(struct super_block *, ino_t);
+extern int iunique_register(struct inode *inode, int max_reserved);
+extern void iunique_unregister(struct inode *inode);
  extern int inode_needs_sync(struct inode *inode);
  extern void generic_delete_inode(struct inode *inode);
  extern void generic_drop_inode(struct inode *inode);
@@ -1676,6 +1685,8 @@ extern void __iget(struct inode * inode)
  extern void clear_inode(struct inode *);
  extern void destroy_inode(struct inode *);
  extern struct inode *new_inode(struct super_block *);
+extern struct inode *new_registered_inode(struct super_block *sb,
+						int max_reserved);
  extern int __remove_suid(struct dentry *, int);
  extern int should_remove_suid(struct dentry *);
  extern int remove_suid(struct dentry *);
