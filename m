Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316993AbSFAIlc>; Sat, 1 Jun 2002 04:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSFAIkr>; Sat, 1 Jun 2002 04:40:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47882 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315417AbSFAIjC>;
	Sat, 1 Jun 2002 04:39:02 -0400
Message-ID: <3CF888ED.C7D4F01D@zip.com.au>
Date: Sat, 01 Jun 2002 01:42:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [patch 7/16] remove inode.i_wait
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove i_wait from struct inode and hash it instead.

This is a pure space-saving exercise - 12 bytes from struct
inode on x86.

NFS was using i_wait for its own purposes.  Add a wait_queue_head_t to
the fs-private inode for that.  This change has been acked by Trond.



=====================================

--- 2.5.19/fs/inode.c~hash-i_wait	Sat Jun  1 01:18:09 2002
+++ 2.5.19-akpm/fs/inode.c	Sat Jun  1 01:18:09 2002
@@ -14,6 +14,9 @@
 #include <linux/writeback.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
+#include <linux/wait.h>
+#include <linux/hash.h>
+
 /*
  * This is needed for the following functions:
  *  - inode_has_buffers
@@ -149,7 +152,6 @@ static void destroy_inode(struct inode *
 void inode_init_once(struct inode *inode)
 {
 	memset(inode, 0, sizeof(*inode));
-	init_waitqueue_head(&inode->i_wait);
 	INIT_LIST_HEAD(&inode->i_hash);
 	INIT_LIST_HEAD(&inode->i_data.clean_pages);
 	INIT_LIST_HEAD(&inode->i_data.dirty_pages);
@@ -176,21 +178,6 @@ static void init_once(void * foo, kmem_c
 		inode_init_once(inode);
 }
 
-void __wait_on_inode(struct inode * inode)
-{
-	DECLARE_WAITQUEUE(wait, current);
-
-	add_wait_queue(&inode->i_wait, &wait);
-repeat:
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (inode->i_state & I_LOCK) {
-		schedule();
-		goto repeat;
-	}
-	remove_wait_queue(&inode->i_wait, &wait);
-	current->state = TASK_RUNNING;
-}
-
 /*
  * inode_lock must be held
  */
@@ -538,7 +525,7 @@ void unlock_new_inode(struct inode *inod
 	 * that haven't tested I_LOCK).
 	 */
 	inode->i_state &= ~(I_LOCK|I_NEW);
-	wake_up(&inode->i_wait);
+	wake_up_inode(inode);
 }
 
 
@@ -899,59 +886,6 @@ int bmap(struct inode * inode, int block
 	return res;
 }
 
-/*
- * Initialize the hash tables.
- */
-void __init inode_init(unsigned long mempages)
-{
-	struct list_head *head;
-	unsigned long order;
-	unsigned int nr_hash;
-	int i;
-
-	mempages >>= (14 - PAGE_SHIFT);
-	mempages *= sizeof(struct list_head);
-	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
-		;
-
-	do {
-		unsigned long tmp;
-
-		nr_hash = (1UL << order) * PAGE_SIZE /
-			sizeof(struct list_head);
-		i_hash_mask = (nr_hash - 1);
-
-		tmp = nr_hash;
-		i_hash_shift = 0;
-		while ((tmp >>= 1UL) != 0UL)
-			i_hash_shift++;
-
-		inode_hashtable = (struct list_head *)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while (inode_hashtable == NULL && --order >= 0);
-
-	printk("Inode-cache hash table entries: %d (order: %ld, %ld bytes)\n",
-			nr_hash, order, (PAGE_SIZE << order));
-
-	if (!inode_hashtable)
-		panic("Failed to allocate inode hash table\n");
-
-	head = inode_hashtable;
-	i = nr_hash;
-	do {
-		INIT_LIST_HEAD(head);
-		head++;
-		i--;
-	} while (i);
-
-	/* inode slab cache */
-	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
-					 0, SLAB_HWCACHE_ALIGN, init_once,
-					 NULL);
-	if (!inode_cachep)
-		panic("cannot create inode slab cache");
-}
-
 static inline void do_atime_update(struct inode *inode)
 {
 	unsigned long time = CURRENT_TIME;
@@ -1044,3 +978,104 @@ void remove_dquot_ref(struct super_block
 }
 
 #endif
+
+/*
+ * Hashed waitqueues for wait_on_inode().  The table is pretty small - the
+ * kernel doesn't lock many inodes at the same time.
+ */
+#define I_WAIT_TABLE_ORDER	3
+static struct i_wait_queue_head {
+	wait_queue_head_t wqh;
+} ____cacheline_aligned_in_smp i_wait_queue_heads[1<<I_WAIT_TABLE_ORDER];
+
+/*
+ * Return the address of the waitqueue_head to be used for this inode
+ */
+static wait_queue_head_t *i_waitq_head(struct inode *inode)
+{
+	return &i_wait_queue_heads[hash_ptr(inode, I_WAIT_TABLE_ORDER)].wqh;
+}
+
+void __wait_on_inode(struct inode *inode)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	wait_queue_head_t *wq = i_waitq_head(inode);
+
+	add_wait_queue(wq, &wait);
+repeat:
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	if (inode->i_state & I_LOCK) {
+		schedule();
+		goto repeat;
+	}
+	remove_wait_queue(wq, &wait);
+	current->state = TASK_RUNNING;
+}
+
+void wake_up_inode(struct inode *inode)
+{
+	wait_queue_head_t *wq = i_waitq_head(inode);
+
+	/*
+	 * Prevent speculative execution through spin_unlock(&inode_lock);
+	 */
+	smp_mb();
+	if (waitqueue_active(wq))
+		wake_up_all(wq);
+}
+
+/*
+ * Initialize the waitqueues and inode hash table.
+ */
+void __init inode_init(unsigned long mempages)
+{
+	struct list_head *head;
+	unsigned long order;
+	unsigned int nr_hash;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
+		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
+
+	mempages >>= (14 - PAGE_SHIFT);
+	mempages *= sizeof(struct list_head);
+	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
+		;
+
+	do {
+		unsigned long tmp;
+
+		nr_hash = (1UL << order) * PAGE_SIZE /
+			sizeof(struct list_head);
+		i_hash_mask = (nr_hash - 1);
+
+		tmp = nr_hash;
+		i_hash_shift = 0;
+		while ((tmp >>= 1UL) != 0UL)
+			i_hash_shift++;
+
+		inode_hashtable = (struct list_head *)
+			__get_free_pages(GFP_ATOMIC, order);
+	} while (inode_hashtable == NULL && --order >= 0);
+
+	printk("Inode-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+			nr_hash, order, (PAGE_SIZE << order));
+
+	if (!inode_hashtable)
+		panic("Failed to allocate inode hash table\n");
+
+	head = inode_hashtable;
+	i = nr_hash;
+	do {
+		INIT_LIST_HEAD(head);
+		head++;
+		i--;
+	} while (i);
+
+	/* inode slab cache */
+	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
+					 0, SLAB_HWCACHE_ALIGN, init_once,
+					 NULL);
+	if (!inode_cachep)
+		panic("cannot create inode slab cache");
+}
--- 2.5.19/include/linux/writeback.h~hash-i_wait	Sat Jun  1 01:18:09 2002
+++ 2.5.19-akpm/include/linux/writeback.h	Sat Jun  1 01:18:09 2002
@@ -31,6 +31,7 @@ static inline int current_is_pdflush(voi
 
 void writeback_unlocked_inodes(int *nr_to_write, int sync_mode,
 				unsigned long *older_than_this);
+void wake_up_inode(struct inode *inode);
 void __wait_on_inode(struct inode * inode);
 void sync_inodes_sb(struct super_block *, int wait);
 void sync_inodes(int wait);
--- 2.5.19/fs/fs-writeback.c~hash-i_wait	Sat Jun  1 01:18:09 2002
+++ 2.5.19-akpm/fs/fs-writeback.c	Sat Jun  1 01:18:09 2002
@@ -176,8 +176,7 @@ static void __sync_single_inode(struct i
 			}
 		}
 	}
-	if (waitqueue_active(&inode->i_wait))
-		wake_up(&inode->i_wait);
+	wake_up_inode(inode);
 }
 
 /*
--- 2.5.19/include/linux/fs.h~hash-i_wait	Sat Jun  1 01:18:09 2002
+++ 2.5.19-akpm/include/linux/fs.h	Sat Jun  1 01:18:09 2002
@@ -383,7 +383,6 @@ struct inode {
 	struct inode_operations	*i_op;
 	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
 	struct super_block	*i_sb;
-	wait_queue_head_t	i_wait;
 	struct file_lock	*i_flock;
 	struct address_space	*i_mapping;
 	struct address_space	i_data;
--- 2.5.19/fs/nfs/inode.c~hash-i_wait	Sat Jun  1 01:18:09 2002
+++ 2.5.19-akpm/fs/nfs/inode.c	Sat Jun  1 01:18:09 2002
@@ -799,11 +799,14 @@ int
 nfs_wait_on_inode(struct inode *inode, int flag)
 {
 	struct rpc_clnt	*clnt = NFS_CLIENT(inode);
+	struct nfs_inode *nfsi = NFS_I(inode);
+
 	int error;
 	if (!(NFS_FLAGS(inode) & flag))
 		return 0;
 	atomic_inc(&inode->i_count);
-	error = nfs_wait_event(clnt, inode->i_wait, !(NFS_FLAGS(inode) & flag));
+	error = nfs_wait_event(clnt, nfsi->nfs_i_wait,
+				!(NFS_FLAGS(inode) & flag));
 	iput(inode);
 	return error;
 }
@@ -922,7 +925,7 @@ __nfs_revalidate_inode(struct nfs_server
 	NFS_FLAGS(inode) &= ~NFS_INO_STALE;
 out:
 	NFS_FLAGS(inode) &= ~NFS_INO_REVALIDATING;
-	wake_up(&inode->i_wait);
+	wake_up(&NFS_I(inode)->nfs_i_wait);
  out_nowait:
 	unlock_kernel();
 	return status;
@@ -1258,6 +1261,7 @@ static void init_once(void * foo, kmem_c
 		nfsi->ndirty = 0;
 		nfsi->ncommit = 0;
 		nfsi->npages = 0;
+		init_waitqueue_head(&nfsi->nfs_i_wait);
 	}
 }
  
--- 2.5.19/include/linux/nfs_fs.h~hash-i_wait	Sat Jun  1 01:18:09 2002
+++ 2.5.19-akpm/include/linux/nfs_fs.h	Sat Jun  1 01:18:09 2002
@@ -13,6 +13,7 @@
 #include <linux/in.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/wait.h>
 
 #include <linux/nfs_fs_sb.h>
 
@@ -159,6 +160,8 @@ struct nfs_inode {
 	/* Credentials for shared mmap */
 	struct rpc_cred		*mm_cred;
 
+	wait_queue_head_t	nfs_i_wait;
+
 	struct inode		vfs_inode;
 };
 

-
