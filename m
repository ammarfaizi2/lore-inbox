Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVLLXu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVLLXu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVLLXuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:50:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57763 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932277AbVLLXqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:52 -0500
Date: Mon, 12 Dec 2005 23:45:48 GMT
Message-Id: <200512122345.jBCNjmHj009051@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 13/19] MUTEX: Filesystem changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the filesystem files to use the new mutex
functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-fs-2615rc5.diff
 fs/9p/trans_fd.c           |    4 ++--
 fs/9p/trans_sock.c         |    8 ++++----
 fs/9p/transport.h          |    4 ++--
 fs/9p/v9fs.h               |    2 +-
 fs/affs/affs.h             |    6 +++---
 fs/autofs4/autofs_i.h      |    2 +-
 fs/block_dev.c             |    4 ++--
 fs/cifs/cifsglob.h         |    8 ++++----
 fs/cramfs/inode.c          |    2 +-
 fs/dquot.c                 |    2 +-
 fs/eventpoll.c             |    4 ++--
 fs/fuse/dev.c              |   10 +++++-----
 fs/fuse/fuse_i.h           |    2 +-
 fs/hfs/btree.h             |    2 +-
 fs/hfs/hfs_fs.h            |    4 ++--
 fs/hfsplus/hfsplus_fs.h    |    4 ++--
 fs/hpfs/hpfs_fn.h          |    6 +++---
 fs/inode.c                 |    4 ++--
 fs/inotify.c               |    4 ++--
 fs/isofs/compress.c        |    2 +-
 fs/jffs/inode-v23.c        |    2 +-
 fs/jffs/intrep.c           |    2 +-
 fs/jffs/jffs_fm.h          |    2 +-
 fs/jfs/jfs_dmap.h          |    2 +-
 fs/jfs/jfs_imap.h          |    4 ++--
 fs/jfs/jfs_incore.h        |    2 +-
 fs/jfs/jfs_logmgr.h        |    2 +-
 fs/libfs.c                 |    2 +-
 fs/lockd/svc.c             |    7 ++++---
 fs/locks.c                 |    2 +-
 fs/nfs/idmap.c             |    4 ++--
 fs/ntfs/inode.h            |    6 +++---
 fs/ntfs/ntfs.h             |    2 +-
 fs/partitions/devfs.c      |    4 ++--
 fs/reiserfs/journal.c      |    8 ++++----
 fs/reiserfs/xattr.c        |    2 +-
 fs/seq_file.c              |    2 +-
 fs/super.c                 |    8 ++++----
 fs/sysfs/file.c            |    4 ++--
 fs/xfs/linux-2.6/mutex.h   |    8 ++++----
 fs/xfs/linux-2.6/sema.h    |    2 +-
 fs/xfs/linux-2.6/xfs_buf.h |    4 ++--
 42 files changed, 83 insertions(+), 82 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/9p/trans_fd.c linux-2.6.15-rc5-mutex/fs/9p/trans_fd.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/9p/trans_fd.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/9p/trans_fd.c	2005-12-12 19:58:04.000000000 +0000
@@ -106,8 +106,8 @@ v9fs_fd_init(struct v9fs_session_info *v
 		return -ENOPROTOOPT;
 	}
 
-	sema_init(&trans->writelock, 1);
-	sema_init(&trans->readlock, 1);
+	init_MUTEX(&trans->writelock);
+	init_MUTEX(&trans->readlock);
 
 	ts = kmalloc(sizeof(struct v9fs_trans_fd), GFP_KERNEL);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/9p/transport.h linux-2.6.15-rc5-mutex/fs/9p/transport.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/9p/transport.h	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/9p/transport.h	2005-12-12 19:57:43.000000000 +0000
@@ -31,8 +31,8 @@ enum v9fs_transport_status {
 
 struct v9fs_transport {
 	enum v9fs_transport_status status;
-	struct semaphore writelock;
-	struct semaphore readlock;
+	struct mutex writelock;
+	struct mutex readlock;
 	void *priv;
 
 	int (*init) (struct v9fs_session_info *, const char *, char *);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/9p/trans_sock.c linux-2.6.15-rc5-mutex/fs/9p/trans_sock.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/9p/trans_sock.c	2005-12-08 16:23:48.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/9p/trans_sock.c	2005-12-12 19:58:29.000000000 +0000
@@ -154,8 +154,8 @@ v9fs_tcp_init(struct v9fs_session_info *
 	struct v9fs_trans_sock *ts = NULL;
 	struct v9fs_transport *trans = v9ses->transport;
 
-	sema_init(&trans->writelock, 1);
-	sema_init(&trans->readlock, 1);
+	init_MUTEX(&trans->writelock);
+	init_MUTEX(&trans->readlock);
 
 	ts = kmalloc(sizeof(struct v9fs_trans_sock), GFP_KERNEL);
 
@@ -225,8 +225,8 @@ v9fs_unix_init(struct v9fs_session_info 
 	trans->priv = ts;
 	ts->s = NULL;
 
-	sema_init(&trans->writelock, 1);
-	sema_init(&trans->readlock, 1);
+	init_MUTEX(&trans->writelock);
+	init_MUTEX(&trans->readlock);
 
 	sun_server.sun_family = PF_UNIX;
 	strcpy(sun_server.sun_path, dev_name);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/9p/v9fs.h linux-2.6.15-rc5-mutex/fs/9p/v9fs.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/9p/v9fs.h	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/9p/v9fs.h	2005-12-12 20:52:22.000000000 +0000
@@ -28,7 +28,7 @@
   */
 
 struct v9fs_idpool {
-	struct semaphore lock;
+	struct mutex lock;
 	struct idr pool;
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/affs/affs.h linux-2.6.15-rc5-mutex/fs/affs/affs.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/affs/affs.h	2005-03-02 12:08:34.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/affs/affs.h	2005-12-12 20:49:44.000000000 +0000
@@ -50,8 +50,8 @@ struct affs_ext_key {
  */
 struct affs_inode_info {
 	u32	 i_opencnt;
-	struct semaphore i_link_lock;		/* Protects internal inode access. */
-	struct semaphore i_ext_lock;		/* Protects internal inode access. */
+	struct mutex i_link_lock;		/* Protects internal inode access. */
+	struct mutex i_ext_lock;		/* Protects internal inode access. */
 #define i_hash_lock i_ext_lock
 	u32	 i_blkcnt;			/* block count */
 	u32	 i_extcnt;			/* extended block count */
@@ -99,7 +99,7 @@ struct affs_sb_info {
 	gid_t s_gid;			/* gid to override */
 	umode_t s_mode;			/* mode to override */
 	struct buffer_head *s_root_bh;	/* Cached root block. */
-	struct semaphore s_bmlock;	/* Protects bitmap access. */
+	struct mutex s_bmlock;		/* Protects bitmap access. */
 	struct affs_bm_info *s_bitmap;	/* Bitmap infos. */
 	u32 s_bmap_count;		/* # of bitmap blocks. */
 	u32 s_bmap_bits;		/* # of bits in one bitmap blocks */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/autofs4/autofs_i.h linux-2.6.15-rc5-mutex/fs/autofs4/autofs_i.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/autofs4/autofs_i.h	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/autofs4/autofs_i.h	2005-12-12 17:33:33.000000000 +0000
@@ -102,7 +102,7 @@ struct autofs_sb_info {
 	int reghost_enabled;
 	int needs_reghost;
 	struct super_block *sb;
-	struct semaphore wq_sem;
+	struct mutex wq_sem;
 	spinlock_t fs_lock;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/block_dev.c linux-2.6.15-rc5-mutex/fs/block_dev.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/block_dev.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/block_dev.c	2005-12-12 17:32:31.000000000 +0000
@@ -265,8 +265,8 @@ static void init_once(void * foo, kmem_c
 	    SLAB_CTOR_CONSTRUCTOR)
 	{
 		memset(bdev, 0, sizeof(*bdev));
-		sema_init(&bdev->bd_sem, 1);
-		sema_init(&bdev->bd_mount_sem, 1);
+		init_MUTEX(&bdev->bd_sem);
+		init_MUTEX(&bdev->bd_mount_sem);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 		inode_init_once(&ei->vfs_inode);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/cifs/cifsglob.h linux-2.6.15-rc5-mutex/fs/cifs/cifsglob.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/cifs/cifsglob.h	2005-12-08 16:23:48.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/cifs/cifsglob.h	2005-12-12 20:48:45.000000000 +0000
@@ -135,7 +135,7 @@ struct TCP_Server_Info {
 	atomic_t num_waiters;   /* blocked waiting to get in sendrecv */
 #endif
 	enum statusEnum tcpStatus; /* what we think the status is */
-	struct semaphore tcpSem;
+	struct mutex tcpSem;
 	struct task_struct *tsk;
 	char server_GUID[16];
 	char secMode;
@@ -178,7 +178,7 @@ struct cifsUidInfo {
  */
 struct cifsSesInfo {
 	struct list_head cifsSessionList;
-	struct semaphore sesSem;
+	struct mutex sesSem;
 	struct cifsUidInfo *uidInfo;	/* pointer to user info */
 	struct TCP_Server_Info *server;	/* pointer to server info */
 	atomic_t inUse; /* # of mounts (tree connections) on this ses */
@@ -207,7 +207,7 @@ struct cifsSesInfo {
 struct cifsTconInfo {
 	struct list_head cifsConnectionList;
 	struct list_head openFileList;
-	struct semaphore tconSem;
+	struct mutex tconSem;
 	struct cifsSesInfo *ses;	/* pointer to session associated with */
 	char treeName[MAX_TREE_SIZE + 1]; /* UNC name of resource (in ASCII not UTF) */
 	char *nativeFileSystem;
@@ -300,7 +300,7 @@ struct cifsFileInfo {
 	unsigned closePend:1;	/* file is marked to close */
 	unsigned invalidHandle:1;  /* file closed via session abend */
 	atomic_t wrtPending;   /* handle in use - defer close */
-	struct semaphore fh_sem; /* prevents reopen race after dead ses*/
+	struct mutex fh_sem; /* prevents reopen race after dead ses*/
 	char * search_resume_name; /* BB removeme BB */
 	unsigned int resume_name_length; /* BB removeme - field renamed and moved BB */
 	struct cifs_search_info srch_inf;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/cramfs/inode.c linux-2.6.15-rc5-mutex/fs/cramfs/inode.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/cramfs/inode.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/cramfs/inode.c	2005-12-12 22:12:50.000000000 +0000
@@ -22,7 +22,7 @@
 #include <linux/cramfs_fs_sb.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <asm/uaccess.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/dquot.c linux-2.6.15-rc5-mutex/fs/dquot.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/dquot.c	2005-12-08 16:23:48.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/dquot.c	2005-12-12 19:57:04.000000000 +0000
@@ -575,7 +575,7 @@ static struct dquot *get_empty_dquot(str
 		return NODQUOT;
 
 	memset((caddr_t)dquot, 0, sizeof(struct dquot));
-	sema_init(&dquot->dq_lock, 1);
+	init_MUTEX(&dquot->dq_lock);
 	INIT_LIST_HEAD(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_inuse);
 	INIT_HLIST_NODE(&dquot->dq_hash);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/eventpoll.c linux-2.6.15-rc5-mutex/fs/eventpoll.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/eventpoll.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/eventpoll.c	2005-12-12 22:12:50.000000000 +0000
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 #include <asm/mman.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 
 /*
@@ -274,7 +274,7 @@ static struct super_block *eventpollfs_g
 /*
  * This semaphore is used to serialize ep_free() and eventpoll_release_file().
  */
-static struct semaphore epsem;
+static struct mutex epsem;
 
 /* Safe wake up implementation */
 static struct poll_safewake psw;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/fuse/dev.c linux-2.6.15-rc5-mutex/fs/fuse/dev.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/fuse/dev.c	2005-12-08 16:23:49.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/fuse/dev.c	2005-12-12 20:31:16.000000000 +0000
@@ -110,7 +110,7 @@ struct fuse_req *fuse_get_request(struct
 	sigset_t oldset;
 
 	block_sigs(&oldset);
-	intr = down_interruptible(&fc->outstanding_sem);
+	intr = down_sem_interruptible(&fc->outstanding_sem);
 	restore_sigs(&oldset);
 	return intr ? NULL : do_get_request(fc);
 }
@@ -127,7 +127,7 @@ static void fuse_putback_request(struct 
 	if (fc->outstanding_debt)
 		fc->outstanding_debt--;
 	else
-		up(&fc->outstanding_sem);
+		up_sem(&fc->outstanding_sem);
 	spin_unlock(&fuse_lock);
 }
 
@@ -180,10 +180,10 @@ static void request_end(struct fuse_conn
 
 		/* After INIT reply is received other requests can go
 		   out.  So do (FUSE_MAX_OUTSTANDING - 1) number of
-		   up()s on outstanding_sem.  The last up() is done in
+		   up_sem()s on outstanding_sem.  The last up() is done in
 		   fuse_putback_request() */
 		for (i = 1; i < FUSE_MAX_OUTSTANDING; i++)
-			up(&fc->outstanding_sem);
+			up_sem(&fc->outstanding_sem);
 	} else if (req->in.h.opcode == FUSE_RELEASE && req->inode == NULL) {
 		/* Special case for failed iget in CREATE */
 		u64 nodeid = req->in.h.nodeid;
@@ -296,7 +296,7 @@ static void queue_request(struct fuse_co
 		   processing the RELEASE requests.  However for
 		   efficiency do it without blocking, so if down()
 		   would block, just increase the debt instead */
-		if (down_trylock(&fc->outstanding_sem))
+		if (down_sem_trylock(&fc->outstanding_sem))
 			fc->outstanding_debt++;
 	}
 	list_add_tail(&req->list, &fc->pending);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/fuse/fuse_i.h linux-2.6.15-rc5-mutex/fs/fuse/fuse_i.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/fuse/fuse_i.h	2005-12-08 16:23:49.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/fuse/fuse_i.h	2005-12-12 22:05:43.000000000 +0000
@@ -13,7 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/backing-dev.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /** Max number of pages that can be used in a single read request */
 #define FUSE_MAX_PAGES_PER_REQ 32
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/hfs/btree.h linux-2.6.15-rc5-mutex/fs/hfs/btree.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/hfs/btree.h	2005-06-22 13:52:11.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/hfs/btree.h	2005-12-12 20:54:32.000000000 +0000
@@ -33,7 +33,7 @@ struct hfs_btree {
 	unsigned int depth;
 
 	//unsigned int map1_size, map_size;
-	struct semaphore tree_lock;
+	struct mutex tree_lock;
 
 	unsigned int pages_per_bnode;
 	spinlock_t hash_lock;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/hfs/hfs_fs.h linux-2.6.15-rc5-mutex/fs/hfs/hfs_fs.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/hfs/hfs_fs.h	2005-12-08 16:23:49.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/hfs/hfs_fs.h	2005-12-12 20:54:29.000000000 +0000
@@ -56,7 +56,7 @@ struct hfs_inode_info {
 	struct list_head open_dir_list;
 	struct inode *rsrc_inode;
 
-	struct semaphore extents_lock;
+	struct mutex extents_lock;
 
 	u16 alloc_blocks, clump_blocks;
 	sector_t fs_blocks;
@@ -142,7 +142,7 @@ struct hfs_sb_info {
 
 	struct nls_table *nls_io, *nls_disk;
 
-	struct semaphore bitmap_lock;
+	struct mutex bitmap_lock;
 
 	unsigned long flags;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/hfsplus/hfsplus_fs.h linux-2.6.15-rc5-mutex/fs/hfsplus/hfsplus_fs.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/hfsplus/hfsplus_fs.h	2005-12-08 16:23:49.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/hfsplus/hfsplus_fs.h	2005-12-12 20:51:21.000000000 +0000
@@ -61,7 +61,7 @@ struct hfs_btree {
 	unsigned int depth;
 
 	//unsigned int map1_size, map_size;
-	struct semaphore tree_lock;
+	struct mutex tree_lock;
 
 	unsigned int pages_per_bnode;
 	spinlock_t hash_lock;
@@ -155,7 +155,7 @@ struct hfsplus_sb_info {
 
 
 struct hfsplus_inode_info {
-	struct semaphore extents_lock;
+	struct mutex extents_lock;
 	u32 clump_blocks, alloc_blocks;
 	sector_t fs_blocks;
 	/* Allocation extents from catalog record or volume header */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/hpfs/hpfs_fn.h linux-2.6.15-rc5-mutex/fs/hpfs/hpfs_fn.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/hpfs/hpfs_fn.h	2005-06-22 13:52:12.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/hpfs/hpfs_fn.h	2005-12-12 20:54:14.000000000 +0000
@@ -57,8 +57,8 @@ struct hpfs_inode_info {
 	unsigned i_ea_uid : 1;	/* file's uid is stored in ea */
 	unsigned i_ea_gid : 1;	/* file's gid is stored in ea */
 	unsigned i_dirty : 1;
-	struct semaphore i_sem;
-	struct semaphore i_parent;
+	struct mutex i_sem;
+	struct mutex i_parent;
 	loff_t **i_rddir_off;
 	struct inode vfs_inode;
 };
@@ -88,7 +88,7 @@ struct hpfs_sb_info {
 	unsigned *sb_bmp_dir;		/* main bitmap directory */
 	unsigned sb_c_bitmap;		/* current bitmap */
 	unsigned sb_max_fwd_alloc;	/* max forwad allocation */
-	struct semaphore hpfs_creation_de; /* when creating dirents, nobody else
+	struct mutex hpfs_creation_de;	/* when creating dirents, nobody else
 					   can alloc blocks */
 	/*unsigned sb_mounting : 1;*/
 	int sb_timeshift;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/inode.c linux-2.6.15-rc5-mutex/fs/inode.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/inode.c	2005-12-08 16:23:49.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/inode.c	2005-12-12 17:30:32.000000000 +0000
@@ -192,7 +192,7 @@ void inode_init_once(struct inode *inode
 	INIT_HLIST_NODE(&inode->i_hash);
 	INIT_LIST_HEAD(&inode->i_dentry);
 	INIT_LIST_HEAD(&inode->i_devices);
-	sema_init(&inode->i_sem, 1);
+	init_MUTEX(&inode->i_sem);
 	init_rwsem(&inode->i_alloc_sem);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
 	rwlock_init(&inode->i_data.tree_lock);
@@ -205,7 +205,7 @@ void inode_init_once(struct inode *inode
 	i_size_ordered_init(inode);
 #ifdef CONFIG_INOTIFY
 	INIT_LIST_HEAD(&inode->inotify_watches);
-	sema_init(&inode->inotify_sem, 1);
+	init_MUTEX(&inode->inotify_sem);
 #endif
 }
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/inotify.c linux-2.6.15-rc5-mutex/fs/inotify.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/inotify.c	2005-12-08 16:23:49.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/inotify.c	2005-12-12 18:07:19.000000000 +0000
@@ -83,7 +83,7 @@ int inotify_max_queued_events;
 struct inotify_device {
 	wait_queue_head_t 	wq;		/* wait queue for i/o */
 	struct idr		idr;		/* idr mapping wd -> watch */
-	struct semaphore	sem;		/* protects this bad boy */
+	struct mutex		sem;		/* protects this bad boy */
 	struct list_head 	events;		/* list of queued events */
 	struct list_head	watches;	/* list of watches */
 	atomic_t		count;		/* reference count */
@@ -903,7 +903,7 @@ asmlinkage long sys_inotify_init(void)
 	INIT_LIST_HEAD(&dev->events);
 	INIT_LIST_HEAD(&dev->watches);
 	init_waitqueue_head(&dev->wq);
-	sema_init(&dev->sem, 1);
+	init_MUTEX(&dev->sem);
 	dev->event_count = 0;
 	dev->queue_size = 0;
 	dev->max_events = inotify_max_queued_events;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/isofs/compress.c linux-2.6.15-rc5-mutex/fs/isofs/compress.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/isofs/compress.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/isofs/compress.c	2005-12-12 20:47:06.000000000 +0000
@@ -34,7 +34,7 @@ static char zisofs_sink_page[PAGE_CACHE_
  * allocation; this avoids failures at block-decompression time.
  */
 static void *zisofs_zlib_workspace;
-static struct semaphore zisofs_zlib_semaphore;
+static struct mutex zisofs_zlib_semaphore;
 
 /*
  * When decompressing, we typically obtain more than one page
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/jffs/inode-v23.c linux-2.6.15-rc5-mutex/fs/jffs/inode-v23.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/jffs/inode-v23.c	2005-11-01 13:19:14.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/jffs/inode-v23.c	2005-12-12 22:12:50.000000000 +0000
@@ -42,7 +42,7 @@
 #include <linux/quotaops.h>
 #include <linux/highmem.h>
 #include <linux/vfs.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/jffs/intrep.c linux-2.6.15-rc5-mutex/fs/jffs/intrep.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/jffs/intrep.c	2005-12-08 16:23:49.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/jffs/intrep.c	2005-12-12 22:12:50.000000000 +0000
@@ -62,7 +62,7 @@
 #include <linux/fs.h>
 #include <linux/stat.h>
 #include <linux/pagemap.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <asm/byteorder.h>
 #include <linux/smp_lock.h>
 #include <linux/time.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/jffs/jffs_fm.h linux-2.6.15-rc5-mutex/fs/jffs/jffs_fm.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/jffs/jffs_fm.h	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/jffs/jffs_fm.h	2005-12-12 20:52:06.000000000 +0000
@@ -97,7 +97,7 @@ struct jffs_fmcontrol
 	struct jffs_fm *tail;
 	struct jffs_fm *head_extra;
 	struct jffs_fm *tail_extra;
-	struct semaphore biglock;
+	struct mutex biglock;
 };
 
 /* Notice the two members head_extra and tail_extra in the jffs_control
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/jfs/jfs_dmap.h linux-2.6.15-rc5-mutex/fs/jfs/jfs_dmap.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/jfs/jfs_dmap.h	2005-01-04 11:13:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/jfs/jfs_dmap.h	2005-12-12 20:50:42.000000000 +0000
@@ -243,7 +243,7 @@ struct dbmap {
 struct bmap {
 	struct dbmap db_bmap;		/* on-disk aggregate map descriptor */
 	struct inode *db_ipbmap;	/* ptr to aggregate map incore inode */
-	struct semaphore db_bmaplock;	/* aggregate map lock */
+	struct mutex db_bmaplock;	/* aggregate map lock */
 	atomic_t db_active[MAXAG];	/* count of active, open files in AG */
 	u32 *db_DBmap;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/jfs/jfs_imap.h linux-2.6.15-rc5-mutex/fs/jfs/jfs_imap.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/jfs/jfs_imap.h	2005-01-04 11:13:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/jfs/jfs_imap.h	2005-12-12 20:51:02.000000000 +0000
@@ -140,8 +140,8 @@ struct dinomap {
 struct inomap {
 	struct dinomap im_imap;		/* 4096: inode allocation control */
 	struct inode *im_ipimap;	/* 4: ptr to inode for imap   */
-	struct semaphore im_freelock;	/* 4: iag free list lock      */
-	struct semaphore im_aglock[MAXAG];	/* 512: per AG locks          */
+	struct mutex im_freelock;	/* 4: iag free list lock      */
+	struct mutex im_aglock[MAXAG];	/* 512: per AG locks          */
 	u32 *im_DBGdimap;
 	atomic_t im_numinos;	/* num of backed inodes */
 	atomic_t im_numfree;	/* num of free backed inodes */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/jfs/jfs_incore.h linux-2.6.15-rc5-mutex/fs/jfs/jfs_incore.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/jfs/jfs_incore.h	2005-06-22 13:52:14.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/jfs/jfs_incore.h	2005-12-12 20:50:47.000000000 +0000
@@ -67,7 +67,7 @@ struct jfs_inode_info {
 	 * dirty inodes may be committed while a new transaction on the
 	 * inode is blocked in txBegin or TxBeginAnon
 	 */
-	struct semaphore commit_sem;
+	struct mutex commit_sem;
 	/* xattr_sem allows us to access the xattrs without taking i_sem */
 	struct rw_semaphore xattr_sem;
 	lid_t	xtlid;		/* lid of xtree lock on directory */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/jfs/jfs_logmgr.h linux-2.6.15-rc5-mutex/fs/jfs/jfs_logmgr.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/jfs/jfs_logmgr.h	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/jfs/jfs_logmgr.h	2005-12-12 20:50:52.000000000 +0000
@@ -389,7 +389,7 @@ struct jfs_log {
 	int eor;		/* 4: eor of last record in eol page */
 	struct lbuf *bp;	/* 4: current log page buffer */
 
-	struct semaphore loglock;	/* 4: log write serialization lock */
+	struct mutex loglock;	/* 4: log write serialization lock */
 
 	/* syncpt */
 	int nextsync;		/* 4: bytes to write before next syncpt */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/libfs.c linux-2.6.15-rc5-mutex/fs/libfs.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/libfs.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/libfs.c	2005-12-12 18:01:44.000000000 +0000
@@ -529,7 +529,7 @@ struct simple_attr {
 	char set_buf[24];
 	void *data;
 	const char *fmt;	/* format for read operation */
-	struct semaphore sem;	/* protects access to these buffers */
+	struct mutex sem;	/* protects access to these buffers */
 };
 
 /* simple_attr_open is called by an actual attribute open file operation
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/lockd/svc.c linux-2.6.15-rc5-mutex/fs/lockd/svc.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/lockd/svc.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/lockd/svc.c	2005-12-12 17:37:21.000000000 +0000
@@ -49,7 +49,7 @@ static pid_t			nlmsvc_pid;
 int				nlmsvc_grace_period;
 unsigned long			nlmsvc_timeout;
 
-static DECLARE_MUTEX_LOCKED(lockd_start);
+static DECLARE_COMPLETION(lockd_start);
 static DECLARE_WAIT_QUEUE_HEAD(lockd_exit);
 
 /*
@@ -112,7 +112,7 @@ lockd(struct svc_rqst *rqstp)
 	 * Let our maker know we're running.
 	 */
 	nlmsvc_pid = current->pid;
-	up(&lockd_start);
+	complete(&lockd_start);
 
 	daemonize("lockd");
 
@@ -257,13 +257,14 @@ lockd_up(void)
 	/*
 	 * Create the kernel thread and wait for it to start.
 	 */
+	init_completion(&lockd_start);
 	error = svc_create_thread(lockd, serv);
 	if (error) {
 		printk(KERN_WARNING
 			"lockd_up: create thread failed, error=%d\n", error);
 		goto destroy_and_out;
 	}
-	down(&lockd_start);
+	wait_for_completion(&lockd_start);
 
 	/*
 	 * Note: svc_serv structures have an initial use count of 1,
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/locks.c linux-2.6.15-rc5-mutex/fs/locks.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/locks.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/locks.c	2005-12-12 22:12:50.000000000 +0000
@@ -125,8 +125,8 @@
 #include <linux/syscalls.h>
 #include <linux/time.h>
 #include <linux/rcupdate.h>
+#include <linux/semaphore.h>
 
-#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
 #define IS_POSIX(fl)	(fl->fl_flags & FL_POSIX)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/nfs/idmap.c linux-2.6.15-rc5-mutex/fs/nfs/idmap.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/nfs/idmap.c	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/nfs/idmap.c	2005-12-12 20:52:50.000000000 +0000
@@ -70,8 +70,8 @@ struct idmap {
 	struct dentry        *idmap_dentry;
 	wait_queue_head_t     idmap_wq;
 	struct idmap_msg      idmap_im;
-	struct semaphore      idmap_lock;    /* Serializes upcalls */
-	struct semaphore      idmap_im_lock; /* Protects the hashtable */
+	struct mutex          idmap_lock;    /* Serializes upcalls */
+	struct mutex          idmap_im_lock; /* Protects the hashtable */
 	struct idmap_hashtable idmap_user_hash;
 	struct idmap_hashtable idmap_group_hash;
 };
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/ntfs/inode.h linux-2.6.15-rc5-mutex/fs/ntfs/inode.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/ntfs/inode.h	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/ntfs/inode.h	2005-12-12 22:12:50.000000000 +0000
@@ -28,8 +28,8 @@
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/list.h>
+#include <linux/semaphore.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
 
 #include "layout.h"
 #include "volume.h"
@@ -81,7 +81,7 @@ struct _ntfs_inode {
 	 * The following fields are only valid for real inodes and extent
 	 * inodes.
 	 */
-	struct semaphore mrec_lock; /* Lock for serializing access to the
+	struct mutex mrec_lock; /* Lock for serializing access to the
 				   mft record belonging to this inode. */
 	struct page *page;	/* The page containing the mft record of the
 				   inode. This should only be touched by the
@@ -119,7 +119,7 @@ struct _ntfs_inode {
 			u8 block_clusters;	/* Number of clusters per cb. */
 		} compressed;
 	} itype;
-	struct semaphore extent_lock;	/* Lock for accessing/modifying the
+	struct mutex extent_lock;	/* Lock for accessing/modifying the
 					   below . */
 	s32 nr_extents;	/* For a base mft record, the number of attached extent
 			   inodes (0 if none), for extent records and for fake
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/ntfs/ntfs.h linux-2.6.15-rc5-mutex/fs/ntfs/ntfs.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/ntfs/ntfs.h	2005-08-30 13:56:28.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/ntfs/ntfs.h	2005-12-12 20:50:25.000000000 +0000
@@ -91,7 +91,7 @@ extern void free_compression_buffers(voi
 
 /* From fs/ntfs/super.c */
 #define default_upcase_len 0x10000
-extern struct semaphore ntfs_lock;
+extern struct mutex ntfs_lock;
 
 typedef struct {
 	int val;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/partitions/devfs.c linux-2.6.15-rc5-mutex/fs/partitions/devfs.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/partitions/devfs.c	2005-01-04 11:13:41.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/partitions/devfs.c	2005-12-12 22:12:50.000000000 +0000
@@ -6,14 +6,14 @@
 #include <linux/vmalloc.h>
 #include <linux/genhd.h>
 #include <linux/bitops.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 
 struct unique_numspace {
 	u32		  num_free;          /*  Num free in bits       */
 	u32		  length;            /*  Array length in bytes  */
 	unsigned long	  *bits;
-	struct semaphore  mutex;
+	struct mutex      mutex;
 };
 
 static DECLARE_MUTEX(numspace_mutex);
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/reiserfs/journal.c linux-2.6.15-rc5-mutex/fs/reiserfs/journal.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/reiserfs/journal.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/reiserfs/journal.c	2005-12-12 22:12:50.000000000 +0000
@@ -39,7 +39,7 @@
 #include <asm/system.h>
 
 #include <linux/time.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include <linux/vmalloc.h>
 #include <linux/reiserfs_fs.h>
@@ -2473,7 +2473,7 @@ static struct reiserfs_journal_list *all
 	INIT_LIST_HEAD(&jl->j_working_list);
 	INIT_LIST_HEAD(&jl->j_tail_bh_list);
 	INIT_LIST_HEAD(&jl->j_bh_list);
-	sema_init(&jl->j_commit_lock, 1);
+	init_MUTEX(&jl->j_commit_lock);
 	SB_JOURNAL(s)->j_num_lists++;
 	get_journal_list(jl);
 	return jl;
@@ -2744,8 +2744,8 @@ int journal_init(struct super_block *p_s
 	journal->j_last = NULL;
 	journal->j_first = NULL;
 	init_waitqueue_head(&(journal->j_join_wait));
-	sema_init(&journal->j_lock, 1);
-	sema_init(&journal->j_flush_sem, 1);
+	init_MUTEX(&journal->j_lock);
+	init_MUTEX(&journal->j_flush_sem);
 
 	journal->j_trans_id = 10;
 	journal->j_mount_id = 10;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/reiserfs/xattr.c linux-2.6.15-rc5-mutex/fs/reiserfs/xattr.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/reiserfs/xattr.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/reiserfs/xattr.c	2005-12-12 22:12:50.000000000 +0000
@@ -43,7 +43,7 @@
 #include <asm/checksum.h>
 #include <linux/smp_lock.h>
 #include <linux/stat.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #define FL_READONLY 128
 #define FL_DIR_SEM_HELD 256
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/seq_file.c linux-2.6.15-rc5-mutex/fs/seq_file.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/seq_file.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/seq_file.c	2005-12-12 17:32:40.000000000 +0000
@@ -37,7 +37,7 @@ int seq_open(struct file *file, struct s
 		file->private_data = p;
 	}
 	memset(p, 0, sizeof(*p));
-	sema_init(&p->sem, 1);
+	init_MUTEX(&p->sem);
 	p->op = op;
 
 	/*
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/super.c linux-2.6.15-rc5-mutex/fs/super.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/super.c	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/super.c	2005-12-12 17:25:56.000000000 +0000
@@ -72,13 +72,13 @@ static struct super_block *alloc_super(v
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
 		init_rwsem(&s->s_umount);
-		sema_init(&s->s_lock, 1);
+		init_MUTEX(&s->s_lock);
 		down_write(&s->s_umount);
 		s->s_count = S_BIAS;
 		atomic_set(&s->s_active, 1);
-		sema_init(&s->s_vfs_rename_sem,1);
-		sema_init(&s->s_dquot.dqio_sem, 1);
-		sema_init(&s->s_dquot.dqonoff_sem, 1);
+		init_MUTEX(&s->s_vfs_rename_sem);
+		init_MUTEX(&s->s_dquot.dqio_sem);
+		init_MUTEX(&s->s_dquot.dqonoff_sem);
 		init_rwsem(&s->s_dquot.dqptr_sem);
 		init_waitqueue_head(&s->s_wait_unfrozen);
 		s->s_maxbytes = MAX_NON_LFS;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/sysfs/file.c linux-2.6.15-rc5-mutex/fs/sysfs/file.c
--- /warthog/kernels/linux-2.6.15-rc5/fs/sysfs/file.c	2005-08-30 13:56:29.000000000 +0100
+++ linux-2.6.15-rc5-mutex/fs/sysfs/file.c	2005-12-12 22:12:50.000000000 +0000
@@ -7,7 +7,7 @@
 #include <linux/kobject.h>
 #include <linux/namei.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "sysfs.h"
 
@@ -55,7 +55,7 @@ struct sysfs_buffer {
 	loff_t			pos;
 	char			* page;
 	struct sysfs_ops	* ops;
-	struct semaphore	sem;
+	struct mutex		sem;
 	int			needs_read_fill;
 };
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/xfs/linux-2.6/mutex.h linux-2.6.15-rc5-mutex/fs/xfs/linux-2.6/mutex.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/xfs/linux-2.6/mutex.h	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/xfs/linux-2.6/mutex.h	2005-12-12 22:12:50.000000000 +0000
@@ -19,7 +19,7 @@
 #define __XFS_SUPPORT_MUTEX_H__
 
 #include <linux/spinlock.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /*
  * Map the mutex'es from IRIX to Linux semaphores.
@@ -28,10 +28,10 @@
  * callers.
  */
 #define MUTEX_DEFAULT		0x0
-typedef struct semaphore	mutex_t;
+typedef struct mutex		mutex_t;
 
-#define mutex_init(lock, type, name)		sema_init(lock, 1)
-#define mutex_destroy(lock)			sema_init(lock, -99)
+#define mutex_init(lock, type, name)		init_MUTEX(lock)
+#define mutex_destroy(lock)			do {} while(0)
 #define mutex_lock(lock, num)			down(lock)
 #define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
 #define mutex_unlock(lock)			up(lock)
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/xfs/linux-2.6/sema.h linux-2.6.15-rc5-mutex/fs/xfs/linux-2.6/sema.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/xfs/linux-2.6/sema.h	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/xfs/linux-2.6/sema.h	2005-12-12 22:05:13.000000000 +0000
@@ -21,7 +21,7 @@
 #include <linux/time.h>
 #include <linux/wait.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 /*
  * sema_t structure just maps to struct semaphore in Linux kernel.
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/fs/xfs/linux-2.6/xfs_buf.h linux-2.6.15-rc5-mutex/fs/xfs/linux-2.6/xfs_buf.h
--- /warthog/kernels/linux-2.6.15-rc5/fs/xfs/linux-2.6/xfs_buf.h	2005-12-08 16:23:50.000000000 +0000
+++ linux-2.6.15-rc5-mutex/fs/xfs/linux-2.6/xfs_buf.h	2005-12-12 20:47:50.000000000 +0000
@@ -114,7 +114,7 @@ typedef int (*page_buf_bdstrat_t)(struct
 #define PB_PAGES	2
 
 typedef struct xfs_buf {
-	struct semaphore	pb_sema;	/* semaphore for lockables  */
+	struct mutex		pb_sema;	/* semaphore for lockables  */
 	unsigned long		pb_queuetime;	/* time buffer was queued   */
 	atomic_t		pb_pin_count;	/* pin count		    */
 	wait_queue_head_t	pb_waiters;	/* unpin waiters	    */
@@ -134,7 +134,7 @@ typedef struct xfs_buf {
 	page_buf_iodone_t	pb_iodone;	/* I/O completion function */
 	page_buf_relse_t	pb_relse;	/* releasing function */
 	page_buf_bdstrat_t	pb_strat;	/* pre-write function */
-	struct semaphore	pb_iodonesema;	/* Semaphore for I/O waiters */
+	struct mutex		pb_iodonesema;	/* Semaphore for I/O waiters */
 	void			*pb_fspriv;
 	void			*pb_fspriv2;
 	void			*pb_fspriv3;
